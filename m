Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F1FF54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o4-0003mO-9N; Tue, 24 Mar 2026 12:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nm-0003ig-SK; Tue, 24 Mar 2026 12:40:23 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nl-0005LR-3M; Tue, 24 Mar 2026 12:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvakYQCGhwi89aC70UglEW1T8KOybQG0K/WnAPIBQKb2G2c6GQO3AkG3jf1rzOpTdtLK3T4Y31ueBLVK6KfaITyNu5AZJqmMFZyZ4TaaKJtwduHs0afrJ41M5lvb+hgeo9xj3qcII3t9JzVB+mYoakbEnbZJBQLhxHTqIGDd0L93hs5wXgvHRcbSkWyKCsXm+NNDWW7/E+iQTv+u+EAnN8ys3vme0svLRj/e95hGL5XRIUHhDutY1nKfoJYdqDeSlFgYAiX4K/3pjWTpaJZVSaIYqeolA0nzLCVf79VNFZyVe/FvvkvDYjN4wPYENCmhpV3h0hNZHD72oFvhWxLhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecCfSg8uDGE4ujf8sKSBImdcxzfMnPxIU4Dlw7Q9APE=;
 b=qBxZWWidTaxXzlkbd3NZiMvmDCA1kBTUwP/010syTTlilmBd57Fw5TaQTl267efpzTRO+P30f/XaQAW1k+YgUQrAghN1gXiGkA41T0EZC+diMlh8MQeaLrkTnZZVrFpThldbDfIUSdD6fTiM/3f95tEK0blQSUrsYmZ+X4TflywwoqfBLiPFbXx/CFWvbnWQFe1LKGR7XVPNI0HCh50erTE5jQVxMrqDK2N/7FtoH569N187Fd2e2CqAN3uBmg4w15Ac12pLALRXPpLNzoVhjJw7QTnTpR/D8UqavXyEu/HIhlF5NI4jkAW/HnIwLYk32u5ER9qvNUfW/YktDxi6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecCfSg8uDGE4ujf8sKSBImdcxzfMnPxIU4Dlw7Q9APE=;
 b=YABQoQFLTKYE8jrMcxEHsYbYU4ts/QAE6h+GZ7i/VdQWJf9NzxNqdhLolabXixf27GdUYxMI8h04TDdvJONUK9380qysuSUK8yXqLRMw4gZWQ3S11F6O4ygMN4T6U3+b/ozoulS9515GxYywqN08WmRDi1f6H+5yOn0tKxOcCrlHKspnZIEQvcx4Pw4b1TCFs2wT848skJC68n69dvbi9OyDxPAIv2tI7zxkYE8THevDfV5zgfk0Miwk8IlKjuSkikOj9CsXhEzNNKqkP156t6oO8vcC9GBD8Q49E41DKRSYCY3er0P0Zn4L7Y+BJOWGt16Hh1bptznHHJ4HLr2Nhg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6145.eurprd09.prod.outlook.com (2603:10a6:10:475::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:40:16 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 2/7] target/riscv: Set endianness MSTATUS bits at CPU reset
Thread-Topic: [PATCH v5 2/7] target/riscv: Set endianness MSTATUS bits at CPU
 reset
