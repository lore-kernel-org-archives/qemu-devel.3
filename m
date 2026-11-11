Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B0606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=cVupIKs0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3b2-0007P5-Jd; Wed, 11 Nov 2026 03:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3b0-0007LJ-74; Wed, 11 Nov 2026 03:22:18 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3ay-0005QL-Cp; Wed, 11 Nov 2026 03:22:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isaq7ZIKs3YhNL7bSKedGDlzasNlESkgsaj4vYm4lVcPnubOcx6JPLAp3emda9M2bc8eyJ94eJRimWRLGjkYxcRdSyWjLLhWrpFv6xNp34oo3SNjY3QHzETJ7x3sGjo4H8+WV9XuidF59uWrkq5ibsOoz0rCVhmGyqYEjnX/VNxrRnBPaRl3k4Y3y6pXaczXqNYYUNG23+GMFK1t24tDo/WSmC6Vr/k5GKWlDxXGM+s3ecsstzcjyM0tdg5EgpMu0kcvXndQKwdwE6ENgZNVmChVRucRvElXI9gHLUBjs1IBf43vpXuVpHK1cOafSGN+kfBMtd+GQrKqD1j/o46dZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGRHxKQI97IZLtNHt7/ElS30QiPeDaLwbECBWKbZzpQ=;
 b=dYYsR43H9jbO7k5ul1C1ujOhVk/QHq95To1vREinG8GKfXVgbOn3ubnVI6epJz2N+IlXR7m/iSVWe5XneatvL084sKpNlDk2tBqK0lHl5q6zuVViXuEN7NjYFBlghED6titTUCpZSQ7urCuubnjBW6UU8gI3xpYDQUiGxKEadPRpmKSMPtas8f1rqvp2rJhauTpYDzNpKuGgqUscpnkVCz7u83UmQG/vbfzhO6TqhYZKFIZORNy0MotUNS442tVU9nrLzxvg8Md8lKkH7A2Vp+oUpCgpeSWmT2DPzHNcHwYD3rkycoHjiJB251j7VS0YaCP+nPJxAL9JOZF04h9lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGRHxKQI97IZLtNHt7/ElS30QiPeDaLwbECBWKbZzpQ=;
 b=cVupIKs0FZx7Q35RoweGAbybnn1RS8oAHoj6RxBg2uNtlCFKsXdUp5qdTm/fttWGnRz+XH1QgUiZ+kxIFdmYGfuMiVjyWmSAycDQh51V9N7N6RBk/deB78xYnnjQfrA7wO4Y018iZh08TrBRdIK9oiF92njkQzGVx7+FjQN//9i2SFy0YoYtnuM7KzzjYd/HphRz70RjSlixpp8QBo2jNBQ043V7P+U48gEYBRD5WAyx2TuC335nEBtnrO5rCDkLaK+Qmxbf4gJLVpErV6jEwt/jPbB+w5vU7fknB1mdHjF6E2Fc863iKwo8mrjXYV6eyRL67fUO5a6uvDBqsckrIg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB7487.apcprd02.prod.outlook.com (2603:1096:101:1df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:22:10 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:22:10 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC PATCH 30/38] target/riscv: Add cfg property for Zvfqwbdota8f
 extension
