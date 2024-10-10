Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28411D24442
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 20:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syzPj-0003vX-SB; Thu, 10 Oct 2024 16:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syzPh-0003vE-5U
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:05:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syzPd-0002qT-DT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:05:31 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJteBY003088;
 Thu, 10 Oct 2024 20:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7Zyb66ykufe6WjSp0o5Qk2cDpso4K53Zkk8riVly7nQ=; b=
 QSbIHwPeBGxWZjZp9ryzZRj/4SYcqtlhVIVncAI18LLkUgQjOh7+IZul8ipi6fhm
 e2FNOAF10XuKjuXgvhZbOfgCByiikCP6jq9FABmpGGAlI0Ix0C3ARLWS5awGBrdL
 CzZoDiToa0dQWTJ9zlOj4roaTJfPxDtV7kkGC0zAcmwUW1ZCegq04jD62fseDv2s
 QnbzzxwjyEepO4yTf51SbmNSEwSg+aKehR5nNsPs1wIekLhuAJjWWdHxdRxj7nxs
 bdiofpTYzMRVYg9owM5KF37vrvYNVhrPC+ubQZ38sQxQQtya5PuhWB9tgSMiwNwy
 NTL84djfYN1+qHnz5kyggQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dukx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:05:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49AIpeZU017288; Thu, 10 Oct 2024 20:05:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwgvdtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvYOMGRsuuNgCzMhm0iucXIcl/Q81zK9zj09BWYEj/CvGSh6wNfv6Ya5iV08k9caVN3ztajYIrFa2rLwIxjv5pN9vIc8Igea9X4cKD0nxY352C3LGS5xC8QlZ6zuAyhZhFW1X+chOlqY7fFN2PhKgfenKMkkDqzD6/0c9DnKk3ZejpfcR4Lq0h/B3nIaeDgGb/RlOYNUCJwGHeFKp9Ogq6UQAZCNcnumkX20jqYyna/dd5ka8JnFJpBsSLDIY3E4PKjxlFIG4Kf4PBuPnJstwQgjhICVLbdS1iBgELDHliZEa+GMdW021HGMSF6/BBaNxffETeV3T8jvNWarGDtvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zyb66ykufe6WjSp0o5Qk2cDpso4K53Zkk8riVly7nQ=;
 b=ft1xWE+ZyPZHDbjZanzz2enYqLiXxzta9pNgMmWKoGnh34P2Jfe5cp3PkpFIAJxgvyGcbvFGCwFhpN0n5rLh+7JWUNQksD+00usx6vSRMDOBS6g/zq9faZyA2wnmJFUyxQ/GxNZhgEzqnSpGNFphcFQkDeAZ3ItOX4SLRbTnQTYWblFHG/kYLCuOtswmoL2Hjr+t7OhiI85VbwI9f5WTG8wCIMJ/MjHKk10/b//Bmg0Bpbkrh+tSaTJyLGs6FP+JyVMllZzoyevCpAWmBKrWjxYP72Ubrjkcwl5SYX0AJa4+GGmi2JrlFG53DB3EYHO8gPw6L/EZ37KaoNRkfCAstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zyb66ykufe6WjSp0o5Qk2cDpso4K53Zkk8riVly7nQ=;
 b=XKY5AwzqEnoc/I8a4bBq+FGiDLGU3EjHDazbMwVxB4cjIMIxv8cBC3JVNjtotwLKFNhuwpsPqo5fneEb64EV9ALuKJ6c78+/mDcUQ+vzawmDJ9hGYH3sInI+SlyeRWQ6c9i3eVbKz4eqCWcucGvFjzzxhcJDzvkRxZWWWmDdf2Y=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:05:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 20:05:16 +0000
