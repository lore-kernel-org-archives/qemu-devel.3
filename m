Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D9606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2CugT2Y1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XvNyJY9Q;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2CugT2Y1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XvNyJY9Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXJt-0002Hw-8E; Thu, 29 Oct 2026 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJm-0002Gf-0p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:50 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJj-0001HZ-Tu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA3F6222AC;
 Thu, 29 Oct 2026 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JbjEtdL2DRurR7EuZaGpokUmGwuBEaTEySNRVLKGns=;
 b=2CugT2Y1634uR24AunW3EPWJnvyNfdiy9+6J8HTseoOKJkGJ7mwoylMflXvV0d8dJS0oI1
 eZT/VhLoDMZA5qVuS5G2R/DgIefAyYquSoxLYXL3EQXIMmPe1ilqFlDWtJk2lWKbfoOYlc
 aqkzt0i8XInwzzfCathq1EkNf8KhbbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JbjEtdL2DRurR7EuZaGpokUmGwuBEaTEySNRVLKGns=;
 b=XvNyJY9QcderL4KSHet8Rm3A3npoL7CIOxB3vM7VYAKYx1q2WqZ9fDXF3jpF3z+/iWRF3E
 e44vb6Jge/u0cIAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2CugT2Y1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XvNyJY9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JbjEtdL2DRurR7EuZaGpokUmGwuBEaTEySNRVLKGns=;
 b=2CugT2Y1634uR24AunW3EPWJnvyNfdiy9+6J8HTseoOKJkGJ7mwoylMflXvV0d8dJS0oI1
 eZT/VhLoDMZA5qVuS5G2R/DgIefAyYquSoxLYXL3EQXIMmPe1ilqFlDWtJk2lWKbfoOYlc
 aqkzt0i8XInwzzfCathq1EkNf8KhbbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JbjEtdL2DRurR7EuZaGpokUmGwuBEaTEySNRVLKGns=;
 b=XvNyJY9QcderL4KSHet8Rm3A3npoL7CIOxB3vM7VYAKYx1q2WqZ9fDXF3jpF3z+/iWRF3E
 e44vb6Jge/u0cIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E317D13419;
 Thu, 29 Oct 2026 21:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1LmGia142qaYAAAD6G6ig:T4
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 21:05:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/5] tests/qtest/libqtest: Use a GArray for
 QTestState::irq_level[]
Date: Thu, 29 Oct 2026 18:05:34 -0300
Message-ID: <20261029210536.2260016-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029210536.2260016-1-farosas@suse.de>
References: <20261029210536.2260016-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA3F6222AC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email, linaro.org:email]
X-Spam-Score: -12.01
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently we use a fixed irq_level[] array of 256 elements in
QTestState to implement capturing the IRQ level reported by the QEMU
under test so we can return it in qtest_get_irq().  This is smaller
than is actually used by some devices, and if a test tries to
intercept more IRQs than this and one is reported to libqtest then
we'll fail an assertion in qtest_rsp_args().

Switch to a GArray, which automatically resizes as required.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9e7a2d43a18..22b0dc193c9 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -42,8 +42,6 @@
 #include "qobject/qstring.h"
 #include "qobject/qbool.h"
 
-#define MAX_IRQ 256
-
 #define ACCEPT_TIMEOUT_MS 250
 #define ACCEPT_RETRIES (4 * 50)
 
@@ -88,7 +86,7 @@ struct QTestState
 #endif
     int expected_status;
     bool big_endian;
-    bool irq_level[MAX_IRQ];
+    GArray *irq_level;
     GString *rx;
     QTestTransportOps ops;
     GList *pending_events;
@@ -501,7 +499,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
                                        void *opaque)
 {
     QTestState *s;
-    int sock, qmpsock, i;
+    int sock, qmpsock;
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
     g_autofree gchar *args = qtest_qemu_args(extra_args);
@@ -525,9 +523,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
 
     s->rx = g_string_new("");
-    for (i = 0; i < MAX_IRQ; i++) {
-        s->irq_level[i] = false;
-    }
+    s->irq_level = g_array_new(false, true, sizeof(bool));
 
     s->fd = -1;
     s->qmp_fd = -1;
@@ -693,6 +689,7 @@ void qtest_quit(QTestState *s)
     close(s->fd);
     close(s->qmp_fd);
     g_string_free(s->rx, true);
+    g_array_unref(s->irq_level);
 
     for (GList *it = s->pending_events; it != NULL; it = it->next) {
         qobject_unref((QDict *)it->data);
@@ -778,12 +775,14 @@ redo:
         ret = qemu_strtol(words[2], NULL, 0, &irq);
         g_assert(!ret);
         g_assert_cmpint(irq, >=, 0);
-        g_assert_cmpint(irq, <, MAX_IRQ);
 
+        if (s->irq_level->len <= irq) {
+            g_array_set_size(s->irq_level, irq + 1);
+        }
         if (strcmp(words[1], "raise") == 0) {
-            s->irq_level[irq] = true;
+            g_array_index(s->irq_level, bool, irq) = true;
         } else {
-            s->irq_level[irq] = false;
+            g_array_index(s->irq_level, bool, irq) = false;
         }
 
         g_strfreev(words);
@@ -1192,7 +1191,10 @@ bool qtest_get_irq(QTestState *s, int num)
     /* dummy operation in order to make sure irq is up to date */
     qtest_inb(s, 0);
 
-    return s->irq_level[num];
+    if (s->irq_level->len <= num) {
+        return false;
+    }
+    return g_array_index(s->irq_level, bool, num);
 }
 
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
@@ -2100,9 +2102,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
     qts->pending_events = NULL;
     *s = qts; /* Expose qts early on, since the query endianness relies on it */
     qts->wstatus = 0;
-    for (int i = 0; i < MAX_IRQ; i++) {
-        qts->irq_level[i] = false;
-    }
+    qts->irq_level = g_array_new(false, true, sizeof(bool));
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
 
-- 
2.53.0


