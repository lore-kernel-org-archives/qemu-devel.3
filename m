Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D27EF4BB72
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0n-00046U-5f; Wed, 25 Feb 2026 05:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0h-00043l-MD; Wed, 25 Feb 2026 05:20:51 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0f-0002vD-2R; Wed, 25 Feb 2026 05:20:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wimn0oWbQOikl6D/jUVmhEUqdnptfITm04gV35LGr6bKw+gmA0vscaOWaSo+Cd9uebjTKCRK8pr+SsIBzfJc9WsZ7WO0G7r7zWflP9B0Gy5o+b2poT4w4fQa3+yb+AJpCiLwOnBEtgP04pynM6eTF9BLXt8UOAUIFl98kFIMPRGPGyI2QrDKyH6kiqu1NaWJYgd1scwr7iS2n69+W/RZMPwi/VLj3FvxrVoZNJ/dkX3M9Ew61AOrGYrEzMnxySQ8+/CPZJKrwZnD5eOulxoMfatlh7oMrukT605ugZ3EGF2b9v+dUwG/NiPTAd9XZbi5YbJDptYCsUyPpt+koyeWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hgUWF6kA9fcsxJjJgintRsyzZaAmz1mzT9r6hlXjJs=;
 b=uAs2E5ksDIm+MWD8aT/XfPk+5Kx2vJ1k1HEohrIt0uk5BKiG4BfuAsDFOaIuL162FaG3FIF0JtiZNF/wypb8rAD8NPRxkrfkK+4YGTgOeB8TP656vRx+LoLgrX7wret3NemRMXQl2XqoUBSZIwO7iRx0aSvfb3bo7xvRFpZNRQUkIgExObQDd1+H9BPzbcdHPHxKU8P5smqIDDExdBCSF95WQoKQMGGCdA0P3wUYxrBeIfa+64NeYRKUEPT9yYCrxW15D+dIqPoAolB2GkxAriPt5xJPdW9t8agQyY6tWU+cB+vrqrc9msfLdcd0GwBXlQeWfKrRNcrn0W7MxCSkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hgUWF6kA9fcsxJjJgintRsyzZaAmz1mzT9r6hlXjJs=;
 b=pJy0gzBpzEzEiRTVe0m4hb0g1qCI2HXnxZSF9zEYJpVe8kDzwhDxZpXQ2AQy5YGdEE/iD87DHdpKKMHG391gfDcC7SHb+EYaPhaeCU2JaptPd/Fi1M0j3tExO45Q7+EAIW4s7Q4x3oVqpBwWHbZi5Cf04ONGMxalzJZXvlZK+5p6VHJLZ+W6nBxZewgFnU315hd7g99hIby35M+RTizdcXGPBONbQ0JU6z1o3lKUruDXV8XMnZyC8uFquNM1LJmMtzd4SiQf2Mzkv84FZEkE99PbtDvze5S0JebNDzppAEsF6NMbSHNz/l9yWSmsU67eJcGwJkHhJ5z54GIc7z09/w==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:30 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 09/16] arch/riscv: Set UBE bit on BE target
