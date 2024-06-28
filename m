Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D950C3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPY-0005a3-DU; Fri, 28 Jun 2024 13:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPM-0005YO-P0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPI-00029Z-In
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuxMfRanQpqIe+rAUiRiqqmIxZ2Dd4XmJCnCNtxApfk=;
 b=UIrZvsRWY+wmDspw9eyZP3FivYOihlTmPukyZ08djCKAjnmIQJHbvSJ1T0g9f/A//imxtM
 etHNqp9We2V54H/o0FcvRBV4bECINzkzzNvFmDAfZ+4qyokXYUXZNSHtrSe6qaAG/1e6El
 UZVAK3q6wmnEuo6wtZrmtuoZRk8pMrc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-PvG9ViSXOXyMdoi4TXDp7A-1; Fri, 28 Jun 2024 13:29:04 -0400
X-MC-Unique: PvG9ViSXOXyMdoi4TXDp7A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a729da8fbf1so242389366b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595743; x=1720200543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuxMfRanQpqIe+rAUiRiqqmIxZ2Dd4XmJCnCNtxApfk=;
 b=s4olnSMGNNSwfqFytZWmilFAVsjacqCnXnechVreRO5MD0mqyBtNGiF3IGwejVKzOc
 lXaZy8uRGp2X32jlD9hlWFd9C8hATbTP2rQ8teqT3RWGPD3Hdy8RUtA8jYitU8fLBtWu
 NGtGwa/J8gHEO0I1DD/ZzHARHpb9U/BPNfqb5x8Y9q/YkTq2Oiw1714MmF0qeSMAK8Mo
 TGuuyiZTTv7h8H5/9EAOaTnTn5GjbLwEPCAGv+qryi8aIjJeGyBY/CArreG8vYIQr1j3
 fq4acHmJyBb4pDDmnHT8M4G+G1GjeOnYKbBJ58qkpJBehRdfOJSmv1R6hPz7d46Zt9rb
 51gg==
X-Gm-Message-State: AOJu0Yzx7tWf2DCnrARZ327obcFfQVny92TFiTVFlYENOxqL4O6xBzDT
 BvOlLlaaVJ26Ecf1AOgz62Yk0MVSfouYkfDEdAq0ISqihuBD5ZGJb5JMi9ARojNqyDm6HGM4/Np
 7toawcIXLocr8dn14ntANMGvRs64OtBuGzR6Jvn1TTDHWZJ2mhWPw0dVBp8qbQ7QGW3y4BwkaAn
 MjNBOLP9fACi9MjivMV7Y/mtXJTf+1i2b2X1e5
X-Received: by 2002:a17:906:1dc7:b0:a72:9077:7172 with SMTP id
 a640c23a62f3a-a72aeeb156amr156617466b.19.1719595743011; 
 Fri, 28 Jun 2024 10:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqpab9z0zqzegpxovk0mznubm8DA4sMAf4arQpkxJ++AIDETRQpl705KbctmZ6U0/i/s5hg==
X-Received: by 2002:a17:906:1dc7:b0:a72:9077:7172 with SMTP id
 a640c23a62f3a-a72aeeb156amr156616566b.19.1719595742617; 
 Fri, 28 Jun 2024 10:29:02 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b889dsm96555866b.225.2024.06.28.10.29.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] Revert "host/i386: assume presence of POPCNT"
Date: Fri, 28 Jun 2024 19:28:34 +0200
Message-ID: <20240628172855.1147598-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

This reverts commit 45ccdbcb24baf99667997fac5cf60318e5e7db51.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 +
 tcg/i386/tcg-target.h            | 5 +++--
 util/cpuinfo-i386.c              | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index c1e94d75ce1..72f6fad61e5 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -11,6 +11,7 @@
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
+#define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
 #define CPUINFO_AVX1            (1u << 9)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index ecc69827287..2f67a97e059 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -111,6 +111,7 @@ typedef enum {
 #endif
 
 #define have_bmi1         (cpuinfo & CPUINFO_BMI1)
+#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
 #define have_avx1         (cpuinfo & CPUINFO_AVX1)
 #define have_avx2         (cpuinfo & CPUINFO_AVX2)
 #define have_movbe        (cpuinfo & CPUINFO_MOVBE)
@@ -142,7 +143,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        1
+#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -177,7 +178,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        1
+#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 8f2694d88f2..6d474a6259a 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -35,6 +35,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         __cpuid(1, a, b, c, d);
 
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
+        info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
         /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
-- 
2.45.2


