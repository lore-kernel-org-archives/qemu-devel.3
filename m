Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCAFD6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUax-0001BZ-6U; Thu, 29 Jan 2026 11:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUae-0000JJ-Qm
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUac-0006eG-LU
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so1159783f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702984; x=1770307784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8J4eY9wxv1cYUuMQ9c6DeC3OQdL9/UJSVtl7VAJyfKI=;
 b=Az96hfw43lFu6Ug1d+QxrcQZEUdRvx1fYUbronjAIuzO9kc7kvwr6SnPwU/ovNbg10
 tc8i7NimXSdCKu1TSF2hjUcPxYkGUHkexPu6/xE1SqvqohRcrPaBvgO9zaWpdhpLwY2x
 UOBiKqpI742or8cj0RPEVNOFRuN05BJw4KQaqfWpzpanHFplb7EBX5hXBl1P3uBOUApx
 BZBjclJjvtxW77BNkFfS8efuDQPo90CJCgS5x5OFzUfaNakG+nqZ11b8o0eTzy3T0ZcE
 7Tdi9g6s1SNQ9/lHOw/Xg9xmflFWxtcFYi16LBGE9ZXPUUpDsgd5nSlnF59oipDmWJZ/
 SQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702984; x=1770307784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8J4eY9wxv1cYUuMQ9c6DeC3OQdL9/UJSVtl7VAJyfKI=;
 b=pgqXrmCVa4kD0hSflWMN5/1oavX1t0gOxVBfirkvZ0rp/ToAS3X3PggRChZ4l5CNwh
 TaWikHtQyu7b6A+KzvrZGIVchvX42kCf3Z9pSh1h6aaPp74gAm4GMFi2V49EVg57Rd+0
 ZU+dwb80AluZB8eh2hToBP7M6rhu95TlpZgQz5U2T/5ctvcEV1ieDQuPtF8JRX06XEyw
 lPJ3MLg9G8R6zLFJ+kZlPB2GnWxz7ROccdX9p2HxJeHC9+PAQP5MnsnTx/sZCTHocKLA
 ykimz/xVUqAxVvS5ELKpeKZZyOsrIrVLNaIFUOxmComSgeHv72TG+nP+JPkkL9sNcIAi
 hyNw==
X-Gm-Message-State: AOJu0YyMulYFoHKhlccG9jyFodEIbCV5WeXevPsnH3WSC7aEOM4tC+Jz
 U3xlq1DdcagExVHhLTdPAqg8NLzAhB/Hg5DPa+udyq60nM6F7BsHbFTk3enoURvboK0Lnzx3PfB
 GvLIxa/I=
X-Gm-Gg: AZuq6aJPeSbcSfmV+4w+yELP478CJtrpSoZdqszXWu+GtboSvxNNkg4qiL+cy2Zbn5d
 NwhFdxbdNdy7ZCMNo2ip21XFbwact3oz8IfIMPxC5JDqLIBhzMS7L/3yUlznepldap9Vvh3VGjl
 +kqiV0YLl8RGBW0KS4oF94+ymXMJhiFjQvDUFhnj5p3rwUap55LDfYLXnyqeUWV3MkN/PWna4Ls
 0aCgzYJrsSBJCFWnG311Ma8qhsktXDQ7nOAvHROmyuUvO4CneJcOCDOnk881Co20LwYhTp9aeSd
 vkLkoX1ByZ2C5O2xiAhG1HJQfTmVkw7yuUr30Sj5ML8JuPWYBwQc872ZuCqDlCffxjTENQSZ+/v
 x80hB7LhCYm7ZBWlGV21KFUx5hC7SJT7DdyKdcOQd1/P+iJDGEI7uTcbhPaKVSDq0PxW/CbVFst
 j6pRABlNcUUiEOmwnwhcBHxqQqWeAVsA==
X-Received: by 2002:a5d:5d06:0:b0:435:e450:f05e with SMTP id
 ffacd0b85a97d-435f3abb7d7mr126369f8f.63.1769702983580; 
 Thu, 29 Jan 2026 08:09:43 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/43] hw/arm/smmuv3: Initialize ID registers early during
 realize()
Date: Thu, 29 Jan 2026 16:08:54 +0000
Message-ID: <20260129160917.1415092-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Factor out ID register init into smmuv3_init_id_regs() and call it from
realize(). This ensures ID registers are initialized early for use in the
accelerated SMMUv3 path and will be utilized in subsequent patch.

Other registers remain initialized in smmuv3_reset().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-21-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4efef73373..e301bb467d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -258,7 +258,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     info->recorded = true;
 }
 
-static void smmuv3_init_regs(SMMUv3State *s)
+/*
+ * Called during realize(), as the ID registers will be accessed early in the
+ * SMMUv3 accel path for feature compatibility checks. The remaining registers
+ * are initialized later in smmuv3_reset().
+ */
+static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -298,7 +303,11 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    s->aidr = 0x1;
+}
 
+static void smmuv3_reset(SMMUv3State *s)
+{
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
     s->cmdq.cons = 0;
@@ -310,7 +319,6 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     s->features = 0;
     s->sid_split = 0;
-    s->aidr = 0x1;
     s->cr[0] = 0;
     s->cr0ack = 0;
     s->irq_ctrl = 0;
@@ -1903,7 +1911,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
         c->parent_phases.exit(obj, type);
     }
 
-    smmuv3_init_regs(s);
+    smmuv3_reset(s);
     smmuv3_accel_reset(s);
 }
 
@@ -1935,6 +1943,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+    smmuv3_init_id_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


