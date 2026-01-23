Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5422CD778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFU-0004yw-DW; Fri, 23 Jan 2026 14:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFT-0004t7-6i
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:15 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFR-0003nf-2f
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45CD733868;
 Fri, 23 Jan 2026 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBfBtMexc6Q4KzT1isEsummEGEzS3cWOpbOmeEXMzzA=;
 b=0quOCBFXLL3RrRuhB/IBF7EuVogLzbX0z4evQujWHg1PFjxQstA372XDcK4C6WELyVY0cx
 547ZG4dh/bAFdJNGWplQgvydfqWuYRRFrx1bBTktnBeUImnr2AeZLY8tpllQX7ksC71yeg
 T8yuWzIJqne7izeusXvhSqWG6eCfdYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBfBtMexc6Q4KzT1isEsummEGEzS3cWOpbOmeEXMzzA=;
 b=IkQ5XpMnLEpwkjzbBi+Cp0V4NfBonFMXaSkb+4MqGTxgt3fMan8Sb9oMzkoz/pc85ytvLW
 R0OIcL/PKIBoZ1BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBfBtMexc6Q4KzT1isEsummEGEzS3cWOpbOmeEXMzzA=;
 b=0quOCBFXLL3RrRuhB/IBF7EuVogLzbX0z4evQujWHg1PFjxQstA372XDcK4C6WELyVY0cx
 547ZG4dh/bAFdJNGWplQgvydfqWuYRRFrx1bBTktnBeUImnr2AeZLY8tpllQX7ksC71yeg
 T8yuWzIJqne7izeusXvhSqWG6eCfdYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBfBtMexc6Q4KzT1isEsummEGEzS3cWOpbOmeEXMzzA=;
 b=IkQ5XpMnLEpwkjzbBi+Cp0V4NfBonFMXaSkb+4MqGTxgt3fMan8Sb9oMzkoz/pc85ytvLW
 R0OIcL/PKIBoZ1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E68B31395E;
 Fri, 23 Jan 2026 19:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Nc0Kf/Rc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 25/36] migration/rdma: Use common connection paths
Date: Fri, 23 Jan 2026 16:53:40 -0300
Message-ID: <20260123195352.12850-26-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Use the common connection paths for the incoming and outgoing sides of
rdma migration. This removes one usage of QEMUFile from rdma.c. It
also allows further unification of the connection code in next
patches.

Move the channels enum to channel.h so rdma.c can access it. The RDMA
channel is considered a CH_MAIN channel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-15-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.h   |  7 +++++++
 migration/migration.c | 13 -------------
 migration/migration.h |  1 -
 migration/rdma.c      | 23 +++++++++++------------
 4 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/migration/channel.h b/migration/channel.h
index ccfeaaef18..93dedbf52b 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -18,6 +18,13 @@
 
 #include "io/channel.h"
 
+/* Migration channel types */
+enum {
+    CH_MAIN,
+    CH_MULTIFD,
+    CH_POSTCOPY
+};
+
 void migration_channel_process_incoming(QIOChannel *ioc);
 
 void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
diff --git a/migration/migration.c b/migration/migration.c
index dbb28da38f..93ebed5f8e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -90,9 +90,6 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
-/* Migration channel types */
-enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
-
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -1024,16 +1021,6 @@ void migration_incoming_process(void)
     qemu_coroutine_enter(co);
 }
 
-void migration_fd_process_incoming(QEMUFile *f)
-{
-    MigrationIncomingState *mis = migration_incoming_get_current();
-
-    assert(!mis->from_src_file);
-    mis->from_src_file = f;
-    qemu_file_set_blocking(f, false, &error_abort);
-    migration_incoming_process();
-}
-
 static bool migration_has_main_and_multifd_channels(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
diff --git a/migration/migration.h b/migration/migration.h
index 4dcf299719..cd6cfd62ba 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -527,7 +527,6 @@ struct MigrationState {
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
                        MigrationStatus new_state);
 
-void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index c41c3e24b9..98a6cebb17 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "channel.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "exec/target_page.h"
@@ -384,7 +385,6 @@ struct QIOChannelRDMA {
     QIOChannel parent;
     RDMAContext *rdmain;
     RDMAContext *rdmaout;
-    QEMUFile *file;
     bool blocking; /* XXX we don't actually honour this yet */
 };
 
@@ -3835,32 +3835,30 @@ static void qio_channel_rdma_register_types(void)
 
 type_init(qio_channel_rdma_register_types);
 
-static QEMUFile *rdma_new_input(RDMAContext *rdma)
+static QIOChannel *rdma_new_input(RDMAContext *rdma)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
 
-    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
     rioc->rdmain = rdma;
     rioc->rdmaout = rdma->return_path;
 
-    return rioc->file;
+    return QIO_CHANNEL(rioc);
 }
 
-static QEMUFile *rdma_new_output(RDMAContext *rdma)
+static QIOChannel *rdma_new_output(RDMAContext *rdma)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
 
-    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
     rioc->rdmaout = rdma;
     rioc->rdmain = rdma->return_path;
 
-    return rioc->file;
+    return QIO_CHANNEL(rioc);
 }
 
 static void rdma_accept_incoming_migration(void *opaque)
 {
     RDMAContext *rdma = opaque;
-    QEMUFile *f;
+    QIOChannel *ioc;
 
     trace_qemu_rdma_accept_incoming_migration();
     if (qemu_rdma_accept(rdma) < 0) {
@@ -3874,15 +3872,16 @@ static void rdma_accept_incoming_migration(void *opaque)
         return;
     }
 
-    f = rdma_new_input(rdma);
-    if (f == NULL) {
+    ioc = rdma_new_input(rdma);
+    if (ioc == NULL) {
         error_report("RDMA ERROR: could not open RDMA for input");
         qemu_rdma_cleanup(rdma);
         return;
     }
 
     rdma->migration_started_on_destination = 1;
-    migration_fd_process_incoming(f);
+    migration_incoming_setup(ioc, CH_MAIN, &error_abort);
+    migration_incoming_process();
 }
 
 void rdma_start_incoming_migration(InetSocketAddress *host_port,
@@ -3994,8 +3993,8 @@ void rdma_start_outgoing_migration(void *opaque,
 
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
-    s->to_dst_file = rdma_new_output(rdma);
     s->rdma_migration = true;
+    migration_outgoing_setup(rdma_new_output(rdma));
     migration_connect(s);
     return;
 return_path_err:
-- 
2.51.0


