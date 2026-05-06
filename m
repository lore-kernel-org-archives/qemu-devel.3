Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EB8CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKeUW-0006cR-2d; Wed, 06 May 2026 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wKeU8-0006TB-Ci
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:48:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wKeU5-0003WM-O7
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:48:28 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6466brL1855322; Wed, 6 May 2026 15:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uQmtKe6Fw80J68j62f3f7qpk0cosoSAOOgp5NvoWGq4=; b=
 gkMgSbNfYo5HzbzwICV1gl4dx+fQc61HUINizixvCdH4uNyrdqMRycTufyvRuwH7
 UlHfH79OGN3F258o5788+b3HgUGJp+RA+XYtxo6BS4Lwt8s6USioTAiK6+AlAxBO
 KBmIn5dYP1Oy0b5K9ziOh8oFUEd6SCrZ6Yf7ChAKjH8cX4/O52SQBT1ixniPrIb+
 4DKTks8iKN1fFGiy5Zr3tU9DzE7GoItwpaGEoweLql9QvxDJDXfuFbIIq/4ygi2T
 Wi5f9zxZHKnhSJeuRl0sJ5NCCuz3tQ+DGwefgH/UMNoiqRIZWdrVnJ7PIIUbFlby
 WU0morW9qEa7hzzFT8KquA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9fb72ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2026 15:48:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 646FfUOG005095; Wed, 6 May 2026 15:48:19 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx593sudy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2026 15:48:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucCrMBkkEpZRdEh7fRndR+joE8j3FR+3Z/0s85VqWWmIHZFXUPRPZnFhi14Iwzz3KpmcCchTFZMm2rVZonjJ2UItqnh8h9oD3xCJBdL50CNeG7MM2e+JgSEVSiCedqrQgHyrdCF08BwtroexyVHFrVtwtzVHzXjSnFqpXFSlYfJbkAmZ7M1aLwEMEjOcfTSUQqZTVDggydp/OH3XFbfIXnc79aTZE2IMjb7taqvq+X72tNk2/5RqFPWokWSAYs8PQOxeXf83hP2Ur+dBHX2ocWicm5AAS1mOVCUMZf4AvJERjcLZ4cof8q9aqAbSM1Wcy1SFhVt4sG0AOEl1+sa7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQmtKe6Fw80J68j62f3f7qpk0cosoSAOOgp5NvoWGq4=;
 b=v3wCAbWzaqsbCSnQLot58HQnJ9WcZu2vJe2W6x2+FxR5GLl6Hrv/jTh+LEyHftAhwaDHtf5PA4FbQr2OXLx/2HWUxvo0jVkI+wnrIEMCYZdsHq841sMIM6QeRyymIUr8ULW7Tf1FSjkuzZavZVYgBRE3dVHs/dvqMmJkX6DkeAgx05dR/Ql++Be8tY1+bBvexZK2RoE1rG8KQDVVLxjDeICJjxCccjorXdUKBqCbUEgrHcuL16TGzn8z6cQAK5xaSE9EManXbN1TQH7sel6OAL7APjobfi2cZulraK3+oNX8+Qf0fPgkKWuCf3CnWvJap7hMtWfrkTg1kcyDvZSh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQmtKe6Fw80J68j62f3f7qpk0cosoSAOOgp5NvoWGq4=;
 b=K6IWvyzuPY0PhGNYfY2B7799eeYNlRD0LGcKoEAWw04m8sXNLSdpfeVJX57fo/PuSedIiMzHTr8zIWQb3Xdiwq3jAJM8sIv1D0JLWHPGr2JL73kaQuc9RunDyLhkQxAnmi0tiKeyBJUZolYRjG0j5WyyDYJ8GKOB5v7I5k4sysA=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:48:15 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 15:48:15 +0000
