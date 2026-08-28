Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73249C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzzzd-0000AM-B6; Fri, 28 Aug 2026 13:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzzzb-00009q-T1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:03:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzzzZ-000304-Dj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:03:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDrprI2788429; Fri, 28 Aug 2026 17:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=VpNcEtwWTw3gWtvpA46tqpygY2b66F65c847csna+CQ=; b=
 W503ey4o/UsDmWLaQHpA07RBMvjjOmDlLqUUk5AZepEiGsmJ9JG59bxB94ES5nu/
 kFVDROeHK1Azs6Z9zM+IFPuzpCdPYKxf7gE447pgieGGHIauMucyHANPL2Ktl0lo
 7aZlHUu27HIqpCZpMSbrXkqg2MluR89S0GwhGSSByL1ifc4aVT5QZ/qTsaa3aZUp
 XCYXR6mNr1pEw0oehK6TGMP2aoggDX1JqSaw0Nmljtyz/VWiv6885fr18gdGeEfq
 ZzV2+bSOB8ZXDERHktROXwn4KrIbQromipQY3Zt3IqldHAcKXbI0BuaEXGEbuMFC
 5ijQkeLuVQY/7iLSMOJNkA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72j2299k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 17:03:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67SGtXH8006559; Fri, 28 Aug 2026 17:03:43 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kq1q4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Aug 2026 17:03:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLsYandJcfWBwKDg9FxF/CLqiNX3ifBzIEpWnwnnTQ5MoQFkch8WkFMy/s7FBpNEE90Afb0JXJEBnr6VowA4EJijii/Fs5PH1pwsPY63AZN6d+rct+lXHJktZvMPDmS0DnmPGwas8qUo0dydpWuGAEZ5hGM1GyL+8l3CscU9VGPi/qykFPgSC6bO0xm3pB9t29fEiOnc2CyZZ/T7WwW/MOL7KFik8rq9Ro/LCbToBxHKb5iE8UOSoWUOcQeGBBvagCFbN3R24yUSn9kN2tKgdTttDiD6USnkGPzUE2H9L502kBLJKGhKtsSTyohJWICl4YVxIowWRf3eh1KM+pWEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpNcEtwWTw3gWtvpA46tqpygY2b66F65c847csna+CQ=;
 b=u4l7S92NMusil/Xad/SkOAkX2mCaAgjV2y4uQ6etW6gDaU1f1T+HHZj2p/j4k27KCL9XK0A9V0HqwnCDKK2p5iMr2695fVCEHgwOTtlFBjvrmhMTOT24b+45RUsr8xzvyGac04WwB32EDWSm41X1wWZ4KaiYHxhTdYUrZulsai0jd1RruidQk8ATPe9NpJVV8P6RAeuvp6+NWEf4R0MkKE2QWRsu0m/2TIK3a0wPTSiNlaxi1JtzP4GT+PHEbEypWzFTYGBlzbq7jJVpfE5g/LdAqGaj7WUlyTpzX2+A/lHdTvjk7+TfX0DiyvRXSY7Fbp5AV6WdzQZgjj6qPRMzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpNcEtwWTw3gWtvpA46tqpygY2b66F65c847csna+CQ=;
 b=JKITJGc6N/PRxdzGtQJYzubMQkE3vDG9JYYEjkm1lVoXTLTXrTFFDsiurxKXQ/P+jM6jpCbQZ8aLd8t2J8k6r0dHbSJTVXlecpUe5NcFxXljnhib2/2DtPWMpREOySrP0ZZJ8a4V+xMfRC/Kz4VDm6ykLPaJvDOZMY32kUUwiVE=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by CH0PR10MB4828.namprd10.prod.outlook.com (2603:10b6:610:c8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Fri, 28 Aug
 2026 17:03:39 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 17:03:39 +0000
Message-ID: <41bdc862-2092-4a7d-b0cf-431007e29254@oracle.com>
Date: Fri, 28 Aug 2026 10:03:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] amd_iommu: Bugfix and Cleanup for IO Page Fault
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20260724223216.108667-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:610:58::11) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|CH0PR10MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2f4a78-e59c-460e-3b2e-08df05264e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1M9B5YgBkgmDk5f4oBWrgjIcbejV0giyJRrPJkqAT0alVov7wcc8JRwTdRDfyADW6UTWqMRnyyaREc5cdFb8Y+S6gkHp11Uc4XbQeJQPcWsZcK6+aOJtE2+nkT9sMcCKwcb1H+P32sPJ3Ie4+EpNtlB7CD8avzk/RCt7bymSeKyCoNa7WmnTL6Lol8DNG35FWN6rro9VqxGSZVuDtTzhuSxh9KCRDhgvZ8hxIVH+Cmi693BoEFhGAYFFr3UzJQ8Rw2doDVTEn+emzxwVAjbbESKsBGLVxNJok+ux3P5e6EejhNSJYdWk+I9e35oYqSv/7QnjCEAu2Yo3lzLtwXDrGxsrn0XjIHvS18hJcm3GkpKeQDDBCNSWMYgS7znNXlMFes+0f/5l08LWzsHsjtdbr1oy0TZKiyE0BDXZmQ2GJYonTlxjGKNlBaUgjTOnVaF32B+s1os1YwsM+AqU9OvOSOgPEW+c8Kra4YSNj8wXgxSDviSXvaWxGFs0mWUbViXgQdKfBFktP3fRgJi9WmjqgLJ3A/U4aZYiQ0AxF7E2l5i7o98mD+lwGABzYTdKIdgbIkBEgGVw/Qj4pOtSOSCWfsRT8+zCSA5m07/VM+7oJ/a9jhKHI7LibpK96uvVzDgGEQYTkfAjrNND9/r9HcvcwYbBaIxdWjRC859P6OM//ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZCR0JySHR2ZnBPdWVnSlpxbnFHM28yL1F1MXREdkw4UFkzYlJDWlZwNkw0?=
 =?utf-8?B?SEhBTFlHOEpxMmZhOXc3Y2RDenBMQ0Q1UlFXNlRWeWxnWUl1Tk9vU2pTdG54?=
 =?utf-8?B?Mnk3ZEY0SEpUU09rNVFFWFUybWNPVVJLNHllQ2kvNTJxZzN4VHZwSFZRT3Br?=
 =?utf-8?B?REtaRW10Qlgrbk5sVXp4VkNFMGUyWEx3cWhXK01HMU04aDh5Wlc5S3YybWln?=
 =?utf-8?B?LzBVRUFjNnZ6bzNFUGVFcVVmQ1BHR1J5d3VMNUF3QVgrUkVTbnd1b2ZKWU9l?=
 =?utf-8?B?T25FTlNyWnJBazR2TVdNQ0N6U0NjdWFPRWpVYkFjRWdTMnhqUkI2WWRTK04w?=
 =?utf-8?B?MVd1V3A2RVdLcVlXV3hvRU9HZ21iZHViNlJzd2x4OUViNm5PMHA3cExyZDZB?=
 =?utf-8?B?K2FhTDhSem52MWFMSG5ZYWYvU0lUL2M2Znk0OTU3RDdiWDZpL0J2NVh0dzRh?=
 =?utf-8?B?b0dXSVI0dUF0Qjh0YUZ1M0dyQVErTHliZmtDUURiaUVNOGNiOUlWSzFrcnBw?=
 =?utf-8?B?c0N3TEVYQzZyWHRLaHZRbER3c0lkYmIxbjRVMExETUN3R29STXVlSS9PNlN6?=
 =?utf-8?B?cFpKTEZ6V2JWdE0wK2JjTEFJOWhtbXoyd3VGNnVBbVRRZHk0dzd1L2hPMWRy?=
 =?utf-8?B?S3dsaUcxNytmOFJENmdSZzJUWE4zU1JiQ3dGbGNSM00yNXc3Nkp4V0R5dFJD?=
 =?utf-8?B?ZFlsdCtXV1VpVkl4cEdIcXBnNEpKVXZIMG1WTlFrMWl5djdzWXFZdFhqZXhp?=
 =?utf-8?B?R0NLSkxNQUx2OFRFQU5KVUZ4RVMwYXNyWkk2VkJtYmJhdWtJcDlEOTZhQ0k1?=
 =?utf-8?B?VVpmZ3owUFJqT0ROZmhZL3E2QWQzRjFEWVlZWEFpWnd3aEhhM29uSnArNzN1?=
 =?utf-8?B?cFVRMWJFaHJOcytIVGZ6ZTNURm1PazBOSDNndWJpbWpuOE5IV3p6RHpkdG1P?=
 =?utf-8?B?SlVmc1Z6T2szUzU4V3R3eWFYeDlsWDVsQXF3cXR0WEs0SUI4YTJxTHNlUWJE?=
 =?utf-8?B?NnhnT1k5N1lVSjdiWUhUMkN6dHppT21CcmJ2OTVoMnpRQ0taYlVYL2dlS1BV?=
 =?utf-8?B?dTVKZzFrMEZaRkQyS0YxR3hVQlpGaGFsaklMZWxkMlRGcWJNellRalh4Z1Rh?=
 =?utf-8?B?UENVR3lmdnBHeWc1VnQxWnJFdStsWXhwaGdVNUpxVmpGOHBJeVJFQkRGelFw?=
 =?utf-8?B?UjBkYUZRekNmZjVGQW4vZ0o4MlVCZDJzR1c0RWdNaGt6Y1ExaER1SDFNZUVx?=
 =?utf-8?B?Z3JOUE5qNHY2RGZyNzdLa01FYWFjSGpJcUFMWTJlRTNjbmZockZZUE9JY0hE?=
 =?utf-8?B?bmxvOGlrZzZrR3dBbEVRSTRjZ2JBMURyakhvSEdtTlVkN1c5NDA4OFlpUUlN?=
 =?utf-8?B?WGR0N2xXbzA0VldVSnoranBvMU1TcUhTeVRGRW5KSWJYcWVZb0ppTXZUTXBx?=
 =?utf-8?B?QTMzdFhFTHFGMGpqM0ZiNklIb25YbU5JRm1nLzRHRW9rOUlyTWVFbzFzMTBx?=
 =?utf-8?B?YmI5SFh4THZYS1FrbHczR1FseTZpSWJ1ZDdnOVgyTU9OR2VzTS8vU1dQbmpO?=
 =?utf-8?B?TUVBMXVFKytpUnVMZnlnZVFXblNxNi9QVGRjSUtKaTQ5L1F5ZmQvSGFIMW9Q?=
 =?utf-8?B?aDdPMW56dnBkdTVUNVMzR0VTWFhhbDZEbG5XV1RQNW5VWXUzYS9GQTdSdlpG?=
 =?utf-8?B?UlEzRWk3ajNETXIvaUpCVVhrU0d6OFFzUU5IQjBUM1RUV0FmQllkakJQMnpj?=
 =?utf-8?B?ZVFFVFNuM1FsdldTTEloV0VlZ3BMTWNaaG9EdlEwTmNLY3ZZR0FWaEljYnIx?=
 =?utf-8?B?bDZjbEdHTmZsYTBpb094TmpTYW1WcmFrTjFSdmczWVYyY2FLcGp4MkVZU25u?=
 =?utf-8?B?OHBGWEMyblNXTm8rNHF1SEdybnl6dUNvTGlqT2R2ZGRUTXdkQ1h6NDhGT0FJ?=
 =?utf-8?B?SEtxUkdNTXJ0N3hpclk0MkdicmRTdURjcmI0dFMzUHBmUXhNemZ1dndrODcx?=
 =?utf-8?B?eGdlOWpPMEdjNUJJeEI3dHM1U2NVRGdyUVhJck1rMjl2NTJYVWZDa1NCeUQr?=
 =?utf-8?B?MTZvTWpReUZ3UWtOcUxTcFVYVm5vdDhjRHZVdVcwdHQrZFFBa080d0l6MEVR?=
 =?utf-8?B?aTN3elB1SkkrMFgyYXN6MExqQ0todzJLMWRKNkxBT1FPV0srWnBsSE9SS0t0?=
 =?utf-8?B?a3JJc0FoV25ab3lPbkd5TG5NTlZOalJoSXVkMTBpWVlEbm1JUnlpY01aVXpm?=
 =?utf-8?B?LzNBbmd5Tm9VV1RyRkliN3NNWFdlS3JVbndMYmlSRGZockZmYkovUGdPbU93?=
 =?utf-8?B?MVRpZzBqNE5oZldVSUsrbGZqVVBkb3RXL0hCVTZYWXN4R3A4ZEFOU0lyTWR6?=
 =?utf-8?Q?358VHGZ1nfP6Eu9o=3D?=
