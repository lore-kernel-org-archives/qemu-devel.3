Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CAAC19F32
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKp6-00018Z-4b; Wed, 26 Feb 2025 12:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKp5-00018Q-CD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:51 -0500
Received: from mail-vi1eur05on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:2613::71e]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKp3-0005r6-4D
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2gdhwgJEnsckYIKGMUcsKBFb3qGqAOgcqtB2TmDxIW/iIewdHzVKfQJ66PWc+qdf1wvyACVaFSwS+lIDd6sUYEn6nSx/rgXgGuFIy/o8iSOH4MFja5GUrPz6WlIXo5KXRy1p/KQe6VW9MpgOjxFbLrhsvWKUMhBxoP906/Bs7rw0iq/HD+6h+wBQR/2pctuEQV2yrFEzUK+jfqqcNrtUyTsACwrt4nDnZxmUlLSQlKmEfxQFgKStDCpqx4HMyjEyc/H3qGLke8K9+IwcyiROYaUt6WtYRPSj8S/W4VjmB4ZaQRIDc5JhcC7aY3TnwOZ1u6LMoVm629JG+JPYNGr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmvkKjNzWmlYL9hmD7xXtPKG9RBEhuwvo/Rh5fmAdAk=;
 b=w+X4lQ7BorBuo/O742W3DqVhNbOnTDM/bsQdo0VKeNe6FUbAWUoIJaGZNPSRiEUsJ1sQzdpK+ulR5gheHQ8bCGra/MQM+glMnoQHhBYrQEd2a3yVWQw9A9y/3HvZs2L3h5vP6U+kkD8Oo8Vx5InAhm6IvkKdf0/ndQma+LJlTzX9iuPKLFxeGVI1A+hbyliQZWIxnpHvKFsXjm0VZ9bBGkAgCqm9RG5M8ne3lx2AVX+VL4rirm2LuSWx3giGEPBoofmA4GgOcgnzJof7wUspB14nFKv+UZxFUu8g5Us8a23CcY9c59JpkeQ1FPeD7jmj9Sk63LrU4lcxqFTmSW0Zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmvkKjNzWmlYL9hmD7xXtPKG9RBEhuwvo/Rh5fmAdAk=;
 b=TYaVO8hidPIQljD1XDM6yhYR9xJz9E0YztqnVOrmRzlVbWLANy/qQ5bPEJQGbmlBZJ2U1snk80atAp0jOfAUUkAvhLZ+k8hglVHvbsUJkXpiGKCseWrxBnRDSV0cMwspTXWm7viFduE4NunMtANL/jmIHWixTbfgxyK8qGHMGMfdlxfLpIgJGIuNbxkZ9g3CDI4f0aCf/lsCoSPbxNk7Rc4WD1a9YNj+YDdTkSHxv1BmBnqwI3hLFPRPp7vHEW/ss8Qx1eOPBglpHhyMeQOqCBI9SG4k3ReXcb2ywOEJuqGlk55QyYl0oJsgk8GiBguI6aKubf0k3k2sN36HJdDnHg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB7419.eurprd09.prod.outlook.com (2603:10a6:800:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 17:03:05 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:03:05 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>, Faraz Shahbazker <fshahbazker@wavecomp.com>
Subject: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Index: AQHbiHBN9WWu61L0jUe8EWyWqAJpAg==
Date: Wed, 26 Feb 2025 17:03:04 +0000
Message-ID: <20250226170246.1971355-4-aleksandar.rakic@htecgroup.com>
References: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB7419:EE_
x-ms-office365-filtering-correlation-id: 564d127a-d0c4-4772-b329-08dd56876fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?W0kfI94CDFHl0IFZdb6bAi4P5JgD6QdMFUMN+BW+KoSeDZCSw9goMvNeQf?=
 =?iso-8859-1?Q?H6UWCRfoz4PosNldDJO/yUDf1ZZx3bFh6XscEeZt5L7B+Fml/oioPuUH4V?=
 =?iso-8859-1?Q?Hbu3HQPh58jOFQm4GF2MsEFlcC0iqVfB/U5uMfJkptCMAKqXb1xc8OHGA7?=
 =?iso-8859-1?Q?RAj9oK7fAeV3rKA/J3xKqjQ6yljICIPzyzCV4Lma+M7RIn+Men0Z0AMyXD?=
 =?iso-8859-1?Q?1So8Tz4rLVxcOE+eRtWENXFD9QGw4PH4gC4Y1/TlBURm2a9IN0pFT+18nk?=
 =?iso-8859-1?Q?K+0SZtdHmXLSXHYe2mCWpOQ8eV341ne/l/dGK60QOuulaGUdFsZfPuI/KA?=
 =?iso-8859-1?Q?tp9mgCdUUeonOTUrLE0Vz9CgqEyLW+UaRcRH+C2ycT8hvbcz+GzUXLisPa?=
 =?iso-8859-1?Q?Y+5JJrrdnm2y3IcFPt3e04+qf860bpHIKRW6vFEDvB18+LU+cEpP//KR1L?=
 =?iso-8859-1?Q?v7u5XoV5SvXjSoLOtag4RcznLzfMpV03683qqDpqE6NFApvPXgfhU06uUl?=
 =?iso-8859-1?Q?Gq2E/1QUF7uZORLlb4pxsqujE7YGnZVvHzdf/9bj4THaiFoZ/8qJe+j/d5?=
 =?iso-8859-1?Q?zU0FlOprP/uVD/SASUy4lJt0FLSL1ATrkZSNXzuiknYvHwB/X6JNXknQe1?=
 =?iso-8859-1?Q?7TXVVfF0e6/ccKH1QFMxl21Z1ci6oFLe+tP4vb1VeA1qp5ijtqxtr6+a+B?=
 =?iso-8859-1?Q?gaxhO5cku8bmLxoPby4o10tz3zAcP1h2L1VuY5U/XMlZDSTL0qmhJDK++j?=
 =?iso-8859-1?Q?hdx7PP0Z42O7SUXgbxg0QNe7b0byEhTOj3y+p7LTARTFfMFiQVp6imUl/3?=
 =?iso-8859-1?Q?E8eleuSdZGeAag/I6ta182E61xeqMlgMIozBktRI+w7qJYkTuJp3xXfIsx?=
 =?iso-8859-1?Q?OR0s0YPj9fx+4+tN0coPL9DFoVM9NaKBVidlXle+ecG7QijWxKtv0FjMsO?=
 =?iso-8859-1?Q?PLpR8Nd8RStImsmrAB2c2QxQPJF4CRegglSNU6QHApmWy30r424Yg4e949?=
 =?iso-8859-1?Q?ymm8r1dSvgQxefvR0HEYce2wJ7L24XA9XU1alMfBJsu9Q0HasDSnN6THPb?=
 =?iso-8859-1?Q?Hicj6XAjuhDFv5D87E1Bbu+uBf1a+2wHctRjvQkk4BkOJqvI9N7Ll5le9n?=
 =?iso-8859-1?Q?Ukc8KTEQfaK0R+eCD5MefYGE9rgugHiF7XYnkvYNJzu565IjR584VeKvco?=
 =?iso-8859-1?Q?xNlRx2wa4+uo6/FQxwTPs2kp0s+PE102n+cjPLtXz9sRn5Bm9Bj3Pu/Q/W?=
 =?iso-8859-1?Q?uDKns+shnQz9y2rUFANEeM39OyLFmPUfpO/TrtTcftRAs0DlbcHxcCXJMr?=
 =?iso-8859-1?Q?GHVQMaickZJXmPiTDFnSj8Gjrq/YOm/WfRVSHIcmJDzq0q9EyIm7fDx3Qe?=
 =?iso-8859-1?Q?yh1BXsXfZcSt6K+oChDAYbACGvP6n/qrr6qq2JXysj2ztHfxM4F1rHKRRs?=
 =?iso-8859-1?Q?fqElmgO6Dunrp3scECyfNtmL6jISccRnOChgJEofcwRxv5em072S1Oaeps?=
 =?iso-8859-1?Q?XZRBmt9d2fPNmm9ROyxfaG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wGc3Ie/s7lQpBgMRDud8B2tLphWYkRCbR3MwTgHmAltPBieDPlvGJxsapk?=
 =?iso-8859-1?Q?pxMqdDDJjVc7/mYtqrcUWCgRuljdBrRXxiPekTArc5MTxWrDpl58/IcEoQ?=
 =?iso-8859-1?Q?HFTlGp441Uh5Md6nS/1n3sBDswNkwIIBP0jLuOd7LEdfzGmB6ssnyHyx5H?=
 =?iso-8859-1?Q?V8Z0N9JDAKDEj1/tY2vy7pWZqKXcNHBRk3KgZNZJwpubko0GowJVXewoH9?=
 =?iso-8859-1?Q?PwWvVLjoo5MdnboaBVn4vZdT4JauLdAS8ZBp9VbUk0NZfPQGe3SF7FaY+R?=
 =?iso-8859-1?Q?rVhC5STWuA6DcWFZSxcvCXR6Wgk1EWOdy2SpaDPc73wxrwR7YaZ6g6MoFZ?=
 =?iso-8859-1?Q?R+MQW3DK1CcE0Rv572zUeNYhk2NVuGVKle6xwfhQP7odGeGt7mvXN1Dc6W?=
 =?iso-8859-1?Q?etQmAebGjE5rE38bUvW+vynd7TdxYA4mzam+8rKro+XNO1CyIerh9bs7Yv?=
 =?iso-8859-1?Q?HKHNcfn6mi+ZOd8AGwb/AJt5EC6eXD6pGk5a+RyylaOVPO0k6PxtIiGM3J?=
 =?iso-8859-1?Q?HlW9jxPvqB26mECbUdiNq3GPdSCV79ejUeJhRwxVWRSgbCIYQwbKkb+Lhv?=
 =?iso-8859-1?Q?n0ef9sgm3ma8GGyL62F98NBy6fyHFs7fNrxbQ2j/TwsZTn5ayxaerKUS/X?=
 =?iso-8859-1?Q?TY3u9EI65B6v9PnmyuckFMZ68EFvekA/UR7j2RZggu+W8Idr0ucCphbjM+?=
 =?iso-8859-1?Q?9ApQ4/GXHVp4eUEoO5lyQpjTtFkxrTT1OVK47hts7u4aAA7nNaNnmeZD8s?=
 =?iso-8859-1?Q?QDbJmantzD/iDqTMwaQS6B4f7XgkHfaWFB+9B3ipDxpjX8t5KVLUv2PYER?=
 =?iso-8859-1?Q?57weRjXjjJlV0TtAdBwMtpLy+FQWd2QiwMmaJG/GTXu26i/ILjuRNyD8+N?=
 =?iso-8859-1?Q?IkF5phUiWxMUoqeS7biZ6LK2nUsKS8o/pLjoFViEx11cABDReKKOkeGyAE?=
 =?iso-8859-1?Q?XWynPrm4qMwtYjovy4HfoICiF2YopFM33fzhAoA1eFxQ4kmwZrgTCYy5Qu?=
 =?iso-8859-1?Q?D+rqDbNKyHQDJ7YXH5JGhB9mz+fJQJn0swVtGY9zTeTBPkD8qHUj2DwMFO?=
 =?iso-8859-1?Q?U9tjuuxJf1ga4LsWnRKcge4beVAjbAJg+WoXC/hUvqh4nRDuh+avG2+FM8?=
 =?iso-8859-1?Q?xBvh/ORi3TIkn8Z12a39s5AL0FrNg3tHYLR3hUONoCBLL0mt/S6btB3Ruv?=
 =?iso-8859-1?Q?G3ikli9LuAiRqIw5s6Nm2LcjnY9qGQrfUBWt1iYwJbK0zXJKCBp/eD6lPI?=
 =?iso-8859-1?Q?yl/0RuvwnY5vArSOL1vLi0OR5FRqoo3NmkQ51YwPJX1LJhTIqhWZgVhBO+?=
 =?iso-8859-1?Q?rSUiOelUxuFP+2RwFGpTinHDjGxXCbO5+vEyDiKsalw3WhxaU1s7D1lqkG?=
 =?iso-8859-1?Q?iIA+IfasWYwjOyJsn77YOAZahBEzul8L9MlTA8QXloZyEOzNn40YExFlVt?=
 =?iso-8859-1?Q?dGMoliwrGWmAHLO7W+tNJfHiyrrn/wUbjUJyUvH0Y6NvkwHohg+nPuHqCm?=
 =?iso-8859-1?Q?TaB3IpZT1iOJ7eQcPUWgUx8/UVG/vfrWAHNlsu5IWAx7ZvnnmV1ySa//I/?=
 =?iso-8859-1?Q?m7M7G6VxnmCUfPU/uNs3Y+Fv8B2H8W0KL92CmcBJg2txHqB9GJ04MoIa/1?=
 =?iso-8859-1?Q?kAp8ykMz1fMMTdbTgfNiKcufJtMQBFF9YgENvSdDdzNveF8cK2Ey+qVzDB?=
 =?iso-8859-1?Q?NO3GbXcFdNVWwhNlHyM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564d127a-d0c4-4772-b329-08dd56876fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:03:04.9436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9Px+ge8EqoA9ncUjvWv9Tpn7BEqgFyFhXPycPkByLBT6Bs0+kyQt1YXfHN3goy94RK5HWST6GWWWpHNBcBY+0HIHSB+UsNgIMRoUtpJWGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7419
Received-SPF: pass client-ip=2a01:111:f403:2613::71e;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Skip NaN mode check for soft-float since NaN mode is irrelevant if an ELF
binary's FPU mode is soft-float, i.e. it doesn't utilize a FPU.

Cherry-picked 63492a56485f6b755fccf7ad623f7a189bfc79b6
from https://github.com/MIPS/gnutools-qemu

Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 linux-user/mips/cpu_loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 462387a073..07c1ebe287 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -304,8 +304,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct ta=
rget_pt_regs *regs)
     if (env->insn_flags & ISA_NANOMIPS32) {
         return;
     }
-    if (((info->elf_flags & EF_MIPS_NAN2008) !=3D 0) !=3D
-        ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) !=3D 0)) {
+    if (info->fp_abi !=3D MIPS_ABI_FP_SOFT
+        && ((info->elf_flags & EF_MIPS_NAN2008) !=3D 0) !=3D
+           ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) !=3D 0))
+      {
         if ((env->active_fpu.fcr31_rw_bitmask &
               (1 << FCR31_NAN2008)) =3D=3D 0) {
             fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n"=
);
--=20
2.34.1

