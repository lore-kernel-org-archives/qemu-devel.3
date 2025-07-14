Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911D1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHn-0008AC-3q; Mon, 14 Jul 2025 19:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHJ-0006BZ-2e
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHH-0005eV-Jr
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwfIzYrv4MBv7GUQsUabPZ6KXkMEaOc7eKieOXGGWEg=;
 b=i9TyUPhuwDuTHYuTcOY2u16AbtV5NXJlhX+DKVqSTkux5/lNNbHRm2sEboUxCvka/nu9ML
 iOCnjkhIJzcIf12yvDlJ2wZtCplzmDsrT/QfNbfH8SwJ6XT+kNC1xBnw8ktMgyxz18vSgk
 MwoEU+ie4VQ7FPjzgzUGtaTzfpu37hg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-QHQhHS9LPZ2hGJGn-BKyFg-1; Mon, 14 Jul 2025 19:08:05 -0400
X-MC-Unique: QHQhHS9LPZ2hGJGn-BKyFg-1
X-Mimecast-MFC-AGG-ID: QHQhHS9LPZ2hGJGn-BKyFg_1752534484
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso3441229f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534484; x=1753139284;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwfIzYrv4MBv7GUQsUabPZ6KXkMEaOc7eKieOXGGWEg=;
 b=Bmj/7+pTArLlF9YYq72w+noJoIQGaE0bJ4CGVFgAcQxYjbSQNwTU6h0bg9brtdOX8J
 Xg91cL9Il4eLV59rkKbCug/5pJ1GxV+U19svoGAo+oIrmkBNPZVvxBIHoA2Ss2D+wgH3
 D776GHzounHcN3WfoP83MzKZziU8kjWI9+450Q43gYr2NkGiwVOJFdb2zb4+BMH15VZz
 Z5eRuBAElVnsHJeJQxSHYP9f87fQk+vysZMQMS54ZcC8Z7FoHG9ssiQmEaFZm/6rF6mF
 OPDSGQo9HFQiktYStWIHa3tKJmjljgtVwne4NcYBqSXOTzGE+xizROeuHbj5oLF7Vrhx
 X3iw==
X-Gm-Message-State: AOJu0Yw5i7mlVxV4iX9ln6QcLyuCOcmAjy2/fZggXZ+N7izGcTSr1QpU
 jP+o2LlqvH3Nhuw3+xAXwTGvakM+r1JNRPv6j3iFG7KBdUTQEHoaaJw+5fR6TNRfVSGKvjki0py
 gWyOYgxLne70ax9Gm/2t8hbDLyGQ7UCDVW2I/BSJcDN+kGhBUkLrsZ+J0m6hItQa429iephzrKi
 bQgtMs6TjoV0QZIMk158FUbE2VXdJoBK02Fw==
X-Gm-Gg: ASbGncvYU3KMhPW+m0u0s4fINDYPuAut93wnSOLxlDM9e1jtOFE1oqoK7F9HmyDlbZm
 /zFgjOc2eXwJB0m0KvEVaLgF5qd/uiWJTFwJpGG0rjGSGQJcwtWrgpsq3qGtmzQ5pMIOfrTjqoV
 ShLOXUni1unwTPXUm701pAVXNuRz6Fg+Y5X2bWowLXvs3knxQ2g9qv00Bmf05bHHHPqcTS1kPaX
 4GHr1/crwmkfB8Arv2uC0ppR2HYlfldv0HHk7XI/aBDA/nY2kZELItaSSKyDG4bRVshaJxNp9RF
 4fd3SRWKuNiY1TU+lcSQ1I4PjToQhG9s
X-Received: by 2002:a05:6000:1378:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3b60a14f3c1mr205854f8f.13.1752534483845; 
 Mon, 14 Jul 2025 16:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmsZYuT6huZe2wvMM0CjkEFlyytrdcV9WE68nRN16ICd0Zs/XjIANdMDIp5e7cjdCGmSO0DQ==
X-Received: by 2002:a05:6000:1378:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3b60a14f3c1mr205833f8f.13.1752534483365; 
 Mon, 14 Jul 2025 16:08:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1741sm13735871f8f.18.2025.07.14.16.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 42/97] qemu/target-info: Add target_endian_mode()
Message-ID: <68661aa12085726b71ad43fbf2d3a813bbfdf85e.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

target_endian_mode() returns the default endianness (QAPI type)
of a target.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250708215320.70426-5-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info-qapi.h | 8 ++++++++
 target-info-stub.c              | 1 +
 target-info.c                   | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index a8b34d150a..17887f64e2 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -22,6 +22,8 @@ typedef struct TargetInfo {
     const char *cpu_type;
     /* QOM typename machines for this binary must implement */
     const char *machine_typename;
+    /* related to TARGET_BIG_ENDIAN definition */
+    EndianMode endianness;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
index a337c867bf..d5ce052323 100644
--- a/include/qemu/target-info-qapi.h
+++ b/include/qemu/target-info-qapi.h
@@ -9,6 +9,7 @@
 #ifndef QEMU_TARGET_INFO_EXTRA_H
 #define QEMU_TARGET_INFO_EXTRA_H
 
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
 
 /**
@@ -18,4 +19,11 @@
  */
 SysEmuTarget target_arch(void);
 
+/**
+ * target_endian_mode:
+ *
+ * Returns: QAPI EndianMode enum (e.g. ENDIAN_MODE_LITTLE).
+ */
+EndianMode target_endian_mode(void);
+
 #endif
diff --git a/target-info-stub.c b/target-info-stub.c
index 2e4407ff04..ca0caa3686 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -18,6 +18,7 @@ static const TargetInfo target_info_stub = {
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
+    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info.c b/target-info.c
index 8e29553b4e..a756c0714c 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,3 +42,8 @@ const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
 }
+
+EndianMode target_endian_mode(void)
+{
+    return target_info()->endianness;
+}
-- 
MST


