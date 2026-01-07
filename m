Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A642CFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIc-0006MX-Iw; Wed, 07 Jan 2026 08:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIU-0005Vf-5W
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIS-0000KA-7D
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:57 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so16759475e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791394; x=1768396194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jPdNmZA8j/yx5+vAulTL2BlPCCMjWRZMdn4TN5f6yU=;
 b=Fb7HMmuN8L2uGlxkNwEU/BTCeTBxNO3Zl0OFTEHFDYjpf+hxNVdJ4MTt6lRcvYSBmR
 RqxdCS6grGSCX16Zfx1sAKdg74cApAeo03/Qyhb9Qzb+UbtpXtsRuIgJny4R6qc00ic1
 gL8VMpLZA86gwSRnZBO499YnYviEF89TwdpC6BnerzyfMNj1pjXBAvC9BFDFmyDJnXpo
 dSJ2r8AZoZRTJO+hbVLEUV5DjGXuU1xYWBiMwWUmm6O5oTZy/atiNzmjzuAqqiHKcjKY
 IAxmJ7GhJ2C3cV8u0QtMJbheQV+bUxfoxIzGh6jErVYlPlQWR//tKRAkhDbpEvh7Ggcs
 8sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791394; x=1768396194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3jPdNmZA8j/yx5+vAulTL2BlPCCMjWRZMdn4TN5f6yU=;
 b=tRx0NqsR2hY/4FRqel+QWfabqhFDNyOspARAXxG3VXbTZXl/Kg7Kx+oopIiyn+eD1P
 C4z95ITW0MpAj/jLre2Sgdh1KpcQzhk7MYTJQWkvq5g2CwhdPb2871AgBGYKxmHOsf5j
 QrO+Rb7ciHd7/iMW2PUSmjtnSKt1AE7wU502YlCN8GfzlRKLwcrvtBZm6xiws4PYIP1J
 nySftGvGwsLIuHcSDx86eo9GTwWXesFfNS0I/NHtGCopt2qkIjnX3XC+zFoSRzQ77xg4
 BRDfQ2MjWIktqr1DWKp6ra6FBFhmI3oC6X+JM1CZz3z3Xf6zwxgSohox+W3XrN1oN+xO
 RR+g==
X-Gm-Message-State: AOJu0Yx9U9Yo5upBk7NWBGo8CNYh5o50Zk9LUqDGDYhRmkNOF1KACKPL
 ChrTZ4hlUFnDKo5SolyynJ0m6hl+xQLuAzr9gdB7zwJCXdispxIuhs57hGDvkyVDLPw/10Zfxj4
 XEv1dZaI=
X-Gm-Gg: AY/fxX6kmq9USdVybfZsMS3EnYnLeTZBcxsEnj4WJIkqaPogeOOUQW6wh+qF3kWGtn0
 ZEG8PI1vQIIfKzFcPMrtgpJjF5vRgcGaWmKx2ZPirlSOqucLQkm9DCGo+gxkuzPjoVjiFYRn4ES
 QaXGtxM2G64LSyUxLgCpGrmWIaPgp1Eb7JN3ckE8SNnUhmHLePpqhjm607Rs5Yb6e8ClZgY5KEd
 Na6zZ7TgxG+TDbChY2q1WG8wXGLgfsa1CO6MUQ2eNJ/lMKi9C6q490WQ0TYPYJrQWpHdO0Nkped
 eQV7XNDtf8QJZW5neMbvHDEgzmA4CiCPo3F6ddoeJ5XKyJJLNHc1JLVogkp3W9G+YBV6Oj1hZI9
 TMJDK+k9OyhosEZnW6TljSCmquX34hvYNtz3BFlzk52J38NMG0e4Pois/ETlaHyDHZ4Sjva+fMa
 m5Id34HOg8xZhiLlJ/t9lQmFZctdh7/DvJgYNrEmDQD9ZPTpW22mTn3gGJtdqO
X-Google-Smtp-Source: AGHT+IHUcVoHsJscuUkeklzlrCou0jEKNLzVM2+UxDiyT70o7uW2ieghcTDKA/AwpRfSSq42vphleg==
X-Received: by 2002:a05:600c:4fc3:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47d84b3b9e6mr33890795e9.23.1767791394366; 
 Wed, 07 Jan 2026 05:09:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa07sm10377345f8f.25.2026.01.07.05.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH 15/18] target/s390x: Un-inline s390_is_pv()
Date: Wed,  7 Jan 2026 14:08:03 +0100
Message-ID: <20260107130807.69870-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inlining a method which use a static variable is really a
bad idea, as it totally defeats the point of both concepts.

Currently we have 12 + 4 = 16 static 'ccw' variables...:

  $ git grep -wl target/s390x/kvm/pv.h | fgrep .h
  hw/s390x/ipl.h
  $ git grep -wl target/s390x/kvm/pv.h | fgrep .c | wc -l
        12
  $ git grep -wl hw/s390x/ipl.h | fgrep .c | wc -l
         4

Fixes: c3347ed0d2e ("s390x: protvirt: Support unpack facility")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/pv.h | 24 +-----------------------
 target/s390x/kvm/pv.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 94e885e9335..e266fc3d545 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -12,8 +12,6 @@
 #ifndef HW_S390_PV_H
 #define HW_S390_PV_H
 
-#include "qapi/error.h"
-#include "system/kvm.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
 struct S390PVResponse {
@@ -23,27 +21,7 @@ struct S390PVResponse {
 };
 
 #ifdef CONFIG_KVM
-#include "cpu.h"
-
-static inline bool s390_is_pv(void)
-{
-    static S390CcwMachineState *ccw;
-    Object *obj;
-
-    if (ccw) {
-        return ccw->pv;
-    }
-
-    /* we have to bail out for the "none" machine */
-    obj = object_dynamic_cast(qdev_get_machine(),
-                              TYPE_S390_CCW_MACHINE);
-    if (!obj) {
-        return false;
-    }
-    ccw = S390_CCW_MACHINE(obj);
-    return ccw->pv;
-}
-
+bool s390_is_pv(void);
 int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 2bc916a5455..3d508165f34 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -25,6 +25,24 @@
 #include "target/s390x/kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
 
+bool s390_is_pv(void)
+{
+    static S390CcwMachineState *ccw;
+    Object *obj;
+
+    if (ccw) {
+        return ccw->pv;
+    }
+
+    /* we have to bail out for the "none" machine */
+    obj = object_dynamic_cast(qdev_get_machine(), TYPE_S390_CCW_MACHINE);
+    if (!obj) {
+        return false;
+    }
+    ccw = S390_CCW_MACHINE(obj);
+    return ccw->pv;
+}
+
 static bool info_valid;
 static struct kvm_s390_pv_info_vm info_vm;
 static struct kvm_s390_pv_info_dump info_dump;
-- 
2.52.0


