Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F77DCD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurxp-0002fA-Dq; Thu, 11 Apr 2024 06:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rurxh-0002Ln-TA
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:47:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rurxT-00056x-MW
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:47:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e2b41187aso1234079a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832426; x=1713437226; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sKWmKBLG+YXBZ1tTc61l69JC4XvmnzRAHSm/Kg1vw9U=;
 b=Z5X5HUdTOhuGTwVwDZu7uz2sZq5zpbUeZNhLEAogXRISL+49mCUZvcu36qVeSRQ4cD
 /fRfWvmCsoM8depr49EPNH26O4+It+/E1OgPqD3PCTt07RuA+9Wi1fdE7W6I4kRSXBdd
 v+4yMNae6Y+nyxeTc7pZEasOOzWb/B/XC/PBoLJXVK1nhJswEZkzlHHymL7H3M/Gk95j
 vimcW5Cj7y2J+tZZi4kILg//RrkmR+nLqxwIjG2smwAbCObC2HkJ+qgrnM+xI1ZRAymr
 JfqrkSU1Bzm5koy/2+ukOFKmUT/8H4RWrtn7StyvisLN3F7xC7SwDoSqVoNDVO++uQEW
 uYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832426; x=1713437226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKWmKBLG+YXBZ1tTc61l69JC4XvmnzRAHSm/Kg1vw9U=;
 b=PM5miPkVWv+HYljKck8ovBOD6nIhIRhnwvX7Lo7EjFb7Bw8J8G/mGmgIzSQOQFltLa
 NgptZ30ORJzmcGDtloTNnAy+NgHrTwYsBXNGZh8z4ia812mBLNrMT8bK62R0EjS77SDA
 B74jNol2TGBLzj+ZSRLN4rHP7q42Lx0A9Z8HvMrpmpb5/Yxp6he0sj7/anIlKhhBuwgr
 9eh7Oih2K9CnuLw9uozcJ6cWgI9cLww5el5N5RqOir7sZsHZulmE1DFPXY+Uc6WyeSlC
 /+eOAM5dCzAuDXdyjUR5lsv9v7utEGVHAK3VPS6c0AxCGMkdfE9fOCSn6WBpXIx1aYRo
 CSQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS5gNeog1JAtl4U7P7UIbHYY82WUs48TGDRFZHveGk8k1NKrhEoFQzcJcXGtJ7SPpD023ffia8hsLYM19tUWuMFmXTVFs=
X-Gm-Message-State: AOJu0YwL3cwmdcZtwEz5mr1g4EoUOVe+TMExQ4iSfJV0+RLavxpi9J8A
 lGdqMDk8bZ2HJDQvD8GwVUnK3buv7SVzG5e2wBtkB6hDbuem5h2PTWzASomG4Tw+H3SbiKAY+We
 46cNGzFxwbdaAs1ZDD3XpuYMjbw2W2JpPeyGm+Q==
X-Google-Smtp-Source: AGHT+IGT0SIm+7bz8FJuCUjI46yXJbsBQ6DCyC8G+2TvHa6rXvfGg22ujNbkn/rju1wwNmNGp4nw+sWLWIhsh/XHGB0=
X-Received: by 2002:a50:cd8c:0:b0:56d:c85a:7893 with SMTP id
 p12-20020a50cd8c000000b0056dc85a7893mr2169253edi.8.1712832425985; Thu, 11 Apr
 2024 03:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240411104532.588170-1-peter.maydell@linaro.org>
In-Reply-To: <20240411104532.588170-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 11:46:55 +0100
Message-ID: <CAFEAcA8-QfBq_UGHtS00tBYEOY1y0ZbzbcyaCeNp430kHuGJLg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Avoid sprintf() in the imx devices
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 11 Apr 2024 at 11:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Various imx devices in hw/misc have a pattern in the
> debug logging where a function which prints register names
> has a fallback case for an unknown offset that uses sprintf().
> Use snprintf() instead to avoid warnings on macos. (The
> buffer could never overflow because it is 20 bytes and we
> will write at most 10 digits plus 4 nondigits plus NUL.)
>
> Commit created with:
>
> sed -i -e 's/sprintf(unknown/snprintf(unknown, sizeof(unknown)/' hw/misc/imx*
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Philippe: here's an easy sprintf->snprintf conversion for your pile :-)

Never mind, I hadn't noticed you'd sent a second patchset on
the sprintf issue, and you've already covered this one.

-- PMM

