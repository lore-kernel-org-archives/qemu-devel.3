Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFABFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk743-0000LW-LZ; Tue, 12 Mar 2024 14:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk73z-0000L2-Tr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk73x-0001Ka-H7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd9066b7c3so1897745ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268880; x=1710873680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjlfxfhEdFjoQzS7fGHXrM249N7fWoW3k9qQmZDIWL4=;
 b=pD/qDVa17Alu/sMrs1Q8Km0Yb3UN28a8OoQxBHq1AhqzFeFHEoZ8NwEVDoiIuCsdXB
 2Bjg8KjYXzZ4omt1vxMw/LoVD0Ln4IjSWs9G3k27ar7O+EKXuqNiUZyloh/TOQeh74Ss
 dQpEaXWEFmNWCl/zg3WvzNCMO8X9sYSImS9NHrHdrpLyX0c9qIzlsbYNFNOFPKF7uk8r
 xXMISd7GY2XiM16YpYVFNPIHwH+trhm1bX4keKJoxx0QzmIhhB8tqHrJNqwMUC2h7+iF
 qF7KXc3IWuEY1115zUaMTBKnZHAxLUQve5/XZRcTy7OmlyJL3O/BsnsPUvWLj1TL09hf
 jHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268880; x=1710873680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjlfxfhEdFjoQzS7fGHXrM249N7fWoW3k9qQmZDIWL4=;
 b=Py9rDk0HwiQ4nBjkcfCqWp5HaUPz/JZ28o512WP+OG5qKv14uy4Bur3uMR9F3KkZs0
 0gxbdP3SVzToHcpa6uXseAShBcy+1QgMRdReNT6+fq1hCog8WcPw+Bx9NYybFQMH331T
 u2A/EyZJJF6C4kdlHBB2vTVvtjrX8js0NxMBCrnZ//Vk1+3Bsw7jnFuUpJFve5vKrDbS
 epQJdEplSkr3WUE3iOIesDHXWn+EMRwHA6GQ1I6XnUfk+fblxT7OMmScGF7R+UtEjUP8
 3EDNXOsmeswXqLS1bLj+F0R04gVJL+uH+L+gDKFLfRmtLpx+Cxc5e4mvRhlVJdbzvuvF
 kOsg==
X-Gm-Message-State: AOJu0YxjQ8eeAcTv9IZoTaUxP6GnQDDPihgqjOhxBdiAtCkAKL5rbn4L
 TjpIn3IZovnVLjOhloUXwn44IqeM7M9Qyz/8rML4XeiXVWuUjJuru5gPordkG+S4zOOs+3PC5cE
 w
X-Google-Smtp-Source: AGHT+IHAjL2gaHZ1QwXIKU6T59AReKLB7urnbWuECvvgRmxkfi7/hQaSpn8a07gh3RsrYsGri7ymEQ==
X-Received: by 2002:a17:902:d2d0:b0:1dd:9957:2989 with SMTP id
 n16-20020a170902d2d000b001dd99572989mr5537134plc.19.1710268879683; 
 Tue, 12 Mar 2024 11:41:19 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/8] linux-user: Add FIFREEZE and FITHAW ioctls
Date: Tue, 12 Mar 2024 08:41:08 -1000
Message-Id: <20240312184115.365415-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Vogt <michael.vogt@gmail.com>

Add missing FIFREEZE and FITHAW ioctls.

Signed-off-by: Michael Vogt <michael.vogt@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240220105726.8852-1-michael.vogt@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ioctls.h       | 6 ++++++
 linux-user/syscall_defs.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 071f7ca253..1aec9d5836 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -134,6 +134,12 @@
      IOCTL(FICLONE, IOC_W, TYPE_INT)
      IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
 #endif
+#ifdef FIFREEZE
+     IOCTL(FIFREEZE, IOC_W | IOC_R, TYPE_INT)
+#endif
+#ifdef FITHAW
+     IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
+#endif
 
      IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
 #ifdef CONFIG_FIEMAP
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 77ba343c85..744fda599e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -943,6 +943,9 @@ struct target_rtc_pll_info {
 #define TARGET_FICLONE    TARGET_IOW(0x94, 9, abi_int)
 #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
 
+#define TARGET_FIFREEZE    TARGET_IOWR('X', 119, abi_int)
+#define TARGET_FITHAW    TARGET_IOWR('X', 120, abi_int)
+
 /*
  * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
  * claim type "long" but the actual type used by the kernel is "int".
-- 
2.34.1


