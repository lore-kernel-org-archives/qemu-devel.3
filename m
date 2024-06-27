Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F3C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs7A-0006id-Rf; Thu, 27 Jun 2024 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs79-0006i6-Rh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:36:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs78-0006Gw-7U
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:36:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-706524adf91so5110287b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506209; x=1720111009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rACG/vuO/S3Vlzq5anwamEbvv6JBpN3kidbAkLumh2I=;
 b=pZy+8s17idcNtQi05/7aWUmlXDAxW2OjPwzPOghOpQAWbKmJxGgV6CXTx/ZuF+eBkL
 COgCXnGx7AjV2QFg+pOS7jJlEZALyD5NGbj4QPU5HJon0V4cDuuwWlZZG0Va+bnMYQCd
 +cUM+ojeQEnFd/1js/DWOulGwt7L/pUFwcg+uTbylyiyThj/ETcNcAi207G44clu91lb
 qWF6eB5NHOp3ocDy/A8jryJT4kse+MZow0yl4eU7aFaxKHw8ju6zlbPE2pt/Cf0muTAG
 P0fg1CYwcVbKeOYw+a8GPwppsB5OCdStmpqFXArlaiRnoFoviAk5MG/pOAvq+zt4Qu2z
 7PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506209; x=1720111009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rACG/vuO/S3Vlzq5anwamEbvv6JBpN3kidbAkLumh2I=;
 b=GUpzf/NZ6kGtjK5LZ1ptRfusRHzWBhvOilvTEgdxB6OTZ18D+xNS+YSM2x4dUIcyH0
 zWkd10zSQ3SDGQtz3CmNrLYZUU0gBY6rRCxa4jfzB9wmeJ+Hof57j7a9t8wVrxmXmPr+
 qvyJCu0vsGjebKbL/vFrUnVSrXBCflEAHpkap1iAt7ZNLu0buTDKfEy9XtByI8VCvL69
 emEha7mugFccW7eU9lV8pf9FHAYVNSxdv1rjhmX+fkGjFmq3ZRkxHq+9yHKNNwgE2Uba
 2W8dlb2HlhfFFLaCiyAbiPKLAK4FX2Z67RAa9VAiw4b6bpEtCSv3aIa1MzM1bjcbPSRb
 erUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxnw71yB87Z9OEi8y+k31+FcD3oyxmFUJcOg37UZVuugVWzj4wz0LqQn42SQubMwO1tzH4NbxPvCp4NzQirtw75mA7qAw=
X-Gm-Message-State: AOJu0YxXRxhxzW68QNDNbwWB+uWQqXK952MXuTE+QEBS8kMRYeB1v4H/
 h+EKaV+RV3WytYibqBDCtdJk7KEQivC+f5ogVIJqB7kZvg+widZnzDIr0fPOUtE=
X-Google-Smtp-Source: AGHT+IGtmSKcFFZYhQidbILsYW+XPiLdp3bewwcy1kpjJeMtlOoAsYTGu9laC2J6e1Apy6YGn+6+TQ==
X-Received: by 2002:a05:6a00:1703:b0:705:9bd8:4f57 with SMTP id
 d2e1a72fcca58-70670e8fbc0mr18123428b3a.7.1719506208684; 
 Thu, 27 Jun 2024 09:36:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a072e5sm1566304b3a.105.2024.06.27.09.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 09:36:48 -0700 (PDT)
Message-ID: <6144d10c-0a03-4c88-be37-9ef937b3acad@linaro.org>
Date: Thu, 27 Jun 2024 09:36:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/i386: SEV: store pointer to decoded id_block
 in SevSnpGuest
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org
References: <20240627145357.1038664-1-pbonzini@redhat.com>
 <20240627145357.1038664-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627145357.1038664-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/27/24 07:53, Paolo Bonzini wrote:
> Do not rely on finish->id_block_uaddr, so that there are no casts from
> pointer to uint64_t.  They break on 32-bit hosts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Yes, that is better than my patch 1.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 6daa8c264cd..2d4cfd41e83 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -153,6 +153,7 @@ struct SevSnpGuestState {
>       /* configuration parameters */
>       char *guest_visible_workarounds;
>       char *id_block_base64;
> +    uint8_t *id_block;
>       char *id_auth;
>       char *host_data;
>   
> @@ -2170,16 +2171,15 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
>       gsize len;
>   
>       finish->id_block_en = 0;
> +    g_free(sev_snp_guest->id_block);
>       g_free(sev_snp_guest->id_block_base64);
> -    g_free((guchar *)finish->id_block_uaddr);
>   
>       /* store the base64 str so we don't need to re-encode in getter */
>       sev_snp_guest->id_block_base64 = g_strdup(value);
> +    sev_snp_guest->id_block =
> +        qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
>   
> -    finish->id_block_uaddr =
> -        (uint64_t)qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
> -
> -    if (!finish->id_block_uaddr) {
> +    if (!sev_snp_guest->id_block) {
>           return;
>       }
>   
> @@ -2190,6 +2190,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
>       }
>   
>       finish->id_block_en = 1;
> +    finish->id_block_uaddr = (uintptr_t)sev_snp_guest->id_block;
>   }
>   
>   static char *


