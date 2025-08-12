Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89B7C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliEK-0004DZ-NH; Tue, 12 Aug 2025 02:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliEI-0004DA-Sg
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:11:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliE8-0003cR-Oe
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:11:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so34674535e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979071; x=1755583871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZxFXwyVAxGG1bnmMAUvDfFmztF63vJO613iY8PdoSU=;
 b=VFCaTLoZOaPkSTKiIGngkcPeLGyfaGIEK5M193BUObZhIUGv5zUkt5w5VbOmFL7cek
 FUO8RAikrNiRDZPQYNKl/KxTh20XsDQo5sLP/WWUCrh8nXmdeP8uPzkjPErqbpj20nN4
 5IbakqsOXjWHSHtINRIdOryXVNXpjhEekgv/askdWZKzf7Upm3w0Er1bQIzx/lVPC/K6
 gYaixHhZprZvQ2W0YpE/5bbx4J2NTXY1mbKmB6EjsTl8M4Rvk5dgREePEPnNX0gFevHN
 2/+d0anM+TR7tDaDJoeZIq+7dyncg5a9d6t45s/Tahy/ZdAOY4pdVRmQSem1RjxSIjNv
 EBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979071; x=1755583871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jZxFXwyVAxGG1bnmMAUvDfFmztF63vJO613iY8PdoSU=;
 b=I3mE19B54rpdDrYAFQTJNgFouI4w4dedwoL8svNTmifpXe2QZugkOKUlxsZ8P8v4TM
 L7TC+B3AUoeUAVj7BwHhqnnL1HQOsPzBwTm9YFcRkhnJveWoD+SVfQt4PS66hTbgqsFn
 OKU9mDbOrHIj6EMjYPZW4bBL5NmiF84oL1tv+vgWpE3Wvxat8CIvHoJVCYB4syGuWXuH
 ZQpO61VO4XjBSLVvI0YwVZgjvIcptxuD57UrzQCKUlYgP/Map0w10Xy78oC3B4sEBTr6
 2V0yUNAVeBtnmtwjdK99s/s+MhZw0gtdTbXpoL/BN+cusLp2ET7Z+WmUzP8s+7oGA6Kr
 bQdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnFz4iQQErtqRg3RuiZ1Cr5c5PcKzc4Deuzj/ufhT8d7uE0vw5DcYaDQ8aRAIghWLFRDvlurrGe7zx@nongnu.org
X-Gm-Message-State: AOJu0YzzcTUU08+HFoDCDnabAAa8TnIEt+J9Ii0D3gDmKrbjYGugJk/S
 cpjgAz08z7cINSxjpj8SrAXt5doR0b6xAHL4mWv0o4bBEu1N7OXeLU+jCZ4KK/B+zcc=
X-Gm-Gg: ASbGncuvU0x3gzb0fMDJSiaaY12XBTj7aFg3JeD4zooBOFZW3Ie8KhUPNY8YddC4PUc
 da/Osa43z7OyEMpTNKY039ZpVt89Xl3uOs6s3eLVLwhwL5CMax6u2lUCBH6Aq/6KPjJrqxDbkdy
 /+h3qaMlKYU+Wd/6vwSbkhpIW9ubGceKNFCf3LwS1jUKZ3MAp2GeMqdAC5Umnb9gnupoWtstWq2
 h0TJvseKiS9geJnTU3Lwea9WDQXzEtG9DGEk9zgLckaTTDXgpjswayBgDgar4WZOotPTrYON2RV
 TsN5Z6qpHyyqs8T2sAyRM0XE09kYjf2qnwoRqAGCgZLWASfw2DhXD7cIumRVGStoMx1Y0ty6YHA
 UdoBi1PeatP21EAVsw/xeAv3pfRljzt9yH4VaOD7q9SfeaVl4pzMW3scrwv1gVkhl6WfazHRdZC
 1h
X-Google-Smtp-Source: AGHT+IGfe4sc30IPzDEb4NhPDkNnFSGJss9O+bDu53mu/wcQGZhp8157yjM8U1HWHlYL3OPh9DlQnQ==
X-Received: by 2002:a05:600c:45cc:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-45a10b9bec7mr16601695e9.1.1754979071038; 
 Mon, 11 Aug 2025 23:11:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58542f3sm279837095e9.10.2025.08.11.23.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:11:10 -0700 (PDT)
Message-ID: <0a422178-d251-4d28-b355-c617b588d486@linaro.org>
Date: Tue, 12 Aug 2025 08:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 50/85] target/arm: Expand pstate to 64 bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-51-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/8/25 01:29, Richard Henderson wrote:
> The ARM now defines 36 bits in SPSR_ELx in aarch64 mode, so
> it's time to bite the bullet and extend PSTATE to match.
> 
> Most changes are straightforward, adjusting printf formats,
> changing local variable types.  More complex is migration,
> where to maintain backward compatibility a new pstate64
> record is introduced, and only when one of the extensions
> that sets bits 32-35 are active.
> 
> The fate of gdbstub is left undecided for the moment.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  8 +++---
>   target/arm/tcg/translate.h  | 20 ++++++-------
>   target/arm/cpu.c            |  6 ++--
>   target/arm/gdbstub64.c      |  1 +
>   target/arm/helper.c         | 11 ++++----
>   target/arm/machine.c        | 56 +++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/helper-a64.c |  2 +-
>   7 files changed, 81 insertions(+), 23 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 98360b70b8..7769c4ae3c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -268,7 +268,7 @@ typedef struct CPUArchState {
>       uint64_t xregs[32];
>       uint64_t pc;
>       /* PSTATE isn't an architectural register for ARMv8. However, it is
> -     * convenient for us to assemble the underlying state into a 32 bit format
> +     * convenient for us to assemble the underlying state into a 64 bit format
>        * identical to the architectural format used for the SPSR. (This is also
>        * what the Linux kernel's 'pstate' field in signal handlers and KVM's
>        * 'pstate' register are.) Of the PSTATE bits:
> @@ -280,7 +280,7 @@ typedef struct CPUArchState {
>        *  SM and ZA are kept in env->svcr
>        *  all other bits are stored in their correct places in env->pstate
>        */
> -    uint32_t pstate;
> +    uint64_t pstate;
>       bool aarch64; /* True if CPU is in aarch64 state; inverse of PSTATE.nRW */
>       bool thumb;   /* True if CPU is in thumb mode; cpsr[5] */


> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 64ee9b3b56..3cef47281a 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>       case 32:
>           return gdb_get_reg64(mem_buf, env->pc);
>       case 33:
> +        /* pstate is now a 64-bit value; can we simply adjust the xml? */

Please add a similar comment in aarch64_cpu_gdb_write_register(),
to not forget to update the returned value (4 -> 8) when XML gets
adjusted.

>           return gdb_get_reg32(mem_buf, pstate_read(env));
>       }
>       /* Unknown register.  */


