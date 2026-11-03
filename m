Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736C606A331
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bmfzcp4s;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZFC465lB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2s-0004zh-Ja; Tue, 03 Nov 2026 06:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2p-0004sw-Gp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2n-0000Nx-S3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99ub510hspfjTNbRaNnKOoklgZRp2udwZpVPiomHk3Q=;
 b=bmfzcp4sQjqw+2Mt26waxHN6MTb+40o5p3uhtBVBfJ7keOMeiYaXsBp+cn/DV16mII3G58
 jeLwxyUfG7gfN7E3GrQa2U93Dl39+wFCGxp4Uy+qOmCgOBGAORrtHPCWiJfCOThRrx2nc2
 kSCL0LOR4A1rf7GzxK3n4qk7KQ9FW5c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-dLeiZGywMTqERpDYHVg_cw-1; Tue, 03 Nov 2026 06:51:11 -0500
X-MC-Unique: dLeiZGywMTqERpDYHVg_cw-1
X-Mimecast-MFC-AGG-ID: dLeiZGywMTqERpDYHVg_cw_1793706671
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48df5b058ddso2686277f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706670; x=1794311470; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=99ub510hspfjTNbRaNnKOoklgZRp2udwZpVPiomHk3Q=;
 b=ZFC465lB7O8ra04ScduDcDRo9YuGGVViK3B+i7EOkSo7Y6JOMYDgrs4V6Tiw8k6t5E
 5YxL7r4IF6UPgDIn7AAhKg+4ZVizMz5/TlOko9dRBJbVTy40J/DiPo1E9Oq9PYQlOqX8
 sNbdayPAOIu/YXWNWCgiyFvehHTYjLKM0lbuxdxBe2YmVoYEsutv2XP2V3UC5ZmN7/EX
 KfFPsxsJkQrv4mCnW1DDHLpNL/M8uzX9NMQNi77ApvyXV9bCj8L2rKUqhwTjel8Ozp/O
 SUGtaEadqiv8xEamZ1Dgg5WV821TnwTj7i/SD6m/WF0cFtKfUShXitxjUeV7hGq71cPu
 4Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706670; x=1794311470;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=99ub510hspfjTNbRaNnKOoklgZRp2udwZpVPiomHk3Q=;
 b=otPnhJBflR+CuwLD6kNCa/wAPYYnB8/Omgi1EW2kkElUeYhW88R3u/C/2wuJ0mZAB/
 aGLRuSq4bQ/v7s50NB6AKF7wLoA5o8fbuDwl7smQEV7am3mgFOsaAiU5Ir/FGSXO4Lja
 2R2Xu1gpdhjBsebrnbh8vjCyr0zDGCPVyfxEttkE6jEYpxpKn/2iwD5XB57SzFfsdRV8
 OW7Y9ZQsrXEG5d+11gsWujFKjENRg/llOuIxG++S635orh657bjjYLR4cU9KTXAF1FId
 NTu3c6O4fehopcEL9o1iURqMq0Y6Fj7CPdoZosRhQiY2PWCb8JM5bFFfJXFlvReL7s2t
 aWhQ==
X-Gm-Message-State: APuU4Z8UrCKIYjly8xlAewDrOA+h400gqYsFML3uSF+kRhojYarJbNNk
 GqqiD9ABwIzPnjHdX5d4Bz+krINc2LFH1uoKJnAmzTqsBVdLKY124ZCZJoJ2sQ0tr/xgXRXzRFK
 phH8jRYb9CNjDbPWSTn33A3726hvroftYzEkN56ImifPaxF34AYVwoaPHqf1aQuNqdQTYrxxUEa
 9GcW0D810Hk4bM7BJOgq1bAp+udCfv+tlyaA==
X-Gm-Gg: AYBFou0gbBhvJ784ghqd8YbJORGa/n0oOknNJBkh7DswRDyk61xVAJ7WF4ywaW69LPR
 3YDnPdemK2Zg9OFey7aa2tYe3cGJbHKEl4DPwEgXbaMt0fX+zqWkEMytU0eyFZGfBc12VFy3nK6
 QvFRQPj9AIBIyBmyQBPPXUkQkI3SqpJR5wUzoEM/V1WoM+8UYFJLlXqu58ohNeXoXf5l+aeiCUE
 n/mo+de7Ito/iMGhYxpZ1rGXYvShNaZOwk5F4ZnTK5T28L3RA38w1FeIs1Yy9y9dN92PoWts4jM
 BwzdD5KxVKBE/8CBjy1RokY3r0KgdbjAzjyIUcxco47UBfvV3XHthuoBMSgv+Yeas4rq1FOnUpF
 mWFqslMVlYuDSIqSNa54OKRF8xKZfIS0TmpBKDDSXnA==
X-Received: by 2002:a05:6000:46c5:b0:48e:5db7:fd6c with SMTP id
 ffacd0b85a97d-48e6e2bde59mr17109050f8f.4.1793706670350; 
 Tue, 03 Nov 2026 03:51:10 -0800 (PST)
X-Received: by 2002:a05:6000:46c5:b0:48e:5db7:fd6c with SMTP id
 ffacd0b85a97d-48e6e2bde59mr17109018f8f.4.1793706669743; 
 Tue, 03 Nov 2026 03:51:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm25280492f8f.35.2026.11.03.03.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:51:08 -0800 (PST)
Date: Tue, 3 Nov 2026 06:51:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 14/17] tests/qtest/libquos/pci: Add migration fixup helper for
 pci devices
Message-ID: <4de39eb9370b7518c3c8e6668e73b88e5c7efb20.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Migration tests can create new QPCI devices for the destination
machine which may need to take on some state of the source machine
after destination is complete.

Add a migration fixup helper and call it from ahci and nvme migration
tests.
This is currently a noop and will be used subsequently.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-8-uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.h | 1 +
 tests/qtest/ahci-test.c  | 1 +
 tests/qtest/libqos/pci.c | 4 ++++
 tests/qtest/nvme-test.c  | 4 +---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index c3a0f85fef..cfb7c17dd3 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -120,6 +120,7 @@ void qpci_memwrite(QPCIDevice *bus, QPCIBar token, uint64_t off,
                    const void *buf, size_t len);
 QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_t slot);
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 043a916fdd..291f29e762 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -137,6 +137,7 @@ static void ahci_migrate(AHCIQState *from, AHCIQState *to, const char *uri)
     memcpy(to, from, sizeof(AHCIQState));
     to->parent = tmp;
     to->dev = dev;
+    qpci_migrate_fixup(to->dev, from->dev);
 
     tmp = from->parent;
     dev = from->dev;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index e9233c81e9..e78dd4d4c7 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -625,6 +625,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     return bar;
 }
 
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
+{
+}
+
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
 {
     g_assert(addr);
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 09972b50ff..dfa59cfbce 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -517,8 +517,6 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
     test_migrate_setup_nvme_ctrl(ctrl);
     test_migrate_send_nvme_reqs(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
 
-    qpci_iounmap(ctrl->pdev, ctrl->bar);
-
     dest_cmdline = g_string_new(qos_get_current_command_line());
     g_string_append_printf(dest_cmdline, " -incoming %s", uri);
 
@@ -528,8 +526,8 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
     /* Get access to PCI device from destination VM */
     nvme = qos_allocate_objects(to, &ctrl->alloc);
     pdev = &nvme->dev;
+    qpci_migrate_fixup(pdev, ctrl->pdev);
     ctrl->pdev = pdev;
-    ctrl->bar = qpci_iomap(ctrl->pdev, 0, NULL);
     g_assert(pdev->bus->qts == to);
 
     /* Migrate VM */
-- 
MST


