Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D800C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 00:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUbot-0005FL-1C; Thu, 18 Jul 2024 20:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sUbom-0005EM-AY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:49:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sUbok-0003Tp-IC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:49:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc692abba4so9078855ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721350189; x=1721954989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aF1wN2SQQiM0P+MKMdLR5FdYtXgILbBxG/AxWnL/y5E=;
 b=cqeEnqGLmT4gWY4WHLPH5GzERkDlvE3UoAIh/K8zZq51RpMlRVKyWwffs2Ea4oAuyX
 QMli/QF9PuXBpKC0DSJjCWCEWB2XJk61HqsF7GGxwEGpynRtbd3EBXHTvY4bOU2APvrg
 kiLIPoRf2tjDnFf3nmKR5nIUsx6aKOaOtaCp8KNf/+KEVq5kB5+Vl+MQl4Hy2eqxk9Zw
 wzUk1ei/fOV1n+nZ/pXcix3bN3AgJu32wIhyoPTdOEKnxDOIrZnXcP3epOVyypVyyQji
 O0A+UWdTMsHq5Gk7PduQQV3xnq6eQk6Bp9f60rVy66UskeeiV3DOcXWVSSgihXpUi1rf
 DbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721350189; x=1721954989;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aF1wN2SQQiM0P+MKMdLR5FdYtXgILbBxG/AxWnL/y5E=;
 b=FYCv0oJZugWF8SoscI5cBwlBeJkkuTOWcjTl9VP8S6cvkHJf44cpRN2SAvZDIq6T8f
 19pU33TFLVVAj8DvQOy9YvNzeQ29N7lKtMw2vb6thXgmJ/IdIw6c9/0W8Ek3Lmb6g57b
 lbzRTK4CN9WKm2UltPAv3FuhYYVN5dUz0c5UUQI7e33Cf9/hluBpBwc9tVzwpelN4jKv
 z2ckD32MmPEVlc0z9a3P7Rm5Agw1mV6I7w2U7KbANyzIotOnTTRGn2GEy+7y3ec1UqLo
 OrnKL0Ntf1yRCPmUk7EXopxlpHP6V7r3VScxQXF+yRWxYL7QvO0Oh1bbrvJYxyxuNVvy
 v4Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdwZZ5OBFA/uNc2Dg5lyVAkACEkLbiLhgbD5HB7z+FtANuYTTcooo9GAvFLmZXcbMx2NwIH54U4pv1H4h2tRiGd6Wm00g=
X-Gm-Message-State: AOJu0YxsGhtUzpXmf3RxIenHrtO9i/aSPAZ/6a1EaXp17kpA7ykQp9gb
 grzev3IcUKXztz2ZH6o0gZSz1KWsrZaqQr9+goo8+Xdvj9N5GZBe7vZpHH3xivjmQ9WjT7AWliJ
 URZw=
X-Google-Smtp-Source: AGHT+IHkgyFJJTtUwxIMnfD3RoXb3Oi0PCZmNQTRT8z8BBzrfidQUMnHNYe4xI4u49uUd8RtuCJUDA==
X-Received: by 2002:a17:903:11c4:b0:1fb:2e9a:bef9 with SMTP id
 d9443c01a7336-1fc4e148a9amr57016745ad.16.1721350188808; 
 Thu, 18 Jul 2024 17:49:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6662043bsm655955ad.25.2024.07.18.17.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 17:49:48 -0700 (PDT)
Message-ID: <6662bae1-be55-45c4-8dcd-366e3d7aa1bc@linaro.org>
Date: Thu, 18 Jul 2024 17:49:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/aarch64: Fix test-mte.py
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org, alex.bennee@linaro.org
References: <20240719004143.1319260-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240719004143.1319260-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/18/24 17:41, Richard Henderson wrote:
> Python 3.12 warns:
> 
>    TEST    gdbstub MTE support on aarch64
> /home/rth/qemu/src/tests/tcg/aarch64/gdbstub/test-mte.py:21: SyntaxWarning: invalid escape sequence '\('
>    PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
> 
> Double up the \ to pass one through to the pattern.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/aarch64/gdbstub/test-mte.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
> index 2db0663c1a..66f9c25f8a 100644
> --- a/tests/tcg/aarch64/gdbstub/test-mte.py
> +++ b/tests/tcg/aarch64/gdbstub/test-mte.py
> @@ -18,7 +18,7 @@
>   from test_gdbstub import main, report
>   
>   
> -PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
> +PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
>   PATTERN_1 = ".*(0x[0-9a-f]+)"
>   
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

