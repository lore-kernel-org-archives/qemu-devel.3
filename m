Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AF4C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrb0p-0007vu-Sp; Wed, 05 Aug 2026 08:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb03-0007mi-KD
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb00-0006dT-Ml
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490791a3e92so963155e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785933929; x=1786538729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k4EmmzszfD+1kffTictZyQ8sdVf2+Y0ZJ/alY0rtd6c=;
 b=S4OuGRmbpWPvxmixJYdF0KJCivypbN2mpNbDwbitttI3085ILzRdtZFW4pKm1OU2Ra
 9tKZjCwklsJDvqxkoMv3XTSvw6Lpqbqr/8jSSuceZUyaDLHBJKb82V6dWfZOUId+cwKc
 HhCiDWI242vspHcAX6xrnNAxyEHXaM4dBJTG9lhpHiNsHPwxOBpkzYjo/322BJuPaIBp
 FOrfXvwWOrfIl+bP7kZssI8VbNyE8wRjXrO6Av/9mFoCuVCFoZjEHWzntvlcECTfHlmr
 RPM0LJnsMEGU7e0iQ7iWfBGbOcfeh1OrBBLos3SjvsCanf7wNHp3WFyoHfSBqw+54wvu
 10lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785933929; x=1786538729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k4EmmzszfD+1kffTictZyQ8sdVf2+Y0ZJ/alY0rtd6c=;
 b=D0R8t3fhDFIHoPB0mEFBHUdopZ255sAQlBjdKyFK/k4Znq8HB4vfF3hL0JMSTLfDOB
 axqoRK1XStj8Cw/ZHGQ2mDneSl4ZfS2uJ+esM21RjPcXTlLxyWnH1Qu/qSZ7+/ZcpR+s
 XuRcJdz2TZL07AXdtDXRBXOFzD40Izs7kLs7KTlmOMf62j633w45xUG/lsgI/s88frr2
 1qSYuEHAzcOTc9COnSEuJucRpg6/GpAKljjSd6OK4fq25O2/zNwfLsdB0eci7z8LOKx1
 hIoozZcqTNq1r/yXM7llvGg6aHwQI6gGk9D7ma+luzZoXk26+9Qz+QnF7NeheH/yQm13
 kKQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfZFTNM+SX75gFV4zP/KN4bmbSHBiYV6JM9jy3oKKUSST/Xu4bC+dLSDgGO5APMaQKruua/tA3vsrz@nongnu.org
X-Gm-Message-State: AOJu0Yz/vNFeyqL6+JEYrUjBnZ/vo8TFOkCtyhQbiaA0Z7d3lNxDIZBE
 D0p/d8my+gopKfeBLnceNNObc9CHUrfEnOBzfYombOh0YHvyrE1SPYLC
X-Gm-Gg: AR+sD11StSpjqbG0n1FhrSPvusHmp+ZQwKVV1W/BsFX77Oxi/Py3YWheptaTJgvhD94
 qdr9oBvZhrZq1z3is8AFTCmFnm1IQx+en7QOxGuvWKV164HcADnJFUZVwx3v5PlTmSzva1K6l24
 1iFdhQY0fmVV47ZK822hkoGxKXCfOwe3gkxwXJMNfu/sAFtl6D/Ho9DPPqTPxHgRSHqmgpAhZxi
 R3ntv+N209jbPcQ4P0UJl6y+drhfmwwfN8lldLsBI8Mu1Qihz8csi7tfinBx/6gedpuEfD/MQJa
 oEivMJOV7zrm2dKdgoFi2nladxTDpTPFrSfqvH/8ngiFVcyCgODG5zv5FaQwMSPOqysEhyzGQdg
 SFnKUaanhzfYE+1zlcGiHC1K7syMsz5ts0OkVBlQaf25yb+DosIEhc0gAIaW0WsIFtoY8eM6bNn
 64MfW+1yCK4+aQyMKrx/+3eLELJtx0TJFPcF7ildWHtSdDNR+KDUYMPO/50wdDA31Zo7GPOIQ=
X-Received: by 2002:a05:600c:c4a5:b0:499:521e:86c1 with SMTP id
 5b1f17b1804b1-499521e86cemr1123385e9.1.1785933928593; 
 Wed, 05 Aug 2026 05:45:28 -0700 (PDT)
Received: from AtiePC ([79.116.13.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a100e14sm166453775e9.14.2026.08.05.05.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 05:45:28 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/3] hw/nvme: fix assertion failure on sr-iov capable nvme
 controller removal
Date: Wed,  5 Aug 2026 14:45:16 +0200
Message-ID: <20260805124519.30054-2-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805124519.30054-1-danielpaziyski@gmail.com>
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In a nvme subsystem, the ctrls array maps controller IDs to nvme controllers.
The value of the array elements can either be NULL (no controller present for
this ID), SUBSYS_SLOT_RSVD, or any other value, representing a pointer to the
nvme controller structure.

The SUBSYS_SLOT_RSVD value is special: when a nvme controller physical function
is being created and is reserving the controller IDs for its virtual functions,
it indicates that the slot is soon going to be filled by its corresponding
virtual function when it is realized, and on virtual function removal, it means
that its controller has been removed.

When the physical function is being removed, it goes through its list of
secondary controllers (virtual functions), ensures that their slots have the
SUBSYS_SLOT_RSVD values, and then frees up the controller IDs by setting the
NULL value. This traversal occurs before the virtual functions are destroyed,
causing an assertion failure because the slots contain as values the pointers to
the secondary controllers.

Destroy the virtual functions (and therefore, the secondary controllers) after
they are offlined in the nvme_ctrl_reset call of the physical function, but
before releasing the controller IDs of the secondary controllers in
nvme_subsys_unregister_ctrl.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../hw/nvme/subsys.c:49: nvme_subsys_unreserve_cntlids: Assertion `subsys->ctrls[cntlid] == SUBSYS_SLOT_RSVD' failed.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index bd6ad64b20..b726c13a56 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9676,6 +9676,10 @@ static void nvme_exit(PCIDevice *pci_dev)
         }
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        pcie_sriov_pf_exit(pci_dev);
+    }
+
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
     g_free(n->cq);
@@ -9700,10 +9704,6 @@ static void nvme_exit(PCIDevice *pci_dev)
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        pcie_sriov_pf_exit(pci_dev);
-    }
-
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
         msix_uninit_exclusive_bar(pci_dev);
     } else {
-- 
2.55.0


