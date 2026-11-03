Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958486083616
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gz05GrbK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Jl3VY6dc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2B-0003aV-Ju; Tue, 03 Nov 2026 06:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD27-0003ZX-PN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD26-0000JV-60
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYM0E0G75slhjVgSpznVNuQ0X1v2jo6RpWzfk497PSY=;
 b=gz05GrbKLAlp6ODCRTF9LHkXH/kJbKoSm5bfEy1GQllsFbPmezQxO8ZaPsYS7BXD7IhNUd
 KmnFXP1weYwE5dsaEqxVRvWUkNV6MxadjqtCBt4IEjLuHL3EI82ctEMDXE0Oe0JHbUjtOF
 yxm8ISOYI4BKjENlfX077pCsn1YZ5UQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-tdoCChSpP2-HlJuJo9qZRw-1; Tue, 03 Nov 2026 06:50:28 -0500
X-MC-Unique: tdoCChSpP2-HlJuJo9qZRw-1
X-Mimecast-MFC-AGG-ID: tdoCChSpP2-HlJuJo9qZRw_1793706627
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c7fe9736eso3514325f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706627; x=1794311427; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZYM0E0G75slhjVgSpznVNuQ0X1v2jo6RpWzfk497PSY=;
 b=Jl3VY6dcoKEMJHcmXMqCy00Op/+on8vAsuY9UkjmDbjyvghxIWj17M5kE9AVrgXNrq
 uqKBC9UCieRTStfLASZ+ORUxiptec6N2PAwhZOrwaPS3OL0NkgEsyWVj97IXE29YhelD
 tsJD0VCjd3ytnhewhCISmEcOZwe9C3sKVB4m/CNN9eFV8RIFcI9NrcB8l+lazuKkgIgl
 mQV+U49Cy2QcEKQ4NHBu7EmxdvwJnGgtrnJXyNH7XDkcM6E9hQ5reYcV/c0oPyqkJLwW
 KzU8T6NpaxLbWZwxn7/Zp/S4VpoLbPC5/3utRV7O1CRBY/+cCpRV9FqTIN/XRYJQndRo
 L76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706627; x=1794311427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZYM0E0G75slhjVgSpznVNuQ0X1v2jo6RpWzfk497PSY=;
 b=cQmgx72HPiALyx5O310KVMBrF/F4AH6hynVQtW+tfhOY7vl0FS5kuhWicX8g49GXdy
 RIqBQCQCpX5+yDSB4KSYgUgE20Eot6McEsQ4PTIq+Q77OJYloARqlbd5yH01kR4lXK6q
 xx7MHGzE3AlovDai2dFO9I6WexrswOznSL6aozKzA8RXc9lPw9weHyV3AvazPqT50PgQ
 xKmaOb+k2IbQqDPKxG3Si3cpqeHyVASg/oYHQbK5DNXlGLr4YKpJ1GW1WRwF9eB5KPxc
 VtJgBePyLpazkqfpS2RGMx1sPCqu5vbMiloinlPTsd0G48AyoH57uxtlk28x5bpSx7d2
 Jlfg==
X-Gm-Message-State: APuU4Z+O1aIfvoI8nwEsjplQRwQOch5gLQi8MsGptabSGMYf+XoW1XJv
 uzfrYwKOE7J9o7rBUWhDQAIr/FK0eCJ7leizqH00B3QcdARyhJnzvukpPX9WAO5ukr+zH7r0QZ9
 vSLTCUNVVXKESgKLActUHlPEF3hdmyoJNiirgxKfMkAJr7MD1ZkolMrigGAiiD67DAg3UzgXugD
 cHuaz9ZJHSfO7J3vuO0NXGfu1Pd9jp67tcog==
X-Gm-Gg: AYBFou1aFA9ePHdrBLWQoZoRk5l7Sd4YaWNr7IzDmyjzrMTlGxPBObq+R3vQwghBh82
 QN0xJjyPcAfRqw7Ot0sB47zS9nE2cfQomNqwXOVrNAsgg0yETe5whnI7R6Cpm21l0owg946qQQ8
 XD6gdjMI8tqAMJfSK/ZcifIIO2hrnSqO1ZN+tU+lS8TZJpTMQhc6/WifX92yA1IcPTlnoJhZBLI
 JmrIcszgqYpZqGYJjSibusNecXOqvM8L64Xw4K9ezJdjW3PbP/xoLi3E4ONdFx6PVLkaNa1+cc2
 6l9boBj3FArvDT49f1hYo3VP7zban/Ydxpf1Io/jM/5D4RD3excBvCcphI0oh59ll83sQohcghT
 RP5J0LVEqOOWwXytRuLGWbDOmiHKF6YeQF3lkIhdcpw==
X-Received: by 2002:a05:6000:41d1:b0:48e:6a23:4a09 with SMTP id
 ffacd0b85a97d-48e6e50d8cdmr30708966f8f.54.1793706626771; 
 Tue, 03 Nov 2026 03:50:26 -0800 (PST)
X-Received: by 2002:a05:6000:41d1:b0:48e:6a23:4a09 with SMTP id
 ffacd0b85a97d-48e6e50d8cdmr30708916f8f.54.1793706626028; 
 Tue, 03 Nov 2026 03:50:26 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e7a1d9d71sm19181738f8f.48.2026.11.03.03.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:25 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Subject: [PULL 01/17] pcie_sriov: Rework the assert statements checking
 region numbers
Message-ID: <5bc52da8047b2174232a52abd55b73a8ca7620cd.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

pcie_sriov_pf_init_vf_bar: PCI_ROM_SLOT is already out of the SR-IOV
regions.

pcie_sriov_pf_init_from_user_created_vfs: ROM region must never have a
non-zero size.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261028144539.691098-1-clement.mathieu--drif@bull.com>
---
 hw/pci/pcie_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 6a748c3626..e6891436d3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -230,7 +230,6 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
     assert(sriov_cap > 0);
     assert(region_num >= 0);
     assert(region_num < PCI_SRIOV_NUM_BARS);
-    assert(region_num != PCI_ROM_SLOT);
 
     wmask = ~(size - 1);
     addr = sriov_cap + PCI_SRIOV_BAR + region_num * 4;
@@ -344,6 +343,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     dev->exp.sriov_pf.vf = vfs;
     dev->exp.sriov_pf.vf_user_created = true;
 
+    assert(vfs[0]->io_regions[PCI_ROM_SLOT].size == 0);
+
     for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
         PCIIORegion *region = &vfs[0]->io_regions[i];
 
-- 
MST


