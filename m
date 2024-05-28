Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43CCC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzZ3-00086Q-32; Tue, 28 May 2024 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzYt-000849-Oq
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:20:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzYs-0002G0-87
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:20:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5785199e0d6so1521387a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716913226; x=1717518026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WnKnBqDMju2+kTOzdWij6cyOYKNfAnLsfvdkGPajW6Q=;
 b=ze/o5eP0X+05BNPV++cXf/zJLo6DwIw9q7ZAc8pmeFhZLTIKmF1g6m24DsSn/GZq3K
 sIUfXYC7BWJgAnLDwd3w5vIT2UiDqHJbop7RzWupu7gM78zztf6WYwBXLF7VUV+ebsr3
 vhijbpYdnqaVsEk/Xoikr1NVg937Wddc4k4t6V+5Z2g5lr0/Vq4vk3m7ZoBfv8PJK4Uz
 ks6k/88TlhyfZL2XvmcN9CvY/Mozxzyt49Kurw8kEb1TMx8GeRG2/rsZU872dcMBH/pQ
 I7LF4FYwqD1h+DduaUgoriIhhdIZwOFVRMwJXBvDbLzmulGhPpHDgnCiL+HU/Cscv8Lr
 A9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716913226; x=1717518026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnKnBqDMju2+kTOzdWij6cyOYKNfAnLsfvdkGPajW6Q=;
 b=V5dl/2zuWE+flJ+n0FJFITPFw+uieZBl2RZ37gZiB1QQJ4+pJsRUm+JJ99lxYa18kl
 CBMkikIWbLDSkc8GR0mOQeEORIBaSdD4QhI0c3buaMx8CWx2XX2dkkEZT5R+phm4JmZi
 KgK2/SIYFrFxmWuSaJ8S3uKVyFPsP/qzTnRqsBdOX7TnDegyhUIwNtWzhfi5N3j04GoL
 7qck4hPtwkIt+GpY3FAE5yksk2f95BzqDz3sbcomPd33LZHlGjAm99hADvu7P3RGxHIi
 5K/OPgR5i0FZQW4hCA4KnwOkkUTwJT9phIgdi1RaN+Ip0mu0lYtqe1DtCUupL7fhmyLM
 sAXg==
X-Gm-Message-State: AOJu0YzK2/MF5G0iGBTQsaJ9FNoe9nL32wimdVELENpAlfqlthtWCWJ1
 8Pl1zqxBzgqJGDzRIb69QpoEAhK6rAG8e5Z1B9gc2oAJPGl9/rlkNQ1Ikrf7sJEGTdguVz5SzWB
 OcIE0iJfQfeBsij7F2CTNcZ16vvyC55p9XvIFew==
X-Google-Smtp-Source: AGHT+IH1P9uJW5h8o3STrkuSgVIm/4bSS3MKD62c1pmrMvnn+2dtAUbThGAIVqwL3ndyRCDjqUcqBwWs+TFXyP5kLcY=
X-Received: by 2002:a50:aa9b:0:b0:578:59f4:9a29 with SMTP id
 4fb4d7f45d1cf-57859f49b4bmr9527841a12.23.1716913226318; Tue, 28 May 2024
 09:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:20:15 +0100
Message-ID: <CAFEAcA_B7hCi0wH8vFgfBq6o7gfmpMd6i3QH6P3RO1Eo7Q1fNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/67] target/arm: Convert a64 advsimd to decodetree
 (part 1)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In the process, convert more code to gvec as well -- I will need
> the gvec code for implementing SME2.  I guess this is about 1/3
> of the job done, but there's no reason to wait until the patch
> set is completely unwieldy.
>
> Changes for v2:
>   * Fix existing RISU failures vs neoverse-n1.
>   * Introduce vfp_load_reg16, fixing a regression wrt VNEG (scalar, hp).
>   * Fix typo in SUQADD vectorization.
>   * Two more conversions.

I've now finished review for this. I pulled 2 and 4-36 into my
target-arm pullreq currently on list. To save you having to
go through a lot of replies that are just me giving r-by tags,
the patches I had comments/questions on are:
  3, 38, 44, 46, 50, 65, 66.

thanks
-- PMM

