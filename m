Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32746CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgtZ-0002z3-Jv; Thu, 28 May 2026 15:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wSgtR-0002wY-UF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:59:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wSgtN-0003Pe-QR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:59:48 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGw0it2229925; Thu, 28 May 2026 19:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Ch3uIAjfVZgI/+3/kPAWnW95nmRZyj5ryn6WgmBQl/k=; b=
 VYHQ13MHlqrg2exJ/xp1954AQQWNIUhmmhYUZVcyKtOIEProLZbEy1bZ6emouLeA
 gfMEdyw2/4vyKvWP5AZjzWENu7MsDg9VPte/yr7rU1jkg1/tvdJPgCFCOo7BcqBf
 Vs38BwR+qBuFvO/wvMbyRoJLy2Q17XTk8tl8IpllwRPti0+8F48ULovkRKWjNlwk
 ZujhWNe6SgcboGqGIMWihfyUCa/oddIuHyY7+65B5QZjdqjgQLnsY+pzNoCtYxRB
 XOIsOjkwbNNwIILO5AuTQ2qewsoyJMorWAthdDyj/yaTua5IOZ0p+Nk8Rr+IP6Ep
 /8GMCU/A3R6BxlBMx0F8Wg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7ws9m2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2026 19:59:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64SJssuJ035408; Thu, 28 May 2026 19:59:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4edjs3p7wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2026 19:59:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJXOSlCukA9qi/6JMcw6ftxleD0m+oPi64UK0R8M2OP5jMikOfj6V8tdJxffReP5MTLdZmRZJU49K4oEt0X1yPbVVYM3Esl8jUSVeJCTS6M75KaoEg4gSOOhFMtRdGZ1H07CXxB/zqzXB1vUHUTArjiEomWDlgcbF1H7cKqqv0wJWvwB/kfGoqgodQTPCBx/KBwcPCOKcAHxKP2a9JNYX1yRGQafk6yVJpJeoIB8J3p1DcB1SCgQsQJr85MQSOuvlkioNgG0pyUVa8qvKMW0UbWJdxeMIiFOVtDAiNnVspLKwKQJ7rj+JxRykhs1gOgBjF3Mi1dAjse1FtUTGPrLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch3uIAjfVZgI/+3/kPAWnW95nmRZyj5ryn6WgmBQl/k=;
 b=MRi6iGpkpLZVlo0SySuO08fnwoz0QL5VjFSoV4/TbIXJftsZv8kZwJfzoKe9/atylPq2hUgsCeBxDtHfKBhmqggTWMHJsSrjMJXPGCMCZ0Hg2yMb+9giWihFZkSjiGSJGidVKq3A9ACWCjh7qdp/3W0/J7140PY8lz9evqRx3IY2qMrtODlKVO7LALJUzyPSOhzh2CnipRXkMyd9ChgtiVDYxM5BlIEn64F1JS6ECbhSYtyjA2KtIobzhCgu2zIcbOYLKooz2ruTu5dLsX8OhPCgxR/yAn/ganpxl8lWPJLS0lFwcqK+POnT2m4LtDwaUWH8VCrfYuC+pCLii09Fyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch3uIAjfVZgI/+3/kPAWnW95nmRZyj5ryn6WgmBQl/k=;
 b=Kl/QgUlcLr49yh0fPzlhxRvxCeZHOaRTEYPUK+5c1axJWtQeEuxLhcB8KkhQ252Taf8DQ4UpvuOkgreY96Vl9GN84Md+XjWjYQXZXJvX1WLfpO6ioLc33a5QO5hR/NBJv0qXPrujxa3SUdRMBVzS+RhtB/PBYua1VCqrQZ08uHY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MN2PR10MB4158.namprd10.prod.outlook.com (2603:10b6:208:198::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 19:59:36 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:59:36 +0000
Message-ID: <0094f356-36c9-4f8c-84ff-5d98b0108f14@oracle.com>
Date: Thu, 28 May 2026 15:59:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd-iommu: fix CmdHeadPtr not wrapping to 0 after full
 command buffer pass
To: Costas Argyris <costas.argyris@amd.com>, qemu-devel@nongnu.org
Cc: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260517192314.355499-1-costas.argyris@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260517192314.355499-1-costas.argyris@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::14) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MN2PR10MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f135bf-25fa-45ef-61cb-08debcf3a489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: at2pFuG1wlE6YYIckFwGJizNx986simMCMbA7OtwbEcOdeDuily+8chLpi9VZ3a6Amest0QuEdUMBXUYvIbLQcyBc0wZmOGoxFcHVh7VGZGHW0wVBiAjjGROawdo4pAKwJ8hmhCUTPJ5K9i6HTI1tuuL2K2ZeIJ9cSVU7KJmBACthr4vGTEu8MelD4UV5gu3JuYkjQBAMQZ11BR2JwQBXd+NpjroO4myz9aTW1ZA/069qk9HI2wL1dMVUuH/jpUHru0FxnlLLwmij5hGORoYi00SVjqleKXI9wDTRoYnIHT51CBZNmu/COCqpFtQJ3ojrP7m4F/MmRkhi445KZNlkRzzJQQfzSd97ZCd092oK2cYKqDcCsubilZOgM0VaynbZPRbMOv+OoAD78YrmkazBgLuVeg+vq6KrheKix2WRqWTxPTzMGX8uvqbWNW54UgA9kTfDGypZkSKPjfYI4FF/we64cU+C4kJQ92st4nKt4kpMLO0wCnmlj2FXd6vUyAB5T4bpuNWkDXaJcCTU/8J08ADnab8aJgKJiB+KC/1Nx3K3rrabLUoHmsJD3OHihGbzbUYyJaDVTYJ3hgcTOYtn3XyWPnX2mWs5d2jRf1y0q7/Pb8Pf9S0vXaaM0hrZ/fkAKpbjljlJvItAf4W+TqSByjLMBzmeeeGt55uFt0jDvkvwWpbKHk28+TrSwRn2Z1dX3XkEb8Qim/mmlu1JoD/cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FVK0VKOXVtdGs5YnNVM09DYldFTmNiMTZvMGZOWmh5bzBwSWplZTFBeXhn?=
 =?utf-8?B?MEtSMnlUcytTWEhYTjVJWmw4aVFzc2N3RTlYZ2EwVEljeko2cEExR1gzaUor?=
 =?utf-8?B?TVhsNUtaSkkxUG5tb3FNWW9oM3NYSHIyMHRGWjlOS0htVHNjMWlLZFhrUExz?=
 =?utf-8?B?YzhVY09LbkhybFhMczl6dlJqYjZrcktEaml2MmRaN0d1dVI5NThJVVhxeEdm?=
 =?utf-8?B?WXpxU2YybDdFdyszLzZXUFYyUldyc1RrR1l0SXB5QStYdDljdnVFelphLzJo?=
 =?utf-8?B?bzBIdlBGNng4NlpTYXVhS1hkaWtPZUMxekFrczY0cW9sWW0rZjJLN09nWURx?=
 =?utf-8?B?MEpsS3dpVHJXdEhoTXpqUkRpS3AzcTZaWFEzZ29tOTZDeFM5ZEVEbkVXVm1I?=
 =?utf-8?B?VGdQVjVDcXpLdnAxeUlTeG5mNE5nek5rZnFSd3FSWFNmcW5mK3lWWFh0YnVu?=
 =?utf-8?B?QllnMTg0OGUreGFFOXZGeWVxSFZNdGo0bG0yTEUvMnp6OGJ1dXAvYXZ1Uk1C?=
 =?utf-8?B?SUZyMHg3R1BxVEFHM0REVGRrZ2VndmxFakl6cEZkbXlBZ0cwdmRURDNmVGx6?=
 =?utf-8?B?VThsNjc4bklKTHdsSjVGQTJhL2hyUldHdlMySGRkanEyZlJSVE1aZUNoa2pn?=
 =?utf-8?B?R0lzOVd5b2xUU0pZZTB2VlRJVnI3MjhvTG90aFd1RnFpelc0a2NRUE54Zkpz?=
 =?utf-8?B?TTBQUkkvZENjZ3N1OEpFdkFlTUJzZFlXbmh4ZXBNZ1BlUm9jNE54L293WXh5?=
 =?utf-8?B?L2ROazVaL0ZjVWZnUGpiSVdBVy9EYWdpemUrRzVSUmdWQi9HNkdHdFJhcFB2?=
 =?utf-8?B?MWpZcENMSDVOclgyZ2p0bUQxMHMyOXVNejRtSVdrT1h6d1EydWk5UW11b1BG?=
 =?utf-8?B?U3pITjlsclVMelVFTzdld29Ib3ViVWVwTi91UUxxamh0SW8wUFczV1pITmVN?=
 =?utf-8?B?bXlNQnhtelRKdHBBbWRVZkpVY1ZCWVB6ZnNaRkNkbDc2VTIycXdPY2EwNmd0?=
 =?utf-8?B?S2RzWklneDd3ZGRwaWNqQWxPMXJXbUpwdDQzRktjMkNrNU9QNm9Od2tJQnJZ?=
 =?utf-8?B?SDlCL3FjT1UwRnNTdWY4NHZ5cTB0N1ZXSVdVdmkvVkVxektDMm4xMHE2dms0?=
 =?utf-8?B?bjZDZjNqNVNuSEFucXpqNXplMUdSdi9iWHRhV25uNFpjZmMxQTdoNEJTYytC?=
 =?utf-8?B?VklVV1BTdTlpQnZRUXpvVXltTzZRZHIrUk0rSFN2UzV6akVzS2JDVlYzeUQw?=
 =?utf-8?B?cVZ5MW5UMmRZdGJTSStVamZ4eVhNN1RXSk1yc214VnppNlEybkNmZzlnTzdN?=
 =?utf-8?B?bFVWVmMxK1ZTM0NpaFBGbXZiYW9GWXFvanBUbE5GS2ErU2pKV2RGV3lDd05O?=
 =?utf-8?B?RTIvOTkvMmRsUmhqeVVWYmw4VFdUSHpESkc1U0ZNWFZ4VzNOQkc3NWxVMmV2?=
 =?utf-8?B?cDBVeFVVNGd6bmYreFJWOWlhT2pTQnltMFBnTTQrMk5qcGl5Vkx2d1RuLzF2?=
 =?utf-8?B?WDl0N1BNQVEybFdJYTZIRzdzaCt5RTVCNGF6SFhqRTJpK0pIOXc3aW1OUE5T?=
 =?utf-8?B?K1ZBc2o0bVphK3lFMTF4Q2VmY24vYWV0SmpOU2ZsODJ5bFNiZDU1M3FqTitK?=
 =?utf-8?B?ZFBCNnJpcmxPOWptYzY1dUF4OWZUV3ZTR2Q4SDI2T1dJQXVaSThRRWExKzlj?=
 =?utf-8?B?aEw2MFZlN2RhcnEzTER4NHdVL0RaeEo4ODNSTGNFSlJHdG9oZ0ZGNUQ3ODdv?=
 =?utf-8?B?bGdtR29zcHVSbE8xK3UycmZQa3B3aHYyZmExeHU1WjBQSjBBRTEwQU4waGJY?=
 =?utf-8?B?OG5uam45WWUrQTR2S3ExSFVIK1Z0SDdhNWJVQ1pvck5GNzF4UjNNaVlzc1pu?=
 =?utf-8?B?T0tZcHBWZGpqYVV3bDFsRjRiZHJXOEo1cE14U05ZY01hbmdtcTVPa0Jhb0ND?=
 =?utf-8?B?bVZ3ZVpsdzhJZUl5L3NuOExEMkFYM0hUUWNoWDQwblNjOVJSdllVODlpU1F4?=
 =?utf-8?B?VVlvdVQrRnRvdGdNd0JiOThZcEIvSW8vZU8yQkhicmNnNnEwSktlQkY1YjFj?=
 =?utf-8?B?dGxURHJuSm9MYWtiNTlQaFpwczVnanZDZmhpUTB4ZDNFdk85d1R0ZDlrZmtt?=
 =?utf-8?B?TExlU0VtaDNadWNnOUFibzI5bURYeGI4R29DRy9iSkJSY3N6RHN3M3JockdB?=
 =?utf-8?B?eE5UeFpNb2lIb0RmNmdZYm9vVnN2RSt3dUR5MkVJWFdJVE5wU0FtTjVoNHVa?=
 =?utf-8?B?UDB6eHNVMVBTTUExZnZ3TmdVb3VyeTFzSExhc0IxOTR1emYyUWowb0QrYzdu?=
 =?utf-8?B?QXhCb3JyNFBRZDBhOHdpaXJqYUk0WTFZMk5FcDF2dHdvdHl4UkxDam1tNUNH?=
 =?utf-8?Q?ck11T9zr1FCb0gh0=3D?=
