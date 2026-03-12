Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0194106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nVA-0000BM-WE; Thu, 12 Mar 2026 17:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w0nV0-0000Aa-R2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:23:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w0nUy-0007wY-3Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:23:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CLHcpB1820625; Thu, 12 Mar 2026 21:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7nO5nppitIn4yLGzBqiMiu+B9Gyv9J3jxgESThvzefI=; b=
 OGf5Kdc76swDiYNE13ZBQFRamMwvUTmUdSPuCLZk4Xx46eY4CqGaDWcI5j5X4iaH
 JHuDPbZydG35XZvzcPeuSEvhX+Mzq6K2GsFUdIY8gBqbTj5jHdPHYG8XAlljdfqS
 QCrffLdLYZEvyHp19t6gbBYzCO0DcrUgBh2RQMtpjLis97k+EJ62Pyju0kM5/7BS
 a55Dqts4JzmWJVSGHKITuQC5LzpApuchApfKY7u88b76AQ3R4VNFWfpQIO8j+w5Y
 e6sJ/iIyQbXDBmjOCZ66QaRtgUQp9+AB0SfpyQg4rhX9hKtT+UWA8YdrRA/5zCXL
 mgBfqK73gq0KeSXxfHfBJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4h1u3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2026 21:22:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62CKVJ7C021612; Thu, 12 Mar 2026 21:22:55 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4cuh5kvgjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2026 21:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmtVWFok2H5OlhSvg0A9k24yNNAxLirU1jqM1G6V9hr0YMXAJXtfhenGAhAWTRR/SVLE1AfCe6pyAf5OScAaLw8Q/NLQNOZ0X3gRYPTL3HnL8qttHg5TSmcor9QP3dzKtFzWHAxhW4HpUTiBKggDHJT+i7adfoANwB1EJSc3MzV3v/kvj3biBxzd5AzpLM96KaJHLMKVtkIGqXzkerR/SZMPuHQv1k+fB3SN/yW0nt7mTmtqjP5qh3iHf2EbILDpIN8V5ZMBmfP+vNFLMlRbdnKIrmNeCzESnoI8Mz2qGDQFw6MYanb/+iZW6gZJ+KFJlfgFD+dyNElFVIeTsxkfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nO5nppitIn4yLGzBqiMiu+B9Gyv9J3jxgESThvzefI=;
 b=WQ4Vyqeg174A/BhaKxdrbns+6bJVjiWG1MmY7BvwxEY/UbFfXTjGSSrLVYUqQKlmTdDStsSCU4Q91/gkQL8bd6gWzJKUsGibGkAogFSiTePS2IWfsFQrTETvJaek/FYPu9JYOi3qoCMtI4SIRgHtsuVx85AKDURbW14CfML3vylh/MAmNjONTs4jykeNrJo5Q0xzYc/Fjxxlr4Ukm4OGXqYPrpTtfSz6bTHuweTHIWAB9Fk9Y2FoIdy37+/+Tf+0uMQ8Gck/Q7bhZqy3CPhdkD6Zg9fIF49bmhAgw0kiLcYB5tUCeHUChvOjD1ZLRUB7qJXnwjYj0nW4mhq9J7goJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nO5nppitIn4yLGzBqiMiu+B9Gyv9J3jxgESThvzefI=;
 b=HJB4uT5txHcADRwlruyKS1bQQd8NSpeosqjdXt+Qe/LUJbCBZDwzIPckQjafsN65fEb2EXRgMX0J9U2DBklVzQ2EFxdJsJvD4Ds7mhOxQWGMleNKpeIxWyJ1toSa06SFJv0w8paeePbU2WU/S+1B8bgJBDPR4TpE/AmLEgLojnI=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 IA0PR10MB6770.namprd10.prod.outlook.com (2603:10b6:208:43d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.15; Thu, 12 Mar 2026 21:22:53 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::c649:a69f:8714:22e8]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::c649:a69f:8714:22e8%4]) with mapi id 15.20.9700.015; Thu, 12 Mar 2026
 21:22:52 +0000
