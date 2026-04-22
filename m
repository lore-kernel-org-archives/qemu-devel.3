Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA60FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkX-00070T-JI; Wed, 22 Apr 2026 16:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkS-0006hF-5c
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkP-0001zO-If
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so52312185e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888030; x=1777492830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tKKgOnY7W4pfIUOPQqfOdsFHNmAXFxNShvdnDNL3w0M=;
 b=vMR9r3gIyqhX0JhKm1f+oBDF52470E1wgPk0Ou2urIGvsZm5T44AuOFAE7RJYhAfc1
 iRv+z6AyfZ7clB63QUCeIOq7DDUJ3+tfNgbLODMp1EmRtIthZCgpx7EBw88FF7KuoU8Y
 CCozYzlF7XLCiznBud+S5cZUjNIv14q3KTNcsDfHO9rWsWvEIRWumpyfCCPDsHiPbXQK
 Q74biSoPBDEBlPF2cWW6MgyTsb47ZrZTVL0m7wU+doYbOYUWto7ynj+AeXTLsPcSIYiG
 kOD4MNwA7LPPlEgAx9To4TEx9CzWwXdUxj6qQn3unE5GScSo22HKcrsXxp1aK2O7Jdm5
 tXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888030; x=1777492830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tKKgOnY7W4pfIUOPQqfOdsFHNmAXFxNShvdnDNL3w0M=;
 b=Bv8MhM1tCh771kvR0nuU9RYXsNfm5mRwJOblnQuhdC4t4P7f8GrwJFhaKRSQo5kPdh
 thJmhaPEZufhYysusRoyjQfGNb/45AjgrNRpfbrS05kSbJUMoHRT4k6jvUDtrRhYLr4j
 iS7VDUzx/XrGm/BieiyYSGG129y3t7N7ZjcvRyS15SzZnLBBihO3C3fHve0Lu5HOrJ/7
 bGwkoybJz+OjiS4Q2IOJ79Ht1Kij2GT9+wNMwx04RM4VJXl8C53pXA5tSyeOdpzHFkGj
 NKDWno+qsE8eFwRddnHuclrzcDOVo+wDYGS4hffTPGDgEC1ZA7Q6xo/B74wjyFxVN6rd
 Czgw==
X-Gm-Message-State: AOJu0Yw43+8dXl7VXF5VHjdMqQGkpu306c1pN+7BQ443LmwnO7PC1liB
 ++mkeCvUH4thIoBeeYVH2kHC3PXaZ0gjifjyGuw4mRUwNzInIiJQHRoVlQlGiHBtGuvpT+Rb7Ws
 swXBQzKI=
X-Gm-Gg: AeBDiet4g3mvMr2tmRCMM/OAHMj99KdpKQ/sOrDD9LpcZXN2tn0gGHYnYaLOTQACiYF
 I5UERnkTLUbvqxO/fPPNJW0lzUXrXKgFBlVwT0vWAIKQkTM7mEn+RiOtCql8r4er4v/RhcChHZ9
 fwEkQklpxx9ISaizYGd1/wchhXOWRG6cYYoMTTxuZFgwIXVrnkEW5JWL6U9HT/dmz6KJwpaPzsK
 rYropbbp8I4oGFtEA8T2855LDwsCCTCpjZkPp1LzMKJBjHx1s/bLV+7+8xD3wSi2w6EYMcO0Zsp
 gvXbhKUJxQd94acJ4wWaKwBy2Q1xyG9ZhpqCnGtS3T0L5YQ4RCfNtak4oyLQOXsKHnoXdP67kqs
 9y6AmF7KkwgtLJU75w/VmkvuTR9mDybDTBV7bbLa96A5M75eAri4hDKljbbIpuAFMvEGYFzdj1T
 F12OD7e/xNippSit+WPaPHLc1YBWlK6Ry9xtNluuvIZQfEbtGn/HB7ws3wcBqnJGeMbS+fgCydd
 P88eZ0x4uw=
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id
 5b1f17b1804b1-488fb78e576mr236453525e9.27.1776888030496; 
 Wed, 22 Apr 2026 13:00:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm210103615e9.0.2026.04.22.13.00.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/48] hw/tpm: Simplify tpm_ppi_enabled()
Date: Wed, 22 Apr 2026 21:57:21 +0200
Message-ID: <20260422195746.88865-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20260317120241.16320-6-philmd@linaro.org>
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