X-Exchange-RoutingPolicyChecked: pwLojAe6VCxYVHY/1IotE4eyi7xBBYEenXuugQd6dJ8++wjvxyQ+hkpMUnLRBXkMoFhDYrxlAK5RuQB85rTKLBYW7HgXJZSk7apWME89IN/Yutbs0SnPjWbIqwgZgDM+oiEIYFJ7/F4g2WlP5DEYthrvJlfy5eXSZjCYC0XtUwrspTndDhNWFcEtudOBhGafHnboAXSH3eXOqJdPofvTqXT4T0l7yNEYfclQ5fe3cGiCFmv/pg/RwVkTjPu7+Cjz5jXf17V15/ji5pgmS4zbhfMrjMl6EbiYVZ6SluEh6OFZ1sbqaW9r5FWjiMbi2MpoGgZUHtbt1ZJVJ9O0YH0RGA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CtelW+QnWUPHCO0edn1gcEu8+EATxrY2ln3d54T2Yo+XDP/k6arsH+SgirynVDRTEfF2Zq18NBaaIAIngDTMafMidZi5X72nfzTWhVWzI0xgkUthCmqStffa5JBWZ4QZSRg984GMwl+SxVghKpn6SAQ8ZsKC4X0wvKmS6Nup0jjbmA/CHjNcKUcd4ybdNmvn2VrUXBlRFkykEJPG0RzydC209bnPsUdfD7SitEjxTNF7ta80QD9Od55XdShxbI/T1Swhh3oDFhLTWoFSgQ7zS9sRP+RLqivYBMhyBp23yTWVZduYqr+JmNI2o8LQ0eaQ5D1iFVktFHLS2qUCAeMDCFqkzl3T8aqBa18CIpZw8rhQqE8F3dSm4gwRLFv8G3MWWGXsJzeKSrtLtY35zfLviojqCfDhP8wDXQsLSbCmF/atP/DWx1A9aaIdKNTGWvUMr6K/WejLbxHadHFyhC7fGlFm1tTgX8wtXcDK4+cteErto6EBt/VsysFFIwx/EDLAOiMBdc2Zq2TOXXM/ccsSK6Rrs0E9DU4LT6WvWb3ehI5B9P2HzFr8EP9/er41lx4IXRCGwUqCap4RkU8qzCsiYveAVyIyr8UPnBeiwYo3A9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f135bf-25fa-45ef-61cb-08debcf3a489
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:59:36.1364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ljIUkgB5fDiQ0w2YHAH0yYTkXEBNK6TwEsKp8/DrTU5sUYpe0tvL4amGJlmZmDNNPzczjq/N2j+i++EQCwF4/u+vYfyowdjUpO/hzNjmYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605280201
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwMSBTYWx0ZWRfX6GfD79mNNYlC
 7ocCRysZ5B/6A2UBQvbe+7SiSDH+JoKksVOs1ozjZBng0r0xtKNY1DhSox8j+nRzxhOqFbgU5k9
 tUK7tKr7msNDklnazuGqD842+Hfpu3oj9xq8rGXZAtOGQQdwQaLC3IN0BUde8crj0YzzBCk7lRe
 AsNGw65o29Bt9CKX8H1KkbwFdHP9b05UDIBravowvdUl4Su5DLAW37o4wTN7Kyx8E077ZBzRPER
 mWOp1qX7vLPqhhz2a3S0sS/ydVirn44D1/bQ9XlNMJ5mkmgMAwnFWzuWeK5tTYHQQreQbnMNwvo
 ftPZSaMaRSVFqACe7Mp8vqtIBtCloRJzPJ2NtIhunAz2PhJk0VJBjbrY2/GyeH+AtA6bai9CjvI
 swIHjfN7sJRtUrxEVvYvY8IcWt/LfaY2GEd4KoDcIRpj4nrXPm1MFbuguyFXtPqWubdgBC0X+Mj
 PpC1mCAaTPNTy8CacZg==
