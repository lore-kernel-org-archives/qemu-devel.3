Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBA0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSU-0005ds-TR; Mon, 06 May 2024 04:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRs-0004zW-1O
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRL-0002bJ-Us
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYkUXKVgikgRxjMEnZM7x1wi9MeC1reAhoLZnGHXz94=;
 b=KzK2CVsKvFY0i7SiGYCmgIjy8WBGC3RTcfLl3ymnANRmAECwqVvmUPl29UMQCOLAXI9mvI
 2qZ2pk4A2m91YCktXHeT+N5utOde/c+EHN1b+NtOU/5St3bnh1os6uoACbzFSlwnWST6cO
 ZVDDD/WMBf9VLkeMc2P5bxFfGb3XFGE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-61L3IBJGN-GVKsCFx7b7mg-1; Mon, 06 May 2024 04:11:13 -0400
X-MC-Unique: 61L3IBJGN-GVKsCFx7b7mg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59aedbd9a9so110977066b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983071; x=1715587871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYkUXKVgikgRxjMEnZM7x1wi9MeC1reAhoLZnGHXz94=;
 b=hjn0uwEwV8Dqynpfe742DgBylgAgGd8IGb5YaVIfAmReIIBoyyi0lN1uCz/2g1yYfz
 qNOojuQZ1YLUwosppkE9IZHyCAsN2+PFjktK2778JZnC5ckh8DIwW0yI+cSv7rfIBmiA
 7XkSS6Tkq32MDBFDSGX3F+mA50ltLI9TQYT/qeJO//6wcN5S7XtlL6AchBh+dSRVrDvj
 RABMFrSPNsFXjiOAINNQsNXtwU9AFP/esqSLswjaRjTT6DFjAzKc+dJRHDhe75qIulOv
 ruAOmhuBbefsSc0ldwJsqjT9/B0Wcl883N/8OyVzHZ5FkQ/NA0A8Q2qYbjDWkmXRwT4Y
 3oIw==
X-Gm-Message-State: AOJu0YzvkGzYzc4ehvPEeAV6QaDHNeKjtraZUfHyshduk5JZVZQwIqsb
 UIlo3A0Dt4x2GjMB939yTVtwIjJ4N2i2ZIP/YbcBR9oy9h7ijhOvHDnO/rERR3+uWRd6AmMwtyx
 SxCptuKU+edW6TD589QJK9HA1lynnE08r5PGHU2UBO8U6YXwwkNyD72pb45S3l6nwXlX7UDpReE
 uvbI+qycFJPSTmN/el4VJzj3bov2lflyYhC0RJ
X-Received: by 2002:a17:906:730d:b0:a59:c52b:9937 with SMTP id
 di13-20020a170906730d00b00a59c52b9937mr2266189ejc.4.1714983071646; 
 Mon, 06 May 2024 01:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuQ1XcljoG1T0HEnTD08yF+oBvdS3f3N5SNQA8yRZjGAJ+JWjdJQYUqv577fRME1LqojUiOg==
X-Received: by 2002:a17:906:730d:b0:a59:c52b:9937 with SMTP id
 di13-20020a170906730d00b00a59c52b9937mr2266164ejc.4.1714983071116; 
 Mon, 06 May 2024 01:11:11 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 lc5-20020a170906f90500b00a599c783c04sm3453689ejb.20.2024.05.06.01.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:11:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 24/25] target/i386: split legacy decoder into a separate
 function
Date: Mon,  6 May 2024 10:09:56 +0200
Message-ID: <20240506080957.10005-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index e077fdd8c71..8c1062c8e13 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3116,15 +3116,15 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
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
@@ -3270,6 +3270,38 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -4725,31 +4757,15 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
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


