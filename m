Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DDAC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFHp-0005Ur-GE; Wed, 14 Feb 2024 08:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFHn-0005UX-Oz
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:26:51 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFHl-0005wh-7U
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:26:51 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso2987086b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707917207; x=1708522007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUH6yU1PblzidNSmOOdLIwRJdms6r64ppT3R6wX7CRQ=;
 b=HIxg7C5O4jxzAvVDhVBumSj7gtCG/0/Xn3RW0A2JambB7M+dW0LhWUPe6kQsyGZRPv
 IVMRNapq0TyKyXaMYRfc6z6StrjWE1JtzUPYlJ0y5Zmfz+Pe+Dbp6clQ/OOoPeUZYHT5
 q2TePtJE8zoAmnvKSgjoWnRzhcyH9J6XdobgboEsfgNQTPJGAjW0uEsw/CcPEOh6tMao
 VOkhMNmt+5xED4b4vyiHamj5u1wgTlUXX0kSsT6Ywd7hT+DVRAdfhkHWsBDJSCE9kpfp
 LVzQmYlHw+cVT3Wqm1AxYrr3NOyoDVyREBOFuDXIojfwCiJ9p6gz1uNyTdqwnu6xetAR
 C6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707917207; x=1708522007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JUH6yU1PblzidNSmOOdLIwRJdms6r64ppT3R6wX7CRQ=;
 b=YKBInOaxsnGfZwNiR+LKjYTt7fduvDZj+mL3X1T3Ud8gszhZ7/mbA/q6mkRiZUzU7W
 CwUXwFuxAmlLF7BQNhE1f20z54X7nh/46z2nWQ4iTdJ1u1sBRMV1vB+kmne+4zNELG5B
 q0X0/uZ6joKeYRGAlYxv3vCP3eYCwGym9md//L2SFrWjyhbWWiGRxXa7OpaHTpDXKlOz
 M8NjhYmjirpieJtSyt/C7337yW0OSLSOevH1hFn613dYIwzHk6+wHCCi4tUNUCwEo6a/
 mqfd+X5RgoCnJ1l5CJ0XeTbWXT+ky1lcnLooxJIsm4Dj+U/fmbB6ArkWv9clSEQ5Pc1o
 Gpng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSbNP63CzV+tcUrUP+Rj0roLX/0Sv6rv/9NcNLOEHAFQf0Rt0rKdg5P26wQbssg8jOCIoTMFMcY6swoplk+W2zaIiSFxg=
X-Gm-Message-State: AOJu0Yyj0pu5p7sawXIRiodCP+OgkotC8AxQ9YnlgnYW1CQBAP2MNjHx
 GP6iQFKbWhtCRWrPDORZ4lvCNG6tI4W82NB/2NzZVij3EDRO66an4eez+lhiE+Q=
X-Google-Smtp-Source: AGHT+IF7VpCjZ32uM3BKyzgFc4NxZ5X3kWFTqIqT6tYma2KquLsj84lsagq8gCG3Z7zjz5Jjo/Ixvg==
X-Received: by 2002:a05:6a20:c907:b0:19e:b192:1daf with SMTP id
 gx7-20020a056a20c90700b0019eb1921dafmr3689415pzb.56.1707917207423; 
 Wed, 14 Feb 2024 05:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWKQra75WAGOAkGrlN+a1Fj5tdaMS3L9H07Py770YkMRUzZlgbqdLJm50Wz/HtHWRy0ejQiniKpoiyw/C3uMZUgD1oC3nLrESY/hyKmvXghoX7t2+GCgaP1VjSyiGkL3d8Bt4FAl7uap8KO4DZj97nlCfMCi8cfuW+WKumoCtL1AMcRK9HA8EI7Iz//Izi/ANDPIiZNlOf16AMTjavv73vTPqremfz0kUVNhRcM7ISI9QDtO1pqwZWAEz7Aed6etYvae6uWITyO5N1P/TbURlnUfN52K4QapZOIj707os7RpqrzCs6nDs1/UoiOI/Du03V63ks=
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a056a00099000b006e054704c7dsm1388142pfg.123.2024.02.14.05.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 05:26:46 -0800 (PST)
Message-ID: <f1843cb3-2faf-4a21-b484-5e6b836bd974@ventanamicro.com>
Date: Wed, 14 Feb 2024 10:26:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/riscv: Add Zicboz extensions to hwprobe
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240207115926.887816-1-christoph.muellner@vrull.eu>
 <20240207115926.887816-2-christoph.muellner@vrull.eu>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240207115926.887816-2-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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



On 2/7/24 08:59, Christoph Müllner wrote:
> Upstream Linux recently added RISC-V Zicboz support to the hwprobe API.
> This patch introduces this for QEMU's user space emulator.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   linux-user/syscall.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e14248..43467c9707 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8799,6 +8799,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
>   #define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
>   #define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
>   #define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
> +#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
>   
>   #define RISCV_HWPROBE_KEY_CPUPERF_0     5
>   #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> @@ -8857,6 +8858,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
>                        RISCV_HWPROBE_EXT_ZBB : 0;
>               value |= cfg->ext_zbs ?
>                        RISCV_HWPROBE_EXT_ZBS : 0;
> +            value |= cfg->ext_zicboz ?
> +                     RISCV_HWPROBE_EXT_ZICBOZ : 0;
>               __put_user(value, &pair->value);
>               break;
>           case RISCV_HWPROBE_KEY_CPUPERF_0:

