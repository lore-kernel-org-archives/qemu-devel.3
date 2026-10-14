Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864A2CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnkU-0006it-JB; Tue, 13 Oct 2026 21:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnk1-0005zi-8L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:25:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjx-0006wT-OU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:25:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXAPbFXAEJd1W5ihF/GXpfDBkxuxehQPsNtwYOYYFDBDAHD6WhdViu1RQFvtOdMxeJHURKv2xOClcY/7WV4uGg9i0JgmuF+BFDNdSlKigkraUMswVP8agUMXOaIS7APiR2kUAWV6icqoh383WbEDnjZHf6FH+XhWjDjd6YHaP1oQuzwMhS9VlFepEnL8heXfc/9ee1FMDpOrnKXY3+pzmeuDRyY4l5g493Ew70TSPTszWM1RQ66zdXYrCQ0AHFpu/GK9K0ppORPAZb8ixN+i8lSbsfadv/l2EleY3OeTBViLgNCY6/GY6w/8JcAddCzXcQ0vcYc8GUG357/mhP4TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnZAlERhgYWkU6102CJfsTPod2vCtjBfSIXTariJ8d0=;
 b=coBG0tqb5UyXkTduyWmF4aD9SdQ/JvlrP9Q8oDQbnNbM12Z33Jwjdm0VApWT9NIfTzJ7a/MbnQ1pnDVP92/kXIV3MclGLYXKG5KcFO7Qgras+3mb3g2dHyad206wnCzYWhDBRDxCQclYgQvP6J7gStWCUaVQx9VnZcyzjHsXaFyVAtmOb7LtF10+JLd61a4ACMMlwla0HdBA0WsRgKMfIRPRfEXeGjdSEykRSUG+wJxi9yM0zkk4IRdl7mu2SA9zTe/2A/ViEeP1G3kvcRstavyc9LKJi6WVHjYNNsi6YdodjXHZxDOo0JLCgtlXLMrkSHVcpY4pIQNb+1M9WrQARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnZAlERhgYWkU6102CJfsTPod2vCtjBfSIXTariJ8d0=;
 b=gf16hti7pzwBJvaQ8yEX6CCCvpp/ynRIQTztQIWGBIriG+rPcFOI6a0NVVWR/prHZhILHiQub56pPiI1qox8VSHUIrsfqMzBHxt+9abHhs3TZmeYwytfTbs7uDMFz0NO+hNNkcGszeMTUxhTygJz+Pnn3jGc7cXV+LT0XO2RTyhRzk6EoAVFErnRsL2zLj7ZMlNZb2xdNOvEgWCuJBVcAO5fgEFW8GNBz4+Kt3glhFuNe6RezNUIvy2J6QhDb2BHpz2Fc1zD17wIGdzwvbzb1m/JYxNkiE+ToQEMVgSjD0xsuRt/kt2S/EInjl1qUyPrz39a/zdRjAO6zU8nVUHB5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:25:01 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:25:00 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH v4 27/27] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Date: Wed, 14 Oct 2026 09:23:07 +0800
