Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516A606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=0XXMu+tY;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=qMMoSqZO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO7Ab-0006v5-RR; Tue, 03 Nov 2026 00:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhisek.panda1@nutanix.com>)
 id 1xO7AZ-0006tz-Na; Tue, 03 Nov 2026 00:34:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhisek.panda1@nutanix.com>)
 id 1xO7AQ-0002dU-OG; Tue, 03 Nov 2026 00:34:51 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A31eLhW2449607; Mon, 2 Nov 2026 21:34:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=qr4xb5FZtIPCz
 gnWu1N0JWvW2cAJBo2z6wFqCZjSV8k=; b=0XXMu+tYOaRnpGxvmixqQCMlp4Ml3
 yzZ7siepuNxhRkJ+4cnzYulzHR129p+MQ9gJqGymS8DGeQvqwUthG+ver6+5+AbF
 T54tixqcX5kNnvUibl/6D81SnMgqC94QIv1k9vS0BCIu9zX2JRTivrc0KkEK8qs1
 Hws5J9AXq2rbvLMkZcdwn+FzFghb3i2A+j3UFIdzXmui/tVrVl9xxYtF99tLl4oV
 /uk4fwgRlzBrWKvEo2z17DkQW5Io+bvdZl2adx9so+vQpXP0NMc0YXVtnpgM+Z+/
 vDwwXkUHylMrxNWxqR4a5wuc3tKa6IxxqU9Zt7cOfD8pO8Ysw8JtO2QAQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020088.outbound.protection.outlook.com [52.101.46.88])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hnfuywhek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 21:34:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzoPItlwKl2Hm85HB5ewgu43j97ZinqqszE55mwsb3nRLgCtzbSkxZB1qhEQxoQ50/lwBM+CJLPe2qZKjs7KLhCaUGM050FirAiEIRvaPMV/zwzyYp7t7r3Hy2DsUX6yc2xrv3WSbi8xDPFD40BFY4cC/7KacMKkS3609CzdWypbrA4jmhG+BBQH1QaaVrwsMyny8sKP+JLECbZgivyQwxt5H9EjS47lBb/dFfdlddUGmwcwgNauUEnjr7/JUqeKfCc4hiaplWVXxeQbUq18lPsqOdXxP2u4L9QV1HH4ZfGFvrviAQ7cby2WBMh5PDy6JQCom26xxldm7b9CeNnRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr4xb5FZtIPCzgnWu1N0JWvW2cAJBo2z6wFqCZjSV8k=;
 b=JerxtIdmVlQsXpXliOMu1I2Apqi2SpdvXB7bXukAAuLaN04MGF0zY5R7/1sxT7U7vKY+n2ZDZsYbA/BNnHCy7bWJFzWiCWSzEWbXMdwYNedc/BPYP6ozof23cr9mn/olf3ksse24/Px9MJikYeneuuEONsxmf7P5UIGAved+4rSjx4TM84rMp5ouvxlYa5Lc5omVdPHWdMAHBrd4R4jN0sgK4UZ+041s3yQb5jHHn8Sf5qPRGrafEdvI4wLDfzWyzj22gKjxGXHqe53GGTTz7P7+dKXVba9AfQiEzr645gkACD8Be5aqFn0NJ2JuXKrK8qYtfGVQ76E+78Sn2PJ0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr4xb5FZtIPCzgnWu1N0JWvW2cAJBo2z6wFqCZjSV8k=;
 b=qMMoSqZO05MmnJtZw0GwQBQ/WknvqK01VeVov+PLwyEgflrJ09Y89gBaIgZR6XpUF8BPcG4MZacgDKkpEpZq7z0WCaaIth0F+j5GUHRoNhOz+lQJ2dyCxY8uwEnXcQ9bud+KE4WsEoCkwma9e05liP0GRISqjePzdOeuyY5RhnHh2im47YUJb4EALk+EnUkeJFYZU4NqOab5ztqLXQxYE+pjCiCGfa4kdNCWiap5yLXTmwSCY0FvA/GFkIWTbpl7dkJHKgkbJYHSosLwfceibHAKcN/KQbJS2NmpkmfxD87lKNZ+VLTmCN3j3/R9Bs8vPk8yTdKyrG7v2MBbTkL4Kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BN7PR02MB5329.namprd02.prod.outlook.com (2603:10b6:408:29::15)
 by SJ0PR02MB7344.namprd02.prod.outlook.com (2603:10b6:a03:2a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 05:34:27 +0000
Received: from BN7PR02MB5329.namprd02.prod.outlook.com
 ([fe80::a3e:7534:76c8:6715]) by BN7PR02MB5329.namprd02.prod.outlook.com
 ([fe80::a3e:7534:76c8:6715%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 05:34:27 +0000
From: Abhisek Panda <abhisek.panda1@nutanix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@openvz.org,
 jsnow@redhat.com, mark.caveayland@nutanix.com
Cc: Abhisek Panda <abhisek.panda1@nutanix.com>,
 andychiu <andychiu@synology.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v3] ahci: Check Bus Master before starting DMA/FIS engines
Date: Tue,  3 Nov 2026 05:34:22 +0000
Message-ID: <20261103053422.615686-1-abhisek.panda1@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To BN7PR02MB5329.namprd02.prod.outlook.com
 (2603:10b6:408:29::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR02MB5329:EE_|SJ0PR02MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c5205d-16c8-40a7-30fe-08df396c2036
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021123027099003|56012099006|261009223027099003|261028144727099003|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: U6TARgtEP8zjB2NfKgbcGtMI1nJj4KI87U1FKqOllR6JV/3UFTS7bqjWhoejPtx9r8qFz/BIAT+ooG/+CDu3A/4o5ASjbp6uKeyOaCtbbMHs3sJbrQtHKTOrqvSdb3SnZf85mEQUqJNdZmGohnp1/OfkHGj84ok4TNAR8Odmf9u5I6zVZW5snXcu2jQEoYhFRO7ObDOrUxLIhB4gtEPjCJBrrEa8D4UIUCSFdgnWhtIEeOhrJjoj1Z+WqmqQ/uWV8hh5tM8TadA9sgpIKMLYpqJbSMevsg/BANS1d54DPrBu9dKHv3qW2GW/KvFRpRI9fkXmLwsjnfNFPZKcMfTQoE95zH+Go7ndHahZVvr6vcPP0zoR4Da9IF9H9zJjl5DBOzmIDcwCTalqo3PJ+IQ9kmGQXlhNaMc0rtV+WOYNjlHU/Yny7lbOB0t1AuSXaifzGdnPQddPXrVtOqpD7VTCc/a9aWFagcrQPfKQ9sVmTj9IJP9+0aYvW6S/osWGymuGPTvWZp/G5ANi7V5qrU3AZO2kflE+iKjfSUVdstWtALFgROMvnSgiuaV2SpkuXS4g/ADjyBP8xbF5IQYtNZTRmFyQOSMWKPwYGy4YWhBYzeijcfBx5/xTXZ4yW6m9YR7S0Jf+n1tTVXUP4v9KjeVUJUOsO14pvoWGWfCQ726d1Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR02MB5329.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021123027099003)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWc/IDlCcEFJQFzOA6APR1C1HCMrBR6cvsqHUIUuyhH8mpHQGMwp1ooin5Rc?=
 =?us-ascii?Q?qu6r1yqOu3vyHsCEacm/svUMtKqEr2PfxPuV+CXoLW4PnYNBMiwRLgcHWsFG?=
 =?us-ascii?Q?VVNO0EDESm2zsewE932N8wZ8/r+weINpNqZ6vRk8ews/mg9ls9viC6lBWM0A?=
 =?us-ascii?Q?/G/0cicYrFp2fe76ewvvJSItybzz5qQL20DxVHWNYMUnQuywOlHleiC/6Fl5?=
 =?us-ascii?Q?RSrZ+Q9rRX75Sy2+atR+fZbXQomUKdkZIrGBrAefqd8luMb20rh/iRV4cT6r?=
 =?us-ascii?Q?dL5Pf42PXAs7DzllJLHxEKThV1kvqdioSaQ5oL0Vf6ce/WPKJXeJqC3AGbor?=
 =?us-ascii?Q?peDHiNPH37xYaGWzREfaqziRguHR5UPf4Egr9Mfaa5nSZdye+ASETgFJ/i7x?=
 =?us-ascii?Q?d5FRDboQXsc4/xl9a96hpJH+0BeFqrnEpwD/r2ExH8y/H11NLqzVPMNMNXT/?=
 =?us-ascii?Q?LmFpBTo+dDCpaKQoYpG//W5zpn0fFoJBOiHl03wH1UFG8AGI+ei5qkPekNT9?=
 =?us-ascii?Q?Y3f8sTfnm+tWO14x12rA0QM9uDfIljQlf3FldZ0zYRWJzJ54GSiRm4fS5K2W?=
 =?us-ascii?Q?1kXun5hVR0C7G5IDZHhGqcpFhz7oOgFeakHc37oPjUGJGPSr+GYHIWHZfc5m?=
 =?us-ascii?Q?uHlvzzt/wEiAnFPGvbO9u0oyd6/MK4Rdziom3ED4iM5CgeGw8c3Dda9XUH59?=
 =?us-ascii?Q?VG+mwx9IWlk/1FFheb3wrtxCGQZudUzgypMKPr7RA9VqqZ+eTS/yJIzagTyp?=
 =?us-ascii?Q?7LFgEePHONlkZEpRo6CMURfu+C9VuD407EsGoU3XQu8dQmwQOf6syALj1vYC?=
 =?us-ascii?Q?aBh/VQa/wc0V49KUi0ea8OCIlOQ1Trh7VfTR1R+w/jHUpP2YH1QqGpk/ylEA?=
 =?us-ascii?Q?eXUkRe4V2STBzNRE0oJSlBQoLClSXXUFU0ddoC559vXlNWKA08fXa+Ff4Gf2?=
 =?us-ascii?Q?gmOYOJ4VB41i9vMrf2AdOaZ5w5CLJZzWwHCc2VrMy8VdLZpeeRPaghWdxYuZ?=
 =?us-ascii?Q?/+qay5LJx527qyjMe2Vchxanws+f8L6sObi2jjbqpGkEjajn3+k7EjP9MC22?=
 =?us-ascii?Q?9YBoLn8MLUhyoS1SkvyVjlmXX5zArqJpPELMXgzQAndXzaS0+lIrGFbfNoec?=
 =?us-ascii?Q?7LH7acJQETyoA9dwY8aH9LAm6fnH4scqDEXwEpDm9EZ0aMQLlQFzchLFGwGb?=
 =?us-ascii?Q?lPc3Py8SQe3cuWwJn4eInQE9flbaMfEPBTb+fiL8HRfx5f5L7mnSHIa7URC0?=
 =?us-ascii?Q?mLXktLdsnszUhmqpdy2XtcgMYZKwkT4revaCKGZuh1aGeJp+Lg2V3W0zQp0D?=
 =?us-ascii?Q?b35RNDI34FIHr9/b9XivCMemRsnb84H2xno0OtVS1GpCA/ONefMCI1pckIec?=
 =?us-ascii?Q?vy6W1dWUgQkhSO8XHzwgdTaqZU5AjblTFF8ObUwbdcH6ZC2D2ztB9vwmqOQ+?=
 =?us-ascii?Q?2XaidTCG32JKHxJMjukTwXrZtC1yVW0lw/ppKdq7F74Pq+CgZUZgIC5LBKcx?=
 =?us-ascii?Q?DFqr6UKilo4XrHIzrIPbWIg6PM5PT00qba0hc11f2TT7FNmU9C69hqLBWmdU?=
 =?us-ascii?Q?EG33oYB9h/BUpcMcCcDBQHxBVR6or4BBvea9SBRreuI8x4n3/VeV9h6XF0zJ?=
 =?us-ascii?Q?ZoHd85LOj3Yl7odI943rh8PNCMxw+7S1EUuk8XstFtwtoMfL/LPWCIygL6oJ?=
 =?us-ascii?Q?9T2zRPODCY6S06wx57/MIfUf0vRJOtv5SV7Lr2qDJhoOFj8LIsrOZ5bRayiS?=
 =?us-ascii?Q?P1EO7LRKXyHJJuHqtARtmtZkXhvfxDY=3D?=
X-Exchange-RoutingPolicyChecked: 5Nm9E1+cP4f1+46ZhLBDj50XOC79l0OESwxs4yHs8DDXna1LgObZoNZILu+Vxf6f5ODE+qL4vYieNVlZTOZ2jzgXyMABq4jpwoXLFm8gSwRpvuIiVAB8SNz0b1Z25rFpVbBYmNQU5eTk7Yhz/8d2MkIP3sVedkn3t3pH1IMIwaI0JbY7Qra1GzRguInZFXKCcS1oW6I+HgET0cHJYt1zyi0EGvnk1QQbMejgkX5HRPYsqrzT+lghVRmfV1wLsTzzbtMy4yKiVFIW/2As4muL6jNB8snfl893GrQbRy6/lmASED9nNrc/ezQvOgoRpnPUPLIAr7INblGuLBuTvYmB3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c5205d-16c8-40a7-30fe-08df396c2036
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB5329.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 05:34:27.2027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ndmEBNTcPlLbq4TQyRqLbwvL/lQtsCKjA8GLbiBuVd58t1XgsI1EbDosftgCUx75OLFRuH7E9QjrmETSdbtw1r+Q9f0dyIQngB8uSNC1RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7344
X-Authority-Analysis: v=2.4 cv=dZsVTnXe c=1 sm=1 tr=0 ts=6ae97265 cx=c_pps
 a=XrAAyJxZ/W28UfFUt0AM7g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=mDV3o1hIAAAA:8 a=LM7KSAFEAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=6rqHouBjAAAA:8 a=dGAneBrWY87vluzyH40A:9 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfX74IUMWQjU9Zg
 GqTmQitxDGWXWAj0yLsOB1Wh49My57CfBsAFEGTsIXAq2gYrd3qpI0IvS7u6DQZ5zGiTSZ//kKn
 Dgfbd2CcgIFQk0qCR7Z+J7pLZEec1EQ=
X-Proofpoint-GUID: oA2loK27LE4a7y6XH0p3LD1ADK36NMDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfX9uqLhwrxxI+R
 eZEGwgx1gZtvP/U49VuLr/mPKFrIFQ5p5wyD+yoQAw+htqWHeFclJ3utws86+1OJWAilCuJ7x7Z
 EWlGqxNvgTmoK1hMxCQzWpXLjVNeVKYuBJDpvwXZOTuu8q/SMkENQuLGc4hTcPXkeLVg0R2ZrWa
 6LZ3PorxIbqmc/Dg97sEWyAjs6MwgzcxyAJ9eRUM8h+eWLEK6L9q5m9Kxuiz1jDra7Ju/IDHhgb
 GIRPL7PaeQovB49pZNioOAT/oxS2759oLRsPc4CnzvWPo+Dsa/nNOQuX1yIbrggepxK+Q99apaK
 Aq+aDjrwxCL400ByHcIKdRmoSJaI7FsOOjRvYu7yjl/fojlNrNVgxZtcm33+NPUtO58plhK75/N
 ylUec14l7JrX/gR3I5Ec0z4tMc/NJlbbcjWhUVxGLZx0ebsUsIe6eo5Z+qj6qOojHejJIHNoPFn
 OJzaiHyUx2y+0a9EKEQ==
X-Proofpoint-ORIG-GUID: oA2loK27LE4a7y6XH0p3LD1ADK36NMDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=abhisek.panda1@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a Windows guest puts an idle SATA drive into standby, it disables
PCI bus mastering on the AHCI controller but fails to clear the port
engine bits in the port command register. During post-migration
handling, QEMU's ahci_state_post_load function checks only these port
engine bits to determine whether to start the engines and map the FIS
receive buffer and Command List buffer.

Because PCI bus mastering is disabled, DMA access to guest memory is
blocked. The consequences of this allocation depend on the bounce
buffer budget introduced in commit 637b0aa139 ("softmmu: Support
concurrent bounce buffers"), where each PCI device receives a 4 KiB
bounce buffer limit:

1. Silent Guest Memory Corruption (Budget Not Exceeded):
   To start the engine, QEMU allocates 1024 bytes for the command list
   and 256 bytes for the FIS receive buffer (1280 bytes total). With
   one or two active drives, mapping requests succeed by allocating
   private, zero-filled bounce buffers, allowing migration to
   complete cleanly. However, when the guest later resumes the drive
   and stops the port engines, unmapping writes those buffers
   back to the guest memory regions referenced by PxCLB and PxFB
   with zeroes. This leads to silent guest memory corruption.

2. Migration Failure (Budget Exceeded):
   When enough ports are active the 4 KiB bounce buffer budget is
   exceeded. The mapping call fails (e.g., "bad FIS receive
   buffer address") and the destination QEMU aborts migration.

To resolve this issue, skip port engine startup in
ahci_state_post_load() if PCI bus mastering is disabled. When Windows
10 re-enables bus mastering to access the idle drive, traces
show that it explicitly restores the state: it sets the Bus Master bit,
rewrites PxCLB and PxFB, toggles PxCMD to restart the engine, and issues
a COMRESET. Windows 7 does not hit this path because it does not disable
bus mastering during standby.

Reported-by: andychiu <andychiu@synology.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: John Snow <jsnow@redhat.com>
Link: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01544.html
Signed-off-by: Abhisek Panda <abhisek.panda1@nutanix.com>
Tested-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c         | 17 ++++++++++++++---
 hw/ide/ich.c          |  8 ++++++++
 include/hw/ide/ahci.h |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 86f6297dc9..5f842eff13 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -172,6 +172,11 @@ static uint32_t ahci_port_read(AHCIState *s, int port,=
 int offset)
     return val;
 }
=20
+static inline int ahci_bus_master_enabled(AHCIState *s)
+{
+    return !s->bus_master_enabled || s->bus_master_enabled(s);
+}
+
 static void ahci_check_irq(AHCIState *s)
 {
     int i;
@@ -1625,6 +1630,8 @@ static const IDEDMAOps ahci_dma_ops =3D {
=20
 void ahci_init(AHCIState *s, DeviceState *qdev)
 {
+    s->bus_master_enabled =3D NULL;
+
     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for no=
w */
     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
                           "ahci", AHCI_MEM_BAR_SIZE);
@@ -1792,10 +1799,14 @@ static int ahci_state_post_load(void *opaque, int v=
ersion_id)
             return -1;
         }
=20
-        /* After a migrate, the DMA/FIS engines are "off" and
-         * need to be conditionally restarted */
+        /*
+         * After a migrate, the DMA/FIS engines are "off" and need to be
+         * conditionally restarted. If PCI bus mastering is disabled, leave
+         * the engines stopped because DMA is inactive.
+         */
         pr->cmd &=3D ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
-        if (ahci_cond_start_engines(ad) !=3D 0) {
+        if (ahci_bus_master_enabled(s) &&
+            ahci_cond_start_engines(ad) !=3D 0) {
             return -1;
         }
=20
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d..44fd84d04c 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -110,6 +110,13 @@ static void pci_ich9_reset(DeviceState *dev)
     ahci_reset(&d->ahci);
 }
=20
+static bool pci_ich9_ahci_bus_master_enabled(AHCIState *s)
+{
+    AHCIPCIState *d =3D container_of(s, AHCIPCIState, ahci);
+
+    return PCI_DEVICE(d)->is_master;
+}
+
 static void pci_ich9_ahci_init(Object *obj)
 {
     AHCIPCIState *d =3D ICH9_AHCI(obj);
@@ -117,6 +124,7 @@ static void pci_ich9_ahci_init(Object *obj)
     qemu_init_irq_child(obj, "update-irq", &d->irq,
                         pci_ich9_ahci_update_irq, d, 0);
     ahci_init(&d->ahci, DEVICE(obj));
+    d->ahci.bus_master_enabled =3D pci_ich9_ahci_bus_master_enabled;
     d->ahci.irq =3D &d->irq;
 }
=20
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index cd07b87811..434a6457b5 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -46,6 +46,7 @@ typedef struct AHCIState {
     uint32_t ports;
     qemu_irq irq;
     AddressSpace *as;
+    bool (*bus_master_enabled)(struct AHCIState *s);
 } AHCIState;
=20
=20
--=20
2.43.7


