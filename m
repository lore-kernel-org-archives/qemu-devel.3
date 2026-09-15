Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1958DC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6TSj-0004XJ-Qw; Tue, 15 Sep 2026 09:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6TSg-0004X3-7W
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:44:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6TSd-0005sS-SC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:44:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17AAB21C5A;
 Tue, 15 Sep 2026 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789479868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kkvTy79EwEKYA902MVsiZAw5ul0UsKBOGYVO/1L4KjI=;
 b=xgBeFvuHZR01gtw1jLnw13RdSItn5W6M8RiCQ9/DZMezJcbebaN294CHe7SwYVpdS0xbxv
 8rhg/TcXxx7YgJwL6mRmbEpwlcn7W/ViZsDUQL9NQCBA9H3l9BXvN9DPBkkKhJfG60VZig
 ofeOzApYgAq/Eea9QgcnirodQ0lVZdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789479868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kkvTy79EwEKYA902MVsiZAw5ul0UsKBOGYVO/1L4KjI=;
 b=gBngGvMc9ncz+kdQLCuxLsB3DhYdeBdjMLds5LU3U3jTyAtNgdN12gWIPOmLeQEfnskS3t
 6RsMIPLAnoTi0RAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789479864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kkvTy79EwEKYA902MVsiZAw5ul0UsKBOGYVO/1L4KjI=;
 b=ER7DdgtdtRY5vi70/H/4Oudf9xpToDITxDUiX2uDeQX1isR9NO8FGG2mCRiC617SaEBp85
 upMOWK+fFvGk1VMmn9sb3xLntM+q5hOgIJT/BB2uMa+yofoOB7xxvqpd2qMPRpvEXDXDg1
 /gzhIFZVfD4ikfaI1QKhlz6fsHaKjk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789479864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kkvTy79EwEKYA902MVsiZAw5ul0UsKBOGYVO/1L4KjI=;
 b=2cDr8sPpLfcyW+vGVqY5HPc6xUtn0eFPnn/M9wHg9/gzWkwOwdaZkxoqBilZ1U7Bn4ycmA
 ihtKVMRZUojVq2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D305C136A5;
 Tue, 15 Sep 2026 13:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s6jaHLZLqWpeBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 13:44:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qemu-option: Cope with a missing QemuOptsList
Date: Tue, 15 Sep 2026 10:44:12 -0300
Message-ID: <20260915134412.4187164-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It's a common pattern in vl.c to chain the qemu_find_opts() output
into the first argument of qemu_opts_parse_noisily():

opts = qemu_opts_parse_noisily(qemu_find_opts("spice"), optarg, false);
if (!opts) {
    exit(1);
}

In cases such as spice that have the group defined in the module file,
it's possible to reach qemu_opts_parse_noisily() with a NULL QemuOptsList if
the module is not present in the host filesystem.

  $ ../configure --enable-modules --enable-spice
  $ make
  $ mv qemu-bundle/usr/local/lib64/qemu/ui-spice-core.so{,.not}
  $ ./qemu-system-x86_64 -spice a
  qemu-system-x86_64: -spice a: There is no option group 'spice'
  Segmentation fault (core dumped)

Return NULL from qemu_opts_parse_noisily() if there is no list.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9fbf425f86..0ec12d252c 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -945,6 +945,10 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
     QemuOpts *opts;
     bool help_wanted = false;
 
+    if (!list) {
+        return NULL;
+    }
+
     opts = opts_parse(list, params, permit_abbrev, true,
                       opts_accepts_any(list) ? NULL : &help_wanted,
                       &err);
-- 
2.53.0


