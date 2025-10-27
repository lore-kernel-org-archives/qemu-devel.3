Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C79CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLuh-0004NW-Fz; Mon, 27 Oct 2025 08:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDLuS-0004Ac-Fi; Mon, 27 Oct 2025 08:01:13 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDLuN-0000Io-Ud; Mon, 27 Oct 2025 08:01:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy4D9XoNag7fX7MQmPQeBAFcmHtzd3kVjApzCRK+14QNxN+M/8lBpT8Bvh5WdXGBq3kSnRyw94k+gCx34S1HlC6zi+jhrNuyDMbIoBMjDVUJ6phFVYjB3jUJq0IMQAhnolgKBo1joJm9UT7jziqYHBUTS7Nu4npyASWw1nC0sZ2E82HrKaa6YSCY68Kbq7YKQhRBJ05PbkbQezh1NzdoJStuvkjcoSySk47y1CrwbJyT7DQQZ+ny26SGn6YVGzmB3JLNENjy+IYo5MqnqRBCFWutHUOVOItpMiQO9+AWKOTAoce60JPolHBh6xHuuAdH05pflIqYy9/u4yhwZG+s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwjBJggXUU/8hl4J1SSeVc6MkJde92YkAxcI7gYMq4w=;
 b=bFSSEvR9r/Y7LuTnI9ZBA+HbiL7AuXuD6FPPwA4T2B9ecx5ojp18T60HFXBmnUxCZWqvftPBlvloNaWMLgvyBH0HAfaD+yYRSfl3l9a21T2JmIyZ9ADNlNkpF3HltAt+T4zJ53xW9XHG4J3laDIgym0NrUVKDL9YeIkjC1fIbAtHjSLkWWYE1CXG44N5N1eFXaq5mJOrtuYOGnWChy13d+7so1N0vA90yKcF1P9l8fBsBKGPKceaDUWpFVoWRPg8EE3ZlIBvDZByLSCHCDyiQP/HdsY9odfJk7GGazW3uAlj8QK96r34l0a9TeG4smsBHOBxuyz5CLzkDn3ZJ/qs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwjBJggXUU/8hl4J1SSeVc6MkJde92YkAxcI7gYMq4w=;
 b=iYE4iucJBFFEVf/uH+yqTpGn9hUXItY6qqP/TgOMEPxrQ6Gu6quA5EtR4ztOqUly5UG0+5xpzGk3fQlZDe0oFpIEHibDqKSMv5r61bThACrWTJIkJ8WilmFnOrL/KPLRN6D6wNRSbgpXLXEHBoLGRLQIX2u+mO1osfN6brlHfHMFu6e7BQHyBsnS/cYlHi8zilTmoW4Jg8gtHS/x9lH2rP6wvWebL90QdNviyCdOXhXcX6Kc4NG9oNTYH6IPLam+a94aPn++BOADxYdVHa7PWVbwhj3LqAsgc001sPiUcffawP6LEj42IPGQl4xcWAiMssP7HgfHooEltcFUexg76A==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:00:54 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:00:48 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
Thread-Topic: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
Thread-Index: AQHcRzTCeCLV6gXFnkisZLP5UoDVsrTV42AA
Date: Mon, 27 Oct 2025 12:00:48 +0000
Message-ID: <IA0PR12MB7555DDCBFD26D3E22B0A0218ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20251024084350.252702-1-skolothumtho@nvidia.com>
 <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
