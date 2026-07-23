Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2B1C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqbm-0005bD-I6; Thu, 23 Jul 2026 06:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmqbl-0005b4-7G
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:24:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmqbi-0005Wa-Qj
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:24:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47362928f65so434774f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784802287; x=1785407087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O42YCXBICnrvIBNhHjduTWwmjJGiTgTKUzI2XeKS/O8=;
 b=Wt3WNscCsQgmYFfcfmsFwl9fg8dldftmEKqStmkTV2qYs6ijBwdQVvkOwgeUz9+jZO
 8zFSB6k1mZyjaSTW8L1bBpTp6sbDDLjpMwgH8sANgFM6TyB68ZHxRgrqLqqIgaRkSmKu
 Y8crwYlb13IN7CZ6jhKSA6LIKCgLLgfTb2NcYnpaw1aPi38hr5D1TRXR9Jr/2FRxCHOJ
 DNqzxZilY8E7XZ+0G7hw6Tsst6QTmReKRcMprgQfbFhnwS829lVOw1dWSjRh3zMjlXXy
 6Qs9gsaVs5fUNZO5BZfqBHhem7FCBgjmoIeGiWUUD8XZoJoM0bSSdN+360FfVBr3xlxh
 J7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784802287; x=1785407087;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O42YCXBICnrvIBNhHjduTWwmjJGiTgTKUzI2XeKS/O8=;
 b=CM5AJx+uc2mlGfPZOTriNxXht77UYeAioSLOQtvHWlNVp09I+IKMhVWZmFuh2xOHZq
 Wz/wuZLIbetrH+jBq4ukEEXKHezITGwAPkmb/WmUmd0Fzrgwq2+SCqHnpH6LjAN6EL1Z
 kTMxCod1qrTN4qzaoxIFbuG0q5KZ1KBgkPnaO58Fyf2hVR+aynoeW7qiYvEsAb9+YpDu
 GS5GXijsyIUsW3MQ/QafHHeN3rumaOp7ih77X5D5vJd1rdZQM7VxVM9llHJph4pPIPJT
 y2oUgvk4XpT3ndBJl/21TyeoR2gRIXDl2nIf1ggncZLMtd180eFF1hkVOyvPv8iIIUjI
 lP4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiwHA1R3Dai5gD0xdyoWJvQd5MyOwDI/fsNhj6hLRQ6nMcC+tFnKgV+XakOGckfwowmWTgWKBUl2gX@nongnu.org
X-Gm-Message-State: AOJu0YxgCLhIOwngQI1YuzbPF/UE63NmkDca1oSChusFXZv9o9tUBuRC
 FKaXjyh/KoxHiH7IG/k7csSTNNeV1QwZHB+utQBL2SFMgbilwF6Bck30
X-Gm-Gg: AR+sD11DaqfLIX88J5unn/JFmW+ERQT38nxw8KsbjPds/dUcCwE+OWJn13fUJS/Ls9K
 vWFKeHvVDc0hMJCPlPjJrtfXv+5wov3RVn/TilmdjI3pDQ0p0JwSJd6cXpOfcsc6S3DqhXTxHhO
 ADIrQU4pFXoNueEexhyI9yeQvFCrfu9Zt6s2gCP8IVL1G3+fzw1uDU7siSXogTDTXivCIZXvhJi
 b3sJ514DEqW5WHO2mOEppGlbH84FH24Cc11FzEnrQ1QzdYp8f8j/Jnip2Af3rxizgVm+1aiNspI
 vBflBcfFbCl8vn10Idt/thfub5bZ3FPBH18eoJXFthFj/9zgZUGjb/D4BB2jjembiOqk7sfJ5nt
 b8me/aBlEFfERkzg9AqH3GGGbBXsbWURYoY4LceMzi+Smrj+BNwN/k3Mc9CnRDvvyD3a/1Ef5da
 n2FVWQXsPR
X-Received: by 2002:a05:6000:29d3:b0:47f:901b:5835 with SMTP id
 ffacd0b85a97d-47f901b6874mr1757792f8f.10.1784802287229; 
 Thu, 23 Jul 2026 03:24:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd850asm14078142f8f.15.2026.07.23.03.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 03:24:46 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:24:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
CC: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 Pavel Pisa <pisa@fel.cvut.cz>
Subject: Re: [PULL 34/54] hw/net/can/flexcan: NXP FlexCAN core emulation
In-Reply-To: <CAFEAcA-QBiPfgN4YJXD9FQULobpBVNgeJHSqG7Eqg1CzyKTfaA@mail.gmail.com>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
 <20260629120032.1645265-35-peter.maydell@linaro.org>
 <CAFEAcA-QBiPfgN4YJXD9FQULobpBVNgeJHSqG7Eqg1CzyKTfaA@mail.gmail.com>
