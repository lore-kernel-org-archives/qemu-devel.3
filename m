Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7C606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iDEItJQn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XLxwV46p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbJE-0000nC-SU; Thu, 26 Nov 2026 10:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWbJC-0000lg-3V
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:22:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWbJ8-00066I-GH
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795706565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFDJcJjeX1tXUiktOqAa50IyI2MtSH7qryjzPnMarAk=;
 b=iDEItJQnuB2acyZqY0NFxzUeZ3R6SDTemgOR+SI6SnJ9TPwnX8y49dWM0k+U4RCLVe78Oy
 CQDTECz7EieNxOCciPmkPP0rWCWk0i6x1O0iJBrd7FrAmLGyALg0J8EctFQUFH7/9n8buh
 okwMRWit+00k9imYGZqB/ObT+SIk6ZY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-s7GNXkcrMpqFFYkqgtagUg-1; Thu, 26 Nov 2026 15:22:42 +0000
X-MC-Unique: s7GNXkcrMpqFFYkqgtagUg-1
X-Mimecast-MFC-AGG-ID: s7GNXkcrMpqFFYkqgtagUg_1795706562
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c5095dd1514so633456266b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795706562; x=1796311362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nFDJcJjeX1tXUiktOqAa50IyI2MtSH7qryjzPnMarAk=;
 b=XLxwV46pIZiAMskKuEAV5orxzDvwDLcELnLoLDbfzrZAU6BI9TrVoohJySJ1prbGT5
 5BSQUJA5IldlCqOc8XteeQ2D0JWavP8Yill0BW9XL/ngEY0q1ll1+vW54rLcJOFY5sOS
 +gx3F6c4wNp7L30Fpiqwe95oGGVkcvOUonnzDz+xgapfqjZ6tqurJTb2t2AAc2DQRLUm
 U20d4Yui4NqJ5MGrVLSr22Jx6NqTj3CzVlY/B0HU6gPh0v6DIcnN0BYyInwSoGYmyiXk
 GJ0+9qgH5sIptMAo4c87H9sVFMvS7dTQHzip6+HqfkoCMRDp8+anh2wYh8HjKqGdlS2z
 K/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795706562; x=1796311362;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nFDJcJjeX1tXUiktOqAa50IyI2MtSH7qryjzPnMarAk=;
 b=ZUg5p4/haKOaitZls7tOOmQ9BRIaUp/8s6Jau7Ywx9NutjxIk1RLg1dtMED/k1qC4r
 MSw0p3rKzLb1K2tPdmIEerba/Kg43vA5pBXabAM7KjWYgjU1w0apYUdlQZkOpJKgYQee
 dek0A6D0GAQxU96kqYhlgRcjyNTCLTkF4JNUL4TBE04gQgrw8L2T5ogrEMEZ7O6QKroW
 yunvgGMLbitHkWuxkLNFGeQpVNHTcDgqSOZ/mqHGpH9f/rm2fjQlRev+nvQjdtfA4NRe
 O/tABQH9CAevkpoXcKJVCe8ozCkC5WjaVSyeN4yb1yM05rAFttFN0/W20djCQjUGjBWV
 N6Aw==
X-Forwarded-Encrypted: i=1;
 AL+hErGrvBsGb6v22i3hVstrpkQWD0cbtWfp5QtMWe/cQ4MtE/fcbY2t1jZ8tyg1F/XDrXdIMD1sF2rSifaS@nongnu.org
X-Gm-Message-State: APuU4Z91QG4VwifPmej34tjhlyFY4jInr3wzrxh/V9dATeA86siopMic
 f1fmgKf1VNXo3u7TyCrO+Zzv2iAm3CS8y/rpnP8B7+Rorkye4lBuDhuOsvy/ahF7d4dzqLgdOAv
 ZlpzoF369UjczjIjoyrB6UP8q+fV9xc2Ct4fjaqBzXz1PhvsFEZJmj4of
