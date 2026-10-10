Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B837BCA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQf0-0005NF-SJ; Sat, 10 Oct 2026 02:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xFQew-0005Mo-MO; Sat, 10 Oct 2026 02:34:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xFQet-0006Rn-Hj; Sat, 10 Oct 2026 02:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1791614032; bh=2dIUyWwesfKs49Sd71nzdsgLUr5/sg/97GzkxdspwX4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WNNerQ3A6vZHFuhV/wTm51rf4fl34CuZs4u88uEM+apKKFzRYad7y3VbE65xW+ClE
 haJqQ8vIVJ7GUhg8XNykBIGL/XujcxSGjjP3LAUmJlM31AQAQ14Qj7wCeiMqqmHQJD
 P/h6+DQsOTKo54g39PhBehm2BZYT7MEOXvBtIv/GIbYh1KbTivJXMBzu2F8+BT5Q5h
 0iNy3g+5mTatlLp80wx+HYYUWk2BkDNk7cVv/r62zvBJ2VUWDU9XjZK4jLVl+zimCs
 JncPi8NaagKiCAgTjKzQR2JSPQsG0ZBZud8DReB/ER4o5+d2C+J5yfzMhr1JU9s4St
 7ME5Npen2M66w==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 5AC4F1DC590;
 Sat, 10 Oct 2026 09:33:51 +0300 (MSK)
