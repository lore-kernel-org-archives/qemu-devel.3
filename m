Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2B7C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcghG-0004bG-KY; Tue, 28 Jan 2025 03:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgar-0002Gd-BY; Tue, 28 Jan 2025 03:05:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgap-0002mR-2v; Tue, 28 Jan 2025 03:05:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 309D9E1B71;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A0A721A6324;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 2F1C9520D9; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 42/58] migration: Remove unused argument in
 vmsd_desc_field_end
Date: Mon, 27 Jan 2025 23:25:28 +0300
Message-Id: <20250127202547.3723716-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-3-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 2aead53d39b828f8d9d0769ffa3579dadd64d846)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/vmstate.c b/migration/vmstate.c
index fa002b24e8..aa2821dec6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -311,7 +311,7 @@ static void vmsd_desc_field_start(const VMStateDescription *vmsd,
 
 static void vmsd_desc_field_end(const VMStateDescription *vmsd,
                                 JSONWriter *vmdesc,
-                                const VMStateField *field, size_t size, int i)
+                                const VMStateField *field, size_t size)
 {
     if (!vmdesc) {
         return;
@@ -420,7 +420,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
-                vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
+                vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes);
 
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && vmsd_can_compress(field)) {
-- 
2.39.5


