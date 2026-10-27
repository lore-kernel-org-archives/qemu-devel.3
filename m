Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0544606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=zWiVYL89
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLefu-0005KF-D5; Tue, 27 Oct 2026 06:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefs-0005JW-Rx; Tue, 27 Oct 2026 06:45:00 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefr-0007qr-8Z; Tue, 27 Oct 2026 06:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERH8bLU13wHyjSnc/SormUV6gb9xozDbeA2FIs4+p6gBGQMHwHpnGMFINeXP/uNvAvONDesjOKbz5Gf8XWHNU//2DvSAnRLojEka37WYF+07U7U1MHpIIkN/7/urpvj5EZ78ql3tca/s7KaI1iYe0Pr0ad5mZjtDWhfI1TiZVgMvSSnGLp2Onq6du0Ku8o84Ssome91SMqADEydrh/EKs12nH8OHPak0iQIrNko7mNJAyTjLz9buMhRPe3ARMoyUHYyhClw6r9cOf14Bsvds70xo5Ll8xc4QLfGNN8tfMLWW0A8QZ03vZb3xDMFAnTwiurZyFJyVofmMd5/OqJOjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOBMO+2GV6U5RptyObnXbWB5av49Joz6bvyZBwDSg7Y=;
 b=Lau1qgCcUhUGGenlbhbVCfWIioNc4GfmmyHsraOrmbTbtl3bWtYHODjvIflfdK27u6lq8GtUJt56Deh/okSL8fluBAh1jDyPMiJbvp7DNRXIbrb/1NfNb6FwiRX0LdRPOmvnn7h6ito1sh20TIjNJISNtkd3NljA5taROXkNpWlLhjCkcdBdy698maf459VRmPJgEz1VFfgzPW3YdVHUnK2uP8hugKqdmi+tTmM6uJrrfBvO5KnYsMZ+XMy1P0vB7Vko8MrBm63Mzp9GTsbfCkdBve94Y6Brrwh9OVQsSYsqFztNIuurThjTN5qOMkeBlWdjP7XGyBtA1OjOltKJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOBMO+2GV6U5RptyObnXbWB5av49Joz6bvyZBwDSg7Y=;
 b=zWiVYL89QFtqkIgyyZ2aew2PKNoxmbxsF5OUr285A2UwQCs/4adIuND4IiZAXJ3kM1eA1bEdCIJwW78V5qJCrSHzShHxi2aoZYhKpYDnGryNV+cnJ3DbxWfniQRpxH8B3cNiBkkJWaoFvba0bsfbT/YJVHoM2hB1hPMpG3GkRxTX2HB3zvDyl1z/uDNnKloaNpqoaP6Pp53gz+qG2oByPwZDDh/3XBE7328KnoHIvnpXo3N0g89T9WWIbB9VtGJQqCd+M3rJtfu8g8Sk6tVLq3ST5y4MIBnBnQY/YyYz4rZTpCrFWrAJZJTVSAZhGI46C0TsYBdmk9EzeW1Poxwapw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB8805.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:44:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:44:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH 2/3] qcow2: fix snapshot data corruption with
 discard-no-unref=on
