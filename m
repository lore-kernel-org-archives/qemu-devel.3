Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862FBC2A075
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 08:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcgHT-0005r8-FI; Mon, 05 Jan 2026 03:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcgHR-0005qg-BJ; Mon, 05 Jan 2026 03:49:37 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcgHP-0007of-Mk; Mon, 05 Jan 2026 03:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpX8dPcHkgjUvZN0OUAYTa52WN91nmMZAuilNgeCqJAOJYP98av+iw1uBFNvWAX2h2gEOdAt1fCTkK4N02ujKW30y5kUfoGTSKGmp09aJZFqhPok+g9l3W/N9CYX5GRIsxdQWn2YGmu6rcueX1cUtryXzzb2RvJfTnXy0gs4uhTUgekUg+JGRAc+PV+VAHkL/c1uSfzt1ut/OaBh2aDHc3YDh4Xxci9orKRgvAZP/J2zU/pR33g5PcOIbBn1OAbYKs7HRbXR0HeUdqEhTYl5PhS2CrkqwtOgH+qg8Ji/RI9m9V6zCSqft8uO0AEMNtAEoMGRqnmif/LzG0RDbhoPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qr7RoQXlCbdvL8eZUqZdLUmVy59fUtoDL+R7hhKHYs=;
 b=Fgv8x6HCrqhexnqfcTgxT8fohPnpvXc0Vwqy/03NdkNc0zVOVtIAiQfyfHj1OD0TB1fdWpFHugV/EQmvVLHLalDGl+uejdCNl/jmVORIb2Y5DO7YyvYu/mzp9/41NGAhbxEIhn956b/88O5mLGahtV6TP4tZZa5O44W9KcQevOJSgEsu+WU73CKFCsraBiSqaN5sMvdm6SLh4sAj25KAYbrDBEQ0crP9Q/wxbUIgHjk/S7ynNMzdCpiNiWBcF207SFc0s+QAtKCA6qfyRdYob4XR5DdOmvzeAOJZ+4RvjfEJSkPvlAM9tcwX2/+LDXiroknqoKS7iblM94KkFyXu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qr7RoQXlCbdvL8eZUqZdLUmVy59fUtoDL+R7hhKHYs=;
 b=Nxm3htb6Ot4SDK0TxpAkr+V1hCuCG6pvFPrNx4TBL7ioNj2kfSTv8B7aM5P8COn8dJ1v9dyWF0hsdZr6BN72g0B1jtZX94uZFTbRydlxHuNBKSTaQzRUq/2+NSjBZN1V3w0FSbfzrqmEdpMvBVEARTfVBz6/7tUFrbQV3EMkSrqKL56b2AvZG99isz8xOe0v5CUwKXt7miWGs7de+cN3kNvNjYEHX9s6bduK8iDViLjhVgK5wFPZR3QwMLuovUCgo61OZ+1sA0lO0QZThEi0Cy5yd0QIs+b7m8GCbfijdfxnAYNsRKEdUS5rCEY3GTcw+CzGygwI17uGc6kv/6yrZQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF1C65AA8C1.apcprd06.prod.outlook.com (2603:1096:408::787)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:49:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:49:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 18/19] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Topic: [PATCH 18/19] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Index: AQHb2/bDlM/m+Occh0GVuwP9k+8otLVEiHBQ
