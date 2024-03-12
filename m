Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B707EC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxPT-0005Tt-Tg; Tue, 12 Mar 2024 04:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPR-0005Sq-Kl
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:22:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPO-000172-WC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:22:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41329b6286bso10538135e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231769; x=1710836569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7t8ToQvoKJ38Eour/5JL7+zSxhmxaS/0ISJ7lI4Kdc=;
 b=QL0r5xmqh3146A1Ybqwsgpaz0Z/RI85sU7uuwNECqQlwCNcw7GXaIx7dpeipi3FznM
 ir/oGuKq6k7M20nowBjqHTg7XbawV5jXbj73/hTJMHvSaEOdLsUbo0bOGq4QsYLnMkhj
 BSOHEdy9k+pfNhDXsqf4+M7jJmHhONxtza1wFuS/nHeE0cpOSx8tzKFbO2KGZXbDH1zL
 iipvTPOBkgF5jv93E/Z+Sd7StUG7rlCPO16OfE/9ruDfft4I+15nrp1EQuhAZEGdBkw9
 sIkgWLOq8qEMHGx6TTJRNveHFr5Zp+9uS8mMsbs3TnaqblHaV9m9zgXSgvKGMXXG4NzM
 h4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231769; x=1710836569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7t8ToQvoKJ38Eour/5JL7+zSxhmxaS/0ISJ7lI4Kdc=;
 b=T67xoitdJOKO2pqlLcRV29PM2eoe2Ux00K4S2/uAGQfTFv3N9iqnVPI3PigrRlBAlJ
 L91CuctdARiv9G7Si9pTV/4d1ISmwcKEF+dFDa9iWlqpCVg/NP4cKEEs+PI9ZlKPkXDg
 DGQFWGtHOITn8pZizo1JfqJqpzkDVirK14LMKTkyVlRd1pPm7hjeYfCVqobO9YXz6tb7
 ZveojEEkglmps6aPGSliG3xSEObrjYzFbvPOrsQchJpWTT4rc14JEHAx6XoNYTjFZGQ/
 0C6q9DuwgG132c8ufpvZNFemKgpMDbtTGXR9H4mu1M8R9xwPXkKYf997PzTA+TlXQ/4s
 crmQ==
X-Gm-Message-State: AOJu0Ywtj0Xb7q7jz0e1rsRH2t7mRktkeChRwhsswW6oYfh/O12nMIB5
 UKiYjvifDcgD0VGzKiP/FfFjOY+RDSyPcwlSr4LBifB9fjMLtX0fXErnEZCGtaMbGRXwESlDcPj
 1
X-Google-Smtp-Source: AGHT+IG0QqIGogzMqwbFvEHg2eLWebIzfILzC8eVhOUbTh/vO+/88ZKK3HzQuK61STvYsUctEl6H7g==
X-Received: by 2002:adf:f48c:0:b0:33d:ca56:a61f with SMTP id
 l12-20020adff48c000000b0033dca56a61fmr6912288wro.49.1710231769187; 
 Tue, 12 Mar 2024 01:22:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4002000000b0033de2f2a88dsm8320603wrp.103.2024.03.12.01.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:22:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 01/13] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
Date: Tue, 12 Mar 2024 09:22:26 +0100
Message-ID: <20240312082239.69696-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Other headers now use dash instead of underscore. Rename
ahci_internal.h accordingly for consistency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/{ahci_internal.h => ahci-internal.h} | 0
 hw/ide/ahci.c                               | 2 +-
 hw/ide/ich.c                                | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/ide/{ahci_internal.h => ahci-internal.h} (100%)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci-internal.h
similarity index 100%
rename from hw/ide/ahci_internal.h
rename to hw/ide/ahci-internal.h
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index b8123bc73d..bfefad2965 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -37,7 +37,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ahci-sysbus.h"
-#include "ahci_internal.h"
+#include "ahci-internal.h"
 #include "ide-internal.h"
 
 #include "trace.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 3ea793d790..9b909c87f3 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -70,7 +70,7 @@
 #include "sysemu/dma.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
-#include "ahci_internal.h"
+#include "ahci-internal.h"
 
 #define ICH9_MSI_CAP_OFFSET     0x80
 #define ICH9_SATA_CAP_OFFSET    0xA8
-- 
2.41.0


