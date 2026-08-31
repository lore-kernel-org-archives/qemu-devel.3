Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C847C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0v0e-0000o6-Dh; Mon, 31 Aug 2026 01:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0v0c-0000no-Qo
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0v0a-00039M-RS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788155799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ecbFYv+BZVCEsHoBeRK/1GAi/tQuEbRoNMjrdxZPzA=;
 b=IymcUHrZ3lVuA7S6/KN7e84P+KtDIBBUWiyKrzJPlJQ0SvuOU0axzGdF9qWIeZ3rJpq1Hq
 Vpny5361M9Yl76gVqOO9gNkP8U0if35eiS47ycSkcB3TViCno7UDwjNKNZtENxS4in3gTA
 0cNXAxqTtK8aWLNgZ3leAyKrgb/3tdA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-L1dQhKwRPPG2ynVNIcsqzQ-1; Mon, 31 Aug 2026 01:56:36 -0400
X-MC-Unique: L1dQhKwRPPG2ynVNIcsqzQ-1
X-Mimecast-MFC-AGG-ID: L1dQhKwRPPG2ynVNIcsqzQ_1788155795
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482f4a554dcso2771714f8f.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788155795; x=1788760595;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ecbFYv+BZVCEsHoBeRK/1GAi/tQuEbRoNMjrdxZPzA=;
 b=A5iry0sSA8ilEFoBG5W7f+x+xZVUlA4aCkVxr5ToQOPHq12nVJweqpGVsMOdvonIxz
 iR+pRo7X24Irem1N9RmpuvfXM8hvdQk9MeqTn2u6GduK+m/1sYgRcSoIDpiFsWPU3MxP
 NuaiU06dB3/rhRIwaaP/B6E+llm/BbxxhH/BB0W24qouuCTO7rZHFWw7JC7lO2kT53VO
 NPXzhZNixXnb8V8A27WnHsEcfSN5IG90fMQuw6K6TuOmWtnAmC2E6PwiYhTZtvhzhJtS
 FcojkhrjPCFxsw7fPbZYyIDKKq6LNlcnkgRl+EnKB7EJkaq84XH01It/b0QkRtVyrt/T
 ECRQ==
X-Gm-Message-State: AFuF++lLU4yWSyjWg6B6c004VMQaIInZsV7E610vvZp/X6v2lJhfi9iE
 C0rx5/tfNYQEv/g3ewjrlfgDQR9cAE650vQJE9lHOOd29cAae0iXTkuITjcS6UMdDiVEdjtjt1i
 aqyiGyCWFfLOdqs87myrgHkwFMq9LgHAKd718VtGjMN3UoJsmejKNfDCI
X-Gm-Gg: AYBFou3ohOCsOAtl7q2eDj8VBBjqFrgI1UYMCJSRGYkkuMgZdbMJfhaFUle8rWAMiBa
 o23ErQ/LkNZyJ0m+7pDThzEjkM72hZoVBa1PT20esBbj7K5WHpVjNGeguQCMobJB69t5cY7kQMT
 bbUkUlwQRZ2D/fGqm19Dxm5nZykR5K82xVJFQ0bzS5k+gu8/rfCwWB5JLC8eiofzTnRbi5FXAFL
 32eXQvs/TvdFOIEJvow9p43141fdBbGH4lkIssCDZqsmCt+7rXjMfbXRsLqnPGbyVgugMle+1Zk
 lQVf8QvoCrNyK8wBIyFNdoQPa7iRxWeL+QkLakBrgSIxpMQ5FF9rVWNZhSExXdmX3qLUm7AsV+G
 KbYDqwIcHcUTkY69WwCfPmARjreShOD28kgJCnWn/odID421E
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id
 ffacd0b85a97d-483ca4a6d9cmr21158904f8f.20.1788155795471; 
 Sun, 30 Aug 2026 22:56:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id
 ffacd0b85a97d-483ca4a6d9cmr21158871f8f.20.1788155795072; 
 Sun, 30 Aug 2026 22:56:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20713sm19516454f8f.21.2026.08.30.22.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:56:33 -0700 (PDT)
