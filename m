Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69C3C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uUn-0003WC-Kb; Mon, 31 Aug 2026 01:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0uUl-0003Vq-Bu
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0uUj-00084w-7F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788153824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eY9MsCEXUuolmJZN31JCHWI9YnnSoSFkbcDH4Ro0H9k=;
 b=CNuspgicJs/x4btnuzjPAfjy3oshXncVHkBi1pmfAmhpgjY1+2fo8BogowcwkDvnQJDZTZ
 SFAkpUBJfoSA/jZpz53I5Olb2oMLDMX+7LXammNRBladqcgnu61NbTjpMJkSkh4y7XDJBt
 J9uI0XGcARv61tDai7y9QTPxQxPy8+0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-B6i_VWaPMdaZ_BuQVzaqtQ-1; Mon, 31 Aug 2026 01:23:42 -0400
X-MC-Unique: B6i_VWaPMdaZ_BuQVzaqtQ-1
X-Mimecast-MFC-AGG-ID: B6i_VWaPMdaZ_BuQVzaqtQ_1788153821
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499913d1a79so16317985e9.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788153821; x=1788758621;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eY9MsCEXUuolmJZN31JCHWI9YnnSoSFkbcDH4Ro0H9k=;
 b=aV4x0JiXCnQZu/JQRsHIARSyVj6dT0PgS/syDtbil2VaI43N6RhNLqtzcyl3xRzjDj
 l3sO/oRlmrb+C50QInJ23egu4yQHwP8rh6cyLUsa1I2jLo2OeOsM054GHJEgXlyItT3G
 +0Uci7qYNBPFWXUcX4SlaQpwegenS9si4TJy2CdeLupIEGrWsBkRbMo4airvwhBI0PYq
 EL9prCJbHOpwW+xn3kDYw4HyWarKvff/3vCB9BHmbLf0qe6nmaDANR0UjGoHeQAx0ZlD
 QsIWB2xkVpfcKtoGjx2ybOwKXWT+HNx+l8BbpUjaBIqMm+vsCVWSHXPlrtgh+jQvuTTh
 izrA==
X-Gm-Message-State: AFuF++lpTmgwqGOoxAOnsZm0Kd2e8UIUp7tYFas9P4/TktNjdTZcXw91
 GG15JfNxuPc3aPXDoHoXsSOB2DRjTQymLPmJG6Ix5Hs0Blllv1Qtb/I0mpIgWLmEQK8xIZVeQbO
 bZPRMF84f7AlrFBpISnDpUCePFzoSAKxuQ+uYs1fuTExX08YQADlYKv/o
X-Gm-Gg: AR+sD11ZT74sMlNtpJqLux/BnHyYhLVRwjN6beQcHUzWnjr+81B38IZwUeZgnYbdwC5
 lve/ZmHk3LlTNYD9q6CiCWon88S9tiBJ0PVBHCAWq9Ntr327Ls4eWJLut89bSgWNzSZDD8lRmCo
 HtKXzAFC1B6gXqsgHRPTuoaoZXQyymkNYRZGBOwAi8y0jnTtoylhVFnHb5jlWYmXUwZJWCsFF1u
 V9mu60CqfByfnGhPdTNSRboGbW43CxWvUv7vr1uMs3P5leYVxcKOMgZBSmsATHL1ezpTNDqLqSG
 Q257b/NzyYBO8BTZWZUnHvcvXAh2E0GmIRZrogRsunII2bZLA/TpaNY+ucv3hg5KjHuGA1mWXIo
 rCd8ItMrCZMkUkfCF0pEX3tamKRSre8AO170BHLn0ZtaDznrG
X-Received: by 2002:a05:600c:608d:b0:49b:9438:7785 with SMTP id
 5b1f17b1804b1-49cd9415f38mr11266055e9.4.1788153821049; 
 Sun, 30 Aug 2026 22:23:41 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:49b:9438:7785 with SMTP id
 5b1f17b1804b1-49cd9415f38mr11265745e9.4.1788153820673; 
 Sun, 30 Aug 2026 22:23:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd775dae8sm83661815e9.9.2026.08.30.22.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:23:39 -0700 (PDT)
