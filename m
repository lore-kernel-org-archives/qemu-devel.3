Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4488CC531DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 22:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfRXV-0000yJ-Sv; Sat, 17 Aug 2024 18:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfRXU-0000xi-Ql
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 18:04:48 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfRXT-0003TV-37
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 18:04:48 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70968db52d0so3417432a34.3
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723932285; x=1724537085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZsaievVq39Pm0l3UynHIOpLHY5AVNf5CLxHtmwOnTM=;
 b=Uqc2KXVhFH+Pp7b5NAqTpVepex24+izjlaFvVdlSy3qrpLAHIfd++XjK4b9Vk60boG
 eSgpHjdqVnXGfoiuC9SMIExiGtWNuZVg4VGSdzc3pdEuXNrsk/oQeB+XYYNsqfBM2Zp1
 T1InThGLv7F7mzlQd4hqy1h04eF89haPL/T4/2q/mqXEc1rGSZ2zYbWjGWZeY6fOSkeB
 yKnrzuqMijBgbpXYzWQSwmEY9mzD9ZdJFYtD67t/q6U941In1JYi7nmFUXDKtAFaRPsN
 Gp7w/yN8tAgjCEqFsA121SQRuEskg6WdJamxQapcaO5Aoi2VeWoVM4jYdrkS+19x930d
 Mgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723932285; x=1724537085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZsaievVq39Pm0l3UynHIOpLHY5AVNf5CLxHtmwOnTM=;
 b=SFX5Q5H1oQsnks5ARj8fm8orBLUkRuvCxTgy6UZmglqFeooLqoW3trf4vc84DZfP64
 px266mj5AZrEzbLm9HpVAK8+5wlLUdXTg0+/hZ0aHxe0W4P+LvowB/dvYAOcT719Uu2m
 9T748kcq6dWKS96Z/1MLlBNRiZ7GNpgASBCn0HM0kHQpZkiQiE99FCOmFqBEADvzG1+q
 ktYA8J6o0guVP1+o5LItt3Hs8qiV8oGoEpUtjP7WPp/u4SWFpazDLWmuliaZGL4+b0zH
 CM9R8kzKuLKg2ruSu2Vn/hmw6sbw8fLHQf9vnKOpCRo1La5BEQUyYIl3cNmgKUBPLPmc
 k5gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVGfJJCn+iowgFeDsocfJZ2UxezHXA+3DKBtk7rG6N6vLU4XndrvZijRUr+b/08BLna42k3x8fXJL/eWNOdrl2Oi/tTCw=
X-Gm-Message-State: AOJu0YysKwm9Bj4ps3wMFmBhWNEg6Ga1i1u+AKZ00j0yfYk5boW7IMfN
 sLNxrinc/R5SaJ7s45afpKqloRrSLmO7BSHGtvFZDYqyRceHrpEeVu8FpXy18wSqVsXmHFu/Azk
 py5c=
X-Google-Smtp-Source: AGHT+IE0nmPpALVBcT+8A2l13g37QP+uZcGH/tf6AoxBTEJEdSzCdlRDyrHA33A7iiAV3GGbTViQIw==
X-Received: by 2002:a05:6830:6e8e:b0:703:6989:5b04 with SMTP id
 46e09a7af769-70cac8bcc04mr10399958a34.31.1723932284968; 
 Sat, 17 Aug 2024 15:04:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d418e7b76csm1586501a91.2.2024.08.17.15.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 15:04:44 -0700 (PDT)
Message-ID: <52eff0d6-ab85-4c6f-a4d9-78738b4cdcdf@linaro.org>
Date: Sun, 18 Aug 2024 08:04:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 for 9.1 00/21] Some fixes for 9.1-rc3 (build, replay,
 docs, plugins)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240816131713.2321664-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816131713.2321664-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 8/16/24 23:17, Alex Bennée wrote:
> The following changes since commit ecdfa31beb1f7616091bedba79dfdf9ee525ed9d:
> 
>    Merge tag 'pull-request-2024-08-16' ofhttps://gitlab.com/thuth/qemu into staging (2024-08-16 18:18:27 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc3-160824-1
> 
> for you to fetch changes up to 278035fc81510bd88501afb78bd5ab652beffa76:
> 
>    plugins: fix race condition with scoreboards (2024-08-16 14:13:07 +0100)
> 
> ----------------------------------------------------------------
> Some fixes for 9.1-rc3 (build, replay, docs, plugins)
> 
>    - re-enable gdbsim-r5f562n8 test
>    - ensure updates to python deps re-trigger configure
>    - tweak configure detection of GDB MTE support
>    - make checkpatch emit more warnings on updating headers
>    - allow i386 access_ptr to force slow path for plugins
>    - fixe some replay regressions
>    - update the replay-dump tool
>    - better handle muxed chardev during replay
>    - clean up TCG plugins docs to mention scoreboards
>    - fix plugin scoreboard race condition

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

