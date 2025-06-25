Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4529C7EE31
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUWSU-0001x5-AD; Wed, 25 Jun 2025 16:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUWSS-0001wq-Pg
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:11:00 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUWSQ-0004lk-Ij
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:11:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiWCZX3RiXL+jtDJ49OvfGUUJvgl1K6PQ8sA47dr7E5NyTq/Q1ppNLpCEy6n/MhiXLLIpMe2GlJJASfAMy9+K7gfBPJPmprqgRKzb/k21jfaBdaLyFIzAsroyt4hBQsIBoWUPH0L7gV4gVq/DHw+9E6Pj+OVADlE/Q0vaLR4McyVrKvYaP30KeMpjyZILa+zJ7m5Opcd05EW9v00FTclyHE74cXmLaNHOEw7LKI5eBpz0qSgIpCGRLjIXD8piZxcuf6kZhlZW9giFYVupu8SQYZ3fRrf0Hk/2R3r2u26QBxkC1YbZaJTt7/IKXh84wjQpEN8r3PWqYtWIy2nlHaLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay+1upKGD0Bm/V+6J4MinKRU4wNc7mLEh+AChwTTrrc=;
 b=rLcJtJYKi29Kg4yEJ2gKledU3lI4BVwDUQ1309v0CsoROPrTbNj7kGT3YpQdMJwMVIg0xeyjtYx4AVqiNIdmvK/F55zAFjAkc3CLyeaYFoHHDRzx+ytgI2sIybKkTDqDpiSOy90DiWz51EvbYPbCGyW3xSewwfyRTGK2AuweJhL7UmKpR7qmZzR6Lg9CB37RawBZ1zGulNYZKdcP2l09U5TQTrhjfSTxz1lwKljedNq9O6VIBPLRQf1OzMc/K1DYkBVZovm/Jfn4upEC39/n5CgtL3kfzRTBa07ZtlyPCQMLQbHFu0DmJOnhBP5Rp0uM9uu/lOeMWAg2MgBhxco5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay+1upKGD0Bm/V+6J4MinKRU4wNc7mLEh+AChwTTrrc=;
 b=IUTBQdCBMimVqKPorNLrIbWe2BEHjQRygZgGrWMW80POfXSso63UiXhnuKPeOF7zwenxmXM1cEN7Ak0DMs+ahzrHeiH+2oUckLVIlVQinmHIeBw2DZ4Ic2w6gmk+bpWW1eSVax6G6pofmvjV70EJ7/I59ebCbAC5YFRYX+89g5EJbxYPFRNji6oPZUs+1W7d5gKAfKAonKwLIbSYsSWPy0vetvEFW/YUzZKcsnNpx6e1zgc0L1tO8/x4dlV7ogGjSmoI5Nfo37FQZajVdPJbJZTM+6x66xWVx5XVgD7dTgUfI/DDIH/zPnt3AaSFJLs9ey3/JDSwjp8U0m5bz73xvg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by AM7PR09MB3687.eurprd09.prod.outlook.com (2603:10a6:20b:109::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 20:10:25 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 20:10:25 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v6 0/1] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v6 0/1] Add support for emulation of CRC32 instructions
