Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10328606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p5iMStj5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCZe-0003th-Mb; Fri, 23 Oct 2026 06:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCZd-0003tW-8b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:32:33 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCZa-00065k-RR
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:32:32 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b0dba37a7fso6330187b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792751549; cv=none;
 d=google.com; s=arc-20260327;
 b=b9pvzRqhKwIWH9BGsKB5fbtVkve1R+nHSW5WId5fnI0cseuJXunUO5Fhpk63mkC9xt
 3voaDda6BqVsNczsWSVL7r2JPZwO0DE+YVNd0/ti6Yx44eU87PQHEQlPbg2a2xhn9jaZ
 764nO5ZKH6HfWQc6fsJlkV4pR0mx7iMfbMSAYXnYnGnqhIZE8CDU5JyI0c5Fd6mlSWTo
 5Ens8dYJmviT9IHDWmqIY3Xbny7S0MQS2MVm/O/2Iz70Mb+K4JhPCYIA7HAIgEp9u2zN
 hezxu7vSLUoZDwQFoZrGJ2o2N+hf4z4gUcHRJ1RiFTNroHlgd2yqrtM4pWL8WlqF+0/i
 2vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8W3Lv9N1iX0Ekj08dfEj7pPVQwWfY1nt7HBD2uPeyi4=;
 fh=gREritCzZWvcfaWqpktBp3/OUmb0rOUSRfa2BWEvW68=;
 b=NIMnkVLGHxeQIZeYng1zZpdBnGbh3kLSOC2sc2eMhY5SZ2BV/7e6fnMegxKIhCTBud
 WhwUZ2MV+zTzr+zjHWXmQxDUVkF3oRXzuAyAWiOYcVhcI9yyGncNFautGE1ic4Xih5lP
 BHeFoRc8K8RMq/fJCxQlA7gryvfkrfE0+sHLczNEXHa446DNx209x41SVBiWxYg0xgXe
 zMwADB9ugYvBOG+/w2lIOV+oBlf7Rxy4SxV5G/K70rin7Fz871zpzc4C6/tAfPzZJ9FH
 FM/Qt166CJjNN5LmPRb1c4lgp9ca3w5IGfVKygiHzr4I3y1dHq3VgQ5TnMygoXfowlQv
 6aeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792751549; x=1793356349; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8W3Lv9N1iX0Ekj08dfEj7pPVQwWfY1nt7HBD2uPeyi4=;
 b=p5iMStj5qOkbqTycU3jp8UmqrVvmo7oT2CZEJHFhSIua43ytUzbImh8vqGHSmGteNJ
 zeaF7OEoGtBl0YN4aGGBm1CBc45lxr2/6QPhW3txofYbff4YvZLFK6Y9O+In2Z9rOxHk
 CYzfDeblDXlappk4grYOXWXCvRKsiD7Me3/t8uanuASeEfqZJdqTpnm96K6hR0qym4qE
 wx4hzwW7gpqAK06q7Ql4jJw4x1oyZayAqvwih5+9Io/XoVOng7SyV0Rip2a6PRGcp9x5
 KZGXzfZCElcuiaBjJK5siQ5DGcHPi+KqKhM6oD+naQ/ZKvw7yuYU6lDqwDu1rEoxGRwW
 JqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792751549; x=1793356349;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8W3Lv9N1iX0Ekj08dfEj7pPVQwWfY1nt7HBD2uPeyi4=;
 b=f1qtV0Pp+GfJuVT6EUQ/1BLB+9bk61QDTLYYypRWaZgfiKozN3APieyczQxpk9dLRw
 8xPYS1waeZq2i7kk33xzh4rV/fand7TwkqRg3A3OV3gBWybRnreRQd0bHmnvPu/ok4x2
 jxytqB6Gg5leuBdlUvU0sGQTRoBvhofxdSY62LB2lfcTylHCngieRdJbLBBe548HJhPc
 7GftzfAuI/nAdMgtgIGZd9Kk/9ubXuUsDBf4C4OoJMHwTK0WnqjeNOfYnmI6an4UfBXN
 zTs6G5xENOOuRdWpXgouNdEjyqEx6DwglzIwZ2K+3x7YXquUCXqtsc/ndul72qxMUJka
 CZOA==
X-Gm-Message-State: AFq9FYKz5k1wA6IAxYrJ0e64b3uJpLs/3cDj87ruEf/k37qGIc//1mbK
 IMzhuRv7XmTQnAewZz8uAjKHO5D8QrJCWmal90RN9rKbPJCZgXiMJmhIxnaIllZNddQ+TiNsEu5
 6t9F8x3o3+evFwNM1ROGG+Kci24PxFHYMFopVS6xjcQ==