X-Gm-Gg: AZFdTZcDRXZz3Wi+xK+anBEMPjV2wztT092KrOQxmHuwbEeJeAN80Cte64Q3VZH594f
 T6CvVs1xoM1mNIoMf4lOywAqwDUEtSWMS5GW27AuFCOt6edKd6Ryen+aOsdtQ6BH3pB7QLQIb5A
 oTy5uxWX1SKS6yHGV2szoEj5pDFbQdv2MkQEeEB/9A+MFQIihVRGFuVv4bZo4b/AsLcwSuvlbz0
 IpnSUWKoT/YZTXVt8Ajmv8mBaYcKkqOtwdKMHQnd16z665wR2j62rUMd8JpBQSVkgdmH6H40t7m
 6ifFmA6+MoRgWJg83X1h9XSYMR0jh3QfuRaiyKEtibQQaZH+sBPbuc1OLE7Llj2jYOI8wBtRycP
 H5HLMqeXtA1yJj6AlSLE06cItVyHigmY1dtjCo19sFZ9tvOIvBlQUqjA5HHlzkzAEEXWT7bEI+T
 avhxPkxgyKk6ayNRTv
X-Received: by 2002:a17:907:fd15:b0:c40:33d:f06f with SMTP id
 a640c23a62f3a-c513aaad90bmr1788473766b.39.1795706561422; 
 Thu, 26 Nov 2026 07:22:41 -0800 (PST)
X-Received: by 2002:a17:907:fd15:b0:c40:33d:f06f with SMTP id
 a640c23a62f3a-c513aaad90bmr1788469266b.39.1795706560812; 
 Thu, 26 Nov 2026 07:22:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b1ebsm42752341f8f.33.2026.11.26.07.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 07:22:40 -0800 (PST)
Message-ID: <18b5aaf4-e6bb-4622-899a-bc0c7984e7d5@redhat.com>
Date: Thu, 26 Nov 2026 16:22:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hw/arm/smmuv3: define Root registers and x-root
 flag
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Gustavo Romero <gromero@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261126-jmac-smmu-root-registers-v3-0-b46a8ac59b6d@linaro.org>
 <20261126-jmac-smmu-root-registers-v3-1-b46a8ac59b6d@linaro.org>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261126-jmac-smmu-root-registers-v3-1-b46a8ac59b6d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jim,

On 11/26/26 10:44 AM, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Adds all the non-optional SMMUv3.3 Root registers. These registers
> do nothing at the moment, but accessors are provided for future
> use.
> 
> The extra space will only be allocated if x-root is set to true. This
> is off by default, and in most machines the Root registers will be
> outside the SMMU register space and hence inaccessible.
Naive question, what is the exact rationale to support MMIO without the rest of the functionality?

