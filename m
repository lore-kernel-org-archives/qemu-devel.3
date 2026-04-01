Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4FBD35170
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sX9-0007Ut-HN; Wed, 01 Apr 2026 06:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sX7-0007TN-9s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:10:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sX5-000382-Gh
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:10:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486ff201041so65936795e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038241; x=1775643041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/poj3UBV4S56AET1/k9VBM6uJDtVR9ttmEYGxdzX9s8=;
 b=RzAMffFpOMpniLRjMaMtD7wpevOTm57LhM5YxfiKlL8I8NTUqRPwuhUfBFYEmV8Ifm
 qFYlCt0aRaSOGy0j/OsWsrayt1pozUWb6XnRU1nApMawAbcD1D75CFMabYy0J4hEdb95
 zg3GJ/yzF3PF2r4NGGV13aDTmsDrUD3JLYigOGyYXS9zBkCiFhLP/Pm/ihNqy2BauzOs
 YsrHddJeDIFob/Mb0Urxj2WHl3JpJ+6ZfFxqdiFmdlpL/q0AMNUPsHUX3gXo8w7SxHqN
 8VNweohjA+nCsXSa3fQF8u202aiAN9t5F2MQFeNJTmzfqX8gQnGC1Qy+kOftJDjmTcdJ
 pJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038241; x=1775643041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/poj3UBV4S56AET1/k9VBM6uJDtVR9ttmEYGxdzX9s8=;
 b=gjEGV4ewUCviZkpFaCUtm4tN/dRko8EmJnj5jH1NBXsgXeuxJr8TbLG2kT5VWvYiNu
 k6kYKN/WCDpzLrUPmmpmw6Wz/CzFIu6rnwy3Xjgy8sOkBC0IF1Tnee4MCHYiRyxRAHBl
 IqDLPlMDbZ8ZPOqBeobE+2OQaPMJwX5Bo1oBDxf/QQZ8kuVAcZeLDrN/S1/ktcnx8Jui
 jVCBjOlgiDCid6qPBIkWnxLcXlBhn/DPg2zruUtvVupduuIRSwNvm+/vc2w/EknAUmGU
 hyg4rBKnjsfGgPGR1ISDQaUOTJBBIbrvd4sl3CIXNvwYN/+ox55VkvIW2qemy1AWh9gX
 h3jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+BgrkZLRESZLgRyWszXOpNZG1r4CYpQMEvVxmaKeJqYPclPCuz0ebnxLlFZBZzwm6cWJG4of4SEdK@nongnu.org
X-Gm-Message-State: AOJu0YyJF8sKM//gkKwVKhKQqLmnp0n8tth0uy7LFeT2m0orb3IEvbaF
 xtWO9pEkEVv3IVaOVPzdsY5etb6UcgkfPVodNPF9sawCVbGGRLAmHIqPUcPCsG18H78=
X-Gm-Gg: ATEYQzyqqHdSlreAo8CHKgustWy+HSYhyYr+wrZ7AUrYGDGKZOdToRHBstYn25rO+A+
 1EC1TV86AShEQieE9GTop4nFC+4FfdnuXKN+AT8cJ541XViiM6XaxeGXQYESMFdHajFiaMCKC6S
 DIcvmbtLjpqwVsYmazFEJRUWKcgMufdJNkRqM8VRMkd0Yqtcau/QJHth5ChNNMQ6OGFmJ8mn8iE
 CBRgjtuBkEgQStA0UvVxRzPtyV1bnW/8O0FR50lHaHSLdk744xA9cGLaEGjDI/DyvVZ77qsuP7h
 RFGp+7QCp/qqJpeZAagaNckoY9o9o8GPvwhDqv6j9pQYl/SI7LVL2wQVL78OBRIMaQljWoBKLAS
 P/cRqZZ2o1Bbgy+fG3KIUKOcY9u0HRTEwv5wvy4bxy+scfpYeDDTlEYTZ7R6aV0t3PKMFUF+7Vr
 21vC7waKlehuA6m5YNoEu/DrNYyc7WE2ctKeru4ovs52OocHFFY5Ht1a0hnXsFxhxJTw==
X-Received: by 2002:a05:600c:4fc5:b0:485:445a:87d1 with SMTP id
 5b1f17b1804b1-48883562a3cmr48310225e9.8.1775038241196; 
 Wed, 01 Apr 2026 03:10:41 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e82e262sm106556825e9.10.2026.04.01.03.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:10:40 -0700 (PDT)
Message-ID: <37430b6a-6e11-4154-b784-61d3cbca5875@linaro.org>
Date: Wed, 1 Apr 2026 12:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] tests/audio: do not compile if audio is disabled
Content-Language: en-US
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-9-heifetz@yandex-team.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315201646.96862-9-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 15/3/26 21:16, Sergei Heifetz wrote:
> If QEMU is configured with --disable-audio, do not compile the audio
> tests.
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/audio/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/audio/meson.build b/tests/audio/meson.build
> index 84754bde221..97c1d623bbd 100644
> --- a/tests/audio/meson.build
> +++ b/tests/audio/meson.build
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -if not have_system
> +if not have_audio
>     subdir_done()
>   endif
>   

Squash with the meson change in patch #1?

