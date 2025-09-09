Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E45CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0pZ-0004hc-Bh; Tue, 09 Sep 2025 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw0pQ-0004Uf-6l
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:04:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw0pE-0000UL-Hb
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:04:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Fti4S014136;
 Tue, 9 Sep 2025 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=N4yU+nY6gsYZVZzyX8jVU4atVnRkGkn76rHquTmwRws=; b=
 J15p7ICTuHkIb3+KSQWb9huO0AKmqUuohjsDxH8Zbunj33J5IJGz0pfKRM5RPZmU
 418fzG71nZsl5c7s3KdyHRVhjd+YovVgk6AsPjvBbWFR4mmInn9X2POWTfW9r+vG
 Y/JDD9SDMbD7cCA5fVLsedBdg7oBvVEXn/n6DLXZoT97zJGGap48Y7eQ6nXBWGYX
 SB8RMKsoMCYxT7qdI3/dy8wfr0LqlxMMgdvVgjxCK4vwdlV7Y87ggTpUGAFEiN2u
 WFgKeBdJunHP45XB+edc9hsB9AEMkl6/yLc9Os1pEtN3wgJ/QTbUOHaT6LcJAGJP
 LcqC5GnOOuuqtKJTg6UQ5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226st9qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 16:04:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 589FYLYE026171; Tue, 9 Sep 2025 16:03:58 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 490bd9u8k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 16:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7Gn75kJcawxAFPzil0gxIoG6W486iZSRRs/jZPa8yND+rOyxa+A4UBz998cETY/vS8K3FYTVyONhGGiUr3PCfzGe/t8oHMgWZFcTxZef8+7avg8H8OAAuKYYmD4DpWUFRlk4YPTEmh/7Zbj9h5opuzfxwwvbvKVKtEqHkTo6+1SsgTDkPZWlzoQnip+A5vrZQiBsIlv/lrbCAYbyAAWzMTeOMkEZoZ9vUT+wInz6FA3DTAdYLKNcRV/gNT8AHCyNnMI55dNvrNCjWfQHe5BypJttT6BDHdMYIL366N03O6UvhunTNHzLAp8THT84IiaG4gk1lLdqf77iriL4LlP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4yU+nY6gsYZVZzyX8jVU4atVnRkGkn76rHquTmwRws=;
 b=KrVBCYbm63GvrnFQx6qlJuFRbI2o8+wK6PZnFDgVIFAYAUkhhGj4z9MOZ0v6AC/3axjPah4tKU7aRmAI13nd0v+K4YJ4e8kMED7GbE+9wVay8MxaRkCDBgVP6iSiUoAYrHBMVkCdhKpLlYxcG6OTeAD9hWBgZoY0FT46urtZ0yP2URbxTjOlqih2s22KuIfMflGrBcqTokubnEEyobXAcFR2Dq30NnNh6A9LTguzjFQULbwyaOMT2l8rkRz6sA3Cylurmk6/dcRc5yyFU22C2hExsc+NHeRg4vJwgGH1xLu5h7ckDUFNuSW2T58eaqKTkIBQivk8exANBshMVmjvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4yU+nY6gsYZVZzyX8jVU4atVnRkGkn76rHquTmwRws=;
 b=CswqOUUEuNRZ6tWqFHPpbOXjOdzN5cZDbvi9w11G1oKBCJNtjjjOJE/BIeTRzO/FvCWEryUKtBLdB3YMy6Qdk0bO2grU8ZrthUFeMMCqtZbXcD65KqbxMg5X3AbhrcHL7itqzHv6NU2AQXcSG7Ui930Uk6wiRnAAKAC0IkimGmA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 16:03:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 16:03:15 +0000
