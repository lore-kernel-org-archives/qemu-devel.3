Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138EFFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAer-0005nU-N7; Tue, 05 May 2026 03:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAem-0005mt-KS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:57:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAek-000603-2k
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:57:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso36710925e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777967844; x=1778572644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PWQ5sqXfuI7IaCZ7L9BfQyKyaRqZ4DEsEDqyslmJDKA=;
 b=CMFOoaB4TPMf5Y9ZzwqWZVFASJAMadGOzF9OvTRfM4tlhSrxpPvAFdMRSlIX5ZkeBt
 5dqwNF0r8Yoa54SPmB8r0bcABOa5WuTNOUs2eVfVEy1rbtj2Mi+K/fvAImugdN8ZEy4d
 X7Z3fJ84IcgfeNqHOACWxIxO/8dJH13l9Aj12yVmjlgNu8u2eQS6mRxomiqrqpJNxnAS
 GTbqtwfIY1pCS+obhog+YnIFz4ySHiz+3/STLOgVjTX2KbpWPpPRCvgwV/2wA//BytLa
 PtzgYbutpxiFkuSWItpxByAR4sVZbgi4ERZZSlBkh5VZc2fkre0yun+hiJBWR2F/NWm+
 mQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967844; x=1778572644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWQ5sqXfuI7IaCZ7L9BfQyKyaRqZ4DEsEDqyslmJDKA=;
 b=SwwuAxpP8sd8mW23L/+cb41tAGcwOBiE9w5F4klcTnFu44vjiX6T8lBtODQAmgFmOP
 vQiHxShzy14CWK5XGoCIR5Q8MtQorvQItVfsnrQZjIxYYdiM9TccXuA3b2Z8yU0HdKWi
 34lywywNAEg74+jyvPum42h5Vr66is4q4gvKTkDvOu8Z3EfDq6Mw7oJ+PmxqoV3xZ5qM
 DF3ze19pHDw8VvcgK7b9AGQlAFrjPWe9AYhG9D3YhYAht6m8v07yXr8lQ5KBTxP9GtJc
 COvSLrqtp03LRAFjzZ4JasQGQATX/dWjxhJkzWRQXEkCk8+yBYTtKEltK/AhL4wZAipE
 kkVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uJGIRS+AK/nUJSugtb7WSpkzr6hJTICEt71tdxyFa/FM388lv7eelpFzko3ym0i7+5/6DqHrKlkzW@nongnu.org
X-Gm-Message-State: AOJu0Yw/5HexF3CbYnh1IElXtpTngfwBxFpa3RyDyuuDlX3bf2+yY283
 NKP+0qd5W+wP/Lb9x4Qo5N0THvDZPtI5l6hxBA6lqn2hOv57t1tAjjKiRwvdndLUu0g=
X-Gm-Gg: AeBDies0Yhx6b1ZpMytXg/VjRWiXd2TwFGU0yKMFde6Wgwy/EJRlYk64Q27GUouYdxz
 Eb5gDPt2rRZSJBM89seLFS7+xf1DJXDuQpmBHYs93QKmW/xasrIZKfFQt0ue/L3ClgoasEgWvJk
 lD9apJLC8p0wzgkRzhmbcPV650t3HItgarpaQDtE5V8zgeUeLVjmvwGrMM7jgfrA6+PzFjlK97O
 6WQ6zuwC+cDfOU7Zx3DjkFdHkBractn1U5LLUuII5k2UpOlJ2BwocmV5QJEcLKgFiC5mRa0PPbS
 USit7C2nQWT71SCtrPF6XouV8h5VGrN/1jhch3XaDze1cZNprnX8I2htrLfLrmXaltqRJpoLCl2
 SN4VoY+wigHfBhxKC+sChu7/bDbh3lvF7YZ0RsOYK73/AKYM196b0+n9uCkP1i9BWpBMWZ4gg7B
 DXCgqgZIqJY/xhim94DY0l+f5kQtk2Swu13EOUxx6HgKRCdafb2OcJJAw3GsRMH01Z0w==
