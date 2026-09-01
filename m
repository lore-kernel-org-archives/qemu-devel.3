Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EC6C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jey-0008EU-49; Tue, 01 Sep 2026 04:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jev-0008DO-5o; Tue, 01 Sep 2026 04:15:57 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jet-0001wa-Dg; Tue, 01 Sep 2026 04:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuFmP4C0wX1bhpnMJaLua4vjTRgNulOUN9mIoYDw221ulb4vaOapQwrWCSiUk74916QI64le7YU3dTbODVkHJFzazTgoUdO5ZYkZT0Sf6HH6MXHiiJiYUXXjV2O5yljnlT61u201IbBqqUBVyw/cgOn13TFgSN9U2Vt9qnAQpk1RcjVw7ANe7a50LwAT4NKNp3I+Wp4bJLIPcSGO8gX5YihqHHssotabNv0BrPOe6kZP8qF7tk42SKVuEHJXR+gG0f8+u9P1iqCbPDjWN2BW9586tr0vDPrasCrpexQZmJhl1TBWvLO46DHYCnZUr+qyDUmnxbIFQI5q4CCqC07jJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWZwaYbR27mg+n341fXRwM9QBw7OxQhBVWtBy7YJdTo=;
 b=sQiOHxhxy8tm3z4H3ZKD3kc1W9qeLDCrHuE+w4XKUd21cdq2Y4haimz7mEus9oAxTSKP1AWlcsO7/9HTXxv6BBfmQdQnFqCT3pUldBON4J2c7z5QxVJodG6qtR6doCYbiWYuKOQR1uJf4HTza/8HphAzVbUrvHJ9fw+QA0Cc+j5xgaVcZTL6OLReU7wvtNxRDN2oLhpVSHkdcJgsrWPBGrqjF0G40hBtYKR0Rte4gBoakY3qW0QrtpbzIskVY0lxSmbnYEl3PFK/B91e6Xt4JVUSLaoRS6ZTaSwZdRLuFnt39N6I2oi1Z60ebvxEV3u1xSjMU2cBlwz+WxS9KBceHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWZwaYbR27mg+n341fXRwM9QBw7OxQhBVWtBy7YJdTo=;
 b=Gj1WsEXSdDSXCRiAngyN4JT+wCiy7Ill3MRpobND8hAVy+XdQAqL7FtUm37q2kxrgt6uV7twOgRDCJNanPEQBtT3f4KLL4L9pB5tTLWlOTcHRkauqxVynjESqnS21HrjGPKUWrP6Us89Ja1WTwDRVQj24hkaQYsVW/A7JdR4+D3CJc+ZSPWX+BJrlJGlj6uRFqb4/D0cjfTPaHtwiEW3LSqyz01nIol67KBJxuUlwWPYm7QD5bgFfc/H/v8MrfatSjlb8Xb6nUS0eOeQyxxuvnIGTBhDyhRkLJ+Urqzr+4QvVP1GW036tHzd7TX1TlXzCOyjTmRy3EM8uu+cnSPnqg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYUPR06MB6151.apcprd06.prod.outlook.com (2603:1096:400:350::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:15:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:15:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 0/4] Add ASPEED ACRY RSA model for the AST2600