X-Exchange-RoutingPolicyChecked: 1Tgl3oSqGuhfuKpQZ8jdIU9T7pYajZY1SP4FdGPbsiSHJhAeOF92t84e9HogqKSBg89UmJF3/SCuIRNq1PFkaUxgbm4RPAGR9h7BETJA9ERJzpDLQQG3sYMkyOdj2H9qXIapUtCvPsywQuPFThu+HfwDuRVb7T7uDYrGDF3SHnRA2X1BpEhprSz8HWLruwBMHStFJMLhVf218KkoVDMwADq3a6GzKomCVQapgWtol0qMIlkF6JfU3xnaPF5nt6AmVsAoEZbm3u0bZ2PY8n/qOOovtqkYVKGcIgnYNAiYa+UQZWLylJwxBn25wdT2JiNAKmmwmTA6gct23ZT6ykkQQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IuClzLQ0QanbrKA0sP0lolRxW761kzghbVdRwcgjj/9FBJp+/ngRb9iBjycLOqIXQQu19DDnN4Ks+tdaZ//vvgrmw2TfYYoC/VJhstxwfqu+CaItb/Jgq4vCmwM4YuXW0yjyGdUn5HuEPJhNr5kpv0GenTZ7Y4C8sNNkm31fb1hDzdQR5+3D8hcr9Ovm/rPbaAwY2Zll4cx+J6Y2YVbfXWuJl2HrFixMb8R79aHYp2cL4b71Qoki7WqN9O8f13MWoDiALH+M8ZJS40sVW6w03S8Zr5IKelChywOcWUy79jIaZ7eb7FWneA2ZzfovdNiOs66I0JrPkCQ6KiC2jaJ8QjQ5HJ+yCtVwj/W2EaYzhwg1XqYSTmcbiloNA4dgQVfru8MIlJwRvt1QzYKyNKd36JUjho5f6GORgypsYtPCtbvtMRaC4UGAo8jz3S4p8OOowIIlNDL8xBk1KZTGRebc5ewnAl8QYmea9IEGzpxGzDXSFKEzsDgAw4SiHeUBVyJYLtKKQQz68TuMZNj/5/IrveqgTD95t0gI6aoHK1SXEyGiB+K/bLn9qT6rutVffbiI5D/28BTf/c2CgzA7dKvcimy30zwNcHyG5dFqUA/WMmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2f4a78-e59c-460e-3b2e-08df05264e77
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:03:39.5002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nj+UVrDpx9SdpOh/P0/i0KOpyLcJnYlaRQSuY98tysK3DQtN7aPItbxfXow/QvV45fwsRkR0SKWmhgb/gRlC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608280147
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE0NyBTYWx0ZWRfXy76u5eRDbzdv
 EnCqJx+mTNEmJCCv8a59BZDBs7NcDfPsHc6WXfDnAdr/juEOurR9cSYdr4vNQqh9wb6bIe/+IMm
 qDga0UEhTnX1Yc0h3RQ2C+tvXAPBvCE+O3T1A/1jZ4UGbDOY+xbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE0NyBTYWx0ZWRfXyJYIlr+98ldb
 gEUGzKiz6QonSIcvq6cSx5eQ0U4EjK3rHfY+T7Dc2Q0WXT5r4zeNC/nf1WxluNRBKqrVRc9ea7m
 VhUswFuykrtoTmCRJ7+7ZOmTOvdOT/6iBqaRXvffACfEm3Gk0s7hudbpkO7Oa1+BdX0IQue8Y/X
 +5WLWKguiRMNoiAPcIYDjaJ5ZBZbqTRprrHAA975F15DL0TjoAe03OORBqsdXmrVGNoUcv4qZdy
 5MK+Bm/zoLsy4zdAA5kkMZ3U9eYtFZfvlLe6c9aIV6XaL2wvFq9cqvO68zZP74Qyw0S0P1D04MQ
 /qAuy+7CoVBrszn5Sblv1mnOIWrPMWdc1TLFomdHXDD+jBERTG8GP6LY/WGRvKqRRvP/8eZ8X2Z
 8Z97oHD9vqIXFGYp7CPHUg+mB0b200sXlP6m8RNhMZ4SFzp7v9Gim3Q8HR8HdZujq7HcAZIZq8H
 II3G+ClgOSLTazLfE+znVGKx8TloJmNdlrVRq1jc=
