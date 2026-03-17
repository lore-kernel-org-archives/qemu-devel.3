Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E7AFD874D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TB2-0001H2-VJ; Tue, 17 Mar 2026 08:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8b-0008S7-Tt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8W-0001UV-E5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b43f5990dso1314810f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748978; x=1774353778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf40uxhO/fec5b+8gTtkOYyrPHsmu6O6HFwfVcu28uU=;
 b=PU1BfXHwhVeICz+gi8uRY6pBaYC7z0wgZx7hZmB8AlRqJ4xZ8Jxl+gQsNgFY623Mst
 0rQGiwW5UiQtBDHXdO4lVcm3Pr1RvppI7l+ksWAQsruAQKXM66m9B2Q/p3BHe/n3sRzu
 0NkT85bwg080IHHvz8t8Ejo3HW99fBHADNMuJuK3NHCPi4/lXX5wWb/kDU9qRfJuJTmM
 5Cw3rER4xyO2FkFOC9ZxKpGSnjq3dJib7eC263+Bhw2G9Vv60Ll50jaHW001MT55MUHE
 YOzKM2OmPPO3FiAKm+HwOy8dbDC4FZJz4mIEl+l2bsc72MIVOBMy4QvSuJXcfu7THUwh
 IlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748978; x=1774353778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zf40uxhO/fec5b+8gTtkOYyrPHsmu6O6HFwfVcu28uU=;
 b=XKb6HAh4IptXQkaOIHYVjYafVz594NNi3EVjarE+MWhMxSRgW8FNg0TrwUyp/ydMya
 X40Y7sT6JdtZC9ZbPzlzLMCv5uhFJWccXNnbymtNqnlaDJ+Zyw7wQaP1BQeFZGXrK0uk
 HMcyXBLoZn6k96l04PE0PNWefz+tIKXnwyAY0bDXmvXy6fl3QL9rA1ZNr6ehUKjutKO6
 8A8X+OLpMv9H8Hudv8e2yLjA0Pb3L24TY5dfs5zl9NdcbNrlQDIhzdJtyX4t5DufghcD
 EmK1FyPAWu8aqwWr6UwqWoIEl2w2Dwie0/hj/2ixZlnxtUIzsOTG+rbTIec4L3RhbuGK
 l61w==
X-Gm-Message-State: AOJu0YyMp9tFxd9lCCKPwFh69eMUKj9RbEzrfU47KEw+i9W1xK/vc4S/
 l5SB9/XdvScxjSObgCTlk7opBG8kv3mc6MCR9t6hkym9Bvh57s+JlBhHpCvkstkcSVKamz6yDUJ
 cIwEs+SQ=
X-Gm-Gg: ATEYQzyxyEGSS7RT4Ns4BHAS8NwOxJgqCYKesekUDgMKckbg0/++dpBCOkC9VhzgCiM
 irnRr/TsWGbFiECNTAlQ1eV0gc+2qR2kRGWJ/GDK4As8kLPlJ+jE6pq1wPwy5vksATyjHlS5faj
 BUSnadKlOY0QnLcftgSGAZzmnsMhZpyMUYNSSAaHPgR5TCzLXbd6y6HTvwgivFeSvOYWWl8rmmi
 2nT1+yL4LMBhdE1gdRhRLER5tNRDCXk76IYYEbthRwc5q1O3WNeC4OLGbZ7BcoyDxTl94n41jXc
 2YI4wiyxM6JAmeFmgqL+OWp8JpXVQL5iPrB80jxx90RMc/jxE7crNr41pKwu7+aNzKyOLeFUfhz
 T2qtT5rPh+bsU6dkXqIQ/pQ7jGOouV+vNs/od/TXO/S1uQYMDfN+lvCYrtnd5v6Qz+YSHjducoz
 EuwxgjkwzE5k8lZe+3F9bAY50lmbolpvN+kwuLI0Kx3Ibayf0o8ktW1g807pC2K715tkM/tWkI
X-Received: by 2002:a05:6000:2583:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-43a04db18cfmr32111462f8f.28.1773748978182; 
 Tue, 17 Mar 2026 05:02:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b46b41eb2sm14250402f8f.1.2026.03.17.05.02.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 05:02:57 -0700 (PDT)
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
Subject: [PATCH v3 2/5] hw/tpm: Add TPMIfClass::ppi_enabled field
Date: Tue, 17 Mar 2026 13:02:38 +0100
Message-ID: <20260317120241.16320-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317120241.16320-1-philmd@linaro.org>
References: <20260317120241.16320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Each TMP derived device has a @ppi_enabled field, itself
exposed as a QOM property. External layers (like the ACPI
subsystem) wanting to know whether a device implements PPI
has to check for the QOM property available. This can be
simplified by declaring a single field in the TPM interface.

Here we add such field to TPMIfClass, before converting each
TPM devices to use it in the following commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/tpm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/system/tpm.h b/include/system/tpm.h
index b90dd4e8cb0..9458ad6668a 100644
--- a/include/system/tpm.h
+++ b/include/system/tpm.h
@@ -43,6 +43,7 @@ struct TPMIfClass {
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj, int ret);
     enum TPMVersion (*get_version)(TPMIf *obj);
+    bool ppi_enabled;
 };
 
 #define TYPE_TPM_TIS_ISA            "tpm-tis"
@@ -84,6 +85,9 @@ static inline bool tpm_ppi_enabled(TPMIf *ti)
     if (!ti) {
         return false;
     }
+    if (TPM_IF_GET_CLASS(ti)->ppi_enabled) {
+        return true;
+    }
     return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
 }
 
-- 
2.53.0