Message-ID: <40aae38d-a013-4be1-a259-93174fe52a69@redhat.com>
Date: Mon, 31 Aug 2026 07:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 22/28] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
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
 <20260813162624.2809349-2-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162624.2809349-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> This patch hardens the security validation within the main MMIO
> dispatcher functions (smmu_read_mmio and smmu_write_mmio).
>
> First, accesses to the Secure register space are gated by whether
> SECURE_IMPL is enabled. When it is disabled, all SMMU_S_* registers are
> read-as-zero and write-ignored.
>
> Second, the check for the input stream's security is made more robust.
> It now validates not only the legacy MemTxAttrs.secure bit, but also
> the .space field. This improves compatibility with Arm security space
> handling.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index dc3fa618883..e5f0bc18415 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1605,6 +1605,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>      return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_EVTQ);
>  }
>  
> +/* Check if the SMMU hardware itself implements secure state features */
> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1905,6 +1911,38 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>      return 0;
>  }
>  
> +/*
> + * Helper function for Secure register access validation.
> + *
> + * Follow S_IDR1.SECURE_IMPL accessibility rules for SMMU_S_*:
> + *  - SECURE_IMPL == 0: Secure state is not implemented; SMMU_S_* are RAZ/WI to
> + *    all accesses.
> + *  - SECURE_IMPL == 1: Non-secure accesses to SMMU_S_* are RAZ/WI.
> + */
> +static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
> +                                     hwaddr offset, bool is_read)
> +{
> +    /* Check if the access is secure */
> +    if (!(attrs.space == ARMSS_Secure ||
> +          attrs.secure == 1)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Non-secure %s attempt at offset 0x%" PRIx64 " (%s)\n",
would suggest

"%s: Non-secure %s at secure offset 0x%" PRIx64 " (%s)\n"
I am not sure we shall detail the end behavior here but rather put that in the call site

> +            __func__, is_read ? "read" : "write", offset,
> +            is_read ? "RAZ" : "WI");
> +        return false;
> +    }
> +
> +    /* Check if the secure state is implemented. */
> +    if (!smmu_hw_secure_implemented(s)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Secure %s attempt at offset 0x%" PRIx64 ". But Secure state "
> +            "is not implemented (RES0)\n",
> +            __func__, is_read ? "read" : "write", offset);

"%s: Secure %s at secure offset 0x%" PRIx64 "without support of secure state\n"
RES0 is a bit ambiguous. is it the capability which is RES0 or is it some end behavior associated to the access? I would skip this and detail in the caller instead

+ *  - SECURE_IMPL == 0: Secure state is not implemented; SMMU_S_* are RAZ/WI to
+ *    all accesses.

> +        return false;
> +    }
> +    return true;
> +}
> +
>  static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>                                  uint64_t data, MemTxAttrs attrs,
>                                  SMMUSecSID reg_sec_sid)
> @@ -2272,6 +2310,18 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>       * translate the Secure window to its bank-local register offsets.
>       */
>      if (offset >= SMMU_SECURE_REG_START) {
> +        if (!smmu_check_secure_access(s, attrs, offset, false)) {
> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
> +            /*
> +             * RAZ/WI/RES0 are deterministic register-level behaviors and do not
> +             * imply a bus protocol error or abort. Therefore we acknowledge the
> +             * MMIO transaction with MEMTX_OK and implement
> +             * "Read-As-Zero / Write-Ignored" in the register model, instead of
> +             * returning MEMTX_*_ERROR which is reserved for real decode/access
> +             * failures.
So here you document again the associated end behavior. I think si could
be simplied to "WI single line", no?
> +             */
> +            return MEMTX_OK;
> +        }
>          reg_sec_sid = SMMU_SEC_SID_S;
>          offset -= SMMU_SECURE_REG_START;
>      }
> @@ -2508,6 +2558,11 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>      if (offset >= SMMU_SECURE_REG_START) {
> +        if (!smmu_check_secure_access(s, attrs, offset, true)) {
> +            *data = 0;
> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
> +            return MEMTX_OK;
> +        }
>          reg_sec_sid = SMMU_SEC_SID_S;
>          offset -= SMMU_SECURE_REG_START;
>      }
Thanks

Eric


