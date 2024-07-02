Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2DCC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOk00-0005Q1-DL; Tue, 02 Jul 2024 16:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzi-00058M-KH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjza-0001hF-SD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6T5wYohIMyfJ7zfD4BymibarRz8jk6tb2fFAczZH0qE=;
 b=KxQiaqjJPuMZvgyPq0jMmbH1Bc+AENFmWPX9vwpCEu1idd38igjmB3aojM0qm3prpmmDBX
 fQRh1j8O7s4u+dpBdJsfof8YJ3WYsSrFnZG18ZFcje/abhC8js7KG1ei1sXwmRYGc2uP8A
 0Klc3tE/WiXytX0NMmTC9Gvpn4alWSc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-e2Sf7kmgNI6xv16s77ztmw-1; Tue, 02 Jul 2024 16:20:45 -0400
X-MC-Unique: e2Sf7kmgNI6xv16s77ztmw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec617a3355so45389551fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951643; x=1720556443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6T5wYohIMyfJ7zfD4BymibarRz8jk6tb2fFAczZH0qE=;
 b=Gi4ISK88Tfh1mrIBAF58P4Bb0tyl2iazr5ryWErzej9KOnJxqybr1lGsPcUaCuUIGg
 7uFUgry/7yuM10ebEze4EbOJSEq0PIGbQbCe2bxHceNhv5CT5dWpPYfr4vABcY1tuHHL
 gIkkmq0lBd0tc2xGNh7D2CqH3GzxCmSuIr/zPdHu01+6OhotijiVCrhBg//tk8Q+bGW2
 /rK4DTUO0x1ZTi0RINlV7l/66BzQ5QdKZdjAIbMyxIOeB0olsA7UDaI8JNtQJ77YZvmq
 X5hBDfwPRIVvIpyLdBoudSJhIQSQ0Vu9n1szhfb+n0q5B3HWRbDU8tlCvnKQeePgEBs2
 xbXg==
X-Gm-Message-State: AOJu0YzYR9Ne6sP9KX+RPw7DhcGVFYJTHq+dFQVFiFW3WZKuLHdVtvzZ
 tL6Hgo3RcLt4sDs3UzcnOCRVjWTn4aAnDSVt2HsmA0daHfFhYtlwTqH5QY9d8MiKjHkYg7eyZoz
 KwB6yXTY9PnC/dKudxOvdNKAJgFLhMXMwbGmA0wtg5fnfr4ZsjQmVflNl7od6RvTGZoL+T/brY5
 EUWFTTPOQMjG+RX+3Vc2LQt7PIBq1tcA==
X-Received: by 2002:a2e:a813:0:b0:2ee:7b7d:66ee with SMTP id
 38308e7fff4ca-2ee7b7d68f1mr7866551fa.41.1719951643173; 
 Tue, 02 Jul 2024 13:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHXzsT9LOQ95Bb3qlIkTnBS4wRNvaMilflNQJjz8KlF7qUd5cBdpwMwaj5m9ielLSomtTUw==
X-Received: by 2002:a2e:a813:0:b0:2ee:7b7d:66ee with SMTP id
 38308e7fff4ca-2ee7b7d68f1mr7866321fa.41.1719951642600; 
 Tue, 02 Jul 2024 13:20:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257cdf4982sm131856715e9.47.2024.07.02.13.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 82/88] pcie_sriov: Do not manually unrealize
Message-ID: <f211696efcee92bfd69490b02011fcc79634caea.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-4-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d7..499becd527 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }
-- 
MST


