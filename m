Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B85C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yB-00088E-Eu; Mon, 02 Jun 2025 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y8-00084E-Bk; Mon, 02 Jun 2025 09:12:48 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y5-00029D-SM; Mon, 02 Jun 2025 09:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6EZOYkW1E6lsLtzWIyAYD46D/4K+P2aLu8mDsDxq92nZaM+9quvBIhWWSptCAvDuUSa7rZBl2wBQPrRhxQyHz7x7J9zwALhq7AX4sTfgyjzwRAWNAhWkXoZxOQgWGr4XeTsSlqThsfHEZuSIStHuWvHH60ULU/TIWIgwhx0j0pz/nXKlpPaRjMKYpO7lejvjQp7uqdMcuXnby9By+bX9UtSkTf00bopAt41t+GiP5BabSZCT6YDobTfbZT7n7C3uPRZenN0kAV9LdFGZs7dMjyWU5UfqjohKtEX5SJe9g6UVjsBUWXLIQk9d1MXdR9OrA9Ac/8DrkN0NYu4DlzUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeKS5MbfiqC62WzHCioYBzfmd5mXUbw3i+XBTYm3+Q8=;
 b=QMpC3rpBqXyP59tBdTjALRxDU/dpMAFZiJ4RXBHMBhMlSNtxX3PXvT0hL3vAwFb+eIu/LxY2+D5UmD68x94a2lT/Ryj11sLn3pZ4isYmAOdzqw792CGJrdmb0pmVIM1YvR+mQpnOn4uOG1kDShQnKolIRjTwNhPNb4c/t+hcfS87RalyBJCHDEzz9ubrwsvzw1jibjYBxjee3USokLHqFWeVJtev9K/3FBGkY86RGcxfkwgZyrMOgC/Oe5sTSkro975K8VvjNvoz57ichd5vcF3bscqFDzLt8eGDKD+0BWAn4EEa8i866W/v3reVsLQN3yFHnLVlJxdtqV9kRwE9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeKS5MbfiqC62WzHCioYBzfmd5mXUbw3i+XBTYm3+Q8=;
 b=acWK0h9jWKNce5S/pRLFftjd97cD3EX6H3kSEiv5xVmT5UrR48HEJ26tL6JUd+BnrJtpOfYvA0dIqUOKmTtjpplO2RNQi4GRH/rc5OfAP+TWo0oujUvkEuklvkBp+RM2C6vNcHgjixB4hPJKTt9LWcIDNf2BhQnUqAmqT60ZtD8U1fkOwR8hbztKpMHUG9VJ1Nv2lBxw3vks6BSBPI8XB1/A1pvAlLsAG2OS6CCZGpDaNDCSfo4LgLwxcrW+w6ZXsf/716TZU8K8Xy4CZ/3+Azj5ReT647zUk5Kn3kdYDmvT4ujdyoaBShTa4SgEqBkdCY6unLvQzcr35UoeRQXVeA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:36 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:36 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 4/9] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v2 4/9] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHb08AC0ykxvyWoHkCX6I6wePi8kA==
