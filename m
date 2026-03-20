Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068BD1098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQX-0002sH-Mn; Fri, 20 Mar 2026 11:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQP-0002la-Dr; Fri, 20 Mar 2026 11:06:11 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQN-0002Q3-IJ; Fri, 20 Mar 2026 11:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyzrwZmWaURxmQxIt+stQ1m+mx1a1kQGVmAPi8ZHFhf6DCWnuHzXVkZJgU5opdpy/NWt/i2kJT902eG968KTN57T588U1/7SIegqnawCcwTswz86aieEUyM0a3D87P3H0jHksysc0bH3D7B3VSE7/FonXJAfv7Li1mRMYnDOrF6yYoddGs3/FnNwi6zp2PmuNnGgjQhKco0ndKmOow9DVNX5wwPOlNf+uAh8Xs4sQS0pYi3oHk4oiIN1xNn7q3H1Xz/iymur5m7ShbKhCxZsbcMDg3zy3g+CNoacbm5NReOE2SDRTGu1jpDGm7t1KrBQC34JMFQWsx7fjfAP1bYn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHnzdsgHNf2uFkRyxnKwPC5haEbrZ9k9qd+J1Br6akA=;
 b=pOI3G5tqFhinGbbF4lw1A2QDx2f8/Z/IfZUZsIixBDghPz5/aicMXFZi9N5V4k6cSvAHK6BSJa/aDbkcXQAyqsXSTAJ1S571w1Ra919sZuabVccEIIvWVnLb0LpgvXynLmbYWWPddiJFn+VLE5lLKbtE26DgIvCPQOm4PqxQHVaEO7TYZC5qLtmZPTIYuNBb3cIddDMNp3w63KyFX+R9EDEyE0Zbtj8UyNrtZocYuH/40Nj/QcZ2sdCG0qUG2oGWIM27ZPk21XLr8iUNH4c3eFK1/br1O/QDMmJoGniooxC1Q0OatDca3nuxY74lat3OVNBY+poJ1NBAxbcIVrknIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHnzdsgHNf2uFkRyxnKwPC5haEbrZ9k9qd+J1Br6akA=;
 b=BSEV5M3UAHY+bV5HnsWiUQg4oDn1P/Np8Q5G8rpR5v57Y/QISEr86hNDKbsyVAxgj/ZlrAGU1CaSas0+8T2Lzs/Bsf81q+u7RgsxZzy3AXV3z6HxKv9sAd3VGl8hD2PLBRrmSyfEYn0PMs9LandlYRe4Fnvsyv16d0bpispb+1V8CaVG0jZaCe64pRpmPB0SQAp5VZ0gIRpDFnrImPpIRpsg6nsT2FFIuVrjPxZDCocOy3KNzz//pPEshA5nLRuWib1zHqaFmAeTkV8cKX3SP/DoU1/dVf0zW+96NOSocYHajgGKaqwKSfFvBkGqQ9EUw/8eBpr4J6Liu5mQ2mkI8A==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:05:59 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:05:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 2/7] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v4 2/7] target/riscv: Add big-endian CPU property
