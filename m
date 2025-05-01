Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9426CC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVJy-0005gI-Dv; Thu, 01 May 2025 10:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJw-0005ey-Fz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJu-0005RD-9k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:28 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2241053582dso16829035ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111324; x=1746716124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V3es0q86fneop67hPwyyNUzAvnUBYSgJshp4N+xyHtE=;
 b=gBCJEWwAUHmDE+WNP78YXlVmkiaM8GwEe1KDyv1paoFl1mEOI2wXuoZk0K7fS/5NQS
 WYzhTkIGSTWKlIXcyRBD7KT85pz6Xp4jqUddTWf24L6Bl1bheyb4xnX/vRLLRDPiYCdm
 nlosKMqVvYcgsZgLVSR7rPAe5DolZgiIXFw7fVf9GuimtWNbem8Zssk8Ko91U2S+NP1i
 yqk7DVDUtDthwlsw/RqQr7l/URP7pgohU/D+1CThjJB4GEEUWoBdCdltVrcolDaT+j9c
 0d5L4DC2gnxhRQGG7q0/C1vCUhMBUQ8JQpxeMhh5tPG6ITzkhSbazIkVGS0lehDr6Js+
 BcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111324; x=1746716124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3es0q86fneop67hPwyyNUzAvnUBYSgJshp4N+xyHtE=;
 b=gkAn+6GKlxqHD5JzkY7xpWdDRqLreqNPc4iXSwaLKOrvjZCI1B0mIApYg5dnrMTDYb
 Ae+8WpTlweXvcetd4GgoT6u1oHcTO/ncgcykDBB+c5HFRNHpnc7Jqag9uSp501auS1tD
 nfFYSeRDmrlkwxRX0d7EehMyoFGEQF/zfCtmKfjCJi0mMnW7p3oPmmadyXloti+wpytT
 ieqOJq7eeoizg162lYJ9cvZ5XHkzkYeSL7JAx9ZvVuC2F+C3DMR9stcCgqXrFFdzrW4z
 vYXaO8GeWfSxgzIROH+qTVymUryZQ9jrOYRtHY0HEp9NkMXacM7TWdFKIy6M1Ir/44Kw
 U1vA==
X-Gm-Message-State: AOJu0YyRtsJduhBKkDPotDSVGq/R6ZPXWrPuOehOqiHg6lGX3T/5pnto
 TqGb0PSS9mbeYWTSiyBp8PCIF7Cb/wgzYnZesLVSNyXCohKXETFR1EkmN+a2VtaqVFs0tzQfK7j
 D
X-Gm-Gg: ASbGnctRy/g9EpV3vNbC73kKTyGLvgkyP4Ko/LLNazusO0zniz7xcqp9IXevjI7cWY4
 bk2oBxggWViwzxMLUF8aU8XwaWOlhWq/NpDvfEtZwE7O2h9poluOPEMdHPMlJ3OBoH4TbszcYyT
 GFhRg/XiqxfBnGPP9FjOeZmJdjDlj63dlQ8dsojgrd2ulXj0fYAdp7Nd/2dQCSthkr30nEix/gk
 oOTwpaSUHoQdk0QXxpC4BaTkp/xWlkNVQ7U63nFFpoP0wx5pg2I6q4ik7oG4udwvFNBao7PyoTk
 UXPEFwmUHrS2seM0rTjCbJoLpd1qqP0Qkxz0BW5ffz2jzmE2hvNqxzQWTC+/PANpF+XIqAQ1rJM
 =
X-Google-Smtp-Source: AGHT+IEVX7AxsVe+9bs31+EGLTsaEGL7AFYloTuA/D2MM5bqxNMYyX1QssIrq1sDplgUWdrqFeZsFw==
X-Received: by 2002:a17:903:2f43:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22df581d613mr101616905ad.34.1746111324641; 
 Thu, 01 May 2025 07:55:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] accel/tcg: Build cputlb.c once
Date: Thu,  1 May 2025 07:55:13 -0700
Message-ID: <20250501145520.2695073-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c    | 3 ++-
 accel/tcg/meson.build | 5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 35c467aace..5f6d7c601c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -25,7 +25,8 @@
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "system/ram_addr.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index d6bd304add..9b86051b82 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -25,15 +25,12 @@ tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
-  'cputlb.c',
-))
-
 libuser_ss.add(files(
   'user-exec-stub.c',
 ))
 
 libsystem_ss.add(files(
+  'cputlb.c',
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
-- 
2.43.0


