Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443ADC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0d-00054y-69; Fri, 24 May 2024 04:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0Z-00052Z-9I
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0X-0000NK-MS
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzMu4bGplTJ0/IjTAQY/99ej8JAgWkuVwj+4BdBCfyk=;
 b=ZEBbRjIITJuZTw5WKWKXwq4oQ63WOnzJqc9xKuo1TyAA5qPoKYhPNFrmlljQuASN0BVHPM
 UpFL+i2rK6UaXPkfxZ0e2ZbuTvJi4dm8HVMO/K2iae5zgRWxSm3Bg+ly+FGqHIl5YM9E8g
 JEBcO15a4zwR8Yoo5du8eEDQBuRdHqg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-2IZSzd3LMQu8OLb9wXZErA-1; Fri, 24 May 2024 04:10:31 -0400
X-MC-Unique: 2IZSzd3LMQu8OLb9wXZErA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6265d3cb78so26097566b.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538229; x=1717143029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzMu4bGplTJ0/IjTAQY/99ej8JAgWkuVwj+4BdBCfyk=;
 b=csfUmlTAQzoTjGgWUO1xg/lUCRzi36WMjZ1yHh4wfgqI08StTE70vEWvTroSeECtaS
 mMFTo3QGkp1AJeugwQX5qcMoajD43fYNBOcgbp4vIuUaRVn49PvoWnBsMtJSSOIA+VNb
 23MMijmJHOVGZ/verpoZNAi2Ost8USzoC02BigUdjH10MOk79FLEFMCxDSuveVGxgzBz
 /RtnF/0c2HLfZOQHgsCGxKakKV9VyVQlHETKVCnIN7jn6vcm+nPuCwIVS32oNvQbfY4U
 OoOicFLng3CUrcQjKkLZsTh5bZRPc4xg7IR9OJHci7DFZjCJa5FQmb544EoQ/UpG0hMn
 nJmw==
X-Gm-Message-State: AOJu0YzlT7u9095MO53k7Ns1eqd+PW0zJ1UkT9iX2wwXeH9AFeoS/UGo
 IbMZzhHELZwxCroDznAjHE7iDiXmUk+Es4U4lBqfQZi2w1vQCAYpyn0AuQoFNfHzUyD7sRUwJOU
 /VtVK0OGx/1mOES3RrUzjo5dOlQMeJ1rGBGf/2yIakyBK2ov5/ZpPMUdAhYO1nlimLH1Br6gpB1
 7ntokuN7u9jdbCXZY5KS3WO/KqNuCGevHnGfgG
X-Received: by 2002:a17:906:a252:b0:a58:eba0:6716 with SMTP id
 a640c23a62f3a-a6265128466mr82816566b.60.1716538228977; 
 Fri, 24 May 2024 01:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOJqWx8aoDtHqY04Lf8yWJPeTups4VdBXnAWuLIWQ4AUiqeldEcWzwOOqd3yDr8gcyO3RoAA==
X-Received: by 2002:a17:906:a252:b0:a58:eba0:6716 with SMTP id
 a640c23a62f3a-a6265128466mr82815166b.60.1716538228550; 
 Fri, 24 May 2024 01:10:28 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817a98sm91542866b.37.2024.05.24.01.10.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] target/i386: avoid calling gen_eob_syscall before
 tb_stop
Date: Fri, 24 May 2024 10:10:07 +0200
Message-ID: <20240524081019.1141359-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

syscall and sysret only have one exit, so they do not need to
generate the end-of-translation code inline.  It can be
deferred to tb_stop.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 52d758a224b..24e83c1af84 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -168,6 +168,12 @@ typedef struct DisasContext {
  */
 #define DISAS_JUMP             DISAS_TARGET_3
 
+/*
+ * EIP has already been updated.  Use updated value of
+ * EFLAGS.TF to determine singlestep trap (SYSCALL/SYSRET).
+ */
+#define DISAS_EOB_RECHECK_TF   DISAS_TARGET_4
+
 /* The environment in which user-only runs is constrained. */
 #ifdef CONFIG_USER_ONLY
 #define PE(S)     true
@@ -3576,7 +3582,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_syscall(s);
+        s->base.is_jmp = DISAS_EOB_RECHECK_TF;
         break;
     case 0x107: /* sysret */
         /* For Intel SYSRET is only valid in long mode */
@@ -3595,7 +3601,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
-            gen_eob_syscall(s);
+            s->base.is_jmp = DISAS_EOB_RECHECK_TF;
         }
         break;
     case 0x1a2: /* cpuid */
@@ -4799,6 +4805,9 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_EOB_ONLY:
         gen_eob(dc);
         break;
+    case DISAS_EOB_RECHECK_TF:
+        gen_eob_syscall(dc);
+        break;
     case DISAS_EOB_INHIBIT_IRQ:
         gen_update_eip_cur(dc);
         gen_eob_inhibit_irq(dc);
-- 
2.45.1


