Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0B5106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvk-0007iz-Br; Fri, 13 Mar 2026 02:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvh-0007TY-Az
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvd-000769-Kw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso16108585e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382994; x=1773987794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjA6sJ7x+19/UzPszNkrM8yAgPxIhNlCQ3fnVoQPV9s=;
 b=wr913yV7woXzSHZNrtK0IiaVdgaW+Y9wOdtCYk88+smjCc8WU1xsqzmniU1auPcdef
 rO1vbv/Ns8jz3gef5VoexIldeOjTHrL/UosxnZyIUYcSB1qlmk6KeRZpOzohP6O1PZO2
 9DokEW1nKAmj1ED3PdNQRjhnew1E8Ig2B2OyNVRpXZ3ff3JfgZz4+oqUtmrUJfalcfWl
 BL3w9B1E4pxRPoxA6tcNhvirWbir0DbaNNJCqlqy/DF8FJr8hBmJWpPFIlIirwAofZAr
 DzLHExbu5TyT5yNyIGZ4vW6eavRxnVdThNaxRPHy4ux61ya9AOqGIgTZ57Kqc4uy/cua
 OLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382994; x=1773987794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yjA6sJ7x+19/UzPszNkrM8yAgPxIhNlCQ3fnVoQPV9s=;
 b=LEIBnvWcCVlDPsnapVeH5NT7l6BJyBKpWnXlMjbDoMDb7buDuYMxSkJUISB//uotg0
 +9TDVxH/3wepUdVQFwxXO8IUyLxvtfgTfIUu3vUlXdwaX5Nc78ooG79FWfRekWrvC4pI
 5W2D54Sn7h7JE+AXRbFf6aJtL5kBhgzW8TfoE9zvCxaIdQOkjuBTUGDjtBoS4GadjHiE
 D3HuNMGEvTo62ELQ9QLy18GNcFFpTLNJquCI+7sJ8J/qyDldW92jNKEj2ETmr99Ojb6G
 enTVOWOmelD0jm/Mp2SQ/AXgSmgyzzdVxYOXqICtqHWsxxx8GSnQvaxQV0Sj/dOFP9z1
 /g3g==
X-Gm-Message-State: AOJu0YwTHoG6ZHxnsEfkBVtOuwS4aECkwxu04NdbQMey2KbMmlZTPIVE
 7XqxeVRU8X00Alf0r+STlXxp32y6LBSHkamZcVYiF/mnA65mL/2wuF1F2Ka4aOenudFTSJEFKUO
 h+JUjShg=
X-Gm-Gg: ATEYQzzTPLmjVsSpdNcxuoBp2t9JjuXFAuht9B3kA+xOSXNlXTO39xupfOV9CwDGv9/
 Eeh6FdRauHfc+RDhnVgP8xEBUIgfEjvnPErVvXH2Jp3+SOJLdvK/6GgZjTY4amM5QmQJCyoUHoq
 egnS6c/T8HgCNA/wQi9FyURp99M12R66YjLfN4JDIlH5xNvwHLnV5dojhDfBzlhD1ZLFaJ7WumJ
 6nmrCkkusnFdVUcspZwoPNnuWcficdq8vx7cStbnasbzGr+TWGGxmyZgoOmAtEbxq8chxrHraKC
 yJNLoN2lRsnQkT/KCx7DVMY4JSzJzyFdq/vKJc4Wp2kVVnkK9y5JzNauXI73VIUmbOS8odE/CBE
 9qX/P8NvOP80aBDaA0jHvAPoWXTKdU6chTSSVyoRhwNl5N6knRULkahwbbGpj+NX6n2ydT+5QUN
 UP13trKpg4jOdqdIrCHOeSFJbKlJqOKIbU/kq/ZuXIoAFqDTmiaROhXlDhuhCKEP6FWbaVA7Lkr
 I12dg==
X-Received: by 2002:a05:600c:1f8e:b0:485:3f58:da1 with SMTP id
 5b1f17b1804b1-485566e936amr32763795e9.9.1773382993773; 
 Thu, 12 Mar 2026 23:23:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c7220dsm12175615e9.30.2026.03.12.23.23.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 20/38] hw/alpha: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:36 +0100
Message-ID: <20260313062055.2188-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
 hw/alpha/dp264.c   | 2 +-
 hw/alpha/typhoon.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 98219f04569..86be3ff129b 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/alpha/cpu.h"
 #include "exec/target_page.h"
 #include "elf.h"
 #include "hw/core/loader.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 7722d4fd009..e32fed86f9f 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -12,7 +12,7 @@
 #include "exec/cpu-interrupt.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_host.h"
-#include "cpu.h"
+#include "target/alpha/cpu.h"
 #include "hw/core/irq.h"
 #include "alpha_sys.h"
 
-- 
2.53.0


