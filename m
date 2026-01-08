Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058BED14880
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 00:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdeLN-00033D-Rg; Wed, 07 Jan 2026 19:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdeLM-0002uD-3v
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:57:40 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdeLJ-0002Rr-NN
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:57:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0834769f0so21470085ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 16:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767833856; x=1768438656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7t6+wM+8OZKJoq57Ivh4In2mIxjkP+zkTI1/cumdnE=;
 b=j4WyUL1Nj3ATNtuk+JaZsmiMQCBzxWFC3YNex3M5VufYBU0ibqvpAxl4KwqIERiF4u
 qWSO42cN5DfhHmOSf52T44EmHmQtOPKG6lpTSlOchPOtY3jI102UDrrSjW2G1552BAxZ
 zXnUzH2ObZFTDkqq6YwI+Ukw2N1Eam6k8AqeAtRig6ih3lbWq15Vc9wri40PhjsJ7HnU
 wCx0+AC5eLGPlTjKTXyhaXDLlntDF9lt2o2e46LdpUCbdYDzSR0LV4LZP4ZE+7tP1+A7
 60dHjNCmUEyMhmZLyUevtIHxKbkbOwADwU4sCzUvXV6CIjK89nrVhLq8E+Pp+ZTVTsi9
 OR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767833856; x=1768438656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7t6+wM+8OZKJoq57Ivh4In2mIxjkP+zkTI1/cumdnE=;
 b=q9ebYslhBAfGtCu6JXQM7C0+TIcUJxyWu6WmpMvbX+lneFRdESpSnLCFyMy2NmSLpu
 PCh09KeBNTDmu6xnOBD4W/oZwmPcKRpwDnAAHB/39NP9LOZH4HeUMjbh8epWYzQ56MvQ
 4l+mMUCp2YFnMfqGO0HcKiMVnoWRqkwLxA2zHTCwPt4WdVOHwlt2P48a6Fr92Vm/yE3Q
 /hm/EwP30z6uQ7rXIGYsEBYO3uEqUUQnWRjBFhTFMEi8FltNNQriEky1QAVyc2Iw9yHG
 YKSxVrc3bM2MxmCnzqHvpE8HEKTe5ygp3RKV3r35vqu8QeJMFERZI9+zQOVrXZNhBRKI
 BNGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXizylo7LOns1osuBXPYz2FNDSdrp6US63H372SesFOnNAkghiSSmdyiVbtQtUdY6ll+0ZP71rk6zrg@nongnu.org
X-Gm-Message-State: AOJu0YxkPyG6YNROlZpRJIPY/j8Olr/uUUsVrEi+hBOm38LzcXdkDLe3
 qGZsINAHfBPGXUmfh/n8Z4gQXz4DjNk35978S53x9nB9o7qkCl6tuaEm+HNAB5kfhJM=
X-Gm-Gg: AY/fxX5DWSY5876M7K+TYb47mLpEdGMWoLkVNVVesRbXODZWhS1iDTnci9fNbYKgMej
 G0Il3L5BigUz8dePIBhxZm3IgYmHahUtCLANX0jwrsisK/nNOb8IbiYOQwz9R81bpKovwfJVsZr
 8Dz3cwvG+yiVOpX+0GruZ9zN0lWNtA/ynuQiXn3LY64DAxfe0VYM/SfOUe6ab+W+6slsbXLrExc
 maqcjsR8KCHqBGhF2BkhJ2jTPjQH85A8ZoSOJslhdQA9jYVb5vUC+rV8VbCITpuWVMQZju9v8na
 oY8MXROnN4Hp3H6RF2Cb1IFRuJsvxLqdiBEqIdyQkHBAbT1UuxapAFSCcG9zQ3SlAwEtG1bAo6r
 rygS0TcmyG88WJrSKaMWrV10nJfZrwCh7AFDBGi5dtoDaiKkR3P7SbVa06LsWuvAxs3c7ytcmw4
 cZkEJBzR0MOTc17wIPYCU1Fq9oNOSLgAMv1B92+XvXhUFRvK/tD00/EABQ
X-Google-Smtp-Source: AGHT+IEtjWhRfSxvbfI/MFZGTHK/jhiTFYOr5Aha2Y8sRMXoj0VlDMZHdNCxEmnWdcr+yIKm10oVvg==
X-Received: by 2002:a17:902:d4ca:b0:2a0:9040:637b with SMTP id
 d9443c01a7336-2a3ee443be3mr36420505ad.26.1767833856046; 
 Wed, 07 Jan 2026 16:57:36 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd492esm61760945ad.98.2026.01.07.16.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 16:57:35 -0800 (PST)
Message-ID: <3640a20b-9578-402c-a16e-dff0c6464516@linaro.org>
Date: Wed, 7 Jan 2026 16:57:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] accel/tcg: Un-inline WatchPoint API user-emulation
 stubs
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106231908.16756-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/6/26 3:19 PM, Philippe Mathieu-Daudé wrote:
> Currently we can not build files including "exec/watchpoint.h"
> as meson common objects because the CONFIG_USER_ONLY definition
> is poisoned. We can easily fix that by un-inlining the
> user-emulation stubs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h | 17 -----------------
>   include/exec/watchpoint.h   | 23 -----------------------
>   accel/tcg/user-exec-stub.c  | 33 +++++++++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+), 40 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

