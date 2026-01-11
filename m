Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D670D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej4Q-0005Pc-Bh; Sat, 10 Jan 2026 19:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej4N-0005P8-TF
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:12:35 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej4M-0008VZ-EG
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:12:35 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f478e5283so322704b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090353; x=1768695153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSHQM/Z4om6R0eAMeVr/yPv7W5X3BK61NW1rotRfBSA=;
 b=pSFD7vWcjQ+IVKItSpZehAHXESHz+7Cr6/3H2byHYiQgkqKdo3+pwqkBR+rKUO4dCu
 udb1dOWKW+N/gGC/5e+ps+nK/kzuNnyTzS8j5AlKdnM/uXNbpCsKu5KKhpRBrISkO1Vx
 U068pAfmKnog5kAAflCNO9NYnCycXTnQN0R5iXd8nOyPAx7Jx/UkBiJ3Wt84rwttHxm8
 5xKkY6sI3WFylZS1xJb5jHjw6s2NvBKhHrFQ9f9dPHR/HR/HtbW3589fvD1tSsN3Wzay
 7Be9KaXLO+2ImiN05xJEMtSy0ULI7agnt/6V9ZDOc/YwsxZIFBO7CTRhOoSKTD45jm05
 afgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090353; x=1768695153;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GSHQM/Z4om6R0eAMeVr/yPv7W5X3BK61NW1rotRfBSA=;
 b=DigG9F23NqlO9jkwyUR7B2glaVQVJMuDLz/6JnYfgonM/1+vdmEXrZP0BxrQZ6rsEm
 uKEs+dSccytSmQKYySSEJmxNSAyyfB4MoELAOOcH/gjpmbv4O909Pe5Avo58FQ9CWLQC
 G+pKBuPH3BAejp8tjCAyTFTazkOTlUxA1LpynITXjQ4uhFfiFApfCJqYUIBD5huVSk3C
 EsP7qXAo4Nfk27bpo3oT63/1cXW39ywNCmDh9EfyOe0Y1dj+lHP7AtGT/Ma1D+EMHWG3
 65c1nyPkqaSrZy7tzGiAxais6cCmWYe6V53YQNfc3iBSdMTVDEZFUJR/gzuBz7+9avwG
 ndHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYfJUdF5LnquRi9ZH2KI2YtUesG1Gwqwvf5lQ3jxYoOSqtNajOgM6vRHIxa/7Dn/5MHJgFeF87Cn5O@nongnu.org
X-Gm-Message-State: AOJu0Yx+6bQPxCD3h49DO9s1HBRUkmvwF1NInrabWdYpHK8IB7RVGVhu
 YdkGQtCIdXA4rejHgkLFGHQBlx90U6zpEEXqA55EN5/Kio/wc4aPLPgCUEv35ZKFHyzmQS/85pt
 0ox9GgWA=
X-Gm-Gg: AY/fxX5E6uUykc16So6er6UkxTROFYGGmhL+mYW/sQ4nLqqrSXd3wDeetYrRXA/+81k
 YJDrJyFKY7XUhr8BfyeOtRrlGZ0Yd34CHkeonLWIunlObgHgo7TTbkwK97K0QiObxNO9J5DlQcm
 C8AL26ZxretqYXkO9NvHQpns8QzBxPMjt4nUcnUsiMA8qBdEHSaMIyOjj+R0eNPd3EQ9ibm2xxA
 +8t8GLHOUZYrwXZUUIzXFWO+qpEAK4qn7nv6H6m4MiyAqaKnenOQiBnFOAHS7tNQP5ZbvFHBAip
 wdgF+SEFbUo1D+MpkYVx7WS9sJzViUWWTH8MYjw8w5HhvYodfojHLqPdHnpZ3AhPon1LglB64sc
 BAJU4+8Q0IgifPmwzHkCn7WJ9Pf6Syi/YWx0gsVIPKpueKNLdQXqbfBE5Pga2Q+S0E/5RTY7lRe
 uHnQ0JohX1KrpIk4izKT8GpzDMrw==
X-Google-Smtp-Source: AGHT+IEhRuT7W6qG/8dGSQArf+TzhAAhMTEKhIPjFdheFpAoAfPcJMSTFSpUlgCBjIbgr/26oOzyMg==
X-Received: by 2002:a05:6a00:1f17:b0:81d:f1a7:98f with SMTP id
 d2e1a72fcca58-81df1a70b4bmr5448441b3a.57.1768090353083; 
 Sat, 10 Jan 2026 16:12:33 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f3cae7e7esm2634177b3a.44.2026.01.10.16.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:12:32 -0800 (PST)
Message-ID: <38d49edd-fa9d-4e2c-a1ec-47d5cee133f7@linaro.org>
Date: Sun, 11 Jan 2026 11:12:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/m68k: Replace MD_TLONG -> MD_I32 in monitor.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/8/26 07:07, Philippe Mathieu-Daudé wrote:
> m68k's monitor_defs[] array implicitly uses type=MD_TLONG for
> all its entries. Since we only build this target as 32-bit,
> use the explicit MD_I32 type to avoid an indirect target_long
> use.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/monitor.c | 60 +++++++++++++++++++++----------------------
>   1 file changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