Date: Mon, 5 Jan 2026 08:49:29 +0000
Message-ID: <TYPPR06MB8206F665AA82758316557C21FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-19-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-19-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF1C65AA8C1:EE_
x-ms-office365-filtering-correlation-id: 789602c1-63f6-43b6-46a2-08de4c3756d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MjhueFFCdkIwcHJZZTFzeHB1ekVNN3NuMnIyZ3dkdGRNayt6ajFHaUxMN0li?=
 =?utf-8?B?Z2Jxd0h6Z0k3VTlaendiai9QSlk5WE9xY3lQQWs2VFRDQTdvNVhUVFE5REo4?=
 =?utf-8?B?TnUxL1d4MjZrcVJWamNLTzhkK3pINE9pS2d2aUtZNzZuTmQzRWRNMGVzSFBK?=
 =?utf-8?B?NW1hM3pXWm9JUVZrRXdPMUhPQThXY3NwVWdtanRSbDlSMkIxMlVhWWpFNzdr?=
 =?utf-8?B?Vjg0dE02MmQxM2FSVzFBampmcTR0MWx1cTZlLytGNlZrak5CTGhaamI5R0l4?=
 =?utf-8?B?c0dpdU4vQkMzNGpyYU54Tm94WXlKSzRIRGdsN1J6ZG93aW1hUy9sSFdyU0o3?=
 =?utf-8?B?cjh4amllTU5Zakg0MC9MNG1xYjZmL2QyekFVNkZlejMvclBrdlJrclYwcUht?=
 =?utf-8?B?Z1luZkRsV0ZHcnRKL1N0NjFvV1pZSGVBOEliMTBnc3VxcXVnYm56TWttUG54?=
 =?utf-8?B?NUZNREJ3SnFvUVZUR0cvZ1JjbC9RNUZoalhSRzBUdi9jR004cmxNbG40dGdF?=
 =?utf-8?B?dGtLVlcvcUMvOXhweGFvY0JIZEdPRDZ1Slp0dC9ZbmpjTEc5YVhVTHNlbjJ5?=
 =?utf-8?B?aWg4VHNoYUZieUhIWjdEMjNKNlRVQ01ERFc2RURiYWhYVDdPQUxIV3lsbzdx?=
 =?utf-8?B?a2JsUjZYQ1NiSVRRWk5ZTU5VTFdrWmVoVHRjL1lhQWVyb2dqRDVBNGVFcE0r?=
 =?utf-8?B?N3paTFBTVnZzMm4wK0xKSnpQVFJyZnJKUTltMWRoczlndFVXSmlUa05lLzZC?=
 =?utf-8?B?UkRQUWRtRmhJUldNczZzaU1Cb1VscmVMYjNRZFNEUk5LYnM1NkhSSitYQ1JB?=
 =?utf-8?B?eThvdmRCTVQ0d3Q2VWYyV2s5cjV2eUNvRllHY3JNWldiU2xDdkhRQ1NzL1Nh?=
 =?utf-8?B?c0tHbzE3ejlyUHFTUkpsdG93eEpad0R0bG55blhUa1pTYXR3V1NPRFhOcnEy?=
 =?utf-8?B?WWMxMjQ3WGM0VkJxQlgyZ3hHdmhzc1ZCeEJ6NGhuYTBsMTFrdDV5RHBIckx4?=
 =?utf-8?B?S21mUkpUQVYwYUhIL3ZBb1BUSXdtS3AzZ3ZyUENTQldVUllQVENDU3F5SThP?=
 =?utf-8?B?eW9EWkJpeStrTzJtSEl1b25aaFFUWmlYcEZTRmg3UE9hLzVnSm5tdXcvekZO?=
 =?utf-8?B?NjF4VVN0aWVRZG5VVHBQWE44N21Ib3lmQWZuNm0rdyt0S3oyeHN0UFRyR2hz?=
 =?utf-8?B?N3J2Z3AyeDRBZHFaL0M5NWtqeVRwSDBJRXJkd0ZNZ0I2UnhQc1pvUS9JVFpG?=
 =?utf-8?B?RDdoTlZiVlphTFhNenpXeXRrZWd3bmMxNUMvV3N5UmM2eUh3UWNMUWU1NklZ?=
 =?utf-8?B?dDlMMHZRRGdRcmVrM0d1akhBd2tldmlNTUYrQmpZWHVRQlBmV3dVU3djTG1k?=
 =?utf-8?B?YW1CVlA0dGxNNk05Nll3dTdFZk5jeEc0WVd1QWhIZ2FrM21JcURBdGpaRHNr?=
 =?utf-8?B?YnR1WmZrbEkxbWtObEhxeVBiekk3OWliTzRva3JVWVJwNG00L1dFYnlPY1Qx?=
 =?utf-8?B?ZGk2dW1FSTd2bUlKcmNiZldPUFdOV0Z4T01CT0NTUE1oK1k3WnF1WVBaU1RK?=
 =?utf-8?B?d3ptR3dQN0IydjIzb0o1eUZGVG84RGZ1cE9UOE9OMEM4NmF2MSt0Znd2c05Q?=
 =?utf-8?B?ZUx3aFQxRmVYbnlJQW4xOHphY1B6MjNBdU8wNDJGNVlRVTJEVzI4TzJtdGZZ?=
 =?utf-8?B?eFV0L1IwaEc1ZDVxUVcxUFJRcHFUSW9MaEFaWjgwUTVoeWpOMytDbDBmamJE?=
 =?utf-8?B?MnN3WUh6L2ROOHVUUUI1MlRQUHl1RGdVQ0N2elJjSXlmTWJMUUkxTThKU0tu?=
 =?utf-8?B?SkdSZDkybWVtdFJrMEdnb2kzaDczZE5DU2hKa1FteE5BU29CNWczTFdlQ0pK?=
 =?utf-8?B?d1oyUm5QQVVML0p6WFdQQVV6TzViTi9HL1FicTgzZXprSS9VNm5kUmVRNEhx?=
 =?utf-8?B?dDk2RUR0ZjN2RmhMS0M3S3pjZjlRY3V3b1lVcHpFM2dKTjdISzh6d0Vxc0pl?=
 =?utf-8?B?QjMzbllTS1VBOUlIdzJsR2ZoZlRwcTY5dzdQYUVCME1ZeHpra2doOW5wVGRJ?=
 =?utf-8?Q?DdpFEU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkNleFBEWkx1NEJIVW9sam9uaHNjOVdSY3lLQ0xjOVBwTnZPSTdUNThIcDVp?=
 =?utf-8?B?QzB4RXRXQ28xQjRPZEt1cDY4RThMUVJBNnFSV3BnZlB1WVJyRG5iRDN4RVRM?=
 =?utf-8?B?NEVQRkZQUGNKNkFkbkhDNlJwazFHYUU5WDZ3MXIyamorblJxSVdwaTdCSTYy?=
 =?utf-8?B?VnpheHZ3aUtkTzNNekRCTkhHY0NFZnZaTkwvU3loSDJ6L0RjMDY0RFY0MzdB?=
 =?utf-8?B?a0tVbnVHWnhDM3laTzFjUEVFZUd1RW1PWFFJMUNlYWJ6NVVQam9DZmNWVkZs?=
 =?utf-8?B?cGZkSG43RWJrNkRMUVVsSFQvRWdvZHVCWVVmNEFMWGVlV1ZPU0RDak5CNWhM?=
 =?utf-8?B?c1VDb2VleFJ4Sjg2SGlZUTFPVmFMQTJOQ1JmZmxsOUlHSDNEVGQ5V2o5RnUx?=
 =?utf-8?B?TU9BeE5RUms1ZjlVYWQxYTl2UzJqQmFTQi82R3VHV1BvbGhWT1BCc0JzVGJq?=
 =?utf-8?B?Z09YZmZENDNwSWx0Tm1jd2Z4RE5kVnlnQWNUSEljaDhENkZrR0pLYkJPSXFM?=
 =?utf-8?B?NjJnblRhSUp0QWNNR3RLUXZqajk1UTlldGFEUThBbElXYU5sZzd0NFdxZ2Ew?=
 =?utf-8?B?Ry9Fb3NSZXpUaFBMSmppK1VuRVUySEtEWjNQSUk4ZFZYR2VEMm1UTi9DWU9s?=
 =?utf-8?B?V2tsVkRobGFQWXNIZEllSjVtWXcybTZZVzhSRHNiSXlBZ3JabldRUExzYVZk?=
 =?utf-8?B?ZFhkYXduL0xBTjJ4YnlqMU5rZERlNnZYTkt1eVh1d0I2dFNlT1NURWtUdkJD?=
 =?utf-8?B?bmcvQk5oUU5mL2FUV2VzNUpKcXZwWllTUENwMDhaZ3QrRy9hQSt4VkxTRG9S?=
 =?utf-8?B?ZHZUdWpyVmlLNGViY2wwQzBaV244RklWTXl3U0RrR3I3TDZHVXZ3TWptSkh0?=
 =?utf-8?B?eEpBcGFFVzk0QURuQ1pmbEtVbTZqQ1FvUkJZNkRIM0VwQ1BySmtpUkRocDFp?=
 =?utf-8?B?ZkpXYXZYWGlJSEpKOWt0ODA1OFhkODY0Y0dRbnBNaDIySitLOU5kdW9RbS9G?=
 =?utf-8?B?ZWdzTmEwc0lSRFd4RDdhaTlpSWxxcm9heGdFQmkzd2pOd0tVa3NpTzdkNE5O?=
 =?utf-8?B?dUVrN1BjWm1BZzV0eXZBcEMvSU1BNTdRQUlzM2JPUTBVMjFFZlJySDgvc0tt?=
 =?utf-8?B?NmNPNnlnOFZwNE9XeS9sMU56WnFLR3VNMmFwY3RFTEFOTk1YdDhwQmFKNmFV?=
 =?utf-8?B?ZElvRWw3MjcvcXRWRkY1VkZtOGJLODhhVjdocFlrcWUxcElVdEVsc09uZXcw?=
 =?utf-8?B?Z0FOMWluMVpsMDhuNDB3SUZaUmcyQmVEY1dpMHZwaE00aXl4T3JOanhuVFEx?=
 =?utf-8?B?eDB2ZnAzcHluRmFwbWtlWTkzVG1rL2FMNVRUSUw2c3FMZnBZWlhRaFk4YjFh?=
 =?utf-8?B?ek1Tc3ZyTGo0dzRwVDRWMnp3cGJVaUp2SlRmZUk5YmpRWDIzODR4dzBQUWV1?=
 =?utf-8?B?ZzZNMW9EV2xhSmk5YndybWVjRGJxY2VsSzhTYkdNRFZxMnMzK09PUzJPNVN0?=
 =?utf-8?B?WUZBSTFVWTFQN2R0Q3ZlaVpEa3ZtZlM4UEYyelhxRmU2bTR6bVJlYTIxTGF3?=
 =?utf-8?B?aFJMOFNiUXBhR0U1MUhTVjZ0bXBaM0FvRzFDZlorbXRVeE5UVmZUbTlBZ1ZL?=
 =?utf-8?B?N01zR1RpU3hYK1VYRjR3d2Z0a09zN2Y5dXFPQVVwVmJvWEVndjBxMGRpTlpX?=
 =?utf-8?B?U2doMFNlUnEwcmRVN2VhMlFlY2lyekdHSVhSdEFFbDNFVTNDYTl1S2hjSElI?=
 =?utf-8?B?RjVCa3RQM0hYV2JYUms5VGNLcmp1SVVuRVQwaUZyS25nTlJuWEdBVG9qeXlS?=
 =?utf-8?B?TGhrZ2VpMkFJaHZMMkYxMUorclc5TWRrMU5oeldlUzg1RGt5a25DVlFReXV3?=
 =?utf-8?B?OVRDZVdmN3VGczMwaU5BN1lXWUVoTERRUVVmWkdjVTdyeDNuaFpGQ3ozTTM2?=
 =?utf-8?B?SEEya0wwYnlSMDAzdnVCODN6QTFwN3FYSm5aRVZLNzE0M3NTVit3L1BZWVZj?=
 =?utf-8?B?ZnY1UTMvRnE5ZFE5c1RnVzd0VXM1UXZsbzl5bEpveExxQXIrKzJkd2xSMmNO?=
 =?utf-8?B?YkgxZ0NjWUNNS1RaQnlSR0luUDZkR2ZLZVVvdUUrbHB4QloyajU5UDYrNDV3?=
 =?utf-8?B?a010NXI0NzAwZHJ4TWRyTlVNOUVqV01CTnE0NUo5MEFUelVFbm05S0lNUytv?=
 =?utf-8?B?akQzMHZmREZRN2FjNUF6azFjTzFRUzZXL01KNG5HOU5ZMXZibnUxWnNsUDNP?=
 =?utf-8?B?TG5OcGdDVTBzck13dDd0dWdHVmkyN0grUHJtN3llK2lRRlNzWHRrelBtdzVS?=
 =?utf-8?B?clNDb01yd1ZoU3h5UVJPWXlEb1lHK1N6NTdGSWk0eURHQ0J3NnBEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789602c1-63f6-43b6-46a2-08de4c3756d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 08:49:29.6497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUrBjLJB/9C4L6bVJRef8/9CQYpoKN6iiMTWIpcB7zjHIgU66loFhveROvW01eqt8hmwmt49OQVL62LydfeI0jcczeUNZSe7rJylsPuLCd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1C65AA8C1
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

