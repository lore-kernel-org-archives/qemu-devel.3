Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4512C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLje4-0000me-Nt; Mon, 24 Jun 2024 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLje2-0000lh-Qk
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:22:07 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjds-0006yq-Ig
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:22:06 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52ce0140416so1835905e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719235314; x=1719840114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtPfj3Rr8TYOLDSlaqbXQgaU5zT7Ct0Jmt7DP5WEx3Q=;
 b=u1gPrvZExOKOIEOtUNlzxMwG9Ce8g837VIdmQnWPiDwBuZKlLxxOklyMRihLx5ZTA+
 4UjhkecCTqvdhf3/8eTipVmg595Ot4era85PdzbeC4BN19ClOnH6dhveRKplkBNaMA+W
 Dq/WduKFqQ5+fH606w/r8VeL9peGvKCGkTBRVWiH4raOFwDDwD0w+41TwRKuf2zMyqPq
 MZxQ2bKnuHgTMd6m5FdAM9I0r36XeUuJuYOL5mwQQdMVTwkppFCGYboF7AZO5qchA26s
 +U6i28OVa19In3+IYF4GWejxZMp3JcKwc+mTOmvLudgU6OiLJvdAWHfcC2o4OxQnOKdi
 AQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719235314; x=1719840114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtPfj3Rr8TYOLDSlaqbXQgaU5zT7Ct0Jmt7DP5WEx3Q=;
 b=MKpYCDgMkzzUyJ4WdRt+l3znbqVXiR24l1WI2GpVtnoTrUSeYPRSHBxtTenfySD2kV
 eRhGMhb8S4E6P4Kdlt7eO/+SSOR2xTZRgzddKF1wOzHgHpH7cmbuRSJneNJogxsFX/5z
 twNLzhWbg81klNHGG0Aq3pvF0U/flGpA9r6Zs6Rb+0vgdn55Ed3KhCTvzMZ7vFdUpcpQ
 pWId8APsv0BNDcY7ow61bMiMlcXpWVe/oQ1KrZIrMogco3D6th6mMnyYTFRiSKCKr+rZ
 6Z9oFH0EJdFOVqzQ4uBTUARGeXgOGf1B0+8ZNBiHBxH77laMpCmXy6QkO8dIqMA0o8Wk
 7B/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCiypiwHx/5xIk10pz0f+MP3QlNXvVX1ovW9kVqsPi2SEC6YcdoXhBVxi2oBAdfQKR1z9xoKtuh7eTa0dkW+mUu27TiuA=
X-Gm-Message-State: AOJu0YyVNPjSJjVG+GJ/RE0dmjLvOcqVJ7gmfgglaEcZWWx3ZsEFa30H
 ygt0y0ax/oUCemWDP+Xb7jL+T4QgVW927sUH1+XBiMq5BaUclFoZ9+7NlAVY7d8=
X-Google-Smtp-Source: AGHT+IGXKCvTDanaK8S04z1nwTF3Ox2ijSAf+LOM3aJfcjddmSmE/i1jEBNdBOWjLWYXNXmh/TTnbQ==
X-Received: by 2002:a05:6512:2827:b0:52b:c296:902a with SMTP id
 2adb3069b0e04-52ce0610642mr4384985e87.5.1719235314279; 
 Mon, 24 Jun 2024 06:21:54 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f6777sm10115425f8f.21.2024.06.24.06.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 06:21:53 -0700 (PDT)
Message-ID: <dc589268-efa3-45ae-85e9-30937fef81cd@linaro.org>
Date: Mon, 24 Jun 2024 15:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/avocado: sbsa-ref: switch from OpenBSD to
 FreeBSD
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org>
 <20240624-b4-move-to-freebsd-v2-1-64ea7b04998f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624-b4-move-to-freebsd-v2-1-64ea7b04998f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Hi Marcin,

On 24/6/24 15:14, Marcin Juszkiewicz wrote:
> FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
> than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
> so we can stay on 14.x for longer.

Could we keep the test but not run it by default on CI? No need to
upgrade the distro version, using the fixed cortex-a57 (and not 'max').
I find it useful when bisecting hw model changes, when we don't need
to test the bleeding edge sbsa-ref. At least I'd like to keep
test_sbsaref_openbsd73_cortex_a57. Maybe:

   @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')

> 
> Moved from Neoverse-N1 to Neoverse-N2 as sbsa-ref defaults were changed.
> 
> Timeout messages expanded to mention being affected by PAuth emulation:
> 
> test_sbsaref_alpine_linux_cortex_a57: PASS (24.00 s)
> test_sbsaref_alpine_linux_neoverse_n2: PASS (82.24 s)
> test_sbsaref_alpine_linux_max: PASS (81.10 s)
> test_sbsaref_alpine_linux_max_pauth_off: PASS (23.54 s)
> test_sbsaref_alpine_linux_max_pauth_impdef: PASS (28.96 s)

(These are Linux test outputs).

> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 53 ++++++++++++++++----------------
>   1 file changed, 27 insertions(+), 26 deletions(-)