Thread-Topic: [PATCH v4 0/4] Add ASPEED ACRY RSA model for the AST2600
Thread-Index: AQHdOeoOg+VpFs4KlU2yRpYhi5f9sQ==
Date: Tue, 1 Sep 2026 08:15:32 +0000
Message-ID: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYUPR06MB6151:EE_
x-ms-office365-filtering-correlation-id: 869f83ee-00ec-466f-75d1-08df08013164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|56012099006|921020|38070700021|18002099003;
x-microsoft-antispam-message-info: 9e98iPlOz00TvIDTDiU6Bp1XC4RCZQh2TMA4X4SGjpU/59Dqy8GtSvirSqf5GKVkXwM8GmlGGZF06fBBtW/2M1PLLnU+A5mnmMiq+UwTVevpfebq5jH5WMhJOVxC3yf7V7S4nndFxh3Stiz7kQ4n6Z6K4ii2PbbFzNfSinuZQfyz3IcydVh4eS/3k0KgIa6H8JYbOlHg1A51XpcztI4D9NvVjAPxaggoJ88uJu9Ii0sffkPJEhyZqMqSj00pbgSskuYfz/ioNCwxoahzFvTk+N+MwgXE66K2h8HV1Cwx0IpCy4umIiOMJ1/tMeAIAtq3jU/W9pgY288bhuSRqjKQFbxCm5QzVQqYytq4D9h1ElChXSOs2Rf08c0B6jnw9UI6m2aSVl/nN3xlmIjDC6yAu5dwYCiqUCWJRvxoDIBRQBG/YXXlR/FdS6N9vshd9Qj6ZMPXBWMJySTr9NT+/xxvTXs5FRYv3hkBAYYtUS0DJTErbaKB1yUZhJ5Zrf6wplflDoQWOb3rLBo/xehZxsQqLtQrsVTJRwK1LjatrxR1hk83QUCN9fQSeuBLskrUhj+kaXvm1J6PlC/VLSyDJLQyevqm+i2T2WvMWM4BVEERHdQSYrZLsNGw7+5VlqZx0WAuhaMlFD1BaPMDm2vnfnBcMbJAfH4U0aj5rXzrz8l67mWpM0qP0rd8dttcUtyChYm9pSwHtKfOBfEMjYh+ubdPJApli1GwNGzoB6qG9dMgvptktqkULeFsAdZe3u20XMBU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(56012099006)(921020)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I8cWXsLOOkVoDPlvk9TXIRnxNf3da/mEy55YlprNn3Ooy/5V97vGvJ29BB?=
 =?iso-8859-1?Q?zXn0zxDtVet81MYpCY0b0zqULtxZoO4JsCREgzpjnugAIcjSG8Nv7BGt84?=
 =?iso-8859-1?Q?l1jVvGzJlj7BeUXI8I+lz3RD+iQ/oiQOgW8U2QPGerpOpRSm+2m/o1dd6e?=
 =?iso-8859-1?Q?Ung+gZJlruRCyPHQJYyXML5Io+085cCNS7DdW0NSOTTaItoJODxHiSMFrd?=
 =?iso-8859-1?Q?S92oIDjiBJS2y58YDe2OFjouUSfjdn4sbBjc5bH7kykaKVtSlzY2Dm7Tza?=
 =?iso-8859-1?Q?UvDTp7z7DXuKqrKoRud3CM5JGUfHEyNn84yd+4c2b5ByIgekeQL8oO/52N?=
 =?iso-8859-1?Q?y0AcDhDIO64HFMCbR7zC1Qlhxd6sJXMnrTe1onJZw2gv8HP+Ln+tP5ZiaK?=
 =?iso-8859-1?Q?6DfgL9Y4Qfd7DJPlik3mZWWgoYIZYjErc8Zc6XauAsleF3EpTvZwD/usrb?=
 =?iso-8859-1?Q?r74VzE4zgm9ZFC599uruMx619D318eI+/ydYaxHfjY3hXg8bo2OQQik4m5?=
 =?iso-8859-1?Q?b/1LqlsjFUznn5NjCGGIaFw/HQd1cL7FWGrwEPJI47WQLBHbbvDZC2ZWsW?=
 =?iso-8859-1?Q?l2rW6dwUHwvu9jzp9wIe5p7MKi9R5ZHlng5eBYmBFSBaokFhaW/Ld5bjex?=
 =?iso-8859-1?Q?DmxROTpg70RKJffCWftjRrWq71UqjuRUE/OLTJ863uN1UUT7ON+Oz4XbNo?=
 =?iso-8859-1?Q?q70FeMpvok1bKIAJoCDW4o4aRr6w/YNO0rki0sL6rZsh8BhG5YmcrlgQjF?=
 =?iso-8859-1?Q?/9pf2iptosHn+ZP2j10vg1CQEyhdLmdypU9IY5gSeqxtfpJnZt/FFqg3Cg?=
 =?iso-8859-1?Q?20WdIQ45Cku7F1wm5kXeA6R5GjBW4aFQtyq+AX4w16ZFChQeCtwsBdW1BG?=
 =?iso-8859-1?Q?iU0Xf41aROkTDHM25WAa9S+w3HGEXBMH4aGpTtafSLI0fEWArI6OGkOLgs?=
 =?iso-8859-1?Q?MOoZDah6ZLa1xmBMeUhl0V6IDK0Wrcetxefo/LxHOSV7kkTLxYnS7AlZCm?=
 =?iso-8859-1?Q?UVD5SEfDG0/NsR+sqsqnuEF+b2VLaC8sJjXTiYNrcz219gXL5EAVzDgnFf?=
 =?iso-8859-1?Q?Mw/fy0AFaass7vGwnS8L0oyX4/eBHagzcwA08tXQVUtHrn8XrP7loW3F0K?=
 =?iso-8859-1?Q?7mWUo/hBPLwNxnSpWunfx87YTzJ/TPdZLeNYdjX4V2X63XwFrQKlqpZzZI?=
 =?iso-8859-1?Q?g/QHVbYBT7O04O5/06FOarC2Nf8n+Ik/5OvU3sFMEL5i3WZz8iWZEVWvCD?=
 =?iso-8859-1?Q?cZd4unh+xrkE5LC2mQlFnzAQhE9aCiqSoA5hC2+ZKKkHh/300VENItJNtn?=
 =?iso-8859-1?Q?VEbHM+oeisHJCGRY1rsZE0se0IEecsHFvXI3QkBPY4A75+uQJ9ijvrpm5e?=
 =?iso-8859-1?Q?30zMHJZGvRBqN0Lki7D4iR7Zy20iLnSBdUV8nIB/gNY4nui5t2ef9HI6MP?=
 =?iso-8859-1?Q?fuYYOeNa61+HwL0P1ownSsuu+6UsRcPsd4bDyBt0z5pPdEBjkaLT5zANS1?=
 =?iso-8859-1?Q?HT1klQ/u6Ojasvk1O2J0+AQiOihaZR5H5KS9NjViCJmSBjtCXuy0tgRZD5?=
 =?iso-8859-1?Q?0zD1rr+5X1NqKYdq3wl55MPMMcbtYcTEmv5hkKhOGSX64OaZq3MClbeLao?=
 =?iso-8859-1?Q?Ne5THCy42RmOO4kisWrrFnV0FVDW/3kBSj6qFwhk+YYmP7KArOgHl+dEgm?=
 =?iso-8859-1?Q?EA/uj1JjXiNKcQ3sKpzyzsvHRrpydV2nK9LcfDSfVXmGGRjMKAFDIArYQ5?=
 =?iso-8859-1?Q?6stZxA2p0eKwLpI15cZ0HEGR86ze+x4XwqIuhBZjHc/DS0bMe0PVmeAkm6?=
 =?iso-8859-1?Q?HyNwTj3ZGA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3uBFN90yQcjtB9CH5Jyfaygf/Zr28hrH3OGfyqx0f79Q+vGo/Q1RylwlBDVF7aQdTCLahq5SKKbDv9TcEfujz0MmSQv4mBwO4bnvJwcxoLYZmouomL8eWhBdgGBTqIx/1cCtsFAD74+s8rfAEKNkDNpwIEP4XhLMkuq+F46Sg+NrHwr7pD8lwPA4nedk7Gg5os7Ru0ke+irAguB1gNNlreKQSNDxg9vdwKdpjK3sa9PzOTPtw29AaScsi1z3OBnpLsS7JdV3zf0lbBiaGjY0tHRPpd+yHpl1sugL4TSZjj53lZyoKtcvoSuwHQFC9U8yRbpmg1pSRoQdzQPn0vLVYA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869f83ee-00ec-466f-75d1-08df08013164
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:15:32.6120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJIfr4wTXsWl98u3nrQBQoHBuyKP8yCztNgccvTv5T5BinhvF7dGj+KEz3PauVdYndHNInAkcn/1CFAMJJezfI0J8wRFYeu0QadfB3e9rZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6151
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds a model of the ASPEED ACRY engine found on the AST2600=0A=
SoC, wires it into the SoC, and adds a qtest.=0A=
=0A=
The ACRY engine performs RSA modular exponentiation (c =3D m^e mod n). It=
=0A=
DMAs the operands (data, exponent, and modulus) from guest DRAM and writes=
=0A=
the result to a dedicated 64 KiB SRAM region.=0A=
=0A=
Guest firmware uses the engine for RSA signature verification during boot.=
=0A=
Without a model, the guest starts the engine and waits indefinitely for a=
=0A=
completion interrupt, causing the boot to hang.=0A=
=0A=
The model uses QEMU's generic akcipher API to perform raw (unpadded) RSA.=
=0A=
Raw RSA is currently supported only by the libgcrypt backend, which can be=
=0A=
enabled alongside gnutls with -Dgcrypt=3Denabled, so a build does not have =
to=0A=
choose between the two. When raw RSA is unavailable, the engine still=0A=
completes and raises its interrupt, but returns an all-zero result. This=0A=
allows the guest's signature verification to fail cleanly instead of=0A=
hanging. The qtest is skipped when the selected crypto backend does not=0A=
support raw RSA.=0A=
=0A=
Although the hardware documentation describes both RSA and ECDSA support,=
=0A=
ECDSA is known to be broken on this hardware and is therefore not modeled.=
=0A=
=0A=
v1:=0A=
 1. Add ASPEED ACRY RSA model for the AST2600=0A=
 2. Add qtest for AST2600 ASPEED ACRY RSA model=0A=
 =0A=
