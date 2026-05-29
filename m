Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50ECCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Fd-0002M0-PR; Fri, 29 May 2026 15:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3Fa-00021Z-Ol
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:52:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3FY-0005FO-EF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:52:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so1476547f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084327; x=1780689127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je8q/HCAd0aP2wgv5J5zrln6ORTrwi01jkqwR3v8AHc=;
 b=beB6F2aXLhiQma7R/YJAHFVZIGBZuqmPSzClBr5IZMPEmsVGLh6/9Ua6vWD+6ipz/n
 x05nuTYKnoo0gOa5q61bReBEtzm0JggMcsKMTtCZt5S+iAu4Va7UTSe7c9oeI1LRXXy6
 l7pGRP2l41g+mdA6Y2XcJaWaBZogRlvG9Wqoq4BcRijlMxoESivyMV7SIMQN0Ig1meDx
 XpNGa5PSnTMJEbl35TA1hvuJ8iDsnvBa4QjnWyNdwUPfCL4mSkYbnw74ncozGeUJQhOb
 k9EgTUL6XbKkvcK093GliP80wOP8dHLFXDYQdRbD4T9qeZ1zVHUf7juhyADG/rFdKPlQ
 RuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084327; x=1780689127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Je8q/HCAd0aP2wgv5J5zrln6ORTrwi01jkqwR3v8AHc=;
 b=I2hs1kuTg1cFl2NhbsuhcJx6cD2VGsaUby9OSq6wPAbhv7AXZt1WpML5m44PCvY6H9
 UU6lemTfOD/TlsamTmsQVRIDtEn/EsGsdwKfkw35nJpFA5f9NKyZbkY0N1nJDYzBt9wD
 Bfh/JBdq/bi7EtieN0IdBnr1u+S5U1D1DLOwM5cOxGGF1BcrYqV8gOQ/hGoL2eAKqmH6
 pPyXiB0qVmEQuevIFhqK+xwsTZ2FUcby951rYUZYez7Xya9eLYYd/SDs2ghKTu4Mvi9m
 b7z0kI21t5gvckZiwMLi6C0wJr6jjvljBRFltD9vPsOZwosIacQc3pg+IqYZbP1L6M5j
 ewyQ==
X-Gm-Message-State: AOJu0Yw959udaCQs3Bq6heA5W9P54ZahtTmuwG5KZG29IyNAfNIr0jY+
 fsOyEOn1tbPoVdn7Fgj4xrXKXWi23cjCud4alpIK/lG7hqUdZOooJNiLAPduPPUxOwrOhEQA0Fu
 mr/h9p4wx7w==
X-Gm-Gg: Acq92OFf09z76z++NIINp5v/C28eaz6RsOoMAZIEdFx/CQQNbn6L2MWX2t+PWkWHz8M
 w7+qfONTSZipPeldUpeyoRVLxWQLJaIRRCdncu/ShWDJ+Njp4sTkgLAEV+kqpeF5QXPhDZ/bAqM
 ldw8KDugqU6zSoiiLT3dnrTtVzB1rfhxKeE/NguVO/S94XsBTLkLFpAoUZl6Rm0HrOrm/bTVCej
 t+aofPAhMBVbkuOnhyIzIZAgMm4QcuWS1SNip6tN+G0wN34oF9UtACErVCsNwg5m9ZA/25OmYfv
 eG3/Ha9k+IyKqYOho38YV6HRKw8TanZBEkLaRBYc9vpb+K8GajaE8wgkRlzZu9Rl73JxE6NusgB
 +mG/eXvkXmAx745vneuEZT/lud8aAvMvcjhvpRoRYcFJv5CK3nS1c//wg3ZCId4fXoI4kzGwtcR
 f0xpYdf7KQwmLx++XNNV7pJyCMTYIOENLGvnFUeqWlF1km1UZIHjB9uHZq6x3emM6esA==
X-Received: by 2002:adf:f089:0:b0:43d:77c6:be78 with SMTP id
 ffacd0b85a97d-45ef6ba1425mr1556824f8f.39.1780084326851; 
 Fri, 29 May 2026 12:52:06 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34bd896sm5336956f8f.14.2026.05.29.12.52.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:52:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/17] accel: Remove AccelCPUClass and
 'accel/accel-cpu-target.h'
Date: Fri, 29 May 2026 21:49:39 +0200
Message-ID: <20260529194940.97143-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

AccelCPUClass is now an empty class. We removed all uses of
the TYPE_ACCEL_CPU definition. Remove as dead code, along with
register_accel_target_type().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu-target.h | 31 -------------------------------
 include/accel/accel-cpu.h        | 19 -------------------
 accel/accel-common.c             | 16 ----------------
 3 files changed, 66 deletions(-)
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/accel/accel-cpu.h

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
deleted file mode 100644
index 6feb344e29b..00000000000
--- a/include/accel/accel-cpu-target.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Accelerator interface, specializes CPUClass
- * This header is used only by target-specific code.
- *
- * Copyright 2021 SUSE LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef ACCEL_CPU_TARGET_H
-#define ACCEL_CPU_TARGET_H
-
-/*
- * This header is used to define new accelerator-specific target-specific
- * accelerator cpu subclasses.
- * It uses CPU_RESOLVING_TYPE, so this is clearly target-specific.
- *
- * Do not try to use for any other purpose than the implementation of new
- * subclasses in target/, or the accel implementation itself in accel/
- */
-
-#include "qom/object.h"
-#include "accel/accel-cpu.h"
-#include "cpu.h"
-
-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
-DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
-
-#endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
deleted file mode 100644
index d7ea45ada2e..00000000000
--- a/include/accel/accel-cpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Accelerator interface, specializes CPUClass
- *
- * Copyright 2021 SUSE LLC
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef ACCEL_CPU_H
-#define ACCEL_CPU_H
-
-#include "qom/object.h"
-#include "hw/core/cpu.h"
-
-typedef struct AccelCPUClass {
-    ObjectClass parent_class;
-} AccelCPUClass;
-
-#endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d8ee6d62667..4fe15349012 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -11,7 +11,6 @@
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
 #include "accel/accel-ops.h"
-#include "accel/accel-cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "accel-internal.h"
 
@@ -98,18 +97,3 @@ static const TypeInfo accel_types[] = {
 };
 
 DEFINE_TYPES(accel_types)
-
-static void register_accel_target_type(void)
-{
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
-    const TypeInfo accel_cpu_type = {
-        .name = name,
-        .parent = TYPE_OBJECT,
-        .abstract = true,
-        .class_size = sizeof(AccelCPUClass),
-    };
-
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_target_type);
-- 
2.53.0