In-Reply-To: <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SJ2PR12MB9085:EE_
x-ms-office365-filtering-correlation-id: 2079e1d8-b406-4db6-b6c7-08de155077b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?KytqaDQrT0FlajRnUmsydFprajdKMk82RlBieDU0U0d2M0lCWEkxNGtpcjEv?=
 =?utf-8?B?UnNpR0JkN2dhcFJFVW9IVjI2RlZ2QjRUdytvd0ZMUUJzWGpsWFhvSXVZUkxR?=
 =?utf-8?B?NkVkS2FLeVVaYlJodktFaUd4T2NCM2IzYkwxVUtQY3RET3Q4Z1h4MnE3ZXhu?=
 =?utf-8?B?cWFoZVZ4MTBndXRkdlU0OURRMVdMbmtQcjYrSDdoVWlKQ0VIbmkwR3BYcnZt?=
 =?utf-8?B?dlpGY3g5aGFib1RaSjBJRU9aR1kyb0d4UTlZRlNvczB2QXFmS2FEMXUrcmpH?=
 =?utf-8?B?Slh2Y0hYVERyR0J3c2FlbS9JQTMwZzBkS3p2TWVCUmg0VGdkQmZoTzNCbDJC?=
 =?utf-8?B?V25vSFJPbEZkZ2ZLL2tWa2tUYjR0N3hCMjJKc0dVYzdGZ0swUm01SFhIYlE2?=
 =?utf-8?B?alRVeXNROGFtQlN0QVJZUlpZanVOS1NEL085QkxRVjVBVWc4cDR1cGgwMXNZ?=
 =?utf-8?B?cDN4ZHRQeXE0NFNvTFFqTzV6WXBmWnQ4ZjRjbUZvQVUvaitkSGJQWmRjamlo?=
 =?utf-8?B?UzBsY3pzUUNPaFV1UVA0RlM2QzJZNk9DSVZ1MWpqOHVHWXd0dDhZV1FkMzZx?=
 =?utf-8?B?cjdaTDhlODdwelVLbm5hSXFQWlRGZ0VuMmdGTjNseHhBNlhnZEM0bzlKQTdl?=
 =?utf-8?B?aUdxeGJJdFMrUXVMeTZJaml5U1JleHVDYnZHYXBsQ092MXZVdHlHQ1NoR0Qz?=
 =?utf-8?B?Ui9STHlBWm54SlY0NGpTcTJIbkJ2VHRsWU9DSFRMTzVaOW5aUWhCaWg2R0NI?=
 =?utf-8?B?ZzRPQ2NTbmE3YWxRT1MwQURmdXlabUZMYWMvdCtzRm9iQW5KUG1zdlhaSUla?=
 =?utf-8?B?QzNhVHVWVzc1amhCTGpCYzVYQS85NThJV21BN0ZKQThwUkRLMzNoQ0RTakUy?=
 =?utf-8?B?bkNaMlRUdEVxb2ZETlN4OHNSZ2duWXBYNkI1R3N5MEZjL2RXdnhBS25CMHZ2?=
 =?utf-8?B?MVpHWTdLV0NuRnFNSDVRM3BGaGJyOEtvUnRqWVZ2cU1Qak5paFkyMy9DVEc0?=
 =?utf-8?B?ZEhZSFhzdmo4dCtVTXFOV2p6ZkVmZ1pqV0VUNnFjT0VhZlJaU1YwenVTM2p6?=
 =?utf-8?B?TUZHRSt1SEhaTWphY0N2Mm1SODc4bUdFbmtLdjRzUTBCWG1NbURsZEJxcXFx?=
 =?utf-8?B?RkdzWFF3QlFBa3NLTWJjaTdPMUsrSm9kWUY0UXA2N1NTMko3TXJ2L0VQRFZC?=
 =?utf-8?B?S2NtSFhtVTdMSGtma2tXbUlMUmJ4a3hjSHAyT21zdVRxWDA5TnYrREdZRkps?=
 =?utf-8?B?YjJxbVk0Yk50Uk8rVURwcmpwVnBMZ3NyZWFIRkkyU1ArTThzUFcwVlpsdG9q?=
 =?utf-8?B?TW1MMTBWOVRwYXNnT1piRDd0ck00V0ZqT2ZSU3BMWkU2WUlQVUxBNDAvY1lv?=
 =?utf-8?B?dkpYRU5YTVBxNzdXRGR2TWVwdUdnWWg4dGdlL0VaWEt0L0ZvUnFKRFp0anF5?=
 =?utf-8?B?aS9oWnlDbWVqcHJmcktFTVJpbDBQQ0NBV0lvRDZodXkvQlpDNHRtcG5RZDZW?=
 =?utf-8?B?em80U1hQZWF4UFVVWldPVWc5V0pqYUJMTTE1UDVvVzF3elA1bEZZaUVFakJW?=
 =?utf-8?B?UUZwTWhFWlp1dnlidUVJRWF0SzBIT0k0dHRPNlcycHR3eUVKTGFqZy9RaVND?=
 =?utf-8?B?UWI2YnUwREhqVnFVdFlzQUwyOXVCOHV5WUMzYXlzZ3RvaU82ckJZenRtOU9r?=
 =?utf-8?B?RDR2bkdHdk4rblNuWGdGZ3lPbVBEb2tEckVnVXRKZ1d3MzYvZkRqM3JXRUY4?=
 =?utf-8?B?YUdYSmV6STN0Y0NLeDYvU3ZuSVBKVHlFdUg1TEZKWHl6VzRuOXlCMGhyeHFs?=
 =?utf-8?B?SzVRTGUvYzBGM2hXOUNKR29Na1VZWkRjMU4xeUFtYXVHOGxnb21kRExOQWJJ?=
 =?utf-8?B?MUVsOFhXOUZnWU8xMHZXbzlUZFk5ckdFbFoxdCttdUFYVUdjWStrZ005OE0z?=
 =?utf-8?B?eDNDclNYY01xdlR1Vld1UEptaDNVQW5NdzFjdHdUZWR6RHhCbndwNHJMNjR5?=
 =?utf-8?B?MFpEaG9FWiswVFlmUmZsZWg3c3ZXRUpiM0Q3dVBXdlVtZVRzZzBoSUY0ODU5?=
 =?utf-8?Q?B+N+Yq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG45MzNaamFGbXZwVmdQMFcwWjVZU3ZkdkRmL1hjY2RENWpSTHdMdmNpRGFO?=
 =?utf-8?B?U3hDTlYzUjhMamtJQnJhZ1M4ZXkvckhqWE9jcFlhSjF5S1hxaEZ1VzVOcVhV?=
 =?utf-8?B?Nmh5QzNzZ1I2R3lnWDBYdFdsN3dIL2o3RXdidDBkbEFxVG13WjY2N0VkQ1lT?=
 =?utf-8?B?Sm1QdXVUYXBqemFSSExVcTFodHJ6T2V3K21kV0R4UXdmcWJGemZqQXpVN0JL?=
 =?utf-8?B?S0czTEFxblMwSHozU2RTNElhMXFISHNDa1g0MGJySFFKdXk3NGRmd3VqY1lz?=
 =?utf-8?B?azloK3VnTFY2ZFliUm4vREI3WVhuZGtLZ0dvVXpHR2dxM1g2MnZZMnJUS2pX?=
 =?utf-8?B?bmdWT0RSZ1c3WDR3NmhaRm1kVFhoRjl5SVlsSGVIcisvQ1JMNUQxZTVsWDIv?=
 =?utf-8?B?QW9OVHlEbmgvNW9QM2RzTjJoN1ZSUlAybXc5ZVlncXNsS2N0OVJGMVZGZXpu?=
 =?utf-8?B?UjBGR2VIeTZndzhHaFJJdndYbkN2ZXdBaVZ5akZZMjEzTnhreHlLRTc5azhF?=
 =?utf-8?B?V09xREZnRzlrMTV6ZU5NZzJ0eG02bEEzd3U2MTJ6V3hoclowYTlvQzhNZ1I4?=
 =?utf-8?B?SW5Kdmt6U2ZzMGkzZGR3azd6TlNNd05pZ1RiNGdXbFFlVFYzVHNZZkF5ZVN4?=
 =?utf-8?B?RGM2aDRBMkJCejNjQ2dhR25waFhoUGUwOGN3VFJtVkN4TlVNZnNiYXQ4T2x5?=
 =?utf-8?B?anJpZ1lrQWhDOVgzMUZWNUVyR0Zqelc5V3VhcUViczhySDJtdytvQjA5MnRh?=
 =?utf-8?B?WEkxUXBKUUJxaG9UMlo5VEZMdStFNkJmN21oTmJwWXJRZDVQZkdmU1IxMndB?=
 =?utf-8?B?RTZhL01keXlSQVZHZWFpZkpvZE9DcVBFUm5lSVV3ZzBpSGIwWVdhdzg5VUN0?=
 =?utf-8?B?UUsyaWwzTTdjUDVydjIyTWFyNEY4WEhkS1ZiRFdjSVYvY3RRK2ZCT2Y2eGNV?=
 =?utf-8?B?L3dUcXNNeFN5RUNudy9JeTNGckZsd3JSdjBOTkR4QzFid1ZmaC9vNkVDTmVj?=
 =?utf-8?B?MTNXeTJqdWtUSVdFcnN0ZlNSOFdVUng4WkhLR0JzZC9majQveGM0bCtEMWNk?=
 =?utf-8?B?VlU1TjFLQi9qN2RXNDlmZjhBcUtlQ1h2UkZXMEw3ZmgxcXExYmY5K29LTVVh?=
 =?utf-8?B?bFQ3cDNFNVZSRWlDMHNMNjM2UlpVMDE3d2xhVTQ5RWlxa3NFOURKNUpXKzVH?=
 =?utf-8?B?bnFteXVCYjFNUCtPYnllZDlVdXN1WlkvN0NDT2NaVDlBNTBjVmppNXNrcFBW?=
 =?utf-8?B?dnB1UUxYMnIxdk9hTTN3RE1KZmlXTStWTVdGUTFiUTl0bUtVTDBnL0c0a1hv?=
 =?utf-8?B?NTI3ZmVKV3NxM25aNjdmMDZqb0tJVmhZWkN4eHNKVEozRTVtY01ySHJPaG5v?=
 =?utf-8?B?akRDYVc2N2RiRGhNaTN6aWtndEtUYi91T0lwR1NwYWZacjc5ei9jQVNkWEFM?=
 =?utf-8?B?SXcreHpVYVVvNlNvaXlsakRIaFFFVVUzNTdRNmpOK3ZvSGh3TjVJWm94cXFa?=
 =?utf-8?B?b05wZ0J0dExRMUxZbERlSEFjMUIzb2FzWlhwSnJDenZkVmxoNWQ1WnZ5MDU5?=
 =?utf-8?B?ZmU0K1hhenpoaU1Hckl5TloxaWpxQVNxWEFVV2JnTGE2b0MzOUZPWGZGQ0dn?=
 =?utf-8?B?TUdBMUVYM1M5UTFkQXhOMEFIZDNnM1g1SkxvQ05ZemtzV0l4b21tazdDSk9O?=
 =?utf-8?B?QjVmTnVHM3hzNkx2NSt0aUY4RFpnWExrYjhiTDZXRmkwQ0xjUWoxMHR3VGtD?=
 =?utf-8?B?bWRlRlk3UWtSV2MvVDZKTFdQZFM3VDYrbUl5Yzh1UUNvdUdVZm1BZ3lnQ0NP?=
 =?utf-8?B?d3lZL001aTBYMXBEd1I4QVk2M1cvekpFSGZPUTRSYTE2MkE1RCtvUDNNb3pk?=
 =?utf-8?B?M3lkQXVNNDhpdkpZdHVSK2lDMUFzS0JHc2ZqVmVQeUY4aUozRU9kVGNxbmlX?=
 =?utf-8?B?OHE1QjM2VFpTdXJGVGVEalRPancxTlRRcXFRNDhQTzE1QmVtNjZQZ2F3Z0JE?=
 =?utf-8?B?Qzh6YnM3Mm5DdDFKdXNGbGFDNHZkcHIxb3MwcHdWMXcyeDk5bTRkaFFxb0Rz?=
 =?utf-8?B?cGJZYkpZODAxVi9QaE5TdnBCcURkYUdNdi92OWFSUzVCb2N3TzNMK1M2eWhX?=
 =?utf-8?Q?GzJAzRFGL6ZSoc+i2JiVTNIDC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2079e1d8-b406-4db6-b6c7-08de155077b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 12:00:48.2856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5vW7B6RVbP58NsSHKoJjZx/OS3Q6N3XXZDvnb5uk8Xft3uwp1P+/MzccAFmk2D94CSVHRGr/KP/GLUOkKxxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIwMjUgMTE6MjgN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzog
cWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47DQo+IGRkdXRp
bGVAcmVkaGF0LmNvbTsgTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cw0KPiA8bW9jaHNAbnZpZGlhLmNvbT47IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyXSBkb2NzL3N5c3RlbS9hcm0vdmlydDogRG9jdW1lbnQgdXNl
ci1jcmVhdGFibGUNCj4gU01NVXYzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIEZyaSwgMjQgT2N0IDIw
MjUgYXQgMDk6NDYsIFNoYW1lZXIgS29sb3RodW0NCj4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29t
PiB3cm90ZToNCj4gPg0KPiA+IFRoZSB2aXJ0IG1hY2hpbmUgbm93IHN1cHBvcnRzIGNyZWF0aW5n
IG11bHRpcGxlIFNNTVV2MyBpbnN0YW5jZXMsIGVhY2gNCj4gPiBhc3NvY2lhdGVkIHdpdGggYSBz
ZXBhcmF0ZSBQQ0llIHJvb3QgY29tcGxleC4NCj4gPg0KPiA+IFVwZGF0ZSB0aGUgZG9jdW1lbnRh
dGlvbiB3aXRoIGFuIGV4YW1wbGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtv
bG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gDQo+IFRoYW5rcy4gSSBoYXZlIHNv
bWUgbWlub3Igd29yZC1zbWl0aGluZyB0d2Vha3MsIGJ1dCBJJ2xsIGp1c3QNCj4gYXBwbHkgdGhl
bSB0byB0aGlzIHBhdGNoIGluIHRhcmdldC1hcm0ubmV4dCBpZiB5b3UncmUgT0sgd2l0aA0KPiB0
aGF0Og0KPiANCj4gDQo+IC0tLSBhL2RvY3Mvc3lzdGVtL2FybS92aXJ0LnJzdA0KPiArKysgYi9k
b2NzL3N5c3RlbS9hcm0vdmlydC5yc3QNCj4gQEAgLTIyNCwyMyArMjI0LDI0IEBAIFNNTVUgY29u
ZmlndXJhdGlvbg0KPiAgIiIiIiIiIiIiIiIiIiIiIiIiDQo+IA0KPiAgTWFjaGluZS13aWRlIFNN
TVV2MyBJT01NVQ0KPiAtICBTZWUgdGhlIG1hY2hpbmUtc3BlY2lmaWMgYGBpb21tdWBgIG9wdGlv
biBhYm92ZS4gVGhpcyBhbGxvd3Mgc3BlY2lmeWluZw0KPiAtICBhIHNpbmdsZSwgbWFjaGluZS13
aWRlIFNNTVV2MyBpbnN0YW5jZSB0aGF0IGFwcGxpZXMgdG8gYWxsIGRldmljZXMgaW4NCj4gLSAg
dGhlIFBDSWUgdG9wb2xvZ3kuDQo+ICsgIFNldHRpbmcgdGhlIG1hY2hpbmUtc3BlY2lmaWMgb3B0
aW9uIGBgaW9tbXU9c21tdXYzYGAgY2F1c2VzIFFFTVUgdG8NCj4gKyAgY3JlYXRlIGEgc2luZ2xl
LCBtYWNoaW5lLXdpZGUgU01NVXYzIGluc3RhbmNlIHRoYXQgYXBwbGllcyB0byBhbGwNCj4gKyAg
ZGV2aWNlcyBpbiB0aGUgUENJZSB0b3BvbG9neS4NCj4gDQo+ICAgIEZvciBpbmZvcm1hdGlvbiBh
Ym91dCBzZWxlY3RpdmVseSBieXBhc3NpbmcgZGV2aWNlcywgcmVmZXIgdG8NCj4gICAgYGBkb2Nz
L2J5cGFzcy1pb21tdS50eHRgYC4NCj4gDQo+ICBVc2VyLWNyZWF0YWJsZSBTTU1VdjMgZGV2aWNl
cw0KPiAtICBBbGxvd3MgY3JlYXRpbmcgbXVsdGlwbGUgdXNlci1kZWZpbmVkIFNNTVV2MyBkZXZp
Y2VzLCBlYWNoIGFzc29jaWF0ZWQNCj4gLSAgd2l0aCBhIHNlcGFyYXRlIFBDSWUgcm9vdCBjb21w
bGV4LiBUaGlzIGlzIG9ubHkgcGVybWl0dGVkIGlmIHRoZQ0KPiAtICBtYWNoaW5lLXdpZGUgU01N
VXYzIChgYGlvbW11PXNtbXV2M2BgKSBvcHRpb24gaXMgbm90IHVzZWQuDQo+ICsgIFlvdSBjYW4g
dXNlIHRoZSBgYC1kZXZpY2UgYXJtLXNtbXV2M2BgIG9wdGlvbiB0byBjcmVhdGUgbXVsdGlwbGUN
Cj4gKyAgdXNlci1kZWZpbmVkIFNNTVV2MyBkZXZpY2VzLCBlYWNoIGFzc29jaWF0ZWQgd2l0aCBh
IHNlcGFyYXRlIFBDSWUNCj4gKyAgcm9vdCBjb21wbGV4LiBUaGlzIGlzIG9ubHkgcGVybWl0dGVk
IGlmIHRoZSBtYWNoaW5lLXdpZGUgU01NVXYzDQo+ICsgIChgYGlvbW11PXNtbXV2M2BgKSBvcHRp
b24gaXMgbm90IHVzZWQuIEVhY2ggYGBhcm0tc21tdXYzYGAgZGV2aWNlDQo+ICsgIHVzZXMgdGhl
IGBgcHJpbWFyeS1idXNgYCBzdWItb3B0aW9uIHRvIHNwZWNpZnkgd2hpY2ggUENJZSByb290DQo+
ICsgIGNvbXBsZXggaXQgaXMgYXNzb2NpYXRlZCB3aXRoLg0KPiANCj4gICAgVGhpcyBtb2RlbCBp
cyB1c2VmdWwgd2hlbiB5b3Ugd2FudCB0byBtaXJyb3IgYSBob3N0IGNvbmZpZ3VyYXRpb24gd2hl
cmUNCj4gICAgZWFjaCBOVU1BIG5vZGUgdHlwaWNhbGx5IGhhcyBpdHMgb3duIFNNTVUsIGFsbG93
aW5nIHRoZSBWTSB0b3BvbG9neSB0bw0KPiAtICBhbGlnbiBtb3JlIGNsb3NlbHkgd2l0aCB0aGUg
aG9zdOKAmXMgaGFyZHdhcmUgbGF5b3V0LiBTdXBwb3J0aW5nIG11bHRpcGxlDQo+IC0gIFNNTVV2
MyBpbnN0YW5jZXMgaXMgYWxzbyBhIHByZXJlcXVpc2l0ZSBmb3IgZnV0dXJlIGFjY2VsZXJhdGVk
IFNNTVV2Mw0KPiAtICBzdXBwb3J0Lg0KPiArICBhbGlnbiBtb3JlIGNsb3NlbHkgd2l0aCB0aGUg
aG9zdOKAmXMgaGFyZHdhcmUgbGF5b3V0Lg0KPiANCj4gICAgRXhhbXBsZTo6DQo+IA0KPiANCj4g
DQo+IA0KPiAoSSBkZWxldGVkIHRoZSBzZW50ZW5jZSBhYm91dCBTTU1VIGFjY2VsZXJhdGlvbiBi
ZWNhdXNlIHRoYXQNCj4gaXNuJ3QgdXBzdHJlYW0geWV0LiBXaGVuIGl0IGxhbmRzIHRoZW4gd2Ug
Y2FuIHVwZGF0ZSB0aGUNCj4gZG9jcyBpZiB0aGUgdmVyc2lvbiBvZiBpdCB0aGF0IGxhbmRzIGNh
bid0IHN1cHBvcnQgYWNjZWxlcmF0aW9uDQo+IG9mIGEgc2luZ2xlIG1hY2hpbmUtd2lkZSBhY2Nl
bGVyYXRvci4pDQoNCk9rLiBUaGUgY2hhbmdlcyBsb29rIGZpbmUgdG8gbWUuDQoNClRoYW5rcywN
ClNoYW1lZXINCg0K