Message-ID: <8702e349-bbe6-403b-b58f-d4e33a83b271@oracle.com>
Date: Thu, 12 Mar 2026 14:22:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/nvram/fw_cfg: update bootorder to fix SeaBIOS
 bootup failure
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org,
 joe.jin@oracle.com
References: <20260310170712.46336-1-dongli.zhang@oracle.com>
 <abFSF_Mt6xbMEzXz@sirius.home.kraxel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <abFSF_Mt6xbMEzXz@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|IA0PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e28fad-66a0-44d9-0710-08de807d849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: esiLvLSaCH2JSE4TN2TTaU+Vzh1LTW6971rMSXHvU0U1/qbWldKq+GmmcIvggsUm6jhQZD6OruIx1MgtZREl9VKA9p69+GL6uOYrfEJYvtldRv0UZkuD2gfLoysPWgXLnkzqj59mAELQONBrmhL+7E2EYKgSTSXmhmqciUnXVGEz28cwi61IFXJDrFjOxavnRTKTUZxW19ZZ7cAiOH/26PfWdu5RJ1DqKruFLkTfhAGRMgtW3v3xiJuki1qI3b0/xxhWXkMSYSTnXCpIE74GoDns7e4gHTqeDyOxu+QdfmPs59bAj8oGJ+QCfepgzPAN2Vd3b5CJVb8WGIKqDsTVCFpeT2KI4JCyePz2rOim24Y/DzXxd8rWzQpwclkrRp4pM992b/V9rbZCQpHjDy5ByJQZv8KorOtq30ccryGApmE+Zay/05T5fVV4CwsSD3A8TKQc8u+hMhzF+Xy0NUUEWo2FU2DWIG+tfWayQ9PtuakYPiWnDEppUqdA/9tEXicO0y5oa2aXCsC+63nPyAg32qGMc+F5lCuc23y5aU2CRA86dOpFhUZyZt95Tithc7EaI2NA0lwOWhQla66rZtJb5WPI5hMbpVanJmTQJ3mJ76hUPD6gHu4c0nmc5TWh2Qmjgx9OVL+AKPcQCY8YBm0P/JPK8LjPgm+CaDXnShp619ku6MPfA2295B6Qwld9OOk8ijpuUnMZoBYCR2ycFbvL3L/Xt0L6pp5sofUKMfBO/UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk4wa21OdmRFUUhOOSs5eGl0M0NseWZIbGdxSUpuOE9uNGVXa3UybkRvV2d6?=
 =?utf-8?B?ZUpVenk2ZWdtQnEycVc0YStWbW1GVElZbklhdzYvOWlpUnFobTlkSVhpaG5E?=
 =?utf-8?B?d3hhK3F5ZlZXeVZIR3Q0WlZmM1pvSEduamV5UjBqY1hBZ0ZXamcyd2hMdDBF?=
 =?utf-8?B?UklseHhxN3BNclR2eWVUUGd3ZHpoL2dzN2JsQ3R3SkpOUngrcUcxZmVSek1L?=
 =?utf-8?B?b3VZY0YxT1VKQVdSa25HZTVUMy8rUGJmUDRnTFc0c1oyMVJVNzA5eldtR1dZ?=
 =?utf-8?B?RXplZW1mbEl6a2tuaWk2amd6RjVmbVRqNjExa1Q2MGV1NkJpTEhuNXZyaldL?=
 =?utf-8?B?Q21xZDloZlljZ21MMnFOWWxtckZvWUlSMkJPUzlLcGVJTXBLbGhNNlZRZnhv?=
 =?utf-8?B?L3N6WUhBY1dyM2NObDg4TXovazF4cTdYZEprRWpFZTBFY1ZJaFltc1dPejZ1?=
 =?utf-8?B?MGNsUXludlNBQzNTVmNEYndWRXRWY08rSEJwbFhZMXZKTnJrLzA1a2pqR2xJ?=
 =?utf-8?B?RDZ0aEwyam9qeGtrMDhzbDJUd0l3cXkwL1Z1cmJUK2pLYWpzTmJyUUFpQkYy?=
 =?utf-8?B?dnc4NXNmaVFsWXJ4OUx6c2pTTi9SNEZSZGhsTG0xRW9ibFNIZkhyOHFMSU9o?=
 =?utf-8?B?WVJTQUhyeHE2NGJ6RlJsRlBrZDRLdWZJT1VMaG5kYnVjN1RzdFB6OFdJbnNs?=
 =?utf-8?B?dHZvUDZQWUNLTGo5NVZuZnFvdW9SbTlzWHI0M3FOeTdIZ04ySkpnQVBSQmx4?=
 =?utf-8?B?eDZjSU0yVlRXOVR6eXlpdUdmdmIweGRLUG5LcDIyMW1SRFBqbEZ5TmFLM2RS?=
 =?utf-8?B?aVRNTk52a21oZ2ptNnJwMmcxRW5vaGlvVW9QVnFqVnpITitSU3Zla2R4Znlk?=
 =?utf-8?B?a09mako5OVYvUUdHZXdTR1FSbUlkVkhzN1FLRWlQSk9VNU53MHJLMHRlckZu?=
 =?utf-8?B?c3VwZzNpQ2JwdFYvZzVoeFFmNnorbG0rQVBXL2lMM1l4c1lVVE9tdS9XNWxX?=
 =?utf-8?B?dVNqRWdkU2FxTjFCbkNQdW0vVFE4SjI3Z2FiVHl6MG91UEI1Tll3TEVNblhr?=
 =?utf-8?B?SHJuamYvSkdSQ2g4akJ4eTNjTWRydW1Vc0oyTENXTTVJK2VmRXVhdzZ1ZDZM?=
 =?utf-8?B?V0E3TnoxS3ZXbGlHZmMrNDMvTDB2d0E4S04xWUloYzNHazhmam5ocHJ2V2Yr?=
 =?utf-8?B?Y3U3UnZmdUJ4SHh1aGFtUWFtVU5vaDNrdU0xQkRveFJwWjVNcys5TXYxWG5q?=
 =?utf-8?B?UjZiTjhqak54UTJNbU5JZzJ2aXlSU0w4STRwL3diUkUrcnFmbHZqb3pmd2Rx?=
 =?utf-8?B?c3pxTjcvNEtmaG5VWUg3c1MrelVwMEdTTVJKNkpmOEJnK3plbzA2VjcwVGwz?=
 =?utf-8?B?eFQwY2p3VzJHWTdvWnV3dmVDcG9ES3BRNmhFRUVyb0QzYXJHV0JPTGFBWnlP?=
 =?utf-8?B?REd4RDQwdlBieFBlbGw1SVM3YzFYWTZ3eTRFSXpjMHdFSjdtcWg0UjI1b0dB?=
 =?utf-8?B?eWxzaXNickhGb2ErMzI4Tnp0OFlvblU4aGRQY1BkWDRyWS8xK2pLSkpOYytk?=
 =?utf-8?B?Y2FBTUNNTWhoUjZUSzBlTW9ha2JDWXBiR2lrc0lLZi9xTmJod1ZpNHEzR0pB?=
 =?utf-8?B?R01yUkRlVFFxa003UGVTY1d5YXM0dHVtNUtCd1diRys2bXgvaURqS1U5NWIr?=
 =?utf-8?B?VG1oYXY3TGVITGI4SXBsM3p1MjNsdFRIYzBzK3lRSllibDcvVWJBVlVPeE15?=
 =?utf-8?B?d3dHKy9JeVVqcHgvU0owZ2J6VVRycUx5NTgxczE4cnlza252ckgyMWE5V09p?=
 =?utf-8?B?ZlJyZnhBejdSMUtTV0lFT0I5YVpyaXVQQ2V5aitON21uT0owSEFKSGNMVlJy?=
 =?utf-8?B?RFNSdktWYldnYTFZd0NlNGxnMTFINC9zbklkdlk2YVFXRy9GUEw3RnRibVdX?=
 =?utf-8?B?YmJEdHhqblA3c0xHS1ZoNkxZdnlZTmFJNnRRMjBkb2MwaXVuMnNEVTdGY2Uy?=
 =?utf-8?B?S1c1QnAvZU5vRGRCS3IwTDZsQUhBZTh4N01tNXJCVE5mM3ZwZEN4b0t5ek16?=
 =?utf-8?B?UXJKNEVQNnpqcXZxc0NkR0FlZHB1R1BDTjh2eTVDTks1WE5JU01CL252QUJJ?=
 =?utf-8?B?ZXladk5zTkVQc25KWVZqVnduMWpxZkVsMzVnZ3ljejZnTG1KU3o1OXpYcHpQ?=
 =?utf-8?B?SGFodlJENHFKRFV3MHdtaFJmY3Q3NzQwNytUai9TWWpLSnFSK3JtNFU3clFC?=
 =?utf-8?B?WC9NUFFTc0FQR0NaS2F5K2xkUzNPTXovSmpDUTd3MFR1dTNXRU53MDlzbHNE?=
 =?utf-8?B?ZU9Rd0M5TndTTEdCSkYxVFJ2M3FveE8vbVhmYVBXSXUvbWtVY0JkQT09?=
