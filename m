Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAF606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Nojjinul;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uAMzY+xf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Nojjinul;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uAMzY+xf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUPhp-0006EV-Kk; Fri, 20 Nov 2026 09:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xUPhl-0006Dm-Qc
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 09:35:09 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xUPhg-0007uB-75
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 09:35:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5037D1F799;
 Fri, 20 Nov 2026 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795185302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UMcC9Urjlo2v2kx3Au54XRO6NRDKHt9lLkpIPF9pm9U=;
 b=Nojjinulrw+QW/fHk9TWWwonJOG1byncU4V4P5s9iSOFALcYirydcNrWVQ5YmcyPCJunfe
 awegzrrGRSHfrHYfpBEQL7jzp+t+u//wXZt7zveUM4d+K+7YiIJbpZu3hDefPWgPqRJCH/
 WpgQNZq3sz81k1R60XRPza6Mt4O3kyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795185302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UMcC9Urjlo2v2kx3Au54XRO6NRDKHt9lLkpIPF9pm9U=;
 b=uAMzY+xfDx9zON+XfHb2qrNfeMlX8TnKt/z3LAIJJtU4Qp1KA8MFHo0TIfJSTKuHWqiCjx
 hDYfbq4xRME8PYBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795185302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UMcC9Urjlo2v2kx3Au54XRO6NRDKHt9lLkpIPF9pm9U=;
 b=Nojjinulrw+QW/fHk9TWWwonJOG1byncU4V4P5s9iSOFALcYirydcNrWVQ5YmcyPCJunfe
 awegzrrGRSHfrHYfpBEQL7jzp+t+u//wXZt7zveUM4d+K+7YiIJbpZu3hDefPWgPqRJCH/
 WpgQNZq3sz81k1R60XRPza6Mt4O3kyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795185302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UMcC9Urjlo2v2kx3Au54XRO6NRDKHt9lLkpIPF9pm9U=;
 b=uAMzY+xfDx9zON+XfHb2qrNfeMlX8TnKt/z3LAIJJtU4Qp1KA8MFHo0TIfJSTKuHWqiCjx
 hDYfbq4xRME8PYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD6621342D;
 Fri, 20 Nov 2026 14:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K1EBEZRaAGt4MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 20 Nov 2026 14:35:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] docs: migration: Clarify the security posture
Date: Fri, 20 Nov 2026 11:34:53 -0300
Message-ID: <20261120143453.1998949-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
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

We have documented[0] the scenarios in which a migration bug is
considered for a security vulnerability but some ambiguity still
remains, mostly because of the mention of live migration in the
untrusted entities list. Remove that mention and expand the "Security
boundary scope" and "Sensitive configurations" sections with migration
content.

0 - commit 8b6405a493a ("docs: Add security considerations for migration")

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/system/security.rst | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index c0254fef113..a41b84ea70d 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -28,7 +28,7 @@ malicious:
 
 - Guest
 - User-facing interfaces (e.g. VNC, SPICE, WebSocket)
-- Network protocols (e.g. NBD, live migration)
+- Network protocols (e.g. NBD)
 - User-supplied files (e.g. disk images, kernels, device trees)
 - Passthrough devices (e.g. PCI, USB)
 
@@ -136,12 +136,17 @@ an issue as a normal bug.
 * **migration/snapshots**. Migration failures and snapshot load
   failures are considered part of normal operation as long as the
   source virtual machine and savevm file, respectively, are still
-  functional. Aborting the QEMU process at the migration/snapshot
-  destination is similarly not considered a security issue. The
-  migration stream is assumed to be secure as long as the design
-  principles described in the Architecture section are held, in
-  which case plain manipulation of the stream is not considered as
-  an attack vector.
+  functional.
+  Aborts, crashes or misbehaviour of the destination QEMU due to an
+  externally manipulated migration stream are bugs, but not security
+  issues. The user must deploy QEMU following the design principles
+  described in the Architecture section to ensure that the migration
+  stream is not compromised. Manipulation of a plain-text stream is
+  not considered to be an attack vector.
+  A crash of the destination QEMU that can be triggered by a guest
+  manipulating a device on the source QEMU before or during a
+  migration may be a security issue, if it meets the other documented
+  criteria for security issues.
 
 * **uninitialized stack variables**. If the bug scenario relies on
   undefined behaviour from stack variables that lack explicit
@@ -343,3 +348,23 @@ authenticated client to send the bytes that will trigger any QEMU
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


