Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A12C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIS-0003T8-Vc; Mon, 14 Jul 2025 19:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHG-0006B1-9M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHE-0005e4-OE
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUQMsD0OTjK6NSdPR5fnk3SR/AQMl7B+vWC0iuHgWB4=;
 b=cogMnvdcaWVyHeMNoCgFJi4DHsi7UzfQjDr3G1zg7HEz+dOriLJ2td+VJPjEsEwXHzQ7HF
 enRciG1DvZdtSx/XVmJXTZHKtkOhJqH71nwz1VQlltD2cxl+u6+lu7DGKQfWLprm/9MR9Y
 Y8vjpSKMlaw3U9j7/AfG5M0FaXlUtUw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-iTchXHfUOym9GeJQJTYONQ-1; Mon, 14 Jul 2025 19:08:02 -0400
X-MC-Unique: iTchXHfUOym9GeJQJTYONQ-1
X-Mimecast-MFC-AGG-ID: iTchXHfUOym9GeJQJTYONQ_1752534481
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so3030293f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534481; x=1753139281;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUQMsD0OTjK6NSdPR5fnk3SR/AQMl7B+vWC0iuHgWB4=;
 b=H3H/eLWzmKZENkXvesWRWwx+9rPQdFVrJ18OOx69Y5t+JJUWr6qNM1Szx06R2pynvh
 Po4szUsk9wulNzS4ce8VZGzDbHmsOJ0p778xbBPo8vFsjbr+yz7anBAqtZNn5kRFj+xq
 9a2NzL7ZzqALW1lScpWOtzwhbFu2xFzY9xhoO/5IyKwoNEiaOpDKa0Ld3ssclIi/2kVx
 mCgjhLlm58OGyBOlEkrEgrX/rVi7aGNevrhX5/4Fwc+Rpv9Y8XVPxZk8RSUmOJN9vC14
 4kqsZ6rfBMWApOtufrCfbT6xZDAGof6YMtDzFCPo+kS7jMzVsezkGCUiKXjoQvOdxy4w
 47Kg==
X-Gm-Message-State: AOJu0YxcKYdSRBAaDewdX6OSck9VuIN9Q65v0tcHwztqk3xZxGEAExfR
 FLv4yeXdaNt5MXf017rKSrBrnRi8qWJnuRqEVctInI3oDaWkAfUUNHJsfx3/KArVxZn8VCiZQaJ
 XfE+A1IHtaZ9bCLQx5pqEF88AsRlMdysmgz07AhO3+Am4QD1/Auf4OONzEyJLzbOhx05VAf7Xmv
 YQblYWrCgP1WEIkMY3L50cFcc0/JwC9XM43A==
X-Gm-Gg: ASbGnctrNw4HO1X6iwKiRADOGlj+p+FzPHC2BtJ8jxHcYd0gcPDN4B6uTemCS+6j9I9
 0xVPdiu8xPONai8sA14PUdmeZ2l3XNw9iEQNpR3aOmlsFx6nY/d4vzw2fBJfpiqZAtGL1z3Ez9a
 eWhh0dTtQ8J/xcC0MnbBPJj1MdHT+LGAQbZvZKhNe+TWUShXoe2DA8jVS3BZtAfQgvx509bkclX
 iPRAfQPg9kME5FlhnQbmXXjRoSV4UVUaOwtqLuKxDtFZ3PwYiU7cE+wGf4+FlHtRtCDVFmuIA2q
 TB1mRkSWg4AMEDytnfUia6Ekcl3iJDkb
X-Received: by 2002:a05:6000:4813:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b609522266mr1202418f8f.6.1752534481298; 
 Mon, 14 Jul 2025 16:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEicwywIXnry2MwhM5a+JDwbJ7HFqb3x8zLJNA30KZVGdw5vXOlaDU+Fp4g2weqKjwAsKKD8A==
X-Received: by 2002:a05:6000:4813:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b609522266mr1202397f8f.6.1752534480906; 
 Mon, 14 Jul 2025 16:08:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1a5sm13318956f8f.74.2025.07.14.16.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:59 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 41/97] qemu/target-info: Add %target_arch field to TargetInfo
Message-ID: <6d60578759b0fb09a3435c16837b7ecf48c56fed.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250708215320.70426-4-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/target-info-impl.h | 4 +++-
 target-info-stub.c              | 1 +
 target-info.c                   | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 1b51cbcfe1..a8b34d150a 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -9,11 +9,13 @@
 #ifndef QEMU_TARGET_INFO_IMPL_H
 #define QEMU_TARGET_INFO_IMPL_H
 
-#include "qemu/target-info.h"
+#include "qapi/qapi-types-machine.h"
 
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
diff --git a/target-info-stub.c b/target-info-stub.c
index fecc0e7128..2e4407ff04 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -14,6 +14,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .target_arch = SYS_EMU_TARGET__MAX,
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 9ebabec988..8e29553b4e 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,8 +24,13 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    return qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                           &error_abort);
+    SysEmuTarget arch = target_info()->target_arch;
+
+    if (arch == SYS_EMU_TARGET__MAX) {
+        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                               &error_abort);
+    }
+    return arch;
 }
 
 const char *target_cpu_type(void)
-- 
MST


