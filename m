Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ACCC3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFQ5-0006Av-AP; Fri, 28 Jun 2024 13:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFQ3-000629-6S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFQ1-0002GY-Fh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2XgIgI4I4VJi3eTDPeYIQcPPk61UBK6QowRUBwCEHE=;
 b=K0hAojPvZ3dgP/ZkKiaRa+QImaw0ARb5IEI2x/y5FOW+3d4R7rbzJQ1d/5ZBYgHghhu6N+
 RXWVRuE2BGgW7MW0eiBS/EG1eTiL/88R5SYcc1faEQeD64zQhvfpiCWM7QXcXigixcgvxF
 OcQBz9PhksUYCkEeHanGAl8htEEpMm0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-gOyNK0_OPLW5HUBDlLNHcQ-1; Fri, 28 Jun 2024 13:29:50 -0400
X-MC-Unique: gOyNK0_OPLW5HUBDlLNHcQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a706f30724eso55835966b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595789; x=1720200589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2XgIgI4I4VJi3eTDPeYIQcPPk61UBK6QowRUBwCEHE=;
 b=r6vvOW2YxTj/Iyw+Eoq8r6JyPNbad1axW9GpxK8PTX6FLMKjvIAALKZpQmlUL+rG9W
 Jp42Tz91vev4I2uMtpLxocvCkHRhR64FWSpL61KYsYb3kj+NRGZL5lszY+tyELnuyZvP
 bS+8V+DaxNdTiL5YL18xUa6kbRGTT/pb7d77IBFULjDpo8cUNWWwyk3T+YqA218pU00/
 stHdsudHFNr42d9UdIuv6Ta4U6rpTzMQ+Li+GMecG+GBduPz0a88gzDirAjeSBimhkNL
 nUlRMih8pP0BsTAXukfftsHtkV/ecjL4gSynTXlRpl6jsvFei9p/sDrZi3BU4Rhi3j/f
 DvaA==
X-Gm-Message-State: AOJu0YxUbUW+fiBERmE1AO9+cipcUnh8QdFvoqtPHnrA2SvJO/eNdP+q
 YyAXssRBcTm+XVnG5+h4kHJEuLIOoRRtUfPx9GUcDqUf45EYR3EP4GabWpFMvkvyMCdXMULOLjE
 XibS6cdOkDg75DFEdfED4MG8/+VLp0qplzhjNQDumgXqXo1st3NtG+fwsTaLya6LMps6fWMPNlJ
 GfGCaTrqMkDbPspsftnkwt4VY1xMHGUvdXo3tn
X-Received: by 2002:a17:907:d047:b0:a72:76c8:ef68 with SMTP id
 a640c23a62f3a-a7276c8effamr793983566b.69.1719595789331; 
 Fri, 28 Jun 2024 10:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5AvOQ3mB8J9KBEOwST0l511Y0M3LUJ1fZY5khi/OOQgFQn7mIUl7JVK+5z8BmpJQW0Wc7jg==
X-Received: by 2002:a17:907:d047:b0:a72:76c8:ef68 with SMTP id
 a640c23a62f3a-a7276c8effamr793982166b.69.1719595788994; 
 Fri, 28 Jun 2024 10:29:48 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0651a8sm95235466b.128.2024.06.28.10.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/23] target/i386/sev: Use size_t for object sizes
Date: Fri, 28 Jun 2024 19:28:54 +0200
Message-ID: <20240628172855.1147598-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

From: Richard Henderson <richard.henderson@linaro.org>

This code was using both uint32_t and uint64_t for len.
Consistently use size_t instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240626194950.1725800-3-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 16 ++++++++--------
 target/i386/trace-events |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 28d6bd3adfa..0ffdf8952c3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -121,7 +121,7 @@ struct SevCommonStateClass {
                                        Error **errp);
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
-    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, uint64_t len);
+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, size_t len);
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
 };
 
@@ -173,7 +173,7 @@ typedef struct SevLaunchUpdateData {
     QTAILQ_ENTRY(SevLaunchUpdateData) next;
     hwaddr gpa;
     void *hva;
-    uint64_t len;
+    size_t len;
     int type;
 } SevLaunchUpdateData;
 
@@ -886,7 +886,7 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
 
     if (!data->hva || !data->len) {
         error_report("SNP_LAUNCH_UPDATE called with invalid address"
-                     "/ length: %p / %lx",
+                     "/ length: %p / %zx",
                      data->hva, data->len);
         return 1;
     }
@@ -945,7 +945,8 @@ out:
 }
 
 static int
-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, uint64_t len)
+sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                       uint8_t *addr, size_t len)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -1090,8 +1091,7 @@ sev_launch_finish(SevCommonState *sev_common)
 }
 
 static int
-snp_launch_update_data(uint64_t gpa, void *hva,
-                       uint32_t len, int type)
+snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
 {
     SevLaunchUpdateData *data;
 
@@ -1108,7 +1108,7 @@ snp_launch_update_data(uint64_t gpa, void *hva,
 
 static int
 sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                           uint8_t *ptr, uint64_t len)
+                           uint8_t *ptr, size_t len)
 {
        int ret = snp_launch_update_data(gpa, ptr, len,
                                          KVM_SEV_SNP_PAGE_TYPE_NORMAL);
@@ -1165,7 +1165,7 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
 }
 
 static int
-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
+snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
 {
     KvmCpuidInfo kvm_cpuid_info = {0};
     SnpCpuidInfo snp_cpuid_info;
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 06b44ead2e2..51301673f0c 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -6,7 +6,7 @@ kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%zx"
 kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%zx"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
-kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIx64
+kvm_sev_launch_update_data(void *addr, size_t len) "addr %p len 0x%zx"
 kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
 kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
-- 
2.45.2