DQoNCj4gU3ViamVjdDogW1BBVENIIDE4LzE5XSBody9hcm0vYXNwZWVkOiBCdWlsZCB3aXRoIEkz
Q19ERVZJQ0VTDQo+IA0KPiBBbGxvd3MgdXMgdG8gYXR0YWNoIHRoZSBtb2NrIEkzQyB0YXJnZXQN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvZSBLb21sb2RpIDxrb21sb2RpQGdvb2dsZS5jb20+DQo+
IC0tLQ0KPiAgaHcvYXJtL0tjb25maWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9LY29uZmlnIGIvaHcvYXJtL0tjb25m
aWcgaW5kZXggNTNkNjJjZDA4ZC4uOTQwNDE4YjQ2Yg0KPiAxMDA2NDQNCj4gLS0tIGEvaHcvYXJt
L0tjb25maWcNCj4gKysrIGIvaHcvYXJtL0tjb25maWcNCj4gQEAgLTUzMiw2ICs1MzIsNyBAQCBj
b25maWcgQVNQRUVEX1NPQw0KPiAgICAgIHNlbGVjdCBJMkMNCj4gICAgICBzZWxlY3QgSTNDDQo+
ICAgICAgc2VsZWN0IERXX0kzQw0KPiArICAgIHNlbGVjdCBJM0NfREVWSUNFUw0KPiAgICAgIHNl
bGVjdCBEUFMzMTANCj4gICAgICBzZWxlY3QgUENBOTU1Mg0KPiAgICAgIHNlbGVjdCBTRVJJQUxf
TU0NCj4gLS0NCj4gMi41MC4wLnJjMS41OTEuZzljOTVmMTdmNjQtZ29vZw0KDQoNClJldmlld2Vk
LWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFt
aW4NCg0K

