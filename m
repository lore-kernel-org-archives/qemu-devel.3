Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6A606D804
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P3oOnhd+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0N-0007J7-Oc; Mon, 09 Nov 2026 09:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ09-0007AL-3p
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ07-0008Ai-F1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so10629575e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233133; x=1794837933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FZAwqCiEl1W88wep/IFipCYSS4NkriudY1WvKjdITM0=;
 b=P3oOnhd+JOcQCO79GO0zeHDdWOXMQSdFYkI/0P49SOQb9bdLDGXidWoROoKcdiNJaB
 Mk23J4/wUMLN8tly5XhEKjZ1I3q6x8QR9sWs7vILSs3XkOFm6JcbrOD8KuTjNRqdqEfO
 892qrdMqA/bMexqa0VaHnHICP18A8higyZGeY7YmX9DbR5PvWlvA3A/LiZgS34ZAJC9e
 NuNXCuHJauXXbAm61RVzGvcnmW1HsLGUpkYhwu1iScqfd3kR3BOdlwK5NoHq9JQztaEk
 MxFv68O3k98x7vtjTkkWML37sjin90ofzx142UsaZHIzOOKNS866brRE8Pia072Y/0Of
 /d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233133; x=1794837933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FZAwqCiEl1W88wep/IFipCYSS4NkriudY1WvKjdITM0=;
 b=uTyCiuRB60DkjaqxnQjz2MrLAAekObx2TGHxzbntGSC8ierzOxdI3lAnEOFWsOb3Zx
 wM2ifQy4YZSQNp+d++0ppHd62qh/E7nh8XLDQWzLr9i6+oM9z00nj+5zfKynPxS6A1j0
 60jCZ+ZXKUhgqYni01/yArGBd+uEy2mJ5OtAZGoiuc5M+VDkn2Z35qN4vxfOqnD95tvy
 fccLGpjVCtxmP94SUAlFD2LWhZmb4ApOq+0C1HHtsMPz7URcKh4fF5VyDXmp+npjYctm
 Cgpv3kvNmpKs4wuQCg652tAFl3K0I0EcEPx+5zh1fRV2in9aWxhEB5qn5Mu0iRWUX0LK
 Xo2g==
X-Gm-Message-State: APuU4Z9YNd9qYLA/rgj0wi0deT+Qun30WrVz4OSCHkzGa3rLo5otGEL7
 z32rqBis9v3xCqQZPdKHKyAM4xhin+FnqgjZBZVeu4Pqqm8JsjE2BGIfEETgk4g9+cRhiNE/jgE
 AokMXgEg=
X-Gm-Gg: AYBFou1LIZCayohpPSZZHsZv6+XcwqVv4VZ3UUq/AnPX7VhiYvs5ewboCS+zXShz8vw
 JALERKqNrgEY5cUmjTLdqAg8rNKWA6Oski/PWOFoQ2qa5IG8Z7xXmEuNmMIaGK2CEj6TCLfFWMW
 RVQK15cqvMfEzWEniSKslk5SemJW+31PuNdovqOIO11pz4BVYDze4OAioDGad+7xuZditONgTqM
 v/FVOOdTXbG+0OsOnqHsP0NfzGNyd+qcgZkonwYWXTvpC6qQR1yuqfjJzZ2Z5nr6/mGkPjH3+VA
 zE5CwgjvkUBcdxpKcalUlYzCIMg6ZOgDEznwvZR+8kEWceAcsIpA+zuwK4GZfSMyJYWQPiC2IYA
 4dh0QENA8UE/BHwLsx4OaLlNVNBHuTcT2bOJOihkGxYJIT8LHTwj7sExKQA0PBg0k/Qkw9ooOKe
 SQbNBNB0u06y38ufDoeXA7L8bx1WIy8R2LYO2nZ0nUMBYuQgXNYPaw6Q8pKJ/LZlGcvMvhILPtk
 EEkjhvswY3wM5xIBdDSGUEPw0DDp0J3C/gIKEQos5AZ3iH9PaxmEWb0Xcnlp2IG4O+JRlxU/mxj
 8KcUG72V2jtoc2RmwpZGJk2XQ/MpXU6Fc6O1UHgGnCuUTfe4eN1lA9BJeveaMiZ5M2t14mpwu4k
 Tecx28B3wI99UplnNj/oEDCOkQTYKMGv80uhMjLisgrhHhgdH8dCaQkM=
X-Received: by 2002:a05:600c:4e45:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4b963c75f1bmr78416325e9.7.1794233132718; 
 Mon, 09 Nov 2026 06:05:32 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/intc/arm_gic: move num-priority-bits check
Date: Mon,  9 Nov 2026 14:05:20 +0000
Message-ID: <20261109140523.240161-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We check the num-priority-bits property for sane values in
arm_gic_realize(), but the property is defined on the "common"
superclass, so it is present also for TYPE_KVM_ARM_GIC.  Currently
this misplaced check is harmless, beacuse the KVM subclass never
looks at the property value.  However, we are about to make a change
that will want to use the property value in code called from the
common class's reset method.

Move num-priority-bits property value check to the common class
realize method, where it belongs.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20261106-gic_read_bpr_from_property-v2-2-9f096cce4814@linaro.org
[PMM: rewrote commit message, moved patch before the change that
 it is a prerequisite for]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c        | 10 ----------
 hw/intc/arm_gic_common.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d4b79e6f34..b60f1f630b0 100644
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
index 304d89cf562..a7c0763ab6a 100644
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


