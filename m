Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83D5C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rx-00052P-C1; Wed, 15 Jan 2025 13:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qk-0008Cl-62
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qf-0006zn-Gl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcEA8Xia0/aKbFvQOw0Cn9Z1faY/ZlIm/oUS1p8/iH0=;
 b=E4mZAvDZmk/slF35G2C3DZ8AduaZ0g9QwloCZO8gzmNtmlpQh6B8r84fHCkJDnx9f12b7h
 /iRFswK+853qbjjzudv7oeqnWcTiopXHH+lne2C8ddQ5Fd60q3rpHaWDaz/r9YbNyP5cvj
 uZsqufYTdQrqXLoPuEcgKju7Hu5KNc4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-IdHsjRuxNFOaLPE0PTeB2w-1; Wed, 15 Jan 2025 13:10:20 -0500
X-MC-Unique: IdHsjRuxNFOaLPE0PTeB2w-1
X-Mimecast-MFC-AGG-ID: IdHsjRuxNFOaLPE0PTeB2w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso55877905e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964619; x=1737569419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcEA8Xia0/aKbFvQOw0Cn9Z1faY/ZlIm/oUS1p8/iH0=;
 b=C5LWh/J8YBRoQamu35WvyfrL4Ye/2PNThDerjnGgEkRBeCC8UyJ4YlG0ksmD+buQRz
 BqH+Zb9HJKUbTisL+sYR63sAb4jalD47mIwjuAJEsVmlq4odc4EBGTo7NRkmy/TsRlQ+
 6qSnrYyk7uiozj3/l/Oe4pTpR55LUIboz/TP/mL/57gBKckZAxyrYrqbe5ojIchJWCnu
 RVHzpWe2FMkMfTbcfh2kAenpPrlqT51fz0TBMByB01tXM4XQQiIJ0gx9/WIZPyaudZoW
 M9bVDRhtRt4sLZhy9P0pVl8Fu1tmn7Af87F/g4FFnW89RkP8zhbsNdN3tH9jtivdpmzi
 8wbA==
X-Gm-Message-State: AOJu0YyLVCXoN4++3Qfc08F5XEM8EFWKUKhGT5AR4/O05+/yqhomA+GD
 qQKMo5pw5AxUmZPZZtakp2mBPKSU86t4reu2sQCEUYvO4xTUscVhEkjlVTlKoMT1HNjVSjyk6E0
 v2EGW5YX3ZaNKstPk5Zty5+DQkBg5ahZlYXgcvHXypSXR1F2xVTha2GBseGv26I0wkwHuthDIb3
 I2WSA/96ZU5sVtOiiGn1t0D87gtz9qgg==
X-Gm-Gg: ASbGnctHwP2/LYkAjbtNduyIO2CIFz1HMH4hQm0xYc2ISk7yDnh9/k6C/PN+rJbgVXM
 C01ACb4o+H+hjxoV7FCDrz+XAPOXtFkTW+BbMyX13XhrseS1N+18klcDkQahYE4J1FWKccrozxA
 HYfut+ilXWd4LGLOdMLm5M8Cz/EAIqNfvydtljzwjLAtsdrSkxFJ8h95ir6n7pmIiHWZTK7c23h
 Duyv4qZ41JYL8dArhMw/m4wEa998+OmPCBEkRP6hVPibw3nXoh9
X-Received: by 2002:a05:600c:3b0c:b0:434:f7e3:bfa0 with SMTP id
 5b1f17b1804b1-436e26e2593mr233770885e9.21.1736964618911; 
 Wed, 15 Jan 2025 10:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP/afa4m7Fa8Xk3Et61DA9Qzhp3PfZtVxEZkeh1+fEfOJSbB8lHNgqS0aepmMaknXAFp/kuQ==
X-Received: by 2002:a05:600c:3b0c:b0:434:f7e3:bfa0 with SMTP id
 5b1f17b1804b1-436e26e2593mr233770635e9.21.1736964618431; 
 Wed, 15 Jan 2025 10:10:18 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7525ee9sm31012265e9.32.2025.01.15.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:17 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 34/48] acpi/ghes: don't check if physical_address is not zero
Message-ID: <2e223c5ec1146b61163d3372ac629d9240d57cb1.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The 'physical_address' value is a faulty page. As such, 0 is
as valid as any other value.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <da32536bf4962e5c03471e2a4e6e0ef92be4a1be.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index edc74c38bf..a3dffd78b0 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (!physical_address) {
-        return -1;
-    }
-
     start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
-- 
MST


