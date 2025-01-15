Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3BBC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxCc-0002FW-BO; Wed, 15 Jan 2025 01:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tXxCQ-0002E0-92
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:48:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tXxCO-0000pi-Sh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:48:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so104778155ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736923697; x=1737528497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pY9vdP9KrQzzUAagFD6e3VgrnW7ct4SyKNr03/IIzc=;
 b=APIu33dX+r1r094/wA2X+07GFgOGfWwELcfHxvsq7cZeP3lVGzjms/VPRZ9kSZAo+t
 dhKd5QscMjyBPV5j213ykyb2g7Wbce/5hbh764rJDVGbvnsGxIWjuUjBnIQCJU7zBCk0
 wRGWUbsxjea50NdOqaQX3+h+K7V8NC9RIN1haawPace9hUhq8mTXcV/qH1pVPne8c7ro
 /N/yjory1C7pydLFMNTMUQ/7elPPVrNVfrkY9h5XW8JVU6hZxXJ8GqKm7IWHwL6j8dog
 ChDHBq4JHhrcTJN3jKq/+dhWseET/kv0PT+Vzrf6wpACXUc9XU6+6HoWKgrQvCXDfKog
 bi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736923697; x=1737528497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pY9vdP9KrQzzUAagFD6e3VgrnW7ct4SyKNr03/IIzc=;
 b=sCBFDxrUrW7luUTAzrWBH7UWiYFRCig8E3EMREHUvCEC+OBgCrABlgSppMsVGuoJyF
 4IpKgUGoZvg5OKpjehfhNAeANmVnKjxpSfG7nu+u4mhIWDgYXVBSsChVFvEntR5pWX2v
 /Eljmj5cQnFR6KNty8X4cNOP/G832/i6A2PNSQNUUJ/8jW/7SgFT5fpmmrIVH9yQlI8A
 WfFWDt0+IzlveHb+dv2U8sso9SgirZsDVXFXj8BUYaeTjzR3eZT3lB10BlPIhKIkB8OD
 JARc9OUeWLfJju4wym9ZFxD1r6gBfO2dSjlNDrDxNl4HebrtzJsn/n8HOgTrb3m08JF6
 JIog==
X-Gm-Message-State: AOJu0Yz9JcRYtd0CrUxB4dZQWtDmPiZ9ONAVglGGjstuO/S9BHiso+X5
 TgLkoQZAv+miB0wdiMRAOOPoWfGjdDFSAeRpZzUWs4csOPeiKFkjrVlQIR6lL9sDgZIiHD1tM01
 sMFYpKtJWYIR38kcBg2kxe/qs0XaUkp9mpeJXb7CnTY66SELrvJhRJskQHC16N/kyoZL3FdFXB3
 UbETY6WTQ+mqyInHVVd6M6hZVoUCh+vPytXOWUuwY=
X-Gm-Gg: ASbGncsX9G8pmDwZ0JpdIbAGcMqd2hHjSS87ezXWSmMrLZmmaU1iEdAesUhLGCF0KBk
 EqHNPGGvW5vxgDDwM3HAgxQCrnOsgOza9XQkAgLfBWm2oyetvztRGCCKHsY8Ax6qOkg3y2tKjhq
 eMx11cxlCRDajVOcza3RIkWDFXO9mCI2Jl27aEnVFQpF35rgiBJgQpzglrPY36afdWONTQFQAmf
 3ZCaC2/vgosIqgomuiCHRo85ZY7WVaqR7nJEn6yOkgCR74BgZIcsJ+Yf1SxcUkmitHLkKQRk+fO
 W6+BlGsf
X-Google-Smtp-Source: AGHT+IHSrZXijupkuYB1HEg2VkUP1gfVxOifl29QPVUUCBNGQj+aMbfxeiD/WzDf5hEeLzmClwiEqg==
X-Received: by 2002:a05:6a20:748b:b0:1e1:a0b6:9861 with SMTP id
 adf61e73a8af0-1e88d0e21dbmr45074921637.12.1736923697324; 
 Tue, 14 Jan 2025 22:48:17 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4067ee81sm8668470b3a.132.2025.01.14.22.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 22:48:16 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 2/2] hw/riscv/riscv-iommu-bits: Remove duplicate definitions
Date: Wed, 15 Jan 2025 14:47:37 +0800
Message-ID: <20250115064737.16350-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250115064737.16350-1-jason.chien@sifive.com>
References: <20250115064737.16350-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x629.google.com
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

The header contains duplicate macro definitions.
This commit eliminates the duplicate part.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 485f36b9c9..de599b80d6 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -50,8 +50,14 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
 #define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
 #define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
+
 /* Payload fields */
+#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
+#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
+#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
 #define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
+#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
+#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
 
 /* Common field positions */
 #define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
@@ -382,22 +388,6 @@ enum riscv_iommu_fq_ttypes {
     RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
 };
 
-/* Header fields */
-#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
-#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
-#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
-#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
-#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
-
-/* Payload fields */
-#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
-#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
-#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
-#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
-#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
-#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
-
-
 /*
  * struct riscv_iommu_msi_pte - MSI Page Table Entry
  */
-- 
2.43.2


