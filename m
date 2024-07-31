Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080D4C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyRv-0003Dr-Oy; Tue, 30 Jul 2024 21:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyRu-0003CL-EU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:48:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyRr-0000lD-U7
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:48:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso3668717b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722390494; x=1722995294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yx+blxF0nJcVP6pjbRxGnGBYG+43Yu8DIozXrpu3MaI=;
 b=noSF5Q+VZ+qKb9K7Iia4WMqkDw7bhTpEzyNr4qOb0XLTDJpIgCOddgDYyQpWF3+w2o
 GYLxdGeVcei2vyLyVVej8RJYN7uSgylD3sIjUpedvijsugKDe+urrA65oxzPlfLGdDzJ
 XcbzNmWMR8N2sbpyc5I//8XUanPihqfRDjE9d3Lq/Poz0UJRXx4qS0AdrpnZpJHNIb8n
 v+877g2dOAMGsvUPMvw/Iw37CoIv+v0yZD866ic4BKna9vA3AdZUi6JA8mx5OwNKIXJ5
 IwcjWzkA2dKYfCHtXUKIySO/GQWOywkGAxbvZX30/N8L+L1mDDNjf466NhQOn/8NAFoc
 8vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390494; x=1722995294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yx+blxF0nJcVP6pjbRxGnGBYG+43Yu8DIozXrpu3MaI=;
 b=VC/IcFFRDnG7uez30qyh13F9D+IQAon1NqkfQtvoqIEv9T7/cZPdVRwZqTyo7GkliT
 mF2ytTMT6MJAnwyYLjBvYpBdJMYX3kK8IWZP1wFAgFX+tJBqHOBElEqLhnUwZh3m7Y+m
 NYLa/HuUnC7C7TiHsHveWqjqSQqvb1tIyvdk+Yb4iTm4LYU8fbB0/eMuCCb0/3P61Nw1
 sQGWqYXgJtoJ8lzQwNUDNjlTH52nDM5msLPp+Pyddg7tPmJBG79XNtYHLu/vnJKgFBlH
 TPt6RPYFTuv2Zg5HTjG9eU3DU4f0B1ofOypY7/Orff5u9quGhu1DyBP4XzmqT+RTnmTU
 h/PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY/7qMpgjSo53qLL4RIiXZoP9+PPNxWz/zto8UR6L3Gb0v5dFELd/87i6IuVJCgwSqADJa79HTsVngR50Nj1MkftbJBmA=
X-Gm-Message-State: AOJu0YxXV3JlKa9OEtgXPbtCRHaiDQ3QjO88Z3j8dHqQ/OQcBYA1Gpig
 xwneExSB73fR/04gQzTGmo0M0CXjka6FrWunLpvFMTORVdWWEl4V8q2BaLgfvDA=
X-Google-Smtp-Source: AGHT+IE9lfwB/iiBM6UoPxGjCBlfa5BFZ+HgplEz0x7Dx6LWeqpDCnXh20bqptlNmp/2Pz1sZT8UXA==
X-Received: by 2002:a05:6a20:3d83:b0:1c0:e77b:d37 with SMTP id
 adf61e73a8af0-1c4a1179211mr12121675637.9.1722390494117; 
 Tue, 30 Jul 2024 18:48:14 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f1cdcasm108601955ad.198.2024.07.30.18.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:48:13 -0700 (PDT)
Message-ID: <e0b7d735-e54a-44cc-bcb0-ef6f4518da5b@linaro.org>
Date: Wed, 31 Jul 2024 11:48:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] target/arm: Prepare bfdotadd() callers for FEAT_EBF
 support
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> @@ -2790,7 +2790,7 @@ DO_MMLA_B(gvec_usmmla_b, do_usmmla_b)
>    * BFloat16 Dot Product
>    */
>   
> -float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2)
> +bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
>   {
>       /* FPCR is ignored for BFDOT and BFMMLA. */
>       float_status bf_status = {
> @@ -2800,29 +2800,50 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2)
>           .flush_inputs_to_zero = true,
>           .default_nan_mode = true,
>       };
> +
> +    *statusp = bf_status;
> +    return false;
> +}

Looking at the next patch, I think dropping the local variable is better.

   *statusp = (float_status){
       ...
   };


r~

