Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D847CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTU-0004gR-3A; Wed, 01 Oct 2025 05:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSo-0004Oe-TP; Wed, 01 Oct 2025 05:49:36 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSg-0004v0-1A; Wed, 01 Oct 2025 05:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSkVFPQfqWnnU+RIJY3CcuV4jwLuwMt/o3c5fM2qmTtWdq8t2xJGH+qDARTGvXDsBsp6+rSSP+r5wZRuRcvs2aazFa8nJYTH7Gek+jQyc+vSGe08Eif/Ag8ne2gVv32aXKneL/pIpuZh9bPIImqLiAbpxpLshVwzoKG5y6IwtL1QWLM+RwtuRyC1EbXTpmuqP1E7iDQx3kZcawrlVeSTLawuzbrgUwur99yqOyFS5nmwdwh7ZsTtPrKvcu2nzJ1szXb8jdioyZNBzuIIqxF/N1sCtcyGVv0jaAJ0NucPw2BoPvss0eNxry6MqBgPcX/s/jlQ6Bb+dgF+ZnIYmZSG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB9+MWhu0JXelnCpKrizX2qJyRui3/4sI6qBobEVaCQ=;
 b=kRFd/6i9Wmssb7oWIAEXJP22A6lbHGls1+yJl6rC/dh3gd2Frc6NBHA0RxNMyRZBLohUf6/j2qaWJ4G91KKbZaUUwu+D3bNySEBkJ5vQ4UnGQDS82V3q4zoqrdyKSrZqFHD4JOHI13WWdwISgAyGP1rvwRUbRgqhBTo84Eyr+SE0YAehGNphgcGKVF1OVDp8x2ttfahUp995Sg6hMUBs1iq1TiM686M7uOnVBC6h3KqgSehAGHqmidPfkhB4ISM23b0K+d+cUdAQ/k6Nu0xKOr+tMh5PYV7snHoO20t0fdTbV0PQmS9yS1R1np9K8+96Lrst9OiZkx9/dou2rYMiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB9+MWhu0JXelnCpKrizX2qJyRui3/4sI6qBobEVaCQ=;
 b=GEJnfGZNSn6fWymV1Yqi3WFfQeTFHiG/LH0BfAL7aVzNs/WV+P4IFpe2H3bvvhk8iwrEgV+/7CyPunrnV4A/ZhF3x48YdzAsE3BCTq6/lpdanAVWASCOxp1RlDfD7E7RjZI58Qk1ft79RG6jNPjDuXjgrvKD6loJQdxc8Z4j9bFuNgtqsMgoIFqdAFpUx5IueP2EDf9+/MxR/fKEHr3s/hOmBya1hBUEA7KsrK1as/tYhQdI/Vq08xLGBsW8j/OFeTKoHwuyKOVfOIxzSvuqQwd20fbIRNjiGiupXd79bnum9+7rqF7WTqGBEuxeZsPAoKvTI4z9h5krHbCnKZ7WLQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:10 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:10 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 02/13] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v9 02/13] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcMriiJMjdKnMaeUmdbBWLAwyUcw==
