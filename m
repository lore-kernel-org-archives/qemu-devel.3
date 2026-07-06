Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6037C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5R-0008Oc-3N; Mon, 06 Jul 2026 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5I-0008L4-U5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:53:48 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5G-0006jn-2Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6O/OYJT5EDwNUhMfDO0FZ/8LxMEFo4FMuUgHx009CbzZBe4BDc4EGV5My/nXCQZnPaCR5HH4C8ItwU0GqK9yqJ2+RfbqrYgesV33a8pm9LfVYBSN5lmaoRbGo+4n0LGgP4LXSYp5lnvEss1CDb+XAjneNOp8fj4sL0VffMTixHbPeNRC+Jr8RzFBJeTog4fx+1vPoQwc8DGUwx4ZygMCDXb6i1ofyefK0TzAMqXTIROUSOqP1f0KfwDXyTfVz+Lqp7PfTK2PCquWBAJNzTy/Gw8a/jM2ld1QMLAayV4RhYgVb0IH+0AN/ftKjC0YXeSYwXX95rT7PUeA2HRle9qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl8s9HLn75wyEMf1e6cks/oDd3z1TL6mDwKAVviPT40=;
 b=l38GJ2o2cIE6ddTelVpKx9Qnu0ivnbxIS1oQ3SAnHFcKWuk0frP5y45kmmYNNVJcryYwJwZvb+PG+5u2+tUwIK+/6y9fVFr726jSBV5zNeqMjPYE0U8IzV+p9qQ7FEBrisfvVS6fESaxnTpnkxJG1xTIzp9xUio6x30eDLuAXpZCbd9eB/rvclXYQFxj4jVPU78Y6XiwUW3ItOYQJ33X9PpSCA4Omp1VgD+ARBw5HNGY07f2JZZUBRviaHzkzTSPcrIZDdOUZahYAfPWcB5dkWYg8RuZrARNjW9OVhneMg9+piIrS7bZUU+og7X4pSx5PByb7nmiSTnf41WmBTLziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl8s9HLn75wyEMf1e6cks/oDd3z1TL6mDwKAVviPT40=;
 b=GaGwj+ZgqnCVyqo1c/M3cavvb9MMIei2K9ziDWTAzpU1lydx0S8SDhI78CmbQvWDezN9w+N4ONEYufoaYWRv1dQlLpwpXL2TQ0UDqKfVG6Pf3+IvXdriTejxPzq/f0Wz+5J+SQPIPlxriZGdZ35Zy1v6coWr/jXJOm1C1wbkVmc0EVXYd4MqmGar+w9jgLXa/kujovqZh+IfTBnI/P6MobJeqw9WsRfkrHznbpLFhcMtOXmHXg9DW7vpQrSy7muQ1PhStQokkpFojdtf87HVj+6A+tyYvSbiPdGfrNNTbmf0goqCVT0gCCxioIiD9H+6Lz0end0AuFbxBkSPr19wzA==
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 08:53:31 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::4f) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 08:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:53:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:17 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:53:11 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Gavin Shan <gshan@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>
Subject: [PATCH v5 02/16] migration/ram: Use migration_bitmap_sync_precopy()
 for postcopy discard
Date: Mon, 6 Jul 2026 11:51:57 +0300
Message-ID: <20260706085211.13905-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6ebc3d-623b-4737-2121-08dedb3c0dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y7Oc8vGsBl1Y6fZQ96mJXqWmTiydnSAR0x8zw55hphuNBqFsic61RSdzDerKH1M16zsW48nf7H8LLlUSn0chka7Z/2GE0ett4XdV+nECBnRBzZdKLqLBw4p47j5hxQe1xqXwXTqIxTmqvG75tHNiwcZm1UPfOEEpT25lypJgZPz9Og+8QUf0MmjpnVbBnr/BQBCPEnVKSh/ZZXbREjpOGPMOGhnaaRa+JDRq1cOeL+A/LmL/gmy4fbbwKxvGRNC27vbtGrYAVFDbXfuWz9y2fIqqtDFCZUn6hv/LA140XeUrjDJJ350m1kU2rE+SGFaYwWSRb5vkvsxAzkuM6UtxeRcBQw5H9wGyW0Z/UPXpP/SJhYf5WOdBqwq3LDZeZOwqYVV05XPWS2t4EKlfJKxJhE3r4j/JDcoA8wnE6RnDIQe+uF8rP+29VPFodTUML8MD4krOXs3mHJCcyCgyrpxs3L5G89UPctlkeJcp0SODAzJ95pvivJknNg+xTCgtHD/tK47QwsWNCs+kE9AtC1zmyttiBJt5OSGWNGiW/9AuSs846e7+7QsI4QbIonUnEcg/6dH7kQgSmN6WnOA65QmpccDuiTEqezG9jlK4t/VQJOCwFws8qSHpjfCrov3L6cv6XzoUUo1E0hy1TRtT9gLItdur40eF/Z/AHAWb5P0r6FM0rFC43fY3q4IjnMuuV7ssDCcmOodW8Dex3DSoq/VpwQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8HWNX4gyTpkDy4g8TmOEr1m6vQQh0B9NIuAqS4fQI7881mYVa6CmVYHwPUH8GIh93HlsWhtaXl2DzQ/gQz2o0lBiJQMdtjRUJLNkSYeMKE3IHsHQsmbq32LDk8gUlilXsS1nR+UmO6pPvX3+5u8Vam7ELFxycbQUaQjpKQ3Dlx/THJxITutUxnTaoQTeuojZ53yO/RQF3rwdAdYKinrgucU6Z1UDap/cgBzep7jnpnFA8Hw84gD+5SVkZql/LfveMa0jyVZJyzWJzQN1zqIdWFNLN/tbf8fzJrgkVczbzigFQ8PYQSzwHitNkTwPTtcJLUtDouMyXORDh7Sqbz2jOfUotqbKKO/mg7eEDQAjFhbGNr5g2Xhe5T0zyhQYNFVA7yErHmSJ+YzxCzG3RveocGNfNxa30BxwWDF4GNkq23zoYi8kzTsPeKzpusKVHQE4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:53:30.5607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6ebc3d-623b-4737-2121-08dedb3c0dad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

ram_postcopy_send_discard_bitmap() performs the final RAM dirty bitmap
sync at postcopy switchover, before sending discard bitmap to the
destination. Unlike the precopy switchover path, it currently calls the
raw migration_bitmap_sync() helper and passes last_stage=false.

Postcopy switchover is also a stopped-VM final sync point, so use
migration_bitmap_sync_precopy(true). This keeps RAM final bitmap sync
handling consistent across precopy and postcopy switchover, including
the precopy bitmap-sync notifier wrapper. Current notifier users are
safe in postcopy: virtio-balloon free-page hinting already opts out when
postcopy-ram is enabled [1].

This prepares for moving the final sync out of RAM completion/discard
paths and into migration_switchover_start(), where the migration core
can run a final save_query_pending pass for all modules uniformly.

[1] fd51e54fa102 ("virtio-balloon: don't start free page hinting if postcopy is possible")

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index bd519f1931..55aa9b47dc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2687,7 +2687,7 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
     RCU_READ_LOCK_GUARD();
 
     /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync(rs, false);
+    migration_bitmap_sync_precopy(true);
 
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
-- 
2.40.1


