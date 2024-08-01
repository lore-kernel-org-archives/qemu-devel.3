Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF80EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAt-0005t7-Tv; Thu, 01 Aug 2024 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAo-0005OS-W4
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAn-0001gm-FU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KkHPmgwBXR83hmpRdf4peeHnWvvgF2d+14hJg8f9R0s=;
 b=ENlFUZIgB2Ul6hJiorlV6Yf6elhD3bg5ED7g0zg2DSo69xGg3MFtjL0+OW26Cgfh/CtjLW
 4L75i+muotGn3yS7/I1KwDkC7fpxT3Ioizv8vECoA2yW8yc4WG7zbDcl8nsFfdX5KtAskv
 msUkAvNGbESFjD7eyv9ZtrVo/zPx8II=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-vaI-UWSDPui6dbeXtDNhaw-1; Thu, 01 Aug 2024 06:36:39 -0400
X-MC-Unique: vaI-UWSDPui6dbeXtDNhaw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a766a51b0dso7447873a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508598; x=1723113398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkHPmgwBXR83hmpRdf4peeHnWvvgF2d+14hJg8f9R0s=;
 b=BLS1dqvT6lPpxoBlhmZz+NLlxFWAXYXYv/9HrP+Gp72Gj/H7mVekZ+kbwPKLZiulcE
 3AhjIoAnzoa87BrTlP43u/WMg4XH9dvr6EcOiYxImp6PYJRt1EV66DqrzBpv7JSKAiTq
 b01AOx2dWFXwS8rURU33lpkC8iNjZEwW7PEyqa8VqC6+dHaSWaybIcmgLW0W+K/oBGSx
 XFe5X0BNAyE6L6sJ+jcZLS6wBR+5LuRw9YR7iPtzqbCHqahoQb7/EeIrDonmMjCxD7Ug
 PXv7jfDbuw7Z/+1Hb2pUpeeK3G/NKZHbosLcFWVGHJMX6THyaYSqDxF1AfrSoJScUPGd
 nM1w==
X-Gm-Message-State: AOJu0YxvKIe+KbdePWgD+wuwrW1B9/U9dVE1U3TVRynR1hdlM/XVtHrc
 +jZiJT1CEHf+ob+qt78czBSzbVF2w0IeM8cJVZZM2ekJMh8N4zKvgN71yx2U4OXtnwRQCqIvzYd
 jf4IWjP3IJY4SeTcvkB5fG78A7UZq0dyVg2pfZzkkDFhdkQ4kbbEB/hLtskHRzgnX80PMUT+AT6
 darpjZ2hXPtH96/j3/4CFEOLo3zDq3Cw==
X-Received: by 2002:a05:6402:104f:b0:59e:9e8b:f6d with SMTP id
 4fb4d7f45d1cf-5b6fe52dd9bmr1150665a12.2.1722508598047; 
 Thu, 01 Aug 2024 03:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ/rrLhrx5z69phBz3eiWDIy8ROdi9xooEqTrEgeLYfXIio6t1PQ4cqydl8Y7/H4U7Vu0kMQ==
X-Received: by 2002:a05:6402:104f:b0:59e:9e8b:f6d with SMTP id
 4fb4d7f45d1cf-5b6fe52dd9bmr1150645a12.2.1722508597317; 
 Thu, 01 Aug 2024 03:36:37 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac631b0395sm10040635a12.20.2024.08.01.03.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:35 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/19] Revert "pcie_sriov: Release VFs failed to realize"
Message-ID: <9bab08da4e932e9c95919951792ae09d0a59f726.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

This reverts commit 1a9bf009012e590cb166a4a9bae4bc18fb084d76.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 9bd7f8acc3..faadb0d2ea 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,8 +99,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
-            object_unparent(OBJECT(vf));
-            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }
-- 
MST


