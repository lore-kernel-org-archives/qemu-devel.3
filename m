Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C6606A32C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=iBUPBSWC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGF-0007XK-Hg; Mon, 02 Nov 2026 04:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFI-0007L4-62; Mon, 02 Nov 2026 04:22:33 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFG-0000W7-Lw; Mon, 02 Nov 2026 04:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gyjn4LB6+PdZtvqQNEOUdcBHK5wTtbHvJlOdRmJVquNlseQaaQWpjwWHf78Nyk9Ot2qnU2Ncy0XDUGrASoEMNo6r/Hb1jkMHm+FVKzDbXqR51tNdrLwJpxpWkVkdhXF2hLOKY1tSIark6S5k7+nH5tZ5gjaGTsvjekh6Z820cI5mNU8a+WawXfENSOJDSnfX5VjaCIkxLPNcPDIjcdvfT/L2rwB/AqwuqFBhO5mGQN+louEAGM4hjnt68Pe5Bjje8KOyH0SfuDbl5luE/+vnK5pYaYGr691Sk9LgetEQwy4z1pfqYL1BZvUQa7Om10E+QGgUc9niIcOL5AjH2jvBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J9hw3nrZMuGs8jMFjazW/vAJ+CqVwyt+EmnecSmrgw=;
 b=abLL23A+1D9u4RGAkbd73j83KraWYBURQNSsjGbAddvy6pE00kScIGFLjYIurCgVkHGBK9lCFO1C9nsJQ4I+2KASOy8NHeWx1/5U9qO6a6BMpdP/kR+lgXXETKx1wqLmnGjH+Z5nM9JSHQcVKMX5UmuTGMW3SyDYPEf5snCdKnnXHjHR0Ahz23OwWrX+59ZtOOZ1R8e+XsSCEO7o0e4MDGrxMzz59PaUO3FOH0T4nytrQ5o3OMqazlXlBDRnZMQqvDjCgZ+Dp+C5ekzyl3ekvuR48859yM6eH/yWm5+BYiiYnZGkIG8q0WspQIqAx8D0vGNOiZJz+/uU2DvRfz/S+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J9hw3nrZMuGs8jMFjazW/vAJ+CqVwyt+EmnecSmrgw=;
 b=iBUPBSWC18cOS+WnFIYcfhlpg1QitVXNw80T8bDrQN6pEOZYEnuAOOm2sFDDqgyRL2C/9JG4nOmGjg4T5WcBA1AaXRFvgISvSUO10Uxx/C+357U4+3neCw6p33sndZKenbNsKxTyiH5YBkCKGMdrryTN/7WOb01Efj3Lh3LHyjHJE7OxFERXS9x3CEZf7VfWw5/s11MWenREnIYqWxZ9pnzVmZuwCV5ROZ6H5u7ZaHv95Kj41KkBiofNfayjVoIDFQaqHPitJLe/G7Ie1Bc+5GksdjPflY8ZGi+gBT55mwPLXUMneupu33VD2UNJ60scnOT5ob9qD8vvVvdI5fcJGw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5265.apcprd06.prod.outlook.com (2603:1096:4:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:04 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 01/18] hw/usb/bus: Add an auto-hub flag to the USB bus
