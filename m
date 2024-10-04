Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506C8CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlIn-0002ip-DH; Fri, 04 Oct 2024 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGi-0006ze-Ct
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGg-0006DP-SP
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nN9lqEG6YcOFZmpCVL2tbq4RA/rBtzOxA2lN9ZBgAA=;
 b=e3Y7bqFbJ/CK5PEyjsFNhZQaLouif1UKPvzneqf6rLF+6F9X/MpArNYS9eFXLeTbieUMXY
 JyUdQtEzxt18cY1c6jElMfzBok8J/Et4j6jarvlmnrdYQ/mIHUVs/56XPxJyoZuSvT6uJ6
 8AQBmpR/PgyQBDpm4pnw1oKMeGUdFMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-zRvP1hRaNtWldhw5gQdhfg-1; Fri, 04 Oct 2024 12:35:00 -0400
X-MC-Unique: zRvP1hRaNtWldhw5gQdhfg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42e611963c2so17702995e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059699; x=1728664499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nN9lqEG6YcOFZmpCVL2tbq4RA/rBtzOxA2lN9ZBgAA=;
 b=KKH1zxMKneIUXIaV5wgAnD2RnEVT3zUXXV5RZ4ZaXDB1hwiK5T4TJSkNinxtGOXu8m
 iptfedhpy0+ewKcDOofS3ly39VFOAzW6iynipklGYRxlVlKUhDgfD0TX5eoNKW0Ih2dS
 P+Xtqlfbm2tef070Bg7dIgiYh7hdhKYJ8+Ld9U/+bvr76gIhfgvEj/x0rdgk7q3X3OFA
 x3FInH/OaedIh7i78A+tIL3SfD8VPEoOB8SVQP64qjix6kAI/GrqEIMivyuAUXzi/lZe
 42OzKK/sVzgHNeYYvbebKaERkaUa2yx97hOVernLaAUUrerbLfSCx7cVX9sgV1fhXuaf
 yJaA==
X-Gm-Message-State: AOJu0YxJqOKtxT+LAS8FoJHuWTVV4k061F3zz7cl7+DOMVMrbu/RxvaK
 zm7XTwiHZhdWCnA7/PXxxeSt/QFoEXF31Nz0yfO+jia7Ub+QV0R+jij4dqdh5KGp/pSU6OC/un+
 VFU+Gl6pxD7K+XiA64yoGmbVeupT1sxVQkLBeHtEdRWYPZBlcrZMtCvpcrNUR8hiHNSbsLFfiZC
 bd97I0e1i268qkp1D1T7dfnwMb1GOO4T+Rt8cXwYU=
X-Received: by 2002:a05:600c:1d17:b0:42c:a574:636b with SMTP id
 5b1f17b1804b1-42f85af1018mr22036755e9.35.1728059698864; 
 Fri, 04 Oct 2024 09:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv5572tI7UODNf578Zd2izTMW7BWrig8ntuTEUDPvciPEPAX9wXCi5kNKF2Ev1IlN7vH1u6g==
X-Received: by 2002:a05:600c:1d17:b0:42c:a574:636b with SMTP id
 5b1f17b1804b1-42f85af1018mr22036595e9.35.1728059698413; 
 Fri, 04 Oct 2024 09:34:58 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e85778sm1629705e9.2.2024.10.04.09.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 13/23] hw: Remove unused inclusion of hw/char/serial.h
Date: Fri,  4 Oct 2024 18:34:05 +0200
Message-ID: <20241004163415.951106-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
2.46.1


