Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A97C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztBE-0000G9-0G; Fri, 28 Aug 2026 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wztBC-0000Fs-HP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wztB9-0002VB-M2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787910438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qm7YizpKPZpv7PCuyBgXL6ZHDWQBYClCWWtnxZlCtkE=;
 b=WpJCc4ZNjjmJjPJhqSi5gmw1whF0i5A5RAntedhnXBAvG93Ysp7zm6cpKK3g3kNN6ZdkM2
 VibabX3qnM8aYOfEavToineFilq+4lgWFNUmbhYO4fVfm74ZCs7Lrbt/TWyuKZG5hk+5CM
 j2hNOsI8gXkf+Q/+QODXC1o3qZfS4pc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-E1etsLRfMdqZXm2vkv8hQQ-1; Fri, 28 Aug 2026 05:47:17 -0400
X-MC-Unique: E1etsLRfMdqZXm2vkv8hQQ-1
X-Mimecast-MFC-AGG-ID: E1etsLRfMdqZXm2vkv8hQQ_1787910436
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b7c1dc61eso5014005e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 02:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787910436; x=1788515236;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qm7YizpKPZpv7PCuyBgXL6ZHDWQBYClCWWtnxZlCtkE=;
 b=FCkSFQ2hgeR4uf8jOYIFA2UMyhODXOF2mI2ffOmjVKiBk3OFdC5g4DWD4UZ/++VRyd
 uMeZHFkaF+TW5BYAofjuSIbIEKyXK6aSI7BFsmYsveeaGMoZBBBt/yrHU43cGSUUmOuX
 hRAwWXCnYRUvQZXJvu3Py9EGbKOFFtuKhuA1wRcwuhzq8SO+pSJ998F01Vqtcr8ZnAaZ
 hCBVl+MD3eQPKh4kdI4RpZOxRvU53cOLaezdfV77eW5qYeZlp9l4GJxT/a8bkVs3qkNw
 v0Jbu5JmvL21TMCfthasH2XlUD6JjYwxyxnyH4qLG4usVH5kxi//n1/1XCotlK2+MtQo
 OCgA==
X-Gm-Message-State: AFuF++klEtjd3JzZMi5FkNOvWm0yajcQNABYQwqkwjEGI6u8ktqkRWtU
 ggYZqo+/mGYm71Tadk1LGsOnyEhBYvraGnd5iwTfotXT9hIa3YdFX9AEd0NNjSUGUVodBk4mggC
 8eGJD7OobP4l0aMrGk4JQxIGKLCxhFavkxR1ENGyS48l1VLK7uYDCfBMk
X-Gm-Gg: AR+sD11VuZAsTvHrFRREhJcJEhHS8qCXf8s4JrB95Djl5Nl7We1CFgbIfeQ2w69KR5Z
 KVx2RjltXRF2MhVqpADLIWI8/o6Ezhfj5IZ4zhSsgN8dXkRPGyAYhu1gsDxWUIvOhdmmEsUhA7Q
 NQcw4/1DhS83BtkV5FZNCGf5RN7gDfJWtYTCjptZqam3xTnpXIXPSGaiFxhSJEWl/EcRoeNy4Ex
 qMeiYJMmmHGNTW8dOV3HJrcEARkmcwspDVudP2vDZaA8++LSuLN5BaWhNwAy+7GcjhhaZn8YhvR
 brr6QwBKsQrWkeAy4/A92a7GCgMU+8udWNawLqRRERuquLxOJWj6ZuOhFrz0eGjmrNf+FBtAZvq
 hTA/3I3PI36OLOgyhrWYcnRGEwlyVXMQkYyEsy5fTR+FbMQqm
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49b91c2e145mr81879395e9.1.1787910435804; 
 Fri, 28 Aug 2026 02:47:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49b91c2e145mr81878285e9.1.1787910435193; 
 Fri, 28 Aug 2026 02:47:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266d45esm28298695e9.2.2026.08.28.02.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 02:47:14 -0700 (PDT)
Message-ID: <7b5f99bb-891f-4184-9278-207664b02fb0@redhat.com>
Date: Fri, 28 Aug 2026 11:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 16/28] hw/arm/smmuv3: Add access checks for
 GERROR_IRQ_CFG registers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162558.2808607-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 8/13/26 6:25 PM, Tao Tang wrote:
Please directly explain what is the problem we want to fix before what
is actually done in the patch.

Spec says: "SMMU_GERROR_IRQ_CFG0 is Guarded by
SMMU_IRQ_CTRL.GERROR_IRQEN and must only be modified
when SMMU_IRQ_CTRL.GERROR_IRQEN == 0." This check is currently not
performed 

In SMMUv3.2 and later, a write while SMMU_IRQ_CTRL.GERROR_IRQEN == 1 is
IGNORED.
Accesses to this register use the following encodings:
Accessible at offset 0x0068 from SMMUv3_PAGE_0
• When SMMU_IRQ_CTRL.GERROR_IRQEN == 0 and SMMU_IRQ_CTRLACK.GERROR_IRQEN
== 0,
accesses to this register are RW.
• Otherwise, accesses to this register are RO.
"

By the way you are not checking  SMMU_IRQ_CTRLACK.GERROR_IRQEN

