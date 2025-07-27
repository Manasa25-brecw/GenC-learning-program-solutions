import React from 'react';
import CohortDetails from './CohortDetails';

function App() {
  return (
    <div>
      <CohortDetails name="React Batch 1" status="ongoing" duration="4 weeks" />
      <CohortDetails name="Java Batch 2" status="completed" duration="6 weeks" />
    </div>
  );
}

export default App;