Message-ID: <20261014012323.322790-28-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 663d68e7-d925-4879-d738-08df2991f723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OVm6ZeQmxzKBQsBdEoGzo+VUerIjjfXfDeHw9HDRy1CtlyEv1WXe5ouq4he2uWWvurM5ZuyXnbEEbcxwPkafRlWYWZh+spo36EovQSeMdGplrj/F4rAdBQGH6+0PBoPB9m83uatwfpq71foYtXbSHSB9BDEuzFzoyURcSG8n3yzbA7Ef43wv3UpUkxYyIAHcy95LvF6HC6nDo0FnixjhR4BErBeBFkyY7iIlw5hggsHSrIXzo72wtK4lkfwnHAboocYjLYCR+8xti4ZQUtsfm3lelzxHphG4PmZk2+kf2PUNF3qXYx+YeoxlRh9TLu3BpnpIifCTCzgpCJmTFdART4k1B83F6VqLw44KaN8piTDFxFhd/n0jEB1pii8V299tBK9aPmqxeqnOxwVqbjrqhLgIf7A3IGOVRgMhn6ZVb+hbveS1/li/NELKeWOtEz3PmNdgLD8Ei56nRTKrDdAZrpw5JDDGDCI0Y8cQG4vOBshgEYzZwIgrFOV74i4KzoIXo0VTQp0VShKhQrbo8Ad/AIh4F1HGvT+5s6QfHUEnHF9P9Slw7umcagkWR25bZJfPsBz5I3MESySe0CFivPURR/9a0Fh+3kEY1SyoNnMUN0WfCJytRhh6QBbB4t/KGaVq8qpgjy3gNDtgtdI758pWou9ZeOSDp7J+ufKiWcseUPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLCedf8+VWl2bN1030TqLRzbqHclbD74mJr1EJhQd5EtIZiCYwVuZ2+PVRG+?=
 =?us-ascii?Q?CSAwcjvcC1jPXSqGSZ8pXj1ofKg5YS3hhQfbtGMP7ON4jkvpXDJXh2HRKJnH?=
 =?us-ascii?Q?bEpbht0rPVZ0UgslC3Z3LOZ5K+9tcpG35tzwxtfBvcZFv/rLlm6tlp6etSJ3?=
 =?us-ascii?Q?bd6Pt+aVD5gkeRUhOPH4POkfWCQYNfXq4n4BOEIzsAzP+DsA01P6ldtYeIL4?=
 =?us-ascii?Q?Mb64sJ8Zfy39ydh9IEDH8fVuoW25uCLn8NYDZguFGCnXt7m2tflTyaKIRySU?=
 =?us-ascii?Q?vR+nUsUNr/qDfBunaE8ih4eoTMRsXwEnOR1aENyPZfJGT4J07uvNNlU7DmcU?=
 =?us-ascii?Q?TWMapa35xEWtRXWN602LmenlwuQm8TduYlQVpTcONDuxKVz1DCL3PcrN6sby?=
 =?us-ascii?Q?0u0Iv2zifPzR9RTdL3GZZILtps0meBXDVjXajNoKQ7K3aoYoxgisN/Y7mK5b?=
 =?us-ascii?Q?pFLZiiYe4LsP179pSd2+xP7T7Sn3VkrLrMZ1uqHrS2dlr/SFeqM89kMoNgP8?=
 =?us-ascii?Q?w5hQfsa8Bkt6DltFazg2rE7IofOzKDqhXS/5c5URkw2uixIakgGIgKZ4syCx?=
 =?us-ascii?Q?oYmTLr4i5dKKtzR7Wg+sKLCZOTttw1GhKkh81l13tqYB3YTr64oeyeeq6UVh?=
 =?us-ascii?Q?EaUsGF34KMATGjmVkYRaMMkXrYMRnJpk8CmykV9MeZuuqx62Req3EbDSX+fS?=
 =?us-ascii?Q?Km6EjSAjd/AP5Pjcfo4q0PYW9kMwI9E9OXqC/NNZ10/LKBa52ATCu67ivvan?=
 =?us-ascii?Q?8Q4qZ6jJFrnLaTpgoUkOoATAURKOkaPzNG3Jnq0r+zoDhXZ8D3rvmetEEe6L?=
 =?us-ascii?Q?v4mfN7FO07cJDGSObJS10Ep9attN21GOxHJTocoQeSdnSuMt0aRYKPnmfLef?=
 =?us-ascii?Q?tfgkEIpd0dHIKQuGEJnn7RAdk5ssr8Ag/Wta17pBVBmNkbXGt+xJa+yCdJeD?=
 =?us-ascii?Q?nS8qdZc+XnFbutadgThJn2ZfpRySvTlk6DwiaASHIWiZVGAJiJ6I8nlP5NY0?=
 =?us-ascii?Q?O7oCXyLd8eSJvJcqP9ZMJw5DMG2wi2KNX/bXhQHAGOsW8hMATnCzPyQkrkzJ?=
 =?us-ascii?Q?oSI1f3uaJHBpsjaM8mVM7e+ewqHsXJPuzUND2ViyaAhdGx3C4XCJ42FglSY5?=
 =?us-ascii?Q?D5O8Axg/KfV2Abg+QZx9JqRWvSCPsBMNwy5LINtL23FDJ7ArpfNuAcQ2gshK?=
 =?us-ascii?Q?ho5+YrkWVUebcuf4KjMefI1/gU6n8/z6Uw9qjOA8p6PnCZNbTXpL1YVtnNe8?=
 =?us-ascii?Q?gCqX14P0AILcLnt1Nh5cxd1iDlS3CEBoU4olkjpAEudzw6dUFRetYC0gA1rt?=
 =?us-ascii?Q?N1KclMLAEsHiQacutTGCkkkXcg1qp8m3SomtmPhXUi+AGZ7zoxqI56DIFOzG?=
 =?us-ascii?Q?SISMFdCic7Q5B3cxVjQE4nO78X2fcCmb1g/h/Vc+kua4JIJJ34f/z1X0U5fa?=
 =?us-ascii?Q?ukFjAkLAAXOE6UHQBjPKY19K8ksepQ5VgyZlAzSprep3J5n69xWIoOMnRKQA?=
 =?us-ascii?Q?QdvshcQkbgVdhVeAQKWEebUbmPiYQP6OS/u5GdSZYMOHcD5sPfS9kFwRQeYs?=
 =?us-ascii?Q?dRv8ZlJkrt+1sd9RR0lX6XKkwkMtFvRpzEmH1ZHE4u/Q5vhUz2RQlyGXts0T?=
 =?us-ascii?Q?Hpc9zb3GnITCv1AA4+44f5E8c77LO6boBaYrKYz8mDAhGiWLg/nE5UfAYghU?=
 =?us-ascii?Q?CwoEB2pGP1gxgODhsfE3jSYEbEYWb1PoYSu1d9cclUcavrcYSA/XyjtG2+yX?=
 =?us-ascii?Q?9mGBTJoEYGqBf0H949XzoKXSTmGJ/zA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d68e7-d925-4879-d738-08df2991f723
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:25:00.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMEavkRI9on5VlPMFFxxLwKJIhIedi/x/+DAxqjr2V+dJUiC3X6d5wUC9aKW7xXjn0QIQFbtYWRwQW+a6JzZh3QVdMzB/CzRameAIER/b5c=
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

Conor asked not to be listed as a maintainer, since that could imply
that Microchip sponsors his work on the platform.

Keep him listed as a reviewer so he continues to receive relevant
patches without suggesting an active maintenance commitment.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Conor Dooley <conor@kernel.org>


---

(no changes since v2)

Changes in v2:
- New

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0edc7385fd..40232cb65e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,8 +1794,8 @@ F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
 M: Bin Meng <bin.meng@processmission.com>
-M: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
+R: Conor Dooley <conor@kernel.org>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
-- 
2.53.0


