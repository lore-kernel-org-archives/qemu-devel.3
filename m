Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C06606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Jerkpci7;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=mFCVlHYk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4ft-0000Vl-Q8; Thu, 22 Oct 2026 22:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK4fg-0000V7-UF; Thu, 22 Oct 2026 22:06:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK4ff-0007y4-5W; Thu, 22 Oct 2026 22:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792721175; x=1824257175;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L3WNwczpr4kLc+GFOngp78F0UBXvydwlhUCZ40UgzMI=;
 b=Jerkpci7cgBD36JNO+mSzTCG9ZakjZQy/5xuwLkTfjfbFvhdtYW178wA
 3yzmp7K7irh/gZf6QxrtQs9Sp9G3GBRa2RZj2fQW8jWdikKrnZR7CH7jo
 t+8S6D75Wa9c/Ggn7NCt0bBnbKERGrUHqlpqUtX8AXidfMzCz7uRll5pZ
 UK0FWmQGVM/s4mLM5bkjI7Hl6N2ayCsDMdru35M+bb6uQjFxOrL2J0jkw
 f2X0AfWsBZ452436OgUCZ0vPD5Ciglzhct0pwlTxjzCpV5eoWKTtndSQF
 /CIt+R+unUC9jrDlpo+vg6CePPE//t+shhfTgmDg3Kc5TFY8Om4NJkzso A==;
