Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B7FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsoh-0004mG-Qa; Tue, 26 May 2026 10:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRsoQ-0003LD-J6; Tue, 26 May 2026 10:31:19 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRsoO-00022H-1S; Tue, 26 May 2026 10:31:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux5lgTkTEjCZKl5zr3Ztn8IsYGnRGmJcxXYCH2Z55CGAWrY5CisYRAkmq5IOtnGWxLXvFw2aBlxLF0khSkbdnr9ak1El38m6vc0HYT7D5k5ipJXAAwapi96ibF4f2t0PEIgNv0NGTsLNrtd4pm7Hlt3axg+qKnU/8CoVQBz16l/pb+DGx2qveU3VYVwQCoEKVuek/q1Q5daKfP93geHfJ4tjN/NJIyv1NXujAWD5wuXqZrsxj0zSE2XswwH0deT7nmuIpegSghO14ZnSq6GZdQ+rUAPZo7SHJwFe+vPeOXqjUgPrfGcaLWxcrlA+Xz4STMffMwx2BhDG0aw8GANH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAHsVG9MIz98jVarx265RIl6o8PrLAbYbr3pSb99LZY=;
 b=TmvpbtHy9gioNkPUzE14FEQoS9mGJ0yn9JHzEH9DYWNJiqJQpDQqjvwjQuFlLsFz7m11rJPfCfRRnGeHfrAERPjTzLiAsBnZml3qNDPbQ3UeRa7u9NxmOcmeRkBXxnEC5qGOGtF7Dy0/suudgAlzdl+sfCGOicDrAZTooSe5M8+GVxCDqdAtVLoYeKnyqJhnYMWBbvxU5TwD4CWt6cozRVZMPYDQsumM7TwoY8hsogVXzzpkvU6OgDslX9lUR+SXRH5PS2fJsK84OMRIXfo0qpFDLxRG4nrOSTt6X+UeJWr1lEe6UVXx2rmAaeq98FldvjeQIU9aGlV0EoLkm6AHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAHsVG9MIz98jVarx265RIl6o8PrLAbYbr3pSb99LZY=;
 b=X6TvcBby765YIavNFcaqlc37RmD/Ia1dkRaeXBZQqWZCCSsbN+3BbY3gG5An7sPz0qnsCYiDUaPsiTFgZadVlpyWIWSZ+rGBf2imTGrOyyUK2bVECwYw+N1GM3G+OqyrW777pWRLfexPY2Y+D2w+SxhKsEe3LFwr3H7yLhXxfcZaAM+oKxxyP5XziwC1tLKTyEnmrg2KyBoxm4zfXWkGPIa2LO1CM1HcT6pyEm/nrDBS/y7LSbLaShQfy2hsXtlSId0WsyjItld6l2GKV8NI+wFA92C67cNOog/K54louII4c01LiBsqvCC1jqU8/Hz8zHsb8wIaOiNdh6iOLVXOew==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:31:09 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 14:31:08 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 27/32] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Thread-Topic: [PATCH v5 27/32] hw/arm/tegra241-cmdqv: Limit queue size based
 on backend page size
Thread-Index: AQHc53vrSNT0QNUr/0KAcRWeLNWCCbYgFwCAgABRYoA=
Date: Tue, 26 May 2026 14:31:08 +0000
Message-ID: <CH3PR12MB754809084E160A0D3D681835AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-28-skolothumtho@nvidia.com>
 <12bc6dd2-2ef0-453d-bd49-2776dbda63be@redhat.com>
