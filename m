Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DE4C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPa-0005bj-BW; Fri, 28 Jun 2024 13:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPM-0005YP-PE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPK-0002AA-1l
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MD4v48+cGAfMcTScuUpWWBLZnAAnBazGHTddcBuIHp4=;
 b=PUXUyxlr15vCv4YGHHp+vTbGoJyHTAFOIf/95leXqWjbJ/xhwqvjywngZy2zqERnEM6Hol
 y+9jToFA+/jrMGU4s/AsrvaRRGElEkOA3TRh/w4MKusMUcCiar/vsH5V9Bif5e1YngH23X
 PghnYUOkE7Qup5ojoe/d+9hKtHyL/Xs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-W8-THCXMMrefXPZem4Po2w-1; Fri, 28 Jun 2024 13:29:07 -0400
X-MC-Unique: W8-THCXMMrefXPZem4Po2w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6fcb1a708dso62233866b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595746; x=1720200546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MD4v48+cGAfMcTScuUpWWBLZnAAnBazGHTddcBuIHp4=;
 b=OmBKGc181G+miECDQ8baDyyTsfkDAeTDyDFTzKLcS355PPgsZ0QH7L6A9f68H7O3KX
 Yp8pno6U3Seqw39S2/kOWyohBebA4eUrobFvziYFWkzz65eE0YIxBMWjK0nT9eNXZKEi
 A5T5xiuOMLg3m3U2q2DYROjepnOHeR/Jx/76vj/ZC9mIn4L9Qtad+MzHSOvsmMPpjUCs
 aq8pzXrQ0lBVX5sXsVfqZseFQFmCt8RiC7QExERO9rHaPI8zfe2JkmWLxu1DrYVYSFS6
 93abXY9oa/WziUbfqz9GvX6k83p0lFswsk/nU54QG9mgQTsPlD2IPfIIuqQNyFUi9iVF
 ASMg==
X-Gm-Message-State: AOJu0Yxq4lrVflVzhljU/QmSYf2Tpc6CP0jn2K/7Fq+NA6ZT0V84u+bB
 yVFGg24Fo+o3z35BeGihy7wDKFzoj0VdO9+Clk3vwfl7g3hxt2nF9kCBGrVcd07GTXJdE/S2RUA
 a87t9jShWqdODKN8T/IhiB3r6UqWrVmuO2x1zTrZuIACDqkCCck7QpD0bt6f4Nh09ff2milU7CM
 z1Tfa0wioawoF61lpTIf/2bqifSC5IZE+ipHXd
X-Received: by 2002:a17:907:7ea7:b0:a72:b26c:7792 with SMTP id
 a640c23a62f3a-a72b26c7ad7mr164103266b.69.1719595746111; 
 Fri, 28 Jun 2024 10:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfDt3QXBwhhq033fU35UAhfYzNDixvdgyl/YjMCQW3QJzE9iCWoHn5zXkCdqYLDdhB7Xwckg==
X-Received: by 2002:a17:907:7ea7:b0:a72:b26c:7792 with SMTP id
 a640c23a62f3a-a72b26c7ad7mr164101666b.69.1719595745650; 
 Fri, 28 Jun 2024 10:29:05 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b56e6sm95311966b.202.2024.06.28.10.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] Revert "host/i386: assume presence of SSE2"
Date: Fri, 28 Jun 2024 19:28:36 +0200
Message-ID: <20240628172855.1147598-5-pbonzini@redhat.com>
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

This reverts commit b18236897ca15c3db1506d8edb9a191dfe51429c.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h          | 1 +
 util/cpuinfo-i386.c                       | 1 +
 host/include/i386/host/bufferiszero.c.inc | 5 +++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 72f6fad61e5..81771733eaa 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -14,6 +14,7 @@
 #define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
+#define CPUINFO_SSE2            (1u << 7)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ca74ef04f54..90f92a42dc8 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,6 +34,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
+        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
diff --git a/host/include/i386/host/bufferiszero.c.inc b/host/include/i386/host/bufferiszero.c.inc
index 3b9605d806f..74ae98580f6 100644
--- a/host/include/i386/host/bufferiszero.c.inc
+++ b/host/include/i386/host/bufferiszero.c.inc
@@ -110,13 +110,14 @@ static biz_accel_fn const accel_table[] = {
 
 static unsigned best_accel(void)
 {
-#ifdef CONFIG_AVX2_OPT
     unsigned info = cpuinfo_init();
+
+#ifdef CONFIG_AVX2_OPT
     if (info & CPUINFO_AVX2) {
         return 2;
     }
 #endif
-    return 1;
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
 #else
-- 
2.45.2


