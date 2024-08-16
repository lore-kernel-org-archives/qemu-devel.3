Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632E1C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sen8j-00080i-50; Thu, 15 Aug 2024 22:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sen8h-0007xx-Nk
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:56:31 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sen8g-0001p0-2h
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:56:31 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-260f81f7fb5so1061880fac.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723776984; x=1724381784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04pOJ2UsJisADRa7BQqXQkAlTitSXJvGuEX6eX5vFYg=;
 b=tEzVRCWhK470SzOTXYy3ylgMvNmPJFPpz69wMTWnAOSPINe+XJXNK9Htxg/OaZwX/i
 BdcdZBLEAQUAjkQnOTnccN+E+yBjhOZJ84IwiQzrsCoNSRZnHIcbRVA9G3vp/6ohqoeK
 WhJR6Jlvn0nGAhWLG3yPV0xK/BEkT7rROnUyBuYH6vP5NAqC6Db72tZlsWO7zNGmQOaG
 wTJ09pIFrt9nDIymvCS3O6o01JxtGPUuc7PPeu220wXKeNOU9wzSXfXDJep7CxJuQ2jV
 mXq1NVQ0GBF4U7axYRp2iAEXesH1S3iEmhyiD/DSNNKxAciiHWFj+eTZNDjuGqgqb9U6
 vewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723776984; x=1724381784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04pOJ2UsJisADRa7BQqXQkAlTitSXJvGuEX6eX5vFYg=;
 b=J7S2OH5hN97fYmTXsxzrr9SOnpYOW3sY3L34L+hCp7OG2WAkU1SG87qsIuyTHD9th8
 gjtY7GA+/XyfmKEg5vQhkrBMxyS1M7YNemW+o1YKUizniEbrAOgGyyIf+f+fbVtidZvw
 8tVSAiV6qfcXvx9Qm6Gb2N9R+ZCwp0kr9RPYY/WFIIJE+iNMO5UK9DnDAqR5koboktyb
 5fcS8aUi0PI1wFSlhcAK0syAra1aP2l0iBmLPGiWei/QlUHb+lr+udhdJgVOF5nBG00b
 Q9XIUiz6kriZYe0YBadTAIKGi4v/3cTJByopZpw23ciZ0pwy6uAbTZ9zwCYXjE5Em5we
 x2LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh70aAPvAIB3mq8GteOhDuqcyt1Ymz3KbRxKhSvxt8JD1C3VsqQ/uGdpNpS8bEYKXiE+3f+3vcc157Zs5JSQWbqxE5qjs=
X-Gm-Message-State: AOJu0YwV4JZiJdjus+cNdCEaB2pcJi2jl3N3KZURZoiH1/Rq47IPFhA8
 V9BB9DgTL0LoUFpEoA+4EQXJKjVXxHgdcmax4Ywx3H8/u0utpz+LCGAKyjkdAys=
X-Google-Smtp-Source: AGHT+IHAX3150+RfprYIVtyKre7zZUFYCI4hTfEJqrdjQfkRARowd68/2+tnqsn+hBkpwnz0lGTUdw==
X-Received: by 2002:a05:6870:7f05:b0:25e:24d5:4d54 with SMTP id
 586e51a60fabf-2701c5a1974mr1731745fac.35.1723776983779; 
 Thu, 15 Aug 2024 19:56:23 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:d09c:46ba:97a2:4a99?
 (2403-580a-f89b-0-d09c-46ba-97a2-4a99.ip6.aussiebb.net.
 [2403:580a:f89b:0:d09c:46ba:97a2:4a99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1999fsm1688425b3a.169.2024.08.15.19.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:56:23 -0700 (PDT)
Message-ID: <3e23b4a1-d05a-4189-aaf2-3ee75b154945@linaro.org>
Date: Fri, 16 Aug 2024 12:56:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] target/riscv: Introduce elp state and enabling
 controls for zicfilp
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-3-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-3-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 8/16/24 11:06, Deepak Gupta wrote:
> zicfilp introduces a new state elp ("expected landing pad") in cpu.
> During normal execution, elp is idle (NO_LP_EXPECTED) i.e not expecting
> landing pad. On an indirect call, elp moves LP_EXPECTED. When elp is
> LP_EXPECTED, only a subsquent landing pad instruction can set state back
> to NO_LP_EXPECTED. On reset, elp is set to NO_LP_EXPECTED.
> 
> zicfilp is enabled via bit2 in *envcfg CSRs. Enabling control for M-mode
> is in mseccfg CSR at bit position 10.
> 
> On trap, elp state is saved away in *status.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Co-developed-by: Jim Shu<jim.shu@sifive.com>
> Co-developed-by: Andy Chiu<andy.chiu@sifive.com>
> ---
>   target/riscv/cpu.c      |  3 +++
>   target/riscv/cpu.h      |  2 ++
>   target/riscv/cpu_bits.h |  6 ++++++
>   target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
>   target/riscv/pmp.c      |  5 +++++
>   target/riscv/pmp.h      |  3 ++-
>   6 files changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

