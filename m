Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81793D767F5
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNn-0004le-Mo; Thu, 31 Oct 2024 13:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMg-0002LQ-N1
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMe-0007RC-TZ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiVqWkstUV/F0IFzwEgI64OSPFJg4cv0MklXzVnGPTs=;
 b=JSrWgIssqVpgfZSVwbGykQaTl/Gg2PdvOERPsONTTr9M1zQR9twlJnfd1FLsyYboK9tSls
 8L+FWBDF4zZMeYvpkkS+pz2twW22vRxwPRlM1P2Ap+Ro767I1NDumB+iMyI8UQgED8Mzkc
 /yLhu5xoA/b1kDYAUNH91czddr6KhVY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-YFECuegOMaGip0FtKIzLwA-1; Thu, 31 Oct 2024 13:53:42 -0400
X-MC-Unique: YFECuegOMaGip0FtKIzLwA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99ea3e1448so99487666b.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397221; x=1731002021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiVqWkstUV/F0IFzwEgI64OSPFJg4cv0MklXzVnGPTs=;
 b=F8Gxp56KvE0auwV3PNtIbLPQOAJDRV8Ouwb/b7Icwz/g2I/m8x5RVdR7EQqfxGxqqJ
 8mIMvFJylGgi6hOOkCdjmeT2ym8TwOFnYEzJPx2+6Xux5dc44fckTEl3c4rkMndqbm6S
 IyY2hvRbCpc3sjKtD5bZfZ0sbjA5wWrlsANijA7hjAV8RYKQOdtPZkKVt36c8k9qGn9N
 RbRVm7ejnu12SnixfJ91I59k4KD7Tfhz7/GRrC4dbIdUGhxFGhR/5L8oDccy67PAQgW7
 bskXOuLQtvq831tvwBv95gFciu3i6yPg93g3OXLon0h034DEXgna0HL4Vu7OCmM37Moo
 eJzg==
X-Gm-Message-State: AOJu0YxM1OvoWf9c6IDxMQ87yoakM9QyWg3lBCHebZtbHidiLEMaPIhG
 3Xc+HTzmiLAqFAVFCZentzxNy33ngvfq8UVOVxe1eGE7lWoHwa1lBEwkz/IKI5uNQPwZhR/qL2l
 jvN1zzSBOEsRV8HeWOjkPHQSPKtV8uIp37sTva4ZkMhplrmwpydR4Sakf8yR/Aw7qF3K48B5sGb
 Z8IHyZhO4ocUAXaCKG0w+dfheHKwiwb0HmS6FDBZM=
X-Received: by 2002:a17:907:2d90:b0:a99:43e1:21ad with SMTP id
 a640c23a62f3a-a9de61d1a80mr1976415166b.45.1730397220868; 
 Thu, 31 Oct 2024 10:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrHZvOtX9wJVqyiNvPk04/lw/KIculd401cl97x/6ivWZXbttfvB7HLDKy8+/3NcAjZvl4Ng==
X-Received: by 2002:a17:907:2d90:b0:a99:43e1:21ad with SMTP id
 a640c23a62f3a-a9de61d1a80mr1976411366b.45.1730397220339; 
 Thu, 31 Oct 2024 10:53:40 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564c5655sm89900366b.74.2024.10.31.10.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 38/49] target/i386: make flag variables unsigned
Date: Thu, 31 Oct 2024 18:52:02 +0100
Message-ID: <20241031175214.214455-39-pbonzini@redhat.com>
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

This makes it easier for the compiler to understand which bits are set,
and it also removes "cltq" instructions to canonicalize the output value
as 32-bit signed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 46 ++++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index c5425e57cfb..4cbbc73c3cd 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -39,9 +39,9 @@
 
 /* dynamic flags computation */
 
-static int glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2 = dst - src1;
 
     cf = dst < src1;
@@ -58,10 +58,10 @@ static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return dst < src1;
 }
 
-static int glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
+static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                          DATA_TYPE src3)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2 = dst - src1 - src3;
 
     cf = (src3 ? dst <= src1 : dst < src1);
@@ -79,9 +79,9 @@ static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
     return src3 ? dst <= src1 : dst < src1;
 }
 
-static int glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
+static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2;
 
     cf = src1 < src2;
@@ -100,10 +100,10 @@ static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     return src1 < src2;
 }
 
-static int glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
+static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                          DATA_TYPE src3)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2 + src3;
 
     cf = (src3 ? src1 <= src2 : src1 < src2);
@@ -123,9 +123,9 @@ static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
     return (src3 ? src1 <= src2 : src1 < src2);
 }
 
-static int glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = 0;
     pf = parity_table[(uint8_t)dst];
@@ -136,9 +136,9 @@ static int glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2;
 
     cf = src1;
@@ -152,9 +152,9 @@ static int glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2;
 
     cf = src1;
@@ -168,9 +168,9 @@ static int glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 >> (DATA_BITS - 1)) & CC_C;
     pf = parity_table[(uint8_t)dst];
@@ -187,9 +187,9 @@ static int glue(compute_c_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return (src1 >> (DATA_BITS - 1)) & CC_C;
 }
 
-static int glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = src1 & 1;
     pf = parity_table[(uint8_t)dst];
@@ -204,9 +204,9 @@ static int glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 /* NOTE: we compute the flags like the P4. On olders CPUs, only OF and
    CF are modified and it is slower to do that.  Note as well that we
    don't truncate SRC1 for computing carry to DATA_TYPE.  */
-static int glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
+static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
     pf = parity_table[(uint8_t)dst];
@@ -217,9 +217,9 @@ static int glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 == 0);
     pf = 0; /* undefined */
@@ -237,7 +237,7 @@ static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 
 static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
     pf = 0; /* undefined */
-- 
2.47.0


