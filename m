Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16356CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzd1v-00058L-Cp; Fri, 19 Sep 2025 11:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd1t-00055I-1K
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:28:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd1m-0001xC-WD
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:28:08 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtp5x017687;
 Fri, 19 Sep 2025 15:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=puYhAuTWUdoNl1TY7yks4bO6P+YoqiVhP68gQhB7ryE=; b=
 D4uHo9y/VQ2/p8zJ+kxJFrELKH5oRjZd9UisLoVcFaj0gvZmgLF3wuCiP1vmPKs6
 RKCJEwIIEtB++G4/sj/4RorMG3IrLvDUZlGFYYcNrqYTe/AoZXOfHxxPiii+R4it
 2oX/ar0Nbv3bXGks9S15Q0vpcWesOKq8vgAydGVNGXrDfpRQmdcMj22QUlIc2OFK
 mJdtlO2M5YFKB1rSoYqRibWVcgfxMMV+nYnzhJxODBUPr6pEcovL6h+W99nzMVxq
 mfpFr4QGRn3HFeODNvq2lKSeF2PhETsm0fgZhpVeSln2nvpYvjj6k7qduzp5VCy2
 w53NIada7P+zBEEH2KlTfg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9wv0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:27:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JER56l027223; Fri, 19 Sep 2025 15:27:58 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pw1j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbZy41xRAoiyYnBk1bIgBvfoNXj5YOnUBEFz+iaq6mrR8/UGtIeFUjQAi4rQtjybmWA79tspHVrVwcCcoV8Le8laWz0Mqw7eLRMuaLPDVGy0+WkedzDc4lN4eitw6bjsn2zu0GPPb+JwH9YvXj4uJqSu8fQZHGqsqju8mq0U/4TeAHKmpXGJf/DSzwKgoZ7g29ro3Oot/ZHW69+VsIIZ1u59i1Hlr2snzhif2hcYE9+oZml4Gs8sIDRuUhKxF4ILTl52iyAcD2mYN+frppCAfrPIWCzLnNUgwL3IWoyGe39kH8ziaisgNH1T6uyomJsxc4rXrCiL+V9T4b3pPwiWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puYhAuTWUdoNl1TY7yks4bO6P+YoqiVhP68gQhB7ryE=;
 b=kux2WEhYwVGq8dFBYceqysQbOGbBSSEi8c/NklC8mb7AB6yo/1Bw3G2ZQ9GrtOaeV5hlOvDz5nU35PyQIeNqw2hsV1zdBndQGGfUatX5CXj8F3zpdjCRgtSyOlC9zXueLFF+IjV0t+8831YjFHYa1OHEurxrl2kBLE9vcoo0pxhWBuWxgSv9n0Gmz1sgx7rYRgPdtS4PBtQ4Oe8lWiDb16Q4ETqrD05eEhGBSNHnKKNskiydXaGnImCnoBVnIRmy6mmWbPSscQwENvrK+xStAmbLutUTUV6VpGAO0QnB5h2QdVvsJ3eWPZ0P0/jJ8DIZs4M3q8Jh+8atD9lPHqzkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puYhAuTWUdoNl1TY7yks4bO6P+YoqiVhP68gQhB7ryE=;
 b=NQsEWXjMwXa1YLBSwOoglArcK2ZpopURau3OlDzw3OY8eko6B3sh8VADaL1Mc0tzdL5BtmY03EoAtYJ7p0EFxy4Jobdc5zJYpXqHNb3Humh2+Iai1srTOlTXQW2aGf4c9Kq9hfyBqd0pk2UdsENTxX3VuuisRZbxcxH7Eq4+b38=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8640.namprd10.prod.outlook.com (2603:10b6:208:583::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 15:27:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:27:55 +0000
Message-ID: <2bb2f7d1-240c-4da4-8135-3e99e90364a0@oracle.com>
Date: Fri, 19 Sep 2025 11:27:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/9] vl: helper to request exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-5-git-send-email-steven.sistare@oracle.com>
 <aMBNCUXuMzxUToff@x1.local> <28bf9c97-1e69-4121-a4aa-2d2bf5ac50bb@oracle.com>
 <aMhAYkVgf73gjxVZ@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMhAYkVgf73gjxVZ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF0000409C.namprd05.prod.outlook.com
 (2603:10b6:518:1::48) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d072bd6-a49c-44e5-8b9a-08ddf7911ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTBjYncrc29uNjZETm44TDUvQnVXbXEzdUJhSnB1T2RpRkZoUmhtZ0VyYVU4?=
 =?utf-8?B?T2UwTlFmTVhzbmt4UFlhSlIzYTdOQWZnNHU2QjR0ZmI1QmRUOWpaSVdtdmNs?=
 =?utf-8?B?OG9DZi9CZVdsazBpSGRQcUhUL3pGdXJxdHduR0VCK01vMXpUaUxCSHZRRXB4?=
 =?utf-8?B?TnhXZXBOZjBPb0tUdFdickZlYU1rUUpXMEtBQ0Z2S0FKOXZYUk9jTnQ1Vjkx?=
 =?utf-8?B?eDAvMUtWMnFXL3Bvb2xqeUFQR0hGWUIxOWxCZGNkQjZXYmtZL1ZUb3ViNnhl?=
 =?utf-8?B?aHR4bEd2blhCdDg1SjdtZWRlMVErWWF1K08yd1JaZlQ1L1RqMTdneUl5NnBF?=
 =?utf-8?B?bkpOSEtjdW1WOWdmZ3ZhNjUxTnhkWVRUSDV0Ymg3cGhTZGNnL1AvWWVrQVpN?=
 =?utf-8?B?NERKUEJtb1RER0RwODAwUGQycWJqY2RDM3M2elkvWk1TWkMwakJCNjR4QVp6?=
 =?utf-8?B?Mk9HMWtZQTFwcC9rcis3VVM1d3ZOUnJlM0dBa29ONUZydktYTU51MkZsWG9o?=
 =?utf-8?B?b25tMzlIQlN5N1VyNjFhTmhFZlVENzlzR1c4WTBqbEtsaUVNMWNwbU9tUWsv?=
 =?utf-8?B?SUs1N1pNMHhMYmo2b1FoRjFSZ0tRWi9JaUlvbW1iK0w0RnhzZGhNN1AzS3FT?=
 =?utf-8?B?d21NQW9iVVZ6VU94anNMQUFOUkFCWHBmdjFnT3hEQmFDb2pxRXRVa0JlUms1?=
 =?utf-8?B?VitmNlJpM0Q5RGdaQTFFTkRsWDRxVlZ6ZWxic2g5VU8wYlZjcFAzaXhqWlJH?=
 =?utf-8?B?cUZ1cnFBSkhPcHBJZVVuL2NvLyt4QlZWb0txMFFhaEhDOG5HcGdsYkc2OHhl?=
 =?utf-8?B?WWlHY29wR1lKdndlR0NOTGtKdWxKbjNrbkxhZUNpUUFxcmlSRjQ3T1h5VWZ3?=
 =?utf-8?B?VHJ1d2xZaytrbWRrVlI2aEc2RG54VFRjKzN6bEkySk41eUFUZmNrQm1iWEp4?=
 =?utf-8?B?aEU3Mk9PbWpBcVZnWnUxWWFjUVo4RWxYcmNYUDJ6aGRCWXFyeXlJaW9hOVBL?=
 =?utf-8?B?SjdXVWdlZ0NGYkVJS2R0VERtZ3VRNWdMQ0FxN0JDVTlJVFQxdDY0dWNNaVRX?=
 =?utf-8?B?SGlzdDNrSndZb2RmLzVFQ3Q5blZpZ0c0d3ZMQ2txdkI3Q1BHOGxSamU5UDk1?=
 =?utf-8?B?S1BCSTJ0ZnUwZHR0ZUdPUzJQMk81b0lwTUZpemsyR2Y4WG1GbFRjUUtzc0JB?=
 =?utf-8?B?QkpKdWFXQk9hTGJUV1kzQU5MN09BQysydzdNa2NCSktBNVdaQ1hQamNYazlK?=
 =?utf-8?B?WFVTUSsyQWJRZ1IwUmdvcll3WTRsRloxRFg5UlJFenFTaVZ4b1pqMHBwL29U?=
 =?utf-8?B?UmlDK1BXaHcxWUI2V0Nlc1VYSmZVUi9jcXY1WjdvcGFPVVNvc2pLY3pzN0kr?=
 =?utf-8?B?N1BDVkhpYWJYT1BKMVVvVGlVQ2g2N2VZRWRCVzNpQ3NiZmVWSmU0RUNMT1Fk?=
 =?utf-8?B?OXRvWEZCTDJpR0RpQjlvcU9qMXRSNUpUM2QrcXNqRWhjQlFMd2ZWN00rMm9H?=
 =?utf-8?B?aDkzVlZZMzd0bWRuNmNzeVY5NjhINXpHSFlvUDZDMTEvWlVVSDJTOThsOTFQ?=
 =?utf-8?B?d2tNYUlVQ05yWkhiSmMzKzJEaEJqZldFTkgxVUhPK0VwWWUrOWR1ZlZ5L09L?=
 =?utf-8?B?Z2pzOG11dnBTODFhQ0Uvb1JGVHZWMkFRcXl2TEVxa3ZUM25jcjI5QVA1Zm5L?=
 =?utf-8?B?NEgvdDJVdWk3UkJLSDAyV0hCZ1VzNVF5S2ZvQndEQWlGNlo5bmo4TkxHeTE5?=
 =?utf-8?B?QnliKzVnVm51dWUxbGU2T1RpRkt1VGJud0s0TVBxcGZyb0o5b1I5SHRSREdN?=
 =?utf-8?B?ZTBRaGlhMm1YeVUrRHAwZyt1TkVNUU9nOXNPTG9YL2NpS25qNklLdWVjbDB0?=
 =?utf-8?B?WjZXM3VITDFtK0FqRXFVc3FGSHV6NG83U1VJeU5oVWtIeDR0WnJvNjcxQTdE?=
 =?utf-8?Q?cHz5Ud3l90Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtzVXlyOG1pTEFVbWo1Z3VQamlMOVpMdUYzaVdwRjFXTDRhcWpzWlJJanFx?=
 =?utf-8?B?R2xqUDV5WThaYnBJZFpKN21wQTRsMlZFUHIxN1lSdi91SGtYVjRtM0lEd1lj?=
 =?utf-8?B?ejQvTFVoSHBBazllSlU2c1BZYUFaWXpad1RvZk1BMkFzdWNtRm82TjFxaEpy?=
 =?utf-8?B?cWNwMEdsc09FSXM3TCtKNGdxKzNHZjB5ZnlMWmRzZmtDQ2lrYjBmb2Z4Q3c5?=
 =?utf-8?B?b1k1R2FSSytWd2NkakRVazRmU0JlTkRUMUszVm9wcThuSzd1ajRuQnNtZUR2?=
 =?utf-8?B?U2t0enZDYXFIOGdkcEVKbVo2eGNlbGNQMjFLQmZCbVpwbm04eWdBeFF4b2ky?=
 =?utf-8?B?YUQ1ZlpPZlN0RjZNU0d5Zk1hUjJkZ3FRYmljVEpZdE9KS0VNZWRDdFdJamx3?=
 =?utf-8?B?T2NuV2tVcUxpMk5DeDdTdEZLSUJEVnArN0ZrTFo1TWkzZUJ6cDEzdGNSS2dY?=
 =?utf-8?B?WUFQVGhrTXNMcENlZGRJMzc1TDRjTzV2bjJoOUVKdFQ1ZGEvLy9abGpOdDZx?=
 =?utf-8?B?YjVzZFlpTnNmT1JhYVlrUmVqTDRvMDJEMjc4aklJbXpONUh4Wk1BRlR5enYw?=
 =?utf-8?B?M29MU3lYMk9kQk9VdW9JMDliQXhBM0tjdWZ5K05oNzlwQ0trRFFFZGRON2gz?=
 =?utf-8?B?UlFzVFdWOWREVmZ1N0NUNjFxRmFKamNneHlPbHhqY0VOYTVSbEJDbjNDZktx?=
 =?utf-8?B?TGhLUzlFUlA5Um1ONVdSenVrSHpORnFHbStNd1l2Qzd6UjlkeUpJRkExQmFC?=
 =?utf-8?B?eU1QWE9zU1VuSFR6bDJCY3JBNkQ1YVgxZWtCb2FSSW5kTkhGeDlRc0V5VStJ?=
 =?utf-8?B?Y2RiRVFVTFc4T2tkR0UrdWE4LzlTS3lXb0o1MFJMUE5rWmhlb0RtNzZzOVcw?=
 =?utf-8?B?R3FaaVU3aVFZQnRESXZpNFU3cHc4eTY0NmJNeWthZlNoNFNudkVWTHJ3aEZP?=
 =?utf-8?B?OEF2S3JaSjVXQzk1cUx4elNLODVCcFVEOXl2SlEvZnN0cDl2dS8xWXdIWUJR?=
 =?utf-8?B?QkRZSW5hUHhqMjRncU1FUjJwNCtNcVhSRGI1dUdrYVZJR2dJTE5GSWFMeThw?=
 =?utf-8?B?N01kYTdrbDRMYjc3bCt5NmNESFFiMTlyOXFBQUE4Nldmc3lMZFVwTmtpOTlM?=
 =?utf-8?B?ZnptQVEyalV6cEplcXNFeUpuRmxML0NnNmxSN0IyV20rMmFsWnlERDNIdkxY?=
 =?utf-8?B?cE9VSUZ4Q2hWa0RFT1d4UnRlZWsraXA0ODdoWWtoZDU2ang1RGRwclEyU0ds?=
 =?utf-8?B?ck1oeWpPYXE2U1BnYVpzcFFHWVBJdFJMYXZrUWZaaGYwaHFIK0pEaE54d1Zt?=
 =?utf-8?B?TVc1a04xSmhaZVRmbHJHZ0hCUUFVaEorWnk5ZlJkOGxublBMbk95TE1xR3Nn?=
 =?utf-8?B?TXJibC81WXAvMDhXZFoyWXB6bVZMajZISDVNK0V0OWJRd0swbFhSdXJWeWhT?=
 =?utf-8?B?dDBQVVVPWUJYRW5Qa0VUb0tlb0c2N0s2WGNkVzBrZVYvOExVanJVMXo3RFV0?=
 =?utf-8?B?NXhteGZOc2R0TDRhQU14ZVJpZmQzSTJXS0xka0p6eFlWcTRGVFJSM1g4bmho?=
 =?utf-8?B?bU1QM1pNOFBOTklvR2QzNXJWZGtGT09BZytmQU5qTVJramN3M0lWeTU3QkJk?=
 =?utf-8?B?WlZZS21GNXJXYkN3cGhjTG1ZQXJMT1l3S3VCdXhnYU0zYUNYaTB6ZzJNTkpF?=
 =?utf-8?B?Z2loUkt2TDc3amMyVnBEaVMvRjl2SDRFU2hYc0ZNdFFuYUZRazMxdDBWNVhu?=
 =?utf-8?B?Ynk3VktRQW5FVlk4NG1LeGRCWHJEZUtaMTh2VUFzTDBrUWM2K2VjQ1hOa1Bl?=
 =?utf-8?B?cjJkMGFocDlvRXZjNm1DV21KelVSOEhDWmplMGttNFh3Z1cyV24xRE9pckFi?=
 =?utf-8?B?RnhlbnRFZHF2bFlvZEpQL3F1UkxmZ01HMWU3ZE9iR0lQb2hFRS8zb1o1QWZN?=
 =?utf-8?B?UWhJNHViOHdYTzdDdmk5REdkNzBZU3FUaExiNFJOandiVDJHc25sV1d0aHVi?=
 =?utf-8?B?c1Y1UjFFdFpQdTNaT29LUzhkL2VRYUJyMDN0ZUNXdlJBTUVwYlJvRGptR1N6?=
 =?utf-8?B?OEFMWmNuODVDNmVqNFNldlJodGN4ZUZ3RkpKaEc0Q2ZmTWdqbVlNVWNtd0dS?=
 =?utf-8?B?emlUd213UTlYT09CYVcyalhIYkZkYy9WUmlRbEkwd2MyTEVwbzkzTGNTN2Rl?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W+IrnTsAcacRQAH3bxJyeSirDJK9Mn9m9qeASiHvCRFmEdveHvN/dtyJCHO2Nqvs1rvf+R5Xm2emJbmflyazc3ZdMkRHz24HsE4S9IPSL86P8gBq43PdRQ0ofITrKh/LFQ3O9tCP8ws1TY/3PuyLjEzhfSslbNgMw86rRb1otar0eN5k/XqJWEOrB5BjNSYZBIfGe2owjiRHbDPN6KdNPnQviCgdxpQoOd9xOWe50kB5G9KyYkNcfCB5pOnu1ifspbvs2ADKR67XuQ9Ei0kTGcMwe3IzkRjzDmerTWM6S5f/YZruxw1dL8rdT8d61Apne5TW2Uk7BDRPQj+OOBwd/KN28FXbz/xQTZosa/M7qmwY0it3fFfy6yj78qCJZZwTrqYz1z5mvycE7wlP6FV3SV2oDWI+VHst6iIpPQMReVWSHlydsGQscXciPd0kU+WWW4L3p0RUzOR0NQmdXneudbKU6EBC/hTkg7n1rsJlboMorYrZaF2M/TzjFmjxe9IpjsxfkmBkVLm+0wbQPvDJxZsfIiFWy2kDSmUspktX2BrW9hj3aR6XNYKEcu9yOoccKfuezfFHUjofinVwyNKykY65L2vACpDXcWXn3cK4qV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d072bd6-a49c-44e5-8b9a-08ddf7911ac3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:27:54.9638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qasXncoJV55H7MAFZpLf4a2eWrrskMLAGib9UB/9VcyxfDisyUTn9Xx3Z4zDRWbFNjXGUwL5UmWRUTsrjcm0iGVZnLmN3Dau0XfkpLwfRNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190144