Nevertheless our emulation does not support MSI, right? So why don't we
hardcode this behavior on SMMU_GERROR_IRQ_CFG0 access, ie.

"This register is present only when SMMU_IDR0.MSI == 1.
SMMU_GERROR_IRQ_CFG0 are RES 0."

That would be simpler.
> Add helpers that separate IRQ_CFG register presence from the runtime
> IRQ enable guard. The Non-secure and Secure GERROR_IRQ_CFG register sets
> both use SMMU_IDR0.MSI for presence, while writability additionally
> requires GERROR_IRQEN to be clear. IRQ_CTRL and IRQ_CTRLACK share one
> synchronous backing field in the current model.
>
> Reads return RES0 when the register set is absent. Writes are ignored
> when it is absent or GERROR_IRQEN is set. Apply the same checks to all
> three GERROR_IRQ_CFG registers and mask reserved bits in CFG0 and CFG2.
>
> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
above is enought I think
> Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 47f0d575817..628911d3f21 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1428,6 +1428,62 @@ smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
>      return true;
>  }
>  
> +/* Check whether the selected IRQ_CFG register set is present. */
Remove the final "."
Besides worth to add, check if MSI are supported. Even I would rather
rename the helper to reflect what is pratcically does, even if your
eventual interest is to know if SMMU_PRIQ_IRQ_CFGn and
SMMU_GERROR_IRQ_CFGn are not RES 0. By the way IRQ_CFG is always present
;-)
> +static bool smmu_irq_cfg_present(SMMUv3State *s, SMMUSecSID sec_sid,
> +                                 SMMUIrq irq)
> +{
> +    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> +
> +    switch (irq) {
> +    case SMMU_IRQ_GERROR:
> +        switch (sec_sid) {
> +        case SMMU_SEC_SID_NS:
> +        case SMMU_SEC_SID_S:
> +            return FIELD_EX32(bank->idr[0], IDR0, MSI);
> +        case SMMU_SEC_SID_NUM:
> +            g_assert_not_reached();
> +        }
> +        break;
> +    case SMMU_IRQ_EVTQ:
why do you pass irq if everything besides 

SMMU_IRQ_GERROR is unexpected?

> +    case SMMU_IRQ_PRIQ:
> +    case SMMU_IRQ_CMD_SYNC:
> +        g_assert_not_reached();
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +/* Check whether the selected IRQ_CFG register set is writable. */
> +static bool smmu_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid,
> +                                  SMMUIrq irq)
> +{
> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
> +    uint32_t irqen;
> +
> +    if (!smmu_irq_cfg_present(s, sec_sid, irq)) {
> +        return false;
> +    }
> +
> +    switch (irq) {
> +    case SMMU_IRQ_GERROR:
> +        irqen = FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
again the name of the helper does not reflect what it does. 
GERROR_IRQENMeaning
0b0 interrupts are disabled.
0b1 Interrupts are enabled.
> +        break;
> +    case SMMU_IRQ_EVTQ:
> +    case SMMU_IRQ_PRIQ:
> +    case SMMU_IRQ_CMD_SYNC:
> +        g_assert_not_reached();
> +    }
> +
> +    /* IRQ_CTRL and IRQ_CTRLACK share one synchronous backing field. */
> +    return irqen == 0;
> +}
> +
> +static bool
> +smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_GERROR);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1735,7 +1791,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>  
>      switch (offset) {
>      case A_GERROR_IRQ_CFG0:
> -        bank->gerror_irq_cfg0 = data;
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
> +                         "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->gerror_irq_cfg0 = data & SMMU_GERROR_IRQ_CFG0_RESERVED;
>          return MEMTX_OK;
>      case A_STRTAB_BASE:
>          bank->strtab_base = data;
> @@ -1803,16 +1866,42 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>          break;
>      case A_GERROR_IRQ_CFG0: /* 64b */
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_GERROR_IRQ_CFG0_RESERVED;
>          bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
>          break;
>      case A_GERROR_IRQ_CFG0 + 4:
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 + 4 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_GERROR_IRQ_CFG0_RESERVED >> 32;
>          bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 32, 32, data);
>          break;
>      case A_GERROR_IRQ_CFG1:
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG1 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->gerror_irq_cfg1 = data;
>          break;
>      case A_GERROR_IRQ_CFG2:
> -        bank->gerror_irq_cfg2 = data;
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG2 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->gerror_irq_cfg2 = data & SMMU_GERROR_IRQ_CFG2_RESERVED;
>          break;
>      case A_GBPA:
>          /*
> @@ -1938,6 +2027,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>  
>      switch (offset) {
>      case A_GERROR_IRQ_CFG0:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = bank->gerror_irq_cfg0;
>          return MEMTX_OK;
>      case A_STRTAB_BASE:
> @@ -2006,15 +2100,35 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>          *data = bank->gerrorn;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0: /* 64b */
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = extract64(bank->gerror_irq_cfg0, 0, 32);
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0 + 4:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = extract64(bank->gerror_irq_cfg0, 32, 32);
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG1:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = bank->gerror_irq_cfg1;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG2:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = bank->gerror_irq_cfg2;
>          return MEMTX_OK;
>      case A_STRTAB_BASE: /* 64b */
Thanks

Eric


