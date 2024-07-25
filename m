Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3021C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 03:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWp0a-0001ME-1s; Wed, 24 Jul 2024 23:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sWp0Y-0001Le-8O
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 23:19:10 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sWp0W-0005nn-JG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 23:19:09 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cd34c8c588so374862a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721877546; x=1722482346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qcMpgLGL9j8l9kfydq+cIbgvN8tsuQS15sWlL0Mt2Ko=;
 b=B2gSeB5PjQv2AoPX9pO8JkQuzKr0jZ3omwwZAk0ja7ZJS7r+pxW3zZW1pTJV4xlruX
 xM4tLw/jHWH3WvvANE+FaO+Fj1CXLlRDuIdibC0JgZ1mVS85GSwLUspA2z211/a2s5RJ
 ynDaZVqW+oZ8ALZ/hFXFksR0Tvb0plbOwzTtwXTf1AphU5k3M8oqUuMeHcpSRoaLnqsS
 xaaI26d0wec6ueaMaGg1v8czaHbXAGg6h0P2oznLB8eUmtzDyXEyXtvgFOx/SVCIFaEV
 3wFZhausdXfOAzqtDwHAk2xbpFm1oo+lGSqR9m4Mx2YJJ9BaYv2u9lrc7uv17GBGQ4Ue
 j/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721877546; x=1722482346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcMpgLGL9j8l9kfydq+cIbgvN8tsuQS15sWlL0Mt2Ko=;
 b=ijodFcochc5hpIadNsxZcIlsowwpKH55cEAaOmgoJXG2I72KfhxOsleTmEyRTrM+mQ
 PnFiMnWkyL433Q36s7h67crUC9qkJapLGEGpB6XlbWEGbSiCOI7dRt+VYY2M21dpUAIV
 pzN+PHnrPz+5vpZ1h/zAvBxavor4ZhIhHS1xfolCD83mfHbLLyRVyHcaUTMF6oy4P1Y3
 NVA2xDFadhAokRiBUziLotUN9lls0Gi3ValdX4xljD0pPqEY4P0kyxgW4V8+YiWy4fnH
 +UG4VQVQGGAvZvtVUoi/Iso8kl0G7WfIYlRKT6dnIQPWh3xLpyaVPbxnppKzAuWPDepA
 ib+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4jZgo1ithLU87TCZoqqKLtXEJQTO5bbSYxixYJDtjB4sDyDY78ILRvcLulxiZ2BcPdr3MV33KmNaDNNT29KWT4JRUUAI=
X-Gm-Message-State: AOJu0YxSr1sxRmXqVX8PsDxSnZwqiqdBEa4lbXMmKnDhYRBDTNAwldoD
 ZN2wXcKygmeJnmjoI0t8vJ9VzGl/vCDVhe6fM3diF6scaEDuEBKx
X-Google-Smtp-Source: AGHT+IFjiJPrFUPEK8uaoLTVAcloAi5xV3LthBV6+YSeYUOAIzq9Yo77dmuFi9H6yej/5tPV2vYbOg==
X-Received: by 2002:a17:90a:8985:b0:2c2:c149:ca4 with SMTP id
 98e67ed59e1d1-2cf2ebb95b5mr446525a91.43.1721877546371; 
 Wed, 24 Jul 2024 20:19:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:300:0:2:6482:27ff:fed7:6de1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb738825dsm2455524a91.8.2024.07.24.20.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 20:19:06 -0700 (PDT)
From: YeeLi <seven.yi.lee@gmail.com>
To: mst@redhat.com,
	yi.l.liu@intel.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, yeeli <seven.yi.lee@gmail.com>
Subject: [PATCH] intel_iommu: Fix for IQA reg read dropped DW field
Date: Thu, 25 Jul 2024 11:18:58 +0800
Message-Id: <20240725031858.1529902-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=seven.yi.lee@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: yeeli <seven.yi.lee@gmail.com>

If VT-D hardware supports scalable mode, Linux will set the IQA DW field
(bit11). In qemu, the vtd_mem_write and vtd_update_iq_dw set DW field well.
However, vtd_mem_read the DW field wrong because "& VTD_IQA_QS" dropped the
value of DW.
Replace "&VTD_IQA_QS" with "& (VTD_IQA_QS | VTD_IQA_DW_MASK)" could save
the DW field.

Test patch as below:

config the "x-scalable-mode" option:
"-device intel-iommu,caching-mode=on,x-scalable-mode=on,aw-bits=48"

After Linux OS boot, check the IQA_REG DW Field by usage 1 or 2:

1. IOMMU_DEBUGFS:
Before fix:
cat /sys/kernel/debug/iommu/intel/iommu_regset |grep IQA
IQA             	0x90		0x00000001001da001

After fix:
cat /sys/kernel/debug/iommu/intel/iommu_regset |grep IQA
IQA             	0x90		0x00000001001da801

Check DW field(bit11) is 1.

2. devmem2 read the IQA_REG (offset 0x90):
Before fix:
devmem2 0xfed90090
/dev/mem opened.
Memory mapped at address 0x7f72c795b000.
Value at address 0xFED90090 (0x7f72c795b090): 0x1DA001

After fix:
devmem2 0xfed90090
/dev/mem opened.
Memory mapped at address 0x7fc95281c000.
Value at address 0xFED90090 (0x7fc95281c090): 0x1DA801

Check DW field(bit11) is 1.

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 hw/i386/intel_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9a768f0b44..16d2885fcc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2947,7 +2947,9 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Invalidation Queue Address Register, 64-bit */
     case DMAR_IQA_REG:
-        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
+        val = s->iq |
+              (vtd_get_quad(s, DMAR_IQA_REG) &
+              (VTD_IQA_QS | VTD_IQA_DW_MASK));
         if (size == 4) {
             val = val & ((1ULL << 32) - 1);
         }
-- 
2.34.1


