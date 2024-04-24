Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67BDC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlpq-0000Oz-BZ; Wed, 24 Apr 2024 19:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlpe-0000Nr-1b
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:15:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlpc-0006x7-1d
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:15:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so447034b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714000512; x=1714605312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpaiVEBlxxoYrCmqblEKTbgi1ilpb6EDQX934DCEWkM=;
 b=CWMST7g3lxYOdzVM18ggVLCwtjPNXTM0UKuHbfWX2QNUWdrhlpSv8gi90k42LsEGw+
 sSWpwXC/pWKzV95tmLPvtebMh5iUtesyCLuPQSBfxyrYD9Aqc158+6XPG3B0aPoB6ECC
 l3v7x7S6wBXliq60wKnf0bxO3Ft+M0szTMJsRyzgL8ad+fehY5o5JOsUXTpgx4CxegyO
 uJZ+2fHsE842ng2EjyXi8wE2tvkqF8AaVKKKs8K57n76+bY2tnFyzNkkT+R5F21+a5K0
 IA2KlKqXtYwIBUI6KXnhUiTZHZR7r0BDjQP2bJaxcqqxHl1bviXsVQkA0uQZNF49hVE1
 AnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714000512; x=1714605312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FpaiVEBlxxoYrCmqblEKTbgi1ilpb6EDQX934DCEWkM=;
 b=WX2N0w4YwrCvOKXbn2XCwKWCNtZWDipwEwkya1xP8yi0CpAFiB3NgE7WNpw13xXRjc
 NZhGr95462WRX/GIWvcISM13flCASZjIEkM4v42SUqznKWH3eah3CToFvUetGqnOVId6
 dJnHnbq9qcS//sJ9Ws6Y3HyE+YzCdxCrq3Hnkc/xdbmoaWHB88wSmnGhh0XWmBOU/QXF
 I/UxaPg/TlTxaBsiUMlQVk41udflrKlwHcDH/Oo/0hV0J0Y+NwN8ckWdMP0LVAZFtlil
 jyicMLlGBsoBJHHyrRVa0ThvunceBmtIAm3Wc+KSwSpVdiGZ6TDoQ5cF9a5b5ZLXSic6
 IgfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYNr/l8+pWtWzOdhbXiDQRxdfPHciYaiUgKp4LEpEvdbKySb+NbMmSkBlAaQDW63PhRuY5P49bvBtpqtY9cxK7Ms481Kw=
X-Gm-Message-State: AOJu0YzErDVfaCrU3G/imdDBjrRJv0cdDfugMVN1giaud64jBxKkbfAh
 n2FE6vHh9AXPUIzI9UqoRMNO9sCpufoO0YRpKoyjtCwjhRSZKGTNP61AN7zjG8g=
X-Google-Smtp-Source: AGHT+IEnD6esIykGtn9/sugE1GBKMUCGtOmAyiiEFojoUw/MNDZzKuFyvCc6FA2QR4jJ7Hjds5p69w==
X-Received: by 2002:a05:6a20:7f8f:b0:1a7:5425:3044 with SMTP id
 d15-20020a056a207f8f00b001a754253044mr5235697pzj.62.1714000512322; 
 Wed, 24 Apr 2024 16:15:12 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 ka4-20020a056a00938400b006f3aa6a03dbsm1439338pfb.127.2024.04.24.16.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 16:15:11 -0700 (PDT)
Message-ID: <9ce3f50f-2074-48ba-8827-3e5276cc88b4@linaro.org>
Date: Wed, 24 Apr 2024 16:15:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/arm: Update emulation.rst, add some easy
 features
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418152004.2106516-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/18/24 08:19, Peter Maydell wrote:
> Peter Maydell (5):
>    docs/system/arm/emulation.rst: Add missing implemented features
>    target/arm: Enable FEAT_CSV2_3 for -cpu max
>    target/arm: Enable FEAT_ETS2 for -cpu max
>    target/arm: Implement ID_AA64MMFR3_EL1
>    target/arm: Enable FEAT_Spec_FPACC for -cpu max

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

