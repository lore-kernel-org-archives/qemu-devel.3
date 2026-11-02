Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD513606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=RMCjLxMF;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=i5ZhDRSG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwcl-0007z3-BM; Mon, 02 Nov 2026 13:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhisek.panda1@nutanix.com>)
 id 1xNwcj-0007yD-5C; Mon, 02 Nov 2026 13:19:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhisek.panda1@nutanix.com>)
 id 1xNwcg-00042Q-Bw; Mon, 02 Nov 2026 13:19:12 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HRl5D1311965; Mon, 2 Nov 2026 10:19:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=CVHb32j4NCwDm
 B8qdjnLlGdCBUseQb2W7Hc16ZCtdc8=; b=RMCjLxMFSjSJ0whdkPmZACyhL69aq
 pVXSOarRqN9MTDIPQSa4IAmv36eR490aW9RI9iQkW8WfLLL7KZWPAH/cXuSe6h3w
 HUAXpoL0fAr/7znUlX/pbHLroj+n93Lti0SWW6TwYPXZUG57Uc/atsQ55HKJ+Lk8
 ulhkEGNt2lM1FvOqpXY5U1dVPDm4OKDF7IHnha+zoP36yjVFJ9PhVrVxQx7w6G7j
 MhYbx6Yb3o53SJcmWqlNSwPX+voUG4VocDVK7kEeYIKVPLvfmLfnOUDvwL2O+eI9
 FtZwMUar7tLow2MAFB/Ww9JCH9axfEP/RJgSUK2ErS91HtWUT4ENe0dpg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020140.outbound.protection.outlook.com
 [52.101.193.140])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hncnsmewk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 10:19:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1Et9H6coXVjWkqiszHlMUf84GHIT05EIFxbEgkzK3JlDRXSUuhB2TWZf2E9KwVp7z8RzI4SyIC5wcHLHYgX8dYMkKA8fJn9nknOcbgX55wZljL3C4H25gZlV/xozoEqhfBiP+z8D4R2Qj3HrdY7s5QGZpobWsQmDk0ecp0GvV83z3HuA34aOcIH7D2L4AaxqsJiBKudVh4YvYFS1GLagB/ooUTfA/OqzJAcE/uUmoSkQHSiG449+oGPBDJPNSMj+umKbW0/w5HZ4PA3IL4hj+Gfax2Z1Gn4RBngpOIWOhjbMWTXSn4Djzx2Ur+NKIX8pKko+KwlIzehEugvHDvl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVHb32j4NCwDmB8qdjnLlGdCBUseQb2W7Hc16ZCtdc8=;
 b=EjrYhbe/ZbX+6RIFkU5d+dV38WGEXPveURAs8VvoxrtnuHgQUK0bpCT3Tb2t7vdACx4cu8iTOu5htJB+d3BxVkWltTfbHlf2Iq+DDFRsKEFsRtsZa9Oe5RHU3zAwg7AC1OFrH07lS1vkhgc3SZH7n2AReDxigceM7u0iLRDduFNWBSsdo5oW+nfdMN3cQ8C1atcs0Qy2aCAjckIMT0Xb/PWSjiMWCcIcMJ0PWjVuc6oeZGr/Enc+WNzjiepGRff11uoUl7lZ+mhfHIXwC9PtTu2AD7O44GQct2veT3WerU4jsV4FzlrluwyEcc43UpopytohEBT2SNlcY++6xkmCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVHb32j4NCwDmB8qdjnLlGdCBUseQb2W7Hc16ZCtdc8=;
 b=i5ZhDRSGCQ7lBMAt5pz3baJBvFDiPZ6Kvea6uu+pWcTCAPIut0G9vpPmOQ9B1cuwTA9oI4lKDgtE5Jmi82ujoWp1FDa8qwoa8hfQrRJXIPTxur1bW9SrEc3Xyk5KwdNhwRIKwQR0NV6+8LrNAqCrcb3lBHXhQ8GIYLAsq5zSIWKZDnPH6jfY6D5oH7c8uhAKGxeRbih3p+agtHYT9hjRLlBSJpijfyXV5ue3Y+/8efTfRzkFy1Q80UwuQbQwnFBmZITm7WMYxctZCgtHNsOx1eKPKtaIvyI+ugJ07DvLCqDMTMF5p1R1yoKB81yhEsm6854cP+/1FuO5v/oIOAmhog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BN7PR02MB5329.namprd02.prod.outlook.com (2603:10b6:408:29::15)
 by DSAPR02MB665783.namprd02.prod.outlook.com (2603:10b6:8:51e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:19:06 +0000
Received: from BN7PR02MB5329.namprd02.prod.outlook.com
 ([fe80::a3e:7534:76c8:6715]) by BN7PR02MB5329.namprd02.prod.outlook.com
 ([fe80::a3e:7534:76c8:6715%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:19:06 +0000
From: Abhisek Panda <abhisek.panda1@nutanix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@openvz.org,
 jsnow@redhat.com
Cc: Abhisek Panda <abhisek.panda1@nutanix.com>,
 andychiu <andychiu@synology.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] ahci: Check Bus Master before starting DMA/FIS engines
Date: Mon,  2 Nov 2026 18:19:01 +0000
Message-ID: <20261102181901.329008-1-abhisek.panda1@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To BN7PR02MB5329.namprd02.prod.outlook.com
 (2603:10b6:408:29::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR02MB5329:EE_|DSAPR02MB665783:EE_
X-MS-Office365-Filtering-Correlation-Id: d375e15a-a9e9-436d-3395-08df390dc7ca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|56012099006|261009223027099003|261028144727099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261022105027099003|10067099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: udsdxnG+S99IhFeKg884K82gj3vTCp0394PpS7wFvWQaCOLJO/ftUM4s81mRuH39egaOEB89qVf1scpKKk2c7r7XjwXfF5g31l/DCSFXDC7stuLsK+BejLcHmV6+OcOa4CDRq7h7Wjd0JNN044xInDBSVWOLb/8TLSZRgn3c6Mqo4WFdY6TDWzIKZgwf/hnA/wtKmszYC382zVt/+F3TztArgJxlsFcIK1T8kvxMxWpaxPj3F+j7mzU04KUwmL2ktvFkBsWVCzmRKrNwu97rAwuy7E2g/SBYazaOqs47Qvn8klQp6EbA/Y4I/LrAlF2W9dxdyiQigmQqquWQp+Fdm8hK93mhbO/PRJzJDlPI6GD80qsYWjQ22vUfGbcy7hGYF4A7aL54MQEhsV3IRFiLgoKSLlSB/ij5u13enDFeknxkN9Awgv4er6YEPVbuJmnLJfLt/H1Q1aA5X/l1BmqASzUZTy1WV+YxB0QcVY7FsqxAiX5NguZ3WjdBtjcO3RwxGfWG9WHmZUL7dLqCdDpMIUxePFilDWL2VHkqpWxiel6SvxyNqlzHDH17HJSETAmtzGRObNr4z1Li8GmoioIARVhYmox+fCaQu42Lv6yGvUPCHj+tOBYe+rUFIzvGhX+z26qL5FeDZPWqsoo0a5nOn/qIeizh7WQCMp5e5jGhbY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR02MB5329.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM9IA59zbbm019SsW2AGZamEiNT9c+XB5XW6Zde/TE+jc/d+AMZiw2LGtF38?=
 =?us-ascii?Q?FHAT+Ul39YESRY10qy+bPHAiKG9I7UpEd8K6yEwa79UAHZahrWknAeKRtPQl?=
 =?us-ascii?Q?LlBWYlD+IWICKsNjnWacfYcsOKHkuGrrrYS/SrylmRrrPQCB2eTU06m7CiQr?=
 =?us-ascii?Q?8B3xE5Yp0at5Vzly7NVu0NjwSd+gLDCiFUrIBeS6omprwvbfgMbzNoZci1Pv?=
 =?us-ascii?Q?Gr5Au2B2dL2PRh5V1iMCvUWQj/jx8zy/6PKHrHjnX4ErJZ4YZxAfuzuEDLNM?=
 =?us-ascii?Q?lD/O996wLUHc+z4AtjN6/RqRC9Gs3kSU/zbvnWOrMdG3nVsfx6DYhKrO0QBG?=
 =?us-ascii?Q?H5xAOjHOigi6MLP/kgEfou7u2P4OmqyNeAFghjLHyR4BbDCSoPOk9WJHMnuo?=
 =?us-ascii?Q?D1ojDqVJPw0qwXZUTkBja7Vd08SZObMzWHYRZdwVEBTwt/8b86+R1iHWKHHk?=
 =?us-ascii?Q?+fyaLRDGrodHZnMURvxygvMc+r69IBldJBLAEvgfq7YQ4QHHrfz5qbs6mX93?=
 =?us-ascii?Q?gyH5UqbrkO/3C2N4c3qqPn4gwiKVr8bD5AvZD24oJVKxLh8LMUFvfxfzhnMm?=
 =?us-ascii?Q?oJJyeuJjswf8IVVrFJbaFtrGz2wXTQJnIAUTescr8SXVqYyvbvjRYACDybgk?=
 =?us-ascii?Q?rYBc/Elgt/2pnacjdD0DJHREfrNYUzXxclDx4wkzVDSX9uEHnpuSuufc973j?=
 =?us-ascii?Q?UXWIPzfuK0bYgXTEchrZdHtcLz2RPiALRBN+wmpzPkv0sMFys/snV5zmEVHC?=
 =?us-ascii?Q?d9EF7UBldEmB/7WQO5gj84+sUjrwuisxUXVS5empepTEdlfx5EfC/ceZPrck?=
 =?us-ascii?Q?IuXL+Tt0wGiHuFODU7uV48ndQjYvOLJ+xodr94sv5L1cEw5NuB0YYFOLTEDk?=
 =?us-ascii?Q?MaZjKfBXt9DF12HWxQHlKaAJFhVddrEYGxGuZtV9CQmolHYp9ccys7W008uX?=
 =?us-ascii?Q?S9m08xz8xOe60Y42Aqt3NgGEVqwbXFgwtRmUtP/LbfzcB8K2vhwz+F8yWU6K?=
 =?us-ascii?Q?lUKHrziMV8U9pv/esVINAJFJ9M4g/Csfi26aTdsEyAG8WUcLC6EPEjXR8Uk9?=
 =?us-ascii?Q?YN9P6LmcMgMxQJpnDmNtsx4SS4Lq3l1LVXTFeBAq6vRF2+9O+/9qpbkEBQNo?=
 =?us-ascii?Q?xurrDFgcwnx2gsTHP/hd2g6F2GFQ9s5JYorH9jGQRsmScwvtZ14O4ebhGWcr?=
 =?us-ascii?Q?rj+ItH8L7qC4MRb+Vt+zyHt0PMIag9vJfhXq+vM+OVJSXfGxUdKTYMHN1Zjo?=
 =?us-ascii?Q?SwWdj7gqchEtc3Q27sM+oWUIrzMWQAVi8s86GENxjot7BdT16mloqZsKPagn?=
 =?us-ascii?Q?d+MJllXs6B3Z5NJB3A6Kk/XISMOBmsFJJXfLm+kSbFhbIXMO7h7BOUH2StdF?=
 =?us-ascii?Q?JDhfA1+JSwm7MOj2qyCw4YiAN+4jivwMlZtSUjR02GcJH3Msb0ZOpFaidtYT?=
 =?us-ascii?Q?2PGEYYB3YsVrogPd7mNNcnYflMaUVJO/veOHgLhHgjoNU35Xjr4kbpe9teQs?=
 =?us-ascii?Q?5KmlygsC1jiyqWiZvN7rTGAzmRLqqYe3QGDagAjBDunxhBYnS/5mEM2PSLI+?=
 =?us-ascii?Q?qZjuA04r8zyVjoFd9eNNu6eCPwNejIX/ALz0oB76Nzez6XHQIKIQAlu8rtAN?=
 =?us-ascii?Q?5JYi/3YRAfN4CdNdeTzx65t6+6N4R50Xw7aacsa+Ka+ckADWSVjVNtYGZCg0?=
 =?us-ascii?Q?8R6d+Jo7Kmelfe7TTr/XJmBsn18RQ0+vs7GmSWtrUwOmsL2ZSp3eB49sped5?=
 =?us-ascii?Q?NV3QsOxzHcZk6CZZ7FytxoA9UnAYHDM=3D?=
X-Exchange-RoutingPolicyChecked: wfCtRZOHoxBEwn67HAMVs+gZKgXJrfNYnMGqOzGIj/xsGcDCB/Yjx8B0lriK17ZMiKb3gl2A/KgnE4kMXkf/iz0jnSvaUsRQiUwYfygjg4fYzDnHKKSQd1hxXvxdmf3GJt1gU42PJxWBtPky8+dSQ7cTCgPXBOrxqM1XGrtAMPp4Ne+D/b5dSYrPKiKrlAEUnkDnbw+qAd5/GxF6PIQXQtzvsL2wgv2drFPHQXzJAcapm0kjsAbl/jpJNPFsHoXwMasDfig2nsrZrIyE+x7yur+UGip3H9y8Y48ZlwcfC7mkRTRYfZiHDD0gBetTQECpfz6h05Jq5k86xIyHKHd5HQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d375e15a-a9e9-436d-3395-08df390dc7ca
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB5329.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:19:06.0778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYFRc/MUAMtWGGGJ6PMDjaZrusPw6vz8W1DbdnFD0pINtF9ZIcFpcQ6ODeblFrcSRpHc4oFNDcMCSDoRysjUGa7Gfu4RlNM2pwRwuIXAJSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR02MB665783
X-Authority-Analysis: v=2.4 cv=Dt3Da2/+ c=1 sm=1 tr=0 ts=6ae8d41b cx=c_pps
 a=Wk45V16OzwFZ9uDPeOR8rw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=mDV3o1hIAAAA:8 a=LM7KSAFEAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=6rqHouBjAAAA:8 a=dGAneBrWY87vluzyH40A:9 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-GUID: ng_zber3vdxW8Sqni6HfxWEqot55sPjb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3MiBTYWx0ZWRfXzD2W/QkY+vST
 eKKMGPVnDJbtqF2KywD5dYWMn+J2wzrCAoPVYYNKUiSvIElu3MVAhFx0hLF8zYFxy27otL8y2ee
 w74cItwTX+U5q/GuSA2h5P3BAlGpxO3gq89aWyY3yJBjpNndFGqE5NUDvVNn16lKNSXmV9wVlbm
 8+lY3zVvVPKo5EC9qtfuQb88pbW5/QM8pqLpgzjjyLtA/NOf1FgKGkOMpmeFRsgLDBp//qtTxgr
 iQrspl9ly+5+ySJzpfJ4IQdTEnv50OkP1mmKR5yZb4JqRIlDKvDm1Js9OVBF43lt9IpYfQHCGWe
 0ytXExplfiUJIdCOCraugfvuHGmXLc9gU8NviCRO9VWpKHxI+fJWIVvMCOxJWaY5C58zXmPLUBZ
 rB5GkWqqK3KFkfJJCoVmyYgu23xv+mX36+vUUN+6ER/X1/YCCNnDFn3n+zXHTRXV7nKaGmchJ/L
 gWQhgxJmJ+CzToUf/Ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3MiBTYWx0ZWRfX8Daqktk++9wQ
 wcDm8nnILDGJMpjYY7FuJfbHrizOiHtBDt57GWK9JUCaopGH/3d58BYJiwJOb4+7broYVX8se51
 mdrmYzcsUnaAMwdhVMpW5DC5CdzZpq8=
X-Proofpoint-ORIG-GUID: ng_zber3vdxW8Sqni6HfxWEqot55sPjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=abhisek.panda1@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
index b00987f08d..8e8c2e108d 100644
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
+    return d->parent_obj.is_master;
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


