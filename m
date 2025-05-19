Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A07BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3Qo-0008Cv-Em; Mon, 19 May 2025 12:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH3Ql-0008CQ-RG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:33:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH3Qj-0005CL-Cs
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:33:35 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMn7s001703;
 Mon, 19 May 2025 16:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=R5cF/oAfpOzfOZioccGrubKLPCyZ01W+JSBRprXHXgI=; b=
 eQ2GuIJt5GWNwEzWF+sj6WcvK2DZ2pZUHxrNMTYPk5rF6UtfH38ugQtbWto9b1I4
 A5m57c8yKeZ+BySkG/uv0W7A5JjYhEOxENG9d/D1fgUC8KRv+9DeaOwFfDK3Zxnk
 NfZBeV5rWIhlerr+Vp96xKF1sZ527eXrhhk4bm4FjEcLbWFq3icGPkW48SXx1d50
 l0DMRDTnVbCgQFgO/hYFyv7+HUrJ/WWAWpgeNm9OI671XEIOeSkxWi1Jlh/9GQY1
 rKOwjACPe8CA3eC7Tv9ABnL/IcKo3WTPYVmh0bCdj781QBTRMy18zA6/CyRij/JA
 UIi1aEsSufkkT9RjKeYmZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge3geb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 16:33:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JF9o7H001022; Mon, 19 May 2025 16:33:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6xbr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 16:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMuTXC+pARM5FX8WyUg3C54rWD4sz9XHcgWaeRa4LaiNaD0hdLPM+5tgoIMAh4LHJLJcCMtxHKI9hVE/lxh5creFc2/PyledPmG9CB0hSdmZYUb0w+2jkJx46eZVfIzc2g9fiNfTadY6zi3kCLEq5sWaw4LQG35yiMGl71YycgcFtgyGHLcTjBnXFuLRolL/XJBVfOyDWtE5P6LcDNjZmW9NzObEuocfDIasK1j8KSU6F7VsQD4TZ401BvpNjXL5AHf7oLK631HRPDQQIYQ9n60ENfNirxvJFOEcEd17+dI2SXV/TGmbxZxF1buzJYv2JiTpHvsomHLL7uiboJO/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5cF/oAfpOzfOZioccGrubKLPCyZ01W+JSBRprXHXgI=;
 b=u2S9AgnIOLs8ADGIydMtI0dEUrneXBsLTnvW3nNo85xZz6sdTG5iQAC2mPJKyt463Hm9aCyEKGkYEl2QGVSF0NMKaQxhRYgz93ELKcZCAJP3cnl3ez3q2dAbvQc4zZX0rBjGUKZetQKSWfSm48YNl7Pvx/cvLF+4SqGaMp+GXascAJrZmovPxPn8ihWC6c+KpV1gfGkGb/TWsgQoRw80H9F4jP7GcAnsS8s8Y2RGqyOmKMsSdZn98gzM//RFXFWd2hhoizQQNGbL41RjrBRX/E6u2rEsMSG348Pbl5qR9ljVxlLkJEyuenU/pji1Q9ji5VIFJbQ6DO+IN8htymSNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5cF/oAfpOzfOZioccGrubKLPCyZ01W+JSBRprXHXgI=;
 b=RQ0oDg9ABsenirE4SFTIe5BdAS/1Q6HAMKkoSc1hYm0FKjWQTJvbBwjkTOpqvuM4aWMVZ6Vjwjdx4KgYLOKKgz3/ivyLTCARR38+XsJWYd4jG0crJVtSYNzXiyxtut5+Zb5bs3a1BZOeuhaloDDKpHLdp2+PdJddddk55Hq7MtQ=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DM3PPF311E3C1FE.namprd10.prod.outlook.com (2603:10b6:f:fc00::c18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 16:33:26 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 16:33:26 +0000
Message-ID: <399b0a79-0b16-4521-ab25-7800f12cffae@oracle.com>
Date: Mon, 19 May 2025 12:33:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/42] vfio/container: restore DMA vaddr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
 <0501dd8f-7cae-456e-b4d7-e80b8aaaa5b2@redhat.com>
 <8a5c86ea-f0aa-4b84-9efd-1ce0edb2e7fc@oracle.com>
 <2e53aa41-30a4-4912-9919-4048a51828a8@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <2e53aa41-30a4-4912-9919-4048a51828a8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DM3PPF311E3C1FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cabe93-ff0c-4296-959b-08dd96f2e160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkRtUFk3eGNPMjdxd011QlprWmNjbWVYZTB2bDhXTm5XK0lzTVoxQ1ZxOXRQ?=
 =?utf-8?B?MldNY1N5SHVYcGdQdjZvT2pWajRQN240djBLTEtxOWFzdWZrRFN6S0NhYVZh?=
 =?utf-8?B?OEdMTUNiZWVxUkpDMnIvQUplTDN0SEw2ZUJ4Tzl0VkFraThUWVc3cTd2aDEz?=
 =?utf-8?B?QkRydTA4UG02NkhzdTRWcHJzdlBZT1JIZHBzN0VqUk5jb3RxRjNFdHp5SFQw?=
 =?utf-8?B?a1VyTkJwclVLaDl1UDVndVFKTEJPbzFZcWpPNURGdjlIek0rUlBZRUkwUEVO?=
 =?utf-8?B?Mjd3VGw2TFR6eUZwS1Y5cUdnUmFSQ0pCUTF3bk9pRVp2U0pwQVgyUFBJME5s?=
 =?utf-8?B?U2RPaEtPK1cyNStjM3gxNjIvTk1qZS9ibXhmSUFzYytFMlRsd2UyenN0bnZh?=
 =?utf-8?B?WGl5UHV2MnhkTVo1S2E5NGFjdW9FdU8xWEV1TmRvb1BKNnhjanJyZ2wwc3Jw?=
 =?utf-8?B?N2pYdU9TNnNaN2crblVZUGUzejIrTUhaVDNtcm1vb01oVGMxaHpZMVNGa1di?=
 =?utf-8?B?NW1pTi92SjBpR21PelQweEcxUW1ZU3R0cldXNWlQeEJ6Mlp1K0laMEk5ZWFW?=
 =?utf-8?B?Tnh6ZE9lckgrMGh3aC9yK0NGQ2JZTzczd0hyMVNBRFR4MkV3anZEakl6SU1m?=
 =?utf-8?B?Z3BlTk16REl6aHpreGZMbDBGYkMwRExKaGZEUEVJaFdMV1kzb0RtTVRISjRm?=
 =?utf-8?B?dnFHSXhSTWlyVFQyenpEazFONXhvZGYxanhXSHAyd29vUmNUMmhSMDcwNHp4?=
 =?utf-8?B?eHhzYUNNWHFUU2diMkU2UEQ2bTJkMUpNZ1ZjN3o4ODhSY0lYZHlLRWlTMTM0?=
 =?utf-8?B?S2VJVXhReU11aS9lRGZJOFJUb2RNTmFRM1ZtdUUzdDNXTDRMVE9XNkFHNVNm?=
 =?utf-8?B?SGpCTWpSUHJCSDhKRVV2MytNUDhqeXZqNWx6WVBsQTFSaXd1alJMSUhxN0ZL?=
 =?utf-8?B?STBxc0VHT2kxbWVpSGI3TU5ucXVTbXZoTTIrZHlUZTQ5RUJidCtFWFlldnpS?=
 =?utf-8?B?bFBpZnJzM09Wem9WRU5aWDVnRXlrak1sTlhlMWdkK1VaMnVHK3ZUOHdLOGc2?=
 =?utf-8?B?RWZQci9UeE9OL0dscDE2YUh1RzVDd2czME94QmhKWXRLaEpZNUdnR0NBNmk2?=
 =?utf-8?B?MHdGeGY4b1M4bm9YUnNadHNERkN5dVBjSEliandiTC82c0gxKzFZcFpyYTFy?=
 =?utf-8?B?dlZkcUtudS96QkJ0ckxaa3lvQnNNY0wwY2ZjK0hKNEFMT1JoVmxYdXZlWWVo?=
 =?utf-8?B?RC9nVEJYK0EvblI0d3F2TXArcXBNN0xXOTlJU0M2SFpXNE5hK2VydDdoYXZs?=
 =?utf-8?B?NnNldkRtejZtcE01VGlaU0lVRWh1TmdmR1FySVhCZUZsb2VmMEd3N1RKaXVE?=
 =?utf-8?B?UWFnc1pyMlZtMTZtS1Fub3dRa2luR1cxMTNBaXlwZWtCZzAzemtpblM4dkFu?=
 =?utf-8?B?VHZ2MkNibG1pK045Q1VlQXAzTFR3WkU0b0Rudll3LytFZDRjY0R5TkduaDVF?=
 =?utf-8?B?YnRmaGFlRmtFZGJTVHpjV0JzZnBZWkpZaGxkZktGSzBEM0M2WmU3djAxMURX?=
 =?utf-8?B?bzA3WjNwWGhWMTFEYkR0aGE2NmtJS1hPemFpUnRrcitNMElVRjNNeFJONmRH?=
 =?utf-8?B?dHdEOE1pc0NvdGRPdmlpMkE0ZVZXSWVGS2VyWjlTeXdUWjFyallxTy9oeDJC?=
 =?utf-8?B?R3lTZCsrS2x5OUpETmp5cXU0czdrR1hOakkzRnhVQUk3bSt6Nk1yNzY1aGd5?=
 =?utf-8?B?dS9oVXlhMjNoSGRVenRXOCtPTzYvSzRFOFRNeHpBclpWeFJFTjR3Yk1mTnNQ?=
 =?utf-8?B?QVVaYjdmLy84RUlmYWkzYm12M2o1UDZtQzluZE02MG9uWmpzb2lJblkzZHBZ?=
 =?utf-8?B?dFVvUGVIazhqY0xuc0VlN29rYWk3aWQwa1F1b2JaMWJIWnNMRkJPWDdJakpw?=
 =?utf-8?Q?Pc09GK7fN6I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRzLzJRUlplS3NLMEcvM0dNeTFpS3lDS1premdnM2dtZ2JrOERaQWcvUCsx?=
 =?utf-8?B?RUZ1ajJTRnQvdG1qLzEyd1V0emd2WUZpSklhTm1UVUZiL3JHSTcwNGJ3eG9p?=
 =?utf-8?B?V21qaHJTM24zQWxuZVR3T1F2NjhtYUNVaUNHbmVpdGZvUndWbFozVU0wazFq?=
 =?utf-8?B?bWtYeHBIZ202dXkvTkdmQU9MT1ZUQTdveElnRUplZ1pwZFpiS3F0ZnhtQldJ?=
 =?utf-8?B?USsvaGZ1bmFmc1hYUEhWdWIwdEZtajdVZWh4aDFHaFVzS1NiZk1uRGhyUHRy?=
 =?utf-8?B?ZDNONFM5YmhCRzN0c2o0U1BPN2RiVm0yVnYvNThnMVgrRjFsb1dvSkpBeVkz?=
 =?utf-8?B?Ykx4akVxMVVzN1BRd2hFTDFiaTJCbHdXK254NURJWFM3WlpSa3hPc2MvTU8x?=
 =?utf-8?B?SXdTZGJsYWNhTHRaWTc1eVJVdWxzYnBKRHlMV2tjT0x5cVdTVkFMQ0RocHJh?=
 =?utf-8?B?QmM0ZzdTZy8xd3VBbGFrSmRSck9qMTdLVG10bEZsbUZZckl5UzJ5azZ6Q2tl?=
 =?utf-8?B?bmhzYzhQK3h2L2g0b3JXOWdnakhZMlVHbDZPVnZMZmNBQk1TdGN5VzJJZnZY?=
 =?utf-8?B?Ky83UXIwbThCbjhPL3Qzcm5HMjJWR1k5aDNFTGNYSW1ycEhuOHMyWWJlU1Jh?=
 =?utf-8?B?Ly9YNGw5U1R6ZEEyNlVDQWY4Ri9lbUo4bWxZRnExSHlSczVncmNlTEE3OExW?=
 =?utf-8?B?NHRpeGoyV094RzJaTlYxTlFjdWFVMWx3ZGZHTHRxN0s0QWc5VUxJMDUwSUMz?=
 =?utf-8?B?MWcyMDhYcWo2cjdrZytKblV4QjNjOG1mcE8vSFN0bGlrZ2ZGT3RyTm5LbmQx?=
 =?utf-8?B?bytobGJLYStUWVFKcVB1OW1MZWFQTS9SR0g4TUhNL1dUWE9XTjV0VFE5N2h3?=
 =?utf-8?B?dkNHeklGQThxOXVCcXpwMnE5N0xuRUNrSUFwdm5BRVFvQ2FuQWQ2cWZybTNo?=
 =?utf-8?B?MGYwbzBWUWZNWHdFcWdPdGpRbVc2dmkwc1c5eDErNERHOUV4alNRaFpZdnRo?=
 =?utf-8?B?TnROSElaVGttRGlnQ0VoZDBMcERSTTd0Y3hCSEpHQ0plcVV2YVNrbkRuNjFo?=
 =?utf-8?B?VFdKcW51SzlhbEh5SnE0OHdtcTN4bGo0eWJYb25hekpYS09uT1Z5STVPelZT?=
 =?utf-8?B?VkExaGpxODhRUnZuT2Nka2s3eXR0T2lRekZzSkFUWk1vR2N4dFB3bi9CNkIy?=
 =?utf-8?B?WnBFbldvSFJnSExNSTlPSGpLTUN0ckRIMThJSEFTUXp2QnJmZzB6MTIzMFYx?=
 =?utf-8?B?UmJLcWJ5UE9OWWJrZ1ZkSkFNSGRqRTdCK2ZYeUdZemJLNXhHTzg1d213YmVr?=
 =?utf-8?B?TlJGSGFqdUZmS3RHRGF3YWprQng4ZXRJeTdyM3FSbDhOd2RsQ0ZDQk42QWE2?=
 =?utf-8?B?QkdJQi9sM0w3TmQySVBwc3dXZFUrLzVZNktDd3dsYmJMeENoSkoxVlpxQVpN?=
 =?utf-8?B?ODVHSkoyZkNIZ2tBd3B6N3gvZXFFakFqTUpjVDJpeHhFWWFqMGU4cm0yVm1I?=
 =?utf-8?B?OTR4cmZlT3ZZcjJ4MTNBSnJKUVJrbFZXOTBCeHJFREkvbnJ5eHVFcG9mWW1z?=
 =?utf-8?B?ZGNmOWFGb0czajBnVDAwaEdEaTRmYU01Rlphd01mcHRjeUUvNVFFZW9ZUVQ2?=
 =?utf-8?B?RDJOWnJMOGtrakJpNVdMcnEzV1VWNDBhNk1aNTNGN2hrZ3U4VzZRRXRoNXgy?=
 =?utf-8?B?Z1ZKZXg3VWZKbEVRYklvZWUrMnZnU2E5SnBCVkNIOXlNY0FDWG8vdkhMNEUw?=
 =?utf-8?B?Sk04YVVQNGRxbGRURmVoOFRFc0U0aFVNeUkwbE9pNFNkUE1PLzI2eDR5UmxL?=
 =?utf-8?B?c3R6UzZRMXc2SDJMRCtMUzViZ2xjRlVTSWhWQTRMRFdiaDloQWpVOXl5OXdK?=
 =?utf-8?B?M1E5T3NWZW5TQXlZRW9IdXdIdHhLVnVkOWFJeXhHTnhON2JxOEtVSE80YVJu?=
 =?utf-8?B?THphbFBlNUMzaW00SHhRK2RtajR0bStYTVNpNDhxOWwzT1JyOW1UQ1Z0WStN?=
 =?utf-8?B?aER2SEt1VldoaDBLZFpxckVNQTE4WnFIY0ZCcEF3Ris1U0pBVUxwZW1RYU1k?=
 =?utf-8?B?U3d6RWhGN05sR3hwem9xUW9Dci9rYm1DM05MQ1QrWlVUSEN3YzhBbEpueGsr?=
 =?utf-8?B?OStxM2hxVFdxNTJzR2ZIWk94ejRmblJBNFQ1Qzk3dWg4dGFxcmxUQWE4eDRo?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gWdyGxRUqIah+ZHOSfPN1COJF1HkWPHXSgOLtHRIczPSeoySlJrc/bXaZ2ByGg68llvVsXE9VwRW/Sxp4mly7P6iBxC3nAFf8AmyhSePwd5WNxzgIxgAsaieRhcMd9/XEUdZjW2MwOtQyPZN+k7CN0yrcDKTymLpKNz3ZH2tLSaTKvRkeDLfOInX7pgkE0gcTEQHf5FXMlXV/YfFMjuTMZGEyffav912RZWmhANqu51tbcHX0dsgngb9Ab/q5DGKAD3HKKsYOmxjTiccRJa2AWM7ApssCNXPg5F1bMDRzmHYkOfAMfMw2fG/d5muWJU1bSid4pbard7PBpAw2Opsl417Nx/7yun8p8658exaFBRmj5xpt29K1RM6uHm5rRIbQh1MR9O4SUc6Y4bi6qEmimwanqvfOxmH1t1Hx1zAn8abUXKNQbX7ha5S9lOKiBk1cV7GnEicqb2VupIBUVYeoKAlR++Q1mqelWkjov0Zqmxs5cCme53OB3OYkR6mvvc+9Ck6auI+RcUAeFeH2UVsiwPTshtCMlF1YzI4F7r9v4dget2ATLjoufGmZjyn6t7dJzhFG9Oh318usdFhaZqTy4E6+e7wPeoRjqOkT2WkhKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cabe93-ff0c-4296-959b-08dd96f2e160
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:33:26.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulQH+FCWsZzYvetwUI/U2klUPlzOW+JbHP3O6hX5XbwROHvBhgJcznIS908fRZD3bXij6sJKc1p/I5ya41GcXwSNIMHyX1ar8krATXGjXXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF311E3C1FE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190153
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682b5d59 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=ufLEzA5eQ1ZwfnIYg-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1NCBTYWx0ZWRfX/h0UDU/U5DJA
 wKXA1J/zXR6j5Ai/NpF2aRnVCdjMmaZ0z6soxyub6bGuiK+NYq2r0r+YnlYGvbYT999zX9PDy3L
 f0JgxnrNj3XgQqA2NpVHsFKGY3PBvOQ05deoGkpcDWipWw2dsUDHo0KHe0cANbhELfx0Vt4+BnB
 NEpGvJb0OgExK3q7dcVNcGG3b7akldTr+hD0nAvzTpGYaHnMEcx4QwnEev3+dEblwOqdbaZRGJS
 8dTLKL7Ah5eY1fVqdkGaMvcXeHpjbVlzdg2CKijk+gKQ2lHVvuRs5niasR8TtsteVh96qG2fYBR
 aEU8GD43hUiego9gLeYS7vG0wrECj6bRAPJ1LdCWpeGgXNT3dS9tyrxRlCm8mdcD+UfOPRE1ak7
 Y/bk0eq1MXQCV5XjBDHiAZxXy2n94W7C9+bn5ZYN3JddQn6X1kJ4LxT2nQkdE5QYuTZrx4Fs
