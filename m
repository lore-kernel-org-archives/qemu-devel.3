Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641D4D4920F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD10g-0003Bm-QE; Mon, 18 Nov 2024 07:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD10Z-00031x-TO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:37:36 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD10X-0003yy-6r
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:37:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43169902057so34189985e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933451; x=1732538251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vd7pbdXii55017LG60srcuEq1aqp17J3bfINrh/lbU0=;
 b=lVMoJQyf4ozuGvQFMU37r+6zgYepvw1jM76XWklKJhP+FWaW+QlcHNfg0ibz4vMAQC
 /tTYw2MztRcVcxzgaLtFHbVFV7j/ts2c6oWSpsk4q6StiPTpkEJw43Tx+ZF4gq3Ex/ch
 ex+yZYehrns6XvDjVjCE+/9/A/56c0bf4CEqbR6cu5z0AaukywblMoLnO/+hzzipVHgl
 FJ3ysQ9z9qXU2Wi0iBTaSytaUo//mls42wCgD/jZyULPKc2gFS63EQ1r4r7z0IdwGlHi
 RAavavVAUSWqOMNTao48YxVVVtrPKOpCwJGuB6rbzmv1etUCarTmvXVYAqmn5dJdBCV/
 zhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933451; x=1732538251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vd7pbdXii55017LG60srcuEq1aqp17J3bfINrh/lbU0=;
 b=kOwfL0mKAIqHOOsNc/DOnQzsnRTUS4TsSWoxwcoEMblOJ5x2IP3t6eyv3QVax6ORJu
 7jw7RfV4Iet6Xjv36TzUUBe7kZFMR62nuZOk46/kC8649W9hOcNmH8ZOvZ3ZvxhU2EmN
 mDLkV2UjIZMwRZEDGWHAU0S+K2gw1kWKIKxAEeCJEgoOGqQmU7Z3qyjaKW9+DtiYFTko
 8IZz8EGV/gns8wHBYBl+CT5KAOf1Eleu8YyRhJFBmoO9NJHOnhJIoLwo/BcP2/W0Keqb
 WqeCWCznysu0fRz4ktj+Lip5naOKuL0tqM/li+Uwu1Ll5kzxFceJLq5xB34LdxFwMIuS
 5O9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnuwP3fbDJdBG2dMsmr+jmp6nINbBp0TUamVGldtqX+NlFlVDrUOmyea3kYQ0eM1wICTb81C6oVj/b@nongnu.org
X-Gm-Message-State: AOJu0YzcybYo7CI47Ze8IS9JcRSzaTjgAQn6y2JB+mLxK9K/WluZEnA/
 17m+0jmvdVHB3FUZfJszxBchkQhVMd3LtdGUpadaep3IwCTLjGj77EsDz81ZtTNbUldBNEfw21s
 o
X-Google-Smtp-Source: AGHT+IE2g0OFW6D0TEMfsCwxv/D9fRF2Ug4zfF8GVlE1yZKpMmldWwRtxjRML2P1iEAV0IJo8u7v1w==
X-Received: by 2002:a05:600c:1c98:b0:431:60ec:7a91 with SMTP id
 5b1f17b1804b1-432df71c4bamr109259245e9.2.1731933450947; 
 Mon, 18 Nov 2024 04:37:30 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313a8sm12507385f8f.105.2024.11.18.04.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:37:30 -0800 (PST)
Message-ID: <cb71eefb-2ccb-4e50-8280-13815a8fd0b9@linaro.org>
Date: Mon, 18 Nov 2024 13:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/nrf51_rng: Don't use BIT_MASK() when we mean BIT()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>
References: <20241108135644.4007151-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108135644.4007151-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/11/24 13:56, Peter Maydell wrote:
> The BIT_MASK() macro from bitops.h provides the mask of a bit
> within a particular word of a multi-word bit array; it is intended
> to be used with its counterpart BIT_WORD() that gives the index
> of the word in the array.
> 
> In nrf51_rng we are using it for cases where we have a bit number
> that we know is the index of a bit within a single word (in fact, it
> happens that all the bit numbers we pass to it are zero). This
> happens to give the right answer, but the macro that actually
> does the job we want here is BIT().
> 
> Use BIT() instead of BIT_MASK().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/nrf51_rng.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Patch queued to hw-misc, thanks.

