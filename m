Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E72606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ARrNTQpN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ey/9VANy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sBNRY1J3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=y8/uCPDl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKEo-0007cr-9c; Tue, 17 Nov 2026 09:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTKEm-0007ao-Ai
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:32:44 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTKEk-00041z-ML
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:32:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95C991F78F;
 Tue, 17 Nov 2026 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FtiLTUKxzrLEHSCvGyUcduuARdG9LKVDZHmJFwNKYms=;
 b=ARrNTQpNpu+9b4j3mMQWSYiVYFlKDH0wNW/O6KTtDG70CazJ4KBvBxSDusvp4Am8VmKhZM
 7lLV6pZNDPiFtC5qEmRJQQSh1QmI+UW8t2Csq6JQIKHqUTHExyR7PgWt4z1t9a0UGZKBzA
 WGIMC2vZ0keoefO6MbuaVlwRSjmdxeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FtiLTUKxzrLEHSCvGyUcduuARdG9LKVDZHmJFwNKYms=;
 b=ey/9VANyMXyWiVN/9t0mSUaWKFNGIR5pD6qEW6olNvqBtWHCmLUpzqzVTgPHcJS9i4fqzp
 Vuw25bGvPwG5xwDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sBNRY1J3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="y8/uCPDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FtiLTUKxzrLEHSCvGyUcduuARdG9LKVDZHmJFwNKYms=;
 b=sBNRY1J31qs093E3PTXf6+4KRPXf/jZEYOcwLnvugGF/0SofqJZca33bNEPH8KPRVtxG34
 CZ/h+6VNB80mFDEjD9CekZI43tJN63qMjRbl2iXEgsmya8FEkQarz2ayKmqnnPsUh/m5px
 Or7JffXSknnpovwHkWoyQ/ZClnc7Bb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FtiLTUKxzrLEHSCvGyUcduuARdG9LKVDZHmJFwNKYms=;
 b=y8/uCPDlX7begHHsv0w4rfLxS7l9L0mrTrpcO+LrZng4qGIgr4fzodZvJbpXmIeWMCAruV
 ch8P5RUsxT1VICBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D3DB13302;
 Tue, 17 Nov 2026 14:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lN5qDIRl/GpRQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 14:32:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/3] Migration patches for 2026-11-17
Date: Tue, 17 Nov 2026 11:32:30 -0300
Message-ID: <20261117143234.1794926-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95C991F78F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:

  Merge tag 'docs-security-devices-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20261117-pull-request

for you to fetch changes up to 8226ab2b9a96e150b2473bd881b7581c057b2378:

  migration/block-dirty-bitmap: don't hold the load lock across stream reads (2026-11-17 09:54:19 -0300)

----------------------------------------------------------------
Migration pull request

- Avoid possible deadlock during shutdown
- Plug a leak when migration blockers are used by tools code
- Trivial code comment for CPR

----------------------------------------------------------------

Denis V. Lunev (2):
  migration/cpr: document the BQL as the cpr fd table lock
  migration/block-dirty-bitmap: don't hold the load lock across stream
    reads

niming (1):
  migration: free migration blocker error in migrate_del_blocker() stub

 include/migration/cpr.h        |   1 +
 migration/block-dirty-bitmap.c | 222 +++++++++++++++++++--------------
 stubs/migr-blocker.c           |   9 ++
 3 files changed, 140 insertions(+), 92 deletions(-)

-- 
2.53.0


