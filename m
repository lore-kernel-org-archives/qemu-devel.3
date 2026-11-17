Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED14606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=FW7LSCpO;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=wBimoZG/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGNw-0008AK-9Z; Tue, 17 Nov 2026 05:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xTGNu-00089k-C7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:25:54 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xTGNr-0006LS-Gl
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:25:54 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHAO8fC3753300; Tue, 17 Nov 2026 02:25:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WCjtF7dFdP5jSH2yJtmYAes3dEAyRR04URc78R+Nb
 AE=; b=FW7LSCpO3yU5w0niwH6J0nDUD0Pq5vO2uBuWxJKCDLV7zH3YxX2ZxB7BW
 MQTuahAJg1fEvRbRLeciNMGze/NCpwHLEOY24mWpytf5a1tXkaQ0nBDJ6LM6tA9v
 j3IwaN+NYdfa6EEoK9nV9hC9JXUKijVMjmTPBWsjteGoR4+88ZhBt8gpbvNi6cgo
 38Dt/0kcktqXkXXBeY9whXknZLqWN5Y4R8mE/x8Hp2FJN3pjIyFfC9fEvmZYUJG1
 CZh91Mx6f7bLl1/YAM/ZfE/tfbzCc+NF+uzf9prOOvOe4LyIzqR0xO5bqU2w2Jjq
 FPPCbfrKKdN6DcWGebjoIckf4U4iA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021090.outbound.protection.outlook.com [52.101.52.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hxqkhxbb7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 02:25:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWkW4O4A+aD5oUXDJKnBAmPrQ/svWCqrQwTSja0Ywsi3TO/dgWgkyPuJOcYAjZriIoLCzR58A33ZAUIkxkFIhhk/UKbuPG6yKjFa9hZQ6+fAQXNLqrDSZ7i1Qxaz6Y3eQKyvRIN8wexzBDfkJTIJQnLE6lLeOKlBdMKtm3N0W8UlSypkbl7mLBZ8PUWvhmdgmNZUTVkNZsCRXkgww7i8AYbosBxogcAlOdSOIwBpVEeUbpGsiy9Bl84PQUR7N/HGze74h78MCl4CLmSb1lnp5RbBykf80FMoXAld+AqPg/Zs6kKjh0pI4Q/6y6bPpEX9ncP3qOTZ1MjsoBgZTeQQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCjtF7dFdP5jSH2yJtmYAes3dEAyRR04URc78R+NbAE=;
 b=kdcYFTwWZUPkNth7cMmfcVh0LYaGY98VybHvH6LAIqeDB7tQ1v8BQJLDnVqwY9qAewN0JMNyzRnOFayU7IDUgKOQ0RPaK4ctPtzn0FldgfpGeRmtFyzJHG7M/qgZnHUiMJsu61rHRpraZYt2IIAoSaOdORdt56BKFP1HGV6qmp2z4yPlBTWzt6O0MQvUs8tEmUcvGtHj4axOWMDJ/F3YfZ7xRCQhy8FDA/NvDyCRPAjP5JshkAvBqcGfNL/iDpf6KiD3BA2rf4C5+cL3pA/5bHhMkkLHZppK6xDiAIS+8JGQMXTVfQ3oMRVIuNa8fv34vzD6U6XzCDxW0xumC29sOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCjtF7dFdP5jSH2yJtmYAes3dEAyRR04URc78R+NbAE=;
 b=wBimoZG/6RnAeQXg9Za3tfkuFVAg9hHUjPM0GLaqQCzl0SSv2rNApTSpA9b4n7rBMa+vLoQCtofZ08gRDOnjU3EZeSBSjPBAUwyGGMtNkKo/u4HilVX8u4sflSS7QEM6N4QfDBlvoOI1RcFBNTGR1VIl/dPRD53NOOYvxNP+xvHp2b0di/QtlaFstoaKSK4dMppwlV3XjILSTFTMs+ylFU1jnaSuslOuWDKaA44m+un9t1EWe1da33uFpZyeFXxV/v8KpgaQ3n7OprcWaG97ornmI/9rSeVTdKumlMNnXvJyuKFhuRZg0A1iPJ7lx1fGbkA00nrp8JywyORig//pDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB889703.namprd02.prod.outlook.com (2603:10b6:208:5a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:25:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:25:46 +0000
Message-ID: <8f95f37e-eedb-4523-8b18-3e0466a4c282@nutanix.com>
Date: Tue, 17 Nov 2026 10:25:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user.rst: clarify handling of VFIO_USER_VERSION
 capabilities
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 john.levon@nutanix.com, thanos.makatos@nutanix.com, clg@redhat.com,
 qemu-devel@nongnu.org
References: <20261116114947.3365480-1-mark.caveayland@nutanix.com>
 <d6dd9ec4-d3b6-41c7-a79d-e72161aeaf37@oss.qualcomm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <d6dd9ec4-d3b6-41c7-a79d-e72161aeaf37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB889703:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afa83ab-8cdb-4904-2cc7-08df4495247a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: xGlfZxmSa4uhKjFmCVmnymP+rZm3Q+bvRv0pu9pf7tUL6qbAdt1JV/mhQ4rinFu3SReCyMuIwPCpdD2AhDB0a+waXCMnUjPRfd4oeR5t7Saky/DsKYO/klIDkj1kyf1afQJotdFVzBoUZaPuOAOevn+i2BoErVoQ3z7Ttg1HMxgppIO7ajq8Ji1OTqO4ZKEcDnoxybrnBe4Akp1+hFhrGsK6AHsMEPZ1jf1hZau4ZP6zTbPDMTNUlHptHs3laptf5oJGF6GFsNnkdJt39uOzPKnyEIYFYDNsMoLLvSD6pktD098mcYiqd0gjyy6ba8utgcJxs3akVF4umjn/kUap7CBRLLEiTS74w+VEavAT8cXiiwulJWOOvgykhTQdNX0XpMKNfHp1f9KPxyv9ynO8+NCsHm4mAuAvB9w5rRKRfecQgL3JQJPtTBNMBa/+lQDf3WhzcxWF+xd4g5B9F2LnlZlnvI17jMBodaJOr0GCI2jaIb4qGrMprGfmN09kNTl9Se2inu3LwEUBeCPH8RWdIYf0Ljx6GjPqRuij/aNIbMZnotvAKIFKo085klXnlTYcZ1d80egM9Jv4ztxIbZrL+0CmA24FwN5n3a/EnHGUVHxT8hlTGPG5aaTNJ4yYfXXi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnBMQlZiYzdKUCs2TzE1dlcvaDBuL1RhN295U3JGTDBCby9NQjNhTm4yWVY3?=
 =?utf-8?B?bVlVMjRXV1NCRTdZVFcvWTJrdTBMdlBHalJkYWJUbWRFUzEyR3E2aGlnVDVC?=
 =?utf-8?B?UkpCTERmWnlaNFVBOVV2MmpPQ1hlTDBrU0U2SFJtMzE3RngzSGVDb3BnM3hi?=
 =?utf-8?B?WU12OFUzTDBUSzNVQXA5QlRZQ3RQd0poRm1IRkxYbUlkNlVsa1ZBaTNEckpo?=
 =?utf-8?B?SEhFTmFkWDRYVktXTE93TzFFRWcrRjNqNnZLakRCRG1DbDZzaUdocjBaQ09J?=
 =?utf-8?B?WVJBcWgxbXJBSSsvbmhZQzJHNm9QOUpwSlZCYzhyMUVhZEgzbVpNSDFmby9E?=
 =?utf-8?B?bC9uandjK3FXZE42aU92UWhDNTJhWXRyTjB4cGx4N2JwQ3VJTlVHMEhYMzZv?=
 =?utf-8?B?ejBGSWwrb1JrL2drOGpwM04wOGV3eENZano2a2NIZEhQVnBTU1RQUmtTbktZ?=
 =?utf-8?B?MDRWalVoZ0R4enpJYVVtby9PV25Vbm52S2gzcGRFVHBlTjlSM3ZGQ3NmWFdT?=
 =?utf-8?B?blY3K3hBS2o3dXBrNWFmNlltM21uU3ZyUVY3V3hDL2hxcS9jcGhIbmVTR3ZQ?=
 =?utf-8?B?WFVsU2tSKzJWTTFmSm9nQzQyQlkwQ2RVb0VBQm9takk5OU9iWVppTWdaU0Ez?=
 =?utf-8?B?NkYxcWw4dlFnemhIbFNhN3U3SHJRTlUrSDAxdE5wanE2Rlk1R1JzZkxMcnNn?=
 =?utf-8?B?ZUpLMnpnM0RyN2hEWm9YcFJZcHZoWmlvem5iTFg3WGZMNFhjeW1EQmdBN01x?=
 =?utf-8?B?UGd5UERmd0owS2swY0dHMUExL05tZVFuZktqUTVPS1NUY1gxK24wM2wxemJY?=
 =?utf-8?B?allZNmlYeEp6N1JJSDB4T3pFaUxzanZocmpVRzduN095NW55ZndaSXJ3TmJh?=
 =?utf-8?B?aFdHc0wzc2NRWFBCbFB5RzBoR3FOeURsMVRYcVdxUmF6SU05UFhFSThPSzJL?=
 =?utf-8?B?NGRKYmdSQXJlZlNqQUJKQ1pEcW9tVndKZjJZSUh1S2c2M1BZZHgzWFBCSFFn?=
 =?utf-8?B?MVhrbStBckdETHllYWJ6VkNYUlRMR1AzSFYzWDBhTHNZQXJNUnBTb2pEdWVq?=
 =?utf-8?B?QzR6bXpVRTBhaTRPeUVHVXUyVHJnZnNNY2dxS3c5ME15cGVpNHpzYytIdjRq?=
 =?utf-8?B?bkZTazNZbkQ5aXBzY1Y4V0hLTUdUaHM3bTNwQUsxRnpyNXpxMjZ0NWo5VU1y?=
 =?utf-8?B?WWVpUStodWtXR0QyKzhhNDB1dHdDVm1XMjI4QkszbGFmNjVnVVV2b2l2d0No?=
 =?utf-8?B?Nk1yR0wxVTNsak55WFVUY2pMaWtHMlNSUy9FeGlyTGRUTGpTc2Q0MDZGVlBk?=
 =?utf-8?B?RmdndmVzQVg4ajBuL2RuWjVFZkkxK013cG55RThJS1ZVRWtzYitCaEtHTlVN?=
 =?utf-8?B?RXNneWlqYnRkVWhZUGI3b2ROZzJxeTJPUUExcVJLdXkvS0NBVWhaeVhHVmRG?=
 =?utf-8?B?bVVpZUo1cUt4TVlRS1BodEs0em55K2EwSzRxTlY2bVFjZEJsUTRvSkFPbmUz?=
 =?utf-8?B?QXBxSFBzZkk0a0U1TkVpZFdBK0tINDl4K3dOQTBZbm5WWHBkd0NKK2JLdlBT?=
 =?utf-8?B?UnFiUUFpblMwOFVLU2tCQUFacEg3UzIwcDgvU1poaVFhR3hWYkVNUkJDOVNQ?=
 =?utf-8?B?YzVvSXIzMzdHVjBOYjBkSjBlQTJ6S0p4SUs3RGJvMTg4WnFseDhUUU5xeFVv?=
 =?utf-8?B?dXp3S3BaMkJuelZRY3dzalJjU1BTMlc0SFNjZmVRR1c2a2pHeDdndm9uQ0RD?=
 =?utf-8?B?SGl2cDRVK3FoWHpGZURTazVnbkxqZnFpSkY2RkpNQk5ySjA3UklSOXk4aVJa?=
 =?utf-8?B?bWRnSi9RSHVTSWM2SjlBeUNrL3JwVFFpMnJvZ2NKM3hMNG80SHpLNTZ3clJP?=
 =?utf-8?B?Q0RUVkxlWS9QRkFzOVUyMnloamhsMFRYaW53WW9oUk44NGxDazBkUSs1NVNk?=
 =?utf-8?B?Tk9EUWk0WGtnbC9NaGIwVktxQnZwdzc4Z2lmeVo3OEE5VzRkK01VbWVUMGI1?=
 =?utf-8?B?REJLOGJxTXRQMGdSZmJXeE9tY1VyazZDQ1dHMTVzLzYraHMyc01nM3JNZXhl?=
 =?utf-8?B?MklkLzBpVU15dG56ZGkyK1ZrSVpEbVlJaDRhTXBCRnhsWDdDeEZ5L0tubUM2?=
 =?utf-8?B?V2lJWWFOMlp2TWZCU1B2aCtncGpEWmFaS211NVNFVnhUL3YzQ0dzQXdpblFL?=
 =?utf-8?B?V01OZE9YZGFveVVobUJOYk80QU9VM0dZUmxyTHE5bDVqRUp5QjhiOVh2TW5o?=
 =?utf-8?B?dFdKWFdDQmdXbGVQejJjNXE2Y0RuV1F2R3lWY2RiWTBEK0ZpN0FLQ29wcHZp?=
 =?utf-8?B?bi9JZ3NVRjlSLzJCZThjOFowMzl6RVBsc0J6OGc1dU5CVFpIdGhHYVgyYkw5?=
 =?utf-8?Q?9ZAbZAGCYDZxk/24=3D?=
X-Exchange-RoutingPolicyChecked: mabFfLC0wObimLd1t1iWiiOJKUxJrsHG69Ah/tvKoShcy9oO/ulDG8xkBX16EXsCixHUWw2e3+FVw+kkNUfLohWL00MX2qfInDxyT6KTlxoSNyTqnQeFdCbBPfLHWCwHKzoa0cQ0tojCiX/VNZjYuHSBO1YcpUoyoA87EM5hvqv83qq1K+zLCSzKSrEpBCZyVrPIAjVWL9UF4a5E0D4Aqto2mncVUu1p6jf88PshS++lKozEJfMBZdFEDT+nyUZETR4+HJRxcUF+FZaFzyQbiYkV+drSorWUwFE0tKg/N/bF1g35Lz/ndPQR+0hnhnKzL2aJXGpPZI9D7ntG6/7HVg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afa83ab-8cdb-4904-2cc7-08df4495247a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:25:46.4036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6xcAmp2bEqODhb4rSahKF2Hb40Jb4Y2Wwent+3MNGvZ76hsGHZTBosFh7e/0DE9dsm5K2QZXihrh/vNMqy1ZL+RNKFhXwM2pJzVqUP+eqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB889703
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX2n8JsrNHGc44
 AjPfNSIbMOlwx0IBORVTamwTtdMfDcaAZoMXahdkowaq0HSLHtasC+gV3BwxbuG0pqM9Zy34Shy
 IRC53Djqfaa1gwgTf2jDZ5hxrmtDEHUm+z3oDWePJr49+/l5i9F6tJp2i4LQ5lCHK4u+DFI3xvW
 75I45THWSAs5BSMOfNap7gird/wqVG6dgcKV5XdZp93n4JnlbHLwEV9ufG5CjXcwWBjWIVoB0ok
 hR3BrVFSN+zA2YH3hakqY588T0s/oFBIhsjAai/K+8ZxZUqT8ouzSHvZ6azF0AqQQzmnPnyYGn/
 7diTkx5/RE9tfkbEkWqN1TF4OCZSRztv7D3MsF4vFF9vZeuFbr+F6wWxf5hJMR6kBOzrw0cyqba
 nCnBtHNeXeztQmSRMj4gpCkbetZzpDm3GB8rhl5NhxEt8S4L4a+KYPAHwVnYAG2oZsjJB4ZRjNe
 2dQuaFFX0+cQn7vTeDg==
X-Authority-Analysis: v=2.4 cv=T/UZ3PKQ c=1 sm=1 tr=0 ts=6afc2bac cx=c_pps
 a=i3X4t2Xqt3CcVAOequVlKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=ID6ng7r3AAAA:8 a=64Cc0HZtAAAA:8 a=_KxARevNxOJ_2n25-fIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX9caPmbxuLMky
 8olkAQ8+So/otJPb4PVLfYSCEKiuccn5b0VSuUt7/8AXUbhMFGvgIoTABPXYEhk0UbawE6Zeru0
 feor/juZ624bZP8+LGTxWkZBenty8g0=
X-Proofpoint-GUID: 1OqLLUnJGcT5tAkf_jS44LhLVgCBSher
X-Proofpoint-ORIG-GUID: 1OqLLUnJGcT5tAkf_jS44LhLVgCBSher
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/11/2026 13:51, Philippe Mathieu-Daudé wrote:

Hi Phil,

> Hi Mark,
> 
> On 16/11/26 12:48, Mark Cave-Ayland wrote:
>> The vfio-user protocol specification currently lists each individual 
>> capability
>> as being optional and provides an indication of the default value 
>> within the
>> description text.
>>
>> Clarify that all VFIO_USER_VERSION capabilities are optional 
>> (including if no
>> capabilities are provided in "version data")
> 
> What happens in if "version data" is empty?

It means that no capabilities have been provided. The existing 
documentation at 
https://www.qemu.org/docs/master/interop/vfio-user.html#request is 
fairly clear that both these fields are optional.

However...
>> and move the default values to
>> their own separate column within the capabilities table to make them more
>> visible.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   docs/interop/vfio-user.rst | 61 +++++++++++++++++++-------------------
>>   1 file changed, 30 insertions(+), 31 deletions(-)
>>
>> diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
>> index b49781a755..4a5cfbb704 100644
>> --- a/docs/interop/vfio-user.rst
>> +++ b/docs/interop/vfio-user.rst
>> @@ -515,37 +515,36 @@ format:
>>   Capabilities:
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| Name               | Type    | 
>> Description                                   |
>> - 
>> +====================+=========+===============================================+
>> -| max_msg_fds        | number  | Maximum number of file descriptors 
>> that can   |
>> -|                    |         | be received by the sender in one 
>> message.     |
>> -|                    |         | Optional. If not specified then the 
>> receiver  |
>> -|                    |         | must assume a value of 
>> ``1``.                 |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| max_data_xfer_size | number  | Maximum ``count`` for data transfer 
>> messages; |
>> -|                    |         | see `Read and Write Operations`_. 
>> Optional,   |
>> -|                    |         | with a default value of 1048576 
>> bytes.        |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| max_dma_maps       | number  | Maximum number DMA map windows that 
>> can be    |
>> -|                    |         | valid simultaneously.  Optional, 
>> with a       |
>> -|                    |         | value of 65535 
>> (64k-1).                       |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| pgsizes            | number  | Page sizes supported in DMA map 
>> operations    |
>> -|                    |         | or'ed together. Optional, with a 
>> default      |
>> -|                    |         | value of supporting only 4k 
>> pages.            |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| twin_socket        | object  | Parameters for twin-socket mode, 
>> which        |
>> -|                    |         | handles server-to-client commands 
>> and their   |
>> -|                    |         | replies on a separate socket. 
>> Optional.       |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` 
>> messages     |
>> -|                    |         | are supported if the value is 
>> ``true``.       |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> -| sparse_mmap_fds    | boolean | 
>> ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
>> -|                    |         | capability is supported if the value 
>> is       |
>> -|                    |         | 
>> ``true``.                                     |
>> -+--------------------+--------- 
>> +-----------------------------------------------+
>> +All capabilties are optional. If a capability is not included in the 
>> request

... I added this extra paragraph to emphasise this behaviour if 
capabilities are not provided.

> Typo "capabilities".

Ooops, will fix in v2.

>> +sent by the client, the server should assume the default values 
>> specified in
> 
> The "must" -> "should" change should be justified.

I'm not sure what you mean - this paragraph is completely new? Or are 
you saying I should use "must" instead?

>> +the table below:
>> +
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| Name               | Type    | Default (if unspecified) | 
>> Description                                   |
>> + 
>> +====================+=========+==========================+===============================================+
>> +| max_msg_fds        | number  | ``1``                    | Maximum 
>> number of file descriptors that can   |
>> +|                    |         |                          | be 
>> received by the sender in one message.     |
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| max_data_xfer_size | number  | ``1048576``              | Maximum 
>> ``count`` in bytes for data transfer  |
>> +|                    |         |                          | messages; 
>> see `Read and Write Operations`_.   |
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| max_dma_maps       | number  | ``65535`` (64k-1)        | Maximum 
>> number DMA map windows that can be    |
>> +|                    |         |                          | valid 
>> simultaneously.                         |
> 
> Pre-exiting, "64 KiB - 1" is more accurate.

Okay I'll change from 64-1 to 64 KiB - 1.

> Previous was optional, now default is always present. Can we clarify?

I'm fairly sure "Optional, with a value of 65535 (64k-1)" is intending 
to express the default value if none is supplied. John/Thanos - please 
confirm that I've got this correct.

But indeed, you've spotted some of the ambiguities that this patch is 
intended to resolve :)

>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| pgsizes            | number  | ``4096`` (4k pages only) | Page 
>> sizes supported in DMA map operations    |
>> +|                    |         |                          | or'ed 
>> together.                               |
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| twin_socket        | object  | (empty)                  | 
>> Parameters for twin-socket mode, which        |
>> +|                    |         |                          | handles 
>> server-to-client commands and their   |
>> +|                    |         |                          | replies 
>> on a separate socket.                 |
> 
> "empty" is not clear; maybe "absent" (unless requested)?
> 
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| write_multiple     | boolean | ``false``                | 
>> ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
>> +|                    |         |                          | are 
>> supported if the value is ``true``.       |
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>> +| sparse_mmap_fds    | boolean | ``false``                | 
>> ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
>> +|                    |         |                          | 
>> capability is supported if the value is       |
>> +|                    |         |                          | 
>> ``true``.                                     |
>> ++--------------------+---------+-------------------------- 
>> +-----------------------------------------------+
>>   The ``twin_socket`` capability object holds these name/value pairs:


ATB,

Mark.


