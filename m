Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27E7E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvsu-0006WE-Ve; Mon, 02 Feb 2026 10:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmvst-0006Uv-35
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:30:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmvsr-0004Da-6v
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:30:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so34715475e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770046235; x=1770651035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MZ51eWSEUzqtNu7Iazuf6KdAkqd+YZGG0v1m/OVg1Ns=;
 b=XmTMIlE16ub566mgX6VBWyyOgarx8lfve6x2oQ92RHeMjHCt8zkaQa0gcOcWCr+DdM
 H7nkiSEeQ4gHgZ70n9vbV9HdLGmgNERxQ0Hs6HI3IIDm66YwHUoZs1u7heFD8PsrqFxE
 bIuoHNyKRyO0uzT+MKIiI2ErAFpdteT0iL3Tt4EnKxhpwZ6CdCW4fyNAN1GfmYunDWp8
 wju+fpXX+5NtAzXBze63Kz4OMNKgQORx54xgkh35qik6GjD1GwFFl7XiIPaQl9dRM1VZ
 WCfktKMqtFyklXlOD/Jt2Un/nytDwADQD3+BGC2qu9iX6/t/wGSNIEnP4Iehx6DRHj/f
 SnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770046235; x=1770651035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MZ51eWSEUzqtNu7Iazuf6KdAkqd+YZGG0v1m/OVg1Ns=;
 b=E+sRE0+f8+2OAMrqHSi1vu/1qSt3OROa2zlDbNTct54CKF9JWJDU+qXGoiMjO8y7PN
 3Mb6Drz5mNE0YcQN8mjcC4YUHZGqgefXUZJm5+mWeLfp0kJ42Tq0oAjI6PeJhQjxkMHq
 kHrnly95KfcuGQnACckW8/EJzOfOMl2Hrv6Tnxtx4p3qKmGaqxWvqxGGmjYeJHvJv/7g
 4FGklO7hfIPQMf2a273gz5IR79WWpO9PQM/wv8pB9bP7SiP1W9r5FNbPJc2ioqduhxIm
 nsM47VvCnpi4m/0Z2uCsFIT1TDf2UEB7KayCarJrdmJA/rRnMAAjaG63kFo08iLXMmRl
 QSSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYmDDIaTc1n8LHLf/G0OD4cV2BfgP14udOGmFF+gx2FBVLNE5eckxsXEXCuktH2e2OykMCbtFx+rDy@nongnu.org
X-Gm-Message-State: AOJu0Yzt7VBUW/Zjse4KD6AsYdNoyN34gYIQEyxpSQEc/vxHrXJvszCe
 6+HFQDGlwyxkKzm/yzURrwnwom35CCAxFoGLMMYgKQ+sChcdxaEQyOV4cPbrLlUZ91s=
X-Gm-Gg: AZuq6aKzaiCyWc48pMfbDRjvcs2QjF2F60pT4KRXY/NNd0v5IegHGeR/RgyF+Azuy/o
 snRqktx3ilM186Tz2RGH42Pe2fMu9qBMKMkQIhq81AWBXGY6+idICGzk8XedmfSCdXFjH/S00Lq
 7l5VpvZIi6bMWTO/tBDQzxJlzvXzB5UYbrVGImd8h96Bc2iUYDR1PHFjNoIOqEifVXwfpOoENVk
 TZj51YhoRwuqTIIlJfIcDVg7nvQQLnfN+qzcb6pL4GmlQL2C1DMNpvt73lsbgMY5P6zanjRPO2Z
 N+rWA882E/Xf33Q9dxrE5FnQILCOHS7kNxsRLVW9rf2e+pHHCkL74zp7fpmdLmHbJLqSjE7G6hu
 Oor9OidTbg0zVpj5I6Ndox3jQS4Vw04hnMiMfFbCUjFCQt2M48Ur3YasbxdzQLEx97N7obkvUPV
 KgmDBbQ+BxXt+XEPNgSYTzuI5H8s8mFZCtGE+soCM3q/Sfh4yKhQ27bg==
X-Received: by 2002:a05:600c:8210:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-482db44795bmr173087155e9.6.1770046235262; 
 Mon, 02 Feb 2026 07:30:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdeafffsm378277075e9.7.2026.02.02.07.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 07:30:34 -0800 (PST)
Message-ID: <fc2fa936-389f-4326-b001-21b22444388b@linaro.org>
Date: Mon, 2 Feb 2026 16:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] memory: Add internal memory_region_set_ops helper
 function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1770042013.git.balaton@eik.bme.hu>
 <25045c95c083e31c6773521ecfe41900738b7bb5.1770042013.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <25045c95c083e31c6773521ecfe41900738b7bb5.1770042013.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/2/26 15:28, BALATON Zoltan wrote:
> This is a common operation used at multiple places, add a helper
> function for it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   system/memory.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