X-Proofpoint-ORIG-GUID: zG9-ypH_cKZ-nr_HhM_LjztY4mfNorrx
X-Proofpoint-GUID: zG9-ypH_cKZ-nr_HhM_LjztY4mfNorrx
X-Authority-Analysis: v=2.4 cv=O6wJeh9W c=1 sm=1 tr=0 ts=6a189eab b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=GE-wXZVTzY4YLnir5nEA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Costas,

Thank you for working on this issue and adding a test!

On 5/17/26 3:23 PM, Costas Argyris wrote:
> When processing commands, the internal cmdbuf_head state is correctly
> reset to 0 on wrap, but the MMIO CmdHeadPtr register was written before
> the wrap check, leaving the guest-visible register stuck at the buffer
> length instead of 0 after a full command buffer pass.
> 
> Move the register write after the wrap check so the MMIO value stays in
> sync with the internal state.
> 
> The Linux kernel AMD IOMMU driver is not affected by this bug because
> it uses COMPLETION_WAIT with a memory store doorbell to detect command
> progress.
> 
> Add a test to lock this down.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3338
> 

This catches the same CmdHeadPtr wraparound issue that I sent a few days
earlier and Sairaj reviewed:

https://lore.kernel.org/qemu-devel/20260512150044.334867-1-alejandro.j.jimenez@oracle.com/

