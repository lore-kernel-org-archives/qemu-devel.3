Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571A8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoaW-0002u6-Lz; Tue, 28 Oct 2025 14:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoaU-0002tr-PC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:38:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoaK-0005Dj-KT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:38:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so25052835e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676697; x=1762281497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LiVkULu7cpH5vHA/z/rbLa6gWXf0joU93uS+b0AUFI=;
 b=W2o/QHE9Pbnv7kcpIVuc56Rr4SwyeHGHsEhkTM6qc3+1qSzIqvCu3Im9paA7EdQcJs
 /SN6tmfrc4z7lXGjpEGTf5HccKnS7uOH2FPUFirNrG1u/BdO83XYApV+Z4pmzSgHr7RP
 tNPPwyvd1ATc9aD2EqF9FWsxgWdoTu4Gi+8dHnWtfE/mD93OxHvj8bjTwZVGYtPHCCXN
 MZh/K35hs1tMMWfsnMnJQQnirYF0ddPs+97w+INPX7yCtuF2YXQGpO1f7kMM4Om89XiY
 ark42+layZZ3czw2Hur6BtmuZJxdWLXzgGao5gmggfxwzCBnVZX+ov6aELqLqk7pdmcz
 CQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676697; x=1762281497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LiVkULu7cpH5vHA/z/rbLa6gWXf0joU93uS+b0AUFI=;
 b=bQXY/kORF9/djiT4m9v8THfMVaWGxL11nxtj/zrc0dr9DqgFjCDHpB8nH6Op7u+Yie
 dXb4mDdkSesWJl0+ZzB26yw0dFDgFEqkuyrh1hAZiSjxcCL4kZQkFoQEL5aWdK6QcNDa
 nuG/R7du/arj6SA6HdGyZ+hJ3rY2vwU5d13Vw7173H68Je0RX0xXquS/4ZfL69irI9Q+
 3bD8VfTQ3hiJ4V7hhE8px9pP2O6P6gQ/+ySy43vD7w9UR6u09Z+kEGTHoG1Bw6XbvWDk
 x+45pVV05NmGA+J69Wm35+GuFOMnKIs3KXZDW56Dx1OVOI+9xOXoOe7Dpduk2D55J2EZ
 LJHA==
X-Gm-Message-State: AOJu0YyzgsM2q85QVD71113/ijpEZD58QpI+TKUumA2QFC2BYswZM0sK
 l4gGLQPmXC6TtF5Fx4s38nq5TsUoDpzlv2wT5LTg8GHYigod8msShiJ0pMxRQmmKV9of1JzUL8i
 Exh7JxpM=
X-Gm-Gg: ASbGnculYW6mYJgmQUuNe9LbWTB8Mx/o4eHcKsc3tv8BSPd5xXUsxDIb907mU01PN8s
 wNtfXBmzpEmlYtwJUBFtgJNtDQMW+ggHygn+Q58fEDpFWxJ/pyR71drE/Hw3KeWvrmATRXOkPxL
 3h78fietRzQh1X5G6Z8wRhRqaxtsWJtCnxyKKRoLxD414KLtgoUNgDtHwAHMw0wGgw4CD0KoYCH
 jZ+2PK1QIvAoJPkBdBF07NYAxIs/YVSaUaf72BVt+r1uKc0P3WgkNFQMHZ6T395VhydQ0WNUD8N
 LfjzGGOt4LTghatr+Q9LPGoEkyPxMGO+x0/jQopypiObmPsRDW6KUIOqzvhvTRt4NHf1fyaJpfd
 9Zxyc7losztohyZ6oa4x5aNPrFA52koeJzJ4Rhyv9H8SHoZV0votxgaJWh8hUNQteWInNoXiMwD
 i1yFkdwkSpnfyg6xdv3wQRh+XYoPKaLH/CfoEglsV76M03Iwfxcg==
X-Google-Smtp-Source: AGHT+IHlAKKbu1BvepCk2+xKmeMgOIpCiIa0/Yll5w1gh4uX8422ccZ4n4jMUDX3DYA0RYB95NOTig==
X-Received: by 2002:a05:600c:198f:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-4771e165903mr5014625e9.7.1761676697458; 
 Tue, 28 Oct 2025 11:38:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e202093sm6130775e9.11.2025.10.28.11.38.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:38:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 22/25] hw/sysbus: Hoist MemoryRegion in
 sysbus_mmio_map_common()
Date: Tue, 28 Oct 2025 19:12:56 +0100
Message-ID: <20251028181300.41475-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In order to make the next commit easier to review,
use the local @mr variable in sysbus_mmio_map_common().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 414b3f806d1..dca6e67a92d 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -122,7 +122,10 @@ bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n)
 static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
                                    bool may_overlap, int priority)
 {
+    MemoryRegion *mr;
+
     assert(n >= 0 && n < dev->num_mmio);
+    mr = dev->mmio[n].memory;
 
     if (dev->mmio[n].addr == addr) {
         /* ??? region already mapped here.  */
@@ -130,13 +133,13 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
     }
     if (dev->mmio[n].addr != (hwaddr)-1) {
         /* Unregister previous mapping.  */
-        memory_region_del_subregion(get_system_memory(), dev->mmio[n].memory);
+        memory_region_del_subregion(get_system_memory(), mr);
     }
     dev->mmio[n].addr = addr;
     if (may_overlap) {
         memory_region_add_subregion_overlap(get_system_memory(),
                                             addr,
-                                            dev->mmio[n].memory,
+                                            mr,
                                             priority);
     }
     else {
-- 
2.51.0


