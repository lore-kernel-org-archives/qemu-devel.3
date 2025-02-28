Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23381C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4yb-0005d2-IL; Fri, 28 Feb 2025 13:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1to4yZ-0005bN-NU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:20:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1to4yW-0004e8-Tc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:20:43 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEGaEV023496;
 Fri, 28 Feb 2025 18:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=YkfqCLCy23oVnrxxN7pTVSWmJ3uNsRui+echOMOcMPU=; b=
 fWRAnSVpc/Kyin2or9FNVFVaUgZGNuRfR555DxTpFGO0dL0nwxFyBv350loeDky7
 Ttb92uO5Bn50T/uDboLYEDu8QOaPqE0zY7TwXzSWTIWjZ6N8jF5+gkVrqCWk9JMx
 ze3wtwEHXd0Cl9OE8OnCYCr6Dd1uggdpw/CspmtPufuWgBHdE+6hfodieM7wOvRl
 b94kpmDyI1fwYh9xiAkC36YtzQ5+estQogS7fJoiu57xXZxiGJPmMHPtydXm3oHt
 G92PzfdH9gOqjXg8lv494Qbszzq7m0HxWMHqMmFcqJqujWFBc07lLQhcZ6Op0elQ
 iB1a9gQgpxrkOsdGKYMUCQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psee4qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 18:20:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51SHQxCC007532; Fri, 28 Feb 2025 18:20:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44y51m1xja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 18:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uADpL//Le+hHmlvjQieKtrmgVR2qK6TRvaI6weUkHWsuu/idE0ZbrxQOp9Lmko0lY/0IvpHMVTl+xpE20h1mwoXDFZTOU8YLtp/bzuYDrNaYZI00znqF3nX/sx+BWs6AhM9nNuhQFTUth0e1ITg5H8oJR/aylOO7jUmT63d+3/WTnW5CNJSM3X5mTZPxDVnhlIQYsFq9couolKS8888k+0UunxbbRem912IXQBY1Z1+GK9+VzCkJOPbznCJ1z7tRN50wduw4pDsa0aFGAl82DqHWM61O6s1wcapea1suvYdF72oF1c3vqEWqJf4vPPlIFhco4FnFs7FgtTps7BppoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkfqCLCy23oVnrxxN7pTVSWmJ3uNsRui+echOMOcMPU=;
 b=J8+KfWSXyiPwc73uMoWXoAvRdPlGjDA4ZCk0oinkssIzjmEzyZ/E1iin2TnqO0xlgU9gPes2NiKoYWFKkjWuCj0/S2h01p710X0XfoQgUjRDOyWVRteZcY7SRUcl+f8Se5OBxU52LpDdXzMZw51EzamcboaEd51x8GQ1eU6toL6FfOy7HxFfeiTQWQdm3HkKCUCWybVmHUt0YuVITn/kSsZBj7qb4OZqeQHcMgOY1DIfMxi9T++ntZPOjgKnrPhjW1HQj4ZFOgHNbELQLhpztL8BPKdLzP28SG+wFJ1ujeGuqt2CQvpuPUmhJy0/mEtVE7ruZMEGgoymRVbyTyojfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkfqCLCy23oVnrxxN7pTVSWmJ3uNsRui+echOMOcMPU=;
 b=oeQix4jxf9Cnh2vZP3AYIY6L2e2JJUWK8UyJgnRqMpZHqL1KS12fhJmnRB4Ase1ybYfLQ7F8/iF47e8Y4GpNa2s6panInpgTWPA+p9m0Lz+tctc6b3N5Z9HSz/nXCt0Q6zC1zJo+GuJZefoKCidQTQ1Ugwz7OwR6cjemOK8gLJ0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 18:20:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:20:33 +0000
