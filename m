Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448B4C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfOo-0002pg-QM; Tue, 15 Jul 2025 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubetm-0002iq-MC; Tue, 15 Jul 2025 08:36:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubetj-0001RT-Sy; Tue, 15 Jul 2025 08:36:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Z6kb008277;
 Tue, 15 Jul 2025 12:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=IYZXxqYILFg+5kWAHyMCKAWmPgns9miK3xv8Jp9bgww=; b=
 ULkrtDOTphZtri51S2zSKyldeSW+xz8JyPGkzsoYriDJ3EinhIq28ve4Iy18QRW7
 vPGg7KvJeDVyikWBbdGlhTqGAz2MEW6h1W3EjbqEdAVZBkl5aIkVRRpjrgQQpAsv
 UI5uM4Hjmeb2EbC2Ki8OSOO2mQQo6gCOWX5lv41ZUk/Mk1XVW1xyT8d8c7OiDIDK
 R8vWQfnD1c6TBHSekyxlXiw38N0JE9vmxQWnrqAx+ovKdTnZ0VoPW9pugqKHJAbw
 d1KIA0MSHop0haePei31ZOc7aALW+woIJVDqh4YFzxfFyXvfpRR09puDoy5cXwL6
 yIESWi4UFT0Hsk5J2yp8Zg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7xrb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:36:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56FAtZGt023974; Tue, 15 Jul 2025 12:36:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue59w999-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTv4wYODj+OcU13dlJYllxtMwzgpnsXEDerJk59HDsWpTN3GZEM6b7yZMIZGKqFuBTHPk56I9auGlqcuEYCu3PRXRYlhK7lWTMZzIaJMdLLjNP5kOlNT0X6TU2LFkKI+aJq+2wNtEAdtw3IKRihl+T4PVkX6Ac9VVe9BJCkkLSFo6mD5E/a3Xo6T1SV54krTsffaV6QNqanOIC/Fsv6WUYeEixnCSGfyMNpdOF3GiHwieaqMTDPBiVHvtKq4GkUshiDVMe1fLKxJgwZv0XYOE8ZTAk7eZMD1Hhvn/2esPWkI2QaWII3xyuTdCJmsGQOs1tqJxQ1csc3w0oSbL/7YWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYZXxqYILFg+5kWAHyMCKAWmPgns9miK3xv8Jp9bgww=;
 b=ePuoZdDl8u8WU/lH9Uksj2zRwDMhzdTdQaJumt/RQOFTNSLSapwRIa+sZ4vwIBDRBmSaml7cPr+0mVEa/7cMGju1+Kj8MPfT14+LttfM1q0CKnnA2DzWX4UZ7Q7ukxpPQSE6fUtyDuT3yo6DosIERef1lIUNOR37jjgF6xN6zqiaX1nu6dLCCTtC46CFwHQ3aYQJYJtPy74NcrJRzdr386VlwhNsKAFHvMmCBiImcBAgMJ4KoKirc95kK6KQw0/FJQArgMryDczgg7A4RWbxiA75WRJoVa+sUMHL9IWt1r5pieZtt82vEfHTstPnghZoArayngwKVfrxHgRye/yKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYZXxqYILFg+5kWAHyMCKAWmPgns9miK3xv8Jp9bgww=;
 b=yn34pU6JD86uYYDF5VRiJegtiw0NC/BHYMEE7XdkzqSAYE7T2tvFCZEt/GrtRhaQRM61xZjmwlUggSQkH3h9Rng/5kGIZ3PfCg/fJC7IKt1UpOBbS9zSkT2S1zEu0oySiK84UFqDELUov8Yb0k9s1poLSTIKGNbLrKhqe0cdaFI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH4PR10MB8049.namprd10.prod.outlook.com (2603:10b6:610:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 12:36:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 12:36:30 +0000
Message-ID: <d2062f33-7161-4d0d-8b42-ac361119df74@oracle.com>
Date: Tue, 15 Jul 2025 08:36:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] vfio/cpr.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, tomitamoeko@gmail.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-19-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250715093110.107317-19-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:510:174::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH4PR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: afe2bdbe-409d-4941-37f6-08ddc39c3953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWp6ZnRjbWhYT081ODRCNDhaTkdEK0pOZCs2dEVCRjROYVMwQ0g2emoxTjlQ?=
 =?utf-8?B?UkNRdTNvM2N6aVlhQ2F3UzcxYU9IR3MwcWZyQ2Q1RE5zZ2tITmxrLzlnNVgv?=
 =?utf-8?B?WEJjY1lld1czbk04RHFSUFE4YUhHRnhPaFljK0xSODB3aGZDa0dYYlFFTG8x?=
 =?utf-8?B?ZXhWWUhDWGcxZ1d3ejFaU3JUY0M3TGFiYkM5ZVl0OEVTenQ1SUhDbEQ2aW9y?=
 =?utf-8?B?dzcwN3hmYk9kNU04OW0zMFZqZHVOTllmb0pjdGlMZWNMU2cyNjRtK3ZLdmor?=
 =?utf-8?B?WituZ2dmZ1o4OEdNcldDSC9TcGVJcm1LbU1lbnBLQzZwOXJreTBlU1l5Z0FK?=
 =?utf-8?B?dGxEOTZZL2J1L3RubkpWTGMrcHUxdkFNbjdKQnVxalM4RzVNdDNuODViM0VR?=
 =?utf-8?B?TUZVMnZlWUVsbmpCaW5sRzFTZU9ic2JxWlZxOFh0ZkJDNDJReUN6dmJNdVIw?=
 =?utf-8?B?VjQwZVc3eC95UmFZZjBXbE1lQXAyejAybFEvdk8vcTY4ZEZvNjMrM0MrazVn?=
 =?utf-8?B?U3cvbE5rLzRvdE5ScEoyU2c3bG1ZRGdzdGlGMkVzdWJVSGlGcDNKL2Z5YTkz?=
 =?utf-8?B?MVFwL3RiR1hKZFQ0c1J2clVsOWRRbW9tMW53UXEyS3dvUkIwT1phNjZ3UTNt?=
 =?utf-8?B?R2Y2MGVEaGRBbllEdDFLeS9NRnRxQW4yQS9KdzVHdi9COXpxWUUzMVRiU01h?=
 =?utf-8?B?Ukl4L1QxNk1KY1ZaQzRTT2ZBWENkRWV1OFpWTVFETVY0VWJtNS9DVVpVS3FZ?=
 =?utf-8?B?MFVEb1oyM2NBVGlQSWhGUXdQK1NkOHlQbytJOWR4Q2xQaFNJalR6VWdLanZB?=
 =?utf-8?B?eE1pc1VJOElFaXdtTjNLZkR1U2RXOWwzZWowSjFLVjlyVFQxYm5iK05YbzZZ?=
 =?utf-8?B?R0EvendqQkF2ZmFCKzdsdElqNFRCanlvcUpTaXVDN1FiQTdFWGVmc3o5eUhP?=
 =?utf-8?B?bWtPaEFXcTFJdzhXYlVjQ0RmVnB3RGZzTTlWdTlyV3RVaFJHU2lrSXRRd0ZD?=
 =?utf-8?B?QjUxNzJWall0L1d3WHRlTmVaQWE5emd0RStuNFBjSm1lVlNaaXZGNGlSYVA4?=
 =?utf-8?B?Sk1hN3RPUjZ0WFBKaVIzcGJoRHZFT3BCZlltZllnSFdxZlJNUjVwK2FyTmUx?=
 =?utf-8?B?a0NnWXo3ay9YN0N4VHZaSlRMOEpiajVEYWYzZVlUZCt0UHh0MlFTWnQySCsz?=
 =?utf-8?B?MllMalF5MWszYjBBSHJDNWhBeGNPQzdlQzNkcytvNXFzZTBSQm5FSVhxWHMx?=
 =?utf-8?B?cEdmaHFWc1FFSndBb0hhaUp1UndScGFrZTcxZ0ZUKzFldFJLTEt2YW5QVkhu?=
 =?utf-8?B?b1ZwTmNiS1VmZWpDUDh5WFkwKytSTFE5UDU1a1U0M2xKUDl0aTY0a2VBRVhj?=
 =?utf-8?B?TExBaHNrTncrVThuZ2VrTTF6R29xNEZ2MlFnRC83T1I0RENIVjlSVTA4MjlP?=
 =?utf-8?B?OEl1NUVxRWJ0V2k3MlBERisrTVVTR3kybFlLLzViYmRVS1B0SjhqWnZucVdu?=
 =?utf-8?B?dzRWTUVITldZK2QrTUxVbFR5YnFSU0tlbTlXWlp4aGdvdE1uazVPZi9pU09u?=
 =?utf-8?B?b1I3WkhndkJBbnk2Q3M1T2xWZmV3aXJqZVVNY3JuL3pQN2NEUlJLZXI3NW9B?=
 =?utf-8?B?Y0lZWDlEQ1ZOakR5aS9DSysyY3dzQ2YvS1dXbW5qYUZ5TlBjUWpiUWdZQXl4?=
 =?utf-8?B?ZExhVFh2SjhGNUhDWlVtd3dMalQ4eENZaWIveWlBL0dzbXZKYzNSd1pyMndZ?=
 =?utf-8?B?ZEdBR1RvRlhIRTljZnJGU3orQnlxbndRd2xmcDhSUEhJNkZaekp3TDZ3aHV1?=
 =?utf-8?B?RjNlZ3g3bmpiSEpjMXh4VzhTanhZVjRKMzZFeTdRT3RUY3N1WVFRelgwcTdD?=
 =?utf-8?B?Mmo5ZURzOXkybkowTWc5TUIvWWdjc2xqa0tqOC92UUpTaGxIMmFWdVN1cEVk?=
 =?utf-8?B?UCtCK1BmTGQ3eXRwZ3pHU3dZUWREcVVqM04vN082QWNXbHFpbktXTnRaLzZi?=
 =?utf-8?B?ZWRuTWFla0l3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ltQWN5bExRZTBOb0FzQ2F0c1RKVzJtaFVvdGhXSlNrL2JLUGVWT055TXNr?=
 =?utf-8?B?dG4rRXZoYm1GaksxdWxPU2RSUkw0dHd6TTE3bE1CakhQVWU2R2hXaERSWFph?=
 =?utf-8?B?ajljNjlhMVRXY1lxMzVNTzRhbEpNVXRvc255dWNET2NibUM0aTh3aEJuMkRD?=
 =?utf-8?B?NDc0dUh6S2p0Z3plbXJoZHp1YStCS0tnRjM2RnZFaEM3MlRydXFJWDB6blhN?=
 =?utf-8?B?ZC85TnU0a1pCVVRzSDk1OGpMYVlKNmNhZWNJd29FRDl1bDlsY0VBOEE2ai9O?=
 =?utf-8?B?SmJsZllVcnIvVm5VMlBmcVFtT3MvZDArUTFocUJ0U1dsSWN3UkJzaEN4c08z?=
 =?utf-8?B?WTlIMkk4RnFTVjNlTU1VeWV0L3NJd3NKL3Brbi9rUVYzTjNGWXpGNjhDTHdH?=
 =?utf-8?B?VzRHenpBbzN4bHc3UW5XNjd3ZzJRNHNEOVExNmxKNkZDZjhRRGNGVlNMQmM1?=
 =?utf-8?B?Q1JBWEVmaUdJbmZXYWlzQ21OOEk1RlR3bmh6L3Rac1I3cGtMVlNrbG1yS2Fa?=
 =?utf-8?B?clppQVZTby9YQkwxVll4ZVB2MFI2N3RaSWtSQThNUDVpc1dYQ3lsUDZLQXla?=
 =?utf-8?B?b3Z3LzQ1REZlbmtZWERRUHNGY29mY0c4Mk4rU25UOEh5UTIxc0RaQjFNZjZu?=
 =?utf-8?B?V3owN3h6S0hvaUlZU29TVE81aE1MWm9UaG8wQUxxZ2szQUNsZnpKTHVSd3Nu?=
 =?utf-8?B?anRyWDFnTk1tMnVvMDZPVGE1ekZMWWF5Y2tweTc1TmI0SEpiSTZKMUViSU13?=
 =?utf-8?B?cGE1bExWdkRKSXlFSWUvOXVDdFNRTDVzQWgxOXZ3M2hwWmQwSENBRlJEVEJx?=
 =?utf-8?B?dmRieGtQVStNUHJCb3F2d0h3ckdYby9TZm1IYVpnRTVWa3hEaWd1aXp2SXZm?=
 =?utf-8?B?K1VaUEovV3hiRXRnUFBtMEJpLzd6a2c5Z2dURmNJeEd0R2daaGxhQzZ6aHNG?=
 =?utf-8?B?OFdQWUJDNWZyeGpSMjVGelJlZlZiSm01aXV5RFI0eGw4VTQ2OTlSUDYzL3Vw?=
 =?utf-8?B?c2krUlA4M3hreVFQelVLVHd3UmZVZUhHY05qRm5aZUttbFlSTVQ3cmQ3NnE4?=
 =?utf-8?B?aUNBa1R0MTZTakJKOTZxQUQwc3ZwL3JzanpMdnZpTnBPc2dVaG5ueU43V0ZT?=
 =?utf-8?B?MnpqK21RVFUva0dod0dlVkFaSm5uN1k1cXB0OCs3OFBmM1F0SkNEVTZ4dWRB?=
 =?utf-8?B?SFZUQjVpMFZoQzQveEdrRWZyeThXYUVrWXVxYlRmajJuM1pMYThoNk1MTkha?=
 =?utf-8?B?ZVBnMFNURGRvTUliSUNaRC9JazZPQ2dHTWVNb29IQ09XSUU2NjhOVmF3N2Rj?=
 =?utf-8?B?aldraFZtMG5jbWFqeVpvR3ZnL0VKMHBVcjUrSFFjbTlXY1c5NGVnNjl4T0FI?=
 =?utf-8?B?Nm1oVnBONStvN0VCOWI4eEowZ3Y4a3FvU0JJVGF3aFhRVjFaUHc2c29VcEwz?=
 =?utf-8?B?K3JCRkwreURzL2tMT2UrbGkwdVNqRnZxZjMreUFHaURTUUJFL0xCc1J4RkM2?=
 =?utf-8?B?ZVhlZjBKcVVlVml0alFCSTNIUFluR0ZKdzN2RzJSa0hxUXN1OW1vMm9hclRD?=
 =?utf-8?B?TkhmTWo0VC9nQStWSmJmQXFBTWpDQkN5dzE3d240RjNTQ0J5WXRiL1NiQXow?=
 =?utf-8?B?cjlIeXovRmIxcmdOMy9HK3BxVFpIQmlhYXk4dEcvRFJMdnA4NXRKTGYwcU5p?=
 =?utf-8?B?ajBYK1dyYkhMbDJoZ3laR09lUWxtWTd6MWlMYXBjMW1DZEF3VkpMNUlpWkhp?=
 =?utf-8?B?Vm1PVTkwdnliWFFSeFRLbi9RTVM4OWx3U3RsOGh4bDVqaU9SWGZsUERBaWpS?=
 =?utf-8?B?UjNRV2pMdzc3Mm5wME15QllId0FYY3NrU1pxUTZhZStXUlpqM3lVcFE4ODZC?=
 =?utf-8?B?WEJMelRuTTBhalBUTnp6Y1NNM3VKakhxeWR0bXVva1VtWnhDU1JnRlV2dUlH?=
 =?utf-8?B?SEZ1YWF6VjdwNjh5UEtycVltaHpRdkoyY3dJdzFVclBMcEZZUm5RRTllMTVH?=
 =?utf-8?B?L29LaDJYY0ErdlVWRFduUCtYNXIyWHhadFlnTWVDUTdxNEZHa1BsdjBIMzc4?=
 =?utf-8?B?Qys3U3dORFhva29oZVFmNndLN3k0d1ZEaS9ZaG5DUFd0QmJIUUwvM0h4NVo5?=
 =?utf-8?B?Z3IxUUpMN3NxTFZZdlBudjBWR2haMWtyM0tqcHllR3VYS0dhckR6QTlxdFM2?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tO0nPZiDup1q9+1Gtt8Fca61i+JG8mjdwDWrb//5mH+ltt/MF+tlXozGb2qWtQFtqTv0aVyXpxT1D1YglsI+0h60RtVYst3b5EzUgKY1NNwYe8FU9XoYQf3BB2qE1KSGT5ySSCUy07oxKNWiP6Z4I6G5mFB6zbq5CCG0EnRjYKNgRUnxD9ch0P3n/tEOe1iPR97+UErFh48PW+iuhZKycgBW2zgIvwETo7PisXTOEdeKoiBSL7oeLUWy6oeoUbf9yO0ZACgxc+K6E3YvaH9p/YQnvuai7b0JQGcZbB1uXVys0SvFQICiWDl1Dd6IaQGtxkv+jV/pTlB43wfqOeGrM42wOu99t3DNHd0++nV0w791BKKuVM2w8m7REm0ih7kSFXM+sACmaD3gTpLTLnCB7y4Re3p76Y3h23yRzukbVHId3p/sCVYv2tO1HctXgwouuw0VIpSuC3k8cmblP65ryQRlajkNtkfvp2nSHWwo1Mx3tp3f9hf0Kv5cA0wQl+xI+Hz8HWJ309rPGza7TriIJ5sr1iTQHuBK3ydGRowIVyNpEFEyrpDCYkbWbG5iuNWNzUXH6eugjlMzRVxi2dmdFCvSBwDmq/hJKpSkNUHQ448=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe2bdbe-409d-4941-37f6-08ddc39c3953
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:36:30.2831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx5z9QPWs4M/KInZHQ72t1DFOp0TH6Cp2qLDYawa7kv/Qpq9mT+V7YbnLTnLrYizNI3VRj/E34Jm05Md5rubV0MYFpTt+vJL+3kSoA9HBIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150115
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68764b52 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=64Cc0HZtAAAA:8 a=yPCof4ZbAAAA:8
 a=4rH0u7qsSjzvQXx4uSgA:9 a=QEXdDO2ut3YA:10 a=AqYkckc_seYA:10
