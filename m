Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FEED3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG9-0003ak-BW; Sun, 20 Oct 2024 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YG4-0003WK-W0
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YG3-0005Rx-DK
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgy24lMTqIuST3Sc0fNBO9jDVweqRdB371hlg23DEdk=;
 b=L6PG0JdjewsKbelzSC57PrhsXW5ktbKXhahZr3brPwGcDDAPbI91wttTMyCifE40ERzbpY
 KSsp7cVrEWNEg9FPQLxCJmhCdDCIGJbdTUV1dvQKIrL4oh6yl9TOWo23w65KcYdHh8CJfF
 k2UkdZJmoMRb+w3hIVFR3Ag2R/WxK1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-VVLuOD8cMviCcYffaAgorA-1; Sun, 20 Oct 2024 11:54:16 -0400
X-MC-Unique: VVLuOD8cMviCcYffaAgorA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159c07193so31855705e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439654; x=1730044454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgy24lMTqIuST3Sc0fNBO9jDVweqRdB371hlg23DEdk=;
 b=JWT7iHxhtr8YacmghV698ny0myzzL1j29fUWRw2WXJR5TS5R08OTn/hakQqPPVqa8h
 eUYAhvuGq257G7SCuBLt8csocgXvTTIlBULLksSdT/lbHubilivBPJXkO/ETCxZhk3au
 dRMs4W3G6pJI3KUoSwQqBicUgEZb6+u0d9XzWclU6fU6aRPkiDP9KILrpFEXis/g0VaY
 93B9zxwkWzZNDQ5IOMEmCJIpFZlKKyXnafQObacXXWIE4wML5BLwSsjFw2ktCJGMssoM
 uVcBHBV7Jvs/b0bT7sg4HPPqXkjWzFyshwoExlCQTqATvah/VYbbXEDBB6TYA2kHtoBm
 laZA==
X-Gm-Message-State: AOJu0YwPHeRXHXYDo7a9S2BoNKj6m9p1lpVyfZNnkuhDHf4BEED27pWC
 jUX3PkUFg7aE8OnW4oFMhScdBSFRmCIovpbSz3D72Ktf8SdnU1zp4TVHHOfeyQoWv5RFHAawNIa
 vpQHeY/QLYwboI1QG+Z7SgHgIJOxbQUPlblk31ApNU7c+yXj3pvZvfynUVVkLS4H4Sbdl3lFlkA
 39bqjhCorzkFZhy/sXm1N7tKfp52rSuT6HFcaCr8c=
X-Received: by 2002:a05:600c:46d0:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-43161690021mr94518785e9.32.1729439654309; 
 Sun, 20 Oct 2024 08:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvefVFJ3Q1FwgHOfn9xAGGFkYAtcs2zju6QUDw7KAKg5bI6p+qkP+SSoIQ21J0nfziyxpn8w==
X-Received: by 2002:a05:600c:46d0:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-43161690021mr94518545e9.32.1729439653943; 
 Sun, 20 Oct 2024 08:54:13 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58f1fdsm27217705e9.28.2024.10.20.08.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:54:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 14/14] target/i386: use + to put flags together
Date: Sun, 20 Oct 2024 17:53:24 +0200
Message-ID: <20241020155324.35273-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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
2.46.2


