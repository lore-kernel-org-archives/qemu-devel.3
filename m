Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DD5C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvCk-0008Vn-QR; Thu, 08 May 2025 02:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvCi-0008VW-Mt
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:58:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvCh-00050w-2Z
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:58:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso839591b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746687478; x=1747292278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qERxfFuFGFX5ObyvGEeAKyUi7pc6aRH67bM0+w+bSd4=;
 b=pKUP9Ja30dWV5eAz3f0wbPiayGPyZFpA4xRRbGPXwhXturxyjc425rL8JA+KQ+YbTz
 NgiAJIHqDCYNnqqGdcJ8uvMkeYhM9ORnKtiKnlSG4ApGl4FjSQ75aBosq4CbW9jBCQxo
 D+KxtcA7U95swZWSBGf+qV+cttjADPAF8EfkPMUcEdd5nUaGzIAup70Kd0Is6jlSBa+x
 o2YYoB7T8zAa4GVjlg3Hu7rIf+i0fnCB/yhLCBkWHSwmbddqI10pi+OKjro33v4OOYkK
 vVELuQeiqYUMaABI4uOhU5xSVcJPT9ENpVdwF5FNtJqYTPSyLa3KCYjnaiANDyY/p5f9
 PVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746687478; x=1747292278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qERxfFuFGFX5ObyvGEeAKyUi7pc6aRH67bM0+w+bSd4=;
 b=kwZhzUD1YmIV4W5bTTV4rsM2Gz3fYjKoBH78F/FubUnfkO0/Er1Y+Tx8pmdZB4kD+q
 kXVcAUq1V6ke7Hpehl0mXKAad1d54sBmUGtTcFi6j4zBp85ctf4IALNoEUVtcZ7ZJqrW
 VEex0DoGZHRfajY/vwMzDp5nUtmSBCPWnWrlAb6T1wjCjfXZuJJ67jSXyC+sUwuJVxK8
 6wh4gkc7PQuNjD5p8DEgQCNry0fk1GRhWgbUQrScSKleLAlxLTX/KVDkSiqsQtjq2Cct
 TJEo95l/G+E+5/RYLQ5qrwnumYrMnSn95KcKO55InfEdAZh5eljRs9Piol1GyR9aczaP
 vlRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwZjAbCRIwBseraRqxPF3fdjVGu+iAXkSixgDICs3biF65gPM19PNbkSXenkRh/oBirhHlNF1K0tSg@nongnu.org
X-Gm-Message-State: AOJu0YzHiR5IhGXQRhArOetzbr0xqRXG0Mq8jAm+WLlt6HL5cX/frunu
 q3KODi1IQ3o3Ff1DWvGJNALdMTMu4ZFYr8wgX6eUwb7AQ/TdZWD/2HZG4NouFkE=
X-Gm-Gg: ASbGnctf7A+H0BDENxw1RuyWKtYD1oCwdMA4EI58KHfCojYArrGPV8NZKC4Kmoo1Vki
 Ac1Hu5jhNw92yHKJmoHTFiHe0KuzShYpnnaFMlMphy81ex3XzRLFlXziYCbeMMYxWMig6v00gH7
 IFyHAwurYBjjmK9KYLWCXDGUNMWphjrI4zm30/kGXfD+hm1I7HBIC7009OSsPwhDREuJVcZcSgd
 9PI9lijqMztnQsaBTmyhIKejZ5t+ytrzDQZM2w/qAs95Pn7ttQKA1Pv/JSi3PvKJUw2N5dThFOP
 I2PA/BEqvJ8Hw37X0PQGjQd+W4K7eO/ZVJvAboA0fe/ieDZgtDlU8jStAC7Z6CJ42RBDZNR1fZV
 8ZEriZSMi
X-Google-Smtp-Source: AGHT+IE7J9nvwMypNgQkxLgM4YtDVsszRb3Hba1Nx/jcX+bWtghsMHaBrnIrK7wFhBFjnd8ccGIA7A==
X-Received: by 2002:a05:6a21:918c:b0:1fd:f4df:9a89 with SMTP id
 adf61e73a8af0-2148c21e4ffmr9154543637.25.1746687477825; 
 Wed, 07 May 2025 23:57:57 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-741319e70cfsm64652b3a.174.2025.05.07.23.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:57:56 -0700 (PDT)
Message-ID: <b186f7cc-985a-4676-beb9-01bacd97df78@linaro.org>
Date: Thu, 8 May 2025 08:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] qapi: add access to qemu/target-info.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507231442.879619-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/5/25 01:14, Pierrick Bouvier wrote:
> Add a default include qemu/target-info.h in QAPI generated code. This
> allows runtime conditionals to use any function defined in this header.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   scripts/qapi/commands.py   | 2 ++
>   scripts/qapi/introspect.py | 1 +
>   scripts/qapi/visit.py      | 2 ++
>   3 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