v2:=0A=
 1. squash "Add the ACRY model to AspeedSoCState" into "Wire up the ACRY=0A=
    model"=0A=
 2. wrap the ACRY SRAM in a container mapped at offset 0 so the device=0A=
    addresses it by relative offset (drop the "sram-base" property)=0A=
 3. build the scattered SRAM byte offsets on the fly instead of caching=0A=
    them in per-instance lookup tables=0A=
 4. write the result with address_space_stl_le() and check the MemTxResult=
=0A=
=0A=
v3:=0A=
  1. Return early when the DMA read of the operand buffer fails =0A=
  2. Replace g_printerr with g_test_skip=0A=
  =0A=
v4:=0A=
  1. Remove unused macros.=0A=
  2. Dynamically allocate data and src_buf to reduce stack usage in aspeed_=
acry_do_rsa().=0A=
  3. Add a helper function to clear the result when aspeed_acry_do_rsa() fa=
ils.=0A=
  4. Add bounds checking to aspeed_acry_operand_offset() and replace magic =
numbers with=0A=
     compile-time constants.=0A=
=0A=
Jamin Lin (4):=0A=
  hw/misc/aspeed_acry: Add ASPEED ACRY model=0A=
  hw/arm/aspeed_ast2600: Introduce the ACRY SRAM=0A=
  hw/arm/aspeed_ast2600: Wire up the ACRY model=0A=
  tests/qtest/aspeed-acry-test: Add RSA ModExp tests=0A=
=0A=
 include/hw/arm/aspeed_soc.h    |   4 +=0A=
 include/hw/misc/aspeed_acry.h  |  39 +++=0A=
 hw/arm/aspeed_ast2600.c        |  34 +++=0A=
 hw/misc/aspeed_acry.c          | 481 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed-acry-test.c | 406 ++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build            |   1 +=0A=
 hw/misc/trace-events           |   6 +=0A=
 tests/qtest/meson.build        |   5 +-=0A=
 8 files changed, 975 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
 create mode 100644 tests/qtest/aspeed-acry-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

