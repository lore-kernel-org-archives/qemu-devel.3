Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C015AC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMvC-0003Pn-NY; Fri, 24 Jan 2025 11:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbMud-0002hl-Vi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:52:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbMub-00027e-Gt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:52:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so55130825ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737737524; x=1738342324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DS+GEE6KX53q3sVMWPF9TWLj/H4k3Fe7yG4YbLhXk5k=;
 b=qHSm1pAlvRTxtIvbPsO3dHIEoWp50dthznPYzbmkXiIcfjSk6qub76DhJDddzHF5zV
 ndYDEypiXsaxmx1/WV1kjXDCUb1xLeyIG7M+UNsKPVAdLjpmBzGACKAnc4FQW1CY8aV2
 Q+r7whkXclVRJD+JaFwoXa2pood/bgv7MpDFWhL6MuZZmK98Tk/AhtTHjsOSIW0ztn1g
 YgJUR+6DR9wqmAwT78cUOlSgxmS0TtBf325wdHJZFbsxdxA+gpAy1oFUuny99OvbKdRq
 v0nXsBKx/NfoK931zG20TUDL43tujemGTbYHphMwjeMAVDXswy/T7feLtICv5inBUMv6
 W80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737737524; x=1738342324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DS+GEE6KX53q3sVMWPF9TWLj/H4k3Fe7yG4YbLhXk5k=;
 b=wqqV+LMUOClExzIjaVc8jtFewIrRYE1vvjUp9jXyz0lo9OfBWR0E4Lf5x9XKJp+5wl
 a0LTWekyyMRqdnRNuH3hu/wWAaG+vkAJRK8He6bTY15ip7z/s4Fx0A2C2qcO7+gCnYo0
 yFfD/zn/dtEll//vBMk+yZjrG9gFb2SUjzA+tNAPStu2W1S7IdTtiGJqq1qPHop68KqH
 ByrMs9nMyjlV4jS5LOD01ug5PUesS2qAmJqXp/F38Z3EEFQuBS8AU7YULObbQm2S4J27
 sMvZosvSM11k+tu3+eujCfolkrzKu/t+sRSJ1NceYZtLG4oaXGNd9IEEeByaHKqj7gOo
 1XuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/t8mdp3Dm0gIXxlhN0jJA0KbiXkeBiVPg9VsmbzMzEhzTHSCjmKaSARzTIVwao4FrVf8FyfFmlelK@nongnu.org
X-Gm-Message-State: AOJu0YyYwAr+SH7lGNxEGp0rR2HKCe0+PCgQmLt+Pwo6DyihqoFWzTht
 paX3uh1ODNRF7moKg7m9t/UCJo9B+QCalpOxykR2F8sE8/JxTVrTXZ5y5lFfPVo=
X-Gm-Gg: ASbGncvRd6wdxBf894bNrGuhpUQwtV+J/DXPdeQi90ZGlYu6jVtA2gSfw2f2Rdqk1S4
 cNaZrO2U7ovuXK6MVCXXDpsxpfuN2a3tULtXFe5vFmEe1sSUnSxt/4n9HDaHNIy4YXSC4HDUJzB
 tGgArVYBQ9WRmihewXDKN01O1rGIRfc4BOybedduEKz5IMeMpVlfaXCvXciDRvtSOeGE3klR3FS
 kHkbuvsODPk6igTNnjSX751T8IMfzbkjZEo2zzslOlbDc18hJzHzf95ui7gKzFcnvlZbqlHCAig
 ALUJcnakL6MJA2cWDTzAzbtU
X-Google-Smtp-Source: AGHT+IGz9deyuHcEaX3dRwgdNAfShJPIE5dsTQqhgVd1yApQIHCcmAnyjLQ5AzhJuO6ijoy7MrKk0g==
X-Received: by 2002:a17:903:2447:b0:216:725c:a12c with SMTP id
 d9443c01a7336-21c353eefd0mr405666745ad.9.1737737524153; 
 Fri, 24 Jan 2025 08:52:04 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414c4a8sm18329385ad.162.2025.01.24.08.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:52:03 -0800 (PST)
Message-ID: <29baf1d4-9c4d-4847-83e6-c6673bfb81b5@linaro.org>
Date: Fri, 24 Jan 2025 08:52:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] cpus: Restrict cpu_get_memory_mapping() to system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b7367f6d808..2402706c7d9 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -614,6 +614,8 @@ extern bool mttcg_enabled;
>    */
>   bool cpu_paging_enabled(const CPUState *cpu);
>   
> +#if !defined(CONFIG_USER_ONLY)
> +
>   /**
>    * cpu_get_memory_mapping:
>    * @cpu: The CPU whose memory mappings are to be obtained.
> @@ -625,8 +627,6 @@ bool cpu_paging_enabled(const CPUState *cpu);
>   bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
>                               Error **errp);
>   
> -#if !defined(CONFIG_USER_ONLY)
> -
>   /**
>    * cpu_write_elf64_note:
>    * @f: pointer to a function that writes memory to a file

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