Message-ID: <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
Date: Tue, 9 Sep 2025 12:03:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local> <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMBGnHXieiXpBCqF@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: e93ef29c-64f5-4f2f-9fd3-08ddefba62c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2VPeExLWjBPOE9pRHRFYjVFVVRKWlRJaGRPOTJoTmIzZG1tSkpsZkFTWi9V?=
 =?utf-8?B?RGVBUVM2RU15d2pHeklIY0J3TGQrdmdBQmkzU1lESGlXS09sdFBTbEJTRVVT?=
 =?utf-8?B?elFlWjdiTHYzOC9nRlI5MmZlKzZHVFZsQ2FFNXF6NnU3dGtGOTBoOE5NRHJY?=
 =?utf-8?B?M0RqVG9RaVZ1bU1nalZKM2NJN2Q2UHF5ODh5Q3dmbTdyR3pINW1vYjBRVUxi?=
 =?utf-8?B?d1BrYTJJSTA5NFk0dEdBS3ZuVG9YbXRsWDNXZG9pVlp5UCt0aHBlMi8wenhw?=
 =?utf-8?B?NDc4QkVBMC9hQUkybUpNVENzbmJGL3F1N3J1ekZzd2JKOENwbGJCcStYclFp?=
 =?utf-8?B?dnJib2hEM21HeXBwbkplbmJ1bnN2SHBrOHBwTzFqdVBIdlV3ZGIzM0U2V0RF?=
 =?utf-8?B?Zk1Id1lRdU5FTXVIenlaakhhM045ZXlMM29IeW5teGs1dERsUGdrR2U0NUJ2?=
 =?utf-8?B?ditmY1JzMVhUU3BZTVljWGE3V09icXlVa2d4WmxZN0FSMzd5dTgySnVVWXQ3?=
 =?utf-8?B?SVA5SjcwWnZvTWJvZnE3QkF2TW05bG1BOHROcHBSQjNiNjQ0c21NQkxUT0hp?=
 =?utf-8?B?WWI4RG43TUYvSlNUaHFVcXFlNDh2a0hRRmRWN00ydzRsLytBbUw4Z3Bvby9C?=
 =?utf-8?B?QndydHIwZkFiY0MzUmM1Vlc2OWNwa0hDRHBIOVpjUHZrSTRIRUlkUFdVN0hR?=
 =?utf-8?B?c1NqQWN0aWJZdy9aVVpQend0dnhVNEdheWlGVXgzSUNFVUVuUmxhOUNQc2d6?=
 =?utf-8?B?QUNYY09ZZVNkWlFldXVLQzA3S3BKSzJtVW4vVk9PYnBkNTY0K0Y0NlZNUDRP?=
 =?utf-8?B?Z3lXRkI5c1oyVXVhOUNRME10U0xvbTArVGg2cC8wMUhrSWhUWEcycldOMk9U?=
 =?utf-8?B?ZVpuQm5YTy9hSlNiREVBQ3VXb0MyWUlHa2JDNXFqTmZwSU1pN2NYOVF5VkNu?=
 =?utf-8?B?cDBhcWFheTlUdkZpK3lQSlYxRXRDcFpySmtpM3Y1dEhXTm40SEdkVVcyL3JZ?=
 =?utf-8?B?Qmk0REdJYmNtOFN5R093b0RmeFlQeGtQMUhLa24wNGdYYTBGUk1PWnlxVk5S?=
 =?utf-8?B?bmVnVHpKVjM0SXF4a01EUTZzcTZvWlBIN3JNcCtlMnJCWVptWllBTVBGNlFV?=
 =?utf-8?B?RkVOZjRQU2V0OEpXNVU4ZE5mdlR6R2FrRmZoVXZtLy9icnhKbkhJUU9NbkVm?=
 =?utf-8?B?RE5HamxhY282SkJQQ2w5UDJxRDYxdWhVV0h0VFpSQ0sxaC9pRzR1NGhBUzh2?=
 =?utf-8?B?U2svL2xOYTBFSmp5VFhoSnlBOVBnS0pKaENkTmV5Z3ZGTHZpb1hwODVqNXA4?=
 =?utf-8?B?NFVoWUU0Vml1OW8yWmljclA1K2JLR3RYYXRLcTZNS1EwMnlJakxwNEVjS2VB?=
 =?utf-8?B?QmdmN2hoVGZFY2VBVFA5ZjhMcU9xa21yZ0Jyb1NidTZUaGZEOGZLUEV3Zkw4?=
 =?utf-8?B?QlN4ZkhMMWoxRnk2cXd4SU16b1BQbjhrd2FaV3ZtNUtyOHQ1MnM3Z3FKMlM0?=
 =?utf-8?B?QUxpeSt2N0p2b2lwQ1Fqb28yQU5HUzZ3Z24xdWhIUzNZS1o0SFlXZDM4R1hl?=
 =?utf-8?B?SHF5dTU2TFVrcWF4UTRNV3pMcC91NkQyYVM1TjBsNGVsRWE3S1FoTGNNQnRr?=
 =?utf-8?B?ajN6WU54Uy9VRmxadVEwZUQvM2dZQWp6NkhBMHZNVW96M25rUzBvY0FycHcx?=
 =?utf-8?B?dDlBRkFXM1dIeDlkN3V5Z1FHMnMyand0ZjVVbHFCTHFmaEYzZE9QNTMydDl0?=
 =?utf-8?B?V2pYeFlTT2xCTzJlZVFSMkw4T0pYNFJ5ZU1vQXIzVWJWZ1Rtdk5GUjd1cDNI?=
 =?utf-8?B?dTY5QkN4aFhWU2NhSE4xSlRZaU91cGFvZlVaYmdiWmZ2eDBmaUJOa20rOEwy?=
 =?utf-8?B?R3lEMnlncXNQeXMvN0FHWUc2TmdEbHpwK3JYOGlHSm9pMlNCdEF2VnBxaGpa?=
 =?utf-8?Q?BE5S00RoGyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L00yTE8xNmZPV1BhRFp0Yi96bUwrdHdJMURram56QjJpQ0piYWVDNVVLSlh1?=
 =?utf-8?B?eDd3ZGd3KzVDSVBJZlVYaGwxNXUyL0JMRzE5Y21ub3RMNXN6eXBtK3d6OGlh?=
 =?utf-8?B?V1RuRlRaMDBNK1dMUlFwTWNoL2ROdEIxaUNpZSt4MUM4NVhZNTJEWkNvWFFV?=
 =?utf-8?B?Ly95RWhqOUdtaDB0ZVo1TnFGTGphUmlsRVl2TGZtU1YySDlPK0J2dThXaTB3?=
 =?utf-8?B?Ritqb0RsdTJpTUt1S0ZOUlNTOVV5NE9XRjN3VzZLZVFCdURnY011Z0hxMU95?=
 =?utf-8?B?OUZtU1pTdEc5TnNpT2p2anhVRmdZT3NLdzhMMVVZZWs5YmlWZ0xBT255bnM0?=
 =?utf-8?B?S1QyY1dlTXprWGxuNnFZVU5UdEtycXFYSXRodmVUK1ZweEYwUERLbkpwVjhC?=
 =?utf-8?B?enBuTXdzdDdRMFVJT1VSK2twcVFZSW5KUTBncThGN2djR3hiR2JpOWsxSzlE?=
 =?utf-8?B?Mzd3YmRKK1VLSWZiWEtyOEE2a2YyNDVEbE80VVhnNkZkNkNQWUlQdjRFc3Fj?=
 =?utf-8?B?Um9CTnRRUEF2Rkl5cXZlUEFXenZEWlBLUWRNdGZGMmxRdEhhVTB1TVNraFhp?=
 =?utf-8?B?MmFyczZKZkFlN1o5MXZjY2RQVHJIMU11VGVTYVdYSjd1YVpsc0ppRHBCbFc0?=
 =?utf-8?B?akgrSnNtc3BSZzg5Qjl1WFphc29tMTd0dzg1YTl1c2hZVmFhUlhYSjBucHRZ?=
 =?utf-8?B?TWdvU1RCQVNTZFBFM09qL25LQVhSSGxTcDU5bDQ1RjF0S3BPUFRhNXVKb2dT?=
 =?utf-8?B?K3AzRHg5UzN5aTQxVTJ6dENMbXByRWltYVhBanpvaTdlMk03ajZ2T2VnWDJM?=
 =?utf-8?B?VGp3TGN5M1F1dHB5MVdmSldMcVJ5YzB4K1JQZVdrWExra1NPUVdlbFdjNThv?=
 =?utf-8?B?aDdkUHZOVlhUWkw0SHNtUXJqd05uYkxHNld5V2RxbWV3KzFvcS8yTmpmZ0Ir?=
 =?utf-8?B?K2RvYnRoRCtVMnFQak5UWU5jOG5NRlpzb2RTRHIwN2lmMllNcWxBUCtUOS85?=
 =?utf-8?B?QlBPazMxekllNmJqZUZ0RExoR1VUNW15RVdPdU5WV21oSm9xYzdWbGJqL0Ex?=
 =?utf-8?B?WGQxZHo3aEtab1NIeWdSOFZtbHVpdUZCdTVIa2dvQ043MlBSeHNxS3pNcC9R?=
 =?utf-8?B?Vzl6RllDWTBZNUk2U09mVFJ6RHVFdlYzNDlLS2VYLy9WK2tMb0hXOExpOEdJ?=
 =?utf-8?B?SjBkRmgxSHBCMTc2TTFlS2pKeXI5cHJzUHJ5b1BmdWc2UzA1OVE3VVVoYUhw?=
 =?utf-8?B?UW8yS0czbjFPNzRIS3BkV1IwY0NReVY5Vk9UMzBQaU5XZk41TkRUbE9KbDBU?=
 =?utf-8?B?UTVHZUFQZUxCVEV5ZGJ5SUQxQlFHQjdYQ2dmQm9HNDhvK0NzVEtHYjNKcTV2?=
 =?utf-8?B?MkFaUmtrcVU3TTkxSnU1bytRblhsUEI2OFUvQnV3U3JJT2Ftc1lCMkxpTEdk?=
 =?utf-8?B?b0dNbGpaRjBwbDhJSm5oaktHcWNHU3ZRNUhlaHJBekx6QlNYRGtxRnNsNHZS?=
 =?utf-8?B?NnNja2FhcWxmNHU2eVN6MlJZdldpbmlWeWtiUDNzMFJMZ0puZW53bHN2Ky9W?=
 =?utf-8?B?bW1uZmhQRlhjaFR5dlhXUHFoeXBoVEdzODVFR0s1SW4yOWpPZmZ6M3Q0TjFD?=
 =?utf-8?B?MkZHYmtjRERBdm1abTdkOENlaXh4UWdmMjllRC9CcTAxaWtVTDYvT2hvUzhW?=
 =?utf-8?B?WkcvdVlwUFRrNDlka1hFMjRsSUZpREppWHQ4UWNUY1NOV01PZlE5eDU2TlNH?=
 =?utf-8?B?T2FSYnF1MldmN1pSN0h4elFSS0hvQis5OG1oS0dwbmQ0K01Lb2hWTTBXUkNh?=
 =?utf-8?B?N0IxVGlaRm5NaFZZTXY0dG5ld1g3d1ZabWFjOW9zN1Zla2FpTVdENzhtemI5?=
 =?utf-8?B?V3NTL0tEejNsWk5uWXVFSHZSVy9YK1pEM2JXU3NXVTY2djBxL2l0M2FJSjIw?=
 =?utf-8?B?cjQxR3NxeXQxcE5PSS9sT3pEazhBNDNJOEZvNkg5TnN4Z2MzN2R3cEhhMHlB?=
 =?utf-8?B?RGVZM05tRVlodVpQVHREWkZqeEwwNVBETkFqc3lkTm1DMzkxYjZDZExybVpj?=
 =?utf-8?B?TUg5QllXcmc2bW1HVWc5K2dQWDNxREI2a1lNNWtOWGdrb2t0WWtXc1hTZVMz?=
 =?utf-8?B?cGJnbWxWeW56M1FiU0tmQzV3UXZxT0JzZlh2MzBRVjNNelB6blBiQlRhenVV?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6iiF8ks6WtajOYDwueg07DAjs8CuNr0/zC5VFikJ/DKPLa+8XUGdVeCbvzcphaG8GM8lm3aD0oIJQQST1/QmnOjUJFpJhIQ4l302QWflhW7V/8F87TjHLyt35nWYMf6ms5lFklTGFvF0aCn2YTLVEZluyqPB32R6S7CE4JwApyYy7iv0YyE4SO1Z6msg3eVcINWGU3MF+eJ0f4ORS0yh8+SAyRQPF94zIi+GBchvKpx0m+iaUSGG8m441rOzOaCWnDu0GUFtSZQvClfrWS80azddu01wOcxKeyqKEs7/+OBij8zidvz+3uklW4zGbbePTzxc+6nHT+dxE9lKVclBm4657iIGfnAU7tioziBQiYORr/G0PFXXEV2HPE9KX3MKWDgz4DoWuxnRXCqZARHs1YXYfnPCgjbjmWNLj0N+yC2feQ8iwgZnVaTHT8D2QXjZtHfUb7s6/fa5ryfbIWlk9RfFJk290X9UU3v7+nfixz6JQuDVsy7MR2cBSz82/PnMYlePqmBM/3Uam3ejd/DL+pBSL4YymSoItmdvvxv5NAs1Z/SDZ0wkDXLzvhrydslNsmO0myiSShSpaZsABB78bYiE6vEiLJ1Oo58jkiJftTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93ef29c-64f5-4f2f-9fd3-08ddefba62c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:03:15.8867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRxPDhUwjcaiV0a/YJmrjSmCAM2GcHk66vJEOjmrXmYB4mqcXMkpY9VFx+3XMgcgcbIsFN6I7EJZx1mSfbflxWMrEKfXh3xP6gjAx4J58bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090159
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c04ff1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=EYPNbkTCRidsZzW4-xsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: l_hS2RhP5tNp8Vom93rvqxMSeCHVn4TL
X-Proofpoint-GUID: l_hS2RhP5tNp8Vom93rvqxMSeCHVn4TL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX2lDl2D89kjjm
 W3SuZF2wIA7AFno0ekyivkhqhyMZXqrs4nzJS7nM8sjwFE+AqFS8Gl1CODlzItvi2oZMzt6a9EO
 IhywFlcnolni8fuG/OAuFhDvxR/NVOKfxLkIdfzypq1/r6Z0/n4PmXNJL50wOV8RTHu4ej5tEk+
 BPeXUJZJkgTbBWKQNUFKJQMNbKYiY4n2obF16ocqrGm58Gut3vrSfIEWt7IewN7NCv8GZj7dack
 ww6TbtBSGchX6RQxJTZXbET3dZr6fAyNB2X8lYIBqwU0E8/H+pd/gf5drrdIyBn4KRsjkm+ihzU
 PbvAaoKGfKC24Z8AYj4oPYsOoCDhNC10cMX5nhcWXoU5NBZFsN0I5nfj7J0C6NhkGYOIJl0aSCI
 D63TRqeFRuMJJhcHpm1RJpU49y+dKQ==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/9/2025 11:24 AM, Peter Xu wrote:
