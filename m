Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88823606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IKFmCP15;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eU2dOiXR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IKFmCP15;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eU2dOiXR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXJm-0002H3-IF; Thu, 29 Oct 2026 17:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJk-0002GN-OO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:48 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJi-0001HQ-W4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6498222AD;
 Thu, 29 Oct 2026 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFKsKG/+7eMbnSeIrUNwtWUFTYprAdIP0JDz9oY7qec=;
 b=IKFmCP15nKX3FcoPqQKiHak9bbtGNmXmGQi0AJ9F822BydjCSvpOlEj8Pcw7h4QS91isSj
 vOcYnO1lv+wo0T8F8x+7DKx0MtJpcyLOKwbaecpJjdQUAA36ZBvPgp7+T0k5f7+m19+jL3
 i46Ta0bmTDxsx8Z1UJ3xDeypPmjRJ5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFKsKG/+7eMbnSeIrUNwtWUFTYprAdIP0JDz9oY7qec=;
 b=eU2dOiXRLivZC0HQ89r9IjNkpLJqp24bNmGw4H2dIpm6xp36maRj3UCiESokBiAuT88lPt
 +x05yg7QAdrpPADg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFKsKG/+7eMbnSeIrUNwtWUFTYprAdIP0JDz9oY7qec=;
 b=IKFmCP15nKX3FcoPqQKiHak9bbtGNmXmGQi0AJ9F822BydjCSvpOlEj8Pcw7h4QS91isSj
 vOcYnO1lv+wo0T8F8x+7DKx0MtJpcyLOKwbaecpJjdQUAA36ZBvPgp7+T0k5f7+m19+jL3
 i46Ta0bmTDxsx8Z1UJ3xDeypPmjRJ5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFKsKG/+7eMbnSeIrUNwtWUFTYprAdIP0JDz9oY7qec=;
 b=eU2dOiXRLivZC0HQ89r9IjNkpLJqp24bNmGw4H2dIpm6xp36maRj3UCiESokBiAuT88lPt
 +x05yg7QAdrpPADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBB5F1342F;
 Thu, 29 Oct 2026 21:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1LmGia142qaYAAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 21:05:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] system/qtest: Check ngl->name for irq_intercept_in
Date: Thu, 29 Oct 2026 18:05:33 -0300
Message-ID: <20261029210536.2260016-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029210536.2260016-1-farosas@suse.de>
References: <20261029210536.2260016-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
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

Currently we check the name of the NamedGPIOList when doing
irq_intercept_out, but not for irq_intercept_in.  Even though we
don't currently support irq_intercept_in on named GPIO lines, we
still need to check the name, because otherwise we will install the
observer on every set of GPIO inputs the device has, rather than only
for the unnamed GPIO inputs.

This doesn't currently affect any test cases, because of all the
tests which use irq_intercept_in only tests/qtest-l2vic-test.c uses
it on a device that creates named GPIO inputs.  That device has both
unnamed GPIO inputs and a named GPIO input "reset".  The effect is
that a change in the "reset" line state looks like a change in
interrupt input line 0; but since the test doesn't cause "reset" to
change this doesn't happen and there are no observable effects of the
bug.

Check the ngl->name against the specified one for both input
and output interception. (Currently this will be equivalent to
a check against NULL for input intercepts.) As we're now checking
for an exact name match unconditionally, we can break out of the
loop as soon as we've found it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 system/qtest.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index a3de815ce65..5ff3f9f27d8 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -422,23 +422,24 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         }
 
         QLIST_FOREACH(ngl, &dev->gpios, node) {
-            /* We don't support inbound interception of named GPIOs yet */
+            /* NULL is valid and matchable, for "unnamed GPIO" */
+            if (g_strcmp0(ngl->name, words[2]) != 0) {
+                continue;
+            }
+
             if (is_outbound) {
-                /* NULL is valid and matchable, for "unnamed GPIO" */
-                if (g_strcmp0(ngl->name, words[2]) == 0) {
-                    int i;
-                    qtest_init_irq_intercept(ngl->num_out);
-                    for (i = 0; i < ngl->num_out; ++i) {
-                        qtest_install_gpio_out_intercept(dev, ngl->name, i);
-                    }
-                    interception_succeeded = true;
+                int i;
+                qtest_init_irq_intercept(ngl->num_out);
+                for (i = 0; i < ngl->num_out; ++i) {
+                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
                 }
             } else {
                 qtest_init_irq_intercept(ngl->num_in);
                 qemu_irq_set_observer(ngl->in, qtest_irq_handler,
                                       ngl->num_in);
-                interception_succeeded = true;
             }
+            interception_succeeded = true;
+            break;
         }
 
         if (interception_succeeded) {
-- 
2.53.0


