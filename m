Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E5606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pI3WMSVN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hzvHcsc0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pI3WMSVN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hzvHcsc0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqEN-0005zs-EK; Tue, 24 Nov 2026 08:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xVqEJ-0005zZ-Me
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:06:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xVqEH-0005QQ-Tb
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:06:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8D1221E9C;
 Tue, 24 Nov 2026 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795525594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DGwegCKLfTiiGhvoRKG6031iMvry1I96pmLIMwagDBI=;
 b=pI3WMSVNlqbYrxWdpeuc4VIblxlnuZwfsf931zIsIt/Dg/FtATQj+o3hEHggxAVYABz+/D
 4mFQl5pE5IKqbdLGY0XlL3CSb3jR6emdjC+y3CFXntE1kFjPy4lLAtpo+thE7qr3KdHifD
 UMYh7oAtUywYOsmZaynkyAnY5TuUWIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795525594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DGwegCKLfTiiGhvoRKG6031iMvry1I96pmLIMwagDBI=;
 b=hzvHcsc0LsK38AL2kiXNWYrAT/u1+3vf0/pmrJvtm8bjGyfEaO/6ZWFWlr3co6nkMt22fo
 v2ng2oEtrAj+3eAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pI3WMSVN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hzvHcsc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795525594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DGwegCKLfTiiGhvoRKG6031iMvry1I96pmLIMwagDBI=;
 b=pI3WMSVNlqbYrxWdpeuc4VIblxlnuZwfsf931zIsIt/Dg/FtATQj+o3hEHggxAVYABz+/D
 4mFQl5pE5IKqbdLGY0XlL3CSb3jR6emdjC+y3CFXntE1kFjPy4lLAtpo+thE7qr3KdHifD
 UMYh7oAtUywYOsmZaynkyAnY5TuUWIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795525594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DGwegCKLfTiiGhvoRKG6031iMvry1I96pmLIMwagDBI=;
 b=hzvHcsc0LsK38AL2kiXNWYrAT/u1+3vf0/pmrJvtm8bjGyfEaO/6ZWFWlr3co6nkMt22fo
 v2ng2oEtrAj+3eAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 253B213505;
 Tue, 24 Nov 2026 13:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id au1QK9iLBWu3LgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Nov 2026 13:06:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] docs: migration: Clarify the security posture
Date: Tue, 24 Nov 2026 10:06:22 -0300
Message-ID: <20261124130622.2296899-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: B8D1221E9C
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

We have documented[0] the scenarios in which a migration bug is
considered for a security vulnerability but some ambiguity still
remains, mostly because of the mention of live migration in the
untrusted entities list. Remove that mention and expand the "Security
boundary scope" and "Sensitive configurations" sections with migration
content.

0 - commit 8b6405a493a ("docs: Add security considerations for migration")

Co-authored-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
v2:
Picked PeterM's version for the "Security boundary scope" part.
---
 docs/system/security.rst | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index c0254fef113..917cd8bbf83 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -28,7 +28,7 @@ malicious:
 
 - Guest
 - User-facing interfaces (e.g. VNC, SPICE, WebSocket)
-- Network protocols (e.g. NBD, live migration)
+- Network protocols (e.g. NBD)
 - User-supplied files (e.g. disk images, kernels, device trees)
 - Passthrough devices (e.g. PCI, USB)
 
@@ -133,15 +133,21 @@ an issue as a normal bug.
   that affect the level 0 QEMU process. While these bugs should be
   fixed, they will not be triaged as security flaws at this time.
 
-* **migration/snapshots**. Migration failures and snapshot load
-  failures are considered part of normal operation as long as the
-  source virtual machine and savevm file, respectively, are still
-  functional. Aborting the QEMU process at the migration/snapshot
-  destination is similarly not considered a security issue. The
-  migration stream is assumed to be secure as long as the design
-  principles described in the Architecture section are held, in
-  which case plain manipulation of the stream is not considered as
-  an attack vector.
+* **migration/snapshots**. The user must deploy QEMU following the
+  design principles described in the Architecture section to ensure
+  that the migration stream is secure. Plain manipulation of the
+  stream is not considered to be an attack vector. This means that:
+
+  * Migration failures and snapshot load failures are part of normal
+    operation; these are not bugs as long as the source virtual
+    machine or savevm file are still functional.
+  * Aborts, crashes or misbehaviour of the destination QEMU due to an
+    externally manipulated migration stream are bugs, but not security
+    issues.
+  * A crash of the destination QEMU that can be triggered by a guest
+    manipulating a device on the source QEMU before a migration may be
+    a security issue, if it meets the other criteria we document for
+    security issues.
 
 * **uninitialized stack variables**. If the bug scenario relies on
   undefined behaviour from stack variables that lack explicit
@@ -343,3 +349,23 @@ authenticated client to send the bytes that will trigger any QEMU
 misbehavior.  Use of a hardened connection is therefore an
 environmental factor used in determining the risk and severity of a
 network-triggered bug.
+
+Migration (including live updates and snapshots)
+''''''''''''''''''''''''''''''''''''''''''''''''
+
+The act of moving a guest around via the various migration mechanisms
+requires careful consideration of security boundaries being crossed.
+A live migration must only be allowed to occur if measures are in
+place to secure the transport being used against access or
+modification. In some configurations QEMU supports encryption of the
+migration stream. For setups that don't make use of this feature, it's
+the network owner's responsibility to provide proper isolation.
+
+For the non-live modalities such as snapshots, the media used to store
+the migration data (e.g. qcow2 file) must be accessible only to the
+entity in control of the migration infrastructure (e.g. cloud
+administrator or virtual machine management software). The guest owner
+is explicitly excluded in order to safeguard the infrastructure
+provider as well as avoid security policy conflicts. Moreover, end
+users operating QEMU directly should take care to only load a snapshot
+or migration from media originating from a trusted source.
-- 
2.53.0


