Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6C3C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7X2r-0005b2-ND; Wed, 23 Apr 2025 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7X2p-0005ag-BR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:09:31 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7X2m-0002pf-BR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745402968; x=1776938968;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=A9qF9M3jRBbpbbxh4kTyCzOxdrXahi2bVhNhPib+sg8=;
 b=KsyWFH2wgEXGQIpjVj38mXtYJ03cMqBJYjfxeaRFjWnubn3wUZ9LBRJT
 17PmpsZrnjsUg+ZMxdCPZyKd7wnJmdKJDnUnluOFXfq9tJOwf4WwNs6UD
 OiPvKNA4lWDPql4i5wrPTD1yy4BKdYSr6YWuEZH6K0CxCLUZ8bD9SD1pJ
 KAIBeJqEUFYFA0CCGHLPK01z9sISlhZtZVUDGrSbbyp6V5Dn3o+6Xj05C
 5sFYs6ncLhbJBZMcC0aEbjTNkWTIXnGQ5OoFnuA6keCWbUThPh+CrDxfU
 iWn0Q34x2WG9e1l2zepaQuiD6IHVyyj+p9RQiKuwoLmYPGMhnaInwqMQ5 A==;
X-CSE-ConnectionGUID: jflx27kbQ0O9yzKcUFZT0g==
X-CSE-MsgGUID: qk3Lahf9Tr+Qi5RtnAgGmA==
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; d="scan'208";a="35563206"
X-MGA-submission: =?us-ascii?q?MDGjjgkUxcFkDo4KYwO4O+su68zxofQO7DVxkt?=
 =?us-ascii?q?YnLHzZt1u7sLqNn6TuQGqXzNfqEKeJcHKxqAfEQWQvAusvNdaENvghx9?=
 =?us-ascii?q?w6IkZpe/JcfzRxYsIuvQ7k+ZIcP52cPE3XAG5M3x2ibmCCSloxFhwU58?=
 =?us-ascii?q?pCEjRAcIDCk5W1+j/BF2LqXg=3D=3D?=
Received: from mail-db8eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.113])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 23 Apr 2025 12:09:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSD2bbFKlwwaEdpBdo9IaWFznd0FnycSsxKq6bSftoskoESd4S1pgbeZcfO706fGnpy7gb3lwx8uGpRU1J42fEq9VYf9nmzzk3Zgg5j0qhVe19vYajVDoPQy2te6GI1jK2StIL0i9jxIRjyH78DXU3vTxkjfymfjKn3jKtb0K/VcCjvK7iV50K6JzJplAAxL0xczD5kh/T6umMjMghXAOUT8e/HmdUTRph1Dqm+PAnVKSgd1LQ+JkEBxumKWkaL/FaYjaTmp2gC4d5A0q4wyV3phIFB0PLySanaIAoJx7IWXz5pGUQI2Oo7VkV2V7Tl+Z6yjrdvvlanO51u31a78cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9qF9M3jRBbpbbxh4kTyCzOxdrXahi2bVhNhPib+sg8=;
 b=uJOhoBjqhVrhRX04hAgpV+W93J2VFTvwcI7rCDL3RAZeHNjbQ18D+burkBm9GZYOfL4z+cACDr4eUczmBgq8p+Q0zPN+gvZeFJY9pEkVw67E0uCUX38vF5Ch5CHXlhY2JUJdzGrGsiQmztC8HO7woZy1t34tBFhwFMT6OzYa1XxnGZLvMwWscR4ju5QNzZD62OaQmC7yICneYgObNA96Z6OXNOwQTc2wzHjmfJytleqy+TNFRLp4RiD/WzTMJksUrnTRPSBe4HLeFbEO2qeCGAY/30OYm6vWMDXyVBdTM3ZcwQAh7iyQELuIDuqeS8uoYqG9EbLwllHLwB/8NW0l9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9qF9M3jRBbpbbxh4kTyCzOxdrXahi2bVhNhPib+sg8=;
 b=cIMDFfB38zwM6PLV7XCX+U1w67rP60jtf9zRAn3Z9riYocg3Z2FOvoqHXEtMFVpAQzh8J5p8UiXC00NBJtNCvC8/cMgYbgffoWhh6LAcYoFng7q4tiBeukNnHpcui6H5R9xxszsJ3TUagA2oug0uwa4W67StaZu5n7LTXO7ohtr80yBpT22qRmHcLJPQQO0rHUDSoYq3I/n6jqlm6JI5s9q0nttPBmoSxBOZPMeg8Bl55dW+SYryF4eXbM7PGofv6v/EjMKC3lkClKAyqDi+Bl33Arndftr3yTc5zTUbZgGt9UAmB90OJHGnpe53X0t3ruj38rL3/uhUM4YDTkgHsA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7845.eurprd07.prod.outlook.com (2603:10a6:20b:350::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 10:09:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 10:09:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 1/2] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH v3 1/2] intel_iommu: Take the bql before registering a
 new address space
