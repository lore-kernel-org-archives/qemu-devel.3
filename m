Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB78606D83A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9Xr7Z8R;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FT+i9P29
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2o-0004lZ-Mw; Tue, 03 Nov 2026 06:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2m-0004bI-73
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2j-0000N8-Ac
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKqxlI/UASRAYwg9QvB0xV8ul06yjEI6yc9Z7vxiWlw=;
 b=I9Xr7Z8RHvUoxG06Xkw8j9x6Z4c5wIJrFxc7F858MHaUSaxI2Hroc16abYujZWK4nWuYws
 XxEapExqvDDDngDRNJzhFDLRn/Nw/4C3Mrd/0FOL7aAHN+aACjVktKhrphGKcLLpNLqsRg
 GcnK5q8cAmPxuBqKL/ET55G+QihluFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-taNxD8_eOXWJyHTpTgkBlA-1; Tue, 03 Nov 2026 06:51:07 -0500
X-MC-Unique: taNxD8_eOXWJyHTpTgkBlA-1
X-Mimecast-MFC-AGG-ID: taNxD8_eOXWJyHTpTgkBlA_1793706666
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so3465242f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706666; x=1794311466; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VKqxlI/UASRAYwg9QvB0xV8ul06yjEI6yc9Z7vxiWlw=;
 b=FT+i9P29/otoAKQwxpJJwXiPLNa2eoPzTiJZKt84lzULq1xxZeIofTwnwlqLPEMlN4
 LhhShO101w8Xrqam15xXLL502lJ/vAynm9v/YKfLoyNJUBPzbjtm2R68j+9GQcckqWHM
 rSdM4nu7g3OyduYbOYC7t192106/vf34K/rYdaVXQXdSS6KD6ojlOIj/uhJT5Pc/aL39
 esIAg2BijPpQkFYY6Hv0BJsz/vdGKDcGUMJf9I3Zl/uy6sYF+oYoUmc2a4jyW4rxj7gh
 Fk8iMgms/5jxD46RRhUbsAfPbnw71nKDct+UXnU6ubMuhlURb1t/dbbQeVjCY824Z1bG
 LU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706666; x=1794311466;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VKqxlI/UASRAYwg9QvB0xV8ul06yjEI6yc9Z7vxiWlw=;
 b=2GwzcO5b5vLTO5a6vC6+W48zd7V8qZkNwqAi582FKZMLrfHIDYL2AzrgU7vzoY1BMc
 ol3CVov5jWA9VJae2HwBtZC3Ac6eDFCcayRBvL7vYPCz04YziZWGX7dOCKFHjohm6py1
 3JmCpNa0YO7gWmq21DREX2YeHhNUmWXa89HAdomDaCiAB8SgGY0J7jXC+ziVxqGeemRd
 YvOyTKvFlM/vYdLMc0wFg14eQ06CmsVYnnQhtTaLRkbBfka2tdTZb8TOUPoiHvWHpw+G
 h3x425TbqfndvSHasskknB8AoaE8tqyMqyVOwLsNOCyRQ1hVGfyDx7PRJUEG7f9rQq9i
 vReA==
X-Gm-Message-State: APuU4Z8QSSg60EN7excjXanfPWXh4Selg/MHvrPxNnDjzqp+NY1EaURH
 HqyexG0p3Utkdyuo1iQljcup3lFJbiZGAPue6bVGUosgewEM/++piPSLSJL37XMhyNYILx51ePW
 SsfvsYcFo4HSOynLu2vS6G+p10B7xHsmorit5SXQLKg+BH402EKmHrtBGOtyPcpZ8lRn8oDHJxH
 rqo73C4UFuDnlm5H/ctVBdnIMFGkGN01IcIQ==
