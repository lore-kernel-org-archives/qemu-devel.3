Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED0C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztWo-0007A9-PV; Fri, 28 Aug 2026 06:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wztWn-00079m-GM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wztWk-0000BE-Pd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787911777;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8fXNbijNwbJ3nLkjlgjsidmvEDZ60hxI0dxtITUvjk=;
 b=Zs8a6vEpnDYQynYcn34Ij82Mf6D1LOuSmkgkt1EdP6lVLTvVYu78u5dkDTyrbRLJGZJKFs
 C5YbI35t22DGg6qN4MLTFKKHyhKUrITIecW7NCLnBRSHy9kw5eSAvVY1Cqzktq+Vbk5zEG
 pnkpJytCyRuW1WjvWBcYN7gMQRlMcis=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-AxF5Tvb4O7uGzlRbcQrMfw-1; Fri, 28 Aug 2026 06:09:35 -0400
X-MC-Unique: AxF5Tvb4O7uGzlRbcQrMfw-1
X-Mimecast-MFC-AGG-ID: AxF5Tvb4O7uGzlRbcQrMfw_1787911774
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4997b060af8so4576465e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911774; x=1788516574;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z8fXNbijNwbJ3nLkjlgjsidmvEDZ60hxI0dxtITUvjk=;
 b=nv7LWcfJmRd5AfyW0CbyRwRTqbpc6FmV/o0+hKZFa5IWUuSZH8y8POn/kTIf/EXaSA
 eT3YVrNfsfd4JYNwHzgun+L087OIFNkmhk8ljJpIso0P6XDboKe6eZUMt5gzUjayTnlD
 BcZBk6eEVHTkcaFp98aUh6JZGT9zg6meuBGYGyFyzFbbmtTV92ZmDK65R8JyXYDkT29t
 2HdTstyTI33iRM9qWJJISm1v6hMEFsp2+rQ2JgFi+ylCYoztLEy+tTM8wE1CFae0tsBq
 eJD/Qhpfz5NVzKsGNArJqrOSfv6ZgIqZOcjIsBLBY+zdsE0sZU/lcFUSl7fhiDGrX4XY
 IvUA==
X-Gm-Message-State: AFuF++mOks8qKoRAj88RK/G+PvSAsAcLpx5vEULQ/aKhkyX8Iwqp9NnE
 JXkl+fIbLjsTCqGFeXwEoO8dXnD05irwvyVUYLvntvW2JPwa0mQVNTGFVcLQmnZ21hVZUlJO2ct
 GxOEMFu/gjyKBbyvXp5+EjdycWFiGPN4UtTOkQ9UI+qOGWN6sz7G47QBH
X-Gm-Gg: AR+sD12JsFry7LnQs6vtHaLvN1DG+eUHo5NSD4IZRDSAJmfZ8AhOumKuY3I71+vzltW
 q3laVYAny3UKV5cjTYQq5d2or9YG6b6fBFnW25OyicwFIKaoKR8BUUgt2eFKEJHEHpi1f1oLG9k
 r54koh2tIyoZvcnFBVVC43HErtW7y/WH+M0nBLUuNLnFBxjAFkukmbwvw2B9fNP88Mh6RdgIsBI
 GDJ7ekHAmguRRfGJwKlJOo6dBZGNehv21tzey7Gd5DcK9Cy0QtYogTjAwrnWZK9eRyq2k7QJZ3H
 MOgjethC6AyQ0fObvoicqS6ioDwB/LUf7JPusrljLTUCz9OeEpBQOr5HE98ItcNTquelBFyQMtL
 GC84flDfJJLyJr/0gQe6gTzzb7QyT8hiKvO9eRC1xXpZ6nasN
X-Received: by 2002:a05:600c:c170:b0:499:afe2:e4d0 with SMTP id
 5b1f17b1804b1-49b91c2930dmr89397295e9.8.1787911774037; 
 Fri, 28 Aug 2026 03:09:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c170:b0:499:afe2:e4d0 with SMTP id
 5b1f17b1804b1-49b91c2930dmr89396825e9.8.1787911773661; 
 Fri, 28 Aug 2026 03:09:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f45sm4506009f8f.7.2026.08.28.03.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:09:32 -0700 (PDT)
Message-ID: <72f6a745-1a31-4bc6-887f-a79c72669cfe@redhat.com>
Date: Fri, 28 Aug 2026 12:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 18/28] hw/arm/smmuv3: Add access checks for CMDQ and
 EVENTQ registers
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
 <20260813162558.2808607-3-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162558.2808607-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/13/26 6:25 PM, Tao Tang wrote:
> Add access control for command queue and event queue related registers
> to ensure they can only be modified under proper conditions.

