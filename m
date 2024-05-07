Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A86C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVG-0006Du-Pa; Tue, 07 May 2024 06:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IVB-0005ui-U4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV9-0002wd-Gt
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hv1mTHtMOvMDbCaGwvhYNHLHmob4hA1awvsWSuwA+Aw=;
 b=iXgU3M1LUSBAJm3mDTv8g39iF/ejvz57snKVOLsejZb4aH9bM7FeEUhGbuFIz0O5sMpeKZ
 UYmxkr/UOfynHjCPJ+3sXE065Hbnwz9g8sFetrPKKM/T/1J6zhurnt6ApkUTaZFa0co8u0
 CWQnkR0pURoxzM/MdHMg9v2jfCjv1Ck=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-YftTFXGROV2TfX-mowK5mQ-1; Tue, 07 May 2024 06:56:49 -0400
X-MC-Unique: YftTFXGROV2TfX-mowK5mQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c0ecd59cso164812666b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079407; x=1715684207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv1mTHtMOvMDbCaGwvhYNHLHmob4hA1awvsWSuwA+Aw=;
 b=TtFClvm5lm9snT6LsWll5HBNw8JflLvkj4pjXI1JTqOogYh3pDtqDac/hLeWHk/OHv
 t+zfODXZuOxG5+HJ+VbCvmLG8TbycpYZ6ccI9Zi77PvZQVJvLHwW9erUtTA3nbQLL1jS
 vahcLzWaPVgWzM/QGOjS2P+ERwNSp2pAW5fq5eoII3jk14rhdMP0QIU10/qejo0Ow6Fv
 lwybo336yCSdxLjdrhHXsvr+iD7WI8ORFM/zL4hsh1V+meEl/OYGkQhVfWaUTGUv0gXt
 VtaTOuNpPvFevkrMlokwdRY89nVT+DCl5uPHOgALyO5rP/Gvsfx5UpTGZtOg6bEkNV+6
 tTKQ==
X-Gm-Message-State: AOJu0YyT35+Ki159l4lr+b4U0c6BqB7Fpo4PM1kDV1JKkfFIdFgnsjxv
 +An/3eDHss+5wdY26+5gVWddt39BEprYc/Rju/8bNm8WMv/pwsN0IklT1hHyh2xfvaitb4pBE1/
 m7SNo8WYRW6/OvMZFGcAuJ9y9DvVtgDFSm+cdpOV3cp6EKHvHzYgSLaV3iwk7L2tUEeITTF0i+7
 w3AL7p2sc/rCuNryRd9Dye6C0wjJHiyISn1Pjh
X-Received: by 2002:a50:934f:0:b0:572:9c4c:250b with SMTP id
 n15-20020a50934f000000b005729c4c250bmr12021011eda.18.1715079407442; 
 Tue, 07 May 2024 03:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZeF5IeMRdfd8q2wZFgh1br7eSDQtga1AAtIGbq7i3f4uoxxg1zItAiqOPSG0Hw5pRXb8KVg==
X-Received: by 2002:a50:934f:0:b0:572:9c4c:250b with SMTP id
 n15-20020a50934f000000b005729c4c250bmr12020995eda.18.1715079407100; 
 Tue, 07 May 2024 03:56:47 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 er21-20020a056402449500b005726e5e8765sm6215784edb.3.2024.05.07.03.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/26] target/i386: split legacy decoder into a separate
 function
Date: Tue,  7 May 2024 12:55:37 +0200
Message-ID: <20240507105538.180704-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Split the bits that have some duplication with disas_insn_new, from
those that should be the main topic of the conversion.  This is the
first step towards removing duplicate decoding of prefixes between
disas_insn and disas_insn_new.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 58 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 973bf07ef27..eb0e37e1480 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3117,15 +3117,15 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
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
@@ -3271,6 +3271,38 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
2.45.0


