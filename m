Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9494CC30658
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 01:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNjPr-0000RD-LO; Sat, 29 Jun 2024 21:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNjPp-0000Qx-Un
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 21:31:41 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNjPo-0001pK-EU
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 21:31:41 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d5666a4860so1099919b6e.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 18:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719711098; x=1720315898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/FJ5ic18X4jH12Ty/kRAASNDEzHSfIj9u6pJ+OmNqAo=;
 b=Mz5rGqyMXABJ/vGhPKi3Gqg9vgz7OzkMIPKlfqtcbGmyEVybJwtRCq1CKFk4hGh4ya
 R3jBeAcPVNV8GcGfl5ic2Bl9Io+izsp6llXPsGfGBBIpkyxBLF+WTwcuyRSeaI85HzFY
 GWEtKk11aOjSD3s9sY4AyAQjM1yqpuLQmjs8+cIRRGB+tfjQ2Jiw5T2K3Xb2jiY+HiLP
 otMXCMsSiQ7OSN2DN6AH7cNSFJA02EX1WY+D4GTdPnM6uRWqns7NlCYWo/Xet9U3bTC0
 9wYl6YjDhLCnjbwl/Mf3BH3xeKh3GJekhHHZCRXSu1fzDxRpmtYTXFcfAO2MUg97ycix
 8BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719711098; x=1720315898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/FJ5ic18X4jH12Ty/kRAASNDEzHSfIj9u6pJ+OmNqAo=;
 b=hDSEb7n/AWS6H3AIzyrV1O2+sgMK3ne7V1AAY+DAWKcqZQdv1DG5zDIFERdeZ1fgGE
 NOua821dmOobmcr2MfYetiAVUcAxscTtiih4npElVn7jU0SAyWKih0xgWdgCt0CsoZ1m
 xSYqV6VpkilgYRjmiD7nXYkWMa7EO+d9kZlrXyh9HbqNYdHkP81DUtNAnu5O1NYrJQ/v
 FZ5nIxqXjDMCr+dmBW6dCmfMYJhi9Aw0sKIMp3IRdMjdl7+fDuxYNP5HG78LIkBVe5Mr
 xbrzXXn8anJS8AeVVVDMfYzbAc00ESF08sUqYOVfAFCnG10+rJmpzPgJ6mrYHCZy0Wlx
 nhog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8XZ/Iv9ToMviBYlSaN3AvtOnaIQJ9/Ic1kZekr4jeX4Bf9wZM5C81OZBQKdWw8ppbvWJLosKQGRyG1AWRkfJtChaAmb8=
X-Gm-Message-State: AOJu0YzVg2JrhCBrWJv7/LJSf2Qp9GK+CNlBBsVSnc4ag6wF0fjdH5tX
 PTFTdWARnUvo4KQI1cyndK6OcVsWdqPm1kNodekCVm299I4+Rj6EPRo1Zm8z5oM=
X-Google-Smtp-Source: AGHT+IHa3UjTRMWUwNN8urJ6kpLphgTn9XHDpBORQHfzsz1e2U1669b9EIubUSNR0spT9n1O7iROkw==
X-Received: by 2002:a05:6808:38c3:b0:3d6:2d2f:d03b with SMTP id
 5614622812f47-3d6b2b24ee5mr3156853b6e.10.1719711098295; 
 Sat, 29 Jun 2024 18:31:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1568da9sm38063385ad.203.2024.06.29.18.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 18:31:37 -0700 (PDT)
Message-ID: <2712726e-ecc4-4a88-8675-7706c9be4d67@linaro.org>
Date: Sat, 29 Jun 2024 18:31:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tests/tcg: add mechanism to run specific tests
 with plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240626233757.375083-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 6/26/24 16:37, Pierrick Bouvier wrote:
> Only multiarch tests are run with plugins, and we want to be able to run
> per-arch test with plugins too.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   tests/tcg/Makefile.target | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

