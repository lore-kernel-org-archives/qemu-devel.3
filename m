Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA27E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgI8-0004gt-5L; Tue, 17 Dec 2024 17:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgI6-0004gF-Bh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:46 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgI4-0001GN-6i
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:45 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso4576119b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475423; x=1735080223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LNK18GmLLWC1Gkt31PfdfrwF0KHp5RTE2VoXyCRDNkU=;
 b=vt/jFjcjQ/5PRuXP/MC59FIHZMEC2P45d8MFjkD8/JW3eSKdQg3z/Y1uC6WrgrFvUm
 wCDaZRurwwCVrP1DViuqVex1WgSwKhOrcVf3yi1H8Gn13VS3FiXaoPdHAA5oS5D34ZtQ
 0sEIdzBHezIBsqhS7HBY9J3HMQZysgF0ap0B8cVCvb1yfbrcqyOC+RfbbKf37O6fkj1o
 g5uVCsLWoJsK1GQjbycKPQez+4bKbGUkNdUHYriOH8xrZHRGvEq7ACJZi4cBI31AWLx8
 mTedq8iZtAriCZ23jGcwjrFO+Qh37fR5gc0WEcwOPb7fPniO6qlTh1JMCMyGFZQyaO6O
 G8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475423; x=1735080223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNK18GmLLWC1Gkt31PfdfrwF0KHp5RTE2VoXyCRDNkU=;
 b=oStyrafNR6arynoN1okZVUleEc9DEXrypkJJdjluljJTpcrLAZYKx3gLK0FiN6f/Ur
 3Zfi407/CGS/DB0MdFVJRCrY4W7Eb8U2v8FSzB/rLXHgiG/i7ZfNhRHjVxAMKAdcvXFk
 C/OnPvAMHcoUs45BowdvJuK+jEKkoeYc4ldUzOrgXK10MuDYeX3tAxfYEUqc/e5EfRTS
 KQW9gpA+q4iNboPea/Mkh2qzUq4DodGtstRk7Kv2U7fHGJRvx2E8TtrwYYD5MmSn3CUr
 Wja/OQBP5S1KRbLVugaHPQbJcxAAitBy6o3OKe7fX4tlEaZa22z6+iTXyU3B9ttFr1eT
 a4BA==
X-Gm-Message-State: AOJu0Yyl/I8crJoGmp/AyjY225JF818QUdxUopvT2K9TFN46wBe+BL1C
 UIHUfbfhyYlf1fc9dw46jIOWNZUbYaQTSvwldtwZXK7a4KP7MpKrqgSuIti3GmZBE1lM7/AYVRH
 ZNHI=
X-Gm-Gg: ASbGncu7S59bM1xZpgH7Fy1ZJVFS/YyyyM61w0n7W66r1jp4Y6a+OUGxuhcRZEyt2vj
 bCeoW0p0wTUF7IRKBMzT7ET9g0x75xEschSBN/GWeOggr6JabMSSn/Uahxg754N5T2DfEigOeU4
 XeJKyTbfORLhq55tZcpl6li4Qr8+vA5QS9v72fgWYT6VYJmu2A8r0yUrNtdmpaJakATqHPm608l
 ylepW8Rfw1AtDmymVCNnPgc/O0HZfFXyq2UBvx/GMNpie8VRG0TjyQ1Q4FEMgE4R6kKrA==
X-Google-Smtp-Source: AGHT+IH1YyPI1TpdDIz/wVvbo/l/FtZ0c13f5HD3kR9/zhaZoSWlCllPv/rVuxhbMFMmJ0lu/6o+AA==
X-Received: by 2002:a05:6a00:114c:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72a8d2dee69mr1081568b3a.19.1734475422798; 
 Tue, 17 Dec 2024 14:43:42 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72a805c49adsm1361869b3a.65.2024.12.17.14.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 14:43:42 -0800 (PST)
Message-ID: <126f24d2-008a-4e87-b743-223744464ab4@linaro.org>
Date: Tue, 17 Dec 2024 14:43:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Fix 32-bit build for plugins
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 12/17/24 14:38, Pierrick Bouvier wrote:
> Since 9.2.0 release, we are building contrib plugins using the QEMU build system
> (before, it was external makefiles). When building for 32-bit host platform,
> some warnings are triggered and build fail.
> 
> Thus, at the time, the decision was to not fix those plugins, and
> disable by default plugins for 32-bit host platforms (see cf2a78cb).
> 
> This series fix plugins to have the same behaviour on 32-bit and 64-bit
> platform, and reenable plugins for 32-bit platforms.
> 
> There are two portability issues:
> - we use hash tables, and use data as key directly. As key has a pointer size,
>    it limits its size for 32-bit platform.
>    The fix is to use pointer as a key, and point to allocated 64-bit data. The
>    change is pretty straightforward for concerned plugins, and does not imply a
>    memory overhead, as hash table entry is already heap allocated usually.
> - we use plugins callback data to pass a pc. This does not work on 32-bit
>    platform, as we are limited to a pointer size.
>    To avoid doing memory allocations, we simply we simply use
>    inline operations and a scoreboard to achieve the same result.
> 
> Tested (for every plugin modified) on i686 and x86_64.
> The behaviour before and after this series was checked as well, and there is no
> difference, apart from bug fixing (some pc were clipped at 32-bit values, even
> on the 64-bit platform).
> 
> v2:
> - do not modify qemu_plugin_insn_haddr signature
> - fix cache plugin to use a correct hash/equal function
> 
> Pierrick Bouvier (11):
>    tests/tcg/plugins/insn: remove unused callback parameter
>    contrib/plugins/howvec: ensure we don't regress if this plugin is
>      extended
>    tests/tcg/plugins/syscall: fix 32-bit build
>    tests/tcg/plugins/mem: fix 32-bit build
>    contrib/plugins/stoptrigger: fix 32-bit build
>    contrib/plugins/cache: fix 32-bit build
>    contrib/plugins/hotblocks: fix 32-bit build
>    contrib/plugins/cflow: fix 32-bit build
>    contrib/plugins/hwprofile: fix 32-bit build
>    contrib/plugins/hotpages: fix 32-bit build
>    configure: reenable plugins by default for 32-bit hosts
> 
>   configure                     | 21 +--------------
>   contrib/plugins/cache.c       | 18 +++++--------
>   contrib/plugins/cflow.c       | 17 ++++++++-----
>   contrib/plugins/hotblocks.c   | 29 +++++++++++++++++----
>   contrib/plugins/hotpages.c    |  6 ++---
>   contrib/plugins/howvec.c      |  7 ++---
>   contrib/plugins/hwprofile.c   | 27 ++++++++++++--------
>   contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
>   tests/tcg/plugins/insn.c      |  4 +--
>   tests/tcg/plugins/mem.c       |  6 ++---
>   tests/tcg/plugins/syscall.c   |  6 ++---
>   11 files changed, 99 insertions(+), 90 deletions(-)
> 

Forgot to include reviewed-by from v1, please ignore and look at v3 instead.

Thanks,
Pierrick

