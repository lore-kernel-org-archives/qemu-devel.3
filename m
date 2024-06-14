Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D999CC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHvkc-0003Jb-7A; Thu, 13 Jun 2024 21:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sHvkY-0003IQ-SX; Thu, 13 Jun 2024 21:29:07 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sHvkW-00060s-L2; Thu, 13 Jun 2024 21:29:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso1124283b3a.2; 
 Thu, 13 Jun 2024 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718328542; x=1718933342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw00RgKG9Ke3guNs/h7n6V+7+J558p/atK37Il0whdw=;
 b=gxCXB9xlv31gEvV/MI2bdKpH9BvztmAAnsGzv+QuRfQXsGUoOVhu8t+k1PELta/mz9
 40FJcDcV08sO5wY2b7A6FCpYbLA+Af9xk26D0z+XgfwUousxAaaCFLX/w/a2vK7Rul+1
 lOvZtn9weQdq1h9Eg5ALvyyF0sHsegD95GrZzhI/zyuZkjk7DavsMU10xmMqDs358N1M
 VyxjSNt4CGINiLjy6QuuTVHhDqSez2r/4OWA9fqyCH/7U2cc4/r8TrVIQ/LHqJDCPqam
 mL/TXVjaB+CvnFn2TvetxD8Jchn1OkqdJAUp8VryrbwOeWEQDpz0x+hNBzzROJUW/7hR
 yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718328542; x=1718933342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw00RgKG9Ke3guNs/h7n6V+7+J558p/atK37Il0whdw=;
 b=o1NwI4CLXXzwwZ2lannwJpJFVC0qBLKi7K0pzLYIloFmdf3qVQkTTKz2vGgNDOpTdZ
 DeAT3ZahMuUeJHLYe7Anzr7TAPivP3KEFWVhEx80+kS69kfypDxKtXFfJDRJ+B95++ON
 0Xz7eEiyvDzcvTjrb04okaMGpabyko3ZNlbqxoiUUNyz+mwd84I+We/156Pl4soaI0Rk
 arHjKYxvzeWJL084VInmSspwOKJIxD32a+k1j4eoPX6snDTeB1pLmw5r4y49LJfIzZ3m
 STS3v0bsCVh6Ms6441QSZI++QVQNt90mrWypuMiPkR/1TKreVa+6b79xPHXpLE5d9uJo
 3+ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSOvQYSjB5vsXBlgEb8jmvp/9LxoLcKZBLI3eGrPvLWkZ5WyWaWeNtIIjNaEdg5epyMk3xNKSL2dV8Ft6wDImo9vNxR6VWWGNQF1505AvcOfpxm5TAFBTNFxyRXQ==
X-Gm-Message-State: AOJu0YwIY/nroclT/RbwaHLPNGz5S/41NT65m+KfDKg0ehlXNUOeyt1P
 b+RoIeqG4hokOfb5mrxK/HofdFjJ5XFtw19GdBuhp+y/7B1nG/Qr
X-Google-Smtp-Source: AGHT+IFxcojfQUYT0+HqgszjljruaSlotPpuqfNJJoy4iL2zPhbizPetGezZKmaP4oAdsktm072jag==
X-Received: by 2002:a05:6a20:244a:b0:1b8:a188:53ed with SMTP id
 adf61e73a8af0-1bae7de510cmr1901728637.22.1718328542433; 
 Thu, 13 Jun 2024 18:29:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f13562sm20757255ad.212.2024.06.13.18.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 18:29:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: wilfred.mallawa@wdc.com, marcel.apfelbaum@gmail.com, lukas@wunner.de,
 qemu-devel@nongnu.org, mst@redhat.com, Jonathan.Cameron@Huawei.com,
 kbusch@kernel.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 its@irrelevant.dk, jiewen.yao@intel.com
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Jesper Devantier <foss@defmacro.it>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Fri, 14 Jun 2024 11:28:44 +1000
Message-ID: <20240614012846.1016856-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614012846.1016856-1-alistair.francis@wdc.com>
References: <20240614012846.1016856-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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
2.45.2


