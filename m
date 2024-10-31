Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3608D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZN5-00034p-6V; Thu, 31 Oct 2024 13:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMK-0001uD-KX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMI-0007Ot-SI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5sg1ofJZAEmJb7UHkIAx7/U5KIn00yWoaP0I20s9hQ=;
 b=Uv80oRyN3tPLQOcv9uSLuxxK5rbIO2erMU7yEporYanGUwg8kWO2THSkAfsDesfUM6o7eo
 3HitGCZmgUb8uVVC0z3ETYecy4Pd0RNHGv9GoCd9Xd4h/453P4dlMqRA3HjR3nIr3uWvh7
 SQwZPJGlLN1Sgw2DcsJc3b9pepZgESA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Kyz2MrxLOteEEE1_jzNiNw-1; Thu, 31 Oct 2024 13:53:20 -0400
X-MC-Unique: Kyz2MrxLOteEEE1_jzNiNw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so670145f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397198; x=1731001998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5sg1ofJZAEmJb7UHkIAx7/U5KIn00yWoaP0I20s9hQ=;
 b=ku0JkAmJlVIJa7oQk7P8nL+CKRNwO1wofNn8fzu0oRBAylVb6rQvB4fJ9rzP0Pf92d
 51NOK9cFhP9TcTZSVtew1PUJ10PVa8NrwWT/I4wHFRDYwR3Cq3w/QGh7lzDOzU3PdTs5
 fN+ke2n4xa1VGjdsNAZI2M8NzxgUVXpr1L43rm2UOKNtp7/HnLgGCdfzqa49+6x5J+HF
 AH+t9MeyopMoIXIwO99bTve6PP8MqWAzwIl5wmxOZhjJ+TdlLuMXCuEpYQkN773poOeX
 DpE3Onnu7JVmzV1LTly31bf/ROeEA0bzmNiSsXX0vnTVsdDKysU+mbo98cgB+dHQRrbv
 PpdA==
X-Gm-Message-State: AOJu0YwJkez0My/ImLB+0bp2XNz5EKcr0QXFVAKNORUhzVmfA8ujndCK
 xRBk4CsSOvwYKNwrNFnEcfCKEYa+AK63iMmQVGa0PPmb9rIYQuAP6LdYR+RNKssJR8NwXKaczaB
 +eSdjHcxj5w6ESRKi0EiHk920ozYPcRgIwlc4U7AnSNEU/FVhLXRhlrW8TJdrHB5z6S6B4P4W/c
 v2sv1lUclgBQ6F/QVAXK7RL6isKMsoVKudCatFcA8=
X-Received: by 2002:a05:6000:2a1:b0:374:cd3c:db6d with SMTP id
 ffacd0b85a97d-381c796768dmr885246f8f.6.1730397198426; 
 Thu, 31 Oct 2024 10:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWmg7xOHOZ+BU5P0T5FfTPW4Yu0SrExvocosbXGXAIdou4gK7277hGUebe+uH2+C19/n/WoA==
X-Received: by 2002:a05:6000:2a1:b0:374:cd3c:db6d with SMTP id
 ffacd0b85a97d-381c796768dmr885226f8f.6.1730397197960; 
 Thu, 31 Oct 2024 10:53:17 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e853esm66223165e9.8.2024.10.31.10.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/49] target/i386: use tcg_gen_ext_tl when applicable
Date: Thu, 31 Oct 2024 18:51:52 +0100
Message-ID: <20241031175214.214455-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Prefer it to gen_ext_tl in the common case where the destination is known.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ef190416b49..dc308f31041 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -883,16 +883,16 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
@@ -1041,8 +1041,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
@@ -1052,8 +1052,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size | MO_SIGN);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-- 
2.47.0


