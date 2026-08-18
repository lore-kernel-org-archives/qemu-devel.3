Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABB3C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCyQ-0003Es-0Z; Tue, 18 Aug 2026 02:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saini.ranbirs@outlook.com>)
 id 1wwCyO-0003Du-BI; Tue, 18 Aug 2026 02:06:56 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saini.ranbirs@outlook.com>)
 id 1wwCyL-00008i-DQ; Tue, 18 Aug 2026 02:06:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDY8zWk5OOeihTZwvmms4ivCP3tK96wCRKIvjKlraClYxkPLJ+JwE0RNBbq1w5RbyfhDSsXF50nzZW45KOqwGtDMFtUPcPqVrHtWTr0eYIz8qETB5e4Ihe107tpgLKJqtoaiSUucBZUQ4IN6jzc4wMJYdldiD8POgEDEW2gpfB99NQI+Jfw0u7vvLCCQ8m5IjTw4n/SASZ4m76KcZk+cHGvgBICoJ4ROCSWiQg197rGutaATF6JCxCDdOIs7l05IfYoEd1hILeSFlxEKAGqzX9e9NFJj/E1MhDUxR4Rvyp9de/bMQetuxF9/V97Fzjjw+0zssc+vMqKMVc1YqJRfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3NlG8AJ7vqNx0kjglmGEm+NhxhijFOmAY5P3jIfGYc=;
 b=DTl0BB2H922/vClg/lFcPCLsBuYHk5jWPZYaGb7zmg+9tXdIESs+Zw0ZmpWFbK1SN7jWcKz+D0u3eJ8FY3TjoO2OHga+QIe+6vv558f9W0ZXd1nuiF1sLhpX54vIN+lbKD2ezECXonhQmI1AorThyZ6gzf2aKWkSrLk+XEc/CA8aIpj3vlOXdW4/Eh0JnESJuXvaFIOL/YaazYgVbG6nirohu95HOVdvsRjhPRHth0vRB5VKRhJ3vjiu/bbT2p+nYWZkYmxj45xjmbspCwr4YiptjTA6I/5oOVqbdbEx6jt9QnVUzHjFHP17ZSL8YEz4ER70/oshWSnSp7oLobG7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3NlG8AJ7vqNx0kjglmGEm+NhxhijFOmAY5P3jIfGYc=;
 b=jKYFND9KJvDbvyCTYk0gzJfAbHxit5oFQ5CLSgklVwNOuPx5b1tRSATzEXRlVHKS7dV9Pc9VpJhMaKpeXxqbLk5b2in6FxWVzXMycc6XdjbRpr6DJZOv2qguvYRJ79WdbiC9sTxddqM8S2Akg95mA+FagVRpYcxyiWUDY7NA50WbGLub0zb1f40JOQAMilrMgyJQWmfaaTmVeEWkpZUqTAZstIabtylXDSwkQpl8c8/qRGqidlIb47c3EJo4b08q0LlaaqqnfKtJTpYQsf1HUvY4eLWRHo1jZWGXJwyN6eKwuT3h4ygKJj+I+Ux4jyzyPxa5BmLddeWIRs9lhSuluQ==
