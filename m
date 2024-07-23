Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955FBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxX-0002vy-G4; Tue, 23 Jul 2024 14:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwv-0001Ik-Oj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:25 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwr-0001Db-N0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:21 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3970f9331deso23590735ab.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758149; x=1722362949;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NVVykiWpqYjvD45AibIwwzA8pM6gZ3sTQWN+WDs9eM=;
 b=vy9IW+yb5ZvHlHDXR9l27hPTuodJP9CYJbLIRqWQl7M/1ho9EsDYDpSnsrkH6kyWer
 HFf28khJCxKhqkg073Le9G4NpH1jq+LA22FtdCTyePDTCjaI0Y/tXujarAcs2+n2qU3D
 Ln2JiJGzwzFhNfFmpP2+ATjPpWkDqw5yqg20tJQVq2GON08UujeR+zyEDhK8gUSOXnM3
 hmn+QrxKKqoWvS0qJHdBMIvLjGHCpgKXE3S9CN3b209ZHTyWTBzk7Wk5x0hm8YPNwqF7
 xFaWPF1w8KcFzdr+5TLvqdz9OMnEhrPYxjeHVp55Q68W9NzEL1hxClq22NFlFTUJeopL
 qz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758149; x=1722362949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NVVykiWpqYjvD45AibIwwzA8pM6gZ3sTQWN+WDs9eM=;
 b=BEuAt07ViAjZT3BEHu2vucQq+WKl8FJfgKGRxtmrgkfWSM9iu8SPEX9z/j9lXtPjcp
 Fe1QwtfmAv1GcyjRvRgfTodhto8mmcPdjru+sMvyj5BcJTeJOVQSH5Q3zMO/vStnF7lY
 cR1CoaBtBSJ00aYFsHYjPL/WSC8aDX8A8aSZlKrRrm9KK2DXEHYzkLEiRjxajBA1QFYk
 uBDeaq0CLue7M8nW9iAJAPESAXKWDGUYMBrlE9G2SowNbXHi2oqxB5RuSJcn1wCY/swg
 JwVqQH2amFUh61SPBkB9qy/rU7iO2apBwLgic81gWGch7jFh1X/1YmH0mfwNUuojQK8I
 kQng==
X-Gm-Message-State: AOJu0YxBp8wnviAho0F2v64jrFGrdUe9Jg0R0UQI4xaDwTilA1gNS+bP
 UoX09wmmtL0N6cJ8phdk1HhIandqABXNHz26zDcScun2taQdeUo1lLqchF37E1qLbiWbkfjyo50
 UmPQ=
X-Google-Smtp-Source: AGHT+IFPR3Z1Mqosu+CCA9S4Eug3U3NuMK9ezFvt29IY5WO/HvW8TZGbm5vXooT5dMVU3JykdlaqIQ==
X-Received: by 2002:a05:6e02:1a6a:b0:376:410b:ae67 with SMTP id
 e9e14a558f8ab-3993ffa3d27mr116355045ab.16.1721758149299; 
 Tue, 23 Jul 2024 11:09:09 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/14] bsd-user: Define TARGET_SIGSTACK_ALIGN and use it to
 round stack
Date: Tue, 23 Jul 2024 12:07:23 -0600
Message-ID: <20240723180725.99114-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Most (all?) targets require stacks to be properly aligned. Rather than a
series of ifdefs in bsd-user/signal.h, instead use a manditory #define
for all architectures.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_signal.h | 2 ++
 bsd-user/arm/target_arch_signal.h     | 2 ++
 bsd-user/i386/target_arch_signal.h    | 2 ++
 bsd-user/signal.c                     | 9 +--------
 bsd-user/x86_64/target_arch_signal.h  | 2 ++
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
index bff752a67ab..b72ba7aa504 100644
--- a/bsd-user/aarch64/target_arch_signal.h
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -77,4 +77,6 @@ struct target_sigframe {
     target_ucontext_t   sf_uc;  /* saved ucontext */
 };
 
+#define TARGET_SIGSTACK_ALIGN 16
+
 #endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/arm/target_arch_signal.h b/bsd-user/arm/target_arch_signal.h
index 02b2b33e07a..10f96b8bfc9 100644
--- a/bsd-user/arm/target_arch_signal.h
+++ b/bsd-user/arm/target_arch_signal.h
@@ -86,4 +86,6 @@ struct target_sigframe {
     target_mcontext_vfp_t sf_vfp; /* actual saved VFP context */
 };
 
+#define TARGET_SIGSTACK_ALIGN 8
+
 #endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/i386/target_arch_signal.h b/bsd-user/i386/target_arch_signal.h
index 279dadc22c7..2c14153ab6b 100644
--- a/bsd-user/i386/target_arch_signal.h
+++ b/bsd-user/i386/target_arch_signal.h
@@ -88,4 +88,6 @@ struct target_sigframe {
     uint32_t    __spare__[2];
 };
 
+#define TARGET_SIGSTACK_ALIGN 8
+
 #endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 8b6654b91da..da49b9bffc1 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -728,14 +728,7 @@ static inline abi_ulong get_sigframe(struct target_sigaction *ka,
         sp = ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size;
     }
 
-/* TODO: make this a target_arch function / define */
-#if defined(TARGET_ARM)
-    return (sp - frame_size) & ~7;
-#elif defined(TARGET_AARCH64)
-    return (sp - frame_size) & ~15;
-#else
-    return sp - frame_size;
-#endif
+    return ROUND_DOWN(sp - frame_size, TARGET_SIGSTACK_ALIGN);
 }
 
 /* compare to $M/$M/exec_machdep.c sendsig and sys/kern/kern_sig.c sigexit */
diff --git a/bsd-user/x86_64/target_arch_signal.h b/bsd-user/x86_64/target_arch_signal.h
index ca24bf1e7f7..f833ee66cef 100644
--- a/bsd-user/x86_64/target_arch_signal.h
+++ b/bsd-user/x86_64/target_arch_signal.h
@@ -97,4 +97,6 @@ struct target_sigframe {
     uint32_t    __spare__[2];
 };
 
+#define TARGET_SIGSTACK_ALIGN 16
+
 #endif /* TARGET_ARCH_SIGNAL_H */
-- 
2.45.1


