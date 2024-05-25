Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707DBC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfC-0002OE-MH; Sat, 25 May 2024 07:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApf8-0002NZ-V1
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApf7-00044R-BT
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbd4E/05WUdNKIkx4SA2xBZKuCnPUAlJCLsAjzirtJc=;
 b=SPhgDbopNKy5JWe3t00VAEeEy7CuWtqwHsa2xEHv9IJI+XlGM2KKuJlUtgfm3VXytpfgWT
 ciSrDDrEtTEg+ANelaXzu7zchP6qS3yyTNaDs3+fpgicWEPq3PKnVMOidZ1mnhAJAOxzIC
 iS9JA+5eXZTbrfI1i9WI3D9D6UymgP0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-rcazl4BtPTa1s6qLYGbQUQ-1; Sat, 25 May 2024 07:34:06 -0400
X-MC-Unique: rcazl4BtPTa1s6qLYGbQUQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5785fc97facso816621a12.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636844; x=1717241644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wbd4E/05WUdNKIkx4SA2xBZKuCnPUAlJCLsAjzirtJc=;
 b=uN42sLBYac1LnmtnU53tjpviWBkreI4nd8/tknQ3wURvWKTu0hnLjH4EPAmyJ2+4uU
 9uW01us7nFjKy0/nL/jzKRriRK6hcVO9I/VjjyAd5JOyEvHlAPwd2glaY5KZotKpjrcR
 FwimbJ5Xie4sz6N1M0nS0tBHqOUUCdKAnY+nldJiwSmELYlK6GRVIZ9NQ8aEnRIFQPBi
 Ro418jqQesQrK+k25Biispp03mS6fAlqhrSPu2Hw8s43oRo1gjBJwyVv6O5muOL09NjH
 z8X7w6g4qRWkT/eqzAhuxI/9iv+aFPOCDHwu7QRR0fb08mO8xLLjITE5Ss8SEinaWDhf
 B4Yg==
X-Gm-Message-State: AOJu0YxdtqeaQ+H3/KdMLGODAHYQ9SfN3TByVQYItVFsbOacqmDVSvOT
 TGD9rtZgYgGYmtruklcJQZOKPXjzCk2llnBa1u0z/U/a6E9ku6GlUi1SrXbK8r/CTaH5do1X/wL
 LFwHW2CT7hQBqnD/cu/qaAomBgUu6up6zMV2dYgoGlqpV1KcjonvTkvPv8jqd10X04NmKM5G9st
 hRCLrYs4xkvp90801f9fR5495+r4JdcVYYZ/Og
X-Received: by 2002:a50:d74e:0:b0:572:9d24:257a with SMTP id
 4fb4d7f45d1cf-578519a91f8mr3195122a12.23.1716636844358; 
 Sat, 25 May 2024 04:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF2kXKoTrhP2nx6akXDfxYyKZOkgqRo1xIIJwTrQd2L7hUIAf3Ao534/uB+6bobAZ8VUcaDw==
X-Received: by 2002:a50:d74e:0:b0:572:9d24:257a with SMTP id
 4fb4d7f45d1cf-578519a91f8mr3195107a12.23.1716636843874; 
 Sat, 25 May 2024 04:34:03 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578523d58afsm3058889a12.44.2024.05.25.04.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/24] target/i386: avoid calling gen_eob_syscall before tb_stop
Date: Sat, 25 May 2024 13:33:17 +0200
Message-ID: <20240525113332.1404158-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1246118e42b..06aaaa00b43 100644
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
@@ -3587,7 +3593,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_syscall(s);
+        s->base.is_jmp = DISAS_EOB_RECHECK_TF;
         break;
     case 0x107: /* sysret */
         /* For Intel SYSRET is only valid in long mode */
@@ -3606,7 +3612,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
-            gen_eob_syscall(s);
+            s->base.is_jmp = DISAS_EOB_RECHECK_TF;
         }
         break;
     case 0x1a2: /* cpuid */
@@ -4810,6 +4816,9 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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


