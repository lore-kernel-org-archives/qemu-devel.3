Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E2C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekX-0007Bu-Ld; Thu, 27 Feb 2025 09:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekR-00074F-7C
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekO-0003jW-HP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RntUDexksFwvMT7+4/zwxw40OZKETlpI3GYu/coQJlI=;
 b=DKPZupDbVCJVuo4t4ciXx8TIdgm2AYf+DOAqBxPHbmAsatkcabeEe12MJGf5h3eVqJPRVl
 eDXoom/B1za5Ty5A0GLQtdv8vYYQfLzmvCrLYXMLKzHnI5AQ5ezcEdl4LePyYgteYx2WGM
 MORdi5/nFE6KFJFcNcm/hThVom833s4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-kwogPHaZNdSr2sPjRa_Qfg-1; Thu, 27 Feb 2025 09:20:18 -0500
X-MC-Unique: kwogPHaZNdSr2sPjRa_Qfg-1
X-Mimecast-MFC-AGG-ID: kwogPHaZNdSr2sPjRa_Qfg_1740666017
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e0573b9f60so1028416a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666016; x=1741270816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RntUDexksFwvMT7+4/zwxw40OZKETlpI3GYu/coQJlI=;
 b=izjvTM0IEohcm2LbQDeDgyi5FHHFSxhUTYiCEdoTCBqjYm2I71H8qQpGfMyaDltekh
 jP0jn0VtZ+5pXQDThiNY+GYoDX9cOlI5USd8vrNtuJy103+7RiPpJ/R3MGLDEwYp9g3C
 8m1hudRzyXl0HcEy9U0KcbPMupO+WegDgbaUhW93vJqlsG/DjufAuwPjmkZR/gKIJdpj
 HQ4U40uA+0cOh1rr8V65VsRygM/5vxphStDPTrla5n1EZRBL1bVCSOUfWDHKWKXRxGa4
 o14a7CRDhGbXLUCUAIp2P6qz5VifMTrnktrd2gOkI6NxH3H21D0nLQ4mWCgBVtLlytxP
 ApgA==
X-Gm-Message-State: AOJu0Yz5ExW5yByvzJzMBRWEkEF1lFRFqmeH2tzf9BxfmCaZITEOD+d/
 GRB896lAYVSpP9gVmAPPXgVJIVy7CvawvGYKxsHZ1+QFX8YrMsYBgsSOUyjbnUwhAXBp3it0+hV
 X/HdqhslyflN9CV2qFxoZV8r54oDanTQmQZCXRax+J/kHNoH7uZuZIcRS2B7ThG+sXdl1qHd5B5
 gi4whLqxR2lso8kkbFY6+2yIytuvT77fGjdNnCwsc=
X-Gm-Gg: ASbGnct3UjmhmplRE5LY5vjENP5Hup39z53f6rorO1Tdq8mPA4wrxx29nuuhzyXXqG0
 6qA/iKvGf+9oMErPqFDesPK1ThIsm0GIPl9Y1eFjUDVQ3yYQVweTXPhLm2IGTzIT/jak03j0fyN
 gr8iYLFsvkViZn+pnLAduFbaZf6yx5+xlD1X4YYP1cT3ykarIMREduH+98Kxey46+Xs0Zv7hP3X
 /yzKsAbXKV5Sewmo5EdOoC3sgk+Tw425EMrlBsUFj871Gg/kt1csbLAOYt/o6ak5TNwN3/7u22y
 dGx6FV56Iz4iU1i8KJIq
X-Received: by 2002:a05:6402:3554:b0:5de:5263:ae79 with SMTP id
 4fb4d7f45d1cf-5e0b70f0041mr27989570a12.12.1740666016422; 
 Thu, 27 Feb 2025 06:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9rccv8llgNynnIpHT98jNn2N6bzeWxaCSLX8hJwSQfyyn3+TQFQRqPmMSQUvBtNwarAxGNg==
X-Received: by 2002:a05:6402:3554:b0:5de:5263:ae79 with SMTP id
 4fb4d7f45d1cf-5e0b70f0041mr27989534a12.12.1740666015948; 
 Thu, 27 Feb 2025 06:20:15 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6d252sm1173607a12.26.2025.02.27.06.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/34] stub: Remove monitor-fd.c
Date: Thu, 27 Feb 2025 15:19:28 +0100
Message-ID: <20250227141952.811410-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Both monitor-fd.c and monitor-internal.c contain a stub for
monitor_get_fd(), which causes a duplicate symbol linker error when
linking rust-qemu-api-integration. Use monitor-internal.c instead of
monitor-fd.c and remove the latter.

Reported-by: Zhao Liu <zhao1.liu@intel.com>
Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Fixes: fccb744f41c6 ("gdbstub: Try unlinking the unix socket before binding")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250217104900.230122-1-iii@linux.ibm.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/monitor-fd.c | 9 ---------
 stubs/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)
 delete mode 100644 stubs/monitor-fd.c

diff --git a/stubs/monitor-fd.c b/stubs/monitor-fd.c
deleted file mode 100644
index 9bb67498850..00000000000
--- a/stubs/monitor-fd.c
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#include "qemu/osdep.h"
-#include "monitor/monitor.h"
-
-int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
-{
-    abort();
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index b0fee37e059..63392f5e785 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -62,7 +62,7 @@ if have_user
     stub_ss.add(files('qdev.c'))
   endif
 
-  stub_ss.add(files('monitor-fd.c'))
+  stub_ss.add(files('monitor-internal.c'))
 endif
 
 if have_system
-- 
2.48.1