> On Tue, Sep 09, 2025 at 10:36:16AM -0400, Steven Sistare wrote:
>> On 9/5/2025 12:48 PM, Peter Xu wrote:
>>> Add Vladimir and Dan.
>>>
>>> On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
>>>> This patch series adds the live migration cpr-exec mode.
>>>>
>>>> The new user-visible interfaces are:
>>>>     * cpr-exec (MigMode migration parameter)
>>>>     * cpr-exec-command (migration parameter)
>>>>
>>>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>>>> primary difference being that old QEMU directly exec's new QEMU.  The user
>>>> specifies the command to exec new QEMU in the migration parameter
>>>> cpr-exec-command.
>>>>
>>>> Why?
>>>>
>>>> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
>>>> container and its assigned resources.  By contrast, cpr-transfer mode
>>>> requires a new container to be created on the same host as the target of
>>>> the CPR operation.  Resources must be reserved for the new container, while
>>>> the old container still reserves resources until the operation completes.
>>>> Avoiding over commitment requires extra work in the management layer.
>>>
>>> Can we spell out what are these resources?
>>>
>>> CPR definitely relies on completely shared memory.  That's already not a
>>> concern.
>>>
>>> CPR resolves resources that are bound to devices like VFIO by passing over
>>> FDs, these are not over commited either.
>>>
>>> Is it accounting QEMU/KVM process overhead?  That would really be trivial,
>>> IMHO, but maybe something else?
>>
>> Accounting is one issue, and it is not trivial.  Another is arranging exclusive
>> use of a set of CPUs, the same set for the old and new container, concurrently.
>> Another is avoiding namespace conflicts, the kind that make localhost migration
>> difficult.
>>
>>>> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
>>>> is that the container may include agents with their own connections to the
>>>> outside world, and such connections remain intact if the container is reused.
>>>
>>> We discussed about this one.  Personally I still cannot understand why this
>>> is a concern if the agents can be trivially started as a new instance.  But
>>> I admit I may not know the whole picture.  To me, the above point is more
>>> persuasive, but I'll need to understand which part that is over-commited
>>> that can be a problem.
>>
>> Agents can be restarted, but that would sever the connection to the outside
>> world.  With cpr-transfer or any local migration, you would need agents
>> outside of old and new containers that persist.
>>
>> With cpr-exec, connections can be preserved without requiring the end user
>> to reconnect, and can be done trivially, by preserving chardevs.  With that
>> support in qemu, the management layer does nothing extra to preserve them.
>> chardev support is not part of this series but is part of my vision,
>> and makes exec mode even more compelling.
>>
>> Management layers have a lot of code and complexity to manage live migration,
>> resources, and connections.  It requires modification to support cpr-transfer.
>> All that can be bypassed with exec mode.  Less complexity, less maintainance,
>> and  fewer points of failure.  I know this because I implemented exec mode in
>> OCI at Oracle, and we use it in production.
> 
> I wonders how this part works in Vladimir's use case.
> 
>>> After all, cloud hosts should preserve some extra memory anyway to make
>>> sure dynamic resources allocations all the time (e.g., when live migration
>>> starts, KVM pgtables can drastically increase if huge pages are enabled,
>>> for PAGE_SIZE trackings), I assumed the over-commit portion should be less
>>> that those.. and when it's also temporary (src QEMU will release all
>>> resources after live upgrade) then it looks manageable. >>
>>>> How?
>>>>
>>>> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
>>>> and by sending the unique name and value of each descriptor to new QEMU
>>>> via CPR state.
>>>>
>>>> CPR state cannot be sent over the normal migration channel, because devices
>>>> and backends are created prior to reading the channel, so this mode sends
>>>> CPR state over a second migration channel that is not visible to the user.
>>>> New QEMU reads the second channel prior to creating devices or backends.
>>>>
>>>> The exec itself is trivial.  After writing to the migration channels, the
>>>> migration code calls a new main-loop hook to perform the exec.
>>>>
>>>> Example:
>>>>
>>>> In this example, we simply restart the same version of QEMU, but in
>>>> a real scenario one would use a new QEMU binary path in cpr-exec-command.
>>>>
>>>>     # qemu-kvm -monitor stdio
>>>>     -object memory-backend-memfd,id=ram0,size=1G
>>>>     -machine memory-backend=ram0 -machine aux-ram-share=on ...
>>>>
>>>>     QEMU 10.1.50 monitor - type 'help' for more information
>>>>     (qemu) info status
>>>>     VM status: running
>>>>     (qemu) migrate_set_parameter mode cpr-exec
>>>>     (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
>>>>     (qemu) migrate -d file:vm.state
>>>>     (qemu) QEMU 10.1.50 monitor - type 'help' for more information
>>>>     (qemu) info status
>>>>     VM status: running
>>>>
>>>> Steve Sistare (9):
>>>>     migration: multi-mode notifier
>>>>     migration: add cpr_walk_fd
>>>>     oslib: qemu_clear_cloexec
>>>>     vl: helper to request exec
>>>>     migration: cpr-exec-command parameter
>>>>     migration: cpr-exec save and load
>>>>     migration: cpr-exec mode
>>>>     migration: cpr-exec docs
>>>>     vfio: cpr-exec mode
>>>
>>> The other thing is, as Vladimir is working on (looks like) a cleaner way of
>>> passing FDs fully relying on unix sockets, I want to understand better on
>>> the relationships of his work and the exec model.
>>
>> His work is based on my work -- the ability to embed a file descriptor in a
>> migration stream with a VMSTATE_FD declaration -- so it is compatible.
>>
>> The cpr-exec series preserves VMSTATE_FD across exec by remembering the fd
>> integer and embedding that in the data stream.  See the changes in vmstate-types.c
>> in [PATCH V3 7/9] migration: cpr-exec mode.
>>
>> Thus cpr-exec will still preserve tap devices via Vladimir's code.
>>> I still personally think we should always stick with unix sockets, but I'm
>>> open to be convinced on above limitations.  If exec is better than
>>> cpr-transfer in any way, the hope is more people can and should adopt it.
>>
>> Various people and companies have expressed interest in CPR and want to explore
>> cpr-exec.  Vladimir was one, he chose transfer instead, and that is fine, but
>> give people the option.  And Oracle continues to use cpr-exec mode.
> 
> How does cpr-exec guarantees everything will go smoothly with no failure
> after the exec?  Essentially, this is Vladimir's question 1.  

Live migration can fail if dirty memory copy does not converge.  CPR does not.
cpr-transfer can fail if it fails to create a new container.  cpr-exec cannot.
cpr-transfer can fail to allocate resources.  cpr-exec needs less.

cpr-exec failure is almost always due to a QEMU bug.  For example, a new feature
has been added to new QEMU, and is *not* forced to false in a compatibility entry
for the old machine model. We do our best to find and fix those before going into
production. In production, the success rate is high. That is one reason I like the
mode so much.

> Feel free to
> answer there, because there's also question 2 (which we used to cover some
> but maybe not as much).

