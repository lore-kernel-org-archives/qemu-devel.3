Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102FCCDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbiFj-0001YW-FN; Mon, 22 Jun 2026 13:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wbiFe-0001Xl-SB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:16:03 -0400
Received: from mail-westcentralusazon11010009.outbound.protection.outlook.com
 ([40.93.198.9] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wbiFd-0007oL-00
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQrwY1Nqq32EUjUmOFhnxKKHZLwh45W2aSnHgYQ4X9tTn63DUMABXnvxOseLvq/tnN/8HDGM6XsmgigswteqpPqhv11YaFHzqJj0yws+En2Lt/F1Z/3Qg9cdT7wRhORYDzf85EerH6ROigOvwBjp7xbe/sdvgnkp6n0YdtXBPSCVAgd8eZ/jckmv7MHJ+95DIu6PapkZczz+VB3rnNsHYxat4ilFaAKRBEy+Pekg945YmHEFc/MMVV/h8Q5w9z7sqGqCNMCvhMRjeqqiBhky39VRO1vBriKylfv6cm0x1UPNO97Qrw6/Eqi8yHwFJ0+Fnvdu63sS6sUlJYdf2Q79Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3o0lTsHAw7ZuL3WHXei+JVCIx0tnTCVenAP7KFFM1U=;
 b=FXclYY3KvlkyvMmpFVzjCCFJ7J4GZNdCvA1ogj3A7eoy50OhMxl1K3tF7Xnquz6RTWYiWOc838f65FzgQEUcFNhnKEMWetLvDexbvpSZbTDlubbWQPxWjz5o94brU05MouT98jQgAzfdb2ZqhSo06SBGMaAdqCvNTHngOXv4Zztsqb1mDCD5NpXPN5bQ9wOVcZklHSPxm7MgBNj3yIIzbMNJoC5Cz//m54+oai8xFkMNmoSu3zvWhG/6IKFefb9vniRJNEMSbW6apk6Z4mdjHJ3kR5iwzHMpIMyvu5MQtpsBlD97D000c43TCa/phsN2C9fs3dcfdoveFsQHQKTl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3o0lTsHAw7ZuL3WHXei+JVCIx0tnTCVenAP7KFFM1U=;
 b=uERsj5x3R0eOQHZaHFOgLxnTeJpqfq0H1sacmO8D7hE4DXeA1k2KkT734g/hCXE/o0W4gBuGY09T5gHK8Zvnx5PKnWmNS2hKf1BbFuO7NVtIrB4saugEGAoRkepu3EPreKTooUrf4uA8al1rU+4QLKLLjzzcU0yOzsDNJrPRipGg115v8dQTxHBlgLlpEKNGsG9PXe2QFhCu7Fgm6UA88e4Uc9nZUKKTSoucoHrMK+rvRDcBUrcw4c3sPRVTwx9IafWaZmeDbedhpsMGNx7sbegZUB4LHpsG7j96hemDHX/+KyvEd2Q56LtFQQUQpgnjfjBpCGXZLB3ARR1jMFYwNQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 17:10:54 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:10:53 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PULL 32/61] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Thread-Topic: [PULL 32/61] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
Thread-Index: AQHc/cTIsccuraRpA0mEfH0XsvxfYLZKu+YAgAAcCPA=
Date: Mon, 22 Jun 2026 17:10:53 +0000
Message-ID: <SJ0PR12MB86140B812C74AE808CCB604EABEF2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
 <20260616190639.3462006-33-peter.maydell@linaro.org>
 <CAFEAcA8pxFUnqAxa-ngjQ2ALDkJ-cjXsA66HgfisvRU_sMiwCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8pxFUnqAxa-ngjQ2ALDkJ-cjXsA66HgfisvRU_sMiwCQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|IA1PR12MB8467:EE_
