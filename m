Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2D606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Yr+P7i4Z;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=oSgMUmbP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOpbo-0005IW-Tm; Thu, 05 Nov 2026 00:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpbk-0005Dk-Hu; Thu, 05 Nov 2026 00:01:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpbi-00056c-S0; Thu, 05 Nov 2026 00:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793854910; x=1825390910;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RkkjabcnyTq58v95Wxsk8K0Zn81j97oaR1Ri82aLvi0=;
 b=Yr+P7i4ZAdQGClcIIe2RNp1jzTrkdCRV/+eDSAY5HxApCJEMrrBXOTp8
 fFE2QLIsgn5sQcf98okfjI7yExjyCgWbEg/3J1LnFK1tTWaFvXeV9ahPA
 FxUssanlb+Wu7+xUa+j8EXoUU3Yfv/xlHfiowqKzhJfkfjjPmaEuCHYIt
 7/88GDqa6ze3dqmBjQzaglsz9ZFZw/zJBKAuydbUsqW9RZIPOXHw5op4A
 4+RKQ5lwJYbIQ4W2ps3f+r4s6x+xkGEMX8zb1NnNWJwCSg9MY8ihx7CLg
 9Dj1OcRyX9kUYvinKdq23qUVKkST0hLIdwIqJWMuWpVNKfwP4J6/mtlZe w==;
