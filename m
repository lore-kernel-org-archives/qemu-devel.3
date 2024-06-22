Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7756C2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3p-0000xX-UM; Sat, 22 Jun 2024 02:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3D-0000LX-9Y
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3B-0006Te-JE
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuxMfRanQpqIe+rAUiRiqqmIxZ2Dd4XmJCnCNtxApfk=;
 b=BDYSLHs9r+oFlTf4GlMReyyFs6j5W/9LzFLjxwYkR2028FBbvg8Nu2L/5jGHa07Dyexdop
 n95cX6VLUGSWa1LiGU03p+HvMf33bZOyGcQQVkCH+uPJMz3aXbl/QIOezUZE7GzWSFfJE0
 C62uaWi3CYfhw7LbiTsw0PbGpH6pKPc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-PwskY0Y6NzymRC1upIwOEw-1; Sat, 22 Jun 2024 02:16:33 -0400
X-MC-Unique: PwskY0Y6NzymRC1upIwOEw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6efe7123e0so74526166b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036992; x=1719641792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuxMfRanQpqIe+rAUiRiqqmIxZ2Dd4XmJCnCNtxApfk=;
 b=n0dfGJ26GWcRpu9WmFhE/URieQtOo0tTfdf49VJx1Z/0baCRfim5tkaWCRNTXUHntn
 6nML6P3GD+g4bm9UUjvytd58RMekSW0jRRjITsLIUrkaAbhXbIuFsZTdHKCIZzIR6scB
 5bfpWKyEV75E0kGYkw580b6YaeK/SNJ1v4JLFzTNxz0r5QjBdjXQplAlfeJNQum+nlGh
 /T8/LiDXV3uBu3olMuLwD7UpJgZFUKy/y+ICVf0oEJFfNgxTEfeKlH2LoLUGqDaHPLgM
 mP2vl5AWQYpi0cj6TSa1Bc/XlXPMao0MEmfL7zhWs0q3AQZT443iL1TNIi84BhNkOf2B
 BMBg==
X-Gm-Message-State: AOJu0Yx/GDpZ8//sxaulgd7iO7FPNe0VPWyB5xMNHmn3VLSFIoJXMFDy
 H/StLtOTG6I+YkeSsCrwF3KKPo1nPqVDByGaVWOt5vpEooQoUw21BVByhJTgOslQ8VwmpmqW4j6
 fUQAZ15ibrUiQNBakrGI2L3ay2ZMNxX/EQRqzl04RsSqQWssz3bI6+DB43kNxcp4hj4iJe9RXmV
 MIpjByOsiFarSOy0DjzUqkbjQJ0CDjXLeaIMaD
X-Received: by 2002:a50:f61b:0:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-57d07e0d028mr7180914a12.5.1719036992037; 
 Fri, 21 Jun 2024 23:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmD4ginLRsyat+Wf9/9wDqhmYSphrZbNJDOv/7X3FJ7Emt5eYAb0Z4dzvC6rFGs2dOio2Qow==
X-Received: by 2002:a50:f61b:0:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-57d07e0d028mr7180902a12.5.1719036991670; 
 Fri, 21 Jun 2024 23:16:31 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3053558esm1864109a12.64.2024.06.21.23.16.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/23] Revert "host/i386: assume presence of POPCNT"
Date: Sat, 22 Jun 2024 08:15:47 +0200
Message-ID: <20240622061558.530543-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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


