Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1E606A33F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gNl3Teq9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BW+8ncv8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G6-00006V-IX; Wed, 28 Oct 2026 13:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fp-0007Rg-Ba
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fn-0003q6-Od
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xNagQyg1nA7TnvLj7POcIy1chbvzFmGoyOSQkgXe4g0=;
 b=gNl3Teq9Gi5rTGLkuPpjxT4LhVHrM8DsCatSryjOhDh6VhTBi4l0feoGD/d4cQaU5nvg5U
 9SAHQXcVnLIJQ+bEvAeMxJ3ZjJIp8TdtdGftxlaYgDf2cqBQwDQngZAu+rJ2AXx7J9jK4+
 REKQ7JCadK6v4dTSnfHk2Qkaa4NiNVQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-tKcjs0y1PBKeWGjZeAMXCw-1; Wed, 28 Oct 2026 13:15:58 -0400
X-MC-Unique: tKcjs0y1PBKeWGjZeAMXCw-1
X-Mimecast-MFC-AGG-ID: tKcjs0y1PBKeWGjZeAMXCw_1793207757
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso9019165e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207757; x=1793812557; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xNagQyg1nA7TnvLj7POcIy1chbvzFmGoyOSQkgXe4g0=;
 b=BW+8ncv8PsenWEdw7LDHSanpElUQMp+veiwbb3MnmQ8qsoGORvpFHNusdMAMDdklTY
 OlsE/a0LeAb64wlWCgFO58o3WGI7vWz5xpBzDMjWM9ARRwk7QmuOtlsAGxOB5HAe8iH/
 7pPp8s96TbasEkeQvgUxb96XM2sfA5k+UOeWjt/mIx9r7Rexe/Mg6Ua+/9laY5VOL/sx
 lE/uiM8AIl1fc/aR2HhJcl8QhFFqhG7pVSei/bZOpHf8dDvJbcz2IZ2KXzep66C7e0oo
 XPNaEAU5ntatvS9SAX/tmEImy+pxDRpwmVIASldHPsf7vBhKh7Rg1hPSRGd6/vvoyfca
 w0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207757; x=1793812557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xNagQyg1nA7TnvLj7POcIy1chbvzFmGoyOSQkgXe4g0=;
 b=E5InfYCSaegBsM/HzlqqP98pGAjyq1CT5RwXJplZqoEeteDDO3qSMj8go5aEUeHVB8
 O5tKd5CKoMAYF8gNZc3rTT3FwotwN89k2ohuOeZJ46dpHcFVc3B/Zy+1lfMWxgU6Rkx1
 df0n0GuKZ4zdggXMH2suYsiHS2hyrO8WHoV/MRA7EwAzM1P7e+jCA8pcrjR6ASfAbS31
 s7SjQdG9wecLjoSo8dBJHMlT3HtK1VoALOy9l/EEucegOCpKgGx2dD4j66hZUrTQ6TC1
 dShhdzNwXQFl3EBxtcyJDNEm3onyRdAI0JWlNI4NDh+207da9odOG/Bl7bdioe7RBr03
 xuTg==
X-Gm-Message-State: AFq9FYJJxWTlik5jfFN6XGq+n9Imumu2WHNqfgHJTWAo74jPT9K8M0Pz
 MbZTESgBje/O0mmHwlp/EkPkA+CvVgGEFXt9+OP7k8Mo7mP0v/Lzua8S+/FXqVsFeYALj6PnNy4
 8MaXdVkSK4cy/A1QbWCmqkSjHfP+UCg6+vvu7tniTZcM4aiwR+xHlZHIBxa6ifzUVa+9aVkTFhV
 dzCNf/D2RtFtkuK3bT0igMYgHP1dlMFwdMDA==
X-Gm-Gg: AYBFou1nw55bI0pl9XGmWNbuA6Ol0J+huzf1LcDOn3g/KsOZLyZ2fvrj/jjj0UYLL+W
 FZfrMIctIYDFVmBYFCqVdNoHgsZhFJPqsQKb8POr/k2RnJWPr5z81MC94a9he/Bp2u1T8ufB55d
 hrR+vtDXkz1t044axRy2EdSqquQ2sKrKgbpcgmvr0FxsrjXIyAONOjmuBY66rdgjliACZzY9z7N
 TtH9Zg86SqtjxMwPPzHch4aiVv8QJOOVFDw4P7frwzhFj+H9Ma681Qw0Bp9wgnAe+lWGDutpHVx
 X0nkwT8a0fg1lfkmXMDhABIgvWWI6GpSrRVfe9W1XQNr/l0PEwJKYAvflnouYXNzIexS1EmBTz3
 5zL/R9COaJtCntjXAA/LlIkBr478gMhXht0Aoi3H4
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4a9675dc5cfmr62028625e9.28.1793207756400; 
 Wed, 28 Oct 2026 10:15:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4a9675dc5cfmr62027785e9.28.1793207755768; 
 Wed, 28 Oct 2026 10:15:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm30520974f8f.10.2026.10.28.10.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:55 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Vrabel <david.vrabel@nutanix.com>
Subject: [PULL 44/78] hw/pci: Ensure PCIe link speed/width is consistent
 between both ends
Message-ID: <2e5892e8cccc009de0e8e5cef3260f4497a9cf36.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Vrabel <david.vrabel@nutanix.com>

If an emulated PCIe endpoint has higher link speed or width
capabilities than the upstream port it is connected to, ensure that
the link status on both ends is consistent by using the link status
computed for the upstream port.

If the PCIe endpoint is a passthrough device, the link status
continues to match the real status and consistent values requires the
emulated upstream port to be at least as capable as the endpoint.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928152431.310363-5-david.vrabel@nutanix.com>
---
 hw/pci/pcie.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 42bcb9206d..bd00305ecc 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -169,18 +169,36 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                PCIExpLinkSpeed speed, bool flitmode)
 {
     uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+    PCIDevice *upstream;
 
     /*
-     * For an end point or USP need to set the current status as well
-     * as the capabilities.
+     * For an endpoint or USP, set Link Status as well as capabilities.
+     * Provisionally use this device's width/speed, then adopt the upstream
+     * port's values so both ends of an emulated link agree.  The upstream
+     * LNKSTA is already clamped to the negotiated link capabilities via
+     * pcie_sync_bridge_lnk().
      */
-    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
-    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+    pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));
 
     pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
+
+    upstream = pci_bridge_get_device(pci_get_bus(dev));
+    if (upstream && pci_is_express_downstream_port(upstream)) {
+        uint8_t *up_exp = upstream->config + upstream->exp.exp_cap;
+        uint16_t lnksta;
+
+        pcie_sync_bridge_lnk(upstream);
+        lnksta = pci_get_word(up_exp + PCI_EXP_LNKSTA);
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                     PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                   lnksta & (PCI_EXP_LNKSTA_CLS |
+                                             PCI_EXP_LNKSTA_NLW));
+    }
 }
 
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
-- 
MST


