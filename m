Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FF2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJa-0002py-35; Tue, 23 Jul 2024 16:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJU-00025I-2g
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJS-0004RN-DZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so43047005e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767245; x=1722372045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/yrpwbL/sETCyin9I+oHUPZfHbu6njuZ4wq9Na1o4A=;
 b=LIw6LwRbIQXe9LEuMswlNW5CY8TJEiurSyHCthK3vo/g23MfgfNSQgxwj1VVY3vRg8
 ZixBOWVgycTDuESiwgjnyz4X0Tl6dz/ptUeapRlN083+mdEo26OGGzuPza3lIlrO/qD4
 t61DQEA3Xkh1sJ9yKJvoHZxqxbVHwZybVnZuuRYorgzoHd26E17TZhdEPM4ZmkVeVnu8
 hLMiBFgnMw8k7t1E3VkwJg/hvkBye+5VPmHhFNXt5Y40FN6BD1It90FdAvcN8rv+nUbn
 90v+i1SrAnnX7/9VmCR8uYzwJs+Wd3HnHsrVO5tAwG+szkbI9NTOJBN4z923dp2T/7l0
 3npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767245; x=1722372045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/yrpwbL/sETCyin9I+oHUPZfHbu6njuZ4wq9Na1o4A=;
 b=Z/vhoqoYAWCZ2TEG08o48qJkN86Jtt5YMd0m4pKFwGisHY32TQtyFVhv8zW0MmcbIX
 2rSPWjFDGjQQoy44hNMoVsxUJ/a+AJRGLe2yRt+2ZnrSqUvyCHHcja+q2urFytpLzC28
 iViyaMVN6PCF8rXZGboea0s6S9H8OjMRkvw2vJsdvEtxf9C60iL2cRG42mF4rdMiQbWm
 0GIhjvTZldPw7mAtNcXlzc9dvILJ0OhpOhP6ElSF3+Mkso4Khz24qLjMu7sKT9uLVYLV
 P82k9bWhe1S17ysF+lySu/0XbchwbNgfgF4SF9i8Dc/IsVgFnOixWfBQk64/4+vM7nGS
 0YJg==
X-Gm-Message-State: AOJu0Yxn7SXz7n7JQwBw6mlTgc90gs/Djsje+Fr+7WHhlPDH8kpLerse
 wR2BOaEsteWthbjPpWIn83gwXxQGzuMM/NoRXdLHeZvYzjU2Zi9aye69ZFmlDiSU126S7ePtwq8
 9yzk=
X-Google-Smtp-Source: AGHT+IFiBXhYHIAzVlWhXrp/TBqau1VQTshg1DAjiVcO1ZXCliV7JlF6jcOvFzaCAk5O011P7IqqCA==
X-Received: by 2002:a05:600c:3542:b0:426:5c36:207c with SMTP id
 5b1f17b1804b1-427dc569de8mr70546675e9.25.1721767244800; 
 Tue, 23 Jul 2024 13:40:44 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed572sm12368044f8f.110.2024.07.23.13.40.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 19/28] hw/char/goldfish: Use DMA memory API
Date: Tue, 23 Jul 2024 22:38:46 +0200
Message-ID: <20240723203855.65033-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Rather than using address_space_rw(..., 0 or 1),
use the simpler DMA memory API which expand to
the same code. This allows removing a cast on
the 'buf' variable which is really const. Since
'buf' is only used in the CMD_READ_BUFFER case,
we can reduce its scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240723181850.46000-1-philmd@linaro.org>
---
 hw/char/goldfish_tty.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index f8ff043c396..cdff46bc13b 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
+#include "sysemu/dma.h"
 #include "hw/char/goldfish_tty.h"
 
 #define GOLDFISH_TTY_VERSION 1
@@ -69,7 +70,6 @@ static uint64_t goldfish_tty_read(void *opaque, hwaddr addr,
 static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
 {
     uint32_t to_copy;
-    uint8_t *buf;
     uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
     int len;
     uint64_t ptr;
@@ -97,8 +97,8 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
         while (len) {
             to_copy = MIN(GOLFISH_TTY_BUFFER_SIZE, len);
 
-            address_space_rw(&address_space_memory, ptr,
-                             MEMTXATTRS_UNSPECIFIED, data_out, to_copy, 0);
+            dma_memory_read_relaxed(&address_space_memory, ptr,
+                                    data_out, to_copy);
             qemu_chr_fe_write_all(&s->chr, data_out, to_copy);
 
             len -= to_copy;
@@ -109,9 +109,9 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
         len = s->data_len;
         ptr = s->data_ptr;
         while (len && !fifo8_is_empty(&s->rx_fifo)) {
-            buf = (uint8_t *)fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
-            address_space_rw(&address_space_memory, ptr,
-                            MEMTXATTRS_UNSPECIFIED, buf, to_copy, 1);
+            const uint8_t *buf = fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
+
+            dma_memory_write_relaxed(&address_space_memory, ptr, buf, to_copy);
 
             len -= to_copy;
             ptr += to_copy;
-- 
2.41.0


