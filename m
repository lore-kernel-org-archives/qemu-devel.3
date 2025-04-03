Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155D7C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 21:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Rw5-0007EG-NZ; Thu, 03 Apr 2025 17:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0Rw3-0007Di-Mv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0Rw2-0003Wk-5C
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743715033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=M4rWdzZMTs4pl8C+b44mNvuaFQz+JR0KPqTo+/6C3LE=;
 b=LZ8YwUllQJ0phFhdTBhzoF3SE0jVri27+kJLUFdFNyyUzBaNdj5ezEGtStOIB4KiNRrrFH
 hWAal0exE/TPwYYSWeLfW9orDfGQU/1SuIZysXj00cGuarBftIKqOjPqUcg3eEvkE6F2rz
 wP3zs5iFmA2kwi5MUdxj2zdVg1RaX0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-l_KihmyfPu6-EUHqIHLi9A-1; Thu, 03 Apr 2025 17:17:11 -0400
X-MC-Unique: l_KihmyfPu6-EUHqIHLi9A-1
X-Mimecast-MFC-AGG-ID: l_KihmyfPu6-EUHqIHLi9A_1743715030
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce245c5acso15685905e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 14:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715030; x=1744319830;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4rWdzZMTs4pl8C+b44mNvuaFQz+JR0KPqTo+/6C3LE=;
 b=h+smg3Gl0VQCubY/UdBbvUP3nttzgh+Y/79BVx3QBn5A9QltgvPteFnF2Wot8i53av
 t3zMK2KFmUZwsNP6frcPdjSYwlJRhUO8rra7EtGMTQQSP6Gmuli9m+Q9kBtE2iy5XqUh
 tYfKMBP/3KKSrjskTiqVTOOAmBLVJTC0U0CBw/3hfy/iTGF24rt6d3scch71t21tnOoq
 4f6/fKBRJ04Ldh3TyIzDqBIH6bvk9sC7X0uNQbH9bycv9fggK0GM0S7dUvwl2MsCrgGn
 5j20OxcerNIynVtATOxOumSBiIsdXWdfATu5OxVrKlNx6Xphqe1YK4xaDf4unrJCizLU
 lC4Q==
X-Gm-Message-State: AOJu0Yw+faAU1PRCGpmJEBSg2KqEGv16pPumsWJb+nlbilTgv3NP9WAB
 A8pXsJViXQbw55e+9ozr4j3S9YzcwUoaMUpDSCmH1k6TKi6PGYRkfGV2HyVglj9FTabPeSdubb5
 2/gjyox6U6gKiamdJYoHqZ8C0OpEwSonadi6TNYXaN+8MUmlTBQ+BLjk8wNavPtd8yUcNyF0Ydo
 F61vdB+omw5NajQ5qGhG6FRm1llfxVPw==
X-Gm-Gg: ASbGncsquB1TiVKlGPwBTs/gtX1oUa+sFm4FRCknycq3WH+O6BJcYwyxr7B67WV9ciw
 aiS0s9CRr7NAqnqAaR6PXWI2OHhnfmOePfI1yZd8zIpVvz6gTAs8Kkpfia/bHmeSh0PJjRtJfJY
 T8jIzzu7cTDf8wGcm+DRPgtlu0wFbUOhaYP0f8b8WS3Cg9d9USj7PQeR+o8QzBt2zosc8XLgMRo
 CILlYH5T+9MAlIrnR7t1+tZGd+3KR4/gWBN+nV6uNMiQj8Rx9a0WYlBNhal9XNp+MnFPFPL3ZrF
 uQ39EBy9dQ==
X-Received: by 2002:a05:600c:34c8:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-43ed0d6b106mr2210095e9.24.1743715030253; 
 Thu, 03 Apr 2025 14:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkw+uoMmqR8DXfG7r80ZUGFrSjwJmneldKC7CjpsLxWiybhW31J+1+fvLCfhNZvON/z7RdWg==
X-Received: by 2002:a05:600c:34c8:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-43ed0d6b106mr2209975e9.24.1743715029872; 
 Thu, 03 Apr 2025 14:17:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d07csm27738355e9.28.2025.04.03.14.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:17:09 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:17:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] virtio,pc: fixes
Message-ID: <cover.1743715021.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

The following changes since commit b876e721f1c939f3e83ac85bd3c1c2821e12b3fa:

  Update version for v10.0.0-rc1 release (2025-03-25 13:58:14 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 719255486df2fcbe1b8599786b37f4bb80272f1a:

  hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU device (2025-04-02 12:44:47 -0400)

----------------------------------------------------------------
virtio,pc: fixes

A couple of fixes for 10.0.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      virtio-net: Fix num_buffers for version 1

Suravee Suthikulpanit (1):
      hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU device

 hw/i386/amd_iommu.c | 1 +
 hw/net/virtio-net.c | 2 ++
 2 files changed, 3 insertions(+)


