Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29793D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWety-0002Uw-B4; Fri, 19 Dec 2025 13:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWetw-0002Tc-Pg
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:08:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWetu-0006cj-W8
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:08:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so5515325e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766167704; x=1766772504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qoSP6v8NafZhzOwZDwhrjmnlUi45k1UXZkX2sFqRtvw=;
 b=OjvHFyJQJLgeD2O3Wke+bmHx2424OUsJM6PZdGZk9youE3D2f8Vans/Znfu98UDw3W
 eec3g0IQc/IZt/5ykTYveZahX9TraDjJd2PKBm0u6FqrUtSwYqBxef58TszQ1qduauJj
 un8OU2kBXhhvXCX/F6yQxvPKnu1zk1Ajpn0K9ue4l4Z50Y6OCtgqwuoFD9vdgdBEgHsu
 S0VOKD1TDn7ivZJYwOM7Z1Gf67M+EWLoGrLAvWpgT8tsUf8fN2pDUVBBK0H5iZZLKg5l
 QEkJgmbIICEQF8rfQmQ+tYfQyfZitLBDxYYwcCedyU2ZQrJ3ms0Kac8zD4iE6G5/vt7B
 dLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766167704; x=1766772504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qoSP6v8NafZhzOwZDwhrjmnlUi45k1UXZkX2sFqRtvw=;
 b=Q6Lyc8/8ARbb6+EoEP8p/SeamxhqO2tDuEZpW9w95YX7PipYpS2fQLTfkvVmMcgGS6
 /90AM2/wH0/JQD/o3zcmqupbtL4vBL820azT9Yfg51HI8QNsL/LMX98mQ5bpQ6pQ6bpK
 el1UuVuxJX9QKpFxWG70VwYI2g6DFVyV9DSfYArWTQp376A5wybFKHI7q+WmGrPAll5p
 /93bh8i+tLYMD8GPY39c7yMJO77yZqaqV71x8TkhK0e0rxe1EcJ7jzfoMpuSF9Oa/ygd
 Tb2BV/w6Zx8RnDGZkiQX2REHP6GmZRb2AhV3/t0QMmbwxc3uqfOG89gkCdp9b10pFVy+
 fSrQ==
X-Gm-Message-State: AOJu0Yyv8U3hulPkCxIMGs97yp6FFmxJtiwCNiTnEGg1Ts/pWdrMY+vZ
 /1Q5MBU329nEoAeEws3q/GgoEirVbdrk/IRy8uhOoamyYlVSEYOcN4GhImFS2JPfR15Q8H/DmGN
 e/k/slC0=
X-Gm-Gg: AY/fxX4vFhrCdL2xEy8MlyEIoKhV1fPkaRAMZai2qw7NjFyDcS1w6Pf+WbBerCmwc0w
 hnCHfnvUHVrttUEn43yFH2zrFIdzVrKK1T5JbW2akpU57nP+bDvDPQKlJBvujwBNUaq5xyEPsuo
 mzbnuVr+hXVDJNC9xygNMYR3Fm/bBpzC/gflNG7hdhwoPynbb9Cp5seP3secc2Hkt2W3rpbOuWk
 GEYhyi6yiX5RKQZxLEa8tSq0LZmGqBgr5zLTa9kRolyqc+WfLXcgz3EUbM0b74bPWdpde0IUT7L
 7tbKfUZLRPFYGAqZXJ0kejLTgbe7ToyAceIRQ20BXBipi4LxKoOT5b3C/XIAiwqKXd+X3eLQNBl
 hZ7wwwcO7JLRvQ0lk0OnAn+pRac0lmbFSL0qtooSzsnZm7p5cW8p6YhFn5IuKSjzbZjNw+sNE5a
 HBTjELdVRUTSxWO5WuTwhBwTv09D5wWm9gbzlyg56xPEdMHtyImOPjLA==
X-Google-Smtp-Source: AGHT+IEjG3RwBsP24SJX6TNgXjyPzMbRuA0LWS7Zs5AMcys9/AOCrXSOdRW/05B210gdYH/h4wYzvw==
X-Received: by 2002:a05:600c:3b2a:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-47d1953bd29mr32333965e9.8.1766167704306; 
 Fri, 19 Dec 2025 10:08:24 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa477bsm6313250f8f.36.2025.12.19.10.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 10:08:23 -0800 (PST)
Message-ID: <5efeb676-4e14-4586-b721-80a8d900adcd@linaro.org>
Date: Fri, 19 Dec 2025 19:08:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/24] configs/targets: Introduce
 TARGET_USE_LEGACY_NATIVE_ENDIAN_API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20251219161953.72724-1-philmd@linaro.org>
 <20251219161953.72724-17-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251219161953.72724-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 19/12/25 17:19, Philippe Mathieu-Daudé wrote:
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API is a definition that will
> let us gradually remove legacy APIs related to "native" endianness.
> 
> Set it to all our targets, taking care to not poison it.


