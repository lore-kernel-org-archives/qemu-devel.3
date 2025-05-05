Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD7AC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs7T-0003pw-JX; Mon, 05 May 2025 05:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs7H-0003mY-SZ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:28:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs7E-0001U0-0X
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:28:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4469061f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437278; x=1747042078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWBC3mSZ9nkWtKFP0YlbERVtyyCPwfDq/KkYgk7fvl0=;
 b=u6ePN0B+fKs/1O0BPea8YtpNJDwhtcgQVO30dqlUqTu06UvzoykQaCPWivzwdWW81R
 e98+/e8QIFGYiqP3zLjTeUYz9303BYShDKqlPRJnSqjXjPUatjOdOxrC/zjxVlYfDUes
 onTB1kR2cJnL67rzXOVS0eeMcrA2SxCe+ujSqdcQGDoIvNL5iTPZOGB/PrpqyODfzDdK
 W+PmQXy09WkC1k2D9DIkRaieoZCoLz+jGIWgz38TQ2dxz9i6mUc7gOykYxJys6yAoNGX
 bShhOYRjKU67F/vhATG0IjC4lSvT8GdflcW562IANOn1CckJSmoSeqUTGdPZuKXEiBsN
 e3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437278; x=1747042078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWBC3mSZ9nkWtKFP0YlbERVtyyCPwfDq/KkYgk7fvl0=;
 b=NBjG5/n9f6ZOlkfSi7dVJE88iqxRbI7JYwRUJuY0CRPJugy2ijB7o7lVWvA7zctc/K
 muWGOBFHJNb+kT+ihu7e0hY3BzQN8UDxNOEq16RBlc6bqIGRagt+6I9FtGwzjCBTRSgJ
 gHLMByPkPMOPxr0bchz+SBzMz+Qtl6v81T09SEt+wEboAOQT5XKgK3MzFwcsuScgZKZ0
 MGgv5qDoiLuWjAqVFYU1GtETpdS9DDkv1/SFcnkAJcYcMetbIgVYYVrnt8gXLXQ9qqlu
 hkPF2n1UyMkC41s1j8luJGo/6Unh7yMhrS9uSbMaVswiGzyQytX5kuN+hBCsj0FOOb8s
 TY4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVngOSFw8V1VyYu3fYS7Vg4NNOvUA2OxfArqvvLQrnYD/i7omSrBmb/Ow72hX39VdW/Alv2JLSAfeoE@nongnu.org
X-Gm-Message-State: AOJu0YyiOUd6Dns94JLtUp8txDNrzXMYneM4JyRaUhnAftE61YDdhU2q
 VczY+lcF7/1pb9cW3WHPOVsHzD8FJgM8vXfbiMkRIyEbOp0ngbuuKxK/XpBT51E=
X-Gm-Gg: ASbGnctmbNVuz74VWFIbp4Csie0pxo41jVBwBxpxur9P6fPohzEEMaGQMc4sE1/WgVf
 r/HXThNGnUrEOyIIgEIRxYKkZQHlLVrlZK8+VrRhjz1/qS5G+Zed7LLMIdrryBUbCKcIgc9QAQT
 4dCRMip0vxclsp2BZ3F8FG2fGFkznNZKnXF+KzdYLd37ZUWr/H7VqBqWgfs8yI9eloqPJ4qprdU
 K/PPAmJZiC7wqwzo4Vzb17U21sDeBZ7whtAGc680CODPgZcCYYJxaPqJ47uAQ/o0lhm6QS7i7ke
 aQCpWlhO98dKlwcIpZBgBd2e5o9Mr0tOo7RIJs22xrCvWyNzm4/EwxOgeYpZhk1T2k7AMAMq/6s
 UU12dyz0u9YNNwic+ew==
X-Google-Smtp-Source: AGHT+IHghgqBydEmynEJR9JO50E0HZLpnXKO2ioLLuwEgpBUQRHEbpWD52qgDk0XqQDr7Du3uSXNZQ==
X-Received: by 2002:a05:6000:4312:b0:3a0:830e:d1a8 with SMTP id
 ffacd0b85a97d-3a09fdc06d3mr5422145f8f.46.1746437278467; 
 Mon, 05 May 2025 02:27:58 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc469sm128676155e9.6.2025.05.05.02.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:27:57 -0700 (PDT)
Message-ID: <80cdd651-d7d0-4f99-9399-515e9bd49863@linaro.org>
Date: Mon, 5 May 2025 11:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] accel/tcg: Assert TCGCPUOps.pointer_wrap is set
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> All targets now provide the function, so we can
> make the call unconditional.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 1 +
>   accel/tcg/cputlb.c   | 7 ++-----
>   2 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


