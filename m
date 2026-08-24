Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AF1C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQSX-0007gs-TM; Mon, 24 Aug 2026 04:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.bueno@openchip.com>)
 id 1wyQSV-0007eP-2a; Mon, 24 Aug 2026 04:55:12 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.bueno@openchip.com>)
 id 1wyQSR-00014J-Uf; Mon, 24 Aug 2026 04:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3MO2maTX9clz+nrP1nz2PCbcHX+njj5vprp2/ozNPBhTL9cKJBAR/AeB6V5y4xlIb84iuUqsPVTHE75bUBEWqQDPC1Z4B80dyR+k9M/EqS/nFJrZQuBfV3n963PjevgcqMj7p/oasZbxEVXmyz98StqfyFHBv194DfAAdOAJqItfhpgWCALxCmEzyj66PtMTNKm+Zz3FnG7jy1sh1VhXbfFTHAgSxZ7GqgnyNBpsh0tREEn7rVZCJ7IKejTAyoHUP9vAYav9oLkPDTjyppIRiHweNSv5KvamylszHs2fZYtk3z9qVSY6QSvt1XR0/wwSYKJlc8XqeYWHB15r9lnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3+KbcH+1GE51/tVZ1B0rS6DO9/RB/CP/W6LkJbCjVU=;
 b=d8r0R/D2XmVi5D5eIJGTFysa0QnJvf3zl8ZS69f/0i0eCG3a0QKxraqVqZPvIqhTtv4Yuqq6wNDCVgw8/m9+ss332m0CADo+HtvCRuHJKGSrEv70OSBruVEaQKVs57LURaDOkJTnk0FmlFmPRpClNK4jLxauxs2rNMhv0jk2I1Dy74T0uEmD8cZ+QEWKw/i+nW88AxkRbvg58baroEJscXeEVs0ioDq8enQjnqEh/k9xTmbYVQ9JooLNL0aW+MZwAVseUAQq9mb3miUHFoiv3kEaQ11imsjnMSUfzkHP/6/Up0SzcUZEoVMdCLL6mDIWgSTcuH8HyJhDGG/BUFH2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3+KbcH+1GE51/tVZ1B0rS6DO9/RB/CP/W6LkJbCjVU=;
 b=FHNq8tf/OsaFtFNHw5een7EPdp72Sm/OzUF4MX27ioRWZqeWR9mQdxzCh3mz12mDp06ZqmyjTo5iiAyeHsaVAWi7HcHzKdm5XLFFBEiT/y5etznQHvP+Prpz3H+wFYGu4xUdUXdMiStMD8s4W6r3MXpMUGIZeypu6tWd0Z6PG9r8H6PizfB4KaaBpJXF64BP/EANzOREZ3sQ6nWflzMSL2W+HN6LQynnA/8//+5EKBIpb5zkT5U0W7NHhWFHbfliYl0DS6UzgHmwuONFa+Hb/64h50aHLWzFsS1EnIJhjOglV0VZ5cJySnd1Z5cNzD5pNzCjYo6Vo+o2iRVDRssT6A==
Received: from AS8P192MB2176.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:639::5)
 by GV2P192MB1989.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:54:57 +0000
