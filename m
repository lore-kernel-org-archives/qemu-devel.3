Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B2C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXCk-0007FH-Vd; Tue, 01 Jul 2025 05:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.chartre@oracle.com>)
 id 1uWXCi-0007F0-Bj; Tue, 01 Jul 2025 05:23:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.chartre@oracle.com>)
 id 1uWXCf-00009e-D5; Tue, 01 Jul 2025 05:23:04 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Ocdv025895;
 Tue, 1 Jul 2025 09:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=O+ifLTAzhVV7yc/l8t135iLpSUH6WDcM7sQek1TQnvg=; b=
 rctMLQHVOS9ETdg9MfRLQQD7/G77vqzedX7XUzEC9G7x2NOxqdYA+7Rea8oj7lbH
 FEA4viwmqmx/mxYYTWzP7Emrtzw6JB7rkKvc7+KxysA+Zbf8Ezu3OrNb4fkcg50C
 6AbopN+bWCOZvvEpgQLEAL86hh+qw+Rc/1RXl8i9GUZjm14WgKH2GlmmS+vASLp2
 Iqoskjw0LXH6kRf8Mj4Vs+sS8jbysrBvEkYp+cwsGfGuauCKPIJiPAH15joQW3HG
 ngd7vSWoWoV9DTr8KNrFamGo9zbs1h+/w4/1uV6fH5Uz56gt5zoD8GmS/i39/kR4
 zYMsfZY9rbq4NghyNzrtrw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4cxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 09:22:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5618vZ5j025781; Tue, 1 Jul 2025 09:22:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6u9gjq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 09:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8Jtoox+zjUI1xU4qPZMW31jZelJ+x35ur6ik7Z0pB7f/Y/IO7PV/OHjk5O/P5OhtojaYWBu97p7k/e0V3aSVHhOC4PRBiraDKpPEML3FFLY3JCTpGwd8nPRL/sKvt+qNx+N5hjRQVol0MycV8nsX6CwXegkz7f3aadIgXU+Dgkm9mrFvKWCOnscUksbBgJF4npuisIc/f1bgjZ2ZUb7emJvNwVXqzEbG9slvOVwmA8PNc2SePAewAHyeTfEAMQ6Wusk7d90oyyQC+d0Vn8PEYI1RaicLO7QcWuagA6cvOEJgjnqnsB365lRm23ap2cEP/2No+LNCJ2QfAFTYWlY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+ifLTAzhVV7yc/l8t135iLpSUH6WDcM7sQek1TQnvg=;
 b=YedyzNF1xIrzM3nCZKF+VS5XZyc508oIm8H2ktSz0wgQqN5tMHS+5K8TaWv+s0t0B7KIFeL71Ml13AV1b6WKePPBy3PAG64H01dmzNJv8ERTlNcO0qRovaB6Px19Uv3zICPUqos+IJcKsmN4Wxb37tZewaPjyOnzbkx8ggOA3v7I5tuf+62Y/SY3xdsjkY7mlRKsmIv+IHqwgCg7nINJTpVMw/B01s7YZGx8ybDAbWAX47FleVwTXuq4xIEiEzFsMV//S3hKruGzB/yjSxk7qeOoP3MJvhgDIRGgRwm3XI7sefcAT9Os1Y4ghbHC5zajtLXv7Wv+7QjPbBSGqAJw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ifLTAzhVV7yc/l8t135iLpSUH6WDcM7sQek1TQnvg=;
 b=Rr5KMZ4i8eGxGvmEE0o+p29LPMPqMpj5SGHcMvZgMB9+L6QZvbwo3JwK+Xrco4jffRIScxk84WmXK0NGSxntwiqK5q3NGJiYGZ/aH75qVB+nemLe1yzj+op6zxbFPZiUWjCi4mZG3yIf0qUfLAxnGZRt2uYcBqMTknOocNAyWVs=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by CY5PR10MB5963.namprd10.prod.outlook.com (2603:10b6:930:2c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 09:22:53 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%7]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 09:22:53 +0000
