Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=vUiJCiDm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWGd-0000YC-6J; Mon, 23 Nov 2026 10:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6b01fe7e3381a564dd0b80268cdad80fbe45481e@kylie.crudebyte.com>)
 id 1xVWGa-0000Xy-Mm
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:40 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6b01fe7e3381a564dd0b80268cdad80fbe45481e@kylie.crudebyte.com>)
 id 1xVWGZ-0004mq-2d
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=hFzCQ65PyvX+V1mlUXU+PTiYNtN+9AdQ7ddJzTJAtjg=; b=vUiJC
 iDmxhRRdo7NsOxucsnP70SEkzm1vc9jLlo/rEkkcQOeoGWnfuk/8nTFPWGrM5Madoqn1WcMW6pB13
 BrLZ+pocBRK1lWg/tuyCqqHcoZr0xOxTalT8dfPGF5tW/njV6kzXcYxsf1DT0lWTbvidRi8GdX9rq
 1TlIW5U4fIIRHFbjNt84HxoZQguldC+Uc7h1GGFnyVU4jwYd1EeyLknDxMeiGzls1zaL6EMxgJrTB
 q+9/RATBGGZMBbKCyViiNHxopZ2R2tIViOUM/sTRkrksVwOfJCeTOwx5Vwfbk+B3H8BQ3oX3yolVk
 65jG2F3HLeq7ABxJDzmbFboeV+yo1DR07O1kfGKvLJag9yknCJZjiu8ASaFlSlHkbvkTWAyZpb8X0
 8asDBCJXlsULzKOHnXA1NBDy1W98A5VF9hs6suxMsXQTjDNlaMrIiZ4E0YlI0QVulWnP3TjAnzSFe
 LVlMORwsYZj6M2LTgsawufsKZeE64V58hrIThOY6LyYNjeMIE3UFP2vzpl5AeN9lpltmBH3Inhx9H
 wMJ94nOxOdG+j6hmzbxzVOiKs4o6QokXFoRsLjlOsaQ05Xtn0Ve3Q0AlrOzTyf79aykJ+cO1GtlE3
 qNdybhIpengR+1nEMrJ/YpSAJ9WhKL5bINj6K/uuhWVt9D+OpECwespqoe8RVk=;
Message-ID: <6b01fe7e3381a564dd0b80268cdad80fbe45481e.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:24:53 +0100
Subject: [PATCH 2/7] hw/9pfs: move struct LocalData into 9p-local.h
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=6b01fe7e3381a564dd0b80268cdad80fbe45481e@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

LocalData is the fs driver implementation specific data structure of
the local 9p backend. Its declaration is currently restricted to
9p-local.c.

Move it into 9p-local.h so that the subsequently added new test
suite can use the 9p-local function without having to re-declare
this struct on test site.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 4 ----
 hw/9pfs/9p-local.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 710652dbca..8c8cf53bad 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -54,10 +54,6 @@
 #define BTRFS_SUPER_MAGIC 0x9123683E
 #endif
 
-typedef struct {
-    int mountfd;
-} LocalData;
-
 int local_open_nofollow(FsContext *fs_ctx, const char *_path, int flags,
                         mode_t mode)
 {
diff --git a/hw/9pfs/9p-local.h b/hw/9pfs/9p-local.h
index 32c72749d9..b61f894195 100644
--- a/hw/9pfs/9p-local.h
+++ b/hw/9pfs/9p-local.h
@@ -13,6 +13,10 @@
 #ifndef QEMU_9P_LOCAL_H
 #define QEMU_9P_LOCAL_H
 
+typedef struct {
+    int mountfd;
+} LocalData;
+
 int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
                         mode_t mode);
 int local_opendir_nofollow(FsContext *fs_ctx, const char *path);
-- 
2.47.3


