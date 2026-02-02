Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E86DE73159
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 10:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmrc6-0008ME-5G; Mon, 02 Feb 2026 05:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmrc1-0008LU-T8; Mon, 02 Feb 2026 05:56:57 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmrc0-0004L2-Fe; Mon, 02 Feb 2026 05:56:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkX082ul6sus6miBCprCLjONt8wLYH84tk28aphxwBZ5voPXPeNUZaUgIResfN/Vh96xoXXo4b394N7LmkYSoLj9itU/99R2BFxxpwR1A71Jc1NTzhyATBZRluEtiJKB6qPdmo3q4kSvd8+pUzV+GnK9/KoR6jZRdZeVGp6okKnDtu+kdVenhS62VaOlqi1BVC9BXQJ+wIk0Z3AZHzZWpUnJEmFgRKuSVO172t+LNpbibPaKL7LFvskzkTREWuwOSJZs3dELYu4xN38FxmAdOjJdX+HKzHEiB83ptyOiqrLomIOYSE87vGg09isYhsMvYgVuxAnsEKqXr84JJm7Acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xuRJqNOoLlIHmVZHeqWAEuu45ipfipX0GpmFHqOORI=;
 b=iZUhXWmlZ/r3QHX+pvpoLi8SBqLBwxUl1MRh6ao2I9dP4g5kgiNJDa5Po9y22gBrTMmw+b46TKi3Mvy55vGmsccimPbXFcih1eUXlfJ1VzfjHAOCIteAdZNCszi2uoAxdTNfZ1Kx2OO9lVCrWvKtRJHQ2WTdG5MGk2oYe0dIMajQmqiNUaorOT3PDu4VIIZ8MHitkWT3GyKEkXX4+qaYc7VJmjC9WLFd9RVCpSiZvCgUOgMrdfW67mkqc8WJW1XMnLQVqwFj1wjs2jiupJr+WKxjmbBesLrMuEtopNK+gPDGr0JmjTufzkP0r5g1VbEMgCxhLkTqpGz0/QazskSQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xuRJqNOoLlIHmVZHeqWAEuu45ipfipX0GpmFHqOORI=;
 b=NxHkNp+HQgbxKKXFZrsTBfGuJ9wkmACFvJSwbofD1fhgWtwVIaWLE89lMDoWMOD7ABPjDDkc3eFtrX6kODR0wlTGzEezRN4Bp7+ZSEcOl2nw9MyyYR5Ly1VIZKWOaz7GE2+52CciGakPYqewaZut7362g8QhCKrBM0xAYTOCvwLFbfNo/UTTsoV1wQSHbf9NxW2d72RkGoS/dKIXoQcJgI1LWYXWbZDJ0qMYh4cxXccAq4ZqvwIegoRV+2jHO0VajRRbfpD/eflZjN7ulLKLP0DTCCV2wf5eYbHTbB4Va9jL9eOTj0aHNL2qUBVRd60ZllXWjBy557xQmSW/cSQS4Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 10:56:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 10:56:50 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v3 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v3 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHclDFeCZdQrBjlSk+1lv+0pW4egrVvPKPw
Date: Mon, 2 Feb 2026 10:56:50 +0000
Message-ID: <CH3PR12MB7548910F67944630CA7D4BA3AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
 <20260127103328.255382-3-skolothumtho@nvidia.com>
 <9515e511-172b-4994-b5c3-b4f7606fbc27@redhat.com>