Message-ID: <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
Date: Fri, 28 Feb 2025 13:20:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
From: Steven Sistare <steven.sistare@oracle.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
Content-Language: en-US
In-Reply-To: <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d351e31-8ec4-49f1-395a-08dd582496e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlpSaVo5WEZRbkNaSnF6NjArNHF5WUJDR3NocmhhZlhHM0x4ekNzeTU0TzZ4?=
 =?utf-8?B?TFNjRWEzUUdKM1ZMb0J0RzBkd3dUTURVMGlaMTNmRFFITlZGczdYRzJXbXhr?=
 =?utf-8?B?N2VPZCs3V3pGVXBXbmZ0S1JPdFhKbTdwQjJpcUZEdVo0cEVRdXNnNUJvOGw2?=
 =?utf-8?B?QVF0eTZqKzVGQUdDYXA2UUtLU3doU2dneDhpMDFrbGdDckJUZjl0SVhLSzVS?=
 =?utf-8?B?SC9mQWllaVhOeEFBQVZqM1VEUXkwb1hNSjR0UWdmNVFUVkdVZ21OazNQblhN?=
 =?utf-8?B?SEd6S0E0VmZaLzNLSlRBUzVQM0g3cHNxbGcvMm1yWHhIUXdJUkcraHhxbHc1?=
 =?utf-8?B?SWVqMFZaaWZHVlBOVEVsK0dLMzlqbDNsdWpmMTJGMjZwekUxT1E2REtjMi93?=
 =?utf-8?B?cXBKYkIwZHl4bGF4K3FhUHNvS05jYXNkdUEzWVU5VVlqSEQzdWMwMWM5VWpZ?=
 =?utf-8?B?SUFPUVJ1K3poL3JFRklZb1R2SkxQUmtyM1Z6SitVV0k2c3ZLWUZKTlZBbzA3?=
 =?utf-8?B?L0IrOFJYcVZPUEEyc20rYmhtS2swczJKTGlzRzdLdkw0M1BVZm55RDR3Ukhx?=
 =?utf-8?B?dlNnTTVYQmFyY3QwUXV5Vmh4Q0IvSWlFem41THl6Z3c1eTJzUlgwYmh5YjJt?=
 =?utf-8?B?WHZ5b29MdFJNM1FEVFFmeGpScmRjQkpzVmh0bHM5L0s3TnhUYmVoZmoyaGd3?=
 =?utf-8?B?dFRVWjF3bHVRaDdZOVZkWXVPb2tId25menkwdWoxb0V5T1R6RjFpa0tWcEUy?=
 =?utf-8?B?KzFjbGxTWUVqeE5sR2JxbVlYZFBwcGFFWlBKMlZhVTNzWUFmajF2cW9PTUdK?=
 =?utf-8?B?WXNwaVhKZFdUcyt2NUtscmh3QXRsaWg4VThQeFNXZEtpS1ZPMzRwUnZ0azd2?=
 =?utf-8?B?Z043dDVYbSt6TGNtTWc3N2hGRk9VUjJ0WkFYN1h0MHppa3dZMFB0V3BqODJa?=
 =?utf-8?B?QnNIQjJYK2tMRkxkOHdUVHpGK05ZV1I4ZW9IUGJBU0Y2SndLV21ZSmV6N3FO?=
 =?utf-8?B?NVdXOEh0Wnd0bEpnVlpEcUplRWIrdzVmV2RGaDBQTjI2MG9ERjg1NlA0VGZU?=
 =?utf-8?B?SHA2U3JyZFFCaHdxb3dSVHBQK1F1enZBZkt0TGdYbUxxeDV1Rkh3TzY3QUY0?=
 =?utf-8?B?MGVMeDB6bkVCWUdLOEFiQ25LUmJSRzlHQU1SaHBIWVliMzBPeVAyV3JrL2o3?=
 =?utf-8?B?dEZTVlVSK0FsbFgrelhEeEwrZVpGUDZ5a3JDZXhOT2pvOVArS1Zkd1E3UUZ3?=
 =?utf-8?B?TXdKWXBpSC9FVVZDYnltSWFFWXg5MzRKc0l1MnFaWDhPK1B1Z1B5K1ZiQkZQ?=
 =?utf-8?B?YjZ5VC94MzRmSmdsZk5lcVQ4cmd2Q01KMHlVcUF2a1h6MVZKd2VHbU9QTGV4?=
 =?utf-8?B?SWpKRU9OSEZaZ0xmM2s4UENBbHd3cTlOSG1aYjUzbHZXRmZQSnc1cHpWcERP?=
 =?utf-8?B?QmxrbUtuZ0pLVStGMFR3ckZPc2lYKy9pWDd6TThrY1BHQ052OWl0YjJqOGw0?=
 =?utf-8?B?cnd1RDlzaEs3YldBUlRKVVgvdjZXV1RyODhKMisxUTEwZHVDYitzajJZenJx?=
 =?utf-8?B?MktORXZKbE9aSW92bDRrQXBpa25weGlJcnF6eS9PdE14TmZ2QkIrQlJBeDVu?=
 =?utf-8?B?U1Y0WnE4Zkc0MzZydGd1L0NXbkRDL2RZTWJIK0J2a3dDZ0xLMjJGUFl6aU94?=
 =?utf-8?B?QlhQdzNwRWUwS1l1TFNZOWtLeWdMQ3lhR1UyRElIdHBNWStLTGUxdzRuWjRv?=
 =?utf-8?B?ejNyaktQNC9wS0UyZFdGVnRRTW1aSS83NTNFN1ZUMlYvZWZvV0NsMUpwNVFT?=
 =?utf-8?B?QkVJcmJmTEM1Q1F2RmUrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTFKTC9OeXk4S2luOFhkL2JHeDZxOTcvQ1RXNlpQUTEzNXNPdHgrT3QrL0hH?=
 =?utf-8?B?d21NSW9Yd1FoM0ZqamR2ZGhRMjk1QndmcDYrM1FLb3NTd0RRWnQ4Skx5Y1Jt?=
 =?utf-8?B?cUtwQ2huSXVTaThudEFRS3lGd2JrTVlEL216RHZWTXpSTUc4ZzZkU2w4Nlhl?=
 =?utf-8?B?amxBMzI1M3podlhtV2ZnaWZWQW1xbmZETHJmUllqaGxLSXEvekhNUFNibWtF?=
 =?utf-8?B?S09FQzFsVVk3WWFzY2tuK0xRWDloc3hBT1ZXb3FJUHNCb293OU5Hcnl4KzY4?=
 =?utf-8?B?NUM4NnkzMVZUV2JNNEFJR1MwM25ZMjdEYjdDTmZwaUdtdnlKTlRGQ0pKUWgz?=
 =?utf-8?B?b3hIZjcrekZtaDg0TWZmWGFBbXJZS2JkalBrSWRVSlNYbjJnOFpETmN2ZUVs?=
 =?utf-8?B?SzFRM2NQc3pHSzdrZ2VJTTJ3ZUlSMUgwU3pWUjUxVGpYd3lmZDJBQjRzZjln?=
 =?utf-8?B?ZGRvUkFibzM3NHhNWGI0dGtvNFJJTE53VExRcVNGUzcxTXRibGYvdHNwU2w2?=
 =?utf-8?B?ME52d1VwcEtLWlg0QnA0dkVxMDkydm8vR3UrdGdlTnlPQklaenk0S09UMmtB?=
 =?utf-8?B?L1BlSWtha0hlWjQvQzNETHBWSWlDdnFnUWRCMmVWd1F2ejNRaDBpbXJTVUdG?=
 =?utf-8?B?V0RablUrSjZ3UzlOTjdQcUdudVYwZTBPYjRJT2w3N1llVzhYTldxTXlLbmZ2?=
 =?utf-8?B?T2FRcTdmUFhwVUxJZVRrdTlqRmQ1aWR3dGwrNEZHU3hleksvLzA3QVNSRGZ1?=
 =?utf-8?B?enR6T1RJd0lRdmwybDdyZUVlN1FJYW5jQXEyN0RndkJ6ejlJekdqYjdVSVRq?=
 =?utf-8?B?WWZNNFg5bldOZnIyTWJjOWtZSFNML3R2a1FUSUVXL1lZNWc3WlB0L2ZaUXlQ?=
 =?utf-8?B?ZnFQRnRTa1ZlckY5WEFNYWpzY2FUc2JqckR6OG5GRzFwejNKNzRnOXJNTUhh?=
 =?utf-8?B?dTdqeHZoSjR6bE4zNGkxNG9oRXUvV3dhUmVoY3oyaWIvWUxhWXdkWFZKK3J6?=
 =?utf-8?B?RWl1U2ZRRzBmSlJub0ZCeEdVd3g2WGY2bDZEdEZ4VmhnR0pFNStaeDJRclJM?=
 =?utf-8?B?MTRPMnBXOGJSeVRvVFIxZlNZS2QyMEtRcjBGRGpvekV2eHZQVEsybWxSd1NK?=
 =?utf-8?B?cVZzUnE2Kzd2VzdXampGdy9mWnlxM3dNc29lZWJDNWwzWmw0VlRrRzFqVkFq?=
 =?utf-8?B?aFYvUnRFZW93N1IwR2gvRkp5NTZhcDFMdGpuMlBUODg5dHhLU21BaEQ4SjA4?=
 =?utf-8?B?YVlwUGx5RmQvT1YwTlhTS1BsSGsrK3NUS0xJVE5UY3p6Q2pSVFJTTjFFM1p1?=
 =?utf-8?B?NmhSVGRiRG1pTkJMY2tRSXdsQThUcHlUU2IzWGs5NlVxbEVKVzlidzVGL3k0?=
 =?utf-8?B?dGVlNHg2VHBtcFU3amprTTUrcEE0TEtBQ0xKbHNPbTA5dUhoUStmREtob1NQ?=
 =?utf-8?B?SVpKUmd3QndwekJaUFZOZ0VPOUkxSkZmdXBiY0F4L0lId0l5K0dudnVWRHZ1?=
 =?utf-8?B?QVlQQXRlWE5uR0dFUklQa0hDa2xTTFdPSEdaQ3k4dmg0TFl0dDJrbzZqN1lX?=
 =?utf-8?B?WWNFYzRINzg2eFo0cGIzM2ZaMzQ4MkRHTHp4d3hxRGdkVWZQbU10L1B6RHdH?=
 =?utf-8?B?Nk5oMU5tU2lQK2JJdkgyNE5VQS9NSGwvQnFoSGcxOVpMR2dSZXZKNmhSUlMz?=
 =?utf-8?B?cGJYYUlZWE9ZQmtnZDUwQUZrYU1QekRkdHFJZ2ZCaG95QWlyTUlsUzlTR1Mw?=
 =?utf-8?B?cXB0L0pBZjVhc2VLWUw0a0JxSXBhTFBCSS93MjQwVzA3bkNzTHVDVHNyS2NP?=
 =?utf-8?B?a21ieS9TQ25ibVhFYlVTd3I2NkpCQW55N240a2VmQXhiVlBhZHdUckFXMHNQ?=
 =?utf-8?B?Nk53MjlzWnl4dHpWRkVONzcveW9FaUJIZUloeGl5Q0lzK0xQOWlEVjRWYzZl?=
 =?utf-8?B?STB1UFluQ3dtcDdQRnRHcUlPdG5Kc0xONVBqc3VjUkk4QUhtVGNVekZ4ZHZV?=
 =?utf-8?B?VjBKWStRRnVxb1NrYU9rSnlDSDVCUjNockpQNzhvQnFuTm53TjZFb0tycXBa?=
 =?utf-8?B?SUpRUitPVUJwY2V4R2dVYWVBK1E2UGN4UjZCUGZEb29GWHBIb3RqeTA5MURX?=
 =?utf-8?B?eVIwT1FCbCswWGduMUJrYXVDelhCVnZZc2c5NmsxUDFHOGxZbzdNdHVOcmNr?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8FZl2mS5Rtk1WUiT7OIMcn/Dqj7y62DWNZd0egkvUduG4s5pzYc5pJFLuimc+5E8Rn+Q4YX+MmJCn2X2VlfCbnh/6StwqcB7eIQ6T3cABQk9QFmABK8DFK6LYHyOUzXA3SNKA/MK5utArzpokXlQl2e2FsP18msbWcsZUSg/9uXVE1+8OTh+bRmi1Kh91/sgr+o55ZF157VwT6jQoeG5SGhwXBTeOiqHp5xmcjWKGag5UIAQkCCpo3ShSov3JD/kfHP3NTuHp2enfLLGgoj8E9UCANF7zv7h7fMVYvlOtibWch+2rgS9uSlI69UFqGFqPiItXCO5+sMNzi5+4uwYmn2G/NzguGdPT4yN+Poy9MzrrgvwcB2gNm/1E/ALG9QRpdtvQ/MSnrFnYGIoNDA0U9QyvN/aiRrZrncdKoj2xzlkxJCk3rsJBKYGkWQTFBT8xrs5Tv8UjleSh2Q4Yi5zNME+UcOsDLhW21PWBIj9Ecytv1JT5nCrHdUORCxs8TRjhSnwRjvKwVnxJrhGj6V9SFfvn0MtKJpqh2CSxAZnOIRiHudN44Knoy6vb48OZStdO4W1R/npMVo3b6q8Ibq1HORJUvRSw2ey8Mdg49l35Fc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d351e31-8ec4-49f1-395a-08dd582496e7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:20:33.2248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTtijhm77eQe/PwL/qrh1LtVVgovDiH1ljMgtXtJbGkDoC5I4ZRqpjMI2JNozkuBzLgSJpaeb5HWucwAOtBrN7b2h+quk+wwuEvhON60lMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280134
