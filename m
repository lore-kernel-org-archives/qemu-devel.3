Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7A2D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWi-0008As-R1; Mon, 28 Oct 2024 11:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWd-0008AC-HL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWc-0000o7-5M
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wg9v6d6YDJZE1VNEyI3a6xEnT1ZEEyCNwPgTQH2WY0=;
 b=iM24Qmrtlqs1klXLREAvltyBJK2aUgpmlYil0x2Dg83xqcS91Q+MP2djWWZv30UwpCv15I
 8ZoQE3YetZah0tLa7z2gMBVNxEWwYV8PAzVyTohTdjOKCykUUMm7NJP01OEEZ+39thUZBw
 yxkLRTfS2Woaw/+ARS30uapQcNC9nhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-bUwLsPCvNtWqtSK84xsgWw-1; Mon, 28 Oct 2024 11:19:19 -0400
X-MC-Unique: bUwLsPCvNtWqtSK84xsgWw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so2446485f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128757; x=1730733557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wg9v6d6YDJZE1VNEyI3a6xEnT1ZEEyCNwPgTQH2WY0=;
 b=SUsgK8mhXruOMFDneW2xhXIKngV9hhwOt1gtIRhAICMwdiybsxvNFVvTuWI5Vk1AuI
 S03sYjcJxV3FXRSCJvYK90UvzlmFhcWeW5xmOAh5BdmX+u1xu3XDeg+zifQGaOlxInYR
 FTXFpTbeIWGjCdCJZv/mVfQO3c1fduwFOgRjKrPII3t9pJJmca8UYzjQF2blXWEBexeN
 nfSr9lEISPJEZq4mac6IImLhgu4zcFz9+eDntG4viKkNRRJvxjLL0+ePtOw3MK5KNvKB
 lPNh983Kg+s3RT9ezJYA59I8BQzlLVjL9/4otCMH9Nq2GHH1zmZpzE7LnQjNP7VSSKAQ
 MwqQ==
X-Gm-Message-State: AOJu0YwCTVUZtq919GOebc5HqKcEj69mly/mxHUSeyzPVjbayLoalKqF
 7wz9qEQ4XgO4k7AIcihGjyqeXOyVlb95Qt8Yls5Cb3hrhoneLtgijfv4bpFrPeSnqANplFyWV2o
 GfoU5VFuEHwzF85iLCRt12oFpTY+wJjGW0MvkiHiPwmwxY7Nd1d9/vN2uHOhnUf7HpAcDcf92LT
 5PefoD3NLjy3LP8iqjfBeRqubgDP3A2svrg2uUHl0=
X-Received: by 2002:adf:f805:0:b0:37d:43a8:dee0 with SMTP id
 ffacd0b85a97d-38080e51f07mr185659f8f.17.1730128757515; 
 Mon, 28 Oct 2024 08:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnIu6ss1lUBH3y7nRXz2CVcJNDzwC3ZJGlbKtsHcLcmuQW3cBh9PDqiIrZ69x89oVElkqH0w==
X-Received: by 2002:adf:f805:0:b0:37d:43a8:dee0 with SMTP id
 ffacd0b85a97d-38080e51f07mr185631f8f.17.1730128757072; 
 Mon, 28 Oct 2024 08:19:17 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5706c3sm142666855e9.34.2024.10.28.08.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 07/14] target/i386: optimize computation of ZF from
 CC_OP_DYNAMIC
Date: Mon, 28 Oct 2024 16:18:44 +0100
Message-ID: <20241028151851.376355-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/i386/tcg/cc_helper.c | 13 +++++++++++++
 target/i386/tcg/translate.c | 10 +++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

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
index 40583c04cf9..1b83775a914 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -95,6 +95,19 @@ static target_ulong compute_all_adcox(target_ulong dst, target_ulong src1,
     return (src1 & ~(CC_C | CC_O)) | (dst * CC_C) | (src2 * CC_O);
 }
 
+target_ulong helper_cc_compute_nz(target_ulong dst, target_ulong src1,
+                                  int op)
+{
+    if (CC_OP_HAS_EFLAGS(op)) {
+        return ~src1 & CC_Z;
+    } else {
+        MemOp size = cc_op_size(op);
+        target_ulong mask = MAKE_64BIT_MASK(0, 8 << size);
+
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
2.47.0


