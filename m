Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60283CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLS0I-0000i2-IE; Fri, 08 May 2026 16:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLS09-0000fw-4E
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:40:50 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLS06-0001gq-1y
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:40:47 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-47cbd445021so1428606b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778272845; x=1778877645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PSWPIr97x3tuuSvWr8rkm2/CIIhC4NsePasPoT/2Vmc=;
 b=pUKNBmfYzSAK3FRgJIb/IuJhGSICSJd8w0uoj6CkaQb0SQ4fxwVJakFcVy3T2jOgGH
 zdSZsuEnKtdOOd+FAM25ULyErdHGMXGoj+bsJKzCTW1LFj4TU9uckzDaJb/0kd/7FNAt
 Exu3Uy/81iAXz6DwGwrkXPcKc6jfL1TLXS5n/YM1DGjBohSwKUi2hfoJCNvl3hmgFjrj
 syLkhSFYoqshkFhQgpxc5KUP7Bk3+QpdnDQttdD84mOCj+nTqOzhyJ1w2gMSZRJDAk0y
 ydRcx8Q7w8C2ljFwBpyibotupnR1x1clsGRVZeGnLxqS+JEv9w2dc+cMgtnhrQVRfIOe
 ywkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272845; x=1778877645;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSWPIr97x3tuuSvWr8rkm2/CIIhC4NsePasPoT/2Vmc=;
 b=p7lQG1WqzlA727qM+IG7ahuQ6tUor5ocN5ePjthXMT5mDBRGv0l9b5Vv2UoNWEsLsF
 csdZryTFsSIsX0zdHeZyOMu3VHB/rA4WvH5ylhHzproZXwg+uKBd6Vm8tMI7iNhpcELY
 ee6vF1hypzMBQ140USQOD6HLDtIvtvLm/9xrYeXpgz5pK++dcXa1lw3cEDxrTkhNOPHc
 UAjJnLTnqJ/MYPT9GeeUFahiyJbp/W+h2jRHYua27Q8SZt7lxPqB5fl3d7HhX4+ML05j
 7d5ht317h1HVaI/OQXxLv8rGg6/EodEXpNBeYWMQUFGMI6nrl41qXqv0HFejt3QS5Tk+
 Nr9w==
X-Gm-Message-State: AOJu0YxO9xI/wm9mzgVszxizr0k9kUt5wuAPWqC6le/0pMPYB1JjANbz
 vbluW7l7G2fti0lbWBdjt2mPFGoQZ3bd9evaH7dm9iSI5yoXt3hSw1uUCqEZaEcgDbhaijExCrw
 1FqQQ
X-Gm-Gg: AeBDieu1lgxMANNovMkvgsIhf0or2MkjMJxpxnmEkHV31JEUT6JYJO2dh2mc60Ck+/p
 ii+bxg/to7qYE6vb5WTZ3fxZdDsl+gzheQKJ9eq8eV9DBZQBL4/KydaHQVV2inO0XXRbR3JC0Lb
 MxzfeUFG7PaJ30144VBu3rq7se41G2cbx82AH1kxpd+7y5U3hDRhBAsaamMXQYj/Rt3gDATjVx6
 rD7yjpGfFFVnXNSGq0glB5qAIxxSKYR07Lu7T7U7wFtR3IdjNz6xif45U9tG6ZSA/uOuLieKD0F
 OJLQL1fsGGMRKouOe0melLF7H6Mq0tmZFDsYkyKRksdHvtlKsQlQ2qbgrQvGFiRTFdUPNwSR2dn
 u+9zKYVXSDc1/4l+mr9I5GN5gQPwQsvtGY6Yd1dwBbMRXopQbSuQX4X9PqhQZ6U4lGliBb/M/Ez
 uJSP/KWICEnlw5uQRw3vh0mn0Is7ZAo9uaL9gG32CQ0HZR1nXEO1fcDfH3Mh6DhR2NlMYi74+LU
 A+d114=
X-Received: by 2002:a05:6808:c1b6:b0:479:dac7:afa5 with SMTP id
 5614622812f47-4807fe5c82emr2725797b6e.47.1778272844782; 
 Fri, 08 May 2026 13:40:44 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b67sm2536638fac.6.2026.05.08.13.40.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:40:44 -0700 (PDT)
Message-ID: <3a7ba262-9344-472b-9154-b3bcd61c73b4@linaro.org>
Date: Fri, 8 May 2026 15:40:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/display/exynos4210_fimd: Use LOG_GUEST_ERROR
 instead of hw_error()
To: qemu-devel@nongnu.org
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
 <20260508162013.2751001-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508162013.2751001-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 5/8/26 11:20, Peter Maydell wrote:
> The exynos4210_fimd device model uses hw_error() in several places
> for "the guest set this register field to something out of range";
> update to the more modern LOG_GUEST_ERROR.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3405
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/display/exynos4210_fimd.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

