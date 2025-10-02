Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D9CCD182
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mul-0000aU-E7; Thu, 02 Oct 2025 13:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuX-0000ZU-50
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuJ-0005c6-T3
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8HYpUdO2P7nAh/MHMViByHQJ/N9zXJCXtwAC6CreTc=;
 b=G8I5A8vwgEvxC9lxmhhVhQFcdPOnHJ9tXEANy5FWIGnxtqAezBl4M0V+KOXh3RBTxUYu/6
 EExJtE6p8A6lNX3au6Vr1IXI5ivULHmWA7XUZ+Ow02KlMWmuxxi1sDzpfWrgqBGFcPB+wh
 +HukPz2FF9OF97r/YbmmYG5CfugpJYs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-dKWtRAvQPPqqef5tXYy_ZA-1; Thu, 02 Oct 2025 13:15:45 -0400
X-MC-Unique: dKWtRAvQPPqqef5tXYy_ZA-1
X-Mimecast-MFC-AGG-ID: dKWtRAvQPPqqef5tXYy_ZA_1759425345
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3d83a7b6d7so109700966b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425344; x=1760030144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8HYpUdO2P7nAh/MHMViByHQJ/N9zXJCXtwAC6CreTc=;
 b=Ms5m1MJbdtPVVxszT2jyK0Dp/nwX1uUSva8O6QzUUedzlwJ9Pu5ZnUXNKwXNGEei8n
 rPPPlso8GTmZRyFNWRy0sQfdGBiF/jREuKWd9MmlTiOXpHUqm80wO6U59FrZbDUJ97WP
 pqhBogSAIhqjMFz14cTft2CfA0qP8yB4BUqUxUvKCWWxNxkAA/ioEVpFf0OP3s/aaXWf
 oxikNZ4szYAuKUR+cZ5Js6aqvPKyljYc5GRq477D6mYkSO/tZlX6PrsfMlkX80QeDjdo
 2y3Y5P8KOVNg4ewHnGghpMmRyipxiCKZUedl+e8MFQTQYXEyF1+COQs8Bs7QiR7Z/3Bn
 y+nA==
X-Gm-Message-State: AOJu0Yy1Ex41tW1yitD3mv159nBdDILohgzB1OEHSSf6eyQQsO1KxIc4
 bm0umc9cTHxKy0YNK76hd8+7m9egQR9M338l9VtRrAv3OiIuWHb4S6/5HHvNRPdQWI5xLOFEOPq
 sQY0CeYWltcgFB03jKU4KAIsnliG4D3JwqoVi61+evnPmTTtNNmCeRgfvoOHSJgsPLzr1dN/XKs
 xiTFTn63VV903hZ4V3yPpBFiVM2Q1F82EcccBvbrrM
X-Gm-Gg: ASbGncvFPk7CJv06WzzOOwXTmQKx6MhOz/64OwUcXeXeo5h2N2DJfG8nExXgEXFNrOt
 GiUi9IAaRNXsDS3UgEz1y3Ife1uuwvNFhfVyzjtwUqBU2vGO117pwpfL854nc+EIEV4bEksdKHO
 qUR3A/lWFssq8j1m57PqjmyU6gyoEBdsk3WFLUKVrqITsQx3CHtGURpgNp0M1j5ronLa7lMnPUY
 rKyCkQHGiekNLK8qy35COf0cXokQixwS/GKydGfasfENrKiHomb8NOKE3IDaBi15XT7moI3EZGZ
 GdWQCfPqbHJnqqPGjAPJPTfRSSjWdkn0a8VH2tz3YpLC8eLYY0IjKf28ckb+tm8IyiqbxM2pywD
 kcjjUevndOs2U3ogdOCgkdykRwiL4R9id1zxdAazw2rfj1GCa
X-Received: by 2002:a17:907:6090:b0:b3d:7e5c:8578 with SMTP id
 a640c23a62f3a-b49c1280aafmr29642066b.12.1759425343795; 
 Thu, 02 Oct 2025 10:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpNqiLWvpltRU6Kkb2nvimoBwTsBAk5WPz6vC2VaL5ahMnY8N+XH705Gza1m7thG5s/LjpaA==
X-Received: by 2002:a17:907:6090:b0:b3d:7e5c:8578 with SMTP id
 a640c23a62f3a-b49c1280aafmr29637366b.12.1759425343209; 
 Thu, 02 Oct 2025 10:15:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4869b56954sm243435766b.75.2025.10.02.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 02/27] target/i386/emulate: Allow instruction decoding from
 stream
Date: Thu,  2 Oct 2025 19:15:11 +0200
Message-ID: <20251002171536.1460049-3-pbonzini@redhat.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a new helper function to decode x86 instructions from a
raw instruction byte stream. MSHV delivers an instruction stream in a
buffer of the vm_exit message. It can be used to speed up MMIO
emulation, since instructions do not have to be fetched and translated.

Added "fetch_instruction()" op to x86_emul_ops() to improve
traceability.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-3-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.h |  9 +++++++++
 target/i386/emulate/x86_emu.h    |  2 ++
 target/i386/emulate/x86_decode.c | 27 +++++++++++++++++++++++----
 target/i386/emulate/x86_emu.c    |  3 ++-
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
index 927645af1a3..1cadf3694f0 100644
--- a/target/i386/emulate/x86_decode.h
+++ b/target/i386/emulate/x86_decode.h
@@ -272,6 +272,11 @@ typedef struct x86_decode_op {
     };
 } x86_decode_op;
 
+typedef struct x86_insn_stream {
+    const uint8_t *bytes;
+    size_t len;
+} x86_insn_stream;
+
 typedef struct x86_decode {
     int len;
     uint8_t opcode[4];
@@ -298,11 +303,15 @@ typedef struct x86_decode {
     struct x86_modrm modrm;
     struct x86_decode_op op[4];
     bool is_fpu;
+
+    x86_insn_stream *stream;
 } x86_decode;
 
 uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
+uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_insn_stream *stream);
 
 void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
                   int is_extended, int size);
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a1a961284b2..05686b162f6 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -24,6 +24,8 @@
 #include "cpu.h"
 
 struct x86_emul_ops {
+    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
+                              int bytes);
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 2eca39802e3..97bd6f1a3be 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -71,10 +71,16 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
-    emul_ops->read_mem(env_cpu(env), &val, va, size);
+
+    /* copy the bytes from the instruction stream, if available */
+    if (decode->stream && decode->len + size <= decode->stream->len) {
+        memcpy(&val, decode->stream->bytes + decode->len, size);
+    } else {
+        target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
+        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+    }
     decode->len += size;
-    
+
     return val;
 }
 
@@ -2076,9 +2082,10 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
-uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 {
     memset(decode, 0, sizeof(*decode));
+
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
@@ -2088,6 +2095,18 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
     return decode->len;
 }
 
+uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+{
+    return decode_opcode(env, decode);
+}
+
+uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_insn_stream *stream)
+{
+    decode->stream = stream;
+    return decode_opcode(env, decode);
+}
+
 void init_decoder(void)
 {
     int i;
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index db7a7f7437d..4409f7bc134 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1246,7 +1246,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n", env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
+                env->eip,
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.51.0