Message-ID: <1f70668d-fd01-4e09-8d09-6bb11294df30@oracle.com>
Date: Thu, 10 Oct 2024 16:05:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com> <87ed4qtpo1.fsf@suse.de>
 <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com> <ZwbUTXCxxl4heZYV@x1n>
 <Zwbgur3d0cImLV99@x1n> <97268719-56f3-4d7f-aa21-c04cd0262601@oracle.com>
 <ZwbuNnFCgN_vjniX@x1n> <87plo9rksl.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87plo9rksl.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 538f8c42-e116-4c77-7b0e-08dce966db9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk1icVYzYk8yN2x2MHV6WENreWN6Y0JTMktScEhGZ1Jod3dTKzFZZm1MU08v?=
 =?utf-8?B?dTU4U1ZySFFaMVQ5ZlhlOUkvNW5KMDFJcUU2RXE0RTVGZm9SM25hNnZ0UFQr?=
 =?utf-8?B?YUNJbVBURnM1ZUtSTEp1ZUJqY0hJVXg0c0QyYzBZNDRhMVdBenhOUGNveWxX?=
 =?utf-8?B?NDJQeXlnZ2h5NlBBQVE1a0lZMnFieUdiREo4Ly9GdVBVaUZNcThZQTkvQ2wz?=
 =?utf-8?B?LzdaOEhxU3hMWmRhVEdDazBFMDEzY2oxT3hrMkFSK0VMODVMdXptUXlyaXIv?=
 =?utf-8?B?dWg1VGFBR2RXR2FKMXN0QjA1MnFodjFjY1paZTVWdHFaRlV5UVRkZm9xTVB5?=
 =?utf-8?B?MVNwREx6MDg1eGk2TUppT0VzRndidU9GV2ljU3dFeDJoQjAzZXVaT2NObmNO?=
 =?utf-8?B?OHpYTHlOMks0TExKNlNxeURZOHFXZFFsOCtWdnMxSUhzOHQ1eit5ZENtQmhE?=
 =?utf-8?B?emVkT1pWSm00M1VBRlZVdlhmbkJNZEJZRGw3a0wxVTFuNTg3aXJhR1FBaUZM?=
 =?utf-8?B?dG5IeTJiYitOZTVmUi9IcC94cnRrTFY1bHdvTUhrRHdEM0RKY3ovNDNkZC91?=
 =?utf-8?B?QnhXMHVaTERmM1k0TVVNQ0pwc3hBZS9qSE5ZczdRZy9GM0pPZUhCdGJndXpC?=
 =?utf-8?B?S3Z4MFBjUGVXcGkvL2p5V0ltUlNOV3dtN2RabnJjNjFtaTF2b0I0V3VJNWtn?=
 =?utf-8?B?RUFEUU40Wk4ybUdBa0xDcHR0QXNyTm5IRVZqWkowYkRlZ284V3E3Njk3MDNn?=
 =?utf-8?B?VlpHSlpHNUFlYldwOHJ0ZlEwY2lpTi9QZUNsd210eEhCOFF0M1ZHYjJjdUNn?=
 =?utf-8?B?NXVZVzJZOGRHNzlrZU9kckpDOWt4RXczRWdPU0FyVldBVndVTDh2cFpQdllF?=
 =?utf-8?B?NlFGTVZoaHkrMGFOMFUxRHRXamZ5c05WUnRpc2NIWFdMbUw4R2psTG95a1lI?=
 =?utf-8?B?R1I4czcwUFNWWUxaUWVvZmhtOW1WOGtmbURFdS8wZnZWQlRRM3FjSG1XSklK?=
 =?utf-8?B?cVRYNXhZK3RWdS9JWHhCR1VqaUNPRkZzQ3dmWHYzWlRtdnVTZHoxOWNVSHR3?=
 =?utf-8?B?cFV6UXlXbzRmV3c1UDVYMzRSaVd4OVFGK2ppMmlnUnNxOGlRYUNVNVYyMlFO?=
 =?utf-8?B?cXRWN1hyK3NJVFExYXQxNG1JQkl4OFUvZHV2LzkyREpJaTR5YVRPbWJaL3l5?=
 =?utf-8?B?MzVBVHJ4aW8waWNIekh6QXA3TEtnOUc5SzVoeEx3S3hpVzk0L21NRkJPNllj?=
 =?utf-8?B?VjBteUlyeS9uQk5tTTNGb0FETnhMMzQxejVzQVZxdjIzS1pteXZsVzB5TWxl?=
 =?utf-8?B?b2pJa3JENXFGelNZNFBwRCtRWG9hUVFCMThFaHQ2NHpBaEdNbjFtbVM0Mm12?=
 =?utf-8?B?MERQV1NTWVdFdVZSQVc0QmpDaGFrZVVuUVRsQkRZbmhCR2pSQ3FOK1JSdlBY?=
 =?utf-8?B?Z094bitLdHlQVkY3MTNwWUZCTDdZL3p1UnZUZXJrM3paaXNDazk1QzdhbEFh?=
 =?utf-8?B?K3NWYjYzb1Y4aTJqM0tvZkZEZ2libTRyZW15REgwaEs3V2NQcjg3WGl2V1Uw?=
 =?utf-8?B?KytOTHZ1VU1Ya090b3BNd2xQVytnTVIwQ0d2UTg5WEI0TFF6SFV1dlhXYWxw?=
 =?utf-8?B?MWFlSTdiR0pKbkpqMFVNTUt1QkwwSlRLRURFSG90RWp6WXpKYW4rS2Z3dkd3?=
 =?utf-8?B?TVVROHNjUkNnRHdCclEzY3ZmZno3dU4rRmdocTdUakJ3QlBpSXlXK3RRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODgwSnV2V3liOEhZQWZNaERLOEdSUkhOQ25pUUFBY2NON2xrdVNFMHlxYkdC?=
 =?utf-8?B?WE1nSzZEb1FnQU5qNTVwUDhhSFBDT1ZSbU9PNm5qNXEyNmd5NlVJMWpaZHE1?=
 =?utf-8?B?dnNoZEhuVnZWcjJ0YVhDK0ppcTdXY1QwdFp3NmJSUmU5WjV4bi8raFJDZUQ3?=
 =?utf-8?B?SFFGQzJqdW95UHMzNU9JdXlYZDZodXN1YnRiTUhtSWxqcjhxVXpLdjJNQm5U?=
 =?utf-8?B?S2h0bldzQlludlp5N29NUWRuUzg0dlFrQWhIZnhCd1pHQnF2blhmVkJYVStC?=
 =?utf-8?B?WEQxRi9jNDNBVHdSUXhScE14R3ZXL0t5VUMzVVpzREllbldxdGhJWU51N2lD?=
 =?utf-8?B?VGlIM3BWbWdET1VmQ3E0d3pjZEF5ZzJpejhWOHpGYUY3UWJ2Wk9tdi9oR3Bq?=
 =?utf-8?B?VWZIeUJmTy9jdExYcXVoa2FVcTg1NzdnbzRoMFl4Nys4Ty9jVHUxODErVFZJ?=
 =?utf-8?B?TXphNHIyUlU5bUkvVlhPOWZCVnRuZGlwYnEzRUZHSlNFeTVraGllK2ROWU4w?=
 =?utf-8?B?VnllV21scFdFSVB4UFY0eFY2RFJ2bGNPZmhzNGs2b21aYnc2S1lIZWsrc1U4?=
 =?utf-8?B?TEh2T0wwcytvK0p2cC9vcHl5bDFNWHhvd2lPSTdDdUdlVEduRWR2UjZDREkx?=
 =?utf-8?B?WW9IY0F4UkE3cnZlM0xsTGZ2clRoZ243NG5kdzJRczdHWThiMUg1dXl4UWlE?=
 =?utf-8?B?RXYyWHFXWjN1QnZmOHhNTnAzTU5ZaFdNT1VlNkx1MnVDMlV2TE1qclYrZDBk?=
 =?utf-8?B?aS9va2hIWEdKVUJJM3dyZTBWaktDRDVNNk9PMUIweHd6bmJmd0dwbTI5OENG?=
 =?utf-8?B?M2VFUk05QnMzS3RhRFR4TFUxOGVoZjVhR1ozVDVxV2JJRGNKaytnNG1GNVhz?=
 =?utf-8?B?UnNkV0tsQXZyMllmaDNTSmx1M2VaWGNzNmI4RnA4Zi8yNWhlOTlmRXl1TlpV?=
 =?utf-8?B?bFVENE5RcHV4UlQxQU9QV1FxZzBkUWE1RVBpRkZJMFg0bHhaSUw2bWpVMHB5?=
 =?utf-8?B?djlPWkV2cHNFbklTbnJkZEtaejVQU0NSTXVUUC9NWTNvUFl4eUY1TGN5MFJN?=
 =?utf-8?B?b1l4Ym93QTZFVjdiVWJIaWoycWN2eVVGUnBNT05sNi9iNmRzdXlqRzhEamp4?=
 =?utf-8?B?bVkxTm1pZ3lmS20rb0ZDdGg4NlVxVUpkUUFhKzdMKytrTGlXUDZhc0hHODNL?=
 =?utf-8?B?VS91RUo2N0ZYNUtLMUoyajg5cUhSNjcyaWJuZ1hVSFhuWVUxcUxrREVLTjM2?=
 =?utf-8?B?SExKRnhHRmpPN2M2LzJkcWR0K1hzUTg5RGJ1ZStkU3dDUGlKTndEUDVRR2xE?=
 =?utf-8?B?bzNlTDNTUEhFazNIOS9OTWluRjNkbFcyeklwMUM3dmRPUC9xUDY5ZkVWLysx?=
 =?utf-8?B?SzlLdXFFU2pIL3lDMlBXa2laOW00OXpnSHJ1OW9jOWRKbW5JMVhaY2tMZHNv?=
 =?utf-8?B?amdiTmN4Mlg5N3hTYnR3alR4Z1FZMEduaW40MHBjQnpYMWU0L2F4QjFUZ21U?=
 =?utf-8?B?TkorQ0YraU9YLzZLNHNUR0tJSFZLNW9sTFlGRDZ2TGFrNTZuSmJVRzdkekRi?=
 =?utf-8?B?V3ZsOGplSDN3Wi81TGhFSk5QVTNIL1F5ZG5LV004YzkyU3FMMmZFNVJ3dHVk?=
 =?utf-8?B?YjJ1ckFQNW9jNFBLMmZIbVJRS2ExakF4eVBja1VkV2dzVmFpUEgyQ0MzL2tO?=
 =?utf-8?B?L0l3eTRBODZYNE5XblIzdW82dTc3bGwxeWxST09TNHo4NU9WSHppWG1JRlc4?=
 =?utf-8?B?V3Y2TnYycE14WTcxL3NyajZwaHduUk1PakozOEtPZHZocUR2ZC9vcWhVcEgv?=
 =?utf-8?B?cHU3d1ovanFFRHJOaWc4TFZ0WDlZRGtPSGNvNVZqQmd2dUxVNFk1d3dJTnBz?=
 =?utf-8?B?a2laYXFFZFFIcE5QVjlkWUl3Z25JYlY5S0ROTkZRTlZOYmd0MzNJT2pFUVpB?=
 =?utf-8?B?NTFERlM4elJ3dlpoM01iZXQvQ01xWWYrRW42K1N4WTZLOVd2ZWNSeDNZdGJq?=
 =?utf-8?B?RnpsMUlKZ1NiYkRDbS9FVjhrcjRybGFvN2lmbFllUUN3T0VjTHJpUnNNazYx?=
 =?utf-8?B?OERNTnBBemRQWnZSaDJQQVNVam50anUxZVY5YlVyMFFiQnN2cXJNRFJLLzdm?=
 =?utf-8?B?NXhRZzRzU3N1SW5KR1ovMHRzY3l2eWt2WE1WT2x6TG9RWURZcnJydHFVdkI0?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VWk54OAbaTl1q9AFrScP7beckfCOCrXNi+mBrVhgHyvgEvrMGSKYy6+BhZN0ceP21vaXEMVbnZz10pG6KLwEx/c/V5aTilQLb/wMxr7AhrCdB4aYr6El7kCJp4Jc+UHMmAqYMJt36wTGnej+T7D/lAtJx9JDG86WkYxxkmyfeMLJhkLrxxRw96v0MEDVQ4k3ckRF/CK/yUSAZ104wTeuBTme4TCG1bYwBhYXOCkI5OFv3FK2o8ESb+k7lvCEEyrOkMlOvhzcQQkJsCEI9qGM9kXEnEZ2BdQ0GH4RBCrpA2B+rnhhKzd/TivFrb6FGbw7rZ59nI04ZTolBaGQ9LwyaIS1RonChmcrDeKSYRZCpBnxS0LsOAefTtVRkvyx+YchBLUNzOalAfEZ3FaiQ9yWWybMFqDzx2n1sAaRB29Avmn9FlnTSihTS0sFvdwxw4gUEXPzkPTlUHObCbDWGAzikgdLZ9ZXBmG3Okove2A1enwsAUaa8jWDCIBgAgXcojQsjyrDtgm3ZPDlYIwJ+1zswjXkwAwv86f4AZSlS0x09P10R61aOepFuc3HpFv+eUAv+N0Q6cZ4mrIwse2BmBM6DelEvt6QYWvhw1yyEW7WLXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538f8c42-e116-4c77-7b0e-08dce966db9b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:05:16.2249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 586ePiJGzWofTUxAEcZRXSkiIbW/MO7H5zmi+o/Bufe7ag8M/LnbZlSfrz66BcU7GTHLmcBW3q6z2yvtnuZBqWoozH2qmeyFMm1KwHH7Dj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_14,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100131
