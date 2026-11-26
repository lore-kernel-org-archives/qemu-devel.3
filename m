Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24826606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZrJXj7Xi;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M2MBgfuC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWii1-0008FW-DT; Thu, 26 Nov 2026 18:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihw-0008Ap-6b
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihu-00063y-53
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pb8QZnFZ6i9u1K+5wyRDecRf7PdJuD3xkUw7sIQNU1A=;
 b=ZrJXj7XiZV9BOT1PiNCfksmANiYJAudz1FvCV3Iy33OP3ILcon0lnczA14lMlk9nDf/+HG
 S0K/JuTPiqqiIK/0i+rARHtMIsBRciQAVTzycF7Ty9DCMaIoUpawMxN+Kz9RtJtkaYm1pf
 QdVKo1ZOg/ne/T61jf4O16v2+3vN/Ts=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-XN8QBFQNPM-ZdZ4rTjEm7Q-1; Thu, 26 Nov 2026 23:16:47 +0000
X-MC-Unique: XN8QBFQNPM-ZdZ4rTjEm7Q-1
X-Mimecast-MFC-AGG-ID: XN8QBFQNPM-ZdZ4rTjEm7Q_1795735007
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495af07676so1123224485a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795735007; x=1796339807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pb8QZnFZ6i9u1K+5wyRDecRf7PdJuD3xkUw7sIQNU1A=;
 b=M2MBgfuCEKuGhMoqjL0IwwekMu9NSXsSFFTIhQnfzKvNV107ulQj7zq5fC7m4Yk1HD
 3F8TWkgYmyh4kJrhI81ZcG0dwO9MnRxoMa7+XL0b/Tqj6vOZ1bvymRxnsSfbd8btLd7p
 gXGPeCKuTfyyJR1ZcwNesoFeU2RYrs7nvqPEfj6hA+e4lplxa3gJZUOtgsKd3P07dv4D
 u5JUvGcTSYV5NAJ0+yd6/CzvFWBn8pVRklWwzhAM4prPZtEJPe6X7llzS4VoBMC1wRzA
 /V90QsPartReKmdkUpCh1gKSNexTO0zN6rIuIOiEHwrZh4G4enfgG+prig+PXHyq+i/w
 69fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735007; x=1796339807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pb8QZnFZ6i9u1K+5wyRDecRf7PdJuD3xkUw7sIQNU1A=;
 b=B/pnQhKRSzPOy04q9EEDY5iid5DFoT4CMPQ/OdnPfEV6pgObIID5Sl3n/nWjDIZmnU
 l/fyBpVDh+FevFicuxY6nN/Vo4jlvyHDXvZKwAAYwaNT38MBQvrxbuuXJPk2JQ33/tmy
 S9kQxQXpfsU+33/NiMXR6NYAK9oviG4fAbDRZt/o2TM/rZ6hh3dI77WOPtfTDBLAHeHz
 8QLh55jwl/rvIYSGks1fW/Y/tXXDnjeomSiOrf8usZLn2p/ldBzOJFNLV+liIG3dZRJA
 VEW5Zv+cy99qHqRORJFWpOSngkArMAkqy0WvLBSgi0FdRkqpDK/+CAoFDheNNFWOWW9N
 nsqQ==
X-Gm-Message-State: APuU4Z/kLoeqfjsq3mCh/2GscgmzBhrYrHcwmnxnh4b4ZEQkMY9YajG+
 VkRNywMg+tziOF2UUVb8sKL+OOGr3moR0cw4RO5XQpaIHAPhr5mc5Fzaso8ISUILQg7+JENfKyv
 yO8UzVIdROIpN3ZwRJgm8OBbV9Fj0/h/LHoMiKdQ+2R8+L54cU2GRETW4XRytyQF5dHjX2fjnGL
 x5SkHCaqjkuhr/o2/KxNXONogSzfr58jOl1xvyrw==
X-Gm-Gg: AZFdTZfskCBvMgHBwlMBbS29fGLKCxcOTCoZrEzX/FDZZAJV+DAH5T0n/FRa7NArV7X
 c9D1fLovYUHeMGKkPdg+rL1BtN26J/sulwHN+nLwktDl0ES15+ofmUFrVMTO35gvAICU3PsXMPu
 s4ew1aIx9D96qXUuGxPfaDHpKgGBlBg3cFuSXXa8LxazzxaFNvbRMajO6VwU40ucGVwMESB1Bki
 4PLc+dtYrbLf/dCvzpJbFzisRJLyMXMwOrsBNb6tmYq7AHV5sGi0CwvHUUfFLXIurmjcvSr3gMz
 lqSzz6X/PCaLOoCbNKE9Tjz9tPXQLevQ2uKhUmccfEHjb4m2vsdq7XiZ/3HcRwcFgKjTUWvVAV5
 MkYed9kfJ4krUldFrolstz2yXF8hCcHActsJWiE5QYpLu
X-Received: by 2002:a05:620a:4404:b0:93f:19fe:e6ca with SMTP id
 af79cd13be357-949ba9aedf8mr4129887985a.43.1795735006661; 
 Thu, 26 Nov 2026 15:16:46 -0800 (PST)
X-Received: by 2002:a05:620a:4404:b0:93f:19fe:e6ca with SMTP id
 af79cd13be357-949ba9aedf8mr4129882285a.43.1795735006087; 
 Thu, 26 Nov 2026 15:16:46 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb031601sm1678969385a.6.2026.11.26.15.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:45 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>
