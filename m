Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5942FECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwsE-0001I8-IT; Tue, 10 Sep 2024 05:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwrW-0007tn-2v
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwrS-0004J6-SB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8tZZc008924
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=q0iQvauBKftLkn5wPQYkulRxXA4ngQtig5Bo3welgzw=; b=
 LyiXyyVpqkW8uEAY+WsyiOALwnxc/YQBCHddAkXv/1hnoknSpB/EfEo/UKSFGymR
 gOh81K4/LlUUH8llyS/kNVG/R+ZpJaepgf+zofhDbAqVM+9k77dMMm3vpUatBbNc
 xS+kucp4u02SuIGWDSn5iRFBu00ox+lPmdJqg5z6dYjMIZ6S5nBJ/iKUmOihi2Tv
 qlnDK3xSZ8UEqtawLvS9JwXE3OZh3ZLaGCSGZkOvEKvw/8dT2z9/dWiNezQmmtw+
 UmDoEJHq+cUUb0cOJGHlNn7Ndk8nywb/1ZaA8i3EQ0NCxHBzlGsOxGwyxHS27Dr2
 zbef0cFtHixqCDE9lud3DA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9n07t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A8ao8R005070
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9898f7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiVEkCkR5hKZlqiQU75FNykR8/8p7IA/ODBeC2o7nlVUNpTrSIMrdvJNRBkTAPkWsjaqa/+z3ovPgeWjwr8wsutXQLzoZfoMtjv+Gnsp7D6GGDHCjO6jM05RdNED2iF0TqOCyhi/CLp1FUAHS43+bawgziaQusGfyDqVNuCo+Jo2CXkp2FJEmHBA2RfAUEW2XzgeoLuHjTdYDjCzEt9OrzagR+c9NGGrEv2nFHowZ3NwxHdT6Tsm+ZQ6OUHh+jP0mZWWqczn0QsRzsQ7sgfMf7Xemjo0HK6lgxAsl2k3ZmfqenUQcj6edUEdMUbY/Tucx6USFYrMfi8gRA9MYr1HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0iQvauBKftLkn5wPQYkulRxXA4ngQtig5Bo3welgzw=;
 b=f0yg0j5CO/4NBemRyzkCAjWLJ/T5SCwEbZZ8+HZymtJ644cRLj6qE87uzqaKu5hqBuHAfA4ZE59ndcjaLHqX/RaldqUSXvwdGokGRW7HIKF/j9L8j3DGvwAVGAvaVuiTqxW31jF7dLwhoxPj1IQcUdAKmCQ1Ye78YUJUzNciE8mO0Aqleu0zf0da3NHlyZiWpyRvMsZcaYTtn5xvL4KcPeuuGHQSKuwJGfPFM1cey/tUlm2f1lJx40WyhTZ2OOXLj6gMLSLqGGNh6y5cybO72FwKgF8LAKfhFeJSRTIpgSAz/2jb05BDqt9GrB8/+Z7KeJlbjzAEV1FK7SmLPEYMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0iQvauBKftLkn5wPQYkulRxXA4ngQtig5Bo3welgzw=;
 b=mmuMckIFeXpcpDLW7Vunks/1pEfzkLfrcbGtHtYuj1l9oT1lbgxg0vyIiMSfFt16Tzip5Qhzx+gvua6JEvKYLdUpEhuO0DeuGVeDmHChMWpeiitGZ4WuXu64EZsvoQJs3X2AD9hBjz5nsoNNgCzKT27D7o2gr6beRiF0KX61sHs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:08:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:08:01 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 5/6] system/hugetlb_ras: Handle madvise SIGBUS signal on listener
