Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0FC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDa7-00011d-2l; Thu, 07 Mar 2024 08:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDZx-000119-RG
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:14:33 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDZw-00038F-5o
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:14:33 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso1100719a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709817269; x=1710422069; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=umYslEZ0CZzfXto0HMP2li6JHScMPmY5cbLxNVT/AyI=;
 b=ELV8j7GgYNFhxze48LWuj65PHpagmBViBmKDAnkoiIeLj/Zid5GVAppBl6g1hrjXLW
 TzASEj7mr0sfZiYpsLFAijIO4eT9hsxBQHDGsFJW2XFniIQMeIPal0h1WnMMV5E7mOFp
 wHHI82WM1Sq7259JUDKnWgpYbd3qPCVj7HK5ea2VYKTzt0wT7IR8jtwxj7bYxPUzmU2G
 VlMraU1iJgKArja01iB7jLXj6t8e5pEDd3DXR07Ak5DE7kg1OQZ0Ga1mNDTOB6ROxSwZ
 Q9kkL/47QNHiMMJ/rR6EizpCny/MdlrnpqhmzeVn8NHqpYvjTJ2hkprt/u0CaswmmhLD
 4flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709817269; x=1710422069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=umYslEZ0CZzfXto0HMP2li6JHScMPmY5cbLxNVT/AyI=;
 b=u4Qpv16nOAq25C//UKaKJev+nwKcw8fgbpzE5lIWpPp3nh5O3tQvy6JUJQMG2zAj0c
 haG5jLPZritzICM9Hg+F5o4+enq2+wL77QmxLSy/d68LNTkILGFf3jiV2i0k1FjsxbIj
 YCBv3TXtepZC1fCBYTwkPMfaCz9xSEu5/oaJ7DNiZL+Ygf5oZeuoMH9rRiwuzl6RqhfJ
 Iy1GQNA0ek3eBcXm1v6MjWActHGzcYsyrtsSlmM1R3gGQxVNjG4IrVYjXCu7CXMZlaoc
 k6Xn0qGTO5K06T7dOIWWtrPEs6GQ5GgDnmpQDNLjfWBj2VN1u7uiRIzFmAM5dpPP6wRN
 qx+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Aa5fnHhk+rJLrQ9vgWofXHFPuhaXZ3ToE8R8Kq8gyrhb9Iug00wO5pQRMR57rUsV+Z5V84tOSFNuWfaNlBMBFOS+pUg=
X-Gm-Message-State: AOJu0YxnX9qO+LSNpDrzp186wF6PLjcIbfVXZcrJowyNSqEGBTjX2Gvh
 pGISofiv28arDvQxtdRNOK9Tml+YqovrlKdwqhbGH2hkCZooKt5QW0a1k03/CuvHavW6KNOJE7R
 Y58O7bqcGkTFxg8pOQu2yNVdYOEZ5Op/ywLFcMQ==
X-Google-Smtp-Source: AGHT+IHsWDRZfr/T1TgvYpieh0J1BA2RNf2O5YOdxiW6TvELlo4G+MKdWf+3A4CwYzvZPoT0X+duzvH9TmrqBSTT4T4=
X-Received: by 2002:aa7:d1d1:0:b0:568:12ad:7c38 with SMTP id
 g17-20020aa7d1d1000000b0056812ad7c38mr2178461edp.21.1709817269603; Thu, 07
 Mar 2024 05:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-19-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-19-4f324ad4d99d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 13:14:18 +0000
Message-ID: <CAFEAcA8Nv9nz=21X_mGU0N+NSrxio6JLVVvYo0F=HiN8=Ac+Qg@mail.gmail.com>
Subject: Re: [PATCH v4 19/19] contrib/elf2dmp: Ensure phdrs fit in file
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 7 Mar 2024 at 10:21, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Callers of elf64_getphdr() and elf_getphdrnum() assume phdrs are
> accessible.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2202
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

