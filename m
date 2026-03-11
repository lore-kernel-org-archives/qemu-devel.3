Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E428C1062871
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEF-00007h-26; Wed, 11 Mar 2026 07:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDr-0008F0-Ji; Wed, 11 Mar 2026 07:59:31 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDp-0004do-UN; Wed, 11 Mar 2026 07:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rsce3emvdIPALuyZsy1dLWNrlwA1ycSWCtFfgVOdc4cjkaLiwB1EZCm3fW5PMextE8HuT/SdjGquormWS29zZcImfsA4z14DlR0ErpYnonGUwvHnX1Mxq1AQh8qXt9XVNJXzM9+vOCG/Z1WKwDz8bCvr0d8661erO3ZYLNQ2JM/ft8438n4FxGhGRWXWjTx8XOxjQS/OnOGCzQ+NsyEv9+Ag0sbqckGHZhSFulydw5LwKJgBxlQFK4lgQi2Zl+bY4Qy1lbUqwmUXJpuThkBzPv9z9bxfJMX5/ZJTdIKkjMMqbL/GVSuvmsC4kkgV7kZCnwmky8s/ru6jYryBaWDZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkei2kYdtPHqUpnwbmqPE3IhATTJbwItpyNatAULDio=;
 b=gQe/cbUQN11oxNIJIHnPNtWSthmv68W6T1P6oxWu3PnG7bHWbzo4hGzrM4oueCSNo8kzW33ThmTSa0RAZltm5Hf4ZdmW26+mVz6JFHYX5qEDc4SOteAxi/tynzf1Cgqnzo4XQO4x+zj0rGRvum4BI1KT1V+cUVMhs2iMTdGQmUW1iaZhDfnnZRkGinRWWIZxuEHjO9PgBTDZ26WONAwtAj439D7f0so7+C1fXA9XEH+XMRcWjtVDNzaUkcMcDMrr0rV0L4/WqBiahvA2E02jYlwCiQP7H729ofS/Q7bdvejNwWZNHY1WLkjHG3JGekFAgJ7H0fLVj1ouquX7p2ki7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkei2kYdtPHqUpnwbmqPE3IhATTJbwItpyNatAULDio=;
 b=mGIA8tmHuTScOqhs/S2Qex8wv0vPjP3G+yNEtJ2mZQjzLS1SH89NzYi1I4DzzCTnYPoW2BRaI+ai/7aarY6if1ylc9uQEjWfUw6Ms9WcItZEsUfDB39Dkz1KpZs8RjdjnhyC6xarsZQVQfT4J2EL7unHN0mGyRLciAlDFASF3kI0XtzoPn7SUJg4ffD1MZq9BmF645kd2NAfgx7eC2fyxfZ+DrrZff4VhQLtWdhSzGQkvs0j1MR2dWER8x29lMnF0BUnE+mtLXv41VuSISBhRPchB2M8pnuVBk9UNrObHp3uUn5hbubW1VByHns/qksR1iaQONkCy1a6Oo2cWJdM3A==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:19 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 3/9] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v3 3/9] target/riscv: Add big-endian CPU property