please explain what is wrong first
>
> For command queue (CMDQ):
> - smmu_cmdq_disabled_stable(): checks CMDQ bit in CR0/CR0ACK
always assume CR0=CR0ACK?
> - smmu_cmdq_base_writable(): checks IDR1.QUEUES_PRESET==0 and CMDQ disabled
>
> For event queue (EVTQ):
> - smmu_eventq_disabled_stable(): checks EVTQ bit in CR0/CR0ACK
> - smmu_eventq_base_writable(): checks IDR1.QUEUES_PRESET==0 and EVTQ disabled
> - smmu_irq_cfg_present(): checks SMMU_IDR0.MSI for the Non-secure
>   EVENTQ_IRQ_CFG register set and SMMU_S_IDR0.MSI for the Secure set
can't you simply assume MSI is not supported?
> - smmu_eventq_irq_cfg_writable(): additionally checks EVENTQ_IRQEN
>
> Absent EVENTQ_IRQ_CFG registers read as RES0. Present registers retain
> their programmed values for readback. The helper remains keyed by
> SEC_SID so future Realm support can select SMMU_R_IDR0.MSI.
>
> Additionally, mask reserved bits on writes using SMMU_QUEUE_BASE_RESERVED
> for queue base registers and SMMU_EVENTQ_IRQ_CFG0_RESERVED for
> EVENTQ_IRQ_CFG0.
>
> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++--
210 changes lines -> Can't you split into 2a ll the more so the handling
is different from CMDQ and EVENTQ
>  1 file changed, 204 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index de8ca7cda48..efa78869251 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1432,19 +1432,29 @@ smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
>  static bool smmu_irq_cfg_present(SMMUv3State *s, SMMUSecSID sec_sid,
>                                   SMMUIrq irq)
>  {
> -    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
> +    SMMUv3RegBank *ns_bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
>  
>      switch (irq) {
>      case SMMU_IRQ_GERROR:
>          switch (sec_sid) {
>          case SMMU_SEC_SID_NS:
>          case SMMU_SEC_SID_S:
> -            return FIELD_EX32(bank->idr[0], IDR0, MSI);
> +            return FIELD_EX32(ns_bank->idr[0], IDR0, MSI);
>          case SMMU_SEC_SID_NUM:
>              g_assert_not_reached();
>          }
>          break;
>      case SMMU_IRQ_EVTQ:
> +        switch (sec_sid) {
> +        case SMMU_SEC_SID_NS:
> +            return FIELD_EX32(bank->idr[0], IDR0, MSI);
> +        case SMMU_SEC_SID_S:
> +            return FIELD_EX32(bank->idr[0], S_IDR0, MSI);
> +        case SMMU_SEC_SID_NUM:
> +            g_assert_not_reached();
> +        }
> +        break;
>      case SMMU_IRQ_PRIQ:
>      case SMMU_IRQ_CMD_SYNC:
>          g_assert_not_reached();
> @@ -1469,6 +1479,8 @@ static bool smmu_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid,
>          irqen = FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
>          break;
>      case SMMU_IRQ_EVTQ:
> +        irqen = FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
> +        break;
>      case SMMU_IRQ_PRIQ:
>      case SMMU_IRQ_CMD_SYNC:
>          g_assert_not_reached();
> @@ -1514,6 +1526,69 @@ static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>      return smmuv3_smmu_disabled_stable(s, sec_sid);
>  }
>  
> +static inline int smmuv3_get_cr0_cmdqen(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return FIELD_EX32(s->bank[sec_sid].cr[0], CR0, CMDQEN);
> +}
> +
> +static inline int smmuv3_get_cr0ack_cmdqen(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, CMDQEN);
> +}
> +
> +static inline int smmuv3_get_cr0_eventqen(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return FIELD_EX32(s->bank[sec_sid].cr[0], CR0, EVENTQEN);
> +}
> +
> +static inline int smmuv3_get_cr0ack_eventqen(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, EVENTQEN);
> +}
> +
> +/* Check if CMDQ is disabled in stable status */
> +static bool smmu_cmdq_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    int cr0_cmdqen = smmuv3_get_cr0_cmdqen(s, sec_sid);
> +    int cr0ack_cmdqen = smmuv3_get_cr0ack_cmdqen(s, sec_sid);
> +    return (cr0_cmdqen == 0 && cr0ack_cmdqen == 0);
> +}
> +
> +/* Check if CMDQ_BASE register is writable */
> +static bool smmu_cmdq_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    /* SMMU_IDR1.QUEUES_PRESET applies to both modeled interfaces. */
> +    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, QUEUES_PRESET)) {
> +        return false;
> +    }
> +
> +    return smmu_cmdq_disabled_stable(s, sec_sid);
> +}
> +
> +/* Check if EVENTQ is disabled in stable status */
> +static bool smmu_eventq_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    int cr0_eventqen = smmuv3_get_cr0_eventqen(s, sec_sid);
> +    int cr0ack_eventqen = smmuv3_get_cr0ack_eventqen(s, sec_sid);
> +    return (cr0_eventqen == 0 && cr0ack_eventqen == 0);
> +}
> +
> +/* Check if EVENTQ_BASE register is writable */
> +static bool smmu_eventq_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, QUEUES_PRESET)) {
> +        return false;
> +    }
> +
> +    return smmu_eventq_disabled_stable(s, sec_sid);
> +}
> +
> +/* Check if EVENTQ_IRQ_CFGx is writable */
> +static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_EVTQ);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1841,21 +1916,39 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>          bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
>          return MEMTX_OK;
>      case A_CMDQ_BASE:
> -        bank->cmdq.base = data;
> +        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->cmdq.base = data & SMMU_QUEUE_BASE_RESERVED;
>          bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
>          if (bank->cmdq.log2size > SMMU_CMDQS) {
>              bank->cmdq.log2size = SMMU_CMDQS;
>          }
>          return MEMTX_OK;
>      case A_EVENTQ_BASE:
> -        bank->eventq.base = data;
> +        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->eventq.base = data & SMMU_QUEUE_BASE_RESERVED;
>          bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
>          if (bank->eventq.log2size > SMMU_EVENTQS) {
>              bank->eventq.log2size = SMMU_EVENTQS;
>          }
>          return MEMTX_OK;
>      case A_EVENTQ_IRQ_CFG0:
> -        bank->eventq_irq_cfg0 = data;
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->eventq_irq_cfg0 = data & SMMU_EVENTQ_IRQ_CFG0_RESERVED;
>          return MEMTX_OK;
>      default:
>          qemu_log_mask(LOG_UNIMP,
> @@ -2001,6 +2094,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          }
>          break;
>      case A_CMDQ_BASE: /* 64b */
> +        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
>          bank->cmdq.base = deposit64(bank->cmdq.base, 0, 32, data);
>          bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
>          if (bank->cmdq.log2size > SMMU_CMDQS) {
> @@ -2008,6 +2108,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          }
>          break;
>      case A_CMDQ_BASE + 4: /* 64b */
> +        if (!smmu_cmdq_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_BASE + 4 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
>          bank->cmdq.base = deposit64(bank->cmdq.base, 32, 32, data);
>          break;
>      case A_CMDQ_PROD:
> @@ -2015,9 +2122,22 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>          break;
>      case A_CMDQ_CONS:
> +        if (!smmu_cmdq_disabled_stable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_CONS write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->cmdq.cons = data;
>          break;
>      case A_EVENTQ_BASE: /* 64b */
> +        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
>          bank->eventq.base = deposit64(bank->eventq.base, 0, 32, data);
>          bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
>          if (bank->eventq.log2size > SMMU_EVENTQS) {
> @@ -2025,24 +2145,63 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          }
>          break;
>      case A_EVENTQ_BASE + 4:
> +        if (!smmu_eventq_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_BASE + 4 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
>          bank->eventq.base = deposit64(bank->eventq.base, 32, 32, data);
>          break;
>      case A_EVENTQ_PROD:
> +        if (!smmu_eventq_disabled_stable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_PROD write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->eventq.prod = data;
>          break;
>      case A_EVENTQ_CONS:
>          bank->eventq.cons = data;
>          break;
>      case A_EVENTQ_IRQ_CFG0: /* 64b */
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
>          bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 0, 32, data);
>          break;
>      case A_EVENTQ_IRQ_CFG0 + 4:
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG0+4 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED >> 32;
>          bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 32, 32, data);
>          break;
>      case A_EVENTQ_IRQ_CFG1:
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG1 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->eventq_irq_cfg1 = data;
>          break;
>      case A_EVENTQ_IRQ_CFG2:
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG2 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->eventq_irq_cfg2 = data;
>          break;
>      default:
> @@ -2108,6 +2267,14 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_BASE:
>          *data = bank->eventq.base;
>          return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG0:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_EVTQ)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
> +        *data = bank->eventq_irq_cfg0;
> +        return MEMTX_OK;
>      default:
>          *data = 0;
>          qemu_log_mask(LOG_UNIMP,
> @@ -2229,6 +2396,38 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_CONS:
>          *data = bank->eventq.cons;
>          return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG0: /* 64b */
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_EVTQ)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
> +        *data = extract64(bank->eventq_irq_cfg0, 0, 32);
> +        return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG0 + 4:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_EVTQ)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
> +        *data = extract64(bank->eventq_irq_cfg0, 32, 32);
> +        return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG1:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_EVTQ)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
> +        *data = bank->eventq_irq_cfg1;
> +        return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG2:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_EVTQ)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
> +        *data = bank->eventq_irq_cfg2;
> +        return MEMTX_OK;
>      default:
>          *data = 0;
>          qemu_log_mask(LOG_UNIMP,
> @@ -2610,4 +2809,3 @@ static void smmuv3_register_types(void)
>  }
>  
>  type_init(smmuv3_register_types)
> -
Thanks

Eric


