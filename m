Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E976C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLQa-0000Of-SL; Thu, 20 Mar 2025 15:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLQG-0000L1-U4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:19:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLQE-0000Bc-P2
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:19:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224100e9a5cso23569325ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742498357; x=1743103157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tq5F+LFSz7I94wi2CXsI0zOfb8GaJ/jWhQMTyC+MdfY=;
 b=O9BhWGpQr8Zn9TNXhJlxk3rutFMSRSvyLZiZX0ZcimTl1f1wocjFx8az+ODpYZuK0W
 eGFzwynqF/9u600OVRe3WzrzSXjMWWP3ypzxYrSv97SCEfyYh+VfGg12tHDSqGB4LQTO
 I8QX41Ue+sskoVJTUZtvMEznRB9O156L6fES/dl9ZXeOIfCyEChcExNdUx0e3SW8Dimz
 SXMiYpnslqM0BNgcDwziHQ+41Kwv8h89Zba2/kS/LG1zGFP/8C26V7pkw67w0efzy2ny
 XigRSM/NEMYq5062qhegUj+Fe1/gJumlRQRuutI2RKDP7pQL9Y8P6HO+HicMChArDyq9
 191Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742498357; x=1743103157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tq5F+LFSz7I94wi2CXsI0zOfb8GaJ/jWhQMTyC+MdfY=;
 b=K5BXVJ/sI0q6xj5ZG67RUGtoxxH9eQddkUCwcz3Ho97O8TcrIYef319JPa/13HNrOo
 xToPwgJExNA7YyPayfh3EAcYP/kRTfULh+0ICt1+uanewuzAUMnHhMDbRUFj/a1Vo6bI
 ag9OQdXYkhmmOnH5Cj39uo+HaimRWja5dNGYQPsA7ELpDM4pGc6LomBScVqqR8r8Opu6
 qMmUWtkvI6hmvccGbHDIN+BOdM23ZKLrcQssc+rE6x4VtbDPqeDbx69pB8dzERIdeTnw
 ORPGNCYS/z+gc7QVkojEtLDWBnbJv8DrfLaKolz71BuUxJyCZumgxy27/Sa0F66OVPVR
 TgEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgInbDeJ9F23vlOcjprypOWRtwatR5xI0pg3PVCmeXu66zgE/ywVWUB0RqO/lYsjhNibbzA2UMWTd8@nongnu.org
X-Gm-Message-State: AOJu0YyDWHG3rrDK3U6gmiSawL694V30UkjH0tPpBhFc9cTNB/ATjbcZ
 Ke78iLkSIKx5putrY9HkRg4uSRA1W2c2nCp8GzsszxhveXIE5bWCGA5usDdZFro=
X-Gm-Gg: ASbGncvAODOfIkWFPcF1B6VzginNZTvmJjf3cVQUTd1aFDChz9FlLKRyszkZyQ4JqpJ
 7AxVpji6DTiPwk/wadTTn3gZz7Q7oLtYNk1oCl25+hG97DyavXhwfhRwz8ZVjZL7zHvtV2NLjPN
 Tk4FRASebKYskxYQbHg/V6hHs2XAVcR1KxQLnCgYsocLiSLYoIJsNxcAIzk0WA3MUlmBEMxt2F5
 MpnPLYnDrvTUxWGwXk0kQeRVIMgQndkvHPqrcFd8CFsAShtzGp1YkJSGr6QDcIlXKnRM+BqGOl2
 CcSvkR+IP/ded01Wf0ZOmXeS4MNEQIA5cJKrvvzZoljXE8ZyetB4Zxpzgw==
X-Google-Smtp-Source: AGHT+IHnxwSgcecrpXyfAh4nU3RDQ5gC7c6RX8ocuRb2dcZ8am6818rs0+JuCbrRatAoRrsb5qQzlA==
X-Received: by 2002:a17:902:ebc6:b0:223:39ae:a98 with SMTP id
 d9443c01a7336-22780d825c4mr10603855ad.22.1742498356861; 
 Thu, 20 Mar 2025 12:19:16 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f45a7sm1512305ad.223.2025.03.20.12.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:19:16 -0700 (PDT)
Message-ID: <79b3715b-c8e8-4fa9-8bb9-d675a56be7d0@linaro.org>
Date: Thu, 20 Mar 2025 12:19:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: assertions: add static_assert
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250320115521.808019-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250320115521.808019-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/20/25 04:55, Paolo Bonzini wrote:
> Add a new assertion that is similar to "const { assert!(...) }" but can be used
> outside functions and with older versions of Rust.  A similar macro is found in
> Linux, whereas the "static_assertions" crate has a const_assert macro that
> produces worse error messages.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Supersedes: <20250320113356.799412-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
> index 104dec39774..bba38cfda11 100644
> --- a/rust/qemu-api/src/assertions.rs
> +++ b/rust/qemu-api/src/assertions.rs
> @@ -120,3 +120,25 @@ macro_rules! assert_match {
>           );
>       };
>   }
> +
> +/// Assert at compile time that an expression is true.  This is similar
> +/// to `const { assert!(...); }` but it works outside functions, as well as
> +/// on versions of Rust before 1.79.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use qemu_api::static_assert;
> +/// static_assert!("abc".len() == 3);
> +/// ```
> +///
> +/// ```compile_fail
> +/// # use qemu_api::static_assert;
> +/// static_assert!("abc".len() == 2); // does not compile
> +/// ```
> +#[macro_export]
> +macro_rules! static_assert {
> +    ($x:expr) => {
> +        const _: () = assert!($x);
> +    };
> +}

How about using something already done, and exhaustive for this?
https://docs.rs/static_assertions/latest/static_assertions/

It provides a lot of convenient asserts related to types, traits, and 
configs, which will probably end up being introduced in QEMU Rust at 
some point.

