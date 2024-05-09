Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A64C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 15:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s55eS-0000OA-3n; Thu, 09 May 2024 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55eO-0000Me-Gf
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55eN-0006NK-2c
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715268338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zpotsg25Hj/ueq1pSaXUMSU1LC0Q+INR1K1IUm2B9pk=;
 b=QLUNBWLuwCIlbRp5GG4djqHVlZJjnUvGJyc9hnl+HoHC2eIDMsRweH46WjEFQCQecjjvNn
 +93vFJOIpeRon0PgbZ7XiwOWj7xvWwu3uSQZLHJSqOCPnFlDxwnI78fjMyAev6IUmzyflI
 qa12ryo3I9VShhTicSI7C7qWXWaGJ6o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-eH_3xK2VOBq4YCAtuDr1TQ-1; Thu, 09 May 2024 11:25:36 -0400
X-MC-Unique: eH_3xK2VOBq4YCAtuDr1TQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5a1b50d45cso46326066b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 08:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715268334; x=1715873134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpotsg25Hj/ueq1pSaXUMSU1LC0Q+INR1K1IUm2B9pk=;
 b=vggLYRzr6gHn+nGk/U7fhvIxt0i895kEDWRLpHapP6KBl2thh4fEw4pEG1rMO4WnHy
 ZEkTTG7Ch101Cs+o78Akm+PGjZYW2nL2VooGFyFFrvI/hG8hGwQrP1AXR2kkrVRj/ccd
 mu/01qtlUS28QViIP5M0R/6JgE9qs8JnNkplp0Ykyp1d1HPlKs2keMbfqnlZC3VUYC1w
 nseGh1/J2dKciskI0NQxB01wAP9OkoFEb+/SLjQ+vxYtAiaYZDdrb7y4w3eyfsRKAEWb
 W2M78jYekAugdUeIckB7ibdGBJBI1z+OYU1iQjBvixW2FMtZXsjB19X6QbTcdjF+8fsC
 Mvvg==
X-Gm-Message-State: AOJu0YykWy7DIDS9uqiHW7Fzy3Ff8p71IdSjsGKRZbhNt8ORE9/NN2oq
 bpx3W7S0P4QtZ/D0k2GTUPcEgnAqsfnDkdVMt7N+nnLI1+iuW0P31cMx9bwqCuZEHhifmOcFAda
 KiOKbz5Hj3qzionvuo3yZC6ZurkZuwlFK5ne742nxMp9vxiDHK2LP/DjTZKlLEN3FL+t2CyStZM
 9ZQzU6g1vFHf9d/4fSKkvla7weZ88yGbhriMlx
X-Received: by 2002:a17:906:6d51:b0:a59:c2c3:bb45 with SMTP id
 a640c23a62f3a-a59fb9cd4femr398258566b.56.1715268334683; 
 Thu, 09 May 2024 08:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdzmb1orLYiWLwhcGC2MDbexTcAHjB8ZkOP97QPAUgTPGU9iwvOVBgG/7D2vx8nOdL+hy/eA==
X-Received: by 2002:a17:906:6d51:b0:a59:c2c3:bb45 with SMTP id
 a640c23a62f3a-a59fb9cd4femr398256166b.56.1715268334139; 
 Thu, 09 May 2024 08:25:34 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cdb5sm84692466b.29.2024.05.09.08.25.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:25:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/tcg: cover lzcnt/tzcnt/popcnt
Date: Thu,  9 May 2024 17:25:32 +0200
Message-ID: <20240509152532.141935-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-i386.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index 864c4e620d5..ce3bf74b5a8 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -715,6 +715,30 @@ void test_mul(void)
     printf("%-10s A=" FMTLX " R=" FMTLX " %ld\n", #op, val, res, resz);\
 }
 
+void test_xcnt(void)
+{
+    TEST_BSX(tzcntw, "w", 0);
+    TEST_BSX(tzcntw, "w", 0x12340128);
+    TEST_BSX(lzcntw, "w", 0);
+    TEST_BSX(lzcntw, "w", 0x12340128);
+    TEST_BSX(popcntw, "w", 0);
+    TEST_BSX(popcntw, "w", 0x12340128);
+    TEST_BSX(tzcntl, "k", 0);
+    TEST_BSX(tzcntl, "k", 0x00340128);
+    TEST_BSX(lzcntl, "k", 0);
+    TEST_BSX(lzcntl, "k", 0x00340128);
+    TEST_BSX(popcntl, "k", 0);
+    TEST_BSX(popcntl, "k", 0x00340128);
+#if defined(__x86_64__)
+    TEST_BSX(tzcntq, "", 0);
+    TEST_BSX(tzcntq, "", 0x003401281234);
+    TEST_BSX(lzcntq, "", 0);
+    TEST_BSX(lzcntq, "", 0x003401281234);
+    TEST_BSX(popcntq, "", 0);
+    TEST_BSX(popcntq, "", 0x003401281234);
+#endif
+}
+
 void test_bsx(void)
 {
     TEST_BSX(bsrw, "w", 0);
@@ -2162,6 +2186,7 @@ int main(int argc, char **argv)
         func();
     }
     test_bsx();
+    test_xcnt();
     test_mul();
     test_jcc();
     test_loop();
-- 
2.45.0


