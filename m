Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D5BCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n1-0003vr-6u; Mon, 01 Sep 2025 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mn-0003sW-TB; Mon, 01 Sep 2025 06:29:21 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mj-0005KD-Qy; Mon, 01 Sep 2025 06:29:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVwih9IRbIf+HV7ahOU+BJ6q+yKHFrWvlwV9RqPYCHpxNkFpl+esApOQEeYXApdkle3MR4CIT5Fjz7+gJnDn4YMxeVMuQeXlrvmsZaoDv8HaTu1TbjMK+PdwVaCM09WrX7DR9va59mVXkUzq8uYRT4do7oQtIZ7/fQ/H9FBe8W9umAPVuic+ZNv1zpsOQzM/WJKy1RNJjQwXVWop0FKfMEWSeYsUXxc9e+XsMDz+cGiHJ+uLF7OI+ugnqQWyTYuxMgE/27uF9qrK3RBur3gnB9/Tm49ntDbKwRseVzLQPRf7xI8MkQVmCBOA9DgB0oIH7q/8pw+qusQ4Gds7SEISkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YcCosfqk/HtxhulNSPDQUz8sGRxcbcQrutjl8hoQho=;
 b=FzsD1idVZT7rSIL4M94ujosLSUgDyPQlF5AwdzbxDSjbA5NQ2e/e9cyd4dKflWJdbMuWtuQEGWzgmseeZ7LiBuDpeJsRfvtd+Fyclp1Ir1mgxLqPEjnyxE5VEDfoZfSfrDYlbFtpqxNkxGAlW5mF+erz89uU+NcO94Uvk/SK+pxhPpDukUJ49NViAHNiKLUyOeuTx0vXvngUq7b9yJx5PL9FEx/RD+EDpjrnuJ2ZBjaqoGqETmCrAD4NaF2sh6/SV82mQnn9B8Tp4Q69YZSjGcgY++7WITwS1FJd87rR1qJOI15Gvzy/JMhvqYJuMIIEZ0u+PZ5wiuSznfRfsZM/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YcCosfqk/HtxhulNSPDQUz8sGRxcbcQrutjl8hoQho=;
 b=MXfuQwKmdy96Ao+cD2VEKAywYGFL4y2865LOwJqlaW9ceW0KPvYpO+1pNGPvDd3AxNH3IIWzCPhuCSE0hF12Al3QxngmNCwXPn8EOY6CF2tadUjX/Fd+ARv5S58JapOSamKPZRZhRMyXqQ/aMNNadsI+rtnf/CWrLdCabnrlssItAQREHdqlINvd6O76/hm9pwAXlZwSxmHo8MZ/j5dzM5rEM47s5k6y351glg2oZF5E5cnlOEREDKgMPNhJRcFYecqATHzhqlkSegr4Ynu85azouZ0Fwh2OpnlmMHktMthKVnvZFF63PgaL1UOWQRz/vEJf4nmztqjFIlxfaQultA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:04 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:04 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v7 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcGys8RNrcSCta9EqSkRneiQO97g==
