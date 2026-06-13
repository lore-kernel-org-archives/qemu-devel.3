Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BCCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUR7-0005vl-5s; Sat, 13 Jun 2026 15:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQv-0005Os-SK; Sat, 13 Jun 2026 15:54:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQu-0004DQ-8B; Sat, 13 Jun 2026 15:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380260; bh=ljiZBRqzHv0X/sjo4RwbqU2uUMc/lkd7pP77zy4UuEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TBSeaBUpg9/cIQ1HZsrlRfo2Cog+Ms9LVuw8nUnDP926tJwhFv1D0rcqACbVgBfXp
 oknI8sS94N3FTgl/oRMl8ZphcF+54kbwgPuR85PxcqLniwDjtWnuqzTaCt9iRsLbxO
 In16jNtm3MAUa6EWwl5RK+gZQFyRbvKPVnJDb2qA/49mbZgfjSXwHFki8GUGECj8HR
 qYT+o8rTbfBLV0k2h22otPYPlnLdAVVcIQFdK5aKpaMukpMnz0w/jfV0Hrd9YyVF/o
 9fNT0+thn5PYAhBERTk3BJQJ5x3stelmA8SD0B1OsQYYhdbz4CLSXfas5r+bt3pWlc
 LujX/bf8xqUHw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27DE21B6E31;
 Sat, 13 Jun 2026 22:51:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F6F23CE8AB;
 Sat, 13 Jun 2026 22:51:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sean Wei <me@sean.taipei>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 34/56] hw/9pfs: move G_GNUC_PRINTF to header
Date: Sat, 13 Jun 2026 22:50:48 +0300
Message-ID: <20260613195116.1807273-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Sean Wei <me@sean.taipei>

v9fs_path_sprintf() is annotated with G_GNUC_PRINTF(2, 3) in
hw/9pfs/9p.c, but the prototype in hw/9pfs/9p.h is missing the
attribute, so callers that include only the header do not get format
checking.

Move the annotation to the header and delete the duplicate in the
source file. No behavior change.

Signed-off-by: Sean Wei <me@sean.taipei>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250613.qemu.9p.02@sean.taipei>
[CS: fix code style (max. 80 chars per line)]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 44f51c1a3cf435daa82eb757740b59b1fd4fe71c)
(Mjt: pick this harmless one up so the next changes applies cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 74dbf95a63..bf05b1b6c5 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -201,8 +201,7 @@ void v9fs_path_free(V9fsPath *path)
 }
 
 
-void G_GNUC_PRINTF(2, 3)
-v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
+void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
 {
     va_list ap;
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 259ad32ed1..65cc45e344 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -456,7 +456,8 @@ static inline uint8_t v9fs_request_cancelled(V9fsPDU *pdu)
 void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu);
 void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
-void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
+void G_GNUC_PRINTF(2, 3) v9fs_path_sprintf(V9fsPath *path, const char *fmt,
+                                           ...);
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
 size_t v9fs_readdir_response_size(V9fsString *name);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
-- 
2.47.3


