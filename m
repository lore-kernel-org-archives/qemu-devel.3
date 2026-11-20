Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4B606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ID0ugXL6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCVH-0004pq-SZ; Thu, 19 Nov 2026 19:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUCVF-0004oh-U7
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 19:29:21 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUCVE-0002IR-Bx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 19:29:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ee1b65fdbcso997405ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795134557; x=1795739357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t4DdAHkJxdxtMwakgxPnWUx7rvYSVr65l/50cDRuA34=;
 b=ID0ugXL6VwPQxnGUA+A+nsD/MESywMz15XCku/DtKv+faKY6knMPryNhl/gSThRhjW
 WhBQS1/wpfL5yMUyBQs+39uIolsifW5tJe0KzaCqrIADHSyq8Qa63G3Jqsrv3gqbHc5A
 10mim+ZfRJnHNusCE/6HxBw+Dr+6UGqriq3F2mnShU7Vc2oIKEq/KUU7eTctJorLiY4s
 1d8RKXe0omSNsP/9WtQ4s9wJqoCki9WQTi/FjdQp4TYEVE34yjnIwz6uxAiXEXJGudwo
 D97mVIVQ3IioAC5m0WmA5Lo9L490XAigIuUjDM2k4Qg/2tAUfhuum/qCK0XljQSPFFQA
 VQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795134557; x=1795739357;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t4DdAHkJxdxtMwakgxPnWUx7rvYSVr65l/50cDRuA34=;
 b=p4JXlrIIYOwb6bEa9raFmr+9qgEDzV9qnEtdSnpTNR/XwCmDcaak6P3MfCCb19+unA
 Gka1pAOU8yEHcj554EfGVLQtWInYzccqDE7TRPFogZ+TilZ6j47C5PfgTTD7adcamHlf
 fOhbmQ6j5AExGRjVtrCnE4XFNSmb2Hxy7e2bJdfKbIShcK0FIu+pfWZONWnW3xYOuBlw
 Q816PQe3W7lJ0TFIdtk39Ita/XBnIU4HS71uOfKsgDS+Rdhu64m2mJzufLRhvYX+ZP/O
 gkMTyIbOyTotxES2GsFPoEOJLPG4XV+xBog5COfK1EEHHv4p+VzfiAuyq3Z/9cWwLbN9
 ABhg==
X-Forwarded-Encrypted: i=1;
 AL+hErFWXlPjINoDlYPGld//zeiosdOv7hoe4ARu2yLz5UVMsnWTnwrT89hGuUmBvr+mkl5XalssnfpQ6IIn@nongnu.org
X-Gm-Message-State: APuU4Z/jQiTdpfP0CtjYOMeHGqxFM9FmllDzajz9ywVJlojmDuag/EA9
 edeRM4RWrZ4fOowpkniH4ip4oVq/6JeCb4453MCZKH8AmmaBglARPjjTVscx/0OT9skYNs6Fqsz
 6Ov5f
X-Gm-Gg: AZFdTZfHAeWQpGm/K4oumz++x0KnabDyYd2yoHXZn1jyBZ6nbnvmoxLYgHm3/XzKO9j
 N24sRcoGh/w1XjccNjjjM69DFdni+hcJhFBAkfciGe+KfPSXLBPg1DoAW/ANPWVMPaev3hPzGNQ
 WD+29Xvd2ssHtFKCxOjRNOb7OnPdHsyRw/B4WgyzwJbqIus1bXd6+5jKJyOFHI66Ap5eW7+36eF
 u9KdT4lwtJGSG/tMSYVYooahdx1X7RYNrvS0NPRdw2ixKzxoxHBymzHw07/K4TXGNeF+C70zrlJ
 QQseRxzR+KdCFQ2dWYoOKe9O36LbK4j000o915YaB5dWOhsRw9rSND1nAWZSlKZ0N3x5hbudjfO
 m1kJMHl7dwBG+txHuVN0vO6DtH56WspNbMBBce1KrZjreN38uPLm8Q/p9/O93uH4lnduxn95t3E
 8AurDWH0+ClRCuF3av3WVbRqjnjI2j2ZpDvkO619BPY7tpkI852FEYM2o4ya8sGHs7C8haq/m81
 M0FriHA1prSVySeKgYN10JV4lMuOqlRK3pxQ4MJ3aGgLS5wu4Nh8YNJEj270BxVEwanfiS7q5j7
 FUy5640eSLW60Fv8C/WqYSlEnR3wQL/HxGpI2cKtY8JJJQgLmyCYo+FHeKocFYmoyEE7EnA=
X-Received: by 2002:a17:902:ce8e:b0:2e9:9c65:1af3 with SMTP id
 d9443c01a7336-2f03f1eec10mr14229645ad.54.1795134556915; 
 Thu, 19 Nov 2026 16:29:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f102fc4sm6077325ad.43.2026.11.19.16.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 16:29:16 -0800 (PST)
Message-ID: <fd9f998a-ecc1-40f8-9910-eb5e8ce62038@linaro.org>
Date: Thu, 19 Nov 2026 16:29:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/i386: compile test-i386-blendv.c with -msse4.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261119130738.269817-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119130738.269817-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 05:07, Paolo Bonzini wrote:
> Otherwise, the test case fails to build for a 32-bit target.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/tcg/i386/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
> index d2ba8410413..02ac2bbd6cd 100644
> --- a/tests/tcg/i386/meson.build
> +++ b/tests/tcg/i386/meson.build
> @@ -10,7 +10,7 @@ tests += {
>     },
>     'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
>     'test-i386-adcox.c': {'cflags': ['-O2']},
> -  'test-i386-blendv.c': {},
> +  'test-i386-blendv.c': {'cflags': ['-msse4.1']},
>     'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
>     'test-i386-f2xm1.c': {},
>     'test-i386-fbstp.c': {},

Applied directly to master.


r~