Received: from AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
 ([fe80::f998:ee7f:add9:9782]) by AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
 ([fe80::f998:ee7f:add9:9782%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:54:57 +0000
From: Joel Bueno <joel.bueno@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v2] tcg/riscv: raise VLEN limit to the specification's
 maximum
Thread-Topic: [PATCH v2] tcg/riscv: raise VLEN limit to the specification's
 maximum
Thread-Index: AQHdFdBbI/5EsFyGHUubwwFAkANbPLatH+gF
Date: Mon, 24 Aug 2026 08:54:56 +0000
Message-ID: <AS8P192MB2176436BE42E70C1AF1D09A2E2A02@AS8P192MB2176.EURP192.PROD.OUTLOOK.COM>
References: <20260717094046.1600827-1-joel.bueno@openchip.com>
In-Reply-To: <20260717094046.1600827-1-joel.bueno@openchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P192MB2176:EE_|GV2P192MB1989:EE_
x-ms-office365-filtering-correlation-id: 04bdbb96-f75a-4459-d34d-08df01bd5f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|7416014|376014|38070700021|6133799003|10067099003|56012099006|11063799006|8096899003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: nBoHRXoVWZro5pYiFzvD3H+Lprjw3yiSO7AxZ5p7kfC+9oaLmDrUv6QasVDrhnfd8j10Xc1zy1mh92RXEcHETsCNiTXy4wypkJVBvZs5Ew7W3j+WEjjWtCax8aysuIktG95kQkP32hc1SiRnTXnBexoPO8lG7jjm3+LrCMDMRhiyuoUJP7VXGdiQdaSQrn4vKaNhoo9e8W9tRKtZjT43q2TiFPFkoTovFhXdDZUzgpkcTkRSP+PGV3HbyoVL6Wt1VOyJIbxSeOys0csvZTtjTnBBM1HmRXf5J69CAvclKA86zlVbclA4fuFkMktHVDPWWCLzVDZapUADzoOSdaLsznZ8VSrzl1xYK05H5QyEzh38xRAyb+6DHSv7SiDcWKhrHoFPjBDo5Bw/THROM3UlCBjcgoXa/2UoYLoobLzJE9mLZIVx9s7qSEwf3XvZ9//QUUqRS3yPQzEmJftrH9pgMtwupuFOumM+4uIb9n4mGiQxEnTrDzklddtITYv4lkzQUx+qxlS7Xrih22TL1A6UEgWJ7CXJfUNQVUE7Yh2j+mgZooekcsM144jsjU+guQBoGceeBKT6P+qLxxGufM2eZ3fWmbMViFpzN2b1tbKxqa6QqeAKhhoeZqzF9lvfExPg9yilpqUgpRja0kTckgUj6L6MKEzjktae2K1QyJodNC1z4OOsXNSO2wzw/flhG0gTfwkfcyxMNtgJhNVHlY3mqRpQm0TUVzv3kjIt5BG5Wd0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8P192MB2176.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(7416014)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(8096899003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTWECUWc5RpNQBZCpBxeEEl0IwXiDvNY2VHVkmxyzl5w02CGFU7ArUpgaE34?=
 =?us-ascii?Q?Bk6E+jddC2mXuo55u+oCAsMZkD1ugylCH0/uxTOiRfqP48llSKp6OMW4SSj1?=
 =?us-ascii?Q?iifTTSrSJ84B6GHjZUK9nAPwptqBKo4qk4v2wUWZtsoIg9lUxcDawjpWMKh9?=
 =?us-ascii?Q?r3pVuqp1gqeb8+fBYPElzIlvJbtcGC42kU6NOfTCwWkVNgswIzuOPAFjZPEz?=
 =?us-ascii?Q?xLK83eTaO2zoAisA6Z5MvjRxxq8BF2suSzdCQfl3rOH5MWQQTywAH6MV2uPH?=
 =?us-ascii?Q?xVftk/u0YYk/qq9jTNdZYkqT6ceh3RBaX6WTMsergiOGes/ZGBJWEHlptTpi?=
 =?us-ascii?Q?xuW4v5yWnA1sfh1Q6EE6hSQijkSk/sQY7UXhlBoo/dh1SId1N6RDl7Qea86p?=
 =?us-ascii?Q?d7JEjYDB2jbUe3bdLqs829gA115o66up17vyM4jlpe+h1ZaaRGCrg0zHu+/d?=
 =?us-ascii?Q?k7RoNuKhzHfic7xFX9uM6UF+nLO4c5yPiyzTp9/n/Pho/tC1kSv55j/QOCz5?=
 =?us-ascii?Q?qqYVBQUqI+rKXHtgDSu3Z9DEy0mD4rw9iMjQ5oAbiCgu5XuRjlx0fJwgO7FT?=
 =?us-ascii?Q?matRWnq5Y+XyV3aYfF2FITP5E4Ju9GO8v3dZaWP/McBhWYrZIEOrxTn2ADYW?=
 =?us-ascii?Q?NW91xWRnZNOYX2tURYS0fu7imjCGvL9y+RIyZbWxPrmNCF4p2qacrSInjOA3?=
 =?us-ascii?Q?Dt8dQwqPeQyaL2KsU7Mastl9jQL2ihWDPowTtA2WTBYLLVsCFUiMMJeSottH?=
 =?us-ascii?Q?oRSVwZbOvAx6YLd1fpukKNs7bkcHdeLy6a5GM6xkoaG2OFU7xZxmokJIrHhs?=
 =?us-ascii?Q?u2fv42TPXeWVU0FeYvU8YhGkHkCOsmnlS6WdXHSKLFPz9sb3NC/+3rkB+kye?=
 =?us-ascii?Q?nnSwsXd3U+59T4LK4l2ww8ELE4ex3LEaIxWcAS78+aSwkwFXh3S5HWhKnPvq?=
 =?us-ascii?Q?wP+W6KNZYq5/bdK+Ij7A1eKgnC/y1KxNI9EvPuK2FUSvWJjAprxJpoa1On64?=
 =?us-ascii?Q?icC7PFONJz/hKmPi8YwqDreSbP6mbkHj3hP4COk/wFI9vjCzC9wFStNKu6vC?=
 =?us-ascii?Q?9o6XXiv01vJUek/+u7o+dwDzkdxl1LM9X6eWRqXoEDj0DajR/bnlFsoZYHx0?=
 =?us-ascii?Q?E2GbaxlLwu8+1GVJafNgG6Nnm31UUCItmA6GABO9iYbqPlI5Sy5Fky3jhWHx?=
 =?us-ascii?Q?BgucEYYsrHDfUNo5Xndj+1CIerJ2wIywvr2uLH9Swh7FcuTxciIubEvsrkm+?=
 =?us-ascii?Q?ur7B8/E2REfSuWFnrBWtlUQRz0Noa0vkWW+6i4TIDBY5LX/SV+4bp04a0C1i?=
 =?us-ascii?Q?v8vAcizInKSjln9jtq7sLBrnVWqhC/VXVNIOtuqVZ/8Ix4Dk6weykh66I/Jh?=
 =?us-ascii?Q?genhmRdDS5eSCihJeY+W6e5WnNrF1oeNHS/+hYxg087i0J24r8otVlgFqyjE?=
 =?us-ascii?Q?05rRNF3jPaENGZ8umVWNmKlKU5TfTmTHzQqNzv3PqEQ3zqAXcq2KLEZ/feBt?=
 =?us-ascii?Q?OmcBga0HAaLR0xh+H9lG9u5dEy69P3n4cS8bT11i6woqS7zZJ0t9lpZ+27Cq?=
 =?us-ascii?Q?BcVeWKRY3klOQOo4JH19JHnjCO+U57ue1fws18Ahvh+F+loG2QKcIgbfs1gX?=
 =?us-ascii?Q?OMwaR/LCXrExTu2fomUEO5otPJtoVcbNOzwKVnpbsALPVe/fBRpG707F1UwW?=
 =?us-ascii?Q?zy5v3mP7nSVsxNMoViFy6kCaFvItS5KfBOIojnVDeX/P83KvvZTQLkxH9pzL?=
 =?us-ascii?Q?jl1atySutsrRRb+4AvOTDwWvC9a8kdMEkakyb8phbPdpNsRUy2iEItgZM9+e?=
x-ms-exchange-antispam-messagedata-1: YeKi2BPe39QVbg==
Content-Type: multipart/alternative;
 boundary="_000_AS8P192MB2176436BE42E70C1AF1D09A2E2A02AS8P192MB2176EURP_"
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bdbb96-f75a-4459-d34d-08df01bd5f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 08:54:56.9312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIfYa9qKLr72VIC07BAJgJbte+NpAQB0CrJciApUNmx6Cq9O9WZR7ohmDgk+Yy+wG9xCpePCKHL4Ghr4RwjhBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1989
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=joel.bueno@openchip.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--_000_AS8P192MB2176436BE42E70C1AF1D09A2E2A02AS8P192MB2176EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello, sorry for bothering; is there anything I can improve on the patch? T=
hanks!
________________________________
From: Joel Bueno <joel.bueno@openchip.com>
Sent: Friday, July 17, 2026 11:40 AM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; qemu-riscv@nongnu.org <q=
emu-riscv@nongnu.org>
Cc: richard.henderson@linaro.org <richard.henderson@linaro.org>; pbonzini@r=
edhat.com <pbonzini@redhat.com>; palmer@dabbelt.com <palmer@dabbelt.com>; a=
listair.francis@wdc.com <alistair.francis@wdc.com>; liwei1518@gmail.com <li=
wei1518@gmail.com>; daniel.barboza@oss.qualcomm.com <daniel.barboza@oss.qua=
lcomm.com>; zhiwei_liu@linux.alibaba.com <zhiwei_liu@linux.alibaba.com>; ch=
ao.liu.zevorn@gmail.com <chao.liu.zevorn@gmail.com>; Joel Bueno <joel.bueno=
@openchip.com>
Subject: [PATCH v2] tcg/riscv: raise VLEN limit to the specification's maxi=
mum

The RISC-V V(ector) extension specification allows VLEN up to 65536 bits
(vlenb =3D 8192 bytes).

3 changes are needed to support this:

1. Widen simd_desc SIMD_MAXSZ_BITS from 8 to 10, raising the maxsz
   encoding limit from 2048 to 8200 bytes. This costs 2 data bits
   (22 to 20).

2. Raise RV_VLEN_MAX from 1024 to 65536. This increases the static
   per-CPU vector register file from 4 KB to 256 KB.

3. Widen the vlen CPU property from uint16 to uint32 so that
   vlen=3D65536 can be specified on the command line.

To ensure TCG emits instructions correctly, we, clamp the vl_eq_vlmax TB fl=
ag
so it is never set when the total register group size (vlmax << vsew)
exceeds the simd_desc maxsz limit. This forces the helper-based path for
very large register groups (e.g., VLEN=3D32768 with LMUL=3D4), preventing t=
he
GVEC fast path from silently truncating the operation and zeroing tail
registers.

We also need to fix probe_pages() so that vector ld/st works due to larger
vector register sizes in regards of how many memory pages they span. This
enables larger memory operations to succeed since address calculations can
now properly span more than 2 pages.

To finish off, we add an additional check on trans_rvv.c.inc to properly
decide when to use the helper function or not; this ensures that we never
hit:

./build/qemu-riscv64: ../accel/tcg/translate-all.c:356: tb_gen_code: Assert=
ion `max_insns > 1' failed;

On high VLEN configurations due to the amount of ld/st it generates (Where =
TCG
tries to halve the amount of emitted instructions so the generated machine =
code
fits on the buffer but fails to do so when a single vector load/store opcod=
e fills
the entire buffer (Or overruns it...!).

Signed-off-by: joel.bueno <joel.bueno@openchip.com>
---
* Fix vext_ldst_us emitter. Wasn't able to trigger the wrong functionality =
from
within qemu-user but qemu-system with 16k VLEN crashed when context switchi=
ng.

 include/tcg/tcg-gvec-desc.h             |  7 ++++--
 target/riscv/cpu.c                      | 12 +++++-----
 target/riscv/cpu.h                      |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  3 ++-
 target/riscv/tcg/tcg-cpu.c              |  4 +++-
 target/riscv/vector_helper.c            | 30 ++++++++++++++++---------
 6 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 704bd86454..6c277fedad 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -21,7 +21,7 @@
 #define TCG_TCG_GVEC_DESC_H

 /*
- * This configuration allows MAXSZ to represent 2048 bytes, and
+ * This configuration allows MAXSZ to represent up to 8200 bytes, and
  * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
  *
  * Encode this with:
@@ -29,9 +29,12 @@
  *   2       -> maxsz
  *
  * This steals the input that would otherwise map to 24 to match maxsz.
+ *
+ * MAXSZ uses 10 bits to support RISC-V VLEN up to 65536 bits
+ * (vlenb =3D 8192 bytes).  This leaves 20 DATA bits (was 22).
  */
 #define SIMD_MAXSZ_SHIFT   0
-#define SIMD_MAXSZ_BITS    8
+#define SIMD_MAXSZ_BITS    10

 #define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
 #define SIMD_OPRSZ_BITS    2
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa497e5e8a..b5c2139810 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1637,10 +1637,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
                          void *opaque, Error **errp)
 {
     RISCVCPU *cpu =3D RISCV_CPU(obj);
-    uint16_t cpu_vlen =3D cpu->cfg.vlenb << 3;
-    uint16_t value;
+    uint32_t cpu_vlen =3D cpu->cfg.vlenb << 3;
+    uint32_t value;

-    if (!visit_type_uint16(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }

@@ -1663,13 +1663,13 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
 static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    uint16_t value =3D RISCV_CPU(obj)->cfg.vlenb << 3;
+    uint32_t value =3D RISCV_CPU(obj)->cfg.vlenb << 3;

-    visit_type_uint16(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }

 static const PropertyInfo prop_vlen =3D {
-    .type =3D "uint16",
+    .type =3D "uint32",
     .description =3D "vlen",
     .get =3D prop_vlen_get,
     .set =3D prop_vlen_set,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7582874c35..5796aaf04b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -186,7 +186,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied=
_rules[];
 #include "pmp.h"
 #endif

-#define RV_VLEN_MAX 1024
+#define RV_VLEN_MAX 65536
 #define RV_MAX_MHPMEVENTS 32
 #define RV_MAX_MHPMCOUNTERS 32
 #define RV_MAX_TRIGGERS 2
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_tr=
ans/trans_rvv.c.inc
index 23262b1d03..f34fea3407 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t r=
s1, uint32_t nf,
      * Update vstart with the number of processed elements.
      * Use the helper function if either:
      * - vstart is not 0.
+     * - total transfer size potentially exceeding emittable buffer length=
.
      */

-    bool use_helper_fn =3D !s->vstart_eq_zero;
+    bool use_helper_fn =3D !s->vstart_eq_zero || ((s->cfg_ptr->vlenb * nf)=
 > 512);

     if (!use_helper_fn) {
         uint32_t size =3D s->cfg_ptr->vlenb * nf;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b73e3e9dd4..021f9c60bd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -33,6 +33,7 @@
 #include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
+#include "tcg/tcg-gvec-desc.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/boards.h"
 #include "system/tcg.h"
@@ -125,7 +126,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)
         uint32_t vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
         uint32_t maxsz =3D vlmax << vsew;
         bool vl_eq_vlmax =3D (env->vstart =3D=3D 0) && (vlmax =3D=3D env->=
vl) &&
-                           (maxsz >=3D 8);
+                           (maxsz >=3D 8) &&
+                           (maxsz <=3D (8 << SIMD_MAXSZ_BITS));
         flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
         flags =3D FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
         flags =3D FIELD_DP32(flags, TB_FLAGS, LMUL,
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e321ca2616..1254a7b9c4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -176,13 +176,15 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,
                      mmu_index, ra);
     }

-    if (len > curlen) {
+    while (len > curlen) {
         addr +=3D curlen;
-        curlen =3D len - curlen;
+        len -=3D curlen;
+        curlen =3D MIN(-(addr | TARGET_PAGE_MASK), len);
         if (flags !=3D NULL) {
+            void *page_host;
             *flags |=3D probe_access_flags(env, adjust_addr(env, addr), cu=
rlen,
                                          access_type, mmu_index, nonfault,
-                                         host, ra);
+                                         &page_host, ra);
         } else {
             probe_access(env, adjust_addr(env, addr), curlen, access_type,
                          mmu_index, ra);
@@ -480,8 +482,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState=
 *env, uint32_t desc,
     }

     /* Load/store elements in the second page */
-    if (unlikely(env->vstart < evl)) {
-        /* Cross page element */
+    while (unlikely(env->vstart < evl)) {
+        /* Element crossing the page boundary */
         if (unlikely(page_split % msize)) {
             for (k =3D 0; k < nf; k++) {
                 addr =3D base + ((env->vstart * nf + k) << log2_esz);
@@ -489,15 +491,21 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVSta=
te *env, uint32_t desc,
                         env->vstart + k * max_elems, vd, ra);
             }
             env->vstart++;
+            if (env->vstart >=3D evl) {
+                break;
+            }
         }

         addr =3D base + ((env->vstart * nf) << log2_esz);
-        /* Get number of elements of second page */
-        elems =3D evl - env->vstart;
-
-        /* Load/store elements in the second page */
-        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
+        page_split =3D -(addr | TARGET_PAGE_MASK);
+        elems =3D page_split / msize;
+        if (env->vstart + elems >=3D evl) {
+            elems =3D evl - env->vstart;
+        }
+        if (likely(elems)) {
+            vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_es=
z,
+                              is_load, mmu_index, ldst_tlb, ldst_host, ra)=
;
+        }
     }

     env->vstart =3D 0;
--
2.43.0


--_000_AS8P192MB2176436BE42E70C1AF1D09A2E2A02AS8P192MB2176EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof">Hello, sorry for bothering; is there anything=
 I can improve on the patch? Thanks!</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joel Bueno &lt;joel.b=
ueno@openchip.com&gt;<br>
<b>Sent:</b> Friday, July 17, 2026 11:40 AM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; qemu-riscv@=
nongnu.org &lt;qemu-riscv@nongnu.org&gt;<br>
<b>Cc:</b> richard.henderson@linaro.org &lt;richard.henderson@linaro.org&gt=
;; pbonzini@redhat.com &lt;pbonzini@redhat.com&gt;; palmer@dabbelt.com &lt;=
palmer@dabbelt.com&gt;; alistair.francis@wdc.com &lt;alistair.francis@wdc.c=
om&gt;; liwei1518@gmail.com &lt;liwei1518@gmail.com&gt;; daniel.barboza@oss=
.qualcomm.com
 &lt;daniel.barboza@oss.qualcomm.com&gt;; zhiwei_liu@linux.alibaba.com &lt;=
zhiwei_liu@linux.alibaba.com&gt;; chao.liu.zevorn@gmail.com &lt;chao.liu.ze=
vorn@gmail.com&gt;; Joel Bueno &lt;joel.bueno@openchip.com&gt;<br>
<b>Subject:</b> [PATCH v2] tcg/riscv: raise VLEN limit to the specification=
's maximum</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The RISC-V V(ector) extension specification allows=
 VLEN up to 65536 bits<br>
(vlenb =3D 8192 bytes).<br>
<br>
3 changes are needed to support this:<br>
<br>
1. Widen simd_desc SIMD_MAXSZ_BITS from 8 to 10, raising the maxsz<br>
&nbsp;&nbsp; encoding limit from 2048 to 8200 bytes. This costs 2 data bits=
<br>
&nbsp;&nbsp; (22 to 20).<br>
<br>
2. Raise RV_VLEN_MAX from 1024 to 65536. This increases the static<br>
&nbsp;&nbsp; per-CPU vector register file from 4 KB to 256 KB.<br>
<br>
3. Widen the vlen CPU property from uint16 to uint32 so that<br>
&nbsp;&nbsp; vlen=3D65536 can be specified on the command line.<br>
<br>
To ensure TCG emits instructions correctly, we, clamp the vl_eq_vlmax TB fl=
ag<br>
so it is never set when the total register group size (vlmax &lt;&lt; vsew)=
<br>
exceeds the simd_desc maxsz limit. This forces the helper-based path for<br=
>
very large register groups (e.g., VLEN=3D32768 with LMUL=3D4), preventing t=
he<br>
GVEC fast path from silently truncating the operation and zeroing tail<br>
registers.<br>
<br>
We also need to fix probe_pages() so that vector ld/st works due to larger<=
br>
vector register sizes in regards of how many memory pages they span. This<b=
r>
enables larger memory operations to succeed since address calculations can<=
br>
now properly span more than 2 pages.<br>
<br>
To finish off, we add an additional check on trans_rvv.c.inc to properly<br=
>
decide when to use the helper function or not; this ensures that we never<b=
r>
hit:<br>
<br>
./build/qemu-riscv64: ../accel/tcg/translate-all.c:356: tb_gen_code: Assert=
ion `max_insns &gt; 1' failed;<br>
<br>
On high VLEN configurations due to the amount of ld/st it generates (Where =
TCG<br>
tries to halve the amount of emitted instructions so the generated machine =
code<br>
fits on the buffer but fails to do so when a single vector load/store opcod=
e fills<br>
the entire buffer (Or overruns it...!).<br>
<br>
Signed-off-by: joel.bueno &lt;joel.bueno@openchip.com&gt;<br>
---<br>
* Fix vext_ldst_us emitter. Wasn't able to trigger the wrong functionality =
from<br>
within qemu-user but qemu-system with 16k VLEN crashed when context switchi=
ng.<br>
<br>
&nbsp;include/tcg/tcg-gvec-desc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 ++++--<br>
&nbsp;target/riscv/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 12 +++++-----<br>
&nbsp;target/riscv/cpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 2 +-<br>
&nbsp;target/riscv/insn_trans/trans_rvv.c.inc |&nbsp; 3 ++-<br>
&nbsp;target/riscv/tcg/tcg-cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&nbsp;target/riscv/vector_helper.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 30 ++++++++++++++++---------<br>
&nbsp;6 files changed, 36 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h<br>
index 704bd86454..6c277fedad 100644<br>
--- a/include/tcg/tcg-gvec-desc.h<br>
+++ b/include/tcg/tcg-gvec-desc.h<br>
@@ -21,7 +21,7 @@<br>
&nbsp;#define TCG_TCG_GVEC_DESC_H<br>
&nbsp;<br>
&nbsp;/*<br>
- * This configuration allows MAXSZ to represent 2048 bytes, and<br>
+ * This configuration allows MAXSZ to represent up to 8200 bytes, and<br>
&nbsp; * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32=
.<br>
&nbsp; *<br>
&nbsp; * Encode this with:<br>
@@ -29,9 +29,12 @@<br>
&nbsp; *&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; maxsz<br>
&nbsp; *<br>
&nbsp; * This steals the input that would otherwise map to 24 to match maxs=
z.<br>
+ *<br>
+ * MAXSZ uses 10 bits to support RISC-V VLEN up to 65536 bits<br>
+ * (vlenb =3D 8192 bytes).&nbsp; This leaves 20 DATA bits (was 22).<br>
&nbsp; */<br>
&nbsp;#define SIMD_MAXSZ_SHIFT&nbsp;&nbsp; 0<br>
-#define SIMD_MAXSZ_BITS&nbsp;&nbsp;&nbsp; 8<br>
+#define SIMD_MAXSZ_BITS&nbsp;&nbsp;&nbsp; 10<br>
&nbsp;<br>
&nbsp;#define SIMD_OPRSZ_SHIFT&nbsp;&nbsp; (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_B=
ITS)<br>
&nbsp;#define SIMD_OPRSZ_BITS&nbsp;&nbsp;&nbsp; 2<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index fa497e5e8a..b5c2139810 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -1637,10 +1637,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 void *opaque, Error **errp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CPU(obj);<br>
-&nbsp;&nbsp;&nbsp; uint16_t cpu_vlen =3D cpu-&gt;cfg.vlenb &lt;&lt; 3;<br>
-&nbsp;&nbsp;&nbsp; uint16_t value;<br>
+&nbsp;&nbsp;&nbsp; uint32_t cpu_vlen =3D cpu-&gt;cfg.vlenb &lt;&lt; 3;<br>
+&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (!visit_type_uint16(v, name, &amp;value, errp)) {<br=
>
+&nbsp;&nbsp;&nbsp; if (!visit_type_uint32(v, name, &amp;value, errp)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1663,13 +1663,13 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,<br>
&nbsp;static void prop_vlen_get(Object *obj, Visitor *v, const char *name,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 void *opaque, Error **errp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; uint16_t value =3D RISCV_CPU(obj)-&gt;cfg.vlenb &lt;&lt=
; 3;<br>
+&nbsp;&nbsp;&nbsp; uint32_t value =3D RISCV_CPU(obj)-&gt;cfg.vlenb &lt;&lt=
; 3;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; visit_type_uint16(v, name, &amp;value, errp);<br>
+&nbsp;&nbsp;&nbsp; visit_type_uint32(v, name, &amp;value, errp);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const PropertyInfo prop_vlen =3D {<br>
-&nbsp;&nbsp;&nbsp; .type =3D &quot;uint16&quot;,<br>
+&nbsp;&nbsp;&nbsp; .type =3D &quot;uint32&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .description =3D &quot;vlen&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .get =3D prop_vlen_get,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .set =3D prop_vlen_set,<br>
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
index 7582874c35..5796aaf04b 100644<br>
--- a/target/riscv/cpu.h<br>
+++ b/target/riscv/cpu.h<br>
@@ -186,7 +186,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied=
_rules[];<br>
&nbsp;#include &quot;pmp.h&quot;<br>
&nbsp;#endif<br>
&nbsp;<br>
-#define RV_VLEN_MAX 1024<br>
+#define RV_VLEN_MAX 65536<br>
&nbsp;#define RV_MAX_MHPMEVENTS 32<br>
&nbsp;#define RV_MAX_MHPMCOUNTERS 32<br>
&nbsp;#define RV_MAX_TRIGGERS 2<br>
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_tr=
ans/trans_rvv.c.inc<br>
index 23262b1d03..f34fea3407 100644<br>
--- a/target/riscv/insn_trans/trans_rvv.c.inc<br>
+++ b/target/riscv/insn_trans/trans_rvv.c.inc<br>
@@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t r=
s1, uint32_t nf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Update vstart with the number of processed=
 elements.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use the helper function if either:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - vstart is not 0.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * - total transfer size potentially exceeding emi=
ttable buffer length.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; bool use_helper_fn =3D !s-&gt;vstart_eq_zero;<br>
+&nbsp;&nbsp;&nbsp; bool use_helper_fn =3D !s-&gt;vstart_eq_zero || ((s-&gt=
;cfg_ptr-&gt;vlenb * nf) &gt; 512);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!use_helper_fn) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D s-&gt;cf=
g_ptr-&gt;vlenb * nf;<br>
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<br>
index b73e3e9dd4..021f9c60bd 100644<br>
--- a/target/riscv/tcg/tcg-cpu.c<br>
+++ b/target/riscv/tcg/tcg-cpu.c<br>
@@ -33,6 +33,7 @@<br>
&nbsp;#include &quot;accel/accel-cpu-target.h&quot;<br>
&nbsp;#include &quot;accel/tcg/cpu-ops.h&quot;<br>
&nbsp;#include &quot;tcg/tcg.h&quot;<br>
+#include &quot;tcg/tcg-gvec-desc.h&quot;<br>
&nbsp;#ifndef CONFIG_USER_ONLY<br>
&nbsp;#include &quot;hw/core/boards.h&quot;<br>
&nbsp;#include &quot;system/tcg.h&quot;<br>
@@ -125,7 +126,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vlmax =3D vext_ge=
t_vlmax(cpu-&gt;cfg.vlenb, vsew, lmul);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t maxsz =3D vlmax &=
lt;&lt; vsew;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vl_eq_vlmax =3D (env-=
&gt;vstart =3D=3D 0) &amp;&amp; (vlmax =3D=3D env-&gt;vl) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (maxsz &gt;=3D 8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (maxsz &gt;=3D 8) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (maxsz &lt;=3D (8 &lt;&lt; SIMD_MAXSZ_BITS));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D FIELD_DP32(flags=
, TB_FLAGS, VILL, env-&gt;vill);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D FIELD_DP32(flags=
, TB_FLAGS, SEW, vsew);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D FIELD_DP32(flags=
, TB_FLAGS, LMUL,<br>
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c<br=
>
index e321ca2616..1254a7b9c4 100644<br>
--- a/target/riscv/vector_helper.c<br>
+++ b/target/riscv/vector_helper.c<br>
@@ -176,13 +176,15 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmu_index, ra);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (len &gt; curlen) {<br>
+&nbsp;&nbsp;&nbsp; while (len &gt; curlen) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr +=3D curlen;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curlen =3D len - curlen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len -=3D curlen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curlen =3D MIN(-(addr | TARGET_=
PAGE_MASK), len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *p=
age_host;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *f=
lags |=3D probe_access_flags(env, adjust_addr(env, addr), curlen,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; access_type, mmu_index, nonfault,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; host, ra);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;page_host, ra);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr=
obe_access(env, adjust_addr(env, addr), curlen, access_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 mmu_index, ra);<br>
@@ -480,8 +482,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState=
 *env, uint32_t desc,<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Load/store elements in the second page */<br>
-&nbsp;&nbsp;&nbsp; if (unlikely(env-&gt;vstart &lt; evl)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cross page element */<br>
+&nbsp;&nbsp;&nbsp; while (unlikely(env-&gt;vstart &lt; evl)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Element crossing the page bo=
undary */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(page_split % =
msize)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fo=
r (k =3D 0; k &lt; nf; k++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; addr =3D base + ((env-&gt;vstart * nf + k) &lt;&lt; l=
og2_esz);<br>
@@ -489,15 +491,21 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVSta=
te *env, uint32_t desc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&=
gt;vstart + k * max_elems, vd, ra);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; en=
v-&gt;vstart++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (env=
-&gt;vstart &gt;=3D evl) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D base + ((env-&gt;=
vstart * nf) &lt;&lt; log2_esz);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get number of elements of se=
cond page */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elems =3D evl - env-&gt;vstart;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load/store elements in the s=
econd page */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vext_page_ldst_us(env, vd, addr=
, elems, nf, max_elems, log2_esz,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; is_load, mmu_index, ldst_tlb, ldst_host, ra);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page_split =3D -(addr | TARGET_=
PAGE_MASK);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elems =3D page_split / msize;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (env-&gt;vstart + elems &gt;=
=3D evl) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elems =
=3D evl - env-&gt;vstart;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(elems)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vext_pa=
ge_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; is_load, mmu_index, ldst_tlb, ldst_host, ra);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;vstart =3D 0;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AS8P192MB2176436BE42E70C1AF1D09A2E2A02AS8P192MB2176EURP_--

