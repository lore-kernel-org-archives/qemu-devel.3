Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F15BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 03:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXTk-0005Ci-Go; Tue, 06 Aug 2024 23:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXTi-00058k-0w
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:36:46 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXTf-0002FU-Qr
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:36:45 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db130a872fso820865b6e.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723001802; x=1723606602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+SZCs0XEvsOMpS0To+td3p7mOHbavCqm6//01A4JcTo=;
 b=NkLA0tE4Qm973f9yXjQxsvS8nVBX2PRoApFNey4nfMeiU+BDH+UuEJMMkiSTXIgIkQ
 w7nQ1/dvYVS0jlnlMYRjTNU4SLeTmLSmyRluehQVaGmVxnIxqDikwbdjo6Mlpc++EsG5
 Oedb0FYhRB7Z4ohdH275Eu82syfRrMg+EkRB/WQPb6O7vHOQhMukF9IwqJd36nbnIvkS
 M75Nk5P58dyWMlXmwDxuRwld8ctoUFBcl7EH8O6uLImHfdcgeVcP5BJMoU0RqbASdCiF
 rogaSSA44UmEq22viQU/MO+k2xA5YHiUbvcYPYuBf3Piq3BPEGZplVyoSx9ki077vDWG
 eNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723001802; x=1723606602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+SZCs0XEvsOMpS0To+td3p7mOHbavCqm6//01A4JcTo=;
 b=D0MrSQfXuHvaZV300tHR7kUS89OrwX+KBOoZfgv49QMT5/rJ0McXC1N556m0/NIwHa
 0ffgNyuJo5vMCZLSu/6x6m/reqyRJWFAQz2Zz55kRO6iRCTVXYTQaHMuGLwuLzp7dKqB
 Bcl4M7Yjh15uV8w9ftGmP9+JFWlqLuQ0AIGQi68GIjEBGyytYJ/u6vr8cCA5kTFqU0h/
 k17n1SXhqS4JwlSUOZmIfi73soZjmuR5MtbxHiNNHIDD40V0gUgNo5kAxO8jtv/Ybr4i
 uaIf/kNLL4/gDBMsZDquP/gmx+mnqPoZCZ4EjfQ8NxwE8JYnSVgsjKi7T/o2z9SNburn
 DFCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkApsFQALxr1DO+hZiij++jXkCxTBd6DsoWf4cz9Rn8yTvzK528Xa/AghmptaYtuMbKIl4gRIXXSUXu8f45rQED/Zo8hk=
X-Gm-Message-State: AOJu0Yww2wSyESMLlPhT1QuRf6xYZkA9p41qeFRdoy8+Sk+gbiuy+1i9
 uz84USCzYPkFo/WUxicXEUvI+miHyMm3dU8B9dyxvmVFqx4fz/nkL1feBhqUfkg=
X-Google-Smtp-Source: AGHT+IGQZLs+LrDstS/p0cqS9H2jO3WCL5j6JdDIWt8WiPg4pSWu2WespaddvMLxC1b4+Prcb/cYew==
X-Received: by 2002:a05:6808:4402:b0:3dc:2878:c2d with SMTP id
 5614622812f47-3dc287812d6mr5881482b6e.47.1723001802080; 
 Tue, 06 Aug 2024 20:36:42 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9f8d2sm7671022a12.9.2024.08.06.20.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:36:41 -0700 (PDT)
Message-ID: <7bf932f1-661b-4854-b26a-954dff70ba48@linaro.org>
Date: Wed, 7 Aug 2024 13:36:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] linux-user: permit RISC-V CFI dynamic entry in
 VDSO
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-20-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-20-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> RISC-V CFI use new processor-specific dynamic entry in ELF. Permit it in
> VDSO post-processing script.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   linux-user/gen-vdso-elfn.c.inc | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
> index 95856eb839..59c818eb11 100644
> --- a/linux-user/gen-vdso-elfn.c.inc
> +++ b/linux-user/gen-vdso-elfn.c.inc
> @@ -273,6 +273,13 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
>                   errors++;
>                   break;
>   
> +            case PT_LOPROC + 2:
> +                /* RISCV_ZICFILP_PLT: for RISC-V zicfilp extension */
> +                if (ehdr->e_machine == EM_RISCV) {
> +                    break;
> +                }
> +                goto do_default;

Documentation?  This symbol does not appear in either llvm or binutils sources.  I presume 
this is on a development branch somewhere.

The comment is poor.  Notice:

>               case PT_LOPROC + 3:
>                   if (ehdr->e_machine == EM_PPC64) {
>                       break;  /* DT_PPC64_OPT: integer bitmask */

the ppc64 comment describes the data payload.
As do the other comments beforehand.


r~