X-Proofpoint-ORIG-GUID: CG7wgk7rpQLTizIDhcrUFbrKul4cMTj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNSBTYWx0ZWRfXxEUyfk+O5Tns
 wdiZ9CXysdhB4oiiEXRCdVEzJUV4q1SSMytGrubNzYjP8d6Vfk0RFyefM/S/K5ZmbJok38zCMIE
 bMP/ojeQN+HuME4Lsyvw9H2IXdz4NelLXQl9cRwhwassruSrye2D+kuXCMT2c6Nag8zS+KW9wH+
 q2NJen63JH9hyGJBEeS0SHRmt/Lm6YtRhhQNQQ9aAvN2zXseZ7rqH86MbPmBYlQTM9xksqImDto
 87uQRG6iIsuVYXzv43DK7XAqMWrFYuSO/Cr5KpINmCgGnk1R9Nk2jJybMDhKAP+KObHbqOBBYuF
 ZnRXwLgKsFsE8CDmTzPqmH6fH7Q1WWmZ/1BM6GvTpkJClXZlVbWLzAGaKT3sQodfvayI75cRTBo
 5JMme1J/1+FqrjjzYV8zXlzCjmK/qonkuYlqDApo+hlJWjVigfrvTO2sfa/DWb/NVlLDWAzK
X-Proofpoint-GUID: CG7wgk7rpQLTizIDhcrUFbrKul4cMTj2
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

On 7/15/2025 5:25 AM, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
> accessing pdev directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>


