Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90944C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 01:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjUGl-0000qi-9B; Sun, 10 Mar 2024 21:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rjUGj-0000nY-G3; Sun, 10 Mar 2024 21:15:57 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rjUGi-0004ed-3q; Sun, 10 Mar 2024 21:15:57 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso3493473a12.3; 
 Sun, 10 Mar 2024 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710119754; x=1710724554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHwAWctlffnFEsB9EUOTNU4LB0CsC5t0/licVpxihdA=;
 b=X/emqoQ50/wRhZwcDECqOnMhmneWRO0HUB+BYkLpV3qaYMlXoT0J+f+VKgWTykRTK5
 CKn1afHNlrByOG5ffhTD3iCBl+RvKpzUccOFq1MVhK/ShJSo12F23fvhUcqewmPBbuMk
 LXWmVGSdo21+joZawsh5HzO04EyHsnlNiKsz7HPBEsVH/06mToT5bW+TtBZSNtk6XMkH
 okvjZdaQmLcfBq3fCuXdOhFaL24oKtwygBuVW7j3jklyJoLKmoJICPNnnrYJoKPGBIEU
 wYPZr+M3/jgh0/cMSx+osGkX3KvAPvqtbKFwP5B/44e9+2aC1aO77BjytvR7JzRoE9p2
 aDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710119754; x=1710724554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHwAWctlffnFEsB9EUOTNU4LB0CsC5t0/licVpxihdA=;
 b=L50LbHL3edr9pw3p4cA/ll2AGkBQO0HDHVEP4rjS7L6+IbfpCItbqk0wZdcpxb3Mri
 YyLEP3zxPBaXnJogJw20BGp5pGT1pg4HDqlnHcmCJ8Gjw5INIcwZ/TSNnc0coQ7nIbZr
 56B3M8UaPhmdUFie318PNoxFibgb5iSj5e5BulmNNMYgfakLDlZAciZXCxnJro5IuvFU
 1XV11dfpyDBPUUnhag60VFTYBonYBOeRiBXdY1607g0OPSzkefPmPnqsdG8PU5tNCN7D
 CwgxK60y4/F0DUrCHMi9y5dGZrXTGI93UlZ0H+WQmiAn0enHvVF4DqvnIyfZkLJr1LGr
 0dew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCAaMSgcyZ0ER35xbb1/CqxPn98In4dmlEd8L+leprkrlhqtexfbX2MaQw8mjju8DJkyp36fHBIqcK/CJXX8BpNigUqfA=
X-Gm-Message-State: AOJu0YylnlHp81dukoySSdeMzaIeGkPxbemKp/Gvms5aRwl6cNqaE05A
 YG1Iq2+sbyjfRx/F8c0gdmeqZBm59GQap4yOM+TUwadsbxRlssAaLguXGMiA
X-Google-Smtp-Source: AGHT+IFklx8j5uNcj6NGk7U7TWJWa1NZIybbhKbOl22tcxlGvuDCNEk9XkjsC0NwPQRB2XecIcokpA==
X-Received: by 2002:a05:6a21:9212:b0:1a0:a438:f161 with SMTP id
 tl18-20020a056a21921200b001a0a438f161mr3054073pzb.25.1710119753841; 
 Sun, 10 Mar 2024 18:15:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a62bd08000000b006e68984419asm92116pff.105.2024.03.10.18.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 18:15:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@Huawei.com, jiewen.yao@intel.com,
 mst@redhat.com, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 marcel.apfelbaum@gmail.com, lukas@wunner.de, its@irrelevant.dk,
 wilfred.mallawa@wdc.com, kbusch@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, alistair23@gmail.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Mon, 11 Mar 2024 11:15:35 +1000
Message-ID: <20240311011537.65043-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311011537.65043-1-alistair.francis@wdc.com>
References: <20240311011537.65043-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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