Received: from TY2PPF45B8CB2DB.apcprd03.prod.outlook.com (2603:1096:408::9d0)
 by SEZPR03MB7592.apcprd03.prod.outlook.com (2603:1096:101:12b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:06:46 +0000
Received: from TY2PPF45B8CB2DB.apcprd03.prod.outlook.com
 ([fe80::9f85:6f19:548a:7ab3]) by TY2PPF45B8CB2DB.apcprd03.prod.outlook.com
 ([fe80::9f85:6f19:548a:7ab3%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:06:46 +0000
From: Ranbir Singh <saini.ranbirs@outlook.com>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu
 <chao.liu@processmission.com>
Subject: Re: [PATCH v9 05/10] riscv: add RPMI system reset service
Thread-Topic: [PATCH v9 05/10] riscv: add RPMI system reset service
Thread-Index: AQHdLjdINe23vcddCUC9XNFoea8dSbajUvDM
Date: Tue, 18 Aug 2026 06:06:45 +0000
Message-ID: <TY2PPF45B8CB2DBC8E1E6080020BC2FC09EF9A62@TY2PPF45B8CB2DB.apcprd03.prod.outlook.com>
References: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260817105505.2607506-6-subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <20260817105505.2607506-6-subrahmanya.lingappa@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF45B8CB2DB:EE_|SEZPR03MB7592:EE_
x-ms-office365-filtering-correlation-id: 79590730-9258-4128-042d-08defceee22d
x-microsoft-antispam: BCL:0;
 ARA:14566002|8060799015|8062599012|31061999003|41001999006|25031999004|24021099003|21061999006|19110799012|15030799006|15080799012|51005399006|25010399006|4140399003|40105399003|2607281247196008|12091999003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rjDp2GFdDiunQ62JE9/JX+E2YFCuEuRxgrw1+38dyf4N7cO0L0WL/e2Jw9?=
 =?iso-8859-1?Q?FCN6LtFF9IqWXKU/TzO7AnwDws+byi/7KXevzDJgqKMZhbZL3wQihd+Nh8?=
 =?iso-8859-1?Q?NES41vh+He0xnEAlqmUS8YmB6YPljpXZ/Sce2Rsu/ZP5YiGU5QY26nEej5?=
 =?iso-8859-1?Q?gzJqTCh0gYztWIXDqAzXANzWqgXL8FtYaysPYqJqmr4ZBXgTKIUCRrRfID?=
 =?iso-8859-1?Q?NYZCkwaeBZ+uQsGs+GSXUSxtFR7OploQv0JHuYVRK6eOq77ybfSk23DEE4?=
 =?iso-8859-1?Q?uFsWeY2uqNHlKXKgDTSVfs8m70ZKOT4xRikwuDSMUznDP78rUr2jop8kZW?=
 =?iso-8859-1?Q?t/lmPS30XtY87my0Kl/uW4TpDuSJ/lERyRCePEW9pYreFCthKAvYYnD6a1?=
 =?iso-8859-1?Q?cHx98utVa4DSRBO/uekDB9UnLHd+u2iTQfE6/zbgsFc6nbZkizYRtaIN8/?=
 =?iso-8859-1?Q?vYBrxqkQVl1zprxvudJdVswi+8zp11AvwQEeE37UEow4E7OcSG68V0TTPn?=
 =?iso-8859-1?Q?GxBAmAVPGDVrcQmqg+22AG148OHgtzjWFAq9ttogEFYN4qWDs0a4RaX5ZU?=
 =?iso-8859-1?Q?oECd0LkBHzTR8PzlJJWWIXfSneLwCEd1Lh8bnYwALHxrS6zPWVyt9gWm0I?=
 =?iso-8859-1?Q?6BTi0DJ9+beg468Vq0VEMrwQadSUvNy6jnd+tTt0Avfl9KHcuz75/0uQZt?=
 =?iso-8859-1?Q?RHeHJ3lKeEEdz1TPiW4PpMwqVLLGQi6WoYzm5O8nXcauC8cfj+al0z7/Zd?=
 =?iso-8859-1?Q?ZCk6eHvWapsX/uG8E49S7UT7jFdOT+/K30GeRdL/73rAC4+pAlySOrZ8og?=
 =?iso-8859-1?Q?b3K7l2QT5vHyllvbHKuile5hhEMUgP/C9BE5a/ib2iyQBY54cF2uXLPhB2?=
 =?iso-8859-1?Q?XJs20cR+dqJL1iukgk/47xHwPUZq/6SCeJx9I/ooBF7MgQVGD8rSJ14yRT?=
 =?iso-8859-1?Q?skLdWKnj1cfMUx3B+eMbCwlJ2o+CFPPS8CDCG4ds8xvOel+H2wL83ScArZ?=
 =?iso-8859-1?Q?COdgLGzMiFZVvBV0+FDngywOsgZX4RvE7YasiR7IbvP5+mS4ipmfO94Oys?=
 =?iso-8859-1?Q?G3kxAv4FRNTak3V3008GrGqSM3K9wyLoynWfxCBl3jDU1X+T39LZGELuY9?=
 =?iso-8859-1?Q?hkKEfOEJM4LwWWFgQlCGl8o0b+U+Y=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DRgNH4PyG4SSUK3lO84Z0KPa5BywntQRy9efh79PnUiXnz1YLgxanbh6DX?=
 =?iso-8859-1?Q?lKSMokKWfaD0efI9uIjjuxPZluRkVWV3hagJFWmQ5P2omDK/2wZ+bgptC7?=
 =?iso-8859-1?Q?NSvoktXHqxIJFEbMO5Wexjh4cWyFmEVBixmAjZZAROTjLQBHrvvFv42n7g?=
 =?iso-8859-1?Q?S7+jgO7P3RfSze6IJQDq8AeWZEl54vyJrKyDCnqu+A6aLUfxVUEMVHyluF?=
 =?iso-8859-1?Q?Y2dQ7f+JQAGNy9YDfRgUWIkLH43DWhcGZ2LUcmAJ3FrHnYOixB+G79gq7k?=
 =?iso-8859-1?Q?R2Cb+0yExzrGLGYJHVINjzSfc0vJfi4FaMkhKwb8siq3P5cyJBV5JFM9dn?=
 =?iso-8859-1?Q?K2x/Cb2zO6zpgFfQUBliux55neg648uj8bqopOMTYBoihP7QExad/PDTPy?=
 =?iso-8859-1?Q?AduIG9GSrBmJzC9iIFCAwbrYz2nFLMLKM/3hK8n17d0rqs7TGrAZswZHN2?=
 =?iso-8859-1?Q?HkiD3s3/wPEQ454tskzG1JGffhJCZFWOzvbqSwLvDBmYHzNvLaRI3zBoj4?=
 =?iso-8859-1?Q?qGFAEn93RoySq8h/fnvaYGkKy3FFnX4qRueQojaQ+tAdSepgzeJJm1DnPB?=
 =?iso-8859-1?Q?vua08giIYUmfoV3rQQ/xuh1UAvaSrvuqOZ6vHlI1hzuegdQeaao1pZM3bt?=
 =?iso-8859-1?Q?Kn6Yo+rgH33f7za0WSymAhjaIv91kclSLdbkWcnlDACabDRpssDz0Vx3NU?=
 =?iso-8859-1?Q?YHE1uyBSUThI5QGDn7xMuLWa7+Vq1npHlE9QwY0wTqTCToCJMCYnvHbxVL?=
 =?iso-8859-1?Q?MtBzVNfI9eqSvd2kZ+qxXgs8fJrGoZ2V+7GaEj0hTlfKrccXaC+3qyetZ8?=
 =?iso-8859-1?Q?TUbtcsa4vgjXrnPobNPpb6iIsZU80MCtgQtNBaO2p+H7JS5boFv6y9FMTh?=
 =?iso-8859-1?Q?PdGN59ZmmOvVjzkm3EB6Ccqpo01+eQLsY6GaUxgGcPGqubWcqiKXAYJu52?=
 =?iso-8859-1?Q?DIxlMIvgYj39/RDo6MfASVO56dHQKsBYGOC53e2NDc5Y1qNXjfoYL3Dz+L?=
 =?iso-8859-1?Q?jDuqusdX0Kv6uemm0eRhKnOxEJTlAHEwhg407jcjexIrN8SQwdYTTZO64A?=
 =?iso-8859-1?Q?AasgYOLbAqCRIj6WGYLdpc0creGyoP+up0uFo4jd7G14wdZ16DmMpwZKSK?=
 =?iso-8859-1?Q?YwftDaxZIBeYGbf8g+Pqw/m+PZoXY9RoV6+8yjmv1AfVbJoEH3+1vZQrfT?=
 =?iso-8859-1?Q?9EoeLW4FHA1p7c9SBKoTmKFmwkJ2zSyN+igW2FkKi/UGoHIzCcj0ToVnM1?=
 =?iso-8859-1?Q?pgO1j5QCPrxTPkaKerenydx4IdUBw5hYiKQk/HfnaiCLfG7/NjNoU4gISW?=
 =?iso-8859-1?Q?r7Qe8ZrDMvSbscjVBLTBP3r/5t1OvdYwL2TkEPt89mSofkGbY/DllX1C+P?=
 =?iso-8859-1?Q?budwdk/NEr4B48dWOo6xUovYHckWqSeKTPLHRu+ZsyVcgc+s+lZeJtFwBo?=
 =?iso-8859-1?Q?dta8AEJ2AHfCl+EF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF45B8CB2DB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 79590730-9258-4128-042d-08defceee22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 06:06:46.0181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7592
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=saini.ranbirs@outlook.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

=0A=
=0A=
=0A=
________________________________________=0A=
From: qemu-devel-bounces+saini.ranbirs=3Doutlook.com@nongnu.org <qemu-devel=
-bounces+saini.ranbirs=3Doutlook.com@nongnu.org> on behalf of Subrahmanya L=
ingappa <subrahmanya.lingappa@oss.qualcomm.com>=0A=
Sent: 17 August 2026 16:24=0A=
To: qemu-devel@nongnu.org=0A=
Cc: qemu-riscv@nongnu.org; Subrahmanya Lingappa; Daniel Henrique Barboza; P=
almer Dabbelt; Alistair Francis; Weiwei Li; Liu Zhiwei; Chao Liu=0A=
Subject: [PATCH v9 05/10] riscv: add RPMI system reset service=0A=
=0A=
Add a QEMU implementation of the RPMI System Reset service group.=0A=
=0A=
The service advertises shutdown and cold reboot reset types, validates=0A=
guest requests, and dispatches accepted requests through the machine=0A=
reset and shutdown callbacks. This lets firmware use RPMI reset commands=0A=
while keeping the board-specific reset policy in the RISC-V virt machine.=
=0A=
=0A=
Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>=
=0A=
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/meson.build           |   1 +=0A=
 hw/misc/riscv_rpmi.c          |  70 +++++++++++-=0A=
 hw/misc/riscv_rpmi_internal.h |  12 +-=0A=
 hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++=0A=
 hw/riscv/virt.c               |  51 ++++++++-=0A=
 include/hw/misc/riscv_rpmi.h  |  15 +--=0A=
 include/hw/riscv/rpmi-fdt.h   |  11 ++=0A=
 7 files changed, 349 insertions(+), 17 deletions(-)=0A=
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c=0A=
=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index fb761f94b3..f8a317b8f6 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -173,4 +173,5 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi=
.c'))=0A=
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))=
=0A=
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(=0A=
   'riscv_rpmi.c',=0A=
+  'riscv_rpmi_sysreset.c',=0A=
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))=0A=
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c=0A=
index 8598a3f133..97517766e9 100644=0A=
--- a/hw/misc/riscv_rpmi.c=0A=
+++ b/hw/misc/riscv_rpmi.c=0A=
@@ -171,10 +171,37 @@ static bool riscv_rpmi_transport_indices_valid(RiscvR=
pmiState *s)=0A=
                                           s->a2p_req_size);=0A=
 }=0A=
