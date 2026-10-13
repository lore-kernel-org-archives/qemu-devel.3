Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF9CA9EDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGSyM-000084-4g; Mon, 12 Oct 2026 23:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xGSyC-000075-BO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:14:28 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xGSyA-0003Ub-Ov
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:14:28 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso23761797b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 20:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791861265; x=1792466065; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DmW9MHAv8/UchRoPgRyhqivd/bI2CtRp2IghUbmPmdk=;
 b=O8+ivHnd4XZa8jbDbH2zjdZMLgPSicmcikkJUvOwqkqSdv4w8Q2Ea2g5UcgqXhee1K
 DfWHKcJWJRCSi7FT+yqMhvzwmnGVWDK9r0yDulBevhClocI2nEulr7LoJ3NpuSgmyF0K
 c+P74x2NZ6S8q/EwBhOU0edjcKqE3BAbSh+xql4A0vQQ1dCmzZY63b8v5Wim48Os+8wa
 nJWBGNPFX3alEr1LmIcUjrkOQctBVDqLVK2qhK7O2BB2kS1C2wgvETV49+w6jQQ0Qvhh
 D46mn2tuSfgLriEL9F7DKqQpkvBiBtNmFTmu/tEWVjMapUt1Wx/OFdsWypol/I34KfvK
 CUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791861265; x=1792466065;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DmW9MHAv8/UchRoPgRyhqivd/bI2CtRp2IghUbmPmdk=;
 b=H0AO+DBYfwiXzXy3HGhlrk5f/ZY+Hoh4lZCAWdak0bL36r/nQDVIA7M36pZE1UYwLi
 znDz4H4hHV6acO1BxQuMiPZlvSlqKTjU5wPQKWiMNSQluLYg3Al9MA3YwXwbcKQojQXC
 jj203iY+pXXNU2J6M2SVXF2AdDINamcpVGZCzO4WxhTX3euQGg/PjwIIhwVDp2hCQ5U/
 D6rM94KOj7nxlzD2pKFjMIoIpOR0mAvlt5izqC9VBTCK5Yxv5NN7S0NQAAngmbHzGApM
 7VuM7HkNFSZYm8B5fWAYjgcdJJYVHXHA+l6wyvgu16PfTuVECbH3xfk2piZTvdBA6Oj0
 ZfdA==
X-Gm-Message-State: AFq9FYJRQ2aEX/f7JsVTkfebarb/Lugv5Z29PgOnDLlR86TLZttQcB7w
 w41/Cf2cOUOCV5ttAeYAkT/fMnegLL7CNnTQwTPBNuRhOXJ/99J3WH92wgi8qg==
X-Gm-Gg: AYBFou0Uy/0U+fYr5X3Kpijo59a2VxIV5VuM9h43DVdiMiF7rnndRDUwgJI0FdeiA1F
 ECMy2oNkwf5kA8ss9+EIfRly/P69wNHCxuVRIsQ+77KJdzsmgeSI6Ee7Io2HSVcY92nDCe+5Ez8
 AzDEu8Q44xS/INqNtOWpenAKbqfZlGJbGrfWF8mTRQ1ZIxJf+G+dXWUhGaN3WVQldQ2eG4qv688
 9OWNLvCscZST4541XbusAhBFB3ChVpNTvwp1s39mHcLdw608GBC9Hmmk6gDEV3fbiRNrLyfygNQ
 UnF10Y7imnsgITbl0w5Ey4G8J9LepT3OoTqByR8FzaI5IEn13Ttc+9+lGJxfB3hb1l76clKbDcG
 PU3ZmM5MQby1eDg+3TCt4CGqTOTlzqWddtqNQWj4b4Wgaj5iVjvULjiqmFY2CFFox0NE43r7f93
 uJ3PUKFChc5JhAouzY6Z7XKnxJXcSDsm0v3aXIrrHpyLa5tlsH6X0Co5Lm8MegtRrUiOXZlnQh2
 6oLtp4Zq31LhZ5kFk8M/NqI997Krxlx2Qy3GUhDFjKqVnTk8wjc65xQvGGUAje6pGE=
X-Received: by 2002:a05:690c:c584:b0:8a9:9f40:24b4 with SMTP id
 00721157ae682-8b07ed56616mr29353837b3.15.1791861264670; 
 Mon, 12 Oct 2026 20:14:24 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0b0c50268sm8216337b3.25.2026.10.12.20.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 20:14:23 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/2] target/alpha: FPCR exception status fixes for
 IEEE-mode code
Date: Mon, 12 Oct 2026 23:14:21 -0400
Message-Id: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mj3cScgoxE3bSC5CLd4pLEktJi3WJd0yTTZBMjcwOj5LRkJaDOgqL
 UtMwKsKnRsbW1AJrA7XhlAAAA
X-Change-ID: 20261012-alpha-fpcr-status-s-5b5c42702cfc
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=AAOHzClzXrR95JVnwyLhSFb7CY3CijG6g/iOL/2eEz4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLOLuK98tMu9cwyHc4Pkw7t9zT4mbLi1cL7syduOLTJX
 LSszj7iWcdHFgYxLoaZYooscesVWWa17Vjqc1r6F8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6BjFQ+T0GDQyi4tLU4t00wqKHPLySxJLMvPzivXyC1LzCtIL9NIy00oyMvKLilOBRujlpZa
 Yujq6GRkamFg6Wpg5WTiamjg7Oxk6uTk6Ors6GVmamxg4WzqauFqaM3BxCsBcU13O8E//kc/ysB
 rxOXXWcsvu3Gk5OnmTf1jMzTsvJzqeNa3rd0xnZFil/HtK/1x2NqlEH34H82tn6t5F+vtNOMOex
 7Kap+FUEC8A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1129.google.com
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

Two fixes for the exception status that qemu-alpha reports to code
built with gcc -mieee.  I found both running glibc's math tests under
linux-user.

Patch 1 fixes 471d493047, which was meant to record masked exceptions
in the FPCR but had no effect for insns with software completion.
Without it FE_INEXACT is never set for -mieee code.

Patch 2 makes underflow match the hardware for a result that rounds up
to the smallest normal number.  Alpha raises no underflow there and
softfloat does.

Patch 1 does not depend on patch 2.

Tested with linux-user only; system mode is untested.

glibc's math tests (make check subdirs=math), run under linux-user:

            PASS  FAIL  XFAIL
  master    1400   110      1
  series    1510     0      1

Nearly all of the failures on master are 'Exception "Inexact" not
set'.  The XFAIL is test-float32x-float64-div.  On master it fails for
missing inexact; with the series it fails only the four
div_{upward,downward}_double cases that glibc expects to fail on
Alpha.

The tcg-alpha-linux-user suite has six failures (float_convs,
float_convd, float_madds and a plugin variant of each).  They fail the
same way on master.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Matt Turner (2):
      target/alpha: Record masked exceptions in FPCR for /S insns
      target/alpha: Determine tininess from the delivered result

 target/alpha/fpu_helper.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-alpha-fpcr-status-s-5b5c42702cfc

Best regards,
-- 
Matt Turner <mattst88@gmail.com>


