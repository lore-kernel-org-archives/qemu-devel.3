Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C19DC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKN-0006sH-37; Fri, 04 Sep 2026 11:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKL-0006o7-Ox
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:59:41 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKK-0004Wv-7e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:59:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9MAEW2bMO9enfjl8ditLnLf1XAeDi/kB/bZGHiGygzeGJJqD6/pBL9jk/A5PnYnIH5RC2+4neZO3jmaXh37o05Mqt2MCVFvq3YEZIQT7r1/fraWTz5mMkpVfOwVtO8Q+/KaOyRu/8uRnoQfPPXVnx/KIL3sa77CQALJoaxAAshQxJqSjgRZEd04r3TiAkFVLy8v8k8oSPuVZqQOjzrOPk9ZApRQHsCfkkmMH1GTq+0jkcnStrcW48sOT7h2qQY1lsQpdiuYqNdaA8eRd7eHvkh3TkYTJmitYCKwDssSBBvkxeHC5aZInqkImIWNVrvz0X1S8TRP4QzmzkzIP6j95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m1R6JTJaDJvTaFYMihCBVljVWPVYaTUziVR474Mugc=;
 b=FptU6w4izGpsGwpLbqwwouiqE6qfrDAm8xeN40uJGoUhoPUgMZobn8q4uLEp7s0PgolWQ6nIcFpn/1djjDSx/Patm1zfZJo2pLaJQnXS72cIlAcGi0KO5wUaGIsbLEYi2l0d2DZHAOJ6rLiuvGEmGaBnsnF+EkcO+tKQ560OwRcbeINQZQ3yQDjiiLPdJCins2r8rCop7tUlkCB1jSzzeDPLDN54AdcAYcFF4i0aEPHmAJ/oB7J/pjscgSXrqBVgUxyeAKJUxUwMOAAvLQ9CStZTErtaGPYtnsplLdKyGHHWJVyme/icIVzpkeH9lbel2j+Izub76kkIsNyvhT292g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m1R6JTJaDJvTaFYMihCBVljVWPVYaTUziVR474Mugc=;
 b=ERLtdEWOdFli0V4C9p8ZpCc2JbP7F+AR9g4wsDfQlXbLgZuNY3ZX/4Tf691u4JVeWr58LqPll2bZqcqhhXwZ7xBGzE869j48D8dvzqMhvMiF1OkQzOICJiP1Lco0d+odKrGV+GUhEq7XblEXY2ADnVu4JWhsmEduT43T8/upT8H5wsYnIAhlHFw1TCEyrt2mOCcAgU0i1nVILThg5lw+TK28Qsa4Yvv9UpGTGHDUHTT/rjst4XL+JeqXJGJa3gaGjqKjtI0XuyDcfuRxIv1ck/CEtVNuc8UwtJqQaLU9v+x1jkAUXoM4k6VEQFufMvUTJ1XoTvgupo2E4IpZPVGVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:21 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 24/24] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Date: Fri,  4 Sep 2026 23:57:43 +0800
