Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99AFC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKf-0001Ni-Ev; Tue, 25 Feb 2025 13:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJX-00005N-3J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:52 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJT-0002Hr-0K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:50 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439950a45daso37500485e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506741; x=1741111541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6oWV1pSNijlLP/iH4WWfrlnyyIqKScPafOaD025E8r4=;
 b=rK4SjgchHq+CffjMW3f+clAp3dQVI/gCECqqZtM2JMqazRGjE04ChN7UIsobSq9GkW
 hVUgIlHLisa0IXomT+COf5JltMnECKRk+yTaDm3PKLmWMbeDk/QcHu914EaljXv+26Fz
 WNxZPxRSuS1kXcIxo24ytqJxPKQe3KR7AtaQKzcn5zfbUiIKiAb61VWMkFGyQoPmOSKl
 KInnpKwkaxRhPx/CGnLGzl2hpcty/zykAGjtwRpXHAGnJ9gwWp7GxWyQI7znz+A0pOq0
 bcZ1f/EkCf68lzKQO+mX43bDmsWbeyPi24blfaAYfD6EwXUtDLHKvfJLv2sBURXaHXBV
 P2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506741; x=1741111541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6oWV1pSNijlLP/iH4WWfrlnyyIqKScPafOaD025E8r4=;
 b=N02kXwp4qnAYYwcbv72RkfdO8YPPubWrL/7Z/Nzy21rLef/IInFwMdVuJvMUIwpkyf
 ize7wlkgc5Iepryh0HscQhy1GipRONoL6c5kSUdeV4PG975DQwLGjP/o8KpUFuhdRO8K
 i7yI7Sn5W1526dAjpsuEkkz745TDDblAjglzZOvY0fQXmStsuWHZhYSs4ydCvDjqLufa
 KNQEt8OEe4aKYqFkz3fTEb8fcyypatG8eT4pbOjjdA/vBhwgcpxZZ2CwADhWjaek8KZl
 8gnLnlhqGmFH000d0BGOdPQXQPW2YghPpVbcpiOoW6sHsj0tGHelWllXaqtcYixgRZaU
 4CRw==
X-Gm-Message-State: AOJu0Ywnt/+gpjfkh6V5OkYH1bi/+C+ZtomVvnIcsFYa/gc12EFBqPXh
 xG/+DpTfNcnLPC+M9LQNvce/6hUJl8DQNLDgJUHU4ZcqdFDBaqgE99jdE6je0sXbRN/DqRsNDnz
 q
X-Gm-Gg: ASbGncteZUilM1bARnGwrC0fh+0Ns5nGDiF7gp+PYLdFlfGL73s7uDEjBzUdabIVeoK
 d6XyLGRwp+HnI1tNc5cVhhTibuJ2+fWdl6a5+eJLSw73Wl6Z6QtrQ/45x3jYA9DjTn1RVGFBhZz
 e3rAymyGSFBba6Cc8/whXe3FTS+1TPu1QGIPLzzgW7pLAtLNG7t810s3HZlsMNT7x/1D2cupC30
 7TMp+P+H7X32H/Xwuhyjh2n3dUjE/ab4PQFYvcs3vkUgrmes8ToGV/mB1ipqFaeMfIcFy2WrfaM
 7aSfznlWtUkhB/YX4DtBvUGqw+j2NBum
X-Google-Smtp-Source: AGHT+IGsWnu+ehyXm4TrZm4hmUWGjJGg5TFDpqCimhFBRg8MhxaCkXSBb34Qd2v4UoDlee+YAmi5Gw==
X-Received: by 2002:a05:600c:4588:b0:439:88bb:d020 with SMTP id
 5b1f17b1804b1-43ab0f2dcb1mr33484395e9.8.1740506741218; 
 Tue, 25 Feb 2025 10:05:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/43] target/arm: Rename vfp_helper.c to vfp_fpscr.c
Date: Tue, 25 Feb 2025 18:04:50 +0000
Message-ID: <20250225180510.1318207-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The vfp_helper.c in the target/arm directory now only has
code for handling FPSCR/FPCR/FPSR in it, and no helper
functions. Rename it to vfp_fpscr.c; this helps keep it
distinct from tcg/vfp_helper.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250221190957.811948-5-peter.maydell@linaro.org
---
 target/arm/{vfp_helper.c => vfp_fpscr.c} | 2 +-
 target/arm/meson.build                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename target/arm/{vfp_helper.c => vfp_fpscr.c} (98%)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_fpscr.c
similarity index 98%
rename from target/arm/vfp_helper.c
rename to target/arm/vfp_fpscr.c
index cc0f055ef0d..92ea60ebbf2 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_fpscr.c
@@ -1,5 +1,5 @@
 /*
- * ARM VFP floating-point operations
+ * ARM VFP floating-point: handling of FPSCR/FPCR/FPSR
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb6..3065081d241 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -4,7 +4,7 @@ arm_ss.add(files(
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
-  'vfp_helper.c',
+  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
-- 
2.43.0


