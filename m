Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90607C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 12:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8JbQ-0003kR-21; Sat, 18 May 2024 08:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8JbI-0003ji-AS
 for qemu-devel@nongnu.org; Sat, 18 May 2024 08:55:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Jb2-0001GP-S7
 for qemu-devel@nongnu.org; Sat, 18 May 2024 08:55:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso37354945ad.0
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716036931; x=1716641731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gEKwrSVDhciK5xljCqgvaJDYt+P8ob4tabXg53BBlts=;
 b=lhcf+ZgUMtKKIXDAp3NyD0QL+3q+ssWd2ODjAUu6ZMadII1ksbFvTTeKmiN8N608Nr
 83QcbqJ3/FnErQU9mmYZFpsOmZn8VxPt5wqnBzDkRRDPcrBoEznjU48+IL0DcYmyx9rZ
 9mnr4PI64Z9hIrW0Kw7lDCrlOsmUZpEbOW7uG+p+Uf2hqIbCErKdEj9V3PPQVAdtN/eP
 HrHJK85KjtpyAkNytT+I0hbtkoJ10Noy6d/XUwWJhSoLWkvUKrtR7YtR3limAWuK5Atj
 0RcAp6povDfmouxRKxTLsve5LpdbxCz3IZwwugxHDL08WXu0ZycXuwKv9nFl1QLULGdz
 kUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716036931; x=1716641731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEKwrSVDhciK5xljCqgvaJDYt+P8ob4tabXg53BBlts=;
 b=OjtyNYnXJVOFVPqlDXYrosGEiUiBTDjCdTazF9QWUSvuTg4H7/aHPhTpXiyA+p46aN
 cPX1DeRQMcjEgJNwobVMoQmGiKIDB/kCrYMIgna9gCkNi6KMB63jmYtkKPioDPay9cEE
 bM5AQAYqA+iV3BTXnmYSqTRNAgCwNZDRuf2jp504mlZzE6ZFI6E171FEoVkSrC5wyvKS
 qjx28D0okWZaO9Ln2LirxRCUQSjPx2m4eWVO/kmjaKsL9TxeHf0lgPkJx9goBfW+/Ec+
 q6mmUHYqF6j59cig5YjD28Dl4sAO09nLs3KZpGO9hzu8Uvu+tnwibzV78AVLvLbx9K8H
 SWzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRW2Y5JM0J33hF3g1CGyVQNQYwjIITMp3hcW0w7Eh6MkkRIqG7w29QkpPTh0ad6MJ1E3vHbR1fTCY+kQSaQqrEqu0ssG0=
X-Gm-Message-State: AOJu0Yxbq9bUiYFOWRLp+v3Xc9LbDD5uITq+CpgA6JdZfjwx9UjZo+42
 vyRn235YoK4O9hfh6TOza3PnKhQ21PT4n7tojzNsyy3LVddalxAGbz2Pg8p2pLM=
X-Google-Smtp-Source: AGHT+IGpV5Ygjw01nuKNkrjlwPvatKRGPJg18mkfUFjRlyzO2keTDe4ExgwjrO0YkacKTXw6xsiYeA==
X-Received: by 2002:a17:902:bf04:b0:1e2:1df:449b with SMTP id
 d9443c01a7336-1ef44182635mr222683165ad.69.1716036930872; 
 Sat, 18 May 2024 05:55:30 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2f3ed38a9sm5699185ad.158.2024.05.18.05.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 05:55:30 -0700 (PDT)
Message-ID: <586302b6-0e6e-438d-a218-48a577c5c3b8@ventanamicro.com>
Date: Sat, 18 May 2024 09:55:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Extend virtual irq csrs masks to be 64
 bit wide.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com
References: <20240513114602.72098-1-rkanwal@rivosinc.com>
 <20240513114602.72098-2-rkanwal@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240513114602.72098-2-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 5/13/24 08:46, Rajnesh Kanwal wrote:
> AIA extends the width of all IRQ CSRs to 64bit even
> in 32bit systems by adding missing half CSRs.
> 
> This seems to be missed while adding support for
> virtual IRQs. The whole logic seems to be correct
> except the width of the masks.
> 
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual
> interrupt and IRQ filtering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual
> interrupt and IRQ filtering support.")
> 

Please avoid splitting the commit title when including them in a "Fixes"
tag. It is ok if the commit this breaks the usual char limit:

> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")


As for the code:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/csr.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 45b548eb0b..c9d685dcc5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1193,18 +1193,18 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>    */
>   
>   /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
> -static const target_ulong mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
> +static const uint64_t mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
>                                       LOCAL_INTERRUPTS;
> -static const target_ulong mvien_writable_mask = MIP_SSIP | MIP_SEIP |
> +static const uint64_t mvien_writable_mask = MIP_SSIP | MIP_SEIP |
>                                       LOCAL_INTERRUPTS;
>   
> -static const target_ulong sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
> -static const target_ulong hip_writable_mask = MIP_VSSIP;
> -static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
> +static const uint64_t sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
> +static const uint64_t hip_writable_mask = MIP_VSSIP;
> +static const uint64_t hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
>                                       MIP_VSEIP | LOCAL_INTERRUPTS;
> -static const target_ulong hvien_writable_mask = LOCAL_INTERRUPTS;
> +static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
>   
> -static const target_ulong vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
> +static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
>   
>   const bool valid_vm_1_10_32[16] = {
>       [VM_1_10_MBARE] = true,

