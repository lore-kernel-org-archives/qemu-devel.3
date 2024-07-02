Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710CDC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOk0Y-0006wb-9s; Tue, 02 Jul 2024 16:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzp-00059D-D0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzn-0001l0-TR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFIfkLYWXfsdkRs/ADDmSifhmh+YyxsrJ8fplItaj14=;
 b=RgHb5imVKknt5SL12czJy3YZ6MD31+p4kZX809sOKTO+ZQoSa16oRnHC1IM/qiuxRItVGr
 PjBi7A8YY+fD0YWb+55Cg7mc6ElDipVEXaNPhE7HvcK1j2RbiXynZGywPQLU6nr+MNpiDB
 HTJdpgw7mqPPkgi0gewwf8gUASV66qQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-zrUO1PdQO26OK5IB2bjraA-1; Tue, 02 Jul 2024 16:20:58 -0400
X-MC-Unique: zrUO1PdQO26OK5IB2bjraA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-424fb2df2bdso42167935e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951656; x=1720556456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFIfkLYWXfsdkRs/ADDmSifhmh+YyxsrJ8fplItaj14=;
 b=rR1NXhIG/ulyFNkkwooouKpSb3ORSUnYXG7Bb1PXbUzPJNua0g/te4sF/z86hy4ptN
 0hMfXluAfCNU3yU06TT7CjuOk+UGPioRkiz9Bz4RUdzMY1MGxCa0EOivPcV3Zjbp0wBG
 gfSjn7QASd8Fg8RBaFhF7bzQ9heEVDtGgh0hz3XopuRKt41zWEYPo+xnMI5Z+AgLlJHj
 G47+F5q9HT9oTEx+QEJoC49PMUFe/bKVUxG848YVUUvEEBFHoaJq8Nd/aFZHpsB9b/Q1
 23Ct6vLFDTDQe+RPFavLZHTviWaeNNL5Ne/DlYz34YT8ZchJqfhHdNRMjXjPx8J0mMeB
 B8QQ==
X-Gm-Message-State: AOJu0YwTYoZbpoOfnnMwxNjHBRX8752ph0VnU2355KF3bABtn6vgz0mF
 Rd8sbuEYv3ChoOnIRYFgOgxa7u1PU+KhJOykb+hGPl0YlQ24e866X76eUnl9c869h8k0nQliWN+
 4n9xE82m0xVfyNgcXTJT+Z/YE6XXE0TWJnvPriz0t7JwK7Obn+FXplRdD4UnwLu9MjQAEjc7DX3
 VMrXgfEnQOm1EidqV/ABgn5FF6CLQuDQ==
X-Received: by 2002:a5d:4212:0:b0:367:89d3:5d3f with SMTP id
 ffacd0b85a97d-36789d35f35mr1952544f8f.6.1719951656254; 
 Tue, 02 Jul 2024 13:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+3+Y1xG6sT7SpyEr3z7j9pfrnyyMjqlP+aEyCTgV7Y8+WZ63Mjccc+ed1ZZYtEm7IYecC/w==
X-Received: by 2002:a5d:4212:0:b0:367:89d3:5d3f with SMTP id
 ffacd0b85a97d-36789d35f35mr1952523f8f.6.1719951655629; 
 Tue, 02 Jul 2024 13:20:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8ed0sm14171038f8f.28.2024.07.02.13.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:54 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 85/88] pcie_sriov: Release VFs failed to realize
Message-ID: <9593e06b3ab7b99c07fc3b78d84aedc897ebb54c.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <20240627-reuse-v10-7-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea..9bd7f8acc3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,6 +99,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }
-- 
MST