=0A=
+typedef struct RiscvRpmiServiceOps {=0A=
+    uint32_t service_group;=0A=
+    bool (*add)(RiscvRpmiState *s, Error **errp);=0A=
+    void (*remove)(RiscvRpmiState *s);=0A=
+} RiscvRpmiServiceOps;=0A=
+=0A=
+static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] =3D {=0A=
+    {=0A=
+        .service_group =3D RISCV_RPMI_SRVGRP_SYSTEM_RESET,=0A=
+        .add =3D riscv_rpmi_sysreset_add,=0A=
+        .remove =3D riscv_rpmi_sysreset_remove,=0A=
+    },=0A=
+};=0A=
+=0A=
+static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_group(=0A=
+    uint32_t service_group)=0A=
+{=0A=
+    for (uint32_t i =3D 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {=
=0A=
+        if (riscv_rpmi_service_ops[i].service_group =3D=3D service_group) =
{=0A=
+            return &riscv_rpmi_service_ops[i];=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return NULL;=0A=
+}=0A=
+=0A=
 static void riscv_rpmi_configure_base(RiscvRpmiState *s,=0A=
                                       const RiscvRpmiConfig *cfg)=0A=
 {=0A=
     s->platform_info =3D g_strdup(cfg->platform_info);=0A=
+    s->machine_ops =3D cfg->machine_ops;=0A=
     s->services =3D cfg->services;=0A=
     s->service_count =3D cfg->service_count;=0A=
=0A=
@@ -211,7 +238,9 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetTyp=
e type)=0A=
=0A=
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)=0A=
 {=0A=
-=0A=
+    for (uint32_t i =3D ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {=
=0A=
+        riscv_rpmi_service_ops[i - 1].remove(s);=0A=
+    }=0A=
=0A=
     if (s->context) {=0A=
         rpmi_context_destroy(s->context);=0A=
@@ -234,12 +263,12 @@ static void riscv_rpmi_cleanup(RiscvRpmiState *s)=0A=
     }=0A=
 }=0A=
=0A=
-bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind ki=
nd)=0A=
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_group)=
=0A=
 {=0A=
     uint32_t i;=0A=
=0A=
     for (i =3D 0; i < s->service_count; i++) {=0A=
-        if (s->services[i].kind =3D=3D kind) {=0A=
+        if (s->services[i].service_group =3D=3D service_group) {=0A=
             return true;=0A=
         }=0A=
     }=0A=
@@ -247,6 +276,30 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s, Ris=
cvRpmiServiceKind kind)=0A=
     return false;=0A=
 }=0A=
=0A=
+bool riscv_rpmi_context_add_group(RiscvRpmiState *s,=0A=
+                                  struct rpmi_service_group *group,=0A=
+                                  const char *name,=0A=
+                                  Error **errp)=0A=
+{=0A=
+    enum rpmi_error rc;=0A=
+=0A=
+    rc =3D rpmi_context_add_group(s->context, group);=0A=
+    if (rc !=3D RPMI_SUCCESS) {=0A=
+        error_setg(errp, "failed to add RPMI %s service group: %d", name, =
rc);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+void riscv_rpmi_context_remove_group(RiscvRpmiState *s,=0A=
+                                     struct rpmi_service_group *group)=0A=
+{=0A=
+    if (s->context && group) {=0A=
+        rpmi_context_remove_group(s->context, group);=0A=
+    }=0A=
+}=0A=
+=0A=
 static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)=0A=
 {=0A=
     uint64_t queue_bytes;=0A=
@@ -318,11 +371,16 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiSta=
te *s,=0A=
                                          const RiscvRpmiServiceConfig *ser=
vice,=0A=
                                          Error **errp)=0A=
 {=0A=
-    switch (service->kind) {=0A=
-    default:=0A=
-        error_setg(errp, "unsupported RPMI service kind %d", service->kind=
);=0A=
+    const RiscvRpmiServiceOps *ops;=0A=
+=0A=
+    ops =3D riscv_rpmi_service_ops_by_group(service->service_group);=0A=
+    if (!ops) {=0A=
+        error_setg(errp, "unsupported RPMI service group %u",=0A=
+                   service->service_group);=0A=
         return false;=0A=
     }=0A=
+=0A=
+    return ops->add(s, errp);=0A=
 }=0A=
=0A=
 static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)=0A=
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h=
=0A=
index c263033634..ca9838d256 100644=0A=
--- a/hw/misc/riscv_rpmi_internal.h=0A=
+++ b/hw/misc/riscv_rpmi_internal.h=0A=
@@ -18,7 +18,15 @@=0A=
 #define RPMI_PLAT_INFO "QEMU RISC-V RPMI"=0A=
=0A=
 extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;=0A=
-bool riscv_rpmi_service_enabled(RiscvRpmiState *s,=0A=
-                                RiscvRpmiServiceKind kind);=0A=
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_group)=
;=0A=
+bool riscv_rpmi_context_add_group(RiscvRpmiState *s,=0A=
+                                  struct rpmi_service_group *group,=0A=
+                                  const char *name,=0A=
+                                  Error **errp);=0A=
+void riscv_rpmi_context_remove_group(RiscvRpmiState *s,=0A=
+                                     struct rpmi_service_group *group);=0A=
+=0A=
+bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);=0A=
+void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);=0A=
=0A=
 #endif=0A=
