Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A4DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbm-0002CK-14; Tue, 12 Mar 2024 18:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbJ-0000ST-5t
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbH-0004UG-OG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uONnc8dalxn5KqbUxXF6SkXpgxsJrMvte59h3sp2Ce0=;
 b=Z5Fn5NM2CpWCeNfmsKgZdQWBR+V2a6bwdXpHBfjl+KR7ZhamzpF7fQ17PmvqHyXCAaq+qN
 2FPmVQeoH0oVsc38UrvshBr339ST58qaZRTfj3YsGQcS4GSODknvBAM38Mxbksc6BG57Gp
 PM0GZUpgvJGmP8n/k4UY/ki89fd7jjQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-FAGwaPCOMVCHc5b0TfKkSA-1; Tue, 12 Mar 2024 18:27:57 -0400
X-MC-Unique: FAGwaPCOMVCHc5b0TfKkSA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-568647e6d9dso197027a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282476; x=1710887276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uONnc8dalxn5KqbUxXF6SkXpgxsJrMvte59h3sp2Ce0=;
 b=YBId2Zn3M7eTr3oM8U+tguCmZjw/y782ykQWFoZNrv+25M7WPGkGgvFJPTbCRU5FOA
 +8OFR/8Jb5eAysOJo5/mbQ2yDnMxdgd54jiR5ZBpWP2n8Q7dVKqqoyCJG8xB1OQqFMlu
 1DnxPiSkvY90KHeACczx6iy7s9nFjyXuuwEkkUbT6sjWUQ/q4piOUIYtRBS8W0yf/SFB
 kq59mkCong3knQ48p1SzGHOE3crSshkcIeoqIoY9F78oRKen2KBPS2reJNrovCoDc6Yc
 WlG8qtZupGXP1PY7qmo38NoPFNwpLeIh/A1+LQlCCxuWXxNHUoE12cSta2EvigwoBrwJ
 0gTg==
X-Gm-Message-State: AOJu0YyJtNVJydLosu1dbVW6ZXXznPIIPGT49GqlGvV5wm4h0CV+JHaQ
 2eRni/+65zl4DbZS5aD0V/9KXlhWBT214wkDQgCIghvUkBuEcKKmLyHr4XKYeo/AksSSnG15cBc
 U9tDWb9eQaVc3hIs1DMs2DhQEQZladiGqUlthhHA9uzzr265gCGsKlwRScuzOOEr3j09Psd935s
 Sl+QEXq/UiTDLqBwq65wawi/8H7gfZJl8P
X-Received: by 2002:a50:d594:0:b0:565:b4ca:72f3 with SMTP id
 v20-20020a50d594000000b00565b4ca72f3mr3862904edi.35.1710282476023; 
 Tue, 12 Mar 2024 15:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf9Hz0rZaiQCY9cfMLdqVUs/oKzdSOXs1K3kKi7oFgeYUQa01wvwwDvM0E3MT5+nTFW8PvKA==
X-Received: by 2002:a50:d594:0:b0:565:b4ca:72f3 with SMTP id
 v20-20020a50d594000000b00565b4ca72f3mr3862885edi.35.1710282475466; 
 Tue, 12 Mar 2024 15:27:55 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 o23-20020aa7c7d7000000b005686b5c3c1asm1463352eds.22.2024.03.12.15.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:55 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 45/68] pcie_sriov: Do not reset NumVFs after disabling VFs
Message-ID: <63eb76dda237843582f3616f4403ae795e471e17.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The spec does not NumVFs is reset after disabling VFs except when
resetting the PF. Clearing it is guest visible and out of spec, even
though Linux doesn't rely on this value being preserved, so we never
noticed.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240228-reuse-v8-4-282660281e60@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 51b66d1bb3..e9b23221d7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -215,7 +215,6 @@ static void unregister_vfs(PCIDevice *dev)
     g_free(dev->exp.sriov_pf.vf);
     dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
-    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -260,6 +259,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
     unregister_vfs(dev);
 
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+
     /*
      * Default is to use 4K pages, software can modify it
      * to any of the supported bits
-- 
MST


