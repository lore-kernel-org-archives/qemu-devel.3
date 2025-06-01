Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF457C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYu-000230-C0; Sun, 01 Jun 2025 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYh-0001rd-LO
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYb-0004Zl-UP
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qFZ2Ib3XpNyI2PboRJ3fi4hOzy8N9yk8xKqfp9YMBCU=;
 b=EawHNDgrmSWsx7q5loOM3EW+fKK+DkFafucS327FaeE4F20I315OLIGLJubcHS5MMf/uVQ
 PQGwZbdxRsi3u5GXU+y/vCxNAv8hzOqv/ppNCu/wWmRmDA9V739dfGncAeZkpP4AI6wP3n
 Ei9iKsn6WcKVOWVZlkECq+VUcN97Arg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-fqrwcUoSO76niR0ZbUsalg-1; Sun, 01 Jun 2025 11:25:03 -0400
X-MC-Unique: fqrwcUoSO76niR0ZbUsalg-1
X-Mimecast-MFC-AGG-ID: fqrwcUoSO76niR0ZbUsalg_1748791502
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so201063f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791501; x=1749396301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFZ2Ib3XpNyI2PboRJ3fi4hOzy8N9yk8xKqfp9YMBCU=;
 b=wOnVF0XwIoOxRi8klush38QoJjiiDkXhWxuKCraroYUzrrRujC7bGi+JP5DInRFUkW
 /FvazhDo1wnXg3hRKYdCK4EPQ3GYj7fF5igvCa7Tvk5ULBEudYlrTiSh6+c627YiwuAP
 nwwrVvbIjcOKfgz8GGyVtT6G5qAJHXUuY9cTFfjCkiZuTKOX0mWZ3eha5kpjle9N/8fA
 FePsj5s7OTbMKAnTnh0eySnxO3G88/KEsO44c5yXAVQm6zLlf+H92zmnqNqPI61hZJl8
 hP4En86YCg73OVChPm7gk9XJYj5W86XT2P1RQEONF3rE08WsFIXJM7sGqCn2yvRPZcET
 jt5g==
X-Gm-Message-State: AOJu0YzIUAOj8pzklwD3Cy7ffu1c6c8WiDrtTesi3Mr/703JOZiIU2Dv
 2UpH5+8onGEMPfEL0mE74Lx0yrZB0i7bAMhe+SO7amIw+W+gz9ffik4rY6EaZTAg5P0Eb+Evt2c
 zLFwF2RIRRNGpCJu7QlxeJKY2NPAO3In3vdSaRlyJa7wW5+Gpa2jsPkD1Cc9cF3yyRkYVu4rmYK
 p4pJHQ3pGslZx+uPT6AOh14S+vEehaDdMSWQ==
X-Gm-Gg: ASbGnct1uxw4QhWgq0FngK/Cl5nnjkrk4D/JneZY2SryltN2pxZk7Nm33uU3IRA8Xml
 raNXge7DcLS1P/+yat3fQUEuqtXJOkTu0qU6Kyz8Xv8mhuKrOwEqyk/bs2KBIZsBOmOzD3LRIyO
 CnHBeAuqMdGqaxRETf65me72dUnpTcsIxqpCUBBTxHRyQQWWAhX/uLFa+qVzCyBSAtcJupoD4qo
 iNvqSBh5u9iasrEyofziYvQvcuBbuL+9KCnzKW/+lRpW3DCFq77iUmnY4+A1wTly9qk27JfTcMf
 60Xgag==
X-Received: by 2002:a05:6000:2283:b0:3a3:652d:1640 with SMTP id
 ffacd0b85a97d-3a4fe160ba5mr4232362f8f.2.1748791501617; 
 Sun, 01 Jun 2025 08:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDki4BypTlxeuAIOwTeTy3VgGmdVvQZPG7DDlD6e8SQR8m84KVHMjTDtCN1Hmdav+/RZCaow==
X-Received: by 2002:a05:6000:2283:b0:3a3:652d:1640 with SMTP id
 ffacd0b85a97d-3a4fe160ba5mr4232343f8f.2.1748791501203; 
 Sun, 01 Jun 2025 08:25:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009f9d6sm11616102f8f.84.2025.06.01.08.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:00 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 06/31] pcie: Helper function to check if ATS is enabled
Message-ID: <6a3ae6a2440dead9dd8e3f84152dc53a5214c48d.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

ats_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-4-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h | 1 +
 hw/pci/pcie.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index dff98ff2c6..497d0bc2d2 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -156,4 +156,5 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
 
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index db9756d861..36de709801 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1248,3 +1248,12 @@ bool pcie_pasid_enabled(const PCIDevice *dev)
     return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL) &
                 PCI_PASID_CTRL_ENABLE) != 0;
 }
+
+bool pcie_ats_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.ats_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.ats_cap + PCI_ATS_CTRL) &
+                PCI_ATS_CTRL_ENABLE) != 0;
+}
-- 
MST