although I wasn't aware there was a gitlab issue created for it, it was
just something I caught when reviewing a similar patch from Paolo.

So I'd propose that we use this review to commit the test changes you
authored i.e. something like:

tests/qtest: Add amd-iommu command buffer head wrap test

Add a qtest for AMD IOMMU command buffer head pointer wraparound.
The test programs a command buffer, fills it with COMPLETION_WAIT commands,
advances the tail to consume all but the final entry, then wraps the tail
to zero to force the final command to advance CmdHeadPtr past the end of
the buffer. The guest-visible CmdHeadPtr register must then wrap back to zero.

This covers the case fixed by an earlier CmdHeadPtr wraparound patch.

The Linux kernel AMD IOMMU driver is not affected by this bug because it
uses COMPLETION_WAIT with a memory store doorbell to detect command progress.

Signed-off-by: Costas Argyris <costas.argyris@amd.com>

let me know if you agree with the above approach.

Now a couple of comments on the test itself...

> Signed-off-by: Costas Argyris <costas.argyris@amd.com>
> ---
>  MAINTAINERS                  |  1 +
>  hw/i386/amd_iommu.c          |  2 +-
>  tests/qtest/amd-iommu-test.c | 71 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build      |  1 +
>  4 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/amd-iommu-test.c
> 