X-Proofpoint-ORIG-GUID: VTYvSpxuarjqWvNoGlgDSMV3bpN4Vpet
X-Proofpoint-GUID: VTYvSpxuarjqWvNoGlgDSMV3bpN4Vpet
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/19/2025 9:32 AM, Cédric Le Goater wrote:
> On 5/15/25 21:08, Steven Sistare wrote:
>> On 5/15/2025 9:42 AM, Cédric Le Goater wrote:
>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>> In new QEMU, do not register the memory listener at device creation time.
>>>> Register it later, in the container post_load handler, after all vmstate
>>>> that may affect regions and mapping boundaries has been loaded.  The
>>>> post_load registration will cause the listener to invoke its callback on
>>>> each flat section, and the calls will match the mappings remembered by the
>>>> kernel.
>>>>
>>>> The listener calls a special dma_map handler that passes the new VA of each
>>>> section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
>>>> handler at the end.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>   hw/vfio/container.c  | 15 +++++++++++++--
>>>>   hw/vfio/cpr-legacy.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>> index a554683..0e02726 100644
>>>> --- a/hw/vfio/container.c
>>>> +++ b/hw/vfio/container.c
>>>> @@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>>>>       int ret;
>>>>       Error *local_err = NULL;
>>>> +    assert(!container->cpr.reused);
>>>> +
>>>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>               bcontainer->dirty_pages_supported) {
>>>> @@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>>       }
>>>>       group_was_added = true;
>>>> -    if (!vfio_listener_register(bcontainer, errp)) {
>>>> -        goto fail;
>>>> +    /*
>>>> +     * If reused, register the listener later, after all state that may
>>>> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
>>>> +     * the listener will invoke its callback on each flat section and call
>>>> +     * dma_map to supply the new vaddr, and the calls will match the mappings
>>>> +     * remembered by the kernel.
>>>> +     */
>>>> +    if (!cpr_reused) {
>>>> +        if (!vfio_listener_register(bcontainer, errp)) {
>>>> +            goto fail;
>>>> +        }
>>>
>>> hmm, I am starting to think we should have a vfio_cpr_container_connect
>>> routine too.
>>
>> I think that would obscure rather than clarify the code, since the normal
>> non-cpr action of calling vfio_listener_register would be buried in a
>> cpr flavored function name.
>>
>>>>       }
>>>>       bcontainer->initialized = true;
>>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>>> index 519d772..bbcf71e 100644
>>>> --- a/hw/vfio/cpr-legacy.c
>>>> +++ b/hw/vfio/cpr-legacy.c
>>>> @@ -11,11 +11,13 @@
>>>>   #include "hw/vfio/vfio-container.h"
>>>>   #include "hw/vfio/vfio-cpr.h"
>>>>   #include "hw/vfio/vfio-device.h"
>>>> +#include "hw/vfio/vfio-listener.h"
>>>>   #include "migration/blocker.h"
>>>>   #include "migration/cpr.h"
>>>>   #include "migration/migration.h"
>>>>   #include "migration/vmstate.h"
>>>>   #include "qapi/error.h"
>>>> +#include "qemu/error-report.h"
>>>>   static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>>>   {
>>>> @@ -32,6 +34,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>>>       return true;
>>>>   }
>>>> +/*
>>>> + * Set the new @vaddr for any mappings registered during cpr load.
>>>> + * Reused is cleared thereafter.
>>>> + */
>>>> +static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>>>> +                                   hwaddr iova, ram_addr_t size, void *vaddr,
>>>> +                                   bool readonly)
>>>> +{
>>>> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>>> +                                                  bcontainer);
>>>> +    struct vfio_iommu_type1_dma_map map = {
>>>> +        .argsz = sizeof(map),
>>>> +        .flags = VFIO_DMA_MAP_FLAG_VADDR,
>>>> +        .vaddr = (__u64)(uintptr_t)vaddr,
>>>> +        .iova = iova,
>>>> +        .size = size,
>>>> +    };
>>>> +
>>>> +    assert(container->cpr.reused);
>>>> +
>>>> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
>>>> +        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
>>>> +                     iova, size, vaddr, strerror(errno));
>>>
>>> Callers should also report the error. No need to do it here.
>>
>> This function has the same signature as the dma_map class method,
>> which does not return an error message.  It's existing implementations
>> use error_report.
> 
> backends .dma_map handlers : vfio_legacy_dma_map(), iommufd_backend_map_dma()
> don't report errors. vfio_container_dma_map() doesn't either.
> 
> callers of vfio_container_dma_map() : vfio_iommu_map_notify(),
> vfio_listener_region_add() report errors.

