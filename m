Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A1BCFD625
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSwt-000429-MM; Wed, 07 Jan 2026 07:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdSwp-00041X-Me
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:47:35 -0500
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdSwn-0004fh-6L
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:47:34 -0500
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-121b14d0089so1549561c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767790052; x=1768394852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gHRO/P6NXdbiR566sv2ouyZLlTtyqD1lwt61uASXMoM=;
 b=c+NUDHDk+XeAblIS2fgmAn2bRm00Ouy6sp2Q6O1Lsq9ws2irBJwKJREVrIuxK7uZw1
 LM2sDCdu89/0pqj9xit8gZffl7hAZEHJkxo+M3P+uavoyOXlxSDD7qc4iwVD93c4kQgU
 7xaMolOQLY2RTKKZBWQUl6lpnsMTdWai/g9lTWOpKSrUEykSHnWgBPSdWa93++ecUcm4
 HISdwIiorClitPkmAZQYZMpiH/Iwgai12epIOHOr4FZUf0J3d0mXEZT5J49tQxbP/FE6
 bSK8PqvNYEgZHRcNj3z0D2c3VdBbrfQfIsGhptcXfYhwTuMOFzdXoYVotmyD2SXoGhGO
 2j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767790052; x=1768394852;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHRO/P6NXdbiR566sv2ouyZLlTtyqD1lwt61uASXMoM=;
 b=aPqB4I9Qz0jozZzBWtuCWb6UnXOctDWJKH3TcPTI6yYRh7/GOO7ipkFbvx6LJ8C6F4
 oVK7MKhmu99te09mbV/lBdeQ8NwkfE+IGTTHWmLkgFLOn/jq49xkzv8i43DaWDsWzd67
 VppJlJOwXvhB9Y7E0EuqJ2e9QxEZHmddJUTBMSC3f8VrTSdgn3QozSCLBBRcDqBk45Qx
 /2jE/f7ZjpNkofNYp00H0VMqPZW7rnhGurip8Q8zFCj33akjWp9Vc2NfZ2HSGvYx19VY
 5rOr5FA3yjvNav8NMRzHUKawgpuFUBnDQUcqUWJEDAESd4RzG36oYp/0l7Gnc56UNUkw
 J4/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS+KpExIInbTwGyoW0eN1PgcmX2d6Qk1EMxPPcPpLGcooX1x/X4CXbsSnwwTe7TCb9pk7F2V1UnpfC@nongnu.org
X-Gm-Message-State: AOJu0Yx/q8vwcCtQrNSFVZcp4cuTkjWQ1HSXuz8XV+ox0MyBdFsve2f7
 0p6nNnG1ueR6nWHU8ZBS2PVq6FCCC1MQ8h882vr3T6+YNnnBVr51YSXzzzvwM8mDhng=
X-Gm-Gg: AY/fxX4aiJ6K4a7a06u6R94NZzDyBKEqJ6J6NGWxjq8TeBu8PuuPOyP5Xa5qIaSR7AI
 /q7Jn7JuVbZDuBHAK2AY4ctRTIdQJj65OBCT4Cku25Us5itohx5yDs4I7OWqIDdJPCeReS0B34/
 2BLOtNPrcvPjkn48DPUuoQ3rHmByBxpgCXbVlVLb3BrGUAnES22y4OS335lj/OT1FK7yXlr6HAv
 IAyfDMm8Bv8LTRKPN1ZBrScAk/j0S5v3vsXH8N5t1F3erdn3fCAPBXfYoLr/UHiqRonLr+UzdXi
 0+chtP/gMmgs2ETKasHTFjv+p7veAt90jPDYMvj6stP7HgD9S62vN2YwzDjfckaxuZdWBd63fEU
 HNq+KlSNY5NVFgMaqzrgoagcF3oFqnC01Ur7EDdEgtoVUJduXblcQH6C86ZsJz+eVlCdf6U/FQp
 tsbGFs64oTl5+/XB6m/J33IBl27TiSlICNGiKDInrYD7bbiPOl+6V0SVd0jSTVRzaRHA6rWjhI0
 +D231NCy0M=
X-Google-Smtp-Source: AGHT+IHLKpaiHG3wKD4o5zKQjMTMrzKAnQSKqXoK//ky1UElWhGBo05+bfzKuJoj0UaLVyI/MpNZTA==
X-Received: by 2002:a05:7022:160a:b0:11b:9386:8273 with SMTP id
 a92af1059eb24-121f8b9aa3amr1703736c88.48.1767790051619; 
 Wed, 07 Jan 2026 04:47:31 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f23b798asm7627853c88.0.2026.01.07.04.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 04:47:31 -0800 (PST)
Message-ID: <448f457f-a1ad-4f53-93e6-128e8b372b48@ventanamicro.com>
Date: Wed, 7 Jan 2026 09:47:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Remove redundant macro definitions
To: wang.yechao255@zte.com.cn, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260107161336108RbvgIEJ1pww_fKZtMreFp@zte.com.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260107161336108RbvgIEJ1pww_fKZtMreFp@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dl1-x1231.google.com
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



On 1/7/26 5:13 AM, wang.yechao255@zte.com.cn wrote:
> From: yechao-w <wang.yechao255@zte.com.cn>
> 
> 
> The macro MMU_USER_IDX is unused, and its defined value is incorrect.
> 
> It should be MMUIdx_U(0), which is defined in target/riscv/internals.h.
> 
> Therefore, remove the macro definition of MMU_USER_IDX.
> 
> 
> Signed-off-by: yechao-w <wang.yechao255@zte.com.cn>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
>   target/riscv/cpu.h | 2 --
> 
>   1 file changed, 2 deletions(-)
> 
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> 
> index 90b3e95105..e3899b49ef 100644
> 
> --- a/target/riscv/cpu.h
> 
> +++ b/target/riscv/cpu.h
> 
> @@ -172,8 +172,6 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
> 
>   #define RISCV_IMPLIED_EXTS_RULE_END -1
> 
> -#define MMU_USER_IDX 3
> 
> -
> 
>   #define MAX_RISCV_PMPS (64)
> 
>   #define OLD_MAX_RISCV_PMPS (16)
> 
>   #define MIN_RISCV_PMP_GRANULARITY 4
> 
> -- 
> 
> 2.27.0
> 
> 
> 
> 
> 


