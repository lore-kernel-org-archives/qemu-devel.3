Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HKnmwb5s;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6vj+uC0o;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HKnmwb5s;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6vj+uC0o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVAL-0002st-3v; Thu, 29 Oct 2026 14:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9Z-0002Ve-C7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9X-00022z-LG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7FA451F8C2;
 Thu, 29 Oct 2026 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woW40DGe5lOaMcPH0n5oiJG3Ps9Q0vcbBIpC5oKYV3A=;
 b=HKnmwb5sao3x19yqJF2StrL6S5M0ZizfCeOxhwGUIyHaAOBK0JCQKIUcYDqK0ZX8y8qlYS
 PvDZdul3v/VJCg9Nq+h1N/T+xgYqj7TajTPp/4rDy52WHMAk31nJMnHdpGSAOJhgJwRT5S
 jJ8dnhTRCDgSTaGF0oM9PNgtYtM7B7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woW40DGe5lOaMcPH0n5oiJG3Ps9Q0vcbBIpC5oKYV3A=;
 b=6vj+uC0oPNlfksSgTUQTPLNNaF1FQlYCgLUuyK/Aau19WeYVVQMR+QNrkjoTzjg6JURZnI
 oflPxPYNlbTM/QAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HKnmwb5s;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6vj+uC0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woW40DGe5lOaMcPH0n5oiJG3Ps9Q0vcbBIpC5oKYV3A=;
 b=HKnmwb5sao3x19yqJF2StrL6S5M0ZizfCeOxhwGUIyHaAOBK0JCQKIUcYDqK0ZX8y8qlYS
 PvDZdul3v/VJCg9Nq+h1N/T+xgYqj7TajTPp/4rDy52WHMAk31nJMnHdpGSAOJhgJwRT5S
 jJ8dnhTRCDgSTaGF0oM9PNgtYtM7B7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woW40DGe5lOaMcPH0n5oiJG3Ps9Q0vcbBIpC5oKYV3A=;
 b=6vj+uC0oPNlfksSgTUQTPLNNaF1FQlYCgLUuyK/Aau19WeYVVQMR+QNrkjoTzjg6JURZnI
 oflPxPYNlbTM/QAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2CC113419;
 Thu, 29 Oct 2026 18:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMnTJaOU42pwUgAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:47:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 2/8] tests/migration-test: Add multifd+postcopy test for
 preempt recovery
Date: Thu, 29 Oct 2026 15:46:35 -0300
Message-ID: <20261029184641.1973813-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029184641.1973813-1-farosas@suse.de>
References: <20261029184641.1973813-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FA451F8C2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.01
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

We have one for TLS, but we don't have the non-TLS version.  Add it.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/postcopy-tests.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 13a57596551..6c4fd311529 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -89,6 +89,15 @@ static void test_multifd_postcopy_preempt(char *name, MigrateCommon *args)
     test_postcopy_common(args);
 }
 
+static void test_multifd_postcopy_preempt_recovery(char *name,
+                                                   MigrateCommon *args)
+{
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -113,6 +122,8 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
                            test_multifd_postcopy);
         migration_test_add("/migration/multifd+postcopy/preempt/plain",
                            test_multifd_postcopy_preempt);
+        migration_test_add("/migration/multifd+postcopy/preempt/recovery/plain",
+                           test_multifd_postcopy_preempt_recovery);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.53.0


