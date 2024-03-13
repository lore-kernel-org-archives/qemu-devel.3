Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516D1C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkN6b-0005Tg-Vt; Wed, 13 Mar 2024 07:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkN6Q-0005LV-7Y
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:49:03 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkN6J-0003Fc-3d
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:48:54 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d208be133bso77754981fa.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710330529; x=1710935329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1THYEQEsQJgwRa45jnQXidYz3+zTDduzx9e0SC0WCVg=;
 b=OWeSeRyH85yUXHSr38jHr5m3q0rC3a4/fRYbRAeRcx3zcywNEaqk5ZHQp40iiaF2S3
 I/x6mMD/39B2IqImR0Ys+MB9AxcgyylcUB2GexNXRCs62ycUD/WwJI354uYUyL+sIrJm
 KHthqTFMnitZHMZd413yw8r5R+6D5W/DiPzFstfaaywwr98XExmpsqcG+V2kdO2xdR0H
 WMa7qpq4nbHe90PZLiIPHpZFrOGuU7Xs7lu59dj12ZkmhEyLe1OqfvTKWZGzsNOE1e19
 q5NP59Jpvckd7PaKTQhyoqet5U/bCdWulSArH141upy3GgYdHMyiwFfLi1YuyHdrdhaq
 NEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710330529; x=1710935329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1THYEQEsQJgwRa45jnQXidYz3+zTDduzx9e0SC0WCVg=;
 b=vxfgb6fY3D1kFEPmEEZlBTBn5p/X5ZhOeZfss3+pIhgFRFUl4aLXNokiyMCjEQuQYN
 T3Sv9TYNXiLEM5ggTK2Bs4prVMpxSDStwYXMp5Hs8rxL7+6wn4NN4/AV4Vu3xSzAx1/K
 s7n4SG1SnmerPSTV6bhH7tz+LTitmMJCZoa6Dz4z3jejbuRvufPCGz2HxtEufLEu3/Uc
 nCPT79WzVcBrduFyW4YU29PfmfZ8tMkfUhhDYvKpA+MCZvm12W1Hq8/PIENj2VP2UUiP
 yQikZZEgISyOYxLEhI138cyC9QpRFDnXjNxvBbPg8+c+jwNi+cUCKVbNEKSwfzRNpj4M
 AdoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHUA04u99qvAj9veR3uV2w1vR/PsejwJPWFRrohrku0k5ueWwBne/vGxev2YZuZaz6SOnqBRxD1+5ao2BTR6GwaNTIdh8=
X-Gm-Message-State: AOJu0YyxnWatn4B1BOMR5M7NEphnIOZTZrxVdTfgBKHl1zdLfMFRDSyy
 NUpTt1OnQRUdBqLacHo+Kyk3PwVx6g3oMGFzZ7AHJ+RbN+n/uFAml+v0gkPHuo0=
X-Google-Smtp-Source: AGHT+IETAQFeNGipTMkxFWC7tCZlNWHj+dwFSt7GVZPsSejewn5UtSDpgD1VUYLFyBGUibMcwgkJ6Q==
X-Received: by 2002:a05:651c:124a:b0:2d4:6d3c:3989 with SMTP id
 h10-20020a05651c124a00b002d46d3c3989mr733296ljh.36.1710330529213; 
 Wed, 13 Mar 2024 04:48:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 bo3-20020a056000068300b0033e9d0b3faasm6385589wrb.82.2024.03.13.04.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:48:48 -0700 (PDT)
Message-ID: <e6e12dba-04df-4964-81d0-34890906f647@linaro.org>
Date: Wed, 13 Mar 2024 12:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/avocado: update sbsa-ref firmware
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
 <20240313-sbsa-ref-firmware-update-v1-1-e166703c5424@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313-sbsa-ref-firmware-update-v1-1-e166703c5424@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 13/3/24 11:08, Marcin Juszkiewicz wrote:
> We now have CI job to build those and publish in space with
> readable urls.
> 
> Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).
> 
> Used versions:
> 
> - Trusted Firmware v2.10.2
> - Tianocore EDK2 stable202402
> - Tianocore EDK2 Platforms code commit 085c2fb
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 40 +++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 19 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


