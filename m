Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F3ECD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVccq-0000zy-FN; Fri, 05 Jun 2026 18:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVcco-0000zU-Dl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:02:46 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVccm-0000sv-RN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:02:46 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5591F1400144;
 Fri,  5 Jun 2026 18:02:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 18:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780696964;
 x=1780783364; bh=T152RR4rh899pa1fg0KzBtrWfdk46WmtjuNk0YKJABk=; b=
 TnmGEPa/xpcIj+kWl9vAXACPzpVZS7CMp7D8UHzJAb01fnTiverz2Du1uNKiuk2d
 Y9/eMNJiMFGkvyWFhZAxz7CDW2HpIeI7tPa2ON+QaMt5gEu+PphdPvJyk3BSCp+6
 KQsGG2H3urC7bsGQHMqsCPnwK9xrdOQLUzd+TD2v2U394dM8d0aL6KhoBzC1bPzv
 Xmx1DZyrWFgPWvsCMZg/FL9q6k8ELFt+718OKBAZOm8y0NK7gVSQjALl43mE7xsv
 0W/7iVa9lIGr7/ilvr7SzrW1/z8SONjLUoxduBl0lwYjVjUXOnw3Yv3uf/dHjz6M
 csI9pYFrxVtFHfU+wiN1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780696964; x=
 1780783364; bh=T152RR4rh899pa1fg0KzBtrWfdk46WmtjuNk0YKJABk=; b=c
 AK3y3TNt+DkNAKXFx3ca5lTuOy5iqcYEbsGs9bmcK8YLfqtsgDN0TPEa5TfbBlWe
 4bY4/M5w2vPCX7a+FARpk6Cuo1Qybz3twCTaum8lVOnLm7kAjPEsOCii+aWXa0lz
 T4TCv5mWFpuLsW3OmZHxOkm079RdAiuUVDfJinY4ICd640nrIir5CqLW1DGK6tNd
 MTCXmWEPxz3n+2AnVIDQs+E+czat3K9MBBPeSeGfoSUt0aokWP/mFdT2xzzF2dkp
 GCs+RjIrcZiGdAi0HR8f6LOu+YG32lWnmY1g84sEgj4TdNLLJJvQv3vK5hGWSMpD
 w5kSuofumTF87z+X13qFg==
X-ME-Sender: <xms:hEcjar0wQ3I1vF7uBMp3rQZirwDbD4aQbt4TzjCB3aFNGerZmBQZaA>
 <xme:hEcjajDondzoTChu27Z_A8ZhMAZBfBohOE30Pfgmntq_YfYq8KSLxtTasvfjHYh1e
 uf1r7VVXfQ24wHtvLlrI-o9oRsRTS5tbMLEOS6oV03tE35tCdWFzw>
X-ME-Received: <xmr:hEcjandEUNDPtFCIc2b74T_YQBNY2hsn5RMcCpTcasTIYw9ZLPPtx8hXQhg>
X-ME-Proxy-Cause: dmFkZTFW0/HJg84SCHeNWA+1evtL1PhrZVIVRZTGAahxDG44rtp+xna683lf2rr+HHhFct
 syN4BxA5h4qmlSK6Q/oZ4UDNrK3oKLxN6mddwTuiGg/kkdspU7b9Fwle1S/UHOY+i2ummn
 1E6a/sw4sW2oOfVLzLyXTlFnHiodofTFoNKzRI99JFdw03GPzNaRnSviTKnFW0L6FLq69y
 kVdD/8IOAFDGLIeuctWdeVIVm8vK572mRrVXPGNrinbqNggysXZVDWuFzAqW1xDzJQ6Ksz
 9+Hj67Wo2MUZB+csQwUxkiW6Lm5V2ZkoQIJ0gP+6rs2dHxNhYc+IdlJy7x4yAkemAcddqf
 XEZfKIZK5uX00AKlFxsz2OZ11JyQqhTGJzQ1WSrMUOpp4UFuj0mFfIh7TxKODL4t81MBwT
 W1QXt1W7GwqBVJ8dM8fZL4YVCqIa2kxJXqOsTllAAwuVIiT6qCNvTD4LROSFC/g+Gdwssu
 hv+LtlWlAkLnU1UWY7RdnRuHUbPvCFwsJ5CqtO0e7Iz+FcHKPnz9g6uWXxPqCrpu/pgFJJ
 s9crLSf4M30i0jzFw9zg6jUtgc2pmG+GQH8XI6yvh8RqwqjMVBKE3UfvAyjPamK7qURqzq
 SSkpqLGcUZutX2mvRLjwcWNDVPOidAKMqJflfhUj4hIF0GNQ15nS9q8Oxi/w
