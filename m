Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E7CC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztT3-0005iP-0j; Fri, 28 Aug 2026 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wztT0-0005hh-Lr
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wztSx-0007bj-Bv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787911541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0T1v1gUFn9kw++oMMF/nAACbn/31DNDdMLztt8cKFQ=;
 b=JLw55bolrTp8i530EoyIvMaMoDl4FXxIErDcV+PQg6ANXFRCV9sziap7RajS/+UVsFisy2
 w1dayXiLyUybyQj49n9V9TxwR2Nu6s6GIRm1NH3SAY1EYmxUnjno2tEzQx3PnfxgoY6WC2
 jRo2UYfzEL7xa5/LQlY82+4XIcFqzZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-kQpyWf4jPhKB-mlgoK0cLQ-1; Fri, 28 Aug 2026 06:05:40 -0400
X-MC-Unique: kQpyWf4jPhKB-mlgoK0cLQ-1
X-Mimecast-MFC-AGG-ID: kQpyWf4jPhKB-mlgoK0cLQ_1787911539
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47162f83c75so975942f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911539; x=1788516339;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B0T1v1gUFn9kw++oMMF/nAACbn/31DNDdMLztt8cKFQ=;
 b=YUu7rl9hwT+kOXstdAxBCRKJIVf0yck/W1cEf9lOQ8KuANecGz4P5yjRkqLptU8buY
 NpNItzAb7ztiSw1kCcQTjsfiKSm1jhzJGwwVfZUoYPuITQTmh8XpwtLQgGNtK76Sj/Q7
 DKOEbxIYqw8qcV+fLFbgHIY0sr5WwDzrU2dGIFGLASZTwTQ5YRwHFvyEw+oYIjG/4L64
 Z3l2mL8GixmrclGSWlzf0XkV94BumabvwfvG/OkXe9lxlWLE90HfJfIi0u62YgNg0kJz
 mSPsZsoXDcvM/Gx5QUP5ZS/5KmxIHgp0A+PS4ZJjMYwyKGSeM9dBZG5r0GpQVh2hICCl
 Gi7Q==
X-Gm-Message-State: AFuF++kSusWeGS01R2MxAN1eS43iyL2jM2PlBQDooZd7qTY7FFTtAQnz
 fbpWQj+YLXJ6W8X5JAUfnlCAEVaTYNS5k1AMBzGaNJ9FZ0fGgMJP19J4mfrUG4es/61GJX0qfUM
 ZQdZlh7Cr9GrM7yny+6YtK664FCXTt+gjMuicxEcnIti+XmWdkFY0E8so
X-Gm-Gg: AR+sD10gkFUonOokcmH9433a2ZNXKpXR+W10NipEL66XVL33Jyzj2nb9uZwagBzdhsH
 AwvnvVcG5tut+WMCPLOPwc3lqwTV0S5CzdQ9FyTzvgMgCJhr4gcjl/jXSASLyFpax3pd9y5oKIV
 xxSSzvJdvOOYeJRPfCbpq29Dhpo2pC7zaK2h7xxnRMV2h+V4NF+g84be75DrHHDetcrKgrv+TN5
 +7XmcUm+V/Li7ZnPznpbTHx7qruI1nlN+9vwSB95cB6Wp6D2PYKeUmYlUsNdSOynHCUVCpKOsyV
 aAm7uGqGBo/G4bYRdTE0O1XGHgKZbbZmcjC5iTaAJYb8biwobxnKcEkvbuA8YoJEvSwHJkxDJXe
 N8J+79wIR6Ut3geBBN/iuNoejGYqg+odGF5M3nHrU838zgBXe
X-Received: by 2002:a05:6000:461e:b0:481:50ae:df9a with SMTP id
 ffacd0b85a97d-482eab9cdd4mr20198388f8f.9.1787911538867; 
 Fri, 28 Aug 2026 03:05:38 -0700 (PDT)
X-Received: by 2002:a05:6000:461e:b0:481:50ae:df9a with SMTP id
 ffacd0b85a97d-482eab9cdd4mr20198277f8f.9.1787911538437; 
 Fri, 28 Aug 2026 03:05:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm2956275f8f.25.2026.08.28.03.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:05:37 -0700 (PDT)
Message-ID: <485db89a-e0b8-46ec-b586-24e1ce0033a4@redhat.com>
Date: Fri, 28 Aug 2026 12:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 17/28] hw/arm/smmuv3: Add access checks for STRTAB_BASE
 and CR2 registers
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
 <20260813162558.2808607-2-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162558.2808607-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add access control for SMMU_STRTAB_BASE and SMMU_CR2 registers to
> ensure they can only be modified when the SMMU is disabled.

About SMMU_STRTAB_BASE "
SMMU_STRTAB_BASE is Guarded by SMMU_CR0.SMMUEN and must only be written when
SMMU_CR0.SMMUEN == 0
.../..
In SMMUv3.2 and later, a write while SMMU_CR0.SMMUEN == 1 is IGNORED.
../..
Accessible at offset 0x0080 from SMMUv3_PAGE_0
• When SMMU_IDR1.TABLES_PRESET == 1, accesses to this register are RO.
• When SMMU_CR0.SMMUEN == 0 and SMMU_CR0ACK.SMMUEN == 0, accesses to
this register are
RW.
• Otherwise, accesses to this register are RO.
"

