Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F204BC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLc-0007fw-Mw; Sun, 04 May 2025 17:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLb-0007f9-2g
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLZ-0005EW-FF
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c33677183so43680535ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395884; x=1747000684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yJ6sh3pLgJKtEU3rXRYV5JYEmSVW7VzWbjTxsoRblQU=;
 b=u6TGHhkHWr6roR1I8L+WO2zNeAYMIBxw3xLct50spBmYj3YqnWtEs0DQlyZHzQRj2c
 21tu0glO8zo32/L73xqCvfTMdD3syDtsLB4GG7mkjGhe6/KlBEIWJlswXXAZxUaHEuvv
 tYaOLmPHzO8cIfPBCr2oI+LfbWxE3W60ZMs4QBB845UR074DKcndiW6vUevadsofkK6k
 SkqCNcRsH4ZgDjFmGhqJtj9PfQeGKzWTKQE9ovm6gu/GjvB4wUw//81UWBJI1M0E3H2r
 v2/0MxbcR/g/PjE91DtTNxDS+aKYsg2tAPbFZFc47SHt4GkEmL0SsPGRTtC8zW9po0+e
 k7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395884; x=1747000684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJ6sh3pLgJKtEU3rXRYV5JYEmSVW7VzWbjTxsoRblQU=;
 b=i9MJ7jR4NTTwE8ErwoybaTF0d06SD4Zkr1jsR94JC1FoWhZBqQnaPDay67EorrYbpx
 +1fouyRrWZhjCAgAOwfbykDxENGfefKfyUB71JT+aOCbHzMJ/3hgR8arsY9KZFzce1Lr
 g4Xbx/EGtfroiT0jYyjvpHRwPQJUjt8zZ0/C51yEMgXxOgLwSm3nkPtZ/J0xiAd1LSQV
 2LQPXL2W1MghBfrsugJyY72+6FruJyth09qlDdmgh+ANA+HVOtKhBOaUPv3CnNu+y/W3
 DjtO9sKJ7pi9JKhdOb1E/mhbtVzxBzZVwrrR7PAlab/39vdKn+prPwPfbON1D14T0qwp
 vprQ==
X-Gm-Message-State: AOJu0YyRxEkXRp66s9HOVo3KovywD1inVfx8VH9fX9BfpcBqRvDyXmQl
 Seml5Y9YHUalEQPZNVJo0H47J/9CKZw1qUY1syumQSd4ZDOCALrMbWNTL3sL5ADPnBa8L6Ydzsj
 DE+4=
X-Gm-Gg: ASbGncuq5lqFLeCSaadbvEIzS+0+oHLAp0mRON692OylMmdJ72yF0D9hPQJNZ4PAML9
 PkC5w6dd50rFVMZrd671YCe2/AxuIIHPl7GcquHqnnEzPLqlQMaesOs9XGW5ykjgbyL9OJeUI7O
 YEEj5sr1221V9+XIxkmyeD0LuyCFG+tWLEdQJfcG1kWRLLl/ARze07ZD4dpLuj8jAoH6/NmSEBb
 LJDVKmJfTV0rz0GYNxQmspUVHamXRw8ALuoJ7KmQSzHqMLLJ+8SKFnIQon+Thnkd5zhYi+GKZDF
 yMA1ft8OvjuWFBLjt61EKGEu4IWSxlaZnF/eAs0K9Kafehte
X-Google-Smtp-Source: AGHT+IFTAEMZjB78zEYVogYT/aTb+2aaCMQnggNO7XDMlAjClzSVCXsoxQzjdCAaycYD5MfxMW7g2w==
X-Received: by 2002:a17:903:120e:b0:223:5241:f5ca with SMTP id
 d9443c01a7336-22e1ea7c4cbmr63451245ad.20.1746395883827; 
 Sun, 04 May 2025 14:58:03 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:58:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/acpi/ich9: Remove ICH9_DEBUG macro
Date: Sun,  4 May 2025 21:56:39 +0000
Message-Id: <20250504215639.54860-11-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Remove the ICH9_DEBUG macro, which is only used to dump the value of the
pm_io_base parameter, passed to ich9_pm_iospace_update(). It provides
little to no value and is not worth converting to a trace event.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/acpi/ich9.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index a07c9d115b..967b67485e 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -41,15 +41,6 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 
-//#define DEBUG
-
-#ifdef DEBUG
-#define ICH9_DEBUG(fmt, ...) \
-do { printf("%s "fmt, __func__, ## __VA_ARGS__); } while (0)
-#else
-#define ICH9_DEBUG(fmt, ...)    do { } while (0)
-#endif
-
 static void ich9_pm_update_sci_fn(ACPIREGS *regs)
 {
     ICH9LPCPMRegs *pm = container_of(regs, ICH9LPCPMRegs, acpi_regs);
@@ -135,8 +126,6 @@ static const MemoryRegionOps ich9_smi_ops = {
 
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base)
 {
-    ICH9_DEBUG("to 0x%x\n", pm_io_base);
-
     assert((pm_io_base & ICH9_PMIO_MASK) == 0);
 
     pm->pm_io_base = pm_io_base;
-- 
2.34.1