X-ME-Proxy: <xmx:hEcjag5S1Rb-Y-DFjkj-vGegl-bQrhTFLGb7EGYBSg6YzovhGHUnVw>
 <xmx:hEcjaqXeN3ISpLq3wtiRtI2f24-MH8fjVcVK3Fg8_a4JshbyJYZPDQ>
 <xmx:hEcjav552w2m4mzjVKxWsgzx-0ADa5qCGwyDLaungp1a-e8KkvWAmw>
 <xmx:hEcjalr0qjbUQYNDBLJplnyBnDe9w0W7VzhI-r0upabSnh2XfLoQiw>
 <xmx:hEcjatW5NlxTc63NqUMa99gCOELDuAkmbbr6vypoTPsrLR_cWZbHG4kZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 18:02:43 -0400 (EDT)
Date: Fri, 5 Jun 2026 16:02:42 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 1/6] hw/pci: Recalculate option ROM checksum before
 patching ID
Message-ID: <20260605160242.66f6f4df@shazbot.org>
In-Reply-To: <20260603173355.36121-2-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-2-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=alex@shazbot.org;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu,  4 Jun 2026 01:33:49 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> pci_patch_ids() only adjusts checksum based on the new IDs. For an
> option ROM with invalid checksum, the patched one will still have
> an invalid checksum. Always calculate the checksum and patch it if
> necessary to ensure the option ROM is valid.
> 
> This is intended for fixing the romfile used in IGD passthrough as
> multiple IGD devices share the same rom with possible non-matching
> device ID, and its checksum is known to be bogus [1].
> 
> A helper function pci_rom_calculate_checksum() is added and exported
> for reusing in IGD-specific quirk later.
> 
> [1] hw/vfio/pci.c:1090
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> Tested-by: K S Maan <kirandeepmaan45@gmail.com>
> ---
>  hw/pci/pci.c         | 22 +++++++++++++++++++++-
>  include/hw/pci/pci.h |  2 ++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4298adf5a0..043fef1954 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2472,6 +2472,21 @@ static uint8_t pci_find_capability_at_offset(PCIDevice *pdev, uint8_t offset)
>      return found;
>  }
>  
> +uint8_t pci_rom_calculate_checksum(uint8_t *ptr, uint32_t size)
> +{
> +    uint8_t checksum = 0;
> +    uint8_t orig_checksum = ptr[6];
> +    uint32_t i;
> +
> +    ptr[6] = 0;
> +    for (i = 0; i < size; i++) {
> +        checksum += ptr[i];
> +    }
> +    ptr[6] = orig_checksum;
> +
> +    return -checksum;
> +}

This seems to compose better below if we just have the function return
the actual checksum without excluding the current fixup and move the
fixup to the end, ex:

  checksum = pci_rom_calculate_csum(ptr, size);

  if (vendor_id != rom_vendor_id) {
      checksum += (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
      checksum -= (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
      pci_set_word(ptr + pcir_offset + 4, vendor_id);
  }

  if (device_id != rom_device_id) {
      checksum += (uint8_t)device_id + (uint8_t)(device_id >> 8);
      checksum -= (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
      pci_set_word(ptr + pcir_offset + 6, device_id);
  }

  if (checksum) {
      trace_pci_rom_checksum_change(ptr[6], (uint8_t)(ptr[6] - checksum));
      ptr[6] -= checksum;
  }

Just a style/consistency suggestion, not a functional difference.
Thanks,

Alex

