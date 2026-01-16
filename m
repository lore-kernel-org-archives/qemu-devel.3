Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7DC79FBC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkiG-0004l1-9t; Fri, 16 Jan 2026 09:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgkhQ-0004L5-E2
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:21:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgkhN-0007Y9-Tm
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:21:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so15459285e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768573272; x=1769178072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1kdlQ9vZ5FVssk2+kabWN080uS8qQd0BGYQvNWzj1sE=;
 b=kRPC/jeUCTGNGTZgF8MDWoabNI1TTtW68vmPjzeFNcBHF5hwkK69CUBfxxGuOyh+oC
 sykRPlii45bK0+GA1mL9HpY8c5tWqZeZD7Ag5ni+MDjkaRdwh891hyqQKVyDfbr6KRci
 ejGcQIQcS3mhYNikM8rvV/0la5ARa+B2yMJGjtnFrdY0ZzLDE8yCIE6mJj9BwzbwpdYt
 CwcauKZ9YsYi31kygkCKqF3UUdcWQ+Ev9F/wO3Wlbknowk9IXlBHiMXvjhjovkd9Sof3
 pqwugJFVu4zk6vypknfkjR7CIx9OyjhNq4YaHbKNzdQe2sSPvkCo4m3lEWhT2yVyymzl
 +4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768573272; x=1769178072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1kdlQ9vZ5FVssk2+kabWN080uS8qQd0BGYQvNWzj1sE=;
 b=ZPgYtFGsWuPToLa4vqDpa6rnQn4A7cNoLMRbxVV08k5vgzIMnoTOSwlOMdLtr7qbRj
 HFyWiAYUsrEw71lYl8dpeHa1MfS4RKkshjzNjn6/Ftls0fEkSbK4OW0PSorRpi3xVNCk
 CyuXda6/Eh1T4u02v+EtI0AYJNqT/nZHJeR22ePMzHXx5bhuOPAkxeDrj5XFHppGyo2y
 Ap/Mbt9qKFizJZKKBYzXhNkXdpATrLN9VPzie7V6rklgn5XPEj6Yr8+xHgmihaQ4UmzD
 p1Ra26CVJLeWCCphqYoHM/xwkSvE3UkzxM+Bz7WJooXtiT5KyQ6gi8LZdHlK+NIocDd3
 g23Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURGgBWEXt98sXxFp2yH5urIajLuSuBsAyHUi0D+dSQA1hupH1zHY83/DoVRTqoo3+Sv78jkDPD1bf3@nongnu.org
X-Gm-Message-State: AOJu0YzXXit0pn5z94ECfZxSAIBtuVitwXnuhD2Ws8MPQUx/brq+dvUu
 Eff+GuI8zGo5rYh/L4Jy71vb04gNRRSpi5fLI8ONVrbmm01EKuVkq/wPlIPictlZjpU=
X-Gm-Gg: AY/fxX4aNB6RlMIvx/BEdl9UBwFSOdYUV5WqTmdRO+f+XnTik/4ifFLUJvmu747f8y1
 icLNXEuDGdY5F1dcmim4KDHUzlce2ZLMOtBMWVfbutX5vLcQKdBmwxQt1QwOPKapnc6liDU6loD
 A7HTuoHyE8RlQtMR2ygx3lzdJ/aQ3gAuq3EhzqQrvVAMPy3lALGrtZILKdtk9wkNy9jKWGfvztr
 9vC2iD8Qh4FyQ9YuDscYd9pjY5Doy6yPrCIdzvGyFcMNC4rJTa5ZkLRbUI77Lyz5YZzn1J41l+u
 kIxFJQmoi4upTtIewnU4Z00LnVFKgQIqVrcLFCtrKQyjG8rwvVkENVdrj7uXkFfJb++f5zBVe7M
 reftLsF1iJiVHdPzRgatPFGGFSF4UimRKoZYuAIgWkdKr51y52CuH8+jcej934UZU71COSECGL6
 FpYSpTmcwnOWGfl9aT5HSRjvxTKVuEFTNrg1u3oleooH+wgjHClwryfg==
X-Received: by 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-4801eb0375amr32279285e9.19.1768573272470; 
 Fri, 16 Jan 2026 06:21:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm103066525e9.14.2026.01.16.06.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 06:21:11 -0800 (PST)
Message-ID: <23800170-66aa-4e31-9e74-e256933c8a8b@linaro.org>
Date: Fri, 16 Jan 2026 15:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 15/26] whpx: add arm64 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-16-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-16-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/whpx/whpx-common.c    |   1 +
>   target/arm/meson.build      |   1 +
>   target/arm/whpx/meson.build |   3 +
>   target/arm/whpx/whpx-all.c  | 810 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 815 insertions(+)
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c


> +void whpx_apply_breakpoints(
> +    struct whpx_breakpoint_collection *breakpoints,
> +    CPUState *cpu,
> +    bool resuming)
> +{
> +

         g_assert_not_reached() ?

> +}
> +void whpx_translate_cpu_breakpoints(
> +    struct whpx_breakpoints *breakpoints,
> +    CPUState *cpu,
> +    int cpu_breakpoint_count)
> +{
> +

         g_assert_not_reached() ?

> +}

