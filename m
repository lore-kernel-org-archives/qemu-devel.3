Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA734D185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqGt-0002WU-R7; Thu, 08 Jan 2026 08:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGs-0002VB-1n; Thu, 08 Jan 2026 08:41:50 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGp-0005og-Va; Thu, 08 Jan 2026 08:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWu4DwfIU9ppOgdnGKw+l47SBGz2rqRfsywnML/uUBj3r4nyrqJ9ZMiammJozeCtydBS0HYHDd6dV7OXB4+i92OECnzwVqsvtMr0IXNuM7EQle+1p6IXYQ2+EXmj48PYfSi54AgKQk2koJNnq0p0YX5nFaZu4gChyuISzGiT7KFFmYg2nzezuNB14Vj0Jn8Pn7/Y3VezalXlwFPjrrGYrW8INAWCDcLH2+nYYSPDQ12cKpKADxyAdRCxhY/igbU1AeM/Tg1lIGeuOId0HLvH6C4msS4UqsBa4NGgP+a9AVFM+MZwD7jtOUpQLYaXDEacbILi6CTuNuxjfjgp9dpRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBp/O9YKCAi0Q5s9WfcHNw9esmTefoeAw6a/FzssJVo=;
 b=MSBMMwrmsJE0BBce8AXJCWBw1MYJh3m05DDWLZMuybDA2bMDNIA2jtYz5aC4T4/YcdFS9++dRe+wRjSImWt5NBPr6ZUsV1jNyKXm2UGEAd4m6IXga+9xteNAnnEle5uUbA3gBjQI2uHQeR97a0/U/8TTLPkTyLC9AZrDGIJY+qaL9nLQeBClEa7QJkscxdQXWsVXXIXjrN5+Ehcy8mqTH8sJCFEmomCUqdAXaFYwqHaDVomfIhXATHaExZDwByDAItsJNJg7equRLUQ9ks4kDuv5PW2lDGf/Z9KJV+uUjyzVWjZtcxXpjoCQhjSQ1TBhkcYXpf/GYT4W2Mzm3SJyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBp/O9YKCAi0Q5s9WfcHNw9esmTefoeAw6a/FzssJVo=;
 b=Auv2WAfB5jtN+gt6oFEoqWw4N+/3m1Yl5/IS+OI/LEugcdFIW7ncqWHd83yfRpyQmPktyxzesdL14SLIh/WVec4u/sMmeQXRoYAG2wQ6YPjNBZwNlRHZrnpJELsOPat1wFG6oWR8MYeAk8tMXUteaT0Ny1eXlgWjk9To2CPFdvtUVLTb4rzvypuIcNts8qQBiWKEvTTNWePzxg2LFip22foHjYGu/XcPR1HGdzpTgPp1h3EazanQZtznc1xiRV2MGpXqi+LP3r+qkekjLfw0uBKzKE7PWa0HDLhau4Rbn8+Ep81YT5sq5gvP+WR1nS8cqbRrS7xxFB7h6LhZ/J3XWw==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:36 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:36 +0000
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
Subject: [PATCH v16 01/12] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v16 01/12] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcgKSCdVfMKbE1oEW0FJxGOMvWhg==
Date: Thu, 8 Jan 2026 13:41:36 +0000
Message-ID: <20260108134128.2218102-2-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: 65b88540-bf85-43b1-e10a-08de4ebba4fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+UEGrvRXHAXche5/53nZzcpuXU1kujtD4D4qq18hQNXTOtJBSwDvh6VJyH?=
 =?iso-8859-1?Q?TgcdZqp/Ds4CVsdftX/kaeEQYoKES3Lsl2k714vZl6QlhL7R+SVdMNYdP0?=
 =?iso-8859-1?Q?hkyD2W3T1D/rxrPKD9T3inbZQsQ5mWGduoWzoYTcJc55MCLbnzoGZoE5wk?=
 =?iso-8859-1?Q?xP/oekFkdNKWjzV/9sG9WWZBfcJzJLbdx9CvyjVmjXVxPSEempSvnncrpK?=
 =?iso-8859-1?Q?AVo5+TM6UF/iM2NHZIi+Qrdr9Eb+mR2HaacejYDsKDIC3JmGV59e/dWW2v?=
 =?iso-8859-1?Q?1nxTJcOy6GOXpc066zDleILh1QqW4CV8T1lEB4ObEIofD6oohTxFNyX+Xh?=
 =?iso-8859-1?Q?ECUK0S8zI+f3bdeR9dcq4hyvK3lxb4bxFNRoxkh+8ugmA2KzqhDAbsiN3Z?=
 =?iso-8859-1?Q?zRx+ljrET3x7TWTjkKApXqnF1h301Xh5llstgq6lNRkcc97/y1cbeJwcl7?=
 =?iso-8859-1?Q?DKFlWgxKU8V/0Zs1c3Gw1lneHr5CSpdModdKQ1xUn3XgBDt+e3zBgj3MzE?=
 =?iso-8859-1?Q?nnrgrAuvBGxNUVXVA61ssIRRn5e8KtW8dwX3UbJdnNzylC3xEiLd9N8YJ2?=
 =?iso-8859-1?Q?MHjAjfv8TbQMbPxMobFEDwl0RpIrjCllIZUQ3KdoX5OMy/VOBNs7S/mpiK?=
 =?iso-8859-1?Q?uii1ei0okgWmWTtKKZhcaNP2dG+qjsOTYVMkeDg9gVsOW4dZDo8kYEX4Fw?=
 =?iso-8859-1?Q?5YHYB5u8Kcp1vOhxmlb/x1xcVXEI/LbCxXBZslqzs7Ye/hsarztqUIeWLQ?=
 =?iso-8859-1?Q?YIeoLC+gvG+l+tmYAi3AHxfNaC2y4wQiFGyG9WQlpf56P7cxCY4urfH7HI?=
 =?iso-8859-1?Q?UBLYaBxYN0CYs+cqtyccW1spbWxLClkquve3wORLsCta5ME5/1iRUgG60E?=
 =?iso-8859-1?Q?ttSbfO8sL+oyv9U40ovSbIzUVswIfLU5dpoo3ux9vmEV7xjBHVamYPP2uv?=
 =?iso-8859-1?Q?ZOvIlZbLmCDjuTXg/hXTwGyTbt5npoBI4UWumRwg9u+UPC/XIWrEgjPRpH?=
 =?iso-8859-1?Q?Fl93zxJ4MM93Y+vb9cGbmdrO0tpk5npfQCkMQN2d4emjHUskaNwnpWEBBH?=
 =?iso-8859-1?Q?Z6Q172U7Rv5dhzD9B8mXRfeL55rUTnlDwb22FMaQfnKlRJlMb0zqLbCpto?=
 =?iso-8859-1?Q?KWSTh5pr0yswWBK1aFSq/kDQWLydEt3yJJVaSa+i4LMf3i9lBM7niNjgKs?=
 =?iso-8859-1?Q?4clXlvXwHkSlfH7E2Nxjfj1g7I8YUbe4QKhtAguK5jXOeWkT0I78/9l3kA?=
 =?iso-8859-1?Q?wagihk5VD2LRJZZf7BVEY+1DvUmR+vzfnHXFjEzPH+pgNwme4cisxX7n9I?=
 =?iso-8859-1?Q?p4IG/WpkKWMU9P6w1dzm3pDzCPDMzY0Xmfbuh6WdAg/+HYh3D1sYkeUyT/?=
 =?iso-8859-1?Q?ULtV4s7E2X3bOpfeminu3FAblLCjiNOWSSUyaSPclvwYXn+/tJzLKMfo6n?=
 =?iso-8859-1?Q?mTi58SjDM+zvICI6gulYXbaoI/X7E9uHIhp8/Io9W+8Qyo+zqqahrud7tU?=
 =?iso-8859-1?Q?p91iwD/ahI2gynNlLrC5bUNJAKqtWAeNX7DCKJQLPdCLjN3dp0W+UFq+z+?=
 =?iso-8859-1?Q?jU6gp7ypGC0y0YONxYD5MkQBQaF6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SK7SaKngoW9asC3+VXzRxyWVJ1y9tzu0teBhXPQRn11X+cXp8jyTCGXzXf?=
 =?iso-8859-1?Q?nYaEpLpaVcysNNK10jcIPlL5Fb3Suz0hH7PBtCD2K87ImCbztNL/mRs3sj?=
 =?iso-8859-1?Q?jpCGoLNDowcyuu+2idCd4dTtrKTRezLb4pM+S+bDBHzcyar4rqzsGVx9LO?=
 =?iso-8859-1?Q?NyF94SOJSR3TLNmd8rxHDENTOq2E3HdaqoKB7z7UOUjikHppbGVDMMO0JL?=
 =?iso-8859-1?Q?VAsuq6bASfnWsNl68OwD9gxiivtOsPaAPR1/OT8C7LnWa7oiwHgub8AGd3?=
 =?iso-8859-1?Q?TP88syLqj+wVNLO7tQZl27Zub1S6R28hwLgVWH2P2MhgN4OA8dJ05if1jG?=
 =?iso-8859-1?Q?CVbp4T253ZKiOUQQgLz68Coht1T9401S8WkcpTZIceoCzfm0f0T4Sjl74q?=
 =?iso-8859-1?Q?aX8Fu04nFVv7L38wblbVWcn52BXM2LM+AfJSKnXNQw9WQEQk7y5xUNRVd5?=
 =?iso-8859-1?Q?SGoUHUgBMzvQ2Io5jd+mRBd4A0I/IuJBk+mLoS2SS113Jdy8kgnWFfvgoP?=
 =?iso-8859-1?Q?S0rVoOuNVlZF1Xm/+QyIQcuj0RXHd4/eaLRi7dwaUYLtK5ScnEdiVBKD6+?=
 =?iso-8859-1?Q?/MeDxm5iSCc3XeeaBMyjD93cTjWJzsl/DD4h019kliHyR3AZR4hKYVREeb?=
 =?iso-8859-1?Q?sWKBYS0ZeZFEiSRhDTtcHIDaB6NDHmVwBFbq+B9zhr0QDtSZV8xbP46BAF?=
 =?iso-8859-1?Q?Yj801wDDtHPivMO0mgCuA1JjwY0my8YX/kdYQ0qIjWH0Eks20zxgK8V3G/?=
 =?iso-8859-1?Q?+MDaj7A74e24DwXyd8c6zCIITHfecRObC1YAOAEGrxamYBMozuv11O1hd9?=
 =?iso-8859-1?Q?A8ORdGixAIOc0Vwohg8ar4BT3G2hSCI++DJL54SEnZzk4V37hcYiUIeOSi?=
 =?iso-8859-1?Q?XMU9UPhItGL4UETCkWkYo9V4pFQnqPg3Rwr3yKX2UmeXsQAWqw6Wxsl81r?=
 =?iso-8859-1?Q?GyU3nt49/WMsF+hJt9sw8xtfa/rthQost5pR0+4zrXJC60M7lp5CTr4JNy?=
 =?iso-8859-1?Q?+Ay9XncB1smRbVUupL+2pjKr+RLK4tHT6Cj8vqsSzqokxpIJfJseuupkz9?=
 =?iso-8859-1?Q?yOafNJ9aEaQWrmGYNU7o45Rx67YKudPdfpSFTkjUXBs03EjNhFgx/9Uwsh?=
 =?iso-8859-1?Q?ACEY8BOD0RI7h0TjhYXB3mawWf4xxz0Qf37KPoayTj22ANwQE1OMWcHeto?=
 =?iso-8859-1?Q?fvDe9FvlkEqy0euaEaAuydUoLy1TtZVksORIRQwIcLVFMqWN936RWQ6DLY?=
 =?iso-8859-1?Q?fyW7QNMdDhRKXj6Jt/ZIhVfLmOAaAPnELoRNaPUf9LrRTiWtJitsmSWU4Q?=
 =?iso-8859-1?Q?W5vN2qAYf+cr509Xh5vzfQPQMg3Z1V6k3ifGhWkRY/HhD4ysgROmzC64Xs?=
 =?iso-8859-1?Q?p3u1Ptb4AaUCxKDUzPlEJIKKrnzDTgW8Xlwot9Ms+G9/5nTxfNH57IFUN5?=
 =?iso-8859-1?Q?4lHN+J2fiEQD707+K0DuCWa/JjeYq0qIYlIwqoxGWK6qoTia9xO7/m8s4D?=
 =?iso-8859-1?Q?vn4n9Gb6wLtYYThBtNzI+m9Md9tc+czk+2zlUtzZhO5Q23P7ecbGG8CxF2?=
 =?iso-8859-1?Q?jXLU17Cx9M+VTroti655dBD9tHIuh1KC81oOkDT5iIHl+NW3K3nZb4qRER?=
 =?iso-8859-1?Q?SuYgZnNcHJ14yPE3nrYs5RnbuOjZEkCtT7+jyt7V1HfKYO6pTFESQ0+7Vr?=
 =?iso-8859-1?Q?oOoBazBcZtO1FHPp/KDlEOln/NWg/FmXSBrU+8Kvkf3FkzJepyQNiFj00+?=
 =?iso-8859-1?Q?Xjmgc7T79C6Oupnk9eEbEmyFqRq51viTO5fXmwHwO86J5fww6lBgR1C52c?=
 =?iso-8859-1?Q?uZ/TAFf7gW1oYGn1dUX+6jWM6wKxCn05fguctFQBofbK+D5q7jNR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b88540-bf85-43b1-e10a-08de4ebba4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:36.2744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1wuan9Hl2+MZiaVz4WgjfB3ZpaQkUuHtpRoFyz15pg3BVxrwujAPhLWvPsqBkhUm7m1bJBSdczlR+J1qG0RYuKro3SoZVg0gorrYo4uPMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f26d8b8b0..39f2336a70 100644
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
index 90b3e95105..decf1e69d9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -674,6 +674,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
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

