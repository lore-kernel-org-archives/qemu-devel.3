Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F68BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 16:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzf75-00007D-AI; Wed, 24 Apr 2024 12:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzf6x-00006R-Ev
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 12:04:46 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzf6v-0001ea-Ow
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 12:04:43 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so6621423a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713974679; x=1714579479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AvhxFkw9jqfxOrZ5LRzVFFZbTM1fOmun5chamhyiV+E=;
 b=c00QQ/5JSjI1aIwpD8LUKni5NY7zpf2CRYNAlaG6jK9ApGQ++ElHUK0NirR7lo7vT5
 02IwyYfnzhT3VB4Gk1lxms8+fFQX8pVTAZDmm1pt/QdthuY23Pg8NKUB51Tkx3Y488Ge
 d8m1thsJOCykNCu4vgqUBLUPK8cL7OE63wR/LIJmiDfT/4AvOtmX0H8bFkfDo0ZG12YD
 kszQv8m3VIuLHv0Pa71JaLnV0FV+RnVDIziVSZm0S3IJOm4g0eQyJ7vnm81sEsDU1hrm
 r5eP5hrIypZ+Yu8wS6E7DbmtB2nHNMngSdUTuEd6kLol4H8MevhMsKKEDCmxbdTMztiq
 EzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713974679; x=1714579479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AvhxFkw9jqfxOrZ5LRzVFFZbTM1fOmun5chamhyiV+E=;
 b=inCroMckCe8bihErBuRZW5zmRk7hJYudQMI1Fp8ToF10w7WWsJIwZA/w4PrL4Hp2jh
 6NBm1U9vTGUMw3H3B/HBJ6AF3BEOE0dSNzdbL+HGfC6Azd5iBB12eYER4NMFYqbFuU9H
 uPcEsfrGhQn257DtbRA0Px5xSjODMOS9yrznmEc1czGo0y0/97z6HA6b1emh9pJUjakO
 BG4wScvvXmQINaK9rT5EocaGYz8Phkbk1DDCVx5eT14VKC9JAX+eIIySz5ugspFggapB
 vojIPpjyulmaz9WMJI15DayYnEkLOnUriJYbPHmnX3ZB/4lxDYjzwVuB4ZiLzfKpaqOU
 CODg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeAIFoszLiRp3whMDKJ+iCdAHd8+vZGBcuISKE36oylNELYppH/O5a1RK7BZzn0XXPjpU+bAns6ZK8jgkPTFAJv6wBALE=
X-Gm-Message-State: AOJu0Yxl3R10URaDBDaZ9r71oXB7BJ4Qo/lynTdAr8gaNGNVk0ABKitx
 Btm52CjUQEH+wQ11IJ0//xK4C/taVym4VFzDm/HINdo+OkuE3J/FHmx/rBznuaWaLbRJne58W7/
 VKJaBAll39OyMetS15gzA4W6WG0zGIrz33cSuFg==
X-Google-Smtp-Source: AGHT+IHqynN6Er7RUqzNYSdpXRm3xyTkDQyDdl0S6wd4Al2pm8dfXtdVpli1JWpjULN1mQJWzBv2zy4TslT5/uV3B/0=
X-Received: by 2002:a50:f688:0:b0:570:1ea6:e9d8 with SMTP id
 d8-20020a50f688000000b005701ea6e9d8mr2137218edn.9.1713974679115; Wed, 24 Apr
 2024 09:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9JXOxkbQP6-1uTK+hG5yvYRcO31PYFZSxGjfrPis1nYA@mail.gmail.com>
 <20240424125324.1628-1-adiupina@astralinux.ru>
In-Reply-To: <20240424125324.1628-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2024 17:04:27 +0100
Message-ID: <CAFEAcA-=kk_TQVRLLQvH96DC-ffmDqd_hU5=z=Og8ntYGxPUeg@mail.gmail.com>
Subject: Re: [PATCH v2 RFC] fix host-endianness bug and prevent overflow
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>, "Konrad,
 Frederic" <Frederic.Konrad@amd.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 24 Apr 2024 at 13:53, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Add a type cast and use extract64() instead of extract32()
> to avoid integer overflow on addition. Fix bit fields
> extraction according to documentation.
> Also fix host-endianness bug by swapping desc fields from guest
> memory order to host memory order after dma_memory_read().

Thanks for this patch. Could you split it into two, please?
The error in handling of the descriptor extension fields is a
separate problem from the endianness bug, so they should be
fixed in separate patches.

> @@ -660,6 +660,24 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>              break;
>          }
>
> +        /* Convert from LE into host endianness.  */
> +        desc.control = le32_to_cpu(desc.control);
> +        desc.descriptor_id = le32_to_cpu(desc.descriptor_id);
> +        desc.xfer_size = le32_to_cpu(desc.xfer_size);
> +        desc.line_size_stride = le32_to_cpu(desc.line_size_stride);
> +        desc.timestamp_lsb = le32_to_cpu(desc.timestamp_lsb);
> +        desc.timestamp_msb = le32_to_cpu(desc.timestamp_msb);
> +        desc.address_extension = le32_to_cpu(desc.address_extension);
> +        desc.next_descriptor = le32_to_cpu(desc.next_descriptor);
> +        desc.source_address = le32_to_cpu(desc.source_address);
> +        desc.address_extension_23 = le32_to_cpu(desc.address_extension_23);
> +        desc.address_extension_45 = le32_to_cpu(desc.address_extension_45);
> +        desc.source_address2 = le32_to_cpu(desc.source_address2);
> +        desc.source_address3 = le32_to_cpu(desc.source_address3);
> +        desc.source_address4 = le32_to_cpu(desc.source_address4);
> +        desc.source_address5 = le32_to_cpu(desc.source_address5);
> +        desc.crc = le32_to_cpu(desc.crc);
> +
>          xlnx_dpdma_update_desc_info(s, channel, &desc);
>
>  #ifdef DEBUG_DPDMA

I would suggest factoring out a function like

static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
uint64_t desc_addr,
                                              DPDMADescriptor *desc)

which wraps up "read the descriptor from desc_addr and fill in desc"
as a single operation (by calling dma_memory_read() and then
doing the byteswap).

thanks
-- PMM

