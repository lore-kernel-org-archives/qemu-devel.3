Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF9C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E82-0001dx-Ri; Wed, 15 May 2024 08:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E81-0001dl-BT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:53:05 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E7z-0000dj-NB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:53:05 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e0a34b2899so102203771fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777580; x=1716382380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqbX3+t9p0LZsldOKhZGRDiCCka3lbUHUI1hHdPQxR4=;
 b=MnNHRDlVyV/QCqhBUN7sWzc44HXvNMuMd08shsYXckikG8wud3gSVoKdUHTzQ1O/a3
 JDnyBvqN6SwzQ/uZnuWhJyZBTnae4+jDDF3Qo/CzvkZH3kIANPF3KzUpP1JmjYC2Oop8
 S73UD63uvSKk0ne8OttBFM0N1wdSpT2yRufoVXJRoDtwhXCS4BgHQDZ1jJxy4iEYHpQg
 4Ec/8CW9F4kG6VEbROMT3oy7RSyTmfFAEGkNKbH/ecxpSAsNM7mT/RtBMs0bJEsYcHPe
 kQUFDeP3Dk657UoqkHFrAgUtrOz3Se6XWY42HNUwT+ZmqjNOvly6otQQUd7ekMRUNHac
 fSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777580; x=1716382380;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqbX3+t9p0LZsldOKhZGRDiCCka3lbUHUI1hHdPQxR4=;
 b=esdcWhFEuBeQeKRB4Xl0F+5MapnwZsdHXi9N2sUH7bQ7EbUfcNNwwcdiF9GNOzbf+z
 tVyS3q2VsU7fzPx3l2DHMw5bnnmAqyEGN5xtz/nKH6Xv56gijn3tXkza6S1r8yFOKsOH
 oR7UDFtXe8oEBa6LmCR6hcaiVnQGMcMdeVzxpcnSjx/DH2oj5f4sOhYxNz0UzWWUXQkc
 qJkHD+cZj9wASzfM6KQE0KtZVFQTzb/8+VfVnjN4haOQtEBM1Fk2vX4VHQSIARzIXJ4n
 uHJ9htCAw5ZiZkeB8mhwn+ZQl0GVfncPlVE9d+m8K8g0Zc+5jI+QbIuazdKZXrbCXzda
 7S5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1xV7jgntOKdLYMMNJZ2mEji/CAUSSX6/dJq1CVfo2qtkwsdc8wEjv/Jh7I8EnlgL0zvqKqPwMc6o1zUFP3yXvxmPI6kc=
X-Gm-Message-State: AOJu0YwRBOwcPfle7v7HJmkO1+YEvFOyfItd38A9j5kttTExh9LW0fB3
 QP9rwl0Ivq3xvoV1J/3EsjEhfnu2kjRljlfH4tKUwjDFGPrRGE3lpvB385Bge6o=
X-Google-Smtp-Source: AGHT+IEfZmGoZdEJW4RahfsRXOeZTh459Zjf/25BhrGUeZfnJP7yQzZPX1QZbJhagAWrZFAJ4/1u+g==
X-Received: by 2002:a2e:3515:0:b0:2da:a3ff:5254 with SMTP id
 38308e7fff4ca-2e51fd3feccmr132888131fa.1.1715777580514; 
 Wed, 15 May 2024 05:53:00 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fd97e842csm223481355e9.24.2024.05.15.05.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:53:00 -0700 (PDT)
Message-ID: <0f00bd89-6bf9-49cb-9328-32ef66cdf1ce@linaro.org>
Date: Wed, 15 May 2024 14:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] Remove return value from reginfo_dump
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> No uses actually checked the error indication.  Even if we wanted
> to check ferror on the stream, we should do that generically rather
> than per arch.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu.h                     | 4 ++--
>   risu_reginfo_aarch64.c     | 8 +++-----
>   risu_reginfo_arm.c         | 6 ++----
>   risu_reginfo_i386.c        | 6 ++----
>   risu_reginfo_loongarch64.c | 6 ++----
>   risu_reginfo_m68k.c        | 6 ++----
>   risu_reginfo_ppc64.c       | 6 ++----
>   risu_reginfo_s390x.c       | 6 ++----
>   8 files changed, 17 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