X-Proofpoint-GUID: vDjrdqwUYjDoi7WqzX9hd04dGxvk7RW8
X-Authority-Analysis: v=2.4 cv=Wek8rUhX c=1 sm=1 tr=0 ts=6a91bf6f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=tRm9sooZgiJuej0s_a4A:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: vDjrdqwUYjDoi7WqzX9hd04dGxvk7RW8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ping?

Thank you very much!

Dongli Zhang

On Fri, Jul 24, 2026 3:31:26PM -0700, Dongli Zhang wrote:
> v1: https://lore.kernel.org/qemu-devel/20260609204403.323149-1-dongli.zhang@oracle.com
> 
> v1->v2:
>   - Add Fixes tag.
>   - Rename amdvi_as_devid() to amdvi_get_as_devid().
>   - Cleanup and add macro to avoid hardcoding.
>   - Make AMD IOMMU extended feature register read-only.
>   - Drop the patch for enabling I/O page fault delivery when xtsup=on.
> 
> Recently, I tried using QEMU IOMMU emulation to study PCI device IOMMU page
> faults.
> 
> It works well with intel-iommu.
> 
> [   28.819456] DMAR: DRHD: handling fault status reg 2
> [   28.820403] DMAR: [DMA Write NO_PASID] Request device [01:00.0] fault addr 0xc0000000 [fault reason 0x05] PTE Write access is not set
> [   28.822325] DMAR: Dump dmar0 table entries for IOVA 0xc0000000
> [   28.823289] DMAR: root entry: 0x00000001014ef001
> [   28.823291] DMAR: context entry: hi 0x0000000000000602, low 0x00000001014ee001
> [   28.825266] DMAR: pte level: 4, pte value: 0x000000010208f403
> [   28.826211] DMAR: pte level: 3, pte value: 0x00000001020c8403
> [   28.827158] DMAR: pte level: 2, pte value: 0x0000000000000000
> [   28.828109] DMAR: page table not present at level 1
> 
> However, there are some issues with amd-iommu. This patchset aims to address
> these issues through bugfixes and cleanup.
> 
> - Fix duplicate MSI capabilities for the IOMMU PCI device.
> - Fix an invalid PCI address reported in I/O page fault events.
> - Fix excessive GA log messages causing endless guest dmesg output.
> 
> The QEMU test patch I used to inject IOMMU IO page faults has been appended to
> the end of this email. To execute "info version" HMP command will be able to
> trigger an IO page fault.
> 
> The following is the QEMU command line. I have tested these changes with both
> 7.1 and v6.4 guest kernels. I have also tested with both xtsup=off and
> xtsup=on.
> 
> qemu-system-x86_64 \
> -machine q35,accel=kvm,kernel-irqchip=split \
> -smp 4 -m 8G \
> -cpu host \
> -hda ol94.qcow2 \
> -device pcie-root-port,io-reserve=0,pref64-reserve=32M,bus=pcie.0,chassis=40,id=pcie-root-port.1,addr=05.00,multifunction=on \
> -device virtio-net-pci,netdev=tapnet,bus=pcie-root-port.1,mq=true,vectors=9,mac=52:54:11:22:14:47,disable-legacy=on,iommu_platform=true,packed=true \
> -netdev tap,id=tapnet,script=qemu-ifup,downscript=no,queues=4,vhost=off \
> -monitor stdio -vnc :18 \
> -device amd-iommu,dma-remap=true,xtsup=off \
> -kernel mainline-linux/arch/x86_64/boot/bzImage \
> -append "root=/dev/sda1 init=/sbin/init text loglevel=7 console=ttyS0 clocksource=tsc iommu=force iommu.passthrough=0 amd_iommu=force_isolation iommu.strict=1"
> 
> 
> Dongli Zhang(5):
>   amd_iommu: Do not create duplicate MSI capability
>   amd_iommu: Use full BDF when reporting page faults
>   amd_iommu: Define MMIO register masks
>   amd_iommu: Make extended feature register read-only
>   amd_iommu: Do not latch unsupported GA log status bits
> 
>  hw/i386/amd_iommu.c | 34 +++++++++++++++++++++-------------
>  hw/i386/amd_iommu.h | 25 +++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 17 deletions(-)
> 
> 
> Here is the QEMU test patch to inject IO page fault.
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 63e2faee99..9de0f302d7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1877,6 +1877,8 @@ err_undo_map:
>      goto done;
>  }
> 
> +bool testsys_debug = false;
> +
>  static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>  {
>      unsigned int i, max;
> @@ -1951,6 +1953,13 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>      do {
>          bool map_ok;
> 
> +        if (testsys_debug && (desc.addr & 0xff000000) == 0xff000000) {
> +            testsys_debug = false;
> +            printf("fault: virtqueue_packed_pop() desc.addr=0x%lx\n", desc.addr);
> +            desc.addr = 0xc0000000;
> +            desc.len = 1;
> +        }
> +
>          if (desc.flags & VRING_DESC_F_WRITE) {
>              map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
>                                          iov + out_num,
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 443b8c785d..c42004d39b 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -114,6 +114,8 @@ void hmp_info_name(Monitor *mon, const QDict *qdict)
>      qapi_free_NameInfo(info);
>  }
> 
> +extern bool testsys_debug;
> +
>  void hmp_info_version(Monitor *mon, const QDict *qdict)
>  {
>      VersionInfo *info;
> @@ -125,6 +127,9 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
>                     info->package);
> 
>      qapi_free_VersionInfo(info);
> +
> +    printf("fault: enable one-time debug\n");
> +    testsys_debug = true;
>  }
> 
>  void hmp_quit(Monitor *mon, const QDict *qdict)
> 
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> 


