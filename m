Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25333E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQ2o-0001sz-7a; Thu, 02 Jan 2025 13:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ2m-0001rX-CD
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:35:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ2i-0001LM-MT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:35:39 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HXptP023877;
 Thu, 2 Jan 2025 18:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=DRaLkuRP69IaCN0aL9Kxd4giZuFRQoE1xecd3xzzZiA=; b=
 WkV25whBxrctaidoL5tVFAKsb2JvW1MwcGsVTkT5kOzIA7t6K/2dyVMhcEVajivy
 LoNzCAZNjXMh1bUagOg083V2TH/RCN8soVN9fD32femmaeC3u9tDUU/DzHMoR53V
 ZfZU0IWEW75Y5Yu5kIdRAINeHX31YuimX5jhd9x1zq1azZ4kPrCYdXgGOKlqRAoN
 ohnoix69vaeVLhh/XwHUf7pShUo/RWK1DgvKLznf0/9yoAr4Q/Pqi79pnV9a7ppP
 rUgCF3Pexp5klo3/KsvkpGL9HKYNZlT1DF527VOzcIuts7Rg9coXIWOZiz12+N1+
 xYXnAri8KdDoUBrUBqPBBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9chefh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:35:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502H7hr0012282; Thu, 2 Jan 2025 18:35:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s8vkvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkKP8wJLWn8Zkwlv0etDpOvDGt/3WXp9l05U6d6YgTLLtNcrVEFaR2oDwtWTdiwLY7V7ul2R+/2BZomQ7mA57UggYh91TMR0cOyRB5+z1IMrj+Lf/HDV9k9u3k32mtS5qV1pkICQVmgkh03B/lgBWipCQNtX4L5hgbMLmhcwn1qHkDy3OYCRe5Pxel7k+/+6l9aFQ9H5GiUqGi+xKIZCp1ePjhiBOaR9UxGFyLZ5q+9nDc2cDjWuD/t0f9r6NM9DN9nx+94hrVlLhth/outOQRPOqkjXZZnmStoS/qfpbExK7aJpATRZEEizAN2Gmmc5HNOboKluvduCteC8nmYn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRaLkuRP69IaCN0aL9Kxd4giZuFRQoE1xecd3xzzZiA=;
 b=tNdm39JCh/UYEMaWppgzlO4YQU1VzowykdW75y9MC4yCQgZ7/897EJ7Mj3lEjcSidt3JuGSbC7OFEXhVfA/Pf2puOvIak6u2nTGnYcK2EoD41wSBaTBXUIOVXUO1US6xdRoUiQcQoATPorJ41e4zT2r4E8iQtOJZBxf0ZZfGHCoPIPbAs5IvqXqX8WTf91/Ccq+tygaKGW+yDrIJgHJZ/qAkZ8HpZOpG5XYle6wUjxgdBUPot6NCufmBuY4H9wFpPPJ0nNiK3tbmZR6ywGloL5fZn4WnIdztZ11Km0neqPzhpsXEbse4TiYr2oMwxt+NspDFYuDPxU6+CsDmHDEjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRaLkuRP69IaCN0aL9Kxd4giZuFRQoE1xecd3xzzZiA=;
 b=x7Xs8yt8aywgQLL/FvuxcglvymSHD+tgS21or/ML2HNl5ZfNZuDzoI4i40UAgytivCROEokJkcSqLomwuP4AyL6C9AzQyigXk3KcHYBd6Itv4J7V/HX0UciW1lru6ctHanih1m4+6hLqcJz1qLxsyWLKXs30QjAoBCQNfrpUDMw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 18:35:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 18:35:24 +0000
