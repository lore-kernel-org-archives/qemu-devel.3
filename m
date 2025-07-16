Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE00C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1zc-00012g-W5; Wed, 16 Jul 2025 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44f51c1a3cf435daa82eb757740b59b1fd4fe71c@kylie.crudebyte.com>)
 id 1uc1sr-0004MY-EX
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:09:17 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44f51c1a3cf435daa82eb757740b59b1fd4fe71c@kylie.crudebyte.com>)
 id 1uc1sp-0004JJ-Gg
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:References:In-Reply-To:Message-Id:Content-ID:
 Content-Description; bh=S/kV/YcAxXkSzIbKGiyjCfmHoVC9Nicn11iDfG+0lG8=; b=PdSHd
 hx0bhGQIFeRiJ3xKat7JRZOEco4D94aP3hBUNvgpoZdcRcw1td//7AKS6ycd5Ix/fIkh+mrxL4lLS
 4kW2TC6XsRWajAT3TXdqlbRq3j+UHXEOJcfi2rN7RIVy6OR/6s5g3rHb8TDw/cDFqstvZ5u9UJcG/
 1mvPSr+BJRON23a/V8LfSNt2VznDeTg2GgVGootfMpNejHVsKuL2FcQw4Hc2X8cWXQ8mZ1EZHRvgt
 8WuDnQhT56SeGdOvJPkWgVHJnwi6PJbBHQkp6mQI6tvCcyvWoPjyRD86Y0b+4RAkdVixsI4nmzcyn
 xXE35LL9oT22mnnescHza2BJnbxvKdOworKaC+7nnqkKQNT8E24nslVmg7nqmSxwa6fUFLcmUOBW/
 yrWbOMXyPFfZM41krWuZbG54yBlzqhMJnzWx3txwGNp70WFfxsdWaONYbjhbPBVqrkEBLTOA19UC1
 /71QmyCksYQof9C3XsSIW9AAYqMOBHpQwjPgkhma93fLnwrA9ZuT5sf74h1FmobkNotcyYHq3uUy/
 Teko4fu0j4gyAcU1xnzdtCkySvJQ/tnRetHyEkud4kQz65PVnj6vAtg0+2dPKIP2jCQd4UcpgcCpz
 W6iCoEvZGWNB0685DthsM74Abdg0qm1V6qRcWf1BJzJ1tZDgie4PaVX+MIzjOY=;
Message-Id: <44f51c1a3cf435daa82eb757740b59b1fd4fe71c.1752669861.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1752669861.git.qemu_oss@crudebyte.com>
References: <cover.1752669861.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 16 Jul 2025 14:44:22 +0200
Subject: [PULL 2/2] hw/9pfs: move G_GNUC_PRINTF to header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Sean Wei <me@sean.taipei>,
    Philippe Mathieu-Daudé <philmd@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=44f51c1a3cf435daa82eb757740b59b1fd4fe71c@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/9pfs/9p.c | 3 +--
 hw/9pfs/9p.h | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 8b001b9112..acfa7db4e1 100644
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
2.30.2


