Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FC8CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKq-0005k4-3a; Sat, 13 Sep 2025 04:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKl-0005hm-HD
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKh-0004pL-DU
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7929tqjr/p/MqUXWGl/GVOXgHyxRWujXMrtUmPUHm9Y=;
 b=fZvjJ8/97h+TjBRLzq9z+4hXoA7A2vhGPFr/detYv18pEb5YoOXlWkHuS8u8xiS2aqL/SH
 FaJXMvLBF0ai/43njZea2jlyoaf+ZJ57CwFKyfTDiphAmfVV+wOsnpkDMF+gtpTGHXfoz9
 7Tyn2sGDIQXZfBT6dNWEFp2g3NXz/PI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-qFZcaQ7HPeOADbzdICpxMg-1; Sat, 13 Sep 2025 04:10:04 -0400
X-MC-Unique: qFZcaQ7HPeOADbzdICpxMg-1
X-Mimecast-MFC-AGG-ID: qFZcaQ7HPeOADbzdICpxMg_1757751003
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45ddbdb92dfso16735085e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751002; x=1758355802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7929tqjr/p/MqUXWGl/GVOXgHyxRWujXMrtUmPUHm9Y=;
 b=kFi/m7qyi6vqdEEEqZk4fZWBHy7vGLEjcqLj5oSl0sCAQjGgwFhlu2h8t2AT+Q6E/F
 XVV34q6OM0fVl4o+NNJ42qlSG78HY7FvoKyy4mrCAgkugd5XVUK8wyiM6mjLrwmKKQh0
 FbdAwySJCwGDkb9FqAw/Pv/W2UWTLMaVg7foK9KBGVHzTentOJdrUrlBeHPJ4wste2kO
 yiaPIXbM6mnbtIHau9JaFCTilSSEyG44GSS4rWzyfW3T6a2guUs8TidGqYTObEc+75tO
 M7M2HQ2PCsNxUlSXqRASK8vxQKaqmGq6WvEhQuUunFYKtQaM/1Zaw9Vy1Uu/liB7FGAN
 zzIQ==
X-Gm-Message-State: AOJu0Yx/DgK/xt2z1tTT/ow7xHnlvW1D49MdmzVRf2gg+qQbIOnV2+LK
 gJXQwzAbXi/5XqSvxrPvfTz4Z/DqqxK3HqWnLyhyHfrjFaYKwhvxW2QVKJtrbKzql1DfO420Z1L
 aSNG+zIZ3lCmKXhoerlxy29BmjBFOZCFIFQ/WhIxIJDgF5djbSE/v7IpHmXH0W4M2NEcOe+SthT
 K9i8ShVsPtis6O+bPoFhpqaf+wh4maqh9z6kxHo7Qa
X-Gm-Gg: ASbGnctzLANLn1Rcs/PM9SgOhEKMG0eH67do2rUsKF1bJ4dQjPhgGKEX/8LxmZQ8bHu
 dy+ROdoZHIW5YEciAsMZ2QIOGmJ7M43ismX09OlRFXm6lX6PdnKpyM8JNq9blTjAPR+UJSU2UAi
 6Apb63SEtRz0feiQRZClkLM4O1ES3I6w0aUeKIKlOIJ2F1PDLryrN0oZTVnj4Ng0NvB6L3UBdRc
 MfqCjJcPyBxPKQ1zXTntKCFEX/W0zmQatDyvaZtU6UTnMUF1yPGAY3jCTRBJ3h5vKKElfEkqqY4
 JU393JhUozYHvE0Rv6tla+ddYcG65BA44xhCYNCWy+laK167GU+mDVA4fvdIGZr/BZFtL5mH1VP
 dv4u+4AeKJcV7+QwBjwk7fPhlRMaTb3tkf5P2e4j9Tsg=
X-Received: by 2002:a05:600c:6054:b0:45d:f804:bcda with SMTP id
 5b1f17b1804b1-45f211d56b8mr39264345e9.13.1757751001765; 
 Sat, 13 Sep 2025 01:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9RQPXY2+9FoRIOnL3dI6e84Tax1DTLQ1mH23EltvdS3DwCga2OSFo3bgGI5JmGAmgV8bYiw==
X-Received: by 2002:a05:600c:6054:b0:45d:f804:bcda with SMTP id
 5b1f17b1804b1-45f211d56b8mr39264185e9.13.1757751001339; 
 Sat, 13 Sep 2025 01:10:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e03718eb1sm89569675e9.4.2025.09.13.01.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/61] cpu-common: use atomic access for interrupt_request
Date: Sat, 13 Sep 2025 10:08:48 +0200
Message-ID: <20250913080943.11710-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Writes to interrupt_request used non-atomic accesses, but there are a
few cases where the access was not protected by the BQL.  Now that
there is a full set of helpers, it's easier to guarantee that
interrupt_request accesses are fully atomic, so just drop the
requirement instead of fixing them.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/core/cpu-common.c  | 12 +-----------
 system/cpus.c         |  3 +--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b01a0cffd64..23bd02277f4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -495,7 +495,6 @@ struct CPUState {
     bool exit_request;
     int exclusive_context_count;
     uint32_t cflags_next_tb;
-    /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
     int64_t icount_budget;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 259cf2a3c36..152abc9024b 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -67,19 +67,9 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !bql_locked();
-
-    if (need_lock) {
-        bql_lock();
-    }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        bql_unlock();
-    }
+    qatomic_and(&cpu->interrupt_request, ~mask);
 }
 
 void cpu_exit(CPUState *cpu)
diff --git a/system/cpus.c b/system/cpus.c
index 437848b5eb4..9bfbe2b0607 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -257,8 +257,7 @@ int64_t cpus_get_elapsed_ticks(void)
 void cpu_set_interrupt(CPUState *cpu, int mask)
 {
     /* Pairs with cpu_test_interrupt(). */
-    qatomic_store_release(&cpu->interrupt_request,
-        cpu->interrupt_request | mask);
+    qatomic_or(&cpu->interrupt_request, mask);
 }
 
 void generic_handle_interrupt(CPUState *cpu, int mask)
-- 
2.51.0


