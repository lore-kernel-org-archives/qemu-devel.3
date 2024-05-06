Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E179C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tR8-0004Cw-OK; Mon, 06 May 2024 04:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQo-0003UF-B0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQl-0002NG-FZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wcaz5O9kM6xFtdQe7JZoLdV+i05Af/0Zhu3fO6AJ/cg=;
 b=G5rXUaHNtHCxq1wLZ+xs9lckvouiwRWymZYjYTUIhOdSo/yJNTlQJ6m/OzlT9614+i2s/0
 cKdd3YZZCMtG28YCzIYjm445FvinjwIIQKa/NFYxWKbPwHNkAPaK8PJqqaHoOpq8BJ5v32
 eSUbbUNeORZZCucm9aGwkbF/N7D1xHk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-7WovVe1iOemRKBXPu9ibqA-1; Mon, 06 May 2024 04:10:26 -0400
X-MC-Unique: 7WovVe1iOemRKBXPu9ibqA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c02f798bso99245166b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983025; x=1715587825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wcaz5O9kM6xFtdQe7JZoLdV+i05Af/0Zhu3fO6AJ/cg=;
 b=Fpm+hGopvEBuhZkOCeDs0F7u7cHyN5JwDsVdLwU06EdS8CSYXqp27x8X/Kk/SIh3TG
 Zc5KOdxbQS9HQ1NhoCKoJ+hlsHeGfEM2V1RY2POUwp305vKIhIa3eRiM7sKjVB8qAmSA
 Uqc208j5rJxIOMqQa2Wmk8qjeJANQBbL0ATvCodh44BLxUsGm/SHj6rQUuWdFvB68GoQ
 fsHK33j2AwoF91LH0eLdekXxP1CBoZhqQB0kG1aQLiL6tlVSckS6/6q8RjfjKUhN3zgc
 YpMQshpqMxReWNey1ssrhX2r08/K5kGeyQ4PWlh3d8VJkRpMqaB4jq/VdWGpIliySrnW
 AAPA==
X-Gm-Message-State: AOJu0Yyapjjh4/Z1UDaMIWDKr8orWmse2Y0+GchKr3WorsCFlesKQM3M
 A55OjgBcJbQm0o/c+FrKTsxa/zhXKJYaRpzdinT2TztcLNpj7Pn2hfrInQxCljWgLoqM6qkSeR2
 yuCVn0ccSNsY2yoS12+Jl311rWxbn9EjcTWiHFQ7MPwQB7KYP4UF/Vsg+Kg5FrMOHkppII21lIc
 s9xHJztP7Rx5MZfXQDyoN0dTGk5emuHa884hMN
X-Received: by 2002:a17:906:b249:b0:a59:a0da:1ee1 with SMTP id
 ce9-20020a170906b24900b00a59a0da1ee1mr5581461ejb.69.1714983024786; 
 Mon, 06 May 2024 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF03+aiY3a8Ys4WXV7ND/g7gyIxzN7v23U3h/PfmYxewoQRodSQMyKJyznQAXqOZbiaXXcg7A==
X-Received: by 2002:a17:906:b249:b0:a59:a0da:1ee1 with SMTP id
 ce9-20020a170906b24900b00a59a0da1ee1mr5581445ejb.69.1714983024397; 
 Mon, 06 May 2024 01:10:24 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a170906119a00b00a59cd12c9c6sm1055053eja.116.2024.05.06.01.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 08/25] target/i386: do not use s->T0 and s->T1 as scratch
 registers for CCPrepare
Date: Mon,  6 May 2024 10:09:40 +0200
Message-ID: <20240506080957.10005-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Instead of using s->T0 or s->T1, create a scratch register
when computing the C, NC, L or LE conditions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d76f72c1b96..2cd7868d596 100644
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
@@ -2492,7 +2495,7 @@ static void gen_jcc(DisasContext *s, int b, int diff)
 
 static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T1);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     if (!cc.use_reg2) {
         cc.reg2 = tcg_constant_tl(cc.imm);
-- 
2.45.0


