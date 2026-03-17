Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01521FD874E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TBF-0001XJ-8E; Tue, 17 Mar 2026 08:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8v-00005n-IS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:29 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8s-0001WR-IB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b97c44417ffso220492866b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748999; x=1774353799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edjJ3hkKxyqQdGrTaKvvXfJRX41bmdlovs8WuMQ2HOU=;
 b=ql8b3iiE6WsoGP8TgfQrZ2Hp92bRNDFbt5UMbhL3bikysuvu0Z30PqsJbH9MhmpavT
 9BV7wjeW6jg2FqUEPLdpj/oAMn5k1sugIb/C/7HG0xlxChqitxMBY8nJXE++SOUpJNfK
 tF3TNib57zwetvgT0gicKZnqtm1VnDMZ/Oe9lqG8ZFROkDQCkED4MLP1L19l6DCl5vgY
 hfMMuO3vouhQduZfS84z3fl/9qJLcqmbAL1Tgrday/ru/VMzBlfcsUgHcEeY3mRFA3Th
 LkOU21d1Kbm14F03HfEjFuXN6O2klsPcLMkYfEnmzOizdgkUD8O+UENIDkQciPYoH2l3
 Kg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748999; x=1774353799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=edjJ3hkKxyqQdGrTaKvvXfJRX41bmdlovs8WuMQ2HOU=;
 b=Sc4BwYZyfPAZxWyvO+X9w6attYy2Odw4tsCpEnTZ9aEDY0HVfYX6C67/ZIyEceBsPm
 Uw8P7IS09Ra6TpXZ/XGGj21cfikbVSZyPbXOsyUFXyIi1QcGKTwGNRS5HtTnOeEwXUcc
 TKu3WlPYqlodo4V8RbkLbnepO5weeVQcuGrwa8HV2Kvfy4YRbkDDtb3rdkTaKzwZySm4
 iZ7G3BjpzUCDs8luyIBp8VF/uQ4XFuhUSL9xxCj+az8HDI5Ci4xS/CvbJnfR43QWGu1P
 VKNrhz6Sb7ugPDTuadmJzeM3xQbLV7pVjB+YyBIn6Ckk0CSOr9l7UKawwR7Jx5b+TMEb
 b5Lg==
X-Gm-Message-State: AOJu0Yy8MRu/9lTyPad4CcqtdFf73+G9/B9cy1NRnOyXt+O4x3uPo/Bc
 EdXl8QQTiWevi6XR1mKa6FqYeb+9gbKIOTWYsB5Gqg43wjbrrV5yl4BdayGk6+MNlc25d55spIO
 xyTy33aY=
X-Gm-Gg: ATEYQzzx9atMTelYpjlmwHB6RFRAkVvaLyW4PCS4YBqedprlGrtJC805A9hrdLajtIm
 mo8ouhFEM8DxbkIF0IbJ8E1UstikVOQmcAjmPNHdoHeuBOhtKDImzvGIxfFpLrTQSvuYtYWaqbL
 Mnfy99kiXKOIMbA6ohC3LsMvnmKvm46G9e9BPyvpX67z0IEJTNUTr1NwqDBMDkpKLUREDV6ByHK
 c3HWfWN6PAd+7m5uck1ex94Ox86x4uobLDDg8CxGHlY7AScIul+EHhy8pw7D/9hXj75fQtacgGY
 S8+vtM44jalKBOw3b6ULR27Ubii/KblEV3kCiZhmvk2Vb5C2ODNkuhRIqwhCV+S9NOutJ1aYdKy
 i2RRy9DiKHo4V1/e2bo/qYL4QWApLVLM+5Q/x3z7YCJNF4/jlrqTb5JHcB5bqDmwnS/hoTpVi1G
 czOwFh+r9hgWXrM6VN6NOcM0bzwGM6EW9juAT2Vbky12Qggt++QhpnQEzEFCHpzK09FpKgSDic
X-Received: by 2002:a17:907:a44:b0:b96:ecec:2386 with SMTP id
 a640c23a62f3a-b97650b702cmr1104302666b.26.1773748999059; 
 Tue, 17 Mar 2026 05:03:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b41dd93c0sm18105870f8f.10.2026.03.17.05.03.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 05:03:18 -0700 (PDT)
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
Subject: [PATCH v3 5/5] hw/tpm: Simplify tpm_ppi_enabled()
Date: Tue, 17 Mar 2026 13:02:41 +0100
Message-ID: <20260317120241.16320-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317120241.16320-1-philmd@linaro.org>
References: <20260317120241.16320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TPM instances don't expose any "ppi" property anymore,
remove that dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/tpm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/system/tpm.h b/include/system/tpm.h
index 9458ad6668a..874068d19a9 100644
--- a/include/system/tpm.h
+++ b/include/system/tpm.h
@@ -13,7 +13,6 @@
 #define QEMU_TPM_H
 
 #include "qapi/qapi-types-tpm.h"
-#include "qapi/error.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_TPM
@@ -85,10 +84,7 @@ static inline bool tpm_ppi_enabled(TPMIf *ti)
     if (!ti) {
         return false;
     }
-    if (TPM_IF_GET_CLASS(ti)->ppi_enabled) {
-        return true;
-    }
-    return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
+    return TPM_IF_GET_CLASS(ti)->ppi_enabled;
 }
 
 #else /* CONFIG_TPM */
-- 
2.53.0


