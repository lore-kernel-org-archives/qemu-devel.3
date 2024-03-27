Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1624CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPxF-0002to-My; Wed, 27 Mar 2024 05:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxC-0002c5-UR
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxB-0006m2-1a
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56c3689ad2cso1438747a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533135; x=1712137935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Vuzow4wRuBRA6M1t6JbWbYyMIQl6k4id2ay+d/vaQI=;
 b=evp8jxkKX4lOKE6ulNpIJ7o0wQu+bFrLdezU56pxjsCuhCTTxq9wK9Mg6l2QVWYhVn
 SQn8JqjfnRc37Cdbyt9QDK92FcZKkl21A2pQ7eez0Gbq3I+gMgzyMXlZHmn7juXyCjbH
 lCzgY+rqmXkvVgJwJA6yWqRwTs5trlpxXSFgF6gFWz0xTiY7Fhjl/t7V6+BJMJekGQRp
 oAvWvf8WsmjQz/Qbe3AIIR2J921ok+rTabgLV/go4nyC1lTWMFSLrTdFioMZieUQKKHG
 /y+Ko7j4/mRbgI3mhgvN0PkmQVZEedOmEgN3uWHB2DmX0mL4J5+MX19Vtdma1WyO/Qiw
 E6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533135; x=1712137935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Vuzow4wRuBRA6M1t6JbWbYyMIQl6k4id2ay+d/vaQI=;
 b=mkU16B43bYxRdgPccqo/E4JQUwT5D4tVacsw1uPIZyNxWhpqmhTsfYtzBlYlfKmuUP
 Or8ZPn/wD5iJqKkl1eZGgp2LBebDZmnIJ13Zx5ragcs7YtORAEtMHaJrRWbcfxo2lWLV
 IbcuRUQ2/t6c7suhTWjzLJqXClrU9zyUf8jVADWMBGluMj3wl2ZrGEXt9eNbI/F0Cc49
 WViGMF86q/Dxv/1Bkye9gAZWoNiSWYuA70pbkRuR0ny3P5kb4790jFfDLtYYYY0cfQ40
 6887cISAAksfzCKZQJ1W2SjKBykyEe9gfc5Ecplqp23DWuppLNJwSNX24FgW3vopKpeF
 RzhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzQyMVkPrXEuSymo/RsPmCcSvLN6ieXXwmUpixWR1Cpe3t7beeVkeNaF2s3RBIUANN3QzJN1rkMa1h+r43Eku5zalpL+g=
X-Gm-Message-State: AOJu0YyfrdfmLyIlrOKtlWl5cJMS0VhQnsAs4mKeW2uO/5Fp8nF2o1M0
 3Be9vVfYHuWK58IuXkbnanpXDvYZF0QfNKd9FJQNh0R0kSXXlgja4sMx7KzDrK0=
X-Google-Smtp-Source: AGHT+IGkho+VF9jZbFTrsl0A52f9KUabCr6P1DiiRsYYyyiIAiLpythomXDl0mt7CQFoKBH1AWEZtQ==
X-Received: by 2002:a50:d781:0:b0:568:9d96:b2d1 with SMTP id
 w1-20020a50d781000000b005689d96b2d1mr3486483edi.32.1711533135591; 
 Wed, 27 Mar 2024 02:52:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 l2-20020aa7cac2000000b00568e3d3337bsm5050818edt.18.2024.03.27.02.52.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:52:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH-for-9.1 v2 08/21] target/i386/kvm: Remove
 x86_cpu_change_kvm_default() and 'kvm-cpu.h'
Date: Wed, 27 Mar 2024 10:51:10 +0100
Message-ID: <20240327095124.73639-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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
Message-Id: <20240305134221.30924-8-philmd@linaro.org>
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
index 9c791b7b05..cb8c73d20c 100644
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
@@ -144,7 +143,7 @@ static PropValue kvm_default_props[] = {
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


