Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185BBC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuP-0001yF-8v; Tue, 04 Jun 2024 02:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuN-0001xX-Ea
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuM-0007Fl-0K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnre2UF7/f5unB3VrXj0N5RhP/b8i4wPnG8jXCu2p4Y=;
 b=AW64SsAgfvD3RkLNSxu9ET1rq2xamIP5Fl+kSlLQwgnm1O937V+4A4qQsWRqVrPCJUklQA
 HpkPxjPjcZPCgIuQz4zviYlZUNvHdsEau56LKyOwVJivFHwktq+PTZCli+YO3JR8vsRng5
 oAcbop8j7lki3v9zf9yPPzXT+AWcuAI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Vw_6IhouPZ66uwKiy1hPzg-1; Tue, 04 Jun 2024 02:44:30 -0400
X-MC-Unique: Vw_6IhouPZ66uwKiy1hPzg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68f654dc69so107864566b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483469; x=1718088269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnre2UF7/f5unB3VrXj0N5RhP/b8i4wPnG8jXCu2p4Y=;
 b=UE9g4/xGbt063dIpT2jW/laDComxRRrxi2eEC7SSll864Xr3SsjtTpNxBB2BmJSPKl
 tvx6ifkRGTC2pusPYfunmvtuL+IwPgaslUr3hTuAvfrU/E/QWttOl5ICXntFHbHCpJ1p
 B+nWXKfxgAUORMhBhVpy0eLcu2hGzbT17Bsv6TN5eV/AvPaaeXyF9H7PDTHIP2W1hfGy
 60DEvLesPbC2wpRcKOYVjkoSEpJo+F8kL+2MP3RyOq4NOqkfhZurT5f+lxvzhHkDC1jR
 9OWk6ymrSERuPJGiWmB5dBKE2aRgwpZC3xpezqbFxMdJqO+0UCf7ncoa7L6Wz5j+edlM
 Mdiw==
X-Gm-Message-State: AOJu0Yx5CvkVYg8rcRbaFHb7A8IPbhA2/2M5vNxRmyNFmOBSJgmuQa42
 JWwhGuM+HtBLA+AL0zoc/t2rSZBDeeUdsZGnDGFKGlDfnpUv9S4+d0uPV3jNEE/btwFwCT+vYb/
 4IX81Na3k1v1/9EHrNVzrBe4ZktK0/2yGswngFw+9dmYm8b7hYUA/QAooR6wUyp+CxFwqhP/3qA
 ba8HhMYfJ9AqAvDBo9j/UQm8S79IpKUMAsI5Hh
X-Received: by 2002:a17:907:940b:b0:a69:2bce:e41e with SMTP id
 a640c23a62f3a-a692bcee4bemr282320466b.9.1717483468929; 
 Mon, 03 Jun 2024 23:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw9YQl6f71DA6i9PendEh30fTQFobGQh5qPn6O5dlLLub2Q9COeoYRVKF2PJC1BZkNCizNFw==
X-Received: by 2002:a17:907:940b:b0:a69:2bce:e41e with SMTP id
 a640c23a62f3a-a692bcee4bemr282319766b.9.1717483468608; 
 Mon, 03 Jun 2024 23:44:28 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691122859esm233259166b.224.2024.06.03.23.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/45] host/i386: assume presence of SSE2
Date: Tue,  4 Jun 2024 08:43:29 +0200
Message-ID: <20240604064409.957105-6-pbonzini@redhat.com>
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

QEMU now requires an x86-64-v2 host, which has SSE2.
Use it freely in buffer_is_zero.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 -
 util/bufferiszero.c              | 4 ++--
 util/cpuinfo-i386.c              | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 81771733eaa..72f6fad61e5 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -14,7 +14,6 @@
 #define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
-#define CPUINFO_SSE2            (1u << 7)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 74864f7b782..11c080e02cf 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -188,14 +188,14 @@ static biz_accel_fn const accel_table[] = {
 
 static unsigned best_accel(void)
 {
+#ifdef CONFIG_AVX2_OPT
     unsigned info = cpuinfo_init();
 
-#ifdef CONFIG_AVX2_OPT
     if (info & CPUINFO_AVX2) {
         return 2;
     }
 #endif
-    return info & CPUINFO_SSE2 ? 1 : 0;
+    return 1;
 }
 
 #elif defined(__aarch64__) && defined(__ARM_NEON)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 90f92a42dc8..ca74ef04f54 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,7 +34,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
-        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.45.1