Message-ID: <b8651ab0-2181-4bbd-8166-7e47827ad927@oracle.com>
Date: Thu, 2 Jan 2025 13:35:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 22/23] migration-test: cpr-transfer
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
 <Z2sTHg-t0wB4g3Mh@x1n> <Z2sUO7OoX7UK-DPY@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2sUO7OoX7UK-DPY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:408:eb::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: eda7da29-a601-4219-1926-08dd2b5c3887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnVoaFIzMkZkRUlzY2xHVkhvbEtrVGN6ZWllanpXTUk1T3dzZEltTGtvV3BQ?=
 =?utf-8?B?K2QrakdSWnJ0ejVEeXM3ZlVxam96b0phclY0MTZzNUZjanJHaHhmL2lGWHVM?=
 =?utf-8?B?dk9SUFFMYUpLZFEwcVhGR3FEQUtPUmNSVm9vc2pVZE1wU0ZlSGJnMTk4Mkhr?=
 =?utf-8?B?cWREdUJabHRRZHQrQlV4Uks2VmwxYVY1ZXR6NURqeTNqOXlaZGNTTEhVdHpy?=
 =?utf-8?B?VnFNZDFvQkU1V2s4MGdxNGE5VzR4RkhkRmFkbmdUTk9sekN0eE84YUJUUXFW?=
 =?utf-8?B?ZFcxbEVxbkdaNnVWcHl6UnFyaTNFU1krakhUQmxRQzBpK3dHOWtNWlR1a21h?=
 =?utf-8?B?dFczMEplR0FQcVpRY0UrWDBPSC92OXpHY1k2LzgwdUt2NUxHU0c0MW5zT1Rl?=
 =?utf-8?B?TlJEcFhUSVNkSlBzV3R6WDVjQk9xNFhoalhZdDdBZHdYWG5hNDBidlZWK1ZQ?=
 =?utf-8?B?M1J1ZndkaWZMbndqVmc2Q2R6RW5xbGNEZTZvU1FOVG1WdE9seHAyTkVwOEFi?=
 =?utf-8?B?VFJpR29OZEVxQk9ONUVTL3NrNTlsQ3NSaUk4WDVJZWJzZ2NlVjg4OHhlcGJ6?=
 =?utf-8?B?b3h2L1dRekhZRmFRWllFSnlqUWJNQ2dPZ05qUlVTb0xtT3pqdGk2UitqV3dk?=
 =?utf-8?B?b3lCSDQ4YzlUNS9meUIrUlh5cmsxRVBrd0hFZ3h2eWF0Y1RhYTRlSjJudFE0?=
 =?utf-8?B?bzNackM2YWc2YVhyc1FEVXduS2V1bGxMd0hBOTQ1cVhrSlREcHcvOFJtMDlB?=
 =?utf-8?B?RVJITnhieTNTMkZRTkIzQ1hOb3hGWmw2TXNNMjFsMzZOYXREdVEza3FCdjhH?=
 =?utf-8?B?aTZNKzB0K29PbWp4OVlyZGhIYm5Cc0xEWUlzMlZVWVFzbG5XQVJPUldMRGVE?=
 =?utf-8?B?ZFo2ZlBPNWdBL2Y5Snh4V3RCN0svOTZkU0F2QnpTRmU2RGlMcms5YWRGZi9T?=
 =?utf-8?B?dGdBNTdXSWxLTTJBdG5lWWUxblNQcU5lR0RvMW1UKzJhK0tEcE1GM2tRcmIy?=
 =?utf-8?B?U1NSZHl2emRnL1llTTFIcnl5ZUh4c1BDT2ZzUWRPQ3dJYVdEWUtjamd3dzdL?=
 =?utf-8?B?aVZiVk5zTFVoUDFQZDFsbC9kVzFhWXFDQkxPdVFINXByTm9wZE5TMWVTYlpY?=
 =?utf-8?B?UU1mSXNKRmF6OElYZGcwZWVzVGNUK1ppc3dZYWRxZk55b09nUFB2R1RxanlU?=
 =?utf-8?B?dUlKekhiZ0Y2NFdyZERjVHJXM2JXNC9JT0hVa1FNcGVMRllkTnJJQlNEZGMr?=
 =?utf-8?B?YVVJcjdINElaRkhHeHZLUHhSS1FsaXhVSmdFZzFYTkRPd01ISnNJZndnTjd3?=
 =?utf-8?B?Nk5HOHgyUWJPK1E1YlA2VHB4ZGlzM3d0ZHNwK2kwTU1oTG1aWG5NVk8zQnNQ?=
 =?utf-8?B?azVHdzhwR0ZUT09kMFcxdnh0YnBUa0dkQUlFMzduMkdzNk5nd3BGTkNKRjZX?=
 =?utf-8?B?UzJNZnNtSW9ISlRvUEIrZzBNNDRXZEhNQ0RPQXI5T0s2UzFjd0JNR0lINXN4?=
 =?utf-8?B?RTJZWWErTkFweVdlbjlzK0JvVmJYQlBkUmIvZ2NjcEw1TEVOOVRKa2VsZ2ps?=
 =?utf-8?B?b1BuWTFldEtTNS8zWHM2VEZMaG5TelpCRjF4WTljTHd4TEI3Tk5WcytRc05Y?=
 =?utf-8?B?M2hBeVRsYm13YUU4Nm5kR28wc2ZBWWIreWRDZ2VMQkJGYUx2a1dmSXJKQzBS?=
 =?utf-8?B?WVl0L28rRHZTTjJ3dC96WGNXZDZtcUU5Wm11YUQxQmtjZis3WlZUVE45U2Jv?=
 =?utf-8?B?WXN0VFg1UmJnVTkzWEpiWkVKYXMwRUs0dzlWL0RkdzEzdEIwY2lsUzUxZjcw?=
 =?utf-8?B?NFh2MU1vK004by9tMWNvRWIzdnJXTFFsV2tYQnNwOTFoRGorU1g1THhDUlE5?=
 =?utf-8?Q?oK+v7Fk8QjP+d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01wTnVRYy85Wmc4bWpxUkUyRUVHZXRnYzNLS1FjejVNcVF3UzFLc2dqVG9s?=
 =?utf-8?B?OW4yamFqN3FPOGVxQ1c5NkRBSVFKMUZDSGFzdi9iY01KS1BBZmxXeWlIbHFL?=
 =?utf-8?B?V0s1dTRHR3NSSngwaWMyMFBaVkE2ZHJqaVJGK3RJZklLYTlKeVVpdVVEbHcz?=
 =?utf-8?B?WkNEdTBhczBRaXgzbW9aVTBGc0dCUFg0M2tXV21Zd2VVaytJZlFCT1hQdVFK?=
 =?utf-8?B?MXp4dW9wWVlwMURhU0tVVmpPa0lxUmpPalFjTnVyNE9WQ3NhZzlLQVVMUkhv?=
 =?utf-8?B?K1hzUVROS2RMcUY1L0dLOEZWQm9nRG1CYTNFaUJVV3o4S2M5S1dYdXM0WXlk?=
 =?utf-8?B?Q3BBZGtGUDFkWkxOaVZlbmEzQWJIa0xualMzVjBGL2NsU0dzZVpqK0dEam5z?=
 =?utf-8?B?ajdUS081QVRPcEZQT2MrY2xrOS9EWGZDQloveW1FVjIvbmxBQTliTE94THFh?=
 =?utf-8?B?a3BWTGZSVXF5S2xBVnIvZElIZTlpbGxPV1VqV1RTMVZOQXZPc0daZlRiTzBr?=
 =?utf-8?B?VXJQVXV5RmRZU0w0NFVvU2I3ZkFNUUYxZFg1aDNZVHY1VlFqSEkxWkhyRnU3?=
 =?utf-8?B?L1doeWt3elJTczN4a3FRemVFWkhFMHg0RGRhKy9vWDBBTzRxdUVRcTA4TTlB?=
 =?utf-8?B?KzlTOTRHRUFMaGsranZSekFCOENDakpNV2YzbVcwYjRwQjJJSEFtOFlzVW56?=
 =?utf-8?B?TVBKVTlkd1BBeWVkR1BIbEJ5QWJSV2pTdWNOTGp3V3NlSVoycTREeU5vMFM4?=
 =?utf-8?B?T2k0UitURWFkak5Vb1BuNkRXUGpxdjFUZmZUMlJPTzg0RUlHeEg2VGhMeUhF?=
 =?utf-8?B?T3ZrSzMrK3U2bTlGdFF0NTgwS29XamxhL1dXUk93dlIzYTZmazZnaDEwUzJE?=
 =?utf-8?B?MnZqNmtGMXRBdFlwMnhYcDRod0VlNmRUdnpFL2t3Q0tMdkdHWFNnYm1saVVl?=
 =?utf-8?B?Q1d5ek5HOHR1MWFxQ3VOdGlacm1JN05rdm5OQ2k0eEZpSXJzN3FIb1BlS2hE?=
 =?utf-8?B?MVczay92NFNiVjMrMXNrWkpaV0FuWGZqL2s5bzZCWS82RTV3OE1zbENObmxm?=
 =?utf-8?B?SzI0bXVLaUJDSHlyYXgwOC9SRkZHWjdDbTRPTUNEUzMwWm5NbWtYaDRkUzJn?=
 =?utf-8?B?aURvQXJWUVp3am9hRUR5TCtGTTl5UmZqZnMvSHVjdkY1dUtRc1BnYllXaDVP?=
 =?utf-8?B?S0VoY0xaZ1oxcXJiMGRWUWNsUTIwaEVWb0c3UTBtbnErV0JVR1Njd2dncTNw?=
 =?utf-8?B?TU9nTzZVdUdiZXR5dXluVXJ1QmV3ZTFEZnhuOTVFZGlrQjNLRHdia0p6dko4?=
 =?utf-8?B?MTUzSDZYRVZlVkF5RllsNUxhLzl2eXlFaFpua0tBeFNQL2g5dFh4U0w1eGlH?=
 =?utf-8?B?OHRTSFhrRktlUDNEQWRWWm50QWFJTnRlYTczdlNrNExwSXFMZjAxa21scWE2?=
 =?utf-8?B?aDJ1enIxa25kMU90bFI5L1FLemVRbUl1KzhveXp1U2tKQVE5dTQvNk81Z2pl?=
 =?utf-8?B?UWYwSVVmMzNNcExJMlJNNmxTcGRJZ0NmR3BTRFBUMnljTGpvOWF2andiUDFO?=
 =?utf-8?B?bFZvaWNaWmJSc1cyWCtXQ3NoelBEZzVEZGxGZmZQNS9JMHVMR3hsMU1XbUwz?=
 =?utf-8?B?UjZ0SWl5WVgwOThTZmdKdk13OTR0UHRqUUgvQ3NVaGcyLzRrOGNWc0xySUhY?=
 =?utf-8?B?YUJDQnBFeHBxbkpMelNFalZKaFBkTmdRa3hGaDJKNmtqNGFtY0JudGdZbVJZ?=
 =?utf-8?B?OXBXTTVmYWt0RXNiclBsdEFiOUlWYmtLMER5VHV2VGY3NithMFF2Y1lOUzF2?=
 =?utf-8?B?ZE0zZ2JnakVGK3hubEY4c3pScFlRcDBnR2QyQmpaTW03VjJEeUw2YXVoYmlv?=
 =?utf-8?B?alJGNnk4OTZEUUxLS0RxT2h5bktJMVRLZTEraVNxZTE4VHliWmQ4dzhQY0RN?=
 =?utf-8?B?QVBvNFJmOGVleXlKanhTLzZ5TkYwbFU3ZGJlRXRnYVVsSkxOQ041VWhiSHRn?=
 =?utf-8?B?bXF2MktQSFBrUC8wUjk0cldtSGJ1YmFYeU5mWVhoSXk3S1BWWFZpNEh0UStX?=
 =?utf-8?B?RnhUOVJxUDdDbVRMdXJPOGZuQWJBMC9pSUh1MFZzMVFTTVFScG94OGhHVTJW?=
 =?utf-8?B?RGZqR29wek5PTDVoSlV6N3NxZW5rVDNVMzVRM2lJOXFSZnBhUlkvOUpTcGd3?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 36UVmndEs3IyeiJREAT7Zn540MP723s4QAPLRijMBLEIg0nptQfu7zDvJGXrVTMTRj/diIoM4Po8E9UvH8FNUQTUnHch0aP410H12XT6p28HXSVOKhp3G+oLXmC7rOpx0Iu8nC/Fr/7bCaj5XhX8DcJfYjj/ZDSB/zqdJ1vXinFrtLBF9v2GfbqzDF0LeiQAsMb6Is1+WQTbKO7QgSWC5R1F+A7FOFcoWi6JqTYrcalhe4SBrX6wqalKzXiCz7en8RZiBZ9PRMp5ncyd2/nD+Jo5WMbmyGHjj4loj5p4NXIqP/yVBS6S3Wr/eZK7QC//Lyo1VHhDOEnldxLAiEWxyguX50lIJcU2VhYaYN878uxgEdauacvHejPXRKUcN8/SVJongrJOGMIAwpJz8tGLNyuQDb48gksNpem5mWUGo6CIlqnDEknLI9jvg0I6YaTT4Az8TRK4YyP201zZ9pibEdnlsBBLKnxgS31CAjonUs543HecMT4aOrxucj4lLbGnO+Gl85xPyM3/5O8wf7KJ+5M5/b6XSTESgNrCTToq1g7gPstFYcOz4tlZJv1EfVP5br1kR4hVsQlNQKJ2KtjKi2D2hOglxEUmUIiVcKENcSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda7da29-a601-4219-1926-08dd2b5c3887
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:35:24.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSwBeShnYjM/GIuWog8apNAfVGf7hSIGBRC1ELqrbre2osVBtNnCD49s+n3Mz3FF+e6TrKsPwM9y4t2LCxo98jVRmyNDARCXbhwjc824h3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020163
X-Proofpoint-GUID: FH-_0NOwFUVZkECSTqwX2zDQ1yald5cO
X-Proofpoint-ORIG-GUID: FH-_0NOwFUVZkECSTqwX2zDQ1yald5cO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/24/2024 3:06 PM, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 03:01:34PM -0500, Peter Xu wrote:
>> On Tue, Dec 24, 2024 at 08:17:07AM -0800, Steve Sistare wrote:
>>> Add a migration test for cpr-transfer mode.  Defer the connection to the
>>> target monitor, else the test hangs because in cpr-transfer mode QEMU does
>>> not listen for monitor connections until we send the migrate command to
>>> source QEMU.
>>>
>>> To test -incoming defer, send a migrate incoming command to the target,
>>> after sending the migrate command to the source, as required by
>>> cpr-transfer mode.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   tests/qtest/migration/cpr-tests.c | 60 +++++++++++++++++++++++++++++++++++++++
>>>   tests/qtest/migration/framework.c | 19 +++++++++++++
>>>   tests/qtest/migration/framework.h |  3 ++
>>>   3 files changed, 82 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>>> index 44ce89a..b221980 100644
>>> --- a/tests/qtest/migration/cpr-tests.c
>>> +++ b/tests/qtest/migration/cpr-tests.c
>>> @@ -44,6 +44,62 @@ static void test_mode_reboot(void)
>>>       test_file_common(&args, true);
>>>   }
>>>   
>>> +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
>>> +{
>>> +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
>>> +    return NULL;
>>> +}
>>> +
>>> +/*
>>> + * cpr-transfer mode cannot use the target monitor prior to starting the
>>> + * migration, and cannot connect synchronously to the monitor, so defer
>>> + * the target connection.
>>> + */
>>> +static void test_mode_transfer_common(bool incoming_defer)
>>> +{
>>> +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>>> +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>>> +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
>>> +
>>> +    const char *opts = "-machine aux-ram-share=on -nodefaults";
>>> +    g_autofree const char *cpr_channel = g_strdup_printf(
>>> +        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>>> +        cpr_path);
>>> +    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
>>> +                                                   cpr_channel, opts);
>>> +
>>> +    g_autofree char *connect_channels = g_strdup_printf(
>>> +        "[ { 'channel-type': 'main',"
>>> +        "    'addr': { 'transport': 'socket',"
>>> +        "              'type': 'unix',"
>>> +        "              'path': '%s' } } ]",
>>> +        mig_path);
>>
>> So this test already uses json-format channels, IMHO we probably don't need
>> MigrateCommon.cpr_channel anymore?  We could put them all here. Then..
>>
>>> +
>>> +    MigrateCommon args = {
>>> +        .start.opts_source = opts,
>>> +        .start.opts_target = opts_target,
>>> +        .start.defer_target_connect = true,
> 
> One more comment: maybe we can even drop defer_target_connect.  I don't
> expect any non-cpr test to use it.. so introducing the parameter may only
> complicate MigrateCommon struct with almost zero benefit to be reused.
> 
> If to drop it, we could detect "cpr" channel in test_precopy_common() and
> only defer the connection if "cpr" channel is present.

I hear you regarding lack of reuse, but I still think defining this single
field is the cleanest solution. It is tested in multiple places, in different
functions, so the search for cpr channel code would also be needed in multiple
places.

- Steve

>>> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
>>> +                                " -machine memory-backend=pc.ram",
>>> +        .listen_uri = incoming_defer ? "defer" : uri,
>>> +        .connect_channels = connect_channels,
>>> +        .cpr_channel = cpr_channel,
>>> +        .start_hook = test_mode_transfer_start,
>>> +    };
>>> +
>>> +    test_precopy_common(&args);
>>> +}
>>> +
>>> +static void test_mode_transfer(void)
>>> +{
>>> +    test_mode_transfer_common(NULL);
>>> +}
>>> +
>>> +static void test_mode_transfer_defer(void)
>>> +{
>>> +    test_mode_transfer_common(true);
>>> +}
>>> +
>>>   void migration_test_add_cpr(MigrationTestEnv *env)
>>>   {
>>>       tmpfs = env->tmpfs;
>>> @@ -55,4 +111,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>>>       if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>>>           migration_test_add("/migration/mode/reboot", test_mode_reboot);
>>>       }
>>> +
>>> +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
>>> +    migration_test_add("/migration/mode/transfer/defer",
>>> +                       test_mode_transfer_defer);
>>>   }
>>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>>> index c6ea3e1..f6175de 100644
>>> --- a/tests/qtest/migration/framework.c
>>> +++ b/tests/qtest/migration/framework.c
>>> @@ -411,6 +411,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
>>>       qtest_quit(to);
>>>   
>>>       cleanup("migsocket");
>>> +    cleanup("cpr.sock");
>>>       cleanup("src_serial");
>>>       cleanup("dest_serial");
>>>       cleanup(FILE_TEST_FILENAME);
>>> @@ -692,8 +693,11 @@ void test_precopy_common(MigrateCommon *args)
>>>   {
>>>       QTestState *from, *to;
>>>       void *data_hook = NULL;
>>> +    QObject *in_channels = NULL;
>>>       QObject *out_channels = NULL;
>>>   
>>> +    g_assert(!args->cpr_channel || args->connect_channels);
>>> +
>>>       if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>>           return;
>>>       }
>>> @@ -725,8 +729,20 @@ void test_precopy_common(MigrateCommon *args)
>>>           }
>>>       }
>>>   
>>> +    /*
>>> +     * The cpr channel must be included in outgoing channels, but not in
>>> +     * migrate-incoming channels.
>>> +     */
>>>       if (args->connect_channels) {
>>> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>>>           out_channels = qobject_from_json(args->connect_channels, &error_abort);
>>> +
>>> +        if (args->cpr_channel) {
>>> +            QList *channels_list = qobject_to(QList, out_channels);
>>> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
>>> +
>>> +            qlist_append(channels_list, obj);
>>> +        }
>>
>> ... here IIUC we don't need this trick to manipulate the qlist anymore?
>>
>> Looks like if with that (convert the current cpr_connect string to JSON
>> format, attach it with connect_channels), then we also don't need the
>> pre-requisite patch to make connect_channels manipulate-able. Not sure.
>>
>>>       }
>>>   
>>>       if (args->result == MIG_TEST_QMP_ERROR) {
>>> @@ -739,6 +755,9 @@ void test_precopy_common(MigrateCommon *args)
>>>       if (args->start.defer_target_connect) {
>>>           qtest_connect(to);
>>>           qtest_qmp_handshake(to);
>>> +        if (!strcmp(args->listen_uri, "defer")) {
>>> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>>> +        }
>>>       }
>>>   
>>>       if (args->result != MIG_TEST_SUCCEED) {
>>> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
>>> index 1341368..4678e2a 100644
>>> --- a/tests/qtest/migration/framework.h
>>> +++ b/tests/qtest/migration/framework.h
>>> @@ -152,6 +152,9 @@ typedef struct {
>>>        */
>>>       const char *connect_channels;
>>>   
>>> +    /* Optional: the cpr migration channel, in JSON or dotted keys format */
>>> +    const char *cpr_channel;
>>> +
>>>       /* Optional: callback to run at start to set migration parameters */
>>>       TestMigrateStartHook start_hook;
>>>       /* Optional: callback to run at finish to cleanup */
>>> -- 
>>> 1.8.3.1
>>>
>>
>> -- 
>> Peter Xu
> 


