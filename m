Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B789D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84KF-0001UP-GS; Mon, 04 Nov 2024 16:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KB-0001Ed-QJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KA-0005XM-8O
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YkVz0N+ZYz0sOInTQ7tr8J7S7sTGzbncPzAkgRHAQg=;
 b=NrFJT/aWasH+6HrweUnXBvzfGH3o60/gOW4D7pDBLD7KcenO/XzGTzK8GfETMKVS3ZQc+c
 v2JXfWAJRHRnZW/I6u9XhKunsjTwhM32ptsidf/9nrgeEc9z1m91Jlqjn5BjochkCpUMJJ
 pHFqp4EkvRbHEMcMRnePsIC2fvTpkRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Flpomyp0PwO6rj1V6DGfjg-1; Mon, 04 Nov 2024 16:09:20 -0500
X-MC-Unique: Flpomyp0PwO6rj1V6DGfjg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso30703355e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754558; x=1731359358;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/YkVz0N+ZYz0sOInTQ7tr8J7S7sTGzbncPzAkgRHAQg=;
 b=O5eDpYIpDuT3LtskG37wNvqV/dkH383Iz0twubyvLJCE3ijNHs7whZmrUSGHl8nu+X
 NpzpQJAB5l4w7WRGiD2PQxF6xLuooMAAlXGbclAh3OunNL1wuaoO6ULaUyMWDTriBWIW
 2lnqra3DiYq6WpdnN1L9Gz3pNYP4h25vB37WGPjK1aYfNbFoMQwo2t3fApSgYwNNT2th
 ep167SDlj3ulN87BWIzIfkoWULyAmYZMYbZtRb/2boM0mwRPM0oZfzyV/9wSn+OSWgwx
 RUT7JNlA421mdHKlH6Ud15wlQJldtw2wsqbwQKfGVzFqArXi65gXanbXxSrQa4yi/gle
 vzwg==
X-Gm-Message-State: AOJu0YxrB63nuRa2I16LLUSILRbvOgr6fqdTg5ds1H8azl5QV7EaeBuP
 mGOJFBibl53O6jjOv8AR1Aatk+T1tSbRMgRZQWWE63QHCQpDnEk3+SzNi4OY9jbry9qaHUqumx7
 Vpw1nRTAJvocxpDnip2qthM5XaotMsth08KCWt13ISrjT2hvQu0ijSpqimYUkuwldxCC4c5BxQR
 osvrtvdYUcR6lYH0jKp+yrB5+JXRljIg==
X-Received: by 2002:a5d:5f43:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-381c7a6c758mr12746796f8f.29.1730754558529; 
 Mon, 04 Nov 2024 13:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET/jpJhQji/8AsjQhEcmZralLsxtrg2HTRhR+3H1CnlSM/YZjQ054ILqxA6EkmvRksv5piyw==
X-Received: by 2002:a5d:5f43:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-381c7a6c758mr12746762f8f.29.1730754558097; 
 Mon, 04 Nov 2024 13:09:18 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d2bsm14165387f8f.16.2024.11.04.13.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:17 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roque Arcudia Hernandez <roqueh@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 57/65] hw/pci: Add parenthesis to PCI_BUILD_BDF macro
Message-ID: <26f2660bf7a3f0b6e9a939657ba656f4891ff46d.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Roque Arcudia Hernandez <roqueh@google.com>

The bus parameter in the macro PCI_BUILD_BDF is not surrounded by
parenthesis. This can create a compile error when warnings are
treated as errors or can potentially create runtime errors due to the
operator precedence.

For instance:

 file.c:x:32: error: suggest parentheses around '-' inside '<<'
 [-Werror=parentheses]
   171 | uint16_t bdf = PCI_BUILD_BDF(a - b, sdev->devfn);
       |                              ~~^~~
 include/hw/pci/pci.h:19:41: note: in definition of macro
 'PCI_BUILD_BDF'
    19 | #define PCI_BUILD_BDF(bus, devfn)     ((bus << 8) | (devfn))
       |                                         ^~~
 cc1: all warnings being treated as errors

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Message-Id: <20241101215923.3399311-1-roqueh@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 38ffa7bcee..135695c551 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -16,7 +16,7 @@ extern bool pci_available;
 #define PCI_BUS_NUM(x)          (((x) >> 8) & 0xff)
 #define PCI_SLOT(devfn)         (((devfn) >> 3) & 0x1f)
 #define PCI_FUNC(devfn)         ((devfn) & 0x07)
-#define PCI_BUILD_BDF(bus, devfn)     ((bus << 8) | (devfn))
+#define PCI_BUILD_BDF(bus, devfn)     (((bus) << 8) | (devfn))
 #define PCI_BDF_TO_DEVFN(x)     ((x) & 0xff)
 #define PCI_BUS_MAX             256
 #define PCI_DEVFN_MAX           256
-- 
MST


