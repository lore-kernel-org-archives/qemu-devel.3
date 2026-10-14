Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAFACC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnlE-00080k-LQ; Tue, 13 Oct 2026 21:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjx-0005w8-9L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:25:12 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnju-0006wT-D9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:25:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shqIQ9SDKt1NolxzPWT55HE5rqERcc1w63h+6rGByXp4wxRslot9pXuA00bolAs4L1yC+S43FbxLj9SLmFijH7J3ub+vWNIaJrI8rt1zCYgQX7jHEYmufFlCnCQuCWGloL71S3BMLNimtRFEnqFya+VxGy/qrqKpi5t7uD//zYyzBrc3crQ1TpCmjs1gsG+ZNvbyHzGlasLTW+qYTiavRIDkZqJuGVfqtcgVTqBUJDN8Yc9X8TAxG4EXHvSncSCCsgj82jtANWZDgnvQHB55Xgsi8yd56ApbC9Fih1gK4pihlxMvcwGYv5OysuQpGtRYObfe6OxXM+Fhg4eKxtilPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21JSIg4tQTbCRcTBxzQrX4H07Xcz6zi3RalRDOBmfa8=;
 b=gMJeDQnRWlrPsHD1EYvsju3Y9PMincW6n3PHLHM2Hi8NaZDYHrULACfBh2VcrTOP0qWv1IlGbcoeVGosigFCpNNs5ME+CqxXYZX79h5TSsyPP7QahXNkHon8Y0F10KkcFNsiqbrChe1hIxr3CHqhqD3MMwUCzdJ3g94Mk/PBvTk3YMqIA6th+olPMKn8OgIjN4iaewHqKEFsyxPfeOSPDxE9/EiaXQNptB8nxRHqhjMeLKBDnTv7hfCLxQuUcrEg84Or7cKgDwEt4Y4c4fgTMUUAhraqswtMJaQoxqEktQXD7dWuew7HWJWqh4mg1H0Rpd3HbLps7ced20UFlx6OkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21JSIg4tQTbCRcTBxzQrX4H07Xcz6zi3RalRDOBmfa8=;
 b=XkX9h3amm0rjkl9cjBxqSGdkzbK7e8eIAZ8eRB8dQERuAQUyEvUK/9A+/mpeiLCeZ/vLpRDgMjoxj9LQwhQasTA99G2ksWfjxTSwKS+hm8si76w7c9ydqyUPKMwhOm2iE8tEpMYeTj4olML2FACMWUEToaPrj01z2Sv0ZwqJ2pd0evFkq4eMvTeWt4GdYrrg7NMPscMaA/qmZi6L2oX3ZW8EHIrv2umjLilmA3osYpeWN2Aj9HWz17kHlUMizqpBf7wo830ttIaMfg8auaJOSy2HDTmRCMngYRwQyvBQ3Oo4WssZpUmXj96ik2rh06gO6vCbLafwmVX+sm/Icew2BQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:24:58 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH v4 26/27] MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
