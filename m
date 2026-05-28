Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA422CD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGV-0005ZF-UB; Thu, 28 May 2026 16:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGN-0005UO-Vx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGJ-0004Se-Su
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso40827355e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999805; x=1780604605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nvErN0bH3sh4BO43KLmMySscIIcKgO6HqL3/2HV3OAw=;
 b=d2HJwgCGezQ3G2FGYWNqh7f0XtCTy4Jr05mFwfCCYI4JUBBfYl3trcX4hg3vmYtQtU
 zS5cY4GdV3MOj2mRkYA8yuz3yCLjV20Hfj5P9OAUbneaBoPba11VPsBUoDcpop1PSgUu
 LnYjpOQz7BgaO5dxcbQ9WfrpLaVKcaCRfjIXyrrdEDjzLxpv7ir2N3cY3bDpr2zYUxsO
 BoPuhDr6XfiV+Ygb1+HrfDAZcDSlgyD2y0tLGOynKE4n6ve2nG9bBKiHCi2rThW+wnDb
 hFPnmDAhNybr/0TZPzEpKcxePJOUf2tHwYGb91vapR+ZWLouO+4Sty0cp1s5NqhVt4+3
 hKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999805; x=1780604605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nvErN0bH3sh4BO43KLmMySscIIcKgO6HqL3/2HV3OAw=;
 b=Oee+WGqpauuu+Id90KUODBOIo5xRWufn98xwEYbMbLKeS18rJwSrmLB6AFoRkAjmr/
 5DJoJ1w8VkSz/FVEIiHwXcv2H59prF7QIjVja20Z5yhfUJyXLx5SOvLENxb9K5jRIIRA
 9hW8Dds0gyTRSECFSJ3Wlz+9sr+2xWBcC9dallWOv4++QPRJFPWdHOTcVd/D3ukwgOZ8
 eA0+1Q041ZH5UVpV+hQsryvFVEMrGy14BpvP8Tc5ZB7OpDN3Jylhm3VJBhLOUCzWODQb
 TA8xhc310nciojaZ6Dt2mVpoN50nI2v8pMweQLZXohzFKd4RyFGARQmB+xrzWTrH0MvH
 s/LA==
X-Gm-Message-State: AOJu0YxDrqybYjwicDqC7kG94Wm4qgVLA9PCesmuR62ZSu4xcV4AZIef
 3MFIuzXOq6gW5S69Z+aWMXnLFCypK7hrZS9mh7iMXXiazey0AL9DsEolvE5iRUvVBRjsEkLCko2
 kipqSiWyhng==
X-Gm-Gg: Acq92OFk1L8tX7NDupBqM2mczZO2tV6bH8vTUZ3IBownwqke2BhjML9awPElSZQx2QS
 TYNE6nKV7lXIH4QAe1N6WDnAFZlGG52bRui3YuqBoqVY2fyC9b0cSGfJn2OJxRRw98v31Wor7oM
 dXN/S2Vx+H9k2EQ4X3u7pYsXN3qdhHNWnCIKhEIooxb8Oeyj5eNbUYXMNLFB9dM0lICbYnTKxhi
 JOqfSS7TxUuN14POLjo3CwGV7dSPZj4jAMNYCLe/2fbGeHOxKm+D1Ouq27r5ZxTcWbSG2uV+MXr
 bv0vIpKvorrEMjucmAkleSYeB4U7Y3UWGIqJYVWhdU6CRjgb1US1mjXGioYfoQfH5CBIjK7SIA9
 NTj67Sqa12/1El9ZzlMlgbZnNqB0RkTJhTiP3HpUUuwVcTOyFm3+C6zeGt+kPKDu9/SoKklFuno
 esnuhBCiKrP4IzUAb+ewmMcJU2CECzP1qRWjMxjLRyE8NlLaYk1fvDHzOERgA2rqMxqO0gYEFgT
 o8S
X-Received: by 2002:a05:600c:4f83:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-4909c08253bmr807565e9.8.1779999805280; 
 Thu, 28 May 2026 13:23:25 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909284a8efsm72506135e9.9.2026.05.28.13.23.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/22] docs/devel/tcg-ops: Stop listing dup2_vec()
Date: Thu, 28 May 2026 22:22:34 +0200
Message-ID: <20260528202253.49122-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

dup2_vec() opcode was removed in commit 6e7b13936d4
("tcg: Remove INDEX_op_dup2_vec").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260504125032.35465-2-philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fd3a50bf4c4..c417ebe65a8 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -769,11 +769,6 @@ specifies the length of the element (if applicable) in log2 8-bit units.
      - | Similarly, for a constant.
        | Smaller values will be replicated to host register size by the expanders.
 
-   * - dup2_vec *v0*, *r1*, *r2*
-
-     - | Duplicate *r2*:*r1* into TYPE/64 copies across *v0*. This opcode is
-         only present for 32-bit hosts.
-
    * - add_vec *v0*, *v1*, *v2*
 
      - | *v0* = *v1* + *v2*, in elements across the vector.
-- 
2.53.0


