Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB9F5A8A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsaI-0005Pa-SP; Mon, 20 Apr 2026 13:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wEsZr-0005P7-54
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:38:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wEsZp-0005wb-7D
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:38:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a525dd2b5so813835e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776706702; x=1777311502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIqtbZxzFQLgVv222Rh4aZ/y21/2E+5v9iu3Pny8Ckc=;
 b=G1lDGutIWVfsfTEDFhVkhkoPxtH9bfa4Imc+9rIMPQGkEhGDzHSK4iWKLTCAzbZ36R
 LYMAndzUhYpv7O08HWSwEf+BeyDcEZecLXCigIUB5mmestjWA3KdzlMKga6Z15NLHgho
 dSKsaI9DnBm1eqM45rvEyPTTd9BMY7D+nyQKtzLjdJ8rZnGT8zGdHe3EXudipdkToIDs
 dFHAO9KurExTxZ+RXvNWZ66Gx9gwSJGKSzyWw7srf5kWOlrf1L+8Z4BM2et/R8g4U8V0
 zf5+EFboSO2C0m0601auqxfcoYqnG4X/C4ioM3N6a05utQMqZ613+8NcLaLIi+oVQnSU
 S84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776706702; x=1777311502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OIqtbZxzFQLgVv222Rh4aZ/y21/2E+5v9iu3Pny8Ckc=;
 b=Uv4RXXdT5Uu90RI5Y/cHxIaSYMdiFSZDRnHCRlKvgoZ0mqK6r11P0TucELTI02YaMy
 D7o6rMPVVNKTs0PoOMK2TnkuCHVV7I6sTdgKctzbRqf/ya5Jb94z3WQMa8OKlom9XQ4g
 hoPH75HFcea1/t9BrrHRx/AZuukqBGePDW4rUr7M8sE2J26LeCj3KGH83ygzvA42hvKi
 adLx3Wn17yp/O/wSTr7Gu2FjOoxfFniaO0gnKyzM0y5af5Y5PvRJy1EkmaBp8EPLtaaV
 Ac9YzYoAY7CT0J+6kQHqhom5Y7YMfXe+DNzAsDEPOGo/W0Kt5SXtE3Xf5f/Qmc1K3I0m
 7I+g==
X-Gm-Message-State: AOJu0YzqRbsSUTJoAMXozFteYrqbD0Mv3CDTeETIeXGqvJp/VBqMX+fp
 vkgM2WfA18VJb7/djw8jFTqlYanUa5U3NS65+NYJ2Nv49BRtIprVONQC
X-Gm-Gg: AeBDievGz8wgatP5vCMuKANXh1wecJcbGVO2XgP8qAw4FaIq3gfdo+IL5W+UC01Pe4X
 YMGYcFVVooCli0knqQpiy2v+S+bfWmP+l66jz0YaHtfaiH5QjQp//2PkgLR0D1Ne/H6BgHTqTn9
 BsvZ6O0q+be0KX1N0+xAGXl2IZ5UZ7g68rwekAiqFLx+rzJsfhJHaBgZnA0D4Vb7wneSOjH0/d2
 EJCNMvi9au6jl7HUGF6OAlCsTA94au3mfZuyK5NJ0YgQcskk3PaPoYELA9az8wybI/kHV0ZYlz1
 +WD6pQ+usyPYHdtZtQ0L3t1/F4Lc1yw+lEBM9VxIUZattsOe0r96vAhqONn5U0mkoMvQXq8WI3m
 MxrlRktXmmhBZVqVa1sITNpOOFfeiCFHY+FlLiBtIf1O5E9dxswrsiBeDO4dIQhBfQVHdZQYpXX
 t/LGfM3pyByDq6BovklMaOWKzZ9Hl+qpksXapgIBD+Cw==
X-Received: by 2002:a05:600c:3b20:b0:488:afb4:b98c with SMTP id
 5b1f17b1804b1-488fb7864e7mr120780605e9.3.1776706701769; 
 Mon, 20 Apr 2026 10:38:21 -0700 (PDT)
Received: from AtiePC ([79.112.87.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm28805107f8f.32.2026.04.20.10.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 10:38:21 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: mst@redhat.com,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Daniel Paziyski <danielpaziyski@gmail.com>
Subject: [PATCH v2] hw/intc/apic: mask LVTs when software disabling the APIC
Date: Mon, 20 Apr 2026 19:38:16 +0200
Message-ID: <20260420173816.63673-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225180555.154428-1-danielpaziyski@gmail.com>
References: <20260225180555.154428-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

According to the Intel SDM Vol. 3 and the AMD64 Programmer's Manual Vol. 2, when
the APIC is software disabled, doing so by clearing the software enable bit from
the spurious interrupt register, the LVT entries must then have their mask bit
set, and any attempts to clear them must be ignored until the APIC is software
enabled again. This patch implements that behavior.

Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/intc/apic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed0..c23aef0 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -919,6 +919,13 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
+static void apic_mask_lvts(APICCommonState *s)
+{
+    for (int i = 0; i < APIC_LVT_NB; i++) {
+        s->lvt[i] |= APIC_LVT_MASKED;
+    }
+}
+
 static int apic_register_write(APICCommonState *s, int index, uint64_t val)
 {
     trace_apic_register_write(index, val);
@@ -963,6 +970,11 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
         break;
     case 0x0f:
         s->spurious_vec = val & 0x1ff;
+
+        if (!(val & APIC_SV_ENABLE)) {
+            apic_mask_lvts(s);
+        }
+
         apic_update_irq(s);
         break;
     case 0x10 ... 0x17:
@@ -997,6 +1009,9 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
         {
             int n = index - 0x32;
             s->lvt[n] = val;
+            if (!(s->spurious_vec & APIC_SV_ENABLE)) {
+                s->lvt[n] |= APIC_LVT_MASKED;
+            }
             if (n == APIC_LVT_TIMER) {
                 apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
             } else if (n == APIC_LVT_LINT0 && apic_check_pic(s)) {
-- 
2.53.0


