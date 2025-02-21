Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3FCC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS44-0005RF-Aj; Fri, 21 Feb 2025 07:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS41-0005MZ-Q8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS40-000751-6J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vVk3p3HEep2LyPnlOovtQs5KCaYeb3tyVgIY2zzDrbw=;
 b=JbQkl58x0gOei1g+BTXdnn8T2sIuDY5FnTqx+E/VjIq1Hn3iBWR31isyZ9XYMDWl1DC+wb
 +33llT3Tf33bEN4YTqO3hGatdvBwt64yfgCiMM1YvKZEH3FKNExjkBgNNxUuIvahT8fonE
 34uWcZt+jwLeAj9VmcxQ1Fz19CsPtC8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-nGSEFI0FMl6MNVwitmIo1Q-1; Fri, 21 Feb 2025 07:23:26 -0500
X-MC-Unique: nGSEFI0FMl6MNVwitmIo1Q-1
X-Mimecast-MFC-AGG-ID: nGSEFI0FMl6MNVwitmIo1Q_1740140605
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43995bff469so22355325e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140604; x=1740745404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVk3p3HEep2LyPnlOovtQs5KCaYeb3tyVgIY2zzDrbw=;
 b=RUWlVl3lLstytF9M78RMIfPkcMaJlVWJALBEWlgqgGxfEqUs7HEMy9t0HNUgY/Eybi
 0POUPcnI9L5+Yp+Ply3KNsTBD6zV72180BZmwZCdZqvgw03syB2GiiK60+a99Lkqqq7v
 tGXnDJQ/PdNY7+i44r8sw0kebRWclQKmf2XTPsfPiHh/Xwul6bGyKFD/Pxgj5S9Own3V
 eoMIw0+I9vgenBYe5FACFOBw3VRYpec5cxiXq0tHuXyXJdMQVrwuMo3qkhIwY085o5ia
 LJ2EkuJi7zA8GN+txisv0p6NUd3YAxqqFgKvrs+n/Ni1UaaWpvXs9j2tuQw4uj5hP0ax
 GCvg==
X-Gm-Message-State: AOJu0Yy8Iuzcda0DjWDqf/kEXMuR9+TpVs8TCyiCO85cDY0ewnhVJz7c
 xyREPKD+ejNYxi3NK4t5YE96b56wlsjCI7TZpz57mCl9nCN5I5Fq0gwzl2xu6NmtWwtvLykvcE4
 UDxgKhdAq0cPiGUw33AZAGHn+9oSLoxuDJt7mxRyp6GDfmTrbnXARjqIT9zZs+TmcyT+k7Avlyg
 I6uADt9kYe4z1OhFzezYFXYpZjy2Lcjw==
X-Gm-Gg: ASbGncuAE2R6fOt6YXM9XzmbRqeL23+nOEcdAZswyAOoEjX5P1RnQjtaIUUBtrqlW3E
 LaVkhica9OFEjPaFTxz5IR+ep9thTwIPYjvqFbPqtakAGVx/rFvw36P4PVxDvggdUup71IIVUl6
 9Pxr4EoToaXS8mDMv7SKNH//cLlhIt2ThdbcCPpK6dK5XRqCGM5USxQgA0fbTo3vxjonr+gXUFM
 GO0j+GVTUCGiIchkgkT/LVGcZc0F1EfXAJW9juo6xYFtqzpqdfJLwZpWGZk3iScPiWOcV+hL1+d
 JE66kQ==
X-Received: by 2002:a05:600c:358c:b0:439:84ba:5760 with SMTP id
 5b1f17b1804b1-439aeae1c8bmr23195015e9.5.1740140604437; 
 Fri, 21 Feb 2025 04:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7dZXy/S/F+QfB+XB0iaRszV02y5v1dVz9dhh8IXaoCTwnbIMIBkhRjQXTIxb1MVLGBGUMtA==
X-Received: by 2002:a05:600c:358c:b0:439:84ba:5760 with SMTP id
 5b1f17b1804b1-439aeae1c8bmr23194645e9.5.1740140603941; 
 Fri, 21 Feb 2025 04:23:23 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce435sm16117715e9.3.2025.02.21.04.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:22 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/41] qtest/libqos/pci: Do not write to PBA memory
Message-ID: <9e837c961a883392f8c4707a8d3d2e6c6aa793b6.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

The PCI Local Bus Specification says the result of writes to MSI-X
PBA memory is undefined. QEMU implements them as no-ops, so remove
the pointless write from qpci_msix_pending().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20250117172244.406206-2-npiggin@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index b23d72346b..a59197b992 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -328,8 +328,6 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 
     g_assert(dev->msix_enabled);
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
-    qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
-                   pba_entry & ~(1 << bit_n));
     return (pba_entry & (1 << bit_n)) != 0;
 }
 
-- 
MST


