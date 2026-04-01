Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896BBD35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sC4-0008E7-3y; Wed, 01 Apr 2026 05:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sC2-0008D6-0T
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sC0-0000M5-EE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so3253064f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036935; x=1775641735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DPj6a/ykJ3QrXSxGp0eou5I3hh9GvFUes+i3F2z0gV8=;
 b=F6zUkkjlzjQwZ3HlA9DQ5bWE6ShKPL547OK9YUQyNetp8I6gBccX9uP0RH3hC0Fhng
 OkprcZCvmcAPVcgERx8DEoRSUVCMNaSYpGurDcztCOVr9aslso/mZuBgng9wP39LD3GU
 JjD5AU1Pllj13H1OAGCDXWF/+zcSk/9ZUhy1DywUDTot2Bz/C2lbQY6/u00wvmOj6Loq
 yoY2LSy3nSdsWAR801Y0q2esQO8dieR0nHlHwQGo2GbFfJ7Y+dR6/NBNsuyViLgHSSex
 v/Sis8MDn7FWWetCN0vGS6UdYih4Sc1aZV73jtnffZ16x6wUi8I1J9KAsuzG8Z20HNHE
 RhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036935; x=1775641735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DPj6a/ykJ3QrXSxGp0eou5I3hh9GvFUes+i3F2z0gV8=;
 b=DcMAn1EIzucm8MvPHUSas5blpFvUp0kSMHZ4QXvVRpWME7V1MoFsfFTQ1cnT0v02YF
 biw9Qq5WXIf93+IgnVZ4t2JpdklvJf3z31OmjpNJfnb6JppTHHs0zy7XYG23Z1BvwzVc
 ep/8FbX+/JbP5UZiC+k0qxP9ByMldi2W5upyy51TcyG36wdgSGKsgyEB0K16P7kIv2Cz
 BXYl5Mibq87jRwi9+/knO3zkNJ2SARs+V1kSPBBQMcRRaGJAcPIna1Gw11+R0CBKS3G9
 HIdVB0VchNuTy7ENiPvGOmkwI1qhzl6SEeu3HypwwvWLiZK90uLSsPHmdX30WLsYwA+A
 xD2A==
X-Gm-Message-State: AOJu0YwyAQpciJJbgQ747uxA49goG0OFZrXbGfT48pGS2eXn5Hiu1JZp
 VqEhyfAqQUOGMkFNDPlehTXwPGekU5xN+xk8mUenzXkDeZOh/bObxNH2i1DLUoE/uuuetOy3n7C
 qpB+oJR4=
X-Gm-Gg: ATEYQzw53H4mA4/1Okk4UgK0XfY47rhHskurjReRCgNpdSHLe6K9Jntt95pE0pJ1E1a
 bQ4TLW/0//KsSTL2BJ9JaxjlM3cDC0Trrd4Gqk+/Aj0LGz5s9gUx3VCNdt7n+EnjjcPAWfccnl2
 CHSa86+Tcp+nd7IqdqCffmUDutFuGpt1Zvf/vbkUH64OEabtKHW3bNWb36oCxYAMUKFphDeXf2M
 2INhAh5+FShmylIL2e+41K7jD3mJ2VtBJLL+2xfKLeQYabfyoFMpe3Ki5N5VOxGTLdAetY94s75
 3zp9bJQj6Hu3C3hLfG5HooMmZkqNtIOcX1RGdKovU+PK9ExFf3uNzj6EsxjHCyq1vesToIu2dnK
 u26Wgd6Hrk67YdlGnfffFmoFuKRZ0tr4zaj69ZkTig6Mw6i+HiiT2ZLMeCbCsJRePyE4dyguJbI
 +HXSde15YjHvOSwrzX3iSVYutiW9e8MmAv+kTNaPe2pbC9aGc83AWvv6F27d75f8CENXvFh69E1
 PFX+1eKyWq1ysOChuuH/dH5+yCHC5c=
X-Received: by 2002:a05:600c:3f19:b0:487:e2d:f649 with SMTP id
 5b1f17b1804b1-4888359a8dcmr41518015e9.26.1775036934626; 
 Wed, 01 Apr 2026 02:48:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm146945685e9.15.2026.04.01.02.48.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 02:48:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] linux-user: Make openat2() use -L for absolute paths
Date: Wed,  1 Apr 2026 10:48:47 +0100
Message-ID: <20260401094848.2661985-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401094848.2661985-1-peter.maydell@linaro.org>
References: <20260401094848.2661985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Sun Haoyu <shyliuli@aosc.io>

openat2() ignored the -L prefix and opened host files directly.
For example, openat2("/tmp/file") opened /tmp/file on the host, not
QEMU_LD_PREFIX/tmp/file like openat() does.

Fix this by using path() to rewrite absolute paths. Skip this
when RESOLVE_BENEATH or RESOLVE_IN_ROOT is set:
- RESOLVE_BENEATH rejects absolute paths anyway
- RESOLVE_IN_ROOT resolves relative to dirfd

Now openat() and openat2() work in the same way.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3341

Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260317053827.25051-1-shyliuli@aosc.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c      | 11 ++++++++++-
 linux-user/syscall_defs.h |  7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bb95b96f29..f4b74ad350 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8856,7 +8856,16 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
     if (fd > -2) {
         ret = get_errno(fd);
     } else {
-        ret = get_errno(safe_openat2(dirfd, pathname, &how,
+        const char *host_pathname = pathname;
+        if (pathname[0] == '/' &&
+            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
+            /*
+             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
+             * resolves them relative to dirfd.
+             */
+            host_pathname = path(pathname);
+        }
+        ret = get_errno(safe_openat2(dirfd, host_pathname, &how,
                                      sizeof(struct open_how_ver0)));
     }
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index aac8b0c574..679af640c0 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2774,7 +2774,12 @@ struct target_open_how_ver0 {
 #ifndef RESOLVE_NO_SYMLINKS
 #define RESOLVE_NO_SYMLINKS     0x04
 #endif
-
+#ifndef RESOLVE_BENEATH
+#define RESOLVE_BENEATH         0x08
+#endif
+#ifndef RESOLVE_IN_ROOT
+#define RESOLVE_IN_ROOT         0x10
+#endif
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
     defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
-- 
2.43.0


