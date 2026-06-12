Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3526CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3tu-0004L6-Dy; Fri, 12 Jun 2026 11:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY3ts-0004Kp-QB
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:34:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY3tr-0000lq-Bd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:34:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c27fc587ebso5158665ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781278465; x=1781883265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZWw8TEMLF3QPICZgT9USt0bkGDXQwwlisgBKsx0ydUI=;
 b=VYm99J3fsswBT3P05BFjv+mzqsCD6bUWdah8niltJSgB4/IsCfgTSawAWKtIvgPx75
 qtTlRtFnnvN9pjGC1YKGN4uSfxvWQ5GK7tlwgWw0yEbTKR9kvRwOZYN3x1S7zMN+eeyl
 ZYY1ZiH+/Dd09pvx6TTbJsGqrWjtR+Y5SODknIFxiGLw0kvPckoh77N0b5x1Ujs83ICa
 xl3xiU7Fqt33pXzZNYAIuv2hmlYjhsGx1OzzW1L040q3pKd1rWoeKjaqJjuJ34b6GPZI
 TjWHlcyZpXybPEdg8ULKvi/ReqZErV2QVjOQ3dJKu7MCc3JInGF2fr2JYPD0KSQeMAEN
 65fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781278465; x=1781883265;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWw8TEMLF3QPICZgT9USt0bkGDXQwwlisgBKsx0ydUI=;
 b=RsVgYEFfa3QSLZxK2dkfpAWmBpFfadX9A6fs7KxGnY85hMoNEZaFb0E7sfivFjwppW
 ocoGKTxUJHP6udq9YqIAWOSQ0F3xNJQaMTMM4oFsK7bdhdzaA8JpTdduK6N7IAgsPCKX
 /Zh146D0scMdbEbG8cjjQcU6RoxnX5HBtM4kf7qCPJbqIeGht9OcR7Htb4cPimS5HK0Z
 m8XoLMizB9nNAPg13KgyP7JkNwMWZRgHWmmD/P+ag69vBw8Of8lqTnJqm2HFgXOlnVmC
 OjIgsJcUtdHG2G6cZL58t2K6owsOS96uR48Jh06jH0U9QgcJjkvCRPw1kj08Wf5lkNvY
 WWTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hvggNxa7k53SFtrscBoO4bnWGj3rEpOzx5iiL9akT/BGkYLb4U2zmwifurMCK+64+TYl5XBZEGxkt@nongnu.org
X-Gm-Message-State: AOJu0YwqsDG8PrFiIM7puDU7iVfQnxpXCuqlI+MadmYnG5dFWQniwapp
 mhoabpekXWV0qagOjFhf5RknM8hXo+8GmDZGSU1x/WRPw4oH0CDGEwgJPhaOV20dPuk=
X-Gm-Gg: Acq92OHylpoiuKgnAmYQ/aPwPDZ0OLfjsYsB31knpeksPWLy2VJMgl4BDjr5cq5g4+I
 snCvjnx/sRCqJ1wot0hASNWDnwGB4QzwaQY6vTQK5ejCeFs+PvvC3sl1lZUzBrTvu9rVILrEEVA
 IiVaosD0gufbLra59tKpM5XV0wQ6tMHE+5iOrnq3x0yX1pWSSFAqRAkM+1btv5tZUBiwfA+n+oq
 rD5VugDvGP8U8Ow27j+NI7A45+NhWx8vR3vdkSNUJ/UU6YrrWTePt/OFuHpRTPZHdtSSuK8MlXW
 7p+NC5sWRXjzBKYEQnEI59YAx9FCvYear/kn3ky/yKmS98J8zhhfaj3ua5ln1w48/H8LswE1N8j
 1oty1xY8PiQ+dNhbA2dUWQ0N6f5U+uyiK9pJdN0aGQ1TM53z9nNI9A9CizAWTfDSR6Xw+v1Lf6E
 EOR5PlN3uzFAK5YoI8iACdv1w84q5sAdpQyVmf
X-Received: by 2002:a17:902:cf10:b0:2bf:305a:310b with SMTP id
 d9443c01a7336-2c4111b6164mr39392515ad.1.1781278465499; 
 Fri, 12 Jun 2026 08:34:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327aca78sm25952555ad.54.2026.06.12.08.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 08:34:24 -0700 (PDT)
Message-ID: <194dea7c-1d1b-4850-b714-39db43d58ca6@linaro.org>
Date: Fri, 12 Jun 2026 08:34:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] linux-user: Implement /proc/cpuinfo for ppc cpus
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, qemu-ppc@nongnu.org
References: <20260611212705.11354-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611212705.11354-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/11/26 14:26, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Mimic the entries for /proc/cpuinfo to what can be seen on two debian
> porterboxes (ppc64 and ppc64le), which are running via KVM/QEMU.
> 
> The "timebase" value in /proc/cpuinfo is used by glibc on power, but only if
> the __kernel_get_tbfreq vdso call isn't implemented. So switch
> cpu_ppc_load_tbl() for linux-user to get_clock(), as suggested by Richard, and
> report timebase = 1GHz in /proc/cpuinfo, which will make the vdso
> implementation simple too.
> 
> v4: change timebase to 1GHz and use get_clock()
> v3: drop another colon, indenting fixes
> v2: drop colon, add clock output, refine pvr calculation
> 
> Cc:qemu-ppc@nongnu.org
> Cc: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   linux-user/ppc/cpu_loop.c    |  2 +-
>   linux-user/ppc/target_proc.h | 91 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 91 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

