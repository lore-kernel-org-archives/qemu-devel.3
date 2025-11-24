Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B60CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVzJ-0000QR-N7; Mon, 24 Nov 2025 07:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNVzH-0000O2-1c; Mon, 24 Nov 2025 07:48:11 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNVzF-0000Pg-H9; Mon, 24 Nov 2025 07:48:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VONBKrl+K/0svY4CYwQ8wwrB/yzJuC4M6fHYZuSBT0/DmNQwiol+7R/NHotYvCeWvlv9jV0NWW1pkTvfcWD9eUXZxzK2jMaEewRyRcnIUfSBBDBlUi2nK/C7vVhZilhqlFnQJgcSAs7mY4vHDj4TgLmdDk8hB9VaUMW0PHiGAtKseA7wsXNv7n4P73ACqjDxrJ/lEaUigCG5ruyzq6uMIrF6CFMEVvUoi9gIeMr0eX0aCAM1qCgFWwyPgksJohBr2rIcY63oCGa/kjsl2VfyuIIk23xU9QMevvQDNqWPVNypylaopGQ4P6G/9zfQir+upClyOyJhBGgOdTB4Rek/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5PvdCr3Bu+V7oqNUgwOjpzkBAf8b4y4bk57RuipH38=;
 b=AHW2HrVRu5NXfPb6WORhz1vRIJuhNkaKYoFYzjTYgnlqTnbfNoaR/tbigGoMyw9bkLRNSGQwkVE3WAbs32DSM0pbyJ/dMHS605RXBW7Qwfed9f7lWXHHEn2bGLtUKek1Ib3abrYA+0uZz1cECZS5h+Ofl+eI85gf3Err4vkdeJ3LviTZp8jJdycd+gmu7e9cMPUD7HVHhnKyn5x333NWa//foW+aDf4jM2EqMz8gzfUdNTeVxHVYpTzMIS6oH14JcN1IASHrkW36PBox+fAhczqUttnsDpBkZ9t/+m+O7bER4r0XJhJYahVfapRrPRcSD6gx4u9hKlvMBKIqyuWwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5PvdCr3Bu+V7oqNUgwOjpzkBAf8b4y4bk57RuipH38=;
 b=Ir7glz6VwJyStlnlsRaH+f92Ja1J8izIzmashlrE42OyKZPCYMXasir8nbGFuEtXIJzKe/nrSBQ4OyaEEllqbwfB8CFcYBBnkLn9zor6QaiTIAbNK6p52ozZu9dJiyRFB7J8foTIccmKdtXdyJrkRbCP3TXqNnOo/CxBI3VbSb1OEmmrMEuRK7J3C2i18mt1/Xdntt3pXFVzI7K+meuk5YqPl01k4KHfT+Pz142O7OZPEBY9k3j/3g6ROlpXshrl0sSjwXGWn2dMKvZKVe1N0oIYc5cQEn5n4m69rnWK33ANuKFeBo0301grhWx0fkOwkF/SKOAC+9lYyuJOhPimWQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Mon, 24 Nov
 2025 12:48:02 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:48:02 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 28/33] hw/arm/smmuv3-accel: Add support for ATS
Thread-Topic: [PATCH v6 28/33] hw/arm/smmuv3-accel: Add support for ATS
Thread-Index: AQHcWiGXgMdk81Jh30aNcJMZZFXvgLUBv50AgAAND+A=
Date: Mon, 24 Nov 2025 12:48:02 +0000
Message-ID: <CH3PR12MB75484F916587FBE2C7B403AEABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-29-skolothumtho@nvidia.com>
 <CABQgh9EuxEfHYOtMdCMBcaSqJZjzm2Q8Tz108jGcxcfTRpi3mA@mail.gmail.com>