Message-ID: <8685c75f-09eb-4c05-a109-f16eca871999@oracle.com>
Date: Wed, 6 May 2026 11:48:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/10] .agents/skills: add qemu-build skill
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260505170105.228162-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:408:e1::7) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ff7e6b-64a8-45f1-2a08-08deab86e2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|56012099003|22082099003|11146099003|18002099003;
X-Microsoft-Antispam-Message-Info: I1nU242WNRW50GNpPPwHRGfJ3iMTcusSObwyQGupGUlc1bnfX9Z/FOSz63sbFBOQgdLctxizKkyrsAObFy914FrkoxESYHxNjzlh84dlrrPoxGGDXJqhFhSpDt6RCVO8rS/vM7FoBBncydF+RK+5zA2JZ7684kgUusFOIFQMZcJmAmxgHyM0No+eIzsTA2VinwpVJMkxYpxLp03GfEJXy3odkGXm8daHKHdtvFOiNCGJVQJWaWP1nGtw86VB0Rg5Op3R0jZmJzR/eZZXiLZXfVXZHkEPKzvTlqjCJdUnJa2c41YUZfnExG1VafZokHISO/vdTC8vks628MeDusL4U2ViPQzJWRD79mwhaB/HUde+XsylBF+mMTbQI3ho4fKPMrylT8T4hrMDpCE3MCRQ29/az0ZbLUor4szn/SurYSNqiqUM888GQAorp1cbo0wR8V6mAiWq92LcE/+Lg/rDvVa7jYOtRUV5Mdmlye6tURcErxFZcxpIYfATrP87SpEaAKQbmx3Cj55eHjOeMpkHndjXeCanAjkmsDzirgzf5mSlM0Xkp57XRa7YHgpandc/OkC2ZXNAFB78EwZjL/BI4qwbsX1p3cFzLFFnUIX+a//YOiY0LkTWIunAZTqzI5kbG2FMSIn04XmH6cWtuBgrbxzvhlHFDpj+R1tfuT99r+y7ms+7AWM4OC8PIGdEOYLm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(56012099003)(22082099003)(11146099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1NxTEpycktWeDFpa0lrY3BOSE5mb1FjcnN0Q290RUVhbzVpYU5xYVE1OWpS?=
 =?utf-8?B?eVNVU0ZmNHRoV2FaSUlxMktGSVJLSTB6dmxNN1IxZ3JSVVdETXdjWmNkTjJa?=
 =?utf-8?B?ZjV0YUVwdUJMenNrMm1EaTFmYlN3RmRWeGNHc3V1cEpFUFh2aXkrRDUxL0JH?=
 =?utf-8?B?K29mdEgzZTZYQXNIeURic0ZPZWFqZFh5UCt6YkVvUC9XYTkyRUdPRjh2U2x1?=
 =?utf-8?B?ZXhoWW5VbUxMM0IrM25way82bWRydEdoWE1qT3dieHQ1dTNVMTEwNDJnZWFR?=
 =?utf-8?B?cjJGQzFnQUJQeitYNHdDMG02MVpBUHlaVFp1NkhRTVNYRW9sTWdESTYxNUNi?=
 =?utf-8?B?ZDZjVU5OazhPUWFSQ2lEZXRmYUgxR1dUa0MvZ0huNTRYUXNiWDJ5b1g2MDlH?=
 =?utf-8?B?NDhpb0haRVNpYnpackc1WjVFYW9EYkVDbFl5aXFzNHU1UVVpUVRLZnlVLzdN?=
 =?utf-8?B?R2tUZ1IvclNhRE05NllBYW5KWmdMOWNheTZNSXJMckhQT01wbFgxVnV5Zklj?=
 =?utf-8?B?UGxBSWNSNzdkQWVKcEZKQU9xSEdaemRFV2d5QStYYWMzT09pWmk4MkJYajln?=
 =?utf-8?B?SVY1Y0J1d2FaZTlhcHQ0QUx2b0U0RDlpa1FKWVBQcTFWSHBOSGZrRy9keThH?=
 =?utf-8?B?QXJzS0d2VTA3SDNyVDVRdUtzZGg0MGUybXhaVVNKa1cveVFCcmk0Mk1OVWcv?=
 =?utf-8?B?VEUrRmNnRzI2T0pKN2dmMjVRYzZ4L2gvQ29FVzFGcndVaWxad01DU296Wmhk?=
 =?utf-8?B?Mnlxa3Bldk5ja05mdEQ0QzB1eXN2YnFmZFU2WWFhRTFOOVZ0VkhJMnlSSFVC?=
 =?utf-8?B?MW11cDRLOVlNMmFXZDBNMTR0azBia25hY1VNK2lhT0lINHNjUGhtQUhLUDRW?=
 =?utf-8?B?eUx4MlFZZEVETkpSL1U4MUpzTjFiUU9FNmlaQVpnZE1HcUNCK2xscWV2Mlhs?=
 =?utf-8?B?enV1NzJlWU9PVk1mb0ZKbURaUDVqSEhyc0RyZ29taStWWVFTTDV4Q3l5ZWxP?=
 =?utf-8?B?ZmdwZUJhYWx5UHpkdS94UDdZZmFlQUwvdjVSTnJXTktjcHhkV3NSaDZYZWt6?=
 =?utf-8?B?M3hObzhEamJjWDhybURadDd2U3NoQ3RsN0g2SzJJVFYzajR1MnBxMEQxaDc2?=
 =?utf-8?B?RitQdHFVVFVCL0xCa0xyS1NWQkJJcU1hbHFIc21DTVFZQllVOVFHczZ6eTh2?=
 =?utf-8?B?K1djWkRXcy9qYWN2SEFUYVNJS3pWY0h1aldTNXZCWVhBVXdOUTAyOEFYYmx5?=
 =?utf-8?B?MVpYclRHUElFbC9UdzdNOUlxZCtmNWlHa3l5RzJKRlE3cGlITS8wSStGS2I3?=
 =?utf-8?B?L1VCSnB5Y0x3UVpLNVI2QnpydHlmVGtUdTByM3NBanUyVUFWeTdGUjV0ZGIy?=
 =?utf-8?B?MktKYWY5VHVnL2VhQWVKQnFtaldaYWQ1ODFRNFBkbGx1bXBkaHZidWtMeEFp?=
 =?utf-8?B?bVZoNHVSTXhpOVFLakxaMTNnYStabS9UUUgyY0JMVC9PRS9QM0FOaUhjQThP?=
 =?utf-8?B?K2llMjhNOWZOaUZLMCsvUnhsWWc0V1JXNFBGei9abHhGTmJJVUxtYU1IdTRn?=
 =?utf-8?B?YzVvU1NhOHZaUG44VzkwUE5HekY2eVpXWitLV0lTeGV5cjN5TUpIU0tRcS9E?=
 =?utf-8?B?aTJqb1hpbTloNjhNOXE5RWJYL1orcGN4SUxFM1prVjFZSk5VQWpKa09seUs0?=
 =?utf-8?B?SW9oSXFRaEJMUkx2amoxbHFReXNKNHhkZEZ6QStsMHhnaTBjM1VrcHVPTWcx?=
 =?utf-8?B?bm5pczZ4em5aaFdNNktXWDJzYVJ2b2MwVkRqL3Y2eGRQUWJLVDcxMnUvN3Ri?=
 =?utf-8?B?enF4UXFvTGFkZXI1aENlM2NhcGx2MUR5V1FVK1h4YlpuM2lDRlN5UVNicnA3?=
 =?utf-8?B?U0h6bzZ0eVJnbkVGTXozV0ZRKzc4a0xTem82TjRYbFpZVkRXK0dZU2dWakVv?=
 =?utf-8?B?U0RFUE9CbmtqMDNSZXBDLzZVb1hXSmxnNm1GeTNGLzc2RUJyaUhrMU9DcTFH?=
 =?utf-8?B?Uys2Z0ZRNlVPMzd6QjBkVVVSTTN0Wms4UFBEQzFxd0FWM0NRaUxFRmxjbi9j?=
 =?utf-8?B?OFBuNEs3OStvd250VHNxZjBzamJoVDdrdHd1eHk1a0FEZEZ4SmgxUE1vNUVG?=
 =?utf-8?B?aktIWHIzTmI5N09kK29SQTI4V1RzZWl6VGYxL0hwbCs3SWNBdzlTalB5SUJt?=
 =?utf-8?B?dWhJdlZmektYNUJYUVBWVTV3Q2thalJtd3RuRlpXUWF6MmdZYkpHYm9XcGgw?=
 =?utf-8?B?QU9ydElwVXZWR1NrTjI4cDhNeFB5ZWZOaXgxZUp3Si95a2szNDVHTFlnRGtT?=
 =?utf-8?B?MDQrTnE5Si9OQnY4TUxHUVhIaWtPVlViOUYwU0lrUjlUTXM2QWQxaExzcVA3?=
 =?utf-8?Q?yft5oJhIm4jrs1rBMRZJo1hkzZwgmw0uQpnv+?=