Message-ID: <abdf31e3-2ada-47d8-9c9d-d875491537b2@oracle.com>
Date: Tue, 1 Jul 2025 11:22:49 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, qemu-stable@nongnu.org, zhao1.liu@intel.com, 
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0105.eurprd03.prod.outlook.com
 (2603:10a6:208:69::46) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|CY5PR10MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 56497f47-6c56-468e-87e1-08ddb880db43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHhpaFFqTVg1R2hvZjBDUCtPa3I4bnJCWlV5QTZkTmVSZUtnbmtBemJpZGVr?=
 =?utf-8?B?eEp0ZnlJazB3Rjdqa2pWMFkvanJTZ2s1U0kvK3RFK3BqYnluRU9GVTVFbGxC?=
 =?utf-8?B?MHFEMWx0eUJYcS84cHdnQnlNNUwzejZxbytmWjc0dUdVT2RYUlVoKzBsZFY5?=
 =?utf-8?B?Z3RMNXQ4UkYwemJxSVhGSWROODc3NkppQW1lOGJIUDhLMnFYa1hxNzEzOWtG?=
 =?utf-8?B?eEdHZGIrN1VLVnROSU5CamdaUDc0a294aTUzanE0aFdnWUx4SXE2cDNrcE1C?=
 =?utf-8?B?WVJ5Ykl3UnFGVnFHYzVjNVAxUE41b0oyVk9oZEZRMlNwTnl3YnpEUmVhVTUv?=
 =?utf-8?B?V0FjeTlZZFBhSjlVYUsxQjQ3QWtVZU5GUFRVUXRNTkZsTWlFUFVqVlZKakp1?=
 =?utf-8?B?dHdCV29mSDNvNHNSeEh0WmFuYjVEMWxTdUNMZUxRTmpNMUJUYzR2Wm1YWmpv?=
 =?utf-8?B?WWFtS2JkOHVPL2xnbm1LeGtNOEpPeklKa2tkSko4Mk55K3VjYW5NUUo5WnNG?=
 =?utf-8?B?dTBFcVFJblk4U2V5YXV2cVJ2dnl0L3ovT1MxTG1lWWV1N00xaEl4WWJRWDlx?=
 =?utf-8?B?RkhrYnBNK3NKRmZleElhMFJMSzRqMURHVFRNb2dnRHJuWUNXNXZKL3lNWEtU?=
 =?utf-8?B?L0hrSldFYmdlb2dXM0FHd3BDN1hGS0ZrRUNYVGF4SDZZWHBZNzREQkJ2V0pC?=
 =?utf-8?B?Z1R6SUhGMmlCOFZSSkd1UEVZejVkdkZpMk1nRDlJNjVpbFRHUkdNOXdtbng2?=
 =?utf-8?B?N20zYmpuQjRUVWliZ1J0TndDSlhPTnI0dHowdm9MNlJVbjZTaWFWODZWZm1K?=
 =?utf-8?B?OG9CNFNybHVKdEFKVGtoakNCVHNXNG9PcUFZbFdMR0QzcGdLd0lLVll4VU8z?=
 =?utf-8?B?Ykp4dUt1Vk4vQjJRL2dNMEhaaW9yeVJQOElqcllOcXVBQ0lOdUpaYUVndERI?=
 =?utf-8?B?aFlNUVRNSDRDTHBLa1RaN1hCRjVCUjBicktDd0x6Y1VHSnRYcmNvcUp4bUNL?=
 =?utf-8?B?K0FGQmxheXh3TWZQSm5CUWJXU1VlZitLY1pIbFZIcC9DVnY0ZExNS3FTY3li?=
 =?utf-8?B?T0FmWHA1NnRJb1UrVnFyWjRDTEhOZVF4dW1GeXlDdGxDSFFVcGZHWVBnSVR2?=
 =?utf-8?B?TTNqWGxXRVhPVkx1R3ltOUN1M2tuQVA4NjUxeWpYNldjcVFhbzlHMTl5RTlm?=
 =?utf-8?B?eHlnbDl5Vk16dWJLb2ZhTlIzVlJkdHhyNjFKUkdrRXVFL041dEY4RHQzZlV0?=
 =?utf-8?B?eklKUXpkSlIycWFTK1JJOGpkQUVicTUyemhKSEljb0NHK2FtUUE5TktlWTEx?=
 =?utf-8?B?YUpTV3d1a3Z2d1V5TnpUNTdTWW9IbTF4bjI0cHhyTmk3U1hXTVlRRDVsMW5M?=
 =?utf-8?B?M3VZdGNSZnVYS2NSRWJPQ3Vib1B4YndleStpRjJLNTJQblpLMkg4aWorSHBC?=
 =?utf-8?B?d2l2MDBFSXlNOWVTZ25jNWJLSVNmNVNjMzd1Yy9DNEl2YzlTRWZ6YnpzcGE5?=
 =?utf-8?B?MWt4Q0lNUzBIWUd3bU1wSnRUU2Q5TnFkUWlLRFFyMlZIbkVuVEhrZjR1aWpT?=
 =?utf-8?B?cUhtWlNrU3hqbGQ2TkNLMG9mUlRobGRobVAyREpQYzNiTUx0ZkgzVzZFOEZp?=
 =?utf-8?B?MlFLZ0x6U2szVUdSWW1XMzFkVDlnYnVXZThZcEYwWEZVTGpJWjUycjZYbXE2?=
 =?utf-8?B?Y2pPZkdLcUkwNW03SVovSXBVTUl5R3o2SitPNldzbVZuNG1lUUpuZWhkOC9F?=
 =?utf-8?B?djJQeExhdXJEc05RZ2NMVXNjN0x5NEN2Wm8yamltUFlYWjVHOEFYby82eGpx?=
 =?utf-8?B?UjY1Rk9IaHFQS09pYTdoMXlEOURWVkptN2N3dm1wamhudFE0c1F3Q2JUQVM2?=
 =?utf-8?B?ZUpXK1hqOFh4dDh6aW4vc2lqSlQ2b3V2TEdKVWRvMEVNazJMYUpqMm9GU2I0?=
 =?utf-8?Q?NtsxESX6JD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR10MB5622.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURYc2ZWT1N0MXhSaTlEWDdNS05yZnFnMVRKOUR0TVFORVNGb1NEVDZ3U24w?=
 =?utf-8?B?L05Db0Fra2J1NDFYeXllNTRPYjN5YWZjSW4vdVFaU2FQeUtBaTkyaXMxYWdC?=
 =?utf-8?B?RkpZSktOVVdJZlBkTHhpNnYzR1JEUktYQklwakQ0N2Q2YTNqd0VDSUNibWVQ?=
 =?utf-8?B?bWtTbktTay9sL2F6Vndjd0MxNWNrWlBkR1pSQlVpNXJrd1d5cEZDUmdCaGJy?=
 =?utf-8?B?UDRVWnB5b2hQZnVwZktQSjFCM2VoSlZuUXFVd2tRamdUUTc5bkhoczlWZTlk?=
 =?utf-8?B?QlNUY2RUUTlSeWlRdVRaclI1YjR2dWRSS2Q1akVib0wzYkE0RFMwQUF2YUtp?=
 =?utf-8?B?M3lHOUp5MkhHdUhtV2xWaExGV3FFMlR5d3JIUVVMZDl1ZzV5NTNQT0tBeEti?=
 =?utf-8?B?K1BBSlYvcG1OcitnVXJrUjBPSkRKU0NySllvdS85NG9mVGJQd0pWNm95WFBD?=
 =?utf-8?B?eWRjTlFsL29ialhrclFHSFNBK2FuTjg4b0Nkajd2RG9QU0JDd29kSXhjVVhx?=
 =?utf-8?B?THN6Zzg2MXNpZFg5cnBJRG1pclFBbXZMNXFaUWg4U01xNG5POWJUZHoyb21H?=
 =?utf-8?B?eGVHMStjVFB4cjg3RGtqYllYNXBFRFk0R0xnaVoxa2Z6WlJoUXExemR3TDBr?=
 =?utf-8?B?Mkx1VnhsQnJLdGtLNnVZTWhNMFI0TjhSRTh1OGxlZG10bWlpQ0tpNTRwenVv?=
 =?utf-8?B?d0RxK0V4UHhRcWFicGROdHBQQmY3UWVKSmsrNjJCczFqSnRBRWNCY3VmWXh1?=
 =?utf-8?B?YStYVTc4RktIakI0TU9Lb1lOeTV5QkI0Y3hqM3NZSkdUdVQ2UmY5YlFEOVh4?=
 =?utf-8?B?c1BmVTlGalFhVlIzczhMSExsckNiMjcrR3ZNWVdHVnU2ZjZqdVJJYkFPZm5H?=
 =?utf-8?B?MUw1UW9xdnZDZGFYUFZGWEhmckoyVUdpUnkxZ0ZxMUZXYVY2MTJON25BalFR?=
 =?utf-8?B?UUpQc2pQdWJ6VEJtMUFnM3BGaFBWZmZwSkwrU1lOdmxaQllYVU14dWNDV0dm?=
 =?utf-8?B?bzhKMEJ0bEkvbnVXRkJlcC9adWdTV2JzZkh1c1B2L20ramIwaGF1UFl1Tm54?=
 =?utf-8?B?UlB2VnNKeFg1dW5BTWx1dGhXblVPWGZhbEJpQUJGUHkzV3U3SWZPWVQrV1pq?=
 =?utf-8?B?bDBXTTV3cmVmeGpMQkxIM1BYUmRnK2hoZllQaTJVNGFkTk5TL21SUzNnQnQz?=
 =?utf-8?B?QXVkWjdSUTFycWsxUFVDV3UwNU9keDBaNVF5d1ZUeFZMR2dGbmtlK2d2M09Q?=
 =?utf-8?B?OTZaL2pwa2d2ZVVOSzNaczcvcHlKeERNcElMc09YM3BZLzBzOWtZZU5wZVdH?=
 =?utf-8?B?N3RMN2diNXpqaTdtamxwblpHK1B3UnEzU3lrQlFTeFN1a3g2RFAxUUNIemVG?=
 =?utf-8?B?YTA4TEdwdDdCZENFa0dFc3RnZTRQM05aY2drUTczbUVNNW0yOWozdTdjeWRF?=
 =?utf-8?B?VXJIMElyUzhld3ZiTDBkWkRjUU1wTytBZ3hiRlZoM3lONkdaQit6SW1IMTgz?=
 =?utf-8?B?L1pxbTVaUERmUGt6VktOVnA0NDF6WXIxTUIveXNiOXFLMjJpVlR3NEJHTjNa?=
 =?utf-8?B?Y0IyY3FseklhcVdGa1ZJUk9HUmhDN1c0UlBZWWVLUmtmZkE0OE5Fc2YyQTFu?=
 =?utf-8?B?L2RDN2d4aDFQSXRrZVU5emt3WnhCY2hGNFBsK0ZJaGZNOTJHREVOQk5CL2dS?=
 =?utf-8?B?T0ZvVVYxQU5PR2FxMmRvNzhwZHNhSnlYUzFQVVZZR29NSVpvLzM2cTVPUlRy?=
 =?utf-8?B?RTEyT3kxVnExNDNkYXlVNXNOakJ0enB2czFVUlFMcWwvMXgza2ZJSUtDamM4?=
 =?utf-8?B?dHh5cmZvbHQ5bnpMTHFFaUlRc1NMQlRod2lTTEIyMkMybHBvblJjaS9iaGRz?=
 =?utf-8?B?b0J3NnVLNHJKdzhyb3hoNGJwcG4xTDlKOGlpblhJOEZUZmJ0NjIzOGRzM0Z1?=
 =?utf-8?B?N2FkdStOL05VU2VpMDZTVkxRZ2Zxb2ZkUzlRSU4yRUE1TWNDNkVEYkdHYTMw?=
 =?utf-8?B?dVRIdjNXRTZIZGltSnc4SXdSSEVnRG1yR0hDTzNaQk5DN2x6REV6YVJNbmU1?=
 =?utf-8?B?SXNXMklONGQwNldVVmZJSEFtTnl6d1BkcHZQdWhwbWEzNmFnRE5nZlFveXZz?=
 =?utf-8?B?TDUvejRNb3E5Smd6VnF1ZFZYYmRZVUdrRi9MMTJFaDd5NjNlOUxoZVFTaUcv?=
 =?utf-8?B?NVRPR1dxWjBpSFR3aTBST1d0MlFMNjIzL2JINzF0UUd4Y3hUWFBWSloyOUxn?=
 =?utf-8?B?dFZVZjBTU3kvUnk0bDVRTXlpT1d3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xA28qZ91vV7iBmYSZEluGEOVc5uF/QIiQpJMWRJJ8wjRxQ5cMYa46wxZ1GGYzUFhKHRA7123wPC/R3avZ7WSXWSb7sIh5MlUKTqFG1xUGOXvGH9Tw3CuDwFmqiYUfNiQ16w5KTxziH+8PopAa108Ypo6m30xvEQ27+itwN2Ra1Yrp+SoYIvogHpNOuvFtHNUtMo4MxJRI4pzmHy8OeHVddEYDi6f5KHmSQenizcOYeSJGaCAYRiXF8HmoWSykXk+cNdgrO4VJJmOzS5kuHXlAAmUPRKPBEAORR2cjyGMVMZJmouxDCICusmnWCESMg48SuXEEU2hjxQLwNv4mnKUN5kDyDUM8Ka01x4aaQjydyzXiF1FH4RUE7/1TuE26RpzO2D9tZLsFBJxGPCvYuw9YMY1f+Px75fA8nTiTE+Qwr/Gjr75qyNoqxmJx7DtmcrLFkqEUHhosbkwX2yahkh0PGsHRAWpeAOwkR0tf3iadH3NfsPJ+hHIIBWzBK5QfTEcaNSgbGIsxSiN7q3necXv1plgHoskrUia4kPbNdna8U0YUpB0PWplD+f/gFRXKpcfSlN1hve0cyaBvH+n58LxjxqdQJQnQJWpa7El7/DQmws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56497f47-6c56-468e-87e1-08ddb880db43
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 09:22:53.3524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAR3PQV/gngUDjX/u2x+0NQ8XxHKVfP4js7UBtMOf8QAo5CU2a9GRQojJs3Hg3kcPZbuh7ci0ta64+MtBGgDIVAFbSltQaWgbaB7qR1NQxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010055
X-Proofpoint-GUID: nJejBNgjaqcGn3_iSh4J1G6lXh6lCuDL
X-Proofpoint-ORIG-GUID: nJejBNgjaqcGn3_iSh4J1G6lXh6lCuDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1NSBTYWx0ZWRfX3ZjVjbGsteE5
 qb7GP+OaGaH711SAtAaZGmEgmKpmwZK7GUKQCIuJ1XDQN9aaMVOGNkuGczmtUcPBJaJ+pKlFI9J
 D8zLa9xpWq9i1ht1fsiZ9Y+4HdL2HDGcAM+42FaGebPBrgwg5GUvOWAvYpZzUCX9gTMurL7w/iu
 yKEqPL0dgencR3fwTVNAmeHJmm56I15BRkdmnVsBBCU3tvgaCf4FPaD5Cw9rVgCik7wm5Y3Z1F2
 kNyljwMwvNImtjEbd6wFBB+qAWkZIqGQX2UIWAjoxbv3AsKw6XapWv/eovurTJ5znnzT7Sm+3cT
 c/OyiM8VgKAnuoNGDxjfMATXUuKdtQv01IpyCRmXwL8Byac+V7a32Nax1WSVVB+7jgHUrERXZvk
 saVlXD0kiI+Nm3qjcJIyXeA2rEeZ/j6UMzHJLcRMyTpuTV7BbDR8r+I3fmoQnrICD0qDwSk8
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863a8f0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=8twkkAWQGMmOSaPdkwIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alexandre.chartre@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 7/1/25 10:23, Xiaoyao Li wrote:
> On 6/30/2025 9:30 PM, Alexandre Chartre wrote:
>> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
>> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
>> MSR and it makes no sense to emulate it on AMD.
>>
>> As a consequence, VMs created on AMD with qemu -cpu host and using
>> KVM will advertise the ARCH_CAPABILITIES feature and provide the
>> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
>> as the guest OS might not expect this MSR to exist on such cpus (the
>> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
>> are not defined on the AMD architecture).
>>
>> A fix was proposed in KVM code, however KVM maintainers don't want to
>> change this behavior that exists for 6+ years and suggest changes to be
>> done in qemu instead.
>>
>> So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
>> is not provided by default on AMD cpus when the hypervisor emulates it,
>> but it can still be provided by explicitly setting arch-capabilities=on.
>>
>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> ---
>>   target/i386/cpu.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 0d35e95430..7e136c48df 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>           }
>>       }
>> +    /*
>> +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
>> +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
>> +     * continue doing so to not change its ABI for existing setups.
>> +     *
>> +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
>> +     * to prevent providing a cpu with an MSR which is not supposed to
>> +     * be there, unless it was explicitly requested by the user.
>> +     */
>> +    if (IS_AMD_CPU(env) &&
>> +        !(env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
>> +        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
>> +    }
> 
> This changes the result for the existing usage of "-cpu host" on
> AMD. So it will need a compat_prop to keep the old behavior for old
> machine.

Right, I will look at that.

> 
> But I would like discuss if we really want to do it in QEMU.
> ARCH_CAPABILITIES is not the only one KVM emulates unconditionally.
> We have TSC_DEADLINE_TIMER as well. So why to treat them
> differently? just because some Windows cannot boot? To me, it looks
> just the bug of Windows. So please fix Windows. And to run with the
> buggy Windows, we have the workaround: "-cpu host,-arch-capabilities"

Well, the Windows behavior is not that wrong as it conforms to the AMD Manual
which specifies that ARCH_CAPABILITIES feature and MSR are not defined on AMD
cpus; while QEMU/KVM are providing an hybrid kind of AMD cpu with Intel feature/MSR.

Microsoft is fixing that behavior anyway and has provided a preview fix (OS Build
26100.4484), so that's good news. But the goal here is also to prevent such future
misbehavior. So if other features (like TSC_DEADLINE_TIMER) are exposed while they
shouldn't then they should probably be fixed as well.

"-cpu host,-arch-capabilities" is indeed a workaround, but it defeats the purpose
of the "-cpu host" option which is to provide a guest with the same features as the
host. And this workaround basically says: "provide a guest with the same cpu as
the host but disable this feature that the host doesn't provide"; this doesn't make
sense. Also this workaround doesn't integrate well in heterogeneous environments
(with Intel,  AMD, ARM or other cpus) where you just want to use "-cpu host" whatever
the platform is, and not have a special case for AMD cpus.

Thanks,

alex.


