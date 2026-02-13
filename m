Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB26EDF17D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqwUT-000262-05; Fri, 13 Feb 2026 11:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqwUQ-00025H-Ui
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:57:58 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqwUO-0001oU-No
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:57:58 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso651256b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771001871; x=1771606671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BBk3LN13vRIrraQyMYVrvO3hBZWS4Kd/DHX6ab2IqGI=;
 b=GjKh3vmPms5OEG/A6tvDdeW+iC00uAjxk6Nih8UbReWKStcqllTt/vpqlejQFBInE4
 qyy2HCUfvQxMCtmhK6f94vw9Qnz6QjAv6rkdzOzXNxcnBaetCsTGhhGBe3VffVikLkVU
 v5AEG4Tx+iECBsP7Cr7aQbvbIxaAyTkNZAkBpozQmTerlvGHjuAnkJJGFsUaoXPW00ji
 c4QzM9sGH1iyecwKXuHPRL8PfmYtxvzi3bKLUSZp5DJocpoT6qE7CeJTJ0BW1+mp7/vb
 gSO8tQHPKsIvtikxG4Ga9q4qLeOu8svfMvEcQftMZZGSe8O7ZQ0+EO0t7NPqKVjiAevO
 c5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771001871; x=1771606671;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBk3LN13vRIrraQyMYVrvO3hBZWS4Kd/DHX6ab2IqGI=;
 b=BPw76r48PHjGc88HLV1D8FP9rTbDSMkf9v+9cRtIgt1nk3N3EEjANzD+AZEs+a8eow
 CW9kfBc7jWtLLSJnoisOUhINZoAdVAUCxYokAKDVwX57dTTL7NYnZpc9rrinDLzl8SGB
 Xy90u1g+FCUixuJOdkfrGpWp9qgiQDo6JDaDsJuQcsl0rpo+SkFhsJr5ilEKCRuwrdkG
 xEmFzL6NVYDBrPUy68SZjmfCY5Xy+BIBZOUtlZjB9laKOvWkK3YV1xPKbNftTeoa21+L
 OH+mTZb+AFt6Xyphisk71pVQ5F4ihs+4UiDr11bHU41usLIVn7wQSW1oRJcCd3XAPWao
 R4FA==
X-Gm-Message-State: AOJu0YxEQZVx8XpEduhgx5zXrGiQJRLsO/lhbwoxrkQGLe3VkhSasWr5
 uBtd410WTQiFILkTUzOUfYy5mzLTb0OAOZJKVA7dnuxSTlw57VEi6nuuuP9/Ta9zN6T7im/Ycz3
 O2RQo
X-Gm-Gg: AZuq6aJg6tOfm+H+FTkkejhyQvdZl3U+n9CMy/GYTPSZQRxp+Q3RcSkigUYUb39SzCr
 0bNQP4Bna19dzL+yZsa3NzlpPmmi5mifQPU/UP7x/P71N71Y82E0gohoF3DiQVPTiEKUMOU6mwo
 4qtjgKUA6DcTTQAuLqet5vLjnyoXMz9Ie3IYGHcs2kvBTU4kTPMJBNUlm2Ot+nxTHvgsw/nNCZK
 JMb9lNRz0Yq5u60ucrVqAZhQsbdSFzoXqdwegZs3u3+gT10nwzlj+1i5nfCcKVWjrFYdk4p3cEu
 nK98GyBPfWEEhqZ4eSwOwDxJkAySXYALP1XBONSWcjHDkFQJ1OSikhHj8vSOXz/4I0Jd68quUDi
 XyjtDmT5QTlwafTRCak9FTj1ll3wWyr7yDajUWdjKI8dwWN+TrcgFXjj+nxTttp5wMl1PsCZKlu
 BXOWZ8/oXv/dvmrbV+A1TdJFH5AMK6LZdTd2qloqGE16wR84eVi4GhSapxyrSalZkuh0Xd
X-Received: by 2002:a05:6a00:1c96:b0:822:7fd8:ffbd with SMTP id
 d2e1a72fcca58-824c961b794mr2355511b3a.59.1771001870959; 
 Fri, 13 Feb 2026 08:57:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6bb26f9sm3348830b3a.57.2026.02.13.08.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 08:57:50 -0800 (PST)
Message-ID: <8b32f147-89b2-4481-a440-b6b2bd84685d@linaro.org>
Date: Fri, 13 Feb 2026 08:57:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] contrib/plugins/uftrace: add riscv64 support
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/10/26 12:13 PM, Pierrick Bouvier wrote:
> This series adds support for riscv64 system tracing.
> Compared to aarch64 and x86_64, stack layout has different offsets for accessing
> frame pointers chain.
> 
> To build and trace a riscv64 system (requires only podman and qemu-user-static):
> $ git clone https://github.com/pbo-linaro/qemu-linux-stack -b riscv64
> $ git checkout qemu-linux-stack
> $ ./build.sh
> $ env INIT=true ./trace.sh /path/to/qemu-system-riscv64
> $ uftrace replay
> 
> Result perfetto trace can be downloaded:
> https://drive.google.com/file/d/18AVzg5ftwJZyJMMbm_KcB4FMVSas6jVz
> And load it on:
> https://ui.perfetto.dev/
> 
> Pierrick Bouvier (4):
>    contrib/plugins/uftrace: fix infinite stack unwind detection
>    contrib/plugins/uftrace: add ops for walking frame pointers chain
>    docs/about/emulation/uftrace: add info about automatic tracing
>    contrib/plugins/uftrace: add riscv64 support
> 
>   docs/about/emulation.rst  |  23 +++++--
>   contrib/plugins/uftrace.c | 128 +++++++++++++++++++++++++++++++++++---
>   2 files changed, 138 insertions(+), 13 deletions(-)
> 

This was merged into master (7d224fe8ca3959687e9fa16f0891d1731c9205bd).

Regards,
Pierrick

