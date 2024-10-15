Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169FAD21694
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 12:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0gpr-00087N-5W; Tue, 15 Oct 2024 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1t0esx-0006IX-DR; Tue, 15 Oct 2024 06:34:39 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1t0esv-0005RM-HM; Tue, 15 Oct 2024 06:34:39 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CFFD71140241;
 Tue, 15 Oct 2024 06:34:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 06:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1728988473; x=1729074873; bh=lpvhcljY0QB4hqtbjg1qA
 FgkzMmbRH13sxLLRGmorEo=; b=gQRabz1DEnh9UgzmkwU5ZxYW2MrnyYgTPAIYr
 UKbiR7ApbhD+JarX34mmLJCyHZQMIs2QQgwlmx7GhQWP7hsTtpjWFIisCzbRuz2T
 3ITMF5lMHJCWxFS41gkBiPbucP+adrTxOo84L7s7o6n0+RlWA1jK2U08bkM88VgH
 nxwyvwwiSKkJs6QTzaDVXXUq3iF2NgDZRUUt14tClkfESzLPSstUyNbXaZvES8hy
 ft7in0pqxPVUh9lJ4IfM5CSaC540YqqDnHUukkG+SFq0IvAklOcjbryqh3xIukKR
 xdzdd+c9FuAjvs7w6HVbusbM0SVBZeV6YFe/eqpN1zlB7WNKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1728988473; x=1729074873; bh=lpvhcljY0QB4hqtbjg1qAFgkzMmb
 RH13sxLLRGmorEo=; b=mbe5FGiXK/IZz/Ttt4ovC5wfIrpM3I1TesKpInNOcpCM
 jEPQefcu+QyMd+WEmTXjOZsGSSwgTgjtHbyAo0EDY8/P7dx32JIQgO9PmdoAQAqR
 otUgT4hF2aVDPNIlWKzRdBDGYbl99E7ZMHoBKo60HCnMKB0WHnJXeTsMNUvemUHH
 PbpSSDoPEwmTNMUbfdIomyUdOwMWM2fP8T2nQLAxgsg+GVCMQ/vmRqp/3vqFBCUz
 MC/Ghft3qeqkqKJXlXH6GcAeckxtImS4qHRA679hM687fpLzNh2Eobl8Y5J2tOjs
 I+Gjdl8lEWhZhWBlXrXkh4xEs4jSLH37r9LQdCYedQ==
X-ME-Sender: <xms:OEUOZ6-WBUmVlr-awc1NLp1CLG854vNCWR_JDRO_zw-Z5m3ostjOmg>
 <xme:OEUOZ6t-DBAAyI7mHZM7CcCCjLHx06qb0DwipUkkq7gQQc1xGalt87aCng-s4ccLI
 c_ErkHfySRHJaWOm9Y>
X-ME-Received: <xmr:OEUOZwDpIxZIgAEz6eVn73AZ-MIURK92Q0Ax4_USgNAZN0MZT53y1jLWC8UPehaxvkrzRjOtd6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
 rhhomhepjhhulhhirgcuoehmihgunhhighhhthesthhrrghinhifihhtrdgthheqnecugg
 ftrfgrthhtvghrnhepvdffjeelieehgeetfeetiefffeetteehlefgveehgeekteelgfff
 teehkeeivedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepmhhiughnihhghhhtsehtrhgrihhnfihithdrtghhpdhnsggprhgtphhtthhopeek
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtohepmhhiughnihhghhhtsehtrhgrihhnfihithdrtghh
 pdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehith
 hssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghr
 ohdrihhtpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmh
 grrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgv
 mhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:OEUOZyehg8GNTKCE-hk4Ontf97WtPBasMiL_z-Wj0R4qcTZn4nCPLA>
 <xmx:OEUOZ_NrDEZWiLT7onao0C8Yvsii1VbcBomGgLUFnm9zpo-xcq646Q>
 <xmx:OEUOZ8nkMLuBGcgdQ-KqpVJnAExLULB23bxylcn5YMsbdHCa5PxPEA>
 <xmx:OEUOZxuRR0tyEvejGoibCQlgFQGEP8JVhEwo_rHmNPKwGz-ufgJn6Q>
 <xmx:OUUOZ4gRn7K8Iurf44viwdP4y8KFDsCO0BqtnIkN72OJynbCcI4KhGbd>
Feedback-ID: ic5914928:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 06:34:29 -0400 (EDT)
From: julia <midnight@trainwit.ch>
To: qemu-devel@nongnu.org
Cc: julia <midnight@trainwit.ch>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org (open list:nvme)
Subject: [PATCH] hw/nvme: Remove references to PCI IRQ "pulsing" when asserting
Date: Tue, 15 Oct 2024 21:33:48 +1100
Message-ID: <20241015103351.688803-1-midnight@trainwit.ch>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=midnight@trainwit.ch; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Oct 2024 08:39:33 -0400
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

The NVMe subsystem logs "pulsing IRQ pin" when it is asserting the PCI(e)
IRQ. This is confusing as it implies a short pulse, not the level-triggered
interrupts PCI(e) uses.

Also remove the pci_irq_pulse() function marked with FIXME as it is no
longer used by any calls.

Signed-off-by: julia <midnight@trainwit.ch>
---
 hw/nvme/trace-events |  2 +-
 include/hw/pci/pci.h | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 3a67680c6a..5d96d622ff 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -1,6 +1,6 @@
 # successful events
 pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
-pci_nvme_irq_pin(void) "pulsing IRQ pin"
+pci_nvme_irq_pin(void) "asserting IRQ pin"
 pci_nvme_irq_masked(void) "IRQ is masked"
 pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
 pci_nvme_dbbuf_config(uint64_t dbs_addr, uint64_t eis_addr) "dbs_addr=0x%"PRIx64" eis_addr=0x%"PRIx64""
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac810..863aab0b80 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -667,16 +667,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
     pci_set_irq(pci_dev, 0);
 }
 
-/*
- * FIXME: PCI does not work this way.
- * All the callers to this method should be fixed.
- */
-static inline void pci_irq_pulse(PCIDevice *pci_dev)
-{
-    pci_irq_assert(pci_dev);
-    pci_irq_deassert(pci_dev);
-}
-
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 
-- 
2.44.1