Message-ID: <20260904155758.3833179-25-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0e5190-51d7-447b-10a2-08df0a9d7b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2HvoBcr49V0o0e5KTym7O/5l9E9RHiDyUIo4dAXVBwD2dqGVBWyK4tt0QQLHbk6lwS+b4CRBuJVyS/ZxlDzAs5ZQwSZA4j2uGOgVP1iXHgbcde7L5V8jdnCNeVisN5VeXG10LpGa0zfe1hAbScsx/iJt4+rpYiHBh06uMJvMFzU3HUGoY1Gr217qCn7DGMCpMAlPIU6QcCpd7RM/4dD/NrSIhaB49tlNphp4+4YRfR/2/UExB4v7qwdd6KX9M3THiC4JBsj/DGcWi2IU5HGZpIl2KNYiHhnH5dDW/qZSYOi2bNHjluE8hUaZbGqqcM3kyy3nJuwZpPVgCueEXwAdGCEuDzcWdAOzkiczL+OytaM4cSU5UxCzQtOZ1VXve4k2iJZk7GG7A4hF80M0BTqc4XsBxvtA71hqsl8ol/hD0HgJLgxRpd3JMAeaE/Lq91zZOw+0IYQmLm4ykZlFOriP2qs7dggyNNYoAcwWabahGwa1JKzYdvYGV1YC7GzPslTe/R41RziPqxDQ5Vzxn8BCN+CYGlu7taiRmtGxNH4jwGZUMbjkjQAoeRvq1oCr+IQ47uFH/quoIuFlVdpmrFWES3Eiz+KbVbsoQwgkXYMjy9tOC/fqvveow5617KcP2SB9Qxp/E3bT++6SzSbivptPqCjsKj+CvJZS7R2w8bn9/Y8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eb2khcNr8KykBhrBFnan6vASyVthhpEadRJ4Msjq0EkzL66o3XxsJ4Cqou3t?=
 =?us-ascii?Q?o7n0zALrMAbB71SsTuY/xtSobY5QA+0RdCoe/pSmk5xBA/+T17fatQRbj2mn?=
 =?us-ascii?Q?zc6WeN7jNGDUrhRpDVOaAnr6tkrGLBKels125LbroShR7tPbU/VFDpqiOJSF?=
 =?us-ascii?Q?6BPHnaEgGt+N4fUEEnlpJ+G7IvA8lCJnWsvu4+1TPQDrB+0jWUZ6USxqOohg?=
 =?us-ascii?Q?OeYvzXrkU45gEYnJbIM2I5cNgWBnyEF/RaixUjPgzCsiw2t34ZZWbM2Xgu8A?=
 =?us-ascii?Q?r+kD4E8+kOMXwePaESg2kSv+FrnVlh9HbOj04h9X7fjveM3kAaHhxAL2g/T6?=
 =?us-ascii?Q?cQmOK60Sbt2mCg2x7jsuMHvtMcQtAC8omCpIezFeSt8p+NMsnjiINfr40n0d?=
 =?us-ascii?Q?kvdJJYRj403WldPf41EA27ofJCW4VA2y681aVjCf+xmFo/zjX+2LqMzLxKCy?=
 =?us-ascii?Q?cljBkq3rMEJsuy0q0HAancobGEA+RFTjNR6BzH+m09vSh6xlbw6RrL/GdLBw?=
 =?us-ascii?Q?WfA02A1wZO+CE0vuDPbW7RX8NN73DNBYCUA+l/byDsUkNNhiizJhs0++7OU6?=
 =?us-ascii?Q?zdQIPGzkittTqd54QcpRQ6fcccR9UiaO7xtIrrlMSKtIcu4v27ZisqJWPQuu?=
 =?us-ascii?Q?SZTBgTEHXtrhch+2bHaIJtlE69RtjXp6P+Thf696DuW0qZDcXy4L04nBZeNE?=
 =?us-ascii?Q?wM1pkoWaJRO43Z/C/A51TOgtGqmUKGgveWMfx/M26mylD7iBsYHJUpU2qnES?=
 =?us-ascii?Q?nFS2P33trZt8ssVCXc1agOP5oKzlmZ/5jBqnhYn4m1sZCFEVWa2IAFcD+JT2?=
 =?us-ascii?Q?nXlaZ8HGrbqc64K92SqtXiuhLD5cEsQJRfvStoZ24J3tBO92VW2N/yZqibYr?=
 =?us-ascii?Q?X7D7iuyP16X5/KiSYOv6d1HaHdQpR9mXkY6Z+vgGH4aloHZbXYH8bTfhSjgy?=
 =?us-ascii?Q?cnXuSn4wR9MsqkpiSSH5iJrD6celpnGCUbV1au7x3VQg3Gk2CeLlI8NUkqcj?=
 =?us-ascii?Q?OzuMHYGPFrPLwKvfxXvOEyWk89pbjndLym+EYC2xWKY7AMbpjwOP+4W2QKWg?=
 =?us-ascii?Q?4NjU8xCsr5JhnVqo8hSVZrymrg84iX/h+ZY3MFdZeYJjNj408pYNtzbHYQ7J?=
 =?us-ascii?Q?hKAeQ1e7qjf0tjUD1JYDxfcDtM5iril/C4HMFzeMMA2gbCpDNoEC8uCNLxSV?=
 =?us-ascii?Q?cKNrFlvmKx3Y97bF38VxII7AJjNWCv4aenl+WS3Tbxi6/sC/3Uk0kcCbbRJc?=
 =?us-ascii?Q?7RS2O/TBTjBROAx+dLpw7t72p1NuiwrEPcwxVxPLqkzGaGnqu04DEj1sgpsp?=
 =?us-ascii?Q?zZZTo7ASXh+gVgYwCI+Be+EVSVupGwmcUxjsQIg1G8rULrSf7wZmO6MeTQmh?=
 =?us-ascii?Q?BBde7tMcJKaVg6l5qfzD2mSx8a3RM/v7ZCn5w6WOxgpViY5bp3U4U/yXnSAy?=
 =?us-ascii?Q?wmincVRhr+ezT4MIP8R2cBznNcUi2NktJzGZr4tBXw4QcV+3IMsyGAG5RAY0?=
 =?us-ascii?Q?xi6Dj/bX6DQfStTSYJTLy6wR6yITeuVstxNSIdF5rSS+8yufKWNlWX1zmnr3?=
 =?us-ascii?Q?Wm4guqdtAca16Yf9KWLVaub491Y9QOO7fnpC0vwHgUVEmzxLsw8A5ict8wll?=
 =?us-ascii?Q?W4M0icRirRZs0RdX3hdtyqtGMKxmauXFBQOq4Lgj5uMRTwz+oMA3ggbo56ig?=
 =?us-ascii?Q?AJXYyRKaadtO3Spz/5uSB8xisJswWA5t2UjV7O6F2OY+rEEI0ID4/sKBYeX5?=
 =?us-ascii?Q?5b1tK74wf0AsrDyFqQaFcOm8Ot5dYPE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0e5190-51d7-447b-10a2-08df0a9d7b92
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:21.1194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+sadr+q3b3p7HjWYI+Vr8L8AiSM6a+k/vn4c/uBEIsbGg0p1V1Tqh8MXrcCRabNvlxmMywK/IcLWlVzv+CokQfxOylNgJXNN0r4F5cLzug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Conor asked not to be listed as a maintainer, since that could imply
that Microchip sponsors his work on the platform.

Keep him listed as a reviewer so he continues to receive relevant
patches without suggesting an active maintenance commitment.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- New patch

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e68e7eb12e..9590de2509 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1787,7 +1787,7 @@ F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
 M: Bin Meng <bin.meng@processmission.com>
-M: Conor Dooley <conor@kernel.org>
+R: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
 L: qemu-riscv@nongnu.org
 S: Supported
-- 
2.53.0