Date: Tue, 10 Sep 2024 09:07:46 +0000
Message-ID: <20240910090747.2741475-6-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910090747.2741475-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc37579-713f-4073-a76e-08dcd178124f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4aC0e332yH5bykxnoYaZ0ENvAwfsePqd+xKkHQGDzlmc18xq4UJpplx/OT6i?=
 =?us-ascii?Q?ePfoiz94EtcWLOyMf1UtWCAFlZ/DO1HuAgEdwiN3CyIsHXoVWXj1xrn45U1g?=
 =?us-ascii?Q?yCue4V9xkaYOYbaq4OyhNqU7cTnSew1RuovmtxuGAAN3/Pd8xpVN9NgNmBmz?=
 =?us-ascii?Q?eL2T17jOu5R/S46D3spsPxlfwkPOH2aD5N21KG/utUXttzJ4p1cH3uWwmilR?=
 =?us-ascii?Q?0EGbdBkiNtD5Z19qHoCYAOGRpoeC1/w8pDPxToo/aiRXXekVB4/zic+U6kAA?=
 =?us-ascii?Q?IKzqmOSaYx3XloIOikqiJTjzo/FtsBD6YiAQw+1u1T/DqfwIcS8bXHUG+0ab?=
 =?us-ascii?Q?ae2RlxP1a5V8+LLV+3mn497c7M8DACzD++cqVdW8Yh1oBfA/wKqCrVMnY1Ab?=
 =?us-ascii?Q?WGOmIYG1tg9itnLNCftSNELfcn+OUj6byX1WpCKiY/kX+1kwmTd2+G9C8xoY?=
 =?us-ascii?Q?/4LoB70RhhY53l92srn9X0qeFx9ZjOEcZ+TtU40mui3UFH1slyeJIffz5vVx?=
 =?us-ascii?Q?/JdhYdPvphQwuQcjy9ivNUQd1jy+gzNZR3OPiIEYRA72G7I8ZiPqaNVOVGVE?=
 =?us-ascii?Q?ssnmZGo0qFn36Pscd5OwMEPidEELmsQh2oiGHnKj8FEBeNmrVPVMpUw62VD0?=
 =?us-ascii?Q?oW66bvRSkV1FoY9ck/ZNWq2rDOa7d8KcHwnY/1h3ZkcisdpERiZnXvOB8eD9?=
 =?us-ascii?Q?gTBhIjQP4epHSmEL6W8FJ7pNA8eNP4PXfTYnlmgLqAi2vXqYAhYjFweNKfHO?=
 =?us-ascii?Q?sypWq5SaTRHGCVOt3/AS9KPrVakroTauCTPvZAlHVMhvhSVSzvKUF98bPj0B?=
 =?us-ascii?Q?V/bxEEU+EILs9AMgulHva4nnQ2jeUlB8Z7IG0DOptPKvUMb0ACMlbNRgnWqh?=
 =?us-ascii?Q?dx78MEYrWRKnXB8n1jNl4/v/q7GvbqUzEp2eocPn2VKnO6eZR6TWTgc9CHFu?=
 =?us-ascii?Q?QrWD/yYjZSSnevH8i4qFJzYz4WdvZW+OMYjye9f8X/i2cV3iFQS/NsEm4vLE?=
 =?us-ascii?Q?a6BcXzWVBwXf0JxfWMlMdPhc3EQ6Ff0jMlKbPzb2XTkqxtTDm1JB7ycQskn3?=
 =?us-ascii?Q?xQuwkyib816+Y2gjUsAk0j/vYFw3fKNhy1t22AtD51g2QISDq88vvzmaACj+?=
 =?us-ascii?Q?HLndXpOI9YskQtDciVqvDLq+eMaiEeaSBDkrZqypi8lVtm7OBsyZoOV5rNV8?=
 =?us-ascii?Q?1EXuIH+74CQN3wVCxhhTkfZAHFlelR5ONoegensYt4tglr/Qpyk3cBfUNV0x?=
 =?us-ascii?Q?Kw/d47/x3LqQvobr+56KDAUUZmTiQ1QqIAZTVfrWnve9cfZpI4yTMWylfZFL?=
 =?us-ascii?Q?O5AMRS/JQDITCQg/AprDURkZvnUCtMk0hdeUFzn22jihfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Hfwcb35aQsBKMLbCaSlam7wKmfYbYhxA0jpeBMnUKvmJxQUOvtEJpZeP8em?=
 =?us-ascii?Q?oytZlN7uecC1micYyEzG4vAxek15jVGBzO1CNwD9o78snnquCbdxBaSH4KNm?=
 =?us-ascii?Q?M8HfaYkvXlee/JXgPfKZ79MqZRQJB8VUcHfAwoVzSmFG5GXNRWFetzXXnsDT?=
 =?us-ascii?Q?ZkTpcp40k5kjIZVxeOh65kalyelbuAIZkgHwv7/63dX9Q0T9ICH85VgZmqPU?=
 =?us-ascii?Q?fVHq8WQa972hBLc39Sxe+5Kj3XaH6mP5ngdwSUS/WgwNBsRm6z3kS5VYgdbu?=
 =?us-ascii?Q?aX9KTGrjf8FL2c3t1qYoIR8Rw7+1knezpjwUrojljJ5aPp9IxK9pWX9Pe8LM?=
 =?us-ascii?Q?I1XYm63n352mtWit5l2R3ERvRT6l/3qZiWsTOEj+wBWSX+Y/LOjWFHwBZxqZ?=
 =?us-ascii?Q?Yzs0DyeOZ7Bp9Unf6Yqw3y0v5RqylxVSH+a2KCq+FQlLgPJIbUxYWZbmswUz?=
 =?us-ascii?Q?hnj8fNCNVYziIJXRhydECwcqJiwG2KKi/s/U+6rJ4lPyRE4dxiHc4vq9/lhL?=
 =?us-ascii?Q?8/7E6zJACEVZnbO84EuTp0HzAJt75CMDaDrNSWVAa5UEbAF6JEJT7apPtA/m?=
 =?us-ascii?Q?PRB54d9kOt4p3+zJtrqnURLSKRbPNCsYnJjUWQw3znA6AbwThTypChJ6QraI?=
 =?us-ascii?Q?GL9sCChRX+iQM30daEbewKPdq2aS/Zr/R7W3zTKr7/CFz2mkHl3HtZrjbGGQ?=
 =?us-ascii?Q?X7LngFHSyD0d4mOAjXejPhr5KcdD61GrOXdF8db/WSgi3jQ7VjDsQVCY5PSk?=
 =?us-ascii?Q?JqBOqNa3/lLWHi0s5hEKjP45mkr1Qt2XoESRWuokhEZRlLWzEdf/BQWF2U84?=
 =?us-ascii?Q?6yz3Tig49cZwgsAgvhyfns5BTqvQAbCiCMijywmFf+y/AEGBweLdpn0iAA6/?=
 =?us-ascii?Q?wYB0j28NRtP9SQWDdHhftcb3JRNxLVzWtxr0pZrom6V0O7F5EgSIDFXAEZYk?=
 =?us-ascii?Q?wxSXI4DryjADLCZ8LYb7/JA5EGL3EcYnJq93De4d1Flunp0BhcqjBjAMQ76e?=
 =?us-ascii?Q?7QnHij1SXGsZo9cUHRnMzcGBRIUV21r75SGhFq51lxzA3WkqAvYbFBXYYKH7?=
 =?us-ascii?Q?93GqtIEWSdoX9i5W9VgSQ0aFWSVxfhkJaWxX+Oq/gcQpB3J2w9Ju50WeKNCs?=
 =?us-ascii?Q?HgmSZu/tdgK6wUnVjTgumIRYI0ubIpIPN5s/9Fgf1Al4E0BmjBDHzEPKSBpr?=
 =?us-ascii?Q?n98dhZtI+noeXJwcOsYk+RAh5y7TeCni6uFTPO43Kkfcdmsx0oUuv6OcR0k1?=
 =?us-ascii?Q?JjVfNM9xl1NkQOnV4Ush7hI9jCfFpT7jvSP+BvUDlpxvOqsv8ks/oIt6sjZS?=
 =?us-ascii?Q?aKztdpwnZ4+LSpp1o6Txl6osTd15CZOlnoA+O6mYAd344OIwYN0/Lpsmp0HQ?=
 =?us-ascii?Q?+gs4hz1uMzsCJ+ZMxaKVpNp67Yy28xbNoRW3KjWdEgAg3hGCeqShHx7AGyvr?=
 =?us-ascii?Q?kOfZcie9V+ObAROLS0CoRzhD8wgfQ7eUuniZr7DDVKd/qmmciHCp9cDD4lb9?=
 =?us-ascii?Q?igha08+029myW4f9pGJmN3Vc4rcDJpx8YAuV541oMmjqciTmyzUQE+642ik6?=
 =?us-ascii?Q?NBqCol5Ar1cCBcWx8V8iT5ekcvZT9lpxYzO10MRZIyM16CrLOID/lHod2cwr?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2utK5CsBJETOaN3R5ooy1XT0TN4vPuug8E0UuwfbGkv9METXD8WLd5dZ9vF5kmSL/GNygsQNw4ZPVa4IvrOD4OR3tVcNvy5FREGd7CO/ppTwNja+NIIiht3NSfD7SpUMcFKL6ITPlGeqnEejqzMLJJoRpHRJIujKeXwqKb92rDWw+jRKImR3k5lHzVsAgryi9B/2DgXYlqJjC5QRoXFI17vsn783m8HsYfFgZE5DDLYCmbaf1NTS+ISM70dJ+p1ucPPiu0dUUh/u19Slc4LRIi6YYevH49YiL+TFgycBqJ8Chlo4RT6BZfuUYozXB+axsItEObJ8VebTu/iDpTKrKZXQ9uWeut3Yiz5x5Fo0B4Wjcsfh7/tSYSaLb6gFQ5ZjazOLM5cAYTjn0+b1qEFhjIhHfIJTco4KmLAHUPtmq/Kbl/309NE473PdNdbgkH/k1aY++3F6n7lExIa2PsXtYNBjCLayHIT0/qACNFboeLrJnnycQWdvbGanY5QzQruwkwui1FfMyqOQOEvzyRG6V39mUQdLMANJ9gW9UIW9yJS2wAmOBB5+V2xxt1gQc3+2LlPcZbFluhaXltNJmLeV3vWQZdUsuEGqJOKdAE879MU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc37579-713f-4073-a76e-08dcd178124f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:08:01.4935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23FVuucykByfGD2BhHoEqrfMgNlRcx7vnab+NIob8RInmdVd/CEPDh8sS1L24NoZCwSSumdrgtjADKjgnYsuZvoH1Ef0FN+nIh8vNaqbye0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100069