Date: Mon, 2 Jun 2025 13:12:35 +0000
Message-ID: <20250602131226.1137281-5-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: 595f528c-64c6-42d4-2805-08dda1d724cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Z9u4MvfLC+mY9v1Q6zL2+8F1JSZ+bJwYPJlHM0WKaMYeXsNcTiPBLjNgOF?=
 =?iso-8859-1?Q?3uuVFW7b2f1Wjft44VSMXdwKkgtVUSf6LVBgkLw6n9Hw5375r0g1ZI/ptB?=
 =?iso-8859-1?Q?KgggbcfyDeRri8uGH65FcvsJIxrBzu/amaSgtkJ5MTkulX+g2j34VZ9b03?=
 =?iso-8859-1?Q?Qir2CJMC6nMsoX/o4ceej0U4qj1Z0kkzd/ThyhSwbTZWw+zyxhsYPJXAdV?=
 =?iso-8859-1?Q?9D0hvLADncs8xaeea8sopVGo3VIRD8CHpHa+zFMzr56sIRAcNL6wIRn5oA?=
 =?iso-8859-1?Q?q11JzZpXmYFSO/MFXammrHnj4C9rLWbfr6RLJZVggPpWenPDeYDMBL2nup?=
 =?iso-8859-1?Q?oc8DEU5xfAx8p39RYEExPihiWyI6YXoi24MYUTsa090C22ifJk4encRNaz?=
 =?iso-8859-1?Q?btvBLsn5BQqE7MwSaobEufM6MvzpiMRhf+8f7pgfwcK9z2WPFd48VauWMT?=
 =?iso-8859-1?Q?JthEJCYqk0fQeAVU19gJH4BkNC38A3o8V2dmZuk5wptJSbfb+f1vT3fCAh?=
 =?iso-8859-1?Q?TKNskr8X44fmSOvBPCZdSAeCwk8SaknUDD9lD4WtC1xfwaWr5++ATe0rMc?=
 =?iso-8859-1?Q?zN6KJONKc4YJQhMXM2NErhyqY//Df46rop5yY6X/8nLW7WVBD4AB0MRFqZ?=
 =?iso-8859-1?Q?tIdcneF3Qs1AR7TtIL8nlphYb6DKQ+rtERSckCUcdZPiBQvHKx71+ze7aE?=
 =?iso-8859-1?Q?hkTu58Bj35QxcMcDpZuTuZoEfkJY8S2ylRLmkpZI3xgvu8HxGn7IIaMaml?=
 =?iso-8859-1?Q?JE0qlpHMOJKKfNcClIMLXDp4jVYh/8yFEGR9CrMh8p0yGwNdH6cujyvHmS?=
 =?iso-8859-1?Q?lWGE1OLP5CLaF5s7rFOyv54M6Bd2i7AE4/cW63cWpU2zfZWTCyL/28Z8o9?=
 =?iso-8859-1?Q?NJDaM7Cg33SCeiemJzIt75h2SdDasV3ppza5jg4WwTSZSfsBdXEWQ6Nl9N?=
 =?iso-8859-1?Q?ngIdPUhNKI1d8SFBDkXT6Ju+HpANlWWhGS0YwZuB2ulrsqYOCWrXnhcr+I?=
 =?iso-8859-1?Q?isY8nKaHkZ4wKD/zLAUR5hP8PdHpPeDpOdZm4p5lxskynq9TE1jxtzrz1J?=
 =?iso-8859-1?Q?9g3iIjb6pEgsjYrF2iLnn93xJXgzufX0nrof+uwKuu3fqlZVcsU4SS5eNu?=
 =?iso-8859-1?Q?3UgVBYwPg5IA0Fp3NLvcA2UiJ93rYXRX4m2eDAC7kDxrfXEKd+fsQwSOsF?=
 =?iso-8859-1?Q?dlFwMrgfUNTyyS+EQJZs9dGILuNGnTD4B+FpjxA53rmiy9lNNrS5Ew+Zft?=
 =?iso-8859-1?Q?Cj0plSd+LsGvhqfPkM6e4AAod2WInvFakgOziU4rQ0RztqyCcy68oF11vM?=
 =?iso-8859-1?Q?LRrYGyEzPYCVaqrU5pfS4EapUihdMEFugtdXEoIQmZ0jIUp64MzIuRC+Ro?=
 =?iso-8859-1?Q?+57fQ99iLKTJJGxGvzhOjhxgnATlFDkUtMKauGdDo/wGffOfPYDS7S9ngz?=
 =?iso-8859-1?Q?aq+WthvfS5BbrHsKSyINdk9enMRKCsCyThh+HMQArMLaGWXwuzMPy7LMrB?=
 =?iso-8859-1?Q?+wPFPXZlevQYkZGnAvZDsfoCgGAKpXxHt8UWwdyx2zRWOP27FiN8MGJOzI?=
 =?iso-8859-1?Q?qrJUEaU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jSLt0gq59nvLyrPssKT3BaTVvbsNPrNrdBNZjkaGRsO57ArC5360v16FmV?=
 =?iso-8859-1?Q?O4KX0HVSZIdVQA3A5qdv8Q2WqdRFGn4u90bYSA7n5OWFikII1QMEY0RKfk?=
 =?iso-8859-1?Q?vhfl7RzgdggHVjjqlarw28dofXYXBPn+NDEWHETHZLS9mLjRYOvu8BNwTO?=
 =?iso-8859-1?Q?/PDzRJQosWjW0/MUL8Zkl/yYhuW+Ho345AYk+r0A5GuV/E3JX7tbs3/IM5?=
 =?iso-8859-1?Q?xfd2uhsyPdZNfj/wVxT9BQNorOs8IfU7dC2qoidT6aF/Ed/lCAlRvEcPp9?=
 =?iso-8859-1?Q?WYJJyPTtWnnhhfFbRq0UFLx66PVNbUlQr0NNCq+ufMM6Ush2yJcyH053eX?=
 =?iso-8859-1?Q?KOaLO8XfbAGGjQLottd0t5sxuXQgYJxoRPjRf+gSqsfeWsm1BDFGeikS9c?=
 =?iso-8859-1?Q?AlxbsDir3uwuvjg/tXRrP1hvQFcApUMLdl6VJVqBf+2eCcFnP3LlbTk87y?=
 =?iso-8859-1?Q?iw4mQ3r5YXDvbRtfmlqqBsc9Ge02Ny4BsNnnyWepcfA3H/k/2fMSPNNBi8?=
 =?iso-8859-1?Q?xnxOTMZUe8yr9UKSQVaXbbM1YqEi0ZKXGXFZ/Vgzf562JDwAkZbiK7SPUV?=
 =?iso-8859-1?Q?qMS1D6+kYko/SWcZnAfIRwkBzQFsDwDFZVH+P1hCxZj2XmIUFaZxLfB4e5?=
 =?iso-8859-1?Q?Srm+VytOKVJkl8RAynWuJeNKLSYDngFAcY3RRPN8zhYqt1KT26k1qqa2Yg?=
 =?iso-8859-1?Q?WWXN3/4rHB57uAFFfcWFuKBQ79T2OxV8/ahy4AfEXhTIiw+njiGhZ3ZavT?=
 =?iso-8859-1?Q?9u56ZOfaT/z38QA/J3Fy00GJ7qCfya/qZkoc+B4johpmwhUe6x+5aymCfa?=
 =?iso-8859-1?Q?hdvEWySjZQpTx+vyMaFDLeuvdJY2El4PZiWdr+H/2lMf1BYhPJglJr+FzO?=
 =?iso-8859-1?Q?No7gMk9forfRMCiUHYVEZUWqql+txdztjPNLeA4mdWB8UyYnvZWx4HzfPh?=
 =?iso-8859-1?Q?q/QgobL9D97OYCp6cRM1ZsRbvx3bksWFz3YzvbHbcZJrNoC90/fkrhyVyj?=
 =?iso-8859-1?Q?TGpQcgyjcXNiCHwzvDSlFsEsTatdi/cOAGvLvl5NKFtNBV1FFSemzL52kM?=
 =?iso-8859-1?Q?Rj0HVSJmb+rZZ7OWkVYac7g9DeINXRvUIFTeGcOuMcnCEXvA0qJbGh+r1r?=
 =?iso-8859-1?Q?jK/xHtONQILhQgScCI9/3xmk6T3LFRPKgEZGd28zmQN8iQK3IN6IRqR/RW?=
 =?iso-8859-1?Q?5jVC9E8uB7kr1Ff5pyb0EX7C+s0Utv0yhy7PdYHtpZ1F1tIrwurhlZsNa1?=
 =?iso-8859-1?Q?eX/y66X2Ie8YIdkdxD2taL3FYSCgktl99O7VzvRkGfL6z7TwWxjr2T2ovY?=
 =?iso-8859-1?Q?ZmENZQvSKRLt6Re7hUj95sm2ksXcTWLHhezb00w2kcMzMkzPnBA6ljxTUU?=
 =?iso-8859-1?Q?v2YjxwvLqzfWaF0FzC/AFbcf67UQyH++AokgpG2O1UxQhC5kCJn0mvdLOq?=
 =?iso-8859-1?Q?UpfLJS82QA2u92SZUIMzAxNaLjDP9M2We3X4z0j9qo+J+l3NRmmXgJgDbo?=
 =?iso-8859-1?Q?ns75T1PRLCDY5EOPZXp93Y64S09m2vsc4Dsca5uGSKfjCx9Ci1hwhzgPFh?=
 =?iso-8859-1?Q?IuwGQ96pfy17gaSfTZPn42wOWiPbAFdbDK4xXRtA1rv+vUane8TnmtGJgs?=
 =?iso-8859-1?Q?ku2U4DiZJd/baGEZn5kMJWbzaSd/JTK4O1Kz52/5jE7BOgKNh+IF5fU4x0?=
 =?iso-8859-1?Q?sbJT3fIIsDgZUs4hiZc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595f528c-64c6-42d4-2805-08dda1d724cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:35.9005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3kpj0IX1wrus2Fq6/r62RxXhGzGv2bgQr/mF9wRYQdJSejZVeYdKkd0gfLdVd3pCGwgEoacSb2aDTSiZXgY61wkf1C1t89xFzMULs62P8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   7 ++
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 219 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 519d2345b8..db2ad1c08d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3181,6 +3181,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c0e048a66d..984f93dd4a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -497,6 +497,10 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    uint64_t mipstvec; /* MIPS tvec register */
+    uint64_t mipsconfig[12]; /* MIPS config register */
+    uint64_t mipspmacfg[15]; /* MIPS pmacfg register */
 };
=20
 /*
@@ -970,5 +974,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
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
index 0000000000..e5e908fb32
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,219 @@
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
+    *val =3D env->mipstvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    env->mipstvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D env->mipsconfig[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    env->mipsconfig[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D env->mipspmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    env->mipspmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
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