X-Proofpoint-GUID: vyQMEwn9BOgSsu66x_vY6psZ4VPe-3Yh
X-Proofpoint-ORIG-GUID: vyQMEwn9BOgSsu66x_vY6psZ4VPe-3Yh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/28/2025 1:13 PM, Steven Sistare wrote:
> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>> Hi all,
>>
>> We've been experimenting with cpr-transfer migration mode recently and
>> have discovered the following issue with the guest QXL driver:
>>
>> Run migration source:
>>> EMULATOR=/path/to/emulator
>>> ROOTFS=/path/to/image
>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>
>>> $EMULATOR -enable-kvm \
>>>      -machine q35 \
>>>      -cpu host -smp 2 -m 2G \
>>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/ram0,share=on\
>>>      -machine memory-backend=ram0 \
>>>      -machine aux-ram-share=on \
>>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>>      -nographic \
>>>      -device qxl-vga
>>
>> Run migration target:
>>> EMULATOR=/path/to/emulator
>>> ROOTFS=/path/to/image
>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>> $EMULATOR -enable-kvm \
>>>      -machine q35 \
>>>      -cpu host -smp 2 -m 2G \
>>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/ram0,share=on\
>>>      -machine memory-backend=ram0 \
>>>      -machine aux-ram-share=on \
>>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>>      -nographic \
>>>      -device qxl-vga \
>>>      -incoming tcp:0:44444 \
>>>      -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>
>>
>> Launch the migration:
>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>
>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>      migrate-set-parameters mode=cpr-transfer
>>>      migrate channels=[{"channel-type":"main","addr":{"transport":"socket","type":"inet","host":"0","port":"44444"}},{"channel-type":"cpr","addr":{"transport":"socket","type":"unix","path":"/var/run/alma8cpr-dst.sock"}}]
>>> EOF
>>
>> Then, after a while, QXL guest driver on target crashes spewing the
>> following messages:
>>> [   73.962002] [TTM] Buffer eviction failed
>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824, 0x00000001)
>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to allocate VRAM BO
>>
>> That seems to be a known kernel QXL driver bug:
>>
>> https://lore.kernel.org/all/20220907094423.93581-1-min_halo@163.com/T/
>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>
>> (the latter discussion contains that reproduce script which speeds up
>> the crash in the guest):
>>> #!/bin/bash
>>>
>>> chvt 3
>>>
>>> for j in $(seq 80); do
>>>          echo "$(date) starting round $j"
>>>          if [ "$(journalctl --boot | grep "failed to allocate VRAM BO")" != "" ]; then
>>>                  echo "bug was reproduced after $j tries"
>>>                  exit 1
>>>          fi
>>>          for i in $(seq 100); do
>>>                  dmesg > /dev/tty3
>>>          done
>>> done
>>>
>>> echo "bug could not be reproduced"
>>> exit 0
>>
>> The bug itself seems to remain unfixed, as I was able to reproduce that
>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>> cpr-transfer code also seems to be buggy as it triggers the crash -
>> without the cpr-transfer migration the above reproduce doesn't lead to
>> crash on the source VM.
>>
>> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
>> rather passes it through the memory backend object, our code might
>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>> corruption so far.
>>
>> Could somebody help the investigation and take a look into this?  Any
>> suggestions would be appreciated.  Thanks!
> 
> Possibly some memory region created by qxl is not being preserved.
> Try adding these traces to see what is preserved:
> 
> -trace enable='*cpr*'
> -trace enable='*ram_alloc*'

Also try adding this patch to see if it flags any ram blocks as not
compatible with cpr.  A message is printed at migration start time.
   https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-email-steven.sistare@oracle.com/

- Steve