Thread-Topic: [PATCH v8 01/18] hw/usb/bus: Add an auto-hub flag to the USB bus
Thread-Index: AQHdaqufLoPY3HwMvk6g+z4FKihsFg==
Date: Mon, 2 Nov 2026 09:22:04 +0000
Message-ID: <20261102092201.1729245-2-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5265:EE_
x-ms-office365-filtering-correlation-id: 227b7a28-a186-40a4-1695-08df38c2c24d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|921020|38070700021|56012099006|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info: 0O/obyNDU2v73IbP/75EQlVLECLaWrJOIL6PL8uejeF4g34gkXh7y8zCcFCqH6Ds11T8oxZb8CVLTH8qcs4+ytM7NaJ0Ua6npDmbnGk7+LaK6UK7b6RCplu8BR9jRZqTYmLhsFfR/yO9ewTjbZm+q6J002RNwuqsNwfntPLlN2pWeOHlUqbEeYPD71Y9uGeOeStsXd+CZ4WbhlUG2Urmn35hFuXchDrzQlWyezTDZ7CA93gMSzZhXUdbN01l1N7N/1p7ZKPzOlIDJJRmxH1qkS2kwRRDWzePGdlW7zkmROM25Mw5rwRUNXBYaHmy8SZV7BIYUKUbXxQqsjbvZPrAxrrfuEt0VyWB8PmV9AGzqkEiTPUpY8fQGoeGa1Ay9nVRvFwbbdvwSxuZz5xdpUgyuj47wPsk64iGgkhSt69eyuYr7aNUAjX8QGSfpfmC7VAGczK0+LAMlVyE4rHJg4CRioxQYG2WVhlw6SmYgXRcMliYUO4GT0ztWRAGyDHKpyzFlxYxY57YgvnpZ6y5L+u36PXhbrz4t6HOBklMTTZ+rRfEJVpl9sITQcjhJeCnDPR8mt8KP5Ix0fl+S28dITIz3wCMVAa+B4H44WqoE4xE/Vt4afulbnu6wLupSk0qayxWEGmxgjJJ3d6GbE3SCe4/c14o2PNqDtNC1TSesEifr+uFxpVIgiGYatroSZFKh2/vZdQ/EnyBD9zGe2XZQjdvCfl3lxyLC3jg57so+f53VM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YAw2mZiHmdeu1t2tbeIx8gh8Z1P4A27dlF66VX32Vr7xtW8b6OsHwvGjXD?=
 =?iso-8859-1?Q?zR0nmXbAshMpo5/vG8qz0L+Q5pvazTGb3e7g+Adm0EXOg13EkDGc5dGOFh?=
 =?iso-8859-1?Q?XCKkJd4ar9Y0Lp6gyBctlt3vkgvedRAldtnNb1apqMX9vOuifGu4wLQRdm?=
 =?iso-8859-1?Q?LnT7/QhRhxWsfkULSWPCJaOL4FrUaQaXv/f53eeqocFXAD9pX/psZZ1UF3?=
 =?iso-8859-1?Q?pRAUSrOewCMitbR/VEI9uR25WBhW54pJvFpVqMZqzJR+hU1+qDyJSe2E6G?=
 =?iso-8859-1?Q?kYjWZdx+ttS8b/5Gn1DxcVyR+ghj8nTb0lJgxXt19ZhtsiIybHGJAxf8bd?=
 =?iso-8859-1?Q?vUmF9Q+f70xAWFZ5N+1QvZfnrbUxPTz/C55hm68wGXsiw29Xf+Znlbvy1S?=
 =?iso-8859-1?Q?fHbo+gw3F6TWm5Ce2hO1bEKlEiLWqnEF2IQO9KLmtPxcsQqPraulwI/M3o?=
 =?iso-8859-1?Q?GYZAODKIqNSHvR9aTiNTjtgOUU48nOkvj0o070xOGI7S7TLj9SNSSM+B2/?=
 =?iso-8859-1?Q?jquZrmzsyddJ3GRNT3FcjGsTl9eJCE0Hv8ZwWVfvozQvLyKNx6Z8dybu5y?=
 =?iso-8859-1?Q?BptG/mkq5Bsa66h2WSdbsoAw4JpvM3w98ZcRhmXBxE9nTvWwMh/TdAKzaP?=
 =?iso-8859-1?Q?T+jY/VdCruviPxkaJ5uTEVIynzVvQmmFaWsgxRSXybY8u2rEVxg53gf5m6?=
 =?iso-8859-1?Q?TaMYql4E2csIV0Rj0Z1X7vAfGnTRWhhzhrU2H5YxDPr8DuZGcK4NrE7D2r?=
 =?iso-8859-1?Q?6B4gq691ydTMGRTP4wStQl5s1Lpy/4AsCWxGSsQUvbb4RXhTvWOltfv332?=
 =?iso-8859-1?Q?S5p+xLk6yg/8jPKK0dqQ8npDiKNXrX7wE/HUfwdiyVEhYfhOlkDz6LLO55?=
 =?iso-8859-1?Q?e7LlIecXLWpP3epHA15bERTriYCzbDGD0jIDs4yEU3u5cHpCMZjiGiJL8t?=
 =?iso-8859-1?Q?3wVIw1T/9mXoiJiJ3BEQDcbqP2dcNT6Hprr0CIL+e452rqiTW7cpsdlInY?=
 =?iso-8859-1?Q?eH35udjE+Z9nqi3VI2in7LIg8iLZ+emK0S5erLyL3PKvoK2JTEtHTUnK88?=
 =?iso-8859-1?Q?pbcGWx04P2pGomZoGbgHjNUfEC4a4LZnT+wduzAjgS67M+SMZLUyNKID8I?=
 =?iso-8859-1?Q?Fcpkeci/8ouRR1HdHpxDZL9CjJWNauDCNdWMnOZlOHjVhMsEIvVraFUaz0?=
 =?iso-8859-1?Q?z5Axi3XvKkGgmkHrKxbz3iQdVx2X+zeqctTwqBvRqXDdszy2uRFFFU/HD0?=
 =?iso-8859-1?Q?sIrHxNDiXTYs9TWPolM4+UHNaX9/YSC8hcfB3P1BY5HzDDhIy73FhO1gT8?=
 =?iso-8859-1?Q?BvbYkWqBBs6Qqx/Wy3suqqYML8tTpwRsKvpSjX1a3Ht8o82hlkEVhfvnPp?=
 =?iso-8859-1?Q?hUaGPNQbuE9j6SAY8PLbZu/eeSp42/3XS19QN6JQkUnkMkff8HTjlWidMO?=
 =?iso-8859-1?Q?kFUM3Yqsa5b8BIxcQyRo6DXJ/2qoLYNl4qAdGSVThu4VLSsAXm+owbt8I3?=
 =?iso-8859-1?Q?2nzCgSGW6BoJMo1wrJ3Oqs2Byw0SuR3jzN+I/2g+QqFuoZcSXVeW3HN+J5?=
 =?iso-8859-1?Q?Y4ikKudwK4XNeHKVfnpp5HymbCk/wpVq6+xcH1Bz4G7hkF0luNq5SNbyNe?=
 =?iso-8859-1?Q?z8otUJ5ktEdbnGQum/mYg9xoqJXUX5V1Zr8ddTwUUv75NYZBnyGMK4hN6f?=
 =?iso-8859-1?Q?ZiPqt1EwKgLTYU2pKGhNAxytjZct7Om4RGW8+pAdK4mpnnsHGGB38w07Rq?=
 =?iso-8859-1?Q?apjkuhMy9sVE58ejCziIO5IRBHJji50PlviXlk8ywbrTBHLlqL/TLxrhkm?=
 =?iso-8859-1?Q?ph7K//+2gQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YbcnIxKQKycce6RbQN+4KaX5VROZdTBnF4Zvykh19cMgjoLYovwgmCBmA8DWvnZrEnL4HHlPDczhBxudEfeP/kserASOFyKjvT93TejmoLWNr98ftHuX1HJwhOsvwYib1r1YbB+gu32uPqsGwzD4aMKPWBueUwTSOfPC2Uj95dCg5zNPFSQm/jP7jBtopYXFGnka9xVfGzyOwCe1meo4+pAXAr3emB+h0wEHEmUGocCtyoEsAPVAvAfmLBuNpQ4ROLA72CaJ4h2W9m7nvD+dxyJ4WwL+bh2JNfXlsP+/pv1kCjXtXVPAISErqAYnDxJYfgXUuATF1bMXLBpIVQ8PCg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227b7a28-a186-40a4-1695-08df38c2c24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:04.3647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4z5nZvU28MJlOyVFWR/L7B8HUuZq1PcZximqRBzU4sIFZf/tcIso/aGcC7qY0r+15iNGbLyJEl+2oR5G/kbDlYYH+7XyN+S6OisOxJOulk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5265
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_claim_port() plugs a usb-hub into the last free port, so that more=0A=
devices fit. Every bus gets that today, and a controller cannot turn=0A=
it off.=0A=
=0A=
Add auto_hub and have usb_claim_port() check it. usb_bus_new() turns it=0A=
on.=0A=
=0A=
No functional change.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 4 +++-=0A=
 2 files changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..cc1d6d74b1 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..92f67de4fe 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -92,6 +92,7 @@ void usb_bus_new(USBBus *bus, size_t bus_size,=0A=
     qbus_set_bus_hotplug_handler(BUS(bus));=0A=
     bus->ops =3D ops;=0A=
     bus->busnr =3D next_usb_bus++;=0A=
+    bus->auto_hub =3D true;=0A=
     QTAILQ_INIT(&bus->free);=0A=
     QTAILQ_INIT(&bus->used);=0A=
     QTAILQ_INSERT_TAIL(&busses, bus, next);=0A=
@@ -413,7 +414,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && bus->auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
-- =0A=
2.43.0=0A=

