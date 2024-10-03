Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1695CF34D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVU0-0008Fi-Vm; Thu, 03 Oct 2024 19:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTi-0007uG-CZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTe-0003qG-N2
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so9273055e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727999000; x=1728603800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdTDYhDUNRanYUWv5agjrp+BpprZZ5LHmcMTx/9wIGM=;
 b=Z9mCg5z4XKEzlJdLQqqhhgOk41yfJHcrkgw9sVzLczW/FX41Qcm5EOJpwiFOVCoSz/
 iJ36tUPKR4iBmj2Z5mVUoBWy+Y1cLijwCNItpT5m4XSp2Ak0aSJFNXFkndnpOCgofJuG
 202hFZ2gk5R9Vif2+aEKCJ0m4H1yWMvv+hmjBz+klW6Gg3fuoEhb0FnxEVgEu0GwnZxp
 ULCzrT22jVO1xLmdYTkzcA9MaMkyPiXUgFr0JiLaKQIlgFBVt/SRY8BNy7mIOGMe4pbV
 WKG8blVTCEWkODdXDoCXbWEOXJ9fVlYEQjId9i1azaQzWRyj3NCcu/G8+B+q1DctGN0S
 O3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727999000; x=1728603800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdTDYhDUNRanYUWv5agjrp+BpprZZ5LHmcMTx/9wIGM=;
 b=HaRtx6ElAUFWkjHMr9N0MPwHSOKAVoi4WBTbujI5SgfGXLBC0a1zQKdW9oVhvRPgMF
 +XfoSF9KUKNN5RiveFGRP0dPUa2m23IdnuWi6qfpgVaLc34PifupvA6239peEiqtLTw+
 7FZRr1E+TtUKwNgLyX0n3tN0PdS9JxyOfIw7rmcJzTPvocZtpOPP59lBShKtGDQpKRUl
 kHWYM5j61to3mcrB1PsBnbhLc1P/Bnj9Wt04adp5qLa4UsvmoZ2ps+VY+wbBijmrck16
 Tsi4jGUEKvydapG+P6laXsDNO6a+dBjU4+oFnC/3wVKApCDEYy4RgIuwypewPL5NOO/q
 RURg==
X-Gm-Message-State: AOJu0YzcvlrlUIpAl9A+i+kOC8UKtpOssBdkUAECpvbhvTbs53P9ADe3
 lTdCCUbTkHAWY9+bDUCJ2yz8qctbN7kgFzj+CK2zzxznria5UVMzGq626l0Gy5gVB0kaUraQwVM
 c2no=
X-Google-Smtp-Source: AGHT+IFtrsfD2y4Xoskbuwa2GkreRIJVr4sIYvSzKdKxXWgeQsBR88xjo4iMkIkTxTX9Pj3Jl4KLxw==
X-Received: by 2002:a05:600c:4447:b0:42c:b67b:816b with SMTP id
 5b1f17b1804b1-42f7df115d3mr31111865e9.1.1727999000451; 
 Thu, 03 Oct 2024 16:43:20 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b3951fsm1262715e9.41.2024.10.03.16.43.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:43:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/16] hw/ppc/e500: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:03 +0200
Message-ID: <20241003234211.53644-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The 32-bit PPC architecture uses big endianness. Directly use
the big-endian LD/ST API for the E500 hardware.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppce500_spin.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index e08739a443d..8e0ef9467e4 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -64,9 +64,9 @@ static void spin_reset(DeviceState *dev)
     for (i = 0; i < MAX_CPUS; i++) {
         SpinInfo *info = &s->spin[i];
 
-        stl_p(&info->pir, i);
-        stq_p(&info->r3, i);
-        stq_p(&info->addr, 1);
+        stl_be_p(&info->pir, i);
+        stq_be_p(&info->r3, i);
+        stq_be_p(&info->addr, 1);
     }
 }
 
@@ -96,9 +96,9 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     hwaddr map_start;
 
     cpu_synchronize_state(cs);
-    stl_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
-    env->nip = ldq_p(&curspin->addr) & (map_size - 1);
-    env->gpr[3] = ldq_p(&curspin->r3);
+    stl_be_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
+    env->nip = ldq_be_p(&curspin->addr) & (map_size - 1);
+    env->gpr[3] = ldq_be_p(&curspin->r3);
     env->gpr[4] = 0;
     env->gpr[5] = 0;
     env->gpr[6] = 0;
@@ -106,7 +106,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     env->gpr[8] = 0;
     env->gpr[9] = 0;
 
-    map_start = ldq_p(&curspin->addr) & ~(map_size - 1);
+    map_start = ldq_be_p(&curspin->addr) & ~(map_size - 1);
     mmubooke_create_initial_mapping(env, 0, map_start, map_size);
 
     cs->halted = 0;
@@ -141,14 +141,14 @@ static void spin_write(void *opaque, hwaddr addr, uint64_t value,
         stb_p(curspin_p, value);
         break;
     case 2:
-        stw_p(curspin_p, value);
+        stw_be_p(curspin_p, value);
         break;
     case 4:
-        stl_p(curspin_p, value);
+        stl_be_p(curspin_p, value);
         break;
     }
 
-    if (!(ldq_p(&curspin->addr) & 1)) {
+    if (!(ldq_be_p(&curspin->addr) & 1)) {
         /* run CPU */
         run_on_cpu(cpu, spin_kick, RUN_ON_CPU_HOST_PTR(curspin));
     }
@@ -163,9 +163,9 @@ static uint64_t spin_read(void *opaque, hwaddr addr, unsigned len)
     case 1:
         return ldub_p(spin_p);
     case 2:
-        return lduw_p(spin_p);
+        return lduw_be_p(spin_p);
     case 4:
-        return ldl_p(spin_p);
+        return ldl_be_p(spin_p);
     default:
         hw_error("ppce500: unexpected %s with len = %u", __func__, len);
     }
-- 
2.45.2


