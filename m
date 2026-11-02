Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6A606A5B2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d6GzYzkO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuPZ-00053n-4i; Mon, 02 Nov 2026 10:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNuPU-00051d-0u
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:57:24 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNuPR-0007hG-6d
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:57:22 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-89f85edd210so1187451b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793635039; x=1794239839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6CHM2LIUU1+OktdjA4vmoQMT4ZRlNq5nYjN45pwWZPs=;
 b=d6GzYzkOooe/d548yuXnVgcaUjMU4/pvKTyEepH4RJSkqfMIqsexZ16Yh/JpcQpyDR
 M36FYIsHs7VOGYTqUqmuy7G9pwQ6VQBWC2ITC9oMZFQNR5+asMKcafDMJnL4dL8tY+gl
 FLxWsohNGAlohHFp4ks3lRI5aqPZRhICU4WA4SC+N0yyAx7OxDbgN6ho2cml//6Gg6Op
 gaTRoqWFCXgHIaAN59m7NFbVhrbmZ5msjHfg2AAVA3K2vazl0M9gNWwezvIjg7FOtJMp
 n7LhDL8aNXgBM/WNexLhV17K00q/L/Tc9gjveLOt8IbMQr8eD+gCAqMpTi7GijCtCNis
 HN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635039; x=1794239839;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6CHM2LIUU1+OktdjA4vmoQMT4ZRlNq5nYjN45pwWZPs=;
 b=GdjprVMw/1W0SiqGAa04h3oeLlQJ/XoTw2bXO57PYIqeDjh91XdxOuBRCUM8XQD7kU
 iKZLdaplPz42ce+Ot0BpjV4TxS9rr4SJeYFLMyWxMrQR85q8xtsUqr3mGiW4CApZQHxo
 Uhux+QoWwhlZ0OKtqOE0Uprc0xg3z72RNSVKzAmyHLvmY/gE9tyvFiabfHPE9AchI6Rh
 vA4JRWLu5I6NIdbRj3A/SAni5enk8gS0f773/vifJ8BTcbxs/ImH3CHB+6001HyBjxVm
 3s77g2LIccDf7t/rt4jkeko7tWO2iyg2yZHrhLk7aKBqHbM0+tNG5nnmil2xfzMVKk/9
 aZPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0O6rT8O+Iq719fIPY4yjvTCSxMtOSh+ZDDliRjs3NxoXcALmojSu6HvsdQ05ZFegr2lBMAvICTBEW@nongnu.org
X-Gm-Message-State: APuU4Z90Fp/2UrUYyByxRAUcC2g0kCuk9fO2mLo4Rkad115vnswJ8q/M
 eEFdzzDrm1AKxSpkUCbvg697S5mX2/oKr/pQ8sSUs8bPmEzODnz3H3nG8skCPz0+9nU=
X-Gm-Gg: AYBFou3Z/WZodjtvdkK9JYvAd6WdrIGIfhf4tDBfDnnH3uDjL8Mj9B8B25du8K+gfh9
 Mky9YuAVgy7CF20g7lKZv1uA3xxD1r0bUuaNpzS1Mp8wW98Zuaw4NWSoV6+J6edLiJQHadkFCxI
 sAETOx7uWPbyOMJcBuF8XYlqDe6q0pux0y0zmnsB6T4raKJDOjGe0tPJasKdgDXJ+fzMmAirHWO
 Dy1906gDYz1BhuFoCLP4oTavQW9MeXHP83ECAKVgu7htyBMDSsu+wb9DKdcHuxlamTkuyh55Osz
 DQZhXWkPWO0SRRX8AW3Im3ELcBsSBI87V3VsCkg/SohDrfkgfxz/DL2CnsmBBt6Un2RdaCQfFBF
 1jS7hVDy6lxh1iEl2aoswohreogdLw3ii1pxpu/jjE0xZ4Kgy3M2WD67UBTGJsnRxonmB3k/ayA
 D6LvApYE0lqB6LQYuXVlOr2UU9XN1pl/MPPMh1h7TA3Poh5eFN1i6j7g22t+xyETVBjyUnIGBTp
 Y9/E7zA7c7g+h4Unm85HWxaTQ6YfvALUEXvG2blefUw1inTPcOQv7rqQJ5mOyiYmx7Dev+TUksQ
 wn15shF/BbCjPTCLyEu9pMOdRIhU8BJUmXmkX4qijo4ccYiQ1A1y/vsXdgS6g/AZ8t9UOA==
X-Received: by 2002:a17:90b:4cd2:b0:3aa:6b5d:9fe4 with SMTP id
 98e67ed59e1d1-3ae896f8622mr7316715a91.12.1793635039298; 
 Mon, 02 Nov 2026 07:57:19 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3aebc8942e0sm5853155a91.7.2026.11.02.07.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 07:57:18 -0800 (PST)
Message-ID: <bfbaa0ee-20a8-4cf3-ab2d-f2ee92946315@linaro.org>
Date: Mon, 2 Nov 2026 07:57:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Bug fix for QEMU Guest Agent on FreeBSD (2026-11-02)
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261102115657.89700-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102115657.89700-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 03:56, Kostiantyn Kostiuk wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-11-02
> 
> for you to fetch changes up to 03efcb7cfdef40ee3124a80b2609d800ec1df1db:
> 
>    qga: set FreeBSD virtio-serial channel to raw mode (2026-11-02 13:06:30 +0200)

Applied, thanks.

r~

