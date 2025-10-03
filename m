Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE61CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dIu-0003av-VJ; Fri, 03 Oct 2025 06:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIq-0003ZT-HB; Fri, 03 Oct 2025 06:46:20 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIc-0007QF-VZ; Fri, 03 Oct 2025 06:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvZy5QIP+sOFluqGQAlc/XHCndSjXQbych1FjuUUYlqTQCDms8QH9aKjWa0BxmKvKYI9bc/lxI65LwpZRlG2x7uGSp4WSuo0ZhZZLoLKHWH73EL/0lAHF+V8uRhG9comY3Sxt9p2NbR9BSpbUnDPW2xM/ht9bvnWCbmSufoRFhnPqR6OCXebFKEc8AXXH8Tb66gOB8mxR+3r+stYpxigA/Dd76WpdbomZi8sIeGCpbmS6sbXERiwxkykBc5v41s426BeCo2MNDW7tNJS+3Y8HTqS6RWoG9/i/K88iiED/GC9YGjXfJ99yPQ3gVwZ5fymCVv6HtytmuVCvhb+QKW6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCM7SHSz+JAPNXlfy5Hk48bDSNl21hgGwNbV+YP12a8=;
 b=ACmk2n+zRZRZcWr1McIzsmHsyyR+YLkEmREeIlJGZXfc0shl3QRv31ux5ZhZ29jnlHk1jWApIQhy4hKBxgZDwTuQ57wscrGcbGXhbuA4rn6IOfvW8QslYPYI4zX02ljf2WqwdLutXCA2VS1Kv0KOFEFkwGDESQ7JxqhPeQ0DtQ/MjfVJyzAVwW7XgZXHxq7nXgqRNB/XOLUHT74sB/pEmm1NQA8rx0MSb6vQTYgKHxnWJXg2Emr+TfPIvGRXO8g/U+VamB85QZIp89Q5iyeCkcOhsKefy3BKAbK3APUSwDuSKWKGjkWYit/fDGLB5FKH0MvPzdxaGTM5+u+tqnyOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCM7SHSz+JAPNXlfy5Hk48bDSNl21hgGwNbV+YP12a8=;
 b=X/FYg85KEcbXIB63PjZqNAYj3cTDo4OoKImsYaGkGA7DO4L03aX2WMm7MGTAYXfi2b5WaQ29JLmF6ZSyfBAxn1ap/a1sG2PmIVL/W2Nyhku6M9SJOeHrDRXn8t0g3V5jIlkTUC5qnfKjWDLBNbqxHZUOtPC/anc9JRuT+UjisBgm0ZSkMWPXau7CfwW5z+fdoZiIbBY1t96HL2tzsroKr6NmGiswxp3MTfZLbyBMeDK7ymxuRx4mbWSO9Mu6M7SNANd4l+lSLJS/3zSfGGha1j7AO4KKY47u72wY8b6w0ptCTfGsUNmPw5wANICh5Ikfn7RzrjWQMGH98456Ov6pAQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DU7PR09MB7941.eurprd09.prod.outlook.com (2603:10a6:10:5b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 10:45:28 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 13/13] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v10 13/13] test/functional: Add test for boston-aia board