diff --git a/hw/misc/riscv_rpmi_sysreset.c b/hw/misc/riscv_rpmi_sysreset.c=
=0A=
new file mode 100644=0A=
index 0000000000..775eb5483f=0A=
--- /dev/null=0A=
+++ b/hw/misc/riscv_rpmi_sysreset.c=0A=
@@ -0,0 +1,206 @@=0A=
+/*=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * RISC-V RPMI System Reset service.=0A=
+ *=0A=
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.=0A=
+ * Author:=0A=
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "riscv_rpmi_internal.h"=0A=
+#include "qemu/log.h"=0A=
+#include "librpmi_env.h"=0A=
+=0A=
+typedef struct RiscvRpmiSysresetType {=0A=
+    uint32_t type;=0A=
+    void (*action)(RiscvRpmiState *s);=0A=
+} RiscvRpmiSysresetType;=0A=
+=0A=
+typedef struct RiscvRpmiSysresetGroup {=0A=
+    struct rpmi_service_group group;=0A=
+    struct rpmi_service services[RPMI_SYSRST_SRV_ID_MAX];=0A=
+    RiscvRpmiState *rpmi;=0A=
+} RiscvRpmiSysresetGroup;=0A=
+=0A=
+static void riscv_rpmi_sysreset_reboot(RiscvRpmiState *s)=0A=
+{=0A=
+    const RiscvRpmiMachineOps *ops =3D s->machine_ops;=0A=
+=0A=
+    if (ops && ops->system_reset) {=0A=
+        ops->system_reset();=0A=
+    }=0A=
+}=0A=
+=0A=
+static void riscv_rpmi_sysreset_shutdown(RiscvRpmiState *s)=0A=
+{=0A=
+    const RiscvRpmiMachineOps *ops =3D s->machine_ops;=0A=
+=0A=
+    if (ops && ops->system_shutdown) {=0A=
+        ops->system_shutdown();=0A=
+    }=0A=
+}=0A=
+=0A=
+static const RiscvRpmiSysresetType riscv_rpmi_sysreset_types[] =3D {=0A=
+    {=0A=
+        .type =3D RPMI_SYSRST_TYPE_SHUTDOWN,=0A=
+        .action =3D riscv_rpmi_sysreset_shutdown,=0A=
+    }, {=0A=
+        .type =3D RPMI_SYSRST_TYPE_COLD_REBOOT,=0A=
+        .action =3D riscv_rpmi_sysreset_reboot,=0A=
+    },=0A=
+};=0A=
+=0A=
+static const RiscvRpmiSysresetType *riscv_rpmi_sysreset_type_by_id(=0A=
+    uint32_t reset_type)=0A=
+{=0A=
+    for (uint32_t index =3D 0; index < ARRAY_SIZE(riscv_rpmi_sysreset_type=
s);=0A=
+         index++) {=0A=
+        if (riscv_rpmi_sysreset_types[index].type =3D=3D reset_type) {=0A=
+            return &riscv_rpmi_sysreset_types[index];=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return NULL;=0A=
+}=0A=
+=0A=
+static void riscv_rpmi_do_system_reset(RiscvRpmiState *s,=0A=
+                                       rpmi_uint32_t reset_type)=0A=
+{=0A=
+    const RiscvRpmiSysresetType *type;=0A=
+=0A=
+    type =3D riscv_rpmi_sysreset_type_by_id(reset_type);=0A=
+    if (type) {=0A=
+        type->action(s);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: unsupported reset type %u\n",=0A=
+                  __func__, reset_type);=0A=
+}=0A=
+=0A=
+static enum rpmi_error riscv_rpmi_sysreset_get_attributes(=0A=
+    struct rpmi_service_group *group, struct rpmi_service *service,=0A=
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,=0A=
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,=0A=
+    rpmi_uint8_t *response_data)=0A=
+{=0A=
+    uint32_t reset_type =3D ldl_le_p(request_data);=0A=
+    uint32_t *resp =3D (uint32_t *)response_data;=0A=
+=0A=
+    *response_data_len =3D 2 * sizeof(*resp);=0A=
+    stl_le_p(&resp[0], RPMI_SUCCESS);=0A=
+    stl_le_p(&resp[1], riscv_rpmi_sysreset_type_by_id(reset_type) ?=0A=
+             RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE : 0);=0A=
+=0A=
+    return RPMI_SUCCESS;=0A=
+}=0A=
+=0A=
+static enum rpmi_error riscv_rpmi_sysreset_do_reset(=0A=
+    struct rpmi_service_group *group, struct rpmi_service *service,=0A=
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,=0A=
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,=0A=
+    rpmi_uint8_t *response_data)=0A=
+{=0A=
+    RiscvRpmiSysresetGroup *sysreset =3D group->priv;=0A=
+    uint32_t reset_type =3D ldl_le_p(request_data);=0A=
+    uint32_t *resp =3D (uint32_t *)response_data;=0A=
+=0A=
+    *response_data_len =3D sizeof(*resp);=0A=
+=0A=
+    if (!riscv_rpmi_sysreset_type_by_id(reset_type)) {=0A=
+        stl_le_p(resp, (uint32_t)RPMI_ERR_INVALID_PARAM);=0A=
+        return RPMI_SUCCESS;=0A=
+    }=0A=
+=0A=
+    stl_le_p(resp, RPMI_SUCCESS);=0A=
+    riscv_rpmi_do_system_reset(sysreset->rpmi, reset_type);=0A=
+    return RPMI_SUCCESS;=0A=
+}=0A=
+=0A=
+static const struct rpmi_service riscv_rpmi_sysreset_services[] =3D {=0A=
+    [RPMI_SYSRST_SRV_ENABLE_NOTIFICATION] =3D {=0A=
+        .service_id =3D RPMI_SYSRST_SRV_ENABLE_NOTIFICATION,=0A=
+        .min_a2p_request_datalen =3D 8,=0A=
+    },=0A=
+    [RPMI_SYSRST_SRV_GET_ATTRIBUTES] =3D {=0A=
+        .service_id =3D RPMI_SYSRST_SRV_GET_ATTRIBUTES,=0A=
+        .min_a2p_request_datalen =3D 4,=0A=
+        .process_a2p_request =3D riscv_rpmi_sysreset_get_attributes,=0A=
+    },=0A=
+    [RPMI_SYSRST_SRV_SYSTEM_RESET] =3D {=0A=
+        .service_id =3D RPMI_SYSRST_SRV_SYSTEM_RESET,=0A=
+        .min_a2p_request_datalen =3D 4,=0A=
+        .process_a2p_request =3D riscv_rpmi_sysreset_do_reset,=0A=
+    },=0A=
+};=0A=
+=0A=
+static struct rpmi_service_group *riscv_rpmi_sysreset_create(RiscvRpmiStat=
e *s)=0A=
+{=0A=
+    RiscvRpmiSysresetGroup *sysreset;=0A=
+    struct rpmi_service_group *group;=0A=
+=0A=
+    sysreset =3D g_new0(RiscvRpmiSysresetGroup, 1);=0A=
+    sysreset->rpmi =3D s;=0A=
+    memcpy(sysreset->services, riscv_rpmi_sysreset_services,=0A=
+           sizeof(riscv_rpmi_sysreset_services));=0A=
+=0A=
+    group =3D &sysreset->group;=0A=
+    group->name =3D "sysreset";=0A=
+    group->servicegroup_id =3D RPMI_SRVGRP_SYSTEM_RESET;=0A=
+    group->max_service_id =3D RPMI_SYSRST_SRV_ID_MAX;=0A=
+    group->servicegroup_version =3D=0A=
+        RPMI_BASE_VERSION(RPMI_SPEC_VERSION_MAJOR, RPMI_SPEC_VERSION_MINOR=
);=0A=
+    group->privilege_level_bitmap =3D RPMI_PRIVILEGE_M_MODE_MASK;=0A=
+    group->services =3D sysreset->services;=0A=
+    group->lock =3D rpmi_env_alloc_lock();=0A=
+    group->priv =3D sysreset;=0A=
+=0A=
+    return group;=0A=
+}=0A=
+=0A=
+static void riscv_rpmi_sysreset_destroy(struct rpmi_service_group *group)=
=0A=
+{=0A=
+    if (!group) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    rpmi_env_free_lock(group->lock);=0A=
+    g_free(group->priv);=0A=
+}=0A=
+=0A=
+bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp)=0A=
+{=0A=
+    struct rpmi_service_group *group;=0A=
+=0A=
+    if (s->sysreset_group) {=0A=
+        error_setg(errp, "duplicate RPMI sysreset service descriptor");=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    group =3D riscv_rpmi_sysreset_create(s);=0A=
+    if (!group) {=0A=
+        error_setg(errp, "failed to create RPMI sysreset service group");=
=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (!riscv_rpmi_context_add_group(s, group, "sysreset", errp)) {=0A=
+        riscv_rpmi_sysreset_destroy(group);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    s->sysreset_group =3D group;=0A=
+    return true;=0A=
+}=0A=
+=0A=
+void riscv_rpmi_sysreset_remove(RiscvRpmiState *s)=0A=
+{=0A=
+    if (!s->sysreset_group) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    riscv_rpmi_context_remove_group(s, s->sysreset_group);=0A=
+    riscv_rpmi_sysreset_destroy(s->sysreset_group);=0A=
+    s->sysreset_group =3D NULL;=0A=
+}=0A=
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c=0A=
index fa0e0db0c3..1a69fd7cfe 100644=0A=
--- a/hw/riscv/virt.c=0A=
+++ b/hw/riscv/virt.c=0A=
@@ -767,7 +767,8 @@ static void create_fdt_pcie(RISCVVirtState *s,=0A=
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);=0A=
 }=0A=
=0A=
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)=0A=
+static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle,=0A=
+                             bool use_syscon_reset)=0A=
 {=0A=
     char *name;=0A=
     uint32_t test_phandle;=0A=
@@ -791,6 +792,14 @@ static void create_fdt_reset(RISCVVirtState *s, uint32=
_t *phandle)=0A=
     test_phandle =3D qemu_fdt_get_phandle(ms->fdt, name);=0A=
     g_free(name);=0A=
=0A=
+    /*=0A=
+     * When RPMI is enabled, advertise reset and shutdown through RPMI so=
=0A=
+     * firmware routes these operations through the RPMI system reset serv=
ice.=0A=
+     */=0A=
+    if (!use_syscon_reset) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
     name =3D g_strdup_printf("/reboot");=0A=
     qemu_fdt_add_subnode(ms->fdt, name);=0A=
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");=
=0A=
@@ -980,6 +989,34 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16=
_t bdf)=0A=
 }=0A=
