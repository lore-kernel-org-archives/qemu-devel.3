Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A562606D804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zH+ZmpZT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPE7o-0002vp-Nh; Fri, 06 Nov 2026 02:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPE7Q-0002k8-Lm
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:12:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPE7N-0005zm-O8
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:12:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so2020825e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793949128; x=1794553928; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zmLserNUHH8hDL8xoVhFFdXrJOTDSU6Plbtjgws43Ls=;
 b=zH+ZmpZT77Rl4G/EVjfoR35QSKdJcpPWj6vpl0PPRwG5sw0hPSDMvKCcGgr4Qp5wa4
 llP7sLrv/CGxLFpn4/nRY2RZmWxEgCkojL7lej6Fk/N9QvmV1aUbFNvUdHgHK08ENCiu
 ZA41WQ+X6O7NCLSoUGpgxlxyHFrf4UYXqpZ2CvlHMcBAXGZGxX8NrZT5ZG1ub+NU6LMi
 kWT5S/L2gqBbYG7FhobwZUe+6p+7mpkfWf2J+Njd1FpIsLxThO/9mI90Ln7rVq1oEfu2
 B6kyT0TXrkIau/+CFsMPWcgGMacD2WdrAHU2wV6gftGk8R7FZoGaCK4931zL3q2lrvoQ
 GLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793949128; x=1794553928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zmLserNUHH8hDL8xoVhFFdXrJOTDSU6Plbtjgws43Ls=;
 b=fEAj0MSFeSWXEGwuaH5L4FOucdynDM5wCdJqFB8e7NC00xUwuu42ccx92/JmAteyau
 9cvZT+PSM+wu7pV9myfErxZq8dOzjSPMmCSHFzE5/OCXPEZ6+QgSKg2wcADMQZH7CQDx
 IN1pLGrHjKwt6GvOmmUqdR24sZ4ursMEqK0J7So9WJysSB8MkKc3x3u3PpoR7ODfGTMR
 dZnsEIrHoL6PgnbCOvxI77uGEMUqbMN/z13bpgFdO0BlnYgdLlldQNCyQxBylVrJaVE4
 4eyO/OgVHg+Agtxm9UZ2pA6lqXno2GKUm7OHmbm8QmrlOa1WkTCRcvrd8vRr97Pj0Kw2
 eQbw==
X-Gm-Message-State: APuU4Z/63PUNAhp8UIRlDlTXi3sA6wHv0J21Ct7r9LsOpOej1aWeKOex
 ht73w2Fe/O/gW6HPQBI5GjAvRlxiInxGmByNb19ogayUf+aH/Vb4Eq7Jeqq0EQ29Gfg=
X-Gm-Gg: AYBFou1NN5Zqr3J6Yc6NKI4JiSFbX+OBUtM6eZp6HMgCGZrgxaLLIbTBhmd+BaN7S3H
 CwLj0H7zkZPxPe7LuNamjEeBC5tfeI+FxbCC1wB9V53V+ccDbsp1QeY5NCKV19/6aV91luS+naO
 eJkmAXIMZPv8X3WE3PQ1jAvbVqcBuG5Q9k7+QUx2vyQ3YnPjTHb+HT6bgWTaikq+4y/Dr15jLPn
 1ViwT7/NXGTk0DH9sPlC8aouQxf+Zuwj8en00Yx9HyeoF71x9y9QFHWIpHjJIbdYpTZ1V/STfYJ
 ZAQX9fY/NgBSx1X4tK1Y6H2w+ChAQruti6DeLvpumMQCTO2Gb86R+0v8ReQGS+l5jwqch/k7HSE
 aCdvdEuHuwN/jEmi3fThF72wAuRXL2gox3DaIgxm1QX0HeNuzoaFKvWUpSOFS9H1ThAOUKueAHi
 Wry9N/DmXUHUITp9eLkq0RogGj+tOlSCIBo4B7gUNlkLAg5V28htiRZSy6sHyreJa+NiISOnjo4
 dnjGbB5V64ZAVu8nWgEhPgMnkJmRODtcwR7VOlA8NJbMvpe69q8ekkDvDca1MTf+VXm+pXBydfA
 OmflfZpzTY8WjhvikaO7Fq/pY8vtvTXSUKxIfjv1mTpYQYVHOHVp10sdwoQ2YdEdWefrYtIQXgE
 zdfz2xMipDgwDMX+jvy3pIYB26O9XU71sMCsxMKRqrol7UHb8J6ACnBu2Inl2QsSeXB3HZJKY0g
 PtS/hDwoVbkATHAbMaLNYP+bd9jWHv9xhAg3464dkusuncGHCs
X-Received: by 2002:a05:600c:34d0:b0:4a2:d:5ccc with SMTP id
 5b1f17b1804b1-4b6ddee3291mr21049255e9.10.1793949127607; 
 Thu, 05 Nov 2026 23:12:07 -0800 (PST)
