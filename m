Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F4BCD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7y-00020W-Rz; Mon, 08 Apr 2024 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7v-0001yc-2U
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7t-0003dW-DX
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ecee5c08e6so4365296b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598588; x=1713203388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlIBc4Oj7n9g5uv4QxhhxdXhuzA6b3JMjencPErHv6I=;
 b=E47VQeJXl4sKrC7f9Q4uB7mp8pi7Bsu6E7d5KVPy1einLWsbkB5tJVSW9IYtnHYKJV
 wvlVcwd6iKHofNeXZGZ7r5Nq+nN/fOBU+PYHovit2ubt2iDnu52KKjxo62kkcPJ7Fs4z
 PzA3os+WXdQoboHnlBI+w1cOlMVNagU0QdQHOizyqcMAoxUqL98nib5ra5BriPpPfOwp
 jUy/+RTwkXC8Y9DbRvZGQ/G9hCdMJiJcQKw9YoxzwN7nlTPHq8m4vyps0vPePzxW7XgD
 ZTkFDthPYpN6vEzfzf2yy4GUjkNWddX9uq1r+0VNzr5lcSANscJ4EMXkThQF04w045kX
 hyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598588; x=1713203388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlIBc4Oj7n9g5uv4QxhhxdXhuzA6b3JMjencPErHv6I=;
 b=e8b89/gL0RngVBrK6vc7lrRicZvzc+I+QdxXuLn8/vHvNz+f8VTBIfTAVQMD4Reenr
 MtPChRoxB4b+O50CES+sLDZ8Q9kzDnUJ24wG75C0KfvBW1/LPT8nAVbEL/NLocxFHBBy
 2lGqP3KpGDaa7lcBGiIXDcg/yXpFDsOXQbXPTCLit4YQvh8d+tIeKvboXfdDeN22VotV
 en6eUVjJU93y+xIijlYh9sGsIpGuZSDsPFV5JU5f0iagjz8zQWuxpKXZnqSpfn74XUFN
 iF1q4uxuxlvqnyDLtJ1PnMOSlDI+Ufq2cmmu6Wao1J06MNVxjvEWg9E+JQ3D4864nPFe
 fLhQ==
X-Gm-Message-State: AOJu0Yw5ezQhqI6B1+2D/Z8gzJhJeptaeyUBD1rrlHCo0AuWurkuU/Hd
 rwnH8GwSLvo2pudBjD71jiW0rEoAyvoDjrCdruTB2sJKZhGQCbjAni/nrPVzI3DSA8THJ/4zCIn
 C
X-Google-Smtp-Source: AGHT+IF81M8ycils9Js378ZIl1yOXofWx8f2e+ggyjSFB+43Ih1fShZmf1Nkj/1Nu0fe1Lu6UjSYyA==
X-Received: by 2002:a05:6a21:2d88:b0:1a7:7358:f10d with SMTP id
 ty8-20020a056a212d8800b001a77358f10dmr3677972pzb.16.1712598587836; 
 Mon, 08 Apr 2024 10:49:47 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/35] target/sh4: Merge mach and macl into a union
Date: Mon,  8 Apr 2024 07:49:05 -1000
Message-Id: <20240408174929.862917-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Allow host access to the entire 64-bit accumulator.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9211da6bde..d928bcf006 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -155,12 +155,22 @@ typedef struct CPUArchState {
     uint32_t pc;                /* program counter */
     uint32_t delayed_pc;        /* target of delayed branch */
     uint32_t delayed_cond;      /* condition of delayed branch */
-    uint32_t mach;              /* multiply and accumulate high */
-    uint32_t macl;              /* multiply and accumulate low */
     uint32_t pr;                /* procedure register */
     uint32_t fpscr;             /* floating point status/control register */
     uint32_t fpul;              /* floating point communication register */
 
+    /* multiply and accumulate: high, low and combined. */
+    union {
+        uint64_t mac;
+        struct {
+#if HOST_BIG_ENDIAN
+            uint32_t mach, macl;
+#else
+            uint32_t macl, mach;
+#endif
+        };
+    };
+
     /* float point status register */
     float_status fp_status;
 
-- 
2.34.1


