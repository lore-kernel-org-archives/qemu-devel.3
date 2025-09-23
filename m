Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B74DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yRA-0005Qk-Uo; Tue, 23 Sep 2025 04:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v0yR8-0005PH-Af; Tue, 23 Sep 2025 04:31:46 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v0yQy-0003Qn-Bf; Tue, 23 Sep 2025 04:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARcKAxaZbvS0K/PR3/MeLG8lyUYpWpgAU7gPGHQSRbm0sA6pTV3ER8qxS9Ery7KJ+4z3CgBmA0psQTXokl/QOzCU1yECkb/GvkQ7qefH+GsxjQcnOvsSKCWHGF/MgDGrNQx8QXjeqg6coNaamB47HZPzJ9N5Or6O/EDOyrntlJ3MhrMp14JfTSEAiT2itPx4j+KGUDwfjZ6luEVRwcsaFdG5AQAnf1vEySwWszxgZVrFapxDRoqRxzkcAbnz7mXrp3MBiaBy3VoVciUiQrNMrzyz1T1B0j2wrH5gLorTSshCO7ztixEYEcXZUZW1Dbyu9wgL5ZvebVykZ9tDRrFFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rWUJPIUVBkjOlK8ZKYqMTvrkyLa011voOfD9U3rpFA=;
 b=XhO4hWUR3jWIVef/Yn/RglPgsoWIZg27Oc3m05pK1WSBwBnLEFkI1yzRh+ZoYKz9xeq/IK6fbJRB2fZ4lRADHpeeWd/manyyQ1g90HzmBb/YU1vmxot+ilPMmCACDCYObMqZdqvNxLl8zN+nnD288jtqZVd31fPU8r61ZNPrK/3kPM/3YgHyiGtM6umk2853mwE+O8+iSMWqG/W7B8H5RJJBp50Ne7zmFEG6vkBm8op4xMqtz62lbKiq6XlvNK+pg2O5hCZu/QB42jdeSXyGt3/PNZUyLLSETvRcudqQ0ecS4TcZq1i/9icrQZu56NGWQbNQ3smaIdblP3hgV68Pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rWUJPIUVBkjOlK8ZKYqMTvrkyLa011voOfD9U3rpFA=;
 b=c81kiQvXAlLGk5moUm9/shJlTT2YcZq4wrPMz3dZsyRP7HEY6+T/osuMGjfJFc+o1itj8IaSIAVd4oeBJy9oGRQh76+T+ZReBiSpTtNTd8f3yysCK4+8VzyD+29gsnnXsP8wMXk5UMQTi5AfkzosPmgqahobIlt5vMSEpCc6yRNppjJEHB/GS51BCp17xK0HBMVC6vYFkG2Rmdd0xU6mroHxPDFZMNSg/gNeZD4mo0WhmyhF/fEkyKE8JH17H1Cxp45eLqZzLyE2QO6tKIypC1edm0HNThj1LJltf0hzBsHfg+g5US7iDQ8uT1GgGI3d+HMM17+W0GXh8hW9fIVoVQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 08:31:20 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Tue, 23 Sep 2025
 08:31:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP and
 ensure correct device realization order
Thread-Topic: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP
 and ensure correct device realization order
Thread-Index: AQHb9sykX4ZS+8HKlE6CthFW598H6LR/1CqAgCED8pA=
Date: Tue, 23 Sep 2025 08:31:20 +0000
Message-ID: <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-9-jamin_lin@aspeedtech.com>
 <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