X-Proofpoint-ORIG-GUID: Dd-MVO7QG7l2cATmoJ_eteIDhZuHQn55
X-Proofpoint-GUID: Dd-MVO7QG7l2cATmoJ_eteIDhZuHQn55
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: William Roche <william.roche@oracle.com>

madvise MADV_HWPOISON can generate a SIGBUS when called, so the listener
thread (the caller) needs to deal with this signal.
The signal handler recognizes a thread specific variable allowing it to
directly exit when generated from this thread.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/cpus.c          |  9 +++++++++
 system/hugetlbfs_ras.c | 43 ++++++++++++++++++++++++++++++++++++++++--
 system/hugetlbfs_ras.h |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 12e630f760..642055f729 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -47,6 +47,10 @@
 #include "hw/hw.h"
 #include "trace.h"
 
+#ifdef CONFIG_HUGETLBFS_RAS
+#include "system/hugetlbfs_ras.h"
+#endif
+
 #ifdef CONFIG_LINUX
 
 #include <sys/prctl.h>
@@ -374,6 +378,11 @@ static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
         sigbus_reraise();
     }
 
+#ifdef CONFIG_HUGETLBFS_RAS
+    /* skip error on the listener thread - does not return in this case */
+    hugetlbfs_ras_signal_from_listener();
+#endif
+
     if (current_cpu) {
         /* Called asynchronously in VCPU thread.  */
         if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code,
diff --git a/system/hugetlbfs_ras.c b/system/hugetlbfs_ras.c
index 2f7e550f56..90e399bbad 100644
--- a/system/hugetlbfs_ras.c
+++ b/system/hugetlbfs_ras.c
@@ -70,6 +70,8 @@ static QemuCond large_hwpoison_vm_running;
 static QemuMutex large_hwpoison_mtx;
 static QemuThread thread;
 static void *hugetlbfs_ras_listener(void *arg);
+static pthread_key_t id_key;
+static sigjmp_buf listener_jmp_buf;
 static int vm_running;
 static bool hugetlbfs_ras_initialized;
 static int _PAGE_SIZE = 4096;
@@ -105,6 +107,10 @@ hugetlbfs_ras_init(void)
     qemu_cond_init(&large_hwpoison_vm_running);
     qemu_mutex_init(&large_hwpoison_mtx);
 
+    if (pthread_key_create(&id_key, NULL) != 0) {
+        warn_report("No support for hugetlbfs largepage errors - no id_key");
+        return -EIO;
+    }
     qemu_thread_create(&thread, "hugetlbfs_error", hugetlbfs_ras_listener,
                        NULL, QEMU_THREAD_DETACHED);
 
@@ -288,6 +294,19 @@ hugetlbfs_ras_correct(void **paddr, size_t *psz, int code)
     return (*paddr == NULL ? false : true);
 }
 
