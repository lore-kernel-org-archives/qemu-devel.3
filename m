Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADC9CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qq-0005yL-8e; Tue, 07 Oct 2025 10:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QO-0005oB-DY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q8-0002EF-S4
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so60038915e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846319; x=1760451119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XkB6uDpGjX9Nw8CrYgllpEhXvBnPXYlsb/ScNLCSbdo=;
 b=rhn7A/6Dyoe5zB6CVyXSpDXcs9GR91iZQ7fmtDzSSH+Kgw18Zg0fhraDDjdZc+mmwR
 xGUEBk6J8WJZSnkhUp7BNwbyi7o9ZSsH/DVFeH69AuPifzN9h62U/iJTBg+P9o6mhOX9
 pvOTsjHGdUH8ARbLn+UR/hkmmvQjHdZFy6sxvlyvjlFw1ylqk7DPJLQHMTJdh70y142H
 831haz+MJNQA2E3wKNESWM/HF1Wl/8zCBrz9eYS69Iy5V2Z78s5swe6r+4kiAo80+GUF
 WIT61vVgPEAA9ZDqPI/P4gT4tf5xogilaARyd6EdqvMOYt36sLzM5fmGnZ6mrinwGTT9
 4zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846319; x=1760451119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkB6uDpGjX9Nw8CrYgllpEhXvBnPXYlsb/ScNLCSbdo=;
 b=GLTe64M/HWPetgl2LyJ3S2eQmIY5RwNNOCcwFt3jpuLt3p7z9WRn8f1wToPaptx/XE
 Njn3m4njt6YbzmZ4HN1Cf6zqlHgRGW60ZKvZzUdT4RViX1OR7hjxXJJChenGPr60GED9
 6RwyQrwJdgUB0axRtz2qe/w2rlJTeG/RVAoSunClzZ/SSdjE/1lEoleYXQRnB8HXpXeA
 MMP/qeaotk5S9vE3b8acaqhqU1mK6vXOyTbSZTboMLmpp03JMtwSlNSFNSCN0l9ozylC
 egvBg4b49gzuRkBZEFPkFwvSm2bfgi5IQDzVa+aJILGfNRpmiXBOxFtN/n634yPQ2SoB
 bGDA==
X-Gm-Message-State: AOJu0Yy+40y7/yBRPP5xtXoyD9/CVJSEZhbHl90/ggLcofsvzN5ZZRa9
 c0qgcZhAJPS8zlDQkrXopmpZhqXzlUvRVSWzI0QHQ2Xi8MrKwX12uIZ8pWYMjC9x1W3bd6fnReS
 ZmoTa
X-Gm-Gg: ASbGncuaaTMElo2t8bbgH6paDqJpxA/e/s/yqWrdqk5cAunNAVltd8sQCPc4tBkM0XF
 zV4p4Kq/W5W79IKKnxV1+ycQ/br2mnfebTKhvG6sWFBqJKrwgcU52/dKUjEjg9/CnpodytbR+LK
 F0wi4tqCqryky3KNt+bTQy1aS7CYNnKts0ai4Vd+2azLieiwQ2Q9GWnNcCQNqeakGpnrH9qgohy
 /TugZNOBy2ScQhDdk0QTtGPHt6XnZNUjzhV8mjJQ8uUYpHex4YaXpf83HGdBcx3VxoSa79KUB36
 6k4t91dRh0Ti4metHIbm2QdnMnJx+sTSXv2UV220e71kPOtC7AufF23akAEz5Urm7V/zJNEsiSq
 XMRAEw0upOkynkeAjlGBtinojc+W9oN5FY3h460CHmO+ojtQJ0NuBlVl0
X-Google-Smtp-Source: AGHT+IGM3o0PjzPmKOIS+x0cdjzl/QrDe8zYhz0Ixs0QxDucwnZHzxtnRhNbBOJuLFqOevh3iKOi0g==
X-Received: by 2002:a05:600c:8506:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-46e7113f6e2mr119672595e9.18.1759846318678; 
 Tue, 07 Oct 2025 07:11:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/62] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Tue,  7 Oct 2025 15:10:51 +0100
Message-ID: <20251007141123.3239867-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Luc Michel <luc.michel@amd.com>

Drop unused include directives from xlnx-versal-crl.c

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-31-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-crl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 08ff2fcc24f..f288545967a 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -1,16 +1,13 @@
 /*
  * QEMU model of the Clock-Reset-LPD (CRL).
  *
- * Copyright (c) 2022 Advanced Micro Devices, Inc.
+ * Copyright (c) 2022-2025 Advanced Micro Devices, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/log.h"
-#include "qemu/bitops.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-- 
2.43.0


