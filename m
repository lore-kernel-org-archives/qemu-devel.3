Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58097F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Q3-0000zL-Uy; Tue, 24 Mar 2026 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pq-0000qe-3H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pl-0005EU-V8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fb439299so45578245e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365088; x=1774969888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t6RuVFBjGQxXKkbjdmtXNHPThUXn3bXy8K/7GIwt1EU=;
 b=wcOEbUCBh/f0uzDvPszd6Az24FRfAwQ4R7y48EBOJU1+SbWx6WuV7Cp21BcrAMLDpg
 +ag5jJrume9OsP7cY/T6qFkDht+YiVZu8xO3WcsfKcKu+eUIfnYWJizIvMdrcUaO1ME4
 WfGtcPeflnfrf+z+MamRV78QZsLhmhrFn11aLyraMfkjvxO8R+ZzzjOlXQ7Xo6VvUbTw
 r8XsZRyP+Wxz2fnkCRUpiWqUo1WheiMYEYHO/tFbKP75ThqUIyqkRbEzTB2klFPSHH9E
 id1tBPmmLfH0bQ14VY2hm97YHokQdTlbj5tzo3iuYlDLt29GK+OxnRMK7Si09De93/9n
 kN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365088; x=1774969888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t6RuVFBjGQxXKkbjdmtXNHPThUXn3bXy8K/7GIwt1EU=;
 b=iN1knSVzan30ZrSmUyJ8uekAS7gqttJPSrrdFZZUlIN+QZ64ck0M7lL0pq4n1sgDlq
 iu45HPniGdUTce7RAAH08MZuuQA+SrVE4+SmZTR2KPM7wj5R6mun+lHUvQOg/nuHID45
 X0x1oAE31M7DzgF0n/uVr1JMbcN//Q6LWlZ1TUtjtinIcPb0nlNWTYZMJa59ogNpmB7y
 NLw3BTHT7wLu11NEu3QYTO1VU0pT52ecFjPmavN58VpB5Ex55+rq6CMEQbDeUtE/vlXu
 fgkJANDaL0jQO98UrcjklWjsmWYoZK06R/sq7cvk8+NNuC7S4eLfetGoYduOjyrfL0xF
 xGlA==
X-Gm-Message-State: AOJu0YyDT7rvsnrrEwsa+b6p6OX57Sl8hLM0W5BS6o4x1bEdOy/jhny1
 UVlQotQ2BdZ8/U+XQsmPr9oIQmfIF05acvFxMp3aEyzxQ8xCPkoT1p5q1mnUTApxnwyVDI1XnTP
 UCBw98aw=
X-Gm-Gg: ATEYQzy3zUf0pcPQJnkDeAwb1R4aj/Wr2oC+JpjKY0B1LmkVGvZmM6dnoyFtlxuiC/s
 KFLueJQcNz7bcO4WPi0qZJD1qPA8kttBCU48CRXKdhKGMiHsgGtGGzqVYhopevDoiJPrNilRvO5
 khwsTvLo+/RpjdVWWOgpJSYi9f2u5NqDHYCGEwYne7QjrgQJIejbbv31wFt/ZzY8ZwldPRPlbFu
 yroVx+3eiI2FdMWc3oRcnF93cSbdpxAoOWzLFnD6QRTsmebvqS9HRgH0zREiZw9uqZhJQJ3Psio
 xFHWDu+xjY7JsD09ZHPpTNW43x9j2v2KLckYZ2rxj0x9niPC4O/08xFZsHvPQnMJayaTpXOHDbg
 7wWb2oUEsjWIQCgMRJzL3xyqgAG9UL7rWYKHrCqJYWexfUbhnaUmNRumUXOyu3QnePH6cGbl9di
 8N8eoyvUHE/jIcoq9T5BOQqxKns6RFGpisQnDriETdLr634SIUsFL2o/cP0euIaFuSAIlW8tSo3
 XJDgWTUIoFQDB286Nv0msTvNSqpzT8=
X-Received: by 2002:a05:6000:1861:b0:439:b440:b8a2 with SMTP id
 ffacd0b85a97d-43b64277fa4mr25834713f8f.28.1774365088260; 
 Tue, 24 Mar 2026 08:11:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] qemu-options.hx: Document arm-smmuv3 device's accel
 properties
Date: Tue, 24 Mar 2026 15:11:11 +0000
Message-ID: <20260324151111.237411-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Document arm-smmuv3 properties for setting HW-acceleration,
Range Invalidation, and Address Translation Services support, as
well as setting Output Address size and Substream ID size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-9-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index dbcb0155ba..21972f8326 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1279,13 +1279,43 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
-``-device arm-smmuv3,primary-bus=id``
+``-device arm-smmuv3,primary-bus=id[,option=...]``
     This is only supported by ``-machine virt`` (ARM).
 
     ``primary-bus=id``
         Accepts either the default root complex (pcie.0) or a
         pxb-pcie based root complex.
 
+    ``accel=on|off`` (default: off)
+        Enables guest to leverage host SMMUv3 features for acceleration.
+        Enabling accel configures the host SMMUv3 in nested mode to support
+        vfio-pci passthrough.
+
+     The following options are available when accel=on.
+     Note: 'auto' mode is not currently supported.
+
+    ``ril=on|off`` (default: on)
+        Support for Range Invalidation, which allows the SMMUv3 driver to
+        invalidate TLB entries for a range of IOVAs at once instead of issuing
+        separate commands to invalidate each page. Must match with host SMMUv3
+        Range Invalidation support.
+
+    ``ats=on|off`` (default: off)
+        Support for Address Translation Services, which enables PCIe devices to
+        cache address translations in their local TLB and reduce latency. Host
+        SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
+
+    ``oas=val`` (supported values are 44 and 48. default: 44)
+        Sets the Output Address Size in bits. The value set here must be less
+        than or equal to the host SMMUv3's supported OAS, so that the
+        intermediate physical addresses (IPA) consumed by host SMMU for stage-2
+        translation do not exceed the host's max supported IPA size.
+
+    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        Sets the Substream ID size in bits. When set to a non-zero value,
+        PASID capability is advertised to the vIOMMU and accelerated use cases
+        such as Shared Virtual Addressing (SVA) are supported.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


