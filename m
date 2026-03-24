Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBD9F54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o2-0003lr-T5; Tue, 24 Mar 2026 12:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54ns-0003jY-S3; Tue, 24 Mar 2026 12:40:32 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54np-0005LR-TD; Tue, 24 Mar 2026 12:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW9A/8bRZrTAESTe6Wlp0HazDxvPf0SQPPPAPH5eKNu8KzDRiIIV/T8AVFFIn/GBx1wuvdGZkP6kX6i8ZeNCF4ELR+9U+88HAS4y0yE5v2srNThVwYl0tN8uKq97LdO+uIXkho56Q+Bs6cLOnNqa8TknSWPP/MUc4OHaUWOl6QvPginyImDG0GzeOeAdtuwCorJ0stCKyQN3TwvCHyDu7bZYa5tDohs4QDjnwNhfqd+NicP2pPl/WIlDJ+wRVkCfE2HZ0Zt8xalnS+KcE0FsFARjoW5zEMmL8T0sVKw2v7NjxYio1BysqQi3gLXSIVC/ruQiLUuq3qpD/npxHQJFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHnzdsgHNf2uFkRyxnKwPC5haEbrZ9k9qd+J1Br6akA=;
 b=vHGgMDu188txzsG6OHDgH1NATZLbw3erltrUJlSrb6a3syXBPaVJYIKUmvmrAacmWi5SRPF11zWqy6jJxqsU+JiE/KXdW8h+vF+HRgoojc+lL4P5+vdOglaW8ulJnsLectuE025SgKrNKYZxz9HwkwfdH+8lLgNU9IJ0uOU5KoL5Si+YVdqqa1Ybe5s9aXt278loxuWFZ9n/HIYYEsvC2fg6viMO/dYQeccqZvw8+FDEfSblNI+lpdDg43skdMxxUWLg+cYLY7uJDX5Fp5dyxtCTkKUtTZN5D3uZSBVmq9RZ3NSwqQzrLxpByR+qOTMItQmCyFa+JmVYWLWML44l3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHnzdsgHNf2uFkRyxnKwPC5haEbrZ9k9qd+J1Br6akA=;
 b=Q++Pq7W5LI35ZCEENkLZ0ij2GnODqCxtwcIHlna8+sn12MwTJDiaOZK6GuGJsnEPFAK4l8N8szoNuZhElAfZarDKGv3AqEo/jno66HFJiOZW7dPffcWAbxYfOZ/mmPAVZP+yE6xZrHh+xpCCVUejJnP1jeeDQvDroQfBYKp0+j5nARqbfnZXJnYpWspJRO9q2tmxLVcVHdzsCcJx89vv4M4PzCCrHuSe74lswooAbUndxLYLrgOtTIcBLexN1yT83n9RRMomoTdQFvKUVQ+n3OyELtUKxJyfrVmOHNDdEMzb6boKbIVHlfOplT0oySQf3vfiU6ieIE0Se1urD48dNw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6145.eurprd09.prod.outlook.com (2603:10a6:10:475::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:40:15 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 1/7] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v5 1/7] target/riscv: Add big-endian CPU property