=0A=
=0A=
+static const RiscvRpmiServiceConfig virt_rpmi_services[] =3D {=0A=
+    {=0A=
+        .node_name =3D "sysreset",=0A=
+        .compatible =3D "riscv,rpmi-system-reset",=0A=
+        .service_group =3D RISCV_RPMI_SRVGRP_SYSTEM_RESET,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint32_t virt_rpmi_service_count(RISCVVirtState *s)=0A=
+{=0A=
+    return ARRAY_SIZE(virt_rpmi_services);=0A=
+}=0A=
+=0A=
+static void virt_rpmi_system_reset(void)=0A=
+{=0A=
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);=0A=
+}=0A=
+=0A=
+static void virt_rpmi_system_shutdown(void)=0A=
+{=0A=
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);=0A=
+}=0A=
+=0A=
+static const RiscvRpmiMachineOps virt_rpmi_machine_ops =3D {=0A=
+    .system_reset =3D virt_rpmi_system_reset,=0A=
+    .system_shutdown =3D virt_rpmi_system_shutdown,=0A=
+};=0A=
+=0A=
 static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,=0A=
                                         const uint32_t *hart_ids,=0A=
                                         uint32_t hart_count)=0A=
@@ -991,8 +1028,11 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtStat=
e *s,=0A=
         .a2p_req_size =3D VIRT_RPMI_A2P_REQ_SIZE,=0A=
         .p2a_req_size =3D VIRT_RPMI_P2A_REQ_SIZE,=0A=
         .platform_info =3D "QEMU RISC-V virt RPMI",=0A=
