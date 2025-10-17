Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54AFCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lD0-0004u4-Hx; Fri, 17 Oct 2025 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCu-0004sY-28
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCW-0005ju-Qe
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso19999905e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710375; x=1761315175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoQ6SLuQ7FwjPP9PEz/jS+6Ivn8fi/SY5nUjIteDwfY=;
 b=PtErTXWow+7QUmH2tTPRGNJdn1vO+9Sl7r0JZfO9aVygyhAP/9pd74qgDx4oGFKpi5
 7Hazh6+3sV2/4nsCBUTBzhfQ+mAc/XNuJmSuGbsltXkS3yCm4IIzemNpSz74cPV+OciL
 j+xWE+pU7x4fNr9xAf+Go3EW97f8mFemAib4OrIDVn6vZ6Lw0nQXOQMhysmZHlXtO/Dj
 /iQShfIwD1+13SHnOpFDKVsPkdruylXTmkPHy40IdQ7mEUzTqcOF/99pIuDMw7zS288L
 AVY0XIwSc4v4TK/dn/SJvl9lrS7TNBw6SHwlfkyq/SAK7dwCaqk0OcUxRiVhwdQF1TFg
 9yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710375; x=1761315175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoQ6SLuQ7FwjPP9PEz/jS+6Ivn8fi/SY5nUjIteDwfY=;
 b=cVj/xJBOVptVmsodgFRs5/UzV0JwTuoMdwvSPWAEXUvfujCBBtnwDH3RVrYj+eW/26
 5vgqK05k6XK/tri5X12PTomG7EenJeLptB/kRV0Bs08wmmQgcF8NzOjoEnLdCkhwbOwn
 T3NjjmWbdNy5/sNu3KrBZaKdMtxNT3SNjTLvo/DgaYfUfF17qpqWRN2bYWZBOCM8TJzc
 gAhuoFVmRsIJ4mbcTJf8g5qaoNuMPGtr9TUEeEfDw3bga8r90uPVTEUhAONrIxNLl35I
 34kRduwWeRe447q7I62eFXAkgFfoDZlW2cUXez5Rud1WlEpx4xQkZReHWSLsVzLDB7K/
 MA3A==
X-Gm-Message-State: AOJu0Yx2rU2We3Kar8OoKph+d/seIZPd6jfuzZKxZgUx7ebjqIXX6VUE
 ztJqpn3ZVDYqRIfDY3RjvOAZBluabzdp7PN3qUlvjktHxIsBYeZcjS3HB1peQg==
X-Gm-Gg: ASbGnctS3X2MAhRn6N+6dZv5nbw7V5jssLmt281CJTaaUqKbtYsapbXDhhtBy9aIT94
 ZHOGT9Dred7RJwE6HxunGyxLje3Hmrz/wrpBZMzoopK/GON4EvlLJwsTU+G/GFImISYSRthysvo
 K88Bj2a3MUWim1PVl77D5Ornc13wOc+tfjpDdZ5Sys2wigsmTEcoA3o77/RCQwqiX/WMAj20z1N
 nn8sISTnjNBWLfgRlMfa0LCbDpdARbFAvS3jn38RmkwqzZA4zDCgY6D9t/XKERjAIYkD17yzvzm
 zsmD7c/iOiLgdKjvnVfFg3PfUvWqJws6Bpbc3dXwjcMCI5R92gptO8M3e1ChLk606zy+FYX0P2X
 cdsiu9s4y+QiXVg9mameci+yO4GXwWqXA8IF9seMQTwn9MiFJrQXthlu7Gr2vHo4DK1QCnWP4dY
 Z1JVc4qwhbc92pStfLgcag58ti/Dh7g/bhIbqORcBdBhs=
X-Google-Smtp-Source: AGHT+IGDUpHFktS1phJv11AWEB4wPTsgryq8zLqwvPwmU/+IRwKwm/FCG4X5/AX6gCWAr8CSOUFAfQ==
X-Received: by 2002:a05:600c:548d:b0:45f:27fb:8016 with SMTP id
 5b1f17b1804b1-471178726a9mr27315245e9.1.1760710375304; 
 Fri, 17 Oct 2025 07:12:55 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 09/11] hw/intc/apic: Ensure own APIC use in
 apic_register_{read, write}
Date: Fri, 17 Oct 2025 16:11:15 +0200
Message-ID: <20251017141117.105944-10-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017141117.105944-1-shentey@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

As per the previous patch, the own APIC instance is already available in
apic_msr_{read,write}, and can be passed along. In apic_mem_{read,write}, the
own APIC instance is available as the opaque parameter, since it gets registered
when initializing the io_memory attribute. As a result, no
cpu_get_current_apic() is involved any longer.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/intc/apic.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ba0eda3921..fee5201372 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -769,17 +769,11 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static int apic_register_read(int index, uint64_t *value)
+static int apic_register_read(APICCommonState *s, int index, uint64_t *value)
 {
-    APICCommonState *s;
     uint32_t val;
     int ret = 0;
 
-    s = cpu_get_current_apic();
-    if (!s) {
-        return -1;
-    }
-
     switch(index) {
     case 0x02: /* id */
         if (is_x2apic_mode(s)) {
@@ -876,7 +870,7 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     index = (addr >> 4) & 0xff;
-    apic_register_read(index, &val);
+    apic_register_read(opaque, index, &val);
 
     return val;
 }
@@ -891,7 +885,7 @@ int apic_msr_read(APICCommonState *s, int index, uint64_t *val)
         return -1;
     }
 
-    return apic_register_read(index, val);
+    return apic_register_read(s, index, val);
 }
 
 static void apic_send_msi(MSIMessage *msi)
@@ -919,15 +913,8 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static int apic_register_write(int index, uint64_t val)
+static int apic_register_write(APICCommonState *s, int index, uint64_t val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
-    if (!s) {
-        return -1;
-    }
-
     trace_apic_register_write(index, val);
 
     switch(index) {
@@ -1073,7 +1060,7 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    apic_register_write(index, val);
+    apic_register_write(opaque, index, val);
 }
 
 int apic_msr_write(APICCommonState *s, int index, uint64_t val)
@@ -1086,7 +1073,7 @@ int apic_msr_write(APICCommonState *s, int index, uint64_t val)
         return -1;
     }
 
-    return apic_register_write(index, val);
+    return apic_register_write(s, index, val);
 }
 
 static void apic_pre_save(APICCommonState *s)
-- 
2.51.1.dirty