About SMMU_CR2:
"
This register is made read-only when the associated SMMU_CR0.SMMUEN is
Updated to 1. This register must
only be changed when SMMU_CR0.SMMUEN == 0.
A write to this register after SMMU_CR0.SMMUEN has been changed but
before its Update completes is
CONSTRAINED UNPREDICTABLE and has one of the following behaviors:
• Apply the new value.
• Ignore the write. In SMMUv3.2 and later, this is the only permitted
behavior.
"


>
> This implements:
> - smmuv3_smmu_disabled_stable(): Check whether the SMMU is in a stable
>    disabled state (CR0.SMMUEN == 0 and CR0ACK.SMMUEN == 0);
> - smmu_strtab_base_writable(): returns true only when IDR1.TABLES_PRESET==0
>    and SMMU is completely disabled.
>
> Additionally, mask reserved bits on writes to SMMU_STRTAB_BASE using
> SMMU_STRTAB_BASE_RESERVED.
>
> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 628911d3f21..de8ca7cda48 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1484,6 +1484,36 @@ smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>      return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_GERROR);
>  }
>  
> +static inline int smmuv3_get_cr0ack_smmuen(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    /*
> +     * CR0, CR0ACK, S_CR0 and S_CR0ACK are bit-layout compatible, so we reuse
> +     * the CR0 field definitions and only switch banks via sec_sid to reduce
> +     * code duplication. Also the other bits in CR0/CR0ACK are relevant here.
> +     */
> +    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, SMMUEN);
> +}
> +
> +/* Check if SMMU is disabled in stable status */
> +static inline bool smmuv3_smmu_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
s/stable/updated?
SMMU_CR0 spec quote:

> +{
> +    int cr0_smmuen = smmu_enabled(s, sec_sid);
> +    int cr0ack_smmuen = smmuv3_get_cr0ack_smmuen(s, sec_sid);
> +    return (cr0_smmuen == 0 && cr0ack_smmuen == 0);

Each field in this register has a corresponding field in SMMU_CR0ACK. An
individual field is described as
Updated after the value of the field observed in SMMU_CR0ACK matches the
value that was written to the field
in SMMU_CR0.

Besides I don't if its wort that complexity here because the update is
done in the emulation
    case A_CR0:
        bank->cr[0] = data;
        bank->cr0ack = data & ~SMMU_CR0_RESERVED;

Just adding a coment would be enough I think

I would split this patch into 2 sparate patches, first one CR2 and then
STRTAB_BASE




> +}
> +
> +/* Check if STRTAB_BASE register is writable */
> +static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    /* SMMU_IDR1.TABLES_PRESET applies to both modeled interfaces. */
> +    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, TABLES_PRESET)) {
> +        return false;
> +    }
> +
> +    /* Check SMMUEN conditions for the specific security domain */
> +    return smmuv3_smmu_disabled_stable(s, sec_sid);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1801,7 +1831,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>          bank->gerror_irq_cfg0 = data & SMMU_GERROR_IRQ_CFG0_RESERVED;
>          return MEMTX_OK;
>      case A_STRTAB_BASE:
> -        bank->strtab_base = data;
> +        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "STRTAB_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        /* Clear reserved bits according to spec */
> +        bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
>          return MEMTX_OK;
>      case A_CMDQ_BASE:
>          bank->cmdq.base = data;
> @@ -1852,7 +1889,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          bank->cr[1] = data;
>          break;
>      case A_CR2:
> -        bank->cr[2] = data;
> +        if (smmuv3_smmu_disabled_stable(s, reg_sec_sid)) {
> +            /* Allow write: SMMUEN is 0 in both CR0 and CR0ACK */
> +            bank->cr[2] = data;
> +        } else {
> +            /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CR2 write ignored: register is read-only when "
> +                          "CR0.SMMUEN or CR0ACK.SMMUEN is set\n");
not sure those logs are requested.
> +        }
>          break;
>      case A_IRQ_CTRL:
>          bank->irq_ctrl = data;
> @@ -1915,12 +1960,32 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          }
>          break;
>      case A_STRTAB_BASE: /* 64b */
> +        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "STRTAB_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_STRTAB_BASE_RESERVED;
>          bank->strtab_base = deposit64(bank->strtab_base, 0, 32, data);
>          break;
>      case A_STRTAB_BASE + 4:
> +        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "STRTAB_BASE + 4 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_STRTAB_BASE_RESERVED;
>          bank->strtab_base = deposit64(bank->strtab_base, 32, 32, data);
>          break;
>      case A_STRTAB_BASE_CFG:
> +        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "STRTAB_BASE_CFG write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->strtab_base_cfg = data;
>          if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
>              bank->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
Thanks

Eric


