Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1076BEE49A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMYu-0001uQ-AP; Wed, 11 Sep 2024 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYI-0007wq-5L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYG-00016k-Nh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17siYepaBs4jlr+3C5TgSD76bTlJ6Yu84QzvJEZ1NYE=;
 b=CCUS5VPDhjshzlTBLSv2apDvNLXYju2oc6AlJwSCYfuxaUCzRUH2NN7xQwbTRyQICvZEqN
 kP6rXJzma0MHhlzpZFOcsb5wyPJM2d5Hqbp8bQAsHOFvJ2UzkIry4zGLC8kIkyd6QsopN2
 EGAV5/fxgK0iIDi+LCz6dJaoLITC/n0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-dd2eRQYtOYG9IjXOOEmscg-1; Wed, 11 Sep 2024 08:34:26 -0400
X-MC-Unique: dd2eRQYtOYG9IjXOOEmscg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so28466515e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058065; x=1726662865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17siYepaBs4jlr+3C5TgSD76bTlJ6Yu84QzvJEZ1NYE=;
 b=iCpadWS33W6wq5hBszYvoJWeF4HG9AT4xI42Lgz6aeW2d8Z5wl5gWKOieDfHXcN21T
 FLu8K4ONrFSzimtocCtkkuZSUgztUFT4TiOBW+V/MsNEN11nomm6SDscyKTrUJWVP2MQ
 617szx5NexUyNCxB+XOy2UR4lJHN3o4KTTcB+w1iSkVU7NrGfrgKu7FwWvHbUsfngHXS
 2vrKt/rVx2lwr81Xl236yQDoKIrMlpfF7bZ+d5BMpLH2axVKcqlTysvCI61sfRepNjga
 femTvkGUiUiX+MLLV27ZEl0rJuhu0VMB4yxeYM0F1bNTmbDZw8uqxq/EBH6WiIKM0Y/F
 Kq5w==
X-Gm-Message-State: AOJu0Yytzx6x3y6KemfodR/wokUKSAYzHWSatECqWLTYLlXb0+RAaOfA
 Mh+9LrNuatwuYe97Gu+Um6s6OaKW2VALmjpscqMiy/n/AVJZdfAh/AP4qAHD5Kccn29aq8kVA78
 K/qA1g/+ASMcw+6ltcffeNUpp2CabcEJozhZK1Fz+kTDl4jTf+V2so8CdzC/dRRVgtyjMQwTNfp
 DX88zH6FXpk42DWbuHUBtrjOR6L9WxtQE3ZAUVIgw=
X-Received: by 2002:a05:600c:3506:b0:42c:bd27:4c1e with SMTP id
 5b1f17b1804b1-42cbd274fe7mr67775045e9.27.1726058064790; 
 Wed, 11 Sep 2024 05:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08JL7keR6yeoJa/jtcHOElEIm+90qFzGewLwcMZqJUa/Hlw8eznm7WvMbMmKOtK5vthJsWA==
X-Received: by 2002:a05:600c:3506:b0:42c:bd27:4c1e with SMTP id
 5b1f17b1804b1-42cbd274fe7mr67774755e9.27.1726058064290; 
 Wed, 11 Sep 2024 05:34:24 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b8bsm11491987f8f.54.2024.09.11.05.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 13/17] hw: Remove unused inclusion of hw/char/serial.h
Date: Wed, 11 Sep 2024 14:33:38 +0200
Message-ID: <20240911123342.339482-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20240905073832.16222-2-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/riscv_htif.c | 1 -
 hw/ppc/prep.c        | 1 -
 hw/riscv/sifive_e.c  | 1 -
 hw/riscv/sifive_u.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1b..54fd55c3e6f 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/char/riscv_htif.h"
-#include "hw/char/serial.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4eb54770690..fb58c312acc 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/rtc/m48t59.h"
-#include "hw/char/serial.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "hw/isa/isa.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 87d9602383a..5a1959f2a9e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -35,7 +35,6 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index af5f923f541..efc8443c844 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -43,7 +43,6 @@
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
 #include "hw/cpu/cluster.h"
 #include "hw/misc/unimp.h"
 #include "hw/sd/sd.h"
-- 
2.46.0


