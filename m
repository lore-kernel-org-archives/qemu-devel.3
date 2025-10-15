Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2454ACCD196
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909h-0007dG-O0; Wed, 15 Oct 2025 07:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909e-0007Zr-8x; Wed, 15 Oct 2025 07:58:54 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909W-0007nx-Ri; Wed, 15 Oct 2025 07:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SASzmUsbR6yhNFVdoTIo/U7L67hHRz6m9F7b2jjhR8cGKLPL9CAlUqzsSrWWXYr5Bj27J2MmebUg9XSiHv4HiOMwrk8lsB3xVWscRdUXzKX6oBIBMatFXovkKNwJc81i+0IDJYQdZDdSuk/sigQPdjvH3x3ATEabFtyNH9NtudQ2jmXp01D7tbz9Yi9xpIiHte/TaeWv+9fe+XjGB3Wpiczub8fDhDoZWiILv4yR6whGm48j2OOGBZrBRs3IHPHrAveT0KQkBpQil+QLwz6TofZ8DoTaeFDcfrUvF2d9GLmz4edHvyhdvNbnLU+do/69kftil55XxbMOKbyrRxIrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=b9rB3Z1+O1Ez4lxhegNZv9qNjVhMMQlSAJIAqy0EJ6LRn/HUYkCEg+UGAvxQfhB2s8aXs/5/vgfw9J9BgGtxcaxrTExa8zxRVCmg1kZ2NP1CAvMq9CSRlrRo5tHnNURAa8/WuBO+m+luNghKOQaL1R04lwqf3x6bLMCUwxabgEjcKfi1GfdA1YK5QIHHuMvh0mQbSho46E9lmMQxxbkVcaedA7sH9Do0RFjpAR9ozVjyylPlCOGAdpnxdSX84Bf7xpBoOvThafrKMXn18saUZkHQtLRbzfZMe1jEb5xPveoMxJw0PnJfj8IDkyMwHtGZdYoy3LaX+4diMMJj7C75qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=B3q6meLVfvtHVBUOTNKaNM5YXS5xnqI0T+8/5rMwTuOa1hx9V1dEUAY4WAQl6MgJxMaFLDOmaNwXNKr4Gu0C9v88/zt0sh7R+lAIp5GEkqcjY55yb8UcINJkPJG3I8MP40Sg2HDPIllfRR/WSZQyPk2dL/wQSFPb6utBgUt/oACvpZPV2mXPP/iJ0Pf8lNo7pUPjgxVitdhiBmULDuaBXMiEwoVRV0AluPGOJbKu/5jz2WHeBOhu7eWOSShLy//buKtKmE5nYtRl4Nx6Ov+fTu+/cXC/PCgo35j8kbXcFSQMNrUgU2bGQW0m1CHmtSwsKC6hwPjacIuyqjEHe/3U2w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:17 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v11 05/13] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v11 05/13] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcPcr9owApImAzq02NrJFnAbU/Dw==
Date: Wed, 15 Oct 2025 11:58:16 +0000
Message-ID: <20251015115743.487361-6-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 078637d4-19ad-4b28-d13f-08de0be22112
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RbQYllRLZR+HgUiwWhj+hMzInB56fttKeD52nje7umR9wOqjWYNultneYd?=
 =?iso-8859-1?Q?qR1oOqwfBaZPd+wcr4zF9tH/2uGGlqM25KBS+7Cwv3w8B/Ql6XsENASAda?=
 =?iso-8859-1?Q?RD4EN5a5ptc8PJPqUm89UBgXPwL3N2x5xUijNPF+GEXsXKomcFhtZrXByM?=
 =?iso-8859-1?Q?VLq7xx9VPwQvL2B8MKXiAvgWW8EnEHl5tbhuZFcj1gk1s5gADUmlH1OOlC?=
 =?iso-8859-1?Q?xizWLZPMPN74yqytn5Yl5RpG2/9F+aBJQo8cn+g3NhfC5zE3dvnWvWBeQ9?=
 =?iso-8859-1?Q?ICygiCk4HEIvU0LgG/DCkctFn4kQydaFdfdkDmqmzdNMbgkGvercS394sJ?=
 =?iso-8859-1?Q?7YNAkaMf8kaBk2C+QpwgG4gvctaHgPnv6mxfMR0N6p17RTyGIK3GajWt5i?=
 =?iso-8859-1?Q?MXdDbWOKP+Wctx4FzNpotxDmPhv+CrMliBG7i4KjkYhFcum0LLRouc0gBR?=
 =?iso-8859-1?Q?4QbdN5QUeMDtYA8epidhvelA6omYOP9axAVxrXPPjh+zDKwV1RMylxjSkh?=
 =?iso-8859-1?Q?x8vqcp9n3M2eCVknR4M3L7pOhEs6rY1fwsq/ruL8Bc3DZRmwG8W1K7o7xX?=
 =?iso-8859-1?Q?GWIEppJ0X7ZANFCN4Wls3KIXSCU1Sl+VhvFqc1WizOjdicJPxRnCPfHDM6?=
 =?iso-8859-1?Q?WVZxL3zMBSv7+scpAxwwjT0xOiMwZjjpK+CedCa1Fy6M8afhaH/e5O1q+D?=
 =?iso-8859-1?Q?usrI1lcPuN/X8R3svTOqLrJsq7yCrK0sCpFWDeytd7/BopDXUCxBAVfkBD?=
 =?iso-8859-1?Q?pqqjeEaXFf1fetc92HnQ+m93cqqkynfx1vpj22n1FNcOAw7FQTv6kwVmt6?=
 =?iso-8859-1?Q?C2jRpr8IetskqjYiV0HENjvxG/cl3o5oZ0shPqbzWua8LfOEaOdckVREY4?=
 =?iso-8859-1?Q?PRrkjB6902os+s01NdmRyWAdZ5739Rd4czgmujByJJhPtAVFBKvgK99vpq?=
 =?iso-8859-1?Q?A56xPNeagshyH5nPmMm3mBwTLKYUkk9iGPi1F1zNGesMMc4YH7F+sCrtFO?=
 =?iso-8859-1?Q?eHbcZHoF/fow4jUAL7Qbts8pQyYPGtBwa5LvcKXcrpjGEN9bLxuZAKWIKR?=
 =?iso-8859-1?Q?4kFnDGKev4qjeVmktJDz8PNP9tGgFrvPWQPIxONipoGMOlAyDmnqBuhyLn?=
 =?iso-8859-1?Q?yuAuVH3amzNrv8D/SWVWReDIsSVvGsmoAB5iB13C2X1soLn1ZEg9LoZK6a?=
 =?iso-8859-1?Q?uJFu+xTI23VKv6a0bSajqKTf3F/B++6v25Gajd4Jd08BG3GP7PsedD7Q+9?=
 =?iso-8859-1?Q?rIXGbyTh+uQy6umtHy8Fo5EEv3oowK7N5MauOJXgrEOtxiVrDQnxVPii4f?=
 =?iso-8859-1?Q?jrmmgmeRkQmpqjEMVor4NhI8qcbuOFkkmUga9dyk4NW3oSSLWnOgQU3qSd?=
 =?iso-8859-1?Q?+OPyt+y9rEZtUKJWp+YKK9oB54zNlxYnPfYX+IQojRJ+BGrAzmq2izlZAQ?=
 =?iso-8859-1?Q?GaDR+RxNI30QisXuJN5dKRhn9PVSMEH/fvjQ0mReqaEq/OOWdVWabuAvzN?=
 =?iso-8859-1?Q?PKwbNlIebGerNg1460CjAWmeuo126HjSzwI7RXX1o6Eq28QvPo7TUns/P+?=
 =?iso-8859-1?Q?ataRWXLDM3Xip4irlvSBIo1tmPdO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cXvQPDZiK99Jpa91/GYnXwcGPjsD5RQ9eL+v2oRfCuKUgqH3a0A1NioBYY?=
 =?iso-8859-1?Q?m6j6seyR01QRxM4rFQWaneId5fzT9rCkyAO2bg2pfKS0hm+BzNSdFNVRaP?=
 =?iso-8859-1?Q?JhuFmiz8QgkUdegtURzkTt5hJxs6bofeu3wKUIBmb6uAkIf/2Y465uwZdx?=
 =?iso-8859-1?Q?8FhTwpaG9SMfHyK7RJLRhzCaSjhpsiceQG1tB9lwfOulDTgTy63nSAK/ov?=
 =?iso-8859-1?Q?qMGay9rd3aAGLzVR7uhMtufhp1x2JkicvmeEGaxJjveGI6s+yWt5MgYFrf?=
 =?iso-8859-1?Q?uqh2oDcPYf58y95BQpxyshs8rRLXyARbtnpUT74UL1mw35KK4UegbmDviJ?=
 =?iso-8859-1?Q?LS6nqbzBfucWwq845F3UplOPtMupIQ/2VArYO8xmpNi92X6nhu0yiHzcSf?=
 =?iso-8859-1?Q?zS8iaYvDzQTdRzvOKo2tmi43dISCBSgNQrx3u+JuxL/3djpz1Z780KXb2U?=
 =?iso-8859-1?Q?y+PRt1NMshVPbfxBUafDq1yfPNk1+FQNOtg02UZ8iMyCtFKkBnnuanEvZy?=
 =?iso-8859-1?Q?0IyFAY40XHIc8CCXZH7JTiymwC60qvIC+4JLaFRcCtQm0JoAU1tgHySG0z?=
 =?iso-8859-1?Q?G9QiGKhHb+5EzmojMNG56Q2aPeDAKfbpmxDXYq+1dg3LIhwSpAnytQtgaW?=
 =?iso-8859-1?Q?gCmgO92I1AiFo+SvRxhXB8efTC2fTqR/I+8Cm/b9uAMmbzF1LGDSEVgLGO?=
 =?iso-8859-1?Q?efuZeFRLeA+yFLk8tJCy8ak/ciLpOJPHXsXks8MC5HBjjae6UjYxB2Jjqb?=
 =?iso-8859-1?Q?QWq4/NkW9gJjyNIeSHTF1uLk/cdciMxUrdd8ctI2hvhs3obKqtUpMjtu2p?=
 =?iso-8859-1?Q?S4sxLwVshVA+7EyrpjNkZzRY6mPdVlyiwDjJ53YP/qAefnxL6nql4sH2Pk?=
 =?iso-8859-1?Q?wmj/phoTp7uQAqlfrZJSfKWSMRuZBimGpEqqJWqOkGffbvfyenXf/NZU+C?=
 =?iso-8859-1?Q?oUnrQEAxdrRRCai9AAOxqE31KgfH+ivIbnObUV+/w58AmyKlH8pDc86UPk?=
 =?iso-8859-1?Q?1t0nJoZsFbhFkYA/8MPrbRQ298eNKRz9jY0YjRGC+Tlm4ZDl6g5VQBbEgn?=
 =?iso-8859-1?Q?7EiLYtZqP6CwoJTYbvk3PbVVhkJf25uaGnTGJlBs0QfQ+vRUrkU3ya8gJw?=
 =?iso-8859-1?Q?gXSvRYO/FsmaOaYyIHeeKDgp6zHVYGnR2lo2DV6VuqqPJIbv3dl3wfjBTf?=
 =?iso-8859-1?Q?RG93alJYsNSJLwvCYxu6W3J0HPJYNuB5XvMuaEjE40mvNJbggJGdbnU+RJ?=
 =?iso-8859-1?Q?RHLyYJ2M7A+Lw/oQmeQLR8OTw+RRtebXtlF3RDIuN5Q8dItKpui3W407cI?=
 =?iso-8859-1?Q?q8yiIczO2zyFyi1VyHXz64C1OvGaGzbgGvYFqOnP+nHXOyACn8+p0fI56e?=
 =?iso-8859-1?Q?4gHuUmogME9zQE27SxO550mwEf6tyRHDo1Ju7OpBdUmv9KJrY9rl27y1fI?=
 =?iso-8859-1?Q?fBVqTYAfdq9SIFPxDkwlLrHzUj9edLMe8hHecc0oandoPGBvLspwxc1GlX?=
 =?iso-8859-1?Q?VJ8n3DNBMk5jZItEb2w56tx2uFOqxVQPsoQaBMwiyd7EiosPFtS2SZphrG?=
 =?iso-8859-1?Q?o+V6HTDM/NP09qrUvuxR4j9IkTuKNCBFPsViWYfwKEJge5wFZ3Y+nttejz?=
 =?iso-8859-1?Q?draSnp1ThqKA1GJBWoyL9t7uD6LJb/5U99jlmDVpqmniq3zfNFrM6XGIba?=
 =?iso-8859-1?Q?qQzFiUsruRCCQHXd82A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078637d4-19ad-4b28-d13f-08de0be22112
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:16.5760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5aUE5fK1wAZCRvUntnR7UBrInu3zqDLWdDJMrYJhBcatYtem568A9L+gZJ0sdPCOd0hDFgpId0iAabh7wfQE4xvJKDkZUR89/E7Zoac4ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2fd0ced25f..87cb367676 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1381,6 +1382,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..66d31b67d3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

