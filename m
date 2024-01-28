Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75190C46CD2
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 03:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTvxa-0001Tx-Vn; Sat, 27 Jan 2024 22:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTvxX-0001SE-60
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 22:35:51 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTvxV-0001FI-Kr
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 22:35:50 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-781753f52afso144055885a.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 19:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706412947; x=1707017747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SO+RErsUFZX+o4+VjQej1KyesIHHJsM7gmSOlh3zIVY=;
 b=PW0TSEUbW/JSPwHuVcudJ/Rk6a2fkrvtRj5A3LcRkBO5ToiO7zWDwqQw/NoAL/kyCS
 +FcJUIDXa5p2VDCPMu+CUI9OAfD9R4vK3vcQptuPxGXc/E0xcC1hgMYLMhze39juX700
 2Gohe0wX7BGMRB0cvPSOB8Q2vkblrZfsH0pfJ916N/MT1sgMWkCZ6ybgVpdqVEX7QONU
 pdpMw50diOQ7oJXnQqI4JOFzVdm7rH8v4c0ImG0hwrl9jqn4Tl3D9AnvrtoHqtII822F
 q+eYp2/1K//IJNIjqEhD+OtRRT7skK0ZUkHLqja9sPwXjK8zcETwUqbLhov+Fr3dRdj5
 PChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706412947; x=1707017747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SO+RErsUFZX+o4+VjQej1KyesIHHJsM7gmSOlh3zIVY=;
 b=jXFrdy4SIDQxpkNpNXum4Bzn9Zpfdb1vzGF3ca4iW5XkswcF39EQg/6IrILBmpK7LR
 ElX/qpRuBzAI1mP3olXT+ojCrZj8x5yqIZsSeIrs1o7S2OU1o++FLipwKd8lP9DP+y7k
 CIOxvLIzOWZY9ibl0NfNSZ8TavqGSnTQSyuxJDBCEOLIjMc+NpG/Pae3Y6gEpMtIWkGx
 0i+5cVRHuOosoiBITxiu6shUjMRDebCSZBsW5+5aYsReRCAwfFbZT4wEubuu19B5GMhG
 vIpfsz8vm4w055WSakmOSwEI/XJ1a/5M4Y3x3nCyF4X+reyY+OMCdttJfhuaVDer/T52
 UVUA==
X-Gm-Message-State: AOJu0Yx6ozVL3Cg5bCKc14XRYyuxXsgMTi8Ly1A8ZvV6cqBpPzCB5neG
 d1n80BwOKQUBudF1EMM7VPJsmO6iPqTVueXm56ekgbdylRf3vS52OkvjFkPEgtw=
X-Google-Smtp-Source: AGHT+IEmP+NlyZRftfqMeV6QxIKvPg3GecmEgXqtHG+2heaVrl+P1iwyevIAsVY25/trUmG2JL0CfQ==
X-Received: by 2002:a05:620a:13da:b0:783:d5f2:5c12 with SMTP id
 g26-20020a05620a13da00b00783d5f25c12mr2439683qkl.79.1706412947648; 
 Sat, 27 Jan 2024 19:35:47 -0800 (PST)
Received: from [192.168.198.227]
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 kj14-20020a17090306ce00b001d74a674620sm3075828plb.198.2024.01.27.19.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 19:35:47 -0800 (PST)
Message-ID: <316e8645-518d-4b35-bd06-bcf4c4f52e26@linaro.org>
Date: Sun, 28 Jan 2024 13:35:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] accel/tcg: Extract some x86-specific code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> accel/tcg/ ought to be target agnostic. This series remove
> some x86 code, addressing part of "Work still remains" from
> Anjo's series:
> https://lore.kernel.org/qemu-devel/20240119144024.14289-1-anjo@rev.ng/
> 
> Based-on:<20240124075609.14756-1-philmd@linaro.org>
>            "Move perf and debuginfo support to tcg"
> 
> Philippe Mathieu-Daudé (9):
>    accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
>    accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
>    accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
>    accel/tcg: Un-inline icount_exit_request() for clarity
>    accel/tcg: Hoist CPUClass arg to functions with external linkage
>    accel/tcg: Introduce TCGCPUOps::need_replay_interrupt() handler
>    target/i386: Extract x86_need_replay_interrupt() from accel/tcg/
>    accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
>    target/i386: Extract x86_cpu_exec_halt() from accel/tcg/

Queued, with patch 5 replaced with usage of cpu->cc.

r~

