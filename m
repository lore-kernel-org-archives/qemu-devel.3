Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BF4D21688
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRAny-0007SJ-Ao; Thu, 04 Dec 2025 09:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRAnw-0007Ms-Lj
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRAnv-0007iQ-05
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764860372;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jcHHWsOGuAJtR4EYY4dpBeDRFzbFAohrvutIlFrtIPU=;
 b=XgjOst/ZG66Tr6D3vJV6RFcQkMrn/2C2HUMPy7s8lmVMUInDPhPzptUBlIZvVnavKjK25y
 Jw/AxIyMri5pnWU6eDiUg0DWKXR5MJUbl7HDTa9uSWYmXeXQW+Nnhw4THyrQadxs9OTfpn
 3GKAKkqWjkAD7V1sj78s2u80se3QSN0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-H5cEfCb5PnKc-RfUZGn7BQ-1; Thu, 04 Dec 2025 09:59:28 -0500
X-MC-Unique: H5cEfCb5PnKc-RfUZGn7BQ-1
X-Mimecast-MFC-AGG-ID: H5cEfCb5PnKc-RfUZGn7BQ_1764860368
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8824292911cso45002746d6.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 06:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764860368; x=1765465168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcHHWsOGuAJtR4EYY4dpBeDRFzbFAohrvutIlFrtIPU=;
 b=eckYa3f6AZ/cFOEpWD9S4MjtB2g+z78XYJ9CqLUqpibwDKK50SqquW7ZRmKxW1zA7Y
 l5W9GC+i3cUl7dq5Ak1afLWepNBIjLu6aD1bOoIfK31vvgWq5rF3iWHedH4Ob3TxTDmd
 W8d/ECHsoWtOLuYnn1C5R7UY2e2s1lwzEJiky5AzfrR7sanlmeAXl5rLjSjKEYzLljl2
 j+xKu7Mc8CfXbMyGRtOKDWRgopYmITFYv9aVjzD+MKXtAAu9ZXcfb90iAiIfyW5Xs7dI
 q1gVgwyOlpK1zhU8qUR9B+mahYcbjnmWQs4/TYu0TW8XHoepBBIvj4j9yuBqdaQIK6Js
 hvOQ==
X-Gm-Message-State: AOJu0Yzs9lmR4iETLhSrpZyvlNy4OkjnEgGuymhSxyxgVZtlSlJX4SOM
 2rha18YIdWdz72xnjnDVZq4VDsbBjbDkpNpDnv+X67ISvG8PTelWoBunIRBx5XlLhyNBuWfF7cS
 zJoNVQV+4z3HZFJlBulvsGhFx515wEQteZ5YV3g25yYlt1sqZaA65a/TM
X-Gm-Gg: ASbGncv+X3ouDrvTCOU+hy2/5roIhUiAgTKpdEHXLn2Qn6Bvz1OadlHdXDgWJLVMDqH
 lPL0eCcaHY8s4ECl1bQ8HSHuP8CRSoAvRk9mhE+/map15L7gQZA6gHdsJpz0uCy42XwvbvwX56j
 l1ALSdsrwb0G5IWSE+JM5rtcm0TDbeM3HVvHB3VwCw+j963FGZY9fxy8lu2eq/grl6Sfc6ATSvv
 ThP3hZzhIS3q3/42/owvo9iuXDCo8tjK1N01ISMucvIEB/YlnL0yhNgGNVgLALGRqlxoN0LH7Ov
 o6khPxe/3zO8tJ69P97uUHRLd8PL0aVEvNG2GyFDJy06pbtsDJq47iO5AwPpdTJG1nfMAoxawaw
 a2UjpCN9/MVyJ0egBJmtUvWRCD23LAoEKfwz5+dq82u6YCeV482Ics4uMvQ==
X-Received: by 2002:a05:6214:2aa8:b0:87c:27e2:3c0c with SMTP id
 6a1803df08f44-888245c09fcmr49879426d6.21.1764860368290; 
 Thu, 04 Dec 2025 06:59:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAO2wQdLQLcsZ40pEve5TROTgC6c/DV+Ipk+cKMkhqVa/abdKTrBq2ZpLo/E/M2h8se16JdA==
