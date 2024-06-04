Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79820C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuZ-0002X4-5L; Tue, 04 Jun 2024 02:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuW-0002IZ-BV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuU-0007GH-Lv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XSdwd3ltLaWRrXGvIyrs7D5fgELs79u9sjmvlyV4yk=;
 b=BwzfA+jjWNNfMYmnhR/jri98MIw6vANCKuDKJnUldZGygRurakeX1Q+UKJbotyq2sTvGk3
 P/y3qCKvh1xOB0Kf8j9jk3iKoXHmtTQEADC/H/LPaBUchBc2gzCK+W4yfuqDcEk5LCyTYu
 EEpk5nMQrnVYMpR5sWZnMZt1OTlV28o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Pj8JY8aMNWWvDhxmrDEqdg-1; Tue, 04 Jun 2024 02:44:36 -0400
X-MC-Unique: Pj8JY8aMNWWvDhxmrDEqdg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5234e83c4a6so400978e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483474; x=1718088274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XSdwd3ltLaWRrXGvIyrs7D5fgELs79u9sjmvlyV4yk=;
 b=Nr6PVmxTCod1wVDqdvTSrpzM5eZ661FOStF1Hb+ePipB/U6IcowBwAeN2snstuAfjS
 4KQQv1O6z5jTNlGSGClHGljSICEq2uBPRJx8X91Kcjapk2DBbXjtwI0NtBNeoT3T525O
 F/BBi/Bnm5Dbvz0XVofvc8S8LQiBWtt0eaLLUJknChP5akIx8OqyttdV49azTkVrOoTi
 I0YGMaSx11jx7o5KtcGpD5d9sue4JNiK36fX1htsDZz2UQbajnTEuW2pOMpSdhnKh73o
 6pook2AzfpKmDXMFXOPFWLpWhxnChXCgSHx6E1kmc90kf6RP9v/uYfhLPWyHZgZONVRW
 b3Ng==
X-Gm-Message-State: AOJu0YyQpp4TDqJ76zsZ/MeuWmgj4WHmZaLS1fm/pVtBHbPhFszyuvgG
 Eg3x/ULD5aLbQO6ETARRxBQUEWf2AVXnoYK2TCNLe7eLFcNod0aPIm4yWCtqhvnHk734GrwFiki
 EndnTvK1FmlVXG/OSPxOMmsI/jaEdDv7snLcuWs7ICtGhbhL8974vgemHUa/RvOJyrOPbpJW8o0
 KvFiQ+0Oekv3yw0fNzNwA+NLCyL5on5eC2LOj3
X-Received: by 2002:a05:6512:21c:b0:52b:8610:a7fd with SMTP id
 2adb3069b0e04-52b8980f6a3mr6174274e87.67.1717483474632; 
 Mon, 03 Jun 2024 23:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXN/ZAYlM+kG0rR/iFwbAiu3iLP3zmHqtuA7+i/HH/jijP8KwhEil3WZ9x8QYm+KQD52LvGw==
X-Received: by 2002:a05:6512:21c:b0:52b:8610:a7fd with SMTP id
 2adb3069b0e04-52b8980f6a3mr6174263e87.67.1717483474235; 
 Mon, 03 Jun 2024 23:44:34 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31b9943asm6737965a12.14.2024.06.03.23.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/45] host/i386: assume presence of POPCNT
Date: Tue,  4 Jun 2024 08:43:31 +0200
Message-ID: <20240604064409.957105-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QEMU now requires an x86-64-v2 host, which has the POPCNT instruction.
Use it freely in TCG-generated code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 -
 tcg/i386/tcg-target.h            | 5 ++---
 util/cpuinfo-i386.c              | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 72f6fad61e5..c1e94d75ce1 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -11,7 +11,6 @@
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
-#define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
 #define CPUINFO_AVX1            (1u << 9)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2f67a97e059..ecc69827287 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -111,7 +111,6 @@ typedef enum {
 #endif
 
 #define have_bmi1         (cpuinfo & CPUINFO_BMI1)
-#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
 #define have_avx1         (cpuinfo & CPUINFO_AVX1)
 #define have_avx2         (cpuinfo & CPUINFO_AVX2)
 #define have_movbe        (cpuinfo & CPUINFO_MOVBE)
@@ -143,7 +142,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
+#define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -178,7 +177,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
+#define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 6d474a6259a..8f2694d88f2 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -35,7 +35,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         __cpuid(1, a, b, c, d);
 
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
-        info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
         /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
-- 
2.45.1


