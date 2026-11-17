Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A7606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=x74JF2O7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wmCgp/T0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dujBMMF0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8w8g+Kgr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKEo-0007cv-IY; Tue, 17 Nov 2026 09:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTKEm-0007bT-J5
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:32:44 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTKEk-00041y-SS
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:32:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD56322314;
 Tue, 17 Nov 2026 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR1MwD668yPmOfS9wAte8Q/rLaWYUqNujJRB4p7iiUk=;
 b=x74JF2O7jDiMiDG+AcPTnl11N/qiomPYNfZsR+oOv9S6Tq02WL/aSglbPIVwv5vWagFOJz
 KBVjEhH3R5qqZYpmzeGm34OLQHjHe6r+dri5PUJ9PLBEwaokKHC8gAC/5iZz7oVoZ2Tk2+
 tXln0EE7MJTMPCZp+ZsD8UgzxSxe8As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR1MwD668yPmOfS9wAte8Q/rLaWYUqNujJRB4p7iiUk=;
 b=wmCgp/T0cBwd7SuT2tq57QfiGZ+IOsZrCz+98QCHhqUug6dMhYtdXs+TU1XNgwPQKmzDMk
 /tEjGMjXxOgrQwCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dujBMMF0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8w8g+Kgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR1MwD668yPmOfS9wAte8Q/rLaWYUqNujJRB4p7iiUk=;
 b=dujBMMF0D2UdpdDKnMioIXr5pyhFHnEHKu12JbwPGVQVDPgWr+IDgyIIM2HVLxxMXIVhOb
 8JAPXwaGWdj093M1nsR+fdzC0y95Y0friy+3i8yjpFNDM8y5iZq68ybu2X0VqOvkKLJDhf
 f2p7EasahwusOkq2zX41a03Px2wZhGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR1MwD668yPmOfS9wAte8Q/rLaWYUqNujJRB4p7iiUk=;
 b=8w8g+KgrOF6C0t8bHpqomAOFn5iArJSEQIteyB/+Mmleoov6MzyE0/ZIAdHzw+qFsHocQe
 QDNStKrtLLXrESBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9EA5134B8;
 Tue, 17 Nov 2026 14:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lN5qDIRl/GpRQAAAD6G6ig:T2
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 14:32:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 1/3] migration/cpr: document the BQL as the cpr fd table lock
Date: Tue, 17 Nov 2026 11:32:31 -0300
Message-ID: <20261117143234.1794926-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117143234.1794926-1-farosas@suse.de>
References: <20261117143234.1794926-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: DD56322314
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

From: "Denis V. Lunev" <den@openvz.org>

Every user of the cpr fd table runs under the BQL: device realize and
unrealize, backend creation, RAM block allocation and freeing (the
latter also from RCU callbacks, which take the BQL), vfio MSI-X vector
setup from vCPU threads, and the cpr state save, load and cpr-exec walk
on the main thread. The table has no lock of its own and depends on
that, but nothing says so.

Say it at the declarations. The obvious way to break it is a socket
chardev preserved across CPR: its connection hooks run in the chardev's
GMainContext, which for the monitor is the QMP iothread, and that thread
must not take the BQL or out-of-band commands stop working. Such a user
needs the table to grow a lock of its own, and has to keep the saved
table and the preserved fds in agreement when a connection comes or goes
during cpr-exec. Both belong with the series that adds it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3ad084d5bab..5ac46b62073 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -28,6 +28,7 @@ typedef struct CprState {
 
 extern CprState cpr_state;
 
+/* The cpr fd table, including cpr_walk_fd(), is protected by the BQL. */
 bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
-- 
2.53.0


