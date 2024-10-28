Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B9CD33998
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RX4-0000QZ-0k; Mon, 28 Oct 2024 11:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWy-0008SC-9y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWu-0000s1-IR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+7hpjh8zyx3zlcLNxjdL89izQCWDrDMLuGY9zVgw6o=;
 b=JseBk6tiSfrANck7a8rqxiv+ZS9LfSkXrDjbEL0GLCLJUrJZYX/DjsnPYVtXNDGEXW+Etr
 Yuh3tUYwNnHlzURWgKEt12us4MgVD7AOygbXldZqOpqkDQA9Oowknttauo/8OBMKHNKEZk
 WOFMIBAnOdk4GJOrujehVXYFq5mtGaA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-tKzgR1HOM-WglE8tA8xVrQ-1; Mon, 28 Oct 2024 11:19:38 -0400
X-MC-Unique: tKzgR1HOM-WglE8tA8xVrQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539f067414fso3171525e87.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128777; x=1730733577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+7hpjh8zyx3zlcLNxjdL89izQCWDrDMLuGY9zVgw6o=;
 b=DzDLaY+yPLv2GL1aSaBnWlz9JaZYrkpbVzqWqTszT0sPOZC7ZbI8pyZ8no5dgHl63U
 4vTJG6iBBjkOO2yUd0sOPODY/6ylCE5P2EmVZnAmSDGjQ2rFFLXfLKh/ubE5YhO0Otpi
 VGJ6CH6GRaALKNYWkfmpDbm+2oxhhs816C7gF04gf80+B9SQw2z5gwlqbNvfgnKyyVZk
 icOSQfqt568bbGyZQMS46H8nbmStVi9kibuTtikU4ClMCPe1q2INFqD5ZyOXzNuVf8wS
 2tZbn7oCn+aYiUTaBXnj5RwERxafSEERcjjWzuMp634bX8s9WhEnOsiAFPSMhUYUqR+K
 XF6w==
X-Gm-Message-State: AOJu0YwMCdsa6a8Lu7X5FlIhVWSDoMoYllEWxZBAY6IXDL007VofXQfH
 6Jj++L4VlDiSv7uv1I/iEmnbtmm0rUcWWHNUrMpqCu3ElhSsm9XKhT9isnELwykftaEk8qq/Z99
 H3lcQFTs36/m/Xdn67P1sV25KGBPpjFUN9Ptaz6lGsykUnAnTspYfaEinbFlbHnRY0nouJH4cag
 n7L1Y4UMqUeprFkBNTrFope77OquIGRVkAQboE1dI=
X-Received: by 2002:a05:6512:4022:b0:539:e333:1822 with SMTP id
 2adb3069b0e04-53b348b7dc7mr3866866e87.4.1730128776525; 
 Mon, 28 Oct 2024 08:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt90scYUFvRudPh6eWb+hfE0Xbe8bpn1bFyiED3MEfMXz+HnhK4WNE6kaNpindxo6qdHPNeA==
X-Received: by 2002:a05:6512:4022:b0:539:e333:1822 with SMTP id
 2adb3069b0e04-53b348b7dc7mr3866839e87.4.1730128775987; 
 Mon, 28 Oct 2024 08:19:35 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b56ef06sm143691335e9.30.2024.10.28.08.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 14/14] target/i386: use + to put flags together
Date: Mon, 28 Oct 2024 16:18:51 +0100
Message-ID: <20241028151851.376355-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This gives greater opportunity for reassociation on x86 targets,
since addition can use the LEA instruction.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index f29a6dfb77c..d7672c8840a 100644
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


