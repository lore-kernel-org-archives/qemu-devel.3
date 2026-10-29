Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251F606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gv1XTnvI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/fNX0JHM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gv1XTnvI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/fNX0JHM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXJz-0002Ip-Pj; Thu, 29 Oct 2026 17:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJy-0002IQ-81
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:06:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJu-0001I4-8d
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:06:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E63E1FC11;
 Thu, 29 Oct 2026 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0fyxepkDPMymNPwuVzNVIQSKnUg3sx4xGjDmMq/8HQ=;
 b=gv1XTnvIKWnM8xMMtut74j3dqJNI6rxjMA3MtA3d2vUK0hoIuv2nfRa/7R1mGAv8QjCmFz
 r3+yRrlCZJr734F6rHicX733f/rSsqhKAjNjSdtjSjLkJ717/IA3duwMSS1XyiJ8/RnQHL
 0cCL57OWOHZNWV3d1qvw81zj96Gtk7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0fyxepkDPMymNPwuVzNVIQSKnUg3sx4xGjDmMq/8HQ=;
 b=/fNX0JHMtofw8eYUR3edryopDtdtvdkRKvmtJkOpNpxi7Gz5j8f++0SS/izhJXt6PXw4Vd
 XEqCzk+VD6bS2fCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0fyxepkDPMymNPwuVzNVIQSKnUg3sx4xGjDmMq/8HQ=;
 b=gv1XTnvIKWnM8xMMtut74j3dqJNI6rxjMA3MtA3d2vUK0hoIuv2nfRa/7R1mGAv8QjCmFz
 r3+yRrlCZJr734F6rHicX733f/rSsqhKAjNjSdtjSjLkJ717/IA3duwMSS1XyiJ8/RnQHL
 0cCL57OWOHZNWV3d1qvw81zj96Gtk7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0fyxepkDPMymNPwuVzNVIQSKnUg3sx4xGjDmMq/8HQ=;
 b=/fNX0JHMtofw8eYUR3edryopDtdtvdkRKvmtJkOpNpxi7Gz5j8f++0SS/izhJXt6PXw4Vd
 XEqCzk+VD6bS2fCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 496CD13419;
 Thu, 29 Oct 2026 21:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1LmGia142qaYAAAD6G6ig:T6
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 21:05:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 5/5] qtest: don't close listener socket in qtest_socket_accept
Date: Thu, 29 Oct 2026 18:05:36 -0300
Message-ID: <20261029210536.2260016-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029210536.2260016-1-farosas@suse.de>
References: <20261029210536.2260016-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Daniel P. Berrangé <berrange@redhat.com>

The listener FD passed into qtest_socket_accept should be
considered owned by the caller, and thus is is inappropriate
and unusual to close it in the method.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index dcce889ccc1..7f66c1bbb3b 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -132,7 +132,6 @@ static int qtest_socket_accept(QTestState *s, int sock)
                    (void *)&timeout, sizeof(timeout))) {
         fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
                 __func__, strerror(errno));
-        close(sock);
         return -1;
     }
 
@@ -140,7 +139,7 @@ static int qtest_socket_accept(QTestState *s, int sock)
         if (!qtest_probe_child(s)) {
             fprintf(stderr,
                     "child process unexpectedly exited, skipping socket accept\n");
-            goto cleanup;
+            return -1;
         }
 
         addrlen = sizeof(addr);
@@ -154,9 +153,6 @@ static int qtest_socket_accept(QTestState *s, int sock)
         fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
     }
 
- cleanup:
-    close(sock);
-
     return ret;
 }
 
@@ -562,6 +558,8 @@ void qtest_connect(QTestState *s)
     unlink(socket_path);
     unlink(qmp_socket_path);
     g_assert(s->fd >= 0 && s->qmp_fd >= 0);
+    close(s->sock);
+    close(s->qmpsock);
     s->sock = s->qmpsock = -1;
     /* ask endianness of the target */
     s->big_endian = qtest_query_target_endianness(s);
@@ -671,6 +669,7 @@ QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
 
     *sock_fd = qtest_socket_accept(qts, sock_fd_init);
 
+    close(sock_fd_init);
     unlink(sock_path);
     g_free(sock_path);
     rmdir(sock_dir);
-- 
2.53.0


