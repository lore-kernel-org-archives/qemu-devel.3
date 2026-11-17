Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51712606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N/4LMr5i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPRa-000513-Rq; Tue, 17 Nov 2026 15:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTPRO-000509-Sj
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:06:07 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTPRN-0001TA-1D
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:06:06 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-886e61fa30fso112767b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794945963; x=1795550763; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2m5P+5pNkojYkVg+tas+Ovq5MbeFli/0ves+Rg2PDcI=;
 b=N/4LMr5iCvFqfdhQLFIcbkW6np1Vrnt2JVkIqeZsUZlmiKG7YwhIwS/UDBuQVi/QAl
 ewYNMESe49J2rANLVbruCbYxtiUVSfhdsZJFZmDQSnupa4YZW6DX0G+mU0Zohxb9a8iB
 gTKuehMpfESk+YUv/TkxfuE6+NtKxbGIKOQZEYJ4FYY7CVdrG6S/ZOLv58nfhkjX4tPI
 58CAzNZbtMN828GmxB3GhDJxqrBhmdUP0O/CzgfUNn8p7CZLu68h489lR8aWB1/9ct4O
 9Qc8AHUKZNTiVy+67/Mn0cB/R42By3ID2WmP+TyjmxTJtsscen2wWPnlcgpeC+hJxRHe
 m6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945963; x=1795550763;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2m5P+5pNkojYkVg+tas+Ovq5MbeFli/0ves+Rg2PDcI=;
 b=MtZj5xpMFme7ZY7b0TGz+5UvFZTj6Fzytk3waZrD/wTaHhMFcmBopMrqhlSYlhqHoN
 jGvNGaLrg68Q9NEQg+v+QB6r96OwFfoJFAvzAnlKOWtH/p0NazLVcJQwXkLrypt5+2Bf
 W14vpAIp/F0OXknnfh7hUstN168Ftoq96ErjsOTWjk2QIBUlCBF1pvDwcwCaCe/k7gvC
 XW7/Q30+0+rorOwSQCbA+A/0AfXRVQ73T90jfbc695ttAa3WTKO4JWdFmPGPGkxFcrV2
 uVg7HPFGRxOMhnqlj6hbHWBqDeLcWtB20V1YVkOTArCXi2l9MYr0Z0lS+RO1eOzxF9hF
 G9vg==
X-Gm-Message-State: APuU4Z8X8qUS85RSwTKCqSKeIE/1+jV6bUa972QCvquL6q2bMk5m8Lh8
 jiyG3yRxmg8jnEisEaa7JkcSbF4lTIoaWF7GwBuwMTNFX8y6Bqp2MktqZJkWkAGas7k=
X-Gm-Gg: AYBFou3UBh8mRhLalqAuq+sBwESNggFtkyXboiMI2nClCuN25ukvjsGW+WqJQWoaKzv
 akpHipgFc1wjq7vtodiwo+qiccPB533QbPhV15Ok6NDG36Mr7d9uc/vvejGvz+BZnwU8TxHmLD3
 m+u8NC2lOkYo8stRqNpmtz4LjhtSS90rTIZOSrYXPO1A2w0diXr9JXD9FI7dqzixV1GFoqihNQ4
 hGGtjxZ9yNVqIa74NjnCRt7p3LL+F4OQ4P5s2233493Hku6GTjlq33oyKBfX+W9XezNEz0bccr+
 ejfr7lO8OV2C7UVQTJ3ZoGGxGSBVru4Guxy2HyZllYp91RHnb/mRNmyizxCwZNAgAAxozQCX/rF
 hVZerpl6N8c9jfS9pxFuUVLJ7kCQNalVeefqURzfh8ojE8lazmdW2Jbg1GTGfb1FnpKpsW+st/d
 PasQaC3674SXiaNUz+tGgd6LDHr/6E1KdtmkZXMuBsCuCts70k0q4uaFjfnSVPhQ1+T54J8Ur48
 wrp/ubfVsMpQ0pL/wPrjzL0hJae7K094Th9R8Own9/9M03oORrnjLmB6ePJuEBF7EZXAjDsMpb5
 qn08wmM/syK2JNk16wRIG0zK5jLK+Fy1ZKT+ttn97DCXFNss0FGnfYodBYXOepQynrVZmDBX2y5
 4njS/R2SWhwdbE/2Q
