Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD434C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmRy-0006TH-Kv; Sun, 27 Sep 2026 06:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRM-0005xX-Gn; Sun, 27 Sep 2026 06:49:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRJ-00011L-KS; Sun, 27 Sep 2026 06:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=WsbtFo2VH6tA7cfuCU4gcXV5c7xrbUvZDCmOb4qTLB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UdJEGOp73o4sFE33AMtxLpZrDmXJP0ioSkjie62aHPKrDb+wpTZWK48ni0Rd7bBSM
 pH/MZBd3N+4Wq9t5MfVHL1jt6BUneEA4LL1n9/7qNv154U7wH2kXV7mcla9hma3MWt
 QCg4HxSzoaw98O1Epol7yNVEe2XAuKQVsOtkFFdg1QxgpEuQqPtmwFbhxMPp8ejN9u
 nUB/CJzSXvabWSLzoVTUgA5Oj7dCWEqtTgp8jQ5Hg2sJZNSk7dOxAF02H5KtQlJP3Z
 AgGTvZQPh2ENFmUEA7prVKCsrxW6hhhm1aC0BugOgUbA75hJb+7or71rnRrj8G8/0J
 NBshgwOsDY4Iw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 746631D8B5C;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 71E05432163;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4FB665E770; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 61/92] igvm: mark qigvm_find_param_entry as static
Date: Sun, 27 Sep 2026 13:47:37 +0300
Message-ID: <20260927104821.196183-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Luigi Leonardi <leonardi@redhat.com>

Previous commit removed all external usage of `qigvm_find_param_entry`,
therefore we can mark it as a static function.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20260916-fix_offset-v5-2-11cf8ef37854@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit f277592cfdbee95005d39fc05b395d4adae8b416)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/igvm.c b/backends/igvm.c
index 9c610578587..d8815188bc5 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -84,7 +84,7 @@ struct QEMU_PACKED sev_id_authentication {
 
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
-QIgvmParameterData*
+static QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp)
 {
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 1330ea3f6e0..e3552b70f90 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -71,10 +71,6 @@ struct QIgvm {
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
-QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
-                       Error **errp);
-
 uint8_t *
 qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
                      uint32_t *param_size,
-- 
2.47.3


