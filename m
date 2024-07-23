Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0101CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGH-00081N-2H; Tue, 23 Jul 2024 07:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFy-0006ht-5T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFw-0002zw-E1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uKdtFU2bD5M7BU4ChiAF5yuLXt6KWMO049/Tq7aTIq8=;
 b=UbPzDVmzmAuyvBdvLmR72HMJNbkWbIJsyp18HTnqzPg/EAiM4891SQVWvvXAqqlwRTiBEu
 W08sn7vvJ2OFDvFLiLqhqgSwE0+AJMW1a7Y0FiZ5oQrUZ2Z5O0kja4JS8oAlnra4jFcMXu
 9CMxOAc5BiHNNlN3VrPw/jaaH49XNnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-hFtjP2QiPNyukDuqSNlRiA-1; Tue, 23 Jul 2024 07:00:30 -0400
X-MC-Unique: hFtjP2QiPNyukDuqSNlRiA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42668796626so40276675e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732429; x=1722337229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKdtFU2bD5M7BU4ChiAF5yuLXt6KWMO049/Tq7aTIq8=;
 b=vXa1nNpcNhEIFHLSuCtJFlVHwU/lS2KdaGisflH/rPlAfqPhfQntkzXDa4t41d+22t
 hFSxNHDHpgK0BVSGjai+q6XcrAu1RWGhA8lEmVAvUv78AMOUl/Pujpe2ehcAWnCipnBu
 F5S+WKwMRumEzAjPADPCyijq3c/hTuSVfRpZC2Uh309Ql8i5PwOpKlJFb66UxVUu0y+e
 pGrplaiyL3FAczTN/FGaYmFwVuWjnXhE6oIySRzmHIVel5M5XEN7lV9PvkhL/YR0UBke
 dBrFu8gPN8iPFtuEkDBl/z/sLYDX1xkUVUJGPO8KEd6PAbeQZxv2XG/GEPMgSsanGg5r
 oMLw==
X-Gm-Message-State: AOJu0Yycz/+gELsmhIPMwj6C8NC26SVryUUe8g5SJdiS8rNocg008URB
 2prJ5Q9sCtMbOY72M824d2bYCd4Wz+mGa+EjbsfT6DGx1FlD33KOCnEq8WCjYEb/iavAk0EX/Om
 68/bFVzMxTbwm1D6DPCBMRNBMF/XlcGOVsWw6yxidSzfS3r8btbrBK16y9Nx0k07Pexk0No87hd
 9fOgdPuHHCe1klENI3ckrEVouYSK25oQ==
X-Received: by 2002:a05:600c:4752:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-427ed06197fmr16759045e9.35.1721732428854; 
 Tue, 23 Jul 2024 04:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lVsF4SUdxXtBno6EpPUiUoCkONqPT2tvAJwb6e/syW+3H8UrZS+IHTebWDA0zCE28rZCPw==
X-Received: by 2002:a05:600c:4752:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-427ed06197fmr16758765e9.35.1721732428353; 
 Tue, 23 Jul 2024 04:00:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a947fasm195197935e9.43.2024.07.23.04.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:27 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PULL v2 51/61] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V
 UART
Message-ID: <faacd2e6b6a85a5eee2472e5a7f50bf69c4ad44a.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

The requirement ACPI_060 in the RISC-V BRS specification [1], requires
NS16550 compatible UART to have the HID RSCV0003. So, update the HID for
the UART.

[1] -  https://github.com/riscv-non-isa/riscv-brs/releases/download/v0.0.2/riscv-brs-spec.pdf
       (Chapter 6)

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-3-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 5f5082a35b..36d6a3a412 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -170,7 +170,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
 {
     Aml *dev = aml_device("COM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
+    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
 
     Aml *crs = aml_resource_template();
-- 
MST


