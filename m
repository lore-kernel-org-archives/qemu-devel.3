Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52666C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbo-0002Sl-5i; Tue, 12 Mar 2024 18:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbN-0000VS-Bo
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbL-0004V0-Uc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=akonLPthwYIhBZHpIZGIq9r2NNojszL0eybTb3tNgkY=;
 b=HXawJCETuy4AYLzhUJ8P67m4onfiR9y4MK5W4iWDjMp/r+XZORNUtuTaLIi+iGwe8sUnti
 NWTqgj4jgvQKAsl21mnj7YGXHo7DaIwQ70Wo/y+Vs+o2LGqDrnDNmdAv1Hl4UIupR/hrkJ
 yBs4FsdJ1ZNjaWXGWHi/YZ8RCkcsmhw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-EdPnNFw3MdaalUHAy6TPlQ-1; Tue, 12 Mar 2024 18:28:01 -0400
X-MC-Unique: EdPnNFw3MdaalUHAy6TPlQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-568728e521bso1094416a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282479; x=1710887279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akonLPthwYIhBZHpIZGIq9r2NNojszL0eybTb3tNgkY=;
 b=K8B+EHGGud8hL1zefhUcBrhvaBOd4/vVsq0BzFF5YKGNxQ873FO8rdsxRfn1R/LdW5
 i/MVmO4CBqj1G33cQ8Z+YRrzW9ouJvjwFaI7H7kgAJ3Gc7HFr+aboLwJhKeTTaFR+c2n
 HFO3cZhx0wfdDbfJNhn2q58t08d4xDk26+s/cxlHFv/olecaUSIQQGUSZPsYZ8hJROPK
 XsFQxQn0g35jpXWzS22fGSRJsK0AvnpfohxhI9NbVFllvn8qsuPYIwo8XQyLKyTqfa9B
 2Q6IPEs5Zo6bvo0G/KlCk4TPK4jM+1U/dq+K7O6wnoChmg59mnc7bMc34j7t3Q9JepHO
 j3eg==
X-Gm-Message-State: AOJu0YyLkCNXJk6OUt4AU4REB4ibIFo34l1h/JudcnC4YdE9sO2d3Yoe
 ZvaoDT6/Lkyz0c/LrdYMW2M8LdCiuk5U2ucMRLG6j9AgihneMsIzJsfTTnXgaKkCuQKXtKMYxlh
 ASo11jvbVidiZwNX42YXAQpcfNiWIwJ186hAMwOygDRBBYDXv1DwjlcJUbShfJWfp02p0EJA6Kw
 TVrR7FbS4rsj2S6/OJtSTRV957jx8WNFN1
X-Received: by 2002:a50:85ca:0:b0:565:9c76:73c3 with SMTP id
 q10-20020a5085ca000000b005659c7673c3mr2234764edh.29.1710282479559; 
 Tue, 12 Mar 2024 15:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfWqhJk0JNsuF2PrMzMadSWRjBqomqSwwXYF3xskZ8Ar3sCxBUHY7Jt/aQrUTZM3RTh8H+g==
X-Received: by 2002:a50:85ca:0:b0:565:9c76:73c3 with SMTP id
 q10-20020a5085ca000000b005659c7673c3mr2234746edh.29.1710282479009; 
 Tue, 12 Mar 2024 15:27:59 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ek24-20020a056402371800b005682fbc2531sm4262946edb.74.2024.03.12.15.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:58 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 46/68] hw/pci: Always call pcie_sriov_pf_reset()
Message-ID: <1a909e3dd85d5c57a0e6a7e3285a29e57574f80d.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Call pcie_sriov_pf_reset() from pci_do_device_reset() just as we do
for msi_reset() and msix_reset() to prevent duplicating code for each
SR-IOV PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240228-reuse-v8-5-282660281e60@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 hw/net/igb.c   | 2 --
 hw/nvme/ctrl.c | 4 ----
 hw/pci/pci.c   | 1 +
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index 9345506f81..9b37523d6d 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -488,12 +488,10 @@ static void igb_pci_uninit(PCIDevice *pci_dev)
 
 static void igb_qdev_reset_hold(Object *obj)
 {
-    PCIDevice *d = PCI_DEVICE(obj);
     IGBState *s = IGB(obj);
 
     trace_e1000e_cb_qdev_reset_hold();
 
-    pcie_sriov_pf_reset(d);
     igb_core_reset(&s->core);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 447c4de6fd..40159f39b8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7114,10 +7114,6 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
                 sctrl = &n->sec_ctrl_list.sec[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
-
-            if (rst != NVME_RESET_CONTROLLER) {
-                pcie_sriov_pf_reset(pci_dev);
-            }
         }
 
         if (rst != NVME_RESET_CONTROLLER) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca..e7a39cb203 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -409,6 +409,7 @@ static void pci_do_device_reset(PCIDevice *dev)
 
     msi_reset(dev);
     msix_reset(dev);
+    pcie_sriov_pf_reset(dev);
 }
 
 /*
-- 
MST