[...]

> +
> +#define CMDBUF_ADDR       0x200000
> +#define CMDBUF_ENTRIES    256
> +#define CMDBUF_LEN_FIELD  8
> +

To reduce magic values and potential errors, we can define CMDBUF_ENTRIES
in terms of CMDBUF_LEN_FIELD i.e. ComLen from MMIO Offset 0008h Command
Buffer Base Address Register in the AMD-Vi spec.

#define CMDBUF_LEN_FIELD  8
#define CMDBUF_ENTRIES    (1U << CMDBUF_LEN_FIELD)

We are choosing to test with the minimum valid value of CMDBUF_LEN_FIELD=8,
but there are other valid values [8..15], and this keeps the test correct
for any of them.

> +static inline uint64_t amdvi_reg_readq(QTestState *s, uint64_t offset)
> +{
> +    return qtest_readq(s, AMDVI_BASE_ADDR + offset);
> +}
> +
> +static inline void amdvi_reg_writeq(QTestState *s, uint64_t offset,
> +                                    uint64_t val)
> +{
> +    qtest_writeq(s, AMDVI_BASE_ADDR + offset, val);
> +}
> +
> +static void test_cmdbuf_head_wrap(void)
> +{
> +    QTestState *s;
> +    uint64_t head;
> +    int i;
> +    /* 16 bytes per command */
> +    struct {
> +        uint64_t qw0;
> +        uint64_t qw1;
> +    } cmdbuf[CMDBUF_ENTRIES];
> +

The line below adds a dependency on Q35, but that is not necessarily always
available with AMD_IOMMU. So we should add a safety check like VT-d does on
their test i.e.

+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }

