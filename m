Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EB3D3C549
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 04:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1eBP-0007Yt-Op; Fri, 18 Oct 2024 00:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1t1eBN-0007YB-6Y; Fri, 18 Oct 2024 00:01:45 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1t1eBL-0006p1-6C; Fri, 18 Oct 2024 00:01:44 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5D2D511401D8;
 Fri, 18 Oct 2024 00:01:39 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
 by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 00:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1729224099;
 x=1729310499; bh=kE76ksr+yr0X5jcs7T/kmdpnmVgXuaWx/5RYapRPNaI=; b=
 aXkMlc0yGdjWQCPd1C89CkdIapaCrsRy3cAHlmo+DSpqrsbQ9N6/XEP7ABeqnW3V
 ZRsTKM01tXgQNnexaMeQgqJIEXjFNnECDK3gMSfkVCZeLRKjj0hMdqFFrwdNviKb
 a+o6heAQURMY/2OW/ITw1f7FM6Jr9gTXoYuwO7A2WfiQsb/YeQTanolCKCqcqdTJ
 jyaeNBAEGp/f3yagGNyqfG7bMzN5ibgsjAeQ6xOuJIbHCW/nqA6IWqMXSqREy3Yn
 7ICvYQuQxFX8j4SwrQAQgAP/I2WKn/yYU9BvS2r4boK4fAr6L8R/iJj1mNO+VGbu
 xUmfs8EZGgujpkDIOjjQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729224099; x=
 1729310499; bh=kE76ksr+yr0X5jcs7T/kmdpnmVgXuaWx/5RYapRPNaI=; b=O
 6oWYS9h2P/skBiU9pRhaje6PZiWLAtVRnfg4vKp2lRHESEqK25NlIEryjsKwIZsX
 7jguf7/F4tK32uG4GQVr7B4USalsGGqLTAI7/5whqV8UUFlWLGqZzMFtQltZ/hPQ
 VYSUoD42jXD1A01M6wq0M2H2q2e1Bg8EOLzJzoB7JsXmspNDhCt/e9emovH2jNx+
 LkLH7OKB+YxBjb+UC0LqD8PcCPAuGyflc33b6ZVTBzPLXH1ZJMXS35APowjpYTX1
 i8PblIk5KtFIiC2NBcgK67D6AcXOxQSDTjB+LIC9576/Ky1pvB2a27SjNyfiJpsw
 sOSVdD60YJHXMZNFBRioQ==
X-ME-Sender: <xms:ot0RZzUXN_o9Ttoyfa9Q7lPIvvI3YyZJU6_fQirJELQPZYoqbSNDFg>
 <xme:ot0RZ7mbIKthPiSbwCVutl5wWmOWbs4-G3olMGgAAp5PBccyOgzENGCTk9Df90mtx
 DMB0iHxTMWaPFmzIUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
 necuhfhrohhmpefluhhlihgruceomhhiughnihhghhhtsehtrhgrihhnfihithdrtghhqe
 enucggtffrrghtthgvrhhnpeeggfefvdduheeuhfeihffhfedutedvtdekjeeuffekfeei
 veelvefhheduuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehmihgunhhighhhthesthhrrghinhifihhtrdgthhdpnhgspghrtghpthht
 ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepmhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhl
 rdgtohhmpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtth
 hopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhho
 tghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:ot0RZ_bbthwn_ffe6G4bieZNifgWwduYHB8oXQadbttt_AseHwn-Nw>
 <xmx:ot0RZ-UXJuOpgts4Bsk9Sm-N5fpR2XdnwDdDNix55vtZnQ8v69veHw>
 <xmx:ot0RZ9muD8oD7-cTp2egpkpGc6-fHMInkFi_d1xhb8qN1xDiuw9zHA>
 <xmx:ot0RZ7cEt_6rpFeGYbQkelI3METDNmw-0UeAb4ohnBO3saQpJYmx5w>
 <xmx:o90RZ7aznAUdJtUIfSinrw7pT_bWLPPz0-gd_TsQu-l7ca7SKtf-gWum>
Feedback-ID: ic5914928:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 56F43780068; Fri, 18 Oct 2024 00:01:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 15:01:19 +1100
From: Julia <midnight@trainwit.ch>
To: qemu-devel@nongnu.org
Cc: "Keith Busch" <kbusch@kernel.org>, "Klaus Jensen" <its@irrelevant.dk>,
 "Jesper Devantier" <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "open list:nvme" <qemu-block@nongnu.org>
Message-Id: <71d8eded-5700-4584-99e5-ab6195d9c959@app.fastmail.com>
In-Reply-To: <20241015103351.688803-1-midnight@trainwit.ch>
References: <20241015103351.688803-1-midnight@trainwit.ch>
Subject: Re: [PATCH] hw/nvme: Remove references to PCI IRQ "pulsing" when
 asserting
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=midnight@trainwit.ch; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Actually, it seems that trace_pci_nvme_irq_pin is emitted even if the IRQ is not asserted due to a setting of the interrupt masks.  Which is weird because there's no corresponding one for deasserting. Possibly this should be reworded for 'interrupt is high (but might be masked?)', or just leave it to the standard PCI IRQ traces.

Julia

On Tue, 15 Oct 2024, at 21:33, julia wrote:
> The NVMe subsystem logs "pulsing IRQ pin" when it is asserting the PCI(e)
> IRQ. This is confusing as it implies a short pulse, not the level-triggered
> interrupts PCI(e) uses.
>
> Also remove the pci_irq_pulse() function marked with FIXME as it is no
> longer used by any calls.
>
> Signed-off-by: julia <midnight@trainwit.ch>
> ---
>  hw/nvme/trace-events |  2 +-
>  include/hw/pci/pci.h | 10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
> index 3a67680c6a..5d96d622ff 100644
> --- a/hw/nvme/trace-events
> +++ b/hw/nvme/trace-events
> @@ -1,6 +1,6 @@
>  # successful events
>  pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
> -pci_nvme_irq_pin(void) "pulsing IRQ pin"
> +pci_nvme_irq_pin(void) "asserting IRQ pin"
>  pci_nvme_irq_masked(void) "IRQ is masked"
>  pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, 
> prp1=0x%"PRIx64" prp2=0x%"PRIx64""
>  pci_nvme_dbbuf_config(uint64_t dbs_addr, uint64_t eis_addr) 
> "dbs_addr=0x%"PRIx64" eis_addr=0x%"PRIx64""
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eb26cac810..863aab0b80 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -667,16 +667,6 @@ static inline void pci_irq_deassert(PCIDevice 
> *pci_dev)
>      pci_set_irq(pci_dev, 0);
>  }
> 
> -/*
> - * FIXME: PCI does not work this way.
> - * All the callers to this method should be fixed.
> - */
> -static inline void pci_irq_pulse(PCIDevice *pci_dev)
> -{
> -    pci_irq_assert(pci_dev);
> -    pci_irq_deassert(pci_dev);
> -}
> -
>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>  void pci_set_power(PCIDevice *pci_dev, bool state);
> 
> -- 
> 2.44.1

