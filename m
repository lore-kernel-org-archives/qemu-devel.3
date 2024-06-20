Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0420C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRZ-0001Qv-6E; Thu, 20 Jun 2024 09:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRX-0001QX-HU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRV-0006Wo-Ot
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuxMfRanQpqIe+rAUiRiqqmIxZ2Dd4XmJCnCNtxApfk=;
 b=MhXLm+7FghTej6orLIU9LVeDVkqiL/YNeBda0c/mIlrUPBxxnKhtJyTBA5fSoFMu0+VP+0
 sctyiZaiMZ3P3p9wTjQ8ZbxdjnzhjToWGHeuxxwalW553jQ/X/TV603lyY7J7PULCrQ35D
 bBZZ9FG+EHWt5aPmDRx3AOlHwLLGoKQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-FBHZiCqUPp2fdx3FT8e4yg-1; Thu, 20 Jun 2024 09:03:03 -0400
X-MC-Unique: FBHZiCqUPp2fdx3FT8e4yg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57cdc3f0410so458793a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888581; x=1719493381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuxMfRanQpqIe+rAUiRiqqmIxZ2Dd4XmJCnCNtxApfk=;
 b=LSj/bR9I7E3MTPRi2vLF7ihxBCGJ1O5NtQreIdtTzPpCFw/APwvigiL8LVRM+GbzDi
 9ZVBscPA06d/5TzdcFEi5xndhG42PKQmeDY12XraGZmkv6Sk3XJRPqBh36V4BeR2RFpB
 hnvLqhCVZjaVx9WDPjyBOnXzmbUp5/5ZOA+AtGxf6jc3n2DnhC3WPinElFrBaH26ztiM
 N3eR3AR1W8KWq4J0ReuulS35o1Kj9b67iXVEp206mSXJDLMd1s0qfiZn7aZTROLrmWJW
 FXdC6ZUiaQ23jMAu2/S50Zsn+q4cEq+eY1xxZWURYl1Ifth3+jvRwUH3ROL6nhuAN5Xe
 8W0A==
X-Gm-Message-State: AOJu0Yyo85HJI0tIGcUUmi5mhwivTcLH1GtlRD8J/nHD4iGtGyxhzdf9
 6RbbRUhK9ji3X6LVq7CMPGMC5nnskmpJEDyGPwlFNYO9Axn4S0XjyeEwm0V4H2G1IgF5fAyMG5D
 hLvywkQ922Fk8dq9YoIgvMYTdBNiIg1Mh0XMCZ1xqLJAtEsp4LbogU13Np3KiPQ1h4G1k+0ABXN
 uYd7DzqrzvUio8xiGPlBTQ17Om5fu+XfXuIKNm
X-Received: by 2002:a50:d707:0:b0:57c:5fca:ab25 with SMTP id
 4fb4d7f45d1cf-57d07e84bf2mr3389304a12.25.1718888581680; 
 Thu, 20 Jun 2024 06:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr6TmoysP21cnHNMxklPhbR8DW1eELX2UPuk1Q/bseUyUSNPxkRMEAAsVIYq+a7NaLoUE5Mg==
X-Received: by 2002:a50:d707:0:b0:57c:5fca:ab25 with SMTP id
 4fb4d7f45d1cf-57d07e84bf2mr3389285a12.25.1718888581227; 
 Thu, 20 Jun 2024 06:03:01 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d21df986esm860455a12.72.2024.06.20.06.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:03:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 1/6] Revert "host/i386: assume presence of POPCNT"
Date: Thu, 20 Jun 2024 15:02:49 +0200
Message-ID: <20240620130254.415699-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620130254.415699-1-pbonzini@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


