Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DA606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ac6dAwGl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNYJX-0004am-En; Sun, 01 Nov 2026 11:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJU-0004YV-0h
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJS-0008N8-5h
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a78ec32fadso4121115e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793550101; x=1794154901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2hhR2YuIT0xv5LOPPT7Hlt+EDaoi3+8UIv1NmjBiJaE=;
 b=Ac6dAwGl2T8cJ//aeHRsawRTqqPdWpFrtuC25l0UPJqJYi4zF7M6WgUQlO/RxIqrFm
 NCLYfysrfjV5116ieu+DOSX++JS3ckn16UdRbyySW/ASQ3SRN9WsVzkMKt7xMyNwsZeS
 BvfItfWNOr8PhDDZT/ZipMTHylZxaRsTNhGuy6UCR6G+QirfBgKj9cggMq2F3QYWaaPR
 3ZPlj/mj7hI2bLMaIa8UR7WoyjzOL4NqiOEjxmRBbunQBruDvWPopaRCuNZNQXcrNngr
 NJfVMC410q1js6RBDrH1VcuDPcSfg8WRX+I9xwAO3UzPxbskrvAQPQwKZs3sHfMZ/LJt
 gmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793550101; x=1794154901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2hhR2YuIT0xv5LOPPT7Hlt+EDaoi3+8UIv1NmjBiJaE=;
 b=IX1I6PGh+3jizkh5q0ZchCJpyGwDMSAtqN7t54TvitEKv8kbbuHLXfJASQCKtKB5z+
 iRjBLYZiM6h7RNAtdC5g6EQGSlvtWhJnLYmIzT1OCCgksAdcsUpZuCs8WZTO+JrJr3LA
 S648G2Ruvw8WzwciskTSRgdGCr9qyfShE6AkVZWA95SYXBrCcddxe2KgjJNQ5q5/XsDt
 Ayfnw5rD0jnzhLdun04sfkv0Biiln8PxiwLSpDbP2ShYnQsL9sYL1dWQcMohTLsChjuu
 kJD3FXP9EaEqi+qDCNeZE7dWPcHkMHQGaN3JWwzT2REaEEQv3MFlgpSyYuK9B72ilrFX
 Ij1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSpXmQ49yFgiAy5DD7WiJYblO9LKSRMWlyZ1/9FFzvY97QWad/iTU8Uxe7YNK8MONBIhixoFAzt/0w@nongnu.org
X-Gm-Message-State: AFq9FYI+zcFz5Q2nAkFxub2pdHf06u3LgOeuQRfX8KBivEasTSGaxhcZ
 3MhZrvBKSTqlnlVuIvyXsdCe8vDJt5HvWL3n89OOM5kTlYDoqz1WVCkw
X-Gm-Gg: AYBFou1nU/5GPKDF59AAljHtWLl2gopXJ2HT0zp0EP/rUSMUxRNSio8nc5VxlSB+XVb
 DsHMarBv13F+ECkuPbxBaTkCqtuunvNphfd+/tXn8StUANFs8/lq+cdCvMHamgko60PpmBpsG0R
 sSpeyZVPmce0nUq5AUWpY/f/Ql5v2ojY4G44M2ke/LwEV2L/KN9b+Nk7qpyrXr+p6wUibN0qCtX
 i+8qwlS2xgZgKrW6s8nGgsEBGriWeQT3ehXq0EIc7xmyIV5cnLEl61/JZwjxegSm8uEu+igDrZY
 tf13utSlH/vht2YXDqvYMIUxT8JGsi0HN7ZsnhsgU+GBbPj7YqVD7e0ZF1oJAe/2khjUt3sHFQG
 DeRNf+YoTyUsBk3PpLQzapB6gDjqBhpodC1hOsQ7O3e6LQ3PuZeYZA05XTLH4kLPTYGpyMqBms9
 ftzEPB9D10UaCkgQu2WAOKc2eDgZvW7mM97iME5kyYI1gPdvD0v5vs1Q0WeMpM6u8/TcIhSl7yp
 hMNUtI/kOpheqyf5cJRpJDyEpKwAaDNe3wr1t6yn98iAafvPSQJIbmMfOUI4IS1lE69699CbfJY
 rp37lK/Eg/8j4hF2DSyN8XXefa/AImcjy703nRR43HnHHHPsVE68TCv45R+CFlXZ
X-Received: by 2002:a05:600c:1798:b0:4a0:1f9e:5f78 with SMTP id
 5b1f17b1804b1-4ac1228a41emr117770255e9.0.1793550100685; 
 Sun, 01 Nov 2026 08:21:40 -0800 (PST)
Received: from AtiePC ([2a0c:5a87:5006:4800:78cf:63bd:d449:f7bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm283897765e9.4.2026.11.01.08.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 08:21:40 -0800 (PST)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 3/3] pcie_sriov: fix null pointer dereference when
 initializing PFs in a system with user and device created VFs
Date: Sun,  1 Nov 2026 17:21:31 +0100
Message-ID: <20261101162132.147838-4-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101162132.147838-1-danielpaziyski@gmail.com>
References: <20261101162132.147838-1-danielpaziyski@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pcie_sriov_pf_init is only used to initialize PFs for device created VFs, and
as such, it is checked that the PF has not been referenced by a user created VF
by means of the sriov-pf parameter.

This check crashes if it is performed for a PF that does not have an ID, and
there are already user created VFs in the system.

Example:

    qemu-system-x86_64 -M q35                                   \
        -device pcie-root-port,id=rp1,chassis=1,slot=1          \
        -device virtio-net-pci,sriov-pf=f,addr=0.1,bus=rp1      \
        -device virtio-net-pci,id=f,addr=0.0,bus=rp1            \
        -device pcie-root-port,id=rp2,chassis=1,slot=2          \
        -device nvme-subsys,id=subsys0                          \
        -device nvme,sriov_max_vfs=1,serial=s,sriov_vq_flexible=2,sriov_vi_flexible=1,bus=rp2,subsys=subsys0

ASAN message:

The signal is caused by a READ memory access.
Hint: address points to the zero page.
    #0 in g_str_hash (/usr/lib/libglib-2.0.so.0+0x49954)
    #1 in g_hash_table_contains (/usr/lib/libglib-2.0.so.0+0x4ad3b)
    #2 in pcie_sriov_pf_init ../hw/pci/pcie_sriov.c:161
    #3 in nvme_init_sriov ../hw/nvme/ctrl.c:9088
    #4 in nvme_init_pci ../hw/nvme/ctrl.c:9218
    #5 in nvme_realize ../hw/nvme/ctrl.c:9696

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/pci/pcie_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 618d2a4a64..7111f2f399 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -158,7 +158,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     BusState *bus = qdev_get_parent_bus(&dev->qdev);
     int32_t devfn = dev->devfn + vf_offset;
 
-    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+    if (pfs && dev->qdev.id && g_hash_table_contains(pfs, dev->qdev.id)) {
         error_setg(errp, "attaching user-created SR-IOV VF unsupported");
         return false;
     }
-- 
2.56.0


