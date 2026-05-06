Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F4DCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXxA-00087C-Uh; Wed, 06 May 2026 04:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKXx8-000870-0z
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:49:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKXx6-0005f3-Dx
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:49:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so1807507f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778057394; x=1778662194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJiwg8hYp96BltpHNK2XbtYxYrDFICr7Bz+Ii49pY6k=;
 b=CWpwtXZGoXhJv0tv9OXOyJcxCuM1JuvDiTZ3UXDuMlFJeOrXEFOEzXTTgJz0MaEdMD
 BKOQpptZrc2K8BvAWNxnmvSJ/HRJlTvl6GCEpVi3ajR88KfH1pzuVUS/LFVb8JjF44vV
 +AQvCj8cn4u/XNwf+RSb5AYBpMqWFBWRDhU0re4j/4iXXmvTSZp13x7w8Wrwjj/ZTZBD
 y3tEPLWyYctxRnBAmZ9Iaun/cnLHBrHKHcaJq3I7TwVw6Q+P61Ik2TPimHQj5clZSelV
 T/45tR51cfsjw6GBoBaOHJWoNGM/3KBotFfbhPqGU0ksncsXLIxiGpCW3kDjS8KJO8Ut
 G0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778057394; x=1778662194;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gJiwg8hYp96BltpHNK2XbtYxYrDFICr7Bz+Ii49pY6k=;
 b=ZL4F9LFpxbOWBA0Dd8INn18WuwZkNl+CRUuLtUcduWjaApUuQw8q56XPm7GKPk9zxS
 W9JQxx3SHg+HL4JW2fA/3/2nQQzou3Sd6KLUfkc43tnFXJ6+jMXlzV55gQ2MMBN2fOY2
 cDZqImtQr1/czwTaNaXjSnT50IEnNydHHzbyB/+eQvNKhzB3/5RD/Wzr7VP+rgNRmV2h
 3/WDiCmz8gOmF4aNcXtURrJAsWBiIr8AOwTNVJfeZJRoyJGBs86p3OOQauPb36wNUPF5
 OMyv4MfZeHUHHVSCtSlCCqDbzpN2a4SPZQSlSeA/iI900ISYvNlGcdZO1tJtAN2ARuXI
 7AEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Qv2RkZ3K53BUq7AFW+Vwd8Iv4O2JaihdniuuPu3CRkWR8eIL4HQR+ec3fEhS8oBfkW5Kt3PSrobXP@nongnu.org
X-Gm-Message-State: AOJu0YylE2pLSuGNY5ctznThpMtTTTl3Qjgo/7JJ5mNtSuhujYs+E9L9
 NVOAhknSkGIKyjcao33MYfbR+TRHm5iDvjUWpF13Hlws2U7wNAEkqa17cqn+B7UkWwo=
X-Gm-Gg: AeBDiesB0ojVSGqqWWcKrNS0cclRBusdORrO4s7Y59zjXkonQdQt/aR8Qe8FX/4568T
 6AMys0fWc0M0tADaMVkuWZV2DOy+hgxwret8sTEZh04UIXgXqmasweqEbqOJ9nbFNLGgDq7WzWv
 /kaXkRMi7uAC9XW+pRKCg+vx1HbhQpBTb/g3432hI6c4hfJc5i4ncNhiv/Ov3urfCXP6CC7+xhn
 KLWB3au8u1uxYgHastoi4Hl8TANb8V5k2bnrCt3nYdjcSi4v1FJvR6xmm91J8xAloewErD+RW0y
 Sy2idGJ7fW+eM+ize3NUy4mmUmmSBiD896Y6uu9pIsigZqFKsBPKmlE3Q5o07QJwXrKLJtgzWZa
 jID1KP1pSXPYCmpBEz+qzCveOH3J2UkRsF9GENet50M4MyvpznNMpljQZ+LjaFJ/Bvgwy4klQLV
 zDGOE0yVy5t7q+jBQttCcl2kqaoBZikbyKQ+VZrbbBc+5/XXBOzZTNgF0d
X-Received: by 2002:a05:6000:1acd:b0:44a:75e2:5590 with SMTP id
 ffacd0b85a97d-4515d6bbf6cmr3888325f8f.35.1778057394173; 
 Wed, 06 May 2026 01:49:54 -0700 (PDT)
Received: from [192.168.69.210] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e6e0sm10677127f8f.6.2026.05.06.01.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:49:52 -0700 (PDT)
Message-ID: <7efd2995-1b3d-46d2-a07e-f49d8288ec3b@linaro.org>
Date: Wed, 6 May 2026 10:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] AGENTS.md: add basic AGENTS.md for QEMU
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505170105.228162-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> This was written initially written by ECA based on its understanding of the
> code base. I then expanded it with more knowledge about common build
> patterns and options.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 00000000000..401c48da810
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,93 @@
> +# QEMU Agent Guide


> +## Agent Skills (see `.agents/skills`)
> +You should use the following specialized skills for common tasks:
> +- `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
> +- `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
> +- `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
> +- `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
> +- `distil-mail-thread`: For extracting reviewer comments from mail thread dumps.

Can we add each line within the appropriate following patch?