X-Proofpoint-ORIG-GUID: 2gOaEUcrzBjpLq_CAGBNfj1JEsube2ZG
X-Proofpoint-GUID: 2gOaEUcrzBjpLq_CAGBNfj1JEsube2ZG
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

On 10/9/2024 6:08 PM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Wed, Oct 09, 2024 at 04:18:31PM -0400, Steven Sistare wrote:
>>> Yes, I am also brainstorming along these lines, looking for more gotcha's,
>>> but its a big design change. I don't love it so far.
>>>
>>> These issues all creep in because of transfer mode.  Exec mode did not have this
>>> problem, as cpr-state is written to an in-memory file.
>>
>> I understand.  Hopefully we're getting there very soon..
>>
>> I still have concern on having -global used in productions, and meanwhile
> 
> Agree, but for qtests it should be fine at least.
> 
>> it might still be challenging for handshake to work as early as cpr stage
>> even for later, because at least in my mind the handshake still happens in
>> the main migration channel (where it includes channel establishments etc,
>> which is not proper during cpr stage).
> 
> I don't think any form of handshake will be implemented in a
> month. Maybe it's best we keep that to the side for now.

Agreed, and a handshake in the main migration channel, which would be the
cleanest to implement, occurs too late. We should not rely on it to solve this
cpr problem.

I have a new proposal which I will send in a new thread.

- Steve

> (still, thinking about that virtio-net USO thread, an early handshake
> could be a good idea, so we could perhaps inform about device
> incompatibility, etc.)
> 
>>
>> I don't really know whether that'll work at last..
>>
>> So in my mind the previous two-steps proposal is so far the only one that
>> all seem to work, with no unpredictable side effects.
>>
>> Said that, maybe we can still think about simpler solutions in the
>> following days or see others opinions, we don't need to make a decision
>> today, so maybe there's still better way to go.
> 
> I thought of putting the caps on the configuration vmstate and using
> that to set them on the destination, but there's a bit of a chicken and
> egg problem because we need capabilities set as soon as
> qemu_start_incoming_migration(). Unless we sent those via the cpr
> channel. We could split migration_object_init() a bit so we can
> instantiate some parts of the migration state earlier (I'm not even sure
> what are the actual dependencies are).


