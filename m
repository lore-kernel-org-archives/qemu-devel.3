Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8203CEFC43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFuX-0005MA-Gv; Tue, 08 Oct 2024 15:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFuV-0005LO-Gv
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:30:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFuS-0006b7-MX
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:30:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JSXw6014203;
 Tue, 8 Oct 2024 19:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=bE2e7do6mqsghEEF0ZvriwYBw49rgd5YC7rysDwBbng=; b=
 j/ROur9I/XJMZsx0mPuzQ5iPFz9Rt8/j7B83FMAfZSYbIKk3UPBgJxtAsMiT35kj
 7pIX9o3t3Q0HFHU35YzeYIx0qW3RwJmgxgYent5QBBEf25mQokgb7bj5jTGWMdZU
 LRbf4VlRAO5rLyTiaqv7dYNWOds+ckAddXEbbbNxk6kqM2zXm0HUYHEMCtRRC+6q
 B8TBf7xXdCB0SLFOZ8sbaNS7zmrOcrmY4NW/yTnLpnO79Y0yjeQqlRKUhP3Baxpv
 vsB2Fd8PeaumQwOTk+uTVVtf+yiLCInjX/+OMnA9GbPfr11UsZ0C+ZX1yBlQ1DHZ
 K1TkhlN9oe2l8Y8PuYF3bQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pej3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:30:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498Ivxup038325; Tue, 8 Oct 2024 19:30:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7pbyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGDY1tQIAbFeBaMEo56cJzOj65TQvxLY20XL5A+1ciAAjOjpk5eBUCcnxHbN8nW2OMke/oKL4ktSE2Zev0+XSAQ3PnfAV1dvAvLgst77TCLy2P0UDCF7u4PM+V9yhPS3ORwkDbEfK0wJy95BMcNruTLY/y4opE3MmrA8g4SX1eZhpN/rNIpZ5H9xby0RkPgspy+ngSCc2mIoDp7H8I/5HKSADQv/HH7yfyys/dFWKfsjvACD+2rd06qjQNE5ShlWvpO4q9K17wJyw3F0Hptrg51xaCeiygV/9kh6ooGDYDwSwr1pBrrWBiZ0HGsOZPJlVp4oZHG43Dg4NtYjZWfv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE2e7do6mqsghEEF0ZvriwYBw49rgd5YC7rysDwBbng=;
 b=tvYqYpSjBrLiZ+zLZyrvW0SMphsrQJffBhWLdCiofk6tp4EYXnRnqVxK7UET/h3Lh8Gh33FLhN0X2rbHkwZ1rk6zEKy7wVeSjdPNAZz1AJ27nymvyHIxP5dyfrDZ7ZZyRx6wlFcPLUT3tW9ue4mxssGiXiUW3NqMrIV9buJY+y5E54BdP/dWP28F9Lo2/Fl3T17aK+mZr0O6L6DXj72IkJxnGwZzHC3PF1bruGS9lHo498MB0mDv9b2A6trmDG/b16xJdU+EEz5x2/OGKbndFhEffJez1W/qubfGfoXK9IRzkZ5W6TmwyyOKgXb3wG+JDshtnwZvfGU68NnCO68Ehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE2e7do6mqsghEEF0ZvriwYBw49rgd5YC7rysDwBbng=;
 b=adBXkBjU1y1tI7Bh/bhiUGaPARWnjWlzfRmhcTWT3JHvVi4EYVJJlKtzD2gXZD+EsUK6VkmsIs3S0ADS3/R5z/HdjsYKuvpDvpPFAhARIcjTN/TjIO81sJvc9HLeSxsJTu5cCmLktEres+Q68zRN/ucgAwPVPmuq/Yey5Y2O7Bg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 19:30:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:30:03 +0000
