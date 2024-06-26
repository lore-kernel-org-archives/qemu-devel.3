Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A072C30658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 19:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMYeq-0007K9-RJ; Wed, 26 Jun 2024 15:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYeo-0007Jd-2R
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYea-0002gu-5O
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7066a4a611dso3363110b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719431394; x=1720036194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S99rf0kx9Z6i/Im5EEPLTtd6se1SVxvRu0Sq+1mhxcE=;
 b=dGH/XXrHGl+eFynL5BlooT+NXxyc5YmibuSWubzTtFQORN9vGBkHZNmhH+8b34ZcqO
 y1Pe0qGrRROFGrF3Y+k6LrY/Pd6jNhYtIJcuSwxYomfN+LK9DUwsRykbwBhO6pHb0Vnq
 0CA3vFaGgJSRXzd6FE8EeeOb3xOnlWgXObB9Hvmju4sYDHKZ2u3sDWrcOZGlPLHWH6M8
 ptffOMxcGUc6D73W1AM6k4eCLR66PKOSBskpMI98yvDCjIQFaRZxinKj5rGuy6eZjz+E
 JNXV8lDvTW7nbhW1dNdhir/sSHJN6R1vtVzigK3k+nKDb0rLkEM3bam/NXgyrc/1xsnu
 +n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719431394; x=1720036194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S99rf0kx9Z6i/Im5EEPLTtd6se1SVxvRu0Sq+1mhxcE=;
 b=RgOzV+0W4lUqs67XmKK2/LhkWNbg+8Y2A/7xBwuaKfqnlHLsk+NW0BkKCBr4I/QIW+
 T9zwAzynA8DB38x2cy04c6h2VM4JdGCmmac4p7qgk/fm2swBMpqDQ4j09uAOCPOepNA1
 pcHN6KIqdX4CyJCd2u0348aaewZDvInFSmudujS/QrlTeE+fnpkgnKvUJG9lMCixBoqj
 UWW+p999vyTQPG2isGpC6qUueQ+qy13Q08P56EFE7J2aGOh5NEk8kao6M5djq13chAjx
 IoS9CqQ1YyZxUfX1t5Ilx9qjIEZ29W8bOAHJ/nxjltoXuYzBjmvR+FO8K2C4SAgr+5yc
 WLuQ==
X-Gm-Message-State: AOJu0YzBd47rqzTOSVC0y4fNEDfgyZ6QFt5goTxAqB52FCHdgfb126sR
 aYrt2IyYx4dkJPOq3FprxVooYkuFOJSF646CPEMcbH637CxzVOadPrSH4uiWodB7B/PKwIAl4Hs
 7
X-Google-Smtp-Source: AGHT+IEzaQG7bBR95s1I3iv/iLblzQ2j02qBOjdYHL12ZfNwTBXvRBOqFIJwNqicaQNi4fAJ/fOuhw==
X-Received: by 2002:a05:6a20:47e3:b0:1be:c4b9:c216 with SMTP id
 adf61e73a8af0-1bec4b9c416mr1447148637.7.1719431393735; 
 Wed, 26 Jun 2024 12:49:53 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f0318sm103734625ad.2.2024.06.26.12.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 12:49:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH 2/3] target/i386/sev: Use size_t for object sizes
Date: Wed, 26 Jun 2024 12:49:49 -0700
Message-Id: <20240626194950.1725800-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626194950.1725800-1-richard.henderson@linaro.org>
References: <20240626194950.1725800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This code was using both uint32_t and uint64_t for len.
Consistently use size_t instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c        | 16 ++++++++--------
 target/i386/trace-events |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dfdac69ab..f96301f81f 100644
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
 
@@ -171,7 +171,7 @@ typedef struct SevLaunchUpdateData {
     QTAILQ_ENTRY(SevLaunchUpdateData) next;
     hwaddr gpa;
     void *hva;
-    uint64_t len;
+    size_t len;
     int type;
 } SevLaunchUpdateData;
 
@@ -884,7 +884,7 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
 
     if (!data->hva || !data->len) {
         error_report("SNP_LAUNCH_UPDATE called with invalid address"
-                     "/ length: %p / %lx",
+                     "/ length: %p / %zx",
                      data->hva, data->len);
         return 1;
     }
@@ -943,7 +943,8 @@ out:
 }
 
 static int
-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, uint64_t len)
+sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                       uint8_t *addr, size_t len)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -1088,8 +1089,7 @@ sev_launch_finish(SevCommonState *sev_common)
 }
 
 static int
-snp_launch_update_data(uint64_t gpa, void *hva,
-                       uint32_t len, int type)
+snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
 {
     SevLaunchUpdateData *data;
 
@@ -1106,7 +1106,7 @@ snp_launch_update_data(uint64_t gpa, void *hva,
 
 static int
 sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                           uint8_t *ptr, uint64_t len)
+                           uint8_t *ptr, size_t len)
 {
        int ret = snp_launch_update_data(gpa, ptr, len,
                                          KVM_SEV_SNP_PAGE_TYPE_NORMAL);
@@ -1163,7 +1163,7 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
 }
 
 static int
-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
+snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
 {
     KvmCpuidInfo kvm_cpuid_info = {0};
     SnpCpuidInfo snp_cpuid_info;
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 06b44ead2e..51301673f0 100644
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
2.34.1