+        .machine_ops =3D &virt_rpmi_machine_ops,=0A=
         .hart_ids =3D hart_ids,=0A=
         .hart_count =3D hart_count,=0A=
+        .services =3D virt_rpmi_services,=0A=
+        .service_count =3D virt_rpmi_service_count(s),=0A=
     };=0A=
 }=0A=
=0A=
@@ -1001,6 +1041,7 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32=
_t *phandle,=0A=
 {=0A=
     RiscvRpmiConfig rpmi_cfg =3D virt_rpmi_config(s, NULL, 0);=0A=
     uint32_t rpmi_mbox_handle;=0A=
+    uint32_t i;=0A=
     RiscvRpmiFdtMboxConfig cfg =3D {=0A=
         .shmem_base =3D rpmi_cfg.shmem_base,=0A=
         .doorbell_base =3D rpmi_cfg.doorbell_base,=0A=
@@ -1011,6 +1052,12 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint3=
2_t *phandle,=0A=
=0A=
     riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,=0A=
                             &rpmi_mbox_handle);=0A=
+=0A=
+    for (i =3D 0; i < rpmi_cfg.service_count; i++) {=0A=
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt, rpmi_cfg.shmem_ba=
se,=0A=
+                                        &rpmi_cfg.services[i],=0A=
+                                        rpmi_mbox_handle);=0A=
+    }=0A=
 }=0A=
