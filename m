Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9B5E6B257
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 22:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXoUd-0005G6-TE; Mon, 22 Dec 2025 17:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoUK-00055c-JD
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:34:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoUI-0005HW-VR
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:34:48 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so55442975ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766442885; x=1767047685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7RTF1j64IBY28hYosUDSLzGZDz5uyiAuxQNKN747RkI=;
 b=qFTMV5zvoW8pVRCTQP+nnWJePsRGPQxVJvgtDtRUom79ebGWDTDyaOTAmAIXf94Snq
 o81kH9zFQZa5BKLFIRvVtJlYHhqXTwL/ycOQJwvHRh0/7TZXqF1pJ4yEklD66t8bkSj/
 vwAkRHNYWRuY21c1eCZKA9S4asYaElYR00UR79fNM52lewUHa+oYTwSvporlCyarCSzA
 a+xvcAHvEeTKBZkVIvNk4HX9/noRmrI2AjhHsRxEBpEdjOjQZL9+hKU4DhwHtsWi5MqQ
 FFPFzEmoFfRyYD1XzkPV08Oifg+j/3FrdpLT3m/L1eH0GTCFFJjACyYrFBly9NxoiTB7
 V0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442885; x=1767047685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RTF1j64IBY28hYosUDSLzGZDz5uyiAuxQNKN747RkI=;
 b=HSfU0NS/ZJWHZJI3ddw8aY3pWfi9qWoV2MwblQMYHxOwzVn3X2N5G2/591ydp/pv7a
 +BGZ6uv5XALospB9vDokz7onPpv9qZAboU94AXvS8N3aqrSzuJv1YZ4aYq0w2Sf3B3Vz
 CmpOrpczcVQNZ5g11DEp94bxym88KFO9XkPzzh6DI5PRfFKaRKlKG878wyFGA0zd7BOh
 gpW9BBtMqgqqEI4buklDJ+9mEqG9HsSalK42VVr+/XZrzjXccHKPXr9KLmN+vJkdPgbr
 pZypiH2sdTqRfzgfoLvmgbAE7XFelXQJTGgdWeJTYgcqofxkG1CCPWbY2fqHWE+ChTTw
 Jz2w==
X-Gm-Message-State: AOJu0YzRTsmOsUAndeoOSp5DFx5wx+zSqkZU3pe/EVi5JFyIG2zCshYN
 90qKTfYljyncAycwbMZykxi2H8BNR1bmntF2FaTqnBv+Rn9hU85bgTqzyUrwQpATans=
X-Gm-Gg: AY/fxX58RegWmCDsBlWGkdYfjCc7PpY8G413tYE8AMTKFfIGJ1uW9LX9rbC0l5PTA9d
 7Dtp9xSO8G8eee6747RHcYDvendR3SZkJkhPGws0qEkAD7Rf3qdV/b4TBTTyVBUSoLJKkpd6Djf
 ODLQU5pufAObMMFdvxQAPO/Jl02VGfv0WYb+p9w7Im2V7F37yAi5qHXKV/JdCOxi6SsF3Y09kJ2
 fSeOQNrqBcPuUe9vyGoTQRQR5OrqLbZERSXkz0BCviXYrb5rnqvgqdWP9v/d/Oiez6erpVwRifc
 PNR30Qeir8NHWCw4SZJ10570WUmnSfhCspL77rAx8DcB179rjWDRbnnB7uG4KVw12jkIxbaojO9
 ZQjKCYDxpcifp3jJ5asiDyC9PR4DZmxEaP6vKghR1LXgvUlPMvYjVX+9xQl7sW5ZCiiTI/KEKhA
 WgcI97fTaVKgMLVx1iNBbZWNbtxZrMeUEHRlWdUG03EZ8EVibK8+wc/eIONo+K02/CUg==
X-Google-Smtp-Source: AGHT+IE0SCb+IBW8JWS0T7FeTw960usDG+R8f6idCjwQmV6vuuxQcQUJJnR1i3j3NMuRDVPkqqt04A==
X-Received: by 2002:a17:903:2290:b0:2a1:3cd9:a739 with SMTP id
 d9443c01a7336-2a2f2830ba1mr123582265ad.43.1766442885311; 
 Mon, 22 Dec 2025 14:34:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d86esm106215745ad.74.2025.12.22.14.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 14:34:45 -0800 (PST)
Message-ID: <97e673ca-fdbe-418f-899f-43435189f576@linaro.org>
Date: Mon, 22 Dec 2025 14:34:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 4/7] hw/arm/smmuv3-common: Add NSCFG bit definition for CD
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
 <20251222124517.3948679-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251222124517.3948679-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/22/25 4:45 AM, Tao Tang wrote:
> Add NSCFG bit definition for CD structure. This allows proper
> configuration of non-secure access settings in CD.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   include/hw/arm/smmuv3-common.h | 5 +++++
>   1 file changed, 5 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


