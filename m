Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331C606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V01d16S/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A/7cb8FB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2R-0003ix-4n; Tue, 03 Nov 2026 06:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2K-0003eO-Ti
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2I-0000KV-KH
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TktMWa3JuBokAU/8i9lgcgCAS9ZCodBfbqHTmz9KQWs=;
 b=V01d16S/TbFSZ74pwjO/Hk5PiVpmgLIdEim9s/kdT1GQslSvsmZtMHGZHlneEOVoZ6wA9f
 iKk3iazpKlfaGXGhBUaz3ETL9F8SUhngW4EA0WyjBEyd+xZe2HZA42sYvseMcCLfJjuSdS
 3fW/dJSmMPctyIRIurtH8qW2RYShFlk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ene5ltVfNza94IDXVLBa0Q-1; Tue, 03 Nov 2026 06:50:40 -0500
X-MC-Unique: ene5ltVfNza94IDXVLBa0Q-1
X-Mimecast-MFC-AGG-ID: ene5ltVfNza94IDXVLBa0Q_1793706639
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so2756203f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706639; x=1794311439; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TktMWa3JuBokAU/8i9lgcgCAS9ZCodBfbqHTmz9KQWs=;
 b=A/7cb8FBZhhhTuL6V6LZHrwGmXVTMsdaEvYzHSmZV26CZ7fxt9zXt+Hb6HmKBBaBiw
 +uNLcaCXkOC4Dl9MCMULg+EZ9pC4O+81QyfBRye5yikatNEZnP9hG2Cn6t7tgBGN1/Ai
 MZf3o7dNISVwVoo++UuCYK0AZF1KpirU23HjT7kJI7FZnWCpRj0h3mXN6c2K4e5mqKRb
 xJq0zUWM+NR0/DIhROpzEPzU/ebhQdWSr/zH+aLadVa1OwQWvVcWB4L6ih12Ka49+YWw
 5r89qBJw9RpaeK4C+hTA6G8Af0jOMg51HyHhNsyRRlBbl/rDgbCvthKeTPdcUz8+DG9n
 kDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706639; x=1794311439;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TktMWa3JuBokAU/8i9lgcgCAS9ZCodBfbqHTmz9KQWs=;
 b=f4V1K7wi1R+8Kpeh2Z2+HK0AzY7qu/QNOJzvBGA7gl7FWzw0ifwAdWihldNg0FFk9g
 LfqFQDTsqhf5JsXPlszg5Pp1Z4XeAnUfmZiHrH6ueKo0c/b9MzuzND7oaHhKujoVuDup
 /4Mz+CgoYewvTE0yuBTM1TY2iBg3bW0MgbTSicr7hrgELmgF1VxCogc/U/yEJjlp4DCZ
 mqTU2+SCbjvhXKadByP4Ktz5XxYyHHSAlL0sDQyM9GFjLBSkgAFm8w6gnt6zy3hl4AfX
 B4QmNLi/FbYnDQ12i1OPXKDThNQv7OHU26dMVlYKJdEo5XUI7R3uh+8RR7RR5WqDn2EF
 kDtg==
X-Gm-Message-State: APuU4Z+pFj/4JWCzYj8a2QhOm0+WUUV1Rw4b2428F1XAngas9w9NTmJU
 VddhuUso1tEMCnAU9IDM8mfqI9WMyuR7hadMxEvwPj5ZFXzpob248R5RAnwzk+EkNeHaA8v9U6K
 iotxZDpUG60B7YUSfqiYxcux3PLHrw3lnyA2GUMmF4ToJjZJnspQe9m9f3nlJ+Qf9hvDnljZDO2
 I/0i07CIiaSRt8awmtVNIoXi4g+fMVYUaK2A==
X-Gm-Gg: AYBFou31YcsUQDOQwiC+mEYDtg2dZ65vDNBVX0lyjuNiiF0AxVUPT+3Ezf09ejfv0/6
 0DyN0/y7+VePfql9VRQrFLrVmyvuj/eLjNzJZJmkTh7hFXDX35E8q0LBF3zn2hrEoVxQTzBSEPZ
 CSt69pPbHBOmYk7sD/0QbnPM1teg8TusAE8+Jibk1Unw7IEmEozU//+CmWOPdRSJKKWJSZ5EJdz
 o8o+uvmaPS27EonsHxH9AEukJWs2Q2oqFW7CXEHjn3pyZziLAwjtkV2jfOYfBF4NocdanynoNcs
 j8I3F0yqMr5FoNHMFBeDxjmBp1Zhw0rHvdEzBZIHmiJtB2EmD4KqqYaslpS+aHxfjeuseDYW9Yz
 vt9ijMrhwzJ5I4tw39GgAP6hs6QRahUXrbT+PhnmEEg==
X-Received: by 2002:a5d:63ce:0:b0:48e:247f:a106 with SMTP id
 ffacd0b85a97d-48e6e4fa97bmr22225353f8f.54.1793706639253; 
 Tue, 03 Nov 2026 03:50:39 -0800 (PST)
X-Received: by 2002:a5d:63ce:0:b0:48e:247f:a106 with SMTP id
 ffacd0b85a97d-48e6e4fa97bmr22225299f8f.54.1793706638569; 
 Tue, 03 Nov 2026 03:50:38 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78c10sm24274145f8f.25.2026.11.03.03.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:37 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org
Subject: [PULL 06/17] pcie_sriov: perform additional checks after pci device
 realization
Message-ID: <36bc5a879e0f0993aaf95e0896cb35426a32249c.1793706601.git.mst@redhat.com>
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

From: Daniel Paziyski <danielpaziyski@gmail.com>

Handle two cases after realization, which were implicitly handled back when PCI
SR-IOV device registration was done after PCI realization before commit
432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")

- If a device is a PF of user created VFs, make sure that it has initialized its
  list of VFs. This check seems to be superfluous, because the only way it can
  fail is:

  - if PCI device realization forgets to initialize the user created virtual
    functions via pcie_sriov_pf_init_from_user_created_vfs, despite having set
    sriov_vf_user_creatable in the device class;

  - if the pcie_sriov_pf_init_from_user_created_vfs function fails, but forgets
    to set errp (which does not happen), and the device specific realization
    code forgets to check and/or propagate if an error has happened.

  However, this check was present, so let's include it again for good measure.

- If a device is a user created VF, make sure that the device is still a
  PCI Express device. This edge case occurs on devices that before realization
  have the PCIe capability set, but then during realization they clear it for
  some reason. This only seems to happen to modern virtio-net-pci devices, which
  have their PCIe capability on, as any other modern virtio device, on object
  instantiation, but is then cleared in its realize function when it is located
  at the root complex or not in a PCIe bus.

Cc: qemu-stable@nongnu.org
Fixes: 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261101162132.147838-3-danielpaziyski@gmail.com>
---
 include/hw/pci/pcie_sriov.h |  2 ++
 hw/pci/pci.c                |  5 +++++
 hw/pci/pcie_sriov.c         | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5f81e3b1bb..41ccba8a71 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
 void pcie_sriov_unregister_device(PCIDevice *dev);
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1ea388be37..e85b34d06d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2347,6 +2347,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e6891436d3..63d19ea488 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -393,6 +393,25 @@ bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
     return true;
 }
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp)
+{
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (dev->sriov_pf) {
+        /* some devices might clear their PCIe capability during realization */
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void pcie_sriov_unregister_device(PCIDevice *dev)
 {
     if (dev->sriov_pf && pfs) {
-- 
MST


