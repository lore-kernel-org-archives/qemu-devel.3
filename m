Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A73CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHj5e-0000k9-T0; Wed, 21 May 2025 09:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHj4w-0000Zn-LX
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:01:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHj4r-0006gb-Ue
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:01:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LChE3f006439;
 Wed, 21 May 2025 13:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=owdp5Tfm0nz0ylYNgY8bq7P+DVLNtdnVJZ2trO0S5fg=; b=
 Vlw18ol07O+PHM2p8AcCgEBtHcYvVGnId7bOwmep6ii4/e7oGHsklNW295CJpqGe
 jgjkolK/1XHV1zk01IAYLTVezlctmW2C9Lhnk20eyGV0fs8DVNBfH06+370x420C
 EnfC/fH6kAFCwSdRBet/XqZKicx+8JfJiEX/03Y6rkYf+VtQbo7vproddYwC39Xw
 VGRTAXYDwFhEay9Zp/7HwVdqr2g3yDbdVZklkPTo6ozzttetNjsdEkAaxG3ikSkv
 lPMqIYXEPgJAjz0SZ21+hWK3tGGXS4Bcl/ZrnAKchjAByQoKn8VGOHZCc2CRCS3Y
 yUhEzot+CLP7H9TEfCJgfA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sf2m02ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 13:01:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LCCNRi001744; Wed, 21 May 2025 13:01:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwesarre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 13:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nljwh6aV007V9ywwQByFIJUGgKOlOZ2adwP+phG9ksrSyHDd9lWs9XFIicusj63FzcVX/3/3lzcwQpZ+Wk+YFezwAgQ04i4D/liY+4CS5se8wa2/LZO5xjw3YBkYa0NgqBDZ5sPSgfJPlmoShIgjOKM5ninw5xk2Eowh6BcQ5TCayt6WHZmhtNhx4UhdBSnAz1MBqm+pxb6NrRt9Fhl6xcwaHhcbqLTQw2XiF7UrLBAyvUYgs75HV2ik9E555+ldHe/3DczzeaaXyLp8rv5Y/5n5QTkatlxa8Sqj2e57mKe2jolL5+r1lZupP9HFxvObBaWmdOsktD3qqFgaodp6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owdp5Tfm0nz0ylYNgY8bq7P+DVLNtdnVJZ2trO0S5fg=;
 b=RM5NQA0mgYgu5tRhTE1lJERr/47cV42hyjKDaWtIzaUSz9vozHwtafKmsJ0gq8WXN4Doy/92FcI0SYLarmUbhywTpk5JLxeKn80o9iiKIp9PYaAXj+/MKlOrBzVmWvv1/Z3aCQniVnhXer626lwEQVkmOw8631+3aIqvoOhEP7szpXPseazsS16W/65AMO0xcPWR8ql2kbsJM0hdQeLsa0Ez1Bs1B7ffZAJoQPu6jj/plbSes5PrXEC8Pw6Ir6biMi5fLE/aOHolOLOcnR0fSnJQ5OD/+AN+M3E/keNQTMbQl2zm3RNizx5Ac9eME9xUnqfCXcZJ4Pv2P9u7jmhBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owdp5Tfm0nz0ylYNgY8bq7P+DVLNtdnVJZ2trO0S5fg=;
 b=zWz605CHd5lybhTXbPVoDJKWKtECBWBC9qSLBENbDWiAEAgHEAqA4LGZLz4sI4ED4uWaweQIUcOmyfEjQL/D9eZ+w/ZpDSD5RXaA5+WzNg7K/NYvxJDy9Bumhq7VIsHNMW9zTBKSmRFHBmkwSDcJvw/VnfoQOSnu9p0evCQyxSs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB7939.namprd10.prod.outlook.com (2603:10b6:408:219::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 13:01:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 13:01:38 +0000
Message-ID: <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
Date: Wed, 21 May 2025 09:01:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: f5870004-1e5a-4e88-a2dd-08dd98679f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkplRkhPemtRVGZLZURDUWdPSXhNVXo2SmdZN0RvVmszNWlWWk5GQjVZb3Mw?=
 =?utf-8?B?WFhNSStFSURRQWgrTUt0aEptZW5wOW01bUNZOEJ1MWZXQkdPNmdCNGJqTGNn?=
 =?utf-8?B?UEY5ZjdFT2U1NVBSaGJzd1N5RzFzd2FOYjdBZU1Ma3Z3N2IvWlAwMkhMU2Jm?=
 =?utf-8?B?VmlHOUNObWhVNTJQV3Fsb3BHV1FHNmZQMy9FcXBrdmMwdWVWcE5yMkgrYnN4?=
 =?utf-8?B?RmVTYTRCMXpNek5vVnpoSGRrMWJtb3BSUWIzYmlxMXRVZmZEYnZ4SzJkamVK?=
 =?utf-8?B?SmNjNS81ZWdJSVZseDNjNWxYNzRiQ1dFejVUem1MWGRTcUZUN2x3RHNWcXJj?=
 =?utf-8?B?Zkh5RGw3aE9jRGYvUzg2S0YzMHhTSWNaelBxdmFCcjhiTDg2MldVY0lmUTcr?=
 =?utf-8?B?QzJMR3NUMVBhWE5WSVRuUFdCempkZUN2d1RLM1p2cXZPUVNBSFpPRGsxV1ZH?=
 =?utf-8?B?ZHF1VCtJUXd4cmxFSTVKcmNySTFhUGpXVUdHeGJZK20yWS8waERlZzdEeFhx?=
 =?utf-8?B?Uml5ZDZodnU4WGxLN0NKVW9VeDdSQkxlbVkzQ2RiL1N2S2k5Y1U0TENzNUpu?=
 =?utf-8?B?bWZjZHhoRk52Q0ppL2x3TDEyQVVITWdSTlNHL25OZ1lSV2NSTzRCOE0rUjRD?=
 =?utf-8?B?M1hHS1lUR2tCUzZqV3lKcnBndU1mdnhZQ29NZEZFSUw3OE9MS2FIZW9YajdT?=
 =?utf-8?B?bDFDcGZsR3hLWEtJTHd0YmlwNmZvT3E1VGN4YTk2YUhZU3ppaU0zeE9iOWxx?=
 =?utf-8?B?LytKNEMwazBKVWJuNmM3T01EblF1RnhCTjJTZ3FFdlpwd2FoOVJNRy96TnFK?=
 =?utf-8?B?VjYraXorbUlBemhpaytKY2Q4RTdzTlV1c1RMY1o2VW50RTJZMCtsU3RvbHk5?=
 =?utf-8?B?VlFwbXRrdUpDY1JlVEozUHVVek5qV2dZVGtvRlRraEc2UzJWN2doaWZOOTNS?=
 =?utf-8?B?dFk0L05kQlNJMWRNTHA2Y0MzVzd0QkdsMkQ4YzQyVWkyK2srUE5FRWp0cDhw?=
 =?utf-8?B?NXNBR0lrNjliY1U0V2s1M3hvUVBGNkVZSkRWOHhPSDI5L1pTZE5Ea2R2WTl6?=
 =?utf-8?B?bGRjR3JYaHA4ZkVHWGdYbHFoeE5SMk42RjJvbVh4ZzRqaG9CQmN2azFBWGc0?=
 =?utf-8?B?dEIyNjBQanhZWFhqdk56ajlibnF2U1Q0VzR1MFU4c2JtVXovM25UVXlRN2xW?=
 =?utf-8?B?RnpkcDhqb1FDd1pyL2FFUVRvdG9JRWExWWRUbVQyamc0aUtuQWo3UTQ3SE1N?=
 =?utf-8?B?L0ljYzVQcGZMejhEWFJKVG16R0ZDQzY5VzZ2Tk9aUmtzbXZYT0hpK2pBenh5?=
 =?utf-8?B?QVNXT2JYM091VC9ZaGQrald4OUhyNllneWtIc3RCNlUzUDZydTh4ZkFQUHZW?=
 =?utf-8?B?a1lsSTN3MklvdmpVV1p0TkJZa1ZTTkp6K01GM1BiWXJhU2dhemRoZG05MmtO?=
 =?utf-8?B?eG1LbFdXbGZHazRIQmJrZVd1UUk4ZElGa1dHYmd4ckt0UFJjODdidWJzOWkv?=
 =?utf-8?B?cVo3VHMxNGJjNEtsQlRuWjBFeU8zU0dEUDlrS240MGtycmltSUQ0SkllY3Rz?=
 =?utf-8?B?UzFWOVdxd1JTN2wxLzlqVGtwaFJTSUhjM2Q4K3FNckxNRGNaSEovWXpkUVdQ?=
 =?utf-8?B?MTl3YnZkVWl1cHZ3aDhHSFM1bmpwWXh3SWNoT1RIWUhob3cwaGVGOHNXbU9z?=
 =?utf-8?B?V2FLcWNyaVNmaU5QY3hSd2l1VEt4ZHU5eXFxY0xNekNXUHpZWDBsOUc5RW5O?=
 =?utf-8?B?bzRNQlI3Ry9OVUVYbytxMDlDSklKZHpCSUpWS0UrTFJMelgybkk0MU1LdzBw?=
 =?utf-8?B?eFc2VTRqME1hU1dDZnh5OWc1Z2R2MC83SEczR1NEVEhDR21wVFpacEpQamRi?=
 =?utf-8?B?TUJIQW12RFBHVW5BblowMlhNRkY3cTFpQmt5bXFrNTlWSWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJhQytMdDhLUi9JSnhDS0U0VXpPVzYyL0lXQUNxb1krenZYa2VrMngwOXNn?=
 =?utf-8?B?M05wd05IVEN2TFQwRS9rc3Y3b0lVWjBHbWVyMW1tQjdqRi9RS2pWeEtkY3lq?=
 =?utf-8?B?dkYyYVVVellNUUZtdFlkQ2hCS2I0UFplUk45R3lpVER3bFZnYWt1VVZLdHBF?=
 =?utf-8?B?cDJmNXpYMHBwUHJGRnVlWU5pcUpLSXVaYmd1cFduQW1sRDFUd0VPWnZMZmt2?=
 =?utf-8?B?VGQyZ1JSaVZrWDh4a0szT1lGUTJJbStYTjJDZGxTWnJPVC9ZL2NVK3dpbk16?=
 =?utf-8?B?TkhOdGU0eDNDYnhHaGhIcUNsbGcya0E0RFZvVmJPcVFLWSs5YWdLL1BFUTQr?=
 =?utf-8?B?d3FVa1QzOHVDR2ZEMlFhREgzd2pabU0vUmNweDl5dkNCKysxRHlpVklRVkE3?=
 =?utf-8?B?Z2xmdWpnQ3M2U0gyV3VWemRUa3RMYXllTzFzWTgvWGEzVjZ4VXZkdTBkVHhW?=
 =?utf-8?B?YjFUL1kwYms2K29hS3hHSkpzK0wzUmhlSFNrd0t0NDRpT0h6MlFjODVJOVVT?=
 =?utf-8?B?U045M0tkajYwQ2RPSTFYRWdEU3NBTHlNK1Q5NUtNbTRFVzBrZ0M5N1lnVStn?=
 =?utf-8?B?MkRCY1hlcHJIV1gyQXJ1MkZmMXgxelZBZ04zVkE3Vzl3RmhQMXVYV0xhKzJn?=
 =?utf-8?B?TEFpZmxSemEwaVgrbFBYNXhSSHpxYVdreGk5aDNES3pZMTIxRVkyTUwzY1p0?=
 =?utf-8?B?NDJkdlZTUXdyQ3d4RXo3UjBLQldwemR4dnNqRC84TUN4V2pSR3RkeFJYNlNz?=
 =?utf-8?B?M3J6SXljMnoyYmZLVXlDZGlTd3ZlOEdRSkxNaEowRGozSE10TDRHbjdkNzEy?=
 =?utf-8?B?azI3ZnBwTlF3QU9HUXNxZHpZNGpCNFZIaE9vVGs0MkkyNDRKWThkVWVvb2du?=
 =?utf-8?B?cCtML2EwNnBMSEJ5RXJkdTVpcnI5RGxHUTZTSlVCb2dCV01QN3I4Y0ppcTE5?=
 =?utf-8?B?anV6MUdNM1N5VGlKSFhuS1RTbWlLZmdZdlh1WlplQ0htNjNsNHJxdWVKOTYz?=
 =?utf-8?B?S29YeFZZZ092VElQVmtBOVZiSnVKMmJ6WndBOHNDdDMvL1JLWGNKK3NCZlJo?=
 =?utf-8?B?TkdFQ3NmR0xiWjFXbFRqVURFWGVYSEdURG5yTHNacmlwUnZVdzZka0lSczNu?=
 =?utf-8?B?dXk5WW1weXI0UWZwUnBGODRPbFR1MkNYRGFGVEZGdGpPekk3RDJtZ2p0S0pn?=
 =?utf-8?B?MllsUGxUUjRoZHdCSitoNmlaaklTNzlJSUxGajh1YmovU3Rsc0NkTjNJaWZL?=
 =?utf-8?B?R3A5RXhWRUExcEhkb0FLeFBROVFYQUdkeFVzczl6S1hiVEN5dnExc0hIWS9O?=
 =?utf-8?B?QnhvTXJPNXJPeENZTVRCcVNEUGhSUHBLT0x6b2ZnWTI2RFlUdUYxTG9qUmhl?=
 =?utf-8?B?WUg0RGhYY0NVWVlNdnNNenF1aGZEVVdVamJYOXkwWVdmZTdQUFl2c0ovWnFu?=
 =?utf-8?B?Z0wxa1lDcWd0QTEvNG5VZzlWYnQvMUtaNWNKY25rTGxhSFQydTl4M0FUVUhR?=
 =?utf-8?B?MHRmSUh4QnczZXNDNlpiZzREczA0MkR1NGF5ZCtISE1ER0JPT1lQa3VFOFJP?=
 =?utf-8?B?NDFXNjRmQ0pRdm94TTY5eFovZW9ieTYycGhKcFhiSFFWdGVRYmxxaWJzbWwx?=
 =?utf-8?B?d2JTMC9iMjhJck41bFUwOElYa1R2RDFpL1BWWTl2eVA2L01NdWV5K1dUamxN?=
 =?utf-8?B?dUs2cXhoNFZzWVp3VDhEd2txaUpENzZwQ1hOeno3VGJGY0lNWlBGV3JNYSsv?=
 =?utf-8?B?c1pCa1JxbjRxeUxQbnJhckRCVGFKd01iUmhnZGVCcHM0YUM4Ylc1a2xXbEww?=
 =?utf-8?B?dWhKQXNLQ3ArLzE3ZVhZRG85elRiNlJQdVJzRW9DZVE1NldLMjJ1c3QramRo?=
 =?utf-8?B?ODNIa1N5YmRVM3FmTFgzWjNxY2czZU1Bblh2anhxNFUyTkpVYVg5SXorMmRt?=
 =?utf-8?B?S0hleHdUY3VhcU1iMGxoN21rQnZ5T3ltd2llK0graE54MUxmSEVhczMxVURh?=
 =?utf-8?B?K1AwV3hlUVdkSlhVYVVCTDE3SmZzNmhHWitQQ1E5VWp5NUJsOVpvaXFWMGJY?=
 =?utf-8?B?WFNxaHZmTFF5eE53SHF4WENwbWpZeUJiOVcrZVhMcm9ZVXVTYW9Sa2tmZ0Uw?=
 =?utf-8?B?NTRPcC9BTVJZQ3JQREZIb2ZrWXB0OXd0RWRJSG5KcnhIbHhycThIUWlYNSt5?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fgThCyj2Sp0d9ytPk4WvsgZ0jqOPBazOri91NDrqBj0kIRPQk+WnZKJrOBevDt5wDwgvtDUWYzRBEDSh9WB9GDqxEHJi4nfBGD6mB55E/LQIOxHYhkSWALhgIScOZt/sbXbhZt6e4KpFh9qO2B/DnSzmxuiM3jyypQkDqewRXJsVSlatiL0+LWT/9La9MV7arGO3GgiXXNMy6pKkb/vmc6FY1EEDXbmZr8nCCfNPHehPvBWrdPp/C/Lw7YLSdV7bG45UFgjH0KfSw9Dcnz+GgnK9ylff0PNW34GL/lNsr9Sg1eLKIWW7TcZUWJN1SYiHQw5rLuU864Yc6iG44dWTJOZ1Gprb+bw9au8JADKmYgcE+CfYeU5zMfUgcVFdyP6JM3kTsF7CiVOnHqIO9YPM0B6oq9lwPsWQxVdisH9VuLykEix0YsvqaoiAxOSZfAdpGVnmTePDpiDE8lahY8Cs1N+H/FnwAamC5aN20pRNuRDaAQGfFFoGR3aSrhwu/Q4pRpZLuyjq3nfSYdwJfCIO7Rw5hqT9eBpiN+kWm0KBCmQkvxeX4+CoS3TS3vrlsQWFv3HAQgt792ncQvZxQNULC0NaoNqUK+JpN88Kk9I89oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5870004-1e5a-4e88-a2dd-08dd98679f82
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:01:38.3257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eimdqlZPMRPZdZZ4roxeDrzatuJnU3UDacf69IG1qTmvsiPUYpqnnbVhfJvWOAv1IU5fD/qTqNPIHyoYsZhc4bYF9TNisVavNrlHjtYyeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyNiBTYWx0ZWRfX1UQ2N64kAOPy
 NwcOmrC4BZxdjrTluTdmQnKUc+NDQgtEbBY4zCuJeR99s+uo+MKQML3ehtsTDUz15cCzfhfxC4u
 v1P9XLodYHUMKtCawyjpEzmUVRmkj5Dibf9SPaBCSZ7mVzc+RKWNv7duW9yrIo7IWx0vMW+/PLc
 B3AfiWCJtXo6nZ6gN7yY6Hxk39rxoqgueZrXRhtbKYND3RRQBBCIsH+8zfMGWIPitwT6R39E/fA
 eYyQ35CTym0FkQ/erjZ57kxF5GqxEHyIElnyaCRmYG+Vd9TPB9LYWkEsubHl9CvqfbZAR177Xyu
 rbQGcYA/ledH7VwTJrvU7OnsNCjyzy5n4amiYgxDn5uY8WZa7nKnkOtw/rmbLt0x/DXhwpCdUSs
 lq6IXOH5gu1ysBy5aVchpwtFFHb2GfXb+AnpHNIlpq23dXCXFZBQQzpRxji/N5KxNHW4Mn6U
X-Authority-Analysis: v=2.4 cv=CZwI5Krl c=1 sm=1 tr=0 ts=682dceb5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=vxBMm4TzyY5yZwa8HZoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FfOS2ACgTh_jit2Gr3kOpypg6GjHPA0x
X-Proofpoint-ORIG-GUID: FfOS2ACgTh_jit2Gr3kOpypg6GjHPA0x
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/2025 11:11 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>
>> On 5/19/2025 11:51 AM, Steven Sistare wrote:
>>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>
>>>>> Define the change process ioctl
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>> backends/iommufd.c       | 20 ++++++++++++++++++++
>>>>> backends/trace-events    |  1 +
>>>>> include/system/iommufd.h |  2 ++
>>>>> 3 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>> index 5c1958f..6fed1c1 100644
>>>>> --- a/backends/iommufd.c
>>>>> +++ b/backends/iommufd.c
>>>>> @@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass
>> *oc,
>>>>> const void *data)
>>>>>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>>>>> }
>>>>>
>>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>> +{
>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>> +
>>>>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>> +}
>>>>> +
>>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>>>> +{
>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>
>>>> This is same ioctl as above check, could it be called more than once for same
>> process?
>>>
>>> Yes, and it is a no-op if the process has not changed since the last time DMA
>>> was mapped.
>>
>> More questions?
> 
> Looks a bit redundant for me, meanwhile if iommufd_change_process_capable() is called on target qemu, may it do both checking and change?
> 
> I would suggest to define only iommufd_change_process() and comment that it's no-op if process not changed...

We need to check if IOMMU_IOAS_CHANGE_PROCESS is allowed before performing
live update so we can add a blocker and prevent live update cleanly:

vfio_iommufd_cpr_register_container
     if !vfio_cpr_supported()        // calls iommufd_change_process_capable
         migrate_add_blocker_modes()

How about I just add a comment:

bool iommufd_change_process_capable(IOMMUFDBackend *be)
{
     /*
      * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
      * This is a no-op if the process has not changed since DMA was mapped.
      */

- Steve


