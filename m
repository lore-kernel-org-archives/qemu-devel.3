Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC13EC2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 06:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vce9t-0004TW-Bj; Mon, 05 Jan 2026 01:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vce9S-0004PR-89
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 01:33:20 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vce9Q-0007R8-MW
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 01:33:13 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so245185325ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 22:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767594791; x=1768199591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g3SyVIRDBAVhHVfXY1CWSQMOPPeGcE2SDiBiidPF/Dk=;
 b=WknNn3q35xdQSxoJMDyPbYeeqBMU0QN/PuLegZkWwKOWRxiKnQtnZmUvDUMPia/6Xl
 e2JadIBmoQPDQhiTgvTcWWY47AJ+CJ+NZ+G3Tby02s4o/NABMJapFd7ROuV0hR2huBv9
 tgE4xgdk/hWtGcZfl1wb7jBm/KhSjCb4h79wgvGJ+WlCVexStpn2ehwl4bF6lzs0E7wm
 6Rh8WCpZN8kfBoTKzvxFkKXdJOIZG7OgJCO4PdIaB3Tpii5FNifRyZhQXp/vS18pYkfr
 Lsur2ylt6M6673wJTd+VYg3ZbvWBHx1A4aexsb82suk1XL8+wZUIrLopNf2bR5OZXs84
 18Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767594791; x=1768199591;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g3SyVIRDBAVhHVfXY1CWSQMOPPeGcE2SDiBiidPF/Dk=;
 b=m+kQIEGmlECLvr/wbRVvMjzr018HjcCwJtKULwH/lxykWc62fr5rFlxoGjtSd4OYUl
 9bQe4p89XFvaLEguCAMpabIuRFaHHhWQGuFGjF69k2mW6JUcYShbJHED+8f1noW99NOj
 GOp/McRo94lx8bWvPez+8by3WRdsQUdUzwpUJCVvDCOALiceZ4fLjxCBp+jYxrmVoAyh
 dJ/FCswm2O4EInlcvDyXodU9ECQzjGaHLP5gJh8mEhkulV7I6tpvKXQj3jNixi40ouFR
 xPnKFlXX9yn+M6PdP1bgwquq38Wnhqmmcf0roeiphRYTHnk1GucK2nvDdWoPU6roLJ6G
 82aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVso6bMuhZquz2Bii3TNbZoPLavUP4lMOHNX6VeVi8n6oEXCOJ+XYNRnYKqK9kNydwIvF3gVgYWj0pi@nongnu.org
X-Gm-Message-State: AOJu0Yzuzng6Za6Q8P/CNiqUVCcTTUa9Zv+Alw3FPnPSgYrPOk5KPK0q
 4p8qLd/lb6QdQZsSMYTHJR0CdA6JszgtuqnPTkM2HF6l77FJqcGTFQc3W51K71Tb5I4HPTikIpK
 JyijSeCQNbA==
X-Gm-Gg: AY/fxX52OCdTadqX4VYCLDIIqr2wpfh3ZJCrweHtaIhm8hiKu3q+9UOcjhdn+L1+uD6
 rLTNWwcFmTFjc++mRD01yv7SL4D6uU6nK6pFze4o3oNcSM5kPUPvkHh4Ffc7Nyk9g24pLllRQhu
 6qaxrNzP2B9QhfS6mDqQy7Ykd1p92k3/WYaNK1+KOwCMeP8PxZVxpImKzSY8QBqtot/Rn15vhEc
 V7T8CgZ7bkjxWOwKylAZu3Qj9UduXmXwQQPI3M54mEr5qzwON7Uf0hGTdoN06m9GS8vLOfc+3Op
 +CXI9ogT1I/6ButLPfAWH0N56Ho5k9UKk3VFKMZvHttoSPyKHPtDGZ2WBbsuL8ut7hmJ86u95RH
 lTbL4FwJ3TQhxrIRAdYDnQUvGm2NHCdMx4ekQoOoBL8rFRLb3YlpJM4O/rnUth61MKky96y5eXB
 P4MAGR24WNM8H222Bemiip3dytd8QbTQ==
X-Google-Smtp-Source: AGHT+IERjwodSAwbAbtrrr2nw9dfv+MLZe/M94DXeMbLrLvgEO1fgXnnQo0iWfyzinLs+BGxD8zqcw==
X-Received: by 2002:a17:902:f54b:b0:2a1:3cd9:a737 with SMTP id
 d9443c01a7336-2a2f2738124mr475377445ad.36.1767594790613; 
 Sun, 04 Jan 2026 22:33:10 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66bd3sm436364955ad.1.2026.01.04.22.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 22:33:10 -0800 (PST)
Message-ID: <c0623237-626d-4580-9795-293f22d3000f@linaro.org>
Date: Mon, 5 Jan 2026 17:33:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cpus: Define total number of address spaces in
 CPUClass
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20251223222649.187935-1-gustavo.romero@linaro.org>
 <20251223222649.187935-5-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251223222649.187935-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

On 12/24/25 09:26, Gustavo Romero wrote:
> +void cpu_exec_initfn(CPUState *cpu)
> +{
> +
> +    /*
> +     * If the total number of address spaces for CPUs is not defined explicitly
> +     * by the arch the default is 1 address space.
> +     */
> +    unsigned num_ases = cpu->cc->num_ases ? cpu->cc->num_ases : 1;
> +
> +    cpu->cpu_ases = g_new0(CPUAddressSpace, num_ases);
> +    cpu->num_ases = num_ases;
> +
> +    cpu->memory = get_system_memory();
> +    object_ref(OBJECT(cpu->memory));
> +}

Why do we need cpu->num_ases?

We could have cpu->cc->max_as, left as 0 by default, and remove the CPUState field.  Then 
we *do* want your _MAX definitions per the previous patches and not the _COUNT define.


r~

