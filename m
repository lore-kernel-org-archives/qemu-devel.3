Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8EC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHH7-0002eT-LZ; Mon, 14 Jul 2025 07:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzT-0000me-9X
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzR-0001c0-9q
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHd6YlxT7SR0dUhCUOeeHWrJJQghHVPSqPxhxBe2H6I=;
 b=ST80E8NOwoiQ68VrMR4nYa7nQlYikDWTs/40BTs9gy+pHRogdgq+T8EnLpu6LSPd3UH1Cn
 If0Gy837kPuPtIvfMVoa6oa4KOwdQXyW6CWPdxi3CMarO5EmrqB8vvDAQB2oz3zz/7z41Y
 TH/JYKn+/U60oBkQHaA0kuMUYv5t2uM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-jYku1juNPOy5jk3J9Rh4Jg-1; Mon, 14 Jul 2025 07:04:54 -0400
X-MC-Unique: jYku1juNPOy5jk3J9Rh4Jg-1
X-Mimecast-MFC-AGG-ID: jYku1juNPOy5jk3J9Rh4Jg_1752491093
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455e9daab1cso4838865e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491092; x=1753095892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHd6YlxT7SR0dUhCUOeeHWrJJQghHVPSqPxhxBe2H6I=;
 b=HrCFjRyO4hnEt48MAnrgoxQ8di0BMac9pIfiYmWPSceLbFH3Eot3+c30Sk3vHZkt9n
 HuSWft3cbt6kg8Tekey20dW1YE/qw7EtG0/+RkHdEFW15C08FKN1NH0yajS1qsWW5ZpW
 /wD5Z4KRjqGUOltIS5rOaWrjU2Z2WqxG9QFNxC+Tm5CRAywvaBQ+XNYO8nMhd2deJVBN
 VWoKTfUbapnkY2kvXLnCTbup0OdiLP3lCi5RXCx8oT+Sg+tBa1w3aFmgf2R5oDwSQSxS
 IJHKEc01vvzxigqmuoNEueP8IP+2PJ4UsgAzpqMfMY6i+Us6DVfxcdB46FxUad2jevL7
 m7oA==
X-Gm-Message-State: AOJu0Yxiaw8AM2clBw4zCFRv/CTQpMCcE/0u+sq/z/gjRoO33nod0mZC
 Ypaq1Y3yAQlii3DNyDn6v+CG/Cb9NtxcBsixxTW3l7XjJLneNTFjSfJsl3agDitebd490rduuWB
 4DDGep0VrSTmETttjhLphjdBRIczEhIFHkBmp2pL2XKSD0ijc610P7/48YqdzZ4Zh4UmFL2GYfo
 p4orxDK8G5TZG/zthYKmrwU9RNs9OReO/jR4j0cj4J
X-Gm-Gg: ASbGncuR9WFUR5HJMQ62Kr1ZZZbYYo9HctEdq8EB2hxrPLK2Ks8f/blkhZqZJyb48Wy
 X9z6qy/kXBW3yKtZNRCR7pDsnXgud8GB0I8qG/hxt3bNkM6h4Dx9v/6rns/LnY/HfAshGsGYOs7
 ORVzIn0GZzSeMa2F4gQrcM3vd+qQaxBvH2BQ3EhE+HYW8Uo+20mjyUM6TWFmBZ8mvOMakAna3Cd
 wEiYUtpSkYSiYYHcoKRGP0D7Ld8dzkCFGOwj4+Otil73tDN5V9qlt2TCEBGDBL3Ru/rYE1LJDe5
 w0dWAK///Ocu4KmkpYe+C1sA8x16WlLMx0cUsMkhMWg=
X-Received: by 2002:a05:600c:c4a6:b0:455:ed0f:e8d4 with SMTP id
 5b1f17b1804b1-455ed0fedc6mr144023675e9.10.1752491092324; 
 Mon, 14 Jul 2025 04:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH35YT0aMEGjdBP8pzHneR6Xz9SIAbgFNNpcby+WFWSLWTUc1AM8KqQrTvm7mtM62Q/y2iodg==
X-Received: by 2002:a05:600c:c4a6:b0:455:ed0f:e8d4 with SMTP id
 5b1f17b1804b1-455ed0fedc6mr144023215e9.10.1752491091779; 
 Mon, 14 Jul 2025 04:04:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5easm11981807f8f.48.2025.07.14.04.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 16/77] i386/tdx: Fix the report of gpa in QAPI
Date: Mon, 14 Jul 2025 13:03:05 +0200
Message-ID: <20250714110406.117772-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Gpa is defined in QAPI but never reported to monitor because has_gpa is
never set to ture.

Fix it by setting has_gpa to ture when TDX_REPORT_FATAL_ERROR_GPA_VALID
is set in error_code.

Fixes: 6e250463b08b ("i386/tdx: Wire TDX_REPORT_FATAL_ERROR with GuestPanic facility")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250710035538.303136-1-zhenzhong.duan@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index fb31071dd81..7d69d6d7b06 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1321,7 +1321,8 @@ void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
 }
 
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
-                                        char *message, uint64_t gpa)
+                                        char *message, bool has_gpa,
+                                        uint64_t gpa)
 {
     GuestPanicInformation *panic_info;
 
@@ -1330,6 +1331,7 @@ static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
     panic_info->u.tdx.error_code = (uint32_t) error_code;
     panic_info->u.tdx.message = message;
     panic_info->u.tdx.gpa = gpa;
+    panic_info->u.tdx.has_gpa = has_gpa;
 
     qemu_system_guest_panicked(panic_info);
 }
@@ -1349,6 +1351,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     char *message = NULL;
     uint64_t *tmp;
     uint64_t gpa = -1ull;
+    bool has_gpa = false;
 
     if (error_code & 0xffff) {
         error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%"PRIx64,
@@ -1381,9 +1384,10 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 
     if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
         gpa = run->system_event.data[R_R13];
+        has_gpa = true;
     }
 
-    tdx_panicked_on_fatal_error(cpu, error_code, message, gpa);
+    tdx_panicked_on_fatal_error(cpu, error_code, message, has_gpa, gpa);
 
     return -1;
 }
-- 
2.50.0


