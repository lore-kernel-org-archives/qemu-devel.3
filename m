Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CA606A336
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=jcmFXM3m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOp6-00038o-RL; Mon, 23 Nov 2026 02:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xVOp0-00038W-7T
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:50:42 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xVOoy-0002nq-7H
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:50:41 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jXymD2w2Fz8PbY;
 Mon, 23 Nov 2026 02:50:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=8qwYCDDw6XOrMjnkvrbx/0Vnv09u3S+8kZ6jmIwlk98=; b=jcmF
 XM3m/EBtF/9PTSfBflspDvwq3vbUlNXOl7aZ/e/07g0Wbfk2xQTFdHGlu+E3pucM
 ykUe/goFk+nIfiIEa2JJz9oxkV9I/6+/FxOnzvpZo20zZcunVZuPwzUcPZlcgc+e
 UZ3rUyPE9Z+pP1klNnBpEJMFE/71KJS1VveMxwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=lBmiFHMqNiPOzOMVmmijZynGBjfBcxvHBXA59yZNBozP5Z8V0nVrp
 SVv4KoBFv32b3/60UcQ5A/xDZpctsAOUdaSjNATkKVsF68kaU0i0sEqgIaUYTCuB
 hWv/ax758ABKLery0QnMCGQlWNhXHhbPcTMyk7lehepypjpk20pyIM=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:d5e6:e670:c8a6:4a1b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jXymD2J5Vz8PbW;
 Mon, 23 Nov 2026 02:50:36 -0500 (EST)
Date: Mon, 23 Nov 2026 02:50:35 -0500
From: Brad Smith <brad@comstyle.com>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest: remove unused prctl/procctl headers
Message-ID: <awPwS_xYsv2v9oKu@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 6cbde91a2758 ("tests/qtest: use prctl(PR_SET_PDEATHSIG) as
fallback to kill QEMU") added <sys/prctl.h> for PR_SET_PDEATHSIG on
Linux, and commit 49e9f8644b03 ("qtest: kill orphaned qtest QEMU
processes on FreeBSD") added <sys/procctl.h> for PROC_PDEATHSIG_CTL
on FreeBSD. Those calls were later replaced by -run-with
exit-with-parent=on, but the headers were left behind.

Remove them.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 tests/qtest/libqtest.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3..f39a39b85c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -21,12 +21,6 @@
 #include <sys/wait.h>
 #include <sys/un.h>
 #endif /* _WIN32 */
-#ifdef __linux__
-#include <sys/prctl.h>
-#endif /* __linux__ */
-#ifdef __FreeBSD__
-#include <sys/procctl.h>
-#endif /* __FreeBSD__ */
 
 #include "libqtest.h"
 #include "libqmp.h"
-- 
2.56.0


