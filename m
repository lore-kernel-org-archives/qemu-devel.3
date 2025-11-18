Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F1CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXe-00089P-Uc; Tue, 18 Nov 2025 03:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXd-00085q-8c; Tue, 18 Nov 2025 03:58:25 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXb-0003VY-KU; Tue, 18 Nov 2025 03:58:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoAieuO0W1Bk6z046GrAtAM+fskiCj2MtQFmbmdnMQGcKJnsBR497+p0TmXB8SNxgd0gCgaaCMogkm6uO2E18GiKnUl8TpVcBm6+eNVaOwQ0N12766Tvd//kpRp1fhB5rdb3Xn/Lqh0JWHFgcdP433+BHuqG4rcYbEqCJdKPY3EfOMJMZeNGRh0c1mg7tXv0d97ZsTaLEBcpL1Bpx1pWJMu1ZtFiXGr+G2vM6+rQ04zaTZxRWGeGoKnN1B3Z6jfLYzM5elRmCGT6ZJCwWoA89+xwVPXkIRffIs7RY5OZWeO4zslRsYULNVFqb4wvuhbm4q4YTxthO0jJ+6aDPuWg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=OBGBiJxR3v5nUQoDwyb/GSfdPOy/29Oj9fqSZdB0aBBvrAYcMQe5hWwgSw9aHf+cyeWVur/0qZ5uRe7B37KLQ8U+5fGF4+ODdYTPt+JcAoe5XOfuJOLgMoBdNhVtQUjEPTYTUBO/4isDmDjv2GfMGohQfocYYyANA+T6Q9GKv1hpU32FYumBJhirmeayrkjpdW3ACJVIRlvdYIl3HVlJV89THa9nLQzfqiZhrnVMddoWTKx1ifVez+pXYDhhM8DXoacmVzzEfUazQE0hxFWs4nghfKlT6RQ3xTSLgi7o+dgTTwZyZfA8V56CWmJDxhQHdYI3gn/dsv1EUONJqG0GBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=EWw35XuddkmIxDsUTmCu0KL2odKx9sIl1s4nW7kUfN81uFsNNiRf4wMp9rdDLnj7ZSz4p2ba9GH2MJZ/n71tcQWBM/s69aPN5RhD+nHHYOKpXPUBL7hg459/J8y42QLwQtw0C1IfkO3ekTt4DeFmOJQfZCPUuMaRyibApbxgFcRv9HtJqzvmH6Unz0QTx3/y0rvJy5AeiA7TO85LUxB4KGW4VJ0Ea2DpMmyu67ETazUnm/+Tq7f55J+0gUvU1s23GSwgC5iJFIaaxLwC82ZWc8943kbb2QMUTwKN83iC+EvtZlAHqKc9nZ0oxn+zjbT87xeFK/UBGCqr4uTSZwtCFQ==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:06 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:06 +0000
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
Subject: [PATCH v14 02/14] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v14 02/14] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcWGl0wy+U9pqTPky/WyZc98V97w==
Date: Tue, 18 Nov 2025 08:58:06 +0000
Message-ID: <20251118085758.3996513-3-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: 790edbfc-4db4-4d64-fb51-08de2680972e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8evdSPgW487rWCW2IrVq4FGq8KfTD+Ap83HNEp4q5hGHLVoNhEBp1QyVFR?=
 =?iso-8859-1?Q?Q/zA3vhpICCecyH/tC9FaU7hEC7vbaN3Km76KLRaaFypPu43eXoo/67zV3?=
 =?iso-8859-1?Q?4Mjdva/vmjYzypqldcZeyIqc1iVQFA5SLL0MpRNYJsjyqYzsyJEB+r9DaM?=
 =?iso-8859-1?Q?F05YX1XqH7/I4j7gmfrq4gOz+2Uw+s8bnjOviNLMEW+TapXes96AO2aXkb?=
 =?iso-8859-1?Q?b6/HHFatK2lKE3JTg5YIqaUxuXIXtw9fWdlPFScuF21TcoTTc61LQQLsez?=
 =?iso-8859-1?Q?oKpNaLaKEuN6jB4Mh2uehUSD3CsA1ZNB20+O7/5MZEhSp8aVC/7brwDOL7?=
 =?iso-8859-1?Q?gB6VDlaQGqnbyB4AtnsRx41Ms0aJcn84TnMO5/6mJEJ6rD+x66dzfW/3u8?=
 =?iso-8859-1?Q?xw0PopSiKUBIUhLLU7/P/UvYUekAFP02TYNUH2jtdxJp//ZPKQelseKMgA?=
 =?iso-8859-1?Q?+ahRbr8lAz9fPXzjwmZth1FxCw2lbdTaYkK+vGjjksAJ0C8uPlsrRE2jYn?=
 =?iso-8859-1?Q?fFnQMas93k2Vvp+XDKI2RQSf1D2cK358MyXFaB7PdeFy9/2WD79QL4EdFy?=
 =?iso-8859-1?Q?jGBhfJfx53+cX/aER/iKQOuLyQ5WC/LYAw/gZe5MqvsmRQYRB40n3bM1gi?=
 =?iso-8859-1?Q?jLNCFL8DLuYuni5YZ8GCfHcp+DYkitWVSKf6UlcMcC0CacinKonjpy/sTT?=
 =?iso-8859-1?Q?zLsXyrb0o6z407MUPVpqPRsXtlTeWUWyguU3XtrIVDdDf/EBPD+gtq6j82?=
 =?iso-8859-1?Q?Ivny+CLkvTLb/QEtqrFSPlEkGP857DtY+o364ot/6AV36y2mSPKnJQeVsr?=
 =?iso-8859-1?Q?YpmWUYQicLh6koHuutbQlMLiEcSBgAWt2n3uiAgytjBqWzMJEN37qaV4l3?=
 =?iso-8859-1?Q?WMNuuMonExtPwWUz+Yj9yWgzOawXo6T6w4gf1IB7iZhFPQhZUApxV3bMtK?=
 =?iso-8859-1?Q?lyjkfgBT0HaxGbG0up6xopXH65hhppqlklWb5f4rZKaafE29RiY7KHeRVV?=
 =?iso-8859-1?Q?v2gYetV6KgnSIbsBB88CiG2aAbjYQsRgKmfcmB+z4Nh0BJqqn2Sr8eg3yv?=
 =?iso-8859-1?Q?x/C8lepp7UZg0Icv98ZP3FZS3/+ayCohoYZVDSCVtC6N5cIOs5yoR1lsqn?=
 =?iso-8859-1?Q?kGJ3vI2DKSuxsLSs3wQsiq7MYdUgZugp5BLpDE/8mtPm39LbNJGxiTxzjL?=
 =?iso-8859-1?Q?ZiCEJMrMgV2w67fXXWwMdr2+RheOsnc4UjUDAxB3Ff911g0Ziv5sUIDP/H?=
 =?iso-8859-1?Q?mG2u47IOjNqEXugs9ktm/b+opEKm2AjXQRj/sEAGABtq48833qkMmILpde?=
 =?iso-8859-1?Q?/+u6rAfa1ge+hT39UdId1+40X/2t6JEasJvsLHVsmd691Cnz8k5YLJQXoT?=
 =?iso-8859-1?Q?vPOL1lFd8RpZglRktlvsZVw4i5A4tAOtep7gvVaE1C+cCdvgMnHjgUqLoh?=
 =?iso-8859-1?Q?n6LwfRPND0xE13hb8wF94iJUTtEW/te0T3/QVCha5sY4u72tQm9pQDAU0a?=
 =?iso-8859-1?Q?KoYba5OnGo9KbHcRWI9sxjrGFyz/rbXMfmEABz1XnYtOW5WCM5Wm8RClqH?=
 =?iso-8859-1?Q?IIoiJH+TlE/OHWwtaY0mCdtBXQKn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?El5cqJ1q3GdJxDUV8Hz1nEfAMpreLKMGGyQcFtJjUxnnhWVw0aI/kbs1MX?=
 =?iso-8859-1?Q?mi8MO1BmxlmJ78pVGnCTzW9/GxL8a4Gk79yAuyWoHi7USDmkASPkQWBEg9?=
 =?iso-8859-1?Q?YJ5nOPHTJ0hCX49FHJy1OGbrztVUhxc2naBMzR32uahun/hMpbYCkiojXO?=
 =?iso-8859-1?Q?FuoRMbYgtyHQgjiQZAoAn/t5eO/rvUTquO+tEWt/PUTywvurb8L4fxEDwz?=
 =?iso-8859-1?Q?MqqlWySbSoZIYU/7S5+KUVkSDiYfMifYOi5IFRo2kBL+VcAlfvdIh7OqQv?=
 =?iso-8859-1?Q?sH/60pMuibBoiUfY2fkJcYE7uOuQUN4U2n6jfbVM3MRxsj+bBMx0sJ+AAM?=
 =?iso-8859-1?Q?WvzG+Ozh8XU2qRgOVzZuRhICbkOMMRHmo5LF4fhq7rLJS4/zKo1ctukIQ4?=
 =?iso-8859-1?Q?poz/DO+Xc5PUvV5j8usgtWFGh6OkXCbrv5Rzw3gNkLsFZZE4Ll6mWJ9zQJ?=
 =?iso-8859-1?Q?sWZs7TgeU7f4IaH1rB7z1GU5gM9daiyzKvRpDP1S+69PM57kY9NMFLCgmi?=
 =?iso-8859-1?Q?HtekrGRdZ7VCXUHG/4VNe0+pk7coe5um5+39dOh8IUMBavrkMygwUPUkfA?=
 =?iso-8859-1?Q?6kiVd6yYop8quQ10EKz60gDVeQzF/5jwqzQiGyuVR72PpTkG7NyZo1EoVN?=
 =?iso-8859-1?Q?4kF2mymmVobRKse6D6ORz9+twWbkfwrAm7gevqMnefwCpT5u+JZ4xIU8uV?=
 =?iso-8859-1?Q?IT06+NPUGv/7adJWmVGU36gcUhYzY24ZDOKl0ZPRg1x3sySJGyLP0+YVP6?=
 =?iso-8859-1?Q?GxzQAv2eBNJS2aYBWE67bLc1FZ0oFoK9UYh5m15Wzf9IbDM0eBTavvpBwg?=
 =?iso-8859-1?Q?ZjeNDpuoEu8CknqUq5CzxuRjJQ8BfJCgqCRsvyodkH7sPslhV+DZA5SgU7?=
 =?iso-8859-1?Q?MhGiijHHZ/9L9aZrk8RqIL5cATxaZrvVtzGAio6Lafa6eiqA6W5lwwwy2R?=
 =?iso-8859-1?Q?2JEaMTnz3jA7pqbZ0pOfII0rj5d24KLqkCV3jukgpHCJ5lNXwl0I4zkqrs?=
 =?iso-8859-1?Q?sG7ykN1eH3ItTl/vC50Let6+uHLgL+HAbRoIS5ARioO21DFuEkLefoTKt9?=
 =?iso-8859-1?Q?wcQzg6Yg5wFy/OWKj2lkF7+yD4C2NA0PC1Nu29z8ZOrcF/3TEXCRZFJpEC?=
 =?iso-8859-1?Q?kZ/RuIosUpcmRENYO/WtwSn5VmjVHL6PnDRoVblsrxEPwAao/xPgqQAuxQ?=
 =?iso-8859-1?Q?/3G8adL+dLfQlCOSVDudyPn6DnoYmpy0jY87go9/xR+Su+8Chs9OBpBcMT?=
 =?iso-8859-1?Q?l6n9q1okbel4Az6xfRtfjSIYuIkLjXwueyoFeJShTQpQakg2Gecc2NXsOR?=
 =?iso-8859-1?Q?ExWoRaPwXScEtqoWhYEpWy3OvTEPSysixhMFdKAXg1Zkp9d1KTlQpEDmwF?=
 =?iso-8859-1?Q?V/up7DZ/XA9iwUvzyo4eC/tPCgO2hDEV8D+40hpmifOkTQEF+OacvZDizR?=
 =?iso-8859-1?Q?5OIihTHbTH9OmoITfECx56PMEk35SdhXTrlYHXbfXszvlJweSDZEb0Mwse?=
 =?iso-8859-1?Q?dA3cwRqVs1+TsT7/0vmV5red8UcoUNyq9Gs2rHAzyzeZ15dfhpBG2bkfde?=
 =?iso-8859-1?Q?ssF7xZHWnCqnhfwkzdnF+VRQqwsTlD/BAnvB3vQPPJj7ODhmfWy5XnASXb?=
 =?iso-8859-1?Q?mFAGebRKgaGm0SWKI2RQM9qQFsTa6pc9YYLc5w+VWoblBTd37goHWAGV1V?=
 =?iso-8859-1?Q?6wZ16L0L9BG5Rd/BxQo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790edbfc-4db4-4d64-fb51-08de2680972e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:06.4407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JG2+DclgNI5g7YLUsFs3kqC+ILAXd78WT4VqrgqPedBKFJrp0ouxCVe1wTeXSjOHWb2qEozYM15or4GC7Qa1GqxDZZh0wSfxkMfl9IX0+hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
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

