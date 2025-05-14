Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975F3C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdQ-0005u7-TB; Wed, 14 May 2025 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdM-0005t5-Pl
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdH-000686-UP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qrT7YVZqMqQb7VpCMB/6NXpFBdOsQA1eCj/jjnmWcsU=;
 b=Eix7nfEeo/lePqI0sXCgXkv6DAeBYthFct+h7YcIRGnIVHaz1nUg3xpKv2dSPwjKXp5BZ7
 g6TbBs68yDh/o41LjWma6KzxK0CcWe0kQ3+6JnIvN8Kjk/eLysUUHqC+2LTMf+wDTR/x3+
 Ql0mvOKhTFvRv/i9IysjQuUrjzZ8EPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-iC-otmjBMeq8BiXk9T3SBg-1; Wed, 14 May 2025 07:50:41 -0400
X-MC-Unique: iC-otmjBMeq8BiXk9T3SBg-1
X-Mimecast-MFC-AGG-ID: iC-otmjBMeq8BiXk9T3SBg_1747223440
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so35321535e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223440; x=1747828240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrT7YVZqMqQb7VpCMB/6NXpFBdOsQA1eCj/jjnmWcsU=;
 b=UtTOUnxGnzNq0VX6mGdSYBT7siMgyqR0fWQEns2tywMmMPGhRylniOlGsuvhd9MD7G
 tHVtU/21+O/CeDAjwolhtna1nyuIwhQFw1bTl2WK1zHsSv7F0FyD1GFb2wgKdcC96hD+
 HFXzmQPiDX+IJhJWn8AdnFpHEivqiJvMd2ptc+fLZQiJaV0hxUATQp8FFFehmBOGluJD
 O7uZfgFQOTPFQ4eSHhZ7rM/Ivf5Ygc0SOckwgmBlIrLQ1mMMeRjyOpKIJfKSizr4SXd8
 A6a+PtDUKZMHRK/7wEug9JYErzxf/lPwlXtHDuCfXzmQRapNxqdJNht6dyXvTFoOsG9n
 21LQ==
X-Gm-Message-State: AOJu0Yw7eN+ahnDmfIdGUxvcHEg6r/kVWHXozS8jdQV4cH2oiruDuXKu
 +pqJrgRAVXgwbT6/0oOUm2wP5GynWnCG9IMStCeFmA2pK7F4d/Op6RyMI7kcyZNs9qit0YGdOtH
 z0cYhRCq2Oz7+rSJ2SsSDbMsYzlPw9aCPvqOb4aE8GMFLMMmawoxieRTmGT3GeXmKXciv03Mkcm
 UHkVFW4TGXt5hMoKu5QP4flebwtODJ0w==
X-Gm-Gg: ASbGncuOz6O7OZpp7wzSraIWU0rixy0/3rXnpaolQsXLl/6mugTq71ARndA2PBDKYUh
 CC3VBh4YjCrhmNO80el+JvxgRudnBa21Fnl9Q43lfbNm4iilqnkupTUzlh8vyuyBKOOoHZdNpIM
 BJBB+rcT43SQ2EzSqHMdbA3L9ijRUa6M4Hi7CbjokCtqA8mM1eJuXbn1mm5RF/SPATveYJrM5J9
 gyILfpXSQVzM9un7Mrsgi4qrdfnDv1rW5s/a1SBRRZg7tC+w/RxHbbUyLueKnAaerHT5DmGfGMv
 7596dg==
X-Received: by 2002:a05:600c:1d8c:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-442f21001bamr26369055e9.19.1747223440193; 
 Wed, 14 May 2025 04:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD+459asvramdbesDBgr0C2KhtZU5FoYyklFa4L6ngEPLqbdWvX2AtkCV6oxg23E/6mbjrtw==
X-Received: by 2002:a05:600c:1d8c:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-442f21001bamr26368795e9.19.1747223439759; 
 Wed, 14 May 2025 04:50:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebd46aa4sm39746415e9.1.2025.05.14.04.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:39 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/27] hw/pci: Fix SR-IOV VF number calculation
Message-ID: <a5745ac183e606937f22bfbf59a7f18e74f3c464.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

pci_config_get_bar_addr() had a division by vf_stride. vf_stride needs
to be non-zero when there are multiple VFs, but the specification does
not prohibit to make it zero when there is only one VF.

Do not perform the division for the first VF to avoid division by zero.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-2-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6d9d3ce90f..039cf1e256 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1594,7 +1594,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
+        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
+
+        if (vf_num) {
+            vf_num /= vf_stride;
+        }
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);
-- 
MST


