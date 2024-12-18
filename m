Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31E4E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0hx-0000Fb-EU; Wed, 18 Dec 2024 15:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO0hu-0000FS-Py
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:31:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO0hs-0005KL-GT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:31:46 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKJe0W005079;
 Wed, 18 Dec 2024 20:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=cMcxRt8Okt6KHuz/rGj5jduFhI1TsR5LxUCQPPF2Fpk=; b=
 VJKxgaB2mkrwsP5gTYP7J+UzGUdyy7N7xHCOqh46rGyqcj+NES3+SuVC7Aydb5DS
 js4B3/D2MxTn7e+UzykzVKSB030nv6B+ManlN/9ZX0SKxaDhx606JqbCSny+WSne
 qAIE9dceuFRBf5f+mmB9Bk34jQp621c/uADPG/SYZSGVNfrWUDjHvXNUECWDfBvc
 uTo4dp5hzQLq01DkgkziCaZh7Qhp5zrDlb2iQwd329m9R+ZwpqkecyTqRAGelm3r
 Uw7H8u8vhK26UFV5oxStJ+qCib5ZLA4pMtd4QY3gUwcWOuD5XbYNHgjf4d7odHP+
 c4nI+JMeMZZm2gvQVQOjVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt9p27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 20:31:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIJ4xHr010897; Wed, 18 Dec 2024 20:31:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fa6b8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 20:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru2lb8l9Ux5MWTtQl/SJPSpprA0O08TBtK+qdyKA8bjm2efkkoQO+gdIT0iMC9gXddsWOwqb/U01hvc40mwo7z9bzzCaqy9Ag8XAyBJo+nlDk3WhXmUS4O9yk2dPji2j9N52u9HepuGusXPPVKtyJuz/L4ArTiBLq4Py0yZdW3I1j9MlJjw+SnwbBRvu9ofa9/4kJGc+a3kTz9ai0XvgDrIXisQ4s4mDJMC1t/Ymu8UOghfho+YqelycPznnRgRA634mC6fH3qZJniSIHV0m+qoRQpXywJQzAHPMy34zrvOtMbQC8kHXes8ixvoR0adFZHGzkIvZYknhPo1xV1M54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMcxRt8Okt6KHuz/rGj5jduFhI1TsR5LxUCQPPF2Fpk=;
 b=LRZO6e5xfxv+BE/Om095ix126VRekWp10qlVRHbhZBITX8Zl6dRHT9BDDNEBAoz6wrWN6d3ASgiZJHCgtE50FH2EydCd7RcpchumJJSU40vT8TRfskQPKFA5DHpckuQwYBgPu6By8G8silKGFSIm5HfbEIVt9gKCRYmaJcBhyRSo/Yi1DYOOF5U6EbpJUhbcqawx4u/pMnVynES8inYPRavYCcL/oJh+4rnf6I4CbuppFvQ4BCy6ItvlA55e+3aflu+R2C63JquhvB2QTQ+p44QneABtHMsaN8ctXMlh/egsx/KCI9iou7ouV5eOEi4tJLQMO+hjDVHxH2h/EsgbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMcxRt8Okt6KHuz/rGj5jduFhI1TsR5LxUCQPPF2Fpk=;
 b=a0rOGgNsqLV9q5jpdY+7R852FeCAp/pTPcxEHB99qHgAy7IlfVDWzwfZgkszE2yrA1EriYXR4ByBipDp/9PND+x90UbFYUMKx/Ua/S4AEmPTS/EvtrO109LfmhN4oJvJnripCVHQicTppyNKfOmMMSEfwHYXSpZ6FOYiwWtOQ2c=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6919.namprd10.prod.outlook.com (2603:10b6:8:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 20:31:36 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 20:31:36 +0000
Message-ID: <fc1d4f52-7aef-47c7-ae0b-7d46c7700736@oracle.com>
Date: Wed, 18 Dec 2024 15:31:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/19] migration: cpr channel
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-11-git-send-email-steven.sistare@oracle.com>
 <87cyi6cf9k.fsf@pond.sub.org>
 <2ac9265b-0092-4636-8238-91331834ea77@oracle.com>
 <877c8d6ttp.fsf@pond.sub.org>
 <eef4a569-2f1e-4e5d-b2e1-31aed7b807fe@oracle.com> <Z2MwTcIurjwGoHuA@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2MwTcIurjwGoHuA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 64143bc5-4000-41fa-fab1-08dd1fa2f830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDBtdERpcGx1RmxLOTk0QlRTNHA5OHo5ZC9pamdwUHpaaWxOTi9uNDREWGpX?=
 =?utf-8?B?aHBNSGd1MjliV2JNRFVZVVpKT2JHejlYOHFFM3QzSFpwY0FSb01QdUtVdE1y?=
 =?utf-8?B?Qnlib2FtdnNhc1RNeGpHQnhwWStwbkE0YmZHWi94N2xLMmpQbVdxSVNBczBu?=
 =?utf-8?B?OERTSW5XVG1VTHpvTVpWd2pJVnQ0Rnp4clRUa25tejBVczB6MCtjWGFaWFl5?=
 =?utf-8?B?NzJHL3NYdVRVZ2ZJSk9Id2dTb3crbVdZVTRZem45eHFvNFU2aXRMNXM1eTNB?=
 =?utf-8?B?VjFPNkw4U0dGMjEySnpOS0Zhc2xhZkNDOXFpTFlCdm5abEhVSzJlQ3dxVWho?=
 =?utf-8?B?VVlpdzd3dHozcFVqS0g4M3RmLzk1NlpaeUpvVXo1Vy93MEh4blZlN1pDNm1C?=
 =?utf-8?B?Y1BNU2hWUE0yV0M3REdWODhhbGFzWmV5ZHVRZ1dYYk1XQmVVMmJFTVJsN1Rp?=
 =?utf-8?B?NFpydXh2UG1sODFnTklWL0tyekNqRE9JeHdRMGM5dnpmNFIzNTBBeEpuZzlh?=
 =?utf-8?B?eUNsZkc0RmM5b1NxRExrT0dGZlgyVVFWWTF5a1hvKzYxRkdENVRORTJoT0hY?=
 =?utf-8?B?YnRJYUNoZnpyQnNhanRyQVlIV09UMjRLdW5LK1NmOE9nU3U2S0pZZHVUK1RL?=
 =?utf-8?B?UExsNVJxVnNDbXptS09uOEtrdmpEUjZ3eEVaR1VkUzhFLzFUeGpmNXFMc0ky?=
 =?utf-8?B?TFBTL0hLWFQ3Q3BScERvajdIZmwydWdvMWl4YktSMTNwS3RvdW5CeVBZbmdu?=
 =?utf-8?B?UWJKMzlGWk42S1BxY0gwT0pGbzBDUnBWSThCN2FKeDdmRTQydFcvU0RmUWEy?=
 =?utf-8?B?dHN1OUNaV010MUdoZDVYZHpBZ1ljdlc4U0lEdEpZdU1uenhndDhma0NBOUJX?=
 =?utf-8?B?bU4xT3p5eVBiYkVNbGY5YlpEUkdmZWc4SWxPRFZyNElWUHZVbTJSelN2Kzg5?=
 =?utf-8?B?QnRraTBSd0hweFhJcldCbWlIRHNuSkxBQUVZck9UVUVPbW1iWnlqUVJDdUc4?=
 =?utf-8?B?MDdIL3lJTW1JOTZ3NVBoVlJrQ1lmTi9icGhoYTFRN0M4WUxNMWJhN0dNN3Bi?=
 =?utf-8?B?MmZDWlc5Z3JVNjUyTUtWMVliajZWNFpQd3U0bUxnTnFRVEZpM3dmaU16Tk9U?=
 =?utf-8?B?bVRYMnE4R0t4Z2hsR0R0eU9CekxRZG5yTkhkbnVkR2V4WG1pOE1IRFljb0N6?=
 =?utf-8?B?ODIyQnFaYlY2TDZHdUJrWFR6OUdpZFBXZG9HQkhTRkVUVHhZVlN0Z2JDQ2Ji?=
 =?utf-8?B?Y0pHemVOVWx3TWF1Q3FaK0FCQmVwZjcxYUFnM3lWQWtITHdiZ0NQdHFRL0x5?=
 =?utf-8?B?V1NkcmVSL3krZXVqallmb2JnZDhRdkl3aFVHdDVSNmJEcDhqMmJPWE1zcTEy?=
 =?utf-8?B?RVgrTk1FazR1OGg3VGVvRHc3aVpZdWRVeWo4UVFkTTQraHJJUytKTHJSOFor?=
 =?utf-8?B?L0R4QUZuK0ZTWEZ0NlVCU1E0L3ZkR3JvNGN0RTkyMStxRUxZdHptMEJRZWlv?=
 =?utf-8?B?bXVjWXhzRVpscWp5cmQ1eU5hYzlKOWNITFpvL3VIdS9QY1J2b29zVHAxK2NH?=
 =?utf-8?B?ZHJ3aFhIY05XcE9PZHRHcGs0MkVxcWNudFBBVUFmRHVoaVQ1bFpPMWM5a2hw?=
 =?utf-8?B?d3VFOFI5M1d2TlFUcmkrR3NmeFpGa1hhSElFUE8ydHd0MUlHSkpYYXVXWktt?=
 =?utf-8?B?YWFWQjNUK3RhMTRVMjhiQXV5UFk3L2dkNHFYK3M2Q0Q0RkZtVytSUGl0Y0tN?=
 =?utf-8?B?TjFZd1VyMVZYUEpxY3dWSW5QYXV5RGt1M1cxa3l4ZWo2UGRFRUU1VG0ydUNK?=
 =?utf-8?B?MG9lcnQyR08rOTdEeFB2KytuQ0ZvQnVxN1J2S1JPcS9sRTZJN0djd3U3YUlu?=
 =?utf-8?Q?cYfHBUu3TuGg6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpoK0ovWmR1ZmZBdVhQVGlncHV2REtYRm1UMWt0RlBtWU9VOWEvbUZIeWRV?=
 =?utf-8?B?bTJYVDNjaEcySkdSSkhjeDZQdmQ1Yzhpc3hLc1ZrTlA0aDZBRUVBWjNTV2Vr?=
 =?utf-8?B?N0F3NGQxQnJhWjVCSm1SQll4OWtiOEJETlB5RFpZVHZGb1ZWRlFHVktUOWNC?=
 =?utf-8?B?RE5RNnpwQ01PV0wwZVZqV2FMWjBtb0ZldWJNQUcrUHdTbkdWZVVPdkpLTjNF?=
 =?utf-8?B?RFljR1ZEWE43bXo1M2lvcDdMajhMUGxLcExRdXU0dDFsdkk2NUV1R1BMOGMy?=
 =?utf-8?B?eHVaOEU0b0d4OXdYK3JPc1dyY045c0ZkNnRZZHdLbHd0SU1TcmtYa1hpakpm?=
 =?utf-8?B?bWt0Z2I2Szk4VlNIM0NCZnMwaGdDMDhXOXFyV0tOcHFnU3p4MmpIbnQzRTl2?=
 =?utf-8?B?NE1GbDBKai8zYlJ5NHpwZkNoR3FvQlM2UVNRSGdLUnBFeVhZTUpWdGxMUCtm?=
 =?utf-8?B?THpTQmNoVHFxZXB5RUUxZWFhdDVkOTVnRGJ5MzMrVTlZZ2drRE95bFBEUjVK?=
 =?utf-8?B?ZzlsaGhLSXNpNUlWWGx5Y2Q5SUJ3VVFHUzNlU0xURllBSHBnbGVOR2hGUndl?=
 =?utf-8?B?WUFTbWtKamo2WHMyckRTL2R2SGZqck14NGgzSjl3T0ZYZ005ZnpMZFJMSlF5?=
 =?utf-8?B?cG4wU1p3OW1aZ2wrOUJEejIrMVUxdStoRlYybTlVdnR6NVI1TFNFU1VZUDBK?=
 =?utf-8?B?SzYyOFFNYnpJVmd5OUhwc2VoWlF4RFV4MG5HeVUyN0JsZklHajkvNE9MRzdu?=
 =?utf-8?B?a1N1RXJPTnl3bjhJOHhvRERyZFdvUXBZVlVQeXpKdDAxd2dRSEdocnVFemVi?=
 =?utf-8?B?dzFFdmQxaStGVGo1RXltSk01L1hYc1NPUklYdjA0cjRiLytWeDJUQmxLbE1P?=
 =?utf-8?B?RDkrek1FUEF6dkV3Q3hWR0dud3orZlZCam50UUVLZWhaRWpTUTBIdy8ybHlF?=
 =?utf-8?B?SEJFZHM2MGhhQW00NTRuaTUvTXc0V3BiNWFBcko3N3BZdkUraWN6eGducmYy?=
 =?utf-8?B?c0pSaFk3YWt5dkF5Mi9LQWVPaHRyUHlaTVlxUW9qbVZsTGppUmdmdmtrVElP?=
 =?utf-8?B?djBEUlFnVVJERGIvelNJd1V3eFRwTW8rWXNDV0kyTWVHZit3WDRkL1FZWGVP?=
 =?utf-8?B?ZUhvWW1XQzlqR1BUcEZGRHo4clVPOU9RaHhNTXNGVzRZNWx4cEJmMFZVRThj?=
 =?utf-8?B?bUlrUGZmTnk5eHRxT0ZjcUxuSm04QkQyTWRmaWdjdi91TDNVblNqd3QvdU9i?=
 =?utf-8?B?dEUrbCs1Slo4WWJFMXYwbWcrLzZITTBYZlRMVUFROU02ZlpRMThzdGNJUi9X?=
 =?utf-8?B?L1krbmhjb2NValFUUXh1SzlFdUJ6VlBuSm9CMHQwVTVHdjFSUHFmYjY5ZnQ2?=
 =?utf-8?B?dnFoOHJGS2RCNERLSmk3eisyaDZYcmpCY3BkSnNBcEhnN2Fobm1oc05IRFFS?=
 =?utf-8?B?NkxlME9SL29qblZxQjZrOGF6cVE3ZlRBVWtTbXVNOFJ1bnFuZFVIazdCdWI0?=
 =?utf-8?B?a0Y2ZlUwUk9qOUFnTXNUTFNCcjBqWm5yeTJaOElSeDBjTnZXck9iWWF5S05J?=
 =?utf-8?B?VVdmYzhWTWE5czU3emFsdHBLb0dxQnVGNVhnVkNJWk5ZdnlvTWs0SS9DVjA2?=
 =?utf-8?B?enhGSW1LYWJlQWtNenJSMHVNSTlZZU5TbHBJWmdRcldVWm55aS9uVTg5aGli?=
 =?utf-8?B?Rkt4dDc4a0htZkVUTkdFT2dXU1ppNlVoNExXUXJKVHF2ZXpRa0hnM3plSjFQ?=
 =?utf-8?B?WllBSUxoV25KNEU3OU1CcWY1Ri80Z3hvVlBKVEhGVDByVWRRSVl2aTJ0N2Vy?=
 =?utf-8?B?K2Vqd1VFZ24xcW05emplZTJVWGJNQ1ZCNWo5UW9NWDZxS0dJRVF6aTFUR2Ex?=
 =?utf-8?B?Rk40MFo2T1VESkZhZXlZU1NRa0N3eW03UTlGendkd2RxQTlVdWE3ajF4Y3VS?=
 =?utf-8?B?enduSjZDZHVxR3JYR2xnT3VGaVYrT0JmQ2lCTWJRL1lnaVZRWnFCeXN2NDBx?=
 =?utf-8?B?b0NleGxpalpTN2paQlB5KzFSc2NKQk0xRHgxM3hsTWVmbzEwdzd6ZFRycUc2?=
 =?utf-8?B?bmdWazkzbXZEaUh2MTMxai9ORlBRbWY4WERlNHk5NDFLWlZpaUo4alNQQ1dZ?=
 =?utf-8?B?b3dTS3gvMElESDhZMDE3Q1JTY2RUcnpubFQ5N2QzYmNQUi9KMlcxT2E0MzNo?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rhcqMGyQbkwlvm4/JjBtAFA1EjZS2S3QI1ypL5ck/vk8g5WEyXdZgIgs4LnIEbED8pD3Sq0gpm7egDza3nNpLruFx5NeSmba1o4F3L11J5ssTI///F0xTD6Fw2IFktyTQY+9DO8ikpV+OCv21AlsNo321nJMxvuroH5derVaJCSP5bnBHsLPqCqdgt3Mi5BUwBiBcY6m8vdHXxj1R8DngiS0aQO3oM5nYcl1TU4fEfNWzsozEtH0Kt5PkzyqiuOmADN+ZWJRTwD6Fwj8BCdD+e645cEyqx0IV1REGH2P6xTyXFkaVS2HU6/oNv9uXtPvBWFQQ6HoqkjYF7jYuKBk2OSwXuDfb73IdKqe6PcX+1eIzgMp8+RHEHAFEL0RbVDiWn75rGcP3H0p4o/uXpbAqTUKJYQd09mcXXSo0fZoa1q3ykhnGNxwsEpINoCHDo80RI6fPhqv1O+WB5VHeLgwEnP2/GUmEoorxOXqN3kTGjWU3YpiJ3XY5L+9jDCTO8yx/7l+1w6DSa2wyIpasQd6XQojd+k9bQnq0HlZmBW84ahv6Uvyk33jN2AmjiNxNT+pvt+a1/hForMqPKll+pujv6fTFg2E3DOUNf8B3BQPEms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64143bc5-4000-41fa-fab1-08dd1fa2f830
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 20:31:36.7380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fr4uB3BKIulfK++nt+pFPQjxR1prBedVEQ1s2TNJiEHGNO/WvHLtThrRcTIBSWmgzhgPfEexJNebjVvljA+G+1Xx7EibuT1wowN4Agi+Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180159
X-Proofpoint-GUID: BoWiRac2wAYhyEbu3rKfwIRRaylyrIrb
X-Proofpoint-ORIG-GUID: BoWiRac2wAYhyEbu3rKfwIRRaylyrIrb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/18/2024 3:27 PM, Peter Xu wrote:
> On Wed, Dec 18, 2024 at 02:53:16PM -0500, Steven Sistare wrote:
>> On 12/6/2024 4:31 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> On 12/5/2024 10:37 AM, Markus Armbruster wrote:
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>
>>>>>> Add the 'cpr' channel type, and stash the incoming cpr channel for use
>>>>>> in a subsequent patch.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> [...]
>>>>>
>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>> index a605dc2..a26960b 100644
>>>>>> --- a/qapi/migration.json
>>>>>> +++ b/qapi/migration.json
>>>>>> @@ -1578,11 +1578,12 @@
>>>>>>    # The migration channel-type request options.
>>>>>>    #
>>>>>>    # @main: Main outbound migration channel.
>>>>>> +# @cpr: cpr state channel.
>>>>>>
>>>>> What does "cpr" stand for?
>>>>
>>>> docs/devel/migration/CPR.rst:  CheckPoint and Restart (CPR)
>>>
>>> Suggest something like
>>>
>>>        # The migration channel-type request options.
>>>        #
>>>        # @main: Main outbound migration channel.
>>>        #
>>>        # @cpr: Checkpoint and restart state channel
>>>
>>> A quick glance at docs/devel/migration/CPR.rst makes me wonder: is that
>>> really *developer* documentation?
>>>
>>> Should we have something meant for *users*, too?  QAPI docs could then
>>> link to it.
>>
>> I agree, CPR.rst is user documentation.
>>
>> Peter, are you OK with me moving it to the "System Emulation" section of
>> the documention?
> 
> Considering CPR is very closely attached to migration, while we do have the
> migration doc in one place right now in devel/... it may make it harder for
> people to find relevant info.
> 
> It might indeed be an issue, and it can be a more generic that migration
> doc (no matter whether it's user or devel oriented..) always stays in
> devel/ so far..
> 
> As of now.. How about we still keep it in devel/migration/ so migration
> stuff is together, but then we move user-relevant migration docs out
> instead?  That may contain more than CPR.

Fine with me - steve