+/* this madvise can generate a SIGBUS, use the jump buffer to deal with it */
+static bool poison_location(void *addr, int size)
+{
+    if (sigsetjmp(listener_jmp_buf, 1) == 0) {
+        if (madvise(addr, size, MADV_HWPOISON)) {
+            DPRINTF("poison injection failed: %s (addr:%p sz:%d)\n",
+                    strerror(errno), addr, size);
+            return false;
+        }
+    }
+    return true;
+}
+
 /*
  * Sequentially read the valid data from the failed large page (shared) backend
  * file and copy that into our set of standard sized pages.
@@ -321,7 +340,7 @@ static int take_valid_data_lpg(LargeHWPoisonPage *page, const char **err)
     slot_num = page->page_size / ps;
 
     if (!qemu_ram_is_shared(rb)) { /* we can't use the backend file */
-        if (madvise(page->page_addr, page->page_size, MADV_HWPOISON) == 0) {
+        if (poison_location(page->page_addr, page->page_size)) {
             page->first_poison = page->page_addr;
             warn_report("Large memory error, unrecoverable section "
                 "(unshared hugetlbfs): start:%p length: %ld",
@@ -350,7 +369,7 @@ static int take_valid_data_lpg(LargeHWPoisonPage *page, const char **err)
             retrieved += count;
         }
         if (retrieved < ps) { /* consider this page as poisoned */
-            if (madvise(page->page_addr + i * ps, ps, MADV_HWPOISON)) {
+            if (!poison_location(page->page_addr + i * ps, ps)) {
                 if (err) {
                     *err = "poison injection failed";
                 }
@@ -402,6 +421,19 @@ void hugetlbfs_ras_empty(void)
     qemu_mutex_unlock(&large_hwpoison_mtx);
 }
 
+/*
+ * Check if the signal is taken from the listener thread,
+ * in this thread we don't return as we jump after the madvise call.
+ */
+void
+hugetlbfs_ras_signal_from_listener(void)
+{
+    /* check if we take the SIGBUS in the listener */
+    if (pthread_getspecific(id_key) != NULL) {
+        siglongjmp(listener_jmp_buf, 1);
+    }
+}
+
 /*
  * Deal with the given page, initializing its data.
  */
@@ -498,6 +530,13 @@ hugetlbfs_ras_listener(void *arg)
     LargeHWPoisonPage *page;
     int new;
     const char *err;
+    sigset_t set;
+
+    pthread_setspecific(id_key, (void *)1);
+    /* unblock SIGBUS */
+    sigemptyset(&set);
+    sigaddset(&set, SIGBUS);
+    pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 
     /* monitor any newly submitted element in the list */
     qemu_mutex_lock(&large_hwpoison_mtx);
diff --git a/system/hugetlbfs_ras.h b/system/hugetlbfs_ras.h
index 324228bda3..9c2a6e49a1 100644
--- a/system/hugetlbfs_ras.h
+++ b/system/hugetlbfs_ras.h
@@ -1,3 +1,4 @@
 bool hugetlbfs_ras_use(void);
 bool hugetlbfs_ras_correct(void **paddr, size_t *psz, int code);
 void hugetlbfs_ras_empty(void);
+void hugetlbfs_ras_signal_from_listener(void);
-- 
2.43.5


