Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7516AC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 09:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIOWK-0002DT-II; Fri, 23 May 2025 05:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uIOWI-0002DD-SC; Fri, 23 May 2025 05:16:51 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uIOWF-0002vM-D1; Fri, 23 May 2025 05:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZJSz8Hqq4AmMU6uHUFc8L5WFghbVMYsbTRnMFvLjh6dUi+pNs8MeNyKWhGr7d91cjBaKeVYwz0OPqCUxZlTu2CMQOW91nLJ16F/4uSvYvL64pq/d6c7bvr5bIY8SQNemTqF7NzBz57U/+uFdVGQGURNi9YvInZH5+BQ8v7KUq2XinFoIQOBhrIAbKjByARBxaRGsjAPRT/Lyn3S7wNF1NPRFUfkaMLG1G1yeH3WB+/ctcyYWsLVssfdHH4tVB5pRRg3g1k9lA6jMWHKKmM6YzC0Dz9T7/qUYaGpoPpI/ToR7AaZBrX1CUHruND+EKBf3qZ+Vx3XTBowYw5tXcD+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcKYnpn6Tx/P0EdmU/2mUFWI9v9+u09hwYR1MZjJKVE=;
 b=J3r1Vig5S5oJkOmlExGhN8m+II8XgyTsabuD9LpCWCcWxZ4e3+5maCSMTTr0gNPzInH6nYVP6+PxTi4P0ihZR5sD1SRYxYMv/FsJjPGeC6bVzHjfw9bj+5zH8KdT0tYpJPBoZxPKIipOR+AFH0JC3dDCO/CJzl3dHVHJ2b93p1GI4Yasie+C63aQTbBK8ABlNGRhYoWedTUXTaV4o88/PX2UVcNUElJVhiLmN8aE0GXPIBWAIBnSgzDbWc3rOoAh0Qwgs4ojz+xN4slX4N7GLe2jAGC1RbZ3fdHIQWE6aSV2Windz0legFdUL1jWpxDglrIaVkVFXw+kskEt6lQn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcKYnpn6Tx/P0EdmU/2mUFWI9v9+u09hwYR1MZjJKVE=;
 b=R5KWBGni5XOPB9aMJjAkp0gMJNme+ryv9vnBFi81CasXTqd2a6KN8eXnv5rVXVFiQj7s6+575mO0DJ2lDbS1W9P+2/AMw1q8k5BuOmXyN/IQ2PauDywOo6s62S5OJGID4n/vmm+JldpHSdVgdwFgyo0rhLubgcv6VZP/gVs4FlEtYsj0EBN1UlWWhgY5B3XGrTQOA7szXqGBrVfTf4OivXA2vYQl8LJXK+PhivcF2mvZ1VVTZ/6NrzjznRLCWdgf55Y2/+gEgtDB5ks3lrgfOKyTxqcHPoD3/KK4trEkhy+ug88d8+YiGWCzKJV80GXQMYLGANCYgtPGInzE6ODtzA==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB6717.apcprd06.prod.outlook.com
 (2603:1096:101:17b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 09:16:35 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%7]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 09:16:34 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 1/6] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Topic: [PATCH v4 1/6] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
Thread-Index: AQHbyvpM5pV2daqYyU+ycFV8zjXVU7Pf3eUAgAASPCA=
Date: Fri, 23 May 2025 09:16:34 +0000
Message-ID: <KL1PR0601MB41804A5716A72B83196F7C3E8598A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250522091701.354185-1-steven_lee@aspeedtech.com>
 <20250522091701.354185-2-steven_lee@aspeedtech.com>
 <2c8cfff2-8a8f-451a-8495-7f151dd7a376@kaod.org>