Question 2 is about minimizing downtime by starting new QEMU while old QEMU
is still running.  That is true, but the savings are small.
> The other thing I don't remember if we discussed, on how cpr-exec manages
> device hotplugs. Say, what happens if there are devices hot plugged (via
> QMP) then cpr-exec migration happens?One method: start new qemu with the original command-line arguments plus -S, then
mgmt re-sends the hot plug commands to the qemu monitor.  Same as for live
migration.
> Does cpr-exec cmdline needs to convert all QMP hot-plugged devices into
> cmdlines and append them?  
That also works, and is a technique I have used to reduce guest pause time.

> How to guarantee src/dst device topology match
> exactly the same with the new cmdline?

That is up to the mgmt layer, to know how QEMU was originally started, and
what has been hot plugged afterwards.  The fast qom-list-get command that
I recently added can help here.

- Steve
>> There is no downside to supporting cpr-exec mode.  It is astonishing how much
>> code is shared by the cpr-transfer and cpr-exec modes.  Most of the code in
>> this series is factored into specific cpr-exec files and functions, code that
>> will never run for any other reason.  There are very few conditionals in common
>> code that do something different for exec mode.
>>> We also have no answer yet on how cpr-exec can resolve container world with
>>> seccomp forbidding exec.  I guess that's a no-go.  It's definitely a
>>> downside instead.  Better mention that in the cover letter.
>> The key is limiting the contents of the container, so exec only has a limited
>> and known safe set of things to target.  I'll add that to the cover letter.
> 
> Thanks.

