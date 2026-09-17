Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBA3C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GXO-0000iU-I7; Thu, 17 Sep 2026 14:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x7GXL-0000hb-5l
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:08:43 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x7GXI-0006ov-8t
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:08:42 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f0b20so202817166b.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1789668518; x=1790273318;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgdmc4UWsdpXnkq35gq53gJIr0ZUtFn6l4nxbiDR6zk=;
 b=VRLVRK1Vt4YiDtywtovoaLA7o4YwwL6chjwe+0uzJqOssHq1U2uLKSQLGD1VlfQf0q
 AXvno1ND+oONflI7Rnfo+Zx6xJIvLRCJyT0wmjUZKq7m6heoK+l7G7DFo5KJt1GwOVpP
 +WQtuhI2uu1IZBuFB07eIMD3AHB7JZ5V07R0zl7V3rT2MEUXNFAVbzQQ2MCRVubmxd99
 hJJBtQB4EA5dDI2OGqth0feceEb7/ohaF/7amkrrha6N0zvFmEAkkHCm0jkV9JQSgJlC
 Wn7THugq0Ev1JbGwFTiHjEh/kJLwhgwmpbgNUgIYTEMPfrOHDD9HJNPby0jvEPrPCwVA
 osjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789668518; x=1790273318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgdmc4UWsdpXnkq35gq53gJIr0ZUtFn6l4nxbiDR6zk=;
 b=L6TpHjDcHHshb94zqDv4ekIYF33wWwchWgjj7EjW6wRFTrRpxGIqEFCSGjhclVsXl8
 6DokanT1o22CSlmB35BQ/zE5oGta/F1kM9LCLioH79Iu2Fsaj286vOo1WR/uUW1dGBSC
 RJaqYE4EW6py6wT8FV596DBrBrmRdA2lrQjvO0Yo+wpYlPx+2+uOpGs8/TRp9s/KcYlU
 aI9BwgS06Uws/NycTX/KIxNq2x81Z7WgPbbqnLLHH5x5goGLgi9xwcppE6WB/pLH48kI
 4GUhiqK9YahR2Bw7QalnW7it32emUaGbpBNow1Rw0/9QPS+EBOCzlm5nO+aziMd/Cxwm
 daXw==
X-Gm-Message-State: AFuF++nqJrPyFbr79exDPf7sXVhpsoH2PeaDVh/FtxHvepQj70wP+4uM
 7vgLO1wlM+SgLeDnRUr6OUrTm0OXkMrJEDbXxPNxMqwVXwczs+QmnHo09xElZot1w4OIlwnh61e
 TrjXD
X-Gm-Gg: AYBFou3l5c7mIAB3ih3n5M4JAatn8+MaGGzMLAKPsmAt2WlEgacS84SX5O+ePcTXJ87
 a9iDdjL1s/alx9M3aQiFE/S86AJ8cGAN/ozIBh78pyCdt0557DsBA2hIKNfoGJF6bQWrI7yKG1L
 yu5acMyqtbDfxhALO1IwZLoOVB1w2BAWtgCJ5tI0FQJyGXjbHWXNqaaPNlbhyCoRErkXZ5rBr7J
 mFTEk9siMmiHMM3sl91rdtYjE6CLGrPPhDh3JrYaIzsOsWOFlmqEq12P3o2Te/EUVlM2u23wnxK
 +duziEFGQV+iE0mZTOxCrbhAymslHyJxZsdM0Mz2Z8Cs50FwQ7DUjA3UpZx9AQOKg+iCryjbEBi
 EHsFo636pGFanZif3kbYeh83rWBiJnsTjtzj5ie8S04cTm0Hgf2ICjOS1Z3awRbWEPIhnQQU11j
 uVjYuR3OZe/FbeBgq7byB+Wwvf9njGZb4iawNHPzI5ZWKk8XuBm6iks+KLwH4b3GnHSt2ZtRAsP
 3PoL1kAj+u525pnKxvJm9SCyi/MKYBwfmRddxtdNhzz/WsEkVDmBQBKDVocRNQi
X-Received: by 2002:a17:907:d24:b0:c29:f5d8:9c6c with SMTP id
 a640c23a62f3a-c2a15803360mr525466b.27.1789668518015; 
 Thu, 17 Sep 2026 11:08:38 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de5a5337sm334676466b.34.2026.09.17.11.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:08:37 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>,
	kraxel@redhat.com
Subject: [PATCH 0/2] Request for QEMU PCI device IDs for Cnuas.io
Date: Thu, 17 Sep 2026 18:08:27 +0000
Message-ID: <20260917180831.3142920-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:34::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ej2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Requesting two (2) PCI device IDs under QEMU vendor ID 0x1b36 for the following non-virtio QEMU device models of the Cnuas project:

1. CnuasNIC: a software-emulated RDMA NIC supporting RoCEv2 and native InfiniBand, with guest Linux network and RDMA drivers and a standard verbs provider.
device name: cnuas-vnic
device ID: 0x0015
Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/

2. CnuasGPU: an experimental AI/ML compute accelerator with a guest Linux driver and user-space runtime.
device name: cnuasgpu
device ID: 0x0016
Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/

Each model needs a distinct device ID for guest enumeration and driver binding. The allocation is requested in preparation for public release and upstream submission.

Cnuas is an experimental rack-scale AI/HPC emulation platform for functional experimentation in academic and industrial research and development. Its architecture and device interfaces are described in the public arXiv preprint paper:

Cnuas: A Software-Defined AI/HPC Rack-scale Emulation Platform and Hyperscale Data Center Facility Twin
https://doi.org/10.48550/arXiv.2609.15889

Website: https://cnuas.io

Weqaar Janjua (2):
  pci: Add device ID for CnuasNIC RDMA network adapter
  pci: Add device ID for CnuasGPU AI/ML compute accelerator

 docs/specs/pci-ids.rst | 4 ++++
 include/hw/pci/pci.h   | 2 ++
 2 files changed, 6 insertions(+)


base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
-- 
2.43.0