Thread-Index: AQHcsU59vqrNlKryJkO//TIQ3aKIxg==
Date: Wed, 11 Mar 2026 11:59:17 +0000
Message-ID: <20260311115910.564481-4-djordje.todorovic@htecgroup.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6069:EE_
x-ms-office365-filtering-correlation-id: 59cb973c-6a8f-46aa-be70-08de7f65a02f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: a3tLxMNPdBICHBgJW97RFHfzVprvzH4KuMMNKmBFNX749ba7TSJC/2e7JQAeNK+k2tWCjM522TkeFEuwVaweJVKiLzzUX1THdphbLTK8oEPVVGFetAb3MFFESWlRbjW7BjxFa1bkbVdjSA9yr9/jb+co6brlYD0vfwrnwjYYBByzcEzTXVim5XjFBTLXwK0xg4uLMs/AC74KYvgT/ouaEdj4c0GF3zRwG2yedFxuRmQym4o9E/CoTTrb5uPwBqNemJSTgCeORq2t119wLXQPdPOQzHuMDV8AAIvAeGftMuBW72vZWfTu1duZOqAjqGYW5TW9D9pYYKEyBbXTIzYLiodgXKB4WJm2ig9Cy7fWv3usFJzlMtDR6OHCqoR4w5XNOu8fHENDwprStMi1zm0JcbRWZkmwa7tagAbRzEJK+MbID3Ds+UmwS+qDpHp/c5Sc93/NnKzaRAY9AjonE6FxHXYmnimmMFc3dpwQA9Pzq1KjBMax4GUMNjS/uarrikDitMOpKUrU6UwnFhUz2dFhSKKSEsJYssxJlCLVucYQ9Ecd8EXTXAfnI8Y5E56oBZvbXRczkmrAakDmTKdEs+m0KhjA2AqPySoH6sDrEejTLC4QPuWX69MUjYHSR7W2BHX/TiQcb+bBo9Jm10Ln42iNqN5TM6hZwFL7E4+A6zm1qgBHkQoibBVHT12p5GeK9mm1ImaUfCLmS+5v+W1Aok68UhTG721AfStoGe9joeDTKC0XxoUhL9nYU5t/FB6EaRYGM14IeSKCOjI2cOn/b8ujSgWkHzSZjmXIxHvyhG75JzQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cZUvQ7gtqEeqagbw03eEeEUoyihpjsXtNtu4lT0PPHUjAHYI8YLOEeD0+J?=
 =?iso-8859-1?Q?FvQG3VqzZ/dT0jsyqgPtFtojlsnsdhQqPMEFRC/qFfUpelTvSnXnYYyekU?=
 =?iso-8859-1?Q?RCQIo9bxaOB6zA7apqQThHkrxPYYn5l8x+4LKrkTljzgi3bRB//bl67Q1g?=
 =?iso-8859-1?Q?4H4ZnOanotEoF8BxcRpUBgR89xjT2z0xduZMfe/QnPtnHv5LQ2VmaCjx1V?=
 =?iso-8859-1?Q?6DxlgLna9WeW19s0igpMSnthzPMxetZ+6E4LwrQhNaWmpcOf1CHkXs6I1I?=
 =?iso-8859-1?Q?dmtsvFXuf9lOgvu8mTSdENryNFTws3b5FWPvnYqPwUELV4a7nF948KB7kd?=
 =?iso-8859-1?Q?GJeLJPQbs9JQ6Hv/vF/ZXQnMPHgVXfr/DqqfNrruEXSQDy10AdrdYyPare?=
 =?iso-8859-1?Q?HqNAGIo3eZNfLyAGz1YZLMZoFfDEgIDQGoh6h0ULWkT6QCRhwrRVWYCSO7?=
 =?iso-8859-1?Q?+tTG1dzgX7OvNY5JptRIHd27bmAbf8GMVwlWQ4LVJNNJru2X+Z4Z5t6XR3?=
 =?iso-8859-1?Q?oGmKz5w9MxXi3luv24CoQ/UKFjcTE7sYOK7znoYJHP4selw93LnYrLcyik?=
 =?iso-8859-1?Q?EuYo1gVSr5qIyvr9EbMo8NvgCwpZm1o+xAWU4uXXdwybzK2VQ7ejJIa6sH?=
 =?iso-8859-1?Q?hKwy6LOWWi5ymi0JvSEAZGjOlfW1nzCtWXkm+uOKGd8Tz4cw9ilTS1ARsy?=
 =?iso-8859-1?Q?A7wjLyLcKDzlGdbc0rkKEQkHbBNJZBu0X7D+/esFjpVTz5on3KWjsIwCUz?=
 =?iso-8859-1?Q?KstQI1N9uSBFB1ZXpTcELf0GJ+KJh1xPR6VthzWpIpD79C27wy3QewGfO6?=
 =?iso-8859-1?Q?CIb15HQQyA89g1uJS7CxyMUzW50FxvgXlrCvZnTTgAZEfeM67NsBbaheat?=
 =?iso-8859-1?Q?9ICxidRIVYyloLx7KsT25elW9ndsWnZy7pB4wN0d+11rq8M78u3DqEJl0E?=
 =?iso-8859-1?Q?Kbk6pYELCvMmLgSD6oCbXL4rDndG+irfVRtIGdBjg/uyWYR2pn3RYijzRF?=
 =?iso-8859-1?Q?UoidI1tctIDL0puGzG5vyoeihvOeVzrG8aBpjgCB3LQ8trSAuxrag3Okfp?=
 =?iso-8859-1?Q?3Ax/wO5qeyR+HDdG9QmIxXkl61nYErl0Q18S2hDu5JZTAG4m7PdFISeF1S?=
 =?iso-8859-1?Q?QYWHCc/M1oVAbKPxtW2R+suhzWJTajvPIAnQxAUlNxv1WSPrKCTQe8TNoo?=
 =?iso-8859-1?Q?0eIvGgiBvZg82DGSOUs75yhA2ocb4ZmKsH2hxKglPr5YBKs8DGTVVDWIs/?=
 =?iso-8859-1?Q?q6bGPM+yLTd0cM2FEjBoML8KtL5DjB9viewY/lUz8AUbqA0H259hUKzsIZ?=
 =?iso-8859-1?Q?Iy0SxoVSHi6rq6mbY5qSO7FuFTKkjalVaax5vVTX/yn+OuKGthnNLtCvO6?=
 =?iso-8859-1?Q?0ibeOIWqhYnIQp9YCJIq1rK6jF3bs2Lf61w1u05SHbjvTIYO7Vxa3v6fRY?=
 =?iso-8859-1?Q?o8A9kPZqDABH9WP81k4XO5XKCblO/KTH+Se4eJltVDR7VlJMw4X2oe7no3?=
 =?iso-8859-1?Q?TuWy1HLyuAEwyZoQjdA2mpXF4aaGNGU/7sJiGNPACdCANjnHrepWobHzBA?=
 =?iso-8859-1?Q?PnaOopUNIJ4wp8qLNUgQn4T584yINKZa6GL19wv0mWarG0aUHeX/KEYskf?=
 =?iso-8859-1?Q?uGaQw1HHjnGQSy6OcZAp0LL5zwlJOkgyYYqJFpEuqJlW/ezgSwgxOw0kbo?=
 =?iso-8859-1?Q?Hdo5fKPB4v7gPK7iYF7ntZRGgj9GUvj4rgVs/94X/ycscHqQrolr6YjIYM?=
 =?iso-8859-1?Q?2W8nF22bTDewDp25e6M6sR5XIZQHs56/njwFzXjYY1p7jqd/DHBTUso4LT?=
 =?iso-8859-1?Q?g7Hm7gLWw647iQp3QqZuktph1n0A/wgyWUk8U5p/mE22+5DAz6s8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cb973c-6a8f-46aa-be70-08de7f65a02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:17.9929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aINS349rHmvxrQxbqZ0ol5CFeCLK5hb/w/0EtnDSMGyFAlLDpT85j0pI8tAYq0tVSLKtPC/A+iNH/krR4w66+8+k2+2zCMhetso1bRajJ8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
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
---
 include/qemu/target-info.h        | 9 +++++++++
 target-info-stub.c                | 8 +++++++-
 target/riscv/cpu.c                | 6 ++++++
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 23c997de54..1701cc1c9d 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -50,6 +50,15 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
=20
+/**
+ * target_set_big_endian:
+ * @big_endian: the new endianness setting
+ *
+ * Set the target endianness at runtime. Used by bi-endian targets
+ * (e.g. RISC-V) where data endianness is a runtime CPU property.
+ */
+void target_set_big_endian(bool big_endian);
+
 /**
  * target_base_arm:
  *
diff --git a/target-info-stub.c b/target-info-stub.c
index f5896a7262..b6532c419a 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -22,7 +22,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) !=3D sizeof(CPUS=
tate));
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
=20
-static const TargetInfo target_info_stub =3D {
+static TargetInfo target_info_stub =3D {
     .target_name =3D TARGET_NAME,
     .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits =3D TARGET_LONG_BITS,
@@ -44,3 +44,9 @@ const TargetInfo *target_info(void)
 {
     return &target_info_stub;
 }
+
+void target_set_big_endian(bool big_endian)
+{
+    target_info_stub.endianness =3D big_endian
+        ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE;
+}
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..305a8d73ad 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,6 +34,7 @@
 #include "system/device_tree.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
+#include "qemu/target-info.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
@@ -941,6 +942,10 @@ static void riscv_cpu_realize(DeviceState *dev, Error =
**errp)
         return;
     }
=20
+    if (cpu->cfg.big_endian) {
+        target_set_big_endian(true);
+    }
+
     riscv_cpu_register_gdb_regs_for_features(cs);
=20
 #ifndef CONFIG_USER_ONLY
@@ -2641,6 +2646,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
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