X-Received: by 2002:a05:6214:2aa8:b0:87c:27e2:3c0c with SMTP id
 6a1803df08f44-888245c09fcmr49879056d6.21.1764860367819; 
 Thu, 04 Dec 2025 06:59:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f3347asm12403176d6.6.2025.12.04.06.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 06:59:27 -0800 (PST)
Message-ID: <04533911-e6f5-42d6-9813-85e97ce13d38@redhat.com>
Date: Thu, 4 Dec 2025 15:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 18/21] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151437.4130770-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012151437.4130770-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/12/25 5:14 PM, Tao Tang wrote:
> This patch hardens the security validation within the main MMIO
> dispatcher functions (smmu_read_mmio and smmu_write_mmio).
>
> First, accesses to the secure register space are now correctly gated by
> whether the SECURE_IMPL feature is enabled in the model. This prevents
> guest software from accessing the secure programming interface when it is
> disabled, though some registers are exempt from this check as per the
> architecture.
>
> Second, the check for the input stream's security is made more robust.
> It now validates not only the legacy MemTxAttrs.secure bit, but also
> the .space field. This brings the SMMU's handling of security spaces
> into full alignment with the PE.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 4ac7a2f3c7..c9c742c80b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1458,6 +1458,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>      return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
>  }
>  
> +/* Check if the SMMU hardware itself implements secure state features */
> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1712,6 +1718,55 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
>      return 0;
>  }
>  
> +/*
> + * Check if a register is exempt from the secure implementation check.
> + *
> + * The SMMU architecture specifies that certain secure registers, such as
> + * the secure Event Queue IRQ configuration registers, must be accessible
> + * even if the full secure hardware is not implemented. This function
> + * identifies those registers.
> + *
> + * Returns true if the register is exempt, false otherwise.
> + */
> +static bool is_secure_impl_exempt_reg(hwaddr offset)
> +{
> +    switch (offset) {
> +    case A_S_EVENTQ_IRQ_CFG0:
> +    case A_S_EVENTQ_IRQ_CFG1:
> +    case A_S_EVENTQ_IRQ_CFG2:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +/* Helper function for Secure register access validation */
I think we shall improve the doc commennt for the function. I understand
@offset is a secure register offset and the function returns whether the
access to the secure register is possible. This requires a) the access
to be secure and in general secure state support exccet for few regs?
> +static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
> +                                     hwaddr offset, bool is_read)
> +{   /* Check if the access is secure */
> +    if (!(attrs.space == ARMSS_Secure ||
> +          attrs.secure == 1)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Non-secure %s attempt at offset 0x%" PRIx64 " (%s)\n",
> +            __func__, is_read ? "read" : "write", offset,
> +            is_read ? "RAZ" : "WI");
> +        return false;
> +    }
> +
> +    /*
> +     * Check if the secure state is implemented. Some registers are exempted
> +     * from this check.
> +     */
> +    if (!is_secure_impl_exempt_reg(offset) && !smmu_hw_secure_implemented(s)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Secure %s attempt at offset 0x%" PRIx64 ". But Secure state "
> +            "is not implemented (RES0)\n",
> +            __func__, is_read ? "read" : "write", offset);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>                                  uint64_t data, MemTxAttrs attrs,
>                                  SMMUSecSID reg_sec_sid)
> @@ -2058,6 +2113,10 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>       * statement to handle those specific security states.
>       */
>      if (offset >= SMMU_SECURE_REG_START) {
> +        if (!smmu_check_secure_access(s, attrs, offset, false)) {
> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
> +            return MEMTX_OK;
so the access to @offset is not permitted and we return MEMTX_OK? I am
confused
> +        }
>          reg_sec_sid = SMMU_SEC_SID_S;
>      }
>  
> @@ -2248,6 +2307,11 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>      offset &= ~0x10000;
>      SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>      if (offset >= SMMU_SECURE_REG_START) {
> +        if (!smmu_check_secure_access(s, attrs, offset, true)) {
> +            *data = 0;
> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
> +            return MEMTX_OK;
same here?
> +        }
>          reg_sec_sid = SMMU_SEC_SID_S;
>      }
>  
Thanks

Eric


