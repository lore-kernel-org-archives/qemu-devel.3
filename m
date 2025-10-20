Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68FACCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAz6J-00022z-GU; Mon, 20 Oct 2025 19:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAz65-00020v-2b
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:15:33 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAz63-00072y-4n
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:15:24 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-33b5a3e8ae2so4809717a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761002120; x=1761606920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OUaf7wYIozWx/WFVk2ZCYyAiKwn1asAj1d6d6nXUqbI=;
 b=cPUasQ2c4ZkH/P5rJ+qXlg1ujhO2Nq1OQShf/2Bm7or6uRQzRhnusjZg/HpTXRaVTB
 cbVmXsDm0AJpkWCgwW1Hd0dM4R9IuMrUHUAy1wQpTeCCnP/Qptm729GFwSNKuAR1F/iJ
 B/H3qAnv2rScA7lkl7f42l1UnfjPfZ4QBxeUsmicXFbf+vAfgLk57/n8z2jvOET9YDYE
 LT8WRvNmy9VbOsguO67c6sGcKGo3kz2srOb/6lxYO26H653pByxrDpQ20NVny/Mgl0gv
 c1EhnWPOXzsTn6GKtV9gQ2zY1lczV6qNRfAenwLPPPVmqkxEmQnJvDje3X3pB/wW360L
 bBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002120; x=1761606920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OUaf7wYIozWx/WFVk2ZCYyAiKwn1asAj1d6d6nXUqbI=;
 b=lyTjJcp+j2MmoD6Yp7TD3rXeFBFAP0xNowwf5aUbpRyAdKpLKZ5dLovvpPKpqqsJiH
 Jz2M3qvCAl5BETjbzT2WfCGZTyK6x/ghTgt+3N+rQURlkCalnK17y5tggxwQnhgO/AKS
 vGTizIY3RCt1HGTHP8tAFMK5XDQhV10bpNXzvjashvDNdSdaPPDFsRWA8ExSluy64iHw
 Fg3ACkOrmp731raeZ51URa8RIlLHooBwiNGjUCbSVyFzfjdsC5UDT0GvZBd0SZs296ED
 d+IyhLDDTYc6Fh6jX0akaWKPy5oNbc7wFnLpqOeVfrHOzv+sgXRfBbPPcZFzyzWIWp7w
 5JvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmIcpRjB6OWsbqhWW7ToaKGQLW8/atVmP8oQTRA3R0dNWC8JYzs+UzcUocXKBehjn0F6R2ZF5X9fRJ@nongnu.org
X-Gm-Message-State: AOJu0YwW4GoDML6+DTervwFJZal4gfZGJWG9wF5LzK/pYScjNq9vCg7K
 QED7xfIbZozxkfZQRV1AetDGbJldJyIrOg7zXeMnAk5Qu/nSVifUbdoI7crayDjuzAk=
X-Gm-Gg: ASbGncvYeg7TGeAv+W3B/8aFKd2/C0sEEdei35Wd1L+x57JKM5IE4mvJHL41oWOC0UV
 /2mhNWm7mbYmcVL8NXfwlRvRV7/NsSKwqRg2TNNIYLF01FiVbm0ezyickmcBO02WKbydjXYvr5s
 su8lF0qb6JI4jEtibQXgrc3YAaMYTWVSqJ9n4femdUIB8mGcl4mLCTOz+eUSoajeRhMFmhZoQ7k
 6bmUwmAfagXywF50Ho/eCLmovXdGbR5+BMRbmLVpfr57g8OdPUrOl3CpOU/XgQKveUiSaMwae25
 Tv4rXq1AxDURfLKsh3YLyJ1GAGUpPbTkx4NREOnsaZA1uj5jlt8Cdk0wfs/JS+GXblAQHTfo2tT
 3Ul5THKqqDUOrR+jAQjuMUKemtw6ioyLPzDwPbUHJgEG4Fhc1SFJt1Aa+lxR0+z3P70ojvUxq2L
 1C9ob7zXbTif0smA==