X-Exchange-RoutingPolicyChecked: pVKjZfjKzEEthkG7+wYGx2ZyrcwZj6YpSTrzXgfVV1v3N/EK4EU4STkgTJCKblCmjb3gn+OB9Jr198dvCIOp5c6GAY4UgQfewXqIrrY0XTrLzPJFDJNoAXqv8x6/r35fu1T8mJ5ltbydo5hwO0IgPYvkmOhPCF5tTF7Ma45NK+c2BpamXjWlZE58T/+FozybWMOsrXTpCc1zjAE2m1IkKbjZ8hJmIWQWzyeJI8azNSlj8Y1D8bdgsRT81ebfdbQ/R+R2BpzBvmJgmF5EOzbDZqVKkhWzAFWirD8yNyoh4AKZfgGiyaxeqFTNwb7Dqiv92GvDvYvPetEA4u6d9dn5+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BlYwzCRDbjVOwwMEshzifW3zpD/JBnF2/xCu0zvKhhMNCc9ccD+RqJcWQVNdsMeZ5Xw111mkrcjQvt5JHdWGWFgZHHLDz+/lRz0iaI95fFj1QBvtoYsTXsrILSs2+WONgnYFN8YyIv8mxLiABCoR2J5kCLUqY93KLC73BGDtKPuNHYuaeYoId9AOCFVju+u94rydBzSVst0YA/gOyWuO7J6cOx1XRX0Z8pfxb3clrt2EIIBDSfmYfQgfRXL4UzywJsGq3gRGbT9M1+Ls2MlcNLvn+t+/ohybb+U6qVGeomGs+vIVa4dlu+92EA7LMk4jSO+zLlVDvjNtquE3XsyrZvjIXvSmMW4j62DKofiz/+R1yDjIdg3VwyrwEmg5qN+xylJin+mfDpbiw8R4+5t5QSVkCVp4bl9sJbaR1nKxGxcevZEeAc8C38VTwF8UQaPHsFlXfagGDmxtz8Y7I5pRub9AUDZl+Xg+R8stGRVqsTSIllpBADZXZbF3HoBuu+FNbhriZXvHQsnS9Vxbc1UfMHryZBw3H9ahmiXgL9rrY3pM3eeIFxAPFf0lqipqzU5UikHiy/ssREeVolOVk/JJ2XLfWJj4scAwstXs5SK4fvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e28fad-66a0-44d9-0710-08de807d849c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:22:52.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT1mPhv1h0bZJJwoHT8hVR92cQi17wucbyUuOMd6BLSWXAPrxqYul1HQjMIO8xnlJhRZHt6iKhjkMAARgehZ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603120171
X-Proofpoint-ORIG-GUID: v_IQbJu-Et7V1gYUt7nienXC8Ss0IU-c
X-Authority-Analysis: v=2.4 cv=I9tohdgg c=1 sm=1 tr=0 ts=69b32eb0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=rSFp41ukAcPlxLZOYyQA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Proofpoint-GUID: v_IQbJu-Et7V1gYUt7nienXC8Ss0IU-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE3MiBTYWx0ZWRfXztZgNR7EWWMl
 kA87hzteGL6cFQHnPIrct21WsglA32FulmMr2nSPTkGjSiDoTEUjuHJzPPT/JTv2UVcMrnSX7NO
 ph0U83mVX+flsBuaVqbZ19ITYpFP36DmcHOpNfBImy2MlY49gAIjfxiaOGACOJOetYxYe2/pf8R
 q8MOwp8sk3jj2wm11Cu3Dch36AxdxbjkF0TuCgNnmgdXmYfEqKnRBtCb/nkU9mksY9ydlIN9bxj
 PJNjoz3cbVTYElEko2JEh5l/AcuV/Q7XyJ+jdVLCTSzWZUynAdRpOu/lgw9KwqwKEhK9IDyih7N
 cvq8rlhr3pIIu1HJzig4TveEhxa9i4C1Jq4/AiZrnz//VvXSMfwlAcz6sDx5OqJFJwlC++xpStI
 IA2wyovgIEcgb9/ryGuBjlYcT8G7WYZnbJ2v1N1Z7QqdJHyE1WkJljjXuW9jvndN5acLMvEOiyg
 MHr7mxVf4bXJZS0KTXzxlT9WcxUr3TCfamHXF+/w=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Gerd,