Message-ID: <91E2488B-937B-46C1-A009-574B93652D4C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 3=2E Juli 2026 11:34:29 UTC schrieb Peter Maydell <peter=2Emaydell@lina=
ro=2Eorg>:
>On Mon, 29 Jun 2026 at 13:01, Peter Maydell <peter=2Emaydell@linaro=2Eorg=
> wrote:
>>
>> From: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>>
>> Added the FlexCAN2 emulator implementation core, with
>> CAN_FLEXCAN Kconfig flag and MAINTAINERS entry=2E
>>
>> FlexCAN2 version can be found in i=2EMX6 SoCs and others=2E
>>
>> More information about the implementation can be found in [1]=2E
>>
>> Some macro and struct defintions were borrowed from the Linux kernel=2E
>> The original authors agreed with relicensing them to GPL-2=2E0-or-later=
 on
>> the qemu-devel mailing list=2E
>>
>> [1] http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-=
Bobek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>>
>
>Hi; Coverity points out some issues with this change; details below=2E

Patches sent: https://lore=2Ekernel=2Eorg/qemu-devel/20260723070059=2E6332=
-1-shentey@gmail=2Ecom/

Best regards,
Bernhard

>
>
>> +/**
>> + * flexcan_fifo_pop() - Pop message from FIFO and update IRQs
>> + * @s: FlexCAN device pointer
>> + *
>> + * Does not require the queue to be non-empty=2E
>> + */
>> +static void flexcan_fifo_pop(FlexcanState *s)
>> +{
>> +    if (s->regs=2Efifo=2Emb_back=2Ecan_ctrl !=3D 0) {
>> +        /* move queue elements forward */
>> +        memmove(&s->regs=2Efifo=2Emb_back, &s->regs=2Efifo=2Embs_queue=
[0],
>> +                sizeof(s->regs=2Efifo=2Embs_queue));
>
>CID 1662971: Coverity doesn't like this because mb_back is
>only 1 element long and you're copying more than that=2E
>
>We seem to use these fields only in this function -- did we
>really need to specify them as two separate fields rather
>than one array so that it's a bit clearer that we're just
>copying within what is effectively a single 6 element array?
>
>> +
>> +        /* clear the first-in slot */
>> +        memset(&s->regs=2Embs[FLEXCAN_FIFO_DEPTH - 1], 0,
>> +               sizeof(FlexcanRegsMessageBuffer));
>> +
>> +        trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 1,
>> +                               s->regs=2Efifo=2Emb_back=2Ecan_ctrl !=
=3D 0);
>> +    } else {
>> +        trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 0, 0);
>> +    }
>> +
>> +    if (s->regs=2Efifo=2Emb_back=2Ecan_ctrl !=3D 0) {
>> +        flexcan_irq_iflag_set(s, I_FIFO_AVAILABLE);
>> +    } else {
>> +        flexcan_irq_iflag_clear(s, I_FIFO_AVAILABLE);
>> +    }
>> +}
>> +
>
>
>
>> +static enum FlexcanRx flexcan_mb_rx(FlexcanState *s, const qemu_can_fr=
ame *buf)
>> +{
>> +    int last_not_free_to_receive_mbid =3D -1;
>
>CID 1662790:
>
>Initially last_not_free_to_receive_mbid is -1=2E
>
>> +    bool last_not_free_to_receive_locked =3D false;
>> +
>> +    FlexcanRegsMessageBuffer *first_mb =3D flexcan_get_first_message_b=
uffer(s);
>> +    FlexcanRegsMessageBuffer *last_mb =3D flexcan_get_last_enabled_mai=
lbox(s);
>> +
>> +    for (FlexcanRegsMessageBuffer *mb =3D first_mb;
>> +         mb <=3D last_mb; mb++) {
>> +        int mbid =3D mb - s->regs=2Embs;
>
>In this loop mbid must always be positive, because the bounds on mb
>mean it's always somewhere inside the s->regs=2Embs array=2E
>
>> +        enum FlexcanCheck r =3D flexcan_mb_rx_check_mb(s, buf, mbid);
>> +        if (r =3D=3D FLEXCAN_CHECK_MB_MATCH) {
>> +            flexcan_mb_move_in(s, buf, mb);
>> +            flexcan_irq_iflag_set(s, mbid);
>> +            return FLEXCAN_RX_SEARCH_ACCEPT;
>> +        }
>> +
>> +        if (r =3D=3D FLEXCAN_CHECK_MB_MATCH_NON_FREE) {
>> +            last_not_free_to_receive_mbid =3D mbid;
>> +            last_not_free_to_receive_locked =3D false;
>> +        } else if (r =3D=3D FLEXCAN_CHECK_MB_MATCH_LOCKED) {
>> +            /*
>> +             * message buffer is locked,
>> +             * we can move in the message after it's unlocked
>> +             */
>> +            last_not_free_to_receive_mbid =3D mbid;
>> +            last_not_free_to_receive_locked =3D true;
>> +        }
>
>In the loop body the only places where we assign to
>last_not_free_to_receive_mbid are where we set it to mbid=2E
>
>> +    }
>> +
>> +    if (last_not_free_to_receive_mbid >=3D -1) {
>
>So when can this condition be false ?
>
>> +        if (last_not_free_to_receive_locked) {
>> +            /*
>> +             * copy to temporary mailbox (SMB)
>> +             * it will be moved in when the mailbox is unlocked
>> +             */
>> +            s->regs=2Erx_smb0=2Ecan_ctrl =3D
>> +                s->regs=2Embs[last_not_free_to_receive_mbid]=2Ecan_id;
>> +            flexcan_mb_move_in(s, buf, &s->regs=2Erx_smb0);
>> +            s->smb_target_mbidx =3D last_not_free_to_receive_mbid;
>> +            return FLEXCAN_RX_SEARCH_ACCEPT;
>> +        }
>> +
>> +        if (s->regs=2Emcr & FLEXCAN_MCR_IRMQ) {
>> +            flexcan_mb_move_in(s, buf,
>> +                               &s->regs=2Embs[last_not_free_to_receive=
_mbid]);
>
>Here we use last_not_free_to_receive_mbid as an index into mbs,
>but it could be -1, which will underrun the array=2E
>
>Should the condition above have been ">=3D 0" ?
>
>> +            flexcan_irq_iflag_set(s, last_not_free_to_receive_mbid);
>> +            return FLEXCAN_RX_SEARCH_ACCEPT;
>> +        }
>> +    }
>
>> +
>> +    return FLEXCAN_RX_SEARCH_RETRY;
>> +}
>
>
>
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D I/O handling =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
>> +static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
>> +                              unsigned size)
>> +{
>> +    FlexcanState *s =3D opaque;
>> +    uint32_t write_mask =3D ((const uint32_t *)
>> +        &flexcan_regs_write_mask)[addr / 4];
>> +    uint32_t old_value =3D s->regs_raw[addr / 4];
>> +
>> +    /*
>> +     * 0 for bits that can "only be written in Freeze mode as it is bl=
ocked
>> +     * by hardware in other modes"
>> +     */
>> +    const uint32_t freeze_mask_mcr =3D 0xDF54CC80;
>> +    const uint32_t freeze_mask_ctrl1 =3D 0x0000E740;
>> +
>> +    flexcan_trace_mem_op(s, addr, val, size, true);
>> +    switch (addr) {
>> +    case offsetof(FlexcanRegs, mcr):
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +            write_mask &=3D freeze_mask_mcr;
>> +        }
>> +        s->regs=2Emcr =3D (val & write_mask) | (old_value & ~write_mas=
k);
>> +        flexcan_set_mcr(s, old_value);
>> +        break;
>> +    case offsetof(FlexcanRegs, ctrl):
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +            write_mask &=3D freeze_mask_ctrl1;
>> +        }
>> +        s->regs=2Ectrl =3D (val & write_mask) | (old_value & ~write_ma=
sk);
>> +        break;
>> +    case offsetof(FlexcanRegs, iflag1):
>> +        s->regs=2Eiflag1 &=3D ~val;
>> +        if ((s->regs=2Emcr & FLEXCAN_MCR_FEN) &&
>> +            (val & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)) {
>> +            flexcan_fifo_pop(s);
>> +        }
>> +        break;
>> +    case offsetof(FlexcanRegs, iflag2):
>> +        s->regs=2Eiflag2 &=3D ~val;
>> +        break;
>> +    case offsetof(FlexcanRegs, ctrl2):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, ecr):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rxmgmask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rx14mask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rx15mask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rxfgmask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rximr[0]) =2E=2E=2E offsetof(FlexcanReg=
s, rximr[63]):
>> +        /* these registers can only be written in freeze mode */
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +            break;
>> +        }
>> +        QEMU_FALLTHROUGH;
>> +    default:
>> +        s->regs_raw[addr / 4] =3D (val & write_mask) | (old_value & ~w=
rite_mask);
>> +
>> +        if (addr >=3D offsetof(FlexcanRegs, mb) &&
>> +            addr < offsetof(FlexcanRegs, _reserved4)) {
>> +            /* access to mailbox */
>> +            int mbid =3D (addr - offsetof(FlexcanRegs, mb)) /
>> +                            sizeof(FlexcanRegsMessageBuffer);
>
>CID 1662974: This bounds check isn't sufficient to ensure that
>mbid is within the bounds of s->regs=2Embs[], which flexcan_mb_write()
>will access=2E This is the same as 1662975 below; see that for detail=2E
>
>> +
>> +            if (s->locked_mbidx =3D=3D mbid) {
>> +                flexcan_mb_unlock(s);
>> +            }
>> +
>> +            /* check for invalid writes into FIFO region */
>> +            if (s->regs=2Emcr & FLEXCAN_MCR_FEN && mbid < FLEXCAN_FIFO=
_DEPTH) {
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "%s: Invalid write to Rx-FIFO structure"=
,
>> +                              DEVICE(s)->canonical_path);
>> +                return;
>> +            }
>> +
>> +            /* run mailbox processing function on write to control wor=
d */
>> +            if ((addr & 0xF) =3D=3D 0) {
>> +                flexcan_mb_write(s, mbid);
>> +            }
>> +        }
>> +        break;
>> +    }
>> +
>> +    flexcan_irq_update(s);
>> +}
>> +
>> +static uint64_t flexcan_mem_read(void *opqaue, hwaddr addr, unsigned s=
ize)
>> +{
>> +    FlexcanState *s =3D opqaue;
>> +    uint32_t rv =3D s->regs_raw[addr >> 2];
>> +
>> +    if (addr >=3D offsetof(FlexcanRegs, mb) &&
>> +        addr < offsetof(FlexcanRegs, _reserved4)) {
>> +        /* reading from mailbox */
>> +        hwaddr offset =3D addr - offsetof(FlexcanRegs, mb);
>> +        int mbid =3D offset / sizeof(FlexcanRegsMessageBuffer);
>> +
>> +        if (addr % 16 =3D=3D 0 && s->locked_mbidx !=3D mbid) {
>> +            /* reading control word locks the mailbox */
>> +            flexcan_mb_unlock(s);
>> +            flexcan_mb_lock(s, mbid);
>> +            flexcan_irq_update(s);
>> +            rv =3D s->regs=2Embs[mbid]=2Ecan_ctrl & ~FLEXCAN_MB_CNT_NO=
T_SRV;
>
>CID 1662972, 1662975:
>
>Here we guard the bounds on addr based on the struct layout,
>where the relevant part is:
>
>    union {                      /* 0x80 - not affected by soft reset */
>        uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_CO=
UNT];
>        FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
>        FlexcanRegsRXFifo fifo;
>    };
>    uint32_t _reserved4[256];    /* 0x480 */
>
>So we know that 'addr' is inside the union=2E However, 'mbs' is
>not the smallest member of the union, because 'mbs' is 64 * 16 =3D=3D 102=
4
>bytes, but mb is 64 * 16 * 4 =3D=3D 14436 bytes, and fifo is
>(6 * 16 + 128 * 4) =3D=3D 608 bytes=2E So because we only bounded
>'mbid' based on the total size of the union, it can be larger
>than the size of the mb[] array=2E
>
>What is the intention here?
>
>As an aside, using unions like this is rather error-prone, because
>it is an easy way to introduce endianness bugs=2E This one happens to
>work because all the fields in all the sub-structs end up being
>uint32_t, but for instance if there was a uint16_t field in there
>somewhere that would be an endianness bug=2E
>
>
>> +
>> +    } else if (addr =3D=3D offsetof(FlexcanRegs, timer)) {
>> +        flexcan_mb_unlock(s);
>> +        flexcan_irq_update(s);
>> +        rv =3D flexcan_get_timestamp(s, false);
>> +    }
>> +
>> +    flexcan_trace_mem_op(s, addr, rv, size, false);
>> +    return rv;
>> +}
>
>
>
>> +#define FLEXCAN_GENMASK(h, l) (((~(uint32_t)0) >> (31 - (h) + (l))) <<=
 (l))
>
>Please don't roll your own mask creation macros=2E We have
>MAKE_64BIT_MASK() in bitops=2Eh=2E
>
>> +/* FLEXCAN CRC Register (CRCR) bits */
>> +#define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
>> +#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MAS=
K) << 16)
>
>CID 1662973: FLEXCAN_CRCR_MBCRC_MASK is 0x7F0000=2E That means
>that (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16) will always be 0,
>because the field gets shifted off the top of the 32-bit type=2E
>
>I suspect you meant here
>(((x) << 16) & FLEXCAN_CRCR_MBCRC_MASK)
>
>The standard QEMU FIELD macros let you use FIELD_DP32() which
>avoids this kind of bug entirely=2E
>
>thanks
>-- PMM

