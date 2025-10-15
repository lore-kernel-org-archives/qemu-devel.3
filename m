Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B69BCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91ED-0003IJ-1I; Wed, 15 Oct 2025 09:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E3-00035W-M9; Wed, 15 Oct 2025 09:07:32 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91Dn-0000mj-Nt; Wed, 15 Oct 2025 09:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyYlHxYc6XOoB+37cziDP++4Bn+A3O3lWKr09BYJ/YQDJ5Fom+4KfC2QpeX6Yk3oKON9Av9hFCkyGAYhoEe1aROSjpA64sgjme1/ORAPl/PzlaBZcLxNLhKTC5xT1J1rG7GH3EOaOAfiuWxTKDh0r7PsxYDTihRWkHr8uGtEUsbeMagx5k+lgZf9lKfM/fzvIsZufGJC4QY2z4fEpLpkNTrOOiLJOlVMc/WazEeWj38yPtyw9ylZmcqkmJ24rGCjrRdpmzncUaWIDs5mh3qzKYniGm7syqsj9aE2ukycoQ6rAIX8ovMWtNvIFsd/9Bg3JkmrgCFN1EEFx/xgMd91KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=Ranw4jF0D1+jAjOcVHpx+YIhZNCIAB2psxObPMtQ6w3KVkCtaRnnWRraxxXoHP7sWHcjmh9thbwklZxhfraZxJjhIi8NgyMA7dddzCP8rv5yUctaWDuDr0SaD1ZaLi4niwHTPkRgephKBV5VybycG9xeblKQLhND9x3+Q9HTjcDNh/9ZxUxeg8GROsSqcWLNjOhAwcO40iKK2ZdTXx4wrXuKfCLvsYeijF4f2q3174MhNJNBYgz1Mhd8iNMvTm/qjTZQh62S1hMwxn7jSTOt2EcQZF/DfM/ZHOWzc1cNCfpfr5ue5a84zPg6fygg7C7Fz6QBRAzHluXIt4V1JNzkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=IBeTHFl+4G+FP2MkfjDOitgrBXGkKJjMgJHTSPZvg7aWyESfYZb016sGBpOgJuPZ4YBC3Xf/9VBxUmZsTfrGMJXstYtYH7KebnOy+JrYaQIFQ3cEpM6/OmhML7QDI/bpEip5RcAIk4DhddzRfyQbGxSy8hlhtZx3idRf9SYC4lx1fVOoqAopM4TmB8t7VVhMrpjwXtCOJZF6quUx2MGC+oKOdOahqwXIxWyNtQmgV+Ki9MWAiQy5wRTPrRFd1YwGKhToqWhwX+HZp1m+uzBRjqvzN7pAFoDMZWinet0X1B5Tb6ius6foAK103hJS/I8YHjk/m1EO0giGV7RO7BYoOg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:04 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:03 +0000
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
Subject: [PATCH v12 02/13] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v12 02/13] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcPdSZHVPTOx9Ow0C3oKXaRwM8qQ==
Date: Wed, 15 Oct 2025 13:07:03 +0000
Message-ID: <20251015130657.571756-3-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 15e90f6e-508f-4b50-e1dd-08de0bebbc67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pSunUxlGo01HWJictIxiW9FWSSJRoueAXT5KGy1GT+ZIfFzeIrzyU4IUQh?=
 =?iso-8859-1?Q?m0ijgek9DAAlCd7tXz20WAAUh9nXUkGX89t9eDTZEe0bc+cFhgP9wE4Nfc?=
 =?iso-8859-1?Q?r8TGooVcwgf2NyxMj9/ipPmNyCoXroHnxSPQNMz8GMlnf1PcL5HS9PfK5S?=
 =?iso-8859-1?Q?KfGBg7lvdROHwB8VsoRGIfuMZjZKI98KbGdV5ErrLnT+l462VxZVbg8awx?=
 =?iso-8859-1?Q?A166QTtD8nC3uAs6oJaJ/urKwifZ0QiY366D99ErfxNoH18Iesx2Ml4fWG?=
 =?iso-8859-1?Q?i8hHpfxn3Y3yMe1QqaL4Eo0KUxwlOZsn3eo/g3zOBNSyTqNEGabDRvXnDX?=
 =?iso-8859-1?Q?OlVeGvlNdNJhNSdrp6U42XdpThznFzIfadXt1Sr0MXOgjj1c+NTv3zS5Ci?=
 =?iso-8859-1?Q?1gua9DlNxiITixs5EVJCNmV8BSaB7sn/tLLeJAmx/tl8JfGxDrWtdVwE8K?=
 =?iso-8859-1?Q?xF51V0uQffmevW6Mwr3bta+cONyR2M+LA/ltN50uH5diy77OgwWuyMApBD?=
 =?iso-8859-1?Q?NUwbyMmzCVQLWf5nS1rV6/kBqFkrPGLoNOxfgOYfLhereYEr/pJDpEVX4y?=
 =?iso-8859-1?Q?F7yFMBHsqAed1UQUkJxmeO0WPqz6N+Jf4Q4Eg6bKlbV6uYrlhjdDakNB5X?=
 =?iso-8859-1?Q?cgHfySSce0bRu9l/zUkCEiEnePGHY3rpqcePBvZBis4SlPXEfczBWk2eM7?=
 =?iso-8859-1?Q?X2VO17usJ3mSDgOWjBe6JQjws2CHl6PztOSqYz2rqrGxwQHgemHQ5ge63L?=
 =?iso-8859-1?Q?mplBKT8YCVXX9rx98qrghgP1DAYJDiiTuDIWEuWWXhbOKgy+oMTlzZyGrW?=
 =?iso-8859-1?Q?BYwSQHfNzP9JoBfS3h+1fsNXkIfdwmDuQxexn1N1QlM6pnktC82nW16Ahg?=
 =?iso-8859-1?Q?LBU/M8uc59LzaV1NpLHgZsjmVDEI94XWXTVmLw/eUTRMLoTjveMw33gA/p?=
 =?iso-8859-1?Q?upmm1NSsiPexL296X2VRLS9tA8XnrTaf/Brq1QyJX2m+FNYLHhuF6KBFwm?=
 =?iso-8859-1?Q?ghAsiRXHxjlxO/8jFx7rQw9+T+O1fUPx7iHZBk+ynp4e9s/jPzvcGvAYmE?=
 =?iso-8859-1?Q?SpL3Q9GoRVkdWTjXkfRzwGAkwOMc3nSNmqYYR9MAhnxSc5OC6zNodBf46G?=
 =?iso-8859-1?Q?nQDGyS2tFPv9FDDiMrwIbPj+fQv1/C5nGM6m0zsz9buuOJa8onhvl7QQZH?=
 =?iso-8859-1?Q?cUwlv2nIdT2JnIBHVpkj+eHsF3YfdfWS9z9Cfp7Yi27thDobeLEN8ET7Ct?=
 =?iso-8859-1?Q?fieIQHjDak/jaoWdXrStX2fzito8Cq1WJ/RiEuEGtFH32FX6pG9PtS7GUW?=
 =?iso-8859-1?Q?jBdlCSlZMSaPYL9BXz7AIAtiD3J4tcXi53MG1R3w9LkptaYt5e38kmSmyN?=
 =?iso-8859-1?Q?DjlQKLnwKgwl6CfhIfK0LqXdQFcyM0vI9kvAB1k1PdseA50cno6GJaWYj2?=
 =?iso-8859-1?Q?FvPqjzHAs/YSDv7pUT74zDCPEvdZMWjngTT1HYQxEB3CvG2YE2G6yEX4u2?=
 =?iso-8859-1?Q?bx1eN2NBlbhItc7L5GHiq5jTLBGZaY/zViRa2bL/KbA+wc5WoY9+7q5cdb?=
 =?iso-8859-1?Q?KJevzeupN3g6Auq8lW9FN4uXLjLf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yP8wJb2OCAiwef8aaJOfK3sLflGUWjEI+dOGTREbFCVqATXdqOvLineJQN?=
 =?iso-8859-1?Q?U3WW1hVhmyevrRnE30Ac/IR0F2xKFypqSBSGh0fAPPug7V7+dYcqo3qDg3?=
 =?iso-8859-1?Q?VNQIdD4hufgNz21QiGroCdVbSEoDrR1JnLFMLXNO0oXcuYKuYnbzsYYlap?=
 =?iso-8859-1?Q?+MJaRpjAd442SYZQC40gCKHPN32MdEpO0uRxy+b7EX2qpEvWRZzHQTkcM/?=
 =?iso-8859-1?Q?Ya45t5/4AHCqDyAvdWsF/QMfBx75Q72d/iLywqdi/ulUV6GqNXacaB3kRE?=
 =?iso-8859-1?Q?ez2Vkgh1iw7iclV0QzXXz3nL2GhWGDi2nJq0MahIrtX/prYdua5ojiwcLO?=
 =?iso-8859-1?Q?oKOXartKW9ldCaORWOY55kUD4DdbczLuGxmld2dNtn+N680x+cCrbUh3W4?=
 =?iso-8859-1?Q?0Lm+CH7WrVqmF+dHKEjVT0emi8yM9WIeFJ4AoplK74SsTRGeui95SZuC3i?=
 =?iso-8859-1?Q?lpQW+XuJZxcyCgHCOAfdJnI3ldNKdIuLrI39aw4cBmPfUJ2Ht4Q0MV9Kr6?=
 =?iso-8859-1?Q?zmEOet3/e2iAdzo6uL9K741rodg9Byi6Hiqq35SPY2hR4lsdBuvvURezTr?=
 =?iso-8859-1?Q?jYhhuNVlVoAE1QteHHCpsjrg0Gti/AgutEoJs/ZTpOBk9xNHldwLHWyrfY?=
 =?iso-8859-1?Q?axtHOIKzN1Fyh7Gc4Qk4KHiXIVM4HJ/ePTJNionXisgT7LgMPGNj4qh/IY?=
 =?iso-8859-1?Q?BOLE+gYrUF1XQHwP1VB/ZQhQ+sTuK3gL9vZovAqmO406aFfgrHogWuK1dx?=
 =?iso-8859-1?Q?Z29Qu+5oxQs+TcyxSISyGdGOr3cjZ5fVqNA1oSZJ/kQ5oIyK2yET0PtySD?=
 =?iso-8859-1?Q?8pt7oyq6wkED1QA0XpLBiHMrXeuoJNhNxiLhCYHTIFBmKqBxoWkcIXzL9D?=
 =?iso-8859-1?Q?KbTagPlEMahvWGBZ1PBDbHCNOvV7MhfqFAjGo5F/E1q8GuQia6hyGkAfUz?=
 =?iso-8859-1?Q?x3WcEh1alDTMHofs9ju5rDVjF4rBGfoFHoatcTvETt6xsX1l+O5r9jZymQ?=
 =?iso-8859-1?Q?9C/uk/UZO0DfzMmj6MXM/Qq1oaFVINRicFaMuMyxrwPgyyUe6i7mIfmpXP?=
 =?iso-8859-1?Q?EQxNAhhIbFEkrxG8mr1MZwu4aw0qcijSGvvabvWUq+pPfC+rN8uHAFrNgq?=
 =?iso-8859-1?Q?JLacJgpM/VV5YzPht9dys6uXx5+mJ23C2E2/RlrGkwDMADKKZDCEH3WWwS?=
 =?iso-8859-1?Q?yc55kW5UeVMzgjccW2TQefHgsSjggwaFRnpTVSYBvtaeUYM/W61/EsyBGc?=
 =?iso-8859-1?Q?6t0kV2oh0tr0RnH06EjlBS/OS4dNwpwBgiiVJMPbizgLRoTFzlBRZMIA7c?=
 =?iso-8859-1?Q?Tv96oKIIBv1w/2vr9Bs8tRd0GPAI5c/KoHHoOgtZl0AQCe+FFpVer3Fro1?=
 =?iso-8859-1?Q?7lwhPtEBD60YkEDdkmKrYg30QaYCerSdC6peOHDyJpJo26yzs6PnLnWR8c?=
 =?iso-8859-1?Q?7DBtl8NLArj3VdBz2mvBfzs9kFdghMmEvCk1jhH0y0dZD4XfqbGRp0khTk?=
 =?iso-8859-1?Q?BOHN+FIo01Gse8g1ZyEh4DvT2WkxeTAhDSxsOtjOSjMwxJi1RXfQNrm4kR?=
 =?iso-8859-1?Q?uOu6d0EGcqtlwHZwTj52ATm9kgwczkmNk2chJE8b+8d0Vxx4RcGp9IP+zF?=
 =?iso-8859-1?Q?nLzjUfFA+1EG2QQdHw98qndEzoR91GPqnufNLf/zlABdqkw+ry8AEStvgr?=
 =?iso-8859-1?Q?2yAI2vcztDEsqecmqnw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e90f6e-508f-4b50-e1dd-08de0bebbc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:03.8412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IP/pWCCGsoU7Vm5k4JezYZCiXw7mAIgfPzHl8K0+Si55KdnwahV0QRR+sRTz4kMbI/eQL/VNgL+t4sgqLToJvCzz3g4+0BAjtdIw/7naUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..7932ba6873 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,22 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+/* This is used in runtime only. */
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *cpu;
+    CPUState *cs =3D qemu_get_cpu(vp_index);
+    if (cs =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
+                      vp_index);
+    }
+    cpu =3D RISCV_CPU(cs);
+    cpu->env.resetvec =3D address;
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

