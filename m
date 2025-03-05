Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE6BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjWy-0004Xz-Rx; Wed, 05 Mar 2025 02:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjWx-0004Xo-B1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjWv-0007DS-Nv
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEUuRTuxISH7VrsnrtIj3pcFJONapnsboe6eHEzJt+0=;
 b=LbV0K9ZllB9zVZcl8lXU0sWG2sveOUh72zLnBfx4/2HjYkOpCigXl5ZoioTtJ2Yw0uanEu
 W+xbdUZnhSfKguXuYLejIAKidYqe1wvYX8X8pMddDFIEP28LNCA0NtRDPpwM/FIhxHhzB9
 reJbrus+hliRWOMkns6pcj4pq1THoEU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-sCiHA3WTNjCKybDUaNPwtQ-1; Wed, 05 Mar 2025 02:50:51 -0500
X-MC-Unique: sCiHA3WTNjCKybDUaNPwtQ-1
X-Mimecast-MFC-AGG-ID: sCiHA3WTNjCKybDUaNPwtQ_1741161050
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2234c09241fso190270915ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161050; x=1741765850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEUuRTuxISH7VrsnrtIj3pcFJONapnsboe6eHEzJt+0=;
 b=rc8aHAnMah6Zw1I13JB1L1ItYj58T8xFOA6YBF5IVnRquTnX0nyevQ+X2vKsdENU2K
 3YseA+gJ8Btiy5WKqfUqNik90I9tUt5oqJiY2misp54HO38N8vh1EsE/HA+ihXsTQDB0
 66k4znbyV2wKyRPQcD/WyT9bWG3luJgFIWnY30LqqAg3v3QPsrvzoVxXnXiE/6TaJhxt
 89WN7mQeEW1p0nSIFzLiFnr7Py1XBory4GDbzsV1DEoQp4MaN6k629eN1vy4KYmXrW3h
 0KC4ugsOjNJgFoPDyOz0S/1f1M+5fC4+62wlynBM5tXfTraPwgKFoDlsMMs/CJCKDYJ5
 geTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGSuC8welsLQBqnjbkEHkLDqDIhdkt99NBmVX+Wto+JP9keB2urXjzwPw5TariQEJsx9Z99V8Kyykb@nongnu.org
X-Gm-Message-State: AOJu0YzqQwmPMAF9fYsDbT1AyEx3WfRqosvNZMJ7CWM0lPWA/djdI2bJ
 BJ9mWiTlZwtwp7QF0U1ki5h/h2bS+bW5LX9K6XP0CRjcOu3bTBwmZVFE34M4LLTKrNQBIXEqeWj
 QK7ZJtm4YBzAk5qbkPjfQUABFMmbY9JvXMaOR4RxJD5h1dCYmBJTd
X-Gm-Gg: ASbGnctdwnT7P0pldAVoey7QvSCRkcy5XBnONpO3boBoZWJIJHYrAfrZEwSmDgRh+hs
 9GXzkLJmwPy23HBJX4NVO4alDiab8YEBbQLF7y3L3xjEeUqgGtW1FSbr3iRFhhsOOGv0xBMINTe
 zVNs8xx1OMIzD4LLFXTys7kHZuCD8YCylCTDyTS0KDlLYK839NF5rTeZK5vyT+dybDi/iuElzS3
 dRws9iyq+Zv1EVB8eDL3L+QmXCkDVgBWSjzAy8VM9lOfv91lixnZUIOOTiY4z36r/iOkliKMeb0
 NpBPvrfCKmXrrwveu4HXjeY2cUw=
X-Received: by 2002:a17:902:d48a:b0:21d:3bd7:afdd with SMTP id
 d9443c01a7336-223f1b879e3mr28657315ad.0.1741161050404; 
 Tue, 04 Mar 2025 23:50:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYYrfHLc59oHWRmuqjn/V3FhP6t2iR1fJRGeNyed/dSADkLQpJ4y7/a3d2mRIpIX0/PnqGGA==
X-Received: by 2002:a17:902:d48a:b0:21d:3bd7:afdd with SMTP id
 d9443c01a7336-223f1b879e3mr28656995ad.0.1741161050092; 
 Tue, 04 Mar 2025 23:50:50 -0800 (PST)
Received: from localhost.localdomain ([115.96.122.38])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-223501d2778sm107425355ad.36.2025.03.04.23.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 23:50:49 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 2/3] hw/i386/ovmf: check if ovmf is supported before calling
 ovmf parsing code
Date: Wed,  5 Mar 2025 13:20:14 +0530
Message-ID: <20250305075015.26892-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250305075015.26892-1-anisinha@redhat.com>
References: <20250305075015.26892-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Message-ID: <20250228170434.317306-1-anisinha@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/pc_sysfw.c            | 18 +++++++++++-------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       |  5 +++++
 include/hw/i386/pc.h          |  1 +
 4 files changed, 22 insertions(+), 7 deletions(-)

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


