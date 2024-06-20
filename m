Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99686C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRa-0001SC-Im; Thu, 20 Jun 2024 09:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRY-0001Qw-Rj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRX-0006X0-3F
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlW/705FWiMprOSUKjNiwJlL+EDmg1xNJ9taeoREqJs=;
 b=MXuYIQWEQuEnk5pGiVj4dSs0n9GIXvWfAaMncDZXx8HdQnLqLhw+4gQqMXdGPQb1gynK/M
 ITYvIIWvpfxJGRn8wzxWIUuvPFn7kVenMPPK9vrr8L9zc1h3GXZfdq5hGu7sNc6Zh8P9Ij
 mUkZCJnLd7pP40HxkUaEf9dlt1uHqVM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-oVZwD-QpPWWS4cUbJ3Jheg-1; Thu, 20 Jun 2024 09:03:09 -0400
X-MC-Unique: oVZwD-QpPWWS4cUbJ3Jheg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57cad6e94e5so378407a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888587; x=1719493387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GlW/705FWiMprOSUKjNiwJlL+EDmg1xNJ9taeoREqJs=;
 b=adKpWgdLFATOnJMaJBI8BODrY1I9tWFGX+Z91BbHPvgmVx0Kv7EH7/OV4EGVuXH1Va
 8O1JamVjqmehQMHNJJda+sSNVZIErTR1hacnnQDacAGe/3CiLVYC/u6QNWi6zQ9o2AS3
 dICpLu+lSqTTgsqqkATg+rcCA/xl5f3xqHk30lRHGPABfZ3G9RzyQVguh0uhCQhCiZt/
 TdWMcVlM24yOUG67Ch/IyIhSQoOGcUoAeZ1JVoz/7KvylCySmnwqW8mcWc2deYicKAxH
 YLJehDkA6mb+hD8lKmbWVMKXSAHlVzGBeq+xbRhqSdhg+en6G3EWynhCIcQsTiSurX/P
 thYg==
X-Gm-Message-State: AOJu0Yw6+ny+/H6yRwSL9RLwz0PCf6mxM/fYlReqy1FZukyy/bKs2Jsz
 mHhkZ8cxKY7w5SgUg0Kvf2okB7YCPbv/HXw+SzBStrQQWXWc4uPN50DpyK0VcpezLzi6TIRezY4
 65vgiWuIdFloXQUhknIptQmhBiij8DhZNFBhKfvtdb5S/CmqLMkSgxBRoN0JcWbm1uzPvwnQq2g
 kXPVLnMn51x+e71BJmbMHGawiYITB2CRLC5a2S
X-Received: by 2002:a50:d504:0:b0:57c:6861:d72b with SMTP id
 4fb4d7f45d1cf-57d272db7a2mr437978a12.9.1718888587115; 
 Thu, 20 Jun 2024 06:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR4aHAZ6xt/O21ytBNlhtOAmUXMvL4bQH78obqORQ5BeT0L4sxIm03+Svx1Ww1wtCwUHFd3w==
X-Received: by 2002:a50:d504:0:b0:57c:6861:d72b with SMTP id
 4fb4d7f45d1cf-57d272db7a2mr437956a12.9.1718888586636; 
 Thu, 20 Jun 2024 06:03:06 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb743ade6sm9648218a12.95.2024.06.20.06.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:03:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 3/6] Revert "host/i386: assume presence of SSE2"
Date: Thu, 20 Jun 2024 15:02:51 +0200
Message-ID: <20240620130254.415699-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620130254.415699-1-pbonzini@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This reverts commit b18236897ca15c3db1506d8edb9a191dfe51429c.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 +
 util/bufferiszero.c              | 4 ++--
 util/cpuinfo-i386.c              | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 11c080e02cf..74864f7b782 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -188,14 +188,14 @@ static biz_accel_fn const accel_table[] = {
 
 static unsigned best_accel(void)
 {
-#ifdef CONFIG_AVX2_OPT
     unsigned info = cpuinfo_init();
 
+#ifdef CONFIG_AVX2_OPT
     if (info & CPUINFO_AVX2) {
         return 2;
     }
 #endif
-    return 1;
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
 #elif defined(__aarch64__) && defined(__ARM_NEON)
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
-- 
2.45.2