x-ms-office365-filtering-correlation-id: 55a74c99-173c-4c96-6d85-08ded0813790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: 7Jpf1v7jm0sgBGlgEB9iHOsqH5ZkRhvQNyG7I0I4zgo9J4ou18yoVTgkASeibYvI53B7N5mPoxHLMq0CiCgbk8h4dKAWrxRCrmlss3S2xvxxPYRboekb2wjAnEFPnb9rOXKhGluvcCbw52bgco5JEWXnmy/hkFhJD39NMdPhjDsTaUS3HofxYjijWR+utkOVHq7XI2llIfBNG9yuY16ZRoWKV9KrIXYzspSl1L89JZEF4uK2bftzvtbKiDPBvU/mzcReDrsIvvojMk4fgNU9zHRzu1OzMf09caBbjXur5TKMtO4uO9dx+PMakgE2AgczFjQTDwics8EZD/s5GuagiGtjfGj48D8VDw2yVleQwNol7R28qCXh+lhi7XAkGUwfjauKbKftnDiAQUTR8lIBWYqvQ+WXmymNxxJChrRaKRteIt1RB7rNO+u/sSrl4/X3wy3pvoAUqeTy/kgci+/Cyn7bptNd2vTgjB2fUyhhNUXbCi/iWfT05V5sJDqMUNy7qNHvyTBErnHic/PDSVW4mhCQ71cpKQEHelk0tp2W8lbNtNHUYVbBavTvrkcU1EMBsSZfku/IIoteGkjjdB5qEYYkD/P/EoceAAxLJcFiY74I/8s3K88xkVkSJ6Rc/pmSSRETA7G94zykmy3Zv4KtTvNS/vRrPIRe9RQRnq3zpH6o+LAz9fa4Ku5fa83FomWNGTFI4eMKoF3Ly5D0huunuTN6EXgjil0/ILEo8tqfS2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU4wOFo4NDluditVS0o4MDF4bDI4cFQ3cHgvRmM2a0piL0RueEJSMFpINWtM?=
 =?utf-8?B?Y1ROZEtYN2crWmpLczhraTZVNmg1TVVnSTJEVHpWak5PK0tFTTJwRWM4dkdD?=
 =?utf-8?B?U2hhV24rYTh6T1JSem9LK0xtT094Uk9lV3BESU42VnhnaXhrSGIvY2JmUUd6?=
 =?utf-8?B?eWNKVEJtejQrNGQyK2V6ODE5N2FIWlFieENiY3hpY0V4RVZwaDYrL1FhNXdz?=
 =?utf-8?B?bEdUS09ucSsrclJ3dWg3OVNtWjArUWdibkd4a0wrb01pYmNjM3V2elZWMUxv?=
 =?utf-8?B?TXJtNVdsZC9SVnZDQURkcUg4akU2UjhYQVovcjhMclpIUG5paUFuNEprbWhC?=
 =?utf-8?B?Ty9xeWc3NWlpbDRjMitBdXFqM1h2Zm5oNUswaVpVaGhzZjRVblhaWkI1QU1P?=
 =?utf-8?B?MUZnTUlBNy81bVJEbGx4c2g4Y3R6T3c3cEtDMWgzbHpsQ1o4ZXdUd2g1Wk5I?=
 =?utf-8?B?bnJKbXNoY2xNZ0F5MVM5L3dIMkVaWlhwSk1NOXNQREtqRkxoS0ZOVmlIVS9F?=
 =?utf-8?B?d3dkeVBGYUI3Mm5ZWkxEdTAyek9xTGw5cUNQVmVueFdtU2RQMTE0eTdDZ1Bq?=
 =?utf-8?B?RzF5WXBsbjhiaTcyd2tJQnIvcGYzQmJCR29NaUIwVXYvc3l0KzhTME5OcDZ0?=
 =?utf-8?B?bmdQSXRXWlk5c251TTlFRGJkZmJzNm0xM241NFV6eENnbTF3QW11RFVOSUtm?=
 =?utf-8?B?K2U4SnJqZXZ1UU5BcnplblQybmhPdTJWM0daV2VoMVVGSThHU05yUmNDQmFj?=
 =?utf-8?B?QUd5QXlGeEt6dkxXemtHTG8wOEE0QkhseGhJOVpwcndieVlpWW45bGRFRDJn?=
 =?utf-8?B?U0p1SjFERnoxMWxydCtmTStqNXVlaFFBcTdOMEltV2RReHp2enhTN1BmUTR6?=
 =?utf-8?B?QnZnWlFycVZQTFBjZ3VvUi9kblpWeDFLc3dxQlZHWDVtNkRzSkdZeHd1VXBu?=
 =?utf-8?B?U3VKOS9UVDVYSjY1YWlKMjV0S1V2dnRSVXZyTGJOUnI2ZzZpdkpXL2M1UkRl?=
 =?utf-8?B?d21LMlErWi8wOEFTeHBkSGdjVmZQK3I4V01zVnpkaGJlODJVWEJCam9ZSHd5?=
 =?utf-8?B?aWNPMnBHUG00YVdEbzlnZnBUY2dwcUd3SnFHMGhvNy9tV2U0TWNvWHJWYkRr?=
 =?utf-8?B?RGV4TVhxN21FUWJCY2VMYTFzTlErK1c2dHljajhBVExmZXF1QzhTNGVrL3FO?=
 =?utf-8?B?bEdSRlprdnNrT0M0YVc1aUl0eGhFbkhmbkN4TnpHWnlQYkMzVDRraFZFWUtL?=
 =?utf-8?B?RklBOWRGMlZ5UTRLb0w1Q3BpM2ljYiszWmdxRTloQTAxUGRPaG1vVWxxSWtw?=
 =?utf-8?B?Q0hNT2ZGYVNocEJGKzZrQlYvM3ZRSUQyUE5jK2Y5OWpWTFp6cGNCQ2t0UVNn?=
 =?utf-8?B?NHJqam43SDg1aEVoVlBVM1RIMHJ2cTBTZGZkNlNFYm9jblArdDNlUjRiYVhz?=
 =?utf-8?B?UWVGbkhIKzgyWTVYVEZXRkVOdTNERkcyOEVDa0pLR3ZRVXpjVEIvUHhWWUNs?=
 =?utf-8?B?TWVYeDEwKzExV2FWb0JLeTVzZWFIYnpMWHF6V0VvM3Ruays3WkUxWGtQVENK?=
 =?utf-8?B?bEhXWjhmSUI5WndEeEpJUzdKa0VITDlVbjBUV1dmNjJlUWUvUzFmWUJQSVhi?=
 =?utf-8?B?dTJ2MXNzTW9YMWFtV0F3cGJOUmE4elU4SVlQZEd3Q0NXZGxGRmtxT1gwNldR?=
 =?utf-8?B?QWFlYlhhc0NCbEVSOVp2VjVaZCtLaklZR20vK0loWEIyN0VnYk50OEVPUW1r?=
 =?utf-8?B?Tk9LSHhSTlZ1OGVOd3F2ekxpRWd3ZDFVN1ZaSERRbGlFbmJZR21mQVVKazFu?=
 =?utf-8?B?OFpCWHM2NGZCeUpGWGVYOEx5WDRSN25DYk1lMFpvSFRLNmVRZVhuNnZDR0tQ?=
 =?utf-8?B?NndEcmpsbkh1RHh3cXp2clBNZ0U3UmhxLzg4U0drM2ZTZy9hT0N2c0c2NEdi?=
 =?utf-8?B?dWNsV2VjNFhsUmVRSHlQdWhlNmlIb1FyL2poTS9FV3kvSW9hYWlMOXd3VXlJ?=
 =?utf-8?B?eFNCUExUNmxLVEZmNktueXV1YkdOZlNXK3JvbXBIMDFGN3JmQk1kUmNCY0p2?=
 =?utf-8?B?dy9uUDdqbHZwN29QNjJTMGZkc1BjakswYUkzUk5sQXovdVRWdjlFZzh1ZzZw?=
 =?utf-8?B?Zlh5WW42YWVyZmcxd0d5L0NYcFp5VDdueTRyUDJXRkFWMkViVXhBWmxLVDU2?=
 =?utf-8?B?d0ROWXltQWpNc0E4UzBlNzc5d0pIUW5UYkpzQlIrWjNRTlVHRHNmNCtrTklD?=
 =?utf-8?B?UUJpekZ4aklUVnlUelVINGF6ell3R0RVbGlXbCtEK1FzUU1YNjFGU0FCcStU?=
 =?utf-8?B?VHQvanhYejQrRnMvZEdjN3AxdFFVYjc5eTNhR0RvTW5WYWxHTjh5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a74c99-173c-4c96-6d85-08ded0813790
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 17:10:53.4394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQO92T4TlDo0/qLPGP6YHYDLAfY2RLUZdnPL/gBGj98nLwcqqH+pptVSEjsxpGL0iRsxxqhBxFSusn+pDuiHGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
Received-SPF: permerror client-ip=40.93.198.9;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMiBKdW5lIDIwMjYgMTY6MjgNCj4g
VG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8
c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4NCj4gPG5pY29saW5jQG52aWRp
YS5jb20+OyBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUFVMTCAzMi82MV0gaHcvYXJtL3NtbXV2My1hY2NlbDogSW50cm9kdWNlIGNvbW1vbiBoZWxw
ZXINCj4gZm9yIHZldmVudHEgcmVhZA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9u
IG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiBUdWUsIDE2IEp1biAy
MDI2IGF0IDIwOjA3LCBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52
aWRpYS5jb20+DQo+ID4NCj4gPiBNb3ZlIHRoZSB2RVZFTlRRIHJlYWQgYW5kIHZhbGlkYXRpb24g
bG9naWMgaW50byBhIGNvbW1vbiBoZWxwZXINCj4gPiBzbW11djNfYWNjZWxfZXZlbnRfcmVhZF92
YWxpZGF0ZSgpLiBUaGUgaGVscGVyIHBlcmZvcm1zIHRoZSByZWFkKCksDQo+ID4gY2hlY2tzIGZv
ciBvdmVyZmxvdyBhbmQgc2hvcnQgcmVhZHMsIHZhbGlkYXRlcyB0aGUgc2VxdWVuY2UgbnVtYmVy
LA0KPiA+IGFuZCB1cGRhdGVzIHRoZSBzZXF1ZW5jZSBzdGF0ZS4NCj4gPg0KPiA+IFRoaXMgaGVs
cGVyIGNhbiBiZSByZXVzZWQgZm9yIFRlZ3JhMjQxIENNRFFWIHZFVkVOVFEgc3VwcG9ydCBpbiBh
DQo+ID4gc3Vic2VxdWVudCBwYXRjaC4NCj4gPg0KPiA+IEVycm9yIGhhbmRsaW5nIGlzIHNsaWdo
dGx5IGFkanVzdGVkOiBpbnN0ZWFkIG9mIHJlcG9ydGluZyBlcnJvcnMNCj4gPiBkaXJlY3RseSBp
biB0aGUgcmVhZCBoYW5kbGVyLCB0aGUgaGVscGVyIG5vdyByZXR1cm5zIGVycm9ycyB2aWENCj4g
PiBFcnJvciAqKi4gU2VxdWVuY2UgZ2FwcyBhcmUgcmVwb3J0ZWQgYXMgd2FybmluZ3MuDQo+IA0K
PiBIaTsgQ292ZXJpdHkgc3BvdHMgd2hhdCBsb29rcyBsaWtlIGFuIGVycm9yIGhlcmUgKENJRCAx
NjYwMDU3KTsNCj4gY291bGQgeW91IGhhdmUgYSBsb29rIGFuZCBzZW5kIGEgZml4LCBwbGVhc2U/
DQo+IA0KPiA+IFJldmlld2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+
DQo+IA0KPiA+ICtib29sIHNtbXV2M19hY2NlbF9ldmVudF9yZWFkX3ZhbGlkYXRlKElPTU1VRkRW
ZXZlbnRxICp2ZXZlbnRxLA0KPiB1aW50MzJfdCB0eXBlLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmJ1Ziwgc2l6ZV90IHNpemUsIEVycm9yICoqZXJy
cCkNCj4gPiArew0KPiA+ICsgICAgdWludDMyX3QgbGFzdF9zZXEgPSB2ZXZlbnRxLT5sYXN0X2V2
ZW50X3NlcTsNCj4gPiArICAgIHVpbnQzMl90IGlkID0gdmV2ZW50cS0+dmV2ZW50cV9pZDsNCj4g
PiArICAgIHN0cnVjdCBpb21tdWZkX3ZldmVudF9oZWFkZXIgKmhkcjsNCj4gPiArICAgIHNzaXpl
X3QgYnl0ZXM7DQo+ID4gKw0KPiA+ICsgICAgYnl0ZXMgPSByZWFkKHZldmVudHEtPnZldmVudHFf
ZmQsIGJ1Ziwgc2l6ZSk7DQo+ID4gKyAgICBpZiAoYnl0ZXMgPD0gMCkgew0KPiA+ICsgICAgICAg
IGlmIChlcnJubyA9PSBFQUdBSU4gfHwgZXJybm8gPT0gRUlOVFIpIHsNCj4gPiArICAgICAgICAg
ICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGVycm9yX3NldGco
ZXJycCwgInZFVkVOVFEodHlwZSAldSBpZCAldSk6IHJlYWQgZmFpbGVkICglbSkiLCB0eXBlLCBp
ZCk7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaGRy
ID0gKHN0cnVjdCBpb21tdWZkX3ZldmVudF9oZWFkZXIgKilidWY7DQo+ID4gKyAgICBpZiAoYnl0
ZXMgPT0gc2l6ZW9mKCpoZHIpICYmDQo+ID4gKyAgICAgICAgKGhkci0+ZmxhZ3MgJiBJT01NVV9W
RVZFTlRRX0ZMQUdfTE9TVF9FVkVOVFMpKSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAidkVWRU5UUSh0eXBlICV1IGlkICV1KTogb3ZlcmZsb3dlZCIsIHR5cGUsIGlkKTsNCj4gPiAr
ICAgICAgICB2ZXZlbnRxLT5ldmVudF9zdGFydCA9IGZhbHNlOw0KPiA+ICsgICAgICAgIHJldHVy
biBmYWxzZTsNCj4gPiArICAgIH0NCj4gPiArICAgIGlmIChieXRlcyA8IHNpemUpIHsNCj4gPiAr
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ2RVZFTlRRKHR5cGUgJXUgaWQgJXUpOiBzaG9ydCBy
ZWFkKCV6ZC8lemQNCj4gYnl0ZXMpIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICB0
eXBlLCBpZCwgYnl0ZXMsIHNpemUpOw0KPiA+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAr
ICAgIH0NCj4gPiArICAgIC8qIENoZWNrIHNlcXVlbmNlIGluIGhkciBmb3IgbG9zdCBldmVudHMg
aWYgYW55ICovDQo+ID4gKyAgICBpZiAodmV2ZW50cS0+ZXZlbnRfc3RhcnQgJiYgKGhkci0+c2Vx
dWVuY2UgLSBsYXN0X3NlcSAhPSAxKSkgew0KPiA+ICsgICAgICAgIHdhcm5fcmVwb3J0KCJ2RVZF
TlRRKHR5cGUgJXUgaWQgJXUpOiBsb3N0ICV1IGV2ZW50KHMpIiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICB0eXBlLCBpZCwgaGRyLT5zZXF1ZW5jZSAtIGxhc3Rfc2VxIC0gMSk7DQo+ID4gKyAg
ICB9DQo+ID4gKyAgICB2ZXZlbnRxLT5sYXN0X2V2ZW50X3NlcSA9IGhkci0+c2VxdWVuY2U7DQo+
ID4gKyAgICB2ZXZlbnRxLT5ldmVudF9zdGFydCA9IHRydWU7DQo+ID4gKyAgICByZXR1cm4gdHJ1
ZTsNCj4gDQo+IFRoaXMgZnVuY3Rpb24gdGFrZXMgYSBidWYgYW5kIHNpemUgdGhhdCBpdCB3aWxs
IHJlYWQgaW50by4gSXQgcmV0dXJucw0KPiBmYWxzbyBvbiB2YXJpb3VzIGVycm9yIGNhc2VzLCBh
bmQgdHJ1ZSBvbiBzdWNjZXNzLiBJbiBwYXJ0aWN1bGFyLA0KPiAiZGlkbid0IHJlYWQgZXhhY3Rs
eSB0aGUgcmVxdWVzdGVkIG51bWJlciBvZiBieXRlcyIgaXMgYW4gZXJyb3IgY2FzZS4NCj4gSG93
ZXZlciwgaXQgYWxzbyByZXR1cm5zIHRydWUgZm9yIEVBR0FJTiBhbmQgRUlOVFIsIGhhdmluZyBu
b3QgcmVhZA0KPiBhbnkgZGF0YSBpbnRvIHRoZSBidWZmZXIuICBUaGUgQVBJIHByb3ZpZGVzIG5v
IHdheSBmb3IgdGhlIGNhbGxlcg0KPiB0byB0ZWxsIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gInN1
Y2Nlc3NmdWxseSByZWFkIHRoZSBkYXRhIiBhbmQNCj4gInlvdSBuZWVkIHRvIHRyeSBhZ2FpbiBs
YXRlciIuDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBzbW11djNfYWNjZWxf
ZXZlbnRfcmVhZCh2b2lkICpvcGFxdWUpDQo+ID4gIHsNCj4gPiAgICAgIFNNTVV2M1N0YXRlICpz
ID0gb3BhcXVlOw0KPiA+IEBAIC00NDgsMzkgKzQ4NiwxNCBAQCBzdGF0aWMgdm9pZCBzbW11djNf
YWNjZWxfZXZlbnRfcmVhZCh2b2lkDQo+ICpvcGFxdWUpDQo+ID4gICAgICAgICAgc3RydWN0IGlv
bW11ZmRfdmV2ZW50X2hlYWRlciBoZHI7DQo+ID4gICAgICAgICAgc3RydWN0IGlvbW11X3ZldmVu
dF9hcm1fc21tdXYzIHZldmVudDsNCj4gPiAgICAgIH0gYnVmOw0KPiA+IC0gICAgZW51bSBpb21t
dV92ZXZlbnRxX3R5cGUgdHlwZSA9DQo+IElPTU1VX1ZFVkVOVFFfVFlQRV9BUk1fU01NVVYzOw0K
PiA+IC0gICAgdWludDMyX3QgaWQgPSB2ZXZlbnRxLT52ZXZlbnRxX2lkOw0KPiA+IC0gICAgdWlu
dDMyX3QgbGFzdF9zZXEgPSB2ZXZlbnRxLT5sYXN0X2V2ZW50X3NlcTsNCj4gPiAtICAgIHNzaXpl
X3QgYnl0ZXM7DQo+ID4gKyAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gPg0KPiA+IC0g
ICAgYnl0ZXMgPSByZWFkKHZldmVudHEtPnZldmVudHFfZmQsICZidWYsIHNpemVvZihidWYpKTsN
Cj4gPiAtICAgIGlmIChieXRlcyA8PSAwKSB7DQo+ID4gLSAgICAgICAgaWYgKGVycm5vID09IEVB
R0FJTiB8fCBlcnJubyA9PSBFSU5UUikgew0KPiA+IC0gICAgICAgICAgICByZXR1cm47DQo+ID4g
LSAgICAgICAgfQ0KPiA+IC0gICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCJ2RVZFTlRRKHR5cGUg
JXUgaWQgJXUpOiByZWFkIGZhaWxlZCAoJW0pIiwgdHlwZSwNCj4gaWQpOw0KPiANCj4gSGVyZSBh
dCB0aGUgY2FsbHNpdGUsIHdlIHVzZWQgdG8gcmV0dXJuIGZyb20gc21tdXYzX2FjY2VsX2V2ZW50
X3JlYWQoKQ0KPiB3aXRob3V0IGRvaW5nIGFueXRoaW5nIGZvciB0aGUgRUFHQUlOL0VJTlRSIGNh
c2UsIHJlcG9ydCB0aGUgZXJyb3INCj4gaW4gb3RoZXIgZXJyb3IgY2FzZXMsIGFuZCBjb250aW51
ZSB0byBzbW11djNfcHJvcGFnYXRlX2V2ZW50KCkgb25seQ0KPiBmb3IgdGhlIHN1Y2Nlc3MgY2Fz
ZS4NCj4gDQo+IA0KPiA+ICsgICAgaWYgKCFzbW11djNfYWNjZWxfZXZlbnRfcmVhZF92YWxpZGF0
ZSh2ZXZlbnRxLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBJT01NVV9WRVZFTlRRX1RZUEVfQVJNX1NNTVVWMywgJmJ1ZiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGJ1ZiksICZsb2NhbF9lcnIpKSB7
DQo+ID4gKyAgICAgICAgd2Fybl9yZXBvcnRfZXJyX29uY2UobG9jYWxfZXJyKTsNCj4gPiAgICAg
ICAgICByZXR1cm47DQo+ID4gICAgICB9DQo+IA0KPiBJbiB0aGUgbmV3IGNvZGUsIHdlIHJlcG9y
dCB0aGUgZmFpbHVyZXMgKGdvb2QpLCBwcm9jZWVkIGZvciB0aGUNCj4gc3VjY2VzcyBjYXNlIChh
bHNvIGdvb2QpLCBidXQgd2Ugbm93IGNvbnRpbnVlIHRvIGNhbGwNCj4gc21tdXYzX3Byb3BhZ2F0
ZV9ldmVudCgpIHdpdGggYW4gdW5pbml0aWFsaXplZCBidWYgc3RydWN0IGlmDQo+IHRoZSByZWFk
IGNhbGwgcmV0dXJuZWQgRUFHQUlOL0VJTlRSLi4uDQoNClllcywgdGhpcyBpcyBhIHZhbGlkIGJ1
Zy4gSSB3aWxsIHNlbmQgYSBmaXguDQoNClRoYW5rcywNClNoYW1lZXINCg0K

