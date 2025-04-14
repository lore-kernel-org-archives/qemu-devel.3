Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B978C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4QOL-0007CH-12; Mon, 14 Apr 2025 16:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u4QOC-0007AK-CZ
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 16:26:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u4QO8-0005rj-Ll
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 16:26:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EJ75oC028598;
 Mon, 14 Apr 2025 20:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Qa7OtwOD0CRhZg+LHNaAFsRk2NEp3bmP61iQxSGegcQ=; b=
 OkP0puwjLPJYHDRn7bul/54T/8jU7kZ5rcNPJAUBQI0ZqYcYYPabQTajizmD17rk
 hbAf4ulXnuodEFMTKMpi+DFdqqFnS5pYFDtgnRJei7Rel/mdoto+qCvyf4ClIXLN
 s+ZZHL9FU6MQK5ecgcw7AbPJPSlYiqF6hsMaCbozh7OUrtG5wYECRtf7dWYEt8NW
 9btdceTrwUWaB5P+b81ADI6VFMd5Sh4GsYDQh99j8O7wtDYjEgDBqMDKi4CmJ/Co
 Yzo6B38AVXnrCkpO21VKLLrVIP9TMW/4ynj9sYo1qTr+PbcCaLuSSj5glkTpcjfe
 yCvxSf9tbMQPSGf/jixMZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xr4km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 20:26:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53EJoinD005650; Mon, 14 Apr 2025 20:26:35 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d5u8p3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 20:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv3Dd4+vsoiwrbOp2b2VAbfHKaynlIAqi8jF4SDyywTHnhYPhd339dZh3AwUgNMVlAFwh2wa4mr2Gr1CFxURUTMzPNZVLMTvTGLH0LYd9BgNeTBScK2gwHI0bxLf/yWCBENNVZ11duZXUAqJLgAoEGyODM9xvkxwhuwrqKdGI39Mf2Fw1w9vKtcmjgTcCgeuB3oDW54tEVGP3SsmB7oL21y69uq8fUqpQEdUWOfP1WK69Zm4LSBMveZCAdQsK12iupafoi3fMEXug9lUzx2ZNOUklltWkacfNeMIc1UjFAso4binxRnjtk6d/QLKWZP6V39a4bEbV2Q/MQ9jfMhmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa7OtwOD0CRhZg+LHNaAFsRk2NEp3bmP61iQxSGegcQ=;
 b=DWS7dCIMXSfO0w8kUzYHrO7l4+nbemRFqICKYfhjqR/zQRQEWlfmncx82j99OmW0B3H2/NpgDxhpbrKvnFwhjWRbyw4VB0/8NSz2CG2BW33NohpRVhfqqU6m4RcP7DQM2xT53H+E61zxTLAQ2KRPnofv9YDB95qObVT6KmM1a7fAi3BinMvKiGnZ0ODue0O3fazgFBnxnT7DuWprFRYDqY0/sG8Q6nMhfbxJ0qtpra9hW6xF0apzQHy0Bx3c182oEdpDPr1AG3QqSbb35Y+h00xCbolA0Ehf1SlsSMNtTLSDuL3UqxV/VMBspQkDf2xxp5VTzhNTfgvx/8mmkZa46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa7OtwOD0CRhZg+LHNaAFsRk2NEp3bmP61iQxSGegcQ=;
 b=w2lfhAhwY9VTMybQtQ047pjXa1ybV9Ecy6kwJLPhnTPRIQkrC/qFyfdruHLaEw/0ih14pnwykXOjDAn+5Uo2WLUi5fUsGkZKr1IZhHiXFyhmX96OfIg0GmAxXYSjNj+9eK3brHfqiW12YcjKS7ABVqX6TwOs9PCN2BBTGr4LEdI=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS0PR10MB8125.namprd10.prod.outlook.com (2603:10b6:8:1f6::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Mon, 14 Apr 2025 20:26:33 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 20:26:33 +0000
Message-ID: <914314b3-611d-4da3-9050-3c8c1b881e40@oracle.com>
Date: Mon, 14 Apr 2025 16:26:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix device setup failure when PT
 is on.
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: suravee.suthikulpanit@amd.com, joao.m.martins@oracle.com,
 philmd@linaro.org, vasant.hegde@amd.com
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-2-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250410064447.29583-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS0PR10MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 899c072f-4831-4684-7c35-08dd7b92a58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmdTUU00WWc3NHRNVEJEcStDdU5TdVVCRkI5OG13MWhxVVp1ZncyMmJYOXRX?=
 =?utf-8?B?QWdvUy9LcmdzVmRGVm5yc3VVTTY1UHJZSmNqV1RPRWZtVHZEQWowZHF0Rkdj?=
 =?utf-8?B?Z2cxT0NPQXFSTXQrUHJYd3dRRC96TTFRMk1XWHp1VDAwL0ptd3lBRGlUbXdn?=
 =?utf-8?B?Y2lKMitrZndTUWxSajJpcWU2WHVndWRiTmIwUnVuY3dFYmwxYzBjWGNDRUti?=
 =?utf-8?B?UEZsUTR5WmVwZjhKVVZaWEZ6TkJIbmc1ZXlkWlNFU0huTDU1S3dWK0lYNkZj?=
 =?utf-8?B?ZWtEVkZRa1o3cy9oczY4c0F1aWlwa1FJQjRQRHZZL0JqaEs2OVR3NTVCMEpN?=
 =?utf-8?B?ajNrbnhCVlNOM1pHSXFIMXM5WnFjU3NidDlwMTlYZ1J6RVR6dGh3dEcyQ2JL?=
 =?utf-8?B?ckk3T25GZTVLZENVYmRrblUrM1B5NjQrTXd1cWNKUW03SzFEWkpQVlZTNFVh?=
 =?utf-8?B?Wks0QVg3ME1OTSs0cGlPWTUreTBYL015SC9wRlFZblBrRmljOGVRdWw4ZUZn?=
 =?utf-8?B?WGFpREVCdzVZYkdEZ3FDN3YxTjY2UkV1QjQyTldJU3A1MUpDeWMzOGs4SHJH?=
 =?utf-8?B?TFJNaUM2SExqVjlGTXQ3UlRlTC9RU1cxbzB0Z2hkSmdGTTBISW8zaWNLZEhp?=
 =?utf-8?B?Q1hjelVoOFdwd1dhRDMyNnRhUVZMWFFjT3JtckQ4Ykdxalk5VjNyVCtIY2dy?=
 =?utf-8?B?N2Zrdlk2VU1Yby9aZEYxMHlOamhiUVFxQkFaWFk2NUdOdnViOEg3K0RtMXk3?=
 =?utf-8?B?RDF4RmM3amtMclZVS2tObDc3dEMwYnJnbHFPS2NXSlU0T01ZVVcxOU0xWnRP?=
 =?utf-8?B?aFAxRXRpN0RiK3Jxc1BKM0NudnpjZmVYZk9OT28za2J1UnphZHArSGdvVC9K?=
 =?utf-8?B?UitIRmZMQnNvK0M0dTR0c1czY1JBK3gxaXp2RnhuNmwwREEreDJ3b1hwazE1?=
 =?utf-8?B?M3RIWVJDNm1qNUxNWmMrTTNDeUxzeDBXcTVHdzFDaHgrY1VrZm1XUnR5aTln?=
 =?utf-8?B?M3dTV2Rvb1BNRlhpRTdXVFlYa1FFMDUxTjYydWU1WUFOOFpuV3VMRWVzcEZr?=
 =?utf-8?B?QjZSQklEZnBsUGFjS24wa1QwNXgvbHF5L0tBRDJpT1BIV1ZNNVA4clVFZW5a?=
 =?utf-8?B?UGZRVjN6UUMwUFBndHUyR21oakl4WlByYjV3QzB5S3N6c2tzcTFVWnZ6b0cy?=
 =?utf-8?B?ZUJrSEVqVThqbTlFa0hhMDZLempua0hlUVVWei9GclBiTUVwd3hWL1RpekE3?=
 =?utf-8?B?Y0hIZ3ZJMERjVEpNRVdWMTh5ZjZHWXNablpzamlkSjhCa2lLM1dGcVhyYTQ5?=
 =?utf-8?B?b3h2djY5M1c4RG4wczEwdEhRK1pJTVVrcFJDc0c1ZWlXSHNwa0R5N0J2c29O?=
 =?utf-8?B?UEV6TUFDT0xWb04vdm5JUzlaUFJYRk9JSjJnSkF4dk9pU3A2eElpYmNlcDRL?=
 =?utf-8?B?WkYveFF3ZzZFMDdyNVhjdjR0QU5GcVhiQ0N2bWtMbmdodWRnR2ZtMnMxOXd6?=
 =?utf-8?B?STJjMkpDM295Z3RYRTlqYnhaZEhPeXRqbzZ2Zlptb1R3OTM5LzEvQnhsZHdj?=
 =?utf-8?B?NzNCR3IvL2JNWGxWTnVoWnMycmNRTlowK1BtL2thaXJoMFpjM3c1QmlMOEJh?=
 =?utf-8?B?VnFpYjVxeHozeWRRb3hITHVjMVZyT2JYS2E5d3FkMTJaeklTaGxkb0grMDhi?=
 =?utf-8?B?SlYxcElpUkhFK1FjQ2RyOVhqUS9rRm5WL2NKTFJpeGV0MXNnU1lPbGw4cEtE?=
 =?utf-8?B?aWNUNmw4N3NvcDN6UUcxeUJVRUdGMVBWY1YyN01YUjIybFZseFZRZ3JHcC9s?=
 =?utf-8?B?eGlvKzgzMTk1NERCMmxqWU1pUlNaYzdxSUhHOGpKRnhiOGphRU5OSUVhN21X?=
 =?utf-8?B?UFhCako2cUhKNmg5RGx1MC9ZVkpDQk9RSmlqOHNXTlVtc3grY0o3end4WXZY?=
 =?utf-8?Q?sXcWQtHuxVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBoeUFpQ1FwYmpWQVFaWVI5d1N3RWljbWtKaHh1L2lEaTNkMUl5VXZGcGNw?=
 =?utf-8?B?VEtCTTdlSWxaOWZGRmhWaVhtYTdjWXBWZDB2VUtXeTNwdFEvN0VQTTQycGMw?=
 =?utf-8?B?UnRlSXNBSzFEQkViM002ZzhRSkY5TCttaDRHeUNUbitFMkFwOGhveWNvbkhL?=
 =?utf-8?B?SkUyWUh3d3lCbHhydTVkczlPQm1QTW1uYnluTW1ZZ0xHNHdVSHd0SVZQSk9N?=
 =?utf-8?B?a3lDL0JSRDhYNlpiQ3F5MVlOWVBHOFNIQWZSZWpObld5ZGt5Ny96ZWx6Vnpu?=
 =?utf-8?B?N0E1NTBqcVpLdnhGWURJc0xqV3BOL1FacHlyeWJKZVM4UWZ0QVlWOUVpN0Vh?=
 =?utf-8?B?bXRwS28xQU5ucXZYSEwwSXlQMGRxRDlnNHlRbGZMVkpEZVByQmdoK1llVzZn?=
 =?utf-8?B?dXBIQU1NSXFXdzlzUGtSaitjb1RTb2dNQXRlaC85VzV2dmd2dTdqekxIV21w?=
 =?utf-8?B?cEV1cmRxbUExdTgybUFZVm9pRlFFNkdvMmhpR3VXVWp0Vmd5TXRzL0dXSjdE?=
 =?utf-8?B?N081TEc5REJUMTdSWHpvUTRvMTM2Y0E5ZUozYmNEYlMzV2FxWTBqWThybjNo?=
 =?utf-8?B?OFlpeEVZOGQ5dnRPSzYxUmVEQ2VZSWhTQTAxc2lMd085TUw4bytQMHRjNE1U?=
 =?utf-8?B?RWtKeDk1K0RpUTk1bU4wM3ZlZzk4UGM4RnpRY250M0RDanlSbFRKQUZsaGxC?=
 =?utf-8?B?UUcwdUt1NS9BUERGNXkyTnpSckg1WENxSWRjWWhKaHhjbUdNRVhYTmR4QjhF?=
 =?utf-8?B?Y1l2TmFrZU92U3RYVnErblg4Wll6cHp3M0hpbEtzQVc0bWJFczkxWmVLZzlP?=
 =?utf-8?B?ZVJDWEN4QWgvODJUbzF5cnBWd3gzZ0JPcUFMRnV3ekZTeUlBcUxRSEh2Qzdj?=
 =?utf-8?B?L3c4djllb2dlcVBwOUQyWS9wdlVhTFlhWVRMYms4K21TdExrYTNha2huWkQy?=
 =?utf-8?B?dG5sWlREWjhka2lNSUlzTVhJLzVMd0s2OWF3b201WmljTFhvRCt5VC94bHhP?=
 =?utf-8?B?cjZHMU8vSXVrWmV1OUxZUkhvU0IzbjREK2JyMm54WkNOZWtWSXFFZEJudHR6?=
 =?utf-8?B?QVlES2s3aXZjQkFscEtoSTZvQmtFVlNPMy9CVHVDRm41c1JPSnBETk93VzBR?=
 =?utf-8?B?Tm45bGZUSzJtQ2V5RjZuN3g0YWF0S05iMnoxenhsRG5uaW9ta0o1Qm83Nmgx?=
 =?utf-8?B?ZC9tSDViMHM0U0REUEFVeFl1eWZCeXZjMFlKUGFNbldtVTgyOGJNaUpxYzZm?=
 =?utf-8?B?ZWQyZmlDejA5L0dmWGZVa3JjMVVJdG9DYnNKZ1BqMytYRmt5NldkN2xxSWdo?=
 =?utf-8?B?NGc2M3pjdmRtVTREdkU1TnREVHZMRlN3aVRWdngzUUs5VjJvRXFPbFdMTjUx?=
 =?utf-8?B?M2hoRWQ5d1VJWkJqdlpOWEkxK1E2TVZ0N3cvS3FPZjdUWDVUYUNDNnZiZDdh?=
 =?utf-8?B?ZmhnaW04QkpPclYyaGQxWk9WM3RHQWRNakc4VHl0SHpOeERYZElKZDUyWEV0?=
 =?utf-8?B?UDY4b2VxcmhuNEZNRkdSQVJBVitINnNpYkpnL1VweUd0Yy9VbUdYNjFUK0g2?=
 =?utf-8?B?QmxWbGRvRW5OYVowQmxvdW95UGJZK1kzSmpnWE5zZEpMNEswMUtUUUFnNW9C?=
 =?utf-8?B?bmlib2ZML0M0eGJtOGo1anhsdWp6cTEraGdJUFhRQzVYaURoaUkwclRWT0lm?=
 =?utf-8?B?RGp0bUk4emMrMXdGS1VtdFpMclhLZmZ0VlFvY3c3dDdMbzRGc3M3emNVTlUx?=
 =?utf-8?B?RXUzNXZvQzV4MXVHQzdsNHR5bWJOYXVDaFNvcTdEUEdvd3N2N3NQcDJTa2ZL?=
 =?utf-8?B?TnhOMHlkL0J4UUM5M2FndnNxVWVGbmVVb1VudTg1TndiVmFTSTFqUi85YkRs?=
 =?utf-8?B?bGFiYndlOXc2UTE2WFhKbllTNE9VbUJkQmY2WUFIYlV1Zmx2ellaYmJ0SURP?=
 =?utf-8?B?WnlGMFNsZWVZV2tlaGVJQTRadmhWM3BwTis1VEJ1VXQ4M2FWSXRzWlY2LzVC?=
 =?utf-8?B?U3JyelZPSW5TR25nTmNyNXdnZ25UVkUxVU9USStxcVh5SnVUTFlTUXk2NUJv?=
 =?utf-8?B?ZDhkQmFJeVNOMWV3RkwvNlRPTEw5UnRtc3FlSCtqaHdiazVlbXRkbjRkY2Jn?=
 =?utf-8?B?OVVPVmdvcDBRS1JsQXNyR2lPTFpjSHpXTUpYMHFTNUhWaVhNVHBqMWRZR3JZ?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8dUjSpUISq8+uxWzVxrvsyRxE13waWD/Jfc62GIYgwlFE4q+IwHPwJJa3bNFoVuTyr8d7xqCiUIww2jQUvuTxVD+smJ0GQmUY/TJmkenvKmNGhyxzjRl3BGooI1ROsDvwkuzOvUmMXPkSUrLJ3wyJgVOpQqBjOdm97n1o6OG+dX8mzr+m2FmpVM69xyrRnMBurzMoojqbUHP5ABxjNCC7ZvPIEWwahV+s4mROwb6GkWHD/i2ZX7XKMGYFHzOdO9Ogm10xc467JG+1lCV9rZILjxv+bpJ75NegRtpDSfmLlxnAJfE2mA0tnn71ObNYLEHnfgIX897CQ2kAuMaWasa4K40iGYMNJ1lWyjf6M53AqtZU8YsrEkdTwBT5TbfTaaf1OQ826TwoK/qvqzIK079djELEmm5+k7WQ8xWaIZJVj/RqZi/JieWBLt1Yuo0VVsVo4i0V74U9NMjWrH99tECoAGwy6Z2/LaIRO8dZEnRDm/vpPIykoDKyb9WXEQcu0nwUOVRBku9Nv/L3T6Yld9gqOB2vksMeBU5n//tvt4hF7EVR0DjfoyEDjrhy/hZHEIaJaUWmFDC0BvxwV+wrQ8+GYENoMwnM3ZYiIyTJfcAvFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899c072f-4831-4684-7c35-08dd7b92a58a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 20:26:33.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8u+ii7tIyA7GUovUe3CJy0cAV7qehqVkW7xQP3NYhQ+zpka5L0gweMHuyIZEg8jjpoLsJKNqVbPpkFxxIeGWmAGjDx9cGB1YefaQqfm5rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140148
X-Proofpoint-GUID: qtrrhfJciYaSgdGZPopE3FwCNQ_W2kpk
X-Proofpoint-ORIG-GUID: qtrrhfJciYaSgdGZPopE3FwCNQ_W2kpk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Sairaj,

I'm conflicted by the implementation of the change, so I'd like to make 
sure I fully understand...

On 4/10/25 2:44 AM, Sairaj Kodilkar wrote:
> Current amd_iommu enables the iommu_nodma address space when pt_supported
> flag is on. 

As it should, that is the intended purpose of the iommu_nodma memory region.

This causes device to bypass the IOMMU and use untranslated
> address to perform DMA when guest kernel uses DMA mode, resulting in
> failure to setup the devices in the guest.

So the scenario you are describing above is this QEMU cmdline (using 
explicit options):

-device amd-iommu,intremap=on,xtsup=on,pt=on \
-device vfio-pci,host=0000:a1:00.1...

and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'

which will cause failures from QEMU:

qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list 
buffer address
qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS 
receive buffer address
qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list 
buffer address
qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS 
receive buffer address
qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list 
buffer address

and also errors from the VF driver on the guest. e.g.:

[   69.424937] mlx5_core 0000:00:03.0: mlx5_function_enable:1212:(pid 
2492): enable hca failed
[   69.437048] mlx5_core 0000:00:03.0: probe_one:1994:(pid 2492): 
mlx5_init_one failed with error code -110
[   69.444913] mlx5_core 0000:00:03.0: probe with driver mlx5_core 
failed with error -110


Whereas after your change the guest would fail to launch because VFIO 
will try to register a MAP notifier for the device and fail the check in
amdvi_iommu_notify_flag_changed().

If my above description is correct, then...

> 
> Fix the issue by removing pt_supported check and disabling nodma memory
> region. Adding pt_supported requires additional changes and we will look
> into it later.

I see that you are trying to essentially block a guest from enabling an 
IOMMU feature that is not currently supported by the vIOMMU. Hopefully 
that limitation will be solved soon (shameless plug):
https://lore.kernel.org/qemu-devel/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/

But in the meantime, I think enabling amdvi_dev_as->iommu when DMA 
remapping capability is not available is likely to cause more confusion 
for anyone trying to understand the already convoluted details of the 
memory region setup. To a reader of the code and the commit message, it 
is confusing that to support the "NO DMA" case, the nodma memory region 
must be disabled, which is the opposite of what it is meant to do.

To explain the "trick": this change is always enabling 
amdvi_dev_as->iommu, which is explicitly created as an IOMMU memory 
region (i.e. a memory region with mr->is_iommu == true), and it is meant 
to support DMA remapping. It is relying on the "side effect" that VFIO 
will try to register notifiers for memory regions that are an "IOMMU" 
(i.e. pass the check in memory_region_is_iommu()), and later fail when 
trying to register the notifier.

If this change is merged, I think you should at least include the 
explanation above in the commit message, since it is not obvious to me 
at first reading. That being said, in my opinion, this approach adds 
potential confusion that is not worth the trouble, since most guests 
will not be using AMD vIOMMU at this point. And if they are, they would 
also have to be specifically requesting to enable DMA translation to hit 
the problem. Unfortunately, guests will always have the ability of 
specifying an invalid configuration if they try really hard (or not hard 
at all in this case).

Alejandro

>
> Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5f9b95279997..df8ba5d39ada 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>       AMDVIState *s = opaque;
>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>       int bus_num = pci_bus_num(bus);
> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
>       iommu_as = s->address_spaces[bus_num];
>   
> @@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>                                               AMDVI_INT_ADDR_FIRST,
>                                               &amdvi_dev_as->iommu_ir, 1);
>   
> -        if (!x86_iommu->pt_supported) {
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      true);
> -        } else {
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      false);
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
> -        }
> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
>       }
>       return &iommu_as[devfn]->as;
>   }