Thread-Topic: [PATCH v2 09/16] arch/riscv: Set UBE bit on BE target
Thread-Index: AQHcpkBcw+n8KkE3O0CHWi86CGifKQ==
Date: Wed, 25 Feb 2026 10:20:27 +0000
Message-ID: <20260225102016.200654-10-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB6845:EE_
x-ms-office365-filtering-correlation-id: 1dd76ec7-a901-4d18-68de-08de745780bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: TaFipl+jPJT09lmRs9V6tWAPaU9Y5Qp95G5uN3SrqeE1iY+CFKQooTvmRzKg7fYNrdeXzo8AYGNzkdCBk0sf96I59bfX3yJou6eZHrUx/u8VwW0IKe8ID+mM/9OLA4I+HURmkEPUwZgRd8FVMd2aI+L+8jPzyhui2wUwYRlo7WTJeHQQE9JUeparwlh0sL5OmvSb4ko6iKIGZh78T6G9BFBMrowql8MnY/5IsFoO1n4kwpctrX5wzR9NkZ15kpuPpxPRUSiyPPlNjy8550tf1N1bQZHNiAoNMKkGE1UTdfTCzpgEPaGNYNBgwrK6S+d8SSy+XN3tWlpkuIcAKZK+gXuPb+7hEg0q5XSiiJbRtp054zsWO3OJegDFaWfvffuoaAlYed1BQWG6ofqHFZRQwAbjU7qCkVb+xX3fP0IP133aNXlWr9UD55fe5EMnCojLJXLzNykQydgw13sUP65a+sZoInpbOaBx2ShnuV/CBX5hSjDa7kdbnKbEmI0xaDJyUv+C9mufxFeuyWRXYnsOw+LUsFYjAWEDSG7Y/I9TofhzBQwhPbhLveAXFsQWW4a0V6v9MuS/UlMNpdY2sIK2nnus40zL5pxUiAvAOklFPxwm9Q/dGA1xpnZr7mdtBOoU2ADX8IY+sGW/G1/hvGRPYAL9JUmDkfSTzrf7AQduX73eIJRsjtkyKCdE0d8JidpbuVz9NX8JbbH6ZpTD2xT65W1TLT9U4Qe20iwaSKS5xjVMHBzBOXZgR3pk5MrArEVJm0uebBBKv/nkMCKxlY0VLOUlunsoZv5wQXEkOIBgMgM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2dJcOF5998yqgMiv1vr4LdiDIJywbNdWT6w/xApXYc2VneK43Hp8XNs5X+?=
 =?iso-8859-1?Q?AqNKHCmq8RrhB4bwdQJEGqdFEXXVvbYdm8ReliDALH1YBEm8qBaLn2/7cW?=
 =?iso-8859-1?Q?KfiDCkmxlal5guD25U9K6Ro474pDoxLOAnO5ZfoPh7VtdI4GX14VdBfz8p?=
 =?iso-8859-1?Q?TcKcPAv1Kp8nyjmsG2WDzMfl1j2hU64jb5+c8ZtqWoLWmlPjBhk74wMLuq?=
 =?iso-8859-1?Q?Oxl974un85LGq+jnRrL0OK2tYNgNtrW8t1huTdL6a9y+ABk//Igj/kTZ8i?=
 =?iso-8859-1?Q?zVLnuePGHIDyQUwiHM/KiHECeYYSp/kZNHomm5BgJrgnAmdqiimNzGTYAG?=
 =?iso-8859-1?Q?ahQ9+ZNO31eCsVszsJ3TNQ5bTYFCp/Jn+u5PgoOKa9ZL7FRceeHQWCMrqc?=
 =?iso-8859-1?Q?IhXd3YpzpPD55wrp25ODKcwIV4HtjbozDGd6tb5q++r4qPPnyd/JS1Fy4a?=
 =?iso-8859-1?Q?GGXZ1MD4Oj0kSAnv7X+N6JOmQGuqx6nAiBvOKXpUQLPxVPUwvMSuweAzsm?=
 =?iso-8859-1?Q?UX9eRpmgLgVBTFZHaoFSTytZAqmJ0Ni9PTeELDcV+C3zxtLoZzHoc68mSD?=
 =?iso-8859-1?Q?+JnlyaPdAP+9YVvMp4DP5eJMqQM4ETs0VDfDiXI1qf/8GcUSYuiN9Z7JDq?=
 =?iso-8859-1?Q?punf61L6lD+R6+vx9vcqwesSqoNDNBw/HkVLdPgH3Xqj/LPErbsWjQ9jT0?=
 =?iso-8859-1?Q?Itw1zuiEmXz0ANtg2/hxfwNUVSP5La21N9naQISJ1j/u/CA1+8KitZEJbs?=
 =?iso-8859-1?Q?Yq9wW+Uq3J7X5nhWbB26jq+r/eh08SzlhAe/mwa04OTD56P2P+b+tqxsUT?=
 =?iso-8859-1?Q?2OB5eW51bdmRIz7HFN+riYLBD3bvk0kiM28ES/zvBP5mG31CzdNcA3iGTg?=
 =?iso-8859-1?Q?6zgwOdtCtYHv9IPK82i1h1xfKtoq9TmHIpPp5O3sxQE0vDkcUjGjEoI+tE?=
 =?iso-8859-1?Q?ajOZNqAwaVF4CGkqR2Jk6106BpyY8m4J1t5qTir64pnbiUym4JlcaOUf90?=
 =?iso-8859-1?Q?wq/uUfoPE4CQxxJkjQWOjpt/NziuPBu3q+4C9OdOsr3b6Lc8YXs8eSnXsl?=
 =?iso-8859-1?Q?QRy5GvVJe644vPyOtrDj0zjt5DitQOEWLaWd/A6Esasi5FetqKGojL2jus?=
 =?iso-8859-1?Q?EJ5G0tiByvnuTcNFSFblKXME5sdmglPJ/XuNC3s16uqKVB+DkRhOyOVD4O?=
 =?iso-8859-1?Q?GCIOPU5WJBuZsO1/OnCNOgY+kkZhkCaZRZDodUfBLp+HXHrV6R4ouszEZn?=
 =?iso-8859-1?Q?cTYaElY4zvyZ/xutxtQeuJfjJhuHa7a5DyNFDNq1wweMZgRORErFgvWisZ?=
 =?iso-8859-1?Q?cA4Ruy3wz8s9voH/B96gonCKRp2V17/HUYmwEvqwaDij/UnMK8mok68L7J?=
 =?iso-8859-1?Q?CdZEBVLXEZcB5k5q8iAQryTD0T6yjHS7bOJRWRowW/mU8yXk+ejy9B0xnN?=
 =?iso-8859-1?Q?gUjh7bMETZqNk4T7PD2ZkzqFNjohFyLrufwP4t14Spxoa4JZ9U5xPQplv7?=
 =?iso-8859-1?Q?nU9iS+rwpJPhSRlmm00JuoDachdGWDcDu52DOK1EQsnIPkF9Ar/HOflhia?=
 =?iso-8859-1?Q?XDuGbkuaONkaM3jkWpL+Y5dlKQM7Ze9IpcRRFHDnd9dSts0cFkCgY0D/B9?=
 =?iso-8859-1?Q?MtKc1xx0fOKTHdpJssZC4lr47xBZa0sO7pKkDkI8dyxIUUHyWTBZXy/sU0?=
 =?iso-8859-1?Q?OPcYiV0Jdv+E9FQkz+vx24lCGy3L2vBA6Sb/KP6u+3ZEADQmimdemysUp6?=
 =?iso-8859-1?Q?Ji40LzZ9Obl70xCmMAhOPw/ziwQOD+d8nnz8lHipPsO175AZ8zlS1Ot5b6?=
 =?iso-8859-1?Q?3I83zM9hD+QXkdtOk7uNpEFnUt5HUFwxPSsXBIhiMcwpL9qa71Ux?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd76ec7-a901-4d18-68de-08de745780bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:27.7792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/s5ChiMTh/fMsHopHhZb4oYuFT+cw9PKbeLTb245tb/+CYOeUwakMly4ZuhGj8bH7AfLzsXwTFcPL6xVh3oJY4KOqArTMpSjuWyeF5jhAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
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

When the RISC-V target is built as big-endian, ensure that is signaled
in mstatus via UBE bit.
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e95eea0249..0e24f2cbcd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+#if defined(TARGET_BIG_ENDIAN)
+    env->mstatus |=3D MSTATUS_UBE;
+#endif
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
--=20
2.34.1

