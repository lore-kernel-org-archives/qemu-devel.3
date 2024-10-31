Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892D7D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZO6-0006Mz-5k; Thu, 31 Oct 2024 13:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMq-0002eZ-8F
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMo-0007TD-Iq
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Brq1Z3wOHMO5oRfw/7xEwxvFa5ov3wTTHRo4E40rdYw=;
 b=B577muaGBsk8V0e1+qx5Ckp6sISmlxLhy33oZNnngpajHT0DzzjHBLxFhzUIDAQSLduGI/
 dy9w7QMfKLlcnduACpiT4oFWCsmpWwiw+KPXlePlhYhiKQyPepQWpWs1+olN81Y79WYhrq
 7sJPFXX9Pd9Eda1PyFMSJI4HAdaojLU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-VBNYVsJ5PVuxoAm2_Kk5ow-1; Thu, 31 Oct 2024 13:53:51 -0400
X-MC-Unique: VBNYVsJ5PVuxoAm2_Kk5ow-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso9862655e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397227; x=1731002027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Brq1Z3wOHMO5oRfw/7xEwxvFa5ov3wTTHRo4E40rdYw=;
 b=Fbv7YJKjuf2OBdgUvaAl4TF1f9CGyyOI5zvhMvk9BCivrPXlZ840MB9yF448RoF+a1
 FanYbUvID8mNfmw19DDE8BKfEC4BoaQUL0xnfBKZL25YeuKFYcm1wBnK6YENItC1vB7d
 6ysNj1dPP9ryxH7zlBW1CIXhoQ81BODjx14FbE7PDNF60t17kYujlWs17yQBxNpLLzMN
 XuzgenxHMR7c0aWZr4mGDb+xYGgUG/YHPv6IiXEBU3XauK7c4GP+kgWqnjWH8XCv9NN6
 I5QdlGFFaIi260WQjsTRmwYPaYatp1QYH9F4dK3GpXKmXuBTRgU/te6RIZv0Gdg0LtHV
 IhAw==
X-Gm-Message-State: AOJu0YxyewyBnbefJtOt9ZG6yOS5Cna9KtROw1Imfr1Cfp8c5j1tCJB1
 bThMlNOAsPMOWSoXtDYxS1ZoH6eh8FxJ03cvyri6m1QgahKVDoGjvlzXDVtk0Y4AKopAjB5Yebz
 Z4pNTj9Lp2KH82adEgUkenqbn9UCfvmlZqdBwuWajsXkowtK68444sXvGC1aEYtk81zIR5zmuKf
 iTz5yUe4v4FKbcWYq3ZH/NANBbanYav4aMXgWD2WE=
X-Received: by 2002:a5d:59a7:0:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-381c7ac45b8mr751163f8f.41.1730397226901; 
 Thu, 31 Oct 2024 10:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES40UoBLU+6JJ0WD69mHj20CbEFopaqUV9YvGd9YhnA2FQMjmCyBSzffKwcqwxc1m4xKXf2Q==
X-Received: by 2002:a5d:59a7:0:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-381c7ac45b8mr751139f8f.41.1730397226464; 
 Thu, 31 Oct 2024 10:53:46 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e51csm2798450f8f.79.2024.10.31.10.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 41/49] target/i386: use + to put flags together
Date: Thu, 31 Oct 2024 18:52:05 +0100
Message-ID: <20241031175214.214455-42-pbonzini@redhat.com>
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

This gives greater opportunity for reassociation on x86 targets,
since addition can use the LEA instruction.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 628d942a161..9aff16b8801 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -55,7 +55,7 @@ static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = lshift((src1 ^ src2 ^ -1) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -84,7 +84,7 @@ static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
     zf = (dst == 0) << 6;
     sf = lshift(dst, 8 - DATA_BITS) & 0x80;
     of = lshift((src1 ^ src2 ^ -1) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
@@ -110,7 +110,7 @@ static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = lshift((src1 ^ src2) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
@@ -141,7 +141,7 @@ static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
     zf = (dst == 0) << 6;
     sf = lshift(dst, 8 - DATA_BITS) & 0x80;
     of = lshift((src1 ^ src2) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
@@ -169,7 +169,7 @@ static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = 0;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -185,7 +185,7 @@ static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK) * CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -201,7 +201,7 @@ static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK - 1) * CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -215,7 +215,7 @@ static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     /* of is defined iff shift count == 1 */
     of = lshift(src1 ^ dst, 12 - DATA_BITS) & CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -234,7 +234,7 @@ static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     /* of is defined iff shift count == 1 */
     of = lshift(src1 ^ dst, 12 - DATA_BITS) & CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 /* NOTE: we compute the flags like the P4. On olders CPUs, only OF and
@@ -250,7 +250,7 @@ static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = cf * CC_O;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static uint32_t glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -263,7 +263,7 @@ static uint32_t glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = 0;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -281,7 +281,7 @@ static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = 0;
-    return cf | pf | af | zf | sf | of;
+    return cf + pf + af + zf + sf + of;
 }
 
 static int glue(compute_c_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
-- 
2.47.0