X-Exchange-RoutingPolicyChecked: P3yORNnqjSF1ytaKb78eDN1CtqNC6os9uEB5ckOu1cwCBe0Aa1UYn9EOTZ9yl9IM8ANKJ6rdaVNKy/fNciRcH8H+pnld9QnzCQaGIaiQR/kuX8VpSslOnmT78GgniQOi2dUnXH8xtxk4FJnG7v9bYx02IHLQHI1gusBY17tXm/FS2bBcoA+EDH1b+9xhP/5/u3bwMii3SP0K6fSksELELHkyfqIAn9bI7ydnQ6nEJdWUp4MjT2yp5seut2uc2fT8hrXXNvGRaAkqX6q3uz1xHnToB4Byt+hL+vnpPlBmxuLWS7JmHgIMu/SON0V+yizV4EhlhHTQnp4dl2oP3Fwl/A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oyHn/T0kZn+DQJ4FvROFqTJ5BksWnDPM3vV4Ez6yC1Q3uMY4RgyEkxC1GvTPO2w8C+QluahVVkdruWMIX4Psk3XkZuM4zmt+8x8evAMSO/uGFa2n6i4mKc0yq7gbNL2WGbVCogjJYKgBqTaCPqt7taMHJad+ddTRydglTupB+NbzugnPmFcqpCaKo4d8swSiZDNAFJwHRcBzSp/iSIVPd6zmk4/wjGFEyb7JMdeiyhaDTujOxHhHWfacMeLWssgj7vsKandxTb1H8HyrwELooU5Ai1MQYKcvft1CSp3bLGrpfwMLLV2d0U0ZcnMsdxcaDobON/atDuQNMLC63bNHCB+++npXn97mXdURHKUW325DhVkvr3RzevpzQ5o+31GZ9elmuZnzwKMv39fssDn0o6i6qAvuhu9U2yaALZlJ37aZUOtj033NtshUNKwrVctzunAH4AORk6bPHCsLWMDUG7sbRLpewcq9YjASnZRHfwE4CIHVof9Dzmvm4fbLs1YzBm/G1E8U0kmeRBvT2D8KLW3uaIVh5nMvax7D12se/0ucQihOFAIJOjj33m3xp11MYnA2JwedzK+XuzK/F6Pu8bzvVK3B66pf9Ixjo/D9fIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ff7e6b-64a8-45f1-2a08-08deab86e2e2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:48:15.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/R0SkoV/M+wQjLwPUnABv54nBRwkMZwTAMkLEMGxQI71G61BY3yIG/N75lV5ck382gtoEhKiMYKBH33ZbT5YV1w42CdxfrildOTS34yMSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605060155
X-Authority-Analysis: v=2.4 cv=errvCIpX c=1 sm=1 tr=0 ts=69fb62c4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=KKAkSRfTAAAA:8
 a=psOqzFCevih4VJoPeC8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YH8CGiwh6Dz_3HlpjnRv_0xVAvkY1vhS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1NSBTYWx0ZWRfX4hL7CERfv9WI
 ltFZQIzAlT2SuCLTnJtyEmdpCTgEEp4ur2XAS6d3qz67HikBy8lJcHF5kCUA8kTdW5F+515fpfc
 LR6mgV/+RUDYYYGtSbVDfynkExGsk9t5jkQtJToyG6fDMZ0f6WpQufv95VtSGkEZCERzm4GWP6+
 g4o3YiCEAd5WQJBDOU4nREMMNhwkLepJ3lfpCeuGCOYol6JWpArOXcA8tH/GKtQEYErV9yY6DE2
 93uOD6n094ndVD+GjFmhYcUuucli8GNRx3BnPTWuVdsrOk0TSjDnWALoCNcxyH9TnujGkLVxez0
 lpv2w4MEzlcLkSalmZOxQAIINUCNXQEyO1ULO0ocvz03f4fVymABP3XiT0jNFlM29FjBVp4sjpH
 quQLoVwUKxSUVjgHQBemi3PNqw1baeUnkgvcFDgRfuo9U1IbqPLo0ajeKWpKaqDCoW6yqTtYx+g
 7+qQ+AsR1ej0mtu8yBA==
