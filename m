Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F47C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rT-0002vR-PE; Wed, 15 Jan 2025 13:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pm-0006p3-8e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pk-0006fg-PP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tenv3/Fn0175pDVwISZvpL0yo8/HEzy+5ymjzuGHC9U=;
 b=jGQiuISy2L1Yoy7vDg3R9lBmFI5SfQ67/2i44VSGwWLtc7sbt4FWzHzyeHDlaxZXPMXB0t
 GVys5CnbbmKWdG15Lme+BbMD9WnKy9y9Vwq9wfhg17Hymvol5A+TeoV/TfnuOx0MZMRVfc
 JsZQmFndTxMGCatuKKJS9w8+01Y7Zfk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-vJBA7SRbM_aZvqzg9GRqjg-1; Wed, 15 Jan 2025 13:09:38 -0500
X-MC-Unique: vJBA7SRbM_aZvqzg9GRqjg-1
X-Mimecast-MFC-AGG-ID: vJBA7SRbM_aZvqzg9GRqjg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so39300825e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964577; x=1737569377;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tenv3/Fn0175pDVwISZvpL0yo8/HEzy+5ymjzuGHC9U=;
 b=rHa/0MdhFC/PkBDRxOOqcHTIF58aznMYLFjUBQ0qTuCkQhRicaoHpX2hwMyyvUAQwH
 jx5NSiVK+Zw1A62st7qlGXtZHF3lGM2Rr5rKAaLRRNv7BwOJS4iswFfK4NgDeEFfUC2E
 C35KIkQNQ2uaFRYkTLNNTQWUZW+77qBYazfluhRYNnDv6DDvlDLy7nYQBumrhLS2cWDm
 gpu6liwTihw6rHFkFvPYQcej2f15TfINUOifmyHVksAeD5ItsquFPBpvbIMTOr5CVafw
 B0X0LYzUbW9RnzkWFqyEwLAdLHgJYzuVUehH1iRPAFhRMr1o54S6QwUaBB97hnZT+GHY
 9xlQ==
X-Gm-Message-State: AOJu0YzuNMQBvL3Z6pqDNTXIdVb89Ub3UQ63AZ/cvvVpGwUkDkEnHqBx
 UmBRpEavBuRKWVML+Zuuu5YdsS4+mjbBCwTFyZv45zkSfwgdG7Ydv5nBQ0Oy+E7sgYlFOZySGcx
 77e5hDFMvCwnXwn4yYM2aC1U+JaerEm+W+mXxWrdfNcwNG8E4FojZdRD+3eEFPn1PQPjZDqV+Y6
 +FlpduBw67pDLQIvisIpLqZChuOJ8m9Q==
X-Gm-Gg: ASbGncvFX9dadsrjXQzy7IAPD69QLsq5/rm2sD9NxYIJiBhQkEiSscML9ATgi7SwKDy
 WHyOj21F5A3NW7pHO1ne8wJv3RANLT2621or9X7gI/gppQnBS8unGki898qKCCZl7a4Dx5a1EBK
 gpQPuSIa1h08w4T0GQhmRaSiM19H3nIzqiSvEXvdTv09kYNtD1BS+A8LPkffDUZWIRX9WS/l/PC
 +wpUQiLhbYg3sdCJYCrnXTSNU3BT2WfuYhVTIaLwjVUyZflSoLD
X-Received: by 2002:a05:600c:3c97:b0:436:840b:261c with SMTP id
 5b1f17b1804b1-436e26ab54fmr243211765e9.19.1736964577116; 
 Wed, 15 Jan 2025 10:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkWsvTlCCO0h3rZ8fopHRAB+doxkT01YEymJhlBChmWhc38vAC7/Frsc5HpY2hjvNZsIrFCA==
X-Received: by 2002:a05:600c:3c97:b0:436:840b:261c with SMTP id
 5b1f17b1804b1-436e26ab54fmr243211475e9.19.1736964576654; 
 Wed, 15 Jan 2025 10:09:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499bbasm33026955e9.3.2025.01.15.10.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:36 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/48] intel_iommu: Set default aw_bits to 48 starting from
 QEMU 9.2
Message-ID: <ddd84fd0c1f8f62e8384591f7203aaabb935199a.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

According to VTD spec, stage-1 page table could support 4-level and
5-level paging.

However, 5-level paging translation emulation is unsupported yet.
That means the only supported value for aw_bits is 48. So default
aw_bits to 48 when stage-1 translation is turned on.

For legacy and scalable modes, 48 is the default choice for modern
OS when both 48 and 39 are supported. So it makes sense to set
default to 48 for these two modes too starting from QEMU 9.2.
Use pc_compat_9_1 to handle the compatibility for machines before
9.2.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-17-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h | 2 +-
 hw/i386/pc.c                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index a434c2489c..72428fefa4 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define DMAR_REG_SIZE               0x230
 #define VTD_HOST_AW_39BIT           39
 #define VTD_HOST_AW_48BIT           48
-#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
+#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_48BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
 
 #define DMAR_REPORT_F_INTR          (1)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9334b033f6..b46975c8a4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -86,6 +86,7 @@ GlobalProperty pc_compat_9_1[] = {
     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
     { TYPE_INTEL_IOMMU_DEVICE, "stale-tm", "on" },
+    { TYPE_INTEL_IOMMU_DEVICE, "aw-bits", "39" },
 };
 const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
 
-- 
MST