Thread-Index: AQHcuHsPPoKoil0dw02KctBJZCI9tw==
Date: Fri, 20 Mar 2026 15:05:58 +0000
Message-ID: <20260320150552.169480-3-djordje.todorovic@htecgroup.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA2PR09MB7446:EE_
x-ms-office365-filtering-correlation-id: ed8e0f00-4c6d-45ec-7b44-08de86923202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: GHelcCX4Mj5ZFsO25mNWIYMALTLFSHYnFjzgN2SU3G0sWpK6Aka7uUTR8V8KQX/Lap9hLwjWPFrIk029vOF77CJIh4Tf7ohKkOl2GvAGW7iN/rZdPXDJQNFCUbtqwMZAMT8SjwYGL01WQQGRIRricxqKmZO4o9ayfsY/dbvAzC9wNmXL8tpHsRBFqQN5ay0c+X9f6LI0VDfDOUxYOcViln2ZFaD/Mk0WWh+sLTRYVg/DvwlFOyrK5FTo2AvYfVjDBSt3QKwfHPgWG2S+vDVHuymuk0atPf78jxM1iFg/wC1b/Wl3nEQTs+HMOLYPd8n5S6SBPfdvABNrYPJeQf9CqKgDBCkFl1+CvqQPsX5/dYu7pRO3zWlb3iafuyqxsT+WuYyvPWiQfzzTJ2Gn2xeDBQGBPMGyiz2oavJxQhCJ5XwtgW7XGLgWWftdJwo/S9qw1eMN5xcM9FIxs+/uAvmdHmlT/6kiCeNkQR36Uy+XyEWZ9zc8jyh+eCz3DJLpMfJW8oPTSd9KiYMmI9b057y/Ybiz6GKfOjuOhZHlNNJHzmyuArNg8Z6VdBNWj+DGsJR7qlh4UskDP+f6lZDFr2rasrBRxlj0gWeL1NmdgjFXj1QbKaz2FRqHZnfDzDRSsej02CbC4cfDAcLUprdL01NAt4fRcy0Wm9QmQp1xjegQqlUifMYnlIvE/N3oezYE8nvtvDD2eb1XukF3+cM203CBjeypS9UiEF2cqZYTUAldUxbHjQSAXRUdIQXXfe1a00ZbgZ9Cpdnqviw3lP/Sqttxudv+gxjowp7YqdTaSkYpEds=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AAg+85Fv+LmTL5ZPiyqVEGTQRFFtOz83DgJhSog+PigoROTrtF+o/Cajf3?=
 =?iso-8859-1?Q?Kb24kyrNY+rBNzhbf0xfmitPz+K70HpJ2h+m5hU6v8WY6E1lu1gbpcuxK2?=
 =?iso-8859-1?Q?sR1qWQ/nQYzzI3swzDB9eq9F/+uYt+JA8nFW0DhypyvurIdq229FqW+vpH?=
 =?iso-8859-1?Q?Qwr0m80MN9RSgAwA+ExS3mibEFiy8YFhNvMWQJNodzbbYVWUAOapD+DDb2?=
 =?iso-8859-1?Q?LifJaerluJ9EHbrUff52St5QvXfZ3RXVn2NGlBdQyDeIezs4PMHcqzAH+z?=
 =?iso-8859-1?Q?pv5VqxabfGUytG04iEMkAmialL9dJ1uGObPEjbaocrVjN/IYEfjON3kCnT?=
 =?iso-8859-1?Q?1PiswVVPlDdCSFO7TzLaOcfT6YV4lLu4vfrCotbSAOsEf/t5KzKSehnF2X?=
 =?iso-8859-1?Q?mfy6lRCvRFMTH/ub1dUYyQWqbshN9u9Wtbzm0/D54AMl89AI7rD8aKYWfn?=
 =?iso-8859-1?Q?SZslQ6FAasNEIQMbxSpmdldlwagwxXuB7ErRqwRYXj7TKHEnNVOXQgXSh3?=
 =?iso-8859-1?Q?m11020mexwd8K+eQPmakUy1DJ1nZ2SKhFQaz3i+6a8hUDMsSNxoSZ1HWpl?=
 =?iso-8859-1?Q?p4MxbgdNkqCItz5/BwsnmOBbBdQfUqQN8Fr9a8oAK7MT1oEMdgykOa4V1m?=
 =?iso-8859-1?Q?q+5Z26dftPsq2/9W/DKJTTcCsiE+NANmzkajPbmXc3wQ57jxDO7MhffNfw?=
 =?iso-8859-1?Q?b6+6kSGs9USQ3ZPZVgsOMJnDqrz9kvLcZXQ7XunXChdqv90EHMcBtGEMqI?=
 =?iso-8859-1?Q?pVHuW+Vqvkfk5NLV2SPikKPsCDO8je1O+FF7fJCIWnzg/YqXQC/fUt9apf?=
 =?iso-8859-1?Q?RRXdHNAolaHcmTkEfaMnBQ1QhO5IT+ErMt9MPV1Q3cLEF6sxMgG77cRdSX?=
 =?iso-8859-1?Q?FapeD/Mf1SVw5g3Sy4cXb5e8xxqCmcr7O0GZCG0p6ut/yQI/VSIaEa9VuE?=
 =?iso-8859-1?Q?K/7B0Bp82Z/mAVsNV7dUnBOKm75Ap9ELx3/XpLk0g/QswXsafEFvOCZaPP?=
 =?iso-8859-1?Q?ZcMwh3IBkcq4RgQgxn5NUfhkxNx3PkXwYIlrgw0+UuLrA7OSc3om32Acje?=
 =?iso-8859-1?Q?5x3g3hKpDpdbc0r3+utxzhVb9qsNcAEf2mLmGATuztxJjOeEFFRSkYqFBv?=
 =?iso-8859-1?Q?vzuRSbLjUsYNFPFvHg6mUL4gLI6K7WTSzqIpksad2sp7W32iNDr+8tuq9x?=
 =?iso-8859-1?Q?yCrAGRVRYna8AGlssLRJRnhpPibkdNwSBLMGIpYkuLnA+GNgWhK4aaYdiO?=
 =?iso-8859-1?Q?NcEhS0hai2AbW23zlIAPr4iWz5IEFZx2efPiI0OLNYtCoy6hh+dVdOHsLL?=
 =?iso-8859-1?Q?GuydBV4tQqOK2N9hTpyU6+NINAspS1nRuQFvU/oaA3VMeMj2gD3yGMO5G0?=
 =?iso-8859-1?Q?QvcgEKzNa4Z1nrRCq3WKPKgViiq4dPCxsQWAgywjejEH0goF7pLpExF2jT?=
 =?iso-8859-1?Q?DAgDKhVoyAOumDWiH1y0gNyOPC6WHXd3gDcrSTDYvaBM8n2ch2MPomtm/B?=
 =?iso-8859-1?Q?afPs6RXEnt0Ifm3rijVhd0e2+IQ58YkHUuAaZ6LXm9SUqQvZ8R5g4/bx+4?=
 =?iso-8859-1?Q?wNc3lUkLglmCpG3epE/vYifv6O9dCgoKx5MsEw002s0+Cxa+JxqmvXGwBM?=
 =?iso-8859-1?Q?cbuBvszDkGbtf/cnkmaNSU4XJdK3LZflg3dipXtFmGmWkLO3rHv/N0hhKb?=
 =?iso-8859-1?Q?buFnHUTWm275xzfSgIXTs4DSUuDhZXb61vpy7ZVh0RIqN7L0M00SDXHalv?=
 =?iso-8859-1?Q?L0dPQbEcv5dSVI0o2RLkKLYYWPuLkYz6zTilfXup3NEKgfQuKKPc4e3KEi?=
 =?iso-8859-1?Q?aI0EX++3QGHEAPZYDfC+mUYEhvVVHb6+ZXhFoSFYynyifaONniF9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8e0f00-4c6d-45ec-7b44-08de86923202
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:05:58.9664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbY9QbvagamVzNeBxLg+/l6uRzQ8fMfECIJ0HURyjcuGKTQv9HOUwctkm2OK6pHWmHcpUdpK+VZgzeTdTMmhJqaT+DQxh15KldEBkHeLC0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7446
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

Add a "big-endian" boolean property to the RISC-V CPU configuration,
defaulting to false (little-endian). This property allows machine
models to configure individual HARTs for big-endian data operation.

The RISC-V ISA supports big-endian data accesses via the mstatus
SBE/MBE/UBE bits, while instructions remain always little-endian.
This property provides the configuration interface; subsequent
patches will connect it to the CPU state and translation logic.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..4537305dfe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
s[] =3D {
=20
 static const Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
=20
     {.name =3D "pmu-mask", .info =3D &prop_pmu_mask},
     {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 70ec650abf..51436daabf 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
=20
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
--=20
2.34.1

