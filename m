Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19ADCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n6-0003zO-Oe; Mon, 01 Sep 2025 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mr-0003sx-Qf; Mon, 01 Sep 2025 06:29:23 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mn-0005KD-Kt; Mon, 01 Sep 2025 06:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TneUP3UZlZZzm08Mo0cI9SjOvBZ2gdtcIYWoKAmtaOCQhepA2+EakzQ/DvMqpqK/xmnM5pFc3YhMTp1IUR9XAJP+8q/SYjE2YlndOffSmF6+qrB1cM+45efIZv/NacQvSqZPHDu3VgK8iTK0cf5QNEjU2fQdvLv4VAWUn+gfjlD+Zd5oqvQ+9i3fTnVKHSjQwEfEzZP1rF5HQtLo/kuGkK7IujmB3KJcQxeoTl3J7PwS6YbkP0sWnrKuye3j52NeVVBimZZtvSjCDvIsl9qw98m4uipAHSQSOR/QgbyDUIGuDVBH92CNLTab3pRwjfbE36dpRnn1WSVeM+DVEnpYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6h5bfjOCHi4fQ0FheNjN8jq3t0rgIg4iynlSgu/8OY=;
 b=CDfuBTD+Tte6Jn5ggNMrSOBRFrQhvf0Meh1MATRqaS2P075deqlAOb8SsMW1W7bn5U4zF43AJpN8hAH47MX3rFnwC8XD12wVeMHOANH40wDIihK0PhQ/DXrzVJelohVNrHi1/hIlpadomuy1x0SLFiYfXg6xF50G2B+NEm7nCslk8Zz8rnLC3/FiJrrvdBkARtTouaLSb0REhXMUZEhOp1jL9N+cCEhCOdxxyRCT+Dgc+kgSlpqbG60+O6p36RbWPKnIBmFRYb/Uu22DCVTaldFjSpGvzFgLOvmd8FwPBVm63AgWdc9fCiUELnDZnF74eh2KutkeBdT+1DQTkrctnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6h5bfjOCHi4fQ0FheNjN8jq3t0rgIg4iynlSgu/8OY=;
 b=FbGpr+Q9nJQQYMMYGs3iHjpb/xHHD1J8j1qOQSF8L51tVwylsI3RCsB61GJn/XsaOcww6ofUl178DXWizeoSa2xu2CcRbjAjgevYVhF+lp4j8pjvRnQ1JG031Mp1W1ebrsqWTyv/jPcBIfvRvvM9031UIP8uPW6wSnebZ4uGUe2h7DVw06PSdOuaeQgVjztcEZEebQxmoVw3L24OKQtepXkTuZuic/oERqxKDh6DtDBm4Aaue/PN9GU/UvZXP/CnIjeBxvcR7P0PbLUdLTT0OrxPbOVwI30cNkY4+MqEX2MXO1HJ547Vs2bAQUAJlSMVUWnq74y65LTnhHNrVPxdtQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:01 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:01 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 01/14] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v7 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcGys7Lf2spcrOBE2NGRScqrLc/w==