X-Proofpoint-GUID: YH8CGiwh6Dz_3HlpjnRv_0xVAvkY1vhS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 5/5/26 1:01 PM, Alex Bennée wrote:
> This provides basic instructions for building QEMU.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .agents/skills/qemu-build/SKILL.md | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 .agents/skills/qemu-build/SKILL.md
> 
> diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-build/SKILL.md
> new file mode 100644
> index 00000000000..a78678ff632
> --- /dev/null
> +++ b/.agents/skills/qemu-build/SKILL.md
> @@ -0,0 +1,50 @@
> +---
> +name: qemu-build
> +description: Provides step-by-step instructions on configuring and building QEMU. You MUST trigger this skill whenever the user asks to build QEMU or debug build failures. It includes critical details on build directory reuse and spawning sub-agents.
> +license: GPL-2.0-or-later
> +---
> +
> +# Instructions
> +
> +## Examining and Re-using Build Directories
> +Before creating a new build directory, check if an existing one can be re-used. QEMU uses out-of-tree builds, typically in `build` or `builds/` sub-directories.
> +
> +1. **Check existing configs**: You can examine how an existing build directory was configured by checking its `config.log`. Run `head -n 2 builds/<dir>/config.log`. The second line typically contains the full `../configure` command line used.
> +2. **Re-use and Reconfigure**: You have latitude to re-use existing directories when appropriate (e.g., `builds/debug` which is a general-purpose debug directory for whatever is currently going on). If an existing directory has the right flags (like debug/sanitizers) but the wrong target list, you can reconfigure it to keep the same config but change the `--target-list`:
> +   ```bash
> +   cd builds/debug
> +   # Check the old config.log, then re-run configure with the new target-list
> +   ../../configure <old-flags> --target-list=<new-targets>
> +   ```
> +
> +## Launching Builds
> +**Crucial**: You MUST NEVER run builds directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent using the `eca__spawn_agent` tool.

