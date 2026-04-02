Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A0BD6AAFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Nx2-0006e5-Sx; Thu, 02 Apr 2026 15:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w8Nx0-0006Yg-Ru
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:43:34 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w8Nwz-0002sR-8m
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:43:34 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c76c60c7502so552187a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775159011; x=1775763811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3rhdPOFMSj9i+ylqvIGg6bucMa4Ig+P7LWndpMGq004=;
 b=qOa9ELm3xu47liW2rptRVfDUOi0KyWgM1kXLh21JZb2ovKdSmi+ThXQcUO7LhCenPn
 lDzEPu1257+DW7sXX8PW5A3C50YsfJCH5VzLYkq8IcuzV53f3/0Ia2tZgLB/x5qajV7Q
 D+tnUpxp6+S2Z2rRxXHhmeZnXktX/b0p9PWnYjd9sccie1q50yiublec4qQKNipOeLQL
 nzc6nGxtE8nC31tjRqEYnvDW5zmHIs9WWNhNSrfRNYJ1D4L7ZlbN+io0rrSmFNNtHoIr
 QClBlSReBXtoMyTKyq9qX/JeaujiH6JluzJ6N8FYjTFrBQdVl81mRrfHkvhWSeA3DGG5
 WrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775159011; x=1775763811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rhdPOFMSj9i+ylqvIGg6bucMa4Ig+P7LWndpMGq004=;
 b=Y39DdNAPeiTZz9isS/OqTI03Lpdlgsa9AVc3rTdJbcD/96wi6mifpBxnHwm+PvXCic
 kGHwpvOINYJiaMnAVoIGrZZ7NrbWJyWVaQoiZI2WNFNFEpjYczW/j+tXMAv6+C+JoYv7
 i2Jh1eEANnjLRI6PKLc8my2t2OqSnW4H6Hd6nLRWDHslqLLHk6JkA+4+Ug8yIBMkZhmH
 nBGHQ/HncQuC7nsItqnpn+KmCnNx4TgIo4mLnXHcxw5X8ek1AT6b6/IQUIXM6V/CBzdJ
 sa6pJQz++aFxSC2vCg+LkQaZG1r4+pffFyWLYZIXwrTT8jzUGgaivTpZ6jPH+U4+v8fL
 gYyQ==
X-Gm-Message-State: AOJu0Yzt+x7pyRQTgT8qM7whzRjmgVscTmOIHmvzWjJzGdUVeHxypQl2
 wVW0hsnEL9mOg5ojiGCtb/OVH8lrPgTUN+XXl9glzi4ClSrJ9NHQigZlWx4WKM7BbDs=
X-Gm-Gg: ATEYQzwIV9rItp+w/qGDuakj9kYQttzH6pVZYX4Whhu9ObmxSGMpFDVGc4gQuGle+AK
 E0LOvYrxDZFuPjs1uC9JKRIVqpJ7Kyt71HyBgzRiI7N5CWBiHkSisMalsuR89t093OixRXXpLFf
 4i0E4BXIdDRqBlVYgJ72YuLDkDjSq1jPZV6YY4aK2MLppqHc+ZZvOxQtopDvCkNcwKQFld2IAVv
 xUq+FCQoJYj/o048LThQOyOXFmKKmL2Yo6ItQK8FKivQoFjH6Pt8+LcIQQyp1VuICnqlRCs4L5T
 MvvDpBIpxj/Lr+kaczzLq8dAtLpEonfnDoTnjFW0Ep2uhbBB62BVgwJ+bmsUjR5LjrvrAbmvUhS
 9H0r9sgSIQ8L0fqudFshLuT3nc8czoUtK4HOy3YLn1JDWTNkKJRcP7FuYERXIRgqz7Hl4f68d3w
 otpJHcMEifAEAuXevihdjLk7ZxWIiobyNIbvjEbaVqGHhi
X-Received: by 2002:a05:6a20:3d0f:b0:398:9e47:f5e7 with SMTP id
 adf61e73a8af0-39f2db1afdamr332694637.31.1775159011383; 
 Thu, 02 Apr 2026 12:43:31 -0700 (PDT)
Received: from localhost.localdomain ([42.118.191.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c4387esm4094899b3a.31.2026.04.02.12.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 12:43:31 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] runstate: allow inmigrate -> debug transition on snapshot
 restore
Date: Fri,  3 Apr 2026 02:43:14 +0700
Message-ID: <20260402194314.20104-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=vikingtc4@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

When a VM snapshot is taken while the guest is paused by a gdbstub
(RUN_STATE_DEBUG), the saved runstate is 'debug', for instance:
  (gdb) monitor info status
  VM status: paused (debug)

On restore, the destination starts in 'inmigrate' and transitions
to the saved runstate, but the 'inmigrate -> debug' transition
was missing from the table, causing an abort:

  $ ./qemu-system-x86_64 -machine pc,accel=kvm:tcg  -m 128M
  -display none -gdb tcp::1235 -incoming "exec:cat /tmp/snap.img"
  > /tmp/qemu-restore.log 2>&1
  Aborted (core dumped)
  $ cat /tmp/qemu-restore.log
  qemu-system-x86_64: invalid runstate transition: 'inmigrate'
  -> 'debug'

Fix it by adding the missing one (Point out by the author
Dustin Spicuzza)

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1231

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 system/runstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/runstate.c b/system/runstate.c
index 2d4e95a216..97a6a1c736 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -94,6 +94,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_INMIGRATE, RUN_STATE_PRELAUNCH },
     { RUN_STATE_INMIGRATE, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_INMIGRATE, RUN_STATE_COLO },
+    { RUN_STATE_INMIGRATE, RUN_STATE_DEBUG },
 
     { RUN_STATE_INTERNAL_ERROR, RUN_STATE_PAUSED },
     { RUN_STATE_INTERNAL_ERROR, RUN_STATE_FINISH_MIGRATE },
-- 
2.43.0


