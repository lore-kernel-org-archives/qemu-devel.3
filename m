Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3984EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WcT-0005xV-D7; Wed, 23 Apr 2025 05:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc6-0005AA-0C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc3-0008Ni-EV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMMe6WVZZOx0j5O1p4ruDqdzIdRp+p6Wp14EG06lntk=;
 b=KmUJ9nR+Yy2vEdlExgjcK33iVOHUuLRMALG/VUp0Ls9EJ8MY1IdY0WK9fv7mkTQe6edR3I
 Fr7SwyQ7Y+3d6xlfETgap5/WppdCG8ckq9b2GZMxJ2uRSvf4GDe+xK97ZvuZ/OwWaLRUid
 TL1tdYPHyPx5gXUiFkBa/8Ti7xhpWGs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-a7e7n84EOPao_TTOa4tZNA-1; Wed, 23 Apr 2025 05:41:42 -0400
X-MC-Unique: a7e7n84EOPao_TTOa4tZNA-1
X-Mimecast-MFC-AGG-ID: a7e7n84EOPao_TTOa4tZNA_1745401297
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb98b5b0bdso336926066b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401296; x=1746006096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMMe6WVZZOx0j5O1p4ruDqdzIdRp+p6Wp14EG06lntk=;
 b=OtZnsAWXY5B+q0lwR2Fu+OP4jCLO/q6/NpL6vmnmOwDVdV8NiN7nL1Hlw4Vms2VslM
 QHA6frFWNbAtaTcFliojAJKqBhEumVT8jsQuGMq3EBlwW09CzvwwWG7GYn0Nc+PPS9ND
 ByWstFT5Q5muHwHZSFxb8x3vokkIFhtdnAxp2MY/xmi4H/deQkHLanBzITl5Uy7JOTxN
 NAoTyZY2ueMhUrDdcfE/9k1J0S47lzgpqFZZgAjoIrTt9X+rAkIoHScYypmwOOVFsj4U
 oXUFOVLCGr2Lzz7FJn7ZLr0EHPBL+nB8LMNW2i01pSU9CpAaRHAeold7s04tDbk4G0xP
 tKyA==
X-Gm-Message-State: AOJu0Yx13kPMaAICC3F3UcNKbr/a4qT6xeMcK39/pO2J9VGAttNE1hXr
 sYUYZNQHKx0ID/6eLmz+c2qTSMNdFYynU2r+c3IB2z7YGR5ULZ9hYBkEbGph6kzShL3rkZTKTkx
 aoHTKSA5M32ddWmrIAl3jkOKWcdXKxUYBnjotaI5jAvwxj6jPgQsDY4cex7kWHb0PZAS1OTMm3M
 5Ihmkmf9W7iVQbg1PkfjTOTpOHYbrcWUjNtPE6
X-Gm-Gg: ASbGncuG0Mwlg7qn7RyPWzmVX02BhNQxoBmFtPY3t1FvlD3TpPaVTtffqHohj1+i7uQ
 tiIC7KepGlK2R2ohmxIwgYSQe8oSJ+JdDze2O+raB4GvjkD06haT4EONCmLZE+ZSmxApCcjKXy5
 GjDJhRvJ2LysbVtJvRKp0mXxvMtEWZIvPEnvTe2O/eXYgl8YJ5sOH8aOTok0DxaRF4K40LfOcDq
 tc+W5e/zGRP2MfSBaNkm8O1G7FjokX55GXQpElkNSxsLfBlxB+xb6ZsmJ4AcgkzzquIeVGe7PuE
 9pM4hdXi2EdIoAZ9
X-Received: by 2002:a17:907:3d8a:b0:ac7:150e:8013 with SMTP id
 a640c23a62f3a-acb74b1ce20mr1910043766b.15.1745401296483; 
 Wed, 23 Apr 2025 02:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKuWRBVTMISRoJUkLg4oC99uo909hFqJXKh8U1tS0ITD4Hd0aXbdS0YBFTWA3f+Duj6s4EVQ==
X-Received: by 2002:a17:907:3d8a:b0:ac7:150e:8013 with SMTP id
 a640c23a62f3a-acb74b1ce20mr1910042266b.15.1745401296084; 
 Wed, 23 Apr 2025 02:41:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6eefcefasm785167566b.95.2025.04.23.02.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 15/34] target/i386/hvf: provide and use handle_io in emul_ops
Date: Wed, 23 Apr 2025 11:40:45 +0200
Message-ID: <20250423094105.40692-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This drops the calls to hvf_handle_io from x86_emu.c.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-4-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.h |  2 ++
 target/i386/hvf/hvf.c     |  1 +
 target/i386/hvf/x86_emu.c | 29 +++++++++++++++--------------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 1422d06ea18..40cc786694e 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -27,6 +27,8 @@ struct x86_emul_ops {
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
+    void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
+                      int size, int count);
 };
 
 extern const struct x86_emul_ops *emul_ops;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 03456ffbc70..7da03f9c081 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -245,6 +245,7 @@ static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 static const struct x86_emul_ops hvf_x86_emul_ops = {
     .read_mem = hvf_read_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
+    .handle_io = hvf_handle_io,
 };
 
 int hvf_arch_init_vcpu(CPUState *cpu)
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index c15b5a7ca85..7b01ccde5d3 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -396,18 +396,18 @@ static void exec_out(CPUX86State *env, struct x86_decode *decode)
 {
     switch (decode->opcode[0]) {
     case 0xe6:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &AL(env), 1, 1, 1);
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &AL(env), 1, 1, 1);
         break;
     case 0xe7:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &RAX(env), 1,
-                      decode->operand_size, 1);
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &RAX(env), 1,
+                            decode->operand_size, 1);
         break;
     case 0xee:
-        hvf_handle_io(env_cpu(env), DX(env), &AL(env), 1, 1, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &AL(env), 1, 1, 1);
         break;
     case 0xef:
-        hvf_handle_io(env_cpu(env), DX(env), &RAX(env), 1,
-                      decode->operand_size, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &RAX(env), 1,
+                            decode->operand_size, 1);
         break;
     default:
         VM_PANIC("Bad out opcode\n");
@@ -421,10 +421,10 @@ static void exec_in(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
     switch (decode->opcode[0]) {
     case 0xe4:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &AL(env), 0, 1, 1);
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &AL(env), 0, 1, 1);
         break;
     case 0xe5:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &val, 0,
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &val, 0,
                       decode->operand_size, 1);
         if (decode->operand_size == 2) {
             AX(env) = val;
@@ -433,10 +433,11 @@ static void exec_in(CPUX86State *env, struct x86_decode *decode)
         }
         break;
     case 0xec:
-        hvf_handle_io(env_cpu(env), DX(env), &AL(env), 0, 1, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &AL(env), 0, 1, 1);
         break;
     case 0xed:
-        hvf_handle_io(env_cpu(env), DX(env), &val, 0, decode->operand_size, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &val, 0,
+                            decode->operand_size, 1);
         if (decode->operand_size == 2) {
             AX(env) = val;
         } else {
@@ -486,8 +487,8 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
-                  decode->operand_size, 1);
+    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
+                        decode->operand_size, 1);
     vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
                   decode->operand_size);
 
@@ -511,8 +512,8 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 
     vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
                  decode->operand_size);
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
-                  decode->operand_size, 1);
+    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
+                        decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
 }
-- 
2.49.0


