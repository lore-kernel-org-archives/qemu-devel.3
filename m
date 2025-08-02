Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B73EC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLws-0003WQ-Jo; Sat, 02 Aug 2025 19:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoc-00060a-Fk
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:03 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoZ-0006Se-Gp
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:00 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74197e72d3dso709956a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177938; x=1754782738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=bFIi8dMk6OPSVq6xjeSi6zKmtZ+Wh9uUsmbiZ/woS4hYBrv7pnDhGfGqRU638FnLED
 bYORC45c1tgvByKKXA15UZkNwLTsNkR5iGLJTSFCF68q7kxsoH7gIZI9bRjjni4Dqnjd
 QDZi3hWiDuIEyjDfRmI1tG/zCIJ0aZlMVuY1YYUmtfrYh76ze0Zy8Q/GCsk1ijom27KV
 Z5ntaYVWuWa/3EycP0Wl+T2Qsha9fPPsQWysWd367Xq/eX4BLUa+Lxpadr/EZfMARgWu
 e7HKO2teqccoypnXugimTnL46gyInkUlBVzeZ8IRs9J/v28xVI69IIJWOluZizGkq+su
 cPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177938; x=1754782738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=WDfmK/TFPfSkz3/BsbEnZT8givdMkiFrlHltPiozZ/XAzPnUeXATrN4FtvlA29m9QF
 Qr5fN2Ld3aXKLryG+4gEhCUcm5+p5T1zQr3l8bLr5cg35gjYOPF5mH3APQEuYSIytk9U
 mAY9wl3y0miKGDnLmT1xFBgF2LFSYW0OY9vfoL9rp2BIzRSnB1wl7KG8i5+qBLzLLSJQ
 /1fFXTWZ1Eg0U+D8L8In1ndpRUpn0hzZg0omNCLXK1ggiPnbuZR47BATjjmWVTvplz3E
 hzvhvwDoEf2a+0gqMWoMdpInx+C84Q91wxlo31PXn/st4mxJdZbaN1RwqIhHKU8enxrU
 /nhg==
X-Gm-Message-State: AOJu0Yys3Elj3GL/ajPA47qoMBdVU2Ig2BqQNo998oPB1e1bj0fSrTYF
 f0hzH00KSc5Vg+n+xoyioFJHCgi6HtqIkdx6F6B5vMhY7gEXwXtg4PaG7sBORT+qDPSv4EzDgLe
 K1aPebz8=
X-Gm-Gg: ASbGncuXcxbXD6pliMQT+IjhDeJAowSmWS8DzJ9xcXP7oyjBTcoGG/lAqvYGXgti0EY
 0WaGHx7p0rDzYpHkFwylW0A8wgRnrn+jwZh4+fP37LBup6wRZ4crNakGhFhMgoZGxLNahsUBtzd
 wVgMbUkTCTWUnSlf1S0zEnBPwqX+bQJhI+n5JvlEidLnvbjRHJVDqvet06yca1Jwif69klOk7je
 smPOp9Lak7tQQrEMzkRZH0010JpmSyqlG1nmCE8A9lgkckkjpDnaF3l4Ek0IbUoPhnHl9FKXigK
 9/MCEkdVuYNxH6GHaPzExfJQX+bBav45B2Hl6HsZW6wZkcbrLWr9Voed5QWIk52psOYpGDfwIMV
 7pzoursTB1m5Dt3VAvVOvugV2SktfqvHv4E2qVZXg+AoWy8YXtgOx
X-Google-Smtp-Source: AGHT+IFd12Afo8QLFxyH/ZRsIH+89fl14VFvq+w7cMHvbMzfQ9zIJGF7ErYF9J5a6uxYhzuZOijjdQ==
X-Received: by 2002:a05:6830:448c:b0:741:afb2:7ad0 with SMTP id
 46e09a7af769-741afb27de7mr357618a34.17.1754177938449; 
 Sat, 02 Aug 2025 16:38:58 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 76/85] linux-user/aarch64: Release gcs stack on thread exit
Date: Sun,  3 Aug 2025 09:29:44 +1000
Message-ID: <20250802232953.413294-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91210775ed..dfe114ceb3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9309,6 +9309,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                              FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
             }
 
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+
             object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             /*
-- 
2.43.0


