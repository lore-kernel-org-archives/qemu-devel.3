Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE37C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekn-0007M6-Ii; Thu, 27 Feb 2025 09:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekb-0007Ek-KW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekZ-0003mE-Ca
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFjFdlkLFZq0ZT7FD3u03N89XHgvBXcDvp8KHJtTu6Q=;
 b=KV5U8NX2gKptn29fFi1sZnVxj88QogbfinaA9jntd2CsqolDQGDdxkz9hLUatTyE9Sn4wj
 qYmh5xBTm8UrPa3cL8vDuOMYBgsZhuSTSrB62TywCQIdMMM1fUKF7pwzKmWVd365LF95RL
 LL6BNKYQdLj6Jwe2+LfzoeP2hducngI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Rq_O9rL0O0yPkBKiYCtx4w-1; Thu, 27 Feb 2025 09:20:29 -0500
X-MC-Unique: Rq_O9rL0O0yPkBKiYCtx4w-1
X-Mimecast-MFC-AGG-ID: Rq_O9rL0O0yPkBKiYCtx4w_1740666028
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb9d1c8113so105451666b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666026; x=1741270826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFjFdlkLFZq0ZT7FD3u03N89XHgvBXcDvp8KHJtTu6Q=;
 b=wPA0ojgrBrk1Uz6x5pzKbhLLPRv5rC8SsdDNoJCRwz9ABjxufvuU57q3h16WirZzHB
 Rqsb3wm4t/99i44G5kfdItaq+ysRxvO8tiIfgC4rkfRB/hll85eLsErc/E1VtvB3m8n7
 Mk/kMI1xuEtwzrY4vhhmrftSI8fwcXFat85gzSSJeMYIVfQhBNet5XcLrV1omxrf1oIV
 hLmz6h2xAXLh7JsfhFXFGbd4iHLKbGtnc4jEPm3yrYQtJs0WeLTClRiBPuoBWFMiJ7pB
 QgewPi8VTBNUOy7lpOktoTZPt/NXiVcqnA64YHp1kFtGdjsI3Qz6GQrbNmsX8Zaj/Rk4
 e/BA==
X-Gm-Message-State: AOJu0Ywk/xaLuwsCno6hY8JsWlRegBmaIjqkT7dYLTpxCijZzolnaJ9t
 LX9Ce7ldym4tdpPBVNXiYIyErkQhRybPBhuj6B7nllFh9J+MaoKyER/qOAjog6oFGTPdPdnOTf1
 MH5xm67RKVVAcfcfv98xOiY/1jm9D4UoO/T0b9Ac3UghoEv8ZsU34+sp/MKzwtDGx6diJLeI5l8
 6XoHTbCR8mMSaq34SsmHdKOjrGQJyGS5BrWZW5AiU=
X-Gm-Gg: ASbGncu1H5yPJPWY3EOV5TgOWQ7AN7/jUP5S4pdbOOWUqM9qrCX4vuB2n1kpYsWZlqt
 MJvwybZKOJCTHtUkmW8XDmp0ks5V6MQrS+NJdrof1RdZ6ElmZGAl8WU8PGWqEgOmMLbTuetS+3I
 Wnqpb2Qm8J2Ai6axj6psTpcI3QBie3vTctW2llWRjz3Xmt7XfdmSUTE7CmKCSdd4wwqr9/5vazV
 wBcVT67/oP+1Rv2iK8L8aRKoFltoKU/jQ3jYAZP4Zqfnu2HuSlHtWIAXA8Gu+jRRWfbc1KQMjK3
 fOkCH86uP2w0b+dYm0W/
X-Received: by 2002:a17:907:1c28:b0:abb:d9c6:ecb2 with SMTP id
 a640c23a62f3a-abeeed5f5c7mr778296266b.21.1740666026271; 
 Thu, 27 Feb 2025 06:20:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHk3huHDJ0jd9iiFURktx9s849n+VJEZsX+VObrS4e+XichH8/IJ4AK9QwCEh0X3h6dMr0Og==
X-Received: by 2002:a17:907:1c28:b0:abb:d9c6:ecb2 with SMTP id
 a640c23a62f3a-abeeed5f5c7mr778293566b.21.1740666025775; 
 Thu, 27 Feb 2025 06:20:25 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b9887sm129751966b.7.2025.02.27.06.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 15/34] target/i386/hvf: fix the declaration of hvf_handle_io
Date: Thu, 27 Feb 2025 15:19:33 +0100
Message-ID: <20250227141952.811410-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

There is a conflicting declaration for hvf_handle_io in x86_emu.c.  The type of
the first argument is wrong.  There has never been a problem because the first
argument is not used in hvf_handle_io.

That being said, the code shouldn't contain such an error. Use the proper
declaration from hvf-i386.h.

Take the chance to change the first argument's type to be CPUState.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1740126987-8483-3-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf-i386.h | 2 +-
 target/i386/hvf/hvf.c      | 6 +++---
 target/i386/hvf/x86_emu.c  | 4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index e99c02cd4bf..046b681d134 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -18,7 +18,7 @@
 
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
-void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
+void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 353549fa779..1ecb6993ba1 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -103,7 +103,7 @@ static void update_apic_tpr(CPUState *cpu)
 
 #define VECTORING_INFO_VECTOR_MASK     0xff
 
-void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
+void hvf_handle_io(CPUState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
     int i;
@@ -536,7 +536,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             if (!string && in) {
                 uint64_t val = 0;
                 load_regs(cpu);
-                hvf_handle_io(env, port, &val, 0, size, 1);
+                hvf_handle_io(env_cpu(env), port, &val, 0, size, 1);
                 if (size == 1) {
                     AL(env) = val;
                 } else if (size == 2) {
@@ -551,7 +551,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             } else if (!string && !in) {
                 RAX(env) = rreg(cpu->accel->fd, HV_X86_RAX);
-                hvf_handle_io(env, port, &RAX(env), 1, size, 1);
+                hvf_handle_io(env_cpu(env), port, &RAX(env), 1, size, 1);
                 macvm_set_rip(cpu, rip + ins_len);
                 break;
             }
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 69c61c9c073..2c7da10c1d2 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -44,9 +44,7 @@
 #include "x86_flags.h"
 #include "vmcs.h"
 #include "vmx.h"
-
-void hvf_handle_io(CPUState *cs, uint16_t port, void *data,
-                   int direction, int size, uint32_t count);
+#include "hvf-i386.h"
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
-- 
2.48.1


