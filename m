Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F16108E1E9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQV-0007oL-SC; Thu, 19 Mar 2026 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQS-0007m0-AB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQQ-0005rt-C9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:28 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso1274629f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919224; x=1774524024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAiGye3fGjBysGoywQdBfxZN9m2vlKGDWnrT8pe3/go=;
 b=BvXLvQiIN9KutyTcWmJ9CO8oxqCh2hWb4/u64+KUoC9XWWSg50Gjm2W0hcqLoe0n6u
 +UO/pjtUKLZH0sMuTvmq23tLk2dxu2Q3eae3EM5VeUJWtPTaTnkgIKKo+FeQ6mB6ma4O
 FIP7LmpHXlJMMvvhvrzVAhfRnikv1FkHVxJ/f8dg+XuFceh0Ugun8oXU3bVFRqeWKZfN
 d14nvPsnVuyI1j+6hre6mLJjBUuUirUZ020IxGxbGfTUpuuJaN81uyigoMB95YlmrWof
 qkiqKen3J+N30/0U1zYVTGa8GB2oqJaYFWtatgW77VYPmWGJwVTs2CdxNCpLyj8mwB5b
 a29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919224; x=1774524024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAiGye3fGjBysGoywQdBfxZN9m2vlKGDWnrT8pe3/go=;
 b=f5pF8DCI2L/KZ4x2VOEW8PBKZ6LoGc9eh6he3EkTwE6dVc1TkXU/6gLpVcOU7viyz0
 caDdUz5yK7KEObMyjtnkkmTBqkFXKg3C2FNWx4+Cjesra74vg0X2eKq/iNSW/WZwQ6N0
 K2vOn+3/W3fR2fB3IHGAtQju5Hq6nbHVh9l7MfAmaoRRG227pvVTlQ4ZzB9MvWeWpm3L
 jf3Hm+8DjlbfYJaUDq7CgGSpGyvvlb1X0zq1pHfG821ea4bvM4VLvYrGcqlSJw1yAoTs
 6nCYRGrroPQlfL3fqnp3sPYi90PLcNxTKmRVOn/pP1MMpOHnjlrJeurJI1wNOH3nbyaU
 XKZA==
X-Gm-Message-State: AOJu0Ywlfe2VysgpAu+axuwc0ExmRWGsXWEfJoDTTvj4k4zeG95kHJpr
 gXk6Tjr6ix8HlLJ1ALIhXOXXQ3lewAX2L8+GkDkDHkWFmpP8E3DybID8zneCZTSNdLD/j6FkMU6
 S8MBC9cI=
X-Gm-Gg: ATEYQzxZeRLzKOXZ3UC8jhasxC5342Izb5bi1ApsPoJLFBuOFeKqLblm2rt+Sor2KoD
 0+og4zQtxE+FC9vxm28qeC6UfMyOixRo8ENoEczrBgIP4+pMvNIXNQ6p38AG0a50Hcv52BwxbDG
 ZJiW525HQpMYK2HTizeruG8Dlm9ronhwPEUhpSPj7r8Zr3nwQ1zS3s9dKo3r4EXnwEwT+h9EV2M
 Tm97i+hziy+6CWA3jkQOas3+JtLwo22Mch1tzsFLbX0Gqt3L9mw2wW6DhXAZhLo0+A5ckBnMfZR
 LaCU8SNdNDnIi1bzlIkeVuGnUPS5FpCK31fOZpZg/nF0K31VAMH1hCTKmcESlVWCEmQHDuAlYWR
 /J5e9vZCRRpJ9BeIoSE2xgc2ht8fTNRCU2+HwqRJow/HP/6c+5gHk3p2+4VZqtNPEmh3T9dKHMe
 JYV8tQIrMhXtZlg9jN0Cy/3eteGT6uAM+OEajJk2u9zcjdL4tDc0D6lgLFk8n9GBLiIZmQfofQT
 R+GMeSA36c=
X-Received: by 2002:a05:600c:c493:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-486f8b32877mr52941045e9.8.1773919224256; 
 Thu, 19 Mar 2026 04:20:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fb6b85f3sm11600845e9.18.2026.03.19.04.20.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:20:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
Date: Thu, 19 Mar 2026 12:19:34 +0100
Message-ID: <20260319111936.68041-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

In preparation of replacing the ldl_be_phys() and stl_be_phys()
legacy calls in the next commit, introduce the rtas_ldl() and
rtas_stl() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pegasos.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index ac9fc5a6542..4217af25807 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -591,13 +591,23 @@ enum pegasos2_rtas_tokens {
     RTAS_SYSTEM_REBOOT = 20,
 };
 
