Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15255C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFp-00051O-B8; Tue, 06 May 2025 11:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFV-0004OE-MJ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFP-0002Dk-Ho
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1M5y0gUrNjDXJKwCPDO2X1un+fT/kp38fxTLgBPqHI=;
 b=PwGeQ7n7ygea/ieObBhiG6brhQ7booDWiPOULHGc8eKX2nVxzFfkiJP2K33TsxgpRr/kNu
 RxPVO//jc+vUPsyHF0uhfHmi/b0+VL99dbSM+rGCKxjJgX/HBlBZUvsjLQw0y60HwBnq9H
 /Z134jG+bwZScSIc8bmMl7yZADXVBao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-yMDUP_EhP5qNJuucw-zhtg-1; Tue, 06 May 2025 11:30:16 -0400
X-MC-Unique: yMDUP_EhP5qNJuucw-zhtg-1
X-Mimecast-MFC-AGG-ID: yMDUP_EhP5qNJuucw-zhtg_1746545415
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so42977325e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545413; x=1747150213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1M5y0gUrNjDXJKwCPDO2X1un+fT/kp38fxTLgBPqHI=;
 b=MV8YCrqGbVj/LKUsBk3VeACd/I8HD9Dt9lV1NdzGwu+ZAi8GXEC5BGc7Awptw8BlUh
 +m/rnvz1JbSs67S1CDExAMqGfr+oiUJVysRrvPDuiHYtq0aKDI6YNlVdIL0AH1hpfg2H
 nFK9EWjokKgek7URi2haXYftWseWS86Vh10KlNu8n00TP6Mtg2yAdxfh1tgZNEoynXYN
 Q25IQcJOP4n8Yb2YO61MW3ZPb55PkDHFUrUBlSFboKzXRaFHji79kxq4ubFClF6ekTT0
 bn9apO6+KxIcWb9ajaALarRWRrnFtAFukIJylwev/lcVnZq3SXg0apQnXvK8j5Kl4Jv3
 KkoQ==
X-Gm-Message-State: AOJu0Ywvmb6Fn2aEpvO4O/oJlKFS9wViEdwB4lbdWTLuBhd5liCXV0Hq
 BSYWjqN7yR93SGqnoggFnG9knd9SCK8yaMCb49RyHIIvtzcfeD1vWJjMsGm3znAX7n6Uj5Rf1L3
 3lBw8ODe+iyk2r1kRoEAutqMQFB86BrP3Qsa9prhol3w1DCTCJBi8Ui37sZa/Mw1j6Sw38Jk9MQ
 wV6p6krWM2wWG8Kru/MOVD9eJyz+3dQCMK8Iej
X-Gm-Gg: ASbGnctFMP1yXSFS3uXN66i2OgHBoVOuTwb5OX+xrbccP78DRwc2oyiLXcoDRnj7+K0
 4I+mxaoi9D97kof7YOEGMMfWDN0QOPpde0oeu9RaUe8xzhmpz4cWjs92gjhvoBqG+UBLQs+Iwnp
 8tVnIL5Y0EN/u2av2CEgOpYe4RV6U30TOcOmlVoX6mgyTfnih/rj9JE8w3/WngMtyuoHwPxeRvP
 xEryXT9IhWruIzOYqX27MyqLmH+HQxdn4Vz7ZIhXOzjH3K907FQwNZSKa8by8PjHqTkQmx17so+
 +bHTwo06QUScxsk=
X-Received: by 2002:a05:6000:4212:b0:3a0:99de:5309 with SMTP id
 ffacd0b85a97d-3a0ac0da1d4mr2583430f8f.18.1746545413178; 
 Tue, 06 May 2025 08:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHevWwmZb3Abstfyr7YVCjhrocmMBV+7NbPMLFnsMbXELang0WhbaERjn0qaDO1ErFQJelDQg==
X-Received: by 2002:a05:6000:4212:b0:3a0:99de:5309 with SMTP id
 ffacd0b85a97d-3a0ac0da1d4mr2583407f8f.18.1746545412825; 
 Tue, 06 May 2025 08:30:12 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae32fesm13810307f8f.22.2025.05.06.08.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/30] util/cacheflush.c: Update cache flushing mechanism for
 Emscripten
Date: Tue,  6 May 2025 17:29:16 +0200
Message-ID: <20250506152927.222671-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Although __builtin___clear_cache is used to flush the instruction cache for
a specified memory region, this operation doesn't apply to wasm, as its
memory isn't executable. Moreover, Emscripten does not support this builtin
and fails to compile it with the following error.

> fatal error: error in backend: llvm.clear_cache is not supported on wasm

To resolve this, this commit removes the call to __builtin___clear_cache for
Emscripten build.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/2926a798fa52a3a5b11c3df4edd1643d2b7cdcb9.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/cacheflush.h | 7 +++++++
 util/cacheflush.c         | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index ae20bcda733..76eb55d818d 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -26,6 +26,13 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
     /* icache is coherent and does not require flushing. */
 }
 
+#elif defined(EMSCRIPTEN)
+
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
+{
+    /* Wasm doesn't have executable region of memory. */
+}
+
 #else
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 1d12899a392..17c58918de6 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -229,6 +229,10 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
+#elif defined(EMSCRIPTEN)
+
+/* Wasm doesn't have executable region of memory. */
+
 #elif defined(__aarch64__) && !defined(CONFIG_WIN32)
 /*
  * For Windows, we use generic implementation of flush_idcache_range, that
-- 
2.49.0


