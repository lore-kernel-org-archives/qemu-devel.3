Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBC7CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3V-0007Hf-Oy; Tue, 13 Oct 2026 04:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY37-0006rG-9W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY35-0007bI-Ly
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so26930945e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880790; x=1792485590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dvGw7sYWTHKozFXf7ViNBZ3cO32w5AjyPGAyekjse54=;
 b=TgIlRILGZsXyZ7ASYZ02bsBGpd13VFSYYoUw1LzDygCqy/IJMMLe3wGcw9a1WGsypP
 IBlqPh4ftbgK1E9M1bRsGcjJO2Fp8L+TOLrjFYJazuXDo/ul+fdloGcgoYvABKhRJISP
 40BCzyt0rTMrhpKrAEKjuN2rDGXUjaaRIDjbEEG5oPixa6NGLOAooeM/il3stctv0xKE
 i7eqApWL+iendoeJnpf5Ew8cc0RDw6Wv0c5+8QhWjIFWfCFQqKhcF78i8Jis850JfJBL
 uHd3d6wNqrQG0/ZlG3VFwE2S2EgmoTWHbuJ8I7paAIyx6RR/ugjPU/4Lg2DsmMgdRFKB
 FNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880790; x=1792485590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dvGw7sYWTHKozFXf7ViNBZ3cO32w5AjyPGAyekjse54=;
 b=o2fTGVqvNFVj+Rgp6m9IY9ElB4MZOx9q7O0V9vu3NcSHoqeHt2/SK/ciblcSeGzBeI
 ty/0PKsV6I2XvxZhBs3U3ZjI9EddanhgHfvpTCynFpPt9jrjLs987z6ETnayjK759lSK
 H8eGLVRyY9P9XzUC3ZD/OsUkmrJICaYa0TgUPXdMmx8m30qfdJ2dcU2keuXu/euzV+Qc
 Vv+t5DdFnIPNDhJrBJ+FOMABmX5mFaTVDwrzYtYWqeqCwV784A1aHwfq2LL0qmHBWu1K
 rW2aiHIa4G17PSBIYb3ehVfjcrtDI6oXGwUITouiSPtQ4NZ9Cp2VNUlrSPciIQVbocfN
 pa8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKa2QMmq7I7hhQO0YC2AwLGeQ6xicQRx31JMdIbwPYEgDbXRTmEwugI/p+SB2HHIzNcNelR30lz+h1@nongnu.org
X-Gm-Message-State: AFq9FYJhCNQHxLVTrkJmRB7gGBGFi6cmBkU88na5Lcfnmc8JlKMgVmBn
 RdnXkPZpgW4m4uxpPWOeCJYcZIBrfvQH4izODFgC0nqZE1j1je3xcmHMUFhLYmpXd/hyNfaXiHL
 UB8j8lio=
X-Gm-Gg: AYBFou1sAiPVejjKuf/+yJBA3EeCO+mk9lWZXALNu74edcSnheW6++p4jDKzcEiF0R7
 5biyUH8Md2Kx10RvyU9/gE3C+MUvZEy0J7U7nnsL+yZL3PpAYR5R6wJdcJJLpRxqckwjSGsNS0l
 sJ4Nzwvn3/F3567g4ICKK3npXOTpDKFZZ0BGGylykn380uAL7Z8okLYFt2NtA8Dfk+wqjNg1NsS
 jX1TpHR4APblqI9udBllsG/av+SSDCXA+vqKwaBO1431LvLZDePgHYtXT6Tjulc2bhhA23e0I8y
 h1dmPC7K8XGOUoW4S5fjJVBkr561/P1Tx+KU9+IYxfE2xQTN7OUmFQWciCIcln2k7rm/b8opnph
 dm6uOSVsnh8LGV6IQLPx6lVxtff91wTyGyO8XWi1mkXKpHQcz3dDaQTTx4ZaDzjGJ16knNs4KVH
 wfx69ZWlUMxAaQJcUpyROeg08LwarI7Erw/e9oiEFIPVte6TYy6BCIabaEVjmBc/Ag/wJ4iCSQ1
 q8K37i02IQIwFiBr9vp0AybcEtPnQGwufzSC7iKlHDtnp6YA0KHtu1ja07mW/TYutxfKZ9NXrEk
 4Hc=
X-Received: by 2002:a05:600c:8209:b0:4a0:2375:dc1a with SMTP id
 5b1f17b1804b1-4a18e4cb771mr230905295e9.21.1791880790204; 
 Tue, 13 Oct 2026 01:39:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/86] hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in
 gicv5_get_hppi()
Date: Tue, 13 Oct 2026 09:38:17 +0100
Message-ID: <20261013083933.1024405-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Now the CPU interface knows its own cpuidx, we can pass that to
gicv5_get_hppi() and avoid the IAFFID->cpuidx lookup in the IRS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/arm_gicv5.c                | 5 ++---
 include/hw/intc/arm_gicv5_stream.h | 4 ++--
 target/arm/tcg/gicv5-cpuif.c       | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index ecafb4838ab..fd6456cd8aa 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -531,12 +531,11 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
 }
 
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
-                               uint32_t iaffid)
+                               uint32_t cpuidx)
 {
     GICv5 *s = ARM_GICV5(cs);
-    int cpuidx = irs_cpuidx_from_iaffid(cs, iaffid);
 
-    assert(cpuidx >= 0);
+    assert(cpuidx < cs->num_cpus);
     return s->hppi[domain][cpuidx];
 }
 
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index f45072d8c57..641f3d0f499 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -204,14 +204,14 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
  * gicv5_get_hppi
  * @cs: GIC IRS to query
  * @domain: interrupt domain to act on
- * @iaffid: IAFFID of this CPU interface
+ * @cpuidx: IRS CPU index of this CPU interface
  *
  * Ask the IRS for the highest priority pending interrupt that it has
  * for this CPU. This returns the equivalent of what in the stream
  * protocol is the outstanding interrupt sent with a Forward packet.
  */
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
-                               uint32_t iaffid);
+                               uint32_t cpuidx);
 
 /**
  * gicv5_deactivate
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index eea66a4140e..0b1033c1ef0 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -147,7 +147,7 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
         return GICV5_PENDING_IRQ_NONE;
     }
 
-    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5.iaffid);
+    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5.cpuidx);
 
     /*
      * If the best PPI and the best interrupt from the IRS have the
-- 
2.43.0


