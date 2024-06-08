Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D93C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 14:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFxLj-0001Iq-7l; Sat, 08 Jun 2024 10:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFxLh-0001IN-SQ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 10:47:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFxLa-0003ua-TO
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 10:47:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7041082a80aso1244948b3a.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717858027; x=1718462827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKgnE6pUd2RbTzCFCtdaEnBSgtu7MSpifK0gR92br8k=;
 b=NnTzqzpzWGoEhiuDnqPC+P47B0gIWarKKCSCWHwRPnPEzVbpiN/wuIG2RPAoTxs4nF
 ybzAywS93WYDkxVcRj/89jr1n2zdfc5jF1LLmWlj1Lt5vV0Z6tZmoiuZ+7NjeUQU6AjN
 LJK7rY50oDcIfCL3DeI9wcmyCWpJcOUkWIAc+oy6iK3ZJDKF5VB9XBWu5M1dJsMRgHGQ
 YHEEl+ySt4TkNPpToNaHYW+1YJr0LlKR/YKvzXPn/AQ9czbKmhK8gmBsgoz07/+MeEsy
 Vk6obhmfn5Pk/PjdfxatO8S3YGe4OB6krK4KPMEvHdhDbJm/f5EkBxX7Yj1se4AS8Vtd
 NUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717858027; x=1718462827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKgnE6pUd2RbTzCFCtdaEnBSgtu7MSpifK0gR92br8k=;
 b=EEOl2GKDojUSiwwvI9KvF7MLMKX29eO4xxPPdpNmNVdDHy7gAx7x268m6g1P7ar7vZ
 fmcklRsyDOtv7V6GyLch7DKnqLOKezHse0JeMGgoLuFUcAg6O1Pjl5fbKg4QDrKpOSCH
 HhiKiFxBgS6JVpBA9qgsqn9CRmgDtX3OZM5ng5JoYOgYNosx3vg7f3KlXyU2j8lm1qPE
 Tt31uUYggEL+mIkwOPTVzJPN1D+MoqCXXsRpP1zzKe1zDvcWDeM2xvDPjaSwj9vi6asd
 ex7wtoTVuUfGPkiRINoS/aHj5obE7YmVupXUlNHmI7LUSNYILhGLBPo28WZNhf86sBHX
 DVIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCZ+BTStUcfap8Ivi1CzuCGWJ8QzFkEo01pKcatigbNUlbtWk+c4VirM9YoS/T/w0tFsgKJ3Yc0VPau2RoEmaFzeA30ZY=
X-Gm-Message-State: AOJu0Yxt8Gs21aw9ZqpK8CB9tFfuroCbSOFKv5GuiLbdXIo1gn8Evw/e
 PlTlc//Db/fY7m1CisibdzWJIhK3n+Kn5wHPYzJyPOeblmE+Pf7FnohEqaO7/Qc=
X-Google-Smtp-Source: AGHT+IFI0Vep3fCz3DLExuR/Bs6xM2tMBrEixMsi5dLhrZx25GNDLbpF/peJ/crzn6DJ40pMRjGtpw==
X-Received: by 2002:a05:6a21:788b:b0:1b2:b297:9c1b with SMTP id
 adf61e73a8af0-1b2f9cb112amr6021151637.44.1717858027189; 
 Sat, 08 Jun 2024 07:47:07 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-704115884fbsm2608354b3a.111.2024.06.08.07.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 07:47:06 -0700 (PDT)
Message-ID: <82378664-81ee-4100-a18b-88385727555a@linaro.org>
Date: Sat, 8 Jun 2024 07:47:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] target/i386: remove CPUX86State argument from
 generator functions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> CPUX86State argument would only be used to fetch bytes, but that has to be
> done before the generator function is called.  So remove it, and all
> temptation together with it.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |   2 +-
>   target/i386/tcg/decode-new.c.inc |   4 +-
>   target/i386/tcg/emit.c.inc       | 572 +++++++++++++++----------------
>   3 files changed, 289 insertions(+), 289 deletions(-)

Yay!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

