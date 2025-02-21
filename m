Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B52C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3s-0004wo-Cl; Fri, 21 Feb 2025 07:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3q-0004sT-7J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3o-000748-Jn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfkx6yp82DqPMaxn6p6MT4av8h+ImeBPBY6drzozmNw=;
 b=D+x4hVrbdIzEhTg9q5XnSVJdQj8Pq7KNibR+u9rTPz5kpzZOY1TaRguK7tF1dtK+rCJ6at
 Tbi6clLIb+PQQrdF6CSEjSpNLCHfAjnbkv/OyZeaigXfPeRuUXUGQzP55xLWVB4ip+Pbrn
 9uCNnAtQR/eo0FWEXk5h0xdQjPhDb/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-BllzbMgHNWOw-fNmXp0PiQ-1; Fri, 21 Feb 2025 07:23:12 -0500
X-MC-Unique: BllzbMgHNWOw-fNmXp0PiQ-1
X-Mimecast-MFC-AGG-ID: BllzbMgHNWOw-fNmXp0PiQ_1740140592
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4398e841963so22344115e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140591; x=1740745391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfkx6yp82DqPMaxn6p6MT4av8h+ImeBPBY6drzozmNw=;
 b=mnjYYlsNEodpSWe3XzzvzY34ppNJm0ldCTpMk4dKCN0HrC8y85IOTpHx8AiyJUTaXK
 AgRrrVxK/xed3IlwcLhjiuNz0mC349xHELfDCSvOqEIljkyx0zp3eE8bC/gV5FVPFztC
 gp+xEC1sJavrjU0vB4y74PhxOcjpqmvTj68xnq5PJDXXp0PQef7ENuDFSyvnS2f9Q9Al
 rQgoEPS+m8dv0lJnEEEZFOCDtQEhIcgYflD4Ztm1mc8C1zmeGq+C1/Sv8w5B5y+H5ACx
 BFXCGmxuVHFiThA+nPXcpY6KSJKGfshF2HU9dVuizSfONzL5kTpYJw9qVAy31KLGOzh0
 mgKA==
X-Gm-Message-State: AOJu0YzpFqHuVXyndfIyVRSV2asdRw798Ka5bPfIHHEJiaW9iYdbCQE6
 L0syBideh3L2M8Ej/W1NmA4/U94AxuaHCfuUbNU1mk+8vwucjmwnc8kTOsqQjMdOqIqEa/24JFn
 UFkFEUdL+jGuBRVzxdjGTqF3lo4zfrb4oZ57pxD2HX9YTK2RaEtDxyfndMlwK+7/LWnyaKlA3Lw
 VjDNlcBZlss/INcW//h2Tx0wdRh1STiA==
X-Gm-Gg: ASbGncukpwJCDL5hcrUpii/wp1vdP8nqQ6YLMqu24f3ncoJL1kvNxnJpc+4vvm6CED2
 aypYereLxOpSK62MYzOAQaF4m8KZfyrrpb+kZ4wMRjaio0HyxCIGbRCQC0WD8A3wyxbHXSoyxDb
 /MYOJSwMUlORvAUsypxHgIv6LNF2HVs5888JXhgQbhSLcP13bLNCbLzpVU7BkkUvo0aXWnO1ulq
 JTMz4q+lNhBlCHYHnKADZqqRfBDaPCBu/ab2cUYPo1RpKNcWGg8mJR1VQlEGta1PNLdaqta3sZO
 Q1RiMw==
X-Received: by 2002:a05:600c:3c89:b0:439:9ba1:5f7e with SMTP id
 5b1f17b1804b1-439aebb2b9dmr18708365e9.21.1740140591200; 
 Fri, 21 Feb 2025 04:23:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0QupHHnVtVEJcYunHZyS4po6F8CyMlLkfnJFkrKRsEqrEoTWdQDqjuT7zqGuqMerrOuEO2w==
X-Received: by 2002:a05:600c:3c89:b0:439:9ba1:5f7e with SMTP id
 5b1f17b1804b1-439aebb2b9dmr18708015e9.21.1740140590788; 
 Fri, 21 Feb 2025 04:23:10 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3596761f8f.27.2025.02.21.04.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:10 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/41] pcie_sriov: Release VFs failed to realize
Message-ID: <b85901e728d048c931d110bfd5ff8f119cc97df7.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-9-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f1993bc553..db087bb933 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -93,6 +93,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }
-- 
MST


