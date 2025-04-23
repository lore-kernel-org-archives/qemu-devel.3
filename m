Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9F3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcb-00067J-Mb; Wed, 23 Apr 2025 05:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbw-0004qU-P7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbu-0008Mi-Uq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5n9XGcKjTcNvwj+iKBT/bT9ARaFP5wS0AfAoN5tYg8E=;
 b=PgU+OmYx9LV6gnp5cMIJfs6EBBMPubYoMZTjBKIBdoTaWUMN7fN+1ee44vzA7h3S4+3CL1
 AMS4WJ5tS8YvpKvwkGgpvywtB6tHfFasZwRBo90nBHfV2IkPMrAQnff/sl336ll3YHjipO
 iaRsTzpBcIqYPwVRQnaQQR4woM3hAsg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-H_g5wmrJNoSKATLKrpKdGQ-1; Wed, 23 Apr 2025 05:41:40 -0400
X-MC-Unique: H_g5wmrJNoSKATLKrpKdGQ-1
X-Mimecast-MFC-AGG-ID: H_g5wmrJNoSKATLKrpKdGQ_1745401299
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb23361d73so76211466b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401299; x=1746006099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5n9XGcKjTcNvwj+iKBT/bT9ARaFP5wS0AfAoN5tYg8E=;
 b=iFCpv7MbmU7l5n89NDsfAkNwP547LRHobLntYq9kcojTU2okbRhTfPiZ6YwFrLT7s4
 pZbcyE6do4/EfbEiBp022lIr0GtcQKg3w2zOIhZg3yr5vOhtmc26cbpsnAPYNWgjdNDq
 cZ8zkWcw2Nwhy9xXAKhL7BUUduQhEyczydu9fxrDm+RMFr98MV3EtAFjU52yEIeN60GV
 N+NbeeWooI1uw26MoQwahnm58j/Y60Uz+HOUo6iNPvxNNdI4xfphuyX8WMFeGhWZRCFg
 NUoISMPYWxHpAGgduoZhX5Noi6MB1Qbe4058o5S35XhvQjK1/DVYITBGEXt8cXqWfeMf
 5EzQ==
X-Gm-Message-State: AOJu0YziJOmXyGKuFp8dpxykTh765Ciwi+UN6rQNhcG8GFLVw7M3kxRr
 7F2pHX4rg/wLOwnf2QRMa/MeyBlkByMb0CmI1vJDd1CMqqC1YS03yNTRJBBdiE5nYo8gP0Q9JHr
 ii/mYvRa47kUyjUr+TVhv0Ya4t0XIUjllBkGw7MjxwQlpENRgdi5/9GEnwsgX4Su2FPef5woV1L
 t+kMHcNLjwdNKQEVySfbIVyzuNvDEv1gDLwljd
X-Gm-Gg: ASbGncsbVeNc75C5N1ujqpYHDd04asa0xZ2Zp0MVd4G4BE3UPqHOzp/iXHefspGjwLy
 NpMwNBuW10SOV2iT1770CK6BpPdYk3UzHIdjG52wo7ZaykFvXfEy2iaVQGo4+UDsBJJt330PbBh
 QcN1gGbSjYQAYwdSrT/fAuR4aTAsStuB06HryMmDmatAXJERAmG5jWM0ykmGv4IZsNZqbRgLZWG
 3e2Ywh0laYd8WvfGoFl0YbrPEtwhCxUOsHm6rNDx9qtL8HxijGsGR7D/4oZdUj90S0Nj9OPcDWR
 OosG0g9CgStQteRO
X-Received: by 2002:a17:907:6d1c:b0:acb:1165:9a93 with SMTP id
 a640c23a62f3a-ace3f25539fmr197794666b.3.1745401298687; 
 Wed, 23 Apr 2025 02:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLziW5iSa6bbKsemrihb51zXUED/Ob+icHfIsv1CqP0qK6j4urPXmrtnUsLAtmadmnh1zpLQ==
X-Received: by 2002:a17:907:6d1c:b0:acb:1165:9a93 with SMTP id
 a640c23a62f3a-ace3f25539fmr197792566b.3.1745401298218; 
 Wed, 23 Apr 2025 02:41:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6efaa98dsm777011366b.182.2025.04.23.02.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 16/34] target/i386: rename hvf_mmio_buf to emu_mmio_buf
Date: Wed, 23 Apr 2025 11:40:46 +0200
Message-ID: <20250423094105.40692-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

We want to refactor HVF's instruction emulator to a common component. Renaming
hvf_mmio_buf removes the association between HVF and the instruction emulator.

The definition of the field is still guarded by CONFIG_HVF for now, since it is
the only user.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-5-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h         |  2 +-
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86_emu.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7a8d695bdb1..3c5c39ce3d3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2109,7 +2109,7 @@ typedef struct CPUArchState {
 #endif
 #if defined(CONFIG_HVF)
     HVFX86LazyFlags hvf_lflags;
-    void *hvf_mmio_buf;
+    void *emu_mmio_buf;
 #endif
 
     uint64_t mcg_cap;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 7da03f9c081..1cecb765952 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -168,7 +168,7 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    g_free(env->hvf_mmio_buf);
+    g_free(env->emu_mmio_buf);
 }
 
 static void init_tsc_freq(CPUX86State *env)
@@ -262,7 +262,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     if (hvf_state->hvf_caps == NULL) {
         hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
     }
-    env->hvf_mmio_buf = g_new(char, 4096);
+    env->emu_mmio_buf = g_new(char, 4096);
 
     if (x86cpu->vmware_cpuid_freq) {
         init_tsc_freq(env);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 7b01ccde5d3..e59a73e00d5 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -184,8 +184,8 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
-    return env->hvf_mmio_buf;
+    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    return env->emu_mmio_buf;
 }
 
 
@@ -487,9 +487,9 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
+    emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
+    vmx_write_mem(env_cpu(env), addr, env->emu_mmio_buf,
                   decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -510,9 +510,9 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
+    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, addr,
                  decode->operand_size);
-    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
+    emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 1,
                         decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.49.0


