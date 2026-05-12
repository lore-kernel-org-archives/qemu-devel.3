Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB74CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZg-0000hr-2h; Tue, 12 May 2026 02:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZB-0007g0-8l
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZ9-0007Qu-Cl
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:04 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d75312379so3860062f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567161; x=1779171961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KTZoDqLkEaJpfPJBDyKt3ZmMMJNtjsP8cC3diZptPv0=;
 b=F+RR2BbT4CKJHnnuJZPmZKNU+YMvSuy51fPQpaLrW92lzJm/veqoArpqz/FZDXkGuq
 9lwtbZRgUgWIyp6VOl4huQ3eiF79gIoI50JW0z1Srk932ybqDvHaqobPJxXm9h3nJkhe
 ur0yHw6VxidOqe62TIz2bis18Nc0eiM8hXBIMVWjW0lNNuzv8RXUzE86bzz0sjdJ0/IB
 sG2HQk+K0GgfZOpj7Tr0L/zmNfx35g6nt/IN4MirelZFDDy0hUv41hcM4+WPvZrjgirI
 DmCFcW32dY5WMP5dzbNLkKZHZXHn0IYFYTp2xKZ+wjNqbbv48SAD1b4Jp5aU9DxA+jFW
 ktnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567161; x=1779171961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KTZoDqLkEaJpfPJBDyKt3ZmMMJNtjsP8cC3diZptPv0=;
 b=gTV1XjaKWe+Icc7mqAujB0c0RaLtjqYrTUmr35D9zHESvpnZ/f4n6nhfu8YCrAb+8T
 3tQNmu3JXTxD46L+NEKMwIF3KTPfSYCuwS/9397i6cJML4D9np3f0/OkykN4JcyWn/RM
 L0VAvXf0GZVeNrI6sLqmxz1Dgvppf+Be9x4OsJc+DdSEHJVHjTfy1gkcWlnIZiBIITCr
 vwMpJ4qk/3k4OqRdRrWNOCHAyE0ViLdd8gmpCLUI8eimG6vLN/4tYo8UTX5uTDxbp2Jy
 yNA9KQmOYasOGXMnRrcJCLQUMbA5dENIOAHia+W1tkHTBn9pssdc5fILV7vL6IDoh+6Z
 pEYA==
X-Gm-Message-State: AOJu0YxdrcmxW8joW+01AOQEVJH9FBc95vL0pzPyiRwv52BI12VE1gXB
 DVGe7aOVYU0pZIRAFijNDA/BIKq1Q2zdVRz8velsH2HStyggX4WbF6tvLcFB4ZTkF9MpO5LXrNj
 KaTMg1cI=
X-Gm-Gg: Acq92OFCMvrsjqPyxcSqGcGqAONNGJDzv+P8yTQ80bjOKIEVyWeSMWv1ptHsutnOHvB
 m0Z6F6dUt9ft3uqa/+Ds9/ixJ8jQ6p/T7JRhGVCDhRJ3BQ4XvniBygCkFeOaBC9lfRkyh0cNGDK
 1dIGdmg/UqA0jhVmrR4WPJJTwWlgwSawuiRlYh5Gw1NyOgmwG2Qm2XcuqlXwhFjcN8CwF7fyaFv
 0lmmbm3VVASEMsH/02NOq3CeucbkE/umrW6j3+CArtwCvjw7W4W0x3LJvGG8G1LOTKrEOmDTy/N
 Fs5gLC0nTspVFfCd4lnJuUYphMuCuVLL+Sh7AXNcutZRflvu27nu742Oc0vFUGf/6i4Sglbyinn
 z1CkHPqqgMaiEQXVM7bUjMOcqSBIXhxGkG1i2txS/PqRs3Binu8EAhnJYejccaaHPnhIp9Dff9M
 McLTenl6BxWcvnUuzhrhOOKwaAC/k5BZbPxd9uCoxtIRZZNmHXM4rbvbCCkUv2zGBzuZ6K9OE6
X-Received: by 2002:a5d:457b:0:b0:453:9897:76aa with SMTP id
 ffacd0b85a97d-45ac32bc5ebmr2261296f8f.21.1778567161486; 
 Mon, 11 May 2026 23:26:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm33352813f8f.11.2026.05.11.23.26.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:26:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] hw/gpio/pca9552: fix state_str leak in pca955x_set_led
Date: Tue, 12 May 2026 08:21:37 +0200
Message-ID: <20260512062142.67998-37-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

visit_type_str() allocates state_str, but the function never frees it
on any code path. Use g_autofree to ensure it is freed on return.

Fixes: a90d8f84674d ("misc/pca9552: Add qom set and get")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260504-qom-tests-v2-35-ef7e3dc94f7a@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/pca9552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index dd3f1536b65..472d8ad9571 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -342,7 +342,7 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg, val;
     uint8_t state;
-    char *state_str;
+    g_autofree char *state_str = NULL;
 
     if (!visit_type_str(v, name, &state_str, errp)) {
         return;
-- 
2.53.0


