Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96039C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xWk-0001hm-Ih; Mon, 31 Aug 2026 04:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xWi-0001gx-QO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xWh-0003Oi-7S
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788165478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xm+pMxyZm91RAF50pCHOwFUgLtnKlSaqBBHSzjd4x54=;
 b=W328KFhw8wdnTkO53yiCIqjBBcy7WIKxszbkFsggU88qIs1lutfC2CimN+DLbpVDFCUXfZ
 02rZGxVbK1K4dOrBo+oLR5OHoWTdTRzTPn1ukrcz75jt9mtfAtK93MqOX7Xh05+3WSUlHR
 j5Zdp0FJeyrkNjhDiID+v+onIP1ZGAU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346--91dtCw8PKW4bY1QHJ5nfQ-1; Mon, 31 Aug 2026 04:37:55 -0400
X-MC-Unique: -91dtCw8PKW4bY1QHJ5nfQ-1
X-Mimecast-MFC-AGG-ID: -91dtCw8PKW4bY1QHJ5nfQ_1788165474
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd74fc1aaso4214045e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 01:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788165474; x=1788770274;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xm+pMxyZm91RAF50pCHOwFUgLtnKlSaqBBHSzjd4x54=;
 b=KMHCBrywiSUzoE/xP4SjufO1L2VKNTblF/QPMYAxLuT5ZOjLDJnLlchr9J3MqRnD5O
 OHUbz72CdHIUyy9eY/Fb28QPVAHWNhgR0tmitlT3m7j/9ESD5cVpARsd19M1DyvSbm5Y
 9mR82Jm5qjYZxTHxN+go5zJc6NhpzxkJR9KbLcu+iwoQW9wU+tbDtfrIbhKEOO/FPb/B
 G16I5MZUsvwoArqN7weRFTQwC8AnOCId53JY6iatWAwipz3a5uPvqp8Yzv3XLjlToMpt
 8OmlGm4/ADVcyPrKt9WcbiRdOFCVGYRZWhOEVqYH+iACkjLHT4TW/n+K+s2/70nyWRCc
 KV+A==
X-Gm-Message-State: AFuF++nUi7ypIjh0MXbXZedEET4jygnZtFScQNm7DXp8gbpWyesWXodM
 Lb+0UGbexDtNoP4Zn3VOfou686KsiFoXt5I0yoMRXgA3R6iUMypUBRrgJ6R9WWWESnkzN8bZ1ef
 O0pVGMK4rLEdBhF3XOOukJ/J1NSLv1UV+WdXlEO45jv9SbUv15mAbtl6e
X-Gm-Gg: AR+sD13tjAqhYyRflwrw4q2sBAPotuNsuOefkiacFT+4msXmIIrsxFUQt2J4athDXz3
 JW8e8qzguKQcb0qDOMJk5L3G4dOnKOx153nx6xjzbzZvoJ6M0xoy0EkjMt5TIOswWEtXkd4fbhA
 LRECMtjUU4OelHvI+zJrMMnEGadX0DlasEvY07TmuB3KczbJTtzc1CkWS4FZWkt79g2EaJqj77c
 E7Ham2UWYaLby9hZYk8lQOYrFT5pGJjKYafjhxfV2yw2AqqDjzrmIXTMnPwtaP3RejdfjmhXITJ
 2Bykq4F02cC/zkBS4vzOT5F6RWk9fuG+WHBvLmC2ooGCeh9lJ3WU8JfQVc/LCkdcSPueZjDxHeS
 spMsYVpFYze24UCWSENF6YghF2GO2NTACfSz7m4h6/FXuEYfs
X-Received: by 2002:a05:600c:1f82:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49b91c19d37mr377721265e9.2.1788165474007; 
 Mon, 31 Aug 2026 01:37:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1f82:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49b91c19d37mr377720315e9.2.1788165473629; 
 Mon, 31 Aug 2026 01:37:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b945816f2sm322493405e9.8.2026.08.31.01.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 01:37:52 -0700 (PDT)
Message-ID: <b4c5b401-ddf4-48db-bb4b-310baa0405e5@redhat.com>
Date: Mon, 31 Aug 2026 10:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 26/28] hw/arm/smmuv3: Initialize the secure register bank
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
 <20260813162624.2809349-5-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162624.2809349-5-tangtao1634@phytium.com.cn>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/13/26 6:26 PM, Tao Tang wrote:
> Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
> values during the SMMU's reset sequence.
>
> This change ensures that key fields, such as the secure ID registers,
> GBPA reset value, and queue entry sizes, are set to a known-good state.
> The SECURE_IMPL attribute of the S_IDR1 register will be introduced
> later via device properties.
what about SEL2 then? Do you eventually target this in this series?
>
> This is a necessary step to prevent undefined behavior when secure SMMU
> features are subsequently enabled and used by software.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2375b7a17a0..7e7376c65e2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -293,6 +293,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>  static void smmuv3_init_id_regs(SMMUv3State *s)
>  {
>      SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> +    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
>  
>      /* Based on sys property, the stages supported in smmu will be advertised.*/
>      if (s->stage && !strcmp("2", s->stage)) {
> @@ -339,7 +340,14 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>      bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN4K, 1);
>      bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN16K, 1);
>      bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN64K, 1);
> -    s->aidr = 0x1;
> +
> +    /* Initialize Secure bank */
> +    memset(sbank->idr, 0, sizeof(sbank->idr));
> +    /* No stall */
> +    sbank->idr[0] = FIELD_DP32(sbank->idr[0], S_IDR0, STALL_MODEL, 1);
> +
> +    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
what about S_IDR3.SAMS?
> +                               SMMU_IDR1_SIDSIZE);
>      smmuv3_accel_idr_override(s);
>  }
>  
> @@ -352,6 +360,7 @@ bool smmuv3_ats_enabled(SMMUv3State *s)
>  static void smmuv3_reset(SMMUv3State *s)
>  {
>      SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> +    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
>  
>      bank->cmdq.base = deposit64(bank->cmdq.base, 0, 5, SMMU_CMDQS);
>      bank->cmdq.prod = 0;
> @@ -371,6 +380,24 @@ static void smmuv3_reset(SMMUv3State *s)
>      bank->gerrorn = 0;
>      bank->gbpa = SMMU_GBPA_RESET_VAL;
>  
> +    sbank->cmdq.base = deposit64(sbank->cmdq.base, 0, 5, SMMU_CMDQS);
> +    sbank->cmdq.prod = 0;
> +    sbank->cmdq.cons = 0;
> +    sbank->cmdq.entry_size = sizeof(struct Cmd);
> +    sbank->eventq.base = deposit64(sbank->eventq.base, 0, 5, SMMU_EVENTQS);
> +    sbank->eventq.prod = 0;
> +    sbank->eventq.cons = 0;
> +    sbank->eventq.entry_size = sizeof(struct Evt);
> +
> +    sbank->features = 0;
> +    sbank->sid_split = 0;
> +    sbank->cr[0] = 0;
> +    sbank->cr0ack = 0;
> +    sbank->irq_ctrl = 0;
> +    sbank->gerror = 0;
> +    sbank->gerrorn = 0;
> +    sbank->gbpa = SMMU_GBPA_RESET_VAL;
> +
>      s->aidr = 0x1;
>      s->statusr = 0;
>  }
Thanks

Eric


