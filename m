Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD27CD98C5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyUu-0004qv-S3; Tue, 09 Jun 2026 11:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyUs-0004qT-58
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:36:10 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyUo-00015v-2Q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:36:09 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7BE1814000BB;
 Tue,  9 Jun 2026 11:36:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 11:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781019363;
 x=1781105763; bh=0wIF04rCADL4FP/olrhMJI07G6x432e+F07/o7/Aeg8=; b=
 iNbiVLqKSMjXk3h9i0u2T+ykaKo+S7P1AoZKWxec7w4N5LSYuoRjAFfJupLV3ylp
 YIskuouE10wHItAIYh3/ICIYNAZ9NZ+qoYYgc+Ie2Z+JXF3BQqEz8luuwSgUf6Ih
 JB0NCIJ4/p8RlzLzNVyVmzjAg3ntaQBkL1ixaSaw8C4p0kzsgYY74lkENZGGtLH5
 rZGJ7r/oB3f7IN1xf+jjoxpHw5ffK0dQNQ9qWGa33XcT+NuYS565M3CT+CedMhhp
 BuIKL9nFppLYlhSXPCD9EmTqoDhcFdIiZK/0S11pD5Ei0JC+MtCnNgp99GlDuc+L
 ispukCgRrdIeCyZhkePueQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781019363; x=
 1781105763; bh=0wIF04rCADL4FP/olrhMJI07G6x432e+F07/o7/Aeg8=; b=A
 edOu2aDiU44Tq+TxyiEvkeKVriM2l35GLATEv5mW8QfL5863Sz/gQyZAFH1VQens
 /LiT2c61az3eonumBeNQYtv1vGZURe1crnnRmnkL6OWkOlzayf4/cKrXFHhn0Zr3
 2PFLoxJgKUHN3OZbN4WF/RZhlowVyhOWaMWlETH7AyclRlP83mhXYnOrT5vaLVJO
 cD7Ba/NmmgxZjmbTnVdPOp7QS0L+RaGducysoj8gtAtdGwDltLvHSKYIN5CNKxn6
 UoEljnxYOot/bZFw+fU9KJB7yRnj9yHnDhtkgrn6fOKutqQ0Jytu6w2f0JR8DnBW
 TNJhIWN7KnUBL6jEeRd6w==
X-ME-Sender: <xms:4zIoasjIyuPVvJCBfwy2CRhsd5_3N27ccS_fiR-HvjsvqjOyFMHHmg>
 <xme:4zIoat-GF7oX_QK9CXfYQVAy9fDmGMrErCFivAHPQcp5jiJ_FgzUDLFLCXqGnMT4A
 Go5nF39fqxT_CrrwXE0DO4yp5M4saTPQq4Iq1qqiVpDHTUuymcmpg>
X-ME-Received: <xmr:4zIoavoO_my-lySUpRxbfzsIsqbMPp0qp3GTosINnAPQwds83WZyDJWD1_w>
X-ME-Proxy-Cause: dmFkZTFFUpGjjmihIIHbNVLC/jR0MYDO7Yz1OcEbuBORzHZ9NSy7GLwyvtJEIWmvrsejZ1
 KpWUIfiguSPoaOW3F9uLeWY7U1klr1io6U9+xkTnKC5/1hoelE9k/JrotpkZd8u8wEFa1T
 NQBbePSslA/RQlQwTtihLuH+leq3wpoMoxJWfE8wmndDouNMP7or1+JjxjqEpU5QUZ/KUr
 Bq36d/sCtiHp4zBoFePrVBypm2lO3zlnzR8hkHDarSn7WMovMpeXt18AxD4aD0UkePHKAp
 2UTxNTZgbjlEZDeR8AEOM3E1voYmKEwDzL0J8Ad9Ktz5VtWKraJjoouEul92Z80IN/5zKf
 RWGLIIs4+HUj8dc4erA/WnhmxHB8tmXHQCZvEWmee8f9qU6MDbfSbFRmvEs0EtfWL1OZSt
 V4QYHh7kWUErN9VOjCTpkFqMNlAaC2W52Eqr6wPawphDwwOidAaS0MUf/W1p/WhcBgjAgq
 Gkfn4O3B0K5WHK0XUQGccGE72w9Fil0bq7yion0XRiMKomFzWJWlPxrfck14AOJMy53Uz6
 AibU0+b18iHJrCNvCE2Dtg4t/zopK3W933wzQie6waSXMj8YqNSMWrr3Ig3yWS8jRx8pTb
 05VVMqjAH6DLg/q7Wen9awFcUfnJvUJgAyrnzUGT5g/te6naTaAxU3CQn8rg
X-ME-Proxy: <xmx:4zIoatU9ijtZbawko5FcqFL42HwpsfGRkh6N1Rv-fXg3g0kqhw8lNw>
 <xmx:4zIoamAMiYxcFcfTOeNlWQ3JEaIBqFlbx5JrVQuzw_fb9t1_JWPezA>
 <xmx:4zIoap305YOYFJK1oTEa_SHQI0XFMEjH_LRa_uSkwdTuTTmrWyBheA>
 <xmx:4zIoag0E4M8gP4nneGuYfa8eJnzAR32XaRuWDjBMSkqz_j0vI7oOnw>
 <xmx:4zIoaqwtwpchzvCkgLj3cYSBkZkcD8dTKZVNIFJeMraDF71yill3_8B4>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 11:36:02 -0400 (EDT)
Date: Tue, 9 Jun 2026 09:36:01 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH v2 2/7] hw/pci: Skip EFI option ROM in pci_patch_ids()
Message-ID: <20260609093601.59aa6fde@shazbot.org>
In-Reply-To: <20260608134559.23971-3-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-3-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=alex@shazbot.org;
 helo=fhigh-a8-smtp.messagingengine.com
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

On Mon,  8 Jun 2026 21:45:53 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> pci_patch_ids() patches the checksum at the reserved 0x06 byte, but
> for EFI option ROMs the 32 bits at 0x04 are the EFI signature and
> must be 0x00000EF1. Since OVMF does not check vendor/device IDs in
> the PCIR header or the checksum, skip patching for EFI ROMs.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 742917f79d..eb10e586d5 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2521,6 +2521,11 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>          return;
>      }
>  
> +    /* OVMF won't check IDs in PCIR header, skip EFI roms */
> +    if (pci_get_byte(ptr + pcir_offset + 0x14) == 0x03) {
> +        return;
> +    }
> +

Just above this we have the sanity testing:

    if (pcir_offset + 8 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
        trace_pci_bad_pcir_offset(pcir_offset);
        return;
    }

+8 covers the vendor and device IDs, but now we're reaching deeper and
should extend the validation to match.  s/8/0x14/  Thanks,

Alex

>      vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
>      device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
>      rom_vendor_id = pci_get_word(ptr + pcir_offset + 4);