Thread-Index: AQHbtBHswoqaONJjl0KQ7HZVe2CuOrOwwdeAgAA2iQCAAA4igIAAAOCA
Date: Wed, 23 Apr 2025 10:09:18 +0000
Message-ID: <e55ae1b6-0e05-41d5-9580-932566cd6d65@eviden.com>
References: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
 <20250423015815-mutt-send-email-mst@kernel.org>
 <b848eddb-8c5c-4e25-a88c-36583a485d31@eviden.com>
 <20250423060502-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250423060502-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7845:EE_
x-ms-office365-filtering-correlation-id: c6ec7412-7380-42b1-23e9-08dd824ee935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGMvdU9pSloyakI0VGdpWFRwMWgzWHZ4cmVpT2VjTkZ1TjR6aG5tRitLWU5L?=
 =?utf-8?B?YVBERlN2bGhNeFhDbEQ5RTRyMUlXdTdBOGdqNzU0eVJtTDhqNHRleEp3UUFX?=
 =?utf-8?B?Z1JZbFZ3TExYdU1UeVZEdzRHSjBvTjBsUW5XS1Nxcnk3VHAxVXg0cW16MWZ4?=
 =?utf-8?B?WjFhM2FtN0c4d2dXUlgvZjE2QW11aXVtbXhWcjJLZEF3ejN2UjIxVDJKSXMr?=
 =?utf-8?B?QmtPRFJiT0tzS2NMUkN1KzE1S2xKR08wOVliazJtVkJGbXpUZDVCYWdvZnVh?=
 =?utf-8?B?cFU0SFZ5SXdKa3ZwRUVOYWIwa245OGtQYW9idHBvd3JYWEpMNHY4Y2xWNkFr?=
 =?utf-8?B?d0tNbzlWT2RqcGJrQ2JYb3BjMHU4bXF0aWQ1aS9xcW1VK1ZaSml4RUgybFFG?=
 =?utf-8?B?N3ptalVQMTM0THNUQWpGZVhIajl2WHRYckwxdjh0UXo3YndXZjMvZG1PK1hN?=
 =?utf-8?B?YVhMeVBGM1hLMmY4OHVmVTFNT204aENqdDFvcys3WmhJaWwrdEFadyt4TzMr?=
 =?utf-8?B?MllzYmxIdGUvZDVub0VVcmY0TnR4VExEKzBaK2srNWJ0bFBwQ083ZitacnBj?=
 =?utf-8?B?SnlnR2s0ZjhpQlpkejNEZTRHbklnWXBEUUl2VERLYUl4QkMxSFlyb3Frd2JN?=
 =?utf-8?B?ak9JbmNKV1A0SFpJaG5XWU1JV0l1VGdyUGptbzQzU29mWVZRczM4L2ZFMWNP?=
 =?utf-8?B?WnI3M3cyZVc0VXNqVzlDelBxSW1maFlzVzc3SitCZ25KMGZCbDJpS0tRVFhH?=
 =?utf-8?B?MmN3VGZOZXFnQ1hteldXN1IrWXRDMXNWTE9uOGZFbzlwR3FSajBNSEw4aVlm?=
 =?utf-8?B?Q0U0N1JmbUFyZmFwTXBoQUU1b0ZmcHVHaVJKVDhuZjR4eGxXMzIzVW1UTnJj?=
 =?utf-8?B?ZHZQSmYwaHp3MGZrN1VMZ28zSDUxZC9PQ0Q5YkhDMXN2ejhnZ3Z5WEVaUnVj?=
 =?utf-8?B?Q0tYUTYyRnAxb2FvSGxDMDRVV3UxU3BDQWRWSDZXaXNuSkpScGY2aUtTcms1?=
 =?utf-8?B?RTJEeFhSY3RSbXB5aVM2czBWQkEzb2RyWFF0dHdhelB0M2dVNmt0YzNMUlZW?=
 =?utf-8?B?QUJOZG54emY5bHdUSVZvd2xaTkZ6TENxUVluNlRIMnkreWExbUR4cnczeERu?=
 =?utf-8?B?NkRaZjZCaVRFaGZCcnNienlJU2tTRGhBY09uNmlYTXBmakF1STd2TDB5cjIy?=
 =?utf-8?B?TmRLb3RBWjJaSFlNSS9XR1VnZEswWi9RbmR0bk84VTFwTXZDVkJ0S1pzK3Vt?=
 =?utf-8?B?WWVpWGQyN1F4RFBRQzBKeThQeU9CWUxiWUl5aFdFVHpSQUZPMHNXWU1XcUlC?=
 =?utf-8?B?d3NMcW9HeFJPNHBhOVQ0bEVxYTQyS3FuOUI1SkZSVVlvVk5IR2RMVFVhSXpK?=
 =?utf-8?B?RVI5YXFNWnpuMkNpc0s1THA4Qmx3NUovcExiTkg3NVB0dC9RN2d4bHJuZWxr?=
 =?utf-8?B?Vk5xOEczZzFsc1VoNEgxb0p0dllzKy9malFlYmNLYm1LaW14VTNlOFp3d3JV?=
 =?utf-8?B?cks0U3BQUzVOOUhKZlNFNUNTY0Y2MEhvZzJTRmxnRnpWOXBtU2hYeGEwN2ps?=
 =?utf-8?B?cjNkK21DSUNrNmFnRTdTVWtKbkF1dWFnYkh0eDVyVkRMMEFockxKVWd2bTN1?=
 =?utf-8?B?ZjlpQVZobnhrZmlNbTFvUHo2UEtrTThxMDhHbUc2RnJhdjJQaDNja2pKKzBJ?=
 =?utf-8?B?Vm9yYzZKS0pjcGQ0aW02eGIzU0twcWxKNjc0QzRPN0NadkhhZGxIazlueG9C?=
 =?utf-8?B?YzQ1YmFMNmV6TGJFbVk1T01xWVBvbSs1OUw0V0twVDRsaUFhOXZFQS9xNkda?=
 =?utf-8?B?QXhBVDJVNDQwd2dodnNrZ0JKNnFsVnEzY3BVdlkzM2tXS1pLZnFGeFVmNHhs?=
 =?utf-8?B?dzI1eUE4WDNoMkplaXJwV01pT1RybEZTMTVweWNWbVVWSzZKWkJNOXlXVVQ2?=
 =?utf-8?B?c09ZSnlxOUJxZ2JyWmFWOEQ0Mm5uMGxkbnB5aUhRbzJJZjZhUXpMRXBtODUw?=
 =?utf-8?Q?eg2aM6a1ebt4JijCcnapludSVi+t2M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjM2dG5URzdZWnVrU0ZWTTI3bzA5b2NiYVdSVzVVSm5sY3IzaU5yQ2pGVDY5?=
 =?utf-8?B?SmNKSUZsMDFYZ3BwRnBzeHpSb2lpUzJEeUtYbWVTNHgyVXVvU1ZRaFFVV3Vv?=
 =?utf-8?B?bi9sOXVDdUxhSUhKQjhmd1NoNUhKL0FOZURPTDJGVTF4WnhXQ3NQK2M0U3VX?=
 =?utf-8?B?bGxDSUlYSE55N0ZHQ0RNKzZxc21ncTZXdXdQelVQSE9QTWdDTDVKYmhpWXJE?=
 =?utf-8?B?YnRKOWNYa2Zld3NmZXRJa0IzeGJVOXNTQWFVNklxN204cHFGSnJYR0g5WnAr?=
 =?utf-8?B?NlRJcHhReFJ0dWFjcmJubm9xdTVxVVV6U1FYNGJ5Tk1ZRlcvTXExRTlCVFZr?=
 =?utf-8?B?YW5TZWxQYTNqajB4OEYrTVlXeGJNMnRyaUlDYlQ3WkdVNDAvYStlUXBIU3hD?=
 =?utf-8?B?M3lKWkpuZ0k2b0pBRldVWHNnbncrenBkVnI0L3hnRlZNclFJekFGa1U1bEUz?=
 =?utf-8?B?cHVOQmcvQTJscm54QkJqcEY3aUhEbWZkZGFES0pBREUzVE84amR1enRvK3V4?=
 =?utf-8?B?bFE3ekkxVE9TQ1djU3Y4b0hROXIwVUNMSmRDV1NJRjhsVzNQa2JzdXhiclc0?=
 =?utf-8?B?TjJDOVJhdGZRSm5HN3ZpOVJxZmRwTDZQanRnMjJ5YXE5SDlPTWJXSWNxMER4?=
 =?utf-8?B?ZU9ySWZEQTN0b1ovTXhxWTJZTEZRVkdOYUVHcWpENFdLT1hSa2R4cUhOSzBF?=
 =?utf-8?B?ZHdDZHVjbzBSZ0JUakh4VzlkSy9BOFo4RXp4Tm1BcUpFeldmbmpyMm9waU1v?=
 =?utf-8?B?T2FFWWxrUzdOdVhubDNoOHdXSVNDajFSL3g2ODNEaCtXaElDWHhZdFkyWXBL?=
 =?utf-8?B?SDh4dGFmdGg4cGNzcGtsWnFDSjhzYXpaOWdHUldHYmlHMmFnemJsMm9sSUo1?=
 =?utf-8?B?WmRidWMwZnVuVktGZklBTkJaMk05VUVuSFl3QmRwUE1oRVpSRGVTcXFaeDVI?=
 =?utf-8?B?MXZOcTlreGNtZlNIQ0VKdEpoOThGU3JQMTh1SjRtK3BpQ0YzbFdwNXdRSEV1?=
 =?utf-8?B?elFxaTJCVDVCYXRGZU0xQUIrSFZxbEhydTh1eEdoc1lheFRhTTFoRG5tWlVN?=
 =?utf-8?B?aEJtaUdESm9yREtyT3hLNmZYak4xbzJjRUlrMFlmRkptY0xlR1pNcmZTVkg4?=
 =?utf-8?B?MUtNNHFHbEI0VmVnRGFPUmFXYjk4ZTNYTmZWM0tSTEVoN0pUVnRWUDh6Q1BO?=
 =?utf-8?B?dWEwQ0Q2UUJYMVV2UGN6R2FTaVJHZ2syY3FnVCt2N2RPWnY5OHFsekVLRURE?=
 =?utf-8?B?RE1jVjVGYWVrdVlPSlUwVkdTTnJvWWMvNUhVMk55MnhYazdqV0UwdkphbTVr?=
 =?utf-8?B?T1l4ZnduY3kwVmNObm9ma2FyMjJSeTRKb25Lais4cWlpSUhieU1ubGcvZ2ZV?=
 =?utf-8?B?VmxTdHNvQ0k5R3NkSktKUzd6TDYrUCthUUQyS0J5SStTWFNwYkRmL0kxbEhJ?=
 =?utf-8?B?YWowQTJCWnJtUGJPZmVyZ2I1dS9IMnc2RHFvVWVBRlBJU1c4Znk4eUpXVHdS?=
 =?utf-8?B?eXV5UXV0aXAzTkRadkI3R01KL1Y5MHhQejlhTTgyMEIrV2haQ1lXOHgxZllD?=
 =?utf-8?B?UW5qVEFCMG1zZFQxQUs1cGJZMHkyb3Ztb1U3MXFXeDN3Qkp1QzFRQnF3ZGpa?=
 =?utf-8?B?Y3Fpa2hsM1dpZkYrYWlqMEsyWEg1QTNrbWdybzZsOEZ4VkxNWTk4ZDJFSDhi?=
 =?utf-8?B?ZXJ5cTNpZHhXOEV5T0VRRVZPWDAvdGdLTzF5RXFJNkJNelhwUmwwV0ZYenR6?=
 =?utf-8?B?YTBSL3dTSG9jOXZnSW56Vmg4WFc5WENBVG1XUFpmbzg5ZFhBd0NoVlNQd1ZK?=
 =?utf-8?B?T0ZwcUNNYXNvT0hoLzhqa3F5NzA4OHdYTTlYTlJKYUZPdFZoVDRVTTF3ZnAr?=
 =?utf-8?B?UitYTkY2Q1BQeVNYVzNiREdpZUNrRi8yb1NzZUh5dExFbm0xTXQ1OXNYODZy?=
 =?utf-8?B?U3h1VGN2QVFqYUcvLy92Yi9RQXRvcW82Tjg0MTB1Q002NHFDbWNDbXVKNzc4?=
 =?utf-8?B?VTBpVURoNGg5bXUwazBsZFo2ZmphejNsaytabGZzM1pidjBhazFkWHRYNWRI?=
 =?utf-8?B?bTlQcy9uRFUwQU05aVlrcVpQM1luWkFLQVN6bGdWT0RBOHRDcndPdXhPcWto?=
 =?utf-8?B?ZlRXS1ZmNG42ajFvS3BLdFNldzVQZmw1R2R2NzdNcTNVcGlNNXdRN1lPc0U5?=
 =?utf-8?Q?pU/KHxQ/tYjobUQZWi+6KQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB7F854B3FC7DD4CA50E6EB2D7A6E3BA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ec7412-7380-42b1-23e9-08dd824ee935
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 10:09:18.7571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCFfzJxBEUgqpBFXoOpFm/UKtYp5YVBBMXrWQXwzfKOVf9JC51pM0hUxNkH8RoM4P5ArPHBTRNGD+dzvrQWGFhfP5aCSJXK8JO4xnrMgygUTURECkmdJS2xOXPN7kZkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7845
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDIzLzA0LzIwMjUgMTI6MDYgcG0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4g
Q2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNr
IGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBXZWQsIEFwciAyMywgMjAy
NSBhdCAwOToxNTozNkFNICswMDAwLCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pg0K
Pj4NCj4+IE9uIDIzLzA0LzIwMjUgODowMCBhbSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0K
Pj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBj
bGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBh
bmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pg0KPj4+DQo+Pj4gT24gV2VkLCBB
cHIgMjMsIDIwMjUgYXQgMDU6Mzg6MjBBTSArMDAwMCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdy
b3RlOg0KPj4+PiBBZGRyZXNzIHNwYWNlIGNyZWF0aW9uIG1pZ2h0IGVuZCB1cCBiZWluZyBjYWxs
ZWQgd2l0aG91dCBob2xkaW5nIHRoZQ0KPj4+PiBicWwgYXMgaXQgaXMgZXhwb3NlZCB0aHJvdWdo
IHRoZSBJT01NVSBvcHMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENsZW1lbnQgTWF0aGll
dS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4+IC0tLQ0KPj4+
PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA2ICsrKysrKw0KPj4+PiAgICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gaW5kZXggZGZmZDdlZTg4
NS4uY2M4Yzk4NTdlMSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBAQCAtNDIzOCw2ICs0MjM4LDEy
IEBAIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywg
UENJQnVzICpidXMsDQo+Pj4+ICAgICAgICAgICAgdnRkX2Rldl9hcy0+Y29udGV4dF9jYWNoZV9l
bnRyeS5jb250ZXh0X2NhY2hlX2dlbiA9IDA7DQo+Pj4+ICAgICAgICAgICAgdnRkX2Rldl9hcy0+
aW92YV90cmVlID0gaW92YV90cmVlX25ldygpOw0KPj4+Pg0KPj4+PiArICAgICAgICAvKg0KPj4+
PiArICAgICAgICAgKiBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb25fb3ZlcmxhcCByZXF1aXJl
cyB0aGUgYnFsLA0KPj4+PiArICAgICAgICAgKiBtYWtlIHN1cmUgd2Ugb3duIGl0Lg0KPj4+PiAr
ICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4+Pj4gKw0KPj4+
PiAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faW5pdCgmdnRkX2Rldl9hcy0+cm9vdCwgT0JKRUNU
KHMpLCBuYW1lLCBVSU5UNjRfTUFYKTsNCj4+Pj4gICAgICAgICAgICBhZGRyZXNzX3NwYWNlX2lu
aXQoJnZ0ZF9kZXZfYXMtPmFzLCAmdnRkX2Rldl9hcy0+cm9vdCwgInZ0ZC1yb290Iik7DQo+Pj4N
Cj4+PiBEb2VzIG5vdCBsb29rIGxpa2UgdGhpcyBhZGRyZXNzZXMgYWxsIHJhY2VzIGhlcmU6DQo+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzgwNjJkODY4LTQ2OWYtNGMxZC1hMDcxLTA5
OWI4ZTE4ODU3Y0ByZWRoYXQuY29tDQo+Pj4NCj4+Pg0KPj4+IHdoaWxlIHRoaXMgY2FuIGJlIGEg
c2VwYXJhdGUgcGF0Y2ggb24gdG9wLCBJJ2QgcmF0aGVyIHdlIGp1c3QNCj4+PiBhZGRyZXNzIGV2
ZXJ5dGhpbmcgaW4gYSBzaW5nbGUgcGF0Y2hzZXQuDQo+Pg0KPj4gSGkgTWljaGFlbCwNCj4+DQo+
PiBXZSBvbmx5IGFpbSB0byBmaXggdGhlIHBvdGVudGlhbCBjcmFzaCBoZXJlLg0KPj4gSSBzYXcg
UGFvbG8ncyByZXNwb25zZSBhbmQgSSBrbm93IHRoZSByYWNlIGV4aXN0cy4gSSB3aWxsIHNlbmQg
YSBwYXRjaA0KPj4gc2V0IHRvIGZpeCBpdCBzb29uIGJ1dCBhcmUgeW91IHN1cmUgYm90aCBmaXhl
cyBtdXN0IGJlIGluIHRoZSBzYW1lDQo+PiBzZXJpZXM/IEkgdGhpbmsgdGhlIG5hdHVyZSBpcyBk
aWZmZXJlbnQuDQo+Pg0KPj4gY21kDQo+DQo+IElmIHlvdSBoYXZlIHR3byByYWNlcyBpbiB0aGUg
c2FtZSBmdW5jdGlvbiwgZml4aW5nIG9uZSBjYW4gZWFzaWx5DQo+IG1ha2UgYW5vdGhlciBvbmUg
b2NjdXIgbW9yZS4gTGV0J3MganVzdCBmaXggaXQgYWxsIHBsZWFzZSwNCj4gSSBkb24ndCBzZWUg
YW55IHJ1c2ggdG8gYXBwbHkgYSBwYXJ0aWFsIGZpeC4NCj4NCg0KRmluZSwgd2lsbCBkbyENCg0K
PiAtLQ0KPiBNU1QNCj4NCg==

