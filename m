Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5734CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXa1-0004oG-TZ; Wed, 06 May 2026 04:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKXZv-0004o0-AE
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:25:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKXZt-0001lp-O6
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:25:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-452169ae568so110887f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778055955; x=1778660755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pxJsbed4vDVoDnW6zsS1RwiJwyMi+ON6WElcbf3aGrE=;
 b=HYB3Z8yRUb/Y8BT3UYCBfH2/Vm1ziHq0J85aEP4KPP1Sqfp7rwH02egxQ2hM0xSWiP
 yrU1KF0TAMofgzMdce/5R58KRjH5KZZkGJs8+ldGeksvzi5S6Sw/zNPhzqIXTPa3jT/+
 W0AalpZA/1hCs1uw/OMtt4TfJB5Hg5Jd7iguN1IysdEPKE9CH31/HDr/YhbLv6rHalLF
 JAM/jxaim++pFprIT/NGGgL1oCcTKNsU7F8C5X6YZBEmMoFvcYP0MqTOEsS3YY8NTYhp
 3sK+5wxVFKOCvIeF7KINKyspo5IXfkUITL8XljGTKaGLqgbU3O+RuDr9XlYeChUiLj/1
 2zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778055955; x=1778660755;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxJsbed4vDVoDnW6zsS1RwiJwyMi+ON6WElcbf3aGrE=;
 b=OyINoC/lcKvoDTYT7gqQ2wk4RNoa4Glivzpcmab8juAdzYAI1EV3CD62vGoViZ6CTb
 kTxT283LtwZUDoiN7E2LIDT1KZxTVCUo/33GmmpDONAdvcx10rRBg5gT73titw1kIGn2
 9kPAEgVpbKHyKnRYWdZtTndkob1Agm5Wg4bGAo60yobo6NhmkWANRr6fEquoyvSommpe
 5wjo3tDTTA8IrLpQFwYNjR7HSfl/c4ga5vpbldfkVvXGbn2BW9eBXyzPQn+1ICwGNIWp
 bfEKDPuvI70FuIfvO+bdV8yVI/Jxwjl3Z6bm4QqqHB3uVjfiGLifrE6wupw0WFtvEhRr
 yP3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GjmYP8DcJmZ/OJjaXJV76KZiYI5yQmumUssVo6dnVo6Z5eE6Xhj6EpCk/BJrEAcQ7W+A2WbACMlkc@nongnu.org
X-Gm-Message-State: AOJu0YwZZqghvTJ1pVUV3eKv27ROvoIJRKgF1c4U9Ed72ILpZ0m3mrwD
 hOtFMh2nJxLred2blrfJLhAQZeeG3irhOfnklaRZCafKzMaYwHPghsPvHNeY+FlWO8s=
X-Gm-Gg: AeBDies4zIt1GICYG1cHFBzpGQM7GWjZqfrZnsBBhKpWbXBvY6toI0mUMIttY3ZHLyl
 CVRfo+uJIrMzD/+ylyODCg8WLzuX5kVBcgWrl81iQKqHv2Aplqn+uIvQZz/x52DU2FtCrNg4m2k
 akPoeJ4LLEElhkH8bwwzYATPVHrnlkAkjfMSvHGafMAhhbrpHlh3ssmcdj5SuyAK00dtjFn9wpx
 9kosLG+8BVS+8UQLcVfJX1kqITy/NQI+nAvfY3vdkw23sgzRhJR3J/wWnrcYv4lOAgnUZDesJw/
 Z17QB2J2TzrN9fn3CtTyW7XKgCEufiAlgd0TXNUZwskDNyPa7yypvTERccn2z4cOHcRJ0fhQbIf
 dxiaLD5ZH7ClhkoAXQK9VPTUpH2Ne/LnrZAtNCUoty8rryL+LJ4ytRhbmsMmCXXtMXrpGIPMldq
 +fL2ymepmscqboXnHfQMtcQlpc7wZu1JhC1nUQgVmny+mAIQ==
X-Received: by 2002:a05:6000:22c6:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-4515b056c9bmr4002826f8f.7.1778055955084; 
 Wed, 06 May 2026 01:25:55 -0700 (PDT)
Received: from [192.168.69.210] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960902sm11886375f8f.28.2026.05.06.01.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:25:54 -0700 (PDT)
Message-ID: <987b8bda-0f6d-4a8c-9e81-a6ffef9a5ccc@linaro.org>
Date: Wed, 6 May 2026 10:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/10] .agents/skills: add qemu-code-reviewer skill
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505170105.228162-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 5/5/26 19:00, Alex Bennée wrote:
> This provides basic instructions for how to download and apply a
> patch series from the mailing list. It currently doesn't outline any
> details about how to do the review.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .agents/skills/qemu-code-explorer/SKILL.md    |  3 +-
>   .../qemu-code-explorer/evals/evals.json       |  1 +
>   .agents/skills/qemu-code-reviewer/SKILL.md    | 74 +++++++++++++++++++
>   3 files changed, 77 insertions(+), 1 deletion(-)
>   create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md
> 
> diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
> index d41b21179c1..13cb71dd55c 100644
> --- a/.agents/skills/qemu-code-explorer/SKILL.md
> +++ b/.agents/skills/qemu-code-explorer/SKILL.md
> @@ -1,6 +1,7 @@
>   ---
>   name: qemu-code-explorer
>   description: Comprehensive guide for exploring the QEMU codebase using tagging systems (gtags, ctags, cscope), git grep, and build-directory grep for generated files. Use this skill when the user asks to find where something is defined, how it's used, or wants to understand a specific subsystem.
> +license: GPL-2.0-or-later
>   ---
>   
>   # QEMU Code Base Explorer
> @@ -26,7 +27,7 @@ make gtags  # or make ctags, make cscope, make TAGS
>   
>   `git grep` is the preferred tool for general text searches within the source tree.
>   
> -- **Best for**:
> +- **Best for**:
>     - Searching for local variables within a function.
>     - Searching for string literals or comments.
>     - Finding occurrences of symbols defined in system headers (e.g., `optarg`).
> diff --git a/.agents/skills/qemu-code-explorer/evals/evals.json b/.agents/skills/qemu-code-explorer/evals/evals.json
> index dff7afa52fa..131cf46e1cc 100644
> --- a/.agents/skills/qemu-code-explorer/evals/evals.json
> +++ b/.agents/skills/qemu-code-explorer/evals/evals.json
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   {
>     "skill_name": "qemu-code-explorer",
>     "evals": [

Squash these to previous patch?

