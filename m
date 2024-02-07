Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D5CC4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfsr-0002rp-SQ; Wed, 07 Feb 2024 06:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsp-0002qu-Ns
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsn-0003Pk-Aw
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22m3lVs8Rcr/AULyQQp7muXracEJFhELmG8wj9R5NH4=;
 b=FxQ4ktehlXv73nFlibaxDnIqpRZvvXquqf/AwUYyMie08yEphlrZIFy2KRhlvoojVx24lX
 LX5Hc+0CjyN4JCUndhWzRy4NtwEf9ikrRFqr/dtiNfwcB8CUW24Fnk7Mv/fG2GAxNn+NDV
 ZqZuP80aY0wWJ4d+SozI1goRJFHcW7Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-t3CRKQajOYGoYuJb9QAtTQ-1; Wed, 07 Feb 2024 06:14:22 -0500
X-MC-Unique: t3CRKQajOYGoYuJb9QAtTQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3120029877so165163466b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304460; x=1707909260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22m3lVs8Rcr/AULyQQp7muXracEJFhELmG8wj9R5NH4=;
 b=badnLYxzFsK/AeY5/04quUv4kS1qeJjyCpArZW3/ZZvtc3E6hLS9s4fixDQCe3yxFq
 bcZIAJoBY9mmZU3R/mB1jOcXBaSiq/LnI4DMr31keAa2ygUPrjernd7IPzTLaUEH1g7F
 WJo/ssKbqoIYzTaVLa73g6SUgAHcUTEV0JzpYuBmjoPDuQ9il6GF2jEeOoFoXMzvDn7/
 ceFWJki+Tv+k0/Ub1xbUajaQFL5dO8ie/SdlVIqDwR79zb6Yc7xAXulhoUUk8495EXPx
 +Kz8ePPK7t4GjBdbXnfCQiw1n6eVRF4WaqVKhsaAbyO+ysw8Bun8O5Y310I2DsCPBpR5
 pipQ==
X-Gm-Message-State: AOJu0YzbHiLxNVjA/z8rQ4Q5pc3v8MKYBPmvT7tZZLPjc13qKh2FS4Qh
 vPRqjiG9834OVJzZ9W/R0BNTR09mLMfdwc0E9N21GsllYZABz6Is67ALbLTmPr3BJmApOerN2/g
 5QtIa0PkLOIzOfNwECFDbM7WiC85WmN5VANAEsMrv65DiVJMDjR2krPQ1PXokKLvUBlqiNYldwA
 Mj3NZ8yK3BQmLggJJ9k4tDNSudT7IJB6kqw10+
X-Received: by 2002:a17:906:168e:b0:a38:1a75:787d with SMTP id
 s14-20020a170906168e00b00a381a75787dmr5437713ejd.24.1707304460600; 
 Wed, 07 Feb 2024 03:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+I7UvQuCkfJeT8qsOzxYAqKKLeb7PoknbBgk4/TOSfQKpvFWvy72K2CNdbrVtFZZl7h+qOA==
X-Received: by 2002:a17:906:168e:b0:a38:1a75:787d with SMTP id
 s14-20020a170906168e00b00a381a75787dmr5437695ejd.24.1707304460306; 
 Wed, 07 Feb 2024 03:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUgqgYbl1+17M7diVzr2FFiJixDLFvi0YQa6XeDNW7vw0elNJ59mDOMMS02EM71wo0ljmfyu7szxOttHJg1gPIUbw==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a056402500e00b0055edfb81384sm573133eda.60.2024.02.07.03.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 3/8] hw/mips/Kconfig: Remove ISA dependencies from MIPSsim
 board
Date: Wed,  7 Feb 2024 12:14:05 +0100
Message-ID: <20240207111411.115040-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The board doesn't seem to have an ISA bus at all.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20230109204124.102592-3-shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mipssim.c | 1 -
 hw/mips/Kconfig   | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 01e323904d9..abbeb6390e1 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -31,7 +31,6 @@
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/char/serial.h"
-#include "hw/isa/isa.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ab61af209a0..afcfb2b8eca 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -6,8 +6,7 @@ config MALTA
 
 config MIPSSIM
     bool
-    select ISA_BUS
-    select SERIAL_ISA
+    select SERIAL
     select MIPSNET
 
 config JAZZ
-- 
2.43.0