In-Reply-To: <9515e511-172b-4994-b5c3-b4f7606fbc27@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY3PR12MB9679:EE_
x-ms-office365-filtering-correlation-id: 41613a2d-ced1-4ab9-a6bd-08de6249c498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eWJkT2NONmVkSHJXa09VUGxuRVpaQ2t2UWlFT2NodlB4WDBLdHBUVGp4SnNz?=
 =?utf-8?B?eEhjRWExam1hMEhHZ0dxRzlaRlYwZ0dxZHBINkVwdFI0VThNZjkvbEpzbkxu?=
 =?utf-8?B?MGF0T0JsNEFSWVhnMS8vN21MOWhlK0JmbHBnT29SMlQ4TFprc1dyWjJVeTlJ?=
 =?utf-8?B?NDBpeGZQTFFqbnlabFZVdzBNOUFEZk9yR3AvSlFCNzE0RlBvYkpBa21yU3lj?=
 =?utf-8?B?WnEzWGNtU2tIRVZzK3Q1M0Z2OXFob1UwaHkvT0ExUXdQa0daeTdzSGc1L0tE?=
 =?utf-8?B?R0x3R2hzVnUxTkZodnlBYktWaUtGNDVvcjBVQkpIN2dRamRBTkpnS1BYWGw2?=
 =?utf-8?B?K0xMSnRaY1NoVTJLN3RFQjNCYmZsaDBPTWkrSW96bFdhSlNCRFN2NEIyYU82?=
 =?utf-8?B?VWUvNGM5d3JyRjVHQlhJVzBqZStSVGVUdmJ4WFQvR1FZbXlpaTRQSElsUU81?=
 =?utf-8?B?c2ZWaXBOY3BVNmc4dVc2M1RHSHEyYnYzaUo5MzBLOU1tdEVvV3B4ZVNvTHRI?=
 =?utf-8?B?NnBtQkFUQWY4eld1K1NBOCs2LzFXTWhyc284d1JFVytTMERRbExGYWMwMmdL?=
 =?utf-8?B?UFBOdlo2SG5MZUZoaktCZGg3V05NVkFFb2FGTTJYemNnVzFhUUJLNFFGL3pC?=
 =?utf-8?B?UXpJTVFHdVVpUWhpYzk2b3U2dDIxUTZzeG01VlRUd1BkWWgzdExETkVKUVRx?=
 =?utf-8?B?SVB1RDM3a0JOeGg5SGJndVJDdW9RVGp3L2hMLzVHZ2lmeXljeFBzZUtRUkll?=
 =?utf-8?B?dStZY3o4Y1B0SGRCR0ZXTmJtOURPUkhFRTVmMU5JSTNkMlJ4WlExVmtsYUdp?=
 =?utf-8?B?ZHVncVI0N1k3dFBndWdQM1RqS1JvNVE4SE1jeks1M2Z3WkR3Q3RueE9BaFZw?=
 =?utf-8?B?V1JMMGJlYmxHeTFldDczVjFhcGxiNG1iMDZjYzFMNHpPOFVNT2IwUkt6ZTFQ?=
 =?utf-8?B?Mkhuc0V4Z25aVUJkc2VWZ2xZUGd5REc4dkpKMlB5WGJQdnB1N2VTUnBZZXdL?=
 =?utf-8?B?dnNkbHdOYzQ1dHpKckFucGFGYlY1M3RPRTZMaFFhbWhVOUFWcVUrYnRWRm83?=
 =?utf-8?B?MGwzQ1Q0VGF0UHFFdkxwL25mSXRNWFFWeVhhM2ZkcW5ITUpkU0Y0ZEFoRjQz?=
 =?utf-8?B?bjJQczM0VEdFV3ZCQ2ZlL2pHUThDOEJudnI2SHZBZ2dMTVpaSHVEWU5OV1NE?=
 =?utf-8?B?WXY4cXBadE1tSlFvTVBXTitDZWRwQnpHdjJSVHJvTnVkMFNxVWZnYVo0K2hz?=
 =?utf-8?B?WnVnM2NhQURFVG1RWEtGWTYyWkoxYlVIeTV1OStDZ0wvc3JDTStvUTM1cnJn?=
 =?utf-8?B?Z3JEV3FLQUFuNTQ4YlpuSG1XMFhhWUxOc09GbDFDZ21RLzBxSmU3bFZmcUtZ?=
 =?utf-8?B?WEdrZFdZQ0RHY094TTNaZHBKZEVlbk4vVFl3V1BlVm1JdzNSKzBpNUwxZldS?=
 =?utf-8?B?d3AzQTZjZ2MyZE55QlhZclczWitXUWs4bGhMeGw4Y0VuYzdFcHN1WmZwNGw4?=
 =?utf-8?B?WHpPaEN6N3U3RjNqbENQaWYwVDlSSjJYUVh6THFYUG1WZXZtT3V6UWR0QnZ3?=
 =?utf-8?B?SnlCeG9ScEd0U2NhWUFRTWR6K2lLZTZXYnJMQTdPODlEOUhwbnNWRkpGTWg5?=
 =?utf-8?B?eEVUSzZMREh1cGtWUjQvZ24yRENkYlNhdWM0TUdSWTFyWUhLN0ZWanFxODIw?=
 =?utf-8?B?cmVpUStKZlcwSjIyVmowMzU4NnQ5dHR1d0xuSmo2ektESjZXRklkS3p3YXlG?=
 =?utf-8?B?SlMzRlpuaXhuOGFPV3JlaHpwc2RDcVdUUUFkd0pmaGxDMnFSb1JnVGZsV2Jh?=
 =?utf-8?B?cm5OY0wvR3pPOFpmcGNaMXpSVDFzU1RtK2lYd0tlY1VzYlB1dkF6RkE5WTRP?=
 =?utf-8?B?RVJ2K28rVXZnZzArdzEyRHJTOXZESlVQakF3Y09ENER3TnRhYk04Z0xpck14?=
 =?utf-8?B?OUtzSENhU2U0cjFwMXRsbHFzWWJlWUNFU1RaeE9LUGIwUzRvbEpzZjIxdFJX?=
 =?utf-8?B?cjdJajVrSEhBTWg3bVBkczRBcVg2OHd4L1NzSkd4clhhSjNobDgvVVhkNmJR?=
 =?utf-8?B?RHdXdnBjeVBMcEMyQ25Qem50dGFXZy9CUFBEaEtTU1BhZVJZS25oWFVIS01G?=
 =?utf-8?B?OFlwZ2ZybTJGaHJWYXQvcWdZUTR0OVdadkNEaVVXbEhaOUNoTTdicjlWb0VJ?=
 =?utf-8?Q?TcC2RcBnBlBCcXuQcBaz1+A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zll4RFZ5V3hzZjBGeitkbVN1YXhOUklaaFVCRTdlTm5Wc2kyOUlOSFlEemF4?=
 =?utf-8?B?WEY2OWZ4QThIVXJYSkpsU1BGdndOSnFSaERib1EzTEJMREI2dVA2QWxmanBM?=
 =?utf-8?B?SHBEZkRnMFlhTEU1UHNDOS9weGxydVRWbHgveUNiVmNOUGsvOHdzbXpiUHFu?=
 =?utf-8?B?TUpTWkQ2VDJHeUFJOGF1SGVnSlBFMnNCTHk3eHJDQUE2cHN2NGt4VDFxaVRq?=
 =?utf-8?B?OTFvbEk5Z00vbWZlR3BMT2QrelRCVFkyK0xnMGw2Zm5qS043WlNUNzFEUTgv?=
 =?utf-8?B?ZjNqbFhqbHhFWHJiVTdSWlhiWnR4TXBpTEtIWVpsUmNBNVlmTXlSekxpWlFI?=
 =?utf-8?B?anJ2MGdDQVdnMWI1NzZoUStiTXJ4OVgxUDBaTjdhMlVHS1BNZmxUcGN1Nzdp?=
 =?utf-8?B?TlZxNnJkS24vSVhKcW9qR1ZpZXJMbElpNWRCYU1zUlM4Q3d1T3kvK0hhT0x5?=
 =?utf-8?B?ZHRGSW9ObUw1RUdBemMxNnpTQXl2NWROL250ekhsZTd4bjcwWHFhM0hyaHQ3?=
 =?utf-8?B?VjNYQU9ZL1ZTYVBEVVJKaXVQQmdia0ErSG5hUG5PQ0F6VTRPS3doa0RHWVF5?=
 =?utf-8?B?cjVGdWJQT29CMU93WGdHeHdNZmhmcjRSK3dZZHRQTXdudkNjMVJuY1l2VGFZ?=
 =?utf-8?B?U21YdDhmTVk1VFd5OU9XTityZkpvMHBFTkc5UzF2ZENxWXFvUUZYSnNsbC9M?=
 =?utf-8?B?QkplS21HN0tXTEZHanY5Y2RkNk1vSHZFVkluT0M0MndlNUk2NHJrK3pMczNW?=
 =?utf-8?B?eW50YWNjVkY2UzdIOHN6NlZXbnlaWWNHRnNMSVNiYjU0ZzRXNlNZa0lOaGRC?=
 =?utf-8?B?aG4reWt4bEgzZXMwbzI4MkQ1NnlGdWxqSlVLS0RrSk5lblp3Q3Bvc3dHTUUz?=
 =?utf-8?B?aENNSGYrOUFVdFR3TXVIUVVuNTFTQ3RTU09LYUlDWGVTNjVCcExWQVMzWmQz?=
 =?utf-8?B?azhueG10cmJra3FndnZUZzJZZUxiNXFEd01MaUhoT1pCd016TDg3eFZyWWpx?=
 =?utf-8?B?WVRQTUJaYkV0SHZ5NVprdlFHbTJ0WHJuOEVlTTRXaHdqZFhkeG91ZVJaMjhV?=
 =?utf-8?B?YmFOMVZGYU9VSElaak51a3NsdVhnK3NhOUpIWEFjQmVDU2FhM3pzZi9wbS9B?=
 =?utf-8?B?YXU2d2xnVGVhMjlBVXMwb2FlZHpjUVFPQUJMeFcrSDlnSXJ5UkJqYkl4ZEty?=
 =?utf-8?B?M2lCVmxrOG9EM0VQZmJtRkt1eWhHVEVPbENiYU1oazVuNWNqS0taOVFBcmh4?=
 =?utf-8?B?ZUR2ZW9GWU5RTzZPUngxaWJsZ1E4L3pjY0xxMlo3UjkzdXZMK0pLdlUvY09z?=
 =?utf-8?B?b3V6MkxUYUlLZDJweWUzQXlHK0tiWUJSRGZHeFo0QXdrVFUvWXlRVEhoS2FP?=
 =?utf-8?B?cGpDM0lhNXZNL0VVK2tzbEVrNDljL0JkWXc0eGZkZC9ZYVFzVXpHWm9WWmkw?=
 =?utf-8?B?Vzc5eWE5RENZQy9EUEs5R2pGaGhkc1JnSk5DNkRQdnZTQ3owRURkdVR4ZU5Y?=
 =?utf-8?B?TlJIeGUxdExCaWVoZytLWlJnRVlISjJoamxLSEdBVldmN1VzNzFOc2tkMjI2?=
 =?utf-8?B?Tm5Pei82VGhWMCsrSEhwSjhrdmFpZXdWZWVjRDBwWEFzOEgrMXQrSGdqTlpx?=
 =?utf-8?B?RjJpSnBXSDdmZ29MSS83NTBhRlBsWTR1dyt5M01mRE5tc0tQK2xqdHliYmo4?=
 =?utf-8?B?U2VRczFMVHJ5YlZWOUdvdUN6RVZiQktYYVdZbDhiN3dEbkd3bE9hbVo2eXJr?=
 =?utf-8?B?emd1YTlZTklUbzZDOUZ3dDB4SUVSZjYya2krRkF2RDlzb2RhaVR2NzMvdUcv?=
 =?utf-8?B?Z3dya0VKU1IxcHl6UHozV2ttbGZnRFFZVllFTkUvcjhienFmRlYrUk1nRTV0?=
 =?utf-8?B?TUhIc2JHNmEvQllHZmY0VWlRYXZ3K1pZdXhhQ0hvY0JoTU1Ld0hoNHRUSU9x?=
 =?utf-8?B?dFQzVkY0OXM2WG9kZUZFT2hsbm9IYkp2WXphYWhaWitGTTZSQVVueFpyeEpS?=
 =?utf-8?B?MlBHdkhRUko3aVVBb0Z5OE12MEh2d0RhVmNlZ1hJemtXWDFPQ09ocjBPY2t6?=
 =?utf-8?B?QnpiOGZ2L0Q0V2o5NTBHcU5YdUU0MXJocWNYQXY1SEtvdTdtaEZoSUE4WEEz?=
 =?utf-8?B?V1owc0dxRjQySU5PMjA2SjZJbFdldVZPMW5RQmVYbXZzMUhxZ1hIWFhxM2cv?=
 =?utf-8?B?b052QWJ3Z0hmUUVYekFSNmtydEp5bGMzL1oxMzF3OGJ5ZCtUWlAvSnJTY2Qw?=
 =?utf-8?B?TGRheStSd1BGYXlyNUczTUJnWk0xQldqa0RFdThsKzNuc3Nuc0hpMVlGMUZL?=
 =?utf-8?B?bHV4MnpVVGltNnBaYjJFcVZBN2JRckhQV1lEQjdoQUgrVEQ2VEo0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41613a2d-ced1-4ab9-a6bd-08de6249c498
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 10:56:50.3367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JN5kLbWjj+NYiQhDj/6wL137gc6fj6v7FfAh3kiUUy/crf5smZtL8iJJcZQFVUjMlkKBP953v1HSIVSbuZe3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwMiBGZWJydWFyeSAyMDI2IDEwOjQ4DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0
aGFuDQo+IENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlh
LmNvbT47IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi80XSBody9hcm0vc21tdXYzLWFjY2VsOiBBbGxvY2F0ZSB2
RVZFTlRRIGZvcg0KPiBhY2NlbGVyYXRlZCBTTU1VdjMgZGV2aWNlcw0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiAxLzI3LzI2IDExOjMzIEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEZyb206
IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IFdoZW4gdGhlIGd1
ZXN0IGVuYWJsZXMgdGhlIEV2ZW50IFF1ZXVlIGFuZCBhIHZJT01NVSBpcyBwcmVzZW50LA0KPiA+
IGFsbG9jYXRlIGEgdkVWRU5UUSBvYmplY3Qgc28gdGhhdCBob3N0LXNpZGUgZXZlbnRzIHJlbGF0
ZWQgdG8gdGhlDQo+ID4gdklPTU1VIGNhbiBiZSByZWNlaXZlZCBhbmQgcHJvcGFnYXRlZCBiYWNr
IHRvIHRoZSBndWVzdC4NCj4gPg0KPiA+IEZvciBjb2xkLXBsdWdnZWQgZGV2aWNlcyB1c2luZyBT
TU1VdjMgYWNjZWxlcmF0aW9uLCB0aGUgdklPTU1VIGlzDQo+ID4gY3JlYXRlZCBiZWZvcmUgdGhl
IGd1ZXN0IGJvb3RzLiBJbiB0aGlzIGNhc2UsIHRoZSB2RVZFTlRRIGlzIGFsbG9jYXRlZA0KPiA+
IHdoZW4gdGhlIGd1ZXN0IHdyaXRlcyB0byBTTU1VX0NSMCBhbmQgc2V0cyBFVkVOVFFFTiA9IDEu
DQo+ID4NCj4gPiBJZiBubyBjb2xkLXBsdWdnZWQgZGV2aWNlIGV4aXN0cyBhdCBib290IChpLmUu
IG5vIHZJT01NVSBpbml0aWFsbHkpLA0KPiA+IHRoZSB2RVZFTlRRIGlzIGFsbG9jYXRlZCB3aGVu
IGEgdklPTU1VIGlzIGNyZWF0ZWQsIGkuZS4gZHVyaW5nIHRoZQ0KPiA+IGZpcnN0IGRldmljZSBo
b3QtcGx1Zy4NCj4gPg0KPiA+IEV2ZW50IHJlYWQgYW5kIHByb3BhZ2F0aW9uIHdpbGwgYmUgYWRk
ZWQgaW4gYSBsYXRlciBwYXRjaC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hl
biA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmlj
b2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxz
a29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3NtbXV2My1hY2Nl
bC5jIHwgNjUNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
DQo+ID4gIGh3L2FybS9zbW11djMtYWNjZWwuaCB8ICA2ICsrKysNCj4gPiAgaHcvYXJtL3NtbXV2
My5jICAgICAgIHwgIDQgKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFj
Y2VsLmMgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMgaW5kZXgNCj4gPiBmNWNkNGRmMzM2Li5lODAy
OGQ0YmU1IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+ICsrKyBi
L2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IEBAIC0zOTAsNiArMzkwLDU4IEBAIGJvb2wNCj4g
c21tdXYzX2FjY2VsX2lzc3VlX2ludl9jbWQoU01NVXYzU3RhdGUgKmJzLCB2b2lkICpjbWQsIFNN
TVVEZXZpY2UNCj4gKnNkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICBzaXplb2YoQ21kKSwg
JmVudHJ5X251bSwgY21kLCBlcnJwKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBzbW11djNf
YWNjZWxfZnJlZV92ZXZlbnRxKFNNTVV2M0FjY2VsU3RhdGUgKmFjY2VsKSB7DQo+ID4gKyAgICBJ
T01NVUZEVmV2ZW50cSAqdmV2ZW50cSA9IGFjY2VsLT52ZXZlbnRxOw0KPiA+ICsNCj4gPiArICAg
IGlmICghdmV2ZW50cSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gSSBn
dWVzcyB0aGUgY2xvc2UoZmQpIHNob3VsZCBhbHJlYWR5IGJlIGhlcmUsIG5vPw0KDQpSaWdodC4g
SSB3aWxsIGFkZCB0aGF0Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