Message-ID: <307fcc79-4d90-45e6-bca7-8adeaab06e2c@oracle.com>
Date: Tue, 8 Oct 2024 15:29:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwV-NRICDNTajTRq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:a03:80::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a777e15-d5f8-4b2f-0c50-08dce7cf9bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3F1SnFqTHZtWUwzemtwSjFXZytzajVnQlgvWno2bjErTXZiK0VRd3BuSE16?=
 =?utf-8?B?ZzF6c1drU3JVOEpRRzB3S1ZVRFBMcHVPa2Z0cWNndjErNjA0WXFVU3FuWWMz?=
 =?utf-8?B?eE1ldmw1R1dZSGJ4V244Q0diQVhVN0hFSDl5YXRHdVJ1K0Z0bWt1cy91TXdr?=
 =?utf-8?B?SmNHNVYxdHUvMDlkYVoxK0kyY1pRclo4WmxJcXMwRThWSUVKMWM4RTZNR1g1?=
 =?utf-8?B?Vnc5YlBQaGhUdk5wcEtkRVc4bzZhWmtTK1RuSExMMC9rVGhmSm85VE9VR3RL?=
 =?utf-8?B?SEphQXNNTHhHRFNaa1VpYzlZcTNrOWhUNnVrdkFLZFl4aFRyejdPWENIUWFv?=
 =?utf-8?B?RHBULy9jWUlnYjJBb0FWUmFCNFN5ZzVyKzRXNWlPMVdMeWMzRDlpck9BWnlQ?=
 =?utf-8?B?V2JMdzNIV3ZsY0o5cTNwYndleEVTeGI4Q1ZCQzNScW5JZ2k4U1J6M25PQmUx?=
 =?utf-8?B?U3ZaT0RobmhjcHFTb0VlNUdDZlVNN0MrTnA2d1ZaV0JHblltbWtFaW5jd1p6?=
 =?utf-8?B?dXppYy9qaitFcWd5TkpGUXZFT1FVYUd4MWVBUW9hTXU3NjVBZW5qRWZSMWhG?=
 =?utf-8?B?ZmRXcldZSjFCejAzUHc2QUdxNEVSN0VSYVBCcG80NWgxUzJIcHM5ckIwNk9X?=
 =?utf-8?B?NnNONlFVcmJPQ0Y0RGxpYmZHUHliZFlINkFnODd1WDNKQjg5VkpDZjF0MUty?=
 =?utf-8?B?ZUtwWHRib2YzeVlTdjM0UFkvTVR2ZDhXdlZHWUNKTStFaEUwdkMxWnU2dmhN?=
 =?utf-8?B?ZElZWjVaZDZGSHpKcytMR1QzZjRvZ1RGbWVvSUozRExDc3V2Nk5GZmxsNFJK?=
 =?utf-8?B?Zi91ZFVBSStGRkU4T1RVTFNYSjhDNStYT282Z3h0ZURzVzdRUTQ3empCdFJw?=
 =?utf-8?B?QjkzV3VXV0o4V21WZGs4MWlYblJVVGg2d2lDSDNQTmdTOHZuY1NoRkkzcXFX?=
 =?utf-8?B?TkptK1lHbjdmVlBaUWVIN3lCcGpLSE5oenJBeGgrSGt2U2swZXA3T2djTEpC?=
 =?utf-8?B?Wk1ySkNUSTh6alFRaTFaVCtwdGU1TUgwNVRtOVNIVDNuWUozUzRJL2oyb2V5?=
 =?utf-8?B?QXdkbFZRc1VQTVJxSjlQLzhDaUJZRUpkWEZoaXlFOENSQ3VpSUtET0U4Tlcw?=
 =?utf-8?B?QXdnTUQ0UitJOEpOT0VjTEZoOFF0Nkg2cEw1NnNsV2FrQnVQVjRMRTFLV2t5?=
 =?utf-8?B?UU5JQyszTldiNXV4R3J5QXEzaUlweXd2OVRTNG5ZNFFTaUpLTnlLMzFTdGRY?=
 =?utf-8?B?THl1dldnYnN2NksyZUM4aUY5dnBqUThvR2RXMCswTkJMR1VvcHNhblR2b0Zu?=
 =?utf-8?B?cDFqT1hxeGhKOE1KN0l3NXhMd2xnVDNhRUtnS3phVDJDRjZ3MCtkM1l5UjVG?=
 =?utf-8?B?eTFIZlFqaVF3WG50elNjYk9jZ3JOdmZScUtUdE5uaW5jVEJEN2dmV0ZBblpU?=
 =?utf-8?B?blBCZHp1a0VWOTAyaGRsS1N6d2dxQ1hqVkFDOG5TdHl2bEZsUTdmeVdPTlZX?=
 =?utf-8?B?aE45QjE0bzZzQy8zUmxBSW5rSEg5Wm9QSDU4UkhQbjhYQ1FCRG9EV2NvT3F5?=
 =?utf-8?B?SG1oK1JVV1BXd1VpYnhEaG5qc2JJVU1xVkFDOWs5OVk3RDFhMk9mU2hweVor?=
 =?utf-8?B?elVhZmdEY0JqZjRIZnJwOG56aGxDcG9WdjgzMnZqY3F5TWRMelZCaDlXZnI5?=
 =?utf-8?B?Y2tROXhyaGEyOUNsVXBVVXFMYlY3MWpFSnNwL1ovcFNOQWJGSDFFQzl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdWR0hQdzhkRTlETWx0ckU2YUZyQjZEcHFvMDh4bmJYRVh6UWtjWk1sc2ZB?=
 =?utf-8?B?WW5KdVJjZlFPNjhTcEZ4aVpXWERSM0ozWXE1U0tyWGhMS3BOb3J0Q0ZNMFYx?=
 =?utf-8?B?SUJFSTZUdDQwTlo3bENUQW5GYUZxVTNHaE5tc3pGOTZxbkorK0VwWWdua2pQ?=
 =?utf-8?B?UzJqd1pMZjlMS2ZoUGRTanMzbUtIS1c3ZlVlYmRRVlk1NTZvblBjOHQ5U2w3?=
 =?utf-8?B?MkovNnVGcWdQZjNFb3IzRkdyT3JKcTBSak00WE0xejVSSE5LTnlRb1loUkw5?=
 =?utf-8?B?RjA5aXRYdnFVWWJQNEdxMEc1MnRsZ1krb3JtZ2Vwc0Y1NzIxZWNBUms5cm02?=
 =?utf-8?B?NFJsVGZCdHNXY0I4d0pjUE1Gc25yV2Fmd0JFeERpRzVxTU1KQVZnQXl6bmdp?=
 =?utf-8?B?NkkwaVBnUHBneDdhUWdRNGdyczVSOFdzN3J5bTU2Z2ZSY2xJSExPNi9kU01K?=
 =?utf-8?B?TXg2T0hwdzFDSHpzTUY2T20xdkpQRXQ5bzhlRElZZlM2MlZEbmFYakNPaWZu?=
 =?utf-8?B?QWZsSnk5SzhmUEVJT1lmci92akZpdHRmd0x0ZmdFcHgzRzZoWFRRbGlnbFBq?=
 =?utf-8?B?ZEFEdTM5cExvWTFSWmlJcGZ3U2kxUWYvWW02TFNaZkZDcVVTYXFmZmZ3YTJl?=
 =?utf-8?B?MzBvcjBDMXY0bGFJeWZiTnI2YmF2b3hkUWJxVTNHWWZrRC9hdkh3M1NIMVQ4?=
 =?utf-8?B?NTRYblQxQkxqTXpRdFFtdHhtSjcxMGpzZGhZTWdRcjNHMVhVL2FGNzhYalJt?=
 =?utf-8?B?VjJjWGppZlI4T0YzZGdhYkY5Y3kxNkN6eHg2Y2pFbS9iK04yNXVobnVSdC9s?=
 =?utf-8?B?ZXVmay9sMWd6ZHNKU3JhT0tuMGtiWUt0TGprSk8vdE1HaEFJdVlJNzZhS0tT?=
 =?utf-8?B?eDJJYkhjUERUckFWL1hHUEQxU05Va1phUXg1VndyUXlvL1ByYnZFZFVjTUZU?=
 =?utf-8?B?VEdlVEdwUTcraW0xaytKNmhVZmR5TFZMY0dVaW85UUMwdkRaS2hYekpKbWQw?=
 =?utf-8?B?MzV3NVl5bHY5TEVRV0RuUXVOc3ZQSUZLRk5ESFd5a2NlQVB6dk85dzh1Vysz?=
 =?utf-8?B?V3hjbmZRdmpmVU5rc2VRbU16UDJaN2tIRzVnZUdzaUJyQk5vUTJSNzZHR251?=
 =?utf-8?B?YWNBQUFIY0RtWTJyNlptZk5MTGpidVU1NDJtcGliYVV4R0FxL2VXUmIrSkFT?=
 =?utf-8?B?K1loem5ZdWRUU3pvZGswTFQ4NkdqemxIYmZQVDRKRUZKUVZVR0xVanR6WXJU?=
 =?utf-8?B?c1o3SXU0aTlnNGhMT3RTS2xNT0ZoaSsrYmZDWldQY09jeXptek5meER6b2xS?=
 =?utf-8?B?TXFzMlhjaWFRM0N1dGEvM1BUOTZ1UmNrbEk5K3QxRlpMQzF1OWo4N2Zrdyts?=
 =?utf-8?B?SWpUOUlkWDNXalFMeDdPQzl0TklYNVNYOWlFbmU0OEc3QThOWVBTcDY0ZHc1?=
 =?utf-8?B?V1B0OUdzNU5yeWZyekdPODBhd0o1bHJxcG42R3ZwbVJXc0tMS3lNd2lHOWhu?=
 =?utf-8?B?UU5WZXJIQ3BjWXNlWUt6S1dFd3pwMFVnYTdWVmlrK09TV2FpMTFmaENrWDVP?=
 =?utf-8?B?ZzRZTzA3clBwZVUrN1loMlNSUFZoYkQzMDRqNTNPU1U1eG1xK1lMc3RRZGhn?=
 =?utf-8?B?cS9HbURsZExiZDZPcW5Bck4yK0VJRTBYaHhDOWJzTHI5eEl5Z1FIaEROckJa?=
 =?utf-8?B?L0kyQ285SDNBMFhweE5rcTQxNW1BbzU5MSs4TnZMcXRUTVlzQ04xdzdYcmpN?=
 =?utf-8?B?bFBNN1Z0bjU5V1NGcHBsT1o0RFlESE1oV01TVFRSZS9rcDc4WDUvZjhTc2pB?=
 =?utf-8?B?NzVFN2FSUUN5ZjB1VjRwdzd2U2JneisxeVlrZzkxZWNXTWd2VUE2c3p2Q09l?=
 =?utf-8?B?OTJEUEQ1YitxMHJtaUl2MXlndE1WOThkWE91TkRWTG9nUnZ3bG94aFRZKzZy?=
 =?utf-8?B?NzVnOHgrREl5NmVsWmhEOVUxQU11RG5UODBadU40OWhOSENCcXZDTFdzby9U?=
 =?utf-8?B?RWJ0V1ZhUTdaUlllSzlieFNsU2pDY2hIK0ZWK2NBUi8xZWR6L1U0eElYMEsv?=
 =?utf-8?B?Tzh6M250UzRBMDdOT0xqbVVwRHJSVFVGei8yQ0E0Z21XbHl0aHZZYzdDYUpB?=
 =?utf-8?B?SUtHS3JHQ2dKZFAwNitaaVkvNmt5SlFuOVhyWGIraEdVMzZKT28yTVA3QnJQ?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bXtGq+0Fl+Vh1dGoul5lXv4WCWFGf91WjioIH4ex5o9Feog3Yg6MUE46QhEk9PhDQWycQKUEpR0qxzpDxfrsqi11svvDeoEQ60R5rjDwsxAtvNltzYZMmti9w7s/doLkGS+LT7/IBpqLhHQTjfC9CvFcez9FAP7hXqBaQGSKiBu/uOchM8z7dFcQJt3IWPjTA0vY5LhILLgo5pJ6kbYLXbJKPWfb6jsGHEI+MO77KZNTHtdO3okTW3PfdXqlHw4Bwv4lDNC7TkZ+bfl31E826SzCfyD3hulqy0TIehFgZEjbYrs2ty5SQATksZG2u7e7SNG40YadmQqwCFRHqtNL6MX6+aL52oqs9ApBLDmHHRg0nUdp9Up5puA2L1trsFaeIS31VkV5gs+V3hwh2fYXQbIe6jrEDP1zqVC/PThVCxwxT+RJPfTGKB4YZBo4uvUPkrQhuJL9McnRvCe16V4ZG1hYlQw6jUuJEg4bKAxhjT6ajJgHo5mBtZvfkLG9gMHtqrqMaoGJkHpkM+jXuhOggYwIEY26pf2VOC8k/M2cnMO72waBE+4K4q3tdmG4/3jl4S4WsyZ7liqAA9Dj2aQFRhSLDlSFFezZHzf9oZYoqzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a777e15-d5f8-4b2f-0c50-08dce7cf9bb8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:30:03.8108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3WJSzlv38O7fWY+BCXftknW3CVaNB1ji9lgBQ9kfDTVIwGlhSH0MrD74/kVfd/V33Rlgi5VotlH+CSSclpyIPGb0i7GoLW9f2eqjXvi3Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_17,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080126