Thread-Index: AQHcu6zkYuleY+yzyEiUSjKVozh/ZQ==
Date: Tue, 24 Mar 2026 16:40:15 +0000
Message-ID: <20260324164007.549397-3-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 2cf23b6c-d4b3-47c4-9c7b-08de89c4072e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: aEi6ijTkuDDBN+qlvnV9YSo5rTT3BWgRT63YlvI9axRBhQgRr63gK23pudteIxxzA1pk9vmRKMe7kAHm8r0TJ1ZIWwjKTzG33DbldcOjElE34sCMrEkloYJMmwsaqYmQRvh13VlQxz6T3GQdTmNrOn4DzNRfdv5ZXGnF1sFnIZzSFajk8xrDi1ykrI39TgkA4UC6ed3vAW3Caw6bTfLkfsszDuDuU4URafA3wfLFDDAGl4m6JRLT9Q4SCbK+GvK/wGHfN7hoLyp/d1ZfFJqswOa3dVtLZJ6pinGkAxlBwqzpGKeekOWiIwfrGLELnjD6xStHxqlnHq+Drktn7zpJvGaJv58XRcbGO7OJTsLOAmKyyNj7pWwLNAclJ01NZndSLE5zZrbAqV/h85UIrD0mjJZ6FCHNlsdxCZfraG2OdWdFtefsfdrO2DABbmZGabfLNhI+ApY+zAZvM4bw51ff1RF3j0gJkCTUohH7SGf+2CbImqG7WjuzqzpQRCOQcupcXTolow7Q1fto87w84ZK1TZC3ieHlHFE5wlK3BWN1kXyHnZLxPOCRw1ZatoUMVDEzYmout9cFG/3KKeht2t/sOMsXxCgixCreGyNFjp7rOFne6lAMnGOXk6FfyyFS9nmAESHuF050MnJH6f9zH7nxEVtoNKYrLzxltuuB2/GqAkedohsAj58jSFTw0tA/pItJ56JIfejSVhcZ7W6MJlXu+rQTEdNL+9/Hp4+abZBEG9IoyvEkEC2sa6VaBRE9Wsop0ommyehxYqwBgByfEF0F2T9T8CQvXpqkti4uNkXX/zY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qQFR0iXtEIzec69UVWmHH/Yd0/UWgjPhP2Z99EIq86Ac+QAz0YP0UYps0Z?=
 =?iso-8859-1?Q?A9ZoDpzoAB4izBY3WJBHAYVvigqaQurrCgH5x1EYZjBqHn/Y5tUmBp6K0/?=
 =?iso-8859-1?Q?ROB8wiunTOm/6xxNM4maxCrSzoYmcKQMdWM6oH8BOY/Z94BCtLgYR+FaGw?=
 =?iso-8859-1?Q?zKVda9or1P4Tq6mg1ohzrdbHII6UYeGJeM5siOQ0jYxhaDBLwVD3NVVPCL?=
 =?iso-8859-1?Q?/8GpUgbnTmuHTKdRugAtnMvZt63SDqBXaf07DHHtkS/0srJ8BDVOJm6Lo0?=
 =?iso-8859-1?Q?pjI28uCF5lZWL10hAYd7n6NEKtecLfE0CAqYL/rH9/KcO4pav5roaGAqp1?=
 =?iso-8859-1?Q?egDnaHjZ868nsm7dZbr5426Q6+RW+Je8KnRnVppebRZ+lz03chktBLjJms?=
 =?iso-8859-1?Q?dBTZ/IXqLbLnEgbiPZwGe+OHLVbCq7ilJtPkjenfRTKFVxeQhFf1gPjyak?=
 =?iso-8859-1?Q?p9slMfLXqhoPz/jbDeIOQ7kngSZfRpLa4FKfcEKU8OXYwS5EX6VLgJqJXk?=
 =?iso-8859-1?Q?DIJHHffloNg6vlewCkHRQhy71LAPKpJMhzFysl9j05yf55Arv7wicb5GIS?=
 =?iso-8859-1?Q?7gd4ANOLTQ7Tj0zP8mpkQtsaUgZ3kC9XDq4K3YKDJ7X3NFYsaXTWexeKij?=
 =?iso-8859-1?Q?DvROAntno+gjbThk7jeDOKVin//s7/gE3X7UWFnDHeA5CDPnqZaEPmgFu6?=
 =?iso-8859-1?Q?v+H1il2+5SABAsMYIT6EsSqc87XNooRWXkzea5GSM96zIutb7OiRRouWlT?=
 =?iso-8859-1?Q?wk+u20MOx+YyTc/QNGecQHMEld5cqkufSNcKhgdAOsGQfyIIdI/T79rqXC?=
 =?iso-8859-1?Q?OiyUYPDKL38eucT0fvDniC0VoIYrtVc9fhaTdI3QhE56pXsY0oxOUsm/Z3?=
 =?iso-8859-1?Q?UsOMh2QsYx1k1gPx5jpjdB/nm/N/iRc3iuYZmihPulFzPlkLfi+iIS9mH0?=
 =?iso-8859-1?Q?u35S6Pnmhg1DFXg54l+vXhicplxvove2SH7Bd70KWjTY6g3e93WnObHphL?=
 =?iso-8859-1?Q?5iHaLBP8JJcSXHn1kA+NgqYei2+WvY6/aASO6eAS18Mb69QNzgtveuaGEe?=
 =?iso-8859-1?Q?IJmHiJk+H2aSvV6uv1RZ91egxPEHXoa+H/nkODIfhBCbJn/ejIqvM6ozU8?=
 =?iso-8859-1?Q?C5AbCRWy7uZ1ixSpjKXiF7TF1mx1OLu3+WNhT5Wgtl0MCV8NH2mDirQM7O?=
 =?iso-8859-1?Q?0hOuY4JPotV4O/8F0gWgAk20L3+c3Dn7oTrFNLB0mWKzIbtCXUE+yoIcIc?=
 =?iso-8859-1?Q?mHHTKvbUYtxeTS1vkGgrDFdDcUmUDDrAWejZapzYYJzxxKACJgnR1QmkSl?=
 =?iso-8859-1?Q?cZyomQZolcKSHZUOkWpRsB0cHNFhYkw6mZL/8VoVGsrad//cDutGfGMNNK?=
 =?iso-8859-1?Q?zjzsYWAghFDheELvE6v5GaSzNy4+inJ88Z3/SPtMe+xsPt/TjPmrB3xOvZ?=
 =?iso-8859-1?Q?9dpBRCYBVMdu7h45+zlnw5Y4EsdfU39f+DEZOeD++2R8MK7hoqlSlzZElI?=
 =?iso-8859-1?Q?Vmzu15oKhw8IDncUZmQgQB2qNeUzDVSSANNOR5oje59IyuPJdjVh0BXJP9?=
 =?iso-8859-1?Q?zXeZ9/KPtubeQCZ/v+wFwIiPy8VaR1tBf2BylJSjqCgybw6ZjyC4iZtIf2?=
 =?iso-8859-1?Q?O02Gu3k5mauywUNX+t7SMMJ81eFAc/NbYUDfL1DC49UOS0lj1ULECQxqgC?=
 =?iso-8859-1?Q?xAuzuZruOvhsc4WUbewhru/7HnxJddb4vjynwKyv+3p9tQbRZNa1sUEuIG?=
 =?iso-8859-1?Q?yw1ajvOHwx3i31atB3CDCdfJ6d5sUo7R7Z9WXqCSEY3+AzWdQDRVS5ilDd?=
 =?iso-8859-1?Q?gv5pW6cDxV9W1JKNDF0Uk4l5RaNyzeGe09Up36r04qTZKJF/FpLc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf23b6c-d4b3-47c4-9c7b-08de89c4072e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:15.7164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZSjxQQSh1XWLuvI1oZN8PDf7iMfQESJp3rrjaaex60rdfrQ9cXJ9kmMdTepgNrB4/5EriEzKbLp2hq8GUApihN8k1SWsn0tZCHrxVYolNk=
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

When the big-endian CPU property is enabled, set the MSTATUS_UBE
(User Big-Endian), MSTATUS_SBE (Supervisor Big-Endian), and
MSTATUS_MBE (Machine Big-Endian) bits during CPU reset.

This configures all privilege levels for big-endian data access,
matching the RISC-V privileged specification's endianness control
mechanism. Instructions remain little-endian regardless.

Also update the disassembler comment to clarify that
BFD_ENDIAN_LITTLE is correct because RISC-V instructions are
always little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4537305dfe..eed5afd27e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    if (cpu->cfg.big_endian) {
+        env->mstatus |=3D MSTATUS_UBE | MSTATUS_SBE | MSTATUS_MBE;
+    }
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
@@ -803,11 +806,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
, disassemble_info *info)
     info->target_info =3D &cpu->cfg;
=20
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian =3D BFD_ENDIAN_LITTLE;
=20
--=20
2.34.1

