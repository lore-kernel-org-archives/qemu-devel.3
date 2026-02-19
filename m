Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B9AC531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgG-0006uh-64; Thu, 19 Feb 2026 16:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgE-0006sD-9G
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:26 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBg8-0002T3-9G
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:25 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso767607a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536918; x=1772141718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eBhldyIf1uP/zB2uoK9IalwIf3wgKvk7xs+SqpQMcZI=;
 b=qPiH/2X9Gl3KoO7pDQI3Ze72x4Cs6dddiER0GmqwFqQwDCoKtc+KE3tpUldXkvnyVW
 yEl3bJH0RPm9tt9UjaFqnBaOF5FuFtzLBNjudk3xN9VG3rvgR/MYIUFY57zjVblYiUD3
 AG9/G2x73eTqxyR0VQ3s8h0tYYUG6w/XR4N2kOtmeVMhYelE92YXaMWRrzE6Ap1GA5L9
 TbGDUDhr7dro7U65JYpHoAs2FzklbU276+ASA82X336evH8mHf/V+5ucj1NDbMS4tsaJ
 /G72TwVuw3fQsAFqXt1vbNWchc3qcZ7BVQgala2ri8acs2ARP8t/I1F6VfQFd7DLBcia
 4kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536918; x=1772141718;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBhldyIf1uP/zB2uoK9IalwIf3wgKvk7xs+SqpQMcZI=;
 b=O59Tw6UjcIITV2fTMARCOq08S2O6tLNZ5So4z7wK4LKOqdDxYK9WYt+cAmGJZtC37S
 YPfTQQcG3bdcrDS/HqliMbrituHQ5+j+Xsiajx29F95/ivizNe/MuY7r/FGHDr/4JmCf
 yVeoXwSPYT/GffT+DVi7NJWOiiWS+RiOeW2exkwbDj/0utQKpKTJ/i/XJjUzmZnsy+o0
 rnDkO2YPKnnPQWQBdlSfFRgpWkkfZmL0tsym6dQcu3z1cWIQ2k8kUwZDEYCnkDCklWIB
 GmnDHRl08OAxIqUUrE+Ahe5aLdtdCTuNmTETC+Od+4cuZMdG0WfBa4kp0Ask+J0NxZq2
 a5LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSAYI47PFUmsvQH+BVPrc33M7AHhWSYeD3fKyjg8KRokgGayIeIQKK4VBw/mBCi/LH5NHCWGitRf6@nongnu.org
X-Gm-Message-State: AOJu0YwlV5xL0xE8IbfVyZDeZNFytogaRAjD8B5fxpRw5qG+nERqDroH
 XwijJEESjcDz05q0/dFf/5nW0HwdOfob8vhmU7qP8dDwDypMdVXncdTd/9vrnkic0M0=
X-Gm-Gg: AZuq6aJOohpogweP56+pyaLVwVgewrHktSPT2tu+3sfSQ2AaCzGymOe/4k0cXGgZkFi
 hZ16ev/HwgSYER6yPgKWX0vR+QLcJyG9UW7EBJq2HOjGSrw4Kn14D4HxEBjBChHLPULwg64B63g
 Zsv9GSdLJavjlnhZpDPVl9/TU/8e6Y3dQ3PPqxceLS0xQgJygTZT/28SONbH3ZuaiRbyeO2i5bS
 8Qnb5EGxYZhg/vlm41bPyUltMcUAuLB1NL17u9GeffJuyL+qty34gL7E9JdUfx3r5H1iQ+cpJGu
 iRUwyd0W8ZyFiIUp/uf3zGSsA07NtkQk1twPlUvqzLY7IaXi4w4dgiLMHdpmOQTufZfLDjbLjn/
 cfVuHDJycnZngpVY5V95AFl3HWO8MAM7CAZhHDM9qNn8HFJ/rG/zZbU2E3uHA/weVGvxMjMp/rb
 MHUbckSkPiI/0BrEHVCsXlcY/qk6B+z2ojWZAjmfdM9LEUsDOrjxoZDHtjy+ajhTohpDZP
X-Received: by 2002:a17:90b:53c3:b0:356:2872:9c5d with SMTP id
 98e67ed59e1d1-356a7a4314emr22097514a91.24.1771536918518; 
 Thu, 19 Feb 2026 13:35:18 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-358a19b242csm157049a91.0.2026.02.19.13.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:18 -0800 (PST)
Message-ID: <ef35d82f-28a7-41f8-a363-9484366e8318@linaro.org>
Date: Thu, 19 Feb 2026 13:33:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/50] target/microblaze: Build 'gdbstub.c' once for
 system binaries
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-39-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-39-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> 'gdbstub.c' can now be built once for all qemu-system-microblaze*
> binaries.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/meson.build | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 

🙏
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

