Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE2EEEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqcsV-00014i-Mm; Thu, 12 Feb 2026 15:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqcs8-0000q1-HI
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 15:01:22 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqcs4-0004RN-K3
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 15:01:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so216648f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 12:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770926462; x=1771531262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Qgto1mMxevqHypEtfXdXGaroJl/oKxVVPaWgRyjJsQ=;
 b=LALD2HXjha00Mj43fQekkptQoqqAHtkjvqtob13J2LKknEOmKdJRWLE8NsvUJY2TcB
 JZIbpSYqZQwjmnGqvgpwUS8rfbJTfB3DA2FM7DSpLbqDNywUmQcHml3ZNqARq8PMTvMm
 5HODLND9nxJxtlYFF4Ytz9yvnKE06Vl3NZT9J5QdD5wC7SYkGrQ1NC4d4pUhj5xz6Zha
 3HA+tepqlSJ8Apma5LJqVTB496LruoWFlP9VFg+pU/pNdXNZovjviU8wHhJYy187repL
 zL/wwPsgsYpG1IVLogN8lkwkLfXdkWfXbpvp4EPpsjW+bX273H49rtf7U3NolKWd3f/B
 W0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770926462; x=1771531262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Qgto1mMxevqHypEtfXdXGaroJl/oKxVVPaWgRyjJsQ=;
 b=ZLHjuO61LprbQTGRo3ZTvoyk1P9Mzoxixulu55t1o5J42yApEslZ3+/jOZDHYPNFL1
 K1VxRPSUhszFM+neNUGnOUSt8XES5RYkl40A8maSlfxd5XdjkFm9G6A4QppbIAIf5yZO
 yqfb6Fa3do/ZHaEPagRp0L0bCqXiAWP6gK4G8FXcp1Jcw0Dq1DgI/CvX8tL6lXebmHO2
 SkAytX2wUiBWtUm6b8EdBKfW0vt7uQ2Qso65lGs0lb+rF+mhYR4nje16K8zfitVjeAkI
 pSTVFSSR1Zl2j3qUsRrngj6zto1AQm9S0U2XRxZ5uXH3Mv7IVgEYEnkKV9b25tOXcmgB
 Uc9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwj7F5Wbp8rleCxALr1/HwiaeYJVJQIkuLZTm8xoHEDtXRUlxs3h7K/etANeZem+FnwDxdaVBG8yyf@nongnu.org
X-Gm-Message-State: AOJu0YzJpor4txlJjoGRpCrfY67cGf5/iN0+YiTYiprG6WQKm/Ah9Osk
 b/0Q/j6oGLvrctnrRzq0J3tOCtozkc5IwOrRhzNpFmFLVwWsyv++U3h/QSPERWaqF6w=
X-Gm-Gg: AZuq6aKAiV1sbDhCx+TixsWU7JjVFpE+YtlKy7tbKCKG0llm/ZWAVitMREF0pWAuGt5
 8qc9c30fGX6lH/8Qm9ZdxfBevGc2P9mu8yCWsi4ZpT9mVpk/WNzVXvCAp43G8pqTZ3cH7BZviFh
 VUky1JOipvG3QhbodYhHr1EAB3LPuh9c9xG72mhIyaXab7lZppm7wxwfFAfsobU+Zv8wVLDniqX
 QCDUTZKkI5txW2/mcVPTAPxVbYK+PCzEkw+n/Uwc6nr2RYzU7cgPQI30/V4M8XAj3ypoyJS8Ier
 LpRQmNKzgsFtca+2xm9h+ztQEgG9lJf1jLUimeFk9vl5B4tQcLdMEvlAqZ+qraGQZR8ryg6B1dE
 /Bo8rIemgPButsOMJaKHEVEouskwoOnH12ZP+urs4XOA7+ewwVQaNW2320Z2+hhAeVCi12ijcT4
 QyiPgY64CH7uaO5rTZ94iF+Y+V/QbCe7yyVqxROmsMaGzePA/y/Ho9HGawgHwQgXFXGg==
X-Received: by 2002:a05:6000:310f:b0:436:307c:b762 with SMTP id
 ffacd0b85a97d-43796af049cmr156490f8f.60.1770926462297; 
 Thu, 12 Feb 2026 12:01:02 -0800 (PST)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm241406f8f.31.2026.02.12.12.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 12:01:00 -0800 (PST)
Message-ID: <14ee1f39-a8b5-44e4-b9f4-1eb08244c9cc@linaro.org>
Date: Thu, 12 Feb 2026 21:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] contrib/plugins/uftrace: add riscv64 support
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
 <20260210201344.1403613-5-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210201344.1403613-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 10/2/26 21:13, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/about/emulation.rst  | 10 +++--
>   contrib/plugins/uftrace.c | 87 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 94 insertions(+), 3 deletions(-)


> +typedef enum {
> +    RISCV64_USER,
> +    RISCV64_SUPERVISOR,
> +    RISCV64_RESERVED,
> +    RISCV64_MACHINE,
> +    RISCV64_PRIVILEGE_LEVEL_MAX,

Dropping the superfluous trailing comma:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +} Riscv64PrivilegeLevel;


