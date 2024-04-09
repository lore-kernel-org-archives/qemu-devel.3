Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC18C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEae-00010I-Cy; Tue, 09 Apr 2024 12:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEaU-0000kr-Ae
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEaC-000886-4Y
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhATD6WlEijmtwEnMyv0XkMsx8qShTRSUQW4zG6qxBM=;
 b=Zr4zpMnh872+MwUSERRvPqPGsC0w3Fb30da84eUXtweOj+LMGnww25XlG1ccDi9a3NWuF0
 HZP83nhW0LrpXTMdD02zpAesDsAtT6m0mIErGRRLZ9pdVgKjSV8yJl0pK83NYJnCcgOsb/
 wC/lJqhfwtdkBOz+dSFOjiQ/K6TcttY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-vdSc8MoyPPiTu6VzEXpeuw-1; Tue, 09 Apr 2024 12:44:18 -0400
X-MC-Unique: vdSc8MoyPPiTu6VzEXpeuw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4165339d3a5so13448755e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681056; x=1713285856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhATD6WlEijmtwEnMyv0XkMsx8qShTRSUQW4zG6qxBM=;
 b=bmYD8pBvUqqIRw779Vuaiqoj/3QOXXmjWp9rSTyLowDoQaf/xiB69E+9eUVNJMgFHD
 9qjtflpzBbrIDZll7wis4cs0MaRupSKz5qF2Pc1AscBwSCRNkaNboARZwOSqLu1asnaK
 b6vey9x4b/FQVchhVEm4WLGyqu7M8uGpLuIBfCL/OnjUXwOB3WDp2FO8mQ4EUO3sWtMj
 hFq9Pam9kBXMkdNG0o10tznh0tsryrmlEdDUrebRXrsI3Sh+b98kLd1sH3FPBXE7NDgm
 g1yOSXaX3FBuO0f6CoK+7yKe7e9UHZk4Jcx3y0k8rYMSUR8QL4GyC153ug3Gh7tw1pvI
 D1Ow==
X-Gm-Message-State: AOJu0YzYacYDrb6Gzkr7xDb7V0ryUJJD5i6N35WeA4c//Tou5NPkrr3x
 VFWxNnyzmOBBpAoKp+o0iYoo36n094xb7rMNI9sz7hiKQyhksujWZLQ635kpXPOUf9q/0l1wupP
 rmJMCLYz2ftUMFDY3+ZEkCCPFPOH1BLs8/wvEPqDNiu1o1Bwa74CkzXBjv9yve7CoIV0ejD3mO3
 l8bV/c8JqyvzAjoprhBUWhnNxxPwNK4b5igptS
X-Received: by 2002:a05:600c:3509:b0:416:1d6d:dc6d with SMTP id
 h9-20020a05600c350900b004161d6ddc6dmr157760wmq.40.1712681056616; 
 Tue, 09 Apr 2024 09:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHczaWaxVv2jwUGnInMbOrW+Q+M+/+OQaMmF+AU7sLECPPfeznq05gsce+PzbaBRMZLeouFw==
X-Received: by 2002:a05:600c:3509:b0:416:1d6d:dc6d with SMTP id
 h9-20020a05600c350900b004161d6ddc6dmr157752wmq.40.1712681056289; 
 Tue, 09 Apr 2024 09:44:16 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a05600c1c1600b004165315d885sm10744816wms.11.2024.04.09.09.44.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:44:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 18/19] target/i386: split legacy decoder into a
 separate function
Date: Tue,  9 Apr 2024 18:43:22 +0200
Message-ID: <20240409164323.776660-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Split the bits that have some duplication with disas_insn_new, from
those that should be the main topic of the conversion.  This is the
first step towards removing duplicate decoding of prefixes between
disas_insn and disas_insn_new.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 58 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e7f51685ed8..d3c863c5d1d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3119,15 +3119,15 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
     return true;
 }
 
+static void disas_insn_old(DisasContext *s, CPUState *cpu, int b);
+
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static bool disas_insn(DisasContext *s, CPUState *cpu)
 {
     CPUX86State *env = cpu_env(cpu);
     int b, prefixes;
-    int shift;
-    MemOp ot, aflag, dflag;
-    int modrm, reg, rm, mod, op, opreg, val;
+    MemOp aflag, dflag;
     bool orig_cc_op_dirty = s->cc_op_dirty;
     CCOp orig_cc_op = s->cc_op;
     target_ulong orig_pc_save = s->pc_save;
@@ -3273,6 +3273,38 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     s->aflag = aflag;
     s->dflag = dflag;
 
+    switch (b) {
+    case 0     ... 0xd7:
+    case 0xe0  ... 0xff:
+    case 0x10e ... 0x117:
+    case 0x128 ... 0x12f:
+    case 0x138 ... 0x19f:
+    case 0x1a0 ... 0x1a1:
+    case 0x1a8 ... 0x1a9:
+    case 0x1af:
+    case 0x1b2:
+    case 0x1b4 ... 0x1b7:
+    case 0x1be ... 0x1bf:
+    case 0x1c2 ... 0x1c6:
+    case 0x1c8 ... 0x1ff:
+        disas_insn_new(s, cpu, b);
+        break;
+    default:
+        disas_insn_old(s, cpu, b);
+        break;
+    }
+    return true;
+}
+
+static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
+{
+    CPUX86State *env = cpu_env(cpu);
+    int prefixes = s->prefix;
+    MemOp dflag = s->dflag;
+    int shift;
+    MemOp ot;
+    int modrm, reg, rm, mod, op, opreg, val;
+
     /* now check op code */
     switch (b) {
         /**************************/
@@ -4726,31 +4758,15 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
         set_cc_op(s, CC_OP_POPCNT);
         break;
-    case 0     ... 0xd7:
-    case 0xe0  ... 0xff:
-    case 0x10e ... 0x117:
-    case 0x128 ... 0x12f:
-    case 0x138 ... 0x19f:
-    case 0x1a0 ... 0x1a1:
-    case 0x1a8 ... 0x1a9:
-    case 0x1af:
-    case 0x1b2:
-    case 0x1b4 ... 0x1b7:
-    case 0x1be ... 0x1bf:
-    case 0x1c2 ... 0x1c6:
-    case 0x1c8 ... 0x1ff:
-        disas_insn_new(s, cpu, b);
-        break;
     default:
         goto unknown_op;
     }
-    return true;
+    return;
  illegal_op:
     gen_illegal_opcode(s);
-    return true;
+    return;
  unknown_op:
     gen_unknown_opcode(env, s);
-    return true;
 }
 
 void tcg_x86_init(void)
-- 
2.44.0


