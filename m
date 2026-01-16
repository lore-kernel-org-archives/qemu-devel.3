Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A983D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgab7-0005Hu-76; Thu, 15 Jan 2026 22:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgab5-0005FA-Bs
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:03 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgab3-0005V0-Ls
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:03 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so814441b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534440; x=1769139240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uE+wYKHRCm4cAdpr8PeyQJ3cJpbVlmgmPplftBLMyLA=;
 b=m/V5/mxNsnMfNPq/uvBgYhe9czh+LTTSEXVwr1z0WJHOsFasMT68vOD9JObQTa/5JX
 LciV99uQ3hAAfRSKSi7gl9h28N04jpfWEw+FWdq/PTZ8sR/r9TBm9jCVUX0Bem60ZL4S
 mqBRJHj+zz6WBWNMLHymcUPllxxNWiDELzQ91K8oCD73kzPTZ4B9V4WvhdatxdawNJYZ
 NEIVlExGB6tkajqjWvfeTqlB+3oVcB/M9cnM+Z1dgO8PbrS0uSboUWb7ol6P9pI153Nl
 DlWRpXXS2JF36TVQ51+XoR4/oaV2xVC1febJt9JZdq7JJXzCQ/smcIH8XmY1/Mvijk13
 vkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534440; x=1769139240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uE+wYKHRCm4cAdpr8PeyQJ3cJpbVlmgmPplftBLMyLA=;
 b=vGCHb3Wdhr4C+8w+xaCvLVHW4Eziy/PB3hAqkWkigVy0d/Rjl3mVxeUcP01ZOfZ2Vj
 u0Bm/1sIQb1Dn/Ywm22zyGOIH9zlZctzUjJqAnJaDBxBfQ+0tmIlndYLMfwg9g7+nmZd
 Rfoug95sZ5Q0eDZbTKZ2pfDd6rtBXludWNVvsCfmgMAVeUUAo3rCQmg8IoRqScdS+X+4
 DFWtMkAlxUOQI9RMHZJ5Qn+W6ZvqD5su2Og9ZbBujbLVOpuY1SDEudUwlzHd1Zoobsf+
 iTh1yZ/VmXw6GVWbug15IDQGof6K21Ci+ZcmxJ9hjVkXUzUr14L8XtDucsVqijH1pK+c
 VuLw==
X-Gm-Message-State: AOJu0Yy7HF789eG+Y4QNSXoBT/vLGhkTn7f9rzpBoyylBTlpfzdJMFUF
 tLc9Xt7dHCZRgVNsqQjKvpClqmr24zgLrbKKJHgI5aA6SdYwq1BQi/iGi4igsooPTKNo543he8b
 9ezhusuZnsUlI
X-Gm-Gg: AY/fxX6T74QMmrh2Jo/fq5P9buoOtFKP8C8CnN5kd0zmpbys/atLBKCFuYmdmFNBZV2
 rBipNDdKxhVUlEESsp6ZJ5p4wkPXUWnDZYhJDZcqPAd8M2B+LQbZDtxh5YAhYYsosa5kSo6ERCp
 rKRvgkHTZ7+xGy2oscz64vIPkCqEpoNuSdd8zLybxmDx7o4dbg9bNc/skB6CLZc2n/LxbePj61X
 k0hcIi3Fp3lZ9IljOLqWnH+gOi8RQmJfqeO0DQxW9rXodisx6lBBPZk+XyEWd3ZJw1hasXIbcoS
 DFXgcHt+q8J0L8NfYm9KTPwMHh+Qa94G023C9fsgMQ/LJPIst5dtN5/TiT+H6JF9mJdVNSo2jmQ
 H4VuuP3RrabDwNWO5+81Z0Vg8ZKzkzOKiODbGdaTkSnGEx67TjKyG/Nz1x5rkiHfX4qa3d4dIQW
 dTZxDTIm6mcH2d/z3Fy1VTPaH0dnjq
X-Received: by 2002:a05:6a00:340c:b0:81f:9913:5438 with SMTP id
 d2e1a72fcca58-81fa0385979mr1753349b3a.59.1768534440052; 
 Thu, 15 Jan 2026 19:34:00 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v2 11/58] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
Date: Fri, 16 Jan 2026 14:32:17 +1100
Message-ID: <20260116033305.51162-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

The target test is TARGET_I386, not __i386__.

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 52f84d5dd1..c49be32bdc 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -247,7 +247,7 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
-#if defined(__i386__)
+#if defined(TARGET_I386)
 #define TARGET_HAS_STAT_TIME_T_EXT       1
 #endif
 
-- 
2.43.0


