Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P5M-000630-NN; Wed, 08 Oct 2025 03:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P5L-00062r-Hk
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:59:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P5J-00051O-NZ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:59:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so61602175e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910379; x=1760515179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RW++muA8ipgAQrf+PnjwO0dFWxxR4qJIDUHasbAhPQw=;
 b=d7mdTUxWIUqtrAb07AcxSYB//XGe7JTT73RjhKeP8KoDnoZimIQF9nz2t0NMFc9wP8
 omcSy8KItrw26IENvWFojjS9xDqdNSwk1P368fdGyMvnpn+cVjnLH0sZ/TLrI4yKwB9b
 kgpA9ti5Ki3e+kw8ltGyEnE1XA3IkOxuE5/T42O2ETLZml9kZqFXd3axDYbME1SOmqgH
 3aReOh+JfzW+2vIo20GfODqxXT17neuPMk/CavLNbhAME9bGr8scnzaofCciZMxNdWHh
 UuyDL76DDpHl4+b/MjlvIRxaR5A9uJQJLU+WuqFgYaHQihSpLpl+Stmgxm49w6308jiT
 9J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910379; x=1760515179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RW++muA8ipgAQrf+PnjwO0dFWxxR4qJIDUHasbAhPQw=;
 b=XJbDT+AmUZDAlwNSUDfTGWloPv3JXLjO6OJEJQqOLAMgT6N36no3SMy/qgj1tA8rxQ
 XMu2vGrbi6eQXzar0amnBWUOEnrETEWiA3TF/9xfAPGfAby3GwTTBVwOLPCYdC4dTZPf
 ad7rPqg0zJuGwxbE8XiGyUXZtNdQ+hjdHmIhcWF4D5HRI7VHshJkVBiPdapVVVSmSoZ2
 yJKh310pkDkblWTqNeK2uqB7/KKbd2CWpEfmTYrQFaZsvPokjWn6DIFAjkgcVYdMRMA2
 sN65p2JWzbgSZ8o2OXW+Kp1llxP1nXTxeeiDAgM1nfbH0pYl5J+ZdEEWa14QyFqF9OGg
 mzJw==
X-Gm-Message-State: AOJu0YyvCP/N7cDMdIxC8luKdaKR0uD4EWfV8BI6mvXCBmkZhLcsb2h/
 pf2u8fBhujmZ8U6YwDmwp3OhWLfZuxvGkREAWdkfDfImBK/AkUj0IXIQWcjDyjCWvB1zPlSgirf
 tTgZO4ht8EA==
X-Gm-Gg: ASbGncsLN28gVJN9QrcQPUrKj2BlhZ/cBQIRSc4pSGSkXt5cpxWrUNBnL3FhB40w5sR
 TiJsaprFJHkRAr/sauBEDh274Mip5BRM4ErmDLLajEgHLJ2O9EDc6P4fRvP4KhndHNAOoBK0Qio
 Mjc/44zHrYhqEnzUv8wrdmojsCSmcBGlRlDdpB8HzyNIkZkHQQEBvt8eBOZHcy6ZG7k1vRAxNEu
 b9Fdf0hdi52ISHuhZrEtI7JiKssHnj38kDuTo0+NKomW+yuXjn8RepefBKcDrqR6TqCGRpeuw1F
 Y9HvGHaRX/Jt77VBRdMqs4Lkdhz0i9x2EVY/5PLGDURO3elz/9TADbZW+Us2DbICAABB1hlFxdZ
 oAjhsCXMy0xhWQm2JjQfIyS6I+UlkiHhyzdVzFmR8Z17KbJ3sOuu/lxytSIKcFIQjD04bx2BeYF
 2lmw6mHeBx3fbwul4Epm0qp8vTx4ID
X-Google-Smtp-Source: AGHT+IGkF7zzrmL6f7PGM22bNNtfBb0UaDfBLH31FdnGZrXUldVx5HjuHHGUxaqksgDoOpjT2jMAZA==
X-Received: by 2002:a05:600c:1394:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-46fa9b1706amr14020645e9.33.1759910379540; 
 Wed, 08 Oct 2025 00:59:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d4caa4sm26056765e9.12.2025.10.08.00.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 00:59:39 -0700 (PDT)
Message-ID: <6ecda129-3cb9-4d70-a0a7-bd0b7ee806a9@linaro.org>
Date: Wed, 8 Oct 2025 09:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] target/openrisc: Replace target_ulong -> uint32_t
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20251008075612.94193-1-philmd@linaro.org>
 <20251008075612.94193-8-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008075612.94193-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/10/25 09:56, Philippe Mathieu-Daudé wrote:
> The OpenRISC targets are only built as 32-bit, therefore
> target_ulong always expands to uint32_t. Replace and adapt
> the API uses mechanically:
> 
>    target_ulong -> uint32_t
>    target_long -> int32_t
>    tl -> i32
>    TCGv -> TCGv_i32
>    tcg_global_mem_new -> tcg_global_mem_new_i32

I forgot:

      VMSTATE_UINTTL -> VMSTATE_UINT32

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: not sure how to split to ease review :|

~200 lines, not that bad.

> ---
>   target/openrisc/cpu.h        |  22 +--
>   target/openrisc/helper.h     |   8 +-
>   target/openrisc/fpu_helper.c |   8 +-
>   target/openrisc/machine.c    |  16 +-
>   target/openrisc/sys_helper.c |   5 +-
>   target/openrisc/translate.c  | 374 +++++++++++++++++------------------
>   6 files changed, 216 insertions(+), 217 deletions(-)


