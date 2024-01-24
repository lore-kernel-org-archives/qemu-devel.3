Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED7AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdSr-0007nj-K0; Wed, 24 Jan 2024 08:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSdSq-0007na-Gw
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:38:48 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSdSo-0001u1-To
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:38:48 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dd7a44d51bso1557714b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706103525; x=1706708325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bp7f1hEOsiV7YtpZ9AGCbB4JxicM5nyS0Cu3Hyvk+k8=;
 b=E33MVfuK2kKL4buKEXt8mEHuWSy3ok2UOPrHpQ/Spf3zKHgG0+YWTrcyhOETZ5R5aA
 kb5aYqfNa6niDsm4gn9ixa5/JGV9NkDn+nqhXkBiiiVcvJPtvP30cZWFnx8pgok2SWTj
 lvFl0/XBptnmIU35hybTMVUKeGeL0DXeh9Q0yLIX5vJZYGB25kSo+P7O65Wk8uAccD0g
 rl7EHAag8Md/ScVb//6xeHPTAPI6PAddjRhtaMc48b2W4Zfx6gCgMNHfLTv90COzaNjz
 w4PVrEUPlTzcBNwZe2ZwmWh+NmCMQNt3niX8/bgFEvA8oEkDzfzJPE6dgCr1WAfMNnpP
 OBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706103525; x=1706708325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bp7f1hEOsiV7YtpZ9AGCbB4JxicM5nyS0Cu3Hyvk+k8=;
 b=BbEkyb7c4WoMPy7jrWcb8MLf2Og4tnYI+57kE0/QH11fM19Ng2wnCWg+VPqvtEgZCq
 W77cMPfuwQ0xbfS+PBB88Cj1UydGw3EnscTbeCY5ueclujZpuv2RK03JRJw22C4BKpD3
 oCwEh4cNAe+kdt50rLI/LAogwSYJhcsJ9ZW371Hi751iGXzxi1p8CrxiXUXuBeftOtKc
 F73RJOc6hRhfw/29Z43ee8jw8ILF3plcdfZFnkpZltRSUXuUhWciF7rujaGHL1gKfGsz
 DigRu/szdRqC6m7DvQD39i9EIptdioC4j7dQuOx4wS3AZzpkVD7Vts9Aba8eqpBWoH46
 xMxA==
X-Gm-Message-State: AOJu0YxkV49KueAtmwicppqcqIrXb0th/RZMHdNVX0B+FIdk9f39h4OU
 AZUgiEqS2xLFchu6vh6FC91Q4n9HD8hSbEF3rYaw0A122JLYWc/Hc3kw3+OoKfbxX4ebr1oozgK
 1
X-Google-Smtp-Source: AGHT+IHPp755/3BRCAM6G4MKGo6YlH1VtDNX3Nck4jJuySDP5i3KrVaz+HMCP9Y66UR46AQ2BY2Q9Q==
X-Received: by 2002:a05:6a00:1791:b0:6db:db71:f469 with SMTP id
 s17-20020a056a00179100b006dbdb71f469mr3824850pfg.53.1706103525274; 
 Wed, 24 Jan 2024 05:38:45 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.94])
 by smtp.gmail.com with ESMTPSA id
 fj2-20020a056a003a0200b006d98505dacasm13759390pfb.132.2024.01.24.05.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 05:38:44 -0800 (PST)
Message-ID: <78107c83-7035-414c-9a44-af5e234fd5c2@ventanamicro.com>
Date: Wed, 24 Jan 2024 10:38:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu riscv, thead c906, Linux boot regression
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/24/24 09:49, Björn Töpel wrote:
> Hi!
> 
> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
> ("target/riscv/cpu.c: restrict 'marchid' value")
> 
> Reverting that commit, or the hack below solves the boot issue:
> 
> --8<--
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781ad..e18596c8a55a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>       cpu->cfg.ext_xtheadsync = true;
>   
>       cpu->cfg.mvendorid = THEAD_VENDOR_ID;
> +    cpu->cfg.marchid = ((QEMU_VERSION_MAJOR << 16) |
> +                        (QEMU_VERSION_MINOR << 8)  |
> +                        (QEMU_VERSION_MICRO));
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>   #endif
> --8<--
> 
> I'm unsure what the correct qemu way of adding a default value is,
> or if c906 should have a proper marchid.

In case you need to set a 'marchid' different than zero for c906, this hack would
be a proper fix. As mentioned in the commit msg of the patch you mentioned:

"Named CPUs should set 'marchid' to a meaningful value instead, and generic
  CPUs can set to any valid value."

That means that any specific marchid value that the CPU uses must to be set
in its own cpu_init() function.


Thanks,

Daniel


> 
> Maybe Christoph or Zhiwei can answer?
> 
> qemu command-line:
> qemu-system-riscv64 -nodefaults -nographic -machine virt,acpi=off \
>     -cpu thead-c906 ...
> 
> 
> Thanks,
> Björn

