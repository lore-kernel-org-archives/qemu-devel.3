Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BFE1062882
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IWO-0002bR-4y; Wed, 11 Mar 2026 08:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IWL-0002aY-Rp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:18:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IWK-0000cb-4U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:18:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so6634658f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773231513; x=1773836313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dzPmX+n6wesYUuqDbfaSqUYjA0A/rvzEnT07OYu1GZ8=;
 b=B2qB/EnZyq7yc/k9l+W38HEdtsl4Jjb3uUH5yH8UShtBX4SIZGWk9M2LJ0z22gtzsA
 CB6Gc0lsCB+sEHKbWN6g3h+PoLbArDxfodqmxPpmkeVUPxZu8qKDpqjgvLtbzdJOa3RD
 q5wY6/c7doShAt3oeDPDAzMZz86BpVk+K+DyJ7zhmoGR5IuKA67sYjyV0pPDQeAOOGL9
 UlibDj/6WeuIp1PEZ2JEJk5BhL2DjgIByNNMVCy/w6aKDNHWO/Pn7un7R4H72osyXg/b
 cLM4zXZ9vjgOUHjvIa9RMuQTvFR+4cPVcGxAeMPSVU/9GqjYESpNOf9HSHRMZ1+Fwn6r
 BLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773231513; x=1773836313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dzPmX+n6wesYUuqDbfaSqUYjA0A/rvzEnT07OYu1GZ8=;
 b=Ekr8TnU2G101q7OERNCRKkEj+I8JpjHL44wzGOOb9ZgqejTCpSIJ0dyX76vPqCoF3t
 n/yCTpLmQAwHBEAz86s+EvLC09AuEB8+nk4mMhKzsqA4DCkAK9EDMn3883rtX6jhGfYp
 64SUdnGK0EteSYnl4mRCFAZC55HnXhIXCnAdKjxvVzFZU8e+zvWY44glnFGmIScdu8cO
 XZb3Fu2mQ5RNk3UK9MTC/49GP6nX110Wfn7RSH1S3W8a7ZMEsUJd1cZI9OviPu5m6if9
 AJDOAL+U0em2jQOuyM7nlwXJVg2ZluK8R9zdsmgsl1MdR+YiiP5G0ktSdJ0LkmC17D0M
 rjjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyWp86qMfF01KrBp6bmnt69RU8nvxkkaYWXSYl2FZKTLP3aMy6xUTZeKrhFI7QWnus9L7q81Ef4d2B@nongnu.org
X-Gm-Message-State: AOJu0Yzu2ZFfsqMmRNN9aV4/wxvnqqH43AnUicsoNyuFIfvJF6bMYUmI
 U3xoYjK4M15a/NLW7NFPTiNnzUTR2AaH+c+r2BQ4eYPehLe+YCkQrsdMKm4fBgI2eIY=
X-Gm-Gg: ATEYQzy1MnadmIoawfXFLnaS9pGlUXMaud1wEI6LC9Nzr+wFUID5fxnpnQQ4VnBBqMS
 hF8xGhRWEkMiCKUNOPrefZxFqsEjX9hqXUcolxjhm+9YZpViXxmWVb1sDMmWBm/zk4HQE1F1tND
 Jg3H96ypWPleNklpgX4ZjIR8eokOSBq/K13mqdvtz8lFMUsh+JPAJJAcNRioDk/VznK1yVC8chw
 I26q8p4cCtBoXGAUBXXT491urLptnpab46Q9jB22bhXlVJ1eTOYB8j2Cp2KhALvBCtp1zz7CK5+
 cHjYJRmMHckKOSvcms7norL0jDKuzF0dkxrcQNoI0mCWynP/Fchp1KREaBgszC/gDrjfhrhO0O7
 pYgiPbqppuw7gP+EhJ33n2FMXG+iHD5ttRQP2geIh5uMYIgc7ZiygjUcx7XMuKSTJsp3UQHEoId
 Xxk8Ho3bHGopWpjkeNVo4Y39A/gN+EJ9531rTOdPGw8BLS8KO3CK3l+WSdB8EIzMgZ4A==
X-Received: by 2002:a05:6000:40c7:b0:439:d8cb:1392 with SMTP id
 ffacd0b85a97d-439f81df31bmr4708246f8f.26.1773231511639; 
 Wed, 11 Mar 2026 05:18:31 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81acc22sm6014055f8f.16.2026.03.11.05.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:18:31 -0700 (PDT)
Message-ID: <f9f7b5fd-338d-4138-b9b9-103cfeaed5a3@linaro.org>
Date: Wed, 11 Mar 2026 13:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/riscv: Fix page table walk endianness for
 big-endian harts
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-8-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311115910.564481-8-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 11/3/26 12:59, Djordje Todorovic wrote:
> The page table walker reads PTEs using address_space_ldl/ldq which use
> compile-time native endianness (always LE for RISC-V). However, when a
> big-endian kernel writes PTEs via normal store instructions, they are
> stored in big-endian byte order. The walker then misinterprets the PTE
> values, causing page faults and a hang when the kernel enables the MMU.
> 
> The RISC-V privileged specification states that implicit data memory
> accesses to supervisor-level memory management data structures follow
> the hart's endianness setting (MSTATUS SBE/MBE bits).
> 
> Fix both PTE reads and atomic A/D bit updates to use the explicit _le
> or _be memory access variants based on the hart's runtime endianness.
> ---
>   target/riscv/cpu_helper.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)


> @@ -1567,11 +1571,21 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
>               target_ulong old_pte;
>               if (riscv_cpu_sxl(env) == MXL_RV32) {
> -                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
> -                old_pte = le32_to_cpu(old_pte);
> +                if (riscv_cpu_data_is_big_endian(env)) {
> +                    old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_be32(pte), cpu_to_be32(updated_pte));
> +                    old_pte = be32_to_cpu(old_pte);
> +                } else {
> +                    old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
> +                    old_pte = le32_to_cpu(old_pte);
> +                }

I expect checkpatch.pl script to complain for long lines, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


