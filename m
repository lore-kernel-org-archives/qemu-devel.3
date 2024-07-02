Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72E3C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgEB-0004Dq-AV; Tue, 02 Jul 2024 12:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOgE9-0004DS-Eu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:19:33 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOgE4-0001ud-E1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:19:33 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ee77db6f97so11469661fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719937166; x=1720541966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XyS/gtHRLWH7n7Zfmb88pVq94dyboMi47Z1tIBWIfmo=;
 b=IMl1Tvzrmu8JcaTGIkPjNZuUIzXPtGbpSSf3FltCgfoXid3E6ynxbq5+z/Aks/dLU3
 iMZMvpNvKKaf2djBH78/f4KBT7I4V3dlh/fkfzaeGrI2gXWK3qReVkS8IfAkfuA9DdX5
 v//q3ByFUBV7dkoNABCN28GD/OETBPCIkbLN1vOpC+W3XFlevUQ6gsEZcrW8fL9IaXbB
 ft/uKdBl3ZZONZlK6LzwEgxHeId6mZbKH8DdkMB/L1y78vsXcjoDv6QFsdl9I5U/AyHn
 MYtwsdyw5Orgabc5Sl7EJjprW07go5yLmj7mTfOyArUvgF1rqk/KSP/FakZZbqse+ZoY
 gf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719937166; x=1720541966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyS/gtHRLWH7n7Zfmb88pVq94dyboMi47Z1tIBWIfmo=;
 b=ZlYCj1Hk7nFkCDdHnoeX7kjLg4UWaWS6pka9S2vcekMKBTlMbGZLX+pGVdFBFQoFYR
 uWUR2t6IqfHPLLxDnkXKTHEfmdKqlFihvZ5o5XI60mVdJccMPJjYWy1XsDLplDgTdYfm
 lu7zFO+x72aNVS+CMcmVtclJBJqrnxnltCoL8weV9yoXYVCwwTUg/3JGQJ8N2VpYPfoN
 ehVJywWW4yKY9FNZZbjzu8WlNg01iSEE5kx82anGXFOhGRpa/yc7BsGX9a+OnbMhOQo4
 OY6ZxYCw8p+Ah3mQXixmz6L9apUaH0dJKnEliHvvXf33loT30smlfiZO5iq7fWYoUiI7
 sLWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh8l+dO6b1LcGRkqYbmTZbcgaKKWbNlDnAAlCliUqEHFPyl05md1tldEfdMb+ii6ZBPgDL977bV1HttuCrnNVUTaFIMRg=
X-Gm-Message-State: AOJu0Yw52Q9/06iKzEZhWnSJfqmk5XXKdz0nXUtd6eBpRysQ/ZnmjWzL
 7P4YiD2OP066SnUnrJ1aBmp+VtROdnoh7r0obzcfRqCuZrcagv83C4Up2LcxqeY=
X-Google-Smtp-Source: AGHT+IEJFgHPgN/3X7EnPYRsbMknhyg1GsQiiHDe+eXIsyM0+NGaR9vSHyluwep4j2Hwf60vw9E4GQ==
X-Received: by 2002:a05:651c:b14:b0:2ec:5488:cc9e with SMTP id
 38308e7fff4ca-2ee5e3bbd14mr74802081fa.26.1719937166429; 
 Tue, 02 Jul 2024 09:19:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10307bsm13663106f8f.94.2024.07.02.09.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:19:25 -0700 (PDT)
Message-ID: <f5ea6f29-688c-432c-98a5-73e0bb2d549d@linaro.org>
Date: Tue, 2 Jul 2024 18:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ui/cocoa: Add cursor composition
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
 <CAAibmn0S+BvotSV6Sw-d17ybCu10a6Hgyu2sEUrJrzejHs9WZA@mail.gmail.com>
 <56d0c526-5d41-44a5-a737-e4eda60f61e7@linaro.org>
 <CAAibmn07-dRS05rgh9S2pV619AWpA00GFnnPiajCNs0tNOd72Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn07-dRS05rgh9S2pV619AWpA00GFnnPiajCNs0tNOd72Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 2/7/24 16:25, Phil Dennis-Jordan wrote:
> 
> 
> On Tue, 2 Jul 2024 at 16:20, Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Phil,
> 
>     On 2/7/24 15:19, Phil Dennis-Jordan wrote:
> 
>      > I'm still keen on NSCursor support for absolute pointing mode
>     though, so
>      > I can experiment with doing a better job of cleaning it up as
>     part v3 of
>      > that patch series.
> 
>     Do we need a v3, or can you clean on top?
> 
> 
> Sorry, I meant v3 of my NSCursor patch, not this series.
> 
> https://patchew.org/QEMU/20240625134931.92279-1-phil@philjordan.eu/ 
> <https://patchew.org/QEMU/20240625134931.92279-1-phil@philjordan.eu/>
> 
> (That in turn uses the CGImage for the NSCursor as well)

Ah OK, thanks for clarifying :)

> So from my point of view, this series can be merged, and I'll submit v3 
> of my series, which will aim to clean up the CGImage code as well as 
> implementing NSCursor support in absolute pointing mode.
> 
> Thanks!
> Phil
> 


