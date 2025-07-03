Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB2FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHVr-0002sU-Ai; Thu, 03 Jul 2025 06:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVn-0002rb-Rm; Thu, 03 Jul 2025 06:49:51 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVk-00076R-LV; Thu, 03 Jul 2025 06:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB4gZT9R/jYxiDEDP2drHPzQk0XVngjesbI73TGKVCnsDnDUXMGqM1v5T+UKDQCWt7K2TktCTycSRSkFDsKXwwru1xwJr4QAaWGSiLOdU07H8IK7wxrsW+IkkSmilTLyVbWSj6NMEHdK8FWpC6Ap5h3DyoyN1es7AkKXBA6aShkThPtSz/Q5N8zzbYFUxI+i5ez1N8DQ1gU3Lsep1s9+adVtmRJ6gdlsByOHcMnqmyo7BjsSCZwz+jaeDl0HmfL7Xy0hYzlAtEG47174Hm6xZxdlD2EAf4d3akl0uNOZXBQAPQztY2LnEZ975hcpMgEneyDu1mbvZyI9z1jj47wXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2ff2ziNn2+GX5awih+lr4Qq85q9aJz9U8M4bimKwDU=;
 b=y7hPTHPkh98WY2cPqvuy16eEwyZ7Fwrnon8IPGKBYv7x4VobEB7G2ULjxKoBIZ/y+CqUr5VX4bF9W2Mao4pJ7z//OzpBCE3pStzRPxRGwMRgNivr3J0U9FPsS2FJAHPqjuUAdkPlwwNodtdHQS2jVfuiUKgnJIimeNlLIM3yWOWMoiW1LmHXvXWuPFCgyJ9gez12z8tEgeBAr1rGBWd4AXNi31TnQSmFwPBBNZ1n6ymdMNoIeqw/7uvI0QJVfxDWiaXJCkHONhIxtpJa5tawEv/0hIkurbbNLBk+tNMQKsIqFWKM+PUErbPcC5y49JbTozq8u61Zg6XdCl0NNaV4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2ff2ziNn2+GX5awih+lr4Qq85q9aJz9U8M4bimKwDU=;
 b=PJDd0iDuK7hhZ1lOxlhQ4D2DZIlxeaNlyx2WoCSt+0YopexSOQnPccDrF8KIOpsXMMXhuYqjz/dGORZ1F+ufYPN8PvTUPMSUbrtMVl+vhx4765LTbOkISSTClsgjCBOvVczNfoVnjYnb2rq/2tRRtOibl6N2QNM6R1gEdipnsJ+YaA10RVqAoMUOMhWHltCiykUrh+9mO+slzzFrieG6bH9CU0NLay2SNyKlKQhPsM9BkJZRljcqnUYM1nvspp4l5RCR9JmmOYHOMSG8/4cxTBUPmXrGKGiRXa0HFHe60txAiqEfCbDJ3TfaFIjkN1r8qVV0beI2a0OB10wHyW/S4w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI2PR09MB7288.eurprd09.prod.outlook.com (2603:10a6:800:223::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:49:32 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:32 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 03/11] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v5 03/11] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb7AgoRwYXHRZfn0iGaR1GHjo+SQ==
