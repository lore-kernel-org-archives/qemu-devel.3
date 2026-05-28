Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DBDCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGk-0006EW-GW; Thu, 28 May 2026 16:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGi-00064B-6y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGg-0004bx-DK
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so87473015e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999829; x=1780604629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TcuxwHQCBxOEhLaF/65XoPQW44sYSph1ZcSrrBMbmpA=;
 b=xV01q0C6pINiearZ10KONaT0UtYnXBcINePplP0cy94zYhOQRtzpVssIPH4aNHAIp/
 Cy852gaTqeoCcz3YZs2DjbYpw5XMDY2wwXBUGtQnAqLC3o0u+/XO2NT+uOv0aBysS12U
 BWV1OrYMbDFC7mbBG7MKTDRYLUsTY46lRdmF3wgrj4hWjNIfmSIZF7C2yZTRI6kf672s
 XqHKk4xA2ujHa6ZA64jjr4+M6sShgWHGQ4oAyNYCWA0kuEj5z1Y47bC98RbOqAEB50Kj
 qRRp+DZQUHMyihXegr8BrJAoAllC1DRQSmLHiOfAZv1pT5cHpxynaoqRWHYpkthus0+O
 Lxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999829; x=1780604629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TcuxwHQCBxOEhLaF/65XoPQW44sYSph1ZcSrrBMbmpA=;
 b=b+nOppb5Aaj1v7RcFmgHGpAXKrWVA2B5dVi1g9eb+3cIW4VglRzk/jXCEbhFPBfi2T
 wi/J1Jbau0da+MDM9wva96uJJOyGw2Xx+8dCj60lVReCJ+iAYPfrUdz+wYwTkB0eiRbd
 xMmmngdJy3fxfKeBIcDRfV3RK8wP3YhHRKSq+HcjqWSWM2Xcv6JDsMHkCpnRGOQc/HtM
 WZvnuLxrXLfUhI8cwVqrFKIfFfiPQsYQB5GOBP0AbWkr/o2Z363UHm8HfXLWM/c+Nw3z
 DMz5DmyVYZmxW7X0BB9d2rnPf65cEFm04QHiy1XejVqZq+9wrLwu1pwwH8qoJIZ299wm
 GruQ==
X-Gm-Message-State: AOJu0Yz9z44RlPeY2UKCdKca3EpysuMJAssjfyMnV19wTa3cdECDkcdW
 HvoSN7QGfZxUNOby80fP6Jn+DA1NO+jyvJlh2DeAUj7U5TzUJH9OhyP0aFu1WlntYL0KYaykfwa
 y0+H1g/DPuQ==
X-Gm-Gg: Acq92OFxvviAo9bBlcUzKX8La9fqj5GPWHGgDCVdE4twjKyc8+4Z8+ShMm4+4HJCSZR
 2ToGURyDa4yViiBiZ98InLHDIlqgz0vO7u5U/fKS46U//4mBdUJH8EX3eOqiGxI8BzbvVcXYw5f
 eh99svjo5B6haN3ftFroO636eMx4rdc5MKC6vat8UM17sGKM9pL/iLf4AE8jWBZ1BuG9O/Xehb0
 tXHzGbw51VQrisXN/5bkOHf2EO0/Gg2VTjVXADQk4lHLAUkoRmsdDQHgwHOWCOyj9wK86CDf58i
 FD4jVuoZP6AqNE0Zjth91ltA2mDVQooD+P6uwbrujyOSkASGBjC4byKF8IVh0d+2qsRHjnq6eKe
 mLi+ZFcwEmkpzARlaVHknChRzVn57VtyqjhDng4hGF7k9V/pOqq9pEVMHpmmkuJcuuxpRyCmBWb
 dKpRV4yrJIhwrl4Rt/zdcPJHIqBfqHOU6sHvCSOjA5XRzanbGPbvMiXOC1r6sSgmKYhg==
X-Received: by 2002:a05:600c:620c:b0:490:f7c:b19 with SMTP id
 5b1f17b1804b1-4909c0c1a60mr183395e9.0.1779999828626; 
 Thu, 28 May 2026 13:23:48 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909bbda6d5sm1038575e9.34.2026.05.28.13.23.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/22] system/qtest: Fix length parameter in the b64write code
Date: Thu, 28 May 2026 22:22:37 +0200
Message-ID: <20260528202253.49122-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Thomas Huth <thuth@redhat.com>

The b64write code has a sanity check that the given lengths matches
the real length of the given data, and calculates the minimum of the
two values to be on the safe side. However, the address_space_write()
then uses the original value and ignores the calculated minimum. Use
out_len here to fix the problem.

Fixes: 70da30483e7 ("qtest: Use cpu address space instead of system memory")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20260518134020.1420932-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/qtest.c b/system/qtest.c
index a79d10d1361..d6db057b0a2 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -698,7 +698,7 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         }
 
         address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+                            out_len);
 
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "endianness") == 0) {
-- 
2.53.0