Thread-Index: AQHb5g0ty47uRcKYlUaPo4qVlFvYrLQUTiwA
Date: Wed, 25 Jun 2025 20:10:25 +0000
Message-ID: <20250625201005.1480421-2-aleksandar.rakic@htecgroup.com>
References: <20250625201005.1480421-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250625201005.1480421-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|AM7PR09MB3687:EE_
x-ms-office365-filtering-correlation-id: 68fd6be7-5b11-476d-8be7-08ddb4245274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bUsKdDyRqBgtBb7o53l9iIVQMg7BqKFuwCaSZwA/61QJrPluAAbYXbJzCY?=
 =?iso-8859-1?Q?KcRpgo2xzQVaCWll/GsRYlnlBN3dTVMtwYzuUOS5tjOoUGVJ9fFkMk3ral?=
 =?iso-8859-1?Q?rWBGwPnQJTD66cbQeoFIB8/ZDJNLwn1+97VGEr/risciF9C7y10FRcvX1Y?=
 =?iso-8859-1?Q?T9Fs7P7EOkwureqKcYN+IP/iR0o4P4q1iKzUBuSOSzWdXmvGIb9qgz15fb?=
 =?iso-8859-1?Q?VmO1kFSTMELHwY68OR2n4xIYzWRzDSn04oqsgDjwc1+ImMDBG7AXIacF4Y?=
 =?iso-8859-1?Q?iLIo7+e33ChUZ1epTKqqkNY7Lqf6DO3pgZeH0Rn1+HgYkaoMNKAFqZ1GZ4?=
 =?iso-8859-1?Q?1hEFT6r7tG4wzKCU5MfGMiXazf7tUYRsUModjoRCnjNJMy/yIhI9gC0g5I?=
 =?iso-8859-1?Q?/6p04pKGPzoxajT9MjX63n8SKuvAtp2LoJ1jb+3hUM3MIT1LvDhCNJLtob?=
 =?iso-8859-1?Q?o65FJh+gpjxzxSqYyB5xn51t694BXGFSjq0swJ4S5Ky9fhlFGB8N8wVwEQ?=
 =?iso-8859-1?Q?wM/r1TxmrTB0thwRb3PscogVufOdVy2aPZooTzwIrhcIHTYl/K44MJWi3R?=
 =?iso-8859-1?Q?T/J0QYlAe+3J+CSWZFNLfLseA/oDroWh5L8Cds4h4KX61ZVJfpyflNcPnk?=
 =?iso-8859-1?Q?dbu/uQEdJHIQ8hqD4MBVR44odDsr2eItGRPKhle6er/+TDdnTDPR4zZQPJ?=
 =?iso-8859-1?Q?Fcgq7Dt6WhZIDZpnlvuT8Lg6k6I8Pbw090BcR5Wv6KCgYa/r/bgWnajIJM?=
 =?iso-8859-1?Q?SLoZS86As8X9JMSftyDvcpGnEGzyfHPYiczdjb/Lw1qvXkOlqNkJAkiibx?=
 =?iso-8859-1?Q?fdffrstK70ytKH8BOou0Bw+1gls0Ouw1X/PRReueoQs3Q2MpZVN/K7uvz6?=
 =?iso-8859-1?Q?4Dm/OTWJ9Dk+tByP7UkoeIWUBFJQ9MXw6y0rUYITlWWUVBvtl8zUqNzMIX?=
 =?iso-8859-1?Q?UlUwidBC6R6kGFvxHAs71BnIXLSiipwendZE9Jjl30IZFQc3vFnl/QHbt2?=
 =?iso-8859-1?Q?BPo3zJ7BUOnNLbEdpqEITlYoybNSUtG8nR/ERegrTzf9mJcGgBLo7lnfjF?=
 =?iso-8859-1?Q?SH72j/k5npeOM14/EglaM8nKksIF/nC2GOITU8caAL0AzgTDtvrSFFpcYi?=
 =?iso-8859-1?Q?5YF+pBgJ6MWar0R5dpjD6jJhuSiAnt9sfewYnydVFFdentjq+xApNsiwie?=
 =?iso-8859-1?Q?FN8oYCRrdryQ6jSM3PZM1jbyA8Q278X6UKdicy8mpSZybFhpt7J+2OehOv?=
 =?iso-8859-1?Q?R0RfTQYUEE/BfpOhqiqG1Bo1NpJmDYyCJ33wEqGF5pKydaCyTGGjTBwDDG?=
 =?iso-8859-1?Q?5wMUTHnvSAjnY5KUBY6oVDK4NOn9lQWam+otdbGKX1cu+gshHlYkWhYbBG?=
 =?iso-8859-1?Q?5vW1mMJHnQXwIoUtvYHIm+zUE/NJ/3Nv4UQWM3QIZOve+0824khwrSXQN0?=
 =?iso-8859-1?Q?260sh7baINrb53M8OazzuUMN2kJgh24cykBMqkItL7mxjvl4TdXx4faG4F?=
 =?iso-8859-1?Q?cnhVlGkPX7ssvpW2a8kLRIrKGW+fsRFBZY4Je45H678A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S9lMg9C9zhMnP4SsCnPC+Lf8kG8zYdcrBt3p5M5EHWtssTRlNPXFnTkC1/?=
 =?iso-8859-1?Q?xo4qld037MPUEjAgtbeV75cJDwNXSWdXXkCm5QjUyUhxYxdSnHwqRKhOnH?=
 =?iso-8859-1?Q?zfVW5UNSM4HaT8hU5duARPasKV1B8JMpAHbNiNq8HwMVNsOUq1iBzuJBoH?=
 =?iso-8859-1?Q?0SlpH260ZDrDcH9QT2cpstiehBjYAiGbgmKq5o9jlhLdxocfUFH3FuBuzG?=
 =?iso-8859-1?Q?33+MXUgZ9rm75sZ/AQPDp+nXPIjnSnOJiYGEeWxo6b7kAq+oVM5Ps6dLFD?=
 =?iso-8859-1?Q?Fkgu9FEopkHL6cglu8Tv9bgkYOdi6DsUHalv1ct7AjvlXmOrzogzXxNCxi?=
 =?iso-8859-1?Q?Nel17C099RVG5GKhh5SUzr2H3PgoWw/3ZRp0PeIP7VoMfGOqFWJItGz++2?=
 =?iso-8859-1?Q?SpdlHKQOyyUytPh2hHwYl9MOjeI4z31yhDzTdMLnlBur7l1dZ+xhAASSO8?=
 =?iso-8859-1?Q?RJqlrMWmkrZkyNlCg6yfLTD6xc4zx0sm2rQVWRDDa7RVX92VobU4lTe46d?=
 =?iso-8859-1?Q?MwRjE6ZaxuK4WRmP6OW9kIwOABgwf+/4DjLvW0PaEnfcipMyBjNvC3YhD4?=
 =?iso-8859-1?Q?OQ+4CyGLMuRv84PzNinniP+MKiOcm68f9ySn0QaQUPLP0Un8bUIc+fIZMv?=
 =?iso-8859-1?Q?/y3TK+pc+HSwh4tGWqJZZNdmbM1MCwaRmuTIy0DA+bweTdQEUNcXoVch0k?=
 =?iso-8859-1?Q?jxtHaTwuDhDZwmoNFJMtUw3rI6sfpk1XwmyM91OHoGl+nLVcEmXg3qGh5e?=
 =?iso-8859-1?Q?tE/0lu70dmwNs5B9dfEo7Lum+BXERNy9c+OCPuRlcGuJcILBohpKnelMuM?=
 =?iso-8859-1?Q?MzXy1SEyKSHwxnSoAovWRfK57XR5hRVydLgakQi4IxiUTSSeazsCaFb73j?=
 =?iso-8859-1?Q?OTlL4n6ZGYt7ASOd5RHqoHwA7qd0Ut+H5xAa/pXlwXeYDfkR/JXRHPe2L1?=
 =?iso-8859-1?Q?fpHzN5BbW9dtSo6MGMenygCH3UXLPMT2i9jnpj105Iq6zTCh/RVxMK4zNh?=
 =?iso-8859-1?Q?bYogMXBrsaB8w6cwKw/o4HpDxO5wTuGNGuBliDswieA/y+TuFt8XKn48XN?=
 =?iso-8859-1?Q?MyZLRlkBdVIcud/a0Kk0dSOo+JUTMbKsEieyc1/J8PeHjNEVlCFR0qvIqN?=
 =?iso-8859-1?Q?YPn7vx7w9I49234MreCEBocESL69sVJeqwXQ2Za/4JQ+Ho5ifcd/xZgmru?=
 =?iso-8859-1?Q?Yq5PLqTZluPbkIVRhViKxaixzFvaM80EA3BaVanug4osdBFSz231ICqNlM?=
 =?iso-8859-1?Q?kxl0AE2M54CQl6J4hyfyh7u2eCMjYakRyY0YBCAJixUmoTxDFgmmUVMvzu?=
 =?iso-8859-1?Q?vXL9KIoIkbRbYxnfGjw4rSonUgOnSQ0UIjPdTgrAZvgQrnyokLSarR2zTV?=
 =?iso-8859-1?Q?+Y9+COHLQlSa7AoKAEdE7M9mWC35JNl3lCBpZ1QutPwS2JQMxtrxO6EV+0?=
 =?iso-8859-1?Q?/T8fIsyKONOPqprnZao4lD9flrwQhMJz19vFsWWeEQmmoWxDldmWZwUYo6?=
 =?iso-8859-1?Q?HUcGOWzcjLx4ntCax+l/4lmbh/aUw/5/GgJ+3hHin4mjUBmuPpeKYDvb/d?=
 =?iso-8859-1?Q?pA73vkg8j810tsNkbux2/5shlhLEqmATFfkqnwCruM2mOIcFxsR3tOCZCJ?=
 =?iso-8859-1?Q?Wm2DkG4TVxprtun+1+U+b85MbqlYT//qPC/jk83UOgvRFrUJuMJc31Oc6c?=
 =?iso-8859-1?Q?F1tqt0BLc3GYbM37V9M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fd6be7-5b11-476d-8be7-08ddb4245274
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 20:10:25.1142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6ZpWFRCD5HYEpOG6tz7Q5rWBq6663ltnORvuzRSP3itOIfGGP7RuPtl/JZ/qRrURZXgmE6P3FIitpaAr4T5Zc2DChrgpVz4biECWAqac0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3687
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Aleksandar Rakic (1):
  Add support for emulation of CRC32 instructions

 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/helper.h                          |   2 +
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 ++++
 target/mips/tcg/translate.c                   |  37 +++++
 target/mips/tcg/translate.h                   |   1 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 +++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  42 ++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
 16 files changed, 1287 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

--=20
2.34.1