OK, I misunderstood your suggestion.

I will drop the error_report and just return the errno.

- Steve

>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>>>   {
>>>> @@ -63,12 +93,24 @@ static int vfio_container_pre_save(void *opaque)
>>>>   static int vfio_container_post_load(void *opaque, int version_id)
>>>>   {
>>>>       VFIOContainer *container = opaque;
>>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>>>       VFIOGroup *group;
>>>>       VFIODevice *vbasedev;
>>>> +    Error *err = NULL;
>>>> +
>>>> +    if (!vfio_listener_register(bcontainer, &err)) {
>>>> +        error_report_err(err);
>>>> +        return -1;
>>>> +    }
>>>>       container->cpr.reused = false;
>>>>       QLIST_FOREACH(group, &container->group_list, container_next) {
>>>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>>> +
>>>> +        /* Restore original dma_map function */
>>>> +        vioc->dma_map = vfio_legacy_dma_map;
>>>> +
>>>>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>>               vbasedev->cpr.reused = false;
>>>>           }
>>>> @@ -80,6 +122,7 @@ static const VMStateDescription vfio_container_vmstate = {
>>>>       .name = "vfio-container",
>>>>       .version_id = 0,
>>>>       .minimum_version_id = 0,
>>>> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>>>>       .pre_save = vfio_container_pre_save,
>>>>       .post_load = vfio_container_post_load,
>>>>       .needed = cpr_needed_for_reuse,
>>>> @@ -104,6 +147,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>>>> +    /* During incoming CPR, divert calls to dma_map. */
>>>> +    if (container->cpr.reused) {
>>>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>>> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
>>>
>>> You could backup the previous dma_map() handler in a static variable or,
>>> better, under container->cpr.
>>
>> OK.
>>
>> - Steve
> 