Date: Mon, 1 Sep 2025 10:29:02 +0000
Message-ID: <20250901102850.1172983-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 915eb405-7b6f-479a-510f-08dde9425fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?++2osfC1xNl4OBgGITbYhEmpJTBNn1vie7a8sI32u7Ro+B206U+LM0Ih1X?=
 =?iso-8859-1?Q?4GoDXn2b9RujtPap7bYYxqwI72c8csSXcut/SpnTQsLJ9XxW+SvFnHa3rV?=
 =?iso-8859-1?Q?6aP57Tgru9CVdwG6EvwqYhugPz5joWzq9oAxDZnzGnIMLLfbxry9zesbVn?=
 =?iso-8859-1?Q?vxuCEF4tLYx7Boh0QqBt8wG6JcqIh+EcOxFoNqEBoFbQafRchc0sEUv1+o?=
 =?iso-8859-1?Q?kcXZEWUtqDW5T2T8n82iqO5BrwFjGx/w2+3Nm1NkiFnuSAMXxL0/crlnEn?=
 =?iso-8859-1?Q?c+wzc9sqX2nUdRznN69xfBPZ6Kryfscy5mqqPYa4UV6+7ryK+hei8uRMAx?=
 =?iso-8859-1?Q?IMPiHQGuDNgSfGQcf2cYOvqK+/ToAJuXLPO/thlsYW0VQgM9rZoMpn6sG9?=
 =?iso-8859-1?Q?nQ3aPcvpeGJyGbArF2KrgBq4vBZIVYqp0xxh2rqdrMtFa5FnJm72yIocuH?=
 =?iso-8859-1?Q?PNWaBrWt1H55iXqDFJdi9tQdHYnwkFbCPAM2OjKqFEr2Xvy+Im9wbTt6eK?=
 =?iso-8859-1?Q?uizDqD6Dkl5vrWdZ63eZULBtpJ4Ihx4MkdIbwER18HgtDsqvBegfs3s4n6?=
 =?iso-8859-1?Q?uK8fRCfmo2IQU47iLRCqR6KtIzsNb7IjfOs3HU2uGnlPpGO5aK8RR3f+gX?=
 =?iso-8859-1?Q?jUjrjcPG7GqzGZ+RbgJXVwUFgABDMUhmYDidVe8g9Tbp7JFB7JtfsVIgpE?=
 =?iso-8859-1?Q?8taRHdjdxYeJJ/ecJlsZb2InvMEwY0+3hflIQu3wv7LVaBZJZD3aT/nWGy?=
 =?iso-8859-1?Q?7+x7f6zq37o/lv3XjnjqJnNyvCaEDv8iZRlUaD7o58xCnEw77qZXZlyiH7?=
 =?iso-8859-1?Q?iFTDTnl+7Izl1t77D+MDfC0BUolfArBrplIF//OSTsWhyJbykzXCWe33SN?=
 =?iso-8859-1?Q?ehXtVF7A/fe7/XV17F+y0WCzKXc6P5xPHlDaObU7Dh06SLmhWnXuPyUJYm?=
 =?iso-8859-1?Q?ymmnqyDN/DE3AKFOHicYDx9U4hBXs7GZ6ETO9EuCwlBmpu9z9QzEmdyk1V?=
 =?iso-8859-1?Q?uq83GOG7X3Ys6F6nQ50IuoNgfrpCwMYLg4jM2o3npHh4kjtJ3q92rJ5Fmr?=
 =?iso-8859-1?Q?QOS8ghBVCUH2V9eR/gSFfYHH9r6S5AYTBm/H0d7m6FaF/DJ+NdwZhrroz3?=
 =?iso-8859-1?Q?+D+UzDIeIlTrJz+B4Yj+/GbFBC23C+xNI5zPhmM7v/PU67eUVHv17ZZCke?=
 =?iso-8859-1?Q?ATvkYye+dEjfAfVXTYJcrzxZXYB0WiYiRvZukVxSbznEl+aNyd2hvFOvcT?=
 =?iso-8859-1?Q?ptxl6CxNbLNvu/8dTnWXWX/thL3z3pRPjCqETyH+00X3uION+QpJ7zssjq?=
 =?iso-8859-1?Q?K7UNqGS8GsbwOV9bNdtyAElYe1/WLFXQeGq41t4vLee9N5X+ff9PGziqrD?=
 =?iso-8859-1?Q?HXuPQjmAW8bGFeqBQd8TmwTpwa/IpgE8+p7bXPswxQOSHX+y2L6DRqnHpw?=
 =?iso-8859-1?Q?3IGBN65k3ctPDF3cKMGfeffiYOUhEZLOzsfEISPymyO32OVU+dH+oIhVnf?=
 =?iso-8859-1?Q?77KVK1O5MZxafJZNHwP42r/ZHV1QprDrdyUGhEFlEpb+OwPc3mlJZraRtU?=
 =?iso-8859-1?Q?sMzE5jc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h3ROW8BTIuignmbR7hgt/31fUzaZnMbyJ2WGY3EUchFaIzaTMB6EB4FMVs?=
 =?iso-8859-1?Q?e5LzoEpdQREvB5qaoEXqXqwunMwJEIB3ru1ZrZADDB822EhS/zY4p7XTcj?=
 =?iso-8859-1?Q?tab3VYFtFYAwnchBfJ0oSC366Bzw8p/6g+0CBtjiSPiz7p7o0EmWEfvGxN?=
 =?iso-8859-1?Q?ybcoBO3m/+5tErL0W4qE2TTIqm74JKmkZpgTwGBIuaZ1atMaIu1PtL13HV?=
 =?iso-8859-1?Q?X9GtGtLUASJFiSfhhSExqJ3FzyJdrpS0eIX6MfyRl7J6b+1AXjL2WbkYI/?=
 =?iso-8859-1?Q?d3cmjOLXwtspGAO0CBn5gZljnGIqj6UuCButMO53cvrgOwXVZ9a+g0eDN3?=
 =?iso-8859-1?Q?xX4LAClBn7sYzfuDyG/sGcSQcXykipqI+k++WrcgdYH1J+G9DkuUikMk2+?=
 =?iso-8859-1?Q?i7jEuJRtakcTE5TdFKaSppeLjyENjz0IFPdbSYpTyUXj3+qb++IFQbYl95?=
 =?iso-8859-1?Q?mIrjNh2fbmGZxe45sjXkUjnKSwK5AQjwKOG1RcPV2YKQ9p5l019SUTuhAH?=
 =?iso-8859-1?Q?tHmM5t7TZHxKAHJB/jv+tWt876xoUz597QGAhhDKiPSAHHkrHycLVLbHPO?=
 =?iso-8859-1?Q?CrIOpTX3PqX+alys/qHXCnop63umua9BImaxfzMf+6woFGN3Q3S6FY6iDf?=
 =?iso-8859-1?Q?jMHT0Hza3OvnoNkW/4GRcL2Pil5hl4tJtO5Srh9INaeOphmLtHW746eONW?=
 =?iso-8859-1?Q?5MU2/Ln4M9pduvCH1Sca6ZSWj2kJ/bpPcqwZ1q1VQm+3bQqVhBJFhML4k4?=
 =?iso-8859-1?Q?sMXYgp5y5VhYvcjgbek/g+h9LMLK4DqebFFshdcQeOxJjs7WXxlqxJ7Siu?=
 =?iso-8859-1?Q?W4HfDav3C6/KHqmDm5JeQt0r2RIxMCwePvYJdecYYdGvn1VuXiTWULy4s8?=
 =?iso-8859-1?Q?KQyeWHumF1QPkk9ONwQLGddiyPxkDljjbQstOo3WJ4R1Gc5HgIlZndAwrB?=
 =?iso-8859-1?Q?eQoR6gQyg3wDroWjMGk6D3EqWWx5EVnX6Jgje+1jTatrUqSKuxuhQJm2aX?=
 =?iso-8859-1?Q?nL5XTxnbM8HeUeafBn2a+ZMEHcC9eE/wj+hiERq3qAbY7PwWIkszB7QB1N?=
 =?iso-8859-1?Q?b5bNirSXQp6DrUcH3C0VtpZz0lDgM/oU8N4JPVeXncXtptkz79c3vRjK4P?=
 =?iso-8859-1?Q?13DFr76b0xSq77403rkRL5+wBBMO9K9EozOMx24waHIUE7NaxIR1j/2wBf?=
 =?iso-8859-1?Q?9WVe7Yby3v+Wh3wE2pHgZU22Ci4apW/r9R3LMTI7mZecJByaPXWduhYHoX?=
 =?iso-8859-1?Q?usAR0mdC4Ctir8Mn0V989Wy5s+/VJIXyWDeTqgu2oud00zydKJPdWECpTS?=
 =?iso-8859-1?Q?/U3grkOaPBpKFiUbw/LLQj/2bFHBd4pKxH+/HECMWsnOiItw75Qf3fE9Mb?=
 =?iso-8859-1?Q?fnGuDccYWZC5d+Sv1590UrVh/Xywcl5gL3aVSLunQmoSBoVpjENvSdujtf?=
 =?iso-8859-1?Q?eu1Ah+S2fCzPVd926gJ9lIGxLUgP2kzQuCpgAPjbA7ZF8fnK1e9Yah5c3m?=
 =?iso-8859-1?Q?Cu+afwenevVk3EbcfMq25gYaAdvkpAxBXRCYV8y3tGMT8FNZJdz8QKVtq8?=
 =?iso-8859-1?Q?mlr082LJ2BBRCuZVQ9btZCml1naPULHCqeyy4BhduZY+OGRuMDtIxPkDWW?=
 =?iso-8859-1?Q?sEpvlmX8S8l3brc+khDJnZdNf+7DMYKbfB0YpmW3nEYUpstK8K7F+SyxTn?=
 =?iso-8859-1?Q?zgMNBeVCuffxqkx3DoE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915eb405-7b6f-479a-510f-08dde9425fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:02.3510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z5XAPlvfA8/lVVHys2i/9fk/VEXJuYupP7kV7gW0dXJAFXleP5weWli/AG8JERJLiAJyfAoms5ScJmxSC88gChVDzrKBZHO603mB7wlL/g=
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5f610a894f..2400623982 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3280,6 +3280,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

