Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B502BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riagj-00023Z-V5; Fri, 08 Mar 2024 08:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riagi-00020s-7G
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:55:04 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riagd-0002fb-Mr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:55:03 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d220e39907so29614621fa.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709906091; x=1710510891; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zOr3mOsvaZ0DUN7LJn5Yl96Wk0uYZTPx6ljKNcmwe18=;
 b=vLM7JXb0uiGhs1QzqaisBtoSG3uroD+CgSf/pY7dAxSGwWjCguZoWmcVVmONLR0+G9
 ICsk6QPR8QIoqPxB/ybtG4bemmCIVJzAs1gytNUcZfTOR12SF/GxEYN21L1Rrj7FDO5q
 aA2Tqu8GWjvQfeCc62wrVuZl21ZjhM8aUxExvDF2BImcVPT3fESKvxqH03yP6T2QZf6t
 hvMedJzmSA8mmfcjTD6+jCb4iMftJAD/kV+coXFt7xS7gbIyb6SYP6oFelrJLrupE2QE
 VQXa+Ah+i25y7utMUNIQhmaC6MpIp2gb//x31E3ZnfpiKiSlK8pGLRUzAE+4UH/aqtju
 w8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709906091; x=1710510891;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOr3mOsvaZ0DUN7LJn5Yl96Wk0uYZTPx6ljKNcmwe18=;
 b=DU5NTkIzQszMf5FdmGyGU0Wr1yxEvnbuqpw4wsmAemv+hk4CJP2VrxGpXQzQLLDDo6
 lSoWyGTBvNbUo3bEkNiqc1JD8JPnV5aODvtDHhyRlfP12vhSrgkxP2Veh5Huyg7IKNYy
 J7oQwyDvKwq8gGOZfAsPAMX7lxf7k6Rt0evmTXfNW3INNdyEZ5bP4OIOlOgAPLR80Nnw
 SZMGpfPGq7qRBNqDQ1G7hHdcmsHsi8PmJka+a/oyeayij2SeON+JGoMsQbJSdphBWH6R
 vNoLjZ20Zk3rSq0duJWDtFhbdzzkbydXfu5eYZqLYh1lNfrMkGywNCZsfjMzgqjWZ1N5
 eP4Q==
X-Gm-Message-State: AOJu0YzoxXkRuoF/Uph9yWcD7Gq5Sd3UKPPNAdEdtfpHabmiPuaFH/6C
 E4W43wcXJScvg97vOoDog+lRlRtQ6dUXw5sz7wvbcUNdJeNHQpkBDtQ+Z6EjtYjgj4fpAlygJOw
 R5S+XmBTc2ULf3wnknF/V7NnngXzV5qNQN+DTJxNRGaeXECka
X-Google-Smtp-Source: AGHT+IErWeuboNbliv+RcoQ4uo9ZtcV1indKTJixC36jyqZhA1IeG1WNpH2LDyAuAem+6U92PkvbG62QK6n/T6kRN1o=
X-Received: by 2002:a2e:b553:0:b0:2d1:276b:860 with SMTP id
 a19-20020a2eb553000000b002d1276b0860mr3338843ljn.31.1709906091188; Fri, 08
 Mar 2024 05:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
 <20240202153637.3710444-34-peter.maydell@linaro.org>
In-Reply-To: <20240202153637.3710444-34-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 13:54:40 +0000
Message-ID: <CAFEAcA-p9NcQqH_DU70mdneJkd-oaioVUWqJdZoJt6fqaQrDpw@mail.gmail.com>
Subject: Re: [PULL 33/36] hw/net: GMAC Tx Implementation
To: qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>, 
 Tyrone Ting <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 2 Feb 2024 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> - Implementation of Transmit function for packets
> - Implementation for reading and writing from and to descriptors in
>   memory for Tx
>
> Added relevant trace-events
>
> NOTE: This function implements the steps detailed in the datasheet for
> transmitting messages from the GMAC.
>
> Change-Id: Icf14f9fcc6cc7808a41acd872bca67c9832087e6
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Message-id: 20240131002800.989285-6-nabihestefan@google.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


Hi; Coverity points out an issue in this code (CID 1534027):




