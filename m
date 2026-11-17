Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631C606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dtXaYXlO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTT5f-0005tS-5D; Tue, 17 Nov 2026 18:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTT5c-0005se-VL
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 18:59:53 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTT5b-0002Ri-AT
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 18:59:52 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2efe022c04bso1398545ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794959990; x=1795564790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LiRCkLllulkmI4fvZJOfsUWc2pK6aAD880i34sJeYTc=;
 b=dtXaYXlO4xADwhhYMapcXSxruX7wdyaOHCKWT5RFIlYa5rfxHX4OIcb/EoSsGBhFvJ
 NEl5rb7rEkxq0cqSjdvivx9z25Z2VpEDvshhQltHwcgoeWrkGH2IfMc0nEivBKTxaBUV
 u9NVfPhOD2kEinyTviDL0dJWs0Gt2XJ099ANpqjtZA1mciLD2xHJaG1fqI/CTD7i/847
 04SL4jI2Ua8sytwd009a1OF+cp50XrfQgWQBKRgpMxBFLEHN6rl2E3QXfoLhwelWJEgF
 TZjh3Pn1sCnAVOs824TOIXB88IRnsUk4vkZwHnNwRnYxt+0tOFIxDVbsmzOhgNMhR8Ws
 hlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794959990; x=1795564790;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LiRCkLllulkmI4fvZJOfsUWc2pK6aAD880i34sJeYTc=;
 b=NXoCEJufiVgSdmQOGQISd9jhKx28JoP5caP38TM3WGu3K1mRkgoPIImKC3/WkLJQMn
 I/Zswun2oY6BjmIKyLaYOr863lv+XMwjUoba2880Z9E+E9rgk8/2X4GX+Pt3IOLH9BxE
 c7qZu893q3hcxIN9Lhlc9sdF1AM9++iieGahDi9X0NjR6Ew4wekbtNbirfjDI+BYORO6
 gX75FTB3LxltwDMZllHV7gjya2FjGAkE+MNGijJ8XyTHInmz1xMJA4xF3gNgktyGbkLq
 Wnf9uuI+ufnKAa7bWE4hxh0SMIHzVtT1J1fau8o7+IsWdYDnt4PuOKLNSwwgVgHRFdMV
 5+yg==
X-Gm-Message-State: APuU4Z/xfIVu5B6MNoAa0XijAr/MytU3AIiSTqTm2E/3hKNXdG6yebr/
 kjDuWdjitC3qLzUh9VcSnisV+oAwjfWQruyRUOq35mX4vYxrwqvdInNbQ9F4VypIDpD1VkilhYs
 UN1Da
X-Gm-Gg: AZFdTZdx/OKQb0zZhbnWqOlkjLJVZMT2vzScHBJKRn6J3QFI7JEX4+WoxvMeLCTa80g
 ERH2yaE+1T5f5BprnKToyjtKbTaD83Nh0u2jz8mErMs2QGZnWrfykUss0OxE4V6OgaM1hJyhdEX
 nRH9TdxVDbHq+WkOkn78I4LmQxgM4+Q7UuhCXs/zsXv+E/dGv8JynzsKoHO5yU6R+wLn2w7hINb
 ccv9a/9I0+jlNULcgYJB6eXGmqoqsHvOSg5MRv8QwHmYXXrOMhCBtHigB84RLrjNslO4wP0TwHP
 E60S478Rw21jYSujwjhRcbTx+EkvOWSyZzM6LKu5viyiIdzMmcMm6y+wHHOZ9Wuthg+WpqCz4TZ
 P0kLhwgyk7xuQs9zabPLkiW0WIjNiuU3vPBNkIVvbvTnfrshJ9S/d/u/I1UZ2QFJ3ZxY6GZedAr
 82I0NtyXEpkdSfiz1r1e3ssr6Y+t5OsaOuFw5cACRb6MZ8puNoRwm0dWq5K0SQq4Wkw3UzXqHIH
 9osfxRYsvyCGLiquGHPejrz4+OjulkLbVimyjA/a8bQFmOAnC3fhCAEujwhj+U5Ui6fU/lzENe9
 KwdLnjz0SeWa++7eY4KA8FgwdjmVWxEtT7wiebAYh2m2ZE75AXOa2NA5aoA9uDpp1MIT4IyWVUk
 /vXJ97o3ariq+uzO9
X-Received: by 2002:a17:902:ce0d:b0:2ed:948:b68 with SMTP id
 d9443c01a7336-2eff72ea3b5mr7307775ad.9.1794959989876; 
 Tue, 17 Nov 2026 15:59:49 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff628c257sm3514415ad.65.2026.11.17.15.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 15:59:49 -0800 (PST)
Message-ID: <774a7e1c-3216-415d-b118-b5fffafc409d@linaro.org>
Date: Tue, 17 Nov 2026 15:59:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/7] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20261117204902.321207-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117204902.321207-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 12:49, Kevin Wolf wrote:
> The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:
> 
>    Merge tag 'docs-security-devices-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 0bf35a66b69a12f0e8d8a0f3f534a1ff9f52aa51:
> 
>    block: notify only the replaced child in bdrv_replace_child_bs() (2026-11-17 21:47:30 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - vhdx, bochs: Image validation fixes
> - Fix the size change notification in bdrv_replace_child_bs()
> - iotests: Minor fixes to deal more correctly with exotic environments

Applied, thanks.

r~

