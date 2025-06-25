Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CFCC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxT-00073k-On; Wed, 25 Jun 2025 10:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxS-00073N-Hj; Wed, 25 Jun 2025 10:18:38 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxP-00048J-5Y; Wed, 25 Jun 2025 10:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thiB5J1eVq4q4IIYkOJjf84a9V4DWw4CZSXbhBnyy7ta3Okz8ca2/flBkxdqQxjIQx3ACqAkbRurpIBsfbJrHnbZ390lAam5Yy3Bv/9/V6TjDNMwWiGX6Cxy05535mrP1V5bcxGuBByR8vHmYyuhxYeibpXfJtzXJAG4DQCa3Q84+EkapGVfh3y4UrNTrI3YlBFmgk6DFEUOCGvyWKttkYNKg22GNv2XDbDI6YFmF7pEeaKupyNsEdZBH2qFEBfHi1/iEG5lfGrsd9VrBLXdWDvB9sdQcjQl2R8rGq76+cxvYHlvCRiYs7u9CYeORTdg5jCunDv/oiQOPiY2AcWHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L1RqNk4H+5XRuLfvaKs85JYjCgEN889GAa15JVWs+k=;
 b=R4Jk7bPFhdWN8Q+/u8zxY8eIevoYYs0+iLxsuYzY5nGiTFVgpHTzcuN6v2mC7OvaR7S5N8eFj7Mf+XKsfh5PzSJdYULtovRFO1q+Tfu5jO0djhG3baWrt9EJ4e5xjFOoQN6utoCS5X8UwtSf4yG8oicJrN/nZgmiRpTKoIR4lzMJf9KDMBDMBt8qAfKSrFb8RW5fJOmJpuVevOgwqR/rJtrfHf/Buh5P87Y0QFGN2z3kp9vYhgtqtVMGFPIdRU5WeZcr0yUeBhAUmbYr7GO1ozpjhRJp7A5zS6J109WgQkfdw9wnENBmU2bYsIKCT4fM0+ne8VrLBRLc+FR3Dj3VZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L1RqNk4H+5XRuLfvaKs85JYjCgEN889GAa15JVWs+k=;
 b=gFj9rX4ng0se3SPjDI2rnzVIe+LzWoDq3v4Rz+RsJpyTQKnDf+erT47MAKwDdylIgieaxwDkU0cV41gX11P8nDSZBCnnQ9TtUmiJAt944U8i8UwRed6OCiQII3PVPZPY5ZLxEm13nVYviJHQh55JhpGLw2rOlQv1DQsXCow0rk3c2Leg4N1j6wL3sLDSWR7RY0WP8df8GWfXzGplHKweRy2hrB9wkg/xze8O5Q9Uz7i7JSAl0F84+Pheeaz9Fq/6hJ6merrC17O3yt1yqPl2BWYk/q80RxTpePSP+mt7iHZu2oU8ewbqdDeNYbbHekjnwL9jWnrw4cwUaDao/PKhcg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 07/11] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v4 07/11] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb5dwAg6SbuhxT9EqFgrt4FazC/Q==
