Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67624C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxSd-0004hs-Aq; Wed, 02 Jul 2025 09:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWxSZ-0004gf-UG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:25:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWxSQ-0001vi-Fu
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:25:10 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BiTMC024288;
 Wed, 2 Jul 2025 13:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=lpCTw46G8NJ0zL5by5hu03ZJQGQ3Z2tmCcVWGZowgAw=; b=
 JEjT0CTxk6kHam1iQLfB5D5Z9di+WfKObO2oixjsF0gYv5Z973XO6x8gTVuYAKNl
 UnWsqDmrfyVbWom8MRunnEq466vgi6dGouxfte+Lanb9xJwWyA6CEwtTSmLf1XaY
 DPo2ctM2phG4hLA62lJla8Zq++/CS6AXvteTQ3smLAC7KDyrdnj3xuQA/vWKzb6+
 J+LD40PpIj3Cgtgx/W0x1IjvgFm4fXPQy8cr4NxPNCRC/psdepnnxq3CjK3uC8TP
 zW+NnvZbko41kbQyYGc2ZdVXwh8wRz+L4OKE0Gmc0PdBYv8b2g3E2gJH9yX9IWvm
 EKabbWO6JEAmTXighkx87A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfevkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 13:24:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562COSqm025008; Wed, 2 Jul 2025 13:24:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ujf9y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 13:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7vY1Jot/wcJSGsoknOtI+ywR4lpRpx5MVgs7B6O91SIiBaw1xtou+cFRq3Yu7BzKiKQzBiOtG7nqFwBYViUtD0pUtod8QgtsoSceU9CYGx4xMd/n6PEP7XjA6r7hTagPKvuuzyhDZQO5teGUt3CJyiRyKyRZXOWEkzBOtwmrJ6YsIVoAukX3sOFHISskO/McwK7Y3aRBQePFyXfONGTm7vYLGiAHrgkfrEefkqHlU8UOMAeCmeF+YpDAz4obd7rLnMcn/9tlFEWopn1IgSPwAIwDOU2SJVU5npWfX2T585b1uWG2ajmpHEeD5AvdI5RovN5Q9R5aWLESsbkwER34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpCTw46G8NJ0zL5by5hu03ZJQGQ3Z2tmCcVWGZowgAw=;
 b=CjOjAeIVi5NVrQvmoFYx9JpQhDMSXLgvXVCaq0iFc3JkuxvyYbnQbfjAW88T3x6wjLUbH2NQ2gnLAMtdbV/EUqIMYhovu4bL1wyTH+wrK6/lNGgHKEJV2hBewYtVucWJgd1xOMl+cJNeViY3My2AQJoWuVqQYXGxUHQsuVVODpOk7LvY522vYc+JfFoR25BA4yPO8RwIMDwki6IultltDqQdzNHwyyhsYCC+gRxp9RtzIixmYE70b2wYE9Jea08lalJOE72JHmqYl7JoKwjqrmJbJWp3xOWPyyu9k4ZLoMIBtZ/X9dP3wFfDecwT90/a1amlOBdJMbu2PceBQLgjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpCTw46G8NJ0zL5by5hu03ZJQGQ3Z2tmCcVWGZowgAw=;
 b=FedUKjPWIwtIh211V1QMl/agDhVnwEFgFerTe+Ke2ZsXEzOwv92G9V2jsgI8XfARQclrEaTV5Yr0c+hzQXD7f45MtK2r5+ZE+ziW7xL26HH//oExpTdgecV2EPCvlN+3wEnZQUP1p5FO51NKi6Rkr1otN/Ng83jc1VA3dlB4nGU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5710.namprd10.prod.outlook.com (2603:10b6:806:231::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 13:24:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 13:24:55 +0000
