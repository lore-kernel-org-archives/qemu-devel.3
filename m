Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ECEC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfbl-00067V-QY; Thu, 30 May 2024 09:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfbg-00066Y-6L
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:14:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfbZ-0007CP-Iq
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:14:06 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so475533a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717074842; x=1717679642; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f9I4jXGCxf5Kmka0GZKNb3DTamppSrnYUnmoTv+DNkg=;
 b=QB8llEIP/6o1h1ETLg0xWhgWTnaZZXqY+7RsLK/JG9YGB/TLrjPu2z34HqScr8kuyb
 EkqzNJuV8E9HNf4d67UbEWMh+tsNEOrSpXzbNGNtUjzqjbcoOK4JufO5tr6wFmUgYz2g
 dy3lQROZP2jtFoV68elbC8upUAN41MLkLZuhZxGg0zmCHmSHiicHTxifC8r5HVts9EqS
 L5UA1DthCuaLmYRfCJUTdx2ZaTe0yeoc16wfwogcPVi1+n94/HEpQBxZyxIORHl9+tTf
 BlRgaS0AFVb88xW0vqA8mzYX2VLMpcZ+2WjrEMDKGUjsDQzsCCL+XfHYwpw1M0bsU4ZB
 3pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717074842; x=1717679642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9I4jXGCxf5Kmka0GZKNb3DTamppSrnYUnmoTv+DNkg=;
 b=EokYZCGjwETPEQh2fU10fnkbfWKIJm8ZD7I+H6v7VHXUIY6UDL7dMr8HrnR6Zr+kKj
 H9/8pBC823DH7B/+WeePwnOExMccm2vG0Lqt6dB9Rhp13kirBX/awHzS16KHK6+TLLmN
 gVOjxG6mveFu0up+FsYb/kVpH3w8wgd6YxpxuOuidQabkY94Yl7mYlWMtLNLT4n1mpff
 k/fGW/BhuUpKaJ58AphKxhnRoL0MyjC1sqy9k6yfjSXaOQ5zEDUrYv7SWzZ/C4dFt7Sh
 K0LnEzYHSWh8S/pO0YqFSXVtHSMH7pZNgC8/RkqZmnKCxYyMpYsmkhL1H9UVkT7RiFSJ
 JHDg==
X-Gm-Message-State: AOJu0YxB2ZEMCk5qznsa+zHejC9TeYu8jt/nY3tgox7/J7cupx+2Ef+i
 D3WtlFQqpYyqgYYb0YQQj9I0zndO1jd/XrB26qHp6O79VXRp4x1aIjMFASo3M7FYXUBBeHPAmib
 oXPy1kNjQTvR6F8IWuf3x3dZMSzn5ur+NRFncfTNNy5/VkgYM
X-Google-Smtp-Source: AGHT+IF8FjAmw+xgipPjQjBpxijQU/zh4X7YOcA2cpIBllU8zaSbihYHdMskRxwKYVb3YZlA0lPuwrKn+JmD24Uk1Vw=
X-Received: by 2002:a50:a419:0:b0:57a:2a8d:f095 with SMTP id
 4fb4d7f45d1cf-57a2a8df141mr423399a12.19.1717074842065; Thu, 30 May 2024
 06:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-8-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:13:50 +0100
Message-ID: <CAFEAcA-zunRkE+VfRxdDtsR0UNWGMeae5ObRGJTjqg6jyB_hFQ@mail.gmail.com>
Subject: Re: [PATCH RISU v2 07/13] contrib/generate_all: Do not rely on ag
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use plain grep instead.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  contrib/generate_all.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
> index 651cb23..5ff0b3e 100755
> --- a/contrib/generate_all.sh
> +++ b/contrib/generate_all.sh
> @@ -78,8 +78,8 @@ fi
>
>  mkdir -p ${TARGET_DIR}
>
> -ALL_INSNS=$(cat ${RISU_FILE} | ag "^\w" | cut -f 1 -d " " | sort)
> -COUNT=$(cat ${RISU_FILE=} | ag "^\w" | cut -f 1 -d " " | wc -l)
> +ALL_INSNS=$(cat ${RISU_FILE} | grep "^[A-Za-z]" | cut -f 1 -d " " | sort)
> +COUNT=$(cat ${RISU_FILE=} | grep "^[A-Za-z]" | cut -f 1 -d " " | wc -l)
>  set -- $ALL_INSNS

risugen's definition of the regex matching an insn name in
parse_config_file() is
  ^[A-Za-z0-9][A-Za-z0-9_]*$

I think we should be consistent with that. (PCRE \w isn't
quite the same as it allows a leading underscore and also
various unicode letters, but it's closer than [A-Za-z].)

(As it happens we don't have any current insn patterns
that take advantage of the ability to start with a number.
So if you'd prefer to define insn names starting with a
number to be invalid and change risugen instead that's
fine too.)

thanks
-- PMM