Mechanical set it to all our targets running:

   $ for t in configs/targets/*.mak; do \
       echo TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y >> $t;
     done

then taking care manually to not poison it.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/aarch64-bsd-user.mak        | 1 +
>   configs/targets/aarch64-linux-user.mak      | 1 +
>   configs/targets/aarch64-softmmu.mak         | 1 +
>   configs/targets/aarch64_be-linux-user.mak   | 1 +
>   configs/targets/alpha-linux-user.mak        | 1 +
>   configs/targets/alpha-softmmu.mak           | 1 +
>   configs/targets/arm-bsd-user.mak            | 1 +
>   configs/targets/arm-linux-user.mak          | 1 +
>   configs/targets/arm-softmmu.mak             | 1 +
>   configs/targets/armeb-linux-user.mak        | 1 +
>   configs/targets/avr-softmmu.mak             | 1 +
>   configs/targets/hexagon-linux-user.mak      | 1 +
>   configs/targets/hppa-linux-user.mak         | 1 +
>   configs/targets/hppa-softmmu.mak            | 1 +
>   configs/targets/i386-bsd-user.mak           | 1 +
>   configs/targets/i386-linux-user.mak         | 1 +
>   configs/targets/i386-softmmu.mak            | 1 +
>   configs/targets/loongarch64-linux-user.mak  | 1 +
>   configs/targets/loongarch64-softmmu.mak     | 1 +
>   configs/targets/m68k-linux-user.mak         | 1 +
>   configs/targets/m68k-softmmu.mak            | 1 +
>   configs/targets/microblaze-linux-user.mak   | 1 +
>   configs/targets/microblaze-softmmu.mak      | 1 +
>   configs/targets/microblazeel-linux-user.mak | 1 +
>   configs/targets/microblazeel-softmmu.mak    | 1 +
>   configs/targets/mips-linux-user.mak         | 1 +
>   configs/targets/mips-softmmu.mak            | 1 +
>   configs/targets/mips64-linux-user.mak       | 1 +
>   configs/targets/mips64-softmmu.mak          | 1 +
>   configs/targets/mips64el-linux-user.mak     | 1 +
>   configs/targets/mips64el-softmmu.mak        | 1 +
>   configs/targets/mipsel-linux-user.mak       | 1 +
>   configs/targets/mipsel-softmmu.mak          | 1 +
>   configs/targets/mipsn32-linux-user.mak      | 1 +
>   configs/targets/mipsn32el-linux-user.mak    | 1 +
>   configs/targets/or1k-linux-user.mak         | 1 +
>   configs/targets/or1k-softmmu.mak            | 1 +
>   configs/targets/ppc-linux-user.mak          | 1 +
>   configs/targets/ppc-softmmu.mak             | 1 +
>   configs/targets/ppc64-linux-user.mak        | 1 +
>   configs/targets/ppc64-softmmu.mak           | 1 +
>   configs/targets/ppc64le-linux-user.mak      | 1 +
>   configs/targets/riscv32-linux-user.mak      | 1 +
>   configs/targets/riscv32-softmmu.mak         | 1 +
>   configs/targets/riscv64-bsd-user.mak        | 1 +
>   configs/targets/riscv64-linux-user.mak      | 1 +
>   configs/targets/riscv64-softmmu.mak         | 1 +
>   configs/targets/rx-softmmu.mak              | 1 +
>   configs/targets/s390x-linux-user.mak        | 1 +
>   configs/targets/s390x-softmmu.mak           | 1 +
>   configs/targets/sh4-linux-user.mak          | 1 +
>   configs/targets/sh4-softmmu.mak             | 1 +
>   configs/targets/sh4eb-linux-user.mak        | 1 +
>   configs/targets/sh4eb-softmmu.mak           | 1 +
>   configs/targets/sparc-linux-user.mak        | 1 +
>   configs/targets/sparc-softmmu.mak           | 1 +
>   configs/targets/sparc32plus-linux-user.mak  | 1 +
>   configs/targets/sparc64-linux-user.mak      | 1 +
>   configs/targets/sparc64-softmmu.mak         | 1 +
>   configs/targets/tricore-softmmu.mak         | 1 +
>   configs/targets/x86_64-bsd-user.mak         | 1 +
>   configs/targets/x86_64-linux-user.mak       | 1 +
>   configs/targets/x86_64-softmmu.mak          | 1 +
>   configs/targets/xtensa-linux-user.mak       | 1 +
>   configs/targets/xtensa-softmmu.mak          | 1 +
>   configs/targets/xtensaeb-linux-user.mak     | 1 +
>   configs/targets/xtensaeb-softmmu.mak        | 1 +
>   scripts/make-config-poison.sh               | 1 +
>   68 files changed, 68 insertions(+)


