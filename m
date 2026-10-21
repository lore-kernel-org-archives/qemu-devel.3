Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14D60A2614
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PyUaZZnl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXhr-0000uq-3b; Wed, 21 Oct 2026 10:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXh0-0000nf-9v
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:53:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXgy-00051A-Iz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:53:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so511402f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792594402; x=1793199202; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7EnR/xdw+2rpt9p2GEJ7njqFf17QViPNRxh1tNDqVWY=;
 b=PyUaZZnlVnuXvf+DhqPNaMntTjcR4YGzvpniKOciS+gVUydRcSjrePTCbQTKbCbmlS
 68QlqO6piwl/sn2BowBR8LXKG2QNZRBbLe0juq8CdHbOM/iMWB4jmTpD4HcNqC4JXfeC
 v9/pPOZ5TuAYzLRjbrt6uQKimbl8N9DB4ugJuClZBlh8BOwMijqw6l9WFwofSz9DJoiE
 /DzIqf3mvzTgabAeglosP+wDgO/sYVM2Zje3hnuocyHNxWBOARU7KyNd7GaHTEwVuwem
 WWpCQrTDREgUcOW7EVGo+4VPfyGw90HiJL0syzjl9Jco0bwwfgZ6X7Xbs0pIf8MOsi27
 GwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594402; x=1793199202;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7EnR/xdw+2rpt9p2GEJ7njqFf17QViPNRxh1tNDqVWY=;
 b=xlgBg24K5hTYitolMWOwZN0IVC2a3wo48Fov+LTtYK/XqdLGkU8yRq1HFvNvKC8NdI
 vuDpa64g79oQRFrHQZn6P9eOPIDqZ+QWMJN3tQ+3ty8JAWfJa6MJSfiIHLBl5LDps5oN
 LH4mPXftD54gA6C1mFe1mVI0kHF7EIVE6FUbD9sdRdWr8jm3vIFlNq9f8HsQzDGj4tKT
 /FHTVGmcDQoqrizr+sNxTzDBFxPvyHcFR04wSuFZ51M2JOQ6LlOWt7aoxd+8zDGjPSLw
 KCyMllrd8YwnogDpvxSKEeIEwQ5aCGi8KrqWzHsairnTGwFirP6JJajJxVhdzo3+ZmSb
 T1DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByinHmJAW634n3K9160svU4fsDFj1Ez4dQrJZKrISs1TiLn6cr8ngd7ITl8DqUuZ9u88/BinskLTXT7@nongnu.org
X-Gm-Message-State: AFq9FYKjlau8ec40pgjm7VBrWwql85TLNtJ552oC1a6iM/c5C2ktFLPt
 79DZl4durhkdMp/QL6YKMzv2ZTRfmTVpEH0u9+YxDfg5vJb7gCSgiwfdBr8qXw9iEEklOmb8xm7
 FZNYEjis=
X-Gm-Gg: AYBFou2Jxg2pJG51+qEflYmW6Z6XTNjUazT4NjTEAuZ2EaFpLKIvkD4XOjltc0DXO+N
 Ep1Aj1O/Mq4BQXtjhoSnOxqbo2o1yhWstixBnL5h51w29XYIwebdTqbhyXojB6Sde/bukij5mrk
 Jv+NBDygReqylcnfTsUGrjYJKTvgqyNMJ5pK3CGuGnSnLhXkeLTvA/GiOTL73oxjTGn/XgYMc0x
 7pd7u0/F63+dQP6poughpo9Fi7ZysZxy/0vqvQvmWCuslO/oeGX43eULXORN5blcDVb6nu5hpgZ
 PsOBwFKS1ooqC7r/cbc5OTQNjuukPXeDK8ORsb4WZH6qNxfP4jvh4RNBZx0rE3gIfQTJvEJ4ujZ
 +qS5upqCAI2+M/N7B8BddwhlzD/09VB49BiisFyDZUGXpUAoOCj3uhbjgUF9NL/KMhFU9cKLmk3
 cjzJdckzEfVqrQ4J+itrqYwMUL0kPz1MNYQ1oQBr4Ngp9bH07cn8uCi55q07OoGloYX1/IVayMy
 E3Y2Uy10ZfGdEMd2sStraf7MWvpgQCLm3wfChSlJ+SYpScXiqD1+quUJQhIxvFCfcSPYCjZniCP
 A1waZKX5n2Zvu58DzbcZKfh8biE=
X-Received: by 2002:a05:600c:34c4:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a1fdd37971mr54147835e9.19.1792594401947; 
 Wed, 21 Oct 2026 07:53:21 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd13891sm39281105e9.2.2026.10.21.07.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:53:21 -0700 (PDT)
Message-ID: <76978043-aa2c-4bda-bf4e-551b958f0606@linaro.org>
Date: Wed, 21 Oct 2026 16:53:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID
 state
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260914160020.327787-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/14/26 18:00, Peter Maydell wrote:
> When the guest writes to IRS_IST_BASER we effectively cache the value
> of the VALID bit in the GICv5ISTConfig valid field entry.  In a few
> places we check whether the IST is valid by doing a bit extract on
> the register value; switch those to look at cfg->structure instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