Date: Wed, 11 Nov 2026 16:21:51 +0800
Message-ID: <20261111082153.58601-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-31-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 865a5dfd-bc9e-4b9c-68d1-08df3fcce18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102124527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: X2OWoX+CQm8gkWXgrOz7xg16PDvqPPa53KuNPJxAm4Un2ewgecjUXcDFuDlinDdeaJRDMQcPcNaSiM1y/E4nJU5eCVQkp0QuwIYzSGILSKi3g3RtehQ6jQ/xflsa2Y/6g/w9e2AoW6mp2W2EnVM0n778mFEPgFCFvwm1sOHbbpsQzK3s5WIqgz4Qj88R89o1E0Zbsx2i4n4sinQUIxNWLrh8HXuTCQ/4PpHbIz13FX3a8t0NpeKe0/dgcK2hEIvqfj5PBfubaz1DbajpsawNkYmfy9oll9jn0R91bR07NuL6vca+VAHTPDQ0yjd76rNf11lJOggHGNAnQi8mjDlDob5/orU1JtjmLosAfMNfvfhacksVcHpn5pK5ZazAt8nlAQEOXftXPOsZHkTyMMdDJ3XGx1NjByAPX73qoOtJGo9VN1zKxUbufIrjGYBFbJKwyeVMlLM6L+wQZI5CGrf50WFFyku6zlDR6cFX214nTYFPyLQtSMIU+EPNP4s/Ef6QIlgaS7ICeWvE421Ve15yXUGdlIBJfhQnQtRiM6hWhlOYvTcBU7JiEJFPesbrGZihgVU9axdk389+XzkC9ejZ64fEmmx3C+C4umhQqVE3xw86fxzYevpj1w/zSrLd1a3+PpW+oVPcNsxT2/pms2TsD6z1JKX6g+c3owkIneHqUKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102124527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2pD9gkV8Te2TUBg/xDVQmlcbACKpuEGn+deHurjQD8NCRoMI2XiGcbohey5?=
 =?us-ascii?Q?bR/ncC0w4TvWup/Xhl0IDmH8rcELzogZqUO2k5JLKmCfEw80X1A+iz75l1HN?=
 =?us-ascii?Q?6vWrr3+KmsgyXgY/tG5lq2rQS3FXE9ulbHicWu5v3OzbA+99Bj+uTyeH7b6M?=
 =?us-ascii?Q?kHwzaToSwesWjJlEwkmZ2isoeQxMzwtzvwTjRfqXjTju7jv3DF2VbBPhTr/8?=
 =?us-ascii?Q?3bNYG+obrVx7sBFq6QGFNElJ6+5PKjnKQ664NTFrutEyMmoNB+CO1ZlV/9Tp?=
 =?us-ascii?Q?2t5/l9xeX8dN0F8FIQziS8IyE834kjr3Ugs0HiSDTTsQWCk0aPqOmeA3yjuv?=
 =?us-ascii?Q?N37C19BJd/IMXdANLlZvdKgNw/3kCPc3HQZLR7tZTkAmGHk1+bkocuwJ9qTx?=
 =?us-ascii?Q?2AjZ5bVlA7Gi8n946saMLBewOkvLPqgo2hsdK4vLrwRK13IiqjnNa9TGUzAQ?=
 =?us-ascii?Q?QTrSdMXh+0WexZILmgkAwCXsvnF94eO+2dOqbO+VRx6e1HAO03/CmLDOwJo4?=
 =?us-ascii?Q?+RX+KtieKKuJ5Tox0K8iraXVWYdDuXgeZ5ZO8EqIQVhCg1kVHtuGm7dSziqJ?=
 =?us-ascii?Q?UkckHCI8msb8/1P/1/4DFUyE/3zzfdPaxuHEI1ORI/2dptzipvV+GJqLuj4W?=
 =?us-ascii?Q?i3ybKt0lgym7D1UY52AN9+EBLJLktg42IzJsTr1F7QFnxaMvGcUw8qGclGCr?=
 =?us-ascii?Q?Uf8ojX5eroAJRrEp2LplJONmTBHIiyAZQ9I5ud2KUvgy9c0L8yrQM/Bp7HtV?=
 =?us-ascii?Q?ksFCQV9wysKs7z6npm+4lH5OwYb94mY2bHYcXXDq80NtEzGdcl/TBnh0IVup?=
 =?us-ascii?Q?nBaSBK3rPv/TnCBT6s4ELJguZr4ZUZil9dyxD1jE3dGqhE8M6O7PwNNlT+bb?=
 =?us-ascii?Q?HVfuOGjpbgr7fEnOUa5JIgCwmdrYdYLoM7wt3FNxf56ADEOjcXdpvk38CuBb?=
 =?us-ascii?Q?ssLiF2+o2GVZIrKco4Q3iCl/fRCuv4Ch52M6/5JBs+dt3lVJHiat/kPGg72J?=
 =?us-ascii?Q?wKdiZRq+1OAW9Y4jSQGd4ot+AqjKs9gd7T/P1f+ylsEmpjFpbbID8HtgkfZP?=
 =?us-ascii?Q?0f1CQcU5CARPqupjz10WYFNN2+kdy1fklR4VtX0w+4QiUJBJ+BBKXKmyHOL8?=
 =?us-ascii?Q?i10DjeSCufjKgzbfT0cefiE0dttyvOEi/F+eQ9/GZOFhADCEdRrZX25Np440?=
 =?us-ascii?Q?NsgV5PhTUnz1R+q9GJVy/ADyjm7dbb0STbFohx/rT6L+c10ieTwRhu8t52H/?=
 =?us-ascii?Q?xqVRnGklKP4ioEFARZif5cnbVL6zotdeHBtQ4jIHGseyapcDSQKR/1foD8Ag?=
 =?us-ascii?Q?/KreaRDmhJsyT5ffAS8qFtqaMBwkFhiUio0exKNT1GWPUSEbDGj/D8dAjhfG?=
 =?us-ascii?Q?fZhccmSBAyOgN7hwONl4QuHfAFRchgjEzdsBj2aG8bvN4tHuwXtUVZB/mJc3?=
 =?us-ascii?Q?XrbaWiQAKD81TA3d3e4P2yWMBdmqTmiob6OjFPTe2l62bUKpIurQ5Sn5fnx9?=
 =?us-ascii?Q?LQ4vbZakmJyCa84hA0QQx1CKx3t9ABbbCHf0E5cvLIqMBtt94ClC1y/WCkOJ?=
 =?us-ascii?Q?IZhAdhH/Aw8tViGmY+rpDnVc6Dr08sN/m77OFPhc8dOdAl/1rQn3y0xK8R1O?=
 =?us-ascii?Q?O/rArdM/1YqP+B+dtq6HNbhUTdUo15MQxbid/UAbDS0kB/DOfsrsbwNzAubH?=
 =?us-ascii?Q?nTbj1pYb71WkqMKpDdUaUYsXrmvJif+yVbIgTLe+sdlwnMFF+EfT1/uUd0Dh?=
 =?us-ascii?Q?ioNZki+xGdv7Zg3vqykOHitc3RzDqoE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865a5dfd-bc9e-4b9c-68d1-08df3fcce18c
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:22:10.0569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB0VnNRB0WaoxNri9Jnww/E9hNanL3gGejQwfursXPjGHqC5S20czKpSfXhz74TSKs7qsrjwvuNX0ykOsm7ud6QMHoY550gMb4KbA+gNYxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7487
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:45 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvfqwbdota8f extension which depends on
> the Zve32f extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c                | 2 ++
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/tcg/vector_helper.c  | 2 ++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 566e2e835ae..b4a9f2c3e30 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwbdota8f, PRIV_VERSION_1_13_0,
> +                                    ext_zvfqwbdota8f),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
>                                      ext_zvfqwdota8f),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwbdota16bf, PRIV_VERSION_1_13_0,
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 80750db1ccd..0385b58de0a 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfqwbdota8f)
>  BOOL_FIELD(ext_zvfqwdota8f)
>  BOOL_FIELD(ext_zvfwbdota16bf)
>  BOOL_FIELD(ext_zvfwdota16bf)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8684e4c709c..a52637f5ca9 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -726,6 +726,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfqwbdota8f && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfqwbdota8f extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 51170625aad..6f3b666784e 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      target_ulong reserved = 0;
>  
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfqwbdota8f ||
>          riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>          riscv_cpu_cfg(env)->ext_zvfwbdota16bf ||
>          riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
> @@ -96,6 +97,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      switch (vsew) {
>      case MO_8:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfqwbdota8f ||
>                          cpu->cfg.ext_zvfqwdota8f ||
>                          cpu->cfg.ext_zvqwbdota8i ||
>                          cpu->cfg.ext_zvqwdota8i);
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