Date: Wed, 25 Jun 2025 14:18:20 +0000
Message-ID: <20250625141732.59084-8-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: d2e6308c-ed38-45e2-e8f9-08ddb3f3235e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4iuij6K0uX1qAvKJaDVJtb+XkvTnVl2X7JTmkoa1hOf+RVq5y+3hMB/2TL?=
 =?iso-8859-1?Q?Z8U1N9RZC/eo0QN+ACneWwWskIpAJSLrz6JGmVPjNTSinNGx8DXn6632Cl?=
 =?iso-8859-1?Q?lq8g2EAmATXu52H0BHuQc+vmyRTGsLPxtBupjUK8VBKJi7JcvUZbv7RTlq?=
 =?iso-8859-1?Q?rBIjWIJbiscaZ630ICqyrxNMryUgalCo65a49bY5WlBxC86M2X5KVkkEtQ?=
 =?iso-8859-1?Q?GMcVpUeTZ5OEVaXgEih5UBpCupgozF8ofnyspoZri7WpcjGwVgAfTLqaOE?=
 =?iso-8859-1?Q?TzR9D8qUt9A1sPgeFkFM2byRStR+J/69FxVoD7QCBTkTfAJXywfVmtdon3?=
 =?iso-8859-1?Q?wkXNb62hfqqeKIWXF+mfg6CvDq4lMB9E0Xbp3qT0J4SFfP7ZFOG0qBNhPy?=
 =?iso-8859-1?Q?Wn8gp/syDOvZumjK2wcSgMkcmUUUTNKiEuhHbZ4N35nXV3p6HxY7b/rtpF?=
 =?iso-8859-1?Q?QtMwSDM4WwXuO5G036OLX5oyXSIPJbQ6WmGzXXCPpsACtTUfHGlpXuvGPn?=
 =?iso-8859-1?Q?pewPX+Fpo56r0j78XfwJ6162MfI8YXn+0cvY2aIyOodfHgaoxPj/LoXUyD?=
 =?iso-8859-1?Q?g2aahmFw4GmlicwHgcSapAmnOkZvrcv1W3qR6i9DchspTVSFj3CgUBJd7J?=
 =?iso-8859-1?Q?PXa+Qr7qCyWqRdI2yK5hKT3UPcV3Wu/d4rL965GfkvkPOU6PmbewnppCiG?=
 =?iso-8859-1?Q?PuHaCAzS5rGQiQmI/8unRbjuMHPSeLbMfGn7yR0Oo6pVECWqKxhREDUDOa?=
 =?iso-8859-1?Q?7GFOS7W6wHHDlSWU3BgoZAt+rupHdaJtKKdPAJh9YLFaTOKUdoPmMnkFtR?=
 =?iso-8859-1?Q?msjXUH499vvTt78RqShUdDMWqkXKGyQ+titqRln0U2Rjwi4l8jdxokfu1R?=
 =?iso-8859-1?Q?W+7ZU1Je5/sDcy4PgW1XGbPXNu6T1T/9/Th9TmsywcCG/Rgt0qewW+SZi2?=
 =?iso-8859-1?Q?e3Kp/W0hsItJ+1b1u6JYndKyfS6rsCXDeYuWKXw1tFiV8bB0xLazthx0P1?=
 =?iso-8859-1?Q?msEeMGIBMOnbQ4+Tf4iIClnYbR9svYTWg8tQBJmm3aPajUkdm8uhv0qcfh?=
 =?iso-8859-1?Q?4TMnNO9vLK9zjQgEt+GLzKd8sCoza/8EIMMSptP+08sKjAx/eup+RZaQoD?=
 =?iso-8859-1?Q?P4VjseUHOQYvUW7XZl1U/YbiHhKr0a2K6mllUihII0UuBsF5DX7cHCaz6/?=
 =?iso-8859-1?Q?QbO07gHo2SXamwlFEsUwOnk8n0Naxh5iaJ0bx4kgye1s1J2FE/Ga47k04E?=
 =?iso-8859-1?Q?fDmJKRB8c1eoS0G+6KwSCBhqBHdU1QSvVTlThW2iIrLeNAXmNWaQSxRrEG?=
 =?iso-8859-1?Q?aeXHXMbfJ5zyDVFJRjfx+EZSnCwnwx/NPy+0hmL+QvxKH6PYsbQUjB52Hh?=
 =?iso-8859-1?Q?UxNsLvz/bB1/7aslVJNQ8Ar5XLwkQYphcCITMWlkdtOfcLbiNpoLWsdEDT?=
 =?iso-8859-1?Q?Hfeo++eBWyLb2usfPR35KH43wYPgRN9T+TmU3fUw2ktMIqZ+KF6sgMqV1z?=
 =?iso-8859-1?Q?o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GvzLsegxbdRWKjG9/KSTuKCGC4Wz6spUtyRcJ880hT0IwrdzslsbpVw9Fl?=
 =?iso-8859-1?Q?GYXndTkgsCcnNXAWfvYMyMzjw9BORyEDk4J8aovJ0W84To0jZrR/YAOUbk?=
 =?iso-8859-1?Q?O0ateZMORteeo/+sF4+0uhNO0xbM7Y6cKroq43MYZgCkDMducngImdLl9Z?=
 =?iso-8859-1?Q?63vUXpuU+oyu5HYQniGAQtCm9GROtD1hJ0maGRFaWwYgUStTvIsIh8dpbx?=
 =?iso-8859-1?Q?nyqFPqmc5pGB4QJEMBwd+5U88oHXdPjQ+JCuKjhAP48olE2Evje+7IEWCm?=
 =?iso-8859-1?Q?Z7QJbyw/fgLE/2DkibTFZJtzAljOYMHQQ2vDD0ScE2Eln3ZK0Tg5jkAzO1?=
 =?iso-8859-1?Q?0YHKZ1Sq1792r5mzksgr5CDjiCgPdqMH9G9/abcWf9xSBFG21WsQnMEoIU?=
 =?iso-8859-1?Q?dVEpZqOnRWV++qv5lqwU/98QVQNo/4Xx3+8fdfDIxJrhGUmawcmskpDrYm?=
 =?iso-8859-1?Q?+oEaDps88ydj9z5qq1IoxgBVM5gmgW78k3gMH7kW5JXP9d4Ur98q6Fjgnd?=
 =?iso-8859-1?Q?27mIptZLyrkgbDiLeoJ/CkhDzoNOIH7yXN69kTngf4CHLR165w/L62dUje?=
 =?iso-8859-1?Q?vovo4LNPLb3nsqx3t0d1fLWi6WRAOYNYDeYjVoopgwnUXApw8C+38ovNer?=
 =?iso-8859-1?Q?vaHtmBldqkowoBecQI55+6dX+Ag3kdxuW0ubz15N1JWugdi0n0tHIcm8ba?=
 =?iso-8859-1?Q?x8i0mlYqNggx6ayDDtwYP9W+2H9jtHpUFZp9LbjxfWUUJlOPSjtA3A/j2H?=
 =?iso-8859-1?Q?5yS/1HmBRq63Udr3prWEWK1O7d7Iu4yKpM/SnApxWy8ddwbpXsKtLGfxZX?=
 =?iso-8859-1?Q?tlmNVOqbsD8TEkT8zMEh+KyOrNN2xY9as8v9GXl3OoEHtUHe7xPcBinsy0?=
 =?iso-8859-1?Q?JV0HQqJEdY/0nUgfMjX5Zkx1uLtT0q5aZuxA5EoX01ZTpRseyx1lLJwPUg?=
 =?iso-8859-1?Q?bdRMqgXA0TqdgIex9PibVpqXWEnhnghtF1pXY1vOa5czLEGb9wtBcGJn9v?=
 =?iso-8859-1?Q?cTaU6EDwQsXHVI9f9kWwcYK5OJFcKABs/IRzE/jeFrJjdnT1+5llA2lbuE?=
 =?iso-8859-1?Q?mXOF3j8vp7fqeOBZ2m/0QQ+L2UqHgn2TlZR2SatwFOxSqNdjgv5Bpe/223?=
 =?iso-8859-1?Q?j43HGql3Y0lEn7n/w/tOEGfywiW4dWml48FIN+qvVAYCAS6UgikWXQvidx?=
 =?iso-8859-1?Q?NImdGpM/eJwTRqJQYxjeVj/T0xtoeIRc2Cf+UZ2V8eHgo1buND8kd/Bnp9?=
 =?iso-8859-1?Q?1+fDW8MhlxFZaCJWhlGpVVjU47RMlJzL7GMlhn5XOk6yED7MquQxEtS/4M?=
 =?iso-8859-1?Q?79rbEB+BOMLW3EBOaUb3wgw7W5LT416NoUYTPDZOPn2b4xSYnFKZMcqY+Q?=
 =?iso-8859-1?Q?rn2XEbhO/8BfH+7c29GHN6eJG98nta0uKOlyLQeAwU8v0vcbcc8fBSbwbZ?=
 =?iso-8859-1?Q?zQzdgT4HltHtjwzhjhw/fjBs/SN3ZeaRVjYtb4CF97OnWMdeoOVaNszI41?=
 =?iso-8859-1?Q?Da+1J4B7t2LIcnyy1jQ1kzdKW/Ts5SXaLt0kxONMkF1mKT+AzAnVV4hd5t?=
 =?iso-8859-1?Q?YX/vql2dn//xoMee14xtKgj96fko8wOiBuTOqr8wUBMb/+QqSztHyKRgUR?=
 =?iso-8859-1?Q?bYjb4dF4AQWrNqoixbibCd3OOCoaqNlY1eb8TOtQ7sP9lQ0ywoWkm6bYqW?=
 =?iso-8859-1?Q?cGz+tcwHTy7DD6HeTRk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e6308c-ed38-45e2-e8f9-08ddb3f3235e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:20.7704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTkniSsoIWbmRY/dLdt3Rdh1AiMvSteB+t0/WDUPqmGm7XR0FDJ1qAyes96InLrJYjS8g+AuTa8phzf+YlNUbuX9gQuhCUMYzDvqaUUcqXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  3 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1e5194fd06..6e3514a713 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -232,6 +232,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1364,6 +1365,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3182,6 +3184,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9734963035..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,7 +22,6 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
-
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -39,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 9ee0a099bb..b5195959b2 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 6555a6062a..d2720a6770 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -31,6 +31,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -47,6 +53,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 697bf26c26..99c98d4084 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

