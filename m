Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BABC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbWeT-000139-19; Tue, 06 Aug 2024 22:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWeR-00010P-10
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:43:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWeP-00041b-0h
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:43:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc566ac769so13732925ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722998623; x=1723603423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jipd1zlFzCYiT+RlA+44hCaQbnmpb2tLbJQSjZwfgy8=;
 b=V9HPg1p/tlfc+jwjNPwC3vfFUWIDQ0bzVgOhdPnPso5XQIBAbFH+u41Ml9itXnZ3UK
 zKhn6g3/0Lyp1ujn3+KF42tfqTrLwbQROk/LThHHjBFIOzSiAtc52rMjGDrRhtiZrf7l
 3SKYkzGkCseiLtH3w5neEdg7lrm09/YMXtkwIMQ4AvvNf68kWdc/9rBOQvHyb9LHT4xv
 RDz3iMGE1Bj2XgaD2TGuy4EjNyXo/FV45AoINbl433LK8NUXhGv4O64wHbYr7BoKbWkK
 Tz50qha2u1JE+QHrcEJCBC//kL916v6Uyad2rHF/XiIzfbTu73TDkLL/mN88n4zE1bZu
 A4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722998623; x=1723603423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jipd1zlFzCYiT+RlA+44hCaQbnmpb2tLbJQSjZwfgy8=;
 b=ldk5G7iqleI73gloYVwpoZCxDc2vuufL14liGVSPjSluRzgDUIb5gFK/GjdjvzCRri
 uNiDzwcizXL2geTzkq6XHa9SDDZ0BboFQYnutwmRwDMaSR9u2WHbgp4+9f8XKyKuP1E1
 URAe94EGZLntAP6qha11ekXee6hPF/lkeXI9DgbCXXA8H8gRpbdc2iAByr65BXgamQwU
 h7xhai6KL2YYDvINdvB6kJR7l4DdqJq4y5kCvfedgyhNb8/tm5Ym2tOWneH57kfwx9du
 d5WPCnif0TIsppbWn4JAf0p/kNucGh2mUmB011RGmHpW0tqX/z9xIpNgE/ABJ1vxaccb
 CyWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFaDv8Oeu0DGwIk+7uEDXltLyTU1f62nXhHoCZC/gqrp42LYw3Q9DPs6JNLqEOPMXzlC14RgvNkrh4Pud9TJQf/QZEG5s=
X-Gm-Message-State: AOJu0YzsWX6JDQxZkEv3lwR5uAXWMsYoubBCi9kHomFQRmvtHJHmzvWo
 LTCtFCMc2lOzRDrt8JTzNa7DVcPLoBxnZiE5dSaiXXX1xnkeT8EAzAc8MDAK+p8=
X-Google-Smtp-Source: AGHT+IHWP1AGq2taGnJ13BRaztMXWPOAKPJzHrAfhBJKaTtQEgJlhavbPtmPAQgDURPOgzGCAEbK7Q==
X-Received: by 2002:a17:902:f684:b0:1fd:8eaf:eaa0 with SMTP id
 d9443c01a7336-1ff57321340mr173456325ad.38.1722998622753; 
 Tue, 06 Aug 2024 19:43:42 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59058d7dsm94278515ad.142.2024.08.06.19.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:43:42 -0700 (PDT)
Message-ID: <26d37287-b4e3-42b8-818d-b96bcf128a75@linaro.org>
Date: Wed, 7 Aug 2024 12:43:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/20] target/riscv: shadow stack mmu index for shadow
 stack instructions
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-16-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-16-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> Shadow stack instructions shadow stack mmu index for load/stores.
> `MMU_IDX_SS_ACCESS` at bit positon 3 is used as shadow stack index.
> Shadow stack mmu index depend on privilege and SUM bit. If shadow stack
> accesses happening in user mode, shadow stack mmu index = 0b1000. If
> shaodw stack access happening in supervisor mode mmu index = 0b1001. If
> shadow stack access happening in supervisor mode with SUM=1 then mmu
> index = 0b1010
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   target/riscv/cpu.h                            | 13 ++++++++++
>   target/riscv/cpu_helper.c                     |  3 +++
>   target/riscv/insn_trans/trans_rva.c.inc       |  8 ++++++
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  6 +++++
>   target/riscv/internals.h                      |  1 +
>   target/riscv/translate.c                      | 25 +++++++++++++++++++
>   6 files changed, 56 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6da94c417c..3ad220a9fe 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -615,6 +615,19 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
>   FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
>   /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
>   FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
> +/*
> + * zicfiss shadow stack is special memory on which regular stores aren't
> + * allowed but shadow stack stores are allowed. Shadow stack stores can
> + * happen as `sspush` or `ssamoswap` instructions. `sspush` implicitly
> + * takes shadow stack address from CSR_SSP. But `ssamoswap` takes address
> + * from encoded input register and it will be used by supervisor software
> + * to access (read/write) user shadow stack for setting up rt_frame during
> + * signal delivery. Supervisor software will do so by setting SUM=1. Thus
> + * a TB flag is needed if SUM was 1 during TB generation to correctly
> + * reflect memory permissions to access shadow stack user memory from
> + * supervisor mode.
> + */
> +FIELD(TB_FLAGS, SUM, 31, 1)

This is already encoded into the mmu_idx as MMUIdx_S_SUM.


r~

