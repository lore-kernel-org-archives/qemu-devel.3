Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E12D2E009
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 01:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3QML-0004uL-2P; Tue, 22 Oct 2024 21:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3QMH-0004ta-5b; Tue, 22 Oct 2024 21:40:21 -0400
Received: from mail-sg2apc01on20722.outbound.protection.outlook.com
 ([2a01:111:f403:200f::722]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3QME-00050C-Mo; Tue, 22 Oct 2024 21:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFq2c5rJZwDHXXn7pwwTWVFElqYp0CTQGMPLfu4Y7iSWLaBGoiBNoTB37uUWpZtr2s16hinUoQhf/5vxZPrJX6U+Y0cXeYMtarpAz8ZGD+EHJSh1G/Vqzwbc6fVi1UkVUZoJ6cGpkF7UFc3XKFZ+SLUg59ceIFz5lsqhC4bpRzRwzZeoA+gZKnrl7T2U/TSkYGzXreQO/MNVL9r3v9OfbdRFGDhtqcHaTLR1Tep/vcUT0x0WT9xEKlUQf3C9zpmjKU+kGW2gifYay4pVkFK2dMuk6GMPnCijZlTKIWt03Ad0hpqtVb+avZSbiwRo/9vXblNnuainoq4MlOMs2tWIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wsnNhjx+pZXjh0dAo+M3gpzuDMLNU9ivqCXPwFDhEg=;
 b=TvwACW5rsuVTVm2MuHEch9Mf37vsaYGfPbVxpvvvguJ6k+NDiSdatkpEXVNyWZil5cd+pBzbIWlyM9aZQyReIvqIAf6m9TQu4wu7gR65CuGB4I5j9TqnYy1UnWr9M9xvp2QBT+BDgFk9MlBB7tbM67NV1E8E93qaG69qyaamAgk8bVT9yhOIW9Ica487U0VgqcjUVTwHKeqM8O0ywwIMV0RxQBh2b7p8ma9HZ4D3SnLS3k91D8vbYSonhx0TZHlJ9bOuA1NfPmoPlh0+AzFt+VISFR5vLOXjOAdmqiFomoXwYfyomxM8yI/6eJp8vyce7Fna4EbnFzG0kU+y0EBRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wsnNhjx+pZXjh0dAo+M3gpzuDMLNU9ivqCXPwFDhEg=;
 b=cCMAZNZO62M8fqwcAVARt80M9WN5NALsGdweBZNHBW+FCZ5IdQK+9YBYtuLgzs8deULFNHSPgSYDM9BhaDy4Un91uBOYK6HeT1Yrot8qKKLWCE60oMFly2+yZeneqmSd48DYYjW2azOm05pxvFBz7Ue67klj6p/hdSe/eauMFuCm/bE56ekuN7azk1gXF5UqIInTREtE2S7hPB9OaF770MLmxyRY7mW7MELhRwVVA+5eCwDqffRTc13HcjRM4aG2m2Yh2G/3DMGrsY6Xn7OWi0toTkvYTsOUxN3B57hqqXXY8mghFBDIk+3OW+LU1HMYpNYfrUqRJv6Wqq3hjQHSDA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6158.apcprd06.prod.outlook.com (2603:1096:101:ea::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.15; Wed, 23 Oct 2024 01:40:04 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 01:40:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 12/18] test/qtest/aspeed_smc-test: Introducing a
 "page_addr" data field
Thread-Topic: [PATCH v2 12/18] test/qtest/aspeed_smc-test: Introducing a
 "page_addr" data field
Thread-Index: AQHbJGaexNsj8BEW/0iOQgQZ7qVBz7KSyXcAgADGSdA=
Date: Wed, 23 Oct 2024 01:40:03 +0000
Message-ID: <SI2PR06MB5041F4D143A41C5CCA258F4BFC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-13-jamin_lin@aspeedtech.com>
 <ead07059-5ec5-4674-a25b-2afbd4a8dba9@kaod.org>
In-Reply-To: <ead07059-5ec5-4674-a25b-2afbd4a8dba9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6158:EE_
x-ms-office365-filtering-correlation-id: de99d7c4-9e81-4a05-b1e9-08dcf3039d91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WDhYTDVkZzNIWjZNcHJWUk41T1ZKTXBIdlVOWkxydkhWWm8zK2duWG1LNnJM?=
 =?utf-8?B?enRuRDY2d0Z0TUMzaFdoSzRvbVY1bUJGOVc4WjZMQnhZYnJjVjBuNnNGZUgy?=
 =?utf-8?B?dzhtUElDSzBBNjZBcTdnWjk1QnliWGQzaDFBcWZ6MXJOMTFtSUVUMjhVYVE3?=
 =?utf-8?B?QXAyUGpZTEcxK2dKQ3ZoSmhRK2xtU2RWSzgyMEZjYm45WXlBQ3BtQUE1eGQ4?=
 =?utf-8?B?YThFZUJSZWRuS1czTmc5YktXejBXQ2xmNjBmS0M2emNZdTF0TTRLN2Z2a1Jj?=
 =?utf-8?B?NnUybDZpQk10eVpZekJ5QzhKWHlza0FXWFgyaVhCblZkRDFjYlRwQ0krd1F2?=
 =?utf-8?B?M004UzZHbWRRaE9XNjdnT2d6dXpucWtzUGdhekdlYkNMREZaL1pvTkZwNCtq?=
 =?utf-8?B?Y2FQbk84WGIyUzhMUXVOdFd1cThNbDVVY1FNaXFnVzNURm9FeFBZVStNYUZN?=
 =?utf-8?B?WkY4Z0FhdmRPUUphOGpkVEJGV1RCaHJJZHBBUlVQOW0rQkFPK1Q3d3JpZUMy?=
 =?utf-8?B?TjN0SHI5ZTNwTXVITmVuRDZ5NTNiWXJSZWpId3N3M09lVjdqTTJVQ01LNWJs?=
 =?utf-8?B?SzlqQ1ZOUmIzU3d5b09vOVJ0cWo5V3B6SjREaFpzR3ZudGhid2NKSlg5SDhV?=
 =?utf-8?B?RmdzNTJqMlB6RlRMQmsveC8waWJxWlNnQ0lwVDlkRE1kSGNyQTBXdmExSGlQ?=
 =?utf-8?B?U3lhWXBlQWU1MmRrSEdMakFRTm9QL2ttOExrblFIWnJXeGJ6dndydm9uU3l1?=
 =?utf-8?B?VmlNUU1uMGcvUnMva1J3V0RERElqUXBsbXZzTldvTzFZLzBYdG9qVTM2Sko5?=
 =?utf-8?B?Z0JWT3ZPa0pQVjJiTlVEOEVkZHdiU29sZGQ5NHFmY1ZycjI5cENEZjNzNW9N?=
 =?utf-8?B?eDNJWUp5NEh0d1BNRWJxYmExQzljdTZtSkFLRHdXUExTekRhZWViV05Td0lS?=
 =?utf-8?B?d1ZlMTJPSjJrRkM1YldaTkFtMmN5MWdwRmlPU2puTFhKL1dFQ3ltdW9mTFo5?=
 =?utf-8?B?Um13UHIreHMzQmRyK0trS2VBdXRFR0hPaEJXVS9hbzlmcWRCU1ZyNzlDQ2pU?=
 =?utf-8?B?MGZsLyt3amsxYnVnek9HV09xQUd0N05ib01XUzFVdVNrZWhFV1ZxVWdnSERJ?=
 =?utf-8?B?VEhXNUNIWDZIdVVJYWVidkkzU2lZaCtGay9qY1RNMkR1bkNEb0RiS0pxVG5T?=
 =?utf-8?B?bXgyejZXR1VpM3NZaGFsOGNJbW45SGZibGVTTWdUTWhPb240eHc3MkRwZUh1?=
 =?utf-8?B?dnNvelhtM1BDQzJ4UDZjcURPbWhhWFhsMUdXUmlNY0YzQ1h3UnRLbnBhOFVl?=
 =?utf-8?B?Uy9hVEt2UnExL2VETVA0ZU5LZVdTTGcrYWEyYVZuZVRZd2p1VFY2TlpDUDJt?=
 =?utf-8?B?RnRYVlNlb28xWXdQT2xvN29aUGVwUzc4Unlxbjl6b0pkRFhmcWt3MmU0YnND?=
 =?utf-8?B?djZtR0hBRXloM3A3RURpWHFJVkVibVRDbGs1YXhNU0toRTNnc2Y3NE1Jbi9l?=
 =?utf-8?B?cXlNQW9uejFRVTZBbURWL2NvVkc4d2xIWW8vbUtySXRUY214VzlQK05rbk5O?=
 =?utf-8?B?cGIzUXhDQ1ZXc21WR3Fub0RDSXQ2bE9WSW40SzJoeDRkNmhUbndYUTZ2Q29C?=
 =?utf-8?B?VmpCMlFEV3M2aHcvWmx5TnNaQzVHd3FEaEVhZHB1L3ZWdUpSUWl5L2dtYWwv?=
 =?utf-8?B?MkxmdDh4TWZpdHNVcTE2SXI5QVRZVkVrS0ZjTnJaaURrdzUxSGppdDNWYk1P?=
 =?utf-8?B?YzdnVm45eThMUnRCL0dKNjh2OFc5d0M1MTJQRmpjbk15aU1NWU5rSEJIZzdK?=
 =?utf-8?B?WFhqS0tWZWV5YlZOLzVudzNTOEtyNG1nakwzelR3end0MGtGRkRiRm5weW9L?=
 =?utf-8?Q?w54BKVnEg0bIA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnlFRG5Qc2oxRVBkckZIMkJtaXJaTlVWU21UNXFHV0tWYWhiY1pVK3VpWGhi?=
 =?utf-8?B?VXVqUEFMOHpJNzBHUUhUSGhkU250LzFKYllmZm00SlJ2VzgzeksybUI1NjF6?=
 =?utf-8?B?RmxUb3RNRlVtZXZZVFBDZjlBeDhxYzhVN0tPK2d3bDFubm5xMFVxcDlNZnVU?=
 =?utf-8?B?WTVQM0IwbGJ6ZFZxRGxNVEFkRmlRS0oyaW5XeTBrMWhURzl3MHhpMzZ1bTkz?=
 =?utf-8?B?bFJUaGtmbEtVcFg0N1kwUysvbzhnTWFoK0FyUjFmR2VpQjdLamx0cjhrTXM1?=
 =?utf-8?B?d3JONFNEY1VLUVBxVDBYdWFJZzF2aDFHdXpNcjFlVWhWZEdFdGszSDJYcFMv?=
 =?utf-8?B?SFlYcGVtQXBnbnlRMjA4MWF4RTdCMVZzS2ZsMzloTTZTcFAxUXQ0UWhYb2c5?=
 =?utf-8?B?dEhQb1BRSGJWeTY0Vm9RaUZDM0FUa1oxY1pRRlVSQzJ3d1FjWStyWlNMWENH?=
 =?utf-8?B?cmV0QzRDS2xkNWlGY2ltaDJCVE1GOFFFNjZVTzB6eG1JVXZtWEtaMm5IMEVh?=
 =?utf-8?B?Zll3RDRIOXlLQ0MxNGR2Q254bFRxSmlHRi9RdXd2MklvU1lGZzdFWFpFeHhy?=
 =?utf-8?B?ekpjRzFMWDdSZnpkT1M4M0hJSGZJMElNRXdjdlJQT0thTi9zOTZEbEU0dWdB?=
 =?utf-8?B?YnVWVW1wQ1VDTTRYK1orUU9zUGdmQkYwNXFQNk1FK1hHMllEUmlKWm93bnMy?=
 =?utf-8?B?UkFtNVFlbjVZY0MyUVdNcHpqRW03bFJCcUtaeU1HQ3QrOTlvT2VES3hOK3c4?=
 =?utf-8?B?MDI5QjJERHRsNFpMVlNKeXFtdEdBc2dxakZuL29CRXBGdTN3MHcxV21FVEJN?=
 =?utf-8?B?UVNqQlNFS0lyY1pYZlhqVDlQK2pXZjNVd3pNWWJUYm5McFA2SldURDBqRTg3?=
 =?utf-8?B?Z01KZFRLKzZEdWpzNzBZSGVFZ3RMWm9GMmpBS0tibllyNjJJYlJ4Mi8ybmJC?=
 =?utf-8?B?dExHRytNZW1kZERQYVVCcVlvQ0pqL1Q0czQ5NlZ0SHNsM3VSeHVSS21GWVZl?=
 =?utf-8?B?UW03VDZuY1lmblppdmFtRituUkZ0TmZFNHVRSnl1QjBYdWF5Zi9obFNHSzcx?=
 =?utf-8?B?ZzFkS25lQ3B4eksvc0NnNjN1bmZjSHhZd3ZyK2NQQlVEZ2ZUWEY5am1iWVlp?=
 =?utf-8?B?d2c3UkIxbDZIb0VVblRHajhUVmxkQnBtdjJWS0VHL2MvazloTkJnNnU0TGhL?=
 =?utf-8?B?UUlPRmZYNUdZVnRkYTk2Q2VxWXYwVUtPdkN3dVFoN1hKSXRyWHNxbWdHd3pu?=
 =?utf-8?B?MkY0ZC9kVnlvSU00OGw1VDZKSEIvUHVLQmxadEFMZUJ2U3FSSEJJdW1VWll0?=
 =?utf-8?B?dkI5VjVPQ3FuY3UvSHFJaFhsT0ZOTTJKekVBV3I4MG1ISzFYeVQvVXJaZXJZ?=
 =?utf-8?B?VDFQNGtOU2tHemExUHNxUk5QNWNkdzhxS2NPRWI0WGdpL1ZlaU5SZVlaTjFo?=
 =?utf-8?B?VlQ0SFpNRVE4TWg3UVFsUDhoR20rSG9BMFBsTllyYytZK2s4bnNvMWo5UzdP?=
 =?utf-8?B?K1lsNDNuV25xc1pTdmFwbGl4NWk5YUF2YkExYTFtU3orc01Yc2t5OFFVbmRq?=
 =?utf-8?B?VUZxbVJ6NHJVVWxwdGd1QmJjQnFCZFFLak1CK3ZXalRCSUI2MHZOcmZWTVNE?=
 =?utf-8?B?ZWlvaC94d0ZsRzRxaEtpZTZ0OTB0cUFnc0dQODl1RUQ3TWtQNktmOUdNMlFP?=
 =?utf-8?B?VlUrOWxFOGVkNjJNRUF2Z0JPS2llU0tSMXJuc0ZCeUZFQUpNWDBTODNldFZY?=
 =?utf-8?B?Vk95aVNTUW9FQ3pqdmY3dlFoV2lWMDdPRlMwNHZoT1Q1SkNTZEljMFNkaGo4?=
 =?utf-8?B?a3ZWTlJOK2xMU2ZhSEZsMDd3YUQyUEV3YTQ4NGVVNXRhVHRQc1plSjR0RDhO?=
 =?utf-8?B?R0FpYnhiTEdJMS9GODdFNjYzQndxeEFMVGVOUEFPRDRkczNkYlVyRklVb0lB?=
 =?utf-8?B?NmVjVFgza0ZFNG45M1JON3llcFhIQkcwdTVrSmh2UGJXWHN6TkpqUzZrT2ZZ?=
 =?utf-8?B?dnRGS0JSMnk5MmhQamtpcExKY3NpeGx5ckhIRWpmSm1zaTZhaDAvMTFPYmxH?=
 =?utf-8?B?a1BRai9DZjU4M1o2SXlwbFlyd0FoZW1ReG1VVDlUQThYL0NDVE1HT0tmc1Q4?=
 =?utf-8?Q?aTH7zBLSCxzwIjMoAh4kV61E7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de99d7c4-9e81-4a05-b1e9-08dcf3039d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 01:40:03.3229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUMFG44V1tLkGRKBhTqcDzU96uEs49/h3UfOJdfbCMpbqhyuXwg7C9/QbQpn0BHxTljD9U+LyW2lX+c8/Tp80AqWASl8Jf75ZhMN7G9XY3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6158
Received-SPF: pass client-ip=2a01:111:f403:200f::722;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTIvMThdIHRlc3QvcXRlc3Qv
YXNwZWVkX3NtYy10ZXN0OiBJbnRyb2R1Y2luZyBhDQo+ICJwYWdlX2FkZHIiIGRhdGEgZmllbGQN
Cj4gDQo+IE9uIDEwLzIyLzI0IDExOjQxLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQ3VycmVudGx5
LCB0aGVzZSB0ZXN0IGNhc2VzIHVzZWQgdGhlIGhhcmRjb2RlIG9mZnNldCAweDE0MDAwMDANCj4g
PiAoMHgxNDAwMCAqIDI1Nikgd2hpY2ggd2FzIGJleW9uZCB0aGUgMTZNQiBmbGFzaCBzaXplIGZv
ciBmbGFzaCBwYWdlDQo+IHJlYWQvd3JpdGUgY29tbWFuZCB0ZXN0aW5nLg0KPiA+IEhvd2V2ZXIs
IHRoZSBkZWZhdWx0IGZtYyBmbGFzaCBtb2RlbCBvZiBhc3QxMDMwLWExIEVWQiBpcyAidzI1cTgw
YmwiDQo+ID4gd2hvc2Ugc2l6ZSBpcyAxTUIuIFRvIHRlc3QgYWxsIGZsYXNoIG1vZGVscywgaW50
cm9kdWNlcyBhIG5ldw0KPiA+IHBhZ2VfYWRkciBtZW1iZXIgaW4gVGVzdERhdGENCj4gDQo+IEkg
d2lsbCBjaGFuZ2UgOiBzL2FsbC9Tb0MvDQo+IA0KVGhhbmtzIGZvciBoZWxwLg0KSWYgSSBuZWVk
IHRvIHJlLXNlbmQgdjMgcGF0Y2gsIEkgd2lsbCBmaXggaXQuDQpUaGFua3MtSmFtaW4NCg0KPiA+
IHN0cnVjdHVyZSwgc28gdXNlcnMgY2FuIHNldCB0aGUgb2Zmc2V0IGZvciBmbGFzaCBwYXJnZSBy
ZWFkL3dyaXRlIA0KPiA+IGNvbW1hbmQgdGVzdGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiANCj4gd2l0aCB0aGF0LA0K
PiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIHRlc3RzL3F0ZXN0
L2FzcGVlZF9zbWMtdGVzdC5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3F0ZXN0L2FzcGVlZF9zbWMtdGVzdC5jDQo+ID4gYi90ZXN0cy9xdGVzdC9h
c3BlZWRfc21jLXRlc3QuYyBpbmRleCBiOGFiMjBiNDNkLi42ZGIxODQ1MWQyIDEwMDY0NA0KPiA+
IC0tLSBhL3Rlc3RzL3F0ZXN0L2FzcGVlZF9zbWMtdGVzdC5jDQo+ID4gKysrIGIvdGVzdHMvcXRl
c3QvYXNwZWVkX3NtYy10ZXN0LmMNCj4gPiBAQCAtNzIsNiArNzIsNyBAQCB0eXBlZGVmIHN0cnVj
dCBUZXN0RGF0YSB7DQo+ID4gICAgICAgY2hhciAqdG1wX3BhdGg7DQo+ID4gICAgICAgdWludDhf
dCBjczsNCj4gPiAgICAgICBjb25zdCBjaGFyICpub2RlOw0KPiA+ICsgICAgdWludDMyX3QgcGFn
ZV9hZGRyOw0KPiA+ICAgfSBUZXN0RGF0YTsNCj4gPg0KPiA+ICAgLyoNCj4gPiBAQCAtMjU2LDcg
KzI1Nyw3IEBAIHN0YXRpYyB2b2lkIGFzc2VydF9wYWdlX21lbShjb25zdCBUZXN0RGF0YSAqZGF0
YSwNCj4gdWludDMyX3QgYWRkciwNCj4gPiAgIHN0YXRpYyB2b2lkIHRlc3RfZXJhc2Vfc2VjdG9y
KGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICB7DQo+ID4gICAgICAgY29uc3QgVGVzdERhdGEgKnRl
c3RfZGF0YSA9IChjb25zdCBUZXN0RGF0YSAqKWRhdGE7DQo+ID4gLSAgICB1aW50MzJfdCBzb21l
X3BhZ2VfYWRkciA9IDB4NjAwICogRkxBU0hfUEFHRV9TSVpFOw0KPiA+ICsgICAgdWludDMyX3Qg
c29tZV9wYWdlX2FkZHIgPSB0ZXN0X2RhdGEtPnBhZ2VfYWRkcjsNCj4gPiAgICAgICB1aW50MzJf
dCBwYWdlW0ZMQVNIX1BBR0VfU0laRSAvIDRdOw0KPiA+ICAgICAgIGludCBpOw0KPiA+DQo+ID4g
QEAgLTMwOCw3ICszMDksNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2VyYXNlX3NlY3Rvcihjb25zdCB2
b2lkICpkYXRhKQ0KPiA+ICAgc3RhdGljIHZvaWQgdGVzdF9lcmFzZV9hbGwoY29uc3Qgdm9pZCAq
ZGF0YSkNCj4gPiAgIHsNCj4gPiAgICAgICBjb25zdCBUZXN0RGF0YSAqdGVzdF9kYXRhID0gKGNv
bnN0IFRlc3REYXRhICopZGF0YTsNCj4gPiAtICAgIHVpbnQzMl90IHNvbWVfcGFnZV9hZGRyID0g
MHgxNTAwMCAqIEZMQVNIX1BBR0VfU0laRTsNCj4gPiArICAgIHVpbnQzMl90IHNvbWVfcGFnZV9h
ZGRyID0gdGVzdF9kYXRhLT5wYWdlX2FkZHI7DQo+ID4gICAgICAgdWludDMyX3QgcGFnZVtGTEFT
SF9QQUdFX1NJWkUgLyA0XTsNCj4gPiAgICAgICBpbnQgaTsNCj4gPg0KPiA+IEBAIC0zNTgsOCAr
MzU5LDggQEAgc3RhdGljIHZvaWQgdGVzdF9lcmFzZV9hbGwoY29uc3Qgdm9pZCAqZGF0YSkNCj4g
PiAgIHN0YXRpYyB2b2lkIHRlc3Rfd3JpdGVfcGFnZShjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAg
ew0KPiA+ICAgICAgIGNvbnN0IFRlc3REYXRhICp0ZXN0X2RhdGEgPSAoY29uc3QgVGVzdERhdGEg
KilkYXRhOw0KPiA+IC0gICAgdWludDMyX3QgbXlfcGFnZV9hZGRyID0gMHgxNDAwMCAqIEZMQVNI
X1BBR0VfU0laRTsgLyogYmV5b25kDQo+IDE2TUIgKi8NCj4gPiAtICAgIHVpbnQzMl90IHNvbWVf
cGFnZV9hZGRyID0gMHgxNTAwMCAqIEZMQVNIX1BBR0VfU0laRTsNCj4gPiArICAgIHVpbnQzMl90
IG15X3BhZ2VfYWRkciA9IHRlc3RfZGF0YS0+cGFnZV9hZGRyOw0KPiA+ICsgICAgdWludDMyX3Qg
c29tZV9wYWdlX2FkZHIgPSBteV9wYWdlX2FkZHIgKyBGTEFTSF9QQUdFX1NJWkU7DQo+ID4gICAg
ICAgdWludDMyX3QgcGFnZVtGTEFTSF9QQUdFX1NJWkUgLyA0XTsNCj4gPiAgICAgICBpbnQgaTsN
Cj4gPg0KPiA+IEBAIC0zOTUsOCArMzk2LDggQEAgc3RhdGljIHZvaWQgdGVzdF93cml0ZV9wYWdl
KGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICBzdGF0aWMgdm9pZCB0ZXN0X3JlYWRfcGFnZV9tZW0o
Y29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgIHsNCj4gPiAgICAgICBjb25zdCBUZXN0RGF0YSAqdGVz
dF9kYXRhID0gKGNvbnN0IFRlc3REYXRhICopZGF0YTsNCj4gPiAtICAgIHVpbnQzMl90IG15X3Bh
Z2VfYWRkciA9IDB4MTQwMDAgKiBGTEFTSF9QQUdFX1NJWkU7IC8qIGJleW9uZA0KPiAxNk1CICov
DQo+ID4gLSAgICB1aW50MzJfdCBzb21lX3BhZ2VfYWRkciA9IDB4MTUwMDAgKiBGTEFTSF9QQUdF
X1NJWkU7DQo+ID4gKyAgICB1aW50MzJfdCBteV9wYWdlX2FkZHIgPSB0ZXN0X2RhdGEtPnBhZ2Vf
YWRkcjsNCj4gPiArICAgIHVpbnQzMl90IHNvbWVfcGFnZV9hZGRyID0gbXlfcGFnZV9hZGRyICsg
RkxBU0hfUEFHRV9TSVpFOw0KPiA+ICAgICAgIHVpbnQzMl90IHBhZ2VbRkxBU0hfUEFHRV9TSVpF
IC8gNF07DQo+ID4gICAgICAgaW50IGk7DQo+ID4NCj4gPiBAQCAtNDM4LDcgKzQzOSw3IEBAIHN0
YXRpYyB2b2lkIHRlc3RfcmVhZF9wYWdlX21lbShjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgc3Rh
dGljIHZvaWQgdGVzdF93cml0ZV9wYWdlX21lbShjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgew0K
PiA+ICAgICAgIGNvbnN0IFRlc3REYXRhICp0ZXN0X2RhdGEgPSAoY29uc3QgVGVzdERhdGEgKilk
YXRhOw0KPiA+IC0gICAgdWludDMyX3QgbXlfcGFnZV9hZGRyID0gMHgxNTAwMCAqIEZMQVNIX1BB
R0VfU0laRTsNCj4gPiArICAgIHVpbnQzMl90IG15X3BhZ2VfYWRkciA9IHRlc3RfZGF0YS0+cGFn
ZV9hZGRyOw0KPiA+ICAgICAgIHVpbnQzMl90IHBhZ2VbRkxBU0hfUEFHRV9TSVpFIC8gNF07DQo+
ID4gICAgICAgaW50IGk7DQo+ID4NCj4gPiBAQCAtNjc5LDYgKzY4MCw4IEBAIHN0YXRpYyB2b2lk
IHRlc3RfcGFsbWV0dG9fYm1jKFRlc3REYXRhICpkYXRhKQ0KPiA+ICAgICAgIGRhdGEtPmplZGVj
X2lkID0gMHgyMGJhMTk7DQo+ID4gICAgICAgZGF0YS0+Y3MgPSAwOw0KPiA+ICAgICAgIGRhdGEt
Pm5vZGUgPSAiL21hY2hpbmUvc29jL2ZtYy9zc2kuMC9jaGlsZFswXSI7DQo+ID4gKyAgICAvKiBi
ZXlvbmQgMTZNQiAqLw0KPiA+ICsgICAgZGF0YS0+cGFnZV9hZGRyID0gMHgxNDAwMCAqIEZMQVNI
X1BBR0VfU0laRTsNCj4gPg0KPiA+ICAgICAgIHF0ZXN0X2FkZF9kYXRhX2Z1bmMoIi9hc3QyNDAw
L3NtYy9yZWFkX2plZGVjIiwgZGF0YSwNCj4gdGVzdF9yZWFkX2plZGVjKTsNCj4gPiAgICAgICBx
dGVzdF9hZGRfZGF0YV9mdW5jKCIvYXN0MjQwMC9zbWMvZXJhc2Vfc2VjdG9yIiwgZGF0YSwNCj4g
PiB0ZXN0X2VyYXNlX3NlY3Rvcik7DQoNCg==

