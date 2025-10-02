Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32B9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvn-0001BF-Kh; Thu, 02 Oct 2025 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvK-0000wd-Am
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mv2-0005oz-6v
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4e5WisuIRnKwgKzQaGFn0q2ckBCBWWEQciLxXlj8bI=;
 b=hn4tkh9CI5gaspMBz7x80c70lEHlxXRlIaJB/a64OQ0x59Y92kEm8XFuCie7wkdDsySjyt
 dA1UxqMuJmy3A6zNZKcNNgtizxQfXQnu+R09s9Ema6su1ZC/7bW/GrBUPoqLqAKKk7CDTq
 7lHdOqZ0/5v+H/S8yYQyu+vtsD/G6ng=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Ldf2xFf-MHazcl8SuO2jrw-1; Thu, 02 Oct 2025 13:16:32 -0400
X-MC-Unique: Ldf2xFf-MHazcl8SuO2jrw-1
X-Mimecast-MFC-AGG-ID: Ldf2xFf-MHazcl8SuO2jrw_1759425391
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6378fa71087so1166805a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425390; x=1760030190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4e5WisuIRnKwgKzQaGFn0q2ckBCBWWEQciLxXlj8bI=;
 b=E6e2mN6LLZgXt1jrYWsGSfhzD3Zg1e9RgE/0fLSbp61dlanClxneZLHO4A7gbKN7GN
 gk17/mbKAUM0jd775ZxAdZblXFfCn+ln0FdZU1GOW2gHM3cRFR8R0NIToKxMLLh7F/PM
 dOgQDZYheM6ily/iOsRm7thvXf3evRG7P5+e504NMVH+vx7qzD7ptFU/MX/IKUInUrUH
 0gi464ketFbxVA7o1pIXLabk6X0E92f47jt4/MxxSAmW+72Jxe7doFXQIWdlCLf8LSF2
 mfdtq2w7uUnrqrrcpRtzQHEgkdYdYilfOtCa7LAFX/hw25KNU9zrgKr8RWdl6hFn/IY4
 PVXw==
X-Gm-Message-State: AOJu0YyF23FNOs8Le+0con6uvExWJta+IZ3UTwY1i+iwQohNfypAr6lK
 YVZjPsUHKI7++g1LWUg4Y1wakdXuR3QmtwfKlvJO+n0t4WG+mAqnOPLiadKrERa3ox4mBtAFSk4
 MK3P3MJG455pqUddjBKqJEkLdAVOaRvO3uybhN4xJwX3mtmTmAAbPSMXCewS31FfaiNBAQe2jNW
 +KC+RvRwPISmFMr2DLQRj1ld20K2n5Jh/NruOFUROn
X-Gm-Gg: ASbGncu4sRaYtIurqpq01ne0UG/ClDfI3C31lEnaPoD32KwGMPTsdHSvbrwZ4j8y52n
 1FOjanes6rIblTJTMCjpTLDszPlD9LjnC8bir6RNoy85Qn+eE/lwTynRvGqjSVu5yp1SufhMPMC
 CX7RAl6dq63Ce30HneK/hEtvF8uLaQQ9hmg1AcT36hdWBA0jbaMfKP6XVxS4qh34xrNqOBwniWs
 pe9FsOXT5m3pxCxr+SDnhwTWVLKYcqj7GkiWpgeTadjamck0nzzHo5h1lGWUtqbQD4HbfqvcqYt
 EAMm/5Ciy4zeTglGZJlrfWD9+AJm9fj9ZTmiGP3wCZG2xsRj9GfhYTdRFqU7S/mKOXj+MK44Zm9
 VKfCdjVAr+PPOlNFiht3h1wn4tLdYBcrDkmKcFc+SRXAU8/G0
X-Received: by 2002:a05:6402:848:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-63678c78713mr8560382a12.25.1759425390085; 
 Thu, 02 Oct 2025 10:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBZm9hQfVBmYu/xMrSrqwdjylqVLWtbXY+QPROT+2L+665Lpu2zd0zmCQ/vprjd4FhepIZAg==
X-Received: by 2002:a05:6402:848:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-63678c78713mr8560337a12.25.1759425389512; 
 Thu, 02 Oct 2025 10:16:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-637880ffdf7sm2220587a12.28.2025.10.02.10.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 17/27] target/i386/mshv: Set local interrupt controller state
Date: Thu,  2 Oct 2025 19:15:26 +0200
Message-ID: <20251002171536.1460049-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

To set the local interrupt controller state, perform hv calls retrieving
partition state from the hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-18-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 117 ++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 8b10c79e547..0fe3cbb48d8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/memalign.h"
 #include "qemu/typedefs.h"
 
 #include "system/mshv.h"
@@ -21,6 +22,7 @@
 #include "hw/hyperv/hvgdk.h"
 #include "hw/hyperv/hvgdk_mini.h"
 #include "hw/hyperv/hvhdk_mini.h"
+#include "hw/i386/apic_internal.h"
 
 #include "cpu.h"
 #include "emulate/x86_decode.h"
@@ -562,6 +564,114 @@ static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
     return 0;
 }
 
+static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to get partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int get_lapic(int cpu_fd,
+                     struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = get_vp_state(cpu_fd, &mshv_state);
+    if (ret == 0) {
+        memcpy(state, buffer, sizeof(*state));
+    }
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to get lapic");
+        return -1;
+    }
+
+    return 0;
+}
+
+static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
+{
+    return ((reg) & ~0x700) | ((mode) << 8);
+}
+
+static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to set partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lapic(int cpu_fd,
+                     const struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    if (!state) {
+        error_report("lapic state is NULL");
+        return -1;
+    }
+    memcpy(buffer, state, sizeof(*state));
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = set_vp_state(cpu_fd, &mshv_state);
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to set lapic: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lint(int cpu_fd)
+{
+    int ret;
+    uint32_t *lvt_lint0, *lvt_lint1;
+
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+    ret = get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return ret;
+    }
+
+    lvt_lint0 = &lapic_state.apic_lvt_lint0;
+    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
+
+    lvt_lint1 = &lapic_state.apic_lvt_lint1;
+    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
+
+    /* TODO: should we skip setting lapic if the values are the same? */
+
+    return set_lapic(cpu_fd, &lapic_state);
+}
+
 /*
  * TODO: populate topology info:
  *
@@ -573,6 +683,7 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
                         uint64_t xcr0)
 {
     int ret;
+    int cpu_fd = mshv_vcpufd(cpu);
 
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
@@ -580,6 +691,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
+    ret = set_lint(cpu_fd);
+    if (ret < 0) {
+        error_report("failed to set lpic int");
+        return -1;
+    }
+
     return 0;
 }
 
-- 
2.51.0


