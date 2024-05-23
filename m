Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45D7C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZ9-0000To-LW; Thu, 23 May 2024 19:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYc-0008CI-7k; Thu, 23 May 2024 19:09:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYa-0005ld-7Y; Thu, 23 May 2024 19:09:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4d6b7168eso3008563b3a.2; 
 Thu, 23 May 2024 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505745; x=1717110545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMC3KrR26fFXaE3oY4A3sqPo0Tq3GFjMOngHn9knGcw=;
 b=MCRHNjmt3vvxLn8jQmRsHmyshN1M4noumih/UJL6sTamUtV4smh/20SjhmktuHj8jQ
 GkjbTd3oe+Z5gYHACn7GejZcJjkDG4/CjoC1VEB5rxkBD88vh2N1vmKJ9ryDn0/NcnGt
 V7QbNeSO67TmpsFDQOipkubxuSUTwoI+yUBC/CtyUWu9JUSYbozwsj30tbYIXIT3lIST
 mwzpTbr+fqQtBN3u/qoB7aN4Os/ekhmcEYFeqM+TNlvNVYbU4z1l3QLB+shsl6JQdjgz
 2I4XUhRUqqP2V5Pw5TfPlwDxNfIl4nXfFg0t7m9Mz/jF+T5VKYATZTuF20gldAXTHIKR
 A4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505745; x=1717110545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMC3KrR26fFXaE3oY4A3sqPo0Tq3GFjMOngHn9knGcw=;
 b=W0icS5BlNW1lzhEG3MOxXGB/IH9p0f+1FaWDHerNdlc1D6tTtxV1waPW5r9WoRhD34
 0v7bTinHRVyMexUO63hj/hNdtLTuGK6RYEVUOw5Xg0egZ4XZiowEnLQsxGbExNXbffic
 krpUKVA/ibH4QDa1OfHpzhxEP/DJsM/wYO1K1Hr1BeEwGF0qR24ka9EnudzN/UnMbkwC
 a1NUexTDKFZTIqcjD7NYOd/ovJt62uJBaZmnfzf1HFeTLSIco1xP+LT7xpvHz2s4H9Ps
 ivrxerIfplS3ihctxSzPBPp3VDbsxDZIPy+VFIGoBwrGEc4itvEbtzO8o6mJKeKCL1Vm
 Dv0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYuuHigYpKrOkSXCpy8aHbSvMdDlWKBzQmIhv19VTWo8CXTAkfsUjVBeLKhhjkWMEHiNmxLVQ+eAWgEmuP07JpQcCp
X-Gm-Message-State: AOJu0YxK8kIYuP+3wpKvSPW+cogW+wOcIdtOm1H+1wtTewJorBk4+lak
 guiRi7aFrNiZsk1Z6x4ogiUZNYWcGg22dhxdDfaiIlcGOzV6YQWBhxZrhg==
X-Google-Smtp-Source: AGHT+IE2Zwv5J8Nd5XaQdRS7WqosG7C8swhgHcjcOGVLXv/GW49/bYp5e/UdkxbJENKyWVd3LVtq1A==
X-Received: by 2002:a05:6a21:789c:b0:1af:86da:3f7 with SMTP id
 adf61e73a8af0-1b212ced305mr1110645637.4.1716505745252; 
 Thu, 23 May 2024 16:09:05 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/72] target/ppc: Move VMX integer max/min instructions to
 decodetree.
Date: Fri, 24 May 2024 09:06:54 +1000
Message-ID: <20240523230747.45703-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :

	v{max, min}{u, s}{b, h, w, d}	: VX-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode            | 22 +++++++++++++++++
 target/ppc/translate/vmx-impl.c.inc | 37 ++++++++++++++++-------------
 target/ppc/translate/vmx-ops.c.inc  | 16 -------------
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 16f3711073..05c1d8c12d 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -852,6 +852,28 @@ VEXTSD2Q        000100 ..... 11011 ..... 11000000010    @VX_tb
 VNEGD           000100 ..... 00111 ..... 11000000010    @VX_tb
 VNEGW           000100 ..... 00110 ..... 11000000010    @VX_tb
 