Date: Wed, 1 Oct 2025 09:49:10 +0000
Message-ID: <20251001094859.2030290-3-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: 101c433e-7eee-4f0d-d37b-08de00cfc545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Py8vZtr1sznf+pcN1hKlbvWeOnyBnG7HsznHUgKFUfIHmsID0sAplWwPGr?=
 =?iso-8859-1?Q?FNXXkOYKgyJMeoALKQLmoimk96I8m1i+usA9HLfdpufDWmHl0N3t6/vdxz?=
 =?iso-8859-1?Q?3Ww9neYbx461mQ6KoBG1wkfqzuarNXN9ZFO0y+svyAKYBAgqkd4UjT2f0z?=
 =?iso-8859-1?Q?UgrONpDeJMGtb8YECfJotvwdsthau7il3ElYepbnzJ3sGNIH2N2TjbPiE1?=
 =?iso-8859-1?Q?aqXLmgKeIxBrXwTLv9L8Ny3PKhOYjEYfiTVT3SlfcAhagCHZRn5ZrLbj8J?=
 =?iso-8859-1?Q?Qr9OJvVNET5/nu/p3gpnk/UV7pj5YozEgA5sg7H7Q6J/fsdJPITAOiEsst?=
 =?iso-8859-1?Q?jRfKX7FeFLf0K2O6ScW81Q+bjGGHvknGzIG0OSN0HXeSdU03dYxvFg9U0S?=
 =?iso-8859-1?Q?196z467UZ9ZDAX1OVoCR1c8uKT+qcdE3s3Fc+u/97IuQQ+nafuf7sS83S2?=
 =?iso-8859-1?Q?aK/1ixXxfL3sQeR6GgDqYwWmfy60ohSga8xp/e7LrYelopvzaAHBFwNnwf?=
 =?iso-8859-1?Q?1TYtluUMzdMZVVVt0weT8DlcXs40HupFF9Q44FK5QtS4IAVlcFoljtFSvd?=
 =?iso-8859-1?Q?PSMdZc/vv1CuQABAq5AwCFxiOmvxcbhpp1sFdK4wPxWTvy7Pgvg9Uxwgee?=
 =?iso-8859-1?Q?fuGYDoo+oImz/uSJ9XZI2wbz/VYkq+dy98YNaK/qwzDXB2NAT2KOVJka5t?=
 =?iso-8859-1?Q?MMdKQhg0ierBw08yhHPFC+n4uPPlPJulJWDD76tDONtQNP3lOZeTvVQRJv?=
 =?iso-8859-1?Q?GHe9/peKsG1OOYWzhJMO1yH4yEWSrucl2hIxwn84rffQfXhu9makk6ysgv?=
 =?iso-8859-1?Q?OppqD8PHSiGw7XHd7ztdAVo0TIfPmIv+Rr1taYHPva2zCkhWFXoxkEI0lV?=
 =?iso-8859-1?Q?ZOXAfsNuEvxBm2saw+2Yos1D81J9FYoYAirzqNES5B3guaMTAJbx2ysnAk?=
 =?iso-8859-1?Q?ORqFf7Fn2VdK5aNIPXKRToKOobffP7Wotw3lwPYz24T+3fNGVQNNpgIQ/O?=
 =?iso-8859-1?Q?WGw4MHHHrTkm+RErRWeyGDvEoXO/zlM9K992zh4JxGzjn+kjcRLd65VTRi?=
 =?iso-8859-1?Q?859Q0AyQ1SFojdSxRcXCixABWOcgWTCxlNEj0y3aDm2afwYNvWRH27KmH4?=
 =?iso-8859-1?Q?sgSrNoRe5UtB22PD0WFGStrUV+lsGsA6rjTXEIVwGK8v6V3F1YwgLgxOOu?=
 =?iso-8859-1?Q?19ww+d6LzD/mm6SLXWdHvsA88PqKZj3hQWO/6qlyQFjXGsoWpH0HsX8vSR?=
 =?iso-8859-1?Q?e1iLggeYuauqzHloXQNymeciMno4jjOvwBoDQ12ELRp7ODn//0SHtwKITi?=
 =?iso-8859-1?Q?92guLwVYS6TN5Cp5ze6DNrFTqNNBMgCMERAc76UbAohA0AvZUE1SOfkYCn?=
 =?iso-8859-1?Q?owA7xlwQ3CjQuOA5wsES/LUAta05PP7fYqr3XPC/fu0+Sv98gxxOK0j4lx?=
 =?iso-8859-1?Q?pPAT9O4ZYDAH8i+w61vGnZHW16in073Ed7tSbvbq0pQlQYLIr5xqkmgFvC?=
 =?iso-8859-1?Q?CKnhTh+yDM+yPVkfK1pYgmY/RRTdDFzVjlG3aP83gmEPEceu+4oeuS8KRT?=
 =?iso-8859-1?Q?FUMbX6h95xrGFNYVVRB0coZg5fVK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v4fa7TkoznHvuPWJJxXr+rW05yiuH5F3wysNwdS0wn35PMAqmc3IQIBn/F?=
 =?iso-8859-1?Q?xTpFgcieW9GE+P05AVHUPz71tyr9KEL6cFdZI+baeM437b7NIkB3SHK873?=
 =?iso-8859-1?Q?ihdlCKd63VKNOheTNZkwwEg9xc8AVT8tntwWNns0T+thr3nNV9jddgR/Cw?=
 =?iso-8859-1?Q?+jSrTcznv2D+l32/gPqum9NBLGKR+yWUZvFDv1T8dapR7ToVV2bi0/Idp1?=
 =?iso-8859-1?Q?ypV6e6bdKNcjazJTUeeZBUJWwkxX9i4XhrUCFE1jSrJhZSvDcDG91fRte5?=
 =?iso-8859-1?Q?i1MHTH0izzG2jXmsX0Fubfg8h54xk2ksOK7KjM7T5jhYAAPI3lLXR38ar/?=
 =?iso-8859-1?Q?J6JHbSCX6AjSxFIyPqZVEjV7ozShlvRkpJ3/C3ZWxfkXcpDK05cm5c/U2M?=
 =?iso-8859-1?Q?BjOsgxWlj8RcJU/5CGBhL/Ej3DqOd6Vg9oz2/2ZDjPh1pLdvFMDzMFN4/f?=
 =?iso-8859-1?Q?pG1YC1Qr3rjgaXkbrkq+PHsK1jP9lupL1weCXIOCGPnbiVvOqR14gG7e4D?=
 =?iso-8859-1?Q?E+6d57sv1jPM+UlFHXpel62lURJv9AZWwwGTDgfo63POTcFNz2G0nT8xRY?=
 =?iso-8859-1?Q?sgKFPcWtcZjWH6ektnYZd1NlWSiFw7XZVaIwHs/Xi1yc+N3hyJyC+iV16M?=
 =?iso-8859-1?Q?LrobFYO1a1uHj6ba91sGhSi3hEyGdkGlm324obvORy+tO3AKrYoyUaJDcJ?=
 =?iso-8859-1?Q?Yhw4KAjNNDHxyQ21Q2LwdBsC3ks1QAF0ga7UfLDPQLw9Nbp5dCh49FgGiu?=
 =?iso-8859-1?Q?bIGlk8QXdbb2nQ5JysSygt5WYqgxywB1VHcoawqqHpojRpxy1CY+qD8mcN?=
 =?iso-8859-1?Q?rr/Pynp7b86gtycfvgIEcS0apYHtLWJoyBzV5DsWrTk95XoXSSMS7533A3?=
 =?iso-8859-1?Q?cx3YGs9i+WEhyr4DHwcrd1Tpd55o4Ue1Y6hiv90eUesv3jCZXOET0ldunT?=
 =?iso-8859-1?Q?W+jAohLBUnI1iLp5aV8X9tMRkN1JHzb2+nY3hTLT15gmTog/9mKDs/Wz67?=
 =?iso-8859-1?Q?TbHmhcItmuJEJv7AwRA8AQfzTy5/V8us1ABUT/vHtZ0fSCGJaPqluqjF0s?=
 =?iso-8859-1?Q?a69kvRfnYPIIm2velT3+0ZlYj09S/UjrA/aII0kNmz87L474i75uTdqTYE?=
 =?iso-8859-1?Q?ZrZ3t5cQSryMwFh4SZ0enVMNqBLByudnWsUC10TrmdfGcATekJSmUOtxor?=
 =?iso-8859-1?Q?QTdfZFQQYmDKRlJfpNge6an+8zR8x1d1JmO0WzPSQNQfnWiVee0hgQxKsa?=
 =?iso-8859-1?Q?TE0RFPfKOsk8OjhMgxki6D23qiV12AKTRhpWShqGb2XMsTL2j7e7ya6NOM?=
 =?iso-8859-1?Q?tcgpltv16jBWD5xogggnCOkwHhkyTeT8hykgHA1jzC54gJDkQEOZeeSmhA?=
 =?iso-8859-1?Q?gEsdoGJr8p/6AMQfrtu1RUK97Rixz+7AIv/5wwK5zOIlgP12jrMDPbi1D8?=
 =?iso-8859-1?Q?SepvWmvvJZSHbFqI+0xq6/1HuUC2znukyEo+hCz1DgBLr0X0Cb9F3PgtR2?=
 =?iso-8859-1?Q?M+pQyPj6PPTGRgQJWhUGnF6xEx0bleblJkXb+JwnuPfl7XX4zk9WijFv+W?=
 =?iso-8859-1?Q?YSCTnqXuiyQF/kJfNCuq4d7F0ZBCTX+pSiKkbK8riWZqxkaiwqrFSCmCHa?=
 =?iso-8859-1?Q?BdgRY9UbiLPzYf3aGZSPGXfjWuS7ho9zbMw3Fpe1Pkqn8BlHTE+ehH+3+T?=
 =?iso-8859-1?Q?3UYfuF/usJw64GMaauE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101c433e-7eee-4f0d-d37b-08de00cfc545
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:10.0727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLwGuUZu7rMzw1LGjhXp2gDqZKDxNCfd//ocMrsF796sSv4A9MadgGDx93NpBYbCoobVQeKKNgSUlZjXZOgA54IaCutB5DJ8Fn7jj8OA1Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 ++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..74728c5371 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,20 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    CPUState *cpu_state =3D qemu_get_cpu(vp_index);
+    if (cpu_state =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
+                      vp_index);
+    }
+    RISCVCPU *vp =3D RISCV_CPU(cpu_state);
+    vp->env.resetvec =3D address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig=
 *src)
 {
 #define BOOL_FIELD(x) dest->x |=3D src->x;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..34751bd414 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -672,6 +672,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
--=20
2.34.1