Thread-Index: AQHcu6zkB2QMaoma6Uq/22jUgSxNmQ==
Date: Tue, 24 Mar 2026 16:40:15 +0000
Message-ID: <20260324164007.549397-2-djordje.todorovic@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6145:EE_
x-ms-office365-filtering-correlation-id: 02679ac1-6570-4133-95a6-08de89c406f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: nPWaJaKjL8x606PsNO2cmt73KgYSL0xO2OxkldCGugUMmsL/7HhT7YV81w1wZ5CVJRH4lHyNo9/VT5GasKN2IhvWCp+p7zDJQlYxeuTXS8bGlhG3GXIa/GSAAYcBlyxfhV5RgHjjXmEI3MZIwm1z9heB1XmDs/6rzI6qbrDvgo/2DAtBMKOWZIfoVcjs6BwE0VGCs9fZk7NDq+BKXGl+6p4/XTVkUJ/kMK+wRAXLtFgetmcsg2KyRhrzU5wJHN4Dyjv8ARlDnx2j3VEcLYSsyjG1OMVyFkXbnU2XODpI2r53j3XtczTcX9a5ezvpZKbNIQvwqlGB+pODGTZb7vX3VDeDBQ6fBpicrY/7GvjpSkirnaGYtUGt6LYr9OfF52aDRm5h5tEpi0u4IBii4OUKpqllZNN6YYd2EuvjgqE7uUdjQIiKm9jRCEsVnrTOSmrgjGnAtnApHLMGz1TT1URke2B1/Q94KFoAOY5hSMFPbQs8UeMTDBajcemkgEIWygehOxqaNuNpcCV7u8qt2cYC6HemH2VgXuxl1KNAbrrGwp9rSwKJAwGC/1oM2T3fX5RUnKgaxpIZ/WI88a+uO4a2oHbNPv86OaCMo9+LJZHxEjD1rzN5Tx5Nf7TWGQdemmnWiCS//Xm/Zj6P/8ctmG90mluERSmBVzHee1AvwKrr9lFo6VgbYdrOWVvydm6cw3vBgmg0eTX0/U7p3QuZYeZvsWgoXvuI/mpKoTuHqJB1P77+eTwfJOGTukn5RwK4wXO31H7meNccfTAkMeHX/jYoLZzxDWN4IPwF2SD/dFmVE18=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WmJhWArtBcfSmtjoNydgE82demt6Ind/eHI+yT+J8pce0lUz+Lb8EfplxU?=
 =?iso-8859-1?Q?mJx0tJcyCHS/f7U4KoZUhXjp1OfYgIJWvcpz0RgKvTIIPe/43uG5SrzjNP?=
 =?iso-8859-1?Q?iQdrJOPbhAsY08TBYwQxqPPA3rGys/uwinXNlTWjM1A2K+YLmGmn6+krEe?=
 =?iso-8859-1?Q?z1h7x1w3aHpQRHyp1/1gkuM5qOkbMEZgJcnFxGjP34tQJZmg/tlVrsI8xz?=
 =?iso-8859-1?Q?XECQljXfd7vLHVKTYHSf3GS279uigI2SrAOtJkIYpKx8eo8jWQXHSC6rWp?=
 =?iso-8859-1?Q?kV5/HXYnGXRZ9B2jfp7k40yzsXcZbIvsE8Ez2sHu361bhKlYgzBwu9FBD2?=
 =?iso-8859-1?Q?iH9jPnH0GkG04LSddn0mBOajKRC1Alcby7MtuVWWvP1PNQGvnlaMc/wEts?=
 =?iso-8859-1?Q?2wLp+eQPu9IcMzQTTAWHlzk1BEfE/tx0J838k8TJl/M+56qUdYlnFud7MX?=
 =?iso-8859-1?Q?NaHZOeP+zbIMJEumIl324i+iFIN0jcXKrNJ26EQvFD8XnwqruCJhciTz9i?=
 =?iso-8859-1?Q?klE/PSKUGZupUbpK0rP3OlG9zBi+vHCnqvOJzhRvmnMz2FcD+2ZCnZjetG?=
 =?iso-8859-1?Q?3UeKECkSvz3ret4iCRgBtwV0QL6eG4xfaf8czAGU0LZ/D/OSNdmjvHAba5?=
 =?iso-8859-1?Q?+Q2ykJtyG+bkb0sj5K2ni3RtPIywR/IQ34bupo9hnBY4ryRlne9PH8d1n7?=
 =?iso-8859-1?Q?XlpO37MsC6y60LH1trCtgKvkks7rnJzbPgxbjZ9KN0f70we89g2JX/dRSK?=
 =?iso-8859-1?Q?1K3MkgvpzqYsWitp3Rx7T8ZZvKWX0NCw9QhwChwtPx6DwfvtaorcBLNuSM?=
 =?iso-8859-1?Q?BD7m7JCZ+UE28j3nYvtp3qB94hNNofG2xf8iOjQRtWYSrSTA1BNz2BeEa/?=
 =?iso-8859-1?Q?Q0YEkFuXB0mEHnubZ2ZE5FJcOHWn2lAiWmVUMUYAedksyY/Ig3dFbZM0zD?=
 =?iso-8859-1?Q?ytKxurxdNfBUk4glRP9aXFQpE2FA/UfrE85MXSNBePx1J98kz4FtvTLrwU?=
 =?iso-8859-1?Q?uPsKUXrY1YU0PWCE/A20gH6PX196v/oUaFoLF1UPd2ILyBQNQ8zm5DjcrW?=
 =?iso-8859-1?Q?RicW38oL4gtP6DyegHYEP9KbmG0D6LZDb7OxF6OXrX8NLG0WW79I/yZysd?=
 =?iso-8859-1?Q?1m2f50W+zL9eSqEyeC4a6JGGnG2SckAficF8VCNk9zGOJ7Qw5qowlIZkqC?=
 =?iso-8859-1?Q?LryIypn0Nr9kTXmaOl8dx/FX3gm5FOvgZMN7lfoy16chq6FYfs7Soq8awI?=
 =?iso-8859-1?Q?6wnysqVZ0HBrvAQonhoelrnSpoVbr2/rjcszTc65EGjib+KYE6nZNg5YQH?=
 =?iso-8859-1?Q?4gxa6bVF4+KiXb9vEbExQ8D9WBzhLppORTDiPcMFhxSMJu+f1FF9Cehwtf?=
 =?iso-8859-1?Q?bMnSDyt3xkiQpBp1bOdFlojBRm67kS0MmjW/87ns9eQ04rAfTmVELYN6J4?=
 =?iso-8859-1?Q?a+EVMBqA25O1iZQR5/yF4twzGCI2j7BkRvF4hTB5unKCXGQP6hnmPSywNZ?=
 =?iso-8859-1?Q?SFztJ94b9fNfDJou5u368Z0bNri1D4wpCwusEuARVWzaG9s5WIKda3cef9?=
 =?iso-8859-1?Q?XeoD9wYyqXYvhPD90fwaE14heblm7ng+j7yMfTPxcZyjvQ35ywZTGZNhu2?=
 =?iso-8859-1?Q?SdDi0okmHVal2xfC3pQqkIAtI3SeYGSRo1oXgpCPSbZxSiHvy+CBq9zNtl?=
 =?iso-8859-1?Q?VgqMleeA5feQ7drjKu3ED+ErU9I9SD7y6KIsIXAnOI9PUpFlkkbA15JPcv?=
 =?iso-8859-1?Q?UFIOfiGWzNO3plx3rBo5oeh7+Vi9TQnNnmalBwzM1pPZaWTuzrTkvDKs5R?=
 =?iso-8859-1?Q?69yKe9ns6Z5wxFczXGVoUtxQNt6jcZSHKi5hZLp57KuwFDCo74Sv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02679ac1-6570-4133-95a6-08de89c406f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:15.3846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JofTGqAHg0uOTZVGgw0FbOqMSVdjdYoRFQFBxDH5RoqORy0bvJ4QUb0dverRxXJEhYTK9iq4SjLQOMtPxcUnNRSXMyQr8vJmH8qo6o0nTa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6145
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

