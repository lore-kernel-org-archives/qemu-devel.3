Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E3DC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTagP-0001jb-Bi; Fri, 26 Jan 2024 23:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTagO-0001jT-BL
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:52:44 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTagM-0001Zo-TH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:52:44 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e0df9aa43dso757312a34.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331161; x=1706935961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+wIUviclSfQmYGAx2cNKrfo6FtWI8Q0sDjYA5v+L738=;
 b=l/CjAYQ0gaal8FhRXmZjWsr4U0mcuydtY/GFHWpcWJssr69l6Y3PK1rFSAUZcaQGlt
 y30Y/BDXg31l49h6aLwULW6Ax2eiZ/dML6AHdDxs1lvxo5ByDS+Oupb0WNYzrqiKanme
 3vbIfZDUyBd5VZ0hRs382ibgbvdOzoz5yiC+4jZx5a8gqeWZnXtH9pCwKqWDxIWCsGFn
 JCTKVsWFusfBvbhzfV0uhN+LDQML8IHjaAzGfVBdy4Er91frwjeNt0wu/XCF5bE39Ak8
 ouubwkj1pDiIoeNga2t7MWsnnpCg3ACe4jCcFLn2UpRkyRs+QMdSRx6NEJTf7mb3JsJr
 BsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331161; x=1706935961;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+wIUviclSfQmYGAx2cNKrfo6FtWI8Q0sDjYA5v+L738=;
 b=imxo0k2dOqWaXaZXsd1JC3MxoaQYzeHYPMheFX9293j9oRenB4ZQWFr459BYbyP0be
 L3jYZgnqRqMBQTmaVYYGmdiGEyKp1XLctq0NMAT3G89tnVFfFGsIKuj4P963LRuut85+
 GbOrR6oB38Ao8I32jQfh4hCvYUIqOXMU1s4g24NbP47/3oTnZ6laAyAnC8QAXRzWZhjG
 Q+sXo6AiLypA/0hhpFANPhTJzjvTqm3CPuGxzkmEC17u2LNxMKrDqDtYUZYoPQoiDFZG
 cF11qxm1U0xWCUlq463tKkvKy38FUAOMOT866+55ZpZOUg/aBfIqBZG43Tgl8whtbFGs
 owOw==
X-Gm-Message-State: AOJu0Yyo8gtIkRs4zbm0TX1RWHhzl5HRtKgkvTcSka3GzCEfDlZrBvIM
 mn+ziVEVmsnOGXxFI/B8TDrSGPMV7rAgaIoMPM9hSVwJCBIIArFO46IUm7B5uMM=
X-Google-Smtp-Source: AGHT+IExyYxyXhNM5ZRcFzbZcGllBGo8GlFi3a+pAM5HJi6vUwlcZQ+Jl78axZ8OEosthmTBEs8ztA==
X-Received: by 2002:a9d:7982:0:b0:6e1:152b:d229 with SMTP id
 h2-20020a9d7982000000b006e1152bd229mr1352773otm.55.1706331161366; 
 Fri, 26 Jan 2024 20:52:41 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 h13-20020aa79f4d000000b006d9974a87fcsm1882908pfr.215.2024.01.26.20.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:52:40 -0800 (PST)
Message-ID: <cb5ea213-1d90-414f-b6ad-9284d477fc3d@linaro.org>
Date: Sat, 27 Jan 2024 14:52:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/23] target/sparc: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-24-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 1/27/24 08:04, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/cpu.c          | 14 ++++----------
>   target/sparc/gdbstub.c      |  3 +--
>   target/sparc/int32_helper.c |  3 +--
>   target/sparc/int64_helper.c |  3 +--
>   target/sparc/ldst_helper.c  |  6 ++----
>   target/sparc/mmu_helper.c   | 15 +++++----------
>   target/sparc/translate.c    |  3 +--
>   7 files changed, 15 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

