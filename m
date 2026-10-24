Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400A606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jx8qi2ee
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKdRP-0008QB-9T; Sat, 24 Oct 2026 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKdRF-0008IH-6U
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:13:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKdR4-0003YZ-DH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:13:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so4067675e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792854808; x=1793459608; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SY12YQ138oA5PxtPPQYDL2QQthYx9dGhXqZNnyqD8Ns=;
 b=jx8qi2eezSoGFWTPgb8RBOemqv1Xm/wx7LcxQpUgmE9ysjybZK8S+J7whY0EN13+E/
 FlaAQG3qP6iTP5oS+NOInbndCzzH6WGAFCEWfxrhtM1Y93GuGoEk8TayrjLdwpdUHd2P
 aivz+w6lKht1ZrJfEC4GjqkREzRp2dx0sY7zs5KdkYSAESktNn1vfIsU1h9rchqNMRgx
 Nx8tgeoYlek14j4c2bm7a3+EUstKnU6BiakA6yTSCi+fQiZd/qn9Dy2JvrRteXsp9kre
 NJWaYs8+qLvaoIzWjk/yJxyIMo6itay/UwtGtdGTsZr1IGXhDYbCYSex8U3JsqbkKol5
 2SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792854808; x=1793459608;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SY12YQ138oA5PxtPPQYDL2QQthYx9dGhXqZNnyqD8Ns=;
 b=orwFQ0doEYfWIoEJscCp4meW0ceGeyocCdSfBnDRU1wc5F/guJ2klGSPbDm0AdDj+L
 Aly2vS9SB5yfB7N1frB8+zUZJlkRl3Z8LQWEnUHnWhwI0WTVeug0NBuBrt/rATf5tXUY
 vNKWLH8RrvKiiodNR3nLvtuCpgwWDcnrcqs3EIn/CZSW37EtzTIgPkq6OPeTIK3oPlCv
 khnPRCQ54wDCEau3oXxEU/FHIvIWYwh7HY8y0uQzRtjmHnmXamyl+LpxfTn1qruljmEr
 4BnI6MPjfGnSMgFFapjLO6XJ9FGeZKIPBB8b4BFKmG0Z5+YwwCtFO9gbiU0NT9OIgIsJ
 1oTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwd6KtImPQ+Fte6PhxOMFICKuGBpfroy5Yk6bnSDHHjFQ9qogS4DEJbn36Ols/pJCgZzaj0hLomcPe@nongnu.org
X-Gm-Message-State: AFq9FYKh669anG/tT6W3975ZmtPHTI53aTejeKWLafO7ifEg+CoFUA0J
 oIpKyG7jyLLVc3b6tw+g+dxWE5TGu8t9X/VOKKv3ua3HILe+Ipo38vAg6TSFmQy8QRU=
X-Gm-Gg: AYBFou2wMVVkDZ/f+gKyluW5i6TWUr1DIT6aNMJ2q1S43e+4TYGEGkTFdwDLnWaamTN
 3Y9oev6W0bGZ1J/Y2hbX/iFTshdVAL5Z0gxij3gcJz7TMYVuR7YDUKdsnI/NOF4c8QU4469Gsk3
 QyI7W/DvSe26AUWhvETlyqkU8VbgtPXanRhB0bXRzF4TOp0Z0xnxUlkE6q/XiFOKLsqcmAcLXel
 DpF38H2p2dltxXaKoHx/tlbOIik/vky5zg6vsXUmCK3dQ1i36q1Ug7J4o3pvIlwYOaIeMslb5Eb
 eVh7HE29CBTSWlXFrr1urLCZA7t3PDn3lloii9P3umwgYhlMdUB/ho7pCmG8Jm6Hg+vveMBfBZE
 nEpC8QwnOYn3a3tJ082aQ628kmGI8MWa4I+hdQo6QW+Zlc038CrWuALGZ/aWQxzete9iLVKRfhr
 MPPGEXmzPIZrOlXqTgLIIwAtzV+V7xy97vtEs4ETe619SxpnLwohtstgdOSPvJOfX0GXYqUiIhm
 fgwOJqsO9opBO/wbS5Ug/SnJZfRtxVasUBpcbrWK8PNeANwIp9Y8aEy1EMX9jqWcT1kbw==
X-Received: by 2002:a05:600c:8286:b0:4a2:bef:ae5f with SMTP id
 5b1f17b1804b1-4a35ace0b88mr28280755e9.29.1792854808272; 
 Sat, 24 Oct 2026 08:13:28 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm59389845e9.0.2026.10.24.08.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 08:13:27 -0700 (PDT)
Message-ID: <9c61c194-6c13-42d3-88f4-0934f2f62935@linaro.org>
Date: Sat, 24 Oct 2026 17:13:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] tcg tests 20261024
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/24/26 09:10, Pierrick Bouvier wrote:
> The following changes since commit ab5b7ba3794a016663c7200a92045fcca3ed7f1e:
> 
>    Merge tag 'pull-loongarch-20261023' ofhttps://github.com/bibo-mao/qemu into staging (2026-10-23 11:45:20 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261024
> 
> for you to fetch changes up to 9963acf1930536e8f67a2ee4b2201e6187ded93b:
> 
>    tests/tcg: remove global meson variables (2026-10-24 07:09:47 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/3] tests/tcg/loongarch64: fix hang with softmmu-gdb-memory (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261022201733.1941651-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

