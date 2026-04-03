Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE6E88D68
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m8m-0005Sw-KH; Fri, 03 Apr 2026 17:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m8k-0005Sf-V8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:33:18 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m8j-0004xA-Cm
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:33:18 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d932cc948so1361530a91.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251996; x=1775856796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCfX4nMFfJpmH6h38T33fQotCzlDAApsW7fmoOhPgp0=;
 b=Fcp8o3zX1qDGogaqedvISsoshiOxjrJPpmHqnbPbGWVx4p0P29GLUnYdXNGd9/YpL4
 0WAjva2kn5pBEdmsW2JjjBN2F7F/cBXzkPgbwB+/F6KfCDslIb1Tvxaprt0g6tzVtrmQ
 jxpqOH0bHPFXZw8veG2dzmycSYG4JkfaosvLd2oJE2r82wPTXbpnxtcQlggOfQZF1EvN
 486RnVsdZolcU61yFAN2yWlel4pHWUTY/LXoWaKP5MoCzmjWeTYQJcRyB1zSe8IrsO/g
 q3mxYMclyMdtmBg5n8lKZhNzFyInRk9JmAA4r8+uwe3l/aP8EkZf4YMhLdr8ZBmNHr6r
 nu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251996; x=1775856796;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCfX4nMFfJpmH6h38T33fQotCzlDAApsW7fmoOhPgp0=;
 b=X+gw+p5bCSt0kYjmpBjWdNnqRtCOKu1l8RyKbb7JWe2if+9FLNjNDgMOWMJjpkB4kS
 zgtFaO25OZdGF3rOQIj1ge4pk8mBg60T1j4ScihiSn1WDF2VZ4VwBSxgVKoaMznsomyR
 aIrwQQhPza4wI/IASgP34Y/riihQ1Bm71mzOhAjoe+JOTJlwtHAdGo6kqAMPT069e6zK
 kTQyJ6dpRCpSplnPJi/fbkCzj9Fnep7gLFolvNkN0W0dVD7iEx7rTJyUZx8ra7XlHaWj
 68k1P3cVSq/tWG5N0QuvVQelc8Smz8IE5pftCyuNYUq2swVSsgn0HB3v04DTfnlrFdgo
 ekCg==
X-Gm-Message-State: AOJu0YzZY+L6u4wVN3lETU1tHyUgt6bpD899zVyoQWjqey/PjiO8oJuY
 G8lZf392u4XuCPXBvxSp1xVmSvXmh4KhOzn2pGdwITwsGigLDvK5kSwYfZajLDOtNg+aGrKKXsE
 VAj4KuOk=
X-Gm-Gg: ATEYQzzmhJVRbNywkIc3J6qJJjkrYnsCaXmAQaOd//A1Ex0o4YeHBBexqVvtJ3XlSFz
 2ZIKG9lP433Ax0brsTydsfG/b0ImrmYa3bzw/SzpB2Ul4SROOgnYYWBzTXgiMEXQs/6eTFNvM+A
 +mkQImlGW1vmXYb5nnkYV3/GKUwmig3iXuOdvLPgDxwR3Eb1HEKKlAsmoQpzNv0q04M7+V7jEwA
 6B2SU31Z/O/65mOcmoH4uJXgog1ZJLUNad2IgkhhY8wGWPtUh9PUYBpUh/Zu1Z/5cgx66joj84d
 IsWv+FtH72l3sNaO8ARWBphIEpPYpbr3YOLDGS0JzkgFT7ATfIJRqeMbg7MUuH0IEY29mmsvvxV
 tkVU1vmiwdpnI9CMPClz6ZRNbryAmM5WFBlypc0IRILGOcbEXYbkTgLHRQazDhBQrIqKDKawx/b
 ZaBDAuJJT6L3rizoUq5H53wk1gYNm6M9gd196kO9z1F74Q3RNIq3lqEb3CpKMzxa5vJ3NbBsm/y
 T/a+Q==
X-Received: by 2002:a05:6a20:3d05:b0:39b:f12e:d53 with SMTP id
 adf61e73a8af0-39f2ed8d756mr4174720637.18.1775251995752; 
 Fri, 03 Apr 2026 14:33:15 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6492097sm5948426a12.10.2026.04.03.14.33.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:33:15 -0700 (PDT)
Message-ID: <a5396bd2-78dc-4217-9ec6-b7c18f03d70b@linaro.org>
Date: Sat, 4 Apr 2026 07:33:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 6/8] target/arm: Compile HVF as common object
To: qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> Neither of hvf.c nor hyp_gdbstub.c use target-specific code.
> Move them from arm_system_ss[] to arm_common_system_ss[] to
> compile them once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/meson.build | 2 +-
>   target/arm/meson.build     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/hvf/meson.build b/target/arm/hvf/meson.build
> index afc509a470e..ccb0d338af6 100644
> --- a/target/arm/hvf/meson.build
> +++ b/target/arm/hvf/meson.build
> @@ -1,3 +1,3 @@
> -arm_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
> +arm_common_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
>     'hvf.c',
>   ))
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 6e0e504a403..f14debc6a2f 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -20,7 +20,6 @@ arm_common_system_ss.add(files(
>     'arm-qmp-cmds.c',
>   ))
>   arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> -arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>   
>   arm_user_ss.add(files('cpu.c'))
>   arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
> @@ -41,6 +40,7 @@ arm_common_system_ss.add(files('cpu.c'))
>   arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
>     'cpu32-stubs.c'))
>   arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
> +arm_common_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>   arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
>   		                 if_true: files('common-semi-target.c'))
>   arm_common_system_ss.add(files(


