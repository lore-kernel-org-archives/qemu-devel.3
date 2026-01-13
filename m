Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63546D2D11E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffoN-0007ZI-HK; Tue, 13 Jan 2026 09:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vffoM-0007ZA-6U
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:55:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vffoJ-0001k8-Pa
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:55:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso70219095e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768316152; x=1768920952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39DpSnZqTL54ysXG1uN3EJeV07ssQp+A9pSKb1S+UPA=;
 b=jqtmewKKLYtM8l/9lLJKyvo1xpd4aaTycNyQPFdoM2HjvSm2k2vh3iPf1mQPmCRc8L
 XUJV0fWGpN6Rg92zAkE9U6Xen5aBJSJrEJFqiUlvlY1GXe6/smXDfQc2i85dVw9873UK
 IKFpRd0prH6W2GCKZXZ9vHLyxvEOQGqLqeDYjgF1Qnwk6YgB76uBZkl52cY/tsdCJDLv
 BVhqbBnhinTMSvPcInyURqIgUk7OW9M/RJ3qiTF737UMgrAs0F81qy+6p1OO1Hzrx8AC
 tpwXRbm+12h7Ivlm7jjdMdZVQt332yPU4nuAKN4/6QV5KjdRbLcDsFuyigPxsWepEPgM
 vqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768316152; x=1768920952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39DpSnZqTL54ysXG1uN3EJeV07ssQp+A9pSKb1S+UPA=;
 b=CxnyT031mlmREPkqdTevi4p8R4hD+HHtUNQ5B48qol89UkWylHDIAtfnHCzWAA3lIZ
 uAf9RAQdLNySBySITM/mH8SKbyg07K1zMb8ipbEP2gN3wk60CfDvt9HLBFhOnu/dnDbh
 ZHss06xbva4+GyD3qNXA76Ofbe9ONyaJctGRsTP+YuyG1PGruDXTA5uAQLSXkDJgG8Ee
 21LB4QnGXIh7FW/bNeu6QBtGI18/9K1yOA2qSGyA97faTIjWb8SpsRPEiCOVoma6zpEk
 Tb1p3+/yBGer7iblFJJmNZguwihZVEJu8WMSYFE6AC/xfzCC1mGGiYqFA2vr04L2EKk7
 Gvwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzwGrQmke9A0H5EacvOwVQzTpSjqOyP2LjSI/x0umsaF6rJP828K4iXDaHW7jDfk1CAKLHUgq1Qo2X@nongnu.org
X-Gm-Message-State: AOJu0YyguCqWbNXTL09HUrYNL2Jz0iVptwvuVUu4vPzb2L/Ar6Gscgrn
 GDF+UT3KX0AFEaFj4cVb5YcCnmOTvFO1f94yBop44CE4abGD0Y2DidmHx8pw/gKYPT4=
X-Gm-Gg: AY/fxX5dcuMLU8MuIO0Wx9PdmvczajY9T5aB65SX5zXab2pMpSub4N2RyRFp8sPXt35
 Nnzwkg984LbF2lylDKEGpvChSOfSIC1mEiyZzGHXjbNfNWqWJcrsORux1CiSbKAPtj7/X0MN/Gc
 5XaNeZw9Ca4DY+k4hsZyH3AQxqcZPHL17++Ya6ZGt3uuUwzVmEI8G2mp4ZjMmvuoIQY6LA2/jaS
 WgyXWFTnW9xnrkzvmjSR9Eu2jCKT1/XMTyrA4GBnlSgdW1ZS8Tpvl5OmJU+NLlp/Psxxa3/+bl0
 MpET/YAj44T+nj2QtIWkHUhr9c3vupLiEVL0duOGXRobksFabTB+jGs3Y7zU+wdwLuEjFqN34rR
 OOO728I4EkKd6JMkgAzlVUH2fHHYC+Qa598Y2suChw+aWx1WqkR9dVrx0qlv8h1nWSNYYslfpKT
 xVEFkG7b5nvGqKOOKvYjmzrleLDdCTEd8tZYBKLrHpiE+WnhpZwjK8uA==
X-Google-Smtp-Source: AGHT+IFZRnRT8rKeeJAaMm8XuiAMD31/j57aECuSQTIYAapr+/mCvNuX0brpkTqEYmW28mpbfbN2Ig==
X-Received: by 2002:a05:600c:4447:b0:477:7c45:87b2 with SMTP id
 5b1f17b1804b1-47d84b1a0a0mr273165815e9.16.1768316151630; 
 Tue, 13 Jan 2026 06:55:51 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm43850318f8f.28.2026.01.13.06.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 06:55:50 -0800 (PST)
Message-ID: <201775df-0d26-4849-95df-6d82a84ea312@linaro.org>
Date: Tue, 13 Jan 2026 15:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] meson: Add wasm64 support to the --cpu flag
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
 <91f16f0e9ae6b36fbf0c2caac510dcf855120400.1768308374.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <91f16f0e9ae6b36fbf0c2caac510dcf855120400.1768308374.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 13/1/26 14:54, Kohei Tokunaga wrote:
> wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
> flag[1]. This enables QEMU to run 64bit guests.
> 
> Although the configure script uses "uname -m" as the fallback value when
> "cpu" is empty, this can't be used for Emscripten which targets to Wasm.
> So, in wasm build, this commit fixes configure to require --cpu flag to be
> explicitly specified by the user.
> 
> [1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   configure   | 6 +++++-
>   meson.build | 4 ++--
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