X-Google-Smtp-Source: AGHT+IGp09JXsgTv4dDf0DY1tD+NTvYWJXBM5SxGhMeaPywLJVqU+oYlMHiWari0fHQYrqNMm0+o3g==
X-Received: by 2002:a17:90a:d406:b0:32d:e027:9b26 with SMTP id
 98e67ed59e1d1-33bc9d1a8e6mr21159317a91.13.1761002120486; 
 Mon, 20 Oct 2025 16:15:20 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a813d4766sm6984603a12.5.2025.10.20.16.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:15:20 -0700 (PDT)
Message-ID: <bc03818e-d76a-4301-931a-058f21bb6847@linaro.org>
Date: Mon, 20 Oct 2025 16:15:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/30] qemu/target-info: Add target_base_arch()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020221508.67413-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020221508.67413-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 2025-10-20 15:14, Philippe Mathieu-Daudé wrote:
> When multiple QEMU targets are variants (word size, endianness)
> of the same base architecture, target_base_arch() returns this
> base. For example, for the Aarch64 target it will return
> SYS_EMU_TARGET_ARM as common base.
>

I'm not sure that reusing semantic on a subset of this enum is the best 
idea, so many things can go wrong.

More widely, I don't know where we would need to access this, versus 
specific functions like target_base_arm().
If a code needs to check various base archs target_base_*, or it can use 
a switch with all variants.

If we really want to have this target_base concept, at least it deserves 
it's own enum, separate from SYS_EMU_TARGET.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h |  2 ++
>   include/qemu/target-info-qapi.h |  7 +++++++
>   target-info-stub.c              |  1 +
>   target-info.c                   | 10 ++++++++++
>   4 files changed, 20 insertions(+)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index e446585bf53..2c171f8359b 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -17,6 +17,8 @@ typedef struct TargetInfo {
>       const char *target_name;
>       /* related to TARGET_ARCH definition */
>       SysEmuTarget target_arch;
> +    /* related to TARGET_BASE_ARCH definition (target/${base_arch}/ path) */
> +    SysEmuTarget target_base_arch;
>       /* runtime equivalent of TARGET_LONG_BITS definition */
>       unsigned long_bits;
>       /* runtime equivalent of CPU_RESOLVING_TYPE definition */
> diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
> index d5ce0523238..65ed4ca8eea 100644
> --- a/include/qemu/target-info-qapi.h
> +++ b/include/qemu/target-info-qapi.h
> @@ -19,6 +19,13 @@
>    */
>   SysEmuTarget target_arch(void);
>   
> +/**
> + * target_base_arch:
> + *
> + * Returns: QAPI SysEmuTarget enum (i.e. SYS_EMU_TARGET_I386).
> + */
> +SysEmuTarget target_base_arch(void);
> +
>   /**
>    * target_endian_mode:
>    *
> diff --git a/target-info-stub.c b/target-info-stub.c
> index d96d8249c1d..d2cfca1b4c2 100644
> --- a/target-info-stub.c
> +++ b/target-info-stub.c
> @@ -19,6 +19,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
>   static const TargetInfo target_info_stub = {
>       .target_name = TARGET_NAME,
>       .target_arch = SYS_EMU_TARGET__MAX,
> +    .target_base_arch = SYS_EMU_TARGET__MAX,

And nothing can enforce base and arch match by design, which is a 
problem IMHO.

>       .long_bits = TARGET_LONG_BITS,
>       .cpu_type = CPU_RESOLVING_TYPE,
>       .machine_typename = TYPE_MACHINE,
> diff --git a/target-info.c b/target-info.c
> index e567cb4c40a..332198e40a2 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -33,6 +33,16 @@ SysEmuTarget target_arch(void)
>       return arch;
>   }
>   
> +SysEmuTarget target_base_arch(void)
> +{
> +    SysEmuTarget base_arch = target_info()->target_base_arch;
> +
> +    if (base_arch == SYS_EMU_TARGET__MAX) {
> +        base_arch = target_arch();
> +    }
> +    return base_arch;

More confusing, we can eventually return a non base arch if base arch 
was not correctly set above.

> +}
> +
>   const char *target_cpu_type(void)
>   {
>       return target_info()->cpu_type;