X-CSE-ConnectionGUID: PqFvr1WtRfG1YRJlpQV5jw==
X-CSE-MsgGUID: aU2cVVxHQRyhsJwXZBTlwA==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="158692993"
Received: from mail-eastusazon11011024.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.24])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 10:06:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umIDdg8ZmjnlV0sAObNnXdq/KEMqFt83aNVbVLSzF/Rts6Wh7s2lyduuUfVBFXcXRH5VUa/tSzHwKyA0XjcAGkKsEpqAeqwOsqnqzZfAI7AVx16yfoM+P9AgZvq7pylWCGNUoKLcow4p5aXjs4xibGJcEjaCpbEiw72ddj8b6wXUSSHHRSQ0fd78eufTDs/f2W+w9+YyVt1fHhJbAF9IcfgGyqhiEE+Jzy3+vqv3caPgivuvPffJgwTi5ddBRsOS6s+fr9mAN4H4oqrBxBpwp6VmD+NwUAB88eTEg8psayGxQDj66NXPEzajgaRcmCfFsnfs5QtOP6HzQgL6odpvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3WNwczpr4kLc+GFOngp78F0UBXvydwlhUCZ40UgzMI=;
 b=xkzeyHTPan+/VWxyCQBfPTWPphBcdxz0XYKClViwUWsNf2CPPvHB0FVgCCf2K96oUaTHk81f2fG0jivoxdEeLs1qVWcqP0l2cOSycXT6vJ1MJ/RBDOhCDWP9uCk5m5jXMu1ZHcj8EfAyYet54pHUZGmF6ZMWzI/Xs8Difz886NDJD1f7L/STfoWU6Pu8rVsMjIcrVKUSgdkgCKBHIK7+Hgvi9WUSLfc4MPHfwSK3igw5KdIn8mQtDp0NA0puFvSAsBS1zdbPw7lgZKmkRp/pqfROrJMgZLkEynowq2NicsusK1fHpFaEbwfYnzZZWHeivc32f8y18wM4QtRAuB8F9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3WNwczpr4kLc+GFOngp78F0UBXvydwlhUCZ40UgzMI=;
 b=mFCVlHYkWFlLltfjiR45a+g5ysqd1kPUjsDroeEV8BJJW+l6Z+eXaWRtVmihQ+jWYLMcDhgZcMR0UAVCyNIgNCIzlUkM6HjQzs0s5ZZaiLt44Pim7rN9BK790zUJAccT5RA5yWCj+9FkK8jVTdFjcsjFXSIbj9x1RFMxf1vwed8=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH2PR04MB7110.namprd04.prod.outlook.com (2603:10b6:610:98::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 02:06:10 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:06:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Use 1ULL for a value we're going to shift
 by 63
Thread-Topic: [PATCH] target/riscv: Use 1ULL for a value we're going to shift
 by 63
Thread-Index: AQHdYmFsp9hoB5X5A0qrFnLRQji2WrcKYV8A
Date: Fri, 23 Oct 2026 02:06:10 +0000
Message-ID: <f5d4d3627e9f7c971d5132ccf3c8d7e0b8daa1ae.camel@wdc.com>
References: <20261022201037.764619-1-peter.maydell@linaro.org>
In-Reply-To: <20261022201037.764619-1-peter.maydell@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH2PR04MB7110:EE_
x-ms-office365-filtering-correlation-id: d86287ff-9a04-4bfd-c6c3-08df30aa3501
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|19092799006|1800799024|23010399003|261022105027099003|56012099006|11063799006|38070700021|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: X+3le2rxKZsLuXBx3LMHhuBJ45bdmxJWtXKKTmFazh82Mkg/5HKajs81b1E1tImLuDhwx30dox03kkDL0kPqclrG8OMB3YlYi1OmmR//tiirhktMyARAcvzFtLy6ap4T6S/+inSZcflBOsXtBv2P/UqKSjd60E4OikNrNaQa0CFAdp83g/rAmZfhssOZ7xWlFLpdW7Kjy37mmtQIYOjYNkMNtcZf+cv11SJYbReAROwpptADrs/PXLjBgs2VrinXe+YCpryB8JiPALgpliz7dyX8TV1TEplbdFBX+DMNwtTzd/6jt4viuoWrEwzIBPHll+rTmibIzgqT2sDsDDbIjw+jOfn133zwAbwdfeshneGUuOxWnnVzNOicGpS9kbtT7jIhay6mHS5gfuaJkTEEfKQDEs/tgUBgYmvuw4fU7GffQU9XOH5SWSwIoZOXlcF8L3JNu81zUXgfc1DqrGjXbMWHx2/9w+FwOcvAiOI3gctfl2Ks0J9OgAWpW8+KuomF4XDOmtw7ov2ivC96st+r93O1w6s9dM9EGZUQbTeYrKyw/wJj3FANqgCCAW7kYoXHMBb562a5fD6JhVGvtx9VHVakrcDfmp4j8BtIX3cXTR8iySxq5CZK4I1MZgSm7Zxt0zdw6zUi7M48NSU2uDQ3selePZwluPna16nBYkfjFhyfO75NZFXU+Gm32qEmPWlmMZFxwwIEsMlM0QPQUtY6d7SPs6lCnsOHhuq5CJar8As=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(19092799006)(1800799024)(23010399003)(261022105027099003)(56012099006)(11063799006)(38070700021)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmlLdVpReUFvc21PR3orZVF0c2lEbmxxTU5vZjdjUUt5MVoxVGVKcjNJakVl?=
 =?utf-8?B?OVdPdkdTTmg2YW5QR29ERXNZNElybTEvbzEwRXk2ZVlXY1g4cU5pN0xWc0E5?=
 =?utf-8?B?bXNxa2ZxeXRnZGxtaXZRRWlBRlIxQmNpMSs4TE56ZHpZOVkvRXBjNGdhMUtC?=
 =?utf-8?B?d2g4Rm80RWFxcFI2dFRYSUJFQWM1ZzhmMnphY2Jva1g0WkdMdGk3eUMwTWFl?=
 =?utf-8?B?djJCb0dMNWVQNVp5blZzV0RUeEdIYzlXamdqZEZGeW80VUVlQUM2ak9weWtw?=
 =?utf-8?B?M1BudnBrZ0w4cE9pNmRNbkFNWTlkV3JTVmlKNDM3MThWYkUrZVBrandxcDc2?=
 =?utf-8?B?SE9VZVhLQWxyUGJQSUc1Y0dvZVpxYVQ1eWdQMTlEemtKTC80RWV5QzJINnVT?=
 =?utf-8?B?emRVRkE5VVlObGExM0RmUmpFQW1PVVRlc3czQzdCeTlwTjhsWVROWWp5UlJq?=
 =?utf-8?B?NG5qbEZibEJlaGVhUEt5d2szUnY2ODlKQzNjemhlUVhDQjRNSFdHTlVoY1Qy?=
 =?utf-8?B?bU1uRElUWm54cWdQZmxlaEdQZmVDMG5Ca1hBczhVcjduamhRU0R6ZVFaU3Va?=
 =?utf-8?B?cWJXR2xLT3NKVjV1L1ZxdENSVG1mTXNlV0pwV1g5NXRzZTN1b0JBYVV3WTlP?=
 =?utf-8?B?NVhabG9WeVA5cU9qQXNiazhhOUMrQU45UDY3UFpvdnY5Mkp5Zm9hYXVSdHM5?=
 =?utf-8?B?eGd4eXliTVVaVW1XV2VmblBiSXpEZlJ2QjhicTBmZzNmcjB6RUptTWtxbHlL?=
 =?utf-8?B?cHpqZ2gvMUFoUGNSYThrM2J2OUdkRlNFTk9xbkU5QVBjd250dVZqdTBlVDFo?=
 =?utf-8?B?WVQzb2xScEJSU0F0Rk5ITVh2bGZwclhXSTQyaVFBbTcraSsxOWZCMmlscnQz?=
 =?utf-8?B?THBKbVJ3b1Vjc2lkcHFlbHZuWlpBNUl4VUlRYVpJbFlhRXZiYWdXczN1Wmtx?=
 =?utf-8?B?OEduUGR1ZCt3alZyTExQVHRsbHE5YWdHQTZQRlJ0ckpJMmdNNmFOU0tnSUx1?=
 =?utf-8?B?RTBjS3hiSjNwcFRLQktFZ0tLK2RlSEZWNHNDWC84dWU1M1dieHFEOFVaVEcx?=
 =?utf-8?B?cXlqRXB1eWZpT0pwN1lNU0ZSVTZ1SzVQL0dmNGYyUElGYlE0clppUGJRU3Jn?=
 =?utf-8?B?QXlVSWRhVFlqcmYxcDdoWWc4aDhpZHdQSVRRL0cyek4xaFlGT3c1UGFJRzRz?=
 =?utf-8?B?NkdMQmZIT0lJcHYxS1ZYbkhwOWpXWUIzTjR5NlZpY0hhZy9Jclo2UTAyeFRM?=
 =?utf-8?B?Ykwzd1ZHSEdTdktOQ056ZlBXN2NWNjRMVWJLRksyL3YzRXZ5KzVQSHJPZkk0?=
 =?utf-8?B?bVJLQU5QeEF3S1JvMVNFdG14a1BXelZBREhuTmtQTmRMU1lPbjU2eEUyUGtt?=
 =?utf-8?B?T0w1UVI4RlIrSjhpZVFjSWdwNUZzWlBqM3AvTitPaG9Xa0tZcnV3SzRyb0xh?=
 =?utf-8?B?RXZhVmtGaytHUTFhOHM3MlVwS05NcTBtK3VZUE9JcU51TS9uU0RManc0ekFo?=
 =?utf-8?B?Y1RheWM1OElnTHA2Z1RpRGRWRGIxa2RKYUg3bDJjOVk4KzZxYm4wOHRaZmhU?=
 =?utf-8?B?UGtUTUpPcSthVCs3bkR4WTlGV0s0Um9Wd2tKMU9xd1h1N0NacENuTmdkVWth?=
 =?utf-8?B?VSt0TDlsRytyWktPdDdIOTV0bDd1MEJEcFBUeEQ3ZG80YjFvUWlyU242NWdG?=
 =?utf-8?B?VTNvejc5NisyMDBheFFIY3BYdlduOURwUHdacEtkQTFBTy9oOUhVZ0xqd1lW?=
 =?utf-8?B?Nk1UMTNuUVV2eDV2SWl3WDRWSk5MMFJGVy9NYnJxNnhuMmJrQU41SHJWU2VH?=
 =?utf-8?B?RS9WcHdxb25RMStqQWdUZHlzMmhCWDgzWDFpNnhSdWt0bzJmRUZHSjF2Z0pz?=
 =?utf-8?B?dE1ZQ2V0cHBlNU5PVlhlamI0TWloOVhZdUx1dy9IV2YrRW1DZElQaTllYVYx?=
 =?utf-8?B?aFZ6Ujlhdyt3Qk1UOUlLUFJzQmd4ckZHVFE4ZE9mNlFHWmhGTWtuS2Zsdlov?=
 =?utf-8?B?UWFBWis1L2liRjdPQ0pGSFdkYURGMnRGa2szakVaVHNMejkrdWtZL2taT2xI?=
 =?utf-8?B?MUEzaXNnc2ZYVUp4NlVRNUZ6K1BzV2N1V0N0clYvZ0FWMnFXZmJWUGVSNzFJ?=
 =?utf-8?B?T0I5N2pNbGs4Rmp6S0RSN0IyUTJpM1NVdS9LNWphQ2VCU0NNbjNDeFNaRkIw?=
 =?utf-8?B?ci9lWG1vbVRqMVRNbHFXMmVBOTBxWW1DQXByWGsyaDFYcDh5SXJhcUZFRzYv?=
 =?utf-8?B?Qk5IM3hDcUF4Y1FzTjE5QVloa1NkdmlBWlhFeWRLN3pQL3MzY3I3YnJTU2ZN?=
 =?utf-8?B?a0lISFZOTDQzMThHRTN1QVJzSkZkMVFMOGdTRmtweTk3b3hpUXRqN2JrY3BK?=
 =?utf-8?Q?OeY5WTaIdbMk42WbAHV4FQTmV+VlDJdu0TOsDSCe4hkGM?=
x-ms-exchange-antispam-messagedata-1: LGHQiH4VuD00ZqQAAqnm7ur0vocGlWVXi5I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <508F7132D9D12846BC200FB69984F33C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MDbb0ahnp76v6e8WpAK7xVH4+wR2qmg8jxxlJNs4SiEA1mljJGnugMSBnYOuQAtLdGEPkRGAkmRc84SNO0wFhMFSABUV0ryO6DRmZS1t/nB5aCuPDV4BjrXgs+UarNaRtQUjQSWVOh1FtLbvq64iKoFCB7Rw8CyEFYfW8N0CP3q5JXG13L54jlIf9cyuah6sAK8wmnnmx6NwRo5ysrJ/aBMqUyKX4TGEjfPgAkJ1g9FqM0ye3OBsgcCxZ2jTCBrtMpqAuMDEedHyheqCd8EZMbwd3VXKoetUnRucOxH8KvpWvozCybLIn5RtAhOIjx1lNPCJPb0TJ/B6njcCXpmeUg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oFkaGG3RhtEOy2s9ARnr8GRB7McgEnJtxXR0R8dbgjkXFMU8ST7acds7OA3AjtzH+6Y/v2ZhopjmRVyonYWXdeaZz0HetsKhRSfxWkyxejYiXZwxl11HIg/ZGXZxyeSBHPmvpIwLgRgXYxpOpA5tlQDlAfEs58NYlylvG5L+ZSAqYlJkJG7rJAZs6yh7ULCRQP83DQuiqwWLUxr2EBJlrJYrt341gZppFGU5foS9jcZHhjpTLRaVc+0XBoO3k8zKtl5K17fBfGd9W9M0HcSUOO/nn04TMuezY1DC+fMv2/w4YfhtftW/Om8EA45E+/RhcKHGf22fA6wSloIV7AK97CPTahETb0dSdGPLesZSvUfVNuGlHPKM64n5w+Iyuvalj1iouNhku/Mh92yawztZ4zxUzKEQD1XlkQjbGOONxmmhKC97jeLpyclYgZ5UndWJj6bFmrxKJFAYZlpzT+KOVEBeILgAwxBx7iTuK4rVZujy+66Azz8Ez7EgQSXqoss9WWHkEBIcw0z+ar+Ee4KF+oryACid9mhP6+Qk55k8F4hChht+GGidJo2d9H5lUrWC0zc0IP6zFLmYmgkWQRICSoXiUlvW3mkYANR5pt5EcskpAZZEA7hhBu2CFisigfBJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86287ff-9a04-4bfd-c6c3-08df30aa3501
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:06:10.0941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqnYWGndvlWAAtZQa7abDCp++/I/fWI8AN98r9jQJ3dwN/l+Ca5qB1Tdk49EkJqnppNEmcsi7p/yTEG1PT6gA8VFO78be1jFrm3n6PWYlPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7110
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIxOjEwICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBJbiBwcm9wX21hcmNoaWRfc2V0KCkgd2Ugc2V0IG14bGVuIHRvIGVpdGhlciAzMiBvciA2NCwg
YW5kIHRoZW4NCj4gY2FsY3VsYXRlDQo+IMKgaW52YWxpZF92YWwgPSAxTEwgPDwgKG14bGVuIC0g
MSk7DQo+IA0KPiB3aGljaCBzaGlmdHMgdGhlIHNpZ25lZCB2YWx1ZSAxTEwgdXAgaW50byBpdHMg
c2lnbiBiaXQgd2hlbiBteGxlbiBpcw0KPiA2NCwgd2hpY2ggQ292ZXJpdHkgY29tcGxhaW5zIGFi
b3V0Lg0KPiANCj4gVGhpcyBpcyBub3QgVUIgZm9yIFFFTVUgYmVjYXVzZSB3ZSB1c2UgLWZ3cmFw
diwgYnV0IGl0IG1ha2VzIG1vcmUNCj4gc2Vuc2UgdG8gdXNlIGFuIGV4cGxpY2l0bHkgdW5zaWdu
ZWQgMVVMTCBoZXJlIHdoZW4gd2UgY2xlYXJseSB3YW50IHRvDQo+IGJlIHRyZWF0aW5nIGl0IGFz
IGFuIHVuc2lnbmVkIHZhbHVlIGFuZCB0aGUgJ2ludmFsaWRfdmFsJyB2YXJpYWJsZSBpcw0KPiBv
ZiB0eXBlIHVpbnQ2NF90Lg0KPiANCj4gUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNTQ3NTUyDQo+
IEZpeGVzOiBkNmE0MjdlMmMwYjI0ICgidGFyZ2V0L3Jpc2N2L2NwdS5jOiByZXN0cmljdCAnbWFy
Y2hpZCcgdmFsdWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+DQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5u
ZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgMiArLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KPiBp
bmRleCAwOGE0ZDE0ZWExZi4uZDQ3YTY5YmVhN2QgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNj
di9jcHUuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gQEAgLTIyOTgsNyArMjI5OCw3
IEBAIHN0YXRpYyB2b2lkIHByb3BfbWFyY2hpZF9zZXQoT2JqZWN0ICpvYmosDQo+IFZpc2l0b3Ig
KnYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+IMKgwqDCoMKgwqDCoMKgwqAgZ19hc3NlcnRfbm90X3Jl
YWNoZWQoKTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiAtwqDCoMKgIGludmFsaWRfdmFsID0gMUxM
IDw8IChteGxlbiAtIDEpOw0KPiArwqDCoMKgIGludmFsaWRfdmFsID0gMVVMTCA8PCAobXhsZW4g
LSAxKTsNCj4gwqANCj4gwqDCoMKgwqAgaWYgKHZhbHVlID09IGludmFsaWRfdmFsKSB7DQo+IMKg
wqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiVW5hYmxlIHRvIHNldCBtYXJjaGlkIHdp
dGggTVNCICgldSkgYml0DQo+IHNldCAiDQo=

