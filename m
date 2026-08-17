Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948B4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 02:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvnKT-000419-Jn; Sun, 16 Aug 2026 22:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnKQ-00040y-IY
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:43:58 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnKO-0007sR-Th
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shW00leuo50zgKsuRF7omzDfzz2kWGzGXtG/vcFEQBWZHeedemRa6+YAFjLpEGzuMqLqAFuv+2WA2vQEgh3lGgxjPCtzFkSRfZW/njPUfCD5Q0t1swPlfmPZeFs6685FuXYfh+r/pG+hNeEB06OBz/R79h/AvaFouY6Ppt5zI/J9t1ZYj+9yp6Jsf/UwaXkgA/v1dRjJYQRzzYgzmAO1xoTFmbBNFrG6UfJ/gkAp0KoL/OFF/RguLu89IQ5wKCQE66XRtN+2Q/imieEebmZUquT47yufJy7OB9T9N6X6oFxsliOvAFA17dYQaKDgHuehnd7wLLxjleXS5ZBc5N7MFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAFA4FvsxBZL+93ks6TEQ/I7lbXUqu1omhb3pClagUI=;
 b=NzQUukGZxw4bhKq8ZMVy8+jyJa8D6vligUgX2PFR+2kAHolxfJAOIaAhaMw4c44RgHLkgS12ZFc1+BO2RqcpBsszJRi3RLrShBqVJYocS/tv/mgKDe9RSb4VI2poOBfqgi/qXHuHFzh5U2KMiuxRtg1uasjUPpXmhXtuPOOiTunTrqeV+SNfvAyyE6OJ9XHlwe0s4fORxwy79PcLHW20ZwliEGu3Q2YwIRKHOe4EcjF+9d1HmXNxMhRDJ5UBDiUdODR6c5t70CFVzhiVZr4LZ9YEhmKHnQAzBNxzQxU/7ie9PjP476Kj/Sw0EwwlkSp++rpnwiFbmuc8fOTH8xorbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAFA4FvsxBZL+93ks6TEQ/I7lbXUqu1omhb3pClagUI=;
 b=qOpDiE3p9gjSAY2Y4G8s1eUQSOJynNTwKee7Vh/2AAQZH8i16mIkYT6UfalF6vVhW/nbqOlZId4d7eQdbQBMu4U18DnKNIw7edC2qZaiaxoDL6p9olm1oXwTyyosZqxO2TeuVD7OZkT52eTNDrLv35lvNMLMz10fX3ha0g6htZRpSVOh2wzGGLCIA6HMAYRB5zFP9F+2NxqpTifDPgxNgMoPTnkXVTsf1yw610B7+roUZ+QKEM9/ZpteBE1paBX5eqpf18oxk2Ss5Z0uRC446/59YQhYrPzNDOAOLOgB+OeJtAflPl/5y+ZcDTLK/i4N+5T+lYgsQzi02kEJnjULdA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6160.apcprd06.prod.outlook.com (2603:1096:101:f3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:43:50 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:43:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "clg@redhat.com" <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Thread-Topic: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in
 async writeback
Thread-Index: AQHdKvSrYy6CS2yN20qVd8jbUP7gcbadQnmAgARGncA=
Date: Mon, 17 Aug 2026 02:43:50 +0000
Message-ID: <TYZPR06MB49809015E9700009F139DD71FCA72@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
 <CAFEAcA-kKC0WPU2Tqa8Oc9A-1H9LhVr5ibGrksBOc3ZNr54iMA@mail.gmail.com>
In-Reply-To: <CAFEAcA-kKC0WPU2Tqa8Oc9A-1H9LhVr5ibGrksBOc3ZNr54iMA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6160:EE_
x-ms-office365-filtering-correlation-id: 912a6491-e71c-4e75-a5b8-08defc095e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: sL2x/sjTQus9hBK6h3cmb0x2PFxqsrsFSLzdMHYOr3W3C8tCcmuXWGExzNl2qJ3D76k9iZs9Rmu9j3gwJFjbM+Wufyo4/lnShAD1Pb/2ha16qT7cXCnt7DGZjuhrtpR5gSTscQiWN2Jl/KwY5qDuy5sy0qPWUlQ9UOCPmyC2gk3oz6a14crNEl4ivri8KLlJP5DrKCdEi7P9m98qDk//f9re6pSAq+aqzVNaTJgWmxM9ct1mxvjfkzw+Hfy9ra+x+QIC3z+iP1q2Xz+Sl+A2QOrAqShgBTnxm8Ny632XBxYS8RYZcELb42Y0QwfqEghwL9C6f/EVe2DyQgztt6AdykEBVIpVXFNGmUa5BvxZxX5LmuJq+MguL2omndESIn9AMwga6jib0IkF+XkpM/lHCfN74aX7uz0eXQ/gfTELwCoT+32lfgZ3p+auNIs4x5YgTWf0ZkW/CUBlI4S1z/yJv2KoJ8+oS7SEW0psphRJ0eqnXDiUgFIzDBPGaFZWnWyNIq3csycSteajER5flL8HGvb+ogkqNzB9IpCohRuLFvfNJCHjC9DDHT7PhrWJY2UkQszSKOTZmC+t0ZsSbOE4zAIfTGpp6WWMwQG2MrIdlX+w9XSVmaPIorOpQDmG6nBpYzcQlyLK1M3A2HMmaUc/xesvQhtYCU5funmiQBXlHYM3AV6hNu6OCAfG2J2FDR0P2sTWko3DTNkKIQkYvAJkPCJTaVhXklG+EH0N7rxN+BM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkM1dUtveGNMN3FSRExydXNLc0d5Z2FFRmR5ZUN3V0RtUDBjYUFocUdiSVdD?=
 =?utf-8?B?MXREQnlLTVIzd1R3bmlDZ1E5SVowa1pNSWpNeW5Pa0dycmxGSDBwdHpDR0Ru?=
 =?utf-8?B?NHlsS3d1bXA4VmNTYWpaS0pJS2FlaTZ0VFNDTmRmV1dhUHNMT1c0cS9Rc3d2?=
 =?utf-8?B?VHpMQ1B1ZVgvTDM2NWpxTFZLTVY4eW5qa2RoT3N5Ris2ZWJsNFRLOWdCZ21m?=
 =?utf-8?B?M20wR3VHa1pLUk1KYkVRNjA2cC9Ma291Z0IvbUd1N0pwWXZCTmF6QjV1cUh6?=
 =?utf-8?B?SHVvajlFejhFQjB0MXR1eEltSHFXc0kzeEJscW1jTHdUSmtQKytPakxEK0Z0?=
 =?utf-8?B?VmlHR2c4ZmdidG5JRW9qTjdQOStIMlZmeWZ4T2s1d21YQ21Penc3Zk5YRmNn?=
 =?utf-8?B?ZTRkRkJZL1VMNFhVaDhXVGtKVm8wZ0toNEw2VUVZcG90NzJFOWl2UDREWnFM?=
 =?utf-8?B?ZEE3VUcrYXo2bDBDVUFGWGpVYzFPM244NTlTb0ZYQTYwcnRGN3lCWDZOeWx0?=
 =?utf-8?B?VlF1Uk9sUlhYcEhPaXBLNkpVbEU4TXJnVXc3Uy9HREUyWWNwNWFiS1IrU0dW?=
 =?utf-8?B?MHY5Y3UyYlB5azZ1MmlOSGhlakpUNUp4cXd1NEUwcGtXY1NnZ3NTVGlidVJ4?=
 =?utf-8?B?QnNBVk9pOTFHaHdlQXo1dVNBUGhFM0JwVXNzNGM2NFZRVkZVTlZUOU5MYUky?=
 =?utf-8?B?QTBqYlBkZm5yeHlJME1pUFZIamlQTnhzcU8wVTF2clZoVURuYmJsSHBiTlpX?=
 =?utf-8?B?Y1JrL1hhRUl5czc5aE5PREVyenNkSFNZUkJuMkN4NGppVDNzeGxSRTZnM1k3?=
 =?utf-8?B?LzhaeWg3YUFNdWFVZE1NdnZrdHVuak5WdDI2Um80ck5DcGQ1SWNNL3RXNEJZ?=
 =?utf-8?B?TmRBR0hKZUh3eEtMMm0vV1VjWXRGRVVTRmhQd1h1d1dvSFpjYTJmcVZ2b1B3?=
 =?utf-8?B?WEUwN3VDUGhmL0xXLzZmcXRaUkUxOSsrUXd3dkQ4b0VSUGxCL1AzYmRqT1hZ?=
 =?utf-8?B?b0NsQTYzMFYzdmlYYTJONnJTOHFiYlFGMmZ6aWNBMFJJc3FpbnJGTjZ6OEtG?=
 =?utf-8?B?bWIyWGRmTGRwWExldEdNdHZwaDZmRWJqNkdJQ1FnZEFhRS9haEFqekcxRUlR?=
 =?utf-8?B?TUhISk14OVhUZi83anhjTFQvN0YyUDNKSTJxbjRtZzdwd0JRSms1aW8vTEYr?=
 =?utf-8?B?YjMrQVY0S0NvNHR3V01CQ2dhNDB5aWRQMGVJZWRzWGhCVlFXUEpITnY0ejdl?=
 =?utf-8?B?ZVlxUDdFQStkMUo2aU9iNEoyM0dGSjFNdTZBRHdUcElxRDQyMHlNdzRYZGox?=
 =?utf-8?B?YlRZZmtUdVl1M25vUHNad3dYSkI2MXhpRlVESnhmN0ViWm9qNk5hRDRUZnRz?=
 =?utf-8?B?Z2ZlVE1JbGVUV3kzbHFRTUcrbHhpVk5oTkJYZGxvalMrbllwc0x3MG9GbU5Y?=
 =?utf-8?B?N3lNVU9ibnQ2Y1RHVUxCdWhJM3JsRk9kU29iclI2VkVzWEJmM2dkY2xwam5O?=
 =?utf-8?B?SmRpVUxxNnUwUW9Ma2xQUU0zOFB4SjJZUDNlcEZnL3pBeG1lLzZpcWtwZ2dl?=
 =?utf-8?B?NGpBQzQwK1JnUHF4MFhyand3VnNaUGFoS0hqTWhXRlBMUWZ6MDVCRFJDRURm?=
 =?utf-8?B?bE1KdkRTenJTQUhtRmZld2Rsak8zYXRuTFJhNzVaYTBnSHhYMVBIdDdsMXRX?=
 =?utf-8?B?Wk44WGdIV2JiMUp1VVFrRlVGajh0U2RLR0gwUy9KSW1ma0JFekFxZDVyMktk?=
 =?utf-8?B?bENPY1FnWXIwa3BpVDh0QVNzWlpneUpDdG1hSFVBZ2lEUjhLWlNseVBtR1pX?=
 =?utf-8?B?bkVqRHQ2OTZXYzBUTTIyUnNjTjZVc3BpQWp2WFF3Sm9xVlBqSzdseUVYTCts?=
 =?utf-8?B?RHo4ZTI0Zmo2V1VweHNmQXRsVHlFcURKK0F6VTFvenVReEtLTHdlUStNYk5k?=
 =?utf-8?B?REY3aTdVS0xuQnlQQzlyQkZRaTJGUm1oSHBXTm9DeUZSNGlxS2VibDZ2Ylln?=
 =?utf-8?B?L0o3U1BscDU4RzJKbFZLRnVUNjNjc3lLcWk0Ym4vZEFjZy9SMVFKeWtCMGFm?=
 =?utf-8?B?ZDFmUHdQR3NjYWJYbzBiSnRKR20zVXJjWFM5TGlGallUZXlUMlRjNWl5Q0tY?=
 =?utf-8?B?SlBGUGViWXBVMjBaMEkzQ3lrQ09iOHNqd0RQNENxdU5Lb0lmTmFONDZyK3JI?=
 =?utf-8?B?L25DekVlSllub2JGd1B4WmhXNFVNRXZRRURoYk9qdXIxZXZwYlVvSitaQ21P?=
 =?utf-8?B?bUh0bUMvVmdmaXZUdkNnYTE1YUE0Zkd4R0o1dnR0ZzFDMjhIeHlJUGJsN29q?=
 =?utf-8?B?TC9Tc2pNUDFZT1lCYjF1bVZYVlRUWWtvVElld2xjV3krOVl2U1Z5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912a6491-e71c-4e75-a5b8-08defc095e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 02:43:50.4930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OgV/u4XRL/HklMpYaOrRsOcNSJdw+V8I2DzpLk9uYNC3pSbH7Q5L6MdBQb5tdF5JKJX9FmIlOGfOmdAc78bzDT8irW5BcwLr/AqAhr1TrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6160
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgUGV0ZXIsDQoNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hjZC1laGNpLmMgYi9ody91c2Iv
aGNkLWVoY2kuYyBpbmRleA0KPiA+IDQ1MWE5MThlOWYuLmQ0Mzk1MTk3NWEgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvdXNiL2hjZC1laGNpLmMNCj4gPiArKysgYi9ody91c2IvaGNkLWVoY2kuYw0KPiA+
IEBAIC01MzMsMTEgKzUzMywxMSBAQCBzdGF0aWMgdm9pZA0KPiBlaGNpX3dyaXRlYmFja19hc3lu
Y19jb21wbGV0ZV9wYWNrZXQoRUhDSVBhY2tldCAqcCkNCj4gPiAgICAgIC8qIFZlcmlmeSB0aGUg
cWggKyBxdGQsIGxpa2Ugd2UgZG8gd2hlbiBnb2luZyB0aHJvdWdoIGZldGNocWggJg0KPiBmZXRj
aHF0ZCAqLw0KPiA+ICAgICAgbWVtc2V0KCZxaCwgMCwgc2l6ZW9mKHFoKSk7DQo+ID4gICAgICBt
ZW1zZXQoJnF0ZCwgMCwgc2l6ZW9mKHF0ZCkpOw0KPiA+IC0gICAgZ2V0X2R3b3JkcyhxLT5laGNp
LCBOTFBUUl9HRVQocS0+cWhhZGRyKSwNCj4gPiAtICAgICAgICAgICAgICAgKHVpbnQzMl90ICop
ICZxaCwgZWhjaV9xaF9kd29yZHMocS0+ZWhjaSkpOw0KPiA+IC0gICAgZ2V0X2R3b3JkcyhxLT5l
aGNpLCBOTFBUUl9HRVQocS0+cXRkYWRkciksDQo+ID4gLSAgICAgICAgICAgICAgICh1aW50MzJf
dCAqKSAmcXRkLCBlaGNpX3F0ZF9kd29yZHMocS0+ZWhjaSkpOw0KPiA+IC0gICAgaWYgKCFlaGNp
X3ZlcmlmeV9xaChxLCAmcWgpIHx8ICFlaGNpX3ZlcmlmeV9xdGQocCwgJnF0ZCkpIHsNCj4gPiAr
ICAgIGlmIChnZXRfZHdvcmRzKHEtPmVoY2ksIE5MUFRSX0dFVChxLT5xaGFkZHIpLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgKHVpbnQzMl90ICopICZxaCwgZWhjaV9xaF9kd29yZHMocS0+ZWhj
aSkpIDwgMCB8fA0KPiA+ICsgICAgICAgIGdldF9kd29yZHMocS0+ZWhjaSwgTkxQVFJfR0VUKHEt
PnF0ZGFkZHIpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgKHVpbnQzMl90ICopICZxdGQsIGVo
Y2lfcXRkX2R3b3JkcyhxLT5laGNpKSkgPCAwIHx8DQo+ID4gKyAgICAgICAgIWVoY2lfdmVyaWZ5
X3FoKHEsICZxaCkgfHwgIWVoY2lfdmVyaWZ5X3F0ZChwLCAmcXRkKSkgew0KPiA+ICAgICAgICAg
IHAtPmFzeW5jID0gRUhDSV9BU1lOQ19JTklUSUFMSVpFRDsNCj4gPiAgICAgICAgICBlaGNpX2Zy
ZWVfcGFja2V0KHApOw0KPiA+ICAgICAgICAgIHJldHVybjsNCj4gDQo+IExvb2tpbmcgYXQgdGhl
IGNvdmVyaXR5IHJlcG9ydCwgbXkgcXVlc3Rpb24gaXMgd2hldGhlciBlY2hpLT5hcyBjYW4gZXZl
cg0KPiBhY3R1YWxseSBiZSBOVUxMLiBUaGlzIGlzIHRoZSBhZGRyZXNzIHNwYWNlIHdlIHVzZSB0
byBkbyBETUEsIHNvIGl0IGZlZWxzIGxpa2UNCj4gZXZlcnkgRUhDSSBkZXZpY2UgbXVzdCBzZXQg
dGhhdCB1cCBzb21laG93LiBlaGNpX3N5c2J1c19pbml0KCkgZG9lcy4gU28gZG9lcw0KPiB1c2Jf
ZWhjaV9wY2lfcmVhbGl6ZSgpLg0KPiB1c2JfZWhjaV9wY2lfd3JpdGVfY29uZmlnKCkgY2FuIGNo
YW5nZSBpdCwgYnV0IG5ldmVyIHRvIE5VTEwuDQo+IA0KPiBJZiBlY2hpLT5hcyBpcyBhbHdheXMg
bm9uLU5VTEwgdGhlbiB3ZSBjb3VsZCBjaGFuZ2UgZ2V0X2R3b3JkcygpIGFuZA0KPiBwdXRfZHdv
cmRzKCkgdG8gcmV0dXJuICJ2b2lkIi4NCj4gDQo+IEFsdGVybmF0aXZlbHksIG1heWJlIGdldF9k
d29yZHMoKSBhbmQgcHV0X2R3b3JkcygpIHNob3VsZCBiZSBjaGVja2luZyB0aGUNCj4gcmV0dXJu
IHZhbHVlIGZyb20gZG1hX21lbW9yeV93cml0ZSgpIGFuZA0KPiBkbWFfbWVtb3J5X3JlYWQoKSBz
byB0aGF0IHRoZXkgZmFpbCBpZiB0aGUgRE1BIGZhaWxzLi4uDQo+IA0KDQpUaGFua3MgZm9yIHRo
ZSByZXZpZXcgYW5kIHRoZSBzdWdnZXN0aW9uLg0KDQpJIGhhdmUgc2VudCBhIHYyIHRoYXQgZHJv
cHMgdGhlIGRlYWQgTlVMTCBjaGVjaywgY2hlY2tzIHRoZSBNZW1UeFJlc3VsdA0Kb2YgZG1hX21l
bW9yeV9yZWFkKCkvZG1hX21lbW9yeV93cml0ZSgpIGluc3RlYWQsIGFuZCBtYWtlcyBwdXRfZHdv
cmRzKCkNCnJldHVybiB2b2lkIHNpbmNlIG5vIGNhbGxlciBjYW4gYWN0IG9uIGEgZmFpbGVkIHdy
aXRlYmFjay4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2
ZWwvbGlzdC8/c2VyaWVzPTExNDY4OTkgDQoNClRoYW5rcywNCkphbWluDQoNCj4gLS0gUE1NDQo=

