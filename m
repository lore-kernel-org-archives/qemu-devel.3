Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E95C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukj7A-0008My-LR; Sat, 09 Aug 2025 08:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj79-0008MB-0P
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:55:59 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj76-0007yI-4N
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:55:58 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b34a8f69862so2232063a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754744154; x=1755348954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aXpr3YmqWZKgmVwTMQwWfV4vs26Ee/x8lSiUKi74H1I=;
 b=WE/5tSV5K+v1aVVrb3lLOJUESJtlSR57hixrxqrLjZBBHW8v8YhkTQNub9vqvHb8xr
 PBI2TqzbTBDMUg4CBuFn5WknbwzLEDrjdK/HN0a+I/Tq4HKkpQHKLkMy1dMLmsqQPEMv
 /PPkEMJ2jMnSJoD1kdm79AsgPUoBT7LYUN+4x2vYdOFxg+mUb8WY/Pyxk5dVvYe89Wv9
 x6QK/eqE2LVuu/aiewHZh2xjgGcOJijTWm0uVkZmGyUEwS1Q1JFDMFYpEn0R/Rjy1I+L
 1yD43G5TqGQGF6BckUoenSNZzXv6GLSFWh0EkdqjSj2EXSfa09Tw0tR4G4kKwgAirUCu
 ousA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754744154; x=1755348954;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXpr3YmqWZKgmVwTMQwWfV4vs26Ee/x8lSiUKi74H1I=;
 b=OshLJKJROJeCVLRvSmmIhrAiEOK6LHqjdLt41O8foriS+hVeMMsb4ptD+veWGHVK3J
 KIJs4JgUsWdeOgYOsP9haCHytnt18fPawnRbAo5MC6G2wrLLMitzrIHJhBAF8VC0iNNy
 yWd6cuklvZBTXsrItJweU9L9XzpX3agFV23K+mDe8ymcW5s6A16x1lEi1Xgt0buvj2bL
 YqHKKbbsuk+5BSadZ45Q8pIAqy9ddhM18rpy+QoqoXRJ0+plmAKwOz+Vh1xlpM086icu
 /MfcIisHC6Z9VpunuxDD47oT7QVPW1SV+Iq5nPcU4w4TLv+eMpgzuRiIXjrzZJUBAw1X
 g8xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi7IGZW7cnQ7R5OWUuwIg93R+kKpMmHiaB0z383tM+Dlh/NNIqKJjSBlXJ2mf/o2H58rQmlm9KH0qy@nongnu.org
X-Gm-Message-State: AOJu0YyHvtv2Np5FmdPzhBcK47W1oj4pIOD4n5Ri2wsfvU0UcRAPj9NL
 F/wbyIol5wtPENCIROfo9t090Ow895Rdeb03X0p5DzjP70PGfPNEqxW8cB41QqF8Zw+35LSpKTb
 wi8LG
X-Gm-Gg: ASbGncsoYddpnjhr+Xt0cgiE06LI3kZhcX1QK79mmT+GxA8+nhC4QUygRrukXJz65Rw
 Ej888QgHn6ofwX9CqxzuA+il7oTewLKFCBJpIHU3SS4Y63I65ddaFTOAmbQHE4k4vJSifg8zgTY
 TdA5yGbG5pDwf8HWdi3x+Q1QEkeMHnR7xNacKWCeFKcVwQgyirUp1wjhCp00NCt/Ps1NfuiVaCJ
 NGGOmv3AnMvzXSbb265UYUE3k34VfIEGCeRFd2u4oilHr+C10tNzT9mE5OgC/4erINSfxZ/oCtE
 03/PZ5XdQMuzjiaI+aNOd5EXyccCeGuybFCwl2ST53TAERzxvczjWlN4B4u0b/4nGlpROvkbbPK
 MBevi9FQDSjPa8miE3FYhIk2m2cIkSGCiwFBq6Q==
X-Google-Smtp-Source: AGHT+IEOTIjWhQeTJnUg80Y3ylWREy9Cd6s4IeNePbbcDja2BYcXpV6hpSZ7r37E4MsJpc6SGlWF2A==
X-Received: by 2002:a17:903:ac7:b0:240:3e40:43b0 with SMTP id
 d9443c01a7336-242c2225db1mr91147875ad.43.1754744154538; 
 Sat, 09 Aug 2025 05:55:54 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm230016845ad.40.2025.08.09.05.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:55:54 -0700 (PDT)
Message-ID: <6d8bcbd3-7855-4307-8edd-c6835c232124@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:55:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] target/riscv: Expose CPU options of WorldGuard
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-13-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-13-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> Expose WG CPU extensions (Smwg, Sswg, Smwgd) and WG CPU configs
> (mwid, mwidlist).
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1aba6dd853..46df970fe3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1742,6 +1742,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>   
> +    /* RISC-V WorldGuard v0.4 */
> +    MULTI_EXT_CFG_BOOL("x-smwg", ext_smwg, false),
> +    MULTI_EXT_CFG_BOOL("x-smwgd", ext_smwgd, false),
> +    MULTI_EXT_CFG_BOOL("x-sswg", ext_sswg, false),
> +
>       { },
>   };
>   
> @@ -2975,6 +2980,9 @@ static const Property riscv_cpu_properties[] = {
>        * it with -x and default to 'false'.
>        */
>       DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
> +
> +    DEFINE_PROP_UINT32("x-mwid", RISCVCPU, cfg.mwid, UINT32_MAX),
> +    DEFINE_PROP_UINT32("x-mwidlist", RISCVCPU, cfg.mwidlist, UINT32_MAX),
>   };
>   
>   #if defined(TARGET_RISCV64)


