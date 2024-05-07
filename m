Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF53C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUY-0004dH-KG; Tue, 07 May 2024 06:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUV-0004b1-AX
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUT-0002XH-CK
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRM1qMaryv6gzX0RfpKm8mdokMAI2Jdm+A9AH27zy4U=;
 b=ieX8stpweBFzhCava5phzpjSx0snygqiqopcHMeg/rRP+tFMvDPLa6GMgi3AmlkIgYl9em
 PbbfOMrSueLxIV5aQvxO9CeUiigRT1wYUfUHU/9WNtLZZqYT0C9wsTZWcsrfIkmb0W5TnU
 RQAYPEyzrKN2xyjfllDixkQV9knZjlc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-UA-QWJqmN5yCLCKhsNbXFg-1; Tue, 07 May 2024 06:56:07 -0400
X-MC-Unique: UA-QWJqmN5yCLCKhsNbXFg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e0b3a7ffbeso27866491fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079364; x=1715684164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRM1qMaryv6gzX0RfpKm8mdokMAI2Jdm+A9AH27zy4U=;
 b=Fm9/VSA/y6VqtJzTApnuF6EEEGWZgteAI8aonpIvo+5RDYB4DHWvQEVVM9meiZBkbX
 aBMJbK2x1BM+dvxCRH1fazIf65exo0ze7305Lb7Ws6vDesRALDc5N2zczAjlYrX/9mTc
 5iM/PwonEhalzQg06yViwfuZAuusa6u9RzAZc6gNRteFPRmXDd9GwTf6WYL043o+pnvI
 lSBq4aGIhaCDNE6Sp96koa5ABB/UkFIVgsXfg1tUllYsruPTDeAd81ugbTFYgqKfdwfS
 U1qAkS8Gmc9wZBt0ad7UNNm3sIogSl2ZrIYJZtFkCJ4zduB30hOK5arfg2VN1p4LQYTT
 4UZA==
X-Gm-Message-State: AOJu0YyD/CT7MCXjHDd/XnnJM3W3OyLbwwrok4ASqm1AnZKGs38d2/V3
 iVPZ1rlJUMfbsF5DvIdKO1s1+mdnDWeLQupepTHdXMpOBZoZOwHtbTRiz+YCYzIL6yPsNKsicwr
 pIt2wlKiCFnQPT0HioUUnjr/RnCS+HH4lAG2qEjkVfFP5kx65KtGRJCJv2hXvg5IY05GK/AGCuR
 yx9hqNRQ65LH/agUEgRDRt3u6raIJWyVJW9JsD
X-Received: by 2002:a05:6512:3d0d:b0:521:5583:483c with SMTP id
 d13-20020a0565123d0d00b005215583483cmr618265lfv.54.1715079364143; 
 Tue, 07 May 2024 03:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrrkZ0cC50NMhgMLjzA864xPMp2PspizP3CuFp/IPxiAu6gaVk7FJWr73Y2ZxXE8duJh+wuQ==
X-Received: by 2002:a05:6512:3d0d:b0:521:5583:483c with SMTP id
 d13-20020a0565123d0d00b005215583483cmr618230lfv.54.1715079363597; 
 Tue, 07 May 2024 03:56:03 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a50cd85000000b0057259943ba2sm6449053edi.12.2024.05.07.03.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/26] target/i386: do not use s->T0 and s->T1 as scratch
 registers for CCPrepare
Date: Tue,  7 May 2024 12:55:21 +0200
Message-ID: <20240507105538.180704-10-pbonzini@redhat.com>
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

Instead of using s->T0 or s->T1, create a scratch register
when computing the C, NC, L or LE conditions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7292908adc3..dae9553fcaa 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -998,6 +998,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
        /* The need to compute only C from CC_OP_DYNAMIC is important
           in efficiently implementing e.g. INC at the start of a TB.  */
        gen_update_cc_op(s);
+       if (!reg) {
+           reg = tcg_temp_new();
+       }
        gen_helper_cc_compute_c(reg, cpu_cc_dst, cpu_cc_src,
                                cpu_cc_src2, cpu_cc_op);
        return (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
@@ -1152,8 +1155,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             break;
         case JCC_L:
             gen_compute_eflags(s);
-            if (reg == cpu_cc_src) {
-                reg = s->tmp0;
+            if (!reg || reg == cpu_cc_src) {
+                reg = tcg_temp_new();
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
@@ -1162,8 +1165,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         default:
         case JCC_LE:
             gen_compute_eflags(s);
-            if (reg == cpu_cc_src) {
-                reg = s->tmp0;
+            if (!reg || reg == cpu_cc_src) {
+                reg = tcg_temp_new();
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
@@ -1208,7 +1211,7 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
    value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T0);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
@@ -1223,7 +1226,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
    cc_op is clean.  */
 static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T0);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     gen_update_cc_op(s);
     if (cc.use_reg2) {
@@ -2493,7 +2496,7 @@ static void gen_jcc(DisasContext *s, int b, int diff)
 
 static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T1);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     if (!cc.use_reg2) {
         cc.reg2 = tcg_constant_tl(cc.imm);
-- 
2.45.0


