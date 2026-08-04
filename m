Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5A6C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGHg-0000fL-DC; Tue, 04 Aug 2026 10:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wrGHc-0000f7-Ki
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 10:38:20 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wrGHU-0008S0-PG
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 10:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785854266; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=ZmTMd2/iXkXfubc4u2eOyilowVn0BJ/PBdpB44bui3w=;
 b=uhQhlQHmGHgGHEpigVQHCtptFIC4huYFwaDo/NHlv78atWSUga0ihiUIlf77nL+ZdfHAyS16LURdEoAwpdrEp2w3x/5Yqfi4sGbMps/vsA8z7B/EHFmfLpSixJWIA5B7WGL8lEEdbJxnOlQ0UDrn1EIYd7+1m9zFOssDZIDt4og=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0X8OZEmn_1785854261; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X8OZEmn_1785854261 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 04 Aug 2026 22:37:45 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Tue, 04 Aug 2026 22:37:19 +0800
Subject: [PATCH] scripts/checkpatch: Match paths beginning with hw/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-b4-checkpatch-hw-path-v1-1-91b88679f2d9@linux.alibaba.com>
X-B4-Tracking: v=1; b=H4sIAB75cWoC/x2MQQqEMAwAvyI5b6BqteJXFg82RhMElVZUEP9u8
 TZzmLkhclCO0GY3BD406rokyX8ZkPTLxKhDcihMUZvGWPQWSZjmrd9JUE5MIEiDdc5XZeV8A6n
 dAo96fd9/9zwvwu1mS2cAAAA=
X-Change-ID: 20260804-b4-checkpatch-hw-path-cd477b5357b8
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785854265; l=3426;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=iTvSziGfbs1n3Wk6FJsyWV76mMrDxG85MgpEkilKO7I=;
 b=Mf7+34hRYdn8GvDG8GACRL9gZg+6it7KZhJHl5Yfm/8xellf209wCS2P0Peyv4QWqQGioqj3l
 W8q7a2gUWk0AlnLtQg9adXg08wZBLnc+r7yGM3o9uUd9lyy/vRkR1t8
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Patch mode strips the leading a/ and b/ components from file paths,
leaving repository-relative paths such as hw/riscv/foo.c.  The checks
for qemu_bh_new() and aio_bh_new() currently require /hw/ in $realfile,
so they miss paths beginning with hw/ in both normal Git patches and
--file mode.

Match either the start of $realfile or a slash before hw/, making
patch and file modes consistent while preserving nested /hw/ matches.

Fixes: ef56ffbdd6b0 ("checkpatch: add qemu_bh_new/aio_bh_new checks")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
The checks for qemu_bh_new() and aio_bh_new() introduced by
ef56ffbdd6b0 are intended to cover files under hw/.  In patch mode,
checkpatch removes Git's leading a/ and b/ path components before
setting $realfile.  A file under the repository's hw/ directory is
therefore represented as hw/foo.c.  Since the checks require /hw/,
they do not recognize that path.  The same false negative occurs in
--file mode when given a repository-relative path such as
hw/misc/i2c-echo.c.

The problem can be reproduced from an unmodified upstream QEMU checkout
at the series base:

  $ git show b14037f37f9 -- hw/misc/i2c-echo.c |
      scripts/checkpatch.pl --patch \
          --test-only=aio_bh_new_guarded --no-summary -
  Your patch has no obvious style problems and is ready for submission.

Commit b14037f37f9 adds a qemu_bh_new() call under hw/, so that result is
a false negative.  Repository-relative file mode reproduces the issue:

  $ scripts/checkpatch.pl --file hw/misc/i2c-echo.c \
      --test-only=aio_bh_new_guarded --no-summary
  hw/misc/i2c-echo.c has no obvious style problems and is ready for
  submission.

Before this patch, both invocations succeed without reporting the call.
After this patch, both report:

  ERROR: use aio_bh_new_guarded() instead of qemu_bh_new*() to avoid
  reentrancy problems

and return failure as expected.  The analogous aio_bh_new() check was
verified with hw/i386/kvm/xen_evtchn.c.
---
 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..9ae7693a4f388597dc11a58a85736d511fbcc62c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3223,11 +3223,13 @@ sub process {
 			ERROR("use sigaction to establish signal handlers; signal is not portable\n" . $herecurr);
 		}
 # recommend aio_bh_new_guarded instead of legacy qemu_bh_new / qemu_bh_new_guarded
-        if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\bqemu_bh_new(_guarded)?\s*\(/) {
+		if ($realfile =~ m{(?:^|/)hw/} &&
+		    $line =~ /\bqemu_bh_new(_guarded)?\s*\(/) {
 			ERROR("use aio_bh_new_guarded() instead of qemu_bh_new*() to avoid reentrancy problems\n" . $herecurr);
 		}
 # recommend aio_bh_new_guarded instead of aio_bh_new
-        if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\baio_bh_new\s*\(/) {
+		if ($realfile =~ m{(?:^|/)hw/} &&
+		    $line =~ /\baio_bh_new\s*\(/) {
 			ERROR("use aio_bh_new_guarded() instead of aio_bh_new() to avoid reentrancy problems\n" . $herecurr);
 		}
 # check for DEVICE_NATIVE_ENDIAN, use explicit endianness instead

---
base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
change-id: 20260804-b4-checkpatch-hw-path-cd477b5357b8

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