> +static void gmac_try_send_next_packet(NPCMGMACState *gmac)
> +{
> +    /*
> +     * Comments about steps refer to steps for
> +     * transmitting in page 384 of datasheet
> +     */
> +    uint16_t tx_buffer_size = 2048;
> +    g_autofree uint8_t *tx_send_buffer = g_malloc(tx_buffer_size);
> +    uint32_t desc_addr;
> +    struct NPCMGMACTxDesc tx_desc;
> +    uint32_t tx_buf_addr, tx_buf_len;
> +    uint16_t length = 0;
> +    uint8_t *buf = tx_send_buffer;
> +    uint32_t prev_buf_size = 0;
> +    int csum = 0;
> +
> +    /* steps 1&2 */
> +    if (!gmac->regs[R_NPCM_DMA_HOST_TX_DESC]) {
> +        gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =
> +            NPCM_DMA_HOST_TX_DESC_MASK(gmac->regs[R_NPCM_DMA_TX_BASE_ADDR]);
> +    }
> +    desc_addr = gmac->regs[R_NPCM_DMA_HOST_TX_DESC];
> +
> +    while (true) {

In this loop...

> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE);
> +        if (gmac_read_tx_desc(desc_addr, &tx_desc)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "TX Descriptor @ 0x%x can't be read\n",
> +                          desc_addr);
> +            return;
> +        }
> +        /* step 3 */
> +
> +        trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_path,
> +            desc_addr);
> +        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path, &tx_desc,
> +            tx_desc.tdes0, tx_desc.tdes1, tx_desc.tdes2, tx_desc.tdes3);
> +
> +        /* 1 = DMA Owned, 0 = Software Owned */
> +        if (!(tx_desc.tdes0 & TX_DESC_TDES0_OWN)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "TX Descriptor @ 0x%x is owned by software\n",
> +                          desc_addr);
> +            gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TU;
> +            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +                NPCM_DMA_STATUS_TX_SUSPENDED_STATE);
> +            gmac_update_irq(gmac);
> +            return;
> +        }
> +
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_TX_RUNNING_READ_STATE);
> +        /* Give the descriptor back regardless of what happens. */
> +        tx_desc.tdes0 &= ~TX_DESC_TDES0_OWN;
> +
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_FIRST_SEG_MASK) {
> +            csum = gmac_tx_get_csum(tx_desc.tdes1);
> +        }
> +
> +        /* step 4 */
> +        tx_buf_addr = tx_desc.tdes2;
> +        gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
> +        tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
> +        buf = &tx_send_buffer[prev_buf_size];

...we never use 'buf' before we initialize it down here in step 4...

> +
> +        if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
> +            tx_buffer_size = prev_buf_size + tx_buf_len;
> +            tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
> +            buf = &tx_send_buffer[prev_buf_size];
> +        }
> +
> +        /* step 5 */
> +        if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
> +                            tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read packet @ 0x%x\n",
> +                        __func__, tx_buf_addr);
> +            return;
> +        }
> +        length += tx_buf_len;
> +        prev_buf_size += tx_buf_len;
> +
> +        /* If not chained we'll have a second buffer. */
> +        if (!(tx_desc.tdes1 & TX_DESC_TDES1_SEC_ADDR_CHND_MASK)) {
> +            tx_buf_addr = tx_desc.tdes3;
> +            gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
> +            tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
> +            buf = &tx_send_buffer[prev_buf_size];
> +
> +            if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
> +                tx_buffer_size = prev_buf_size + tx_buf_len;
> +                tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
> +                buf = &tx_send_buffer[prev_buf_size];
> +            }
> +
> +            if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
> +                                tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Failed to read packet @ 0x%x\n",
> +                              __func__, tx_buf_addr);
> +                return;
> +            }
> +            length += tx_buf_len;
> +            prev_buf_size += tx_buf_len;
> +        }
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_LAST_SEG_MASK) {
> +            net_checksum_calculate(tx_send_buffer, length, csum);
> +            qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
> +            trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
> +            buf = tx_send_buffer;
> +            length = 0;

...and in this bit of code, we set 'buf' to something else...

> +        }
> +
> +        /* step 6 */
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE);
> +        gmac_write_tx_desc(desc_addr, &tx_desc);
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_TX_END_RING_MASK) {
> +            desc_addr = gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
> +        } else if (tx_desc.tdes1 & TX_DESC_TDES1_SEC_ADDR_CHND_MASK) {
> +            desc_addr = tx_desc.tdes3;
> +        } else {
> +            desc_addr += sizeof(tx_desc);
> +        }
> +        gmac->regs[R_NPCM_DMA_HOST_TX_DESC] = desc_addr;
> +
> +        /* step 7 */
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_INTERR_COMP_MASK) {
> +            gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TI;
> +            gmac_update_irq(gmac);
> +        }

...but we never use 'buf' in the rest of the loop before we go back
around to the top again, so that value that we set will never be
used before it is overwritten with something else in the next
iteration's step 4.

What was the intention here?

> +    }
> +}

thanks
-- PMM