In-Reply-To: <CABQgh9EuxEfHYOtMdCMBcaSqJZjzm2Q8Tz108jGcxcfTRpi3mA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BN7PPFFC4F04B28:EE_
x-ms-office365-filtering-correlation-id: 00273fec-c244-415e-b25b-08de2b57b492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WldqVFN2SHlnWGxUd2hTM1poRytrUUdDMVg4NElRbzZXRE9RcU5hL2I3VTl2?=
 =?utf-8?B?cG5RelZTYkY1R3d4aGtWNFYxVkVhMlF2QkxaYnRXbXRLK3V0dStLeStMV2Ry?=
 =?utf-8?B?ZHNZcnVqMlJvNmZndC9vVUxzUDFrSXVTUkN0NmdVWlhZVDlQZEx2U0sveXpE?=
 =?utf-8?B?R25vcVJKOUlrZk5ERlVXQTRPWjEzT1BEUjVSbGp3NnBkNW1oQlo1eDBnWFRh?=
 =?utf-8?B?Qjl4eW96dTZmajI1VVRGYUVqMGtEcWpLRXZiVXlBT09ESVYvQVdVTHhEY0NX?=
 =?utf-8?B?ZTJlVUprTjY3amRnaXdBRVJPNnFhT0tlV3hZc3k5WmJSUU9hc2FCWkw5VUlH?=
 =?utf-8?B?bHlWSTYwYlNsb3pJL1pJLzFSdXhzSUVCT3ZGQTFZQ0phdDdGTGdDZHlkcnVn?=
 =?utf-8?B?dkJjSjArdzJSSnZlZnU3dXJXZHNFZ2NlUEU2YUZOdlZxYlpPZWdqSVBhSXox?=
 =?utf-8?B?d1ZKNm5vbXBKZllZa3JVOVRkWWpXR0NCdWM2bDhXSTlIN0FvSGVTN1dUdjB6?=
 =?utf-8?B?RTg2SGMvUXdDbWxIMW5rV3NNbDRZTUtGdjJ3ZjBEcVY2c29ud25ueDdiYkdL?=
 =?utf-8?B?THM1VXArQ2dlV0lLdlg3bzNkM0lwVXpWbmFicUxDVFBpSlRtb05GUlRUelpH?=
 =?utf-8?B?YUR3VUdLNDNyaGtoUHp2Z2ZuMHdaQlpyaWpZdG51bytPL0I1QmJSS2wxS01v?=
 =?utf-8?B?M0RUSlNXY2gwSHkyU2lKQ1RsckJoYUF2UHFBbkpoZlJKclJMLzNxOVZ6V0NI?=
 =?utf-8?B?ZzlZZWZRYlRFTDVRSEpaOFB2N1cwWmFMU3ZCZjArVTZ1czA1bzRkekc5eHpM?=
 =?utf-8?B?L2liL2xPNUtaeUw4ZHpYeHdnTmxPcWx1c2lldTFaL3QzQkV0MncrTnNLTUFF?=
 =?utf-8?B?R01aaHRrZXBidXI5TXJjMzZDTStjSXBJTnVVeWJBa0Ezc2Jud2dzNXpROGZR?=
 =?utf-8?B?bSs4WWhoN3FRK3RvQXhhNUpNUk1CUElPaE1oSUFlSGpjWnNPTmViZkhxdzl3?=
 =?utf-8?B?bXh3b3JJMytUWjhEeVFUcUVYVGNCOGJWTU5PRVltc25LV0FGSlVPQUZQK3Bn?=
 =?utf-8?B?a1kvLzBtZjZYblpoUW9vMnBNOWVQaWlJNDFuNzhLRVRvbXozM3d1VTdXVHkv?=
 =?utf-8?B?NXRPMFJZQkxGdXJDUzZQS0xQNWJ0RDl5ZGN5UWhwejRIWFh0ZXJYdzNlK25v?=
 =?utf-8?B?OVhQMGozTE9ZUUIvc3lyWHdWaDJ6QytmVFFIbnpMNU02b3ovcDFYUEJRa2RP?=
 =?utf-8?B?ekxaRWpJTktqOUdrbUViZFR6R09LTml5Tm1vbTg0NkxabEdCU2JjdlcwVHQv?=
 =?utf-8?B?a1JWWktHdTdyNWw2NzM2M1hIcnNSS0dkV1VlT0pQQktpaTk3ZjNHY2oyWFQ1?=
 =?utf-8?B?NlYrTHlnNkEvcEZKSm03K1dNT1didzc5Wjh4WmhBbG91YS8rV1lBQjgxbXJw?=
 =?utf-8?B?ZWhEdmlMRHMrNHpRUDkrTmlTUm04b1l4cHZmNUpkNDlmNHdRcHQyRk5jQ1R2?=
 =?utf-8?B?SFp0c1k2REhuOWtsK29ZZFhBUlUraDQrYmJJNGlkWlIxdFAvWkhOSGRXRW5P?=
 =?utf-8?B?ZWNtSE84aFpXeDdoYTFBYXF1R1lOTHVIbC9pREl4V0tHY29aWW9YL3pJQm41?=
 =?utf-8?B?eVZnK1loNitaL21XMGg1WlBXUmhQTWZ6UWpQSC9id041RWJsbXVxRzJFYWFi?=
 =?utf-8?B?cnhnd2QyTjdHMHZaSGdNckxvVFFZcWlWOGJPMHFWRmlWNG94cnNMNHVseitu?=
 =?utf-8?B?U1djSjZ4ekZJVGR1MW1YL3dnaW9KT21HRzA0QkVVZDhmZFVGb0tEQkJuL3Fn?=
 =?utf-8?B?aUtRdmp5a05wK0x4bmdSZDV2QUovb0tYa2tUVm8yOTQva0pyQ0xCZXVsVHpI?=
 =?utf-8?B?M1pLZW9kNmt2V25JM0ZSeHNRZDVsVjFIRXNHVWJHRDhqbjcvQ2VUUEN5S3dG?=
 =?utf-8?B?Z25YdHVZZ0R2T2wwUlFwRkdkYVI2QlpDd0xJZ3BJV21mc2VVM21kZzVIcmJB?=
 =?utf-8?B?L29DUUFyOGN1RW5lRXhnOHMxUCtrVkJFUmhyME9FOSs2TDJuZG14MGNJbTB5?=
 =?utf-8?Q?AK1/9f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVQVWpqZFFmOUhSWDMyd3JWT0VVTU9rQTFjdVBzWWh4S1p0cmQyOTJqQ2ls?=
 =?utf-8?B?NDR3LzBNWVVGamcwV1F4d1FOWmZUR1VNUFJLYXN6bXJWcEpZUDIxem01UWNo?=
 =?utf-8?B?UjF1eWluZDcxTDFpQ3pncWhVd3BhWG8xYkJQQm5SQWpwK1grNXc3dEFnL1Rx?=
 =?utf-8?B?NnVPMkhWaHZ1bWJXZjJacjg2OWM4VFJ0NHBIaVN6b3B5SnZHbHFxdHJTRUl5?=
 =?utf-8?B?dGhzdlpLUWwreU5wU2N2eHIwNnAyZVFLQVNQZ2lSSnJ0cXpOdE1NNlA4aTZJ?=
 =?utf-8?B?ZUF1L3o2ekxGaHNhSUlhQkZ1Zm8yMzVIY1JnbXJHMi9sTUgzQjdySmpobzhD?=
 =?utf-8?B?R1htaThrWE9sY3ZOWkMxdE1VbVllWkxjQnVvS1hSOHBIK2U3cVJQRkYrNmM0?=
 =?utf-8?B?VWZnSzlEUkQ4Y09lRnN4VWdnTk9GSzQyYTFPbTVwd1JNUUJoVGV5WTlITEJX?=
 =?utf-8?B?Y1A4cURLYllIWkJrZ2toWUc5aU5la2xtUlRwOGhPOWlZMFZzZ0xXb2p6dkRr?=
 =?utf-8?B?d0Y2bmN5emdVKzhySlR4QWNJVE9FQzVXK1ozNmFpNklxTm1CTU5Pa1BpL2NR?=
 =?utf-8?B?dEgxdkpVS29rZzgraitPdkVPemVYSG1NYStkcmgzZjdJaGxsZ0lnalpvTitE?=
 =?utf-8?B?bWd0ZitNZFVKQ0F3YVZ3Uy9qbVFMNWdyWnBPSjFEWlYwZjZhNCszcG1pM2h0?=
 =?utf-8?B?aGkwU2t4VkQrZ2VaWHdNb2g2KzVjcGlkTzA1NWZjSkRvdUM4VGJ4NjltaTJ0?=
 =?utf-8?B?S0JLMWx1Ukh0S21jdW1SNE5QQzdkdFBoVFZ4R3RJRHJyam54aGc5T3Ztb1M4?=
 =?utf-8?B?S3Q3MVMxd1R5ODhGcHJ2VHZ1ODVxTURCanhydDJxV0R4K214elphWUF1dUZh?=
 =?utf-8?B?TjIybmpIa2FsS3FvMmxiNGs2R2w5QXY4OFM5YmdrWnl2cVdPKzRwc3d2QVhw?=
 =?utf-8?B?OFA0djRRaVNHMS9lZGpYV1NsdFNhdE5ZdGwzeDQvVmxpajZhVWUwYmpzU1By?=
 =?utf-8?B?bU4wL3QzQXozWGRRYjNpRUt5bWtkSVNLS2tYWGs2U2V4K1NqVlN1SUdQRkpi?=
 =?utf-8?B?Wi9iN0dvSy9rQWhsbXlNQU9heDVIVUVSS1JEZVFPQnQvZnU2Wlc4QlEzOTlI?=
 =?utf-8?B?RHZDVCtuR2dnZUdTZmhKR0JTTTdGME5YREVSNXFyRG5mL2xabitQM3VGM1Qz?=
 =?utf-8?B?dVEvczNJL29WcnJsc1BOR0JvOFlPQjJCb2tzQmZRM24zcHlLcWx1b21UOGxj?=
 =?utf-8?B?VXVYKzJGNHU0SjhaZWtNRmdHV3lUK0d1OXU2R0RkQmIzbjZ4Q29OU1kzR0hC?=
 =?utf-8?B?K0ZQV1Z0TitsM3pTbEhwQno0cmJnVXR0cUVsMGxGZEY5TGdpcUhUaEYvSUFS?=
 =?utf-8?B?ZE9RelBnUHpqc3lFRUtYU3JMU1VNU3V1dXR6R2JsRFZhQWpCcTRFdzh1OVYr?=
 =?utf-8?B?NEZUSE9IcTRiOGNEOGJYZ0Z6SHBBTDFpelRCZGZ2L2haUVJmcExUTUlCSitj?=
 =?utf-8?B?UFpLVks5QW9JQWdwdUNZaVczd0hzMFdYYnZGekFNK2s5TjJPN0Z4bUdEME5S?=
 =?utf-8?B?WmhpM3BONzEraThnRjNTN3NydXhLN1NGbzhDNFdtM01reTNYMUdjR1h3RXgy?=
 =?utf-8?B?V29jdW1nNVhoTHE3QXZiN1ZhVXpyVGtuSGtBYXNNc3prbHhhSnhTVmdRODkx?=
 =?utf-8?B?K1hHZG1WNTN4ZUtxdFdzUzd1b1JKYllZalRZcUZNaURsTkJ1YlBPQUFmMzB6?=
 =?utf-8?B?M3hLK1IydXc0YTArUzNkc1NiTE83bVdKZ3AwelBkSDNlVHFMNU50VDJROXFH?=
 =?utf-8?B?a0UraUVjS1Fma3J6MXl0aHFPRk5HeHRaQ1JycnFTc1ZrSUN2MEUyNWN4YkJQ?=
 =?utf-8?B?ZGVmREVFa1haSlROTTJZRllUZVh5ak9pUVJRZlIrNFhOTzUrT3ovd3luSXZ0?=
 =?utf-8?B?c3VQQ2lNRno0NHdsMWZpTkYrUk1ZeFl0VzZqRjBZZTdnRjdrM3VTOU1qUmt5?=
 =?utf-8?B?NytxeFB1QkxhNmpiSDQ3MDZBVCs0QVE0TytpSE41cStNNGRJTzhYS040RDZF?=
 =?utf-8?B?ZjhIaWIwNmNoZWxhK0J2Ump2WnUrTXgvSm0xVWE0aWgwL3BCM3FEZldNSlFo?=
 =?utf-8?Q?dUmj13xlmam2FzUR66zHygNk3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00273fec-c244-415e-b25b-08de2b57b492
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 12:48:02.4518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBjjF8R3ols6970hgyQDuumuRQs6sCgk1PGwb0WEQcNQgXhjUuRqE06gxKhsfAHcj8lBTMLa0vb9W2/zpAQEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMjQgTm92ZW1iZXIgMjAyNSAxMjowMQ0K
PiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IENjOiBx
ZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGVyaWMuYXVnZXJA
cmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUNCj4g
PGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1
dGlsZUByZWRoYXQuY29tOw0KPiBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0
aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0BudmlkaWEuY29tPjsgc21vc3Rh
ZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1
YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhlbnpob25nLmR1YW5A
aW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1
QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMjgvMzNdIGh3L2FybS9zbW11
djMtYWNjZWw6IEFkZCBzdXBwb3J0IGZvciBBVFMNCg0KDQo+ID4gICAgICAgICAgICAgIHNtbXV2
M19yYW5nZV9pbnZhbChicywgJmNtZCwgU01NVV9TVEFHRV8yKTsNCj4gPiAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gKyAgICAgICAgY2FzZSBTTU1VX0NNRF9BVENfSU5WOg0KPiA+ICsgICAgICAg
ICAgICBTTU1VRGV2aWNlICpzZGV2ID0gc21tdV9maW5kX3NkZXYoYnMsIENNRF9TSUQoJmNtZCkp
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgaWYgKCFzZGV2KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAg
aWYgKCFzbW11djNfYWNjZWxfaXNzdWVfaW52X2NtZChzLCAmY21kLCBzZGV2LCBlcnJwKSkgew0K
PiA+ICsgICAgICAgICAgICAgICAgY21kX2Vycm9yID0gU01NVV9DRVJST1JfSUxMOw0KPiA+ICsg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAg
ICAgYnJlYWs7DQo+IA0KPiBnb3QgYnVpbGQgZXJyb3IgaGVyZSwgbmVlZCB7IH0NCg0KWWVzLCBu
ZWVkIHRoZSBicmFjZXMuIFdpbGwgZml4Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQogDQo=

