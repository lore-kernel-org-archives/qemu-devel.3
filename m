Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985FCC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbWbV-0004H3-48; Tue, 06 Aug 2024 22:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWbT-0004Bt-Tr
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:40:43 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWbQ-0003qX-54
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:40:42 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7b396521ff6so870064a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722998438; x=1723603238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2h6RDffmfs9D2uTrcqpIe4xx+JbSdhcdn+ZFwlGdCU=;
 b=QfaZo5ENH923sg96EIpfvjYO6hy/27AO/+17ZGD9kPrehVU9FhFnegw/KchhOJv/mZ
 dQs8D2CXYYWQd0IOwhcCQNvjb02TFCrneKoY532aNNXeI8jIwqmZSJMP0Up1Mi+HODq+
 WoTzft/SRHYMsqAsPJtMdCkNXAJsvQ60MwgmBPX4TR6vKGu8gMR3DGO9LfvuC4cE7QM9
 sQGYXj4Iyc9K0f0NmEBkVFW0TiHxv0j4JG2Kktyc0AlPS8rQ1cuaUrasQAVUn+0l4Yt/
 jQkEd7dFC26YI/fggyyWvS4ppHXEiiFgxvgyB8yKCZaqM3dCYpoIMHxz4tffFD/yCSd1
 XLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722998438; x=1723603238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2h6RDffmfs9D2uTrcqpIe4xx+JbSdhcdn+ZFwlGdCU=;
 b=vhvXxCPepSfmMsks1Uxjh3S5MPsayWgpxo2lM1A3Ds/7IaSY6/E0/e8W3srEmAsgqr
 Z5ZYZ9pClwi3J5Q/gdO8OeTohPtUYBSzx9SrER2A53oCJ2m8mW/J017F1j59PeZw44iN
 ZyMhyb1hEMn8G3BaQOn5I3z6Jx8qtUXq6TUMZvBCfAJQi46Tjdo21k/eXF1fnwMHT7CL
 MaC7tQR6RK8yrQUWauZcK18Z3Qu7FjkRsGCBXcSI0O/gaSRRJE7rdswmAs25pfkdXVUd
 xkg9EwjzSz3zyRCks7TxXxR7d8KTyfsUNgT66grRLm6yRXfRJt1z3l5BzKMrIuKuAe5i
 dhKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLlbSwL88KomUfeS1/1yJ0fVELzlMUWOuFfmK4h1/T+thMb0cOv/rXB3TyhtKWHVb7KxBrVyBoCQl3Z0hMyHO2CU8TowQ=
X-Gm-Message-State: AOJu0YxU5fRZwei78vBfBaaOW9CXjssR2iIDb+3xlFHV0BlUwFZGbiP8
 ronSH9BIpQLC+Jrr+25hFIFBeT7TIlDtO6un8sVgRr5z/LnAcNYIItSG9YCWGpI=
X-Google-Smtp-Source: AGHT+IFCiamhBfW0Cq3VrkNNCpANMVx0YcO8bqM+VkcVvcCR1HVIjs/AkvGOF9FeV+VNL43Tr1ymXw==
X-Received: by 2002:a17:90a:8c86:b0:2c9:cbdd:acd with SMTP id
 98e67ed59e1d1-2cff9559843mr20889931a91.35.1722998438018; 
 Tue, 06 Aug 2024 19:40:38 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3adac85sm215655a91.25.2024.08.06.19.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:40:37 -0700 (PDT)
Message-ID: <f0fd018f-171e-4487-875c-577d72018557@linaro.org>
Date: Wed, 7 Aug 2024 12:40:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/20] target/riscv: compressed encodings for sspush
 and sspopchk
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-14-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-14-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> sspush/sspopchk have compressed encodings carved out of zcmops.
> compressed sspush is designated as c.mop.1 while compressed sspopchk
> is designated as c.mop.5.
> 
> Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
> c.sspopchk x5 exists while c.sspopchk x1 doesn't.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   target/riscv/insn16.decode | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 3953bcf82d..d9fb74fef6 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -69,10 +69,12 @@
>   # Formats 16:
>   @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
>   @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
> +@c_sspop   ... . ..... .....  .. &i      imm=0      rs1=5     rd=0
>   @cl_q      ... . .....  ..... .. &i      imm=%uimm_cl_q   rs1=%rs1_3  rd=%rs2_3
>   @cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
>   @cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
>   @cs_2      ... ... ... .. ... .. &r      rs2=%rs2_3       rs1=%rs1_3  rd=%rs1_3
> +@c_sspush  ... ... ... .. ... .. &s      imm=0 rs1=0 rs2=1
>   @cs_q      ... ... ... .. ... .. &s      imm=%uimm_cl_q   rs1=%rs1_3  rs2=%rs2_3
>   @cs_d      ... ... ... .. ... .. &s      imm=%uimm_cl_d   rs1=%rs1_3  rs2=%rs2_3
>   @cs_w      ... ... ... .. ... .. &s      imm=%uimm_cl_w   rs1=%rs1_3  rs2=%rs2_3
> @@ -140,6 +142,8 @@ sw                110  ... ... .. ... 00 @cs_w
>   addi              000 .  .....  ..... 01 @ci
>   addi              010 .  .....  ..... 01 @c_li
>   {
> +  sspush          011 0  00001  00000 01 @c_sspush # c.sspush x1 carving out of zcmops
> +  sspopchk        011 0  00101  00000 01 @c_sspop # c.sspopchk x5 carving out of zcmops

Again, drop the single-use formats.


r~

