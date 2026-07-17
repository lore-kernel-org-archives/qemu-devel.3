Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F30C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf42-0008Rn-5B; Fri, 17 Jul 2026 05:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.bueno@openchip.com>)
 id 1wkf40-0008Qi-Uq; Fri, 17 Jul 2026 05:41:00 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.bueno@openchip.com>)
 id 1wkf3y-0002vs-AD; Fri, 17 Jul 2026 05:41:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWsnxMlns72AxKcx3q7ZauKnyS10/ImpUCPHPV1ET68xVXkTdz3BqeXTW0KmiwvqAerjdPCJOxiL+IXVVcFo5fCxQ1f5w4X9bz0zhhfUGTnVsBOJKoe0OqH9ICDWicc6MzGLbICdon8QRjTQopE10F3i1LDIucMl4D7v3i5l3vz47vU3Cn/y88AXE0dqiGafjDeOmVs/MxjJi81qNHCBGqhJ98g+z413lzGdbmDQY3QAyJSC9jq04fQh30jTxUZ0U4yMn37JgI8t4becy6if/le6mvVgiJJxklmSC7AfjyCCi7DJloPipB5uKQopkrw2q4skgoRtz4O6xxhqBiLHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMEgE4H4p+joBwtncGCuY9P8nNAJ/QgkmfMmr+zGg4w=;
 b=KhP2xy0KvjIuihvqnHLFTatpE+mQhd79Bu8AorHCjL066PuetfeiYEq8ATLzczF5EpYwq7elsH+0JJqa/ThS3br7xAl1lb1F2K5AY2GiA0kIKxUTzy3OafDuG6V4D28VTVoA37Op6t9FBMF3se2l5oWnyxbztkdGxe4UA5tFwHfBnbzUsRENfKRY23px6Mhq4Xg9U2McVpbnjl7h+QoxhWB+6E2I5d5z0gQ/AKVQG18aBacuxV6vdA7x/iydJVomcPQ7AEbnQuZk6MCQN05LEefVSNUYbfE7x7/16yYfqhT7+fpKsCX6EEUl8X9fBhk4je6eIVb+4io+GLBqgCPIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMEgE4H4p+joBwtncGCuY9P8nNAJ/QgkmfMmr+zGg4w=;
 b=InDrFhhdkwsFUv/hFxhLrw31nhI3czpy9vRHcjlI6N2KW7O5GNrYFQvd95I0Am3+q4J2xxvUrXFI5NTpXHVysaoRWZbignVxM2gyDrxNQE2Vz/SYlx0H0z17KA2SSDaet8URWesAJJnOnX5WU40ItmkFd1p+m/raMxT9/FmFpmtecXrta6PsEVogatoSS2Q5kU8Biz7WhYRM7tcbTMWdtEDHSLpKVY6KoxgJnmh+CsXcpmm8EL8SuXDq9ChTU+i97A9ZvnybN1Bp+gmHnBK4+2Ii+Fs9fFHq+BmWJYu4Y1en0Gx7umLpQwQ0u3sEiQi2SQVPDhxsPYMgow/Yj6uHeA==
