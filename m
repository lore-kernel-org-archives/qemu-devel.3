Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F13CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97k-00054E-L1; Sat, 18 Oct 2025 11:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97j-00053g-Fj; Sat, 18 Oct 2025 11:45:39 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97h-0001Rh-TP; Sat, 18 Oct 2025 11:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxjO13GOkCZctERn/J7tKvC3AsOTtQzsDMQa2tvEQ6zkHa2ekG22W5hZ4OgKtdhGDqMsPehx1GXijnNLOa8HkINpm9QpCyISZ1wTIYOT2dabzkAVQAgiBOkhMUTcCCmy+gIr1clrKtWlz96flduiETG4EQq2d318s2Iomu2iUvCIK5wwClllbqezYqPMAmI5fxwij5i1b+VdR4IW9+Wy96l+piJRHaSWSuZgB/j+l62BPHdC+gKt3I+xeTIhhQS5ST9tv93fq0VCsU69v0HYmW5d0gchGKGmQ4gS1U37MqF3xml8UbKcUMObjHLhCG0lBEDJN/PWvd1OV0nYiDzsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=T6lRZVS8q7torqXk2jB8xrgQcBPkGkVgjMckAnZg3z/8/6iaoIFU0rszWDP6Olzsx6RjZ0c8/35wg9C7HhnR3W+53ySKcHRCK8zas35mxYKQOXCLJZPCNGUjLDWL4d0Yxp0i45P5r9XAinMH/E4VJhTKe3iCMAyPF2M+SyO44Do3JnvpxUfxrv8WzonzqsC0E5jXVSdzpPeodMk4kr7cvFK4X5U5x8K4NZBQfjfMKBfqjbB2H9buONWL8EAKpAr3Fkl0boo+chpaaBRSCDnJRDP/1g95wikVEHsxc1YltkOKBwEa5fFS6sXzLjvyvVqO7ce2qvT9pXA3jfjrMfiQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=M6oBhMD5wRA7Z7zKCSpwcHIlc0LoCYuZLgF92OQGrF7OqqkUHyJv32mO363HE15Kfc0WhtEcSVFX/7Vwh8eH4GWu5CABQJNdGdMES+t6PT5fc9R/lBrX5+JelP293ht8WscU3d9bJqzmqet/i52v/WB7UdIX7iKESRTtPStgP+6DVqtoAIi1nwLHwxvW7/QiuPTEkqkS2jC0M3sUmHlY4JK/sm3TD1rcX402ZWRX5BBAbKriHQIS85G6nSy6WCVeifFp+DFcEc2uAxWPRT5OolddWx3xYT+ANis9wRZdpeb0WAdIIfWaA8kEWmvIoMbiMwkwap6U7QtBdax2gJ+d1w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:29 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:28 +0000
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
Subject: [PATCH v13 02/13] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v13 02/13] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcQEY6y4i7j1Fe70uSSzIHQDb6dQ==
Date: Sat, 18 Oct 2025 15:45:28 +0000
Message-ID: <20251018154522.745788-3-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: 30366e3f-992c-476e-5d88-08de0e5d5d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tPyNGnYXNMB5mlNeS0zAWqDUYCJA8S56Q5usn+x9l5OK9ARm8VW3cuj0Wy?=
 =?iso-8859-1?Q?lxiAX2uPJ1MHtKGuMZ6qhKnN439jicFXhijxP9cgGW6PULQ+qPVEihGoWN?=
 =?iso-8859-1?Q?o/iu1dPcPap5vMmVxREUbhJ7JS2zkuJPdxv67c3gDf6WIlW6saNCx8cCu5?=
 =?iso-8859-1?Q?FmA2pb4/B1xljMwoHEf0u0PUgiGcxPUsqo/3G37TO7JRF5ce0lY4eu9lBm?=
 =?iso-8859-1?Q?E9FyamvUEEs6oE+wxoIDFQlCAQxcpAInz1htngiJtfHuPeBLD4h34aXYxy?=
 =?iso-8859-1?Q?J+8cVY6H1l0jj6ZHzUPFCzE8gdK3AGN5E4X4JMlhDsMsgPCKSjtdznhB8X?=
 =?iso-8859-1?Q?42rEWxhDquolQSWVS3/PAmSMeuZACXnn30/hZjTC8vMddToT2dPllwASj1?=
 =?iso-8859-1?Q?bWxbEs9IaODt9AjXPGSJfnWYsJmYKkA1d5vWikZpIGDZiyPcD1vXealYG4?=
 =?iso-8859-1?Q?7EjUQQAb7XYKvmh0LQ15Y1cQi0pV39swn0kWiCQo5hBBfkf7BwIZS6GqBZ?=
 =?iso-8859-1?Q?s4n61CTeVwc2cZ2X+Al/Sn/X6nQTJGc6/Db9l76aLw4qVZexjWm9taKUDk?=
 =?iso-8859-1?Q?9ICoRmiAMheHJCqz44EkMp32nxXKHQmSSw3TW5qhgvp5uGi5khJ6kpW5Vf?=
 =?iso-8859-1?Q?B1MUTnGTAZXwXf6NYWsRpacteKcRd2Y7fguQSzUKGc7K0nJy+NFsruOiZP?=
 =?iso-8859-1?Q?mq0NuVWAT8cIX7j4ROroEdYEEePCnXkZBXLrf0SDhjyjzt0dVwvHPh1hWL?=
 =?iso-8859-1?Q?2sRQKTXLmNcLdL/0a3k8wRA3ktuwdbs2z186LGxhJwFTy7Y10HDI2+6Gbl?=
 =?iso-8859-1?Q?Zn95kACP2Mun9XINgcTk2Tr1tjDWPCrWIlocRLMRb1J5oA3dAUfEb1C7cX?=
 =?iso-8859-1?Q?JhwDnf2F2FSOQtTbR0biW0zei734r87+CMrIV6zkh6zjsUcoql4Y7183jg?=
 =?iso-8859-1?Q?kOv2Q+Kup3f4fbksaRiDBUpfeBrF9ANiRMbABeuNOhzWE+OHetfxuDFdes?=
 =?iso-8859-1?Q?xiRfo+t0xxaPOQz+mw3vg449d8BmB4ExW1xPQxh/NEGvHTwxQ2DxgAYYxO?=
 =?iso-8859-1?Q?+V/rZBUdVYE3Z/MihJiR/NpsFvLDmtJFk18JA5pjm0J4r1JYsTQR17wSGH?=
 =?iso-8859-1?Q?7dnCm2MAblEf8hdsPrGLkVJSgwmUbjiACpW+kg5JTRhtqUApe33o35OXEJ?=
 =?iso-8859-1?Q?mlj40/1871QgJtlr1kUguGkXFShyVvC8mtadxSUgAAuc1YBh/CUuXn/X5/?=
 =?iso-8859-1?Q?aSyWCqmftIT3pF7ff3kEkNDr0+fl/PLHM0JU8dOejVNXRk9oWB5CSj1LdI?=
 =?iso-8859-1?Q?H6OFD8MJJOUCQl+vjnWMVnkucRCi0xOZK5BNATu9gbGJxylk91vi+NpWBF?=
 =?iso-8859-1?Q?fPXz+mCFOYTyjPgbIthH/6mcsfvjU7461gCRmEEwhdET6Amf3DNjtIGtQX?=
 =?iso-8859-1?Q?rKxvFKJPuZQtZLCgtqAz0zcfVzA50OXS1jCwdYdA1R6/ikSvq6lgR4xjdi?=
 =?iso-8859-1?Q?K8zd1iP5Wm5MqqKEqINELZps8hSTRJYCnosb+SVjBXexBl1K+TrvNOMMtN?=
 =?iso-8859-1?Q?cYFVarpqao8v8Oub3SX7NQz1oTuu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L+ufq8exwv+WG0b6GPR3Sz3isVTKdbQ6jb+aRy5KEW0dqdc6mywPY7umzX?=
 =?iso-8859-1?Q?k1bdWyV8kLwO8hIo318iE5w3BMW22nQsoDJ5piu8I1GW+DErJVVWAwenEA?=
 =?iso-8859-1?Q?WM6lfrdKNoKyF4PRiB5p1S2aTyP8aCIFEUCU1H85GlR8ayTG4E4UrfGhTo?=
 =?iso-8859-1?Q?1QBRk930elJ0YNFKaOmIYuE0sFRbKj+ib3nag+n1WTTw3hUGcujrLMhFTY?=
 =?iso-8859-1?Q?EdgCSqKIG3GyJYIkKtAC7xBGgA9PHitOWTh3dYQIMfX9eQnL+CXofkC5GK?=
 =?iso-8859-1?Q?CnxxRsNyowZdS9L45Pg2+mb4lCqK9kaWXT7jd7Dzwmm+jBEXicHczAlIQu?=
 =?iso-8859-1?Q?GzUuwmeIK7dFsnoYdKx39V7YUA9hWACLhtfh+cLiOog0iGLCVruu0C6fow?=
 =?iso-8859-1?Q?YZGEElXWgRMeUHP61/GIhjHl9BBqEfEX8X5NwScfIujYNC4/MeGBVuCqzt?=
 =?iso-8859-1?Q?BrX2TOxz56B8/Ne130bpgbABzTNPCztHh7/lg9qGPMkRoL4UspFQF6MFk2?=
 =?iso-8859-1?Q?5YhgFcCqMTFEwWP1K2gLBU1iFuChvhbTn9VZoKxJAhN66juEGWA8dSOwON?=
 =?iso-8859-1?Q?dgOScF/jj66P8k09mWnPRhzYgMbS0JmVkkI+umkvnkaCN7NmVnaAXNO5vl?=
 =?iso-8859-1?Q?0k+WIhnS6Z7ojWsSH2eNpaH2mYPdy+RnivUdW4H6JUdwt8rr1mRHdf+GM+?=
 =?iso-8859-1?Q?nczq10hYgZQwsLE+DzCzRpemOlbFBTCX7Ci7HF/EckppyJIZPWVzfuWX7H?=
 =?iso-8859-1?Q?wD5ssQ62QeQzRtRLtDjrLzVN+sjbiShEfRqL8fubDFOr0O5xLKfl4bjTFT?=
 =?iso-8859-1?Q?bAh9ti1uhKY1fvIzZ5QE5ua5pKWd3vKr7ZqeshKMswYO0gYZw0UqZJUBC7?=
 =?iso-8859-1?Q?po523l126OoyFA0LeKMEqgIGKsvVUPpL2s3qlhhmcMmNhsKj5ryuC0Dbbx?=
 =?iso-8859-1?Q?kr/TEOhiMRiDnYLTZbs+5iWa6EIIRNAKNVimWqmM93SZWyjdKRbNUTpDHn?=
 =?iso-8859-1?Q?szdO49Trf0FiIljiT6VqN64zU0m1QY8FDd7F21EQjVCwx6ROaHfc2mjB+k?=
 =?iso-8859-1?Q?FStgKskvDrrsfVW7Fhpt6WLFV/0+eO06vspESkhhn1GP+Mff8PplPoegjq?=
 =?iso-8859-1?Q?U5efZMzjGwPkGWj/RpSf25xTCyqa0Hg56HHLcwkE/g26H8Kbjksw3C/sx4?=
 =?iso-8859-1?Q?4CwdY/ikTSnNcPtKSXKbj7UqTQDXzRFzwXBmpejskBKgX+c26Wurof8+WK?=
 =?iso-8859-1?Q?FRCRYmfqLq39QKBf6r1JXMlaZ3zfch7ntLa0TpUD2leUNYauD01xIHhKOh?=
 =?iso-8859-1?Q?nLtvMSkdiCErnRxCamWOQ9TFENCYm0hLAjy70TkQzoPvitavroXDVsIDbP?=
 =?iso-8859-1?Q?lInttXU9GziZ/k6b99uDFqF3VY9yWk2V0Ec+g8zrHm2R4A9XeT9Ekft93T?=
 =?iso-8859-1?Q?ZNNLz5NQOmCswWzqDychENb1pCa1NNoe0KyzWnD3glel7Wmez4QebfG1hP?=
 =?iso-8859-1?Q?YI4ssLBGgywkJUjzxDvoYNaI0rTpwHYzf2+Mfn6sb8PaleKBROCLbyagfw?=
 =?iso-8859-1?Q?xUTIKYz9Hrdog5Ac6APfz59I/nZ0EwEtb7EfC/24UN7NU499lZfNh27VxC?=
 =?iso-8859-1?Q?x1tSBblGbPv3rT48zESlCflbiDB0DhgfxavDgADy3JLI4aWYZr2Gt5wvIN?=
 =?iso-8859-1?Q?6eiyTsVs7ybCw1yvRfw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30366e3f-992c-476e-5d88-08de0e5d5d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:28.5875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oXMlXaWwBSVADMS2GMqLDe/LEmseeGZk/UaWPuXfk2ZtA3HMgEgjPvR6tiZZWRcpE+eoPi8dwqOp/6vzSaSRfUjnIDBpn3SUunJYKEwUrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