Date: Mon, 1 Sep 2025 10:29:01 +0000
Message-ID: <20250901102850.1172983-2-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB5992:EE_
x-ms-office365-filtering-correlation-id: d638ebd6-d25e-49dd-0cfc-08dde9425e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DSQzy8PRRAKxoRIkqxs4WMSo4XVa4EDNVQzQczWhqxxa6XIEfUcHvOhqQg?=
 =?iso-8859-1?Q?CO7hVgYQe88U5JLdxjM6TgoABisUe/07xkECrTjQzLQznwZopBMF9zb9Hd?=
 =?iso-8859-1?Q?pVYynu+xSxqGYa0UH3L9TrskG2FzuBNWCKUsRHancZlmwbtZ6OnwsamVvF?=
 =?iso-8859-1?Q?iiIHrvdb8vqBlTEgrRkQsFF3wt3ew81c3Che1lQL93th6nsFDJ6n7HQVnP?=
 =?iso-8859-1?Q?MMZcMre5AdooeEw2x+u2e2scFlBqaUccC8+ol+nMaFN/spgg8b4uinQ47m?=
 =?iso-8859-1?Q?tfefc4PBbacSIiLrtAKwBacfh0CubiqWaIw/7a5cj7tXKWmL5gvHBpfsSt?=
 =?iso-8859-1?Q?gpp6wY00kIMv51WJaP8ImvoB3SoKv25bmKa9MvjVZg7yh4gqC3JwfJQLUM?=
 =?iso-8859-1?Q?tgpdQGPWlS1A8+CiM+zFwKkJ9pp6eRkyUYoQvy/JARlsvAuKo3uu+ZlZzc?=
 =?iso-8859-1?Q?r1+e5JoUJpdKA3gS492EFcs2v0OYEfb+aOxj+lUPnMUzCM0COWPr7EbP8q?=
 =?iso-8859-1?Q?6txHBTHqul5w8lvY6RzfN8uTiY9hP8pxN0nN2dwwIAF7y/a+1K36gTbv9Y?=
 =?iso-8859-1?Q?ZcpH5sX9I2Gz2pTf1MMJoMOsG5VxKBSe1VAr66PAXnEpAydN1nuB917NPg?=
 =?iso-8859-1?Q?kCtlaxF4fVTpXWQ7iNFik5bHX/YO4QhtETwRGq+1p+WFC495q4GMWoN4mR?=
 =?iso-8859-1?Q?jZPW2Qpqwc1JyUKRT+dqP9lnwSTRq0/0AXQ1c99fas5xCiFjjgIQEeOCxv?=
 =?iso-8859-1?Q?GLb3L0SX91sfbQ2JQ1um1GAKLETDa5j+79mlDH1ehJlr4itAvUSZqRlDZa?=
 =?iso-8859-1?Q?eezhAT0W8FaHSOYDAKNtrqLZtomf1QoWyQbwqTr7wz4HyQaqp+OczQ1qlQ?=
 =?iso-8859-1?Q?doTEyizFAxslbKcEhXwHsOwN1FOehdRqLw5RiSp3mdpHugrtW26pz8o+Sf?=
 =?iso-8859-1?Q?ICZ4czN764C+w7ZKigEy8jQR/5PmwsLFHn+oB8aOB24a8tsl4A2EgO40Ju?=
 =?iso-8859-1?Q?sj07W/iyPqf0rc3WkkYk35fJJGq01EjZmtYjfnKfkzzd9qQmehVN9xrEBx?=
 =?iso-8859-1?Q?iC3cLItahqzYhllcawgP+fGwdihvYqgGGfAkzC5AAGXsqC9yVXH5N9/CG4?=
 =?iso-8859-1?Q?jyRT/7x8BpfezGHXVsRI6Mv03focl/VEvIDX4pHJMLctObrRbIKDZryrUt?=
 =?iso-8859-1?Q?zaXfYBvRBEzDHclRTRAvJWOFtssg4iwQFdTisqx9QiLPeEoPkcfoFMN6LC?=
 =?iso-8859-1?Q?qcP2ONZaoOHXcV/TAE8hDwtfS3mTJ09wPTEx1JqK4zhvxC10y8sTldWzkN?=
 =?iso-8859-1?Q?7At0VpA3loipjgtywWQhBNgrnM7lW2dk8xsJ2tqraz/3JBmokEgjPqY1Wr?=
 =?iso-8859-1?Q?kbgCAwra+NFakTcH8NN2Uyd3mODlK46eUtG6reE/Ie5UJM+aJz3xKP7HIR?=
 =?iso-8859-1?Q?1N4i9tLbmtVK21wr4PV7MoHsaBxLYceRAFN2RebAif+kPSiJv+4KAiyer0?=
 =?iso-8859-1?Q?PnQYbkIJJS23ZfdKF1n9WQP6Qf992qySr36CvwcPx1aw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CtobQIHluh/PCG3jUgA+1bbXtNN50BQAnHN0jF+B5uohdAfmD9S1yQH5xb?=
 =?iso-8859-1?Q?G9e87ztfDg+HxE+MX6d3PG/t4ZMNqf9UkA4oEhJlyqk7GezTv9+wM05kWO?=
 =?iso-8859-1?Q?mCv4lVdut+ar5dutn/yOUmvvqhdwHLPpaCeCYqbZdH1DUOdindjeTq6Cke?=
 =?iso-8859-1?Q?fpuqSB1bsUM5ev65Kb/TVgAVWXQY5tr4DWaO8jp9m5saaCcvybyN4VYIkJ?=
 =?iso-8859-1?Q?hLYW4HvetoxWmR9ClLPq2KeQZZdw35EBA13UmrkS86ro7o8PTCpAzlE4cw?=
 =?iso-8859-1?Q?SoJ6DWG/5JUm5C5BfeyxL+/fXtjfHOSNA5hbJPUnNik2TVJpPAqhSPqJQD?=
 =?iso-8859-1?Q?u12z0paO9obL3D1w1/9R3eSf0bh2lcj2M5M7HdMdMdYH+erY2ZOtHLcDPE?=
 =?iso-8859-1?Q?7DHwFZGP0oarwD9CQNNdno42uyBDFIgLug5uj8rD/b44MjigvbkizcVhEC?=
 =?iso-8859-1?Q?+xRRD3C++Y0c57vz+51my273KWRUfGx706pNdMtrGIRIwnM4CdXFssGUNY?=
 =?iso-8859-1?Q?LDRrGgzV7bfe3Pv+GcJo6L47espDhRi1gjBt9o2FpxzjlQOaTpZe4j+YXA?=
 =?iso-8859-1?Q?Js8P3iy2E71B2YtT/6LOyqJtkCo3S6aL+pcylHpUawrUqm9+KX7l7eVIxR?=
 =?iso-8859-1?Q?OqM5aN7HVBvDxGrr0oqZW88pbZf/o9E7pXRx7nOuCgNp1CZ+yYbTD7ZmKK?=
 =?iso-8859-1?Q?j3W9bI/ZIqUC/cFWEoMrVatzDgddut8s24+529xMJqgQhb8AA5XOYL5oZZ?=
 =?iso-8859-1?Q?gbu8lF+xwiqmVxt1sos7O6vRFT6RKxBu7Fn50BMI/wzLh3bNrdSzHNX0QZ?=
 =?iso-8859-1?Q?g5tNjHkBaVdhxkChoEQdcLw/CVSj3kr+3xrnfE9zuGqdhb+4iQ2ksWUEPE?=
 =?iso-8859-1?Q?AGF7g9KIL3jiBaf0iYRRYhmml/46GpBh3QHwedHwbw6j8GG93ZRrjK6X9B?=
 =?iso-8859-1?Q?KhtF5H5TPey66ZjXeDwo1KbPNdROT8DlP4lFEXA0TaCTgLOKEC57zdBQ5n?=
 =?iso-8859-1?Q?C7iDNlnLMh5TCE8BE9FW5BhGNYCCbaj5bciPLLKRyvTgYfaPWTy1N96V1D?=
 =?iso-8859-1?Q?OKBE3NDnredJsi0ZiaoTUI4ypZW+7LJNyEiFQUahNtomEcwt/VwKYm1KNh?=
 =?iso-8859-1?Q?Terq+D7HtgvRlm11o6Xbg2go657V5ezkWQUQAx3dVshifFX5ikw0aLYotl?=
 =?iso-8859-1?Q?rXF+BCuD6KqvBx+sG67SGXhrxV3nLnXWdykdiuEZAzWXzE2Ie5dG998Vqp?=
 =?iso-8859-1?Q?LXDud49XPesZvp4N6ByIrGG/2Del2ehaSst2eMcBVimbWdQOIYcLwQIky4?=
 =?iso-8859-1?Q?YjTVAtsskncrUtG6FTZzBld4060ADLKPY0o2nvPMpc/forlZ4T52HDXmwz?=
 =?iso-8859-1?Q?9YXaFzISoGPQryuScQFGrtSPZtZsnOO3yPhE/JOBReM/+jBA+tD1FtGCdJ?=
 =?iso-8859-1?Q?byjQ6GIsa7XZeK+PzzND6uXyWfX5S6nIhRxv4RNoiLS76XzpwdMuWiuFqq?=
 =?iso-8859-1?Q?PBc0wwN8zlKWeFo8gMy7GfTfQYxdgYIivH2L5qQT2D/xcQvS9OaKdkip3M?=
 =?iso-8859-1?Q?G8W5AVtcvSMXlXO5xbh5lWOPNFS3HbJ32oy53WBUaHOcGXfqx1+RLx69iS?=
 =?iso-8859-1?Q?cI6twZUGIWWUnY4ZpPruHCR/k5soJgAzX0NH8eOgui6jRutt9oMYi4mmim?=
 =?iso-8859-1?Q?/NKfbCi9s/qK5cy28xI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d638ebd6-d25e-49dd-0cfc-08dde9425e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:01.2748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/TD/5BNJmFI7OwUBBmcrFMS6c+FPIWkJTvsxG8p39OAqKlQuJxa9JIdD4X8jWJY4bBAqhATHySXIquSKOYRP5RhwjUcMnZ5oR0GiUFMJi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
 hw/intc/riscv_aplic.c  | 11 ++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..dc6a88a4f9 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,13 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid hartid:=
 %u",
+                          s->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +492,13 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          swi->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +562,11 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          hartid_base + i);
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..113c906357 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,11 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1090,9 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
ize,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

