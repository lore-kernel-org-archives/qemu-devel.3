Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2777FC2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZR-0007c4-2a; Mon, 17 Jun 2024 14:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZP-0007Oc-Kt
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZO-00053U-55
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:11 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-705cffc5bcfso4140877b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650748; x=1719255548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCkbHRdTwhc461NzNM6M57ey0Qv/rYSZmL7pQTY6Emk=;
 b=CRSuF4lX3V+2w0F6WQiY7PInPi0BvdzWLSS9u5t3lRFYCGkheWw6BVnEFUsmxz6MHZ
 4W4XdcHsWtRWqD+ZVJxCvJu4qb3wmHaj/vHK9NQGPBAXIxUuMV3u+GHC2ObrLC3LqoOz
 YA8cTnjf/UU++fAksTWuL1TvPE3Sc9pUJF8d8lfeDgMiaPxTkScrx5ru+vtRmUl7wB8S
 8sAmyUbqtxMKZNA7trBQ18A8bHpVwyRhKhQ+AyUmfXpFw/9mRfJfWMu1xc5UbG7T0Ile
 8v5ew8iDtidjAfJf0HNIbNxrCtIOH/kYscNSDcsrBiJYz78q5ruco69+F1Z+Pth+S27r
 B+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650748; x=1719255548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCkbHRdTwhc461NzNM6M57ey0Qv/rYSZmL7pQTY6Emk=;
 b=Vqa/LmH9JFj4ytMivSPYhyf223QOdVJsxx1gSnFvsMWSPE/zjPvU8kDbv0zuZJc/VU
 3hcqiDc6nwqi1It3JmCb1O3gYYPLbi/zCWo/qVJGn159OpU1Lc5dhukA4mKuucTZ+O/c
 ZuF0BIYCCPCSAj/p0PxhFaB9lJt+0bSst88Zj5opUx1xyi4ZfORNFIeeijzGSu4cbaRc
 0B5BLzMKIi7xZh5lLUJqTqzv7H0JoyMtOPMs3Yx+tVmeHhQYZEcCw5NMotMEdkXrgb/q
 0cgRR21NUhzyghItlUxNXokZUexV92KRo7wbmVEQ9jrwxvSMTUV8YtKgjXrn56OK5V86
 +vGQ==
X-Gm-Message-State: AOJu0YwAJ+Us+ZnaqbtUnA/BQI2Jdwjncvl4bcMy77Ae/aCVW38pjGqt
 rVvweU+KO21UUpiU6i7djQJeQOO9XJRPcvnSthdGZkZUsM5W2TxxoNbZJmVrk7E=
X-Google-Smtp-Source: AGHT+IFKZJvGXHGMopQTrmrydALK/e3vBu0P0zekshvTkWMZHZtxIxb6W2RUDjeoLBQa7uoU5gN1DQ==
X-Received: by 2002:a05:6a20:1595:b0:1af:f514:6d96 with SMTP id
 adf61e73a8af0-1bae7ddafe4mr14498289637.16.1718650748527; 
 Mon, 17 Jun 2024 11:59:08 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:59:08 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 23/23] Add get_ucontext_sigreturn function
Date: Tue, 18 Jun 2024 00:28:04 +0530
Message-Id: <20240617185804.25075-24-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Function checks the processor state to ensure that the current
execution mode is EL0 and no flags indicating interrupts or
exceptions are set

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/signal.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 13faac8ce6..ad81531ec5 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -117,3 +117,21 @@ abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
 
     return err;
 }
+
+/* Compare to sys_sigreturn() in  arm64/arm64/machdep.c */
+abi_long get_ucontext_sigreturn(CPUARMState *regs, abi_ulong target_sf,
+                                abi_ulong *target_uc)
+{
+    uint32_t pstate = pstate_read(regs);
+
+    *target_uc = 0;
+
+    if ((pstate & PSTATE_M) != PSTATE_MODE_EL0t  ||
+        (pstate & (PSTATE_F | PSTATE_I | PSTATE_A | PSTATE_D)) != 0) {
+        return -TARGET_EINVAL;
+    }
+
+    *target_uc = target_sf;
+
+    return 0;
+}
-- 
2.34.1


