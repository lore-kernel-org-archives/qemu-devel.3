Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB47D12683
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HGh-0004E1-GD; Tue, 05 Nov 2024 05:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8HGf-0004DV-A2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:58:37 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8HGd-0004kO-9f
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:58:36 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso3910219a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730804313; x=1731409113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9GnUD19XuJDeQQIfLrDDAiu6StgkP/Y+HkPPKYKdjU=;
 b=GuEb6lXgvdZ1SMvoMVZOxCyWkGAPGb+65TeSWlCo9ydsvuHDPPkqq8B9ZAHyD6e7KT
 PYaIFSinOvazuuPTIMCXQc2Sx9ikTuKwOS0RMtck3Oh9PZxTUee/H9gVirnaqj6T7R5n
 MODw8SOHozevh7vHQb5garklFKL8kWOgXESeP4OumwKZ/3olAn2Seohnh9tmkObNtIka
 Gj9uYMorScQCBQY6qvMIX9nL0uROEhz7gvR8aOFzQyfDBo2Z+/vzV+8OYtJW/CrPDcms
 HHz/dReCVG/TB4DdFp/qeFLms497Nejuwyf9nF7i2MInIhgFQr+Avmi+OUGU+iKBkhBI
 6H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730804313; x=1731409113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9GnUD19XuJDeQQIfLrDDAiu6StgkP/Y+HkPPKYKdjU=;
 b=rMlmfZM5cADf1yjQwMSFW9R/BWouM9gK2m+k19R8RohVqDymaww09ecqkPvnMFu5Hb
 UoZQd2z69FW3JDQgc2ucSysknxdEeojbnq0LHsJ7wq/boSAWK6DSYJWEtuSXtDoJpKaU
 AOtO42c9kYg1RFPMLbUaQ+zgZre5SPZ+HWNxJZ3gdo+o363sYzuEP2fGTonV17P2Jk/C
 nhGLu1JtooBNJwoJ4Tu7PBSzXfRVI1OWSuvxlXjfNzAUYM3LYly4P942xvHsXJTj9tYX
 vT/E96tJ+9mT34GELFMkBJaSZQOwQMd8VW0ae/5859TkACHik80Bw3QCzwsqM2sh4uIE
 0D3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPKfB5/ogl9T+oHePZ9kL3zu43uqBD63sMtvnXPf5R85L87JAmGzwVBfi91Zswfn2wWEbrMbPwuwCu@nongnu.org
X-Gm-Message-State: AOJu0YyJFIH1WR5xrhGpC/DwyMu+YSVrayTgxTINhtfqA8YrU0J6tYYW
 /tEUkYLK60LkgDVt7w4Sv8rMkyWe+G9ncyEjT25vDd6eCwaChsebrC69AIbcmVs=
X-Google-Smtp-Source: AGHT+IG4u5jLuQo/JFxrOgpTL9mob9GX8RXpRItSc2yE90kzuCAzEUG6YxMsEH/uzuTDtVvBbVjsVQ==
X-Received: by 2002:a17:906:6a12:b0:a99:f746:385 with SMTP id
 a640c23a62f3a-a9e3a573d11mr2472258666b.1.1730804313009; 
 Tue, 05 Nov 2024 02:58:33 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb171550esm116909266b.88.2024.11.05.02.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 02:58:32 -0800 (PST)
Message-ID: <12e5b415-a80a-49b3-b98a-33a398ebf56d@linaro.org>
Date: Tue, 5 Nov 2024 10:58:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com
References: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 11/4/24 21:51, Rajnesh Kanwal wrote:
>   target/riscv/cpu.c                             |  26 ++-
>   target/riscv/cpu.h                             |  13 ++
>   target/riscv/cpu_bits.h                        |  94 ++++++++
>   target/riscv/cpu_cfg.h                         |   2 +
>   target/riscv/cpu_helper.c                      | 266 ++++++++++++++++++++++
>   target/riscv/csr.c                             | 294 ++++++++++++++++++++++++-
>   target/riscv/helper.h                          |   9 +-
>   target/riscv/insn32.decode                     |   2 +-
>   target/riscv/insn_trans/trans_privileged.c.inc |  22 +-
>   target/riscv/insn_trans/trans_rvi.c.inc        |  31 +++
>   target/riscv/insn_trans/trans_rvzce.c.inc      |  20 ++
>   target/riscv/op_helper.c                       | 155 ++++++++++++-
>   target/riscv/tcg/tcg-cpu.c                     |  11 +
>   target/riscv/translate.c                       |  10 +
>   14 files changed, 941 insertions(+), 14 deletions(-)

You're missing code in machine.c to migrate the new state.


r~

