Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5064FEC109
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57g4-0003aM-4l; Tue, 24 Mar 2026 15:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57g3-0003a4-7M
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57g1-0008JA-Pv
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A476B4D30E;
 Tue, 24 Mar 2026 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiI2v6n7yX90Xe5eMuiBRbc0Lf65FwJ+s8Qc9S+1YdA=;
 b=aQBAOvKjhjcmNpSfF/FNVrnSOf6CqDAqRLUqD7VezzH9OSHjIpCmieF4QWJaMuh2MHdyuz
 T18vAM0LzcF8oILFnv4k55Y1MrPuIlxAA0sZbKE3Vcz6Nqb5dvJlvpIhW1HZDIDDpJkpBR
 qX5NNb8AtqxinDqgt9TeZtji4qcROcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiI2v6n7yX90Xe5eMuiBRbc0Lf65FwJ+s8Qc9S+1YdA=;
 b=TJqyYFyvfgTTQ0mk/gDJg/+f3y9/VGfGRiPm48/jnQLYQdEzTI9Bw5Ugl3i3aIwmad6ydp
 7uipzJQr+HYUEfBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiI2v6n7yX90Xe5eMuiBRbc0Lf65FwJ+s8Qc9S+1YdA=;
 b=aQBAOvKjhjcmNpSfF/FNVrnSOf6CqDAqRLUqD7VezzH9OSHjIpCmieF4QWJaMuh2MHdyuz
 T18vAM0LzcF8oILFnv4k55Y1MrPuIlxAA0sZbKE3Vcz6Nqb5dvJlvpIhW1HZDIDDpJkpBR
 qX5NNb8AtqxinDqgt9TeZtji4qcROcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiI2v6n7yX90Xe5eMuiBRbc0Lf65FwJ+s8Qc9S+1YdA=;
 b=TJqyYFyvfgTTQ0mk/gDJg/+f3y9/VGfGRiPm48/jnQLYQdEzTI9Bw5Ugl3i3aIwmad6ydp
 7uipzJQr+HYUEfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D09443FE4;
 Tue, 24 Mar 2026 19:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uMgqE4DpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:44:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 16/17] vmstate: Declare variables at the top
Date: Tue, 24 Mar 2026 16:43:31 -0300
Message-ID: <20260324194333.30004-17-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLuo5zndapfjusa9yqdunguuf8)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Move the variables declaration at the top so we can reduce the number
of lines in the function by grouping some declarations.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 1862198c70..054e642ec9 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -292,6 +292,8 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 
     while (field->name) {
         bool exists;
+        void *head;
+        int i, n_elems, size;
 
         ok = vmstate_field_exists(vmsd, field, opaque, version_id, &exists,
                                   errp);
@@ -305,9 +307,8 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             field++;
             continue;
         } else {
-            void *head;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            n_elems = vmstate_n_elems(opaque, field);
+            size = vmstate_size(opaque, field);
 
             head = vmstate_first(opaque, field, size, n_elems,
                                  !(field->flags & VMS_ARRAY_OF_POINTER));
@@ -649,7 +650,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     while (field->name) {
-        bool exists;
+        bool exists, is_null_prev = false, use_vmdesc = true;
+        void *head;
+        int i, n_elems, size;
 
         ok = vmstate_field_exists(vmsd, field, opaque, version_id, &exists,
                                   errp);
@@ -661,11 +664,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             field++;
             continue;
         } else {
-            void *head;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
-            bool is_null_prev = false;
-            bool use_vmdesc = true;
+            n_elems = vmstate_n_elems(opaque, field);
+            size = vmstate_size(opaque, field);
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             head = vmstate_first(opaque, field, size, n_elems, false);
-- 
2.51.0


