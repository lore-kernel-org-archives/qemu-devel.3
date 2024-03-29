Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF1CD128A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBfI-0008DO-1V; Fri, 29 Mar 2024 08:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBet-00080t-T6
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:48:36 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBer-0001fO-EW
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:48:35 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d718efedb2so8025681fa.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716511; x=1712321311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjChalOR1lFOhwTJ0rAJId3zAj7IGSvTyiEYYFTqnYc=;
 b=ozFhfapZEVFdRbF8lZBlP1N7dxpXl9S78lyRCrBvK8fefy9e9FicH2ezdtZMyVNT4K
 Ef+wZFEXPnoXuFH+xIPFlW/RZeFN+sSCLuw2xP2kz+jetL7G4ki423Z6ZhIdnDTFHD/c
 HaiFznqiiY5jhtcf47RzrV9c8OyiZceTSzrHk9KKP0Fh7Y34H/BSC69IA2eXz3kKKu8R
 NlzdM5xGVluOs7M7PRSq37MPyA0Vj7a+hCF6XlYn1EKPC5UFGwSeIYoA9aVhCNVJ/y3H
 PkBHLEpMDQoUqChXWZ/NzWAhbBJcqNrVchnXC2umyHFteu+wtJ5wpOCMZHCFSIJfWkaA
 25hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716511; x=1712321311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sjChalOR1lFOhwTJ0rAJId3zAj7IGSvTyiEYYFTqnYc=;
 b=GkLA77BJr2BovG1OtaDmd6biT8BY7FEQtJzk996DaXijNUTCo9dgSNDDVcBqcImsg4
 kQNgcJi6pCN+ZdJwMsX4aHAwal4AcH1UaBGy+g7e+EkE9Fhh+5MnTU2SHXEqYr2w5KhZ
 S8q671DbNDVMRSt+0d+DVcZl7Vxexa9rBh2FprNLz8IsS8ngL/qePGnfP7E9p6bW0vn9
 luU93Q1a4ftUU1atr5aZbaShsvoYMXv6NHi+BUG1ELrCwPtq0rCKBN5f9+ywg3ISbYdt
 r7dQTsDJRBc26qI+WKIh1pqzWmfcO6vQB4OoECkVVJ8fW/hF/67Sq+BSU94pSf2EB2R2
 0bEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHfG/WyugJch4Skc4hK+xSIrGTT+tgLV48Ee3ndOirnqLJdVEchdvav9CL3S+rIn+G322uqNK/fh00URZ3yJs3EzASEdk=
X-Gm-Message-State: AOJu0YyOPfW78N4hAuykGh2MrCmtpxtlgYVBRdlfXGDMK6NuJUyXjIAj
 6SwsUxs1yMe5RKc1BKNY4Kt5aCTC8SdRFWRnLqVj+QTzXzSctSSGioO9FW4aznE=
X-Google-Smtp-Source: AGHT+IHLHyc5TeXlB4D6uTvOCxqA2Qc1NVI0gTLOGBg8iIHS4GBX9u03pp4TbjsjA3QttxFMBlzhzQ==
X-Received: by 2002:a05:651c:a0c:b0:2d7:1e2b:6284 with SMTP id
 k12-20020a05651c0a0c00b002d71e2b6284mr257483ljq.27.1711716510911; 
 Fri, 29 Mar 2024 05:48:30 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 bn25-20020a170906c0d900b00a4e23400982sm1756131ejb.95.2024.03.29.05.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 05:48:30 -0700 (PDT)
Message-ID: <dc81005e-f216-4a39-9900-8598b61d48f3@linaro.org>
Date: Fri, 29 Mar 2024 13:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/syscall: xtensa: fix target_msqid_ds and
 ipc_perm conversion
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240329063148.129343-1-jcmvbkbc@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329063148.129343-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Hi Max,

On 29/3/24 07:31, Max Filippov wrote:
> - target_ipc_perm::mode and target_ipc_perm::__seq fields are 32-bit wide
>    on xtensa and thus need to use tswap32
> - target_msqid_ds::msg_*time field pairs are reversed on big-endian
>    xtensa

Please split in 2 distinct patches.

> Both issues result in incorrect conversion results on big-endian xtensa
> targets, spotted by the libc-test http://nsz.repo.hu/git/?p=libc-test
> 
> Cc: qemu-stable@nongnu.org
> Fixes: a3da8be5126b ("target/xtensa: linux-user: fix sysv IPC structures")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   linux-user/syscall.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e1424890..cb334e90d6f0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3758,12 +3758,13 @@ static inline abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
>       host_ip->gid = tswap32(target_ip->gid);
>       host_ip->cuid = tswap32(target_ip->cuid);
>       host_ip->cgid = tswap32(target_ip->cgid);
> -#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
> +#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
> +    defined(TARGET_XTENSA)
>       host_ip->mode = tswap32(target_ip->mode);
>   #else
>       host_ip->mode = tswap16(target_ip->mode);
>   #endif
> -#if defined(TARGET_PPC)
> +#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
>       host_ip->__seq = tswap32(target_ip->__seq);
>   #else
>       host_ip->__seq = tswap16(target_ip->__seq);
> @@ -3786,12 +3787,13 @@ static inline abi_long host_to_target_ipc_perm(abi_ulong target_addr,
>       target_ip->gid = tswap32(host_ip->gid);
>       target_ip->cuid = tswap32(host_ip->cuid);
>       target_ip->cgid = tswap32(host_ip->cgid);
> -#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
> +#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
> +    defined(TARGET_XTENSA)
>       target_ip->mode = tswap32(host_ip->mode);
>   #else
>       target_ip->mode = tswap16(host_ip->mode);
>   #endif
> -#if defined(TARGET_PPC)
> +#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
>       target_ip->__seq = tswap32(host_ip->__seq);
>   #else
>       target_ip->__seq = tswap16(host_ip->__seq);
> @@ -4111,6 +4113,14 @@ static inline abi_long do_semtimedop(int semid,
>   struct target_msqid_ds
>   {
>       struct target_ipc_perm msg_perm;
> +#if defined(TARGET_XTENSA) && TARGET_BIG_ENDIAN

Why restrict to only Xtensa here?

> +    abi_ulong __unused1;
> +    abi_ulong msg_stime;
> +    abi_ulong __unused2;
> +    abi_ulong msg_rtime;
> +    abi_ulong __unused3;
> +    abi_ulong msg_ctime;
> +#else
>       abi_ulong msg_stime;
>   #if TARGET_ABI_BITS == 32
>       abi_ulong __unused1;
> @@ -4122,6 +4132,7 @@ struct target_msqid_ds
>       abi_ulong msg_ctime;
>   #if TARGET_ABI_BITS == 32
>       abi_ulong __unused3;
> +#endif
>   #endif
>       abi_ulong __msg_cbytes;
>       abi_ulong msg_qnum;


