Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489FCC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8cx-000485-1R; Wed, 12 Aug 2026 09:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cA-0003Sl-TU; Wed, 12 Aug 2026 09:03:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8c8-0004IT-Kf; Wed, 12 Aug 2026 09:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=5b/5hVO0uzX4Rv6m6buzYgdoIIHqTAw8nfX62Y067No=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QK/pwLkj49TEA/8CHqtit97eJZHe2YDLekkkiaEW0AURcSw+Vvek8nSMv8VB0yY4I
 8zzZ4a6vXABpZK36UhCPG7YIzvG0LPu/8rKm4aIpKFdk2um5bLfONJ4qSOMjF1dR8P
 uDgzyW7XZhntz32g17aQH2BiBHb5XgUc9e0iRgM2iAEJTbhTFwFuSTTFs28R9Ok7cq
 +Hb4I6xdQQ5kjSx/WOChPJLqUUTfgtVrjcdzbPV/p2nXfrQc3pWVM5bZtt4yk+YkNR
 /iGmdkSdMQ//kQBiFkT6V/5LVZqYE6zkjmaDnO2uKiuURr49Bm3My5STQOzzhh3xWE
 9tsd0p5jmvL/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1BD251CA485;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 52653409B68;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CF9B02F8A0; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 006/102] hw/uefi: make SetupMode read-only
Date: Wed, 12 Aug 2026 16:00:41 +0300
Message-ID: <20260812130233.621965-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: Gerd Hoffmann <kraxel@redhat.com>

This is read-only variable which informs the OS about the
secure boot state.  Reject any attempts to write to it.

Fixes: CVE-2026-16288
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4039
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-7-kraxel@redhat.com>
(cherry picked from commit bd9b3c50f458ce24fee084916cf0eba58bd9a33b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index f3dc9c6ca60..899444af12d 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -298,6 +298,13 @@ efi_status uefi_vars_check_secure_boot(uefi_vars_state *uv, uefi_variable *var)
         return EFI_WRITE_PROTECTED;
     }
 
+    /* reject SetupMode updates */
+    if (qemu_uuid_is_equal(&var->guid, &EfiGlobalVariable) &&
+        uefi_str_equal(var->name, var->name_size,
+                       name_setup_mode, sizeof(name_setup_mode))) {
+        return EFI_WRITE_PROTECTED;
+    }
+
     return EFI_SUCCESS;
 }
 
-- 
2.47.3


