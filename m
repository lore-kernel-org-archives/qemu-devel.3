Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76328C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAT-0003aJ-Sc; Thu, 01 Aug 2024 06:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAT-0003Xj-9I
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAR-0001bR-Sc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UM/pcylz8F2ywrL5YzbgYZuad5efRC8/J6GmKcjAKuQ=;
 b=M6ISxgPIEbQEXNGs76gAzHPIAf7dCYTuylHtN5EZRKBLQz7SkNDwBKOhsjdhWdaj1lHide
 //QJCb7DPpSZXc6M4nfSK+8ne20fjev/rxY4QGtDGHr/VEhOjGXfyGsXc6plejQa2FJTB3
 /78DxMQHRyEkeFHlEHPBoBJJC9NUDhM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-hPEz-PkLMm6mJUTQcIJaAA-1; Thu, 01 Aug 2024 06:36:18 -0400
X-MC-Unique: hPEz-PkLMm6mJUTQcIJaAA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52efcb739adso1230455e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508576; x=1723113376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UM/pcylz8F2ywrL5YzbgYZuad5efRC8/J6GmKcjAKuQ=;
 b=CbVe+gD/T3zzo9rCi8Kb1kC9M6aEFuVOHXfSIhON7lJ8IuY83vzzPWBLO5OkOyCgcD
 JEoyPtCT19jfUx3aS2C7jDGL3F9VfACt963iLbiWZVJaoueacrsSmc9GVAPM0LwQXYls
 Um//DXs/u6uTJE+G5sgFgddMsFCQKkrvO+5CPPkdoZsYw+ig5DV6JB0Cfn0RYBDfuLkL
 eG7EC1xofiP70K3YkXlYk68WFBwwwp3mEQlJeKdQtwBbJt+8pAop2Yum8h7kgUbEbHAq
 MPL6iLpWVVGjQOKTSPRo0JbdfCSgCow5bdUdsl9NexvhJiuXLArIVr6w1PLdXhYhOOEg
 7m0g==
X-Gm-Message-State: AOJu0YzZis1NwEhQnztWfQlDKd7HDRS3qRyhtob0aWSvlgR/QUxF55q+
 LUtkXx2tTxv78hwJSI+GiinyJtoYAzi8d62rnZDM9ZgxrI8Bk4gBxubj/QIKVeWwTpF5dUE8cGi
 QWxZrZozujovn79JOT/jHUvWBYgKs1Y2ikIqxakSm9rM+8l0Hy6D/OY6ICVa5+mbB1Vec/67ABy
 6uWh8x8U65tJrw4qTXy9uSaIs9FhSlLQ==
X-Received: by 2002:a05:6512:3f08:b0:52e:9c0a:3514 with SMTP id
 2adb3069b0e04-530b61ebfb2mr1277828e87.44.1722508576207; 
 Thu, 01 Aug 2024 03:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh0PrB7EfhlOroEgFXg5fSnOn/bthGEE7TXKNUV/XEolw7G182/qfdPkLYKaDHgFO6jK0CmA==
X-Received: by 2002:a05:6512:3f08:b0:52e:9c0a:3514 with SMTP id
 2adb3069b0e04-530b61ebfb2mr1277799e87.44.1722508575332; 
 Thu, 01 Aug 2024 03:36:15 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b64c074f9fsm1682515a12.97.2024.08.01.03.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:11 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 07/19] Revert "pcie_sriov: Ensure PF and VF are mutually
 exclusive"
Message-ID: <da44479b1d79dd31eabaa865260ad3e679cdf2e1.1722508478.git.mst@redhat.com>
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

This reverts commit 78f9d7fd1989311040beff54979bcb2a1ba0aff2.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 6c79658b4c..56523ab4e8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,11 +42,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
-    if (pci_is_vf(dev)) {
-        error_setg(errp, "a device cannot be both an SR-IOV PF and a VF");
-        return false;
-    }
-
     if (total_vfs) {
         uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
         uint16_t first_vf_devfn = dev->devfn + vf_offset;
-- 
MST