On 3/11/26 4:34 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>> 1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
>> prelaunch state. Use SeaBIOS rather than UEFI.
>>
>> -device virtio-scsi-pci,id=scsi0,num_queues=4 \
>> -S \
>>
>> 2. First, attach the boot disk, then attach the secondary disk.
>>
>> (qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
>> (qemu) device_add scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
>> (qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
>> (qemu) device_add scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1
>>
>> 3. Start the VM from the prelaunch state. Because the "bootorder" and
>> "bios-geometry" data in fw_cfg is stale, SeaBIOS attempts to boot from the
>> secondary disk only once and then stops. As a result, the VM fails to boot.
>>
>> One possible workaround is to require QEMU users to explicitly issue a
>> system_reset before starting a guest VM from the prelaunch state, if any
>> disks have been attached or detached.
> 
> Requiring a system_reset looks sensible to me.  Neither seabios nor ovmf
> have hotplug support.  So if you expect the firmware pick up any new
> devices after hot-plugging them it is IMHO a very good idea to force a
> full re-initialization via system_reset for robustness reasons.
> 

Regarding "Neither seabios nor ovmf have hotplug support", we are not using
hotplug with SeaBIOS or OVMF in this scenario.

This is a cold-plug operation performed during QEMU prelaunch state, before any
system software starts running.

(1) Create QEMU with "-S" at prelaunch.
(2) Attach disks.
(3) "cont" for QEMU.

In other words, we cold-plug the new disks before SeaBIOS starts.

However, because the "bootorder" data from QEMU is stale, SeaBIOS cannot
construct the correct boot order once it begins executing.

So this does not involve hotplug; it is purely cold-plug during prelaunch, prior
to SeaBIOS startup.

Therefore, would you mind helping confirm if to issue a system_reset manually is
still the best option so far?

Thank you very much!

Dongli Zhang

