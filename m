Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CD4C282D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3nB-0002YP-OQ; Fri, 28 Feb 2025 12:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1to3n9-0002Y9-Qs
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:04:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1to3n7-0007yf-DC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740762287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tb/pyYYzzR3tunrAtpBbQH39LeeMjzxhHM14eG6svts=;
 b=P2APPOTtNb2iB935nW7ZfpyXcgspEU5Svi+37NIiD8pajDGiCZNlwZzYIQ2NS5IRW6OGsG
 hbti6+2WXYHVM/WN2OzcBNsaTP6Wx3fachPzn/ABiV3BN+U7+YOotGokql2U7vboonjEKo
 WUqxAYqdIWBuNBoVH0NKyCmfdQLScks=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-8Rhc898qM4WgsQFvklGTug-1; Fri, 28 Feb 2025 12:04:44 -0500
X-MC-Unique: 8Rhc898qM4WgsQFvklGTug-1
X-Mimecast-MFC-AGG-ID: 8Rhc898qM4WgsQFvklGTug_1740762284
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2234dddbd6fso53438585ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740762284; x=1741367084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tb/pyYYzzR3tunrAtpBbQH39LeeMjzxhHM14eG6svts=;
 b=Nkv2AtcyFHeddIW2LozlW+U0wy13yVBHzBAWmxcGAUYng+3jHii+CHSOjDqdF0auF3
 pKsHTRrSXfMq594C3d4piaOSgQ766lPBI6SdIN9pj/CIv02SsjUZ8Ei2PnK4S+fMtgkp
 VTU/QqX5kHZjOYC+jjJQrcrKgU0KDRQ1QQFmQuL9XaZ7o2Yxyi7ZFgno7yVMQttyZKmN
 XSMhS7rpCm9l2rx0Xvi8VZ2U0AZ0M+nXL8mRKDkRbN0VR1T61lrsnS/T3sToYoqY4J+P
 0vQuEJRt1/KPkXtthzwMzKdc37/hqK7LiOMgiF1I7jE1CLRo55FgT9voCNDcmTZ23pMZ
 iDlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7J8yPv3sj4eCl8LqET+UL6hAk96LiOaIYE70aPRNg9gAkKbFQZ5B0svWy2E0seGpYDXNZ/URX//c7@nongnu.org
X-Gm-Message-State: AOJu0Yynwc9ft9g2Fboafv3oeQ63MOH3bcj/neVmf+dWhzBDtH5LC4ns
 iaT2VMmZvghobXSn2x8ayndfSk+AtfArszHLrrK3IpLbsPBM7KBIMQ+FLvGEaigU65Hi2krjxGt
 05nAFaVJxRlatW1Rn73OMn4hRJLrZ8wSp+WRVShZv3xWBsiZVx4Mn
X-Gm-Gg: ASbGncsxpqrY79iEZXh7MW5C4/E3Iq9Qxm0bjy8zPd7iUA2T+SQ1soAb6DhORCuLV1e
 zfUgFt/tl1eRrT/cfyqnTN1zL9Mn2+Ua8tgI3idZllpQzBKZm6UOr/+M820axg3J8JDSdrzuiA4
 c+XGc81Qw11DrUOEzIzaEbDQ/LMWVM1MEFLINGNXx05a+X6CxO+0CFQ7NhD9NmdNuq3hyNJS8LM
 Bsm1yutwbm0WY8CH0mfl51zwGYr5pQVVq78vP/EQ+xmrOFxlM+aVZ4ntHjf1y5N5a6i1SMrjCyg
 x9mKEwj1Q0WOtSE4Z2lwvU5LtpUk
X-Received: by 2002:a17:902:ce8d:b0:220:e91f:4408 with SMTP id
 d9443c01a7336-2234b083b0bmr127841785ad.22.1740762283892; 
 Fri, 28 Feb 2025 09:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVCB2mjeireJj0MSgF8Avt+W8iOZr54TSOj+FX9UNWuLdmqdr+4QXQbDo5CA0SopBpPaVqyg==
X-Received: by 2002:a17:902:ce8d:b0:220:e91f:4408 with SMTP id
 d9443c01a7336-2234b083b0bmr127841245ad.22.1740762283449; 
 Fri, 28 Feb 2025 09:04:43 -0800 (PST)
Received: from localhost.localdomain ([116.73.133.207])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-734a003dcafsm4070142b3a.132.2025.02.28.09.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:04:42 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/ovmf: check if ovmf is supported before calling ovmf
 parsing code
Date: Fri, 28 Feb 2025 22:34:34 +0530
Message-ID: <20250228170434.317306-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Currently call to x86_firmware_configure() -> pc_system_parse_ovmf_flash()
happens only when SEV is enabled. Fortunately, X86_FW_OVMF is turned on
automatically when SEV is enabled and therefore,  we never end up calling
pc_system_parse_ovmf_flash() when X86_FW_OVMF is turned off. In future,
it is possible that users call x86_firmware_configure() or
x86_firmware_reconfigure() without checking if SEV is enabled. Therefore,
x86_firmware_configure() or x86_firmware_reconfigure() need to check if
ovmf is supported before calling ovmf parsing code. Hence, this change
introduces an api ovmf_supported() that returns true wnen ovmf is enabled
and false otherwise. Ovmf parsing code is only called after checking if ovmf
is supported.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_sysfw.c            | 18 +++++++++++-------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       |  5 +++++
 include/hw/i386/pc.h          |  1 +
 4 files changed, 22 insertions(+), 7 deletions(-)

This patch is built on top of
https://mail.gnu.org/archive/html/qemu-devel/2025-02/msg06005.html

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index a9943d95c8..725d142606 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -278,17 +278,21 @@ static void x86_firmware_configure_sev(hwaddr gpa, void *ptr, int size)
 
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
 {
-    /*
-     * OVMF places a GUIDed structures in the flash, so
-     * search for them
-     */
-    pc_system_parse_ovmf_flash(ptr, size);
+    if (ovmf_supported()) {
+        /*
+         * OVMF places a GUIDed structures in the flash, so
+         * search for them
+         */
+        pc_system_parse_ovmf_flash(ptr, size);
+    }
     x86_firmware_configure_sev(gpa, ptr, size);
 }
 
 void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size)
 {
-    invalidate_ovmf_parsed_metadata();
-    pc_system_parse_ovmf_flash(ptr, size);
+    if (ovmf_supported()) {
+        invalidate_ovmf_parsed_metadata();
+        pc_system_parse_ovmf_flash(ptr, size);
+    }
     x86_firmware_configure_sev(gpa, ptr, size);
 }
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index edf890a525..08ec18b9b7 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -15,6 +15,11 @@
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
 
+bool ovmf_supported(void)
+{
+    return false;
+}
+
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data, int *data_len)
 {
     g_assert_not_reached();
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 3244c17a7d..e6497fd7a7 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -36,6 +36,11 @@ static bool ovmf_flash_parsed;
 static uint8_t *ovmf_table;
 static int ovmf_table_len;
 
+bool ovmf_supported(void)
+{
+    return true;
+}
+
 void invalidate_ovmf_parsed_metadata(void)
 {
     ovmf_flash_parsed = false;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7b0d0c54f5..2e41ca8b05 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -212,6 +212,7 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 void invalidate_ovmf_parsed_metadata(void);
+bool ovmf_supported(void);
 
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
-- 
2.42.0


