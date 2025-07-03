Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5A5C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHWv-0003k5-I2; Thu, 03 Jul 2025 06:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVp-0002sG-6e; Thu, 03 Jul 2025 06:49:54 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVm-00077s-QW; Thu, 03 Jul 2025 06:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9cugSPcc30sJ7mvy7yQivrrtl/JU/Qk8AGvs5QOItl4G1vcBnNXXR/ZlgQhcFX+uMLmOIFD47TVQSlPDwr6JUoaTFIqkMGjIcYwpk6OWfyMaRVemkW0Aae0Y9TRA+Sp+9/osuqaY+CpNk1mGbRmT9fOV8TAJPVDFXqBU8j9BuZAD9H3oDQFW8y/u1TzKAZ+S/IX4XiS2D3AZ0nF3kglRyCuySSVWxCf1Q1fhauv4ez3szzzBGVoFuoeE+72C71hdlOc6B16597oMuxCTuL0M8HrgIBLIQkpobz7tcUJzyaM3uomBkFcGBQeyQdpsLDuEfGVp95eezAq3YoI4YMizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYnXFok9sL2vBI6+8XtIhryPuowbivR1e/McEtF0trI=;
 b=gt+eWhoe0aJ2iR+Fk8mXxUQ09PIjDV9klQJKRl7t4bejwRwYzDcn6o7aOV/N2Td/415QmTj41QjRFBELJ8VkAFp7QaNNua2B7lLaUmfZN2psSUsiPSUiHxUFqxfdGeI9EH21ZKCTixIgKfKhzJt8RQatc7vfJt+HTUP36QijTwrbsdI40z/lB1OmjwRh2iFVL4xsT4bGBD5RHRg5qf968a34tPUl5knsvbYxvdQjsf1u0fcekgHAYk6BXAEmICpXqseQteSuAVj5p3n0GghHqmz1y/4roD884JbDuySLeFxMweKT8ZiCQPenQYKxjQJgB/ZHhmfrJwYKsjEziEIz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYnXFok9sL2vBI6+8XtIhryPuowbivR1e/McEtF0trI=;
 b=HRIY18WgMHsGjzZMqaFoetHpuOARhQZr/x3AJMeV/kXK1uQhdmCVAQElpzPahTF6kMIzk23HsEgJYUTszHdbMr4tStYM/daTxjzWWJNdYqZ87ZShhIRud7eHgvIiJbcZhiDrtKtAOu0urRSWxMOlUrPHcod5xdPDNuHoyIEDO5O8V1xU94sIY71ZkhekjLLynQyIKBYjMld8MPFqXMFaJLzYDJOiZBUW6QFo+ce9nOiaT2teeAhaDaxXRJHtkl4TSnyoTlSUKw11WtHDNFTcNCfRj6ph9BcDunya+PXIrxf+iL64XlU3VPGskUEgsyrPMRVfUujWizvhe07kX+dA5g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI2PR09MB7288.eurprd09.prod.outlook.com (2603:10a6:800:223::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:49:33 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:33 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 04/11] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v5 04/11] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHb7Ago7NDXxks/akuuFDOR7lMF9w==
