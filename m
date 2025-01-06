Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3B1E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 22:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUvdD-0003SK-Ur; Mon, 06 Jan 2025 17:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvdB-0003Rk-CC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:31:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvd8-0001xk-VK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:31:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso106764225e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736202685; x=1736807485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LYfjSSJpyWF8YdTXFIQrrsDbxYpNwcI0JUFAlwMko/s=;
 b=PuIRE3/0LBzh21cpIXshLw8KdtDHittEj6zh8zmI4HzJ/GlajN4Rqd3WEyu+RlYJKB
 i+3ho09F6cQevFd+VWBPSjOAZivDSV52/W8m73VFuy1J555mXPlHqE90nTMuwipshqoy
 3X3yqVALDaj3RYTB6Uu87NcslfzRyW82gNKJI71Rrr6ptwDnyvzsQqS4/DPE2F4K0ili
 CZEnCda3jPy/AAtMSWBsZVXJ4b+Rtf9LBP7JBZA2wYqCXfDFqXoFF1QRi06K20vXLHqS
 kwjcni4oB+WUsskZ47VkyadatVcSkXkUeCqTyALA7q/aCHHWLjlX3ppsdzPqCG5MQ0fA
 nySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736202685; x=1736807485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYfjSSJpyWF8YdTXFIQrrsDbxYpNwcI0JUFAlwMko/s=;
 b=enu3WRCkZPP+JNsqP5BG5rYS/0LyZVmajLtD7HTskfdG8RHNdB91vDmyMRFF7dPG62
 FfR+h809hFYAUoD0T20Q7wJe/8giUGGxK4xalr0ZgHB+VDdRKeNgvjK+VUlp309qvhdv
 BWnCqGgFybOjOPXYkHB/f2JgSZDvigwMRaGm/MUwWuoOIPG96LOsjjhGKsjiOzujjeF+
 Z8gXHhiy9CdKyyzndn/hBWBJ1R+FgC4lS3lVpCkiLStzlhLmuGlD824yd0o3sQ4E/3HM
 vzghgVg50IDV72TcJciNsBG3DznlktxI2oXtU3k16HFRTvj1dbfrtTcI+v9b/c/aYbjM
 /HkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSMPQNay4ucYoVyAHi0+txV45zQMypF/i5zI+BrDrQ5RjXqmYwL2CnqNSWTQUsOduwiN4QySCU2Y0W@nongnu.org
X-Gm-Message-State: AOJu0YyEW/2mid7JLnu1XXB5V9OFAEe4/GzwZ8paXKxpRqimAirHxtJU
 HDpCZy5oHqRGugNyn95iq/CI61cl7F+tcyNQhaQYSOBfjPM4l5+js9eunQQy1woA1CveMXg00TN
 WuUM=
X-Gm-Gg: ASbGnctlFgyjlkP8CCyHeyZK/n5/BiE7N9427AMAkunpTaxmOipad+pGWoo4LTUoTBq
 s2Q0g7MVNDs3E24jk9/YgfnaQMdFEna0nEMqhtZscxM0mGOzVF4tIp9qI6PlxL3z/40eNtb0+py
 IA7UknOrb8N9/9UTbBZGJ4nQum+gqzIubef0RfAMMGwEgqZysQRzurPg/U2c/J89Pna9R66+KBM
 rzSqGjGpwqVS4vYm5ckK7Eo/vC9n4VSvnJpYLplkGUuDdx4Dsn8Y43XyNMuPZacPmgWSZXCc1nV
 j9hXAeU7SUajNwKSXenYJ2rB
X-Google-Smtp-Source: AGHT+IE5wJRfn693znD86VToMPSDet6TCSmunOqLo4cJloQKQnAgusO7ugExr2Byb7siHt4zycrRsQ==
X-Received: by 2002:a05:600c:5102:b0:431:547e:81d0 with SMTP id
 5b1f17b1804b1-43668642eb9mr474791775e9.11.1736202684753; 
 Mon, 06 Jan 2025 14:31:24 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a71sm576228825e9.26.2025.01.06.14.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 14:31:23 -0800 (PST)
Message-ID: <2e05865f-8577-486f-870a-f797f8538cfb@linaro.org>
Date: Mon, 6 Jan 2025 23:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 67/73] tcg: Merge extract, sextract operations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-68-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-68-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  7 +++--
>   tcg/optimize.c                   | 12 ++++-----
>   tcg/tcg-op.c                     | 20 +++++++--------
>   tcg/tcg.c                        |  6 ++---
>   tcg/tci.c                        | 25 +++++++-----------
>   tcg/aarch64/tcg-target.c.inc     | 12 +++------
>   tcg/arm/tcg-target.c.inc         |  8 +++---
>   tcg/i386/tcg-target.c.inc        | 32 +++++++----------------
>   tcg/loongarch64/tcg-target.c.inc | 25 +++++-------------
>   tcg/mips/tcg-target.c.inc        | 29 +++++++--------------
>   tcg/ppc/tcg-target.c.inc         | 38 ++++++++++-----------------
>   tcg/riscv/tcg-target.c.inc       | 26 ++++++-------------
>   tcg/s390x/tcg-target.c.inc       | 10 +++-----
>   tcg/sparc64/tcg-target.c.inc     | 10 +++++---
>   tcg/tci/tcg-target.c.inc         | 44 +++++++++++++-------------------
>   15 files changed, 113 insertions(+), 191 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