Thread-Index: AQHcNFLS+A/v34Znr0SIuERPqPYGZw==
Date: Fri, 3 Oct 2025 10:45:24 +0000
Message-ID: <20251003104443.51501-14-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DU7PR09MB7941:EE_
x-ms-office365-filtering-correlation-id: c63e429c-b6a3-44a4-a114-08de0269f7e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CY1e7WMV1S2t2OgCaIu7E5hisVlHfLokYQlf5mm7WULapeYJEDGH7GwAcR?=
 =?iso-8859-1?Q?t5YRg8C+ptz2DN/fQNbBYNNpJNHCK4Zu46HTfOycMjYG95KEte2i0nX/FF?=
 =?iso-8859-1?Q?W2xf/nkmS+sACYbjqLsgrHHAPod3szh1m+I0Al3jh4frPTVqTzHyW3Y+1I?=
 =?iso-8859-1?Q?2bA0he8e/8opgZT08JREUfx6USGcM+U1DHD3oDSZ/y7sSQ3BbrACzkwYzU?=
 =?iso-8859-1?Q?s5UH+uQaHuDELXlQ7S6jbiS+qSQkk7tSrMAYyjZe6Tfn3s/I9e54OqbcE7?=
 =?iso-8859-1?Q?urhfsSJtw9zd4BjSr++IQlqZ/Ex0s/uBS51A5fSbwOHvZPkQ6INy84oROz?=
 =?iso-8859-1?Q?2fFc4EJkNALGTsaMUpDWTYeE3DmI1wOo8i9OWcCNEfUeNbmZeck8K37a7h?=
 =?iso-8859-1?Q?PMtl/ZX+jeyyjW9vehBDY3r7xSezNqXyPPFoMCDWW6PXgXUk1baRZy9IaS?=
 =?iso-8859-1?Q?8N0+10tEefs40HMwvgHBXPc1GQGvlVaTGBf4HYL6XJM0EaT84l8MIcNEDf?=
 =?iso-8859-1?Q?HcT+Gwvle9po73gbTuT7UM3hyYAKfoSa6+RyAeSZTA3L6PF+58MlQlFXvo?=
 =?iso-8859-1?Q?ztlFvrM7i4Fl8tas0FjGa5kzffJulvydc686ribGv9mM3c04wfS+5Nkjwc?=
 =?iso-8859-1?Q?INXGS0cN23S1jWt8GuJ9j14d2fl17aWnC9XSIG76QZbO6Y+faYlmZRynHE?=
 =?iso-8859-1?Q?Dc1+UfXiTwBRE0ssNLMZZsvSSAz8jLS0MTIA+7Ml+wpuKbzeAsShkiNkvM?=
 =?iso-8859-1?Q?mMNnd5g4AbhTNNaR7+tUFt11kxKvaug9hTFd1+EDe3w+dSIMf8/GEwif5E?=
 =?iso-8859-1?Q?PZUgJVZE3wMmrvTw3/Td+R8Gd2YejqjEz6zsk8xLKCcz7YQaROlwpJVVEL?=
 =?iso-8859-1?Q?jep1RUDmCaZZ0AMBS7Pdei886+GnVEgSMDMCISalJ86AlNytjS0RMEEbhp?=
 =?iso-8859-1?Q?VVFFfWZddVV2thI7rqYq3PVACfkT02hmNFut2utN0IV6hcgEDYdZ9+F7Fi?=
 =?iso-8859-1?Q?SIn6zDJz7GuV0DkckDQkSEh9nkH+jjIXy1aZZGT3E2AuVsrlWrD4hBZFru?=
 =?iso-8859-1?Q?y3Mu0uZJ6j7tuaGzb1wCrmO3EpoF6UHhjPqR/9Hj+O0RGJ+zRGJEqWaAKi?=
 =?iso-8859-1?Q?axQTrVXjQ5cKKEBw4SWg6yAnujua4oNO33jaUuneDYwiIlazWgwupzjjoo?=
 =?iso-8859-1?Q?CbhqfXqr9nB73/bNWSzTvbfkZY/BLD6IYMo5snlbp3PjQ+EtfvufZ++jOx?=
 =?iso-8859-1?Q?r6E0lbWKxlm2CqRrRxN6oWu7D14Y8T5FtF6TqwQBJSg9CUqMNuzkygE393?=
 =?iso-8859-1?Q?bkZjZvlLQooRrR1K9Ayjg+tWKbuKIlb1IyIEjfMT8Guh+vYaezBaKjWRrd?=
 =?iso-8859-1?Q?wpVXmzsCgWZl2M9r/qsesAbA1zK/Vz8kcFj7scL486c0sJmABYZLm538d/?=
 =?iso-8859-1?Q?fxe02cae/FQpVig9iXZYyoMMazjPxgu4wfT5cPA0WKuxLQq+DMLcZiYyIl?=
 =?iso-8859-1?Q?M5GG/Mm+0FCs2aKWXotygIZi0yxyn1H3Ubcvta8RzwjyOJfmdgwnXbGeNz?=
 =?iso-8859-1?Q?QOe7+2MdwN4VgctBjnu1+PW1lgBW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iQ1Xg7wL8hmHL500V3oVQWZtjg7iq50afsXmsdjC9Y6q33HTvjVhWwsDMs?=
 =?iso-8859-1?Q?mm9U5EFID5K6+i87Ybwa4MS2yVHn9CWQxeLg/VNdh+fdb04KvSfLWO768D?=
 =?iso-8859-1?Q?bD0QKY0LsOkyXVHoT87fU6CcuGn9aQyovNwyB/Xm306VmmirHZ8pA1zESz?=
 =?iso-8859-1?Q?J8LPyCqz2kpX/114NDsGV1AaV7jd34j6taDgA+VsUjeD0XsIcZ0ShmO8ym?=
 =?iso-8859-1?Q?BcukuhadVKFf79UBzw2H+Thr1uIhadHCtWcQdXIa81JQB0LVzSrw3WkFBw?=
 =?iso-8859-1?Q?qMmk9cS3EeVC6LM4l0MWRAgPXAvOQVeBn0nO/c+5TKGBx7BOw+HrHibLQC?=
 =?iso-8859-1?Q?3q8v9/LnaJcIaGuGZxPY9wLgAxNCcWmpbW9ErsowiZHNqkxZocTMRzQLaF?=
 =?iso-8859-1?Q?dRjYWldvI2DyPxZJt+Abdkvw77g1TC1MS6aYsASTFoaSy0y2jdTX7ibdWQ?=
 =?iso-8859-1?Q?tW1QAEtQBC/KpbSpvPDl6+PO6p2hEl0r1zKRKOBPEA3gqvS4zFpLfeIGwF?=
 =?iso-8859-1?Q?/BKYdSSS9Up3xtEJx1o/3h6CIf7JVmGXUjr3RlWADgoSWvynEAhVF7M5Zf?=
 =?iso-8859-1?Q?XFm7X4zNIbypxRpCFZnkE+XO4jtpYkLN63GmXjPgwsK2aGVRWUuI9vkq3C?=
 =?iso-8859-1?Q?hbse0DdM6I7jQCv8kkMGwacyaOg6X4rBcRVVZuVNKrz5kzjrabAkxF/TuO?=
 =?iso-8859-1?Q?cSna0RhW65GOfwlZveXU4wwKFm6+4P6d6o/ixCOLEUWuat1E+gMoBZ3Ypt?=
 =?iso-8859-1?Q?+fNsZwlwyeFnZUzcBo4X+rK3zc9y45eSCyZkoQ4U9e20nj6yLpnZuEwCNo?=
 =?iso-8859-1?Q?hRGweBMdpubSdxmA1CMtKqrucWvJnZnC70h/IhrhvDA7PzatS4TNwrdDcS?=
 =?iso-8859-1?Q?p1NXx+BXnNVRe8JKcYVg2szM3AmiXWwy5W89uT81IUPDRVxiBjDvXLd+bk?=
 =?iso-8859-1?Q?3ij/GiUjLRFgZRfP3zNE0r6vBddG6Ra75pRi6UzNCl9HWwUZL3aFgrEAA3?=
 =?iso-8859-1?Q?8r7SP/GRPAs7vfHcOAkO0Oz23N1e6Ks5f7Yg8xm1Qtx7EZOKrTRc1VHyN/?=
 =?iso-8859-1?Q?+K78vMUicryrBqMLLwVFC5a9Os3FWTds1CKWJnt8MtZhydnqcABj1OJDa/?=
 =?iso-8859-1?Q?HMB9xiby5EVnNftl73zVTvR/3QkXceiXK0jrFgcIlbJGM1EnGNWwJziYWR?=
 =?iso-8859-1?Q?pV8BW1uSMmWMsIk1qaabPvtk7ooLZgbHLrUtRtP33/0GE85d9SdHFOXMjs?=
 =?iso-8859-1?Q?2xvgSPLAhrvlNrQKl2+8DZNUKK309Gxx+EFlL83rd5RVMLYGFf7tRJh9B9?=
 =?iso-8859-1?Q?PUW075JaC7pSUSVV40TLcXPUTJ2LEOrsd+EH5juWqgRx+ZeayzalZ8AChq?=
 =?iso-8859-1?Q?QZzAxLLQBZ9/5NiUdNghM5ub6UfgVhtrFwWpfghJ2iYGvSKyXLQOEEm1Kx?=
 =?iso-8859-1?Q?ZUC2hvvBR7fMu3+E9tyCm7BeD4YWmLNN5IygiBg2IHvHWGHYKLURyrYrMe?=
 =?iso-8859-1?Q?Y7vPDVfktWEILSgpvtglLc31GPCvLmBkowL78gwY2iJI4ryVfvpXeIGc8j?=
 =?iso-8859-1?Q?d4VZY+RqT4Rdq1oJTVn7tq/UfzhvwWvCa+3sfIbhSyLKA6mM9EnpeVg8uc?=
 =?iso-8859-1?Q?Oq0a1AG6wV7dlujH4/rcS7FdWfyvz3/SGfazcjLwWIJlQoXNMqPFFkxPAS?=
 =?iso-8859-1?Q?Bqo0gnezl+43d6SqjkA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63e429c-b6a3-44a4-a114-08de0269f7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:24.3920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVvlA/oD3g0WyIocVALrea8aEXv+3kSAxsqg0U60Nfqt7E0tW7hF/qQVZSYy31K/GIQa/FrmprPJJh/ZQZ0uFv6SPKkiIRjARKw70L73/24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR09MB7941
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 tests/functional/riscv64/meson.build          |   2 +
 .../functional/riscv64/test_riscv64_boston.py | 124 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..58d541f8c2 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
 test_riscv64_timeouts =3D {
+  'riscv64_boston' : 120,
   'tuxrun' : 120,
 }
=20
 tests_riscv64_system_quick =3D [
   'migration',
   'opensbi',
+  'riscv64_boston',
 ]
=20
 tests_riscv64_system_thorough =3D [
diff --git a/tests/functional/riscv64/test_riscv64_boston.py b/tests/functi=
onal/riscv64/test_riscv64_boston.py
new file mode 100755
index 0000000000..d450f7eaf5
--- /dev/null
+++ b/tests/functional/riscv64/test_riscv64_boston.py
@@ -0,0 +1,124 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+import os
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw,sna=
pshot=3Don')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=3D2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=3D7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=3D35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=3D64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw,snapshot=3Don',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