Received: from AS8P192MB2176.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:639::5)
 by DU2PPF1BE901FFD.EURP192.PROD.OUTLOOK.COM (2603:10a6:18:3::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:40:53 +0000
Received: from AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
 ([fe80::f998:ee7f:add9:9782]) by AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
 ([fe80::f998:ee7f:add9:9782%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:40:53 +0000
From: Joel Bueno <joel.bueno@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>, Joel Bueno
 <joel.bueno@openchip.com>
Subject: [PATCH v2] tcg/riscv: raise VLEN limit to the specification's maximum
Thread-Topic: [PATCH v2] tcg/riscv: raise VLEN limit to the specification's
 maximum
Thread-Index: AQHdFdBbI/5EsFyGHUubwwFAkANbPA==
Date: Fri, 17 Jul 2026 09:40:53 +0000
Message-ID: <20260717094046.1600827-1-joel.bueno@openchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P192MB2176:EE_|DU2PPF1BE901FFD:EE_
x-ms-office365-filtering-correlation-id: 1294bdae-6bc1-4125-8c48-08dee3e77e6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|18002099003|6133799003|11063799006|56012099006|10067099003|3023799007;
x-microsoft-antispam-message-info: kjDzxz0oGNsDsTfujnOIhN6ctI7c+xmt8shsFLEuct6MA0MmDUEEWDwf//lG5eTl/JotlmT95v0zCm9q3UMzAAI10Enk5xPOl36/ME/dYZ9jNuMR0be57v10k1hkwDKRFGwYEYHmOYgU9oVqA6Otol71/NVnmyysojDvVfKzJpnVJwW84BZnTYdfuwz7Z5K/SXAg0DNU6Xc/2zx+lrisZqCAoznCfd6QZu2RsXEmWF5NrY93WeCZShSk9R+BRu8LN3YAuFMyEtYcTbT6uPigOzpXIKQbpuI8P94wbdAIitqYaLHWEE3dMYsKFQpDG/uSF41gCQlKSG4GYT7c4UrgM8P8liaVfSkp1/HV6P6Oin657ILP7yoqIb1rcHgaDqt2vTvt8F7qGK5ISQCZGTtVGg3nlaSVv44J7qkQQaRxF2+6sCUn37IJtdTi0nCe/TdAf1RB4MCe2hFRSHhLhIJJArOn++RojknCf3I9VmK1HzRRDh/n0YlWgIkuSI3d0Ts8EZkiCL9jmmkIoHMczuAHQOT8PNFnnuLBpLbAySOt8P2eQnzO+sO0tLo3JHjozmlmP6E6xrY7UfwjXdAe3jhxSm0l4C56WMvHUeG2IAdL+9DN27sWork7YLqq+ae12J4NLcC8nvNbxuS2rDp0hAaAkXLI58RtjWgGuOHOnwknVtUl7HWO0bGq7uo8OoCS/knxfQbkj+sFXy6UjkHjQBpduH2FT37LhQe5ubylc5xJIzA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8P192MB2176.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Lnq9WLkOqAUU0p8f9FsQPLxB4IZbZWRgKWaaCd6Z5zIm5QzK/O/6QKAelF?=
 =?iso-8859-1?Q?RstoPYltzYDpRhj1+4Sc01Hz/BinTn4MJ6OShQQk9S9v8hInw68FEEyjGg?=
 =?iso-8859-1?Q?bCYM+Vtm/YuL0ZWxZyK1LHk9RYkNgMUBrlJn3k1VN+wdcKWec6rWeGVzsx?=
 =?iso-8859-1?Q?1fQGnk3Isd0BmBnCrYQl/HLJ0gYMjU0dWRAcFCKF/ndqsZZgH4jqlz+5+Z?=
 =?iso-8859-1?Q?4kTSZw2nV0YtgCnpbw1wySL8GdBRURYFxaQ3qi+/1kfw9V0CgG6UCt5d0A?=
 =?iso-8859-1?Q?rqibxrSt/mGOZdWNCIq1PBNBS4AX5y9Vjifpimmp1RkNn0KlyeltcnEqLR?=
 =?iso-8859-1?Q?3omPAWc8ooM7KOSveTm48CozS7X7OiPCRKB0/GR5l4XB8DHJ5lGl0lEtvD?=
 =?iso-8859-1?Q?DvT/y2Aa63aBscMo1An1Rc///BN6VRAww/ZjWiaoLWbXzWNBurUoGKS7tg?=
 =?iso-8859-1?Q?ZEVts3RvWLzA0pvy4x71jbE1EorlCYyQVOuiQV+3MI+RUpNIyaPM5OizEe?=
 =?iso-8859-1?Q?0k9KP0R5Nqr23M7fVMQpO6D5/+ViAw/jOnVwuMWmuiS7ROUDitL3I/boot?=
 =?iso-8859-1?Q?u5eH2J02gTJ4owops+oy8WU3uKD5woLMVyzdlW36786XYCq+xr2CjbBQuI?=
 =?iso-8859-1?Q?DWa6CEt5K0czsj+Wj1efyNWHkZ3AuB1nP1d9QwNkWPprOMLEwrWJejJRwZ?=
 =?iso-8859-1?Q?rAj1NxKcD1LZBQltbPO9yaBob9DMIART8vXkyblzJX+AxD51hG5SwLk9QB?=
 =?iso-8859-1?Q?nXP5Ki0FTVwltPFlei+/uMTfPI5GXjBvX0CTwjImT8ILBaHclHMAN2kfg/?=
 =?iso-8859-1?Q?WwEZEKUxNJAlCvhIJiB79D3SrTlU+MaqICXOd8QrJNYqzykkwdeYKkaYUD?=
 =?iso-8859-1?Q?3+T7sTOBq+6C+gVaBTd7LpRWwrHjvqZvf6q2mNxeKkyfqiUa/9MXGOzgZj?=
 =?iso-8859-1?Q?ddAMomH5Um2WvCNWj/c5cu85p06nw8qAcZYKM7bFHnN6dIdKI3feTOdKrr?=
 =?iso-8859-1?Q?4POl1R0Sn3xZp4nGKQgzb75Vbx7SbDwXzCgmmouRC2tU0w/WsR/EPSUAMO?=
 =?iso-8859-1?Q?c+8++OW8Dp1Vxnan+wMMgxKJcfAAD5kvMYKcCWUmr4xT2KOuxq675mska7?=
 =?iso-8859-1?Q?h88eGMIjSd9l3Fbg7MMHibmbZYHyvFNpmTNlhWzrYcCi0uQCRHTpg4qSzi?=
 =?iso-8859-1?Q?wMNw/MG4oMLSd0zRvGHW58WwTQ5lF/D0r517zLdMLP+Ey/qVJdzvyNk4jC?=
 =?iso-8859-1?Q?+6J4JZUbahZ9wSIazFLaSrWsbsKVxop3rCpDI1NEJxHtLlLQUbVDgI1qpO?=
 =?iso-8859-1?Q?GhMWivESbBo5nPK6fE1XmtqIEAwlOsm6VXWP57UAczpIRib1o9e+SXNXGO?=
 =?iso-8859-1?Q?iEyi4BKJbo/iBt9uAMcAsk3yXAf2BxSJW4a1bWFB6scZC4APlC17BnB7fh?=
 =?iso-8859-1?Q?mEwLkmVoS57a+EafEi2PmTnYMGRoqgezkvzRytEUCgKTLAp0QwUGe1Okpc?=
 =?iso-8859-1?Q?jZdUvRIC9MDjaPirsQRGAqXv7k22OVxn+iWq6j1gJ5Qai/BvFsJIuWJaCP?=
 =?iso-8859-1?Q?nobkR/Klo4LDWb6Rg1momQCjntvP+6+i1wbSZ68JOKr3D0xZqG1rsY3WEL?=
 =?iso-8859-1?Q?j6/hiKVJLhN3oWPFXxiwsWD4M6KPMIsg7paoGAoQt65HYI7NDvQ2izfgmS?=
 =?iso-8859-1?Q?qoNLbR2ieoUdk1VqYJqmcrzjaQG8C+3ySDjU2Ow6wTidsHvzWnQUZGlL0I?=
 =?iso-8859-1?Q?6zJGMIes/GGcI363mRWtJ4cyIr/8zRmjaLWDJIDxSYE5vXp+iwuNG/fJWv?=
 =?iso-8859-1?Q?FgGYOXZeFA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1294bdae-6bc1-4125-8c48-08dee3e77e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 09:40:53.0954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THHFc+DJ9s0kZfqV/83TsOyNXbOo78s9Y9ueh+im/e16on9wTPp6jcwws24kOz80WU+eBN25hnBPA8ebd7cL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPF1BE901FFD
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=joel.bueno@openchip.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

The RISC-V V(ector) extension specification allows VLEN up to 65536 bits=0A=
(vlenb =3D 8192 bytes).=0A=
=0A=
3 changes are needed to support this:=0A=
=0A=
1. Widen simd_desc SIMD_MAXSZ_BITS from 8 to 10, raising the maxsz=0A=
   encoding limit from 2048 to 8200 bytes. This costs 2 data bits=0A=
   (22 to 20).=0A=
=0A=
2. Raise RV_VLEN_MAX from 1024 to 65536. This increases the static=0A=
   per-CPU vector register file from 4 KB to 256 KB.=0A=
=0A=
3. Widen the vlen CPU property from uint16 to uint32 so that=0A=
   vlen=3D65536 can be specified on the command line.=0A=
=0A=
To ensure TCG emits instructions correctly, we, clamp the vl_eq_vlmax TB fl=
ag=0A=
so it is never set when the total register group size (vlmax << vsew)=0A=
exceeds the simd_desc maxsz limit. This forces the helper-based path for=0A=
very large register groups (e.g., VLEN=3D32768 with LMUL=3D4), preventing t=
he=0A=
GVEC fast path from silently truncating the operation and zeroing tail=0A=
registers.=0A=
=0A=
We also need to fix probe_pages() so that vector ld/st works due to larger=
=0A=
vector register sizes in regards of how many memory pages they span. This=
=0A=
enables larger memory operations to succeed since address calculations can=
=0A=
now properly span more than 2 pages.=0A=
=0A=
To finish off, we add an additional check on trans_rvv.c.inc to properly=0A=
decide when to use the helper function or not; this ensures that we never=
=0A=
hit:=0A=
=0A=
./build/qemu-riscv64: ../accel/tcg/translate-all.c:356: tb_gen_code: Assert=
ion `max_insns > 1' failed;=0A=
=0A=
On high VLEN configurations due to the amount of ld/st it generates (Where =
TCG=0A=
tries to halve the amount of emitted instructions so the generated machine =
code=0A=
fits on the buffer but fails to do so when a single vector load/store opcod=
e fills=0A=
the entire buffer (Or overruns it...!).=0A=
=0A=
Signed-off-by: joel.bueno <joel.bueno@openchip.com>=0A=
---=0A=
* Fix vext_ldst_us emitter. Wasn't able to trigger the wrong functionality =
from=0A=
within qemu-user but qemu-system with 16k VLEN crashed when context switchi=
ng.=0A=
=0A=
 include/tcg/tcg-gvec-desc.h             |  7 ++++--=0A=
 target/riscv/cpu.c                      | 12 +++++-----=0A=
 target/riscv/cpu.h                      |  2 +-=0A=
 target/riscv/insn_trans/trans_rvv.c.inc |  3 ++-=0A=
 target/riscv/tcg/tcg-cpu.c              |  4 +++-=0A=
 target/riscv/vector_helper.c            | 30 ++++++++++++++++---------=0A=
 6 files changed, 36 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h=0A=
index 704bd86454..6c277fedad 100644=0A=
--- a/include/tcg/tcg-gvec-desc.h=0A=
+++ b/include/tcg/tcg-gvec-desc.h=0A=
@@ -21,7 +21,7 @@=0A=
 #define TCG_TCG_GVEC_DESC_H=0A=
 =0A=
 /*=0A=
- * This configuration allows MAXSZ to represent 2048 bytes, and=0A=
+ * This configuration allows MAXSZ to represent up to 8200 bytes, and=0A=
  * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.=0A=
  *=0A=
  * Encode this with:=0A=
@@ -29,9 +29,12 @@=0A=
  *   2       -> maxsz=0A=
  *=0A=
  * This steals the input that would otherwise map to 24 to match maxsz.=0A=
+ *=0A=
+ * MAXSZ uses 10 bits to support RISC-V VLEN up to 65536 bits=0A=
+ * (vlenb =3D 8192 bytes).  This leaves 20 DATA bits (was 22).=0A=
  */=0A=
 #define SIMD_MAXSZ_SHIFT   0=0A=
-#define SIMD_MAXSZ_BITS    8=0A=
+#define SIMD_MAXSZ_BITS    10=0A=
 =0A=
 #define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)=0A=
 #define SIMD_OPRSZ_BITS    2=0A=
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c=0A=
index fa497e5e8a..b5c2139810 100644=0A=
--- a/target/riscv/cpu.c=0A=
+++ b/target/riscv/cpu.c=0A=
@@ -1637,10 +1637,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,=0A=
                          void *opaque, Error **errp)=0A=
 {=0A=
     RISCVCPU *cpu =3D RISCV_CPU(obj);=0A=
-    uint16_t cpu_vlen =3D cpu->cfg.vlenb << 3;=0A=
-    uint16_t value;=0A=
+    uint32_t cpu_vlen =3D cpu->cfg.vlenb << 3;=0A=
+    uint32_t value;=0A=
 =0A=
-    if (!visit_type_uint16(v, name, &value, errp)) {=0A=
+    if (!visit_type_uint32(v, name, &value, errp)) {=0A=
         return;=0A=
     }=0A=
 =0A=
@@ -1663,13 +1663,13 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,=0A=
 static void prop_vlen_get(Object *obj, Visitor *v, const char *name,=0A=
                          void *opaque, Error **errp)=0A=
 {=0A=
-    uint16_t value =3D RISCV_CPU(obj)->cfg.vlenb << 3;=0A=
+    uint32_t value =3D RISCV_CPU(obj)->cfg.vlenb << 3;=0A=
 =0A=
-    visit_type_uint16(v, name, &value, errp);=0A=
+    visit_type_uint32(v, name, &value, errp);=0A=
 }=0A=
 =0A=
 static const PropertyInfo prop_vlen =3D {=0A=
-    .type =3D "uint16",=0A=
+    .type =3D "uint32",=0A=
     .description =3D "vlen",=0A=
     .get =3D prop_vlen_get,=0A=
     .set =3D prop_vlen_set,=0A=
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h=0A=
index 7582874c35..5796aaf04b 100644=0A=
--- a/target/riscv/cpu.h=0A=
+++ b/target/riscv/cpu.h=0A=
@@ -186,7 +186,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied=
_rules[];=0A=
 #include "pmp.h"=0A=
 #endif=0A=
 =0A=
-#define RV_VLEN_MAX 1024=0A=
+#define RV_VLEN_MAX 65536=0A=
 #define RV_MAX_MHPMEVENTS 32=0A=
 #define RV_MAX_MHPMCOUNTERS 32=0A=
 #define RV_MAX_TRIGGERS 2=0A=
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_tr=
ans/trans_rvv.c.inc=0A=
index 23262b1d03..f34fea3407 100644=0A=
--- a/target/riscv/insn_trans/trans_rvv.c.inc=0A=
+++ b/target/riscv/insn_trans/trans_rvv.c.inc=0A=
@@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t r=
s1, uint32_t nf,=0A=
      * Update vstart with the number of processed elements.=0A=
      * Use the helper function if either:=0A=
      * - vstart is not 0.=0A=
+     * - total transfer size potentially exceeding emittable buffer length=
.=0A=
      */=0A=
 =0A=
-    bool use_helper_fn =3D !s->vstart_eq_zero;=0A=
+    bool use_helper_fn =3D !s->vstart_eq_zero || ((s->cfg_ptr->vlenb * nf)=
 > 512);=0A=
 =0A=
     if (!use_helper_fn) {=0A=
         uint32_t size =3D s->cfg_ptr->vlenb * nf;=0A=
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c=0A=
index b73e3e9dd4..021f9c60bd 100644=0A=
--- a/target/riscv/tcg/tcg-cpu.c=0A=
+++ b/target/riscv/tcg/tcg-cpu.c=0A=
@@ -33,6 +33,7 @@=0A=
 #include "accel/accel-cpu-target.h"=0A=
 #include "accel/tcg/cpu-ops.h"=0A=
 #include "tcg/tcg.h"=0A=
+#include "tcg/tcg-gvec-desc.h"=0A=
 #ifndef CONFIG_USER_ONLY=0A=
 #include "hw/core/boards.h"=0A=
 #include "system/tcg.h"=0A=
@@ -125,7 +126,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)=0A=
         uint32_t vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);=0A=
         uint32_t maxsz =3D vlmax << vsew;=0A=
         bool vl_eq_vlmax =3D (env->vstart =3D=3D 0) && (vlmax =3D=3D env->=
vl) &&=0A=
-                           (maxsz >=3D 8);=0A=
+                           (maxsz >=3D 8) &&=0A=
+                           (maxsz <=3D (8 << SIMD_MAXSZ_BITS));=0A=
         flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);=0A=
         flags =3D FIELD_DP32(flags, TB_FLAGS, SEW, vsew);=0A=
         flags =3D FIELD_DP32(flags, TB_FLAGS, LMUL,=0A=
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c=0A=
index e321ca2616..1254a7b9c4 100644=0A=
--- a/target/riscv/vector_helper.c=0A=
+++ b/target/riscv/vector_helper.c=0A=
@@ -176,13 +176,15 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,=0A=
                      mmu_index, ra);=0A=
     }=0A=
 =0A=
-    if (len > curlen) {=0A=
+    while (len > curlen) {=0A=
         addr +=3D curlen;=0A=
-        curlen =3D len - curlen;=0A=
+        len -=3D curlen;=0A=
+        curlen =3D MIN(-(addr | TARGET_PAGE_MASK), len);=0A=
         if (flags !=3D NULL) {=0A=
+            void *page_host;=0A=
             *flags |=3D probe_access_flags(env, adjust_addr(env, addr), cu=
rlen,=0A=
                                          access_type, mmu_index, nonfault,=
=0A=
-                                         host, ra);=0A=
+                                         &page_host, ra);=0A=
         } else {=0A=
             probe_access(env, adjust_addr(env, addr), curlen, access_type,=
=0A=
                          mmu_index, ra);=0A=
@@ -480,8 +482,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState=
 *env, uint32_t desc,=0A=
     }=0A=
 =0A=
     /* Load/store elements in the second page */=0A=
-    if (unlikely(env->vstart < evl)) {=0A=
-        /* Cross page element */=0A=
+    while (unlikely(env->vstart < evl)) {=0A=
+        /* Element crossing the page boundary */=0A=
         if (unlikely(page_split % msize)) {=0A=
             for (k =3D 0; k < nf; k++) {=0A=
                 addr =3D base + ((env->vstart * nf + k) << log2_esz);=0A=
@@ -489,15 +491,21 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVSta=
te *env, uint32_t desc,=0A=
                         env->vstart + k * max_elems, vd, ra);=0A=
             }=0A=
             env->vstart++;=0A=
+            if (env->vstart >=3D evl) {=0A=
+                break;=0A=
+            }=0A=
         }=0A=
 =0A=
         addr =3D base + ((env->vstart * nf) << log2_esz);=0A=
-        /* Get number of elements of second page */=0A=
-        elems =3D evl - env->vstart;=0A=
-=0A=
-        /* Load/store elements in the second page */=0A=
-        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,=
=0A=
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);=0A=
+        page_split =3D -(addr | TARGET_PAGE_MASK);=0A=
+        elems =3D page_split / msize;=0A=
+        if (env->vstart + elems >=3D evl) {=0A=
+            elems =3D evl - env->vstart;=0A=
+        }=0A=
+        if (likely(elems)) {=0A=
+            vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_es=
z,=0A=
+                              is_load, mmu_index, ldst_tlb, ldst_host, ra)=
;=0A=
+        }=0A=
     }=0A=
 =0A=
     env->vstart =3D 0;=0A=
-- =0A=
2.43.0=0A=
=0A=

