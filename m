Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5EDC636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIY4-0002eE-Kk; Sun, 22 Feb 2026 18:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXv-0002Mr-55
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXt-0005zb-ME
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so33379885e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801644; x=1772406444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qd0G+nfyztxAJMOwNcY/97xGBoHYfcp5GPMnR6QZ8mk=;
 b=DCFZ8x+/7Qs76cfHF4vkaDY1K8f2KnAQwd9nu9AfWulJ6RE6ua8FMxh5r6DISejpRK
 YikBUUYLsEhfb4h3koktrCKJzvkQZFrHajS2m55JcKtnjNQrH1gnDDIYqqdgHx85VozA
 oHfH1VgUj0lr4pVY0FayIIzzsrLjP9eH7Rdh/IUKBGShVU18DfzRaaG9J/3anjrJmbOW
 u0N4WNvQQ1E2GhyQai081URpPeUR8d8EcFBkkqx126nRGZTIblV3yBXwzg8WWzMmv+Z3
 4ga9q8mwIBmby4RkYxBjrj4bPG60t/iI3GkEVQOGOKMlq8N1yOVoiQjafsUk3TXcZCQa
 5mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801644; x=1772406444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qd0G+nfyztxAJMOwNcY/97xGBoHYfcp5GPMnR6QZ8mk=;
 b=a7jD5f0rEWPZ4cmY45sC44nNfHMnsEkPnfxlmOyXm5oCK+d/afDtoFJY1cLPAKv6u9
 GVVL2EtEyQynKIwL6kCi5yLEVdBY8d5j3+CQrHELyLVRd57ZvHoF1ZVEcPMFYOigI7sx
 a/7GL4gpADyqXaoanoKKGRy8dPJ5ajFM7eW8ZXYId9fji6MsPx948BbUi7e+6N+bIrO5
 TzOZF+T1cToFeoHJNVogXjZ0+uL00mKjUSA3vORzs5hHNLd+72jTTuWxsSyGoCcgOB2q
 a0ejdRwwjRbcNGL/WelyVyBFoY/a6mMMIC2BOZ1MXFVEdT9M9LfQTUg4OBt/strdLciB
 fdAg==
X-Gm-Message-State: AOJu0Yyra0AvbAhTwCpw8rdH1pywX6akjY5CksgEtanShrsLAPozW+EO
 WZh3EALUe0BQiScyr0YzX99iEMOE8v8puFDjuBJcT4iSe//7inwTQvqB/vvLNChTPRrdBPNNCFj
 KJ2/j1go=
X-Gm-Gg: AZuq6aImlMwZohD/nqgFFkVf5yQxnDVplcg9ixc8lUhPwFMm5JiJORP8AS73CEtOHDt
 0+gA+bi6cxCNviDzGDI6wPy8gptMz1i12+LYCKNaN2vojLsLmmbXXz/YLctvah+jpyHxIP1BX/W
 K2UtRC8esJFF/ETglP5iXfhzJyIZcvoKCVNSU75lEO+rwuz7d/drckHIA71T1balaqWm01M7hhO
 e8Z/VgoMvd4y/47FQqbFYbv2GME/JYed/Dzcuf+9kJzpeDr6jYjoBndSs/K23DJPFw1ZktiHDuJ
 fVaTTvx1bggR0/GTEaRj+5cCv3Ahu+1Ny3jQsJ8yLEFfGmkNW8DXTvLkC+GYC0aEzgQFH1vi2KW
 KTaTZFT+PWZJh8bWIhnV2f3acV2/OFyo21uonEtujrf+ud1tAXHHqJDnEa4JrLcIgW75a7Jan5/
 ONzp89xD/LiAS1NDl4ks9qLaKjCap8VYHQud7/lpTFB2CWQ3XfitZTAwTSyJYWnUfJWZzy6gxuv
 rFcsgcV9kQ=
X-Received: by 2002:a05:600c:c1c8:20b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-483b1c6a605mr29498915e9.20.1771801644001; 
 Sun, 22 Feb 2026 15:07:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42ea363sm74687245e9.18.2026.02.22.15.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
Date: Mon, 23 Feb 2026 00:05:53 +0100
Message-ID: <20260222230602.5756-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allow to include it from common code (vhost-user, in next commit),
else it pulls ppc/cpu.h which has target specifics.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260131020100.1115203-4-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h        |  8 +-------
 include/hw/ppc/spapr_common.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5476ac7ce7b..b022f8dd25d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -4,6 +4,7 @@
 #include "qemu/units.h"
 #include "system/dma.h"
 #include "hw/core/boards.h"
+#include "hw/ppc/spapr_common.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
@@ -946,13 +947,6 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 
 #define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
 
-/*
- * This defines the maximum number of DIMM slots we can have for sPAPR
- * guest. This is not defined by sPAPR but we are defining it to 32 slots
- * based on default number of slots provided by PowerPC kernel.
- */
-#define SPAPR_MAX_RAM_SLOTS     32
-
 /* 1GB alignment for hotplug memory region */
 #define SPAPR_DEVICE_MEM_ALIGN (1 * GiB)
 
diff --git a/include/hw/ppc/spapr_common.h b/include/hw/ppc/spapr_common.h
new file mode 100644
index 00000000000..a315b685805
--- /dev/null
+++ b/include/hw/ppc/spapr_common.h
@@ -0,0 +1,17 @@
+/*
+ * Common definitions for PPC sPAPR
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SPAPR_COMMON_H
+#define HW_SPAPR_COMMON_H
+
+/*
+ * The maximum number of DIMM slots we can have for sPAPR guest.
+ * This is not defined by sPAPR but we are defining it to 32 slots
+ * based on default number of slots provided by PowerPC kernel.
+ */
+#define SPAPR_MAX_RAM_SLOTS     32
+
+#endif /* HW_SPAPR_COMMON_H */
-- 
2.52.0


