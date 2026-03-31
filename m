Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1388710F92E9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dPt-0006ti-94; Tue, 31 Mar 2026 14:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dPj-0006oY-4B
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:02:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dPh-0002gs-Gc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:02:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso60418085e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774980124; x=1775584924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=79PiBEITITYlhKTXOjq+W3jVKARptoLTz55eOHp604I=;
 b=a2Hfl24n5nzGs/aMSGEtU3DHSsmRwEYqo+Qn+3Yb/RpQl7KWHEBk9PgCAzqctKxjjW
 KvMlbdLs3m/TTgQzB4MeD0Y6sTIJtUTmi2M+biHbR/6jC1CzZtE/A9oxR1YS32uFG9Hg
 1jM9ht0NHpEta+Ns5UjZ41z8PweOETDf+lzQb+95MEwFTV+2Q3lc3ODvSJayxhrN2Als
 1m44PvvP8I2EBOuF0v6hYyxPxRqrruRsOiEAupeydZyb+SGYCqdJdchD9JAgajNsygeJ
 lgfwc8hrgKguWD/w6HFRbrRwTnXAZWytK95pB+UWWeSgKjuONe54UBLG0rgEnkdWM58k
 +6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980124; x=1775584924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79PiBEITITYlhKTXOjq+W3jVKARptoLTz55eOHp604I=;
 b=Axhse2nFoya9/uEAfh5OahZNjMlTHg+1cmCrWuTY7zo+KS6+c4PCnDHGuJ0irJIYDh
 p/KrT83BN0mmHZLQ8dcWTP1US2KDTSW70nENoN5vZ6lRy1iPe3EBtGweOnxYfiU7kYMv
 Vhr4NuB3yfNBIqGcaStD0wuxFsG/TUKZg2jNJ9zBBIk8OE/FYOFc28K8xil+RJ5sLs+9
 YOkZLz3Q1NsPECy79rSM6OgTisb+fLT7GPckrKR8rGC8cB/nlZc5K0nvg/tNmtDK8LXm
 YtYLBDjngcEWHAzpKrd9OvYvDrX8VcC4OhUW/HLOtXDQgzXrKq3GK7a+6OewP1IkNsJI
 ED4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUBvcHM9nIO8+oIR/44V/ypieqvNjiVg0tSKNUiNmlUDtPMzqf7xMRKhTtA52fPOpbKwcW/lB9Gq/H@nongnu.org
X-Gm-Message-State: AOJu0Yx93w916vNVSS1EmjV5FQhSz2Z/pyvOyn8xgzfXV6VzshAV/dwt
 TP8lZ0+iKvv1kV7a2c8opM8f+rTGFN0a4jUWa8NLpvdE1rLm2+ADqxcW8Zop25KlMPYV2fL9AVV
 dARhfknk=
X-Gm-Gg: ATEYQzwr5ieShBmpDCQo8pwOzjLrI36mxoRPRXL/ekYM6qH6e/X3SDhQvxKsT1K/OKb
 dCahPQAj8vnWW95bfgMn4trgi1R3ZtC3loTz2PPJTEuKM62j7Zs9H/mC92nUaAT+fngRpn4QccI
 vThIRRh+uWRlCmj6GrtAGJQlSJNpU8zikXtha/qhATA26hLIiIJz4oPCs7F2cQgkvNGkk0c5Jl9
 gkDgbK4IzM+5E/2i+i6wyN5uU4kUiX5jUM3CMuuLwE79DpL/PHH8EgJBT+eX+9zV7bfaxVc1fU/
 R2N+xJQNEwYljfFab8WFRF8dHy0iDSHcbe0gH2CO1XcsND4iwOqEsgjHxSOh2btIiA4wRRinqcc
 rB1QAtRf/3SLnxOAv3LzDDnW1UsRem6PRPPfahW9z2yK9ll2QO/7GjR3uUjvUZjsm/LM0szeCs3
 7X2C0FVV4QJCfEDmJ7UtAX4VH/u+vfoVaEwTbPU+YbP/StygRM/LYtVHmXg+xVihoTVL/1StNqU
 EM/
X-Received: by 2002:a05:600c:1d0f:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-4888356dc24mr5457475e9.10.1774980123593; 
 Tue, 31 Mar 2026 11:02:03 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm88862505e9.2.2026.03.31.11.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 11:02:02 -0700 (PDT)
Message-ID: <bd2e72bc-af19-4b07-8f8b-e1255b1c005d@linaro.org>
Date: Tue, 31 Mar 2026 20:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include: Don't include guest-host.h in cpu-ldst.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <20260330143123.1685142-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330143123.1685142-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/3/26 16:31, Peter Maydell wrote:
> We currently include user/guest-host.h from accel/tcg/cpu-ldst.h.
> However that file doesn't need anything from guest-host.h, since we
> removed the uses of g2h() in commit 9b74d403b30e ("accel/tcg: Move
> user-only tlb_vaddr_to_host out of line").
> 
> Move the include of guest-host.h to where it's actually needed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This isn't needed for the following bugfix patch, but it made
> it a bit easier for me to understand where we're actually using
> the functions.
> ---
>   bsd-user/qemu.h              | 1 +
>   include/accel/tcg/cpu-ldst.h | 4 ----
>   linux-user/qemu.h            | 1 +
>   3 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

