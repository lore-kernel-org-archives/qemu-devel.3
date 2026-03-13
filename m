Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7704106FD8B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvo-00082O-5o; Fri, 13 Mar 2026 02:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvm-0007yN-Sy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvl-0007A8-AQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so20213125e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383007; x=1773987807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hByIDtQGy+CTZ8ldjYuhIvH/zTTZopDKPTTvR3uIF/c=;
 b=e+xCJP6CXVGzjDuM1ZAKHe1ORYRzzBhgmrbgHEMMwNmbDITp8DLF0s7Y8BanqtYCzy
 uN5St+uGmzc7isCgTp6baUDgQjmVH/O0ak4eBqazd/7Kpuk+uXlRA7HPhQz3pNCvNUwm
 3fIzMLtpEGZ87Xaq92CHJ3rlfADxQyAavSE3v4JFPBxPDHRoqFkJGSiANN4be/LvDGCe
 dVht/anzUcrL7ykhwAx6wHUKSBr0V8c5R+vIgEEPZNfpzhAXGXknrly6MBMtx13DXNpJ
 K7iVFdOC+D65nMgG9HmBawhlE48S04AJbzrwmQ1XgZGRJJIj7K/n1tooTywaH+rQ/Xsf
 3S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383007; x=1773987807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hByIDtQGy+CTZ8ldjYuhIvH/zTTZopDKPTTvR3uIF/c=;
 b=GzqIHRm+6VpPkan/vpXWonv1GjOqA2cOPlqaoATEKXJUJ0dwPfpF9TeS+Fwbbs/dfK
 iUuu8iUjKq179JuDJBaMiZ16pFvu3NTKZptJhH1TTm6daXOUB01d3Uie+eOumpYoOR/F
 t5xS0gV3lLcqVYkd91M4rUakLByYhlWETE48qZgbz/uVQAw5YYJjZJtzBfhvbht1av12
 mFCPWo+FOPxotMf3c8wc8R9iicdEx6EInHL6kR+r74IqjP1kK+z6CR10xnJEHCPfs98w
 O1qPRx+AHUv72n0wepxs5wQAb2DyxgY60Ny+Kf/CHV4CkRd9CAZ3qpl6uiuLklA0ZsfX
 OOgA==
X-Gm-Message-State: AOJu0YwXzAXxCGRk/2D3GfKZmhnslCKWxEybqPb0m3EuPDMmZhEmMIbU
 BwYs3+6DmSCpAk9OndM5PdFJnSFFXmxTIi6zebkKe0IGNQG+JdJSv+mdJiOHGQDvmJa+kvvwLoR
 lQH7XA7Q=
X-Gm-Gg: ATEYQzzI/OYXPU26VHcpV3vIeGyM61embkcZ9O+li4FpXEzaEYfYtWjXr35aybL7CHD
 tujRSUXZ90vvQgZzx9Apgqu91uNFyxrPQ/6eLf0FlWpPGfgTaBJiKc6a3UbzI6ZTtWJK+C6narL
 lMGWdfZaBpHIpwiYloptUynP9115WRk7g9HNf+m/vERtsfmgap7amp7s/Qqw84Wnbg0mZqd4LQN
 Z4PoOCRpF+TAxZAZs9VAiyE5FCm91SjI2A6DZpqH7cFfGhztWm/l73lHQBmhKemRvMJMSGMe0Cx
 4I8gkZPP72Dlq4mLP0DVlUuni1VCxSzwCcg6eeQvnE8SHHjovND0VHWRY+2YqRE6uxzd6GxnXKc
 hzkDnmJqPOCVdcY4A95GYmlMw+eBxMVo4M+nDDlFMeRKpJ/plahoqfL17n9Nw61GWXATuubpxwW
 wrg7DsSYK3QYyDskS+rB7slorgrc0ErQYCmCEVFhGee1v3voEO4/52806j2YMA6BKg5LQc7HOgO
 Xbm8+B+pALz5Hyg
X-Received: by 2002:a05:600c:4f8b:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-485564981d8mr30755555e9.0.1773383007317; 
 Thu, 12 Mar 2026 23:23:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1aa2c3sm12513417f8f.13.2026.03.12.23.23.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 22/38] hw/avr: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:38 +0100
Message-ID: <20260313062055.2188-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/avr/boot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/avr/boot.h b/hw/avr/boot.h
index 9eed2055591..c5efa54d98c 100644
--- a/hw/avr/boot.h
+++ b/hw/avr/boot.h
@@ -12,7 +12,7 @@
 #define HW_AVR_BOOT_H
 
 #include "hw/core/boards.h"
-#include "cpu.h"
+#include "target/avr/cpu.h"
 
 /**
  * avr_load_firmware:   load an image into a memory region
-- 
2.53.0