Date: Thu, 3 Jul 2025 10:49:32 +0000
Message-ID: <20250703104925.112688-5-djordje.todorovic@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI2PR09MB7288:EE_
x-ms-office365-filtering-correlation-id: f6654219-39dc-4726-6ca5-08ddba1f4b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Rs3nXMnDSyaZGwMNLIxr+/J8qfSMWj0/niBBqJCyFPAcvIL4g6iXB5yITs?=
 =?iso-8859-1?Q?hAr/LxBs62w7ddczflxrRWCDaLSC6TgKWh4zuX05LzZqxziHaE48VZJPzQ?=
 =?iso-8859-1?Q?CwlxCQeB1Cz/D3h/TS/5Ei+uZXU+24Ei48NN+VSRnLxhNSaw6KT9lldsYr?=
 =?iso-8859-1?Q?dRXEoyr5O5eWr3x2Muv01cguo61h7OXnIV68HradItJB9lKlAlcHHmAky2?=
 =?iso-8859-1?Q?evAZE715Eiqe37IKAbzcy/CSxeOHFLf8WSbkjCVaSLOzCdFT5q/Kxkriqt?=
 =?iso-8859-1?Q?la4bbYMp7Uvg8QH020Xqb/siIFuFQZZfbquUfstNUiRBI26gpWDS1pbG9Q?=
 =?iso-8859-1?Q?r+hSe3l5MD/0ijITQBiwAhSQfeCtk4v0tpDCjHgos0k1AQTEIaXiHrRrEy?=
 =?iso-8859-1?Q?+Z20lRplpjR8NmOH8xGTIOCDxQ158SiofuoGSLNhS+I5ByzMt5klatK7xW?=
 =?iso-8859-1?Q?D95bXX0Trl0959yAsRwUtAPeZCyfD/XRVAgcHylbtmmRGALXddhnLKzIXi?=
 =?iso-8859-1?Q?yM5s75cBkqNbtN7CVMDUOiax0oYSvHyNiSXw30u2H8d1RZ4JoRQn7hqigY?=
 =?iso-8859-1?Q?TI03LZpsU+hVMm50K9pLkKrAJs+vOpiX2bAuG56Rvh+MeK+/YgTAqmiAjG?=
 =?iso-8859-1?Q?5IqAVrjDgdbFuN6nCQPIzxXeD+Yr1DBqPF0B2bQP10KzGSUeYrn8J01z2/?=
 =?iso-8859-1?Q?GOrpD+KduWgLDxkb9Z6wKAO1RvVLUyuo6etNxk7K1A32E1B/ke+HUXJLEE?=
 =?iso-8859-1?Q?x9yVYgfcKIZlLEC7aRkQGl+2LysrLw8a6ESA88LzUYNXXO0f2VUJlIcDQb?=
 =?iso-8859-1?Q?pOqLhGUa8G5wUvFhOWCI5eNA7/mOQFhG3h9MBXUq+Upllt8K7KHZ0v5Esl?=
 =?iso-8859-1?Q?gr8LT/hiCwiG0K2PV1fOCVI3dEZFkfknNVfspRprebKKoEq7XxCXL/RFf1?=
 =?iso-8859-1?Q?zEIb/P30/61sYFZbO41C8NQLD9xqlel+ArrORrOsyEbn7/ptxmcJi93TiC?=
 =?iso-8859-1?Q?5bXDq28hWo1vntzUkaBsN8nRiM+vTRKHwHoB2od+m782vpdlUMYRT70jos?=
 =?iso-8859-1?Q?tFjvI7z5fEczX3ARsOs1U+jfjsOqsg244yvhQpli4Ku81KJA8g74zUzbc+?=
 =?iso-8859-1?Q?vk1JMaxcn6YALll2l0eCH0HbDPeYlUueeuNQqUOCA4dAm6rwhh4A4YX/yS?=
 =?iso-8859-1?Q?ginjDq7cHJYJpzuTbdo1Bfuh5BbnDyFjM/USihWpnhhh1ewZs3U8SSy43E?=
 =?iso-8859-1?Q?5mMZ1cgh4KvbISwYZ+lmpzW0G/60cxoRM2QOLKmkBYRVTWxnjCXHqB77Vl?=
 =?iso-8859-1?Q?Yn790etIkwRBKKUAHzSdCCnH4yxQbAgd41HQDpIM5GUZEAkFC+gHQ2Av4f?=
 =?iso-8859-1?Q?IoereX0CTcfb1EwbIFUAfVF+gXutYh4Zh7bQcFYlDMDlLUyi9dFR/P5I/i?=
 =?iso-8859-1?Q?qVDtxtcBVZsqEmPVeaiAqY+MRXgx4FevhfIg2w1jyEBlv5T1PvaZBwjYfn?=
 =?iso-8859-1?Q?EFZbWeg+imZh1WUBNlx7Ynxjr6GCE5xTeFLHYj8Plkew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?85CySjCQC8rtBxemHchu9ugfef814RzYOeY6e2jCgQ7Si9AQeiLXL66McA?=
 =?iso-8859-1?Q?rXmUrstkla50ewtIh/rBscWck21nwjmnjFMgMCleZKN1EmemXtEZZg54R9?=
 =?iso-8859-1?Q?dMuXFkGjG6SlQDzAFf/L/Q+0eWQX2pe6DSR+isn51fM5v23hVY4WXjcl2L?=
 =?iso-8859-1?Q?R/zGmlFHjm3HEJPYQEO/Cb6TFDvDWIEZpZRghqV/uB8kLLpnyP0Q+cXGSi?=
 =?iso-8859-1?Q?feC+qhrw3Oe8LRUZMlALIaKqxbncLjdx8ihG7r27siPW1lAOBKRGQyP5Ud?=
 =?iso-8859-1?Q?5fS8VDYScbOzCk1VWabCYuKEQm7bEB+0/85AU5hvn4hmqosK0YO68GR8Oz?=
 =?iso-8859-1?Q?xDBzkRKP+gDiiaHwt/Knu2nz0D7/1hhNZppdBYSmA2R/tDOwy2sl5quDTW?=
 =?iso-8859-1?Q?uc1L8tNyDIRmduDG/lVz9w9q3Xg/FJqBBktK6CpjBhh5anoTawXmJqzjV4?=
 =?iso-8859-1?Q?qgI3ZlKEDsDAzdpS9iud5Ai/GRMh9pF37iGffslsiCrsPzfgDBe1gyXoXW?=
 =?iso-8859-1?Q?eHzhaRhEUWAFOW3FPkTAdcDnUeuCfRKGbOD12JIaeX02bXzyYTHQTMERkV?=
 =?iso-8859-1?Q?jqX+x7kMr/ISEf5Iy3Jw4kFYrcI+vTcmbpj/iXr6/YyCkyRm0gWF3+Mrpa?=
 =?iso-8859-1?Q?Pf5aU45P90mG72jjslPR6Iom1JAdHGvuAoLwTD9K3mwaiLhuLlEQbhCdqx?=
 =?iso-8859-1?Q?V0n2LzxZpuCIO3QGGl4bzpBvHKUYbM5EbAxgZO1qKUJBi1UmWZRfeeVAg8?=
 =?iso-8859-1?Q?3lCeXNYsiEByB++Y66TC+gCKedF0zjKTzIbfc4ugKWV24YtDujDilJCrZM?=
 =?iso-8859-1?Q?xA8MlKtIabKtYMARlTMCMJJ+6WsLl9ESme3bgLt4SLyIy9lh4B4MWdXApT?=
 =?iso-8859-1?Q?2vHWaXWfaGjQrWq9FrBZ9Gv6aph6JGR5XUWhIz0snr07AUVQnwYc++Dx8W?=
 =?iso-8859-1?Q?2GIirh+XIFdBmv01A1Y16LasVkkyi7zDWosR1Dnqg4caLKx/5OWCDP3tS5?=
 =?iso-8859-1?Q?V1BEIDR7ZC2/yoQLbJ/eo1ECafeWtV9EsZ+WJ331yDvhP6qh8NFhRtE+45?=
 =?iso-8859-1?Q?XnBZjhmiemerWtq4Eo1/gNuKe/LR0T/1x4JirHWASqu5Uc8EZA2IjStj6y?=
 =?iso-8859-1?Q?Z4x82ihP4mssPqJUKqDvHzkMA/WtuD7xk/xzlygk8L4x6f5MUxXCKtA11Z?=
 =?iso-8859-1?Q?Dlzz+4NI0HIqWstk3TF1dAjfYrBtFBkiC2D93Vad41ir/IvjpBuS4NDTBE?=
 =?iso-8859-1?Q?8Af79QOZL9sUzuNG/4rmZxx+HE+wv1qYHfOg5zhj2quo7KkmvwDvzJV9TL?=
 =?iso-8859-1?Q?iB9e8hdyrFLyylKuEKF/zVGWLQq+AUYfaK7TS2QxiM6XmnPlSsn29zTRys?=
 =?iso-8859-1?Q?XLaRIjaS8VcuL9CxTPlAiWJ3C8Ld+nhL34+FE5lFXx3Uoq25RuuVofU0Ki?=
 =?iso-8859-1?Q?ZUm7eVEuJs2gZVVlna5vLGeVg9o5OqVS7nQwXrsMNvFv77784+r2LafjhJ?=
 =?iso-8859-1?Q?vu7e4OaVwlhEnHcedlVG8EVM1AE5FzEuuLFA6Ynfi1MKtwnAvjAwMdIZRl?=
 =?iso-8859-1?Q?Pla0aPh9by1vi2WsBSV0C6JLKUyhUGRezhy/Egp+32rWTONvZMPPgfa8iS?=
 =?iso-8859-1?Q?AGdX30Rujh3GuyHyFHPO3R+d2LKlXcbn6bMrcjULCOcPaLpOThdsGSAx5Q?=
 =?iso-8859-1?Q?IJ1Mvhukg7f3vl4mYjc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6654219-39dc-4726-6ca5-08ddba1f4b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:32.4136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iooCsOvljmxRz0RKUHlCE89W3O29vgfi3knIsL0XLmFxRz8eNxEns2v8VEicaLaVCWSwKUlQSJkpGEXpJ8a7Dmz1hxJe1hTpweYO1059t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7288
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 226 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 401c0f6c7d..7f453acbf8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3193,6 +3193,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fba0b0506b..ed10709a65 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -972,5 +972,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..fbb6c8fb45 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -32,6 +32,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..759d5e6a67
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,226 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];  /* Fixed: was 15, should be 16 */
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