+static uint32_t rtas_ldl(AddressSpace *as, hwaddr addr)
+{
+    return ldl_be_phys(as, addr);
+}
+
+static void rtas_stl(AddressSpace *as, hwaddr addr, uint32_t value)
+{
+    stl_be_phys(as, addr, value);
+}
+
 static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
                                   target_ulong args_real)
 {
     AddressSpace *as = CPU(cpu)->as;
-    uint32_t token = ldl_be_phys(as, args_real);
-    uint32_t nargs = ldl_be_phys(as, args_real + 4);
-    uint32_t nrets = ldl_be_phys(as, args_real + 8);
+    uint32_t token = rtas_ldl(as, args_real);
+    uint32_t nargs = rtas_ldl(as, args_real + 4);
+    uint32_t nrets = rtas_ldl(as, args_real + 8);
     uint32_t args = args_real + 12;
     uint32_t rets = args_real + 12 + nargs * 4;
 
@@ -613,19 +623,19 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
         QDict *qd = qobject_to(QDict, qo);
 
         if (nargs != 0 || nrets != 8 || !qd) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             qobject_unref(qo);
             return H_PARAMETER;
         }
 
-        stl_be_phys(as, rets, 0);
-        stl_be_phys(as, rets + 4, qdict_get_int(qd, "tm_year") + 1900);
-        stl_be_phys(as, rets + 8, qdict_get_int(qd, "tm_mon") + 1);
-        stl_be_phys(as, rets + 12, qdict_get_int(qd, "tm_mday"));
-        stl_be_phys(as, rets + 16, qdict_get_int(qd, "tm_hour"));
-        stl_be_phys(as, rets + 20, qdict_get_int(qd, "tm_min"));
-        stl_be_phys(as, rets + 24, qdict_get_int(qd, "tm_sec"));
-        stl_be_phys(as, rets + 28, 0);
+        rtas_stl(as, rets, 0);
+        rtas_stl(as, rets + 4, qdict_get_int(qd, "tm_year") + 1900);
+        rtas_stl(as, rets + 8, qdict_get_int(qd, "tm_mon") + 1);
+        rtas_stl(as, rets + 12, qdict_get_int(qd, "tm_mday"));
+        rtas_stl(as, rets + 16, qdict_get_int(qd, "tm_hour"));
+        rtas_stl(as, rets + 20, qdict_get_int(qd, "tm_min"));
+        rtas_stl(as, rets + 24, qdict_get_int(qd, "tm_sec"));
+        rtas_stl(as, rets + 28, 0);
         qobject_unref(qo);
         return H_SUCCESS;
     }
@@ -634,15 +644,15 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
         uint32_t addr, len, val;
 
         if (nargs != 2 || nrets != 2) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
-        addr = ldl_be_phys(as, args);
-        len = ldl_be_phys(as, args + 4);
+        addr = rtas_ldl(as, args);
+        len = rtas_ldl(as, args + 4);
         val = pegasos2_pci_config_read(pm, !(addr >> 24),
                                        addr & 0x0fffffff, len);
-        stl_be_phys(as, rets, 0);
-        stl_be_phys(as, rets + 4, val);
+        rtas_stl(as, rets, 0);
+        rtas_stl(as, rets + 4, val);
         return H_SUCCESS;
     }
     case RTAS_WRITE_PCI_CONFIG:
@@ -650,39 +660,39 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
         uint32_t addr, len, val;
 
         if (nargs != 3 || nrets != 1) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
-        addr = ldl_be_phys(as, args);
-        len = ldl_be_phys(as, args + 4);
-        val = ldl_be_phys(as, args + 8);
+        addr = rtas_ldl(as, args);
+        len = rtas_ldl(as, args + 4);
+        val = rtas_ldl(as, args + 8);
         pegasos2_pci_config_write(pm, !(addr >> 24),
                                   addr & 0x0fffffff, len, val);
-        stl_be_phys(as, rets, 0);
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     }
     case RTAS_DISPLAY_CHARACTER:
         if (nargs != 1 || nrets != 1) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
-        qemu_log_mask(LOG_UNIMP, "%c", ldl_be_phys(as, args));
-        stl_be_phys(as, rets, 0);
+        qemu_log_mask(LOG_UNIMP, "%c", rtas_ldl(as, args));
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     case RTAS_POWER_OFF:
     {
         if (nargs != 2 || nrets != 1) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-        stl_be_phys(as, rets, 0);
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unknown RTAS token %u (args=%u, rets=%u)\n",
                       token, nargs, nrets);
-        stl_be_phys(as, rets, 0);
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     }
 }
-- 
2.53.0


