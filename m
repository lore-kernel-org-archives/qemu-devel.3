Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F594C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5v-0003iJ-BF; Thu, 19 Jun 2025 09:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5k-0003fB-Hq
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5e-0003vY-LG
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so5830605e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338840; x=1750943640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHGHBjHnm08XY2FWC1TeHuwJJyw8Eo3SwtB3aTyB57o=;
 b=D7haTk6W1wzVr76xrdfjuJP9FVlduEb0cjJYSlkGMbsM59S1DsXIW9BT/cbab35JgZ
 r4C1RwNDzO9SFr4Sn+Sjguh5CBCNIpxH1AJJXHNH2WkvPYjRIfHYy+S5hiB9zO3FaTWu
 NxyLjWlsAj1flYOVsCQstGluWTa9CUoPavrGbE3X9LUfkTABvWVvWbwGZgkyJq1PPJEM
 W7gHiYip01GyuNBd6SWI4o5VfQEUssZyy9ZGEbRphpLEI5svNZjSnO9onhfoPCGIiMas
 VcCNgehwRz63VHQzF5H5kvPuPMKeg2VN4TRsppud4L4ZhBN6s8iek48NoFUEpb9EShAc
 evCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338840; x=1750943640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHGHBjHnm08XY2FWC1TeHuwJJyw8Eo3SwtB3aTyB57o=;
 b=dUAGmdLy6T8RJE1F7RyVZUpmDIMxEENtNPOYs0ZCH+Z23PIRqe4mjKq1SY8v4Araqf
 hliCEyAz5Be4JlSUeTGBV24OK8P5yBNxo+EBus9+e+b9ePsOziPbgE+m8WiLuIjQnnDq
 EsQTwMrGHAz9K3SvDUx8iiMxL6jkQ5PW6yRCbovl9Mn7ycYJ6gShzUXxyI7+jNjAyeNL
 94nmISt4G+lOeAIykM+UZd3UHUQeCCeFbLg4OzcYcgzte1zaGfPfL14xxSmEy5D0wf1o
 zafpbW9OADOoSeXZtfqh4iaCJ999zYnafkfVrXx+7ZEZrqs1ZmP3BK7iX7Nov1OTIgkC
 7s8Q==
X-Gm-Message-State: AOJu0YxvAcudtmIk81FpkmBej7nHJZdc0O9FX5JZ7duxEHMX9pFrFJ9T
 81YIbhpl8ZJQ9MEYOX2RApM2mHyTlhnXY1jA7KN95mYKLPCgWjHi2OaUMXnweUXd47D7g4wqlCx
 9FxnEqkw=
X-Gm-Gg: ASbGnctBc9ThOhFlew4A0sFMhnz9sfUIyQDXGvXS1BPG/5ki89IkSGRDeLDlI4A/xVV
 v/SHUe4SvAQo9Png0dFaENszS76/zKiBIR2jOZs3+CGmPFJSl+QTaxf6/xTkl49GZ+CpTZjp2iM
 nw81Oe8Z3pNKls1sbeDbamo7JQSriDOxKMBP3J/AN3rg0k1WTdZVN87kDOeYLShVUPLTZPPldne
 +An1pMf1SlY+2i6KRzPacdnRjHaKz1APig7DJEUc3OKki9I6CSpTmo+EXUTno6hhB4SxGMauIFH
 B/WaSZF4q9aR5U3NDnhBSNpYWuGZSem48qIUbmXWfIsytPu0oZvPES1A1xejn0fMGWdhNGGx/1d
 rn1SN9VWIa6j+eZnQ/D37hy4Vow1rai7ijmJm
X-Google-Smtp-Source: AGHT+IH0dt4iGJr6FYYNqBSMaXpFrU7CwfQvkc2Mt1yc9XX3BrxWP2rVzSQNRIHBHoy4vELO8HZkLA==
X-Received: by 2002:a5d:5849:0:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a5723aeb2cmr17281843f8f.39.1750338840330; 
 Thu, 19 Jun 2025 06:14:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a547ecsm19782672f8f.17.2025.06.19.06.13.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 07/20] accel/hvf: Trace VM memory mapping
Date: Thu, 19 Jun 2025 15:13:06 +0200
Message-ID: <20250619131319.47301-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Trace memory mapped / unmapped in the guest.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build               | 1 +
 accel/hvf/trace.h         | 2 ++
 accel/hvf/hvf-accel-ops.c | 6 ++++++
 accel/hvf/trace-events    | 7 +++++++
 4 files changed, 16 insertions(+)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 accel/hvf/trace-events

diff --git a/meson.build b/meson.build
index 34729c2a3dd..5004678a26b 100644
--- a/meson.build
+++ b/meson.build
@@ -3633,6 +3633,7 @@ if have_block
 endif
 if have_system
   trace_events_subdirs += [
+    'accel/hvf',
     'accel/kvm',
     'audio',
     'backends',
diff --git a/accel/hvf/trace.h b/accel/hvf/trace.h
new file mode 100644
index 00000000000..83a1883343a
--- /dev/null
+++ b/accel/hvf/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-accel_hvf.h"
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d60446b85b8..b38977207d2 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -59,6 +59,7 @@
 #include "system/hvf_int.h"
 #include "system/runstate.h"
 #include "qemu/guest-random.h"
+#include "trace.h"
 
 HVFState *hvf_state;
 
@@ -97,6 +98,7 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
     if (macslot->present) {
         if (macslot->size != slot->size) {
             macslot->present = 0;
+            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
             ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
             assert_hvf_ok(ret);
         }
@@ -109,6 +111,10 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
     macslot->present = 1;
     macslot->gpa_start = slot->start;
     macslot->size = slot->size;
+    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'E' : '-');
     ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
     assert_hvf_ok(ret);
     return 0;
diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
new file mode 100644
index 00000000000..3c11f69f305
--- /dev/null
+++ b/accel/hvf/trace-events
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See docs/devel/tracing.rst for syntax documentation.
+
+# hvf-accel-ops.c
+hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016llx size:0x%08llx vaddr:%p flags:0x%02x/%c%c%c"
+hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016llx size:0x%08llx"
-- 
2.49.0


