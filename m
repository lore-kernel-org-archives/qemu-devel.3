Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B673FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWec-0003U1-NN; Fri, 06 Mar 2026 09:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeb-0003TX-Kp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWea-0002IY-0L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso81284325e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809186; x=1773413986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VgeSwyGlOOL9FXbTfD4CL4jcvQ444n+6TDIZiWIbUQo=;
 b=wt1TmgxBDWg0QGElGh85zL+qLMz+0OHqJX448qN0uPpIRXyaQaX6qwaivfewuINyIZ
 35nKbXMgRtCM+7npvQ/0Mr5aDQoATiwZNLZzAN/J8ygRAhwo5Qm+45JBL/R0kJIARx8t
 iHU6k7z2FGlqz9i03qhgCLlmjjxzO21n94eHu93reD+yyNMDW744izyKnx+1BeBG22Ap
 o7zQl1RywEMVOf7Q6XFIdhTm/iXO0DSFEth9tAdd044LQNu5z19Ukm8wuwJqW8M/EXVB
 hwi0RdaCm+U3ZgA2PstWFU4Ooi544IdKcvuki+yJQ7GguMcncCEkLABufydRtbc+x1vw
 xBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809186; x=1773413986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VgeSwyGlOOL9FXbTfD4CL4jcvQ444n+6TDIZiWIbUQo=;
 b=ZArN1xYTmMI99SAvH0TiFxCfmcptARy9xBLzWeSOmuXmsqnLWF5SqhlrnXpY1CtsBl
 itUbqkJDB6WnvmTkZ+EgYgTthGC7co4b9WseN7fZaLWlClpO8NqdxoYQqWBbBHhW+Bbl
 PHU5G14+Oq+YXNLTtFYffVhuV4QEWnVrV9uw3wBcXpTR2oIf1dPSKOL0ZPTeU0clDIVM
 gjZpAhMSXW1LLwJhHyZ9kcktP7UoU8S/BBahAyZX7nAJulFsvcvZblORCCeYigF0ls+c
 MVzvjPYouFRxqnSN+2HKFliqhn2dI9VjfAbwr5O3ryoc9T7GQ2vgdpqdlpmZoaZ+AoGF
 7j6A==
X-Gm-Message-State: AOJu0YyZXO8EU1uRNsX9nFlf97nmxitYUp1sPPA7F1X43R74AcboU8T7
 fks5CWOFZ3/gwBfy4kUR2/flhViqNqBn1dZoNUgM+RLwShpsLId1nYepcvtZGyhy417H+eejySc
 RASql
X-Gm-Gg: ATEYQzzCPBfavB4NFH0tgpaztzaxOgvFlrypAmoG+lYrwWesOR7iAZoXR7QiZcRLppG
 6ol6ku5ZELIA4/d5WoZMUpbLblsMNIV3JfURfE0y0twyXzTQUHDWi7Vj7CU/V88Ga/A1OHc3UJj
 zJm3GDfU3bY6nqu9Vf0OvuPhnTUXyX1EyT4SCus1QI+aw6/cDR/HHJ0DUghdcusVntwUbRqzB35
 vygS+nLW3dAdWBsVf+6EpYhOpmyDD1JCHXcKGzlAPEwgrq2OS+/nV/sm5HmNLQUry0AeYfet47G
 R+iPTF01jO6ORk0FG2UGFClLt+fgxMmReaZFaVXDjAEoXfo31GL9AA4RZReZ4UyDe8tTGpDNpbz
 /RiZcwYyZEMeTst6PfRam4Y6YM+ZAIS/oSpgg8D01j67FMpviGRL+sdQdIOpYG3IXYSGK4aLVop
 Z7q1zRMXJ8EBeckRbvEMVH80loNWB9ipo593NG+eFgpsxb2F6Fv9L0C1AP3Rx9jvSpgVKIRF0zy
 UcBZyyQK54w4cp9xjiwlwfAu420niQ=
X-Received: by 2002:a05:600c:8b8b:b0:485:16d8:4741 with SMTP id
 5b1f17b1804b1-4852690f681mr42810375e9.6.1772809186397; 
 Fri, 06 Mar 2026 06:59:46 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/49] hw/arm/smmuv3-accel: Add viommu free helper
Date: Fri,  6 Mar 2026 14:58:55 +0000
Message-ID: <20260306145939.2162189-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Move viommu teardown into a helper function and use it from the
last device removal path.

This groups related cleanup logic in one place and improves readability.
It also makes it easier to extend the teardown in future, for example
when freeing related objects such as vEVENTQ.

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260226084456.112142-3-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336..c19c526fca 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,20 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
+{
+    IOMMUFDViommu *viommu = accel->viommu;
+
+    if (!viommu) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
+    g_free(viommu);
+    accel->viommu = NULL;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -549,12 +563,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd,
-                                accel->viommu->viommu_id);
-        g_free(accel->viommu);
-        accel->viommu = NULL;
+        smmuv3_accel_free_viommu(accel);
     }
 }
 
-- 
2.43.0


