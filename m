Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FD1D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD19h-0002y5-T2; Mon, 18 Nov 2024 07:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19g-0002xv-Q6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19f-0005NO-1f
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3824709ee03so651954f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934017; x=1732538817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYaQEXuNR5+lHEU/8nCGWk7gVy7qrMgUNRPmBIpU6l0=;
 b=OQO2a5SAdBdsaCE8oBcaWZ9Qz3Okoqm9VRw+ZB5IRJvvrRY+67j0fBWiNgoeLRGjcu
 TKbIBs3bmM/ExMXXeF5v0hesqVCHOf+Yh6MHqiNlg7hK0gw5AppC8e9aai9sRGmocLoI
 WP3/yHdaMFQnRUf1BIk438xJiF9NS+MwAX8de6qnFbOvZBfCI9BE6EBWsVxa+mNV3zGK
 NvG6x8/FnYs+sGMGsg72NmjApuqhBSlR4lfFtvJl/R+sG3D213O07pPX0AS7gRpy66EY
 dQnhaqgzJz38EGHlR5DG1X2ohtmu0HuQTZI2OjrswiyP/nPQvjCqtVZskkbjBVVc8vD8
 n1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934017; x=1732538817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYaQEXuNR5+lHEU/8nCGWk7gVy7qrMgUNRPmBIpU6l0=;
 b=t9Ee243pmeVRddzxNaVHgOOxPI8MjgCNZN3X/PAFVyqW8DbfSUl2joBKL7Yb+4Q+zI
 VAMWDm9f6hKYf+VpSoKqfF7tx6vPQAyq4FmOf/G6Eu88/Fq4KxpITZDyCf2/bjRORbkK
 pv0HWRqdjd0eS5LjA+iDE+ZZ2EjDNjUm6vqEik/4z1dro9pZn1U6KVEvJWcCpGmtWD3d
 6yKQ42oWXl6r//OlgPHU7xAZe+bWAdbrPtBxIMy8ke/tORfgkN3KSQ60P5ueS2u4x38r
 fcnba2hA6ULmpkSPNuwi5hGlnH3cwyp+eivfVjEl/cWpenilqmAw8u7gASa8rdUNTaHI
 GyqA==
X-Gm-Message-State: AOJu0Yw342X5CLgrhjo/Rm69Z1D1yvp/tF9kQdDqUzyl5Q1C8OKoFkfs
 KgFGcsf8h6VmxcMZfyVnh6aSUFkHmhGvRxFWjJY1R7Fg0y/Ew7KMyEbF9M9ogGf4xTUOTw94rN/
 V
X-Google-Smtp-Source: AGHT+IGNdfeakP6/JxfeWYZ6+tFEh9hd1Ly4sN2R3qZr8tsW51LVZL6nKb6s+0mud0XEVGF1s3/YNQ==
X-Received: by 2002:a05:6000:188f:b0:382:450c:25ee with SMTP id
 ffacd0b85a97d-382450c2aa8mr3968418f8f.40.1731934017117; 
 Mon, 18 Nov 2024 04:46:57 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3823d253773sm5992907f8f.36.2024.11.18.04.46.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:46:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/15] hw/misc/nrf51_rng: Don't use BIT_MASK() when we mean
 BIT()
Date: Mon, 18 Nov 2024 13:46:29 +0100
Message-ID: <20241118124643.6958-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The BIT_MASK() macro from bitops.h provides the mask of a bit
within a particular word of a multi-word bit array; it is intended
to be used with its counterpart BIT_WORD() that gives the index
of the word in the array.

In nrf51_rng we are using it for cases where we have a bit number
that we know is the index of a bit within a single word (in fact, it
happens that all the bit numbers we pass to it are zero). This
happens to give the right answer, but the macro that actually
does the job we want here is BIT().

Use BIT() instead of BIT_MASK().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241108135644.4007151-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/nrf51_rng.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index bf1eb0cf4a..2d67f3f766 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -107,25 +107,25 @@ static void rng_write(void *opaque, hwaddr offset,
         break;
     case NRF51_RNG_REG_SHORTS:
         s->shortcut_stop_on_valrdy =
-                (value & BIT_MASK(NRF51_RNG_REG_SHORTS_VALRDY_STOP)) ? 1 : 0;
+                (value & BIT(NRF51_RNG_REG_SHORTS_VALRDY_STOP)) ? 1 : 0;
         break;
     case NRF51_RNG_REG_INTEN:
         s->interrupt_enabled =
-                (value & BIT_MASK(NRF51_RNG_REG_INTEN_VALRDY)) ? 1 : 0;
+                (value & BIT(NRF51_RNG_REG_INTEN_VALRDY)) ? 1 : 0;
         break;
     case NRF51_RNG_REG_INTENSET:
-        if (value & BIT_MASK(NRF51_RNG_REG_INTEN_VALRDY)) {
+        if (value & BIT(NRF51_RNG_REG_INTEN_VALRDY)) {
             s->interrupt_enabled = 1;
         }
         break;
     case NRF51_RNG_REG_INTENCLR:
-        if (value & BIT_MASK(NRF51_RNG_REG_INTEN_VALRDY)) {
+        if (value & BIT(NRF51_RNG_REG_INTEN_VALRDY)) {
             s->interrupt_enabled = 0;
         }
         break;
     case NRF51_RNG_REG_CONFIG:
         s->filter_enabled =
-                      (value & BIT_MASK(NRF51_RNG_REG_CONFIG_DECEN)) ? 1 : 0;
+                      (value & BIT(NRF51_RNG_REG_CONFIG_DECEN)) ? 1 : 0;
         break;
 
     default:
-- 
2.45.2


