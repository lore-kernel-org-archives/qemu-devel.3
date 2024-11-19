Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CD5D44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8h-0005w1-LG; Tue, 19 Nov 2024 09:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8f-0005v2-7L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8d-0006Ee-KM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43169902057so46444555e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026210; x=1732631010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/hJApf5pwD9vn4f3viMkJMqu2JClgiQpIabvUaH/M9s=;
 b=b2CT5SxlpJAFF1Rbm0vrWLs2d9KJomc3ubAB/UnTWkiqYmn+jLUgq7L5e8Ge/a1vFw
 ZEWo+W32Sc+rZpOTzfZiEXgogjM1tmWDu8a8iRZPyMWpIHJYfOKFgCGTZaDPAiOeP7uN
 X+oXM9xiJzEiJH5wVqbaWHFxABU/zvzYjP/G20RyLYp3KFYh0qKyC2HoIEhuQQQoKbLg
 BD617SLuaIYX1TgqDvAlSMONFmjDyVuTnZ8hhya0rxoBkybCqROEiROU5jWgVhBiDeHE
 TLL8hcYJ6oGldHxKKc/zibS2hGDghKnc4mLW94Q9jbZlTv5XziMDAblLYFJzNc1Wrdhr
 mcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026210; x=1732631010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hJApf5pwD9vn4f3viMkJMqu2JClgiQpIabvUaH/M9s=;
 b=M+/bIxnrCAmDxzl+atxr2Y7xRfSU4hEgb9XHuku272MQ/oyZpSUYKeOB7nOPFPMC3G
 Oj7yq4PDBlwRD2e8vgjpM3m4VvLu1zorsBNc9XPOoevyNp9ZgWliCxm71Pk/Bmbwicew
 zE3eMtVspJXQ5JxigS2nbaCTys7md0jqDSI4NTFticEV5NOaKM6UxOtTnGJmmXrIZhD+
 lslzbDpcvyTgCzFUpqg2mV/g9wcpVrYZKSxJVp5c/KnghZuqlvhLZHs7o3nj1l2TLzyB
 I0e/xBOmANZGRnqURxGfBDAi24JRLrIbbh0RURqn9qwN+KGi63P5FTVCaXVs9busAoKB
 mVsw==
X-Gm-Message-State: AOJu0Yw4BZvSd3qYudCoHXiEMfZQyZbyzPgx+iRW7adlsmyEbTxdsESb
 bwQXHZw2bH+oUckz19MnQY1VHfYRa82qsmNiPUrEhgVlEKKFV5xVuvOhuZB9ucu9RFCbtliOhnp
 Q
X-Google-Smtp-Source: AGHT+IG8jLOtUpp7wQzHB3/2vxK6h3m9civR8cYuzPCoT26/EJzhesh/8FyNNeGOX98qrqTLw/04ig==
X-Received: by 2002:a05:600c:3b20:b0:431:5a93:4e3c with SMTP id
 5b1f17b1804b1-432df74cdb3mr160096285e9.16.1732026210085; 
 Tue, 19 Nov 2024 06:23:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] system/dma-helpers.c: Move trace events to
 system/trace-events
Date: Tue, 19 Nov 2024 14:23:19 +0000
Message-Id: <20241119142321.1853732-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The dma-helpers.c file is in the system/ subdirectory, but it
defines its trace events in the root trace-events file. Move
them to the system/trace-events file where they more naturally
belong.

Fixes: 800d4deda0 ("softmmu: move more files to softmmu/")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241108162909.4080314-2-peter.maydell@linaro.org
---
 system/dma-helpers.c | 2 +-
 system/trace-events  | 7 +++++++
 trace-events         | 7 -------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 74013308f52..cbcd89dfaaa 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace/trace-root.h"
+#include "trace.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpu-timers.h"
diff --git a/system/trace-events b/system/trace-events
index 2ed1d59b1fb..5bbc3fbffac 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -4,6 +4,13 @@
 # Since requests are raised via monitor, not many tracepoints are needed.
 balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
 
+# dma-helpers.c
+dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
+dma_aio_cancel(void *dbs) "dbs=%p"
+dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
+dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
+dma_map_wait(void *dbs) "dbs=%p"
+
 # ioport.c
 cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
 cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
diff --git a/trace-events b/trace-events
index 9cb96f64c4a..3ec8a6c7202 100644
--- a/trace-events
+++ b/trace-events
@@ -30,13 +30,6 @@ breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
 
-# dma-helpers.c
-dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-dma_aio_cancel(void *dbs) "dbs=%p"
-dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
-dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
-dma_map_wait(void *dbs) "dbs=%p"
-
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
-- 
2.34.1


