Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DC6C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrah-0003ay-It; Mon, 08 Jul 2024 12:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQrag-0003Wl-74
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQrae-0008SC-7D
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720457506;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSnd0i7P0nG6+oAmjYKaVL2/5qRtYO1496V8NqLX0b4=;
 b=KTatiPGOayIARhR72Dtlu0mc7KtRfsl/Vcbz/MaU5BKf6l9huup4p+b/+qspG+fU5DQMOO
 FXB+/2E2bw9slPETI5kNihZwDAk2qQgJQB1jVA9qwqkDE5bihzovVch69I+Y1JBzQAU9vH
 BeRV/kJoR9FzqTdfmcMQmJmkgSgzf0U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347--IIVP2qiMwu4kRfIxdH9-w-1; Mon, 08 Jul 2024 12:51:45 -0400
X-MC-Unique: -IIVP2qiMwu4kRfIxdH9-w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so2531859f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720457503; x=1721062303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSnd0i7P0nG6+oAmjYKaVL2/5qRtYO1496V8NqLX0b4=;
 b=SmIaihDYHsgC2OldPfJsmOKBbSSQnN+LRCxXVYrKtMctNvknIhHQoGxr9+Siv820us
 llyaiVNJdmx3bLa6swQpJgY4lqVPJkZENffeImUtQcH54OcUG0vF9y7Xy1mVruvBdkjf
 X6LHoj3BuEZurYTIvh/1tR6c7BkfgfSovBJ00fwgmB9KKfDGdrhHQG/n2mZUmF4CjynK
 Izw9m6hdySNPnz/4JeU+FlG2WLOBafrcGLJT+iPHEQ8l86DlsGeT9YjBWFqZmfeSpVAa
 wxgt3hxMJ5qnvLb/PjXNbYM31tabjZAGc8xFckH0yTMmbPk7vZTvHcax4Q9HO2h16MNR
 pxWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV44ypbV450eE1DO9lXV3oNpp09y1ecKr61CLL2ke+nPRG0lgrr5g+I/q5B3wOGpOT4H8RXUYTXgq++yF+aDjn/MIqUIL4=
X-Gm-Message-State: AOJu0YwYSOO0OKR4tkzZrQnxM/s7rqLrd76rIijnpBE+axfGfKde8H/K
 t+UN7eO9d/k3e7dScxHtxlZEEkUq08ZAzdvvn8fwdcTJr+pPWPGK2/0J+WZEU/RpNOU0ERxGoB3
 z71kZkligqMMy+jjc2tTPGHss/tUL0ZjM5XmG/GhZT3bXhyR8x7mlvXvLB8RK
X-Received: by 2002:a5d:5847:0:b0:367:9614:fb99 with SMTP id
 ffacd0b85a97d-367cea46a4emr169238f8f.10.1720457503627; 
 Mon, 08 Jul 2024 09:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+9ObSIkf2x/we97KYbHSkH8jz7mZv3rThiNHBeso32jhoiby+JV/ZQVvNOqOvP5Lb5IePbw==
X-Received: by 2002:a5d:5847:0:b0:367:9614:fb99 with SMTP id
 ffacd0b85a97d-367cea46a4emr169223f8f.10.1720457503274; 
 Mon, 08 Jul 2024 09:51:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab199sm241520f8f.106.2024.07.08.09.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:51:42 -0700 (PDT)
Message-ID: <69fb7fb2-52fc-4d03-bfd6-deb2a254f081@redhat.com>
Date: Mon, 8 Jul 2024 18:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] hw/arm/smmuv3: Support and advertise nesting
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-18-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240701110241.2005222-18-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Mostafa,

On 7/1/24 13:02, Mostafa Saleh wrote:
> Everything is in place, consolidate parsing of STE cfg and setting
> translation stage.
>
> Advertise nesting if stage requested is "nested".
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6c18dc0acf..807f26f2da 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -261,6 +261,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      /* Based on sys property, the stages supported in smmu will be advertised.*/
>      if (s->stage && !strcmp("2", s->stage)) {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
> +    } else if (s->stage && !strcmp("nested", s->stage)) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
>      } else {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
>      }
> @@ -425,8 +428,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
>  
>  static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
>  {
> -    cfg->stage = SMMU_STAGE_2;
> -
>      if (STE_S2AA64(ste) == 0x0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 AArch32 tables not supported\n");
> @@ -509,6 +510,27 @@ bad_ste:
>      return -EINVAL;
>  }
>  
> +static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
> +{
> +
> +    if (STE_CFG_ABORT(config)) {
> +        cfg->aborted = true;
> +        return;
> +    }
> +    if (STE_CFG_BYPASS(config)) {
> +        cfg->bypassed = true;
> +        return;
> +    }
> +
> +    if (STE_CFG_S1_ENABLED(config)) {
> +        cfg->stage = SMMU_STAGE_1;
> +    }
> +
> +    if (STE_CFG_S2_ENABLED(config)) {
> +        cfg->stage |= SMMU_STAGE_2;
> +    }
> +}
> +
>  /* Returns < 0 in case of invalid STE, 0 otherwise */
>  static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>                        STE *ste, SMMUEventInfo *event)
> @@ -525,13 +547,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      config = STE_CONFIG(ste);
>  
> -    if (STE_CFG_ABORT(config)) {
> -        cfg->aborted = true;
> -        return 0;
> -    }
> +    decode_ste_config(cfg, config);
>  
> -    if (STE_CFG_BYPASS(config)) {
> -        cfg->bypassed = true;
> +    if (cfg->aborted || cfg->bypassed) {
>          return 0;
>      }
>  
> @@ -704,7 +722,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      /* we support only those at the moment */
>      cfg->aa64 = true;
> -    cfg->stage = SMMU_STAGE_1;
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
>      cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);