Message-ID: <5d280603-e2f9-4d24-a31b-19f908a30c55@redhat.com>
Date: Mon, 31 Aug 2026 07:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 21/28] hw/arm/smmuv3: Implement SMMU_S_INIT register
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
 <20260813162624.2809349-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162624.2809349-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 8/13/26 6:26 PM, Tao Tang wrote:
> Implement read/write handlers for the SMMU_S_INIT secure-only register.
>
> Writing INV_ALL provides a mechanism for software to perform a global
> invalidation of ALL caches within the SMMU, including IOTLBs and
> configuration caches across all security states.
>
> The MMIO dispatcher decodes the target register bank from the offset and
> normalizes Secure-window offsets by subtracting SMMU_SECURE_REG_START
> before switching on the bank-local offset. S_INIT is a Secure-only
> register and its A_S_INIT constant is an absolute Secure-window offset,
> so the handler matches it using A_S_INIT - SMMU_SECURE_REG_START and
> rejects accesses through Non-secure banks.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events |  1 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index d69fc0898af..dc3fa618883 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -393,6 +393,21 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>  
>  }
>  
> +static void smmuv3_invalidate_all_caches(SMMUv3State *s)
> +{
> +    SMMUState *bs = &s->smmu_state;
> +    trace_smmuv3_invalidate_all_caches();
> +
> +    /* Clear all cached configs including STE and CD */
> +    if (bs->configs) {
> +        g_hash_table_remove_all(bs->configs);
> +    }
> +
> +    /* Invalidate all SMMU IOTLB entries */
> +    smmu_inv_notifiers_all(&s->smmu_state);
> +    smmu_iotlb_inv_all(bs);
> +}
> +
>  static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTransCfg *cfg,
>                                                   SMMUEventInfo *event,
> @@ -2206,7 +2221,29 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>  
>          bank->eventq_irq_cfg2 = data;
>          break;
> +    case A_S_INIT - SMMU_SECURE_REG_START:
> +        if (reg_sec_sid != SMMU_SEC_SID_S) {
> +            goto unhandled;
> +        }
> +        if (data & R_S_INIT_INV_ALL_MASK) {
> +            /*
> +             * If SMMU_ROOT_CR0.GPCEN == 0, a write of 1 to INV_ALL when any
> +             * SMMU_(*_)CR0.SMMUEN == 1, .... , is CONSTRAINED UNPREDICTABLE
> +             * according to (IHI 0070G.b) 6.3.62 SMMU_S_INIT, Page 465.
> +             */
> +            if (!smmuv3_smmu_disabled_stable(s, SMMU_SEC_SID_NS) ||
> +                !smmuv3_smmu_disabled_stable(s, SMMU_SEC_SID_S)) {
> +                /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
> +                qemu_log_mask(LOG_GUEST_ERROR, "S_INIT write ignored: "
> +                              "(S_)CR0.SMMUEN or (S_)CR0ACK.SMMUEN is set\n");
> +                return MEMTX_OK;
> +            }
shall we really bother: I read:
"
If SMMU_ROOT_CR0.GPCEN == 0, a write of 1 to INV_ALL when any
SMMU_(*_)CR0.SMMUEN == 1,
or an Update of any SMMUEN to 1 is in progress, or
SMMU_ROOT_CR0.ACCESSEN == 1, or an Update of
ACCESSEN to 1 is in progress, is CONSTRAINED UNPREDICTABLE and has one
of the following behaviors:
• The write is IGNORED.
• The invalidation operation occurs and completes, with INV_ALL reset to
0 on completion.
"
So the second behavior would let us simplify the code, no?

By the way where is GPCEN checked?

Eric
> +            smmuv3_invalidate_all_caches(s);
> +        }
> +        /* Synchronous emulation: invalidation completed instantly. */
> +        break;
>      default:
> +    unhandled:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
>                        __func__, offset);
> @@ -2444,6 +2481,12 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>  
>          *data = bank->eventq_irq_cfg2;
>          return MEMTX_OK;
> +    case A_S_INIT - SMMU_SECURE_REG_START:
> +        if (reg_sec_sid != SMMU_SEC_SID_S) {
> +            goto unhandled;
> +        }
> +        *data = 0;
> +        return MEMTX_OK;
>      default:
>      unhandled:
>          *data = 0;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 7cd4eb38578..ac9f737a5e6 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -67,6 +67,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
> +smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
>  smmu_reset_exit(void) ""
>  
>  #smmuv3-accel.c


