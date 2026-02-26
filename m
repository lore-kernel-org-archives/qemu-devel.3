Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC8AFD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjkC-0004OW-DS; Thu, 26 Feb 2026 17:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjk7-0004NQ-5S
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjk5-0005ln-1a
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:21:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso9786955ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144515; x=1772749315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5ePtIOTRiRlAz34uToC+86ERqihsQg1WmjxddY1c1c=;
 b=YxmNDeciQQnRLbyehCublZUf1BZ5K6eQbuLd1AwC/DtjMR0U+/9Biwh9hnqa8rpo+4
 tUHutoye0T6y9nar5mI0RVskFpXlAzV6zA3OdnYkD77MLsLr2yy1tG0B+uNlst6uE/Du
 vvjDD+plJ3bC9qvbmq4AcYugl0UCgUXyyyw/zbbSDvWp5SUD8R2uMmMvZUoOyH8Ach+l
 MHdbgaB4W8CzCvbSWxQOlMbeiDbGeopAleTC63q3qMrhdPEIUvI7jmbr8HqrPyUyQvzA
 x12OEjyX3TAZYJu7Oc6OxJ+wH8grWiR7qg5uSEJeefI3z3NCGVx+t51iI7XFbBaUt45l
 2cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144515; x=1772749315;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5ePtIOTRiRlAz34uToC+86ERqihsQg1WmjxddY1c1c=;
 b=WJ68NiAI9YVq5XZxNGVzarkhdOP1kqOWieGGtJeGHZEIMQAzhBWkprqj4+av2UHrwR
 Zj5evGtdPCLFCU/zeyagZJgYW1bFWhswgFuRKqu/JFHHsr6kMgBJa8zMyrfPqAYz6cpi
 NNPAZsfmR+BgTL4vDhkKygMLD8Y1929O8bMn/9WIz0z6/YBf1QVMmWXpd0eOI1+QTESy
 +CRvgbYuLoU47z4fOUC6erC7ym4r7SdcLOVN7YprSghoSkCC4u2HtoVuNsikVRFDrm8q
 bkPNgB5lfTKpXwhCNmInftrOrWyIpDSE8gdJGcwAo1XqFxefsghH9/BWwb14/RCQVJvG
 UHpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcsA/G8q0xl9Sy8bhw9am8RgZlYyO2wn3lwlH90aucvvZg60nidkuDPxVJargoLvwZD7g/qGTG9pba@nongnu.org
X-Gm-Message-State: AOJu0Yw9nmkglOfALLIWkxkayEAtq0n2JyXGybVLyeXsowGt91ciIaYK
 iYYY6c3hqjFiAsLRIDJf2Z6OX3SzlSnYgHJ+Dosj0YpDYxS8kuzpRAVhzCIAEATh5UM=
X-Gm-Gg: ATEYQzzgQMkH0XBptU0U3vFScHXB6zS8xiQdlvI3VpyYfRHQyMtV5prYhSeW8VVZzhA
 4hxxg+zPeWtwEMchM/T2U9x7b0Wk2ymVU5I+ZYHkzaoAMuPYXwbVfGTbuE+2EghUzPGnCpko6/I
 arHHNq4H6olCWQSBGLpT2o19CydD2+nyLlofaiTMfVtpqnU3p8XA/U9rOMaODFvX7zNi91EQAGU
 4FIeD3GNYXr47A+bKGqpQQdIQ6HYFvTGTV1Jx/IR2MtiQagNyiOH0fBhrWzKnpqm2TJTkkTs/Cw
 Fy9kW0KJRXH8glDx9Tqh2Ol5pTtKxd5XhLKGhP6xrlTp6BtXrssBGk9yJthqE4/Sf3aD7+db0nJ
 1+HWF1Ivoqde1zj19BldaWJB/mwlFs7xGhMUmcVRxjOeve89DeiMoVyuBzkKUJvTaI5NnNQsr73
 ir7/l/h2ljGgOGH4RiynL3SFjP2TsH9fKvOiZwezviKEIN3kAzesSAmNuR4x0cYdelI8Ia
X-Received: by 2002:a17:903:40ce:b0:2ad:6e0c:6210 with SMTP id
 d9443c01a7336-2ae2e4fd7cdmr3716425ad.56.1772144514856; 
 Thu, 26 Feb 2026 14:21:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6bb5b2sm34105845ad.69.2026.02.26.14.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:21:54 -0800 (PST)
Message-ID: <1dbe9b1d-0d76-4bc3-bcc7-f4c192eeb431@linaro.org>
Date: Thu, 26 Feb 2026 14:21:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> physmem.c defines 2 stubs which are related to ram-block:
> qemu_ram_block_from_host() and qemu_ram_get_fd().
> Move them with the other ram-block stubs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   stubs/physmem.c   | 13 -------------
>   stubs/ram-block.c | 11 +++++++++++
>   stubs/meson.build |  1 -
>   3 files changed, 11 insertions(+), 14 deletions(-)
>   delete mode 100644 stubs/physmem.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