=0A=
 static void finalize_fdt(RISCVVirtState *s)=0A=
@@ -1036,7 +1083,7 @@ static void finalize_fdt(RISCVVirtState *s)=0A=
         create_fdt_rpmi(s, &phandle, msi_pcie_phandle);=0A=
     }=0A=
=0A=
-    create_fdt_reset(s, &phandle);=0A=
+    create_fdt_reset(s, &phandle, !s->have_rpmi);=0A=
=0A=
     create_fdt_uart(s, irq_mmio_phandle);=0A=
=0A=
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h=0A=
index f5fd1ee8c7..a9ccc950e9 100644=0A=
--- a/include/hw/misc/riscv_rpmi.h=0A=
+++ b/include/hw/misc/riscv_rpmi.h=0A=
@@ -27,6 +27,7 @@=0A=
 #define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)=0A=
 #define VIRT_RPMI_P2A_REQ_SIZE 0=0A=
=0A=
+#define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3=0A=
=0A=
Can't we replace the use of these macros with the enum rpmi_servicegroup_id=
 for service_group field in struct RiscvRpmiServiceOps so that there is no =
need to keep adding such #define's for various service groups which essenti=
ally have the same values as that in enum rpmi_servicegroup_id for that gro=
up?=0A=
=0A=
 #define TYPE_RISCV_RPMI "riscv-rpmi"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)=0A=