X-Received: by 2002:a05:6a20:9c95:b0:3e2:9187:4679 with SMTP id
 adf61e73a8af0-3fe8b3f8412mr415587637.53.1794945962510; 
 Tue, 17 Nov 2026 12:06:02 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde3bbac09bsm28514a12.15.2026.11.17.12.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:06:02 -0800 (PST)
Message-ID: <389c8700-e10f-4435-a815-2965136bf5a7@linaro.org>
Date: Tue, 17 Nov 2026 12:06:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/8] iotests: better heuristics to find I/O tests
 build/source dirs
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20261117171758.237462-1-kwolf@redhat.com>
 <20261117171758.237462-3-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117171758.237462-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 09:17, Kevin Wolf wrote:
> From: Daniel P. Berrangé<berrange@redhat.com>
> 
> Currently the I/O tests cannot be run if executing directly
> from the source directory, even when wrapped by the 'run'
> script, due to inadequate heuristics to guess the directories.
> 
> If using the 'run' script, meson can tell us exactly where the
> top level build and source directories are, so we don't need
> to guess. Just read MESON_BUILD_ROOT and MESON_SOURCE_ROOT
> env variables if present.
> 
> If not using the 'run' script, we can do a bit better at
> guessing the path from the 'check' filename. Always resolve
> from sys.argv[0], even when it is not a symlink, instead of
> falling back to 'cwd()' which doesn't work since we stopped
> having in-tree builds. If invoked directly from the source
> tree, guess that the build root is the default 'build' name
> which often works.
> 
> With this change the following all work:
> 
> 1. From root of build dir, with run script
> 
>    cd build
>    ./run tests/qemu-iotests/check 5
> 
> 2. From root of build dir, without run script
> 
>    cd build
>    tests/qemu-iotests/check 5
> 
> 3. From I/O tests subdir of build dir, with run script
> 
>    cd build/tests/qemu-iotests
>    ../../run ./check 5
> 
> 4. From I/O tests subdir of build dir, without run script
> 
>    cd build/tests/qemu-iotests
>    ./check 5
> 
> 5. From root of source dir, with run script
> 
>    ./build/run tests/qemu-iotests/check 5
> 
> 6. From root of source dir, without run script
> 
>    tests/qemu-iotests/check 5
> 
> 7. From I/O tests subdir of source dir, with run script
> 
>    cd tests/qemu-iotests
>    ../../build/run ./check 5
> 
> 8. From I/O tests subdir of source dir, without run script
> 
>    cd tests/qemu-iotests
>    ./check 5
> 
> Before this commit, items 5-8 would always fail. Items 6 and
> 8 will not work if using a build directory with a name other
> than the default 'build'. For those scenarios use one of the
> other 6 possible variants.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> Message-ID:<20261111091133.3527549-1-berrange@redhat.com>
> Reviewed-by: Kevin Wolf<kwolf@redhat.com>
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> ---
>   meson.build              |  1 +
>   tests/qemu-iotests/check | 52 +++++++++++++++++++++++++++++-----------
>   2 files changed, 39 insertions(+), 14 deletions(-)

Fails all of the block tests.  E.g.

https://gitlab.com/qemu-project/qemu/-/jobs/18118947590#L135

>  === pylint ===
> +************* Module check
> +check:44:12: W0719: Raising too general exception: Exception (broad-exception-raised)
> +check:44:28: W1309: Using an f-string that does not have any interpolated variables (f-string-without-interpolation)
> +check:61:12: W0719: Raising too general exception: Exception (broad-exception-raised)
> +check:61:28: W1309: Using an f-string that does not have any interpolated variables (f-string-without-interpolation)


r~

