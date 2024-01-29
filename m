Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB6EC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 12:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQVv-0007op-T0; Mon, 29 Jan 2024 07:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUQVu-0007oR-4m
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUQVr-00032Y-Vu
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706530397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=20stb3jmdCTEzIAUe38oaSM+5OY0esoI+msc2cRxhWY=;
 b=PVpJg0ojPcBPa42qaMgMY51fXogLypM/l/Bigvus8edsnmCT+Axe0AvfiDe9VE170vMODZ
 Esl2lAJ/uHFb9NLajH0JdY30GxL5QK6awSt30exkEsSFXHUZpMEgZKiE9EMif33LzvfQiR
 eGboZDJPQ+J199u2uEgcR5C/aza9iSs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-kW5mjeg9NHOzSOxR1iHh2w-1; Mon, 29 Jan 2024 07:13:15 -0500
X-MC-Unique: kW5mjeg9NHOzSOxR1iHh2w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2cf4df2662dso8777121fa.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 04:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530394; x=1707135194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20stb3jmdCTEzIAUe38oaSM+5OY0esoI+msc2cRxhWY=;
 b=ZpELyvMJU6glkV7s/uYbAMfnLOwzji/GE42r2dtQHjg7wEpg86kmNaV016HDRkGKCa
 u4+2Gs6Wj6IFRh3A2WfKyGBxbgK5xBef90QZhKd/EZpjsXr98pDnHZadwAw2pju4Ycki
 hoZDqb7FYyqZUF5EM2TUpDKw/079HUdPzO9IfE3QVS+ndbITbpWUYi4z1WUHRmS5JMcA
 I4wRrVd7lb2Y8HmYi8+xs3Zmm2ws1PAHIB/jfm8YGQxFB0JjuFeD7WgM9OF/jpsZeki+
 17gnU24njxQ+ZYrSCMwUsGS7LMfdUejwYiST7FniJ1WGdN56ZyPgwa51O/nW5+tjLc4n
 CAYw==
X-Gm-Message-State: AOJu0YzkpeIOoMrwOvXuj5uL8sqU8KQWsEpcxfUWVNdvQ9yG1+LikblH
 UxGqjtGs1HWa+vEOEbHDfEX2Gzb8T8usSk/kpi1strKETOfNF6E1b6cJc/nS+KIxj6V1vfYZaaS
 uAqX9iCyrKxyB7MkH8qbPsVu+/PknTF28uY1+fx4aLaweGOwKNcgOAb458rLoJ9RGXoEz9vIMq6
 vWq56S28WJQVkc0kdmlbp9nDOKFGcHcM4lX3Gi
X-Received: by 2002:a05:651c:19a4:b0:2d0:4f51:531 with SMTP id
 bx36-20020a05651c19a400b002d04f510531mr1086480ljb.45.1706530394057; 
 Mon, 29 Jan 2024 04:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESzWIXA0DAhDZgqcQ7b81NsqtMUCh0Y+D5qFytNlqjlC44m4V+SSfr1zh9IL07XM+QGcW99A==
X-Received: by 2002:a05:651c:19a4:b0:2d0:4f51:531 with SMTP id
 bx36-20020a05651c19a400b002d04f510531mr1086459ljb.45.1706530393586; 
 Mon, 29 Jan 2024 04:13:13 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a20-20020aa7d754000000b0055efeee7722sm977461eds.79.2024.01.29.04.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 04:13:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] mips: allow compiling out CONFIG_MIPS_ITU
Date: Mon, 29 Jan 2024 13:13:12 +0100
Message-ID: <20240129121312.1057281-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

itu_reconfigure() is referenced from TCG, provide a stub if needed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
 hw/mips/meson.build     |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 hw/mips/mips_itu-stub.c

diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
new file mode 100644
index 00000000000..4cc82b8461f
--- /dev/null
+++ b/hw/mips/mips_itu-stub.c
@@ -0,0 +1,26 @@
+/*
+ * Inter-Thread Communication Unit emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/mips_itu.h"
+
+void itc_reconfigure(MIPSITUState *tag)
+{
+    abort();
+}
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index f06d88f3430..2b1b96147a6 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -4,6 +4,7 @@ mips_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
 mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
+mips_ss.add(when: 'CONFIG_MIPS_ITU', if_false: files('mips_itu-stub.c'))
 
 if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
-- 
2.43.0


