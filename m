Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAC2D2B928
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jeg-0001gI-9k; Tue, 05 Nov 2024 08:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JeH-0001XJ-65
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:31:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JeF-0007Ip-3h
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:31:08 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso34017355e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730813465; x=1731418265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HNI3Qh5aNI25n6R83vyAaIQ79DEw1hHSlCehSa4dQ80=;
 b=oEVxMqcW4sMIe+psywmuTN2hmmOWJm/MCx2AtAAkgKGXR8ExkeznkXDcNZmdeh1UMz
 Nb8A5QIvHz70oYerOS+oSGiaxVa2K+GRi/094IaRdVAr1vph6QZ2olxGkNE/B+zUrEYS
 irTX+dMkx+xgp7lt0KgFyS/mO4BbhtvZVZz/E6pT/35Q09wFkn2l7M5tWJyjQxuplqal
 4O2ucxUaL2EKSG7vQZ2Xw7vwSAI6S/tKQQ2VUHl/MYePrTgkU3wsV2r26S42pv+ai+vL
 V+hBzMM876QCPIIVRa5GVjtGNwRfEVkKRSSP51L5qSyHH4sh+Bqa/x3UNjHgCdAQ1PUh
 lIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813465; x=1731418265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HNI3Qh5aNI25n6R83vyAaIQ79DEw1hHSlCehSa4dQ80=;
 b=CZdhiVoOrOY9oXKRaNBeAmw861zpC0OhmaisMrMAZAWiJozmktUdhlTiXKa19tIeRF
 SFw/SZdoWkqMg/d820884lBfbMk+eBEupWl2oKl6wzI+b65ImsbwV5d6727g1akSdUzi
 LhLM+rN+t3x2Tjz7o0t61LHWwOpyEi+9mdazCuZKzztQCUtvr+lTijSfBtn0DZYjFnJ0
 e/EsJV70j791tH6hgfT91boBCLUiztc9n39y778oRbgtEQzt/X577eP+I1Z6v42FLlKc
 WGsupwHhZV7FoORFTMkz50GXb/0vrbF1qJIxcENp61UdpmK+XT0IBGEWRVWyIJa5EMLV
 lAQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVot4upBoMrG6EoUm4MWGH/tbh6x2G4WMIMuxhdbD2qu7mJFE+WwLS+BcRvlj/+Bl+urbGWGpE5j8pD@nongnu.org
X-Gm-Message-State: AOJu0Yzm8U08gScibXvMIkSKN3z8+olf9YPBJAxaPXUWnpSHMzSpsOxi
 aUbzdhYI97NbNfhjDI2DcVGQCiPH6ZkII8SNdBxZ6oRoyy1EEA+nCRDPn1SSPrE=
X-Google-Smtp-Source: AGHT+IHVsw2tJMYjlcTETpKmWLghinjpmGElb5PLOleRYLsnTLYFFvgO6o1/iRif038giWgDWaqtOA==
X-Received: by 2002:a05:600c:4e94:b0:431:52da:9d89 with SMTP id
 5b1f17b1804b1-4327da720bfmr155605225e9.1.1730813465024; 
 Tue, 05 Nov 2024 05:31:05 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c9asm195326765e9.21.2024.11.05.05.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:31:04 -0800 (PST)
Message-ID: <f15f4d4a-9166-4cc4-b1b9-f888be911a75@linaro.org>
Date: Tue, 5 Nov 2024 13:31:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/19] target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it by runtime variable in the next commit.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/microblaze); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 36 +++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

