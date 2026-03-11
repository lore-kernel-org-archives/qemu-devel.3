Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D957103E2E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 22:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RsY-0004A0-HC; Wed, 11 Mar 2026 18:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0RsX-00049s-Q8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:18:09 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0RsU-00062K-IM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:18:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-359f35dfef6so175413a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773267484; x=1773872284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LzBqCwuN/iK8IbM5ajAVsOTNH0vG60Ih9ZnsHIuhMhk=;
 b=C/2HmQppgjoe/+4O0HNB6Y6D5Fez+R1fzdcmMHbk9zapG16XRE9+XkuSLS90MtzKBz
 uwMhhOISrfUZJvXHnlVqS/gxsrRDouTrluMvc4gKx/HVr+wF5c9RLEY7+YDXWm+R7iaK
 QdJS2vgNiJkiPPe0T/c/omM49P+X3vOIh4+fymYL3YZq8wwtobkFzw3tjd4lrCudLJza
 +6852rWVsjRN0WeCoQ6WqSOTd74/UCcMyBzhSKaQuXY/QKnKaerX9t+EPRW4RTLJY1Jz
 u5tEJvhQW9/pZy11r94x7T78G0va+ZeBl63BhRQsA3Wtz/qBaVLkgxpTU2aLBjSDnZAh
 2IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773267484; x=1773872284;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LzBqCwuN/iK8IbM5ajAVsOTNH0vG60Ih9ZnsHIuhMhk=;
 b=cPlxcLI9oBs7Kpg0C5vTmHep2XXrUhgAtB0s+NH8DZIaNZ6kPEu1CvVKKoNbqYqg5D
 /VtfUdXO6L/LBuUjjdKmYU1dn37V2haYbSqwrT6rgHuk5mR+GPs31hOzdU3cnDI60G/l
 ZzuOIgAbSMy4OfWPW7W2EGsRaNHlg972EVvJ5mIXSqKO8MYaVVXKwt68NV9H5dOa3H2v
 svc2KHQA3X6zCEOqg+p4MJ8GEtKNRRL+eMGPjeRKTmTfYOO/Pk24zXPFFLdxE0uPm4mr
 Wnk6UdfTtT5dClQW+1TCctqyC+r9NsBg4CCBRgEX3JWthk5I6OCULH/ggd2oJaEN86/c
 99Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUdcM0zRbwy9AfUmUA3P4a4awPMJPbdePHxMFh6glDYYMo15aUAUFj3MQQQp47xuSzPa8EzWSw7mHs@nongnu.org
X-Gm-Message-State: AOJu0Yy7gTt/PrjtW/8Pe1I1HefsL+mY6BN+0DZZHolmOcUkDHloc9eg
 AJV5hDtSyk4jlV/4A6tEttutoKIlFHlvsTmnaXjSG3VoP8DBaoCp3hpHV3Lkp3s3/Qg=
X-Gm-Gg: ATEYQzzF01YCpMxCQuYrIVbIrVfQi8H0L5LZc+Al1EUuO+OBF2P4OSZBHfENA1sjEUu
 JSfQV0wsJjTxc1R7ikKqiKnBDc+MHbkZbwrMJsTkci61mKHtSVs14+3Sdn5zO9t5Wz94bepTYdF
 vx3aXhw9rfash5KazEuGxEWOmO1q4YapPKpqRMN5FGhbGfsE1CqrZi3sqrlHRbhKNgzTyBMrWzD
 pD/TC5TSD+A9s84rmECAvszogBqT5VffuVKJlcB0jAwxkAqcIQXB6YG/9JFAgqvBVBH1p6EixzO
 uZL7zjYRk2uoelXjyebo2bVvA7CM7bQDhd2qOSHBYVQZp99M6kAJW/BTVdK/+RrQE6M4yWLdk/6
 chGRi4zGot1aAMtC6O7sG5jxWN051jgEA3bVuEGXJUtPp56lxRn+FO6kg+7g40SunvjR0qMojGR
 60fqBInJRpcQGcAUAH0GGDCNu1nfFz+RBwKdWavfSzRm4bwADtjXT9trQbtcyWQlkUMEE/
X-Received: by 2002:a17:90b:3844:b0:353:49f2:1e7a with SMTP id
 98e67ed59e1d1-35a0133c134mr4029226a91.17.1773267483369; 
 Wed, 11 Mar 2026 15:18:03 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02fc8465sm3225955a91.9.2026.03.11.15.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 15:18:03 -0700 (PDT)
Message-ID: <8b0df43e-aa4e-4d2d-a975-b43144503268@linaro.org>
Date: Wed, 11 Mar 2026 15:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] docs: some doc updates
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20260311102626.46546-1-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260311102626.46546-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/11/26 3:26 AM, Mohamed Mediouni wrote:
> A documentation update, no code.
> 
> Mohamed Mediouni (3):
>    docs: remove 64-bit only mentions for accelerators
>    qemu-options.hx: document Hyper-V enlightenments accelerator option
>    docs: mention that WHPX supports Arm too
> 
>   docs/about/build-platforms.rst | 4 ++--
>   docs/system/introduction.rst   | 6 +++---
>   qemu-options.hx                | 5 +++++
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 

For the whole series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


