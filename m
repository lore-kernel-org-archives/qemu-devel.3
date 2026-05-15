Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29724CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 09:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNpC1-0007vr-Sr; Fri, 15 May 2026 05:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wNpBq-0007mh-Cd
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:50:44 -0400
Received: from mail-northcentralusazon11023132.outbound.protection.outlook.com
 ([40.107.201.132] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wNpB6-0007OW-Qs
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h28t2IVfKu8ZYDwrLqRO6aaA+NtPOTKlmRvobF+lx5ZQrTG3qdUkQcF3XhpgcOoVHuJNszhZEz6qhbglqmK7egiwsYqW7tBrUx3/yfrFRdbdopj/TtieV9IHedlFMxjMmRJj8mwiCfih5rZqE2DpskqG60N27LzCToIwIkk+nMGQFYKom9p33/pPzPuUDU+V8dOuQd9ufdS0vfSJGSYeI6y0KgUBbwj2cz+8/S3TBrP3OjjDoEdb33Nh5r1eJ4oO6W1Mm+SGyUvXaG61XPq1rhZWwm1zDupj4hAT9+Tcq7bWaqO2IrZhJZ0zAq9ZxVWf2CGZJ/c9WrjNgcqqDbz1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pXp9cAkQj/Wquqa5sHP3fTjRyLdvngX69wV6BAp2mg=;
 b=seQEthN695dV82D9dHkJMqaCbFAoHfgvmkrlCXp8/yjMPqQr34QzpCaFI95ppCOvH1lq+LXw1flCDHvkDDSUClwp7duQjzwTqm+fkMzQmyiBAQvU1Igm/2JmMgMDCn9pDUBS8q92AKAFWct0HHdZ4qHl3Im9VluuOMiZwcMYdLLgazJo7crsDVvh9tggf48d2xi1ANbiLrZw0JbxlPsbDF4UwJPs62ohw4B0cpu8f4FPJMVUFhXt800IEj2K9PreXFAodhYRaxBfuEaXyrZ+thSxHR9cXLK+G6gFcUBt0IZxjh/Izxn43lkvYCHk9X4xJdGPE0kL88lX+AlTiTFDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pXp9cAkQj/Wquqa5sHP3fTjRyLdvngX69wV6BAp2mg=;
 b=Lt1EOyuOgv+86FVddnOAZAGDaIrBcKiboWJQtZZEWEjRPwPn+tHhk4WQdp2TIgOEuiEXnPJSPGCj6i8gBHHoEsYROyoCOGR+oJYwtHBm6IMkVWQX3uG8g46rb+G2r5ftBE2arYSXTYpad4Z/HsEvyrnRaxetwTRw01hrIlARyTAvTPPTh+CQw8YJDYDOOn+nMGGKIklzdspNvz56gih5j3gNMcBVLTGPCIICfghw5U8tDYK0tTb1HWOzLgedTVTw8vjHS265iQx704JUAKguzlLqRxfiPd4KhYCBwmgvf5U0/4z8AcC/HZPpnyL+1p6JpeKuaG1CGx2aWuarfuC01g==
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by CH5PR18MB927682.namprd18.prod.outlook.com (2603:10b6:610:2f1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 09:37:23 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 09:37:23 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?iso-2022-jp?B?GyRCMnNKJBsoQjogW1BBVENIIHYyIDAvNF0gQWRkIEF4aWFkbyBTb0Mg?=
 =?iso-2022-jp?B?QVgzMDAwIGFuZCBFVksgYm9hcmQ=?=
Thread-Topic: [PATCH v2 0/4] Add Axiado SoC AX3000 and EVK board
Thread-Index: AQHc2IJX9eWJLCWbjkeZlpasvhxYNLYO63fx
Date: Fri, 15 May 2026 09:37:23 +0000
Message-ID: <SJ0PR18MB447991F513FCC7FD4579ABFDD3042@SJ0PR18MB4479.namprd18.prod.outlook.com>
References: <20260430091832.1846637-1-kchiu@axiado.com>
In-Reply-To: <20260430091832.1846637-1-kchiu@axiado.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4479:EE_|CH5PR18MB927682:EE_
x-ms-office365-filtering-correlation-id: d07a57af-d7da-44aa-25d0-08deb2659159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003|13003099007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: IazJnYQlMiyTwsZgA6KFGO8VgRyjUQIcdhGuwG/b8//zoYmCrqbhWeDJ0HpuoYYsevL0YoakDVAjEKM0u97hMCIbUmW7gbFWAxH3jQfCj6anPUoEsX/0dEyOj8qa1feOQ9cnaH/Ig1g1T+//EfznzYDze4kZo/6o6rNSQwzjxvJT++tGvf9WZQnIR1iS9OH2mYdxWhTRO0t3DtlBb/4OU/PNRgXAw95Rqr/q6Oc178rOLrCeBQEwtboH7ndcIgwOPoRhLGvYMJ8i+xE7shurYBfoihtvczO7sICo9YfjGW8EmU2aQxrG8Czr06YqaocueNmslTP+e/vXwWCShW4DEhfAfK0IvHoktBqN1kcS5m0ZTwbWVUvksVt71fi0rJFu9ZiaOZdQs7FR/Rw1yNtpFRRoqM2T+MPF0Bblf9CpYO1cKAcaMKTCdHIzbRcfuCmCOhte9XpBwuchwc3rsR7bEbsqUHlesed/bGS7flH6tlTFPN0AGfAeOyw+AWzKIaMd8qwkbMQFLzgtg5fKsKIURVmjW69pW7GbCzNfZxV035M+om5aiUAsY1NARwhm94PvIu9r1Qh4K5BnQn6VTrriJ/Sy2Z8tnnVq70fllMsme26Pe0dvTYI5DM+A10PlEpq32HoYYCGy+7DBCRRZLQskb1tzAvlvKtUGwXjVEKYDd+Pn53T0lVaBBh57zgiW+/YCKEdR24uHkQj7vfE20rCJoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TWlLb0dDUzNHazlCcW5xbE91WndmVy9OVVFuK0RnMmQ4eDZLQU96VkFZ?=
 =?iso-2022-jp?B?d0ZOd21EL3ZrSlVWRWhhU1ZjQ3FUVm1Db0o4clhUeGpmdlA1NkszK2FK?=
 =?iso-2022-jp?B?TFF6Y3ZOMGFUa3FiRndqVkVZMldoenFaakNOZVQyQzVsQVYzc2J4V1RE?=
 =?iso-2022-jp?B?cTJZMGpBU3JJV1ZtOWQ2bXlYeW5PK2VoZ0JLdDdkTlZubFVsVUc2dzl3?=
 =?iso-2022-jp?B?cjdLeUhhM2VweXQ4WE1haEJZQmlBQjlZakNRcld3cnh1cEljOWdKL0Zz?=
 =?iso-2022-jp?B?dWRTVFpzbGZ5WnVZakNrTWNuakZVdXBvTC9mcXJTN1V5MTYyOVNFbktC?=
 =?iso-2022-jp?B?RVR3YlprcUp4R0MwU2x0ckp5V3hkR0UzQ1BGSnQ4bEdYTUo4RUEzRjB5?=
 =?iso-2022-jp?B?ZG52V3dBVnlvUlNMV0VuMXNWeDdBOWRoSy9keXVDZG51TjcyaE1WY2J6?=
 =?iso-2022-jp?B?WXBCWXoyOS9iTWRuNnRKK3ZiWHhhak54VzdFTUwvQlVZRGxremVxNmtT?=
 =?iso-2022-jp?B?eS9aL0VSbmRyeE1ZdEVZamtWMmFHekdwSWkvZ3lLaThTeE1aTUZHV2J2?=
 =?iso-2022-jp?B?ZDUzdWExOUdjQUhuMGVjdmZNL3phNUJYVlFuTHBUdHI1Y0hicjM1V1ND?=
 =?iso-2022-jp?B?QnF0dmdpczJJVU5zWFMydVB5V3hjNk1reWUya0xiSjVibGhlTGZiWk1H?=
 =?iso-2022-jp?B?V1Z6U0wxenJXWVRydFNJY2xJMDJJOGtpcVRRb0sxbStCNzZ0RUh0VTNy?=
 =?iso-2022-jp?B?Y0RCOHp6U2VmS3NvTHk0ZEMwUjh1V0V4RFdVbUt0ZlRVZmVBTi9QOWRD?=
 =?iso-2022-jp?B?OEs2S1FyT2g0MzYwOXhudmFvSXVLd21YcHJRaG5rWVFuSG9qV01BdEZa?=
 =?iso-2022-jp?B?czNZek1BaDdOa2tzdUpjWFZIcFZraTlSR1doT3hFQkFleDhRT3pIL25k?=
 =?iso-2022-jp?B?N2JlelNScWh2YWd0dVM3Z01XZk9OT0duZkNFUGtGTlFtWEpSbVZqd3hu?=
 =?iso-2022-jp?B?eEV6MkZ1UENITTF4SGtzMngyWVFyZHdIVktYZ05jOWZFNW15Z0ppNmw5?=
 =?iso-2022-jp?B?cHBTSG5lRXVoUGZUZDVhU0VCOUhFZjFIOFNScjdLdDJ4Yy80N3RhYmZX?=
 =?iso-2022-jp?B?TkN6Y1hCcHp5UGRoU3l5OXZZc2lLb25ldTJIZWFoNkxKZ3VpeEQ4c2FG?=
 =?iso-2022-jp?B?WThQRmd0YzJCd0xCRTFuMXY4QVNTY1MvQm1DZjlhTkRPQm4zREVhMVNU?=
 =?iso-2022-jp?B?N2RqWG9rWnRlTFZSODdUV2tGUnV6cU1TejJ3RnRWMUJBb2M2WGdpbnBO?=
 =?iso-2022-jp?B?Mk9qU1BUTmRwVTlhU3F3cGFZVk9YSHZyTFZZRmdPenhTYjFWQjJTbllS?=
 =?iso-2022-jp?B?K0ZocEZsdDduVnJ6eGxoeVJZbEc5bytYZ3N1WHFILy9ZM0ZNeW12RFZX?=
 =?iso-2022-jp?B?UWpGSi9WWjA3U2F0eUdEZENXTjIyQWFmVkEwdlNmUS9sMjlSckNydi9L?=
 =?iso-2022-jp?B?THd0R1llRk9oaTlMRkVmQ0RyWTh5NUJRbTJMY3J2UXVDckFGR01oaUEv?=
 =?iso-2022-jp?B?V09ud1U5bFVOTFNldVRYY0tTenBzSGRkZkl2Nm1XRkJ6a296WWlNQnpB?=
 =?iso-2022-jp?B?cEJ0THhCRFk0akg2SnN0VS9pRXA0Q1dNMVlhcHArQlV4ZXBoaXluV01E?=
 =?iso-2022-jp?B?VlVRdUdLbnRjam9ycU50NTM4aGZwbGRIaVlaMlFTeXBzdkVyUUNUWWJX?=
 =?iso-2022-jp?B?ajhNWkYvc2t6QTloT2R6Ym1zWkl2TFhMS2lGSGJEdnY1SWhPNitKN1B5?=
 =?iso-2022-jp?B?c200dE9yNVZYaG4ycUg3ZlJRVll4VXQ3ancyN2hkNGFaNjRLc0dIVjdM?=
 =?iso-2022-jp?B?ZytNUDh5KzMyRHJLZ1lJS0pQYy9SUHFwWmlBbG9LVXN4ek43TmZMdlJr?=
 =?iso-2022-jp?B?WlVnMUxKQmNqNGJueUlHdm5wbURpWXh6MDlQQlZ0Nm1KcU0yV2NHSlhW?=
 =?iso-2022-jp?B?Wk13cWU1UnBtbU5sWC9pM1QxMjFNRC9wVTdMTzNsUEw3c2NRNjFMMHNV?=
 =?iso-2022-jp?B?ZklXYWJ0Nm1VNWJSQUkxNDViTnRpc29sREhuZ0dweWVkK2l2MWM0NFM5?=
 =?iso-2022-jp?B?cmlhaWlXY212QXRwNjdoYll4dXgrZTJVS002TzBmc0F1RGh6c1pZZGN4?=
 =?iso-2022-jp?B?Sll6SCtHZEE5WUIvZ3RqYW8rYXRVSnVGQ1V5WVNsZVhaSUdDdVRBejZm?=
 =?iso-2022-jp?B?ZG9QZ1owb1hFRlluVzdPQkZHU2sxb0RualZWS044czEyc1hCZ1J6dlZR?=
 =?iso-2022-jp?B?Y0FSNnhOZ1FXZ1Fjd1pnZmlDbEZaR3p6T3VYM2FyQm1WWnM1emIycU5i?=
 =?iso-2022-jp?B?SkRqd3UxZ0JTcnIxQ0c4cTVGeXJlak5sc095dHlhRFZBTVZ1UDJ4T0Zu?=
 =?iso-2022-jp?B?blk4L0ZHb1JmdDV6ZWYybWVIZnNNSE5MYjViUkdua2ZEblRtOTUyVEt3?=
 =?iso-2022-jp?B?aUlhRXJP?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR18MB447991F513FCC7FD4579ABFDD3042SJ0PR18MB4479namp_"
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07a57af-d7da-44aa-25d0-08deb2659159
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 09:37:23.2786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCXKf6XE/3db7kRo8WhJeWQJeM6dxNZs9qA+Q+b5rGK2lUmkXQ4Ht7mAPeFr1ODk036gJxDCogLGXRawuSY3GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR18MB927682
Received-SPF: pass client-ip=40.107.201.132; envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--_000_SJ0PR18MB447991F513FCC7FD4579ABFDD3042SJ0PR18MB4479namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Ping
Please review this patch
[v2] Add Axiado SoC AX3000 and EVK board | Patchew<https://patchew.org/QEMU=
/20260430091832.1846637-1-kchiu@axiado.com/>
________________________________
=1B$B4s7o<T=1B(B: Kuan-Jui Chiu <kchiu@axiado.com>
=1B$B4s7oF|4|=1B(B: 2026=1B$BG/=1B(B4=1B$B7n=1B(B30=1B$BF|=1B(B =1B$B2<8a=
=1B(B 05:18
=1B$BZ@7o<T=1B(B: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
=1B$BI{K\=1B(B: Kuan-Jui Chiu <kchiu@axiado.com>
=1B$B<g;]=1B(B: [PATCH v2 0/4] Add Axiado SoC AX3000 and EVK board

This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
The model for Axiado SoC AX3000 supports
  4 Cortex-A53 CPUs
  Arm Generic Interrupt Controller v3
  4 Cadence UARTs
  1 SDHCI controller with PHY
  8 Cadence GPIOs

Verified the machine "axiado-scm3003" with following command

qemu-system-aarch64 \
    -m 4G \
    -machine axiado-scm3003 \
    -device loader,file=3Du-boot.bin,addr=3D0x3C000000,cpu-num=3D0 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=3Dsd,file=3Dobmc-phosphor-image-evk-axiado-github.wic,format=
=3Draw

Refer Axiado website for more product information
https://axiado.com/products/

Changes in v2:
  1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm
  2. Add axiado_sdhci to support AXIADO_SDHCI
  3. Move implementation for eMMC PHY device to axiado_sdhci
  4. Use UNIMP to create dummy device "timerctrl"
  5. Add cadence_gpio to support CADENCE_GPIO
  6. Enable Cadence GPIO controllers on AX3000 SoC

Kuan-Jui Chiu (4):
  hw/arm: Add Axiado SoC AX3000
  hw/arm: Add Axiado EVK SCM3003
  hw/gpio: Add Cadence GPIO controller
  hw/arm: ax3000-soc: Enable Cadence GPIO controllers

 MAINTAINERS                    |   9 +
 hw/arm/Kconfig                 |  14 ++
 hw/arm/ax3000-boards.c         |  52 ++++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 262 +++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 312 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 100 +++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 +++
 include/hw/arm/ax3000-soc.h    |  99 +++++++++++
 include/hw/gpio/cadence_gpio.h |  66 +++++++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 17 files changed, 1010 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-boards.h
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/gpio/cadence_gpio.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

--
2.34.1


--_000_SJ0PR18MB447991F513FCC7FD4579ABFDD3042SJ0PR18MB4479namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ping</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Please review this patch</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://patchew.org/QEMU/20260430091832.1846637-1-kchiu@axiado.c=
om/" id=3D"OWA16a36802-2d85-83b1-c6e6-21f851091e96" class=3D"OWAAutoLink">[=
v2] Add Axiado SoC AX3000 and EVK board | Patchew</a></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=1B$B4s7o<T=1B(B:</b> Kuan-Jui =
Chiu &lt;kchiu@axiado.com&gt;<br>
<b>=1B$B4s7oF|4|=1B(B:</b> 2026=1B$BG/=1B(B4=1B$B7n=1B(B30=1B$BF|=1B(B =1B$=
B2<8a=1B(B 05:18<br>
<b>=1B$BZ@7o<T=1B(B:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt=
;<br>
<b>=1B$BI{K\=1B(B:</b> Kuan-Jui Chiu &lt;kchiu@axiado.com&gt;<br>
<b>=1B$B<g;]=1B(B:</b> [PATCH v2 0/4] Add Axiado SoC AX3000 and EVK board</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patchset introduces Axiado SoC AX3000 and a E=
VK SCM3003 for emulation<br>
The model for Axiado SoC AX3000 supports<br>
&nbsp; 4 Cortex-A53 CPUs<br>
&nbsp; Arm Generic Interrupt Controller v3<br>
&nbsp; 4 Cadence UARTs<br>
&nbsp; 1 SDHCI controller with PHY<br>
&nbsp; 8 Cadence GPIOs<br>
<br>
Verified the machine &quot;axiado-scm3003&quot; with following command<br>
<br>
qemu-system-aarch64 \<br>
&nbsp;&nbsp;&nbsp; -m 4G \<br>
&nbsp;&nbsp;&nbsp; -machine axiado-scm3003 \<br>
&nbsp;&nbsp;&nbsp; -device loader,file=3Du-boot.bin,addr=3D0x3C000000,cpu-n=
um=3D0 \<br>
&nbsp;&nbsp;&nbsp; -nographic \<br>
&nbsp;&nbsp;&nbsp; -serial null \<br>
&nbsp;&nbsp;&nbsp; -serial null \<br>
&nbsp;&nbsp;&nbsp; -serial null \<br>
&nbsp;&nbsp;&nbsp; -serial mon:stdio \<br>
&nbsp;&nbsp;&nbsp; -drive if=3Dsd,file=3Dobmc-phosphor-image-evk-axiado-git=
hub.wic,format=3Draw<br>
<br>
Refer Axiado website for more product information<br>
<a href=3D"https://axiado.com/products/">https://axiado.com/products/</a><b=
r>
<br>
Changes in v2:<br>
&nbsp; 1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm<br>
&nbsp; 2. Add axiado_sdhci to support AXIADO_SDHCI<br>
&nbsp; 3. Move implementation for eMMC PHY device to axiado_sdhci<br>
&nbsp; 4. Use UNIMP to create dummy device &quot;timerctrl&quot;<br>
&nbsp; 5. Add cadence_gpio to support CADENCE_GPIO<br>
&nbsp; 6. Enable Cadence GPIO controllers on AX3000 SoC<br>
<br>
Kuan-Jui Chiu (4):<br>
&nbsp; hw/arm: Add Axiado SoC AX3000<br>
&nbsp; hw/arm: Add Axiado EVK SCM3003<br>
&nbsp; hw/gpio: Add Cadence GPIO controller<br>
&nbsp; hw/arm: ax3000-soc: Enable Cadence GPIO controllers<br>
<br>
&nbsp;MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 +<=
br>
&nbsp;hw/arm/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 ++<br>
&nbsp;hw/arm/ax3000-boards.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 52 ++++++<br>
&nbsp;hw/arm/ax3000-evk.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 27 +++<br>
&nbsp;hw/arm/ax3000-soc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 262 +++++++++++++++++++++++++++<br>
&nbsp;hw/arm/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&nbsp;hw/gpio/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/gpio/cadence_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 312 +++++++++++++++++++++++++++++++++<br>
&nbsp;hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;hw/gpio/trace-events&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 5 +<br>
&nbsp;hw/sd/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;hw/sd/axiado_sdhci.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 100 +++++++++++<br>
&nbsp;hw/sd/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;include/hw/arm/ax3000-boards.h |&nbsp; 28 +++<br>
&nbsp;include/hw/arm/ax3000-soc.h&nbsp;&nbsp;&nbsp; |&nbsp; 99 +++++++++++<=
br>
&nbsp;include/hw/gpio/cadence_gpio.h |&nbsp; 66 +++++++<br>
&nbsp;include/hw/sd/axiado_sdhci.h&nbsp;&nbsp; |&nbsp; 21 +++<br>
&nbsp;17 files changed, 1010 insertions(+)<br>
&nbsp;create mode 100644 hw/arm/ax3000-boards.c<br>
&nbsp;create mode 100644 hw/arm/ax3000-evk.c<br>
&nbsp;create mode 100644 hw/arm/ax3000-soc.c<br>
&nbsp;create mode 100644 hw/gpio/cadence_gpio.c<br>
&nbsp;create mode 100644 hw/sd/axiado_sdhci.c<br>
&nbsp;create mode 100644 include/hw/arm/ax3000-boards.h<br>
&nbsp;create mode 100644 include/hw/arm/ax3000-soc.h<br>
&nbsp;create mode 100644 include/hw/gpio/cadence_gpio.h<br>
&nbsp;create mode 100644 include/hw/sd/axiado_sdhci.h<br>
<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR18MB447991F513FCC7FD4579ABFDD3042SJ0PR18MB4479namp_--

