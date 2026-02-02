Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727AEE7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3oX-0001mc-Nz; Mon, 02 Feb 2026 18:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3oW-0001mO-Vx
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:58:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3oV-0007q5-CN
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:58:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3972639f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770076717; x=1770681517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HGE8On1jAjfb/JVD+yf+xmdriHyDrkMherkOwuUTTBw=;
 b=GZTLAMwj5jSQI+0NUEIV6R888yNnGkkZGAsxfe111rmWuSzZwOv6jF8XN598vFSMc1
 wGmQd6D61RN2KaubNuLsXyGdOJLaVRUMmkjkJ7DSjL0qoqeXepaMJzpYW/jUZ3der9fj
 THJNWTG6/vabDkxAPrRWCR3xadQ650hcGvVpqBkMMtWPG0DsTAwoS2/UYqJmBo/5NJCB
 vpSDP1kjy/bEDueSroepYNFXo+H7X9hXW77SxeRLr7+KsVpyzZg1Ggbgu0eJ/V7WBopx
 iLXkz3daMg3/q6v7UirLIAOqcOaNa32uhN0u2k8C50MRccZs3y7Q3SofK0ZwfVPO2xkM
 p2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770076717; x=1770681517;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGE8On1jAjfb/JVD+yf+xmdriHyDrkMherkOwuUTTBw=;
 b=JhnF+53yzOP8/3zGtyfBTwVeyqUqo1JzH+cLc4LCCe2G9gcv8+WcTXJGzy7vASFH2a
 uTk7pQ/Tft3/QRck95DO9UbZkxKNhW4105HC6+O8dblJ+Em7EEiKc36ZmhE+hUzpGucS
 W68fQhRt2SWc8Ux/hNoAA12B29t0o18TSUGuhGQMdW/VzAfHoEk2n9EKktMmXtJveipB
 VCcf7j2OD/Ci2L+sb8WS1Nl7QUcY6UcB7liNm70bNekHkOs/w2COnqsT89QV1HJ3lPVI
 2pYITV887AHZXKFJ+md4mJHOEy2pQLuC1tcDbpUf2VQayyRIbRE3s+XLpPmgBybqZ7Hm
 PcIg==
X-Gm-Message-State: AOJu0YyJ7ws1BMTi65+BwOpR4gDGBFGBZSDY6SI/v2HzlNV2I0MGqJ6S
 4GP1uV/M09GpD7CNS1DcqU+twVP7Fh5t1z97swutzimmsrqhBb2FRwTcPdLomURValEB/avJu8Y
 pYl4SueA=
X-Gm-Gg: AZuq6aJPZ3BUd4bi14HZAtVDRKpW5zXJr/H2fXGPaM7BcgJ3VAU5PgRjdbwCoFhNGXo
 XsO4gpa2/asgnAxKUktY+HjLV4gGjkj72irVNNmr42P5l0f2t3DaA2hKOmT+qD9Zd5PU4aJUsNs
 s/GfFfNarXtvs0KVlBn0u+hKMHmAm6QNPyaNU/ZM4tUjVdk3ktLCJwCRPeoLeDCY5S2+GDtPEoO
 RghESpGwg3XtcE0Iv/z7ARFx/2IF6MdMkNgU5vImz1SDaO7kTjIz+dD1ozqMEfcd9GOD8/i4GdC
 XEe3Xpf+G5SccM8iYYqyzGNJc4l1P3Sv7YrgwWDnhj7XxcQ0oRU4fuoD4watPDuJZMUCgf62v2o
 y1czB+RyQHK74hP8wvw5dAZjt4zyqjBtVfSo6P26iIKlRXGcZlB8SwUXmXFQwcsFYEiB5QLb2zM
 eWU4pxI8nC5iANeE9cUmrF7+1tj5gy7OdhIF0yggID4BWH2mKgwuxBY0F1bO2utCtp
X-Received: by 2002:a05:6000:3110:b0:432:85eb:a3cc with SMTP id
 ffacd0b85a97d-435f3a88732mr20095553f8f.19.1770076717047; 
 Mon, 02 Feb 2026 15:58:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47590857f8f.12.2026.02.02.15.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 15:58:36 -0800 (PST)
Message-ID: <35ace9eb-04bb-4de3-a82b-689b136aafbf@linaro.org>
Date: Tue, 3 Feb 2026 00:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] target/alpha: Remove unnecessary target_ulong uses
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260202234550.34156-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 3/2/26 00:45, Philippe Mathieu-Daudé wrote:
> Replace target_ulong -> uint64_t / vaddr / hwaddr
> and TCGv -> TCGv_i64.
> 
> Philippe Mathieu-Daudé (7):
>    target/alpha: Avoid target-specific migration headers in machine.c
>    target/alpha: Build system units in common source set

The following patches aren't required anymore for single-binary; I
just happen to write them before Pierrick's meson rework, they rebase
cleanly, and are good style cleanup IMHO, so I included them.

>    target/alpha: Replace target_ulong -> uint64_t in gdb_write_register()
>    target/alpha: Do not use target_ulong for trap arguments
>    target/alpha: Do not use target_ulong for page table entries / indexes
>    target/alpha: Remove target_ulong uses in get_physical_address()
>    target/alpha: Expand TCGv type for 64-bit target
> 
>   target/alpha/gdbstub.c   |   2 +-
>   target/alpha/helper.c    |  17 +--
>   target/alpha/machine.c   |   3 +-
>   target/alpha/translate.c | 228 ++++++++++++++++++++-------------------
>   target/alpha/meson.build |   2 +-
>   5 files changed, 129 insertions(+), 123 deletions(-)
> 


