Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01471C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WPy-0000zO-G6; Fri, 04 Sep 2026 12:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPr-0000s4-1q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:24 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPj-0006Fm-VH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:20 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso1855362a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788537913; x=1789142713; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MaRWsfYXrPCYR0C2SN+evr+3/kSgvPxmaScaetm9/p4=;
 b=c7dqjewIhPtkgcBDWe9IxGCHt7oa+TxaRpWAprte/sFODkvQsZQTV57tmPRAKPA1du
 K9Lecl6KdYktiffnM5cXrPxoS+UccC9Ynkk9hR9jtylY5WgGI8ki0BQQ8RPgc8l2kJ1j
 lW/YG+aRr8TrAFu8ae4UXRvcDKwzzSGZW/p6oN3Q6V6RZOmIO2ERQCdTlHDhAUvqg1a5
 aaBlYYQYyGaB8LP0GYZ2sdqHtI4nQ2IzXsxubkiUs63XQUH/CALRrJQTZJxEbhX1HUAW
 Ktrhg9PAzxbcsiIUPiFzgLLG1REE4MynGePEffnZeqk1W2l/U/vE33iwHNlGpM9vvxUY
 IEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788537913; x=1789142713;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MaRWsfYXrPCYR0C2SN+evr+3/kSgvPxmaScaetm9/p4=;
 b=ioW56Ffn0B7W1LjkDBCq3LIBZp1qetzPqfEwrIqtAWL19LRD/uSZaCTa1AzrS71rRT
 NV53nfw3oZldnfQmfgevqUQXHpGVVlnKNk9o3k67d9eVe1QWdyEHv3pORxcaGWGUveoo
 7ThUquqlEI72zFSV/A27I0BSQx76v/16h7ygSLeEd3FN0na+yjG1BIA9A2x/3HnpNFtR
 sJ7IYp3R2zfDvCfnCCZOM6bxC9w2NCvnmDJgW+gYk4TbM9XSPiHtmb4wW/l1CJnltNIs
 qGp9edoZH2vtgBsYp4PVr1o9W8VmEma5FYI4a/ZwGry3whL3hzmBOnkdnjwidHTfaxz3
 ZtHA==
X-Gm-Message-State: AFuF++k4vxu1VUCk8gIkiHP7yHf2y+2Cj/aA4nwjx8zhtcS4aLMDAYdq
 qSw/3WTO28Bf8G6iATQZp5J/IwPhrgzfHbqzj3c42hEPmjj1yfHN9bB2HfzLnvIp9Y4=
X-Gm-Gg: AYBFou1Q4bz7rVVep4YXbSNjEbClEwCqa2xDXSMW4om5p3JHiK9hHx+5mw4Z8i6ivGR
 zJH22hpI+24+hrHFyo/kjl8URC5QJZ1ImIQedMfOelAZHEpKH6d9zhIjkpPmUSwWuVoRysF0XXK
 PGKcanYb65SDxypQPzt9bQNWjIYh3B6a7fQT6ThZ8vLVejzPIvD0deHgLq3wN0LwpPeGnwO4Ybs
 4rVe8qwi04S2S2iHMpi7eIKzf5UNqLsXJYsgdH8mOcOCvxDQzilUWeJJhp6xVUPDM5YVwYO6bba
 yByURca3OqTQAS8yNUdGLApwBgcWVoxfg1UzG6Tc6/BI9gBtUiWASUjTKPrIxsHKEyeXF0Tnt0t
 RL/vHwN7RiQXHqKIElBvfsGpFBLhbqX3sHB+DC8h03WFrXqu1jZQ7YJDgtO71x+mGRr62a4OMkA
 XuSRyBH/CRC8wXrl7GmmROkM1lt5FZwLXhfVYr8XJ3C8/GeilpJCK0wQuv3uf+p60l
X-Received: by 2002:a17:906:478f:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c260ca245bfmr318063066b.23.1788537912599; 
 Fri, 04 Sep 2026 09:05:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:60d5:49d3:5d47:8dbd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d036674sm133815966b.8.2026.09.04.09.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:05:12 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 04 Sep 2026 17:05:03 +0100