In-Reply-To: <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6964:EE_
x-ms-office365-filtering-correlation-id: 3370f19d-3371-47e3-5b5b-08ddfa7b92b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?b0U0Y1k2ZkxsUllDbndoeThvZUt4Z2NBVXN1Q0xlUkVOK3Y5N1RLeDFLY05n?=
 =?utf-8?B?dG1JWFJkVXVyUG9NTWthQVlYN1h5MTBMWTNDb3FQRTB5bHk0U3Y3YkU1TjUz?=
 =?utf-8?B?M1NWRWFJTlVvaEhRajkvamd4c2gvZmZCNnE5a2xYT3duRFZWZU14RXJUZUFO?=
 =?utf-8?B?NHBFQ3lYSHBpcWxKRk8xb1Nqa2F3bHJ4NW1aV0VpaVlQMEdwa1dNQUpmMmxt?=
 =?utf-8?B?ckc0QjlySnM3MWtXMG9WRGZHd0podm45aHRxRFNtWFc3VjNTQURTMFAzaFhQ?=
 =?utf-8?B?SzljQXdyMUM3eUova044bFk0cW1DSTlTMUp2ajM1bWM0TVluczU1NDcwSmU1?=
 =?utf-8?B?TVUrVDVwazVsUnAvNXdlVm9NT0ZNNExIeXM2L3FPRndFVzdnWnVuWkJmU1VE?=
 =?utf-8?B?amhkN2RDbDV2MFB5WkdEdWVWa2JZTElEOEhicTVuUlFZS2x3OUpOMnhZdEQw?=
 =?utf-8?B?UytvRXBFanllQUVpOTdIdEhqQ0llVXB5ejZkLytsN3lzRDNKSmNERjN3blZr?=
 =?utf-8?B?RnQ1U05PeVZ0NFVGVVJtSTAzQXl2MHo5dGJXcHFRaW56b3FLS0JkUDU2dzk3?=
 =?utf-8?B?QURKTXc1aXpreVovNUN4V2hPZjc1TUtBWnh1dW9VWE5lK0JpRTBpaGIwUjY1?=
 =?utf-8?B?N2dlbWxVZWxXYUlNbFBVdEU5OXhGdHVBTkNaSERNQUZSTC9ibDFzZ2xSREF4?=
 =?utf-8?B?MmJuU2ZmVVIyWHFtZVI4Z3Q0KzdUUE4rMFh3QW5memVmazhyMkg2bm4xbWJK?=
 =?utf-8?B?Z0EwVnFqYlNPNzN5Y1FVVEJxZXBvcFJ5R2VKZGUxcXZpMGFLOTZ5UmJzUnJ2?=
 =?utf-8?B?Rk5FWUt5UFoxNXAydmhBTUErd2lmTEFIUnZBZ0hpRitQM0Y5UU13cEx6ejl4?=
 =?utf-8?B?ZUFPVmErcmxESWtxelV6QTJxSmZ1K21EalE3L2xPSmFxTEhMVTFOR1ZSMk4y?=
 =?utf-8?B?WUF4MjNrd2FVeElKVE45aE9ObmFPMGUwWG9wTmZrVDFuNHNuaHhmQkJKNG91?=
 =?utf-8?B?MExEMkllM2RQVG55OUFITkFBNVM0RUpwQ012WmZXUHQ1SnY4NXBpT3lYdUU3?=
 =?utf-8?B?ZGdpdHFPVlJJK0xtQXZydENBTG83c3pSUzBXYTJ2byt0MTU1ZW5qdzVPOGlm?=
 =?utf-8?B?bzc0ajJFTVA1ZElYK0dyRE0wUExRWFBlMnFoNzNzNFNTN2wwV2g4NjB0eXFR?=
 =?utf-8?B?K0FscWxoTVN5bm9hMHhQMllDSi9qeFJpRFpTK0ZleTRGOFM1OXRvdk1Pb2dt?=
 =?utf-8?B?ZGIrTGtDUWZaaktqT0diZUtmbmgyYmI2MnhhSzB2aENjMnh5RytLWFRoSmlj?=
 =?utf-8?B?VksrbUgvbFBmSFV2QjZGalNDS2gvdWF5N1B1SE04M2FpRnQ5ZnZweVA0TVN3?=
 =?utf-8?B?bUg5RGhpRXlMRGFCWUQ0OUJYRVVvYkR3OEpMN0U4Z3NDMEtubFlGeGgyOXVi?=
 =?utf-8?B?SkhTTzR4SENqYTgwLzE3bG1MRm9YcXFYNFVWTUxoQVEyNHF6SElkSnhEZHQw?=
 =?utf-8?B?bUp1cEJ4L1Q0MXQ4Si9mT0JoVklsUUMzWWxRbkREK29HdXI5OU9pYWdRakY3?=
 =?utf-8?B?SU5LckprQUIxQWx0VElPVnhQMjh1VURMUVBmVkc4a2QrNXpXSFVmV1kybXA5?=
 =?utf-8?B?cjBVS3pybVhraE8xRW5lSTlRanZIaGdBYTVlTGdhbDF2bisrNmY0dGI2dXdT?=
 =?utf-8?B?dkh5L0RtNkc0L2pWZit5QzZLTnpheWNTYTlVUC94LzZMdWlTbzFwaFJuNVha?=
 =?utf-8?B?ZEpKMVp2T05lOVQwK0hPMVoreEplRGNMa1pxWUFVMmlXUXVvSStZNUVKOE11?=
 =?utf-8?B?enFuQ0UyTkJYQk1JbWpFM00zRS9sUWpiTWxMQzlFUVlpWHl0L2NwY0FvK3E3?=
 =?utf-8?B?MHdzMUMyblUxbUVWVW84VTdKd0pyRThTZ0Exd3VWbzZGZDlSc05NS0g3MVkr?=
 =?utf-8?B?ay96VldWbVovbDhFZFVtenRVcUtuZTUrdlVhS1FSVk1icVZwdmZFbFJKL1Ur?=
 =?utf-8?B?QmhDSDdQMTlmL2t1aE9GWjdqOFo1Z2VEUEhUcjFjRXlQcXFKZU9MQ1g0b1Ix?=
 =?utf-8?Q?lsATpa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi85TDhTUmxlREtrODJBdklYbmdtMklYeFR6M0lLWmtTOEFRdEtRczFqUHQ1?=
 =?utf-8?B?cGVlSGZreHpwYzdlWEdtSHNLa3pYUmVtdzNSN3p0ZGJWQXJ4OVVYLzBuMkhn?=
 =?utf-8?B?WGdpay9nNjc4RFNrVHI2ME16cGFmbEJSUE1EUVRjNlZoWFJRODBJM21jTmpM?=
 =?utf-8?B?dG9JRGJVMHdBdjZEK2xBcUVMUjVpdmhjcnorNzcvTUluVTVtTEV4bmNHMHVv?=
 =?utf-8?B?a0QwbUU4bjMrL0Ntb1FmTEgrSHJIY1g2MkdlWGpHSWJYMzFGdlcyL0VsRHV3?=
 =?utf-8?B?VXd1Rm5jd3B6QmZ1UzljdEQ2ajhRY3JESFZEcUp6Q2ZTNzI4WnN6aVR2TFR1?=
 =?utf-8?B?dXdNS2MyRjZGdm52c3cwYjcxMHZxUUFjdmtSbDRIZ0RvNkJhSjJHQ0xPZklW?=
 =?utf-8?B?ekwyZHhJQTh3SVpZTmIzNjlPWXRwRXRCU3U0NlJFRnNLM3g2d2FhVUp0MUtR?=
 =?utf-8?B?OVA1UTVDd2tEMVBTb0dRVGxoRVVtejhXMEc1Tko3QTJkWkk1S0d5SHd4cCtR?=
 =?utf-8?B?YW0yRldoLzJLK0hjYmZkSDUybDd5d29CUk5NYU15RlhhN2x1eVFtYmE0VjE5?=
 =?utf-8?B?R1dHNFV6Nnl5cWttdDRWNFdDaFFybDJuclNnSFpWdUo2dlVmUjJ4SXZybUhR?=
 =?utf-8?B?WnJRbVBBRDdSc1ExeStid3ZYQmVXUlJQdit1Z3NzdWZIT1hUbVpqbG9UN1V2?=
 =?utf-8?B?bVBmQTdzSjdncXFvbXNLVTBiRjNhSDRHMDRXKytOMVJBYzNVTUpqU1prcE0x?=
 =?utf-8?B?YWZtRStRS1ZwUXM5UXl3bmlnMlFScCtYdHFGWE83TTZMRUhnc0h4UXpXUmxl?=
 =?utf-8?B?SDRIdlkwRUpKZE85MFlvV1NuYjRyR1RHTVlkZCs2dDk4QlNwSlFXc3ltWERJ?=
 =?utf-8?B?UjVwY1hqWHY0THlSdE8wQkw1blZSek1PSUtNbmZ5MkZRbW84d1pERTc1NVpW?=
 =?utf-8?B?RTBMNGFjZHdkY005WEMxQTcxYllsc0l1YlRWaGhtMjQyTWp4dlFBMmpucURY?=
 =?utf-8?B?QUtiVUR0VnFrZG03M01abDB1dnRtMjZLQWpVVGdJN3BmaDhNd3dUdlNaaHpk?=
 =?utf-8?B?dzlvQTlUQUQ5RStoZEsrbXVVR2pSV3dHbGNCcHhhaEMxdm9RY0lDTFozTnU5?=
 =?utf-8?B?bkFiVHkvOGdaRGl6TmV3OWVHV1FRaVFTeXNtT0NDV1VCZFB2R2NKUHR3ZVhB?=
 =?utf-8?B?dzAzWFQ4SUgvbTJwR0xVK013MU9NbGdRVmF6K1FWQVU0U0krMWRmcXpUUXVY?=
 =?utf-8?B?aG5OL2NRcklEYUw1RkJiMUZHWnJadDdIdVVyTzFCOFJwaEM3WDNxRmZJZzJX?=
 =?utf-8?B?ZHZxK2owQm9zMVFnRys0M0FTYzJ0cm1RMkRIZHFIb0ErNFkxWUdFbzlGOTh2?=
 =?utf-8?B?VEFLZDVXMXZ6ZXo4cjk4TWRwNTJXM1RzZ3g0NEV3aUcwVXhjM3lzcWMvZ2FC?=
 =?utf-8?B?UWtNa3RNREhPN0JDKzdYYmJIME5CaThlRzgwb3JDRHVnZmthTDhUSEkwOWZt?=
 =?utf-8?B?TktmRFNiNGZjUjRrMXFWQXdoY2ZEelI0bGxYMHFucHlYeGNwdExuNmFMZzhG?=
 =?utf-8?B?bmhxWFUyOFRNaCtsVThJYmg2d0R6M3p5UXJWYzBJSEdXYk9SS2ltV3dhOGdq?=
 =?utf-8?B?Qnp0Wm9sOGIvZ25WRjd5SUdBbmFNMi96aXkwNEYyTE5ObmIzeEtEUUIrYVhX?=
 =?utf-8?B?YlIyQXVRU1pIZGVPSVBWaW5odHFTaldvMmEzQUorQkRPdmVUOGRsRGxOTmgy?=
 =?utf-8?B?YkxXOUFmb0c0WlhrSy9ORTYzWHZIV0VBUWJYS01GRmRaY0sya0VsMkU5U1ZT?=
 =?utf-8?B?ZmtRcFdTb1p4M2RyaEJyeG9PZDFQSnRqaXVQMVB1RFV1QzN0UEJMRGY2Z3hu?=
 =?utf-8?B?Y3RuVElJb3NHT2RWWjNDQzdteU9lamtrWXdNMGdJQzNLR0FqcFdqSysyeTFr?=
 =?utf-8?B?ZE5MWWlCVVR1UzlCTlRic3ltZytJWk5OLzZUZ3NHR0dXaGRjUUxIdDZ2VUhB?=
 =?utf-8?B?alhtQmNmVlBvWXZjNkVSRGNBOW1HTTQ3d1ZBVFF6WXBBZElYN3gzZlo3Y1Vx?=
 =?utf-8?B?c0pTWWh3OVNpN3gyV2Rxd3ZmNXNyYzl3aTQzbG54akRnaTdmYnEvREttTis4?=
 =?utf-8?Q?Tqr3MQwZbN64TJxlg3KwrCnW/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3370f19d-3371-47e3-5b5b-08ddfa7b92b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 08:31:20.5225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoP9NRS3ofEGlS/los2VO9fsoTFK7K+OYWu+npvxD7CjhBlGmu8viiuM5LqwcJh6T/KPQbNN1n0XkA3+IMbmBBulCVMaqxpBcd14yg5ZXW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6964
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDA4LzIxXSBody9h
cm0vYXN0Mjd4MDogQWRkIFNDVSBhbGlhcyBmb3IgU1NQDQo+IGFuZCBlbnN1cmUgY29ycmVjdCBk
ZXZpY2UgcmVhbGl6YXRpb24gb3JkZXINCj4gDQo+IE9uIDcvMTcvMjUgMDU6NDAsIEphbWluIExp
biB3cm90ZToNCj4gPiBBU1QyNzAwIGhhcyBhIHNpbmdsZSBTQ1UgaGFyZHdhcmUgYmxvY2ssIG1l
bW9yeS1tYXBwZWQgYXQNCj4gPiAweDEyQzAyMDAw4oCTMHgxMkMwM0ZGRiBmcm9tIHRoZSBwZXJz
cGVjdGl2ZSBvZiB0aGUgbWFpbiBDQTM1IHByb2Nlc3Nvcg0KPiA+IChQU1ApLiBUaGUgU1NQIGNv
cHJvY2Vzc29yIGFjY2Vzc2VzIHRoaXMgc2FtZSBTQ1UgYmxvY2sgYXQgYSBkaWZmZXJlbnQNCj4g
YWRkcmVzczogMHg3MkMwMjAwMOKAkzB4NzJDMDNGRkYuDQo+ID4NCj4gPiBUbyBzdXBwb3J0IHRo
aXMgc2hhcmVkIFNDVSBtb2RlbCwgdGhpcyBjb21taXQgaW50cm9kdWNlcw0KPiA+ICJzc3Auc2N1
X21yX2FsaWFzIiwgYSAiTWVtb3J5UmVnaW9uIiBhbGlhcyBvZiB0aGUgb3JpZ2luYWwgU0NVIHJl
Z2lvbg0KPiA+ICgicy0+c2N1LmlvbWVtIikuIFRoZSBhbGlhcyBpcyByZWFsaXplZCBkdXJpbmcg
U1NQIFNvQyBzZXR1cCBhbmQgbWFwcGVkIGludG8NCj4gdGhlIFNTUCdzIFNvQyBtZW1vcnkgbWFw
Lg0KPiA+DQo+ID4gQWRkaXRpb25hbGx5LCBiZWNhdXNlIHRoZSBTQ1UgbXVzdCBiZSByZWFsaXpl
ZCBiZWZvcmUgdGhlIFNTUCBjYW4NCj4gPiBjcmVhdGUgYW4gYWxpYXMgdG8gaXQsIHRoZSBkZXZp
Y2UgcmVhbGl6YXRpb24gb3JkZXIgaXMgZXhwbGljaXRseSBtYW5hZ2VkOg0KPiA+ICJhc3BlZWRf
c29jX2FzdDI3MDBfc3NwX3JlYWxpemUoKSIgaXMgaW52b2tlZCBhZnRlciB0aGUgU0NVIGlzIGlu
aXRpYWxpemVkLg0KPiA+DQo+ID4gVGhpcyBlbnN1cmVzIHRoYXQgUFNQIGFuZCBTU1AgYWNjZXNz
IGEgY29uc2lzdGVudCBTQ1Ugc3RhdGUsIGFzIGV4cGVjdGVkIGJ5DQo+IGhhcmR3YXJlLg0KPiAN
Cj4gVGhlIFNDVSBtb2RlbCBvZiB0aGUgbWFpbiBTb0MgY291bGQgYmUgcGFzc2VkIGFzIGEgbGlu
ayB0byB0aGUgY29wcm9jZXNzb3INCj4gbW9kZWxzLCBsaWtlIGRvbmUgZm9yIHRoZSB0aW1lciBt
b2RlbC4gQnV0IHRoZSBwcm9ibGVtIGlzIGVsc2V3aGVyZS4NCj4gSSB0aGluayB3ZSBuZWVkIHRv
IHJld29yayB0aGUgY29wcm9jZXNzb3IgbW9kZWxzLg0KPiANCj4gQ3VycmVudGx5LCBBc3BlZWQy
N3gwVFNQU29DU3RhdGUgYW5kIEFzcGVlZDI3eDBTU1BTb0NTdGF0ZSBpbmhlcml0IGZyb20NCj4g
QXNwZWVkU29DU3RhdGUgYW5kIGxvb2tpbmcgYXQgdGhlIGFzcGVlZF9zb2NfYXN0Mjd4MHt0LHN9
c3BfaW5pdCBoYW5kbGVycywgaXQNCj4gc2VlbXMgY2xlYXIgdGhhdCBBc3BlZWRTb0NTdGF0ZSBo
YXMgdG9vIG11Y2ggc3RhdGUuIFdlIG5lZWQgYSBzaW1wbGlmaWVkDQo+IHZlcnNpb24gb2YgQXNw
ZWVkU29DU3RhdGUgZm9yIHRoZSBjb3Byb2Nlc3NvcnMuDQo+IA0KPiBQbGVhc2UgcmV0aGluayB0
aGUgcHJvcG9zYWwgd2l0aCB0aGF0IGluIG1pbmQuDQo+IA0KVGhpcyByZXdvcmsgaXMgcXVpdGUg
bGFyZ2UuIFRvIG1ha2UgcmV2aWV3IGVhc2llciBhbmQgYXZvaWQgYW4gb3ZlcnNpemVkIHNlcmll
cywgSSBwbGFuIHRvIHNwbGl0IGl0IGludG8gMyBzZXBhcmF0ZSBwYXRjaCBzZXJpZXM6DQoNClNl
cmllcyBBDQoxLiBNb3ZlIHRoZSBib290IFJPTSBoZWxwZXIgZnJvbSBhc3BlZWQuYyB0byBhc3Bl
ZWRfc29jX2NvbW1vbi5jIGFuZCBkZWNsYXJlIGl0IGluIGFzcGVlZF9zb2MuaCwgc28gYWxsIEFT
UEVFRCBib2FyZHMgY2FuIHJldXNlIGl0Lg0KMi4gU3VwcG9ydCB2Ym9vdHJvbSB3aXRoIGNvcHJv
Y2Vzc29yLg0KDQpTZXJpZXMgQg0KMy4gTWlncmF0ZSBhbGwgQVNQRUVEIGNvcHJvY2Vzc29ycyAo
ZS5nLiBTU1AvVFNQKSB0byBhIGNvbW1vbiBBc3BlZWRDb3Byb2Nlc3NvclN0YXRlLg0KDQpTZXJp
ZXMgQw0KNC4gSW50cm9kdWNlIGFuIEZDIFNvQyBjbGFzcy4NCjUuIFJlZmFjdG9yIFNTUC9UU1Ag
dG8gc2hhcmUgY29tbW9uIGNvbnRyb2xsZXJzIChlLmcuIFNSQU0vU0NVKSB3aXRoIFBTUC4NCjYu
IEdhdGUgU1NQL1RTUCBDUFUgcG93ZXIgdmlhIHRoZSBTQ1UNCg0KVGhhbmtzLUphbWluDQoNCj4g
VGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNCg==