"ECA heritage" showing with the eca__spawn_agent mention. Ending the
sentence after "sub-agent" is likely enough for the model to do the right
thing based on its available tools?

> +Always use the `qemu-helper-agent` for these tasks.
> +Pass the specific build commands, along with the required working directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
> +For example: `task: "Navigate to builds/debug and run ninja. If it fails, report the exact compiler errors."`
> +
> +## Configuring a New Build
> +If no suitable build directory exists, create a new one.
> +
> +1. **Create build directory**: `mkdir -p builds/test-target; cd builds/test-target`
> +2. **Basic Configure**: `../../configure --target-list=[list of targets]`
> +   - Common targets: `x86_64-softmmu`, `aarch64-softmmu`, `riscv64-softmmu`, `x86_64-linux-user`.
> +3. **Common Options**:
> +   - `--enable-debug-info`: Include symbols.
> +   - `--enable-debug`: Enable assertions.
> +4. **Sanitizers**:
> +   - `--enable-asan`: Address Sanitizer.
> +   - `--enable-tsan`: Thread Sanitizer.
> +   - `--enable-ubsan`: Undefined Behavior Sanitizer.
> +
> +## Building
> +**Important**: Always re-run the build after making changes to the source code.
> +
> +## Reporting Results
> +**Crucial**: After completing the build task, provide a concise summary of the results to the calling agent.
> +1. **Summary**: State whether the build passed or failed.
> +2. **Failure Excerpts**: If the build fails, include relevant excerpts from the logs (e.g., compiler errors).
> +3. **Full Paths**: Always provide the **absolute file paths** to the full logs for further inspection.
> +
> +## Debugging and Environment
> +- **Verbose**: `V=1` for detailed output.


