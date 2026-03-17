Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7789FD8748
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2T9A-00007e-9d; Tue, 17 Mar 2026 08:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8S-0008Na-7d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:02:57 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8P-0001TQ-HG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:02:54 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b97b30fa5e5so389454066b.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748971; x=1774353771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hT+7qDaS9TXLWUeu0HUQpIId7ZLbZMO1RZ4Wz9uV/gc=;
 b=F8sKJS+5BzD2k3l0Sw/0tS9sI6vOtZG59c9Dr0fp/hL3Hv8My1mbihIoF7ZOIn1gHq
 kei9JK66edceC9RuJLocClZtIwNuhKtgijGbvIez39W84dVFDh/dOcmRgb+b7tz3Culr
 HzPiCEAjUZI5VBg8H4+ehyki/M4LjUCRPxgUeyo6g77Ue4yUTN+6OSm+zJyfUJp7+oR9
 FnFFCu69JjeDvK6dp1g2GENg4UDOzZj5+/5iwnxVQMyXi9PkAPu5J0/gE9uyF0vYDSIS
 jfrO7tlJ0dJcFhGs0O7LlcWuzN/KHy/PiM+mxQmSFchzL2N5KYoDtbTXyYz8tWxF6jJU
 xzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748971; x=1774353771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hT+7qDaS9TXLWUeu0HUQpIId7ZLbZMO1RZ4Wz9uV/gc=;
 b=jlTXPG5wup7OEug1cDof8Abt4FmoMwZ2QiY5lA0ppH+iKYq+zuO5+tAJbRCwCf4UFK
 6VfUj+cUlAQO4TwDlT/51iFjMf35U96ONdOf2PWDELHjArmJDtM82JQCFOYidqY2g3hs
 x4NrAObPvypXiNUK4+KcxysLHUiwRQ3sVOYP9/+rZZhFgb+P805iOwSvGmZewOmrbT3b
 jdB2CMMmnIVY9bgHJ8xbnmaCbrgg5Rl5I5/T0GcpA1i9rjFJJv8SfJscf73k/5X7E3Hi
 0O1m/U7uDvjyj8wT0UaacQWB9JolsnWGConSMzswvGD7gDZ1RHK0RWvzQOVrlNI2wDDr
 25sA==
X-Gm-Message-State: AOJu0YxYxPHMCsiL+ZUo6LASUYMFn6fcfMQOP8C+J7F9INasLreVGIYJ
 pDnOWikvv3HwA+32cqBjoYwCbHMsOmall6LzliJ507PY9XJiWS/NIIpe9hkZDFz5KGMSeNZSkSO
 ew5/Qp5s=
X-Gm-Gg: ATEYQzz4Wmtw9RZkp2ImB36eJjo93mfsgUOfPfi+4CieqyyQmhxczaZtaj35p70pVTv
 PyPUgIVUOOManJku0GpUCnDzLlOX8PJLEE4KTzr6w8uDHr6TWH098diX+zFF8XROAH7rq2MIl49
 Mjj6DjcGMm6yxEtY5Kv7zNKSavWyo6jmOyy4p6sNVv3lqIYwyfcPRgnlyt95MbwC40hgKus5PLj
 1PGWaKFvj2x80cfQCZ2la85NK5CfwyNRvHq5upmM8qi5T/GHbnz94jyEE5yDz86q87SIpTYrLjb
 faP6VYGRdEPCA5Eum1h8SaDeQZsnMeStRP9GxobNBRrWnR+4uZ92DfaeehORzIbdQ2z9GLJTSwx
 bAwYSMKp08dw/2rBqOgEcEMU8Pzu7oeyfKGqLpuPuTbohKTZYSCkI9ncqAQGTLxLUHuyRU21Rpg
 pOEXDmziGteMO1q3RhgNGl7jHfJYN7l7tduRCkm/HW/j1g2n9O78+3P6jHF0vj1KrWDx9uQ+bX
X-Received: by 2002:a17:907:60cf:b0:b97:a64d:8599 with SMTP id
 a640c23a62f3a-b97a64d888fmr589634166b.11.1773748971040; 
 Tue, 17 Mar 2026 05:02:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bb90sm52848199f8f.19.2026.03.17.05.02.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 05:02:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/5] hw/tpm: Factor tpm_ppi_enabled() out
Date: Tue, 17 Mar 2026 13:02:37 +0100
Message-ID: <20260317120241.16320-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317120241.16320-1-philmd@linaro.org>
References: <20260317120241.16320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Factor tpm_ppi_enabled() out before modifying it in a unique place.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/tpm.h | 9 +++++++++
 hw/acpi/tpm.c        | 2 +-
 hw/i386/acpi-build.c | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/system/tpm.h b/include/system/tpm.h
index 1ee568b3b62..b90dd4e8cb0 100644
--- a/include/system/tpm.h
+++ b/include/system/tpm.h
@@ -13,6 +13,7 @@
 #define QEMU_TPM_H
 
 #include "qapi/qapi-types-tpm.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_TPM
@@ -78,6 +79,14 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
     return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
 
+static inline bool tpm_ppi_enabled(TPMIf *ti)
+{
+    if (!ti) {
+        return false;
+    }
+    return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
+}
+
 #else /* CONFIG_TPM */
 
 #define tpm_init()  (0)
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index cdc02275365..5fe95f2e3f1 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -25,7 +25,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
         *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
 
-    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+    if (!tpm_ppi_enabled(tpm)) {
         return;
     }
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f622b91b76a..4f01e2c476e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2218,7 +2218,7 @@ void acpi_setup(void)
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
     tpm = tpm_find();
-    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+    if (tpm_ppi_enabled(tpm)) {
         tpm_config = (FwCfgTPMConfig) {
             .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
             .tpm_version = tpm_get_version(tpm),
-- 
2.53.0


