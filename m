Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2623C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFFp-0001y4-Qo; Fri, 28 Jun 2024 13:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFFm-0001x1-1B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:19:18 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFFj-00023C-K6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:19:16 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3738690172eso4063535ab.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719595153; x=1720199953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V35V4xy/avSp93x6rrBNSgluMeGbfDaOeyRAKmwsNLo=;
 b=XUxESFWjWoPfT6jJo4giferHLFuwJ3d4mgmj1UpTxiVM3nzIAo4mYvSIf5e93dji7f
 glR/xAs6Jqi9I8lgE1T62WuywCC4XZVwsubcx/cqQYrcJ/bzf3BEkLZsv7fknmuhr1GP
 cGl/edT7tkj7TanHOym2E07myNsynlOAj2hJC95fpb40f6TuwO59CtGOW+TB7xLCxKeN
 oxqlm4hrLjU5qzN2T9mE2qnf0ZknDwGFfdTmN+z/pz81sIjK4ZRzzGUwxpvm3BrYEFtc
 gyhjQXLkYDGTO6V+UAXhbj1lo/bxYFMEXYLChZkjeJb+cMOJ84pTKDqdkCunB5+GflLp
 Kcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595153; x=1720199953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V35V4xy/avSp93x6rrBNSgluMeGbfDaOeyRAKmwsNLo=;
 b=jNc9uYuJI/Dl21CIlmUtXwMowlydP98+bCx4EU4oDnlbr9weS0FgvLQdKu/WR1hup8
 5SfgcIF6VrYI4D11ULORO5r5Nv48drIGpXQ5Vz7UOEsAYYo5yliqVCej0YNTmD5HIbAW
 HtRe+iUcIO2gcM/AbeRDjZvivzy54/DbLnM1za9uEoHfTJlmxzu2/ZH+YZa5d7VVhfrl
 tz45kEgdFsh9LwbOY+7FkrToNJcOklnikvF6ugUsHJmOwS7Vmb15JPo2vWr1Z8MgwpZQ
 MUWdYat2ew6MAKDGPbgAb3vnvAmdQ973UArAzf6TxLsgOSwTtDvvi/Y8FYxw+yIq6Ber
 eLgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLmULWuUVIAYPvNm0Tn7PgnJ1rg1c1s4xsGgqqWIG/B7y2wF4JPOHilFwdJeFI1T7cIPNLwljFode0rJp8cfPAQwJ3Oa0=
X-Gm-Message-State: AOJu0YxHgdXnULSNoQSsyhibUa8K/KcwZ92G9r+Mopm8t1Mdgw0FVAmx
 JLwz+OtQlpDsjaAlxAkAC7Em8y6Oc2wishxFnJf9Vgdg2mxf2T8LF7tvThurkqw=
X-Google-Smtp-Source: AGHT+IF1OSAY+8F7kV7n7oDrfcKXQ9STM/c+975JkjXEXqUClz3ahiBdjV/lzIwAvW8EjXe79Xs9Gg==
X-Received: by 2002:a05:6e02:12c2:b0:376:40f2:9b25 with SMTP id
 e9e14a558f8ab-37640f29fb4mr228440515ab.0.1719595152612; 
 Fri, 28 Jun 2024 10:19:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a1b1csm1537515a12.48.2024.06.28.10.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:19:12 -0700 (PDT)
Message-ID: <2438d654-dd76-4555-98a8-52d0fa006d08@linaro.org>
Date: Fri, 28 Jun 2024 10:19:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] tests/tcg/aarch64: Explicitly specify register
 width
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-3-1690a813348e@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627-tcg-v2-3-1690a813348e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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

On 6/27/24 06:58, Akihiko Odaki wrote:
> clang version 18.1.6 assumes a register is 64-bit by default and
> complains if a 32-bit value is given. Explicitly specify register width
> when passing a 32-bit value.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/tcg/aarch64/bti-1.c | 6 +++---
>   tests/tcg/aarch64/bti-3.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

This is true of clang 14 as well, so perhaps remove the version statement entirely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