Message-ID: <311ad69d-a4b7-473f-b556-99a24fcf098c@tls.msk.ru>
Date: Sat, 10 Oct 2026 09:33:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/32] target/i386 and misc changes for 2026-09-28
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuxuan Li <liyuxuan.darfux@bytedance.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artemii Mashanov <ralerrdirsardx@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Andrey Polivoda <apolivodaa433@gmail.com>,
 Jordy Zomer <jordyzomer@google.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261009122832.348427-1-pbonzini@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsFNBGYpLkcBEACsajkUXU2lngbm6RyZuCljo19q/XjZTMikctzMoJnBGVSmFV66kylUghxs
 HDQQF2YZJbnhSVt/mP6+V7gG6MKR5gYXYxLmypgu2lJdqelrtGf1XtMrobG6kuKFiD8OqV6l
 2M5iyOZT3ydIFOUX0WB/B9Lz9WcQ6zYO9Ohm92tiWWORCqhAnwZy4ua/nMZW3RgO7bM6GZKt
 /SFIorK9rVqzv40D6KNnSyeWfqf4WN3EvEOozMfWrXbEqA7kvd6ShjJoe1FzCEQ71Fj9dQHL
 DZG+44QXvN650DqEtQ4RW9ozFk3Du9u8lbrXC5cqaCIO4dx4E3zxIddqf6xFfu4Oa5cotCM6
 /4dgxDoF9udvmC36qYta+zuDsnAXrYSrut5RBb0moez/AR8HD/cs/dS360CLMrl67dpmA+XD
 7KKF+6g0RH46CD4cbj9c2egfoBOc+N5XYyr+6ejzeZNf40yjMZ9SFLrcWp4yQ7cpLsSz08lk
 a0RBKTpNWJdblviPQaLW5gair3tyJR+J1ER1UWRmKErm+Uq0VgLDBDQoFd9eqfJjCwuWZECp
 z2JUO+zBuGoKDzrDIZH2ErdcPx3oSlVC2VYOk6H4cH1CWr9Ri8i91ClivRAyVTbs67ha295B
 y4XnxIVaZU+jJzNgLvrXrkI1fTg4FJSQfN4W5BLCxT4sq8BDtwARAQABzSBNaWNoYWVsIFRv
 a2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLBlAQTAQoAPhYhBJ2L4U4/Kp3XkZko8WGtPZjs3yyO
 BQJmKS5HAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGGtPZjs3yyOZSAP
 /ibilK1gbHqEI2zR2J59Dc0tjtbByVmQ8IMh0SYU3j1jeUoku2UCgdnGKpwvLXtwZINgdl6Q
 cEaDBRX6drHLJFAi/sdgwVgdnDxaWVJO/ZIN/uJI0Tx7+FSAk8CWSa4IWUOzPNmtrDfb4z6v
 G36rppY8bTNKbX6nWFXuv2LXQr7g6+kKnbwv4QFpD+UFF1CrLm3byMq4ikdBXpZx030qBL61
 b7PrfXcBLao0357kWGH6C2Zu4wBnDUJwGi68pI5rzSRAFyAQsE89sjLdR1yFoBH8NiFnAQXP
 LA8Am9FMsC7D/bi/kwKTJdcZvzdGU1HG6tJvXLWC+nqGpJNBzRdDpjqtxNuL76vVd/JbsFMS
 JchLN+01fNQ5FHglvkd6md7vO+ULq+r9An5hMiDoRbYVUOBN8uiYNk+qKbdgSfbhsgPURqHi
 1bXkgMeMasqWbGMe7iBW/YH2ePfZ6HuKLNQDCkiWZYPQZvyXHvQHjuJJ5+US81tkqM+Q6Snq
 0L/O/LD0qLlbinHrcx0abg06VXBoYmGICJpf/3hhWQM4f+B/5w4vpl8q0B6Osz01pBUBfYak
 CiYCNHMWWVZkW9ZnY7FWiiPOu8iE1s5oPYqBljk3FNUk04SDKMF5TxL87I2nMBnVnvp0ZAuY
 k9ojiLqlhaKnZ1+zwmwmPmXzFSwlyMczPUMSzsFNBGYpLkcBEAC0mxV2j5M1x7GiXqxNVyWy
 OnlWqJkbkoyMlWFSErf+RUYlC9qVGwUihgsgEhQMg0nJiSISmU3vsNEx5j0T13pTEyWXWBdS
 XtZpNEW1lZ2DptoGg+6unpvxd2wn+dqzJqlpr4AY3vc95q4Za/NptWtSCsyJebZ7DxCCkzET
 tzbbnCjW1souCETrMy+G916w1gJkz4V1jLlRMEEoJHLrr1XKDdJRk/34AqXPKOzILlWRFK6s
 zOWa80/FNQV5cvjc2eN1HsTMFY5hjG3zOZb60WqwTisJwArjQbWKF49NLHp/6MpiSXIxF/FU
 jcVYrEk9sKHN+pERnLqIjHA8023whDWvJide7f1V9lrVcFt0zRIhZOp0IAE86E3stSJhZRhY
 xyIAx4dpDrw7EURLOhu+IXLeEJbtW89tp2Ydm7TVAt5iqBubpHpGTWV7hwPRQX2w2MBq1hCn
 K5Xx79omukJisbLqG5xUCR1RZBUfBlYnArssIZSOpdJ9wWMK+fl5gn54cs+yziUYU3Tgk0fJ
 t0DzQsgfd2JkxOEzJACjJWti2Gh3szmdgdoPEJH1Og7KeqbOu2mVCJm+2PrNlzCybOZuHOV5
 +vSarkb69qg9nU+4ZGX1m+EFLDqVUt1g0SjY6QmM5yjGBA46G3dwTEV0/u5Wh7idNT0mRg8R
 eP/62iTL55AM6QARAQABwsF8BBgBCgAmFiEEnYvhTj8qndeRmSjxYa09mOzfLI4FAmYpLkcC
 GwwFCRLMAwAACgkQYa09mOzfLI53ag/+ITb3WW9iqvbjDueV1ZHwUXYvebUEyQV7BFofaJbJ
 Sr7ek46iYdV4Jdosvq1FW+mzuzrhT+QzadEfYmLKrQV4EK7oYTyQ5hcch55eX00o+hyBHqM2
 RR/B5HGLYsuyQNv7a08dAUmmi9eAktQ29IfJi+2Y+S1okAEkWFxCUs4EE8YinCrVergB/MG5
 S7lN3XxITIaW00faKbqGtNqij3vNxua7UenN8NHNXTkrCgA+65clqYI3MGwpqkPnXIpTLGl+
 wBI5S540sIjhgrmWB0trjtUNxe9QcTGHoHtLeGX9QV5KgzNKoUNZsyqh++CPXHyvcN3OFJXm
 VUNRs/O3/b1capLdrVu+LPd6Zi7KAyWUqByPkK18+kwNUZvGsAt8WuVQF5telJ6TutfO8xqT
 FUzuTAHE+IaRU8DEnBpqv0LJ4wqqQ2MeEtodT1icXQ/5EDtM7OTH231lJCR5JxXOnWPuG6el
 YPkzzso6HT7rlapB5nulYmplJZSZ4RmE1ATZKf+wUPocDu6N10LtBNbwHWTT5NLtxNJAJAvl
 ojis6H1kRWZE/n5buyPY2NYeyWfjjrerOYt3er55n4C1I88RSCTGeejVmXWuo65QD2epvzE6
 3GgKngeVm7shlp7+d3D3+fAAHTvulQQqV3jOodz+B4yzuZ7WljkNrmrWrH8aI4uA98c=