X-Proofpoint-ORIG-GUID: oRceOS_DIJhm3P3ZhVZasN7FRbKvjey8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX483wKla41QkL
 PyWbT7kSlnLqzUmQ+QLmhHB+g46b3w3GMfxsqbTR7dyroTjqdc361fpwdFwPv5SJzBTAIILiw9w
 aCzSBE9PFR74TsBYnscoSY4O/6YKztNSaoCq+SPY2A6bjQd6KckmgvKrSjRL+9Law9tnYknkctj
 J6XG9NQePgv6Ji5Ktjx5/kOf8UjXe84XA7Fbd2hqN2AzlVkL8asfUGfpdUF+TUDjECcNLv3rU7i
 1ZyS7v7PeQYAZTI6ArgbbBvD9I3Tdof1mYU8x/X+OeNL6bbsJkL2xMkh6Vhu2f3tF7EaysPNejx
 RRrafF7Xr0twvGqn88DQlkKH0gKO0uxN/OQou6e3kErL677G9s2n0c9XIOfDtcgyD55tngIrqAu
 SGSezYasrqtktsxmFzpZ9phNt+ywbQ==
X-Proofpoint-GUID: oRceOS_DIJhm3P3ZhVZasN7FRbKvjey8
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd767f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PQm1RJz0RxnmLELT-lcA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/15/2025 12:35 PM, Peter Xu wrote:
> On Fri, Sep 12, 2025 at 10:49:23AM -0400, Steven Sistare wrote:
>> On 9/9/2025 11:51 AM, Peter Xu wrote:
>>> On Thu, Aug 14, 2025 at 10:17:18AM -0700, Steve Sistare wrote:
>>>> Add a qemu_system_exec_request() hook that causes the main loop to exit and
>>>> exec a command using the specified arguments.  This will be used during CPR
>>>> to exec a new version of QEMU.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/system/runstate.h |  3 +++
>>>>    system/runstate.c         | 29 +++++++++++++++++++++++++++++
>>>>    2 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/include/system/runstate.h b/include/system/runstate.h
>>>> index 929379a..c005f49 100644
>>>> --- a/include/system/runstate.h
>>>> +++ b/include/system/runstate.h
>>>> @@ -128,6 +128,8 @@ typedef enum WakeupReason {
>>>>        QEMU_WAKEUP_REASON_OTHER,
>>>>    } WakeupReason;
>>>> +typedef void (*qemu_exec_func)(char **exec_argv);
>>>> +
>>>>    void qemu_system_reset_request(ShutdownCause reason);
>>>>    void qemu_system_suspend_request(void);
>>>>    void qemu_register_suspend_notifier(Notifier *notifier);
>>>> @@ -139,6 +141,7 @@ void qemu_register_wakeup_support(void);
>>>>    void qemu_system_shutdown_request_with_code(ShutdownCause reason,
>>>>                                                int exit_code);
>>>>    void qemu_system_shutdown_request(ShutdownCause reason);
>>>> +void qemu_system_exec_request(qemu_exec_func func, const strList *args);
>>>>    void qemu_system_powerdown_request(void);
>>>>    void qemu_register_powerdown_notifier(Notifier *notifier);
>>>>    void qemu_register_shutdown_notifier(Notifier *notifier);
>>>> diff --git a/system/runstate.c b/system/runstate.c
>>>> index 6178b00..b4980ff 100644
>>>> --- a/system/runstate.c
>>>> +++ b/system/runstate.c
>>>> @@ -41,6 +41,7 @@
>>>>    #include "qapi/error.h"
>>>>    #include "qapi/qapi-commands-run-state.h"
>>>>    #include "qapi/qapi-events-run-state.h"
>>>> +#include "qapi/type-helpers.h"
>>>>    #include "qemu/accel.h"
>>>>    #include "qemu/error-report.h"
>>>>    #include "qemu/job.h"
>>>> @@ -422,6 +423,8 @@ static NotifierList wakeup_notifiers =
>>>>    static NotifierList shutdown_notifiers =
>>>>        NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
>>>>    static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
>>>> +qemu_exec_func exec_func;
>>>> +static char **exec_argv;
>>>>    ShutdownCause qemu_shutdown_requested_get(void)
>>>>    {
>>>> @@ -443,6 +446,11 @@ static int qemu_shutdown_requested(void)
>>>>        return qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
>>>>    }
>>>> +static int qemu_exec_requested(void)
>>>> +{
>>>> +    return exec_argv != NULL;
>>>> +}
>>>> +
>>>>    static void qemu_kill_report(void)
>>>>    {
>>>>        if (!qtest_driver() && shutdown_signal) {
>>>> @@ -803,6 +811,23 @@ void qemu_system_shutdown_request(ShutdownCause reason)
>>>>        qemu_notify_event();
>>>>    }
>>>> +static void qemu_system_exec(void)
>>>> +{
>>>> +    exec_func(exec_argv);
>>>> +
>>>> +    /* exec failed */
>>>> +    g_strfreev(exec_argv);
>>>> +    exec_argv = NULL;
>>>> +    exec_func = NULL;
>>>
>>> Would this really happen?
>>>
>>> If so, do we at least want to dump something?
>>>
>>>> +}
>>>> +
>>>> +void qemu_system_exec_request(qemu_exec_func func, const strList *args)
>>>> +{
>>>> +    exec_func = func;
>>>> +    exec_argv = strv_from_str_list(args);
>>>> +    qemu_notify_event();
>>>> +}
>>>> +
>>>>    static void qemu_system_powerdown(void)
>>>>    {
>>>>        qapi_event_send_powerdown();
>>>> @@ -849,6 +874,10 @@ static bool main_loop_should_exit(int *status)
>>>>        if (qemu_suspend_requested()) {
>>>>            qemu_system_suspend();
>>>>        }
>>>> +    if (qemu_exec_requested()) {
>>>> +        qemu_system_exec();
>>>> +        return false;
>>>> +    }
>>>
>>> Some explanation of why it needs to be done explicitly here would be
>>> helpful.  E.g., can we do exec inside a BH scheduled for the main thread?
>>> What if we exec() directly in another thread (rather than the main loop
>>> thread)?
>>
>> A BH is a good idea, thanks.
>> It only requires a few lines of code, and no globals.
>> I will drop this patch and add a BH to patch "migration: cpr-exec mode".
> 
> That would be better, thanks.
> 
> Then, what happens if we exec() in the migration thread directly?  IOW, is
> BH required (to serialize with something happening in the main thread), or
> just looks slightly more clean when exec happens in the main thread?
> 
> These info would be great to be put into commit message, but if there's no
> obvious reason, IMHO we _could_ exec() directly in the migration thread, as
> I don't see whatever to be synchronized in the main thread..  Anyway, if we
> want to exec(), IMHO it would be best as straightforward as possible.

A direct exec is not desirable for 2 reasons.

One is that cpr_exec_notifier is called in the middle of processing MIG_EVENT_PRECOPY_DONE
notifiers, and some notifiers may fall in the list after cpr_exec_notifier, and would never
be called.

Two is that cpr_exec_notifier is not called in migration_thread, it is called from a bh:
   migration_bh_dispatch_bh -> migration_cleanup -> migration_call_notifiers -> cpr_exec_notifier
so it is cleanest to post another bh to do the actual exec.

I will add those notes to the commit message.

- Steve


