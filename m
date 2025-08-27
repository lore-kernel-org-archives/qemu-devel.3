Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84EECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEOj-0002Q7-44; Wed, 27 Aug 2025 07:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urEOg-0002P4-1z
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:32:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urEOY-0003XM-K0
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:32:57 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57R3q94k3003888; Wed, 27 Aug 2025 04:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/YOfz/7OxWISMSxL4U3VBUyPkIFiB/7wEf1D61ih9
 ls=; b=2cgP4FzLcXeEO8xyA1RhNXoT7yS49lK31aoJQEes2YMvORWH8illerWTp
 bcplbePRN6VnV5H1SiHQKNp1Swa7TmccpFkFRziFr7FrkyzhV3nGvKr9g7w0zo9V
 jKnTqIXYvfDqRx/XwFmf+dhI7rWN3JnKTStsEOgSgIdPvJ3YykUb0NHJaFkGUcQT
 XC243AwBq9Jh6LXne9BlfcxgMX0DwasStX1jClP8L+T8Fmn/3b6fVWy1S/5droNr
 IhZS7JUKtFkYLabuX985GZusub+uW+yJdCvHhRqDvmRjvHRJifWmQeelTsBA9tIH
 7YwxhrDGooIaI8oCJ7hseFssb5FEw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48s7283mb6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 04:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCe2v9dGL9fw5+u4prRPnasuSOTx+zoLgDzjfZKRZ9pKE3+cfKwUlkLwYjmqHieE5IQ4wyHBTbGpedQJufT7x5QLRZd5LtFJFq8VNNqsRZ/QrvcXNc85adQeOEa3go45FK+ix/hcl5aC4oWU69fd6VN9wuugMj/vPPFHn767+deG+TaSwO86plzHCdh+U8P/itXG8EOW/dglcUnygxW4TTh/tqeei23cnMYOahoL7GLeLFcD3CEitFSxQhgihKabcu3fgmYTDGzY/kFUqwdj9ZUpyC/E6EF2yPfswn0JFRDRlTR5GA+xyqVS7z2gFfdIHC3PTQyn9AnNOYOnEFB6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YOfz/7OxWISMSxL4U3VBUyPkIFiB/7wEf1D61ih9ls=;
 b=mcRFDB26OKqZ7nH5yy0Yn45FiXysT79yPbbJzcqcgUkLRaVOzYM5zYCZIMyGW5NESaJkSauZuM/OUnbBLLeWLZUpfhKMoA9OxeTA+TGByj/L8g693e4IKhltq5/z+2/e4bzkrAU602NkprLrsuLyV/NZURSv2tdV7IXqErNrZAb9ftEayC0a+N19jq2yzYOfyDKZXxgywXT3V9ZxgJgR2FI3A5yjKIi4Jpc+FaKFItUtn9Ps0BorM9sCgXF486bCxJIs/Cb9JdqC62Q2T5uDTZdti22SwGmedBQ4jVtxafLnoZdHwV7FqAaoLAx7vB8sjRoHIWnbckvwegPwGnXREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YOfz/7OxWISMSxL4U3VBUyPkIFiB/7wEf1D61ih9ls=;
 b=K1F4t8u05b+/mM+KNAveYw2W5tAHgOdsylEnPZokk9I8zAycb8iKeDMbplYNuwOVxLF6fwO9XFj/FK9J5df+uSQtppdOgtVp/SQxUzUYZlCFwdMuqg1JXkzFItdqEwWBb27bObPZgWNKlyjMr+OVMCN/x080RWykltx11CPMpWkiHF5py75eriAhiehwL02nnwd4pDMfQ6sQ6i4rn0gXCYVj1vz61NXImFdm8Fw4AntUUdqniKyOnBe4vlp5Gush7zNlGvySmnc6f6fBDwA0MUbsT+XCB/fYviFttF5gJ4/+VVZAu5gcIfVXKwhCRN+sL9W6cFHtdenIA5EbXCNmww==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA6PR02MB10502.namprd02.prod.outlook.com (2603:10b6:806:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 11:32:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 11:32:38 +0000
Message-ID: <76e1c61c-7449-43f1-826e-864380d6725f@nutanix.com>
Date: Wed, 27 Aug 2025 12:32:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-14-mark.caveayland@nutanix.com>
 <0bb31bb1-1a44-4723-9bbf-da9c528e42c5@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <0bb31bb1-1a44-4723-9bbf-da9c528e42c5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA6PR02MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaec117-65c9-493f-9669-08dde55d6ce2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW5kRE9NWXZTaWJBekI1QXRXcXpDdGFqRVhkbjNOcCttZkJHNWNOckNoZEdp?=
 =?utf-8?B?V3FxT0ZUV0VQM0hsM1ZkZ2hKQk5Pd3lFT01lZHRYYUJoczBQcklPY2IrMzdE?=
 =?utf-8?B?ekVBb2xieW9ZRUo5Szk0c2hiQTNTTG5mSHp0bjM5Y3NqbzRRTWtVbktXait1?=
 =?utf-8?B?S2hVaStLLzF2MjdmeUNCOE54dVBQS0tWci9qaGMya3Zvd3oyRG9Pblk2QnRK?=
 =?utf-8?B?WFFLS1BibjhrazFLM1VEZzRUbkZ1WmZsM1EyS2pJcmM0KzJvUTVhTjQwQlNT?=
 =?utf-8?B?NTllZnlwSkZRZnJDSEUrejRndEJzQXJmSWVXczJBRVR5bG1UcFY3WDMwN1F4?=
 =?utf-8?B?d0RrcE5OaTBvTXFZTUlJSHZnZXBQUlcyRVMxN1owSGc4U0ZlRTFKcHFyZjJn?=
 =?utf-8?B?K1dET0ZiMFpHcU5TN1p6WUY0eFpSUVlLR00rZmp6NlRibHJWWE0yQWhQTTN0?=
 =?utf-8?B?NVBRU3hlR05ZdDVCNGVQbzhxNEpGTDliT3ZERy9lQWE2YjFYbGhvMTJsai9u?=
 =?utf-8?B?WDNXWjY5TDNUYkZMNTBEQUxpcnVYeUZjbUpEVFRXaDM1bEE5Q1RuSGEzVnRM?=
 =?utf-8?B?MEowMDdkSUxicUROSkR3S1N6TDhoTTVGQ25JNVU0WTVJZzhDQVdMbjQrZkJQ?=
 =?utf-8?B?RlBGMm84WTltZXQ5RHlGTG5zdlRnd1lKeTJpNXhDTVVNTENxaFdhUGxkV3FM?=
 =?utf-8?B?NnQzTkxqc21VaXdaT0lGajdIQWpTYkJxWjJERy9rZ2I4VlNPUTcrZVpTQWdh?=
 =?utf-8?B?Y0hGTXk5Zi9mSzY5NWdNVkZmNklHOXlUaFQ5REdxdVN5Vi9HT2Ftbk1Pc3o1?=
 =?utf-8?B?eks5bGpmSXlrUlBiSHUrU0N6Rno0NXVlWTE2ekUvZkxhTHovZDBSL3VGeWpE?=
 =?utf-8?B?U2dNdE1rOGlMOXl4WWZPRkRGQXcxblZycDIwMFNMUWliRU13R01IUWNxUE1B?=
 =?utf-8?B?eGRadHE4VS90Qmlrd1l0aXFKOC9WVEVhMm9IemtWQzF5MkZndDZPU3pWZG1U?=
 =?utf-8?B?ZGcySjI3akF6NjliV3R3WGpibHJlNFRUdzlUU3lkcGtUdHNqU3pwR013eDB6?=
 =?utf-8?B?R08rOXZqS3pObVpVSEdmZERyTWpGUU54YzArVFZTK3RCUHZTK0RPQngzNncv?=
 =?utf-8?B?VmkrM0w3NlkvTFpvQzk4eXdETHdqTXI1S1dsZkxHdWxTckR2SXFCcENXaHJx?=
 =?utf-8?B?NTU4ZENiMGNmTW1IaFR4dGdZb1BlNVZROTJKenZMZEVNVmxBc1hjV3JzWkNz?=
 =?utf-8?B?MXJnTVBOcUNiMld2TVFDWWZDSGQ5WGZFb2RrZTVlME1ldVUwYVN2d1lXMzBo?=
 =?utf-8?B?NmVEYmNoS2tvdFdUUnl1aXlCb1hyTkFXV0xTOHIyMFV3aHk3dXd5WUYwaS9p?=
 =?utf-8?B?WGdaR3JJemNQa3g5VGFmaGVVQnlvcmpXQmpYZXdzREF1TWQyVUxmSFBRaUR3?=
 =?utf-8?B?b2NLcEVHdzd0YVhvbkNyaXBaZDRwY3MyajZQOG9WRUFGbm1aK2hOdjVSUEpD?=
 =?utf-8?B?SmlGSXM0MXFpZGpFeVlaWlhOSWIxMVllanZUalpHVElNZk1mZzZoVzd2S2ND?=
 =?utf-8?B?azB0VVloTzhtUFVlL29nUnpCZjVvTjFHcDAwNGVYWCtDWUFDcFhKc2ZTbDJF?=
 =?utf-8?B?MFR0UGRRMUN4U0JPZnNJNkd5aTZ2a1pWd1c3RHpyd3g2WnNzU2FkNTJFRCtN?=
 =?utf-8?B?bm9TQmREODBnekI3VGdqYVBSU3ZRMTR1OEFaSnN4UysycWtwL1RYRVVHTmNn?=
 =?utf-8?B?K3c2UUs0THIrWTJVcE1QYU9XSFc2NW5wYllNcDN3ZmRZdUVRcTRDcTVVLzhr?=
 =?utf-8?B?QVE2dDgzajljWEY5d0pxTitrUEJzZ0ZVREdIQzBwckU4RkRldlZwKzA0emNW?=
 =?utf-8?B?YnJMaXN2Ty90RlVMT1FWQVRDbnR6NlZJcitPTWorT2Y3SEZZa0xYRGc4YkE5?=
 =?utf-8?Q?dBrAOWkDhK0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2V5c2JYYVFMNGZWVGNpMG9lQ01aWDY1MVpEcG0zdFJ6enRrVDJtZ2llZVlK?=
 =?utf-8?B?UHFmL09Jb2NGZFdvVXNTNVVRMWxSSXRPUm9lUEdycHdremxBa2h0cUkyaUJY?=
 =?utf-8?B?T3Zmd2JzNkRlSnQ3TWdwMXV1VUdKcjRRMktXZGxWTERZcC9tanIyVkNxRjJ4?=
 =?utf-8?B?VGFRWnVTMTk0WmwrMFltVUMybUV5aHdPbUUxVlhFSWQ2aHhmWExlcE5wUXA2?=
 =?utf-8?B?Um1XVFJSUTZjR3BJVlIwRldkRVd3d2hKRzVRcUNXNWsrcUxoZEFPbm53N0FG?=
 =?utf-8?B?WDh5dlJ2bGpOaGI4NXFmMVhrWlFpUmc0dTNvUnZ0ZUY4UStqOUozL1BNRFBQ?=
 =?utf-8?B?dkdRdkZDbXl5MThFTWZuWU9wOFl6RVhZbU5rMVNmY2lwMTdqeFBaR1Jxaklv?=
 =?utf-8?B?VGxBNHFFdVVzci90ekxTcmFwZDRBWVk5ZktFWVlqd3FUMDdVWVFpRGV1SUlF?=
 =?utf-8?B?YVM5VXAxeVdjYWkwNFFaOTlydjNRbk1kK3V4WEVvNFdUU3N1RlErY0E3TThM?=
 =?utf-8?B?dDF0VWJyYnpBSnlka2pUZWtubklIK0FOa0FicUFrSndhcGJiYWpQSHg0Q0J5?=
 =?utf-8?B?aC83VHlXSitVSWJqZm12QzgraUpONkZubjRoeFJ3bm93SjJlSVpxQjRNK3BT?=
 =?utf-8?B?dVlkaUhjQ3lpeTkvbmVBRG9kcDBVNkY5cWEycjhheGpUTXRaaXl0SlRVRko5?=
 =?utf-8?B?T1dNQWZzR2g3b3lRUzEwMlFZNFJQMTR5NnZycG1yaHVzQkI3Z1I3d3pUbmZQ?=
 =?utf-8?B?YkZCdW1GWnN0eTE5SzVFaWp1UkF4NlFVWm5lOENqK0JBc0N4aUJKc3VWK21l?=
 =?utf-8?B?bVM5akJBSDB0R1VqQ0ZEQWJ6NmNaMWYzSU82SWVTSU52bXI4WU9GdTg1Y2hs?=
 =?utf-8?B?c2xzdllUbWNGU2hybVkvajVaY2l2M2sxUDcwMUxzMm1IdWNVd0FBdXFTNGxy?=
 =?utf-8?B?T0NNYjVBUG9DaFNFOVZ5K0hzcHk3WUtvcEJEbExlSnZmQVUxbUVGYmVDbVlk?=
 =?utf-8?B?dkxNTDFjQkVjYVZBWVNGcVlVUG5Md1NsWnlDS3Y0TFN5K0ZVZGNaOXQySkww?=
 =?utf-8?B?TzlPcmhHVjFpVk9oOXNpbGFGTkNjbmdoYkJIOWd5UHhwdDRQTEhhSUxhc1FR?=
 =?utf-8?B?UlJUWmF5VGRmV3hEL2JScGppeHJtMjZwWXNtYWFGanFrUk5hT3dtQ0VYekdM?=
 =?utf-8?B?bXNUdXFOZWFZYnlwQVArRGRUSkRkR2hEVDJhMnJZckRjYlpxbnNDTGJ1aHlH?=
 =?utf-8?B?bGFUMFlWOU13amJvK2hEOEZDM25TS0RGUDM2d2ZVcGxaV0hiZnUzbnNVKyth?=
 =?utf-8?B?U29oOGlsK2tldURza2xPSDRJcWY5UEg1ZERVMDNhL2tHMUIzcG8xQ3gzVEh6?=
 =?utf-8?B?R05xaGpGV1YvTVMxbk0yWlhMYXdJa0hTNmhQR2VUaCtnbGJyejFDYmhqd2RK?=
 =?utf-8?B?aDY2a0NMZkhBR3gycVJ1eUREUmNtYmhuVlJxbm9PZVp5WmdnaWQ5aUg0dmtF?=
 =?utf-8?B?UWN1Y0lnTXEwUHNtbHpxOCsyd3RVQ2VoNityZlpCdXBWSGRPWXhsSWdsY2wx?=
 =?utf-8?B?d0ZJRWZHSG45S1dJRC85Nkp5L1I1ZExReXA3WUtIYnpyc2lkdGhIaWZJZC8r?=
 =?utf-8?B?K2Flc29IdVNQV09CMVo5Y2x5TEdBK2JNUXpuZ2JrQ3IxaGhnOE1zOXlXTWtO?=
 =?utf-8?B?bjhhSmNUalFQQVIrWFhWM1BWRThjMU1lRFFVZDIzdHRQZXpmcEV1aUpoV052?=
 =?utf-8?B?bE5NbWFrOE8zaVREM1hUU0piNjdFZ1A0bjArVmVVaktjTXgwTmZmTnFpcnZE?=
 =?utf-8?B?ZFh6L1dkekxJSktQTDRkOWNUQWxsdytOVWFYM0JLQUFHcWVRSnZJQVlxSU1x?=
 =?utf-8?B?bDdhQ1d5cWF5WGt5bE53YUlaL2p2S0ltVjd6QXZMblV0MWJ1eVlEQ0ZkU3Iw?=
 =?utf-8?B?bFBld1V6dVVLVWtmc3ZncFphQ3ZhSGpoWElqaXlsN2xIbERscVJWYzNIK1N3?=
 =?utf-8?B?aDN5SXRrYzJHTnFaOVlLYkVNcTFVSDh1MmlxN2R6NjlvbTFwbWpDZ3BBemlq?=
 =?utf-8?B?d2N1TUllaW94NnE2cTlDUFUveTBTQ1dCVUpueEQ4VERrTEtxUERTMDJBbld6?=
 =?utf-8?B?dDBUbEhXY2IvVzFydlBYMys1aENJL0tmQU5oY2lQUXJZK1B6bXdteE84eWxG?=
 =?utf-8?B?cDhXZzczMlhiNUhZYlpadmhSdjJ2TmYxdko4aENBb1NZQ0NycUlGcGdPL096?=
 =?utf-8?B?L0RDd3l1Qk9vbXZuK2FvYlRpbEpBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaec117-65c9-493f-9669-08dde55d6ce2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:32:38.0533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vE4nyr+Crz3H0uOxOEbD/W0WscsCl0WfNLxgZ6GC1zicxcJXouwoYakn68kE3clSZemRae03QGHm9zOutZn14Z0dB14fQfVN6ZlmQflhGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10502
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA5OCBTYWx0ZWRfX5RWiK241s6fa
 d2vxokCmAt6m7IIq8ttskjg14gUv9CoVAOGYWyRrP6rbGqWljjzlnwtJ8FfyaZOy6kgN1eTLOd9
 4x7hsewvk79usYpcSni+0Q+8/70Z+ApvFPi7j/eNsgzWKg0HESuJjbiKEFz2UBc8d1mLwAEu2W2
 KArPypOOr1ANlwu/PJVn6Z80QCwYtgBbh9Hm1fXNOgtMpdJW53UKc3sLhj2E6lwtgRm2LGGZmRL
 CH5C9TciK5WoT+lD/+nrXvDLHTdZnhmf2JpQfYK3b7J14SaCiz43S8zAKhmsOq4YurYAs6N5U/m
 ec+NowEmRtQOLn4suzJLkHl/doewH52HQ5qS3MS90WeXHLGQ+a1qfS1i3ZRSUc=
X-Proofpoint-ORIG-GUID: uwADooO8Owx0tyGFo9g5-4m7K30UxpmY
X-Proofpoint-GUID: uwADooO8Owx0tyGFo9g5-4m7K30UxpmY
X-Authority-Analysis: v=2.4 cv=Ae+xH2XG c=1 sm=1 tr=0 ts=68aeecd9 cx=c_pps
 a=ysIXdlsiLQEa0wkRuds0Og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=fyVEKCcoFK5mnPXtCrAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/08/2025 10:50, Xiaoyao Li wrote:

> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>> By definition PCI can never be enabled on an isapc machine so hardcode 
>> the relevant values
>> set via pcmc->pci_enabled.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> It seems to me that this patch can be squashed into patch 05
> 
>> ---
>>   hw/i386/pc_piix.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 924888b59d..e8603b585a 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -492,7 +492,7 @@ static void pc_init_isa(MachineState *machine)
>>           }
>>       }
>> -    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
>> +    gsi_state = pc_gsi_create(&x86ms->gsi, false);
>>       isa_bus = isa_bus_new(NULL, system_memory, system_io,
>>                               &error_abort);
>> @@ -513,7 +513,7 @@ static void pc_init_isa(MachineState *machine)
>>           x86_register_ferr_irq(x86ms->gsi[13]);
>>       }
>> -    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
>> +    pc_vga_init(isa_bus, NULL);
>>       /* init basic PC hardware */
>>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,

Indeed, that seems to work fine so I will make this change in the next 
version.


ATB,

Mark.


