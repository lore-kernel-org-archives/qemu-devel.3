Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93323C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ubX-0005rP-4U; Thu, 10 Apr 2025 12:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2ubQ-0005qe-Ka
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2ubN-0004Qp-5G
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744301883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PGaRO9Gso5IOJbzbhgahH7LW5DO1lAZOAyvH8PRaixU=;
 b=UZJ7UsqKWsJpSJdebJd/7dLu6ohxJcSLCRXIttEQuE1QgG4GIngwIF9elDmJNIj+pcXSdb
 JrFL742XB9edxsSUnnCbOt4udS2E/LbnBe5G12YV1Snb3L2lhbZsEVjTGBzmBdTfsNUEPH
 rxDW2m9/7pelHam2BmfXA1QxFpwmvzM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-KAzQLlI1MLmp__D5_kYB4A-1; Thu, 10 Apr 2025 12:17:55 -0400
X-MC-Unique: KAzQLlI1MLmp__D5_kYB4A-1
X-Mimecast-MFC-AGG-ID: KAzQLlI1MLmp__D5_kYB4A_1744301874
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac737973d03so76394866b.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 09:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744301873; x=1744906673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PGaRO9Gso5IOJbzbhgahH7LW5DO1lAZOAyvH8PRaixU=;
 b=CcmSb9AmXC5cZQ+xUHbvBRVpgJECS3GcN41UhHp1EIeFEmNMQ5jheG9HXMM1FmjULx
 dtbgC8Zeb2+V/VRLAuqf9KVw6pfo5ezHe7X0hkvGvs87qwDgWUZ73hAUyxovnFUlq+1s
 tuLI6krcKovGyjd9gvFVl1Bedtx5Ikoujwvvv7ciR2d2IsAkQQkWS8iuraJ/DJpmRvxm
 J3g61SG5Dp0qr0Z7rL5mjtuppnvPr4bqF9aVGSPXglUHD0eLP+CUyQsuuECdd5GynYIr
 VLxDLVIqaXRzUXcmAEDYhSrxp8Gq3lpTrNkX0O3Rblmx3EKx9fGwSpsKVYHHmjmpoNZb
 TTNQ==
X-Gm-Message-State: AOJu0YxZx7vgD6GdX+a8jWM2HK1UX9mKWIB6FdyRBdRGwHB7QNKurhMO
 U6+EHn/CJ73GlIkyK5xNR7Twzjc1ixRyLGF8p7VDexXUirGw25S9nwTBkw5NrUIDLFsdq6a56sf
 HqnRi0o/ERSK9nczs++Ytmqd3khgjVYh+RYVZzpABrkBfzCebKUP2UXyOWyx8bbe93Ugvf9bMQC
 Qwlp1ibtikdOnbLZvQmAuPMf+STo80OcGxUzN/
X-Gm-Gg: ASbGncuMCrxH0ud/DtUW4IdOlZx5COjCBHi/LAkF5Z2XFyp7EhnAZS1yI1Iuf/mxHCT
 lyldohKCzN4aOYKXTejbEQ1soLrGhoPSpm0Q5S2IvhDjAUPa2whFhVRuEFvFgk6BrtQ18JMiLnU
 XKkM05bsliwPN75mD7ZOYIGuTMn383WiskVClW6Q0xBA2nYr3BTITp3t2DliKDLNBxOphhtzsyn
 3V2t6uwjp82kbbQl9c6PEk2TidKkkvXkHy9ay9btMGDibuPJuHSs3OvZEc+pRvFI0az+adS2sC+
 skQY/EoF5iiAGHhVizAvgRBYQ914z8LDGcEl63nX4Ov2bxA=
X-Received: by 2002:a17:906:810:b0:aca:cac7:28e2 with SMTP id
 a640c23a62f3a-acacac730eemr64168166b.40.1744301873355; 
 Thu, 10 Apr 2025 09:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuy+hmNY0hAj1kZ4fphrFraCC87pbQ/rA9UohsR0Ctza6IfAwBH2xIjesdM1h+xDkIm5dOvw==
X-Received: by 2002:a17:906:810:b0:aca:cac7:28e2 with SMTP id
 a640c23a62f3a-acacac730eemr64164966b.40.1744301872825; 
 Thu, 10 Apr 2025 09:17:52 -0700 (PDT)
Received: from [192.168.122.1] (93-33-70-196.ip43.fastwebnet.it.
 [93.33.70.196]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ccd1c4sm300863066b.148.2025.04.10.09.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 09:17:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PATCH] hw/riscv: Fix type conflict of GLib function pointers
Date: Thu, 10 Apr 2025 18:17:22 +0200
Message-ID: <20250410161722.595634-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

qtest_set_command_cb passed to g_once should match GThreadFunc,
which it does not.  But using g_once is actually unnecessary,
because the function is called by riscv_harts_realize() under
the Big QEMU Lock.

Reported-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/riscv/riscv_hart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index a55d1566687..bb9104bae0b 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -104,8 +104,11 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
 
 static void riscv_cpu_register_csr_qtest_callback(void)
 {
-    static GOnce once;
-    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
+    static bool first = true;
+    if (first) {
+        first = false;
+        qtest_set_command_cb(csr_qtest_callback);
+    }
 }
 #endif
 
-- 
2.49.0