X-Gm-Gg: AYBFou3/bu15ywmwR3r5bxCyqhGNEHHAcad7chtTZ75JQ5dvw6hs/0zP5tGy/xCkJOh
 roarcBhNy9hRHbOW+8VRT5evhqCnGOilN2q34C1V/vK3I+B8Ubdyg8ldnAFpXnMR/7IK0TFaYRU
 2eHkkJGDSZnVFfLPyuo9mbuNPoBWMWiJffmLleTApTAS8CTnX23CD1GfuYqwbVKaRgkwEe/WD8Q
 DOTWi75mPCs0YGzKowZX6hYXsVrfgEUlZXYsZsUHJboQa0VbMrSpZtXR78YY3t65MRAIVqPILSB
 2qwdfmTXyZoI6kIYSzDmnw5AtxtUzaJRStpbBilw7g+EGshG+r1D+eBJVw8ztuSOCEGF7mGvMAB
 xmR6YrHf1JZ8cFxD2ktBEPWsFYMMS6Yumrsu9iCINwbAmklbUaZKJXFH1lnsnp0EE1P7Kp0kNKZ
 FrfqZU/sv6cExh75sG4eFT
X-Received: by 2002:a05:690c:11:b0:8b0:c9bb:1c9c with SMTP id
 00721157ae682-8b157c8d6f5mr13969977b3.2.1792751549180; Fri, 23 Oct 2026
 03:32:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-14-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-14-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 11:32:16 +0100
X-Gm-Features: AclHuK-vaSKsRMxW72PiZKoa6OzFfPPVncEymgVUVLDpHCBRxYCEtYh72kc7VkY
Message-ID: <CAFEAcA9t7ZSHFbE=uJyDdycJj+1ocXw4B3fduFf4ZDhWCmQ8gA@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] hw/net/bcm2838_genet: implement GENET RX path
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the receive DMA ring handling: qemu_can_receive()/
> receive() callbacks for the NIC's netdev peer, copying incoming
> frame data into descriptor buffers on the active RX ring,
> classifying broadcast/multicast, and raising the RXDMA_MBDONE
> interrupt as descriptors complete.

> +static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
> +                                  const void *buf, size_t size)
> +{
> +    const size_t desc_word_size =
> +        sizeof(BCM2838GenetRdmaDesc) / sizeof(uint32_t);
> +
> +    ssize_t len = 0;
> +    BCM2838GenetRegsRdma *rdma = &s->regs.rdma;
> +    BCM2838GenetRdmaRing *ring = &rdma->rings[ring_idx];
> +    hwaddr write_index =
> +        bcm2838_genet_make_u64(ring->write_ptr_hi, ring->write_ptr)
> +        / desc_word_size;
> +    BCM2838GenetRdmaDesc *desc;
> +
> +    const hwaddr start_index =
> +        bcm2838_genet_make_u64(ring->start_addr_hi, ring->start_addr)
> +        / desc_word_size;
> +    const hwaddr end_index =
> +        bcm2838_genet_make_u64(ring->end_addr_hi, ring->end_addr)
> +        / desc_word_size;
> +
> +    if (!bcm2838_genet_rdma_ring_active(s, ring_idx)) {
> +        return -1;
> +    }
> +
> +    if (write_index >= BCM2838_GENET_DMA_DESC_CNT) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid RX descriptor index %" PRIu64
> +                      " (exceeds %u)\n", __func__, (uint64_t)write_index,
> +                      BCM2838_GENET_DMA_DESC_CNT - 1);
> +        return -1;
> +    }
> +    desc = &rdma->descs[write_index];
> +
> +    desc->length_status = FIELD_DP32(desc->length_status,
> +                                     GENET_RDMA_LENGTH_STATUS, SOP, 1);
> +
> +    while (len < size) {
> +        size_t l = size - len;
> +        size_t buf_size = MIN(ring->ring_buf_size & 0xffff,
> +                              sizeof(s->rx_packet));
> +        uint8_t *dma_buf = s->rx_packet;
> +        hwaddr dma_buf_addr =
> +            bcm2838_genet_make_u64(desc->address_hi, desc->address_lo);
> +        MemTxResult mem_tx_result = MEMTX_OK;
> +        uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
> +
> +        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
> +        size_t buflength;
> +        uint32_t prod_index;
> +
> +        if (l > ring->ring_buf_size) {
> +            l = ring->ring_buf_size;
> +        }
> +
> +        memcpy(frame_buf, buf + len, l);

The pointer and length manipulation going on here leaves me
unsure whether we can guarantee that this memcpy() doesn't
overrun rx_packet[].

The rest of this looks fine.

-- PMM