In-Reply-To: <12bc6dd2-2ef0-453d-bd49-2776dbda63be@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ0PR12MB6944:EE_
x-ms-office365-filtering-correlation-id: b6224a23-337b-4bf6-f4c8-08debb336d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: Hlu5UqkqZMRWCP/OZWyHXSc86W+l8todTWH6pGMG+AhLrbotP8avy52Zmzs4f2che7qSlHrZNojmnAj91fYwl8FZk8O28WuQp6cHhusmBWUB4VR3XcwvCJV3MbwnVhJBl3u5iwG1mISjmBAiDgImuMJFCGAn/HsTAJwc0v576+/LKwIR9nDfeOHX+xqGZq6b0zItXd9LiREcNMXTSx86aoGC9WXaF8wueS9uhNXQIW4+0+a3CAq30BsogyiU8R9/sEh7+Ahmo+T7NcRdVORbVvjht3N3jtd5w0R20cxj9bNh59K3/QnFa6IhQNre+EwGI6lhVdHY4Db9snQUq4ZbLnBOEIftiP8aDslCulqDYCxIEc6XSR6agoZa0NAlxaNR+IH4H5losdkjcOKGgRyX9ZIbbRqIPM7WgGYt4thwrVpah3DTSVyQKUqSlTARBaUTlsV9wTKP9BZWgZs7a/NnYRoMA0kHOQinK5XaI5EV+T6mkws/F/zCHJjH4K74fPsRararMnfMATZ53SrcQyVZYy6MxR7ttgKrj5piWRLoNcpjGUMa0AAha3rSNxqtos8G/uvrhDEevNHlI+SFzadywFBpBoSiNlwTqXRTjuNIiQkiJJ+iI0TjMB0rtgUXvM/vOYIx49rUev2DFiQs9yfUbycI60YSWT9g13wLOXpvg6HHAV6WPT0mxfKyr9DzYK/WilEd5dsfu9a0+MU8k1wPnr44alBBhbsHm5p0y3dSDFEC+rnLEEqp5NVeFUuzr3gb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0hpWmE0dWxXNlVBV1lXZUlNZS9qeUVyS0k4OW9YS2ZiN0RwdktKbEVCQlNi?=
 =?utf-8?B?THd6ZzhOVW5OU3dLYXh1dkNFalZ3TXROL2lyOXlBaDdCSTFiM1dZUUdaakRq?=
 =?utf-8?B?SFlybFFwYWVrY3lMNjRINFNPTEVaZkhISFZjK0R3Sjc1NjlQdW45TVlwWVdZ?=
 =?utf-8?B?L1dLdUVTSUYwNE4zT1ZIc2RBUmtEL3VzMjJJcW9TZ3kreC9qT3pwazk4bG1u?=
 =?utf-8?B?N3lyRWxDbmZuc25yaTVWdHZkVnc5NkZROGRaVWRxcEdkdmMycjdYRFlzaHNM?=
 =?utf-8?B?MXdiNFZrYlprbFF3Uk9wZHZGeTlVcWVudkhMTXoxYWVJcEN4dW80ZnVFME9Q?=
 =?utf-8?B?NGVQUklwQ1V1cEl1WDNvUU0rcytNNUpucEdnUENpTVloc2R0RUlZOG9iUmdZ?=
 =?utf-8?B?bXRxYS9oREducUFaQkFhV0VmVkg5aTRrNzh4RExpcjFtMWwzQWtQbDRTWWJW?=
 =?utf-8?B?TlJRTWs2clB6cUI1ZjVYdUo4RmJsS1ZmcUZQcVpvRnJZUFlhQkRybGxWSzhj?=
 =?utf-8?B?Y2JuU012VlVKY1orZEFLOVVvcXJVeUwvd05UVHhoY2FySTliWVhNeWlIVm9m?=
 =?utf-8?B?Z1FjTFFMMVYyaHphTW5YbzZ2Q2tFNFdaOElNSVNMYWtIMHh3T1FXbHpPL0hV?=
 =?utf-8?B?OE05eUZjZ3ZveTI2K3hvUWNKSmRUTzJDT3RoQ0FYL3d3MTlSWDRkVDVzbHN2?=
 =?utf-8?B?SytlWmlBTkorMnp2cm5INXlqRStlSkFmVFdhcUYyclBWZWtMdFJlZURXU0Vp?=
 =?utf-8?B?N2ltMGtDUHE0MUJqNmo0TFJJTDNsUEE1bVU5Sk0ycVBuT3BvczFwdWxPdWRV?=
 =?utf-8?B?TTRWMHNCQ3p1TXQwV0hlTFF0dkpUaGZtb2pwMUtwZ2lDVzdINTI4N3BOOUtF?=
 =?utf-8?B?c29OekRPc21KT29XeSthazBVZTBIMFpSTmF0K2dJUkdVa0FaSGYyc1ZkSUJy?=
 =?utf-8?B?TG5PMEd2a0k5bGNxUE9COVJHY2IxVERxRzUvOUJVL09MVFRLM3BMMFhaVDV5?=
 =?utf-8?B?K0RmY09iREp0aUtDNTdmQlFIaTBmTUxaVHU2ZmtUcmxaMExqclNYTU1XOExo?=
 =?utf-8?B?MTRpZnh5QzZzZFkvdU0rblBEMW1WZXBGdk0wVGk3NmpRckxiL2tDZ0haUWhw?=
 =?utf-8?B?dDRQNEUxU2VEbVl6RERqUThSRldObnZ4VEQzSURvb0hnTU5sdzRmTnZLb29U?=
 =?utf-8?B?Ym03WldkUE84a2NoL0tPNE92MkRUL2V2LzBCZ0RIa0xueDB1azlpdTM5cFg2?=
 =?utf-8?B?ZDJ5aUhGNkgrWHdOaU8zTE1kTm5yYWZXTWhIQzlmOGtSZ0tqK0NXNm04dmpF?=
 =?utf-8?B?M3dtTStRczZwQWJQZ3YwUWZkMEw2SlFQLzBrOFNDRzdBZ2VJWkxMMjdaRkVC?=
 =?utf-8?B?TlpudzdxQkNDcGY4NVl3TWZ6N3dzUW0wQ203Ukt3S2FtS2pQNU5rbWxUaHNY?=
 =?utf-8?B?L2VHUXhYaWtsZi8wM2h0SGlUVndkV0R5VEw3d0hKSXpZMEdWRDlVY2JlUXds?=
 =?utf-8?B?UVlmRjBLM2NWYXowaDV4VS9Kd1RSTXJGRk5HUkQ4U2Z1eHJLbmZnUG1oNEFI?=
 =?utf-8?B?MmdrbVVWeGYydnZsSmVacVptcWRwSFNFcWZ2VmlDSXBDRHp1ellRaGVjT01X?=
 =?utf-8?B?SnRLUWQ4Vjhvd0JHZXBidEJ5VGljaHdpR0Z2L2VaWWZCQ0ZMNHkrdjFZWDQ4?=
 =?utf-8?B?NlhmdUliTWtBNVRCNmhxcEFqc0p4WWJKRjRaVUhxUXRYcG9CRXlZQ1Y4T0lG?=
 =?utf-8?B?RjhTUkJvN1lCY0dDNWVIaW0yQkRtdGpUbWlVTjZoTjNIaytJbWgraWs2UGhL?=
 =?utf-8?B?Z0JLWHY1UEJidzNtMWRzNUpZM3FYZllqZXlHUUYwY1Nrb0ZQL21pRDNqMjN3?=
 =?utf-8?B?SGtydUZNU1VpUlZBMVJEQlIwaGlwTUVYZGR0c0NFcmx4ekJnSHNyUW1LQndX?=
 =?utf-8?B?SEYvZ29hV2Jqa1VkRzhJRW9aTGV0Qml1M3MvczZ4Y25FWVh0Nk8vS3FCWUVX?=
 =?utf-8?B?d0NyR1lFWGRBc2R0Vm10RzNPeGVjZ2ZqbWdkU2I2L0lIT3F3dkM2bHpSaytG?=
 =?utf-8?B?UWNmdGhObkNsam4xU2tscDl3YTAxZnYwcUZFaU9mdFFzVGZQbFlBd1JFS3Zo?=
 =?utf-8?B?SkdwZ0poZHVSbFZsY1MyUGFSRWFoSy85UW9IYzFGMWR5NVVmK1M0RVNvUGs4?=
 =?utf-8?B?eVNVQ0pSYXJWcmxnQ1EvUHpYRHAyQkZqUzlOYVllMXNoc1g3Ky9aYjVtMFhi?=
 =?utf-8?B?YVRoQW5mVUtRTmNUcnBFTW9SQVEvTmd2dmhuZE5JOHFYbUtHb21DS1FTVkJ4?=
 =?utf-8?B?dUozMVpLNE5lM0hBUVZmd0hlbitNelVhYkJ3M1FFMDIzVEoyalZRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6224a23-337b-4bf6-f4c8-08debb336d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 14:31:08.5497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vurg0WAyeZbT7N9QsNkz0+25cIDij+yISynxSu06NfreJJDJhMmdfKIy23Prs1dDRyVVVF8iQDqnb9oBYqfvhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNiBNYXkgMjAyNiAxMDozNQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAyNy8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBMaW1pdCBxdWV1ZSBzaXplDQo+IGJhc2VkIG9uIGJhY2tlbmQgcGFn
ZSBzaXplDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA1LzE5LzI2IDEy
OjM3IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEZyb206IE5pY29saW4gQ2hlbiA8
bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IENNRFFWIEhXIHJlYWRzIGd1ZXN0IHF1ZXVl
IG1lbW9yeSBieSBpdHMgaG9zdCBwaHlzaWNhbCBhZGRyZXNzIHNldA0KPiA+IHVwIHZpYSBJT01N
VUZELiBUaGlzIHJlcXVpcmVzIHRoZSBndWVzdCBxdWV1ZSB0byBiZSBjb250aWd1b3VzIGluDQo+
ID4gYm90aCBndWVzdCBQQSBhbmQgaG9zdCBQQSBzcGFjZS4gV2l0aCBUZWdyYTI0MSBDTURRViBl
bmFibGVkLCB3ZQ0KPiA+IG11c3Qgb25seSBhZHZlcnRpc2UgYSBjb21tYW5kIHF1ZXVlIHNpemUg
KENNRFFTKSB0aGF0IHRoZSBob3N0IGNhbg0KPiA+IHNhZmVseSBiYWNrIHdpdGggcGh5c2ljYWxs
eSBjb250aWd1b3VzIG1lbW9yeS4gQWxsb3dpbmcgYSBxdWV1ZSBzaXplDQo+ID4gbGFyZ2VyIHRo
YW4gdGhlIGhvc3QgcGFnZSBzaXplIGNvdWxkIGNhdXNlIHRoZSBoYXJkd2FyZSB0byBETUEgYWNy
b3NzDQo+ID4gcGFnZSBib3VuZGFyaWVzLCBsZWFkaW5nIHRvIGZhdWx0cy4NCj4gPg0KPiA+IFVz
ZSBxZW11X3JhbV9iYWNrZW5kX3BhZ2VzaXplX21pbigpIHRvIGZpbmQgdGhlIHNtYWxsZXN0IG1l
bW9yeS0NCj4gPiBiYWNrZW5kIHBhZ2Ugc2l6ZSBpbiB1c2UsIHRoZW4gY2FwIElEUjEuQ01EUVMg
c28gdGhlIGd1ZXN0IGNhbm5vdA0KPiA+IGNvbmZpZ3VyZSBhIGNvbW1hbmQgcXVldWUgdGhhdCBl
eGNlZWRzIHRoYXQgY29udGlndW91cyBiYWNraW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Tmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBo
dy9hcm0vdGVncmEyNDEtY21kcXYuYyB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IGluZGV4IGFk
NjRmMDYyNjAuLjdmNjE3YmNjOTcgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNt
ZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC0xNiw2ICsx
Niw4IEBADQo+ID4gICNpbmNsdWRlICJody9hcm0vc21tdXYzLWNvbW1vbi5oIg0KPiA+ICAjaW5j
bHVkZSAiaHcvY29yZS9pcnEuaCINCj4gPiAgI2luY2x1ZGUgInNtbXV2My1hY2NlbC5oIg0KPiA+
ICsjaW5jbHVkZSAic21tdXYzLWludGVybmFsLmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vcmFt
YmxvY2suaCINCj4gPiAgI2luY2x1ZGUgInRlZ3JhMjQxLWNtZHF2LmgiDQo+ID4gICNpbmNsdWRl
ICJ0cmFjZS5oIg0KPiA+DQo+ID4gQEAgLTg1Niw2ICs4NTgsOCBAQCBmcmVlX3Zpb21tdToNCj4g
PiAgc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZfaW5pdF9yZWdzKFNNTVV2M1N0YXRlICpzLCBU
ZWdyYTI0MUNNRFFWDQo+ICpjbWRxdikNCj4gPiAgew0KPiA+ICAgICAgaW50IGk7DQo+ID4gKyAg
ICBzaXplX3QgcGdzaXplOw0KPiA+ICsgICAgdWludDMyX3QgdmFsOw0KPiA+DQo+ID4gICAgICBj
bWRxdi0+Y29uZmlnID0gVl9DT05GSUdfUkVTRVQ7DQo+ID4gICAgICBjbWRxdi0+cGFyYW0gPSBG
SUVMRF9EUDMyKDAsIFBBUkFNLCBDTURRVl9WRVIsIENNRFFWX1ZFUik7DQo+ID4gQEAgLTg4Nyw2
ICs4OTEsMTkgQEAgc3RhdGljIHZvaWQNCj4gdGVncmEyNDFfY21kcXZfaW5pdF9yZWdzKFNNTVV2
M1N0YXRlICpzLCBUZWdyYTI0MUNNRFFWICpjbWRxdikNCj4gPiAgICAgICAgICBjbWRxdi0+dmNt
ZHFfYmFzZVtpXSA9IDA7DQo+ID4gICAgICAgICAgY21kcXYtPnZjbWRxX2NvbnNfaW5keF9iYXNl
W2ldID0gMDsNCj4gPiAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogQ01E
USBtdXN0IG5vdCBjcm9zcyBhIHBoeXNpY2FsIFJBTSBiYWNrZW5kIHBhZ2UuIEFkanVzdCBDTURR
UyBzbw0KPiB0aGUNCj4gPiArICAgICAqIHF1ZXVlIGZpdHMgZW50aXJlbHkgd2l0aGluIHRoZSBz
bWFsbGVzdCBiYWNrZW5kIHBhZ2Ugc2l6ZSwgZW5zdXJpbmcNCj4gPiArICAgICAqIHRoZSBjb21t
YW5kIHF1ZXVlIGlzIHBoeXNpY2FsbHkgY29udGlndW91cyBpbiBob3N0IG1lbW9yeS4NCj4gPiAr
ICAgICAqDQo+ID4gKyAgICAgKiAgIElEUjEuQ01EUVMgPSBsb2cyKG1heF9xc3opIC0gZW50cnlf
c2hpZnQNCj4gPiArICAgICAqDQo+ID4gKyAgICAgKiB3aGVyZSBlbnRyeV9zaGlmdCA9IDQgKGVh
Y2ggQ01EUSBlbnRyeSBpcyAxNiBieXRlcyA9IDJeNCkuDQo+ID4gKyAgICAgKi8NCj4gPiArICAg
IHBnc2l6ZSA9IHFlbXVfcmFtX2JhY2tlbmRfcGFnZXNpemVfbWluKCk7DQo+IE9LIEkgc2VlIHRo
aXMgaXMgZG9uZSBhdCBpbml0IHNpemUgYmVmb3JlIHdlIGtub3cgdGhlIEdQQS4gQnV0IEkgbWVh
bnQNCj4geW91IG1heSBlbmQgdXAgd2l0aCBhIHBhZ2Ugc2l6ZSB0aGF0IGlzIHN1Ym9wdGltYWws
IG5vPw0KDQpZZXMuIFRoZSByZWNvbW1lbmRlZCBDTURRViBxdWV1ZSBzaXplIGlzIHRoZSBtYXgg
OE0gYW5kIHdlDQpyZWNvbW1lbmQgdXNpbmcgaHVnZXBhZ2VzIHRvIGFjaGlldmUgdGhhdC4NCg0K
PiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHRoZSBhY3R1YWwgcmVxdWlyZW1lbnRzIHdpdGggcmVn
YXJkcyB0byBodWdlIHBhZ2UNCj4gdXNhZ2UgaW4gdGhpcyBwYXRjaCBhbmQgaW4gdGhlIGNvdmVy
IGxldHRlcj8NCg0KU3VyZS4gSSB3aWxsIGFkZCB0aGF0IGluZm8uDQoNClRoYW5rcywNClNoYW1l
ZXIgDQogDQo=