In-Reply-To: <2c8cfff2-8a8f-451a-8495-7f151dd7a376@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB6717:EE_
x-ms-office365-filtering-correlation-id: 9c526d00-9264-4d1f-1de8-08dd99da83c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NEF2TlZWTUJBUkgwajNpeDc4N2xhcVI1ODlRRmZJYkZWRTdBbGxLaUVpUC80?=
 =?utf-8?B?SGxISmlHL3dWdUllbmp1ai9qd1NjYnNLcVZTbnlMTmgrbjlWeWcrOTU4TEtx?=
 =?utf-8?B?emZEK3NGbG5GVTdZYmhYc2dxTWdnV0MvR3FWVDFmVUhVS25EbWUzWllkcUJi?=
 =?utf-8?B?cDc3bFNydkpBeXN6TGJpYW8zaE12WnNoYm9zYzdBZUNBOTFmR3JQTGtwYnFt?=
 =?utf-8?B?bXp3RWJZc00wY1p3SzVPaWE0QnZtRitvbk5pY05FTmxEdmp3aU5rSHVTVm5r?=
 =?utf-8?B?Z2NJYitESXMzdHJFZytZb1VlblFkb0dBV1RzaDlrU0VUUEVxZXZjY1RtbGkr?=
 =?utf-8?B?UWNJS0JXOWhhUlZlVkpJVmNTN01xbEUyMWUvYW9ZOEZzazNld2UyNGM5S21H?=
 =?utf-8?B?b0lNMmlKTHdkOC9qejFYY2VxWWY1aXdCbUVPVkxTV3ZpNnNpV2ZxUHNvbngw?=
 =?utf-8?B?dE5TOEdDVWpjQU1VZXEzMDZZU1lMZFVKOFNPMlREVzBwZmdHTW5Fa0g2U3VJ?=
 =?utf-8?B?cnkwYldnSGVxZVlXdU5yWWlrZXgyRG5CSlZIaCtmeWovVUZqajVJRmQvNjJs?=
 =?utf-8?B?bHl0Q0NQbStheGRYS2NjVk9OWTVJODhrR3dDLzNaaDYzSE41ejBOOUkzblBh?=
 =?utf-8?B?SzhSbnRsZHNNd0c5K1loZzdmR2U4UEgyUFJab2x4N3BGWSt2cWM3V2loNFB3?=
 =?utf-8?B?Sm9GTmU1b2FtRnpMSTlmbWlYS0ZidHZpcWZUSUtFR09BSnYvSUNZdjFQMnVT?=
 =?utf-8?B?OUZpdjMxZVdQaFd3UDhxM1NrSmJGNmxHRHV4eFY5eFVkbW5IZjNGcHdaMU50?=
 =?utf-8?B?bTJYT09tTnc2bkp0dno1YUpBZ1NBeUF1aWlmZ3RMS25tMjE1bGhGUkxhNS9p?=
 =?utf-8?B?R1RiYnZTalcwazNKZFMva29mU3FyZjNqdUxLRE9Vd0lmdnVEYUtWYm9hcFlk?=
 =?utf-8?B?cUhDUnkxK0l1Zzc2RVIrNWthdmlMNnhPYzdRTWlFaHRtcE03Z0xBWDNPZktC?=
 =?utf-8?B?UHdnSm92djluSGpKNk1JVVNaVWZtWUhSVXdlTWRxS3MzQWVPMEFac2piMXk1?=
 =?utf-8?B?bVEySUsxczF5ZllpQW1Hd2s3Mm5uMy9WVW9KQTZkMjlkZ2UrVFoxRGJxVGRZ?=
 =?utf-8?B?Z1NCOEJoR3BuTkhKZDZST1M4ZmNmaHhEUDM3RTNPVk55bmNnMVNQT3YydWxM?=
 =?utf-8?B?SGl4YlBZcVRUamdBZitWVWFOUU5PZGxwMWljdk94a0F1M2R4dTFZQXJ3NDVi?=
 =?utf-8?B?SjJFdm1mSVY1M25ZWERoMmRLSEI0ajY0enFSWFpSN1Z2NXhiNXYvbko3Nkt4?=
 =?utf-8?B?S2wrVVBkYzFTSmFPMXYwR1JMUEloLzcydUFKaEhjRng2dmYzMVRHNEhlK0xQ?=
 =?utf-8?B?bjJrRnkzS29QTi8yL25ybWNHNWJlcWxHRCt4K3NhaTljZjJkc0JPL2Rnb1lD?=
 =?utf-8?B?UVRPWWxDRXdqZW8wa2YrQ2lXVlNpZG1JdnN6VkNZWHl1VWVpQm1kM0o5Q1BL?=
 =?utf-8?B?aGtaZldHRE40eDVaR1JiMFpwYWNSeVl3eFV5OWl2Mm0wc0xJSDJzS1FvckNB?=
 =?utf-8?B?THlDUEFGdFM5SWp0MGVWQ042VU9HYnRSelZwRFVST1JjQTJFWnRocFVjK0Rp?=
 =?utf-8?B?QzM3SjcyMHdUVFZ6WkJZRExUTDMrazBLT05wbmQxVmdyR0NpWTVxVmdLUjlD?=
 =?utf-8?B?cDN6UzlxZkl6KzlTYTk2YytMVElmaXNhT2hVNFM0MTNab3lMTGs0bHVCTjNz?=
 =?utf-8?B?dlRCaXp0UkJ6c0YvK3pJT3JUVG9KNEtOMEowaTVOTG9XU2RYYlpYemlGK05V?=
 =?utf-8?B?SWtkcHU2YnJXSXd2ZmQzQkxGZkhBcUUvRDJrbEM5eVBsd2FEamJ0cC8yNmdF?=
 =?utf-8?B?MXRZREdSZVNuS2RRT0JNSkF2cUw1cTB6Z3ZUanROUE1hSGtOOU1pYWlORVUv?=
 =?utf-8?B?U2NkOUd4RGkzR0dFTVpwZ3lMSmY0T1VQTzBPY2RjdDVxNFgyOUQ2aFVjN0dR?=
 =?utf-8?B?V0hMS2Y2bzVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTlFa2NBUExVUm5aaldVSzJnWUwwaEM4ditFN0dPQUZEd2RUZXBQbXVIRFVL?=
 =?utf-8?B?WFpNeDRNYzFGYXlTMWpPeXlCNjJJL1c3b245cjBxb2N1VXd3Z1B6dWgvcEZB?=
 =?utf-8?B?cm5PVFZiRzdPQWd1V3ZOMjVPQ29xZE0vdXNrc2xlTHU0VVVYNnJqNHhGeDcr?=
 =?utf-8?B?WUQwdEpFSHNhVGk5MWEvTFBkMmR1d2dreVBjYUZvQ3NySW1pK0F4d0hOQ01P?=
 =?utf-8?B?bWhTWkM1aFljY2lZRzRnNlArNG5CdjRsQmJkSE44c0t1eDFlZEI1T1cva3Z5?=
 =?utf-8?B?Z2VxMENzODN1ZEV3czFlUm15OWhYRWRvNnhZZ1d4YWFIS3NCQ0srUmJ1a2NN?=
 =?utf-8?B?bmhnNTVUckw1V05MLzZsRDk3a2RnWkh6am0zeTFyRGZFQ3pTY0VPSUNVZldm?=
 =?utf-8?B?NXdkc09Udm5Ha1dqcHVuYmRnUG1wdTkybStRUXZQMXd0bzBJM2doNkkvbmhw?=
 =?utf-8?B?V0FJQTlhRHZ6L0Iwa3I4QWZjb3FHMWtueHlKTUlQRUY0WC85YUdDYThJd3py?=
 =?utf-8?B?R3FnVXJ1dEJpcFhnZ3grVlYwZmt5RktqYXgveU0yNTJZcWhWWHZocXQ2K3dh?=
 =?utf-8?B?ckdWR2FjRmNFVXlzbzZmZnBCaXJEaFQ5ZC9ycnJpU2w4YXk5U2xhc1dxUVNn?=
 =?utf-8?B?aDhKU3VoU2JPdGZiRUt6TitYd3piOVdOTzhualI0a3NXcTNZeWt1KzhidC9E?=
 =?utf-8?B?VWkvSk1FdzQ3ZFQ5U0wxSFdhK3c4QkRUUVFUZDM2V0poWmp4dHpFRG9uSitV?=
 =?utf-8?B?MTY3ZGhzQ2xFek5iYnAzOHFweEpDbHJHbEFKTEQzQ3psYzc1OG53bUpjU1l4?=
 =?utf-8?B?dFVGTEFONXRKbXRpSDNzM3A1Ulh6aGJScGdJcVp0WHlRTzNhOCtpOW1WV1Ni?=
 =?utf-8?B?cXRrVWtjenA0NHlISGN3UWQyWEd1SnJ3b2hjV2t3dzVXVFdtWVZ3YzRrUHlB?=
 =?utf-8?B?RnFGVEhOV1M4NnFBUk1MdmZoRUVFQWNaWjB3YzMzcHdXRyszNjJNaG45R1J6?=
 =?utf-8?B?aXhwdWQzc1RBakMwbkNtTTJFWjdwQWJNRk1tajJEb09USXB0T25kVng1TnRS?=
 =?utf-8?B?ekJsUk9qcG5xYktiRnFvV3RmZjBvcVp3amJlMDltMUpwMnhDT2JEZ25ISXMy?=
 =?utf-8?B?ekFxZzluU0UxYmREa21ZVGRJK01ackVjcGxUQnV1U1ZwM3l2N1BjcGZjaHZa?=
 =?utf-8?B?TTZGYzhzellwSWp2S2JpakdyVzU1USttazdBWjJFSVF3RVk2MXoybUU3U1oz?=
 =?utf-8?B?cVVKN3ZPYk1jb1o3R2p0SU5IUVRqYWUrOWNMTmkxWlBFTERpK1ZVTDllQ2RW?=
 =?utf-8?B?TUplWEZ5NXlJYy9uQkJ2QU85NHZGc2NvbmdwTTF6SU91cDhkZEdxTVhuVW9H?=
 =?utf-8?B?NjdjSnpWaytzZUVkb3d3b2pEdjFpWjhZbzJYMmFqMVM4aXVFSzRRVkMvWkZo?=
 =?utf-8?B?QndaLzQvSElyREE3blZDVWNENGp3R2x1K3hXL2crbk5XVGlxTGVNa1pyTXVy?=
 =?utf-8?B?REtLYnM2dXlKZ3JycXp3NUgwNEJGV0ppY3JrT3pLWGs4L28wY2pUaHdvOGRh?=
 =?utf-8?B?Z0VJbjhRWGRsdklNVDN5S09DQjRINlRFSENnR2krSkdMSXhiMSs5Z082TnVN?=
 =?utf-8?B?eC8veENQbXNBZGNhYm5NTEc3dlI0TWwxaG5pMGo1UmJvTWJSUWJvWW1ZSXMr?=
 =?utf-8?B?ZFgybHJ6QjUza3B4UXk1cmc0bEJ0enlyeUIxT2IxTUwrcjZQcVV3aE1XNHo0?=
 =?utf-8?B?ckcxaDh2bE84dStidDl3ckJ1QXdYSEo2TXhReVlsRUx1OVdwMzlPb1FPNzdZ?=
 =?utf-8?B?WnRxeUN2N1BRcmlxZHJxV3ZHVXlzVytFNWVvZmNJM2d6Sms4RGw3T0t3azk4?=
 =?utf-8?B?TDRwV3U3K2JQakRMTW5iQm94N0c1RWVhMTFZSFI0WnI1V1hvUS9mLzlxY3Uw?=
 =?utf-8?B?NjhKS0s0TEFudFVYWnoxUlE0UFJpajNKMXQzRkJtQXJRQWhBVTk5bEo0TWJF?=
 =?utf-8?B?KzNyM0xtNVRlSnp3eUYyNXN6SGFrTDk4VWhsaDJHeFdVa1Q3Mzg1RmFnSXBP?=
 =?utf-8?B?S0hENHJ1YWxFRkZmc1hzU3RBQ04wY1hKeEpkOXJOMEJWYXBGWGhnanVtMnV1?=
 =?utf-8?Q?lDDcgFsFw54+y3NmXX3+id5lW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c526d00-9264-4d1f-1de8-08dd99da83c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 09:16:34.8781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3pD/y/qpWBW6gxhoHxkgBFYPOMyjlsTTgY3R4FJ0ka5m6QoiyHnXqYXSmS4nbs85gcKc1Pz+fqtaXMHfldGTdAm0uWHUaXuJNQcCAgL+6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6717
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAyMywgMjAy
NSA0OjA5IFBNDQo+IFRvOiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUgPGxl
ZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBT
dGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1h
cm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+
OyBsb25nemwyQGxlbm92by5jb207IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0
ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzZdIGh3L2FybS9hc3BlZWRfYXN0
MjcwMC1mYzogRml4IG51bGwgcG9pbnRlcg0KPiBkZXJlZmVyZW5jZSBpbiBjYTM1IGluaXQNCj4g
DQo+IE9uIDUvMjIvMjUgMTE6MTYsIFN0ZXZlbiBMZWUgd3JvdGU6DQo+ID4gQ2xhbmcncyBzYW5p
dGl6ZXIgcmVwb3J0cyBhIHJ1bnRpbWUgZXJyb3Igd2hlbiBib290aW5nIHdpdGggJy1uZXQgbmlj
DQo+ID4gLW5ldCB1c2VyJywgZHVlIHRvIGEgbnVsbCBwb2ludGVyIGJlaW5nIHBhc3NlZCB0bw0K
PiA+IG1lbW9yeV9yZWdpb25fZmluZCgpLCB3aGljaCBzdWJzZXF1ZW50bHkgdHJpZ2dlcnMgYSBj
cmFzaCBpbg0KPiA+IGZsYXR2aWV3X2xvb2t1cCgpLg0KPiANCj4gSSBkb24ndCBzZWUgc3VjaCBl
cnJvcnMuDQo+IA0KPiA+IFJvb3QgY2F1c2U6DQo+ID4gLSBNaXNzaW5nIE5JQyBjb25maWd1cmF0
aW9uIGluIHRoZSBDQTM1IGluaXRpYWxpemF0aW9uLg0KPiA+DQo+ID4gRml4Og0KPiA+IC0gQWRk
IG5pYyBjb25maWd1cmF0aW9uIGluIGFzdDI3MDBmYydzIGNhMzUgaW5pdCBmdW5jdGlvbi4NCj4g
DQo+IEhvd2V2ZXIgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIG5ldHdvcmsgc3VwcG9ydC4NCj4g
DQo+IENvdWxkIHlvdSBwbGVhc2UgcmVwaHJhc2UgdGhlIGNvbW1pdCBsb2cgPw0KPiANCg0KV2ls
bCByZXdyaXRlIGNvbW1pdCBsb2cgdG8gIkFkZCBuZXR3b3JrIHN1cHBvcnQgZm9yIGFzdDI3MDBm
YyINCg0KUmVnYXJkcywNClN0ZXZlbg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGV2ZW4g
TGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLWZjLmMgfCA3ICsrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAt
ZmMuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQo+ID4gaW5kZXggMTI1YTNhZGU0MC4u
N2JmNGYyYTUyZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0K
PiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQo+ID4gQEAgLTg2LDYgKzg2LDEz
IEBAIHN0YXRpYyB2b2lkIGFzdDI3MDBmY19jYTM1X2luaXQoTWFjaGluZVN0YXRlDQo+ICptYWNo
aW5lKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMEZDX0JN
Q19SQU1fU0laRSwNCj4gJmVycm9yX2Fib3J0KSkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQo+
ID4gICAgICAgfQ0KPiA+ICsNCj4gPiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgc2MtPm1hY3Nf
bnVtOyBpKyspIHsNCj4gPiArICAgICAgICBpZiAoIXFlbXVfY29uZmlndXJlX25pY19kZXZpY2Uo
REVWSUNFKCZzb2MtPmZ0Z21hYzEwMFtpXSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRydWUsIE5VTEwpKSB7DQo+ID4gKyAgICAgICAgICAgIGJyZWFrOw0K
PiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiAgICAgICBpZiAoIW9iamVjdF9wcm9wZXJ0
eV9zZXRfaW50KE9CSkVDVCgmcy0+Y2EzNSksICJody1zdHJhcDEiLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMEZDX0hXX1NUUkFQMSwNCj4gJmVycm9yX2Fi
b3J0KSkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQoNCg==