@@ -36,12 +37,11 @@ struct rpmi_service_group;=0A=
 struct rpmi_shmem;=0A=
 struct rpmi_transport;=0A=
=0A=
-typedef enum RiscvRpmiServiceKind {=0A=
-    RISCV_RPMI_SERVICE_INVALID =3D 0,=0A=
-} RiscvRpmiServiceKind;=0A=
-=0A=
+typedef struct RiscvRpmiMachineOps {=0A=
+    void (*system_reset)(void);=0A=
+    void (*system_shutdown)(void);=0A=
+} RiscvRpmiMachineOps;=0A=
 typedef struct RiscvRpmiServiceConfig {=0A=
-    RiscvRpmiServiceKind kind;=0A=
     const char *node_name;=0A=
     const char *compatible;=0A=
     uint32_t service_group;=0A=
@@ -56,7 +56,7 @@ typedef struct RiscvRpmiConfig {=0A=
     uint32_t a2p_req_size;=0A=
     uint32_t p2a_req_size;=0A=
     const char *platform_info;=0A=
-=0A=
+    const RiscvRpmiMachineOps *machine_ops;=0A=
     const uint32_t *hart_ids;=0A=
     uint32_t hart_count;=0A=
     const RiscvRpmiServiceConfig *services;=0A=
@@ -73,7 +73,8 @@ struct RiscvRpmiState {=0A=
     uint32_t a2p_req_size;=0A=
     uint32_t p2a_req_size;=0A=
     char *platform_info;=0A=
-=0A=
+    const RiscvRpmiMachineOps *machine_ops;=0A=
+    struct rpmi_service_group *sysreset_group;=0A=
     uint32_t *hart_ids;=0A=
     uint32_t hart_count;=0A=
     const RiscvRpmiServiceConfig *services;=0A=
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h=0A=
index b157bda1d1..60c5df75d0 100644=0A=
--- a/include/hw/riscv/rpmi-fdt.h=0A=
+++ b/include/hw/riscv/rpmi-fdt.h=0A=
@@ -26,5 +26,16 @@ void riscv_rpmi_fdt_add_mbox(void *fdt,=0A=
                              const RiscvRpmiFdtMboxConfig *cfg,=0A=
                              uint32_t *phandle,=0A=
                              uint32_t *mbox_handle);=0A=
+void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,=0A=
+                                const char *node_name,=0A=
+                                const char *compatible,=0A=
+                                uint32_t mbox_handle,=0A=
+                                uint32_t service_group,=0A=
+                                bool has_mpxy_channel,=0A=
+                                uint32_t mpxy_channel);=0A=
+=0A=
+void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,=0A=
+                                     const RiscvRpmiServiceConfig *service=
,=0A=
+                                     uint32_t mbox_handle);=0A=
=0A=
 #endif=0A=
--=0A=
2.43.0=0A=
=0A=
=0A=