Subject: [PATCH for-12.0 v2 7/9] arm/machine: Convert cpu_post_load() to take
 Error**
Date: Thu, 26 Nov 2026 18:16:29 -0500
Message-ID: <20261126231631.3392756-8-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert it to post_load_errp() version, so as to be able to report verbose
errors when hit.

A few things to mention:

- The old "fail" count won't work with Error**, switch to fail and return
  immediately, assuming we should stop migration immediately hitting the
  1st error.

- Alone the way, handle_cpreg_only_in_incoming_stream() return value is
  flipped to make it match QEMU's normal coding style (return true for
  success, false for error, not vice versa).

- Provide simple error strings for the cases where the lower function
  doesn't yet take an Error**.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/arm/machine.c | 52 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 02a2b78506..e86fa85a9b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -11,6 +11,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
+#include "qapi/error.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -1151,10 +1152,11 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
  * Handle the situation where @kvmidx is in the incoming
  * stream but not on destination. This fails the migration if
  * no cpreg mig tolerance is matched for this @kvmidx
- * Return true if the migration should eventually fail
+ * Return true if success, false otherwise.
  */
 static bool
-handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t value)
+handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t value,
+                                     Error **errp)
 {
     g_autofree gchar *name = print_register_name(kvmidx);
 
@@ -1163,18 +1165,17 @@ handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t valu
         arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
                                           value, 0, ToleranceOnlySrcTestValue)) {
         trace_tolerate_cpreg_only_in_incoming_stream(name);
-        return false;
+        return true;
     }
-    error_report("%s: %s in the incoming stream but unknown on the "
-                 "destination: fail migration", __func__, name);
-    return true;
+    error_setg(errp, "cpreg %s in the incoming stream but unknown on the "
+               "destination", name);
+    return false;
 }
 
-static int cpu_post_load(void *opaque, int version_id)
+static bool cpu_post_load(void *opaque, int version_id, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
-    bool fail = false;
     bool ignore_s_regs;
     int i, v;
 
@@ -1229,9 +1230,11 @@ static int cpu_post_load(void *opaque, int version_id)
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            fail = handle_cpreg_only_in_incoming_stream(cpu,
-                                                        cpu->cpreg_vmstate_indexes[v],
-                                                        cpu->cpreg_vmstate_values[v]);
+            if (!handle_cpreg_only_in_incoming_stream(
+                    cpu, cpu->cpreg_vmstate_indexes[v],
+                    cpu->cpreg_vmstate_values[v], errp)) {
+                return false;
+            }
             v++;
             continue;
         }
@@ -1278,21 +1281,22 @@ static int cpu_post_load(void *opaque, int version_id)
      * still regs in the input stream, continue parsing the vmstate array
      */
     for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
-        fail = handle_cpreg_only_in_incoming_stream(cpu,
-                                                    cpu->cpreg_vmstate_indexes[v],
-                                                    cpu->cpreg_vmstate_values[v]);
-    }
-    if (fail) {
-        return -1;
+        if (!handle_cpreg_only_in_incoming_stream(
+                cpu, cpu->cpreg_vmstate_indexes[v],
+                cpu->cpreg_vmstate_values[v], errp)) {
+            return false;
+        }
     }
 
     if (kvm_enabled()) {
         if (!kvm_arm_cpu_post_load(cpu)) {
-            return -1;
+            error_setg(errp, "kvm_arm_cpu_post_load() failed");
+            return false;
         }
     } else {
         if (!write_list_to_cpustate(cpu)) {
-            return -1;
+            error_setg(errp, "write_list_to_cpustate() failed");
+            return false;
         }
     }
 
@@ -1307,7 +1311,8 @@ static int cpu_post_load(void *opaque, int version_id)
      * thumb_tr_translate_insn().
      */
     if (!is_a64(env) && env->thumb && (env->regs[15] & 1)) {
-        return -1;
+        error_setg(errp, "Misaligned thumb pc");
+        return false;
     }
 
     if (tcg_enabled()) {
@@ -1325,7 +1330,8 @@ static int cpu_post_load(void *opaque, int version_id)
                       FPCR_LTPSIZE_SHIFT, FPCR_LTPSIZE_LENGTH) != 4 ||
             extract32(env->v7m.fpdscr[M_REG_S],
                       FPCR_LTPSIZE_SHIFT, FPCR_LTPSIZE_LENGTH) != 4) {
-            return -1;
+            error_setg(errp, "Bogus fpdscr[] values");
+            return false;
         }
     }
 
@@ -1337,7 +1343,7 @@ static int cpu_post_load(void *opaque, int version_id)
         arm_rebuild_hflags(env);
     }
 
-    return 0;
+    return true;
 }
 
 const VMStateDescription vmstate_arm_cpu = {
@@ -1347,7 +1353,7 @@ const VMStateDescription vmstate_arm_cpu = {
     .pre_save = cpu_pre_save,
     .post_save = cpu_post_save,
     .pre_load = cpu_pre_load,
-    .post_load = cpu_post_load,
+    .post_load_errp = cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
         VMSTATE_UINT64_ARRAY(env.xregs, ARMCPU, 32),
-- 
2.56.0