Message-ID: <8b751d27-7826-48e8-9821-9a961e2f509b@oracle.com>
Date: Wed, 2 Jul 2025 09:24:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, clg@redhat.com,
 john.levon@nutanix.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
 <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
 <b2bb792b-183c-439b-90b5-9a2f6bcfe864@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <b2bb792b-183c-439b-90b5-9a2f6bcfe864@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: ed56f42f-e744-4bdf-2651-08ddb96bd55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFhZQUdmeXlpc1ZZYllZV0dZUDk1aWhoMFFqdmlZQzdSeTdaUUpnanRtOVNj?=
 =?utf-8?B?MlhnSlNBaUl3MmdiUVkra0wxNlRUbFc1WG1RS0k3cXNoYWNJNFdkenNQNDFI?=
 =?utf-8?B?aiszZEJFWDUrc0pxTkhUUXN0Uk5zSjBaekhxZTNFZ2doYVk2QUd2SlJzTkRM?=
 =?utf-8?B?VmczbFAxR2hpdHJ6MC9GK2R2MUlzdzNVNm1UN1BDQTBqdXdwdEE1ZTQ5cnBy?=
 =?utf-8?B?Zk9BRWdDKzdTcGdBSlVUUVBNMjUvQ2NOb2QxaVFRZFJmdUwzSGszN3RCRERq?=
 =?utf-8?B?cUYxR25nQVJ1WVNJSkpXMDJ2YTcrMXFaeWVqOWJSaWZLck5xUVBYWk1WeDNO?=
 =?utf-8?B?d2EzdjJUYWJtYWV4S1d1NklJSVU1My8yVWwvNHl6YVY0RTE0VFpqSm5ZMmtJ?=
 =?utf-8?B?Uy9iS1BMbmxmWS95Y0ZxQVNZeGt5dmtxOVNiYmZyZnFwMjBQdXg0WTZoYzFV?=
 =?utf-8?B?ZzdKeEV5MUVJNndaOHp1L0N3dHhIYnJ1akI5cloxN0ZwR0x1bmNzaVp4bHda?=
 =?utf-8?B?Qk5ISHM1enpucldITnFaaEpBbldVNmtweUtWQmtPVHRibEpxYWtkcks1VmtS?=
 =?utf-8?B?Q0xNVXB5U2RvN3pTNTVPVm5PVDcvZXI4cXBiOXFoNElQY2ZNdGxnazBCcCtK?=
 =?utf-8?B?R2VINHZxcjREVSt0VWU4SG9xVmF5U2pMTTUwYzA2V3RWRjVieVExNmdBMUJ3?=
 =?utf-8?B?T0hnMEdxdzhoZS9kSmoyWkdXVVk5T1pBODVtQ09FZVM1ZnEyMVJnaUpydzhl?=
 =?utf-8?B?QWJMM3pzOGxFR1ZLWCt4SHlHQ2JjclR5bnpCL0dUekVuNFVqTTI4QUhKOXlz?=
 =?utf-8?B?UWx1N0lLbzlrMVhsUm9QNk1vYmc1MXdvODNBMmNCL296SjY1Q1dlMUc1Rzha?=
 =?utf-8?B?bVM5NGtKd1Y2Z3Y5QW0wbzU0eitlOHlMclo2VEFYM21OSWxBOFZ0QStEbWts?=
 =?utf-8?B?TWY0WlF5eCtEem1abWRwM0EvcVBnOGRadVBUME81alJoeWw0Sk9HeTU0T3VT?=
 =?utf-8?B?UGNpTzROZElFSVpQQUNjNXQwNnBPYVRRQVVUTGFBSGxSdEp5cWxEeHBFcnJO?=
 =?utf-8?B?bkZJQXF1NVpXbUQ4bjk1NFlHU2FVeG5oVHFZR29zSVNOMjN0RWFOc01ETGFN?=
 =?utf-8?B?cHJLN0pxNXNPOGJjK3pPc2M0ZS9iWUxqbG9HWmZMREpOZ0FVT2ZKNnZ2YlZv?=
 =?utf-8?B?dkg1cDBTM1dGNmtZS3ZKTmZXdGtmU3UrRkRQSERIcTVQc2pmQmYrL2lKb0ZC?=
 =?utf-8?B?Vm1aQi9BYTRrSXQyL0t5V0xuSmVTd3JXTGoxRzZvN3orU1IyVnltZTRRUkxa?=
 =?utf-8?B?dXNodHJmSEYrMlF6SFVCazd2a0FNWjBZNk1Ra2srZkFGVFhLUmhGVjAwVk54?=
 =?utf-8?B?NEtwSDFhS1g5OHpTckpQSUd0TFoxZ2E0VlM2bEs2VzAvd090RGtKYWY1WUpw?=
 =?utf-8?B?OER0MFMyVWc5QXA4RnB2R01JMWRmNFN4M2tDSHFOeHhqRDRtUjBIaWxXdkdI?=
 =?utf-8?B?ZHd3d29YRTlsN1ZpQUpscUdvTzNUK09RZTNreEJRNHVlQTlWTHZGeXhMVmRy?=
 =?utf-8?B?aG16Z0hXbW5KaUVzZFhXSHh4Z3BhNEhkK1EvOE1FNk9LSEozc3Zqek9KZ2VP?=
 =?utf-8?B?S0UyYXBoWk43V0poclk1Z1R0aUVaNnhob2xBZFJMWGZqZXArNXBMc1k3OVhr?=
 =?utf-8?B?QkN1MHN2L3pmczJEOGYvb3AwYXRCZTBxakttdmRTcUFHcTNnZm1icFQvZHpr?=
 =?utf-8?B?YmM3TkN4N2FoUFA3SFpOODZDRjZxc09kMVJlZUJTYng0S0Vad2JBalltTmNO?=
 =?utf-8?B?M3lTK1dGbGZDQVJ2SGlFSlk1RTNXSis1UCtpZDZOQ0lMa1dIc0hjc1QydG9j?=
 =?utf-8?B?S1ZkNHJWYWp6TjZnZFU0Vk02eHdBcTdOak5hYlNoS0FsWms0amVZS2g2MVJW?=
 =?utf-8?Q?L6o6vP6u1TI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmw0TkQ1VmluZzhwcTE4dTBPa2xiNjlndXVPYVJVQTdXMjRibGJpRjh5b1Vi?=
 =?utf-8?B?RWwxcjVPR0hVeG82dm5BUTh4UTVwUjZTaUFwcHJ6a1BzNS9wMWFSUlU2bFlW?=
 =?utf-8?B?Rmx4VGVaWUJJbjUwRFh5QWJzOForYXpDNExOVFZ2ZThpQlJkSWwxcWlsTlBZ?=
 =?utf-8?B?WlZwMGZQdStZcktUSkVzc0p0bVpOanNZQ2krcEt5NmYxNmZwRFlzMjN4WDk0?=
 =?utf-8?B?c1g5eTc4TW14WHlKYnZOSDN1S2pxd1g1S05DUlZ3eXhwbmEzWVA3bzZBVmgw?=
 =?utf-8?B?WWZkaGVJYk5xcFA0RkR5SndNYlNzcTlkTmpuVEVXNkJuUmNkcWZ0ZEYwQWVs?=
 =?utf-8?B?eVJLWFZqVE1lZGJxNER1eUFqQVQydkNXK0U3TG13Y3ZpU0pYSUJ3eWEwTTNP?=
 =?utf-8?B?UEJiOVN4QjlYOFErc2liVDErY3ZZTkg5V3FXQm52MUxlT1g5NlNLWW5vR3pR?=
 =?utf-8?B?N2x1ZzVGL0pnR0F5cVYwbC9wdEtwUEIzU3ZSUk1SdGd2bTEwek5vRm9SL2sr?=
 =?utf-8?B?bnF4ejhMU0t5V0ZnY2lvSXdOcWtZNXBmQjFVSWE4YkVqYkNiZDZsdjZqczJN?=
 =?utf-8?B?WEVPQTRLSlBodTBHTDIvUGVlanRHYTlBQm5PekZUVmxHbHVRWExwMHFXeXVS?=
 =?utf-8?B?eU9VVi9ZNGtjNXJsZS9IdnVoelhxSHM3MzRHaFpWUU11UGlMSmpLWnNUV2ta?=
 =?utf-8?B?VDJ3amtjZmV0SndRb1ZpSWdkSVRHU0FKNGR3YlY4RFgwTGxWQkxOdXBwQ0hz?=
 =?utf-8?B?bkF5R1F6UC9LNjRsWHRlZDN2aFMzTU5ucHFwa0R2emYvQWpoRDhueCtUM2l6?=
 =?utf-8?B?WFpoNTNaNlA3b01SSGloNHA1cDVOc09HUjlLNFcyTm1YQVlNZFRKdXR1YmFv?=
 =?utf-8?B?ZHBWVGx4OXQ0bDBuQWZxYXo2ajRCUGRQKzY2dy9JOERQcGZOVnlIL1RvS3p0?=
 =?utf-8?B?M1BjenhLSjR3a0wvY1NtT1Q2aGJLSHJhSTlyMGNCS1RNOFk1eDNoZUloQk9m?=
 =?utf-8?B?RndWakVyeTFyS3Y2VmRXWW42VG10WW1SaHdKN2ZVbU9lNnNxaklOMHFzdk9t?=
 =?utf-8?B?L3hDL3NoS3VXbWI5T0R6U1VoRERPQWxLVnhNVDY4V1BudnRwcWw3MmRQZUlP?=
 =?utf-8?B?SXlYbFRERisyaTZocE1sZGFjN2MvcHdraDc2SVQvYmlEK3dKMHE4bkRWZkoy?=
 =?utf-8?B?NUxtaUV3cWxvelZ6cTE3MXExV29JNzNCVzQvZlZHZGZ0ZzFObTd2dDZtU1lm?=
 =?utf-8?B?N01HOFpSek10V1BPZWNPQTAvTjJNL3ZlVjB2bFNLbm9SS1g1T0EvTTNpUzdZ?=
 =?utf-8?B?QXRFY0pMTjQ0Rm9CRjArUFd5NGp5VVpBQjdHK0NsdHNlczJRVVNoanhGZVFv?=
 =?utf-8?B?ZlpvQ1RDNGRHbWtjRUYyTStMckExYThEaTk4Z1hlaXJRclpaVHZpcXRNR3BX?=
 =?utf-8?B?ZlFQL1R5SE1PUE5kNlpvbDZmRW8yRUFzZHJKR2ZhVmZjWjh1eVJXUTFxOWxy?=
 =?utf-8?B?VnZlbVZjOFFsNktLSFJCQ0Rod2g4cE5waFhBN1ZMcHFxN1hhNjZoZEE2OFlR?=
 =?utf-8?B?czVRcUlZemJFMlB6amVpOXZmb3ZDNVJ3QVVxbzZKam9jWThqVzdOMmY0RXlC?=
 =?utf-8?B?OEdTQlNpSUd2aXoyN3RvdW9KMVgvMVBVTjdOK3dBb2hMbENBcHdFdzN0Z3JO?=
 =?utf-8?B?R1BULy9jUTV0YmNjdC8vOWVKS2lqRGxqdUU1My9mTk5KNkJEdDR3Q2Q5ZzFx?=
 =?utf-8?B?cGc1R3c4Y2NsUmFqUGUvV0JRd01Xd0FqaWpLM0t5NmFwQ0I0ZFZsMXZLRnI0?=
 =?utf-8?B?UngzN041ZTM0YkZETWNCTVhSNUVqc0lEQVZrUm9EaDZ3aTQ1c25nRDhsencz?=
 =?utf-8?B?YWwzRmFpS1NTUThGdHEzYjI1Wnh2YzRSeXg0YVNGdVphMC9CRDVXUTNMa0Fi?=
 =?utf-8?B?RHhaTHNGbHhXaGo1UVlENWFoakQ3ZDhDSlB6MmNNbDZPMzFGL2Zib1pNbjBu?=
 =?utf-8?B?YlBIZ01yT05PUDdHaTZpZm45UUY3WXQxbGM4M2JkVmkzVytIZVZ0VjlmdVFB?=
 =?utf-8?B?RzlwdEdNb05IYWxSTkxHdndFYzJBNFdUSFZjMWZTczJUMWI3K002ZUhLMzRC?=
 =?utf-8?B?c1JPbUpDYWVXdnBWa0ZMLzJXSG1UbGdtSmNGSEl2eEF3dmVtQ3ZpRnlocHow?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MPPP/G57dm16kSXg0le9YgwDrpXNotkY1Dg/tsfb+Az8C/Jf8BABqnlNzO8xI88Y1RavBqu3Trwm4852QAeY9ZgjLOA4+giK5oabEJ7WDOW0NF2RCbAo/yDTgP9GYP66GH10biF44MI3pysSUXbIAoPhQTU/fhXtrtENyutZEgWxuQAhwx29prsSmUqbn1I9xsEx2/ipYb26f7mhI1EVzDPBLXWhxK7yEOXzsOG0BOZmFr0llJr3ZN1mUuRg6iVLkYdIlWRG+A/N7h2vCoZQKW0glUqNcb9MD2cH8ygGBfrEULG+8HRe1KsbyCxdOuo1LXVqT2CN6qLRDD7L82a4t88Ne14a4OFDY8Tvkue+ky49NyisneRQkGHMHuZ4jAwCqzPuc2PJnDFEkQt0vJHLeGI0GCpJ3h/e7QWMKMQ6chhLY5WUuyGLqfuA6kdg3fAuXBRsCRuUPzrxKE41CWqAJb3xCDc0JkavaQujkiR4mjf4BlwsT7d7VQO76UfunoWCEdlglTLrJC5vJSzRPpzj60RfvQ5HDVz1H6e3LypLB/PLwxHT65NEre+HW9qB3FStfg4NMcSMrDacKI//wlCm2p4XE9IqpWnUeDyfcNcqICM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed56f42f-e744-4bdf-2651-08ddb96bd55d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:24:55.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziGVmAkKOfocFaM8sEbfmGfo0P08AdgcjGKN+e6dGRiZH2uXj7u122iOPDvFFhQEnV7y52GjPRQX30mc1nbBQQmxImpyx/mXUumzE1zeXVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020108
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=68653329 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=64Cc0HZtAAAA:8 a=dU9OYu4fhAMAHyTyhCoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-GUID: qxFqVlNaHIBheMJOoAwmclsvf9aiBGWF
X-Proofpoint-ORIG-GUID: qxFqVlNaHIBheMJOoAwmclsvf9aiBGWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwOSBTYWx0ZWRfX5tUVAwZ/uHTO
 NvwR54MTfyFzLcGZsfgvCpT0GoxOAPsoNxxYCuOOKhM0v1CrfPWuHruvArzUFiD+AyDhUgAayfG
 yG0TGsFqu9Jy/2twmJv9wAiryj7OE/zMD8Ug8lo1eKStXh3qFCHxtwYXqW+4LUSgoOy0mUceiqv
 3xvUdOoOx6EMR9VxQXr3PJuu2HZDQfVxrCu027sGz+peYrhzp2+oFeewgQBTZ8Rip4xrp9xX/uK
 m/izP6xbAE+RxEM1BGnQ0a0wb+FPLnKt/HUXliHk0CF9Okoi8ODEHp8Imlyh8KMouFDtvPct2Gg
 TBU4duA8OQoIaq6XQR7eQrhqgc1MPulbA77POJI8AXCJjkgrZIjD0aJh846/ESeVzrbDJuC1xc0
 aNmCeNqj8hQtQG3HL8YvP44kfVkhArcn36v/KjqQvrnnF5H6U5vq5sm9j3nC18aVFlEXJMFk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/2/2025 9:21 AM, Mark Cave-Ayland wrote:
> On 02/07/2025 13:07, Steven Sistare wrote:
> 
>> On 7/2/2025 7:59 AM, Mark Cave-Ayland wrote:
>>> As the full cpr implementation is yet to be merged upstream, do not register
>>> the vfio-user container with cpr. Full vfio-user support for cpr can be
>>> merged later as a follow-up series.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> This is fine, or I could drop my pending patch "vfio/container: delete old cpr register".
>> Thus the vfio-user container would be registered for cpr-reboot mode, which is fine
>> at this time.
> 
> Have you got a pointer to a commit showing how the registration should be done without using the old register/unregister functions? We are certainly interested in looking at cpr here at Nutanix, but since any work is in its early stages I don't think it matters too much if the old functions were to disappear.

No.  cpr-transfer for vfio-user is going to be a bit tricky because of the external process,
and the existing registrations will not cover it.

- Steve

