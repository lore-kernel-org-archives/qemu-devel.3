Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4186CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrH-0000zy-FR; Fri, 10 Oct 2025 09:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqj-0007x3-JX
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpe-00042V-9d
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so19504405e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101602; x=1760706402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vJnkoQvkT0bOTZRVSjpjdc0yr1Vy1lz33J9tYlmKZec=;
 b=AzlYb51naBhxICFg8XtY5jdcKLWDfqxrCWLN/nUgXnR/WjEt8Ex0B+AgvyDD4VyuwB
 b+BndehiS+kxfU3vJL4HmiH3U+uCwskuKML+mNhYSfKxtYephdK1zugjwfmwXRwnUWcE
 X8X+YMCQQp/JvAmII1v15W2aKzW/CeXoUbjhcYVJpzsQQauEL0mlHTWoHxLUzejMNlW0
 nalY8sFGgRma4JU7Am5peqjiQStFhWPE6Kd4Ugv2a/S5dMj+zHw3xe+JXZ9uqQ3c0Ch0
 scT8YE7Yl/kGbCIqMgjw87N0x8Q7JpXxhZixfQpmupXf3W3v23+mhr/SA0crT58Evve0
 4PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101602; x=1760706402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJnkoQvkT0bOTZRVSjpjdc0yr1Vy1lz33J9tYlmKZec=;
 b=RzcYh0Wpr2Kx5UFIOzZ/yRgm0/XQiVkD3uJyDeFGfBVvn5+Z1G4G+A2fm8/KwJ1rN5
 FeAdsVtt/yAy6e+U+jGzF0y6zV9VNL/BT1unUbGDF/GgwpF2AuJ1FdZcSAKMUGJi7ys2
 eFV0TtpMn+sDIBj0AzN/h0ZPUC/GVeMuuL0AcCx6/OpG9hBKP2p8VpTKI9756zluqUkY
 CSixfAFEZfj2eKqFvuePbsaL08YexbLnjrpvlOfw8QyGNEOO+upzzJDdtotk1diKohp+
 Ap/5ISTs30lxqHHP4bLfKTKaCtl8WG5jJTE9EC/SJHIa4T5xaECLo5zhfsA6Ty4HY6Rj
 Tpgw==
X-Gm-Message-State: AOJu0YzLaujIL7FtoDIh4ZDI6BbF+F8hR5doQbKkbvt/OoTEgLOE5evq
 A+M3X94VFYmQiWJcAib4CZ4xbN/AkkSjfgMv5lWXgOlf6/O72x0vEVE/wxw8YOmYhVnz49Ytewc
 +SLyR
X-Gm-Gg: ASbGncv5Onj5cNNO+ey+M5UCz6lZv1ytQ6ewPi0A6oSYuSJAhrZiLfG8BUr+Sled71l
 RejiI1FHGd31GgVxPlpI53/sHbzFv4jexIo2Q1O4fM/ivIJx3zxcxkwOryLQQolDuHvF5Jzqqrm
 onkXF4uRRa4Ia4giYmAy3MnW85SRu7saVwzf4ETtGrDpwcRNadx7TpfpGGsaBonWeGVUeLQbtJZ
 7fwpIjBRe6srsTgJjJ0N4henw4hHPLfIMd+QTVNtHbdUlIW8UorgNqhbFojhdNZNCu/WHsNsUWr
 zvuQjwVdO37zHGyvrqqjCXFuN4QYfA5zp6yBPQGyxH4QwMgUQa6yVUFDM9aMNLMTmByC2b21toD
 0hBcXE2PzsiLS/k7eUXjSsNSnFBSO+VwnxQzeoLtfN7+H6q7jPDDg5NN06kpOCQ==
X-Google-Smtp-Source: AGHT+IF5rpL5ptCdc7CevTiuvcyoBSsAFt4V4szwDwj78hJtLwbgCd8TjU9eugaMx0gKjQVKEYIY+Q==
X-Received: by 2002:a05:600c:870e:b0:46e:35eb:43a with SMTP id
 5b1f17b1804b1-46fa9a9f16emr87696835e9.15.1760101601702; 
 Fri, 10 Oct 2025 06:06:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/76] linux-user/aarch64: Release gcs stack on thread exit
Date: Fri, 10 Oct 2025 14:05:16 +0100
Message-ID: <20251010130527.3921602-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-66-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dffe6c20160..47a6b58cf5e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9429,6 +9429,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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


