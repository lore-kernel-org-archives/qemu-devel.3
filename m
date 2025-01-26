Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC92C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2jJ-0005NM-5R; Sun, 26 Jan 2025 08:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2j6-000590-3h
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:31:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2j4-0004Xx-Hj
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:30:59 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso58322355ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737898257; x=1738503057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlY71SNYgk7QC67qDDFZMs7k3zolz9eizgaAdkILSd8=;
 b=QQrwpafcUVe2euyffdZKQEbw7f/YhVGfHWgr4VpxE/y+2wwQJAqI0LSEnATZS1Vnpl
 9hYHQ8r+EfjTx0eUlhldblijw2L3uUh9TsHHGmu+8/5RO44WvnaNVZVWpJblLsNSCWQy
 MPvdO6qAeTiC/G+NGlpv1Pb1LxNK6xSVQMArAclBrDNpHMb6kUytO7hH6Kgupu/crdZZ
 iqXoP33j0DylQmhPTMCkZcj+FvYFqZgYbFcTuGySVyWfonbEEGnHRFM5rtMT7H/Wcunq
 /PmqTC/1A32szQl3DEcFt4KYbzQ5uu+N4Jd061X4bZCnZcjMkZED9qSLk9PaxHexe2MZ
 WkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737898257; x=1738503057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlY71SNYgk7QC67qDDFZMs7k3zolz9eizgaAdkILSd8=;
 b=h0GpJwFwWGjG+yZhv9RYuGM7++txUiOof75Mpi9OgUhUntUjOcnXKWZNN8QxDqB9Cg
 xXQW4SWVESB6JhWExenEuMyz28PQ99s3wDD3/ENC0dZetJQodQOdgWlupASp5ZQ3RAo8
 RsNxwnScBYex4UA8O2MxQs3uAD8uKA95KHAhv34BOCBbGsQCtQgWa5xKg16YxfxuIIUa
 2PcecYzPJLwXCyojHxFxFoVLaZWKVP/lFmvtUsaq/MTSzGm945zm6+i9Q8MtMhU+zDlQ
 04e1SvLqzSVegAFNppsIlBlHtSN4auOe6i5kMoRX0wRLVrzNBYXWlDCuNZbfYM5+0Uno
 dwXw==
X-Gm-Message-State: AOJu0Yy/Kzj/ZeolTQajI7PHnIsBVTYcQbzj6WI5RgmAFspoJ/4JxyqV
 i7ZDVjLQX+d7WxPv+wzMmFi1BaI44jgzapFhVBCsc4AYgeGihR47qD+iSSbIBxmV39hFNGmBEBa
 f
X-Gm-Gg: ASbGncuB7mbILkI0jcHe2BiGp7LbwUXZwuTHvXaWhKxu60frvynG7b+bTj0cvo5dF7x
 v8OcBnZgJeOEpN36KaeVWYrFK8w1ZbQG/5Jzqg0fV8T9SsssYX4QEVex5/rHhomlXNBZcaFajJD
 Y6/F1q9SU1XtUSMUvhNZhbF8p2mjaayeXvg3P9h0LZaAfoTf70CNbv/qU5nyFoo0J4CeN2RWwZq
 Nf64d3UTWiAKSFJ1kNfpxdok7IFG+0jGFQOLH4a8b/SpuSxOSZlijUVjbrvkhoSayENGymTY4Y1
 hWtfh8NmYphQkGUXGGIAT94=
X-Google-Smtp-Source: AGHT+IEzf04gNhdEzLNeqyhDe4i5jJgAaD6u7glmqDD57SDrpHCTfeWRmiBfAakQqP0KTBu3MJJIwA==
X-Received: by 2002:a17:903:124d:b0:21a:8dec:e57a with SMTP id
 d9443c01a7336-21c35619607mr505605535ad.48.1737898257126; 
 Sun, 26 Jan 2025 05:30:57 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3adesm45773595ad.74.2025.01.26.05.30.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:30:56 -0800 (PST)
Message-ID: <1ebf9d7c-8825-4c8b-8e79-18126e055865@linaro.org>
Date: Sun, 26 Jan 2025 05:30:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 74/76] target/i386: Use correct type for
 get_float_exception_flags() values
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-75-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-75-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> The softfloat get_float_exception_flags() function returns 'int', but
> in various places in target/i386 we incorrectly store the returned
> value into a uint8_t.  This currently has no ill effects because i386
> doesn't care about any of the float_flag enum values above 0x40.
> However, we want to start using float_flag_input_denormal_used, which
> is 0x4000.
> 
> Switch to using 'int' so that we can handle all the possible valid
> float_flag_* values. This includes changing the return type of
> save_exception_flags() and the argument to merge_exception_flags().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/ops_sse.h        | 16 +++----
>   target/i386/tcg/fpu_helper.c | 82 ++++++++++++++++++------------------
>   2 files changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