Subject: [PATCH v2 3/4] hw/pci: add DVSEC RMEDA capability to PCIe root
 port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jmac-rme-da-prep-v2-3-fb461d78bbb2@linaro.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
In-Reply-To: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

After this we can see all the capabilities listed for the PCIe bridge:

00:05.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port (prog-if 00 [Normal decode])

	...

	Capabilities: [54] Express (v2) Root Port (Slot+), IntMsgNum 0

	...

	Capabilities: [48] MSI-X: Enable+ Count=1 Masked-
		Vector table: BAR=0 offset=00000000
		PBA: BAR=0 offset=00000800
	Capabilities: [40] Subsystem: Red Hat, Inc. Device 0000
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr+
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr+ HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [148 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [150 v1] Designated Vendor-Specific: Vendor=13b5 ID=ff01 Rev=0 Len=16 <?>
	Capabilities: [164 v1] Integrity & Data Encryption
		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM- Alg='AES-GCM-256-96b' TCs=1 TeeLim-
		IDECtl: FTEn-
		[170]SelectiveIDE#0 Cap: RID#=0
		[174]SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0
		[178]SelectiveIDE#0 Sta: insecure RecvChkFail-
		[17c]SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0
	Kernel driver in use: pcieport
---
 hw/pci-bridge/gen_pcie_root_port.c | 30 ++++++++++++++++++++++++++++++
 include/hw/pci/pcie_regs.h         |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 452ebf69b3..035212508d 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -104,6 +104,36 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
     }
 
     uint32_t offset = GEN_PCIE_ROOT_PORT_ACS_END;
+    /*
+     * dvsec rme-da
+     * https://developer.arm.com/documentation/den0129/latest/
+     * Arm RME System Architecture
+     * 0x0000 RMEDA_ECH See B3.2.6.2.1 RME-DA Extended Capability Header
+     * 0x0004 RMEDA_HEAD1 See B3.2.6.2.2 RME-DA DVSEC Header 1
+     * 0x0008 RMEDA_HEAD2 See B3.2.6.2.3 RME-DA DVSEC Header 2
+     * 0x000C RMEDA_CTL1 See B3.2.6.2.4 RME-DA Control register 1
+     * 0x0010 RMEDA_CTL2 See B3.2.6.2.5 RME-DA Control register 2
+     */
+    pcie_add_capability(d, PCI_EXT_CAP_ID_DVSEC, PCI_RMEDA_VER, offset,
+                        PCI_RMEDA_SIZEOF);
+    const uint32_t header1 = 0x010013b5;
+    const uint32_t header2 = 0xFF01;
+    const uint32_t ctl1 = 0x1; /* support tdisp */
+    const uint32_t ctl2 = 0x0; /* unlocked */
+    pci_set_long(d->config + offset + 0x4, header1);
+    pci_set_long(d->config + offset + 0x8, header2);
+    pci_set_long(d->config + offset + 0xC, ctl1);
+    pci_set_long(d->config + offset + 0x10, ctl2);
+    d->wmask[offset + 0xC] = 0xff;
+    d->wmask[offset + 0xC + 1] = 0xff;
+    d->wmask[offset + 0xC + 2] = 0xff;
+    d->wmask[offset + 0xC + 3] = 0xff;
+    d->wmask[offset + 0x10] = 0xff;
+    d->wmask[offset + 0x10 + 1] = 0xff;
+    d->wmask[offset + 0x10 + 2] = 0xff;
+    d->wmask[offset + 0x10 + 3] = 0xff;
+    offset += PCI_RMEDA_SIZEOF;
+
     pcie_ide_init(d, offset);
     offset += PCI_IDE_SIZEOF;
 
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index aa21177411..233378fd79 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -186,4 +186,8 @@ typedef enum PCIExpLinkWidth {
 #define PCI_IDE_VER                     0x1
 #define PCI_IDE_SIZEOF                  12
 
+/* RME-DA */
+#define PCI_RMEDA_VER                   0x1
+#define PCI_RMEDA_SIZEOF                20
+
 #endif /* QEMU_PCIE_REGS_H */

-- 
2.43.0


