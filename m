Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E645C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdI-0005sG-Ql; Wed, 14 May 2025 07:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdH-0005rx-Mi
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdF-00067J-Or
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qTrSTVnWfY0mmIhrJkPgqINBw1atoPtzXJd/8tKth6w=;
 b=WO134a3YDrbuzdPtkWQrCO9il/WaaXadobEpyTDjAZkyMQgT83VFAzOsm3RIc20AoRXh9q
 AMOaorIBUro9NZmgzqWSg3wJjJBJ5HlQncfE0i2DOA77+VcN+d8/i1lwTVkw5kp1XbQ1FS
 pI+h25oIReX9bFUjmN6oguy6/6hcTVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-j3eOuvgEM462cHmgU-hzPw-1; Wed, 14 May 2025 07:50:39 -0400
X-MC-Unique: j3eOuvgEM462cHmgU-hzPw-1
X-Mimecast-MFC-AGG-ID: j3eOuvgEM462cHmgU-hzPw_1747223438
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440a4e2bad7so4456235e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223438; x=1747828238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTrSTVnWfY0mmIhrJkPgqINBw1atoPtzXJd/8tKth6w=;
 b=N99kKZLdE48WsB0JiPyJmZMXt//iNRy81epCL48AgMaMIrcHVTyOBBwhaKYncV/xuT
 ch1eqkAQYvNmkn2DpMkA1s6382NGn4UHLEqLjaqyByeLNKLFY2GNDYtkLkEHbCrYu1sZ
 oJbZaxuMg4Cnh0nr6GxdyNBzFWgQbmpkmCvWay5mIoEgv2F6q0lQNkT2yhMfDiDd0Zc5
 7cKPpbhuzK/9uF7y85Z9QT7xkI8oJjg7wyzJj6ApOqL4JBw7rg19uBqyxS7mWoLdrEQc
 YjvWPw+BBQQjMaVQmWeN1IoxDxVmAyBDXwlrOoffogNlismNP8IPjs90U9s8v7VERrjq
 jOwA==
X-Gm-Message-State: AOJu0YwtKdogE9sfjwVzEn0eN1arUmv35snpn5u3iMO+d5zojOvfZIvf
 k1ZrYU5Ixg8e7/w8vKkMg34MW8YJA4gx16TSxx4Hew7fZSoYQMS9CNC6K/LlVeMLa8+qGu9aFvE
 pBgYTFKso2ceg7uTMlBBZUEUXH9jR9oukM86SLACsKlCMR4kHgPfyKybwy/w776aqEDgNPKn1Vo
 p+7d1b0D75kUIwDgMOwZLWZMqCobCuog==
X-Gm-Gg: ASbGncvS3GJE/OChaKXN/+d97Agz3l/hIwo06t6bUrLXNqLX4n24tJumrQULlRzTq6X
 4gsBkIu2e/yolkyqYyX7HURqlNA7skW1s5cLd1QIF6bAr6dyOgWj6sR7dQipjtqcNbMw3Umwd4a
 +7EmpnlctLlhVgeHmIB7CdT5vt6JTzIr9W0aVVa1OejMj12M9yrXtmrHFziinnNm33fp7nUzAJT
 eJXvM/dKbozUZ+RBgMvBjosQD6tXiBDCM/jKmIDXo7/vtxudrH0SEatH+xjZrSqFRmHGE2WoA2Y
 yxOJLw==
X-Received: by 2002:a05:600c:3b86:b0:442:cd12:c68a with SMTP id
 5b1f17b1804b1-442f1a0d8f9mr30006795e9.1.1747223437992; 
 Wed, 14 May 2025 04:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHenNJ49ygUiV5zCRp3t1kn3VlupfpdZHkRyK70zrYvITwom17cIpnvCCvZwq6btdSorgC0ew==
X-Received: by 2002:a05:600c:3b86:b0:442:cd12:c68a with SMTP id
 5b1f17b1804b1-442f1a0d8f9mr30006495e9.1.1747223437582; 
 Wed, 14 May 2025 04:50:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef8f7sm26028285e9.39.2025.05.14.04.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:36 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 08/27] hw/pci: Do not add ROM BAR for SR-IOV VF
Message-ID: <3a031e395dc65239d031890d038bc354af61dc35.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-1-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fe38c4c028..6d9d3ce90f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2522,6 +2522,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar > 0) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {
-- 
MST


