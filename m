Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C2CC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHN-00048d-5M; Tue, 18 Jun 2024 12:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHB-0003qZ-IH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbH7-0006nV-IR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:40 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so1500611a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726496; x=1719331296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6xz4zvShz/n3G+e5wncGUZkG18e32dlxx/8hJCVqxk=;
 b=Z0x+yBPDy5VjhLSP1zCZE1sGQSaKP/KfLkcXWh7j28a5xBqTYS62JzmNErsuKO0FVk
 7zigvPUZ9bEU17PoGQ7jSkZ1hs0tfm7pwa7BfNWtD/7Rr+RrNferbTxGbcuMch57vRbP
 cd/hAVJ7sUkVdO2ntwsl2bi24RYUFOtRokGOf04UdIymjiWzxtmIZ0KWhxf1EOyugrxf
 iNGJo1GA69Ej/Yx5yClncqCbpl8iZgZbv4rf+eGm82v6bKUtEd+HEwo7nEevkW0+L+eA
 vOnNUtMPU/d03wXlrBU0qtjrPYPOvDzMMWg+bjLFhCyYF3/0Hgmfmgw+ciL9woujJHNu
 bDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726496; x=1719331296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6xz4zvShz/n3G+e5wncGUZkG18e32dlxx/8hJCVqxk=;
 b=tGjndogxfpe5cOxf8gZtnb8NQV5EUdoboDSzsyTzuu13RZD5uiNbJ/ukSwzQxiTb4c
 4WUYiTja/ITcQDWRqlwMwyFKxNoCySsPBgAL7pX9SYWkeXaBryL8egeJmvyYzaK5+9pA
 onKyfadGcxGhIOtdUgnr7KjXkZfkiIxL1SImb56L1mgQdchvENXdCTMKtqDhsjllF4Qb
 9p9+RghbtS3vmiNJpOxgVAy60uMxr/gOp16Q02xhz83nicMMylYb0dX7VXRxfrmtWBw0
 xvPz7PvbZWFpK2ihugh3EJzfdfNTFOrf2Xko5noOwEqsaBxFEfTBDm9/h22WjSbHOcsG
 Rh6w==
X-Gm-Message-State: AOJu0YzYAyEHyJULepzl5A/MBMjYkwSs9OkHKqCY9UHi8/cKZkNQGf/4
 0XP6+OpEDi0FBaOB6O+GkYGevGcjQ3M3ccHKbEPi4jswdNhKfc26gWf8pYMv6BfLBsNvMy7Eofs
 b
X-Google-Smtp-Source: AGHT+IEQdiix6B18u6GrbchVxA20ZqXe/nsr8p/OTFLivzrMzDl3tEXu48rO6FZJAn2zy/HC0opG1Q==
X-Received: by 2002:a50:96c3:0:b0:57c:9c5d:d18e with SMTP id
 4fb4d7f45d1cf-57cbd6a85e1mr10899410a12.36.1718726495645; 
 Tue, 18 Jun 2024 09:01:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da708sm7888029a12.37.2024.06.18.09.01.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 09/76] target/i386/kvm: Remove x86_cpu_change_kvm_default() and
 'kvm-cpu.h'
Date: Tue, 18 Jun 2024 17:59:31 +0200
Message-ID: <20240618160039.36108-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

x86_cpu_change_kvm_default() was only used out of kvm-cpu.c by
the pc-i440fx-2.1 machine, which got removed. Make it static,
and remove its declaration. "kvm-cpu.h" is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-10-philmd@linaro.org>
---
 target/i386/kvm/kvm-cpu.h | 41 ---------------------------------------
 target/i386/kvm/kvm-cpu.c |  3 +--
 2 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

diff --git a/target/i386/kvm/kvm-cpu.h b/target/i386/kvm/kvm-cpu.h
deleted file mode 100644
index e858ca21e5..0000000000
--- a/target/i386/kvm/kvm-cpu.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * i386 KVM CPU type and functions
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef KVM_CPU_H
-#define KVM_CPU_H
-
-#ifdef CONFIG_KVM
-/*
- * Change the value of a KVM-specific default
- *
- * If value is NULL, no default will be set and the original
- * value from the CPU model table will be kept.
- *
- * It is valid to call this function only for properties that
- * are already present in the kvm_default_props table.
- */
-void x86_cpu_change_kvm_default(const char *prop, const char *value);
-
-#else /* !CONFIG_KVM */
-
-#define x86_cpu_change_kvm_default(a, b)
-
-#endif /* CONFIG_KVM */
-
-#endif /* KVM_CPU_H */
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index f76972e47e..f9b99b5f50 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "host-cpu.h"
-#include "kvm-cpu.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -178,7 +177,7 @@ static PropValue kvm_default_props[] = {
 /*
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
-void x86_cpu_change_kvm_default(const char *prop, const char *value)
+static void x86_cpu_change_kvm_default(const char *prop, const char *value)
 {
     PropValue *pv;
     for (pv = kvm_default_props; pv->prop; pv++) {
-- 
2.41.0