Received: from satan.lan ([94.66.192.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46489sm113916495e9.3.2026.11.05.23.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:12:07 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 06 Nov 2026 09:12:01 +0200
Subject: [PATCH v2 2/2] hw/intc/arm_gic.c: move num-priority-bits check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-gic_read_bpr_from_property-v2-2-9f096cce4814@linaro.org>
References: <20261106-gic_read_bpr_from_property-v2-0-9f096cce4814@linaro.org>
In-Reply-To: <20261106-gic_read_bpr_from_property-v2-0-9f096cce4814@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2792;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=wA6EzcqhtucP+kK9AIB/qb/3iXw/0VKbem4hOtmL95M=;
 b=owEBbQKS/ZANAwAKAXcpx3B/fgnQAcsmYgBq7X3Ed7BM92QLuH/XHISj8DcMYAy0yZXSRGPg5
 gCde7U31r2JAjMEAAEKAB0WIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCau19xAAKCRB3Kcdwf34J
 0IfwD/4roLdXLDgL50iTzRls0PWADCX3zfJGHFgbZDTQ6IVRtSt2VdohmB3XQkXFxYBtl6sxrjS
 hxydy78HefAbV9v7r4ywlhffLZZ7jxPJEIMWPb/MJoCFWFq+zIgyEwSCMgnFoW20jjTkt1o7feY
 CmToc1to38NhHjo3BiD4ScWf50sXiXuainkwjmk6J+ZLcSwLur4L2awvM3UfVv62LZ1UtpOJTDT
 NHEOfzq4Rh1/lDnZqoDRtHDw7CDxc4tXNZ777kHgTLeG5BzG2G9fV1xoKXoKdbIVJfM8Q4H1hmH
 bruK3ScnG38s8lObD94w/EGhf8+APmesnYRPhiTkE+sIdlGa1JU+IQZP3lD+GBLRmHT8FIkt929
 gSktaLXjrxn10Epq/g3pp8dRsTTE4aWbLDwHfuomY3vMHj2bjyV+yFf0rFHO9DuCapnR0GtqaDO
 2e9FMHm2Gcqhxobt/Sr6WE/eRvjQOCfxIItMl730vhLoDAgiAd/njpkFqE7b8QGzdbs4N8cfGWs
 Q1fxUwF6j4KyhBAGgFIJpP+irEHaLp6QIEjqazgPZl2SATxRT/gsb9Z90qeMi4RATseUD2ntlC+
 p+bGKo91eACnuNkZ2dyLix8ltspS4zVT9goeVMI8Vf6WkXAjMxMC5ib8AdRUJhMLip12vawRyVr
 BimBlJXCoWYy1zw==
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move num-priority-bits property value check to arm_gic_common_realize.

Peter Maydell says:

  We check that in arm_gic_realize(), but the property is defined on
  the "common" superclass, so it is present also for TYPE_KVM_ARM_GIC.
  Most of the uses of gic_min_bpr() are in the emulated-GIC code,
  but the calls from arm_gic_common_reset_irq_state() will be
  used also if you have a KVM GICv2. So if the user sets a silly
  num-priority-bits value with KVM GICv2 they'll run into the assert.

  https://lore.kernel.org/qemu-arm/CAFEAcA-eFmvQZ8hoeGJb0hZagBejYWR0_-9-C6iA75m7k1VvXQ@mail.gmail.com/

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/intc/arm_gic.c        | 10 ----------
 hw/intc/arm_gic_common.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 79a68a8648467c1f18dab69cf691f8e44ec2f011..0236f45c3d106a314dc8b3435ac87ce67b6f3f9a 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2117,16 +2117,6 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (s->n_prio_bits > GIC_MAX_PRIORITY_BITS ||
-       (s->virt_extn ? s->n_prio_bits < GIC_VIRT_MAX_GROUP_PRIO_BITS :
-        s->n_prio_bits < GIC_MIN_PRIORITY_BITS)) {
-        error_setg(errp, "num-priority-bits cannot be greater than %d"
-                   " or less than %d", GIC_MAX_PRIORITY_BITS,
-                   s->virt_extn ? GIC_VIRT_MAX_GROUP_PRIO_BITS :
-                   GIC_MIN_PRIORITY_BITS);
-        return;
-    }
-
     /* This creates distributor, main CPU interface (s->cpuiomem[0]) and if
      * enabled, virtualization extensions related interfaces (main virtual
      * interface (s->vifaceiomem[0]) and virtual CPU interface).
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 7ffd94561202f49d767315893085df57a4f984d8..fec5662d695ab2f66feb4dcc6cb02f4692287a47 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -233,6 +233,16 @@ static void arm_gic_common_realize(DeviceState *dev, Error **errp)
          */
         s->num_lrs = 4;
     }
+
+    if (s->n_prio_bits > GIC_MAX_PRIORITY_BITS ||
+       (s->virt_extn ? s->n_prio_bits < GIC_VIRT_MAX_GROUP_PRIO_BITS :
+        s->n_prio_bits < GIC_MIN_PRIORITY_BITS)) {
+        error_setg(errp, "num-priority-bits cannot be greater than %d"
+                   " or less than %d", GIC_MAX_PRIORITY_BITS,
+                   s->virt_extn ? GIC_VIRT_MAX_GROUP_PRIO_BITS :
+                   GIC_MIN_PRIORITY_BITS);
+        return;
+    }
 }
 
 static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,

-- 
2.43.0