X-Gm-Gg: AYBFou1AS3m8QtnzB7vhpUworqLX41mUnu1jgkeThyHtUPuWio8L2pM9eYKfgwIRJqf
 v8kxJk2uoJY9gtn8R7AndVvPU5sIkWqpAxoqpRhu536Y8f8Uq17DSgS63FHp+lTbcXGBJT4hjtw
 usnxiaH0AiqrSCb3kK78BcWiJxgrozRprO/X6Mk/R4VF7WMbaIy3o4g7v6r+Yb1Ynn7AxosSM/R
 M48N7FNjraIYZ/x8tPQanDO3SKIHTKKi0L6qZqFzZlc2S/fObO4XSrGehZ7tZ3cbdd91M0YGUz5
 nFelxz3vRMFLLWsd0T9i4WOY0LqnKGN3l7uzQ0x3whq8uWlEJBQwOlSWKSBFJT2FyGP/445TLLC
 jnaVeSy8f/NNlJ8TOFGTXyanM66hoo4C2QS6eu8Gtvg==
X-Received: by 2002:a5d:59c4:0:b0:48e:3085:425f with SMTP id
 ffacd0b85a97d-48e6e2dbbdamr30505940f8f.2.1793706666161; 
 Tue, 03 Nov 2026 03:51:06 -0800 (PST)
X-Received: by 2002:a5d:59c4:0:b0:48e:3085:425f with SMTP id
 ffacd0b85a97d-48e6e2dbbdamr30505879f8f.2.1793706665604; 
 Tue, 03 Nov 2026 03:51:05 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm25011883f8f.2.2026.11.03.03.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:51:05 -0800 (PST)
Date: Tue, 3 Nov 2026 06:51:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 13/17] tests/qtest/ahci: unmap pci bar before reusing device
Message-ID: <0ca8f676d5f334e3c1d2c4b93dd7c8ad695320c5.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicholas Piggin <npiggin@gmail.com>

ahci-test double-maps the hba bar in the pending_callback test.
Unmap it first, to keep iomaps balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-7-uverma@linux.ibm.com>
---
 tests/qtest/libqos/ahci.h |  2 ++
 tests/qtest/ahci-test.c   |  6 ++++++
 tests/qtest/libqos/ahci.c | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 6d861c79ee..f098c91b47 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -580,7 +580,9 @@ void ahci_clean_mem(AHCIQState *ahci);
 QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
+void ahci_pci_disable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
+void stop_ahci_device(AHCIQState *ahci);
 void ahci_hba_enable(AHCIQState *ahci);
 
 /* Port Management */
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index c49aa61862..043a916fdd 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -85,6 +85,8 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
     uint64_t hba_base;
     AHCICommandHeader cmd;
 
+    g_assert_cmphex(ahci->hba_bar.addr, ==, hba_old);
+
     ahci_fingerprint = qpci_config_readl(ahci->dev, PCI_VENDOR_ID);
     g_assert_cmphex(ahci_fingerprint, ==, ahci->fingerprint);
 
@@ -198,6 +200,7 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
+    ahci_pci_disable(ahci);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -1457,7 +1460,9 @@ static void test_reset(void)
                                CMD_READ_DMA_EXT,
                                CMD_WRITE_DMA_EXT);
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
+        stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
+        start_ahci_device(ahci);
     }
 
     ahci_shutdown(ahci);
@@ -1523,6 +1528,7 @@ static void test_reset_pending_callback(void)
     sleep(1);
 
     /* Start again. */
+    stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
     ahci_pci_enable(ahci);
     ahci_hba_enable(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 50b63239c2..a709558aac 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -206,6 +206,11 @@ void ahci_pci_enable(AHCIQState *ahci)
 
 }
 
+void ahci_pci_disable(AHCIQState *ahci)
+{
+    stop_ahci_device(ahci);
+}
+
 /**
  * Map BAR5/ABAR, and engage the PCI device.
  */
@@ -218,6 +223,12 @@ void start_ahci_device(AHCIQState *ahci)
     qpci_device_enable(ahci->dev);
 }
 
+void stop_ahci_device(AHCIQState *ahci)
+{
+    /* Unmap AHCI's ABAR */
+    qpci_iounmap(ahci->dev, ahci->hba_bar);
+}
+
 /**
  * Test and initialize the AHCI's HBA memory areas.
  * Initialize and start any ports with devices attached.
-- 
MST