> 
> Based on original work by Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/arm/smmuv3.c                | 241 ++++++++++++++++++++++++++++++++++++++++-
>  include/hw/arm/smmuv3-common.h |  30 +++++
>  include/hw/arm/smmuv3.h        |  14 +++
>  3 files changed, 284 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2a9721b87e..70aecb92ea 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -316,6 +316,14 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
>      s->aidr = 0x1;
>      smmuv3_accel_idr_override(s);
> +
> +    /*
> +     * Initialize Root bank. This register is inaccessible if we don't have
> +     * Root, so the value can be 1 in all cases.
> +     */
> +    s->root.idr0 = FIELD_DP32(s->root.idr0, ROOT_IDR0, ROOT_IMPL, 1);
> +    /* Set this to 1 when SMMU Realms are implemented */
> +    s->root.idr0 = FIELD_DP32(s->root.idr0, ROOT_IDR0, REALM_IMPL, 0);
>  }
>  
>  bool smmuv3_ats_enabled(SMMUv3State *s)
> @@ -343,6 +351,11 @@ static void smmuv3_reset(SMMUv3State *s)
>      s->gerrorn = 0;
>      s->statusr = 0;
>      s->gbpa = SMMU_GBPA_RESET_VAL;
> +
> +    s->root.cr0 = 0;
> +    s->root.cr0ack = 0;
> +    s->root.gpf_far = 0;
> +    s->root.gpt_cfg_far = 0;
>  }
>  
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> @@ -1769,6 +1782,110 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>      return MEMTX_OK;
>  }
>  
> +/*
> + * Check we are from the Root PA space to read from or write to the
> + * SMMU Root register area.
> + */
> +static bool smmu_check_root_access(SMMUv3State *s, MemTxAttrs attrs,
> +                                   hwaddr offset, bool is_read)
> +{
> +    /* Check if the access is from Root PA */
> +    if (attrs.space != ARMSS_Root) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Non-root %s attempt at offset 0x%" PRIx64 " (%s)\n",
> +            __func__, is_read ? "read" : "write", offset,
> +            is_read ? "RAZ" : "WI");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static MemTxResult smmu_root_writel(SMMUv3State *s, hwaddr offset,
> +                                    uint64_t data, MemTxAttrs attrs)
> +{
For 64b registers don't you want to handle + 4 offsets too? Same for read? Looks strange you don't have any.> +    switch (offset) {
> +    case A_ROOT_IDR0:
> +    case A_ROOT_IIDR:
> +    case A_ROOT_CR0ACK:
> +        /* RO registers, write ignored */
> +        return MEMTX_OK;
> +    case A_ROOT_TLBI_CTRL:
> +        /* Optional, not implemented. Present if IDR0.RGPTM == 1 */
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_BASE_UPDATE:
> +        /* Unimplemented at present; has side effects */
> +        return MEMTX_OK;
> +    case A_ROOT_CR0:
> +        s->root.cr0 = data;
> +        s->root.cr0ack = s->root.cr0;
> +        return MEMTX_OK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled 32-bit access at 0x%"PRIx64" (WI)\n",
> +                      __func__, offset);
> +        /*
> +         * Locations not associated with a register (including registers that we
> +         * have not implemented yet) are RES0, and will follow RAZ/WI behaviour.
> +         */
> +        return MEMTX_OK;
> +    }
> +}
> +
> +static MemTxResult smmu_root_writell(SMMUv3State *s, hwaddr offset,
> +                                     uint64_t data, MemTxAttrs attrs)
> +{
> +    switch (offset) {
> +    case A_ROOT_GPT_BASE:
> +        s->root.gpt_base = data;
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_BASE_CFG:
> +        s->root.gpt_base_cfg = data;
> +        return MEMTX_OK;
> +    case A_ROOT_GPF_FAR:
> +        s->root.gpf_far = data;
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_CFG_FAR:
> +        s->root.gpt_cfg_far = data;
> +        return MEMTX_OK;
> +    case A_ROOT_TLBI:
> +        /* Optional, not implemented. Present if ROOT_IDR0.RGPTM == 1 */
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_BASE2:
> +        s->root.gpt_base2 = data;
> +        return MEMTX_OK;
> +    case A_ROOT_GPCBW:
> +        /* Optional, not implemented. Present if ROOT_IDR0.GPTS == 1 */
> +        return MEMTX_OK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled 64-bit access at 0x%"PRIx64" (WI)\n",
> +                      __func__, offset);
> +        /* RES0; See smmu_root_writel */
> +        return MEMTX_OK;
> +    }
> +}
> +
> +static MemTxResult smmu_write_root(SMMUv3State *s, hwaddr offset, uint64_t data,
> +                                   unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult r;
> +
> +    switch (size) {
> +    case 8:
> +        r = smmu_root_writell(s, offset, data, attrs);
> +        break;
> +    case 4:
> +        r = smmu_root_writel(s, offset, data, attrs);
> +        break;
> +    default:
> +        r = MEMTX_ERROR;
> +        break;
> +    }
> +
> +    trace_smmuv3_write_mmio(offset, data, size, r);
> +    return r;
> +}
> +
>  static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>                                     unsigned size, MemTxAttrs attrs)
>  {
> @@ -1776,6 +1893,18 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>      SMMUv3State *s = ARM_SMMUV3(sys);
>      MemTxResult r;
>  
> +    if (offset >= SMMUV3_ROOT_REG_OFFSET) {
> +        if (!smmu_check_root_access(s, attrs, offset, false)) {
> +            /*
> +             * As per 6.2.8, accesses in any PA space other
> +             * than Root are completed as RAZ/WI.
> +             */
> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
> +            return MEMTX_OK;
> +        }
> +        return smmu_write_root(s, offset, data, size, attrs);
> +    }
> +
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>  
> @@ -1918,6 +2047,99 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>      }
>  }
>  
> +static MemTxResult smmu_root_readl(SMMUv3State *s, hwaddr offset,
> +                                   uint64_t *data, MemTxAttrs attrs)
> +{
> +    switch (offset) {
> +    case A_ROOT_IDR0:
> +        *data = s->root.idr0;
> +        return MEMTX_OK;
> +    case A_ROOT_IIDR:
> +        *data = s->root.iidr;
> +        return MEMTX_OK;
> +    case A_ROOT_TLBI_CTRL:
> +        /* Optional, not implemented. Present if ROOT_IDR0.RGPTM == 1 */
> +        *data = 0;
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_BASE_UPDATE:
> +        /* Not a regular register; reads as 0 once update is complete */
> +        *data = 0;
> +        return MEMTX_OK;
> +    case A_ROOT_CR0:
> +        *data = s->root.cr0;
> +        return MEMTX_OK;
> +    case A_ROOT_CR0ACK:
> +        *data = s->root.cr0ack;
> +        return MEMTX_OK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled 32-bit access at 0x%"PRIx64" (RAZ)\n",
> +                      __func__, offset);
> +        *data = 0;
> +        /* RES0; See smmu_root_writel */
> +        return MEMTX_OK;
> +    }
> +}
> +
> +static MemTxResult smmu_root_readll(SMMUv3State *s, hwaddr offset,
> +                                    uint64_t *data, MemTxAttrs attrs)
> +{
> +    switch (offset) {
> +    case A_ROOT_GPT_BASE:
> +        *data = s->root.gpt_base;
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_BASE_CFG:
> +        *data = s->root.gpt_base_cfg;
> +        return MEMTX_OK;
> +    case A_ROOT_GPF_FAR:
> +        *data = s->root.gpf_far;
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_CFG_FAR:
> +        *data = s->root.gpt_cfg_far;
> +        return MEMTX_OK;
> +    case A_ROOT_TLBI:
> +        /* Optional, not implemented. Present if ROOT_IDR0.RGPTM == 1 */
> +        *data = 0;
> +        return MEMTX_OK;
> +    case A_ROOT_GPT_BASE2:
> +        *data = s->root.gpt_base2;
> +        return MEMTX_OK;
> +    case A_ROOT_GPCBW:
> +        /* Optional, not implemented. Present if ROOT_IDR0.GPTS == 1 */
> +        *data = 0;
> +        return MEMTX_OK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled 64-bit access at 0x%"PRIx64" (RAZ)\n",
> +                      __func__, offset);
> +        *data = 0;
> +        /* RES0; See smmu_root_writel */
> +        return MEMTX_OK;
> +    }
> +}
> +
> +static MemTxResult smmu_read_root(SMMUv3State *s, hwaddr offset, uint64_t *data,
> +                                  unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult r;
> +
> +    switch (size) {
> +    case 8:
> +        r = smmu_root_readll(s, offset, data, attrs);
> +        break;
> +    case 4:
> +        r = smmu_root_readl(s, offset, data, attrs);
> +        break;
> +    default:
> +        r = MEMTX_ERROR;
> +        break;
> +    }
> +
> +    trace_smmuv3_read_mmio(offset, *data, size, r);
can we have specific trace points for root accesses?> +    return r;
> +}
> +
> +
>  static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>                                    unsigned size, MemTxAttrs attrs)
>  {
> @@ -1925,6 +2147,19 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>      SMMUv3State *s = ARM_SMMUV3(sys);
>      MemTxResult r;
>  
> +    if (offset >= SMMUV3_ROOT_REG_OFFSET) {
> +        if (!smmu_check_root_access(s, attrs, offset, true)) {
> +            /*
> +             * As per 6.2.8, accesses in any PA space other
> +             * than Root are completed as RAZ/WI.
> +             */
> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
> +            return MEMTX_OK;
> +        }
> +
> +        return smmu_read_root(s, offset, data, size, attrs);
> +    }
> +
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>  
> @@ -2063,7 +2298,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      qemu_mutex_init(&s->mutex);
>  
>      memory_region_init_io(&sys->iomem, OBJECT(s),
> -                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, 0x20000);
> +                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3,
> +                          s->has_root ? SMMUV3_REGS_SIZE + SMMUV3_ROOT_PAGE_SIZE
> +                                      : SMMUV3_REGS_SIZE);
>  
>      sys->mrtypename = TYPE_SMMUV3_IOMMU_MEMORY_REGION;
>  
> @@ -2153,6 +2390,8 @@ static const Property smmuv3_properties[] = {
>      /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
>      DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
> +    DEFINE_PROP_BOOL("x-root", SMMUv3State, has_root, false),
> +
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /*
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 4609975edf..a8919d5be6 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -411,6 +411,36 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> +/*
> + * SMMUV3_ROOT_REG_OFFSET is implementation dependent. QEMU fixes this at one
implementation defined
it is named Root Control Page in the spec, right? In the prositive can we use the same terminology here?> + * address for now, but this may need to vary at some point to suit actual
> + * hardware implementations.
Shouldn't be SMMUV3_ROOT_REG_OFFSET a property then. Why is it set to 0x20000
Don't we have other pages inbetwee, optional pages, realm?> + */
> +#define SMMUV3_PAGE_SIZE        0x10000
> +#define SMMUV3_REGS_SIZE        (2 * SMMUV3_PAGE_SIZE) /* Page 0 and Page 1 */
I would add mandatory pages> +#define SMMUV3_ROOT_REG_OFFSET  0x20000
so you decide to put the root ctrl page at 0x20000. This is an arbitrary choice for the layout.

> +#define SMMUV3_ROOT_PAGE_SIZE   SMMUV3_PAGE_SIZE
ROOT_CTRL_PAGE_SIZE would be clearer I think> +
> +REG32(ROOT_IDR0,            0x0)
> +    FIELD(ROOT_IDR0, ROOT_IMPL,   0,  1)
> +    FIELD(ROOT_IDR0, BGTPM,       1,  1)
> +    FIELD(ROOT_IDR0, RGPTM,       2,  1)
> +    FIELD(ROOT_IDR0, REALM_IMPL,  3,  1)
> +    FIELD(ROOT_IDR0, BA_REALM,   22, 10)
> +
> +REG32(ROOT_IIDR,             0x8)
> +REG32(ROOT_CR0,             0x20)
> +REG32(ROOT_CR0ACK,          0x24)
> +REG64(ROOT_GPT_BASE,        0x28)
> +REG64(ROOT_GPT_BASE_CFG,    0x30)
> +REG64(ROOT_GPF_FAR,         0x38)
> +REG64(ROOT_GPT_CFG_FAR,     0x40)
> +REG64(ROOT_TLBI,            0x50)
> +REG32(ROOT_TLBI_CTRL,       0x58)
> +REG64(ROOT_GPT_BASE2,       0x60)
> +REG32(ROOT_GPT_BASE_UPDATE, 0x68)
> +REG32(ROOT_GPCBW,           0x70)
this one is 64-bit> +
>  /* Commands */
>  
>  typedef enum SMMUCommandType {
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d39fe8850b..a8b354438c 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -34,6 +34,18 @@ typedef struct SMMUQueue {
>       uint8_t log2size;
>  } SMMUQueue;
>  
> +typedef struct SMMUv3RootRegBank {
> +    uint32_t idr0;
> +    uint32_t iidr;
> +    uint32_t cr0;
> +    uint32_t cr0ack;
> +    uint64_t gpt_base;
> +    uint64_t gpt_base_cfg;
> +    uint64_t gpf_far;
> +    uint64_t gpt_cfg_far;
> +    uint64_t gpt_base2;
> +} SMMUv3RootRegBank;
> +
so we add some regs in the state but we don't update VMStateDescription. What about migration?>  struct SMMUv3State {
>      SMMUState     smmu_state;
>  
> @@ -80,6 +92,8 @@ struct SMMUv3State {
>      OnOffAuto cmdqv;
>  
>      Notifier machine_done;
> +    bool has_root;
> +    SMMUv3RootRegBank root;
>  };
>  
>  typedef enum {
> 
Thanks

Eric