Thank you,
Alejandro

> +    s = qtest_init("-M q35 -device amd-iommu");
> +
> +    /* write 256 COMPLETION_WAIT (no-op) commands to guest RAM */
> +    for (i = 0; i < CMDBUF_ENTRIES; i++) {
> +        cmdbuf[i].qw0 = (uint64_t)AMDVI_CMD_COMPLETION_WAIT << 60;
> +        cmdbuf[i].qw1 = 0;
> +    }
> +    qtest_memwrite(s, CMDBUF_ADDR, cmdbuf, sizeof(cmdbuf));
> +
> +    /* point the IOMMU at the command buffer and set its length */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_BASE,
> +                     CMDBUF_ADDR | ((uint64_t)CMDBUF_LEN_FIELD << 56));
> +
> +    /* enable the IOMMU and its command buffer processor */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_CONTROL,
> +                     AMDVI_MMIO_CONTROL_AMDVIEN | AMDVI_MMIO_CONTROL_CMDBUFLEN);
> +
> +    /* advance tail to the last entry, consuming entries 0..254 */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL,
> +                     (CMDBUF_ENTRIES - 1) * AMDVI_COMMAND_SIZE);
> +
> +    /* wrap tail to 0, consuming entry 255 and completing the buffer */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, 0);
> +
> +    /* after consuming all 256 entries the IOMMU must wrap CmdHeadPtr to 0 */
> +    head = amdvi_reg_readq(s, AMDVI_MMIO_COMMAND_HEAD);
> +    g_assert((head & AMDVI_MMIO_CMDBUF_HEAD_MASK) == 0);
> +
> +    qtest_quit(s);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/q35/amd-iommu/cmdbuf-head-wrap", test_cmdbuf_head_wrap);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 728dde54b3..67eea5c71a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -95,6 +95,7 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
>    (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
>    (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
> +  (config_all_devices.has_key('CONFIG_AMD_IOMMU') ? ['amd-iommu-test'] : []) +             \
>    (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
>    (config_all_devices.has_key('CONFIG_VTD') and
>     config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \


