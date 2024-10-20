Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC9D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YFz-0003Om-OI; Sun, 20 Oct 2024 11:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFi-0003NF-FZ
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFf-0005Q1-Jn
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4PvFEk58IPsCXTEM1w79SZ0J2i929/FJcA19Ybp0Gg=;
 b=R0aOo5uYsLF/EWpWZFxUvgbS90PqPOHaF1ATXdIvXyelCDNWBQHg/1at5/4S3ffqjXj53g
 ZMP/KIPfU/du9gCx3+Bx0X9HeZ1aBrmVpaOZ9Bd8LqYVCoiPSr2PWTagS3M7ebaCK8mpyG
 zpmnJ8l42JKLbpU1YddXjN6eGBW7TW8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ASvykA80PHiJO2dxNZ3tfA-1; Sun, 20 Oct 2024 11:53:52 -0400
X-MC-Unique: ASvykA80PHiJO2dxNZ3tfA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d43e7acd9so1935942f8f.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439630; x=1730044430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4PvFEk58IPsCXTEM1w79SZ0J2i929/FJcA19Ybp0Gg=;
 b=JhTJJJfFCq/d3TQIgqRCpTfDPHy7LBedaJDVaCwIgUDj3SYQzmQk/9wawiKu3wZene
 KBlipgo27Z3RKQ+IIysGQrliwwSYshcdeY1bnnMM/vLr07Z3Uex73Kl2fyYmHDIw+VS6
 ysXqiMSjjg3PhMgaGBBYlgsVfm6+7Nu6qZXFkNHf6KhuJro3IsIgL0PiI6CeoBs3u9UQ
 ZwIjGWk595ncx6aMi5rnNMfl+RlBCMnxr4GRFeLK+BnF8uJijEei9I0QBWEnVJu83YFx
 o/b/+WY8vhTWRdWgWoqgMamH+hjCZircFbi0DoPPki8QVhdBFDM8aVH5ivVFo0/W5n95
 ltRA==
X-Gm-Message-State: AOJu0YxTXWo2DDmMOmrvuG4WnN3AyvpKIGvkK4uGWWJ9nDBiZkaUFFFh
 oujKJB7Sf8/Bzt9DizhcsSibQqiaw5ymih4wQ9eS1kIF21tyuQc5vQaqPL/E51mIOEbQWoE4E0w
 ARe8OGlg4QdJmGw/O9cv/U2q2EbtuKZLcTC2WvtaAkZC+CGvfoeVwi8HwXIgqnvzkupN9yDGuLh
 XGvMI5VCwec/ALxsgO3SK93ipmsyUlrO66ePFBllI=
X-Received: by 2002:adf:9bce:0:b0:374:c3e4:d6de with SMTP id
 ffacd0b85a97d-37eb47693ebmr5568572f8f.41.1729439630471; 
 Sun, 20 Oct 2024 08:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYs5PhMmHMVurLaUGvUD3qQLkrgINiHMsLxe/lrIiMjEMIN9exT2J2RBGEAZcGZ9RUH5GKZg==
X-Received: by 2002:adf:9bce:0:b0:374:c3e4:d6de with SMTP id
 ffacd0b85a97d-37eb47693ebmr5568560f8f.41.1729439629969; 
 Sun, 20 Oct 2024 08:53:49 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bb66sm1979910f8f.95.2024.10.20.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 07/14] target/i386: optimize computation of ZF from
 CC_OP_DYNAMIC
Date: Sun, 20 Oct 2024 17:53:17 +0200
Message-ID: <20241020155324.35273-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Most uses of CC_OP_DYNAMIC are for CMP/JB/JE or similar sequences.
We can optimize many of them to avoid computation of the flags.
This eliminates both TCG ops to set up the new cc_op, and helper
instructions because evaluating just ZF is much cheaper.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h        |  1 +
 target/i386/tcg/cc_helper.c | 20 ++++++++++++++++++++
 target/i386/tcg/translate.c | 10 +++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index eeb8df56eaa..3f67098f11f 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -1,5 +1,6 @@
 DEF_HELPER_FLAGS_4(cc_compute_all, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 DEF_HELPER_FLAGS_4(cc_compute_c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
+DEF_HELPER_FLAGS_3(cc_compute_nz, TCG_CALL_NO_RWG_SE, tl, tl, tl, int)
 
 DEF_HELPER_3(write_eflags, void, env, tl, i32)
 DEF_HELPER_1(read_eflags, tl, env)
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 40583c04cf9..c24e6a14c07 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -95,6 +95,26 @@ static target_ulong compute_all_adcox(target_ulong dst, target_ulong src1,
     return (src1 & ~(CC_C | CC_O)) | (dst * CC_C) | (src2 * CC_O);
 }
 
+target_ulong helper_cc_compute_nz(target_ulong dst, target_ulong src1,
+                                  int op)
+{
+    target_ulong mask;
+
+    if (CC_OP_HAS_EFLAGS(op)) {
+        return ~src1 & CC_Z;
+    } else {
+        MemOp size = cc_op_size(op);
+
+        if (size == MO_TL) {
+            /* Avoid shift count overflow when computing the mask below.  */
+            return dst;
+        }
+
+        mask = (1ull << (8 << size)) - 1;
+        return dst & mask;
+    }
+}
+
 target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
                                    target_ulong src2, int op)
 {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1a9a2fe709e..5e326ab1aff 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1008,15 +1008,19 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
 static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
-    case CC_OP_DYNAMIC:
-        gen_compute_eflags(s);
-        /* FALLTHRU */
     case CC_OP_EFLAGS:
     case CC_OP_ADCX:
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_Z };
+    case CC_OP_DYNAMIC:
+        gen_update_cc_op(s);
+        if (!reg) {
+            reg = tcg_temp_new();
+        }
+        gen_helper_cc_compute_nz(reg, cpu_cc_dst, cpu_cc_src, cpu_cc_op);
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = reg, .imm = 0 };
     default:
         {
             MemOp size = cc_op_size(s->cc_op);
-- 
2.46.2