+## Vector Integer Maximum/Minimum Instructions
+
+VMAXUB          000100 ..... ..... ..... 00000000010    @VX
+VMAXUH          000100 ..... ..... ..... 00001000010    @VX
+VMAXUW          000100 ..... ..... ..... 00010000010    @VX
+VMAXUD          000100 ..... ..... ..... 00011000010    @VX
+
+VMAXSB          000100 ..... ..... ..... 00100000010    @VX
+VMAXSH          000100 ..... ..... ..... 00101000010    @VX
+VMAXSW          000100 ..... ..... ..... 00110000010    @VX
+VMAXSD          000100 ..... ..... ..... 00111000010    @VX
+
+VMINUB          000100 ..... ..... ..... 01000000010    @VX
+VMINUH          000100 ..... ..... ..... 01001000010    @VX
+VMINUW          000100 ..... ..... ..... 01010000010    @VX
+VMINUD          000100 ..... ..... ..... 01011000010    @VX
+
+VMINSB          000100 ..... ..... ..... 01100000010    @VX
+VMINSH          000100 ..... ..... ..... 01101000010    @VX
+VMINSW          000100 ..... ..... ..... 01110000010    @VX
+VMINSD          000100 ..... ..... ..... 01111000010    @VX
+
 ## Vector Mask Manipulation Instructions
 
 MTVSRBM         000100 ..... 10000 ..... 11001000010    @VX_tb
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index cefe04127c..8084af75cc 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -342,22 +342,6 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
-GEN_VXFORM_V(vmaxub, MO_8, tcg_gen_gvec_umax, 1, 0);
-GEN_VXFORM_V(vmaxuh, MO_16, tcg_gen_gvec_umax, 1, 1);
-GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
-GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
-GEN_VXFORM_V(vmaxsb, MO_8, tcg_gen_gvec_smax, 1, 4);
-GEN_VXFORM_V(vmaxsh, MO_16, tcg_gen_gvec_smax, 1, 5);
-GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
-GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
-GEN_VXFORM_V(vminub, MO_8, tcg_gen_gvec_umin, 1, 8);
-GEN_VXFORM_V(vminuh, MO_16, tcg_gen_gvec_umin, 1, 9);
-GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
-GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
-GEN_VXFORM_V(vminsb, MO_8, tcg_gen_gvec_smin, 1, 12);
-GEN_VXFORM_V(vminsh, MO_16, tcg_gen_gvec_smin, 1, 13);
-GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
-GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
 GEN_VXFORM(vmrghb, 6, 0);
 GEN_VXFORM(vmrghh, 6, 1);
 GEN_VXFORM(vmrghw, 6, 2);
@@ -727,6 +711,27 @@ TRANS_FLAGS2(ALTIVEC_207, VEQV, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_eqv);
 TRANS_FLAGS2(ALTIVEC_207, VNAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nand);
 TRANS_FLAGS2(ALTIVEC_207, VORC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_orc);
 
+/* Integer Max/Min operations */
+TRANS_FLAGS(ALTIVEC, VMAXUB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_umax);
+TRANS_FLAGS(ALTIVEC, VMAXUH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_umax);
+TRANS_FLAGS(ALTIVEC, VMAXUW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_umax);
+TRANS_FLAGS2(ALTIVEC_207, VMAXUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umax);
+
+TRANS_FLAGS(ALTIVEC, VMAXSB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_smax);
+TRANS_FLAGS(ALTIVEC, VMAXSH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_smax);
+TRANS_FLAGS(ALTIVEC, VMAXSW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_smax);
+TRANS_FLAGS2(ALTIVEC_207, VMAXSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smax);
+
+TRANS_FLAGS(ALTIVEC, VMINUB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_umin);
+TRANS_FLAGS(ALTIVEC, VMINUH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_umin);
+TRANS_FLAGS(ALTIVEC, VMINUW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_umin);
+TRANS_FLAGS2(ALTIVEC_207, VMINUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umin);
+
+TRANS_FLAGS(ALTIVEC, VMINSB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_smin);
+TRANS_FLAGS(ALTIVEC, VMINSH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_smin);
+TRANS_FLAGS(ALTIVEC, VMINSW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_smin);
+TRANS_FLAGS2(ALTIVEC_207, VMINSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smin);
+
 static TCGv_vec do_vrl_mask_vec(unsigned vece, TCGv_vec vrb)
 {
     TCGv_vec t0 = tcg_temp_new_vec_matching(vrb),
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 80c5217749..7bb11b0549 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -33,22 +33,6 @@ GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
 GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
 GEN_VXFORM_300(bcds, 0, 27),
-GEN_VXFORM(vmaxub, 1, 0),
-GEN_VXFORM(vmaxuh, 1, 1),
-GEN_VXFORM(vmaxuw, 1, 2),
-GEN_VXFORM_207(vmaxud, 1, 3),
-GEN_VXFORM(vmaxsb, 1, 4),
-GEN_VXFORM(vmaxsh, 1, 5),
-GEN_VXFORM(vmaxsw, 1, 6),
-GEN_VXFORM_207(vmaxsd, 1, 7),
-GEN_VXFORM(vminub, 1, 8),
-GEN_VXFORM(vminuh, 1, 9),
-GEN_VXFORM(vminuw, 1, 10),
-GEN_VXFORM_207(vminud, 1, 11),
-GEN_VXFORM(vminsb, 1, 12),
-GEN_VXFORM(vminsh, 1, 13),
-GEN_VXFORM(vminsw, 1, 14),
-GEN_VXFORM_207(vminsd, 1, 15),
 GEN_VXFORM(vmrghb, 6, 0),
 GEN_VXFORM(vmrghh, 6, 1),
 GEN_VXFORM(vmrghw, 6, 2),
-- 
2.43.0


