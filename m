Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F042CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPo-0005h1-72; Fri, 28 Jun 2024 13:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPm-0005g2-4b
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPj-0002Eb-Nj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aleBzn+huIt14P3sbcazofrV5NBLqO/zRqX5PoCWTZ8=;
 b=A+Tn9+SkCjZDzZ9xEAuO3pCz2EQBNCk3LPQLnibJVo+kpDNfsUGFixmwn9omscVSEU8B0c
 qTn36ayrceDRQLlZ5Mns76eukA4U8Mo2vbTMfLQrYJqEGQ2ko0U57M6yrpED0FrXqYREHP
 h7bGH+A7oQctuXqsKVdR/hfVoI6Gnic=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-e3rXnFBrMRy4c96lu0U_OA-1; Fri, 28 Jun 2024 13:29:33 -0400
X-MC-Unique: e3rXnFBrMRy4c96lu0U_OA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a724d8c38d3so51002166b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595771; x=1720200571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aleBzn+huIt14P3sbcazofrV5NBLqO/zRqX5PoCWTZ8=;
 b=c7iywsSpysPcRcYuLq0V0ilAiQ2dYj353zHYrfNatSfVAL3+IdReg2dykzkG4vi2js
 pZ5Y08A4rw6VO437VAn+VKp7vrjWsn1MnGQ96UO3J5amwFxFckRsCIkhn2sS/8qoOPVe
 a/8iC1h/dsQAXRl2oDws2j5n6szNJUE5/g1baN8j2+x3B2+ZAtVpzICktKkEHNPixVTU
 l6cpdp9XDAQMBfRQSNydW1+XOmzmlHYONiQbEQPfU//U2dHcaoWNP2c7RLetWtDgTVn9
 ZHUjhcwNaF9GYFSq9fduaS89c3iTMKSENrl9TPozn07AV5tRVfRy2PELXhPSRbwL1prI
 qW9w==
X-Gm-Message-State: AOJu0YwaC/GZBQQ1DE+V1jXE9IVERulsN12bE3nGNdFnj+292hASJgia
 OeDrYvatUf1rx3szhlmoLLsfPOentpbbgJWX4xSKN9pxnPy5ev5YjcJqxUg3Tcwr84rX7Z3CBBP
 6+1N/D30Ra9OnfA3dcXnz3ilL5BYN6cqJRpQSWc3gWnmZxui8Ww/sJydTqTIAftC8cfTf5XPD2S
 SFjd+R/T7tt+ag5T1+Ko0qE6/rUq8t8BcSI4uN
X-Received: by 2002:a17:906:6a22:b0:a6e:f7bc:dcab with SMTP id
 a640c23a62f3a-a7245c64dc3mr1401672066b.65.1719595771322; 
 Fri, 28 Jun 2024 10:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT3uQkXrMm+qoQfJ8OELnvGvIpHRhh8yqSMaWbIexkj2midlvn1DO8fIXnPJ5cbOKIFRd1wg==
X-Received: by 2002:a17:906:6a22:b0:a6e:f7bc:dcab with SMTP id
 a640c23a62f3a-a7245c64dc3mr1401670266b.65.1719595770821; 
 Fri, 28 Jun 2024 10:29:30 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1bc08sm95937266b.28.2024.06.28.10.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/23] target/i386: use cpu_cc_dst for CC_OP_POPCNT
Date: Fri, 28 Jun 2024 19:28:47 +0200
Message-ID: <20240628172855.1147598-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

It is the only CCOp, among those that compute ZF from one of the cc_op_*
registers, that uses cpu_cc_src.  Do not make it the odd one off,
instead use cpu_cc_dst like the others.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 2 +-
 target/i386/tcg/cc_helper.c | 2 +-
 target/i386/tcg/translate.c | 4 ++--
 target/i386/tcg/emit.c.inc  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 52571ababe2..1b4edbe0580 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1332,7 +1332,7 @@ typedef enum {
     CC_OP_BMILGQ,
 
     CC_OP_CLR, /* Z set, all other flags clear.  */
-    CC_OP_POPCNT, /* Z via CC_SRC, all other flags clear.  */
+    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f76e9cb8cfb..301ed954064 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -107,7 +107,7 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_CLR:
         return CC_Z | CC_P;
     case CC_OP_POPCNT:
-        return src1 ? 0 : CC_Z;
+        return dst ? 0 : CC_Z;
 
     case CC_OP_MULB:
         return compute_all_mulb(dst, src1);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ad1819815ab..eb353dc3c9f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -324,7 +324,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_CLR] = 0,
-    [CC_OP_POPCNT] = USES_CC_SRC,
+    [CC_OP_POPCNT] = USES_CC_DST,
 };
 
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
@@ -1020,7 +1020,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS };
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 11faa70b5e2..fc7477833bc 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2804,10 +2804,10 @@ static void gen_POPA(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_POPCNT(DisasContext *s, X86DecodedInsn *decode)
 {
-    decode->cc_src = tcg_temp_new();
+    decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_POPCNT;
 
-    tcg_gen_mov_tl(decode->cc_src, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T0);
     tcg_gen_ctpop_tl(s->T0, s->T0);
 }
 
-- 
2.45.2


