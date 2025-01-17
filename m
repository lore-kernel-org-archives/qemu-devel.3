Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D4FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpXf-0004HC-5o; Fri, 17 Jan 2025 11:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXd-0004Gq-TD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:53 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXc-0001Fc-40
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5CAC21237;
 Fri, 17 Jan 2025 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyORXA8e+vvqhf5HUyhp611IAuk4cWL51dd1rEUZeSg=;
 b=eVjnTjl48MdILXZ2NQbM9Yq1NPO1DkTvanu20LMY7NejUJSz78CWqWTVJjnAveU6kVrkih
 u/GVzKBYz6trz/8ADgddyBJlHpgHjqL1h4/BtWhRXWIJx1EZwxaOZBmtE0E2lgoawtXC3w
 7rYA06U+PN382Hlnv9TD0OgK8lxrVOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyORXA8e+vvqhf5HUyhp611IAuk4cWL51dd1rEUZeSg=;
 b=V+c9o3wO513ivw3a90J58obl/XSjU11Fl3FoNT1oylWp3d9CZJhcdRdhcMUUXANVkTXTYh
 IGpVDwNym9dNACAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eVjnTjl4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V+c9o3wO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyORXA8e+vvqhf5HUyhp611IAuk4cWL51dd1rEUZeSg=;
 b=eVjnTjl48MdILXZ2NQbM9Yq1NPO1DkTvanu20LMY7NejUJSz78CWqWTVJjnAveU6kVrkih
 u/GVzKBYz6trz/8ADgddyBJlHpgHjqL1h4/BtWhRXWIJx1EZwxaOZBmtE0E2lgoawtXC3w
 7rYA06U+PN382Hlnv9TD0OgK8lxrVOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyORXA8e+vvqhf5HUyhp611IAuk4cWL51dd1rEUZeSg=;
 b=V+c9o3wO513ivw3a90J58obl/XSjU11Fl3FoNT1oylWp3d9CZJhcdRdhcMUUXANVkTXTYh
 IGpVDwNym9dNACAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2D013332;
 Fri, 17 Jan 2025 16:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Hz+EiyKimftQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 16:49:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 5/5] tests/qtest/test-x86-cpuid-compat: Remove tests related to
 pc-i440fx-2.3
Date: Fri, 17 Jan 2025 13:49:36 -0300
Message-Id: <20250117164936.22223-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250117164936.22223-1-farosas@suse.de>
References: <20250117164936.22223-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5CAC21237
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

From: Thomas Huth <thuth@redhat.com>

The pc-i440fx-2.3 machine type has been removed in commit 46a2bd5257
("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine") already, so
these tests are just dead code by now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250117102738.59714-2-thuth@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/test-x86-cpuid-compat.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b9e7e5ef7b..9cbc8b7ae9 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -357,19 +357,6 @@ int main(int argc, char **argv)
                        "486", "xstore=on", "pc-i440fx-2.7",
                        "xlevel2", 0);
     }
-    /*
-     * QEMU 2.3.0 had auto-level enabled for CPUID[7], already,
-     * and the compat code that sets default level shouldn't
-     * disable the auto-level=7 code:
-     */
-    if (qtest_has_machine("pc-i440fx-2.3")) {
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
-                       "Penryn", NULL, "pc-i440fx-2.3",
-                       "level", 4);
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/on",
-                       "Penryn", "erms=on", "pc-i440fx-2.3",
-                       "level", 7);
-    }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
                        "Conroe", NULL, "pc-i440fx-2.9",
@@ -384,11 +371,6 @@ int main(int argc, char **argv)
      * code on old machine-types.  Just check that the compat code
      * is working correctly:
      */
-    if (qtest_has_machine("pc-i440fx-2.3")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.3",
-                       "SandyBridge", NULL, "pc-i440fx-2.3",
-                       "xlevel", 0x8000000a);
-    }
     if (qtest_has_machine("pc-i440fx-2.4")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
                        "SandyBridge", NULL, "pc-i440fx-2.4",
-- 
2.35.3