In-Reply-To: <20261009122832.348427-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 09.10.2026 15:28, Paolo Bonzini wrote:
> The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
> j
>    Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e:
> 
>    agents: Add a skill for finding your way around QEMU (2026-10-02 11:11:37 +0200)
> 
> v1->v2: move validate_vex() before all operand decoding (patches 6-8)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
> * target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
> * target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
> * target/i386/tcg: implement APX
> * target/i386: Migrate error code only with an exception
> * agents: Add a skill for finding your way around QEMU
> * tdx: fix buffer overflow in tdx_parse_panic_message
> * accel/kvm: fixes
> 
> ----------------------------------------------------------------
> 
> Artemii Mashanov (1):
>        target/i386: fix EFLAGS reads in TCG plugin callbacks
...> Maxim Levitsky (3):
>        system: fix buffer overflow in tdx_parse_panic_message
>        accel/kvm: protect kvm_resample_fd_list with a mutex
>        accel/kvm: coalesced mmio: check lenght of the MMIO write entry
> 
> Paolo Bonzini (25):
>        target/i386/tcg: compute C of CC_OP_ADOX without going through helper
>        target/i386/tcg: extract validate_cr0_exceptions()
>        target/i386/tcg: move validate_vex() before all operand decoding
>        target/i386/tcg: clarify return value of decode_insn
>        target/i386/tcg: ignore VEX.L for unary scalar instructions
>        target/i386/tcg: JO/JNO can use flags directly if it is in CC_SRC
>        target/i386/tcg: generalize zero- and sign-extension
>        target/i386/tcg: use standard operand order for BSF and BSR
>        target/i386/tcg: use zextT1 for CMPXCHG
>        target/i386/tcg: unify MOVBE and BSWAP generators
>        target/i386/tcg: add APX support to XSAVE/XRSTOR
>        target/i386/tcg: add definition for REX2 prefix
>        target/i386/tcg: mark XSAVE* as not allowing REX2
>        target/i386/tcg: treat 0x0F as a prefix
>        target/i386/tcg: decode REX2 prefix
>        target/i386/tcg: implement JMPABS instruction
>        target/i386/tcg: extend VEX.vvvv parsing for APX
>        target/i386/tcg: decode EVEX prefix
>        target/i386/tcg: add decode functionality for APX
>        target/i386/tcg: implement CCMP/CTEST
>        target/i386/tcg: decode APX instructions
>        target/i386/tcg: optimize CCMP
>        target/i386: extract computation of no-autoenable features
>        target/i386/tcg: mark APX as supported
>        agents: Add a skill for finding your way around QEMU
...
 From this list, what should or should not be picked up for the stable
series?  Only one or two patches were Cc'ed to qemu-stable@ (which I
removed from this list), but it feels like most of this pull request
should be picked up.

  target/i386: fix EFLAGS reads in TCG plugin callbacks ?

  system: fix buffer overflow in tdx_parse_panic_message - I picked this
    up for 11.1.x

  accel/kvm: protect kvm_resample_fd_list with a mutex -- I picked it too

  accel/kvm: coalesced mmio: check lenght of the MMIO write entry -- ?

Most changes by Paolo? If yes, which ones?

Thanks,

/mjt