X-Received: by 2002:a05:600c:4506:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-48d187daac6mr28077645e9.10.1777967844035; 
 Tue, 05 May 2026 00:57:24 -0700 (PDT)
Received: from [10.115.35.66] (95.170.88.92.rev.sfr.net. [92.88.170.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f28sm645837565e9.13.2026.05.05.00.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 00:57:23 -0700 (PDT)
Message-ID: <972d8ddd-8ef9-4cd3-a7e5-90f00ec625ad@linaro.org>
Date: Tue, 5 May 2026 09:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260425131721.932250-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 25/4/26 15:17, Joel Stanley wrote:
> From: Chris Rauer <crauer@google.com>
> 
> In the past this model has been submitted for use with the arm virt
> machine, however in this case it will be used by the upcoming
> Tenstorrent Atlantis RISC-V machine.
> 
> This is a re-submission of the model with Chris' permission, with a
> light touch of updates to make it build with qemu master.
> 
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Chris Rauer <crauer@google.com>
> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> [jms: rebase and minor build fixes for class_init and reset callback]
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v4: Remove unused random header
> v2: Add trace event for read and write, document Alano and myself as
> reviewers.
> ---
>   MAINTAINERS                     |   8 +
>   include/hw/i2c/designware_i2c.h | 101 ++++
>   hw/i2c/designware_i2c.c         | 817 ++++++++++++++++++++++++++++++++
>   hw/i2c/Kconfig                  |   4 +
>   hw/i2c/meson.build              |   1 +
>   hw/i2c/trace-events             |   4 +
>   6 files changed, 935 insertions(+)
>   create mode 100644 include/hw/i2c/designware_i2c.h
>   create mode 100644 hw/i2c/designware_i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa4267b15806..e1942a86eba5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2716,6 +2716,14 @@ S: Orphan
>   F: hw/gpio/pcf8574.c
>   F: include/gpio/pcf8574.h
>   
> +DesignWare I2C
> +M: Chris Rauer <crauer@google.com>

This was 4 years ago. Is Chris still up to this?

> +R: Alano Song <alanosong@163.com>
> +R: Joel Stanley <joel@jms.id.au>
> +S: Maintained
> +F: hw/i2c/designware_i2c.c
> +F: include/hw/i2c/designware_i2c.h
> +
>   Generic Loader
>   M: Alistair Francis <alistair@alistair23.me>
>   S: Maintained
> diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
> new file mode 100644
> index 000000000000..0d8f904f51b7
> --- /dev/null
> +++ b/include/hw/i2c/designware_i2c.h


> +typedef struct DesignWareI2CState {
> +    SysBusDevice parent;

s/parent/parent_obj/

> +
> +    MemoryRegion iomem;
> +
> +    I2CBus      *bus;
> +    qemu_irq     irq;
> +
> +    uint32_t ic_con;
> +    uint32_t ic_tar;
> +    uint32_t ic_sar;
> +    uint32_t ic_ss_scl_hcnt;
> +    uint32_t ic_ss_scl_lcnt;
> +    uint32_t ic_fs_scl_hcnt;
> +    uint32_t ic_fs_scl_lcnt;
> +    uint32_t ic_intr_mask;
> +    uint32_t ic_raw_intr_stat;
> +    uint32_t ic_rx_tl;
> +    uint32_t ic_tx_tl;
> +    uint32_t ic_enable;
> +    uint32_t ic_status;
> +    uint32_t ic_txflr;
> +    uint32_t ic_rxflr;
> +    uint32_t ic_sda_hold;
> +    uint32_t ic_tx_abrt_source;
> +    uint32_t ic_sda_setup;
> +    uint32_t ic_enable_status;
> +    uint32_t ic_fs_spklen;
> +    uint32_t ic_comp_param_1;
> +    uint32_t ic_comp_version;
> +    uint32_t ic_comp_type;
> +
> +    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
> +    uint8_t      rx_cur;
> +
> +    DesignWareI2CStatus status;
> +} DesignWareI2CState;


> +#endif /* DESIGNWARE_I2C_H */
> diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c


> +enum DesignWareI2CRegister {
> +    DW_IC_CON                   = 0x00,
> +    DW_IC_TAR                   = 0x04,

> +    DW_IC_ACK_GENERAL_CALL      = 0x98,
> +    DW_IC_ENABLE_STATUS         = 0x9c,
> +    DW_IC_FS_SPKLEN             = 0xa0,
> +    DW_IC_CLR_RESTART_DET       = 0xa8,
> +    DW_IC_COMP_PARAM_1          = 0xf4,
> +    DW_IC_COMP_VERSION          = 0xf8,
> +    DW_IC_COMP_TYPE             = 0xfc,
> +};


> +static void dw_i2c_write(void *opaque, hwaddr offset, uint64_t value,
> +                              unsigned size)
> +{
> +    DesignWareI2CState *s = opaque;
> +
> +    trace_dw_i2c_write(DEVICE(s)->canonical_path, offset, value);
> +
> +    /* The order of the registers are their order in memory. */
> +    switch (offset) {
> +    case DW_IC_CON:
> +        dw_i2c_write_ic_con(s, value);
> +        break;
> +    case DW_IC_TAR:
> +        s->ic_tar = value & DW_IC_TAR_MASK;
> +        break;
> +    case DW_IC_SAR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_sar\n",
> +                      DEVICE(s)->canonical_path);
> +        s->ic_sar = value & DW_IC_SAR_MASK;

Unsupported but updated...

> +        break;
> +    case DW_IC_DATA_CMD:
> +        dw_i2c_write_ic_data_cmd(s, value);
> +        break;
> +    case DW_IC_SS_SCL_HCNT:
> +        s->ic_ss_scl_hcnt = value & DW_IC_SS_SCL_HCNT_MASK;
> +        break;
> +    case DW_IC_SS_SCL_LCNT:
> +        s->ic_ss_scl_lcnt = value & DW_IC_SS_SCL_LCNT_MASK;
> +        break;
> +    case DW_IC_FS_SCL_HCNT:
> +        s->ic_fs_scl_hcnt = value & DW_IC_FS_SCL_HCNT_MASK;
> +        break;
> +    case DW_IC_FS_SCL_LCNT:
> +        s->ic_fs_scl_lcnt = value & DW_IC_FS_SCL_LCNT_MASK;
> +        break;
> +    case DW_IC_INTR_MASK:
> +        s->ic_intr_mask = value & DW_IC_INTR_MASK_MASK;
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_RX_TL:
> +        dw_i2c_write_ic_rx_tl(s, value);
> +        break;
> +    case DW_IC_TX_TL:
> +        dw_i2c_write_ic_tx_tl(s, value);
> +        break;
> +    case DW_IC_ENABLE:
> +        dw_i2c_write_ic_enable(s, value);
> +        break;
> +    case DW_IC_SDA_HOLD:
> +        s->ic_sda_hold = value & DW_IC_SDA_HOLD_MASK;
> +        break;
> +    case DW_IC_SLV_DATA_NACK_ONLY:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unsupported write - ic_slv_data_nack_only\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_CR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_cr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_TDLR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_tdlr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_RDLR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_rdlr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_SDA_SETUP:
> +        s->ic_sda_setup = value & DW_IC_SDA_SETUP_MASK;
> +        break;
> +    case DW_IC_ACK_GENERAL_CALL:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unsupported write - ic_ack_general_call\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_FS_SPKLEN:
> +        s->ic_fs_spklen = value & DW_IC_FS_SPKLEN_MASK;
> +        break;
> +
> +    /* This register is invalid at this point. */
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to invalid offset or readonly register 0x%"
> +                      HWADDR_PRIx "\n",
> +                      DEVICE(s)->canonical_path, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps designware_i2c_ops = {
> +    .read = dw_i2c_read,
> +    .write = dw_i2c_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

.impl = { 4, 4 }

> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void designware_i2c_enter_reset(Object *obj, ResetType type)
> +{
> +    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
> +
> +    s->ic_con = DW_IC_CON_INIT_VAL;
> +    s->ic_tar = DW_IC_TAR_INIT_VAL;
> +    s->ic_sar = DW_IC_SAR_INIT_VAL;
> +    s->ic_ss_scl_hcnt = DW_IC_SS_SCL_HCNT_INIT_VAL;
> +    s->ic_ss_scl_lcnt = DW_IC_SS_SCL_LCNT_INIT_VAL;
> +    s->ic_fs_scl_hcnt = DW_IC_FS_SCL_HCNT_INIT_VAL;
> +    s->ic_fs_scl_lcnt = DW_IC_FS_SCL_LCNT_INIT_VAL;
> +    s->ic_intr_mask = DW_IC_INTR_MASK_INIT_VAL;
> +    s->ic_raw_intr_stat = 0;
> +    s->ic_rx_tl = 0;
> +    s->ic_tx_tl = 0;
> +    s->ic_enable = 0;
> +    s->ic_status = DW_IC_STATUS_INIT_VAL;
> +    s->ic_txflr = 0;
> +    s->ic_rxflr = 0;
> +    s->ic_sda_hold = DW_IC_SDA_HOLD_INIT_VAL;
> +    s->ic_tx_abrt_source = 0;
> +    s->ic_sda_setup = DW_IC_SDA_SETUP_INIT_VAL;
> +    s->ic_enable_status = 0;
> +    s->ic_fs_spklen = DW_IC_FS_SPKLEN_INIT_VAL;

> +    s->ic_comp_param_1 = DW_IC_COMP_PARAM_1_INIT_VAL;
> +    s->ic_comp_version = DW_IC_COMP_VERSION_INIT_VAL;
> +    s->ic_comp_type = DW_IC_COMP_TYPE_INIT_VAL;

Preferably initialize the IC_COMP registers once in the
designware_i2c_realize() handler.

> +    s->rx_cur = 0;
> +    s->status = DW_I2C_STATUS_IDLE;
> +}
> +
> +static void designware_i2c_hold_reset(Object *obj, ResetType type)
> +{
> +    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
> +
> +    qemu_irq_lower(s->irq);
> +}
> +
> +static const VMStateDescription vmstate_designware_i2c = {
> +    .name = TYPE_DESIGNWARE_I2C,
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {

const!

> +        VMSTATE_UINT32(ic_con, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_tar, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_sar, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_ss_scl_hcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_ss_scl_lcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_fs_scl_hcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_fs_scl_lcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_intr_mask, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_raw_intr_stat, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_rx_tl, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_tx_tl, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_enable, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_status, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_txflr, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_rxflr, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_sda_hold, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_tx_abrt_source, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_sda_setup, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_enable_status, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_fs_spklen, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_comp_param_1, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_comp_version, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_comp_type, DesignWareI2CState),
> +        VMSTATE_UINT32(status, DesignWareI2CState),
> +        VMSTATE_UINT8_ARRAY(rx_fifo, DesignWareI2CState,
> +                        DESIGNWARE_I2C_RX_FIFO_SIZE),
> +        VMSTATE_UINT8(rx_cur, DesignWareI2CState),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
 > +static void designware_i2c_smbus_init(Object *obj)
 > +{
 > +    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
 > +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 > +
 > +    sysbus_init_irq(sbd, &s->irq);
 > +
 > +    memory_region_init_io(&s->iomem, obj, &designware_i2c_ops, s,
 > +                          "regs", 4 * KiB);

I note the current registers only describe a 1KiB region.

 > +    sysbus_init_mmio(sbd, &s->iomem);
 > +
 > +    s->bus = i2c_init_bus(DEVICE(s), "i2c-bus");
 > +}
 > +
> +static void designware_i2c_class_init(ObjectClass *klass, const void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Designware I2C";
> +    dc->vmsd = &vmstate_designware_i2c;
> +    rc->phases.enter = designware_i2c_enter_reset;
> +    rc->phases.hold = designware_i2c_hold_reset;

        set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);

> +}
Since I couldn't look at the datasheet values, for overall modelling:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


