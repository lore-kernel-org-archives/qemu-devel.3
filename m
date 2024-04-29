Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B0BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Kei-0000QG-9k; Mon, 29 Apr 2024 02:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s1KeF-0000LH-CJ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:38:01 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s1KeD-0005DG-O2
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:37:59 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a58e2740cd7so277944566b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714372676; x=1714977476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lPwlxisEEnTSu0dtTI2st04WfNqgTEIAOXEfmhJ0n50=;
 b=rGnuE3N46bfaFxdfacMvfwLOS+Gf5qA4kG7ZRgqQekZttvBhC/2UHWBCAhTatpizPw
 LbbUxpECpa4WTVPSJ6uD+D6GOB9GWWFTGKsRadXg36FDpcbSVfYTncrMhsLlDc52uPL2
 3b9q6axUvxfUcOdhyGG1JPGet0HRlebcMjRW+uxAjqKQQ04A468DFnubaf3n9Jxe+cip
 5bQSWYX0ihlGmA0uZ9RFTM/FzlsTjNNlSKeW5f4/6ThhzjPlk7LXQXq+Fk5upaubMxR6
 PcxVmXPyTF0v4bQShGhpVCSywRWfRCCrXTsKfp/o87BROzfXSGLP/+qkGE03/lT5qzlf
 OfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714372676; x=1714977476;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPwlxisEEnTSu0dtTI2st04WfNqgTEIAOXEfmhJ0n50=;
 b=CZE7BSt4WOGga8RYYDo8pBxcixFo3mv+lQYR6zMI0lPwmjBjnnhyl3bTBjTKVf29M2
 6hvYURqXM5AVucu+TmKejCzTPQPX41wmZhB25m1J51Z+TS1tLZz6qo+NRqBZzXzoERqv
 BTDx5B3GJ3jtIf6xkL1z2aEonrbOM2QXkEXr54oNq8SP0ReR4SdeEg0zLbBzgJt58hR5
 l0amRE9pm+SNiMrh/REVKBGvp42e3ybrIDk3xO4bQ4tf2vz8lBKEs6xNzsEeMkljo2+D
 7kpAREOGgD2iK+apd7BP4pv5In7PAlwXhiceAUzNYjQdbuxihs8nue/o3RCBLPziGvbL
 YuaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz5MiAGZADJ/IpvUtIfbKf4kuLViD3hCHJX4nOdHENAZVg0E2b977xVJyZpcf7YefeikVe+ERblbDugoMy4r6kLIrP8qc=
X-Gm-Message-State: AOJu0YzBlRrokAshxaT3D+of1fJzEIBcvC1Uj94FQClWlH6FRkxPl2NN
 XCayBMj3ZKDtLkC0zdUpZ3Uoo18UZv19glnPsTNb5X20pJjziuv0jCsfsH9W0Po=
X-Google-Smtp-Source: AGHT+IEDuftUnuNCS+S3jagKAm/EMUhdpzoiF0MpYjpLBnjuvO1UBQswjbYmGGBKohR4q40kr5e2KA==
X-Received: by 2002:a17:906:a216:b0:a58:bf24:edc7 with SMTP id
 r22-20020a170906a21600b00a58bf24edc7mr8291517ejy.20.1714372676054; 
 Sun, 28 Apr 2024 23:37:56 -0700 (PDT)
Received: from [192.168.200.106] (83.11.4.140.ipv4.supernova.orange.pl.
 [83.11.4.140]) by smtp.gmail.com with ESMTPSA id
 ju24-20020a170906e91800b00a58df602ed1sm2833272ejb.57.2024.04.28.23.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 23:37:55 -0700 (PDT)
Message-ID: <f1fbc8a3-3a01-4cd3-847e-9912cac0b2d3@linaro.org>
Date: Mon, 29 Apr 2024 08:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/arm/sbsa-ref: Force CPU generic timer to 62.5MHz
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
 <20240426122913.3427983-3-peter.maydell@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20240426122913.3427983-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62d.google.com
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

W dniu 26.04.2024 o 14:29, Peter Maydell pisze:
> The default frequency used by the 'max' CPU is about to change, so
> make the sbsa-ref board force the CPU frequency to the value which
> the firmware expects.
> 
> Newer versions of TF-A will read the frequency from the CPU's
> CNTFRQ_EL0 register:
>   https://github.com/ARM-software/arm-trusted-firmware/commit/4c77fac98dac0bebc63798aae9101ac865b87148
> so in the longer term we could make this board use the 1GHz
> frequency. We will need to make sure we update the binaries used
> by our avocado test
>   Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
> before we can do that.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I leave it up to the sbsa-ref maintainers exactly when they
> want to shift to 1GHz (probably after a TF-A release with the fix?)

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

TF-A 2.11 will be released in June. It will have several other 
improvements so I prefer to wait for it.

We will have EDK2 202405 stable release then too which allow us to 
collect all changes we did during last half year (and maybe even those 
in progress).

In meantime we go with 62.5 MHz frequency as it was before so no one 
will get "too fast wall clock" issue. Then, in a middle of June, new 
firmware will be built for QEMU CI and we will be able to move to 1 GHz 
by default and maybe add some other changes on top.