Date: Wed, 14 Oct 2026 09:23:06 +0800
Message-ID: <20261014012323.322790-27-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: c44c2f99-1886-413a-7b2a-08df2991f587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xVw/2JPKeDnGNkSwi/0Nnir1ywElei3H4kRNOlSe/+/0hEqsBqwEqmIez/+hPIOzp4i9I5kjDaIW/IDqySG+0OmeODgWsw54lOoN3qY3l1mQ1iSj8/sa6agbLXXJeC5YkPioA48hE5o7jHa2mqFRKpSk36ZH+nEBoFiR9S18cXWVgMu/wG0IRMcbE8RO6OZkXQGxDKkodbGtWSZydaPFyF6YzLzggp+7Sd7/1Olc0sApwwFb0W0NzVNbh7lttkPJLm5VrGHY+0tvymjIhjkhlRsgJjpqwRHB+Z++6JUCP694tGDE+e6G11l5sC6jmqtaPEZ1cYXgPcqe0wBqZNoWGqfnibSv2UAdsmGjl0Ono/giJQF02378yhoBJ/ojlpI2bSyBUZd9Q2viqujIju743jXLy18WgUwIRcmudH09R5n742mPnNA5o7dyrUonegaJEj7PcmN1/dLao3qZhmLuiyl36IaOk0BgtG9P4bGcml+H7iiPhO5e4v301jMRLM7op+yepkArAd0IJjsSQz1qM9blxGQK3Sr8XIJKqcayeBHZKFfHfpkMudiYhMHB/y9eFho1n/n1BTlxfXNfKdj3Zofp2ifXGvJSCsbwzqf1iNiN2Ko+Kw0CeWhdyddirh72Mq+UvYcT9bF8nONRPwvaQ6DXrpyWm4YhhVxHJIa1N+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lU/KmU7eqCROKSA6EAKzwKVLHFQjlcf/+7ibx66ixQXxJs6rFzEB5IlxI8yM?=
 =?us-ascii?Q?nhzs37qIUnLNJJ+hh+XDG8EOO1XJr9kg2V1FfbqaanzYrySdkrxaTpwF/DV2?=
 =?us-ascii?Q?llddBcyCm+B4bQ+qcEWfSXpogVvkJFxFFdAlWYoZwpzcUuJhQIPEbJRlzUtx?=
 =?us-ascii?Q?Nr966OwEioF5lmGvTvT12ajfGDPJExFmswlIWTPKUZBuVvsi22r/dMOcO58q?=
 =?us-ascii?Q?+nRgXbMAcG4FNF0+cFuuaqOspmSij2DADsKSzkSzbe+PmkN8z4UVv7q2A4fi?=
 =?us-ascii?Q?sWqf2tOnmYcxwvXhHNBu5QTGt5NxHOglJA2rJLOMTuR54j7OyB/Krkh3hdSX?=
 =?us-ascii?Q?8keQWglEz6D3BnG99UqlJ9LONIa7QqTgMduRm2b03OR8UDYmXueRRTPwqQNB?=
 =?us-ascii?Q?zK43TfoQqvyXb4p5pePVdCCmQiaaUZa0GckaEr53PzuljCdkHd9+N/kcfWGl?=
 =?us-ascii?Q?h9ELs+3HNzcIftu+tHFnSTMjlTYap2jiIiBsxPU0l9yHmvYF5FLqeJtWQdHf?=
 =?us-ascii?Q?YuCj9Fyy1i2FOGtso5uO6TsXZ/AWMnA5LnnevBIaUHEfPrfIBaTwEY02T4Uw?=
 =?us-ascii?Q?2idN0BU9Zk4XlewgrfpAwEJzkPV0kHwa/ZjgggvQ/YaMk86EgCwD+xKTxpMq?=
 =?us-ascii?Q?oGe+Cj3GkVWGQ5GsOiJ3ZbRFzQOlGnYojoYV5TNERqvFhV5G6ziEU9LGTN7V?=
 =?us-ascii?Q?QY6z5U3h4sKqzfYTI2J85w2TDLmN4M4zsb5UPiyP5vJUTlBHp06yjxiy9gEx?=
 =?us-ascii?Q?bLU4WpgInQ6WqOsIpTy+0ymtuNMXvvQSN7cuwe9TDXuJTAGgC5QOPpiYPqvE?=
 =?us-ascii?Q?lswdO6GBWXHqbwkC7uKIjSE5TGb0nHoBlEtskL7G4BYv3f+QkmWlwoZjH0eT?=
 =?us-ascii?Q?HfLfZ/Vv4NF8wcV3EOKWmladkNUZA8kHLJUBwa2IcggNGBfaEBsONeNjyJC7?=
 =?us-ascii?Q?eeW0/Y/kjelNu0kOT6vZFReRxAosAWoiHwGfQ0dwDl7txIyVE6+0yX6veZ/v?=
 =?us-ascii?Q?18ydp5J3VqWFn0vsDH4MdQlM26jEK2ndoVPK5UrgijZnRe/sbxdVlHZZnqKt?=
 =?us-ascii?Q?h5/hG+uQC5nDNvx/OltYcpZt1psQak3EDk50oIeW2kHYnN0XkYyQEouUsOCK?=
 =?us-ascii?Q?XaRBGplBfXGtuH0c9jglkhtFKg7PGGfyNi0N8skxNa8b9KHlDMFTwexJ/nDj?=
 =?us-ascii?Q?UFBeiTOJ15mzo6lTIkHJAF77GTC7dNRuUcGo+tWAPovPy7oS2v+XyiK+7Wwj?=
 =?us-ascii?Q?F++vG5x4SyEmnqawT73v8QmxjlJY28SnAw8b9MnoUA0xxkMYZB57FZvG35l+?=
 =?us-ascii?Q?1mV6qrSbHxLcJNZ/hGWZ3zrKKrpP+Whp6MmQmf42aMcurzIIgZN0JvGNWWDY?=
 =?us-ascii?Q?usK7aWdza/ntWPZIowcH0/O0TAjJkkjgng4fn4+9FrAOMjg+cZtlQZ/+63nv?=
 =?us-ascii?Q?FJbGJxPWksqn/Bw1HxvBr13DUvZaFgiZrgxA8/OCG410mRt5aEQDRfyxVIhb?=
 =?us-ascii?Q?GUVfdy3KLbA7/IeKqL4SZTSYJ0sKVazlvSI44wGiLAeclmFrmiDWqy/gtEcT?=
 =?us-ascii?Q?hABYcK7Jgu6FiM7h7EIxwGlf9zusjP3KblkLJ3Afh8iUHzu1g/aRscJfspsv?=
 =?us-ascii?Q?cLubTqlb5hcKC/TfXzmqQyp4ujODpgn95Tck2y34sZbNNpSyVQ1K61YjcFxL?=
 =?us-ascii?Q?YP1DFtLrHBBrXl58kG/FZ/aneOIH6hF0KyHOB9YvXo1nnKCvEq6CI54pma3O?=
 =?us-ascii?Q?u8TG6Gc3TmHJGIKB13jTwQSs7fkaAoU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44c2f99-1886-413a-7b2a-08df2991f587
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:57.8778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mT3qbPsLJFDxz4eTnDn1IcdudZsT/mhMrELb2A5tFIrNZd07SAswcWl1tarMnwa65paZqbMOdXYhVOWp5vZiRWqqmMGW0radAuaYlxFz8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6222
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

The preceding Icicle Kit updates restore HSS, U-Boot, and Linux
boot. Functional test coverage is also added.

Restore myself as a maintainer and mark the machine as 'Supported'
to reflect its active maintenance.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Conor Dooley <conor@kernel.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---

(no changes since v1)

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84e6423d89..0edc7385fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1793,10 +1793,11 @@ F: target/riscv/xlrbr.decode
 F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
+M: Bin Meng <bin.meng@processmission.com>
 M: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
 L: qemu-riscv@nongnu.org
-S: Odd Fixes
+S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
-- 
2.53.0


