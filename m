Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A588606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V1iZJU4j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNCaV-0003pl-6p; Sat, 31 Oct 2026 13:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCaT-0003pD-4V
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:09:49 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCaR-0001VQ-JW
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:09:48 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-14394530ec6so2244288c88.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793466586; x=1794071386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SCvaE1xWeWnx7UnU/1gnWw/QKe7acN1+xJB52VmOclA=;
 b=V1iZJU4jjNZdqvQIdP19g0LWBrnhsZnQYPh0zpFcot3gH9nKvjnEPIFlbpzFc5N+Ju
 Y7Z9q6gD703fhNxLefJ+gvVHhaBQKDttTex0NUr/kb4ZCvRsMUq0cgn2rsiCNp78rRlr
 mO6kyAIo2jdqJtZE2HH2UwjS094rudsY5f6QHAwXUIkrXSQt+Xy/MPytsN+Em/bxpqyM
 IzXvEldMqrAEljCdeR5r4s72yE8urpAcQPbE/9ZNylXbyXSzAmCdLJJQdfLMrwe9IjG3
 w8mVxhVXKbdYsbbNoLlSRBNKfH8mKoKyruc2BLmD9My5gH97KQWtiunS93aEu99HgRky
 YznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793466586; x=1794071386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SCvaE1xWeWnx7UnU/1gnWw/QKe7acN1+xJB52VmOclA=;
 b=js55N83hTtTMlwjWY3nKJ6yue0LqPACYJj8mTrlzi9uTBc7LomhDAJH7WA5oEt7Jws
 nAu91kdh5APJd0IhhlxJ/H+zf65UUALrhFZHxIVYlQjYE0kPuu7NqeHXkoRmpqU8slwo
 0xodZEt9308ZG6cE8/0c5px4rXNbwZXp9f/XFdRsPQPQYSvhcSywE8a6V2HpdI6C2+VO
 iZc5ITn8pxV8lTH/8yJYS233wUe90a3hWw16LeqiA6NGPGsGMmGbw4+6AYjS7WNQ0ad2
 DCP1f+ZBKtAmyt+GH4gzy/75tWPn3ftRLxNxCnEpzw7u6K4s9GBl8o3oC6pOVJka2Cii
 tzbg==
X-Gm-Message-State: AFq9FYK63t45vz0TTGU5XWS0K9w4fpzxxgjL0BYgIbEN2d3Re6s9g1D+
 9jzMMO7ME9S9Rux+5JR2mTzpfkO7vg+h4XMA4+gP7BGvkiUEt7+1Is5UspEkcky7
X-Gm-Gg: AYBFou0c1pqwQLgGRn/PnBaONGtvrtawKEy8pH+YKE6ip6/0pHkkRG7eaWPfkNczz1x
 ak2XtaJMSwEtG3IJBt5soNPxR+qPtNfOjV43d5VBdDdSiqlMMDuYrtQkqBaQRTM8ETrweBEcML8
 r3h6BL4wNHDxN5dQHZWXgo+6p0UYxL58RJqDGlir6pGTUkNdmlSE2koCIP9l6oxiis4ngqHVzuZ
 mXzG4ip6c3zKiqAk/es7vTfVmol1IeSxiN7l8F2VqfWIfXrG9V8SEaK7ERvxU8EklaSesHEiF6q
 DmnTc8KZGVTYut2ykdUB226lteerUFKG7hh74ExFUPEguln0QGZIVbBn/LgD9khq4IhtvF2ePlz
 Hkzg+VkQQChc5QX0NG1tI3Zd1x1KGRE91ut72TKgOMSs9/ohj9LlPN8JNTzIf8zNUy0UE3Xyozr
 5S03pwUSN/c6qeFoixyvBFX4MQzrANMMP6TDq7CpKWH5WBKHQ7XjpzGhQ0w2ts73diRInTNZIMz
 +qdQ3ouHgY4MdarspW/QAj/dbRz4XxYGEb1xURTN3KpaWRfHPb+Zs7rD+HASTJ0Y12LQNjUtuFY
 R7hMYky3v6Yr3CVSG2Uintg2qowweB3wnn5/6FFGr3sqDC+T
X-Received: by 2002:a05:701b:4206:20b0:1a4:9eaa:d01d with SMTP id
 a92af1059eb24-1ac5fd08905mr7930123c88.45.1793466585766; 
 Sat, 31 Oct 2026 10:09:45 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854da78sm23749065c88.6.2026.10.31.10.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 10:09:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH v3 2/3] Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu
 to riscv targets"
Date: Sun,  1 Nov 2026 01:09:24 +0800
Message-ID: <20261031170925.789-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031170925.789-1-luoyonggang@gmail.com>
References: <20261031170925.789-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is redundant now as all accel-$cpu_type parent is already registered.

This reverts commit 2d3e6b4003d5380c245ce8ffac4b8866f6d10a33.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5a82a63b822..c085b22b23e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -26,7 +26,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "qemu/target-info.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/kvm.h"
@@ -2236,7 +2235,6 @@ static const TypeInfo kvm_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
-    .is_available = target_base_riscv,
     .abstract = true,
 };
 static void kvm_cpu_accel_register_types(void)
-- 
2.55.0.windows.3


