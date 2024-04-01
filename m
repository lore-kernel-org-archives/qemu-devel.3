Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D992DCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 20:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrNtq-00047Z-4s; Mon, 01 Apr 2024 16:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rrNto-00047P-NQ
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:04:56 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rrNtn-0002k8-6h
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:04:56 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4e61accceaso219102966b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712001893; x=1712606693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ufibv/KJPGpIe0d6zayGjFDOFWOqiFYcTzDNrdTmie8=;
 b=Z722xX/UWaurL/lI2jOlIdq+UmxMPMJI1MCtKOIbsvffPebZT8Okqz/bJlW4NPRIZc
 NIiehlYjaxwaDwz0f0rrA2LgvzjUbUSc4gfAyAqaRLXy2qdtQOHu/QKarfphhWpRhUze
 56NTv4pRsrKAjBGuSY/lNw5v9QT5WCqb+TBIDGEt/6gm9Y9auBeD6W1Esdh0vQT4xGRh
 N3K9PM5UchBBUFcHpoZTPkBVscHa6SFcLLMqQbiJOzSwgjNagWBBXmslYHMKKUgOjKXT
 HVdw+4IW3viTE4INR7PloXPVuUFV0ZhfrrU9gLEwuyb/f9VqltIRg4/ppi62mYftE0Rk
 4evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712001893; x=1712606693;
 h=content-transfer-encoding:in-reply-to:organization:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ufibv/KJPGpIe0d6zayGjFDOFWOqiFYcTzDNrdTmie8=;
 b=YxZr1kl3YLV/BZdT1TKXoFDj4jbRoLWOtFojcatOHwr/fGYYQTh53PA7yPeO+Y+BZh
 QdIIo2/Y3gjY52Ko5ijJAt1ALh63z7R6kJYBumT4mpMGgynzETQeJ6W4sY7akOWt3pkh
 iOOj9+nZfUNyP+F0/6bqns2JLSahlcZZrBuPbCb9GrjFS0AUfFAIjFOJhPWsDFuwZv6N
 rGFDgegthSxB9Qyya/j6cXaalVayetw7yAu+Ragx3FJWekq4fL6UJ5TS+9wce1w93raT
 zp55In0XDf854aUS8Bv28hxviMuHtGSusj4WWU/u+C7fzy62j/u6Gd4uFfQ1DZhajIzD
 9/hw==
X-Gm-Message-State: AOJu0YzK38wR7VRcRON4MRJCCtAEiUpmTS+QSG16IjKO49H4nySFbs9L
 9T43cQZVqGnWFRZ82g2cdqpLQ74/wnkzIw0Vnt9tjXqn6Qgz4dB7AgNsCpbsS00=
X-Google-Smtp-Source: AGHT+IFVE7omyNnpK8z1+7Y00NyOEmpmY0vJF7cXloB3ntuJOhgTdAvxVF7B3Kcl/EqgqQW6xN/s+w==
X-Received: by 2002:a17:906:4796:b0:a4e:6276:659e with SMTP id
 cw22-20020a170906479600b00a4e6276659emr3318335ejc.76.1712001892885; 
 Mon, 01 Apr 2024 13:04:52 -0700 (PDT)
Received: from [192.168.200.106] (83.11.9.119.ipv4.supernova.orange.pl.
 [83.11.9.119]) by smtp.gmail.com with ESMTPSA id
 gc9-20020a170906c8c900b00a4e440989f5sm3636306ejb.159.2024.04.01.13.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 13:04:52 -0700 (PDT)
Message-ID: <9719a94b-5ece-47d2-9f97-60f024db105c@linaro.org>
Date: Mon, 1 Apr 2024 22:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
To: Liviu Ionescu <ilg@livius.net>
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
 <A2BE1ACE-3764-454F-99B4-53FCA9127F0B@livius.net>
 <47998747-e990-4c4e-be4e-d0d38b43e9d8@linaro.org>
 <63E7268F-D9EF-4F7C-BDA2-469F0BED2423@livius.net>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org
Organization: Linaro
In-Reply-To: <63E7268F-D9EF-4F7C-BDA2-469F0BED2423@livius.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62e.google.com
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

W dniu 1.04.2024 o 21:55, Liviu Ionescu pisze:
>> On 1 Apr 2024, at 21:48, Richard
>> Henderson<richard.henderson@linaro.org>  wrote:
>> 
>> You were told back in September that Ubuntu 18.04 is no longer
>> supported.
> Sorry, I missed that.
> 
> BTW, according to ubuntu.com: "With Ubuntu Pro, the 18.04 LTS will be
> fully supported until 2028.".

So ask Ubuntu Pro team for support?

QEMU team does not support Ubuntu 18.04. And several other distributions.