X-Proofpoint-ORIG-GUID: cl4m_CMqVt-7aEjJKyDizsDpw_36Sgk-
X-Proofpoint-GUID: cl4m_CMqVt-7aEjJKyDizsDpw_36Sgk-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/8/2024 2:47 PM, Peter Xu wrote:
> On Tue, Oct 08, 2024 at 03:28:30PM -0300, Fabiano Rosas wrote:
>>>>> +    /* Close cpr socket to tell source that we are listening */
>>>>> +    cpr_state_close();
>>>>
>>>> Would it be possible to use some explicit reply message to mark this?
>>>
>>> In theory yes, but I fear that using a return channel with message parsing and
>>> dispatch adds more code than it is worth.
>>
>> I think this approach is fine for now, but I wonder whether we could
>> reuse the current return path (RP) by starting it earlier and take
>> benefit from it already having the message passing infrastructure in
>> place. I'm actually looking ahead to the migration handshake thread[1],
>> which could be thought to have some similarity with the early cpr
>> channel. So having a generic channel in place early on to handle
>> handshake, CPR, RP, etc. could be a good idea.
> 
> The current design relies on CPR stage happens before device realize()s, so
> I assume migration channel (including RP) isn't easily applicable at as
> early as this stage.
> 
> However I think dest qemu can directly write back to the cpr_uri channel
> instead if we want and then follow a protocol simple enough (even though
> it'll be separate from the migration stream protocol).
> 
> What worries me more (besides using HUP as of now..) is cpr_state_save() is
> currently synchronous and can block the main iothread.  It means if cpr
> destination is not properly setup, it can hang the main thread (including
> e.g. QMP monitor) at qio_channel_socket_connect_sync().  Ideally we
> shouldn't block the main thread.
> 
> If async-mode can be done, it might be even easier, e.g. if we do
> cpr_state_save() in a thread, after qemu_put*() we can directly qemu_get*()
> in the same context with the pairing return qemufile.
> 
> But maybe we can do it in two steps, merging HUP first.  Then when a better
> protocol (plus async mode) ready, one can boost QEMU_CPR_FILE_VERSION.
> I'll see how Steve wants to address it.

Our emails on this subject crossed.
I agree that an async channel both on send and recv sounds like the way to
go, but I would like to keep HUP for now, and pursue that as a future RFE.

- Steve

>> Anyway, I'm probing on this a bit so I can start drafting something. I
>> got surprised that we don't even have the capability bits in the stream
>> in a useful way (currently, configuration_validate_capabilities() does
>> kind of nothing).
>>
>> 1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake
> 
> Happy to know this. I was thinking whether I should work on this even
> earlier, so if you're looking at that it'll be great.
> 
> The major pain to me is the channel establishment part where we now have
> all kinds of channels, so we should really fix that sooner (e.g., we hope
> to enable multifd + postcopy very soon, that requires multifd and preempt
> channels appear in the same time).  It was reasonable the vfio/multifd
> series tried to fix it.
> 