Date: Tue, 27 Oct 2026 12:44:40 +0200
Message-ID: <20261027104441.830212-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0070.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 02af1e3b-3885-4a45-a064-08df341752e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|52116014|376014|38350700014|5023799004|56012099006|261009223027099003|261021123027099003|261021121427099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: tjvn4GjkOEZfcMMxTKQJLf9CKYC9Uz0s39KPDTzwzljq3rYKfU01W9GwuaUuDNwhmAONODPkXvjbTnyn4GQoTdDRoWk5F7Wkk/JKWNvzX6kRXWrM5+nRUFSxT2dhFhZRdOQYkIXmasgj7tPe6A/cDeskmAC1USYMQAEbYKSNwCcw2yqE3V2FWXlguBlKWzt9eLuBcniQAGFuL+Dkre2xtIPvU3se3PbBSrZtiY1r9HPp5Ns5pGI8+EN3iA10mmqjeaup9ktDgDuGVFJEWsZETFyC1z12fJCp80+OtKJY1Igka+QIgHk9OmLihVQCGJjPlHwPf4Dc2Y/RaqB+AVB+DoVDt66ZmWGe6zlObB3s6kgK9PYmA79bjThFuet9yWtxqoYu5hL9l34i7dVbajBSceuJ4VvvO97VLvbPu742O0b918afmc/eeE5/57Eo32J3WRszrmJxnFdsu3YOVxjiKA+UIr0gWxF5GdFMxPGoLHuy0W9iOkUPKIGKd688HLmtAumiDDyF56Nm0KfOn2R+1ZrXxLMy0G7sV00kR6zAGYo+096gt8OyJGIbXZYFgBThtLsQen6/VSpwnMNFmbMF8lwhOO4n0vlftoovedMNyUND/I0CI8u4KjVgz6v9U7K2rwiwtGuAfhfxgcnko0/GgVojgUMQuMpMXaEPdC3vcZtbi8UA74b85DYGsmB4+b9ecxCZfXI03rBhxk/TCsHA2E+7k1/dlnxakNJ9YWtJP7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(52116014)(376014)(38350700014)(5023799004)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fn0NNVqkBYEe06a40u7LJ5rQy7OzN5cqHoOta9Ssidol5aWM/WEoaS2FRKTx?=
 =?us-ascii?Q?x2CmTYaFerOAdYBc7MSqC4HunCZwVKyCnISin71TwG/d0aOKB2XW1j/8bMZ2?=
 =?us-ascii?Q?ZmpPUlcO1dUf4wb3LH/YAhnnsrL6m8J/8pMbRAJRAXHYnwJRRNx4R4CP2kkk?=
 =?us-ascii?Q?ZiKC0In/kzP//OKARz5979vNxWLGay5mPedPgt2ltTT9enAbo/kssbYRIBHQ?=
 =?us-ascii?Q?BUEZssesxAjf4w4Dsdoez8s0lhoxqmjdg8bBobASFPxC7/w1zDQhpyevWpRS?=
 =?us-ascii?Q?yl9G5H3opsF3ZohDnp2m9gNowx05SHwiL8+FG7HylWkfw//yx2F3T09hKwMN?=
 =?us-ascii?Q?17UnYrYDyWsAcW38WG8C8mVW0ya2jCwczr841TZj5tLC7L7iQBMUzTrHMnIo?=
 =?us-ascii?Q?/CXN/f28bZyZxUPJ6s+hrnnQUKzuAlXgnEOuSXy62175o4QTxEE5P7dX/Zu/?=
 =?us-ascii?Q?7NNxHm0JajGt3ZFnkSBOjrSGJDlaT0U02HCAAwKHgs2upxkSu1YOdv/beA5o?=
 =?us-ascii?Q?6PoKiMpmCGlGdkWZH6r/Y01AkEmiGcmtU8FAv+Y8RNJHCKaYDfZMoAPDP3Yl?=
 =?us-ascii?Q?zK59ARL73Gro0NRDocRGZQYYxrr0bE86nsgngsE71gQRWQuIrDcOgoZGY2Gt?=
 =?us-ascii?Q?/4zZMR2dwbElcqvGgtLazunOInvrZ8d1/YwzTFIya0Oxap/XgV+TpYzccW3P?=
 =?us-ascii?Q?FhX7wjLeb0+x2W8IVDYlvwxa4vsRoElbT2RYRLpd+oRdfmGdcd4D5KFTQvqn?=
 =?us-ascii?Q?Uewg8CYs2M4u5AS9ssRMwPEIxW3ROuU9vqIyZPwOsX1BOcFgK6V+KrnW/z5O?=
 =?us-ascii?Q?VZzyqunqiZVlTmy7qo+Ct5VduubyVQK/x3YcEQqLzcfOLzGJZf+9odDoOJnx?=
 =?us-ascii?Q?pxqdd8NlR+hKlgQmde8Q9jrP9q1LAKTZgDdr+IJS9h5wylcPEcD89uqPi9oT?=
 =?us-ascii?Q?6VXvlUJoG1iSrIWLZOre4UXewf9OTPr/vPFbx1YKje2buSRUmWpQfTEa2zWN?=
 =?us-ascii?Q?oMd01zIHoAaxUflzas61DYzpCdqyg7zTfd3QzSx0CKbkEFn+feN0fdKXu8iu?=
 =?us-ascii?Q?9lGd+Jmzt3vxBYcLM5M4AB35FQGuBj2H6wLFHN8WynMmniAzDJQXR3KEM8Nd?=
 =?us-ascii?Q?jMnLTjE0kX0t/z1Iakwoin2rP1UvuETAcR51eFLiuJj97yQN9yFzIYv4EX2v?=
 =?us-ascii?Q?8fUnzPU761PI4GgMNLXg1K70sZCuI2kfekEzx375nusgj/q1HDstRiIQwICk?=
 =?us-ascii?Q?rS8+KmPZLvce8m9bkzgn92SRNiWHCqZgKlFsLAY7AiW5mjeFimsHs1nHfHQy?=
 =?us-ascii?Q?oVehdNh9MgBdlqQS4dtfBXba9jNKCZeoyQIMaQEwbfTE0A2k2tpbV6C9JoAO?=
 =?us-ascii?Q?9CARPYPCwNIj63d9MCKI0yJigkFqddtVLFU7dC3MpcyTP8tFWWyxG/Bfsmg6?=
 =?us-ascii?Q?Tg7kMH9je/kccuiaZwzobj0+3tYlMD6q2kPBlKiohBBmW/ArTkDBOFejFBit?=
 =?us-ascii?Q?BuxpYHoNf9UgdRgy/3jCU0CsBH6hc8WxyIGwYPJPu0vSoMuwr0TbpsXFmgWU?=
 =?us-ascii?Q?YWlkmKK7SaDKlbfr/Jk+p4EbbwDldz79Fy8VHcP2QI7esHGn+6+1Wq+XDgMz?=
 =?us-ascii?Q?rFtnSikHBLDVjzCQJJQAekUhAT6Y2ijU8OIpAXIhJLxvwQA39kipBRyNedie?=
 =?us-ascii?Q?Rf/iwT3D32vZSbpzjOYCKmlYAXOw/ljPrCtCNvvzx1PNOSk6fzE1Da+AiQ3h?=
 =?us-ascii?Q?EXegbQEnjK0ULGDO+2aw1PpM2FZrXU0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af1e3b-3885-4a45-a064-08df341752e7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:44:49.0752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3+Uq9+ucX7PCa90JGfERYON3Hc4E6HCVS/xxVfhc2LmWxe7NGXH9JMFxcW5MeIyMQYw8q0wjnMWrXpoj0AQp6FYTEKmZy/aCCkAK1kb25o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8805
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Whenever option discard-no-unref=on is enabled, we bypass refcount
machinery and unconditionally punch hole in the data on 'discard' and
'write -z -u' paths.  However, when this same cluster is also referenced
by an internal snapshot, such operations lead to problems.  The active L2
table is copied before it is changed, so the snapshot metadata stays
correct, but the host range under it is punched out and the snapshot reads
zeroes there afterwards. qemu-img check finds nothing wrong.

Fix this by guarding the 'keep_reference' flag by the presence of the
QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
punching if we own this cluster exclusively.

Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e02fae6a0c6..cc473c7c796 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
         QCow2ClusterType cluster_type =
             qcow2_get_cluster_type(bs, old_l2_entry);
         bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
                               !full_discard &&
                               (s->discard_no_unref &&
                                type == QCOW2_DISCARD_REQUEST);
@@ -2097,8 +2098,9 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
         bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
             ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
-        bool keep_reference =
-            (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
+        bool keep_reference = s->discard_no_unref &&
+                              type != QCOW2_CLUSTER_COMPRESSED &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED);
         uint64_t new_l2_entry = old_l2_entry;
         uint64_t new_l2_bitmap = old_l2_bitmap;
 
-- 
2.47.1


