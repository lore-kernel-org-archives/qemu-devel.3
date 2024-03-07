Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD4C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri26X-0000hC-TO; Wed, 06 Mar 2024 19:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri26X-0000gn-2V; Wed, 06 Mar 2024 19:59:25 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri26U-000849-VF; Wed, 06 Mar 2024 19:59:24 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5a14d7f0e66so144659eaf.1; 
 Wed, 06 Mar 2024 16:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709773161; x=1710377961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHwAWctlffnFEsB9EUOTNU4LB0CsC5t0/licVpxihdA=;
 b=IYq09YD3mbSfUzedLH+YVxYgFGRSCro5YEHEEmLfZG2U42kROW61i+gbxfC0wY7Z5z
 tC2NXZTT1kSc8aMBLRradVEvCK5YZ7ZWdu8aJQn9s5c8CQ+JyAiit8a3zCeRs/qnNWlV
 Hdtk5fU6ZRXJBjQy0QhAy9onXJUP1Qdwe/lP5NQ8m1F3M98Mti/0lTyVEBB85Gi67BJB
 a+KDFQKTEUh3nn8ZxckZkVLzMP3DBSZeVFWr6aKNN6QCKEooqRZKq4Z4S9EIOBbOZRf7
 KMLJ4lpnQzfjh3jcZg8D/LH0gBX9hvBMVGYW72T/bvl8WJl6uSIxjI/WJk59j4PXCgSp
 P2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709773161; x=1710377961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHwAWctlffnFEsB9EUOTNU4LB0CsC5t0/licVpxihdA=;
 b=RiQ6EglwbX7RnMZVgFUPZN7JHP5S0sYZcfu8fMn52nAmo3JCUeIyxk6CXMkCinaWLG
 AmoXSyV2jvMT7e8z074nJtEq0jPQaiTEo+snEBeTdCY7yYI405kxTkEGGsP9qlR9aQ2A
 8ZfWtCsvRtbj4B4lL7Tr0/qQjfP2n/oyuDD9+EISs1yL9/brZo55xRmo2cv4dw027B+k
 8WJnCvegjP8mqLBQHtL/guGrCrL+2EL3Wky2bAi7V+mBtBzDdPfa2dld2saAHhZeLhpR
 TCg79EbxnLds4Wv0GupBRq2cXj4YGRLmKO1eCNm3ZJOX4KjxGnKvGxJv3fsjZsDGYiin
 5D+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWEMik0qC0TUuh91OUD2w/tvSiNqAYA3h4JphGh0y12TaTXZe4bbDIPDPX7sa/FO+rq6NufABuVuInDLSHJurfeHdzt4IbTIFHq7tbsJh7zKgHOYPGoi3NOZgE8A==
X-Gm-Message-State: AOJu0Yy22P6+MrHKSVZ5yNmwf2O/RIcw6u44C6JDyU8NZDvoRr69RBp0
 PZ0dliIhNPppsU+ttWFqa8OVl9+oqEznrW3txbdnpoabdN1qwZIU
X-Google-Smtp-Source: AGHT+IFmEhqBEfOgCdogRcp59FGKbzSdDQtwHdXIqps6G/A9PjdjxQ/GA4krd68wyEAI68j/WhXAzg==
X-Received: by 2002:a05:6358:4904:b0:17b:eec9:8ee8 with SMTP id
 w4-20020a056358490400b0017beec98ee8mr8117781rwn.12.1709773161347; 
 Wed, 06 Mar 2024 16:59:21 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a63f815000000b005dbd0facb4dsm11420276pgh.61.2024.03.06.16.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 16:59:20 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: marcel.apfelbaum@gmail.com, Jonathan.Cameron@Huawei.com, its@irrelevant.dk,
 mst@redhat.com, hchkuo@avery-design.com.tw, wilfred.mallawa@wdc.com,
 cbrowy@avery-design.com, kbusch@kernel.org, lukas@wunner.de,
 jiewen.yao@intel.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Thu,  7 Mar 2024 10:58:57 +1000
Message-ID: <20240307005859.356555-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307005859.356555-1-alistair.francis@wdc.com>
References: <20240307005859.356555-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
2.44.0


