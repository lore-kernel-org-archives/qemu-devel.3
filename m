Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E72C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrW8-0007gG-UD; Tue, 13 Feb 2024 07:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUb-0005Uj-UC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:41 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUQ-00017s-LU
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:24 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d10f52e7d8so805941fa.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707825734; x=1708430534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDuO1yoG1D7/XJGzTiSB0HfRJ9/QIMB6S76Ai8lLnLY=;
 b=Xwd7CsZ2LXPgiUYLjX4Gu9GzmkYhbQmmiqmpYpul+aF2aINR5J1o+nVrypTe/EqqZD
 +ETFJZN6N7RVrwwDLGIDpOv5BkoTlarBmbYSKW4nuNMTXhME6iCSpKIGQ4r3+zVox4bo
 EAr4DzQmjcQvOPFIsop+szK3bOO8BsP9T/5ege35MKa02vGE/tYYfITbwwsR6AsIbLNq
 PZv8yblFJFpcTeDleKNGgVF5DP8K4ZewQfSyxKTCrZGP6+13+UG07CjbusaVkX8tPpT+
 zdPfYptIsoIoVJj78JHXxGj7RZcvQ8SWgN29auSGosoj+u1MsPcK24d7Yo4SLhGvctv0
 Xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825734; x=1708430534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDuO1yoG1D7/XJGzTiSB0HfRJ9/QIMB6S76Ai8lLnLY=;
 b=TydIFF+05gi1J2nWGlaKg/tnWkENM70UOVixORohil9+4HDFkA2+6WNFYvtBWI26Sr
 XZqEX7/nQzp76DBgWb1Ng+rfRPO1HCeYBwujEjAqa71Q5Pf84jykPZ+3r+Wo7QXceXvv
 7181FEVoVfDjcpQ5OqX/feI2nZs2SlOVj3OwqYidy5csqjVfpnzQ4TJ5UZdNWNXOccFd
 fwlPPnvwQBADwgI9z4SKi5+ET+1Vwu9v4u4I6ZTVDjGNw+NMyNlAa9Nwm6i61+i2gzuZ
 hLKGsXFsigREA+APY65ORhmGOgGG89Dy/zm0YVBhLhWRDw07lfqIRl/8qMBTKzQZo567
 ZwmQ==
X-Gm-Message-State: AOJu0YxLqAwrYAANsYDCqilU6a/y+Gzt5IjQP+zhNFLAG1nlcgFgZKKf
 zwb4DVANz+GSbT5S2UDWRsOlXXjY6O+DpjzQZgIgY7tOwV8XkmbpnqUJGO2Z7eKM78RVAhtVhup
 f
X-Google-Smtp-Source: AGHT+IGur+wbZD2yUeBm3JhLiO1/vzzkr/lKJUPMzoRfq4ekHVogWhm8LpJQvHMql0zFWfd3MIprsA==
X-Received: by 2002:a2e:7803:0:b0:2d0:a52d:5510 with SMTP id
 t3-20020a2e7803000000b002d0a52d5510mr6549932ljc.39.1707825733823; 
 Tue, 13 Feb 2024 04:02:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXR6e91YgO3aY37n7c6JtVojful7CgVRLHd4R9TIyxDwLJPl4v0EruBsCz0hJsqCtf3ksdsJKSPl3zN0MVjWAq6GR6H8DbFS2rJ0+Rhzz1HT2+VbytjguDSiVYv/yIhCL/of32ZNabJarCFUB9i+OJFwtsAo0OGmkDEEgQko/s8jYAlD9oGnsU3HNIXy++9EdxqeYjmWCx8SRNyUxCVk6egUbo+88ZMaKFTvzxOJY0U1FcHaVJc0xJ1b8omteLYrQPypUP2LcBxpxnuhFzvitDPVJo3sTJHoawudODm6u9AEvPh7q5Gl961SHqb/iVoY/VSbG4njmY=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c20d300b00410e8ef51cbsm4525823wmm.31.2024.02.13.04.02.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 04:02:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] hw/isa/lpc_ich9: Remove unused 'hw/i386/pc.h'
Date: Tue, 13 Feb 2024 13:01:48 +0100
Message-ID: <20240213120153.90930-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Commit c461f3e382 ("hw/acpi/acpi_dev_interface: Remove now unused
madt_cpu virtual method") removed the need for "hw/i386/pc.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/lpc_ich9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3924eec483..b39d840ccd 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -41,7 +41,6 @@
 #include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "hw/southbridge/ich9.h"
-#include "hw/i386/pc.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
 #include "hw/pci/pci_bus.h"
-- 
2.41.0