Date: Thu, 3 Jul 2025 10:49:32 +0000
Message-ID: <20250703104925.112688-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 9d498c34-5223-4585-7799-08ddba1f4b39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?963TTyj/f9fFZVbIKLcnH+LwjOzBiJjEHEkop11lf41Vokm7FRAT11wz4Z?=
 =?iso-8859-1?Q?1+RHGFGQnNlzPjzjwQ1olWAik5TNz6olr+8tJdbmxR2bdNvEFSlna2drlh?=
 =?iso-8859-1?Q?qz1ylRmsvMZ6xs4aTQJ+Jp+UprcG6s6Q8z3vFd7yeQtZWOjHHCpRuLM+Mk?=
 =?iso-8859-1?Q?Wiu++kaQ1rjECpBjE5d3WB2HbiycGUtuFJCmmZJ6/mAA2tPitexRXfcCxg?=
 =?iso-8859-1?Q?55FVi4aMFvSegBE/RgI/1rfEwW4or5xcMf86cXMEkQ75fCbM5chQsDesKv?=
 =?iso-8859-1?Q?xOHYIoOHmF1rqJM+behFQlk6EPXBhC8Ikt1MZQNd6KUQ635cuuJYGPJ0J4?=
 =?iso-8859-1?Q?+rbL+SrxZ7o+QtRvonxvvkGw9YJanWFEIrwHXjr9tcLRPTVekzQdoX5MC8?=
 =?iso-8859-1?Q?TE0c80FO9xsG1uNaedz1hgyfLyf72BqcwR1ZW/n4jEbzAM/K6olmFPQze0?=
 =?iso-8859-1?Q?kUlmJcLHRj+7Z5c4ErAAkAS1hNPAdEWEseKf5JeSaRW3jQxbanmKrQsLyw?=
 =?iso-8859-1?Q?U6zWTte76oULiYj95vRTIcO5IDy4Zydwg1AHdRAu/klg1A6TFgIBe2d7QM?=
 =?iso-8859-1?Q?kQAkdHlfeDQskawe/zrAWdfVa1VzYVyuLQ5oAE6aVs1xWx3vKmUPIhXInL?=
 =?iso-8859-1?Q?RiSuMek2DqWdqFrEm/174uYTMt8x5yYJvpFopNcVdVZNpcRiUuxquZaxQV?=
 =?iso-8859-1?Q?LFq4n/gPDcPOL4JFKVuRgRy+BQ3kep8hHDnNNje7Fe/z9G5hCUMxNNYC6P?=
 =?iso-8859-1?Q?xXQVholsfQNASn3NinUSZ0uGpnZqv3O3QDe8qRaZUnm13GD1dOGUeSbYdp?=
 =?iso-8859-1?Q?ahey2FRw0KA4wR/Baj6dTf+m6AgOjmzHKswlXQGeqGLBG7j4Q0I++8DvIL?=
 =?iso-8859-1?Q?9GqPa2OBeoAyPmgOr9b081+E6pvHMfbBSx6XPoTq5p89GCwEbHB1hQot2T?=
 =?iso-8859-1?Q?lNp42DgoD7kBzYtW3BWFKvDgkvIKECw5IglSrgcZ5z9z0vLMNO+HHg9GPK?=
 =?iso-8859-1?Q?aRO7ElZkqpJWqeNx+f0u0smeZfUnS8GKELn+pjNpAyt1cckLMW1PsVZZlg?=
 =?iso-8859-1?Q?MEPV8ykzerWVmcT1hEb2+Z357bPi9PpgjNvnEne4zPgovbPRRQtFfGlzYL?=
 =?iso-8859-1?Q?Q02b/RV0hUurJu8DRiUq8fQ8fB9AuGtKiP+AakuKgsoMNFtH1kcw0qE9nf?=
 =?iso-8859-1?Q?/0JjRK3JhS+ZwLCZOaEpIoZPLSU7/dPIfKoPjSjjMLwl2pyog3B4LZLOYL?=
 =?iso-8859-1?Q?qY12C27j6vdlXNN3JFvPZEkwKOYfy0XPSL0avMWGc0rHkWYZ4lVC+S1C49?=
 =?iso-8859-1?Q?0M/CWhUwGvQuWBEdRoVvVyAFSzByk8yERSqAhuCr7rfEyYToj5RjlV+5Cs?=
 =?iso-8859-1?Q?XFaaTq6HyQ8SoO4L+/O8B3/2wIqWRPPccUq6rjnfz/KyC4cP+fDijDmPfi?=
 =?iso-8859-1?Q?8D63zPRdNiu2vw7FeDEjQDb8BJp7FAvxsFIGhcaxZw+KuO2szgXUya1QGx?=
 =?iso-8859-1?Q?ncqoZQTmmyQcp1Dau1dmY0LLDoGUHqB1bY4XTP0gyHtA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r51RNKWiN31m7xXR7a9NGM1yBQnF4FM37ah4dQo71eKJSVIVA8yln6x0yA?=
 =?iso-8859-1?Q?joRoGOw4tPZkLaa1lML0aiMoY2OdzMLCl40jPfYqiOilYgnMipt0MKo24f?=
 =?iso-8859-1?Q?F9WBFYaC/vxk5efB7ztjcRuKLtzyvwcSyry/DyVahBDbtj9FyHl556/+Dr?=
 =?iso-8859-1?Q?FzVkcrM2GkJU9ddT6pYYgtxPYLKfmp4nNy/RsClC9c1pf0ZHCmQGEbUzSf?=
 =?iso-8859-1?Q?NIBBg3dTAiM7T+CGQljdd5soFolJsdaD8EuPMiK8qpfvD0AolQIDirVvpa?=
 =?iso-8859-1?Q?KV95j2JnxKDlNeBP3M+klevYEDrjoS+rDbl39mAKaa/+DIqoFJyG2ibZDA?=
 =?iso-8859-1?Q?EwOsYnEMZ6N+LzwSE1jI2FwRtNySHpVQJuTmg0w8QAPBah6rok8yAaf1KU?=
 =?iso-8859-1?Q?80Z10OC55ERi9KCQsm5jSe9LhjuHxBcoZs5Eu8ueLX93+LomG51o1n5FbF?=
 =?iso-8859-1?Q?OmRhjQfDDVEOhHCiBT03N26tQ4Lv7wrih0Q+0KVRisNOeIx2vSYGtDMzyp?=
 =?iso-8859-1?Q?flseyoILZ9CqWpM9+kzNny8WISfJNxkNF5TwBY9VXuV4X/lHOROQarJl23?=
 =?iso-8859-1?Q?blGgN96H+Y/80VkASA8ibBqyvxZQNE9HHHUwDWGS+NoQYqREg36YgDPgFR?=
 =?iso-8859-1?Q?5lSEX57WgQ4Ap9APIhI0R8rFNBZ4WSqbXwYxGXxNpOJ2uHPusLDhIaiLQT?=
 =?iso-8859-1?Q?hOg/5z2nmA7rLKj6v8zbY2EX4QlMekxX4EJ44d2HvWYeqSQ1oC05N6HRNG?=
 =?iso-8859-1?Q?wdaLeUTrHCIrkhqlL+9aShkf3TY0dyXVtNP/5mzFThLYWpJXgHMTlcp9gw?=
 =?iso-8859-1?Q?N9O9E+7L16cGlNd4osIDLO8mhi7y5OfnSgW2C341cWKlcaHjPo6A56DRCt?=
 =?iso-8859-1?Q?lPnq8PsT4o95cDkMjFPZO2TqBkzzM2nDS9h8pUKH8kKj+szRig2+5sCxdo?=
 =?iso-8859-1?Q?uS0YWFFtxOgdS8TGolbKu/qyEz0gUSquA/SIZ6bwrrxPyGpNLccqx0BSQK?=
 =?iso-8859-1?Q?dO7b7kdpIfq2YrF1rRZCZ6kXT9QWOWv0O5APTOm8Iy4jLApCoppSdIkjST?=
 =?iso-8859-1?Q?Zlp2wdyteTxwbpeoeW/NiI6sLudoN2pU7kIRiTz52m9UfV38l62yOUyBzD?=
 =?iso-8859-1?Q?56Ofe4PvirelwsQ8VrkMPH9PfXPOeTsF6X5dmIdB6GWl97/nbQlGNJd2f1?=
 =?iso-8859-1?Q?DXtPPc0x8QKxx4LLvBDONx/yVCVoMJMCa/HhN2BhmMXsajhkH6gnpv43pT?=
 =?iso-8859-1?Q?mE2JZogsP76WCs52IeVMn93SvpvImN3enl6zB1kA1iAik5O2OYoThtzrKk?=
 =?iso-8859-1?Q?DelPYwm5X/c8YYHxKsu85z9PsDqTiAL7rnzQ1WKzpcnVr7Xk68170Apfrf?=
 =?iso-8859-1?Q?DjcUDCKIe81O3H5/v7jkrUMfm7YAgG2d0VIq5f9YpVvogoXPzpUjP7CiUw?=
 =?iso-8859-1?Q?JjOqwBsqO7+a8brJG73VZSdgIyOilUrSYLiNJRuclpEVQwzgsYlSDYhfc+?=
 =?iso-8859-1?Q?TBYpOrjdhSXUBGZJDHD9lVQazXYmqu9/1CFyQ+LJE31Q+XiG3d8trqUk8Z?=
 =?iso-8859-1?Q?GPWo8jF3+eFqirdA1gTTSUuz1wZMalGDT+klsWT6pLiYhrvE7/HENTmmfD?=
 =?iso-8859-1?Q?1nbJfkyXysayqCqD8e2g/96eIjsrCLb10t4+ktVfYOtOpxv9KqBuRypQSZ?=
 =?iso-8859-1?Q?XiTfCtuV6sYlaOkEc40=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d498c34-5223-4585-7799-08ddba1f4b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:32.1111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPnWC4xmcDnCY9n9kaUJQGr1eoPuo7MMgiwySelvBTmw3W7fB0R2u3sc5cZ6EK6/k0ymxH2i6nHBn9F5YABqGICDxPaKu57TO1d9Wqb5S+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7288
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 15 +++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..1e62b96094 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e584bdc5ac..401c0f6c7d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3180,6 +3180,21 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV39,
     ),
=20
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

