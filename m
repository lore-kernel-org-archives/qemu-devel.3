Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12196C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLqJ-0002br-IL; Thu, 22 Feb 2024 22:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqH-0002bH-Bn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqF-0000cR-Uq
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:17 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso411318b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708657394; x=1709262194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHlUnJMkSLjXViHQWxp6vaRXYVXn1e/U/gKCQwR45lE=;
 b=OHAp4duwjt6L6OBs2GKA5uIiRgF3QH5pO1HCXniUppqUjyzkAvLaVZxKglY2JTdiqc
 O+5UimwD4LCxVBE6hZuP09UitQ8NhNi7NVexlmW8o2kyQPKbqmK8RkBeIQxzhpRBhq0p
 gNoPGXjebjC0w6Zf6sokT8DgbdpFwylN8vTATgC6v3vBJPXo0uqp2Ic3QEracHY/cSSQ
 NYE1POZjdp3Idkf2EKw84lb0hOhCpAweQN8UugIXnQgZcT3Mp/IhkebaYVmcmP5SaMST
 0SXceMqZinkxXetx2E9Jd0RF6Jq5AvzWPptCaxoCiBSxJ5o8VLKFdqfLSt9FoqjjZr2J
 EKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657394; x=1709262194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHlUnJMkSLjXViHQWxp6vaRXYVXn1e/U/gKCQwR45lE=;
 b=YaZ0USds2u9PV4aAWj+8zblI5CKNBKmbTaNCesD3sjHjZ6wcIuH5UtB87BwYNsNQU/
 SO2D9y5qYoQtHgdpdPRc+arjdSZqUXeleQvp7KhW027h3CgwQfhodS6ZfTpC9895P0DP
 KcgR2rTJNOCvUSdPJuj8bnENTH9LyJ9Pthhj3hey4gGqP+Ay2yWWKvcE0YbW/TxLQntb
 w6qWhluXvMdnAz06xLPYtIe9DpxIg+pTjqJxHfALdEBaCS8kDjtN2SCAe3GRNBkv3OvL
 Ygz1fXFZhsu1zQdRl+ahocllo3sYRWLcTD1ttlc6y9slabOIpSM+UpgTe/EcwcSN0VzT
 hdwg==
X-Gm-Message-State: AOJu0Yy+VN1+kCgWoTAZ/2JKu/q3HSLL6diQd0CA4peF1SV71yqoUNFd
 2H7qLHSThOF+3KmYqMHZdU94yTJpjOp/+kNQWHgcjYBV7G69AjCinH+wPu2pJB0eHZDal7rYhZe
 k
X-Google-Smtp-Source: AGHT+IHJunKb2gmTOvW6YzKI59Q7aAHbhAa5pIsAtKFpxevTNWpDutr3UFzNB9HWXLPWfGjegAqZUg==
X-Received: by 2002:a05:6a00:9a3:b0:6e4:74d9:6f0f with SMTP id
 u35-20020a056a0009a300b006e474d96f0fmr1449327pfg.0.1708657394267; 
 Thu, 22 Feb 2024 19:03:14 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a056a000d6600b006e31f615af6sm11594159pfv.17.2024.02.22.19.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:03:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, iii@linux.ibm.com, richard.purdie@linuxfoundation.org,
 mjt@tls.msk.ru, Song Gao <gaosong@loongson.cn>
Subject: [PATCH 1/3] linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
Date: Thu, 22 Feb 2024 17:03:07 -1000
Message-Id: <20240223030309.458451-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223030309.458451-1-richard.henderson@linaro.org>
References: <20240223030309.458451-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The upstream linux kernel does not define __ARCH_FORCE_SHMLBA.

Cc: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---

Did this definition come from the port before it was merged upstream?
Or was it incorrectly copied from MIPS?
---
 linux-user/loongarch64/target_syscall.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
index 8b5de52124..39f229bb9c 100644
--- a/linux-user/loongarch64/target_syscall.h
+++ b/linux-user/loongarch64/target_syscall.h
@@ -38,11 +38,4 @@ struct target_pt_regs {
 #define TARGET_MCL_FUTURE  2
 #define TARGET_MCL_ONFAULT 4
 
-#define TARGET_FORCE_SHMLBA
-
-static inline abi_ulong target_shmlba(CPULoongArchState *env)
-{
-    return 64 * KiB;
-}
-
 #endif
-- 
2.34.1


