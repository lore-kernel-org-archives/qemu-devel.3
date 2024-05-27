Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3155EC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWiS-0006xD-5Y; Mon, 27 May 2024 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWiQ-0006wC-R7
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:32:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWiM-0004aH-88
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:32:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420180b5838so56744025e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716802340; x=1717407140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/DU5vIId6YhzHGLFYreXmHswyG4Ber22YIIUQccoe8=;
 b=T2HPWt2BqMW+y0UtxHfQ8pu1SiKj0fJ7YQFdAOo24uJKeWYw9/Gf4uRlefWvK2yN6x
 P7AB6yxPQEHtfL3wNi9H4ylrz+RtoNwinOku70tOZhb9kHRtfNTa56xVbqzmtnMy+vhf
 FwDo6Ycf94k0CedpFi10PHA8U9we+EA4lgDlaq3hd8vcFK/jN4MSLa5H8QrKYDyaO5q+
 P1g8dQLizUm3BhOmxFSHTBP0hDEd9KdHBxgMoBybL95eyNtPwxYvAns6DKktF2ESf1Yh
 wACUQVOAH0Y9UnxKWpoaKGNj0EvrVjzRXia9nD3MkwD7MTe3JCu9TOb+tLRSjrj4YfTv
 v8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716802340; x=1717407140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/DU5vIId6YhzHGLFYreXmHswyG4Ber22YIIUQccoe8=;
 b=fF8L5eJLeTSiGuNJfrwDqznoWzZ3ohKY/xeM3gD2pfak0TWK0IsIiEsKgCHL0uwhIc
 K1L1UhsXh46qPIckf6sCl+SuqziLeOZKh9mE9JWfmY0c7N373XqL1DVGtdyXYB3ff5jb
 OiTtmC9louraF2INWsEpg/detdb/pjnx+g2NzqZRPdzsO72jfykaNgkXzcJO+jyTKq/R
 WcFq9iX6COl79zJ3s3vtE/bKI0cTaJ44/oKHVBiJoLG/1KkvwbND3xAaycKy5MkDXwzi
 IN6LzV3wQ3e5GrVU2FBFVsvmrRpITCeSZ7oGkng0w2zwYYnyts7BanZm1x0uTIvL72FG
 wQJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAjXPxoefAA+lgViPtAAeXdnJiCs7EcbgVOGq+3A8F1sY4bYG+USDbQNc5XPD1miMpfgck1wt35jO/yLoCs0ZRwPzBDW8=
X-Gm-Message-State: AOJu0YwqjxnGMoylFhIJ6qHevb6yTHZG/IuI8dCo7hbo+r0e9W5PDw3M
 ncwkkZ7cUOTzQ/9fsdPLlsTmGyJuvoYMns7Jv5ZHE4jS7TDJkqX9TdrDF+EFXSA=
X-Google-Smtp-Source: AGHT+IHkRxYFyKRO+kgrRQGAcq0u8Q+SMCJlItR1oAHAaikdt5RWPpw5jEJYg/W44LsBvWTho953vQ==
X-Received: by 2002:a05:600c:2949:b0:420:e454:1599 with SMTP id
 5b1f17b1804b1-421089da927mr90136605e9.15.1716802340384; 
 Mon, 27 May 2024 02:32:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100eeca80sm136215695e9.2.2024.05.27.02.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:32:19 -0700 (PDT)
Message-ID: <ed69a712-689a-4294-978d-d8d818a12b6f@linaro.org>
Date: Mon, 27 May 2024 11:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] testing/next: purging remaining centos 8 bits
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Beraldo Leal <bleal@redhat.com>,
 qemu-s390x@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240521125314.1255403-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240521125314.1255403-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Alex,

On 21/5/24 14:53, Alex Bennée wrote:
> There are a few more bits referencing centos8 in the tree which needed
> cleaning up. After this we can remove the dedicated runner from the
> gitlab registration. If we want to keep a dedicated Centos runner then
> we can add back the bits needed to set it up (although arguably we
> could have a single build-environment setup that handles all distros
> and integrates with lcitool).

Do you you mean we should generate 
scripts/ci/setup/build-environment.yml with lcitool?
Otherwise should we update it?

> 
> Alex.
> 
> Alex Bennée (4):
>    ci: remove centos-steam-8 customer runner
>    docs/devel: update references to centos to later version
>    tests/vm: update centos.aarch64 image to 9
>    tests/vm: remove plain centos image
> 
>   docs/devel/ci-jobs.rst.inc                    |   7 -
>   docs/devel/testing.rst                        |   8 +-
>   .gitlab-ci.d/custom-runners.yml               |   1 -
>   .../custom-runners/centos-stream-8-x86_64.yml |  24 ---
>   .../org.centos/stream/8/build-environment.yml |  82 --------
>   .../ci/org.centos/stream/8/x86_64/configure   | 198 ------------------
>   .../org.centos/stream/8/x86_64/test-avocado   |  65 ------
>   scripts/ci/org.centos/stream/README           |  17 --
>   tests/vm/Makefile.include                     |   1 -
>   tests/vm/centos                               |  51 -----
>   tests/vm/centos.aarch64                       |  10 +-
>   11 files changed, 9 insertions(+), 455 deletions(-)
>   delete mode 100644 .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
>   delete mode 100644 scripts/ci/org.centos/stream/8/build-environment.yml
>   delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/configure
>   delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/test-avocado
>   delete mode 100644 scripts/ci/org.centos/stream/README
>   delete mode 100755 tests/vm/centos
> 


