Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C6606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=gBM2QJnl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP08D-0000xV-BR; Thu, 05 Nov 2026 11:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP081-0000wb-Ip; Thu, 05 Nov 2026 11:15:53 -0500
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP07y-0007LD-SI; Thu, 05 Nov 2026 11:15:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyJ90oCdQ0PPLWEr4KHPmI5+hFwnSpXtAICtSrmycwiLSlBdLWYEJMeycP2uedUQ3n6naYhHT8/Kfjy09iNYq7hi57/tYf5k2rl5nWLKJdCCIcwFQO2VFcZnd/S1PcT5rl85/yrz1BHZCq6mGDIjKX4Pm8Y+mCMF1I+KVKslcVl8zJj+2B3PoFcWusjaYWfpd/DUF2ZHGj/VPxJ0pJbiL+isIX0129nT6jqwcwBJYqqf8cYuFILfXjj6NrTMbSnq87j3ps0nxTSBUPgGBX9ZFrH8wn6eh+GLik6C896eC0KmzSq+8bJEff3TonFEp/3b0c5U1yYTRnj++hRRRIIfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57+MtUfdSUEVsUIvO+TpcoAIxH5756fUauf5vmVeZS8=;
 b=YZUb/VkP+EsjI87WkRkY5AE++eyp7FejOmQRETX8HdwNshsl1wT4vU3A9mg9stzxm8XqT7GA0/GOulRWDGN/bZT9hWQRSUjuqo/8563MnD7rZSwpNaCtFt02UCLkQPt3VDxzzvPZY9cv7OqALgHEh1EpO9P1jRZTSJE9nQy7NzZHiI0MKHnASlAyUv6o/ZnzjmtYJ89uZ6h3rVMSaX6/LOsYbslo5h4GAuIKl0q2beqDUqOTh3e0M4xWt5atleh56XVeErWVc51RKqCej0gr9E6Qw9dwMWQf3qaKzyX4MACPxhIpK2IGFpP/vb3uX9IPf3glXppBC5vcaH8w3f10qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57+MtUfdSUEVsUIvO+TpcoAIxH5756fUauf5vmVeZS8=;
 b=gBM2QJnlLO50zIo8YD/luz+Rsh8/kfBIlXqMqICpxU0LrRy99FxM0lw7suWUYsubnSKid6Rb7XXzx9aru6IgQaPz1zUsRR67YWAsVu4p2ToX57yB0pMlp3aXy4R6UzuqNdOieRE5YpbbwEknkuy5qp80atj+jpXu3UIlu7snybLL5JhCvMA6VFPUs05mtOHxKpPHzDzXsf/VIqUF0u677Vo4MrLj+ZSxaLRGmBklGW0qNpJdzEIFhKJ3UHoDibhoF4iJVio0Egqfbo/zcgWV1akFGLItt/XZbaJ/kJQH7fB7mlXKnr4lzZx63pextCYM7A9IXKCuZp+7dEaqTlmjjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB11530.eurprd08.prod.outlook.com
 (2603:10a6:10:60c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 16:15:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:15:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 0/3] qcow2: fix discard-no-unref=on data corruption
Date: Thu,  5 Nov 2026 18:15:12 +0200
Message-ID: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0182.eurprd09.prod.outlook.com
 (2603:10a6:800:120::36) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB11530:EE_
