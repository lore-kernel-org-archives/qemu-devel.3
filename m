Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C36C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPa7-0004SB-5K; Mon, 29 Jul 2024 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPa0-0004OF-VZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:34:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPZu-0001g5-I1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:34:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso13574755e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722256452; x=1722861252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dieWDFVHhJnXyo0hU8RGxaVkbAnONx0LG2GbC4RBanU=;
 b=EcIZkHXzRYW5WX3y1WsacOLBnb7X+W9KwwzRDCH6b59TzUwz2daLDL/FyoB7K1Ku6G
 UrS3i5TchxiO3bBlsumHFbo9hhpAlYrVAQL224fzVR/n09SJSatXbPkw7cBfaZm0Y5wi
 rUEv1ONIQnVMA5Ye2IqZRbGaAPwf/+efdiAEiCxxtZREXxa3L1mT5BtvSZonIhJMPN+0
 MVeGv08qatuODmKpDL3FpCX6pINHrtYqrwFmGQTtqwJhy/uzR8D60Bly0DKs1igibcaL
 29Q/I6Tnq3T7T/Q+BeHd4uS0PK7vcI7ggxTE1zxJxS3u+UX8AfRn8U1/LChROpiCqn8V
 cvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256452; x=1722861252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dieWDFVHhJnXyo0hU8RGxaVkbAnONx0LG2GbC4RBanU=;
 b=SX+jYuBt6pyNa5cbv/YSnNx1mc0YelNDh5LVqTQ4z1X0AnzNBDe/e3RoA5cWFYj4l9
 01lx+ngLQPS3gH2dTDB3dFJb4h7Nu5uSh8veABpqyJf/a8oWILUXzUjSyCxOYCZDNxn0
 /VDpawyTypcFOPM44ykE2niKnvSQQ8gw/VpUnHkaK7y0bhNcW1vld/w4QlMRS2sBSPJN
 Pk+FP/tMrqcFYaRmghPmgxd6iExCU/0bEyczRfctn/GYLxz6Tqjo8JLUNF4RPOKFt+2x
 DJXMBXfnVjj7bteDxi4z6AXu3WHssZvAJeO9XjXA95x9sPaNFgNCuvNmouLQodVr8LxX
 QLFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFa2XAouZatxYxDGwXpXSQtgTdLZeCgEyEh38hu/VxwWy5ILWV+7ssb3dBAyu6QG73rehqm3yXAMEHDZBXJXCvFWuFJ/U=
X-Gm-Message-State: AOJu0Yzs4AX54KIORz7n2TeCoaqNdAWUC+wLPDnbZNCeq+xMknibQgSu
 S794+uypNVwMpvzfIMVB+NNPle2tJ7Mb49kQR8A44Y9Olu/6loctyRGXnRqmChL/vYF/+IsU0L/
 C
X-Google-Smtp-Source: AGHT+IGqUSIiokqCtHA7YcCBEHaRmZwxu7CxfvGJW2a6KIfDM+wzBPT62h1k6EpDuxRqNEwlEjVOew==
X-Received: by 2002:a05:600c:1f96:b0:426:6171:6083 with SMTP id
 5b1f17b1804b1-42811d89a97mr49748225e9.13.1722256451950; 
 Mon, 29 Jul 2024 05:34:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280d37bad3sm120744895e9.13.2024.07.29.05.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:34:11 -0700 (PDT)
Message-ID: <3ee3e407-2e5f-44c7-aff4-73bd00eaf189@linaro.org>
Date: Mon, 29 Jul 2024 14:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] python: Install pycotap in our venv if necessary
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 24/7/24 19:52, Thomas Huth wrote:
> The upcoming functional tests will require pycotap for providing
> TAP output from the python-based tests. Since we want to be able
> to run some of the tests offline by default, too, let's install
> it along with meson in our venv if necessary (it's size is only
> 5 kB, so adding the wheel here should not really be a problem).
> 
> The wheel file has been obtained with:
> 
>   pip download --only-binary :all: --dest . --no-cache pycotap
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   python/wheels/pycotap-1.3.1-py3-none-any.whl | Bin 0 -> 5119 bytes
>   pythondeps.toml                              |   1 +
>   2 files changed, 1 insertion(+)
>   create mode 100644 python/wheels/pycotap-1.3.1-py3-none-any.whl

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


