Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB658C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4U-0006ay-6R; Fri, 21 Feb 2025 07:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4R-0006RO-52
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4P-00077W-9C
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c79lvmIC7XDPg0zQTrgvrz5zU+cAN9dA2+2j0QFPSdk=;
 b=Flxpt4746WcjCc253L/Df3CT0ZV8OYmtNVm0auDyUfaN0i8B+ZTwNGTeD4s58pbDHFepld
 sVdQ+lqRV4CcPVl8/PC+wgBRMyEjq5lXrr50btJCV99NZjCZmySL0v4Xmc/A1nzww+WdZq
 HdROjyBIEzsn6IU7bOnyUNhN5SR6y8I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-jA0_JEeyOIqs4NYyvnzHGw-1; Fri, 21 Feb 2025 07:23:51 -0500
X-MC-Unique: jA0_JEeyOIqs4NYyvnzHGw-1
X-Mimecast-MFC-AGG-ID: jA0_JEeyOIqs4NYyvnzHGw_1740140630
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f3bac2944so926905f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140629; x=1740745429;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c79lvmIC7XDPg0zQTrgvrz5zU+cAN9dA2+2j0QFPSdk=;
 b=CfZISjmOHpKlfbXXYfN7/QU0u+YOa9dZ0c6ahqckC+iKqhEU1l7fIwNSoiaCMXQdm0
 5sp6ogx50HjuD5HeKd6O5NKBb0C4uHD72Rw/mFEBcez0NhgSQCYahoOSej6WhcPHINUu
 zPAm+lm3XIkQ/1MBXWVMBwKM1hvhn3+nJs5WzSf60QlB/xRyQM7WMO6BjO1Ye6+ZTGdQ
 oG1ax/n+bjl8cji49BsCW8lpmBpg9qhTZDOIqxQbVELbLXfJjgJxSQSlbVJaGTqsB5Cs
 4IAmybenlgqQ33eP7xTnM60vD/pgFyPeu3e/yLm1X2xYwGUNGMzljGSheLtcPbIERifd
 3YVA==
X-Gm-Message-State: AOJu0Yx85q+Gm0RwVcyrSi32uF1KZ0GqukBtVTC1d252ZFDOuQw+NZqk
 F/2DrM9dP3rN7LyebadZpKcjUXiel29hMbhtckq5MzDUjGsgtLPSjnRU7su2UvqgIMrIZSiglqw
 ROde0E8BsCdmcaLcbhO/frMETpCRd+uXZ12I20ksOTaR4elBTTJX1rRl0V1xInYGN9mOqbEqUVB
 F2T8b0bEjXiEafDEA8jOJSixqtYcxzvQ==
X-Gm-Gg: ASbGncs/SKDdf5ijFWvYV8V5Asufju5hOg9DP9eP0WU8SJfGol7jmDfUFohOPP01tbn
 uXzuToxlEamrbGoBNKJUYF4mKG0arsYeqDKACIkv29B+jL7OK/e4/B8wVKKNEcAs7Y5H6fCI3/N
 b53DWhbrI9/Ft5ojk3S2kt38giiSmRQq0Ub2aC+MRwDhgC9wy594LS6CELhN3XUkV/ilYkHGxLJ
 1gYz/k9FCCD8WCLXrDFF9yCQH8ENmM8MdexnaJrWN74HPdnr8Rr06sayrU90yJa5nolL6OQm26s
 YhAnBg==
X-Received: by 2002:a5d:5f52:0:b0:38d:d387:166 with SMTP id
 ffacd0b85a97d-38f6f0b17e2mr2388945f8f.34.1740140629686; 
 Fri, 21 Feb 2025 04:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETYIuEHMaRoMdATYfo+tF0vwvnWwY+dv7D1Lu6nfQZJBD2wIWuRw/G0FlD/TkmWe8mw1DbCA==
X-Received: by 2002:a5d:5f52:0:b0:38d:d387:166 with SMTP id
 ffacd0b85a97d-38f6f0b17e2mr2388922f8f.34.1740140629274; 
 Fri, 21 Feb 2025 04:23:49 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5ee2sm22963814f8f.80.2025.02.21.04.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:48 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL 22/41] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
Message-ID: <06953e7e5ea5e8fa0b7b704bdb66ab1e62f1f378.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Address a memory leak issue by ensuring `regs->special_ops` is freed when
`msix_init_exclusive_bar()` encounters an error during CXL Type3 device
initialization.

Additionally, this patch renames err_address_space_free to err_msix_uninit
for better clarity and logical flow

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250203161908.145406-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4775aab0d6..ff6861889b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -893,7 +893,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
-        goto err_address_space_free;
+        goto err_free_special_ops;
     }
     for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
@@ -907,7 +907,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
-        goto err_free_special_ops;
+        goto err_msix_uninit;
     }
 
     pcie_cap_deverr_init(pci_dev);
@@ -943,10 +943,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
-err_free_special_ops:
+err_msix_uninit:
     msix_uninit_exclusive_bar(pci_dev);
+err_free_special_ops:
     g_free(regs->special_ops);
-err_address_space_free:
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
-- 
MST