X-MS-Office365-Filtering-Correlation-Id: b78a4e83-92d5-46dc-2a2f-08df3b580bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|23010399003|366016|38350700014|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: TW3X249IngRJIvCviGlhEie1a2tB85EqcxQUFuEeR8cgGfvYpyc52go4J2aVIas3jdpu7Jgbrq5uvhVeV0wBAE5iGVvbIqFhPdWDMhNBsVFU2jK9Hh8H4gLCefUG0XybthCB5rWfhG+pJsmsJJHKmE+zd3qpgqioI7gTofRsByUi7lQ4sgLo169PjwdqUvfL62mHK2G/BZdu0v/N1rVrfql9PNYnpklDWsPLrH205WQAJofJkYExRelcX5nHr6vHIdAzvtciliG8dGGodCuVqTk6FeFSOaCLz7YIO2T0BogaqxHZY6OEjPyYE4dETBsJpRsOiSZqKswYx3Xy4wkKr/eCzBp5QAzJ44iyBMWlyXaHtIBEszkKNwWdus0HOPezhcVXGeCFhsQ+BvN7chmX+AIMst4MmgG410zxdYrTWUG+uZIdoBp3MF9TVlzvSD7RKeQMSEGhkqHjJQmV+MlkbDRoFmKOFmck671s+hJ/eW54riJAx5Pukru78Mbg933nXM2msOccMiDfbZlNAEEOvQHdPZmxdVNq0VINrM8VHtDQYo/TcSNnvn86g5xe5jL4EBNDV3UqHvJs9GP2isKGV6CmaVvoFYGNfj0PYqbC11lrg3J4JeSQWcAt9EUO1HzVv6+ivbOGxdPiNuBeF9SlzUNwC/NY2N1Rfj6NSk955lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(23010399003)(366016)(38350700014)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2BwfjOoxrTBS3LcW99tPjolNWQE+DQwro+51PlHXgQFY/HRIlBRdSux8eI2q?=
 =?us-ascii?Q?GqUPg+ommPrE3+YGTLYySy2E0np3lQtf+shMcsvTQcbhIOgvWhm8r5Aqcm41?=
 =?us-ascii?Q?ZOvJj5QVdssJivH6BzJAJXi7GtLSFkj2jK2T2XB3D+C4M+s0PygzMC3wBcCd?=
 =?us-ascii?Q?33dFiC2YxvDbF6IdyfiGlcjJRNpIkaK5kzXOVLWUPdTepKhsx43TfAWCiu6f?=
 =?us-ascii?Q?vVYcK6Xu/Msf6toWVkdx9egOQGHjCDdrbjBPISRUmdS9ttPVcgkCNiR6CuOQ?=
 =?us-ascii?Q?9IKV+CKJHcxsaIIxJq9kE1MgfnC39ptrqi8UUJgTmx4S78cBwZmcoP8Xbpe3?=
 =?us-ascii?Q?UtSGvbtZIq1Rjoziy0tDF4sVkyWhsWyc0wdQX+9wEGBf0fdcuD8fLm9cXHSW?=
 =?us-ascii?Q?2LlArsdNrqsrjtLSNIBcLg1MoVuSINTKGSjY5/CpVf0GD6xhp5pn+jFyyCfM?=
 =?us-ascii?Q?jysL8XAr+bxqjLTgxaWZpl/Xt9nbXGaXBdqlXGPwqI16YkIt9fbKjGC/+M4F?=
 =?us-ascii?Q?HVIdZyrPDIZiC/1dnSmPqcNivUR1bz9TxLTVvJC3wXt8G/QjQ7sSrljwEnFP?=
 =?us-ascii?Q?4E/Rhiv9yk3y8w9goxk9m076e6HdTN9j2EG79wcxbutYhYACc5ejnEIC8tdw?=
 =?us-ascii?Q?gh0o3UgollxTON8NmE5sRWa2TOaN1jDFV5NkwrqBP5IFdthM4CbvgJhcRB43?=
 =?us-ascii?Q?GSWQbY1opoUP/e9yH0Qqubhva8kjsjxi3c3q7J4k9o4dA/+wjLFnccR4EPww?=
 =?us-ascii?Q?y0bUwcmrdqguk+OkFdHfVaoPBysqOns+prLUYRqr8l6INknX3SF83OuoFNAs?=
 =?us-ascii?Q?jMeZK4YBSqqNHO9XfHnVMEJWMHnHyld3PuafoZtgmAAmxCM6NHVisODLmOcP?=
 =?us-ascii?Q?sNziYcdpY6Fpd86XXgLVLMnkf7fikl6YJ63IIjIQLGubV4UEZ6g2MmzTd8qn?=
 =?us-ascii?Q?nwfLyVmweDjs2uiWih2yxhR2/YC56gljIouncL1yJwZV8FemKfPU17QGVZTj?=
 =?us-ascii?Q?lva5BJXYat4YFXIDKLR7rPEkRmeoLtNKJAOIxty6Z0+g3Oh0WTImEJjryMEu?=
 =?us-ascii?Q?jX3Oya6z48FO3I2C2xnTiJo6SjnR4nG2igH+W2DqDCMt7PlAoyjsYNb1QPCU?=
 =?us-ascii?Q?LQKa0svsVxFDDLwzHhUrFJJur1g2EcFYW0DPmy84kcWU+85IDsi3f/UGgBl0?=
 =?us-ascii?Q?2Kw1K5YtSmHGM24M9hg62vUty5qzCjWYk7wRqq8xGwEWPl3Brig3I8Y7Fq63?=
 =?us-ascii?Q?6jfe5WeA38DzT1qUVKkxsj0XvNV4RtA+QesY9dXzGSl0p1sZIIzuMrUhjdmq?=
 =?us-ascii?Q?Qcx3+JuCGSYPIJIFeJo5iBMKz+O26LZfWEfWwe8/ikqoM/A6cMR6GWlQZyMd?=
 =?us-ascii?Q?NBEVz5F56O9Gz7AMYGpw1XYneTs9Aus7MoR5acl/bgI/r5t3HfxB5DI9yYGi?=
 =?us-ascii?Q?nMTvTn9q6+SC9H/sxg+SluH+YN/IwYxx4s+e0egae+s0GFNV/pbUsm6omJtu?=
 =?us-ascii?Q?YIw2pbkDP/HUik/N+/1NXyuHZj+9FZQtqEwg7LoEM+R/qSkwObml/sUmV3FL?=
 =?us-ascii?Q?GEt4VZyX5cltjarGN6Kg+SVdOoWGCb7jKGPJL7WVOu+NnXjJqfpySN4aERDt?=
 =?us-ascii?Q?6HfS7m5NqU6B9P3D9lgseiXIRarn82ZWZrz3DyGoMWPqov4NnCeFgOb4kIcF?=
 =?us-ascii?Q?6BvBQ7mV0HiMQD8gzCLyqqCv0wk2ErJZNFxvvav0slithSJcbcf9rii0HzVB?=
 =?us-ascii?Q?n9trktev5OkkDpuOt4+ZtCx7edkSgK0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a4e83-92d5-46dc-2a2f-08df3b580bd5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:15:45.3198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ww1WzBZoGboBbVPtl6ZVhX/HaXJwe7gL3GwUrWnljquTWe5Xq4wRixLNEkOrDDiiIF38Cj1T4TvU8e9eXhrUdK1wBxbuj8RFwazNbkwEJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11530
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1 -> v2:

  * Patch 1:
    - Add _require_disk_usage;
    - Clean $TEST_IMG.nounref;
    - Fix -fuse test run;
    - Drop R-b's;

  * Patch 2, 3: add R-b's.

v1: https://lore.kernel.org/qemu-devel/20261027104441.830212-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (3):
  iotests/290: add test case to check 'discard-no-unref' option behavior
  qcow2: fix snapshot data corruption with discard-no-unref=on
  iotests/290: add 'discard' and 'write -z -u' case with a snapshot

 block/qcow2-cluster.c      |  6 +++--
 tests/qemu-iotests/290     | 54 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 33 +++++++++++++++++++++++
 3 files changed, 91 insertions(+), 2 deletions(-)

-- 
2.47.1


