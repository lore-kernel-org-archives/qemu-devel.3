Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sr9hWKvR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TJIUBro1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=x9aNFlt8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nFNEXqOt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXJl-0002GY-NT; Thu, 29 Oct 2026 17:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJk-0002GG-Fi
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJi-0001HM-Cw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 822DF1FC0E
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ch6VStuhKfuhlEeqfvz2q1mP35ZnCjnGwOIpUg+n9dU=;
 b=Sr9hWKvRBjfCkXz9vpMgX6YOqCk8mgs1sbMn5X5+V94DBjnudikR2kkHbe/EdLPFxxg1LT
 qPg0F7VkmSjnj4UVWUq6gaLjOiPhj+PSZ07DDp/9+xllgQKJlfxZsS7Z/e5AlK5w1tUc33
 pkOr7aShlf15qSY1BLXhETwU64iSqQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ch6VStuhKfuhlEeqfvz2q1mP35ZnCjnGwOIpUg+n9dU=;
 b=TJIUBro14qNz/HFYYyX7xrJ4JkBoUCkboKJ9COssIPHviFXrMzxQdqq+uN2410R7ORCNev
 rjWNnr+ZH6BRsjAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x9aNFlt8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nFNEXqOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ch6VStuhKfuhlEeqfvz2q1mP35ZnCjnGwOIpUg+n9dU=;
 b=x9aNFlt8i4u5P9AQ8GJb00/7k2qU+rxQtTzyf791pd6g1/Km9W22j+oWT+f0QPXpmHlrZs
 kvxYeNEkQtmn4ftGGOMhuD+fb4cB8CtonXclx2bIylFmAyzbWeQ9d0eIUmsUCoTwwCME1Q
 Sf30zP3Ye4yCRtLBLG3bEGNRmtwmN5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ch6VStuhKfuhlEeqfvz2q1mP35ZnCjnGwOIpUg+n9dU=;
 b=nFNEXqOt5uV0raClNGAbt01BtuqaIwQYDoE8ESzpxIG9db9rOE7qsbL8hrfWm6IR2iHbsN
 TjLw0DI4EuCp+fDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C953D13419
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1LmGia142qaYAAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Qtest patches for 2026-10-29
Date: Thu, 29 Oct 2026 18:05:31 -0300
Message-ID: <20261029210536.2260016-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 822DF1FC0E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url,suse.de:dkim];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MIME_TRACE(0.00)[0:+];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Spam-Score: -12.51
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 5624b266cdd513506fb333e9041778407b6d1ac4:

  Merge tag 'qga-pull-2026-10-28-2' of https://github.com/kostyanf14/qemu into staging (2026-10-28 14:53:37 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20261029-pull-request

for you to fetch changes up to d4a85ac217b653da355f256791d4abd15980022a:

  qtest: don't close listener socket in qtest_socket_accept (2026-10-29 15:55:29 -0300)

----------------------------------------------------------------
QTest pull request

- Lift limit of 256 intercepted IRQs
- Fixes to socket_accept

----------------------------------------------------------------

Daniel P. Berrangé (2):
  qtest: multiple fixes to socket_accept()
  qtest: don't close listener socket in qtest_socket_accept

Peter Maydell (3):
  system/qtest: Avoid fixed-size irq_levels array for IRQ intercept
  system/qtest: Check ngl->name for irq_intercept_in
  tests/qtest/libqtest: Use a GArray for QTestState::irq_level[]

 system/qtest.c         | 47 ++++++++++++++++++++++++++------------
 tests/qtest/libqtest.c | 52 ++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 41 deletions(-)

-- 
2.53.0


