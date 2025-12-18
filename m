Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A59BD6E2D5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIar-0006TT-J0; Thu, 18 Dec 2025 13:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaM-0006OX-2Y
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:52 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaB-0002zQ-0x
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so821471f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766081909; x=1766686709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2jzZ6rMbXeUMPOwWK0Noq7Cc0GkvQldGamqYQfCrH0=;
 b=FBhttFlhM5kfbnIfdiW/hsoU6NC6lCOgkK8XjF0Ayu5gxiF2f55OzKwLT/4tfc3ktO
 Wu21vY4FDDvCXntT1SvCO/KoqcvnmXaNOdUU5ENjnyZS+f+ERxah5xKEjMYlfiKDnGNf
 e5ol+3uHcv8rdRqIpz2+1X5KzV67uteJvetuyEB44nQwY5y5iJFAdBDp74NchyUJr+mf
 JL57oo2iQ8AILMY5jDZLbj8Iyva6YBrL/G3rMPUkmuadE14WF/RUolvjN8KLuqCCKxCP
 5GS1v25HEEbWLuxRRyIlQE/GkOj7he9vS56DO0YGD7WOF2iFFpyxcs4JNFsQRrPvneVj
 ApLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081909; x=1766686709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2jzZ6rMbXeUMPOwWK0Noq7Cc0GkvQldGamqYQfCrH0=;
 b=rXlsdwZhHyqShhaG3dbt2UD4m0cdPuAnLvLFejzfkt7tEUkvpvC98uX0QHbp654GwX
 N6CaHOeNA5boduvX8s+p7BOEfVu4t1/oK185mf17/99+kqI3vJpdOCx/HtPY9amn/7JI
 513ZIJrPfPl4Ck0pq+BYoDgL75Cx8KrIipNrDhgy1+KIw+1ui0ECGr/cyiSuD/gyYgvX
 YAsE6U/Bj3rU9H+3Jwu0FdgSzRJR8IbhIPbwmUYnndouyNRvsb6A1rPnLzhCkA7dZjKA
 uVVEK3Y/zP0sBRckajvrXFbhMJsF9v2+L+ylT0wsGXAX6Qehyl+urGgVhyINZcRsUfFM
 gIUA==
X-Gm-Message-State: AOJu0YzirPS49shcMeXO6Hca4unUKDbUDumJMpZWcN96vYe7rtaKTrD3
 qlBXkJke9mZzrUo0dahT10Vo8+l8WCfHGLT+RqaS1rmDe9aIAmuEahVempSqPFILLLrrsNkWy0d
 Unq9zhJMHPA==
X-Gm-Gg: AY/fxX6QFqPVbgcK97njsjhhuILMIQW0kRvj/oOc5N/d4ifdpb8oa5lf0ujl+QPbTZg
 kVGqCfLPc8HmjXcaJKHIC5DZQhZbVBpJXBNyJdhZBe9qnk2PHvMOv9X9xfnxHxoDV7k/xHbyFBE
 DGKFgjFTOSWPL/z+4upOOSIqNuIfqphD8VoCZCRxsokV0GuU6kTNrRw91tT/8gf9GzGZ6HwEOW/
 OFGnYxawX8Exbx4TohxIIFXiocyYLcMU19tF5KUncf5TQCqpX8aPXCFEeN5h9cgAvqlgIBivi/O
 kXm4NTg6XYWTx4Mdb0zXMgFzGAzQezDKq/RSN1V+cOSWQ+HyetiboXzROAlE6CWsZ7nSgc8vVIu
 7AnmMfLM1zqYRgJPwTloDRBDOkxOyf2q2rqAirJB+UWZCV1BMeNbhA5JtK6a2sCiPA1C9pRq9Zs
 fxwOJ4rASPgeygrvmr6Vzc2fG/nq9d/+xd25ShWizBlw5XwxAMEvPaI7Eum9ZV
X-Google-Smtp-Source: AGHT+IEAW5huNZELbZIqdkHfWdDcXAGjayFL02oMUq8eWGUy3O/rAQUyNE/GfTGxZLtaQgaaZuRg6w==
X-Received: by 2002:a5d:5d0e:0:b0:430:f58d:40df with SMTP id
 ffacd0b85a97d-4324e4c7132mr487404f8f.10.1766081908907; 
 Thu, 18 Dec 2025 10:18:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2a94sm185691f8f.43.2025.12.18.10.18.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 10:18:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] hw/net/opencores: Clarify MMIO read/write handlers expect
 32-bit access
Date: Thu, 18 Dec 2025 19:18:07 +0100
Message-ID: <20251218181812.58363-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218181812.58363-1-philmd@linaro.org>
References: <20251218181812.58363-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The read/write handlers access array of 32-bit register by index:

 277 struct OpenEthState {
  ..
 287     uint32_t regs[REG_MAX];
  ..
 291 };

 546 static uint64_t open_eth_reg_read(void *opaque,
 547                                   hwaddr addr, unsigned int size)
 548 {
  ..
 551     OpenEthState *s = opaque;
 552     unsigned idx = addr / 4;
  ..
 559             v = s->regs[idx];
  ..
 563     return v;
 564 }

This is a 32-bit implementation. Make that explicit in the
MemoryRegionOps structure (this doesn't change the maximum
access size, which -- being unset -- is 64-bit).

Move the structure just after the handlers to ease code review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/opencores_eth.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 7e955c01322..bc4565a9a49 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -682,6 +682,15 @@ static void open_eth_reg_write(void *opaque,
     }
 }
 
+static const MemoryRegionOps open_eth_reg_ops = {
+    .read = open_eth_reg_read,
+    .write = open_eth_reg_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static uint64_t open_eth_desc_read(void *opaque,
         hwaddr addr, unsigned int size)
 {
@@ -705,12 +714,6 @@ static void open_eth_desc_write(void *opaque,
     open_eth_check_start_xmit(s);
 }
 
-
-static const MemoryRegionOps open_eth_reg_ops = {
-    .read = open_eth_reg_read,
-    .write = open_eth_reg_write,
-};
-
 static const MemoryRegionOps open_eth_desc_ops = {
     .read = open_eth_desc_read,
     .write = open_eth_desc_write,
-- 
2.52.0