X-CSE-ConnectionGUID: QJXnf8FlQEab0ogdUxoLrQ==
X-CSE-MsgGUID: RoPQogL4QBKNjsDzxQIIOQ==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; d="scan'208";a="155631504"
Received: from mail-northcentralusazon11010046.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.46])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Nov 2026 13:01:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVxgejzmPlgyKHI8GHWO8B0RglC1gDDRuf8ta99g7+HGMfrsof/2lJcM/rA04RpS4NE6qLOZg5nX4bP19yh5IyW622NV97Pqv39OSfIw63TDQOT/rQlM0GxNOuoLY87hT6i+JuCGWf0T86pUmnzH2IPdE9g9AFn/HMkAEBiZF5G+Y3u+X/l2euDwMR26dsMLrvBAKoMvvFzgMXvseN48nIln/gx5FV03ICvHY6L/QRpNk18nehT88TUPp1zbhO+PWMic3ZVLmaPHq0Bcf9GKsS+h0n/u3hKibFhPl7MYCpe84k75l1L8Bc1ctEEU3KWxUt2hpsXpOLaLWsR44l4AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkkjabcnyTq58v95Wxsk8K0Zn81j97oaR1Ri82aLvi0=;
 b=lED2k+NWpFmZ365RHTwgEusYKmJ6TKG8+TGt6nRPWyF3QP3Ih1IMU0lsCTNg1+2Z5vw4uuXf4kDFCBQjl9XqEwS1Ime+YdN3k75ckgS2uKFBzWh2AheByxBbQsDUdPon7XV5yNjOBvAWopksO/Hwn4+oY6GJ0oRaLgOwSdZiPqCSqlSD8ycU8XkXrsgZebQayzahDqtlbaWbzDGyImidYOmGsrHViV3BtMNN617fUcTcdIHRW1DJ3+3Vm2krPmNo8XnPOvf6yzLyIgQ6Ay7uDXBZhWTH1zCh3TOz0KvvVjIC/9WOI4qpf3C/bq/0UWUgJ28a2lV+X5APRZEvZbBQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkkjabcnyTq58v95Wxsk8K0Zn81j97oaR1Ri82aLvi0=;
 b=oSgMUmbPOj9QRD+j3zAHyU5HFfpeHMIZYQPP92hh4lqQY7RH96BjtS4DLRvhdJNXjV9lzrhDPvsXf2IBLuhiJC5px8zMH2Q3dB/5Er0QiYz6VG+8er/YKIpFo2W8aW0tbhQYHPYhgRSu5frSpDNUqjNRqiWk5a7idM7OYFiTPYw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH8PR04MB993683.namprd04.prod.outlook.com (2603:10b6:510:40f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:01:47 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 05:01:47 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: add contact for the RISC-V server-ref
 machine
Thread-Topic: [PATCH 6/6] MAINTAINERS: add contact for the RISC-V server-ref
 machine
Thread-Index: AQHdYwjqi86iHm//dU2fKf77VuE1k7ce/3CA
Date: Thu, 5 Nov 2026 05:01:47 +0000
Message-ID: <c671689a3851c664fed66da0663a822d1d9ff374.camel@wdc.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
 <20261023160913.24992-7-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261023160913.24992-7-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH8PR04MB993683:EE_
x-ms-office365-filtering-correlation-id: 772276de-6ae7-4174-0662-08df3af9e4e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|19092799006|38070700021|261022105027099003|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: kSMYWfx6tbDqOs1e37CuH5imVclY7VGBxifTPNKRMzMNMHV+DjwfMGTFXAgPS/ENmV99n1VODsgBftxti2PKIBAtQ1oEFgjXablc+nqwYe9ZqvKcdABzuunB7SsfaIQBECDiV7FgAGegD8dCeIKckr3B7ceSLMmKUSRzmECKUq4PmKSW8k/CKvacG5GV9Wc0fcddXf/G/QJkZL90bVlONYWig4C77BmZqJjyyN1xUurCrmBl/g4BQqr/b/wviad6jraBjwJSKg1ACsRwng1832FqXZ3Deowl9EUthX48vX47pjv0xEXK4zYH+WJmk/wQUE8CXaCfeNhxkU3hSJE5tN9s0dALAtWtJVnwcj3dFSp6wyJ8CpdWlZERjbO89y+/6eESZhDm+tnXouOtrUjIV1EJlJjZKfHZ+ar/VrN3wbKqOLzG2qVXVZQGtoJFfvYpIYmG1gTyH6rJpUilf+PVCTHvU42TN4tyErWztuSj2Lw4GjijiFUCEhz7CQmH5IcHxO3blT6YdlwMsKCBFX3a8W8nugytTyrC4ZnOeyIKEmfA7TmjoMcCTICXdQyLdcd0RVmhNHJQdcQwbiE/wikbrjHAbd7XFcXoMBQNj90PWbO2OSg8kMmQkIAuod8wp59gx1UFt5iV58RqXAkwxv2CTiIlyT9AQK8jtFmzMvPVSjPuu4sUWe0HJbiz6HxiiCEzOud7JW4diK6+jr6VeHBhTQdJw8MCvnCdnpnwd22Dyxg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(38070700021)(261022105027099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2djZXhNaEExbUtFanE5Z004MUlJaXNkRVZFOEl2YlI0czZ0bEdTaTN5cmkx?=
 =?utf-8?B?eEF6N2VCL2htVE93UmNucmlBTWNoUXNyQnRNb3dJZlNtbU8yVnRhWGJ6MHRS?=
 =?utf-8?B?M0F6VjQ4dVJEbXlyWkNxdnBnZlRteDBDYUdmSUpLWDNkSnUva2krcUFIRDd2?=
 =?utf-8?B?bE4yWkE2SUQrcW04dVdDYnVKOFM2N0hlQkNvZVhycFEzall0MHAvVDlYZlFx?=
 =?utf-8?B?SHNBVjV2UlJBVGN1eHZuN0gweHoyY2xQOVFvdmhaTEFCQnd1aUV3NDE5bXJC?=
 =?utf-8?B?blkvQlhScU0xWWFwK25nRWc0YzJtT0NmVEtpT2N4VUpYV3JiUzR2RXJLMUlE?=
 =?utf-8?B?YlhjaVFFR1RjbzNrNVFHdmswelU2dUNuWWFMb0NjbG9TMzlwak1tNUI4ZDJu?=
 =?utf-8?B?Rnd0OXc4Q3ZVSGNOdGpxemRWS2MyZkhYYWZHMlRkS1hFMnhwOVBnVmtybkdP?=
 =?utf-8?B?bE13Qm9ZdGdJd01mb0VKMTgzZmF6a1RKQnlXT3haOVNtUitOMmFWc3g4RG9v?=
 =?utf-8?B?VmNCLzAzZURmUUlhbC9JNnhiUmVvcXFnTktGN2NIdERqNTYxVzJ4WTAxMVVs?=
 =?utf-8?B?NnpCOTVRbS81am1IQWQrRDI1UCtWejBsRnI3elZ1clhsMVdvNTdydDFSdEpJ?=
 =?utf-8?B?SUtKWjd2VkprKzR3UTJNaFdqb1VLcWxVL2hFa2dpZ2RpVklWcDVvQVF3WmNS?=
 =?utf-8?B?TnE1UFlXMlFLK2JsTXNhcGpMT1dFdnk3QjAxMzQrc3VDTmpNeHpmM3FGN0Rn?=
 =?utf-8?B?c3p0ZXJiL2phRWU4T1Z0WEJiYnlKRDhnRGJRb2hDTXVnMW9zWnB6SVZIMHlR?=
 =?utf-8?B?dHJDVmo1bVVuUGJVdStEcUpzTk9TYVhyMVI4VjRWQUxvRHVZSjQ1L3BxdklN?=
 =?utf-8?B?ZXZVRUVVTk54U2VMSEZURXNtOVEyTThGRTJTc280VU1YUlc1T2trM3FXT2RM?=
 =?utf-8?B?MjZRRkZsamRhZmR4QXRaT1N4TkFBaFkwOWxTWWhsMDhaMm5mM28vVkJmM1Qw?=
 =?utf-8?B?TThrdUk3N0hWdXBpck9ZQkFZWDArays4dGdqWEJpSlFRZjRFaVRlby9UajZ0?=
 =?utf-8?B?akN4czVxS3YrTFBzaVVBTmY1bDBSZzFTb3MvdThKMEFaK3Y5WW1PUGsxeWpz?=
 =?utf-8?B?ZjNlWnBvaGFGbUp4RkpQSlE2NHpCOGRrRCsvNzgvdkpxSlRwaUU2RW9jYW1N?=
 =?utf-8?B?OUtMSmV4b0szbnA0a0psRGl4YktYR2hvMEZkWjBzMnR6TndDeTNtZFRjdE1Y?=
 =?utf-8?B?cEI4UFpSQk9UOTBIOVdYOEM0b2lTNW9WejVUeG5qMGppMHYxZUNhdWJLNFRV?=
 =?utf-8?B?RFM0U3BEZnJsUWdsNEhpN1lLczJjYm1QNjYxdEZ0WVVXS0NydGphdFZ5dzBy?=
 =?utf-8?B?SkJiT1lYSXpyQTFzUXZzVXMwYW9LZnk1NGMwUmpBYzhxKzVSUVJMUWhzQzJk?=
 =?utf-8?B?WlZkdHhlVW1wRjRBcFh4SkVpRkViNVB3czJrMnhKK3BBUjlNY1NzdjhBK1FD?=
 =?utf-8?B?T3J3NkgzUTFTVnJpSVpreVpBaWtpKzJFbXZMVzRLV2FKdTlEWXkyMmtmbGtI?=
 =?utf-8?B?ZEVwcXdOV3JleWJjN3ZuN3p6L3RqSlloVks1UWlOTG5qOUxuVzVSeUFsNzZV?=
 =?utf-8?B?WHRlalA4anIvU1crbytZRnFmSGJFUnp3c01ZbElMeGhWRWN3SThsbTNCQkcv?=
 =?utf-8?B?d3lnNld2eFh6QjY3K2ZWRlR6SlJjeTZpUmY0VlBMbXFQdlBJcGl1RHVUS3RU?=
 =?utf-8?B?dkpXTWpFSi93QXNQcm85UDJFV3djdVdtN2E0OGFGSjdkL0V4d2JDS242elFS?=
 =?utf-8?B?UUZTZmlrbFFwZVFXLzAvQ0cxcmM0UEt4SitVR0c5eVFmMFcyNGpzVjUrSElj?=
 =?utf-8?B?aTJPR0M3dXZwL2hCSWhhejF6Qm1rMC9xcTNtdjRRSHUyWG93RTJMeEdmaUI4?=
 =?utf-8?B?WTBxeVpYWFBHVG8wZDlYV1FiUFZBanp0TmNSMlFUWkNKUmZoaWhWVXVqM0kv?=
 =?utf-8?B?VHU2QTMwQ3Y2aWcxSnRVWWVXVmJ2RWE1Q3ljT09UV3lOUmNqakRCVFN3Wm5S?=
 =?utf-8?B?YVBiaGR1dG5BR2VuVC9DWkZoOUtPNUk2QVMrYTYvSUloeVlZUEdWK0p6b0g5?=
 =?utf-8?B?dlQ4dHlmTDJhVW5FdUhXMEVuK3VFbjBndTNqbytnMm1uaWVRZ2Vmb0NoRElX?=
 =?utf-8?B?OXV0OHFJTkZEZHAwS0tneEF1SXg4M3BHdHFzTWtHUzA3MVdydU9uaVpzakxF?=
 =?utf-8?B?RmFhM0FxWVZ3b09KR2Z4aG9PMi84ek5CUHVUd0s2UzlZVVhnOWNla3R4UUdu?=
 =?utf-8?B?QnVCaFl2VWV3RzRqN1B4aWJKS2xVdGNBalpDSXhaN2pHZFFreDFyU1RoazhQ?=
 =?utf-8?Q?TLm1+Gc37UQCWl/LJnnIEh2W9tRdYAVsABS+0hxt4qGxr?=
x-ms-exchange-antispam-messagedata-1: kz1nCYcPs0gYncd9ZKBrM3KBq1Mu2iKVz7M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F025EC73F9EA4CBD8F868B7B49EF4D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1zoDIbTcnh+ce/nPr4PUTjBgX+/KdsI3HYj49OTZrm7/6rWK4IEo0mL4IF6UJwkl8v2ZyNOTydRGsxQOwnkemRHmMo1y2KMBuNSRE6iDu022Alh4ZluG9jRwdcRB8HzfZ3X1Gf1kGY4vFl31PUvtX7u/IXQT6vMCH/t3cHLhGrTGTj14qIKR6KYLISxe+v9hzfPYMg5kSVXf1KQgorbvDqIbJ3nBMa+4lrbF7hMyPoP12cRcmdT2jRO8ueP6fGTkaen/Tq6D7z18iguppAjXfSrfGfTrUeYuBL/60re15hbrbttL9QrGBmFv+55oOBk2lF29WDFW7TOfvHKq5l9Mdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BApqHxaJWoFby8cbynpou30PN6/FOeeaWlQzwLK1m7evi2W++FDFN8fGKHhPghb51C6E1gLO2v5KXv4jX50tvaGozrozypFpmbzy86OUVjoXqP9g7m2tFofmooRZ5Wi2jpU5UU92kvow1W2cn4Zy9gaaO5+rJKdSkFXLbWGBiD0nYefe8YdxDpaZH4dczQk7g9DDT0jbCpIAko/m8wINQyF+IFALBNYQ3VqPsOmKgn2+vX0BGiMbemvyXnms5ivoj/VtGjK01cF6A1e2SY1J06HXS7wrC1yw2tgJH/9+Q4gO5f0TFcRG/ov1CNYp3FTKnth5pDArmeUw/cJ6OZXSo1Kmb3JM743FdWPzp1D9w3Yl4wPezcP89aeqYEk3pmZVaqQ/3+0xtTm8GjZd8NAqy/pVK14QKXmfQnlSqgE/mcqVc4Et0ZdTjXFLDIO5DvpHMom7xSn52Ut0pT83CoO6xwDhL5PpJYv8XrqdH3Tj+PlyR4PwS3YYmZ9Q8NMdTg+EUyoX4crl8tjT18g0pqba6wXiwtMHsE32TpO4TohLdh1B4O7GGtF3DRE1QUL1x+toFjnVLtxb/Z0N8zXN5fDeEXOr3epCaht9cc6O663k44ifoZfKzu6cxaFmGI6ZypGn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772276de-6ae7-4174-0662-08df3af9e4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 05:01:47.1054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZckXAIAcX+eVzbEXyTo5utPhSocbrWWTqiigcnlkUHLmE2Hw/AEkfhE/YMpx6BpFuMy7EEXM5x+Hgk60Wzgid7fWLDziRKVQzwS778sXTw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB993683
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEzOjA5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gTWFrZSBpdCBjbGVhcmVyIHRoYXQgdGhpcyBpcyBhIGJvYXJkIHRoYXQgaXMg
YWN0aXZlbHkgbWFpbnRhaW5lZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBIZW5yaXF1
ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KDQpSZXZpZXdl
ZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlz
dGFpcg0KDQo+IC0tLQ0KPiDCoE1BSU5UQUlORVJTIHwgOCArKysrKysrKw0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBi
L01BSU5UQUlORVJTDQo+IGluZGV4IGQ5MjA5ZjA0M2YuLjE0NmJkYjU4N2IgMTAwNjQ0DQo+IC0t
LSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0xODk3LDYgKzE4OTcs
MTQgQEAgRjogaW5jbHVkZS9ody9yaXNjdi9jdjE4MDBiLmgNCj4gwqBGOiB0ZXN0cy9mdW5jdGlv
bmFsL3Jpc2N2NjQvdGVzdF9taWxrdl9kdW8ucHkNCj4gwqBGOiB0ZXN0cy9xdGVzdC9taWxrdi1k
dW8tdGVzdC5jDQo+IMKgDQo+ICtSSVNDLVYgU2VydmVyIFJlZmVyZW5jZSBQbGF0Zm9ybSAocmlz
Y3Ytc2VydmVyLXJlZikgbWFjaGluZXMNCj4gK006IERhbmllbCBIZW5yaXF1ZSBCYXJib3phIDxk
YW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiArTDogcWVtdS1yaXNjdkBub25nbnUu
b3JnDQo+ICtTOiBNYWludGFpbmVkDQo+ICtGOiBkb2NzL3N5c3RlbS9yaXNjdi9yaXNjdi1zZXJ2
ZXItcmVmLnJzdA0KPiArRjogaHcvcmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jDQo+ICtGOiB0
ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9zZXJ2ZXJfcmVmLnB5DQo+ICsNCj4gwqBSWCBN
YWNoaW5lcw0KPiDCoC0tLS0tLS0tLS0tDQo+IMKgcngtZ2Ric2ltDQo=

