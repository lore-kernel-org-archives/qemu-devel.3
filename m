Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D473DECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBqC-0001o7-LR; Thu, 05 Feb 2026 21:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBqB-0001kX-C3
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:45:03 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBq9-0004C4-Hh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:45:03 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a9296b3926so12829935ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770345900; x=1770950700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SZgalafTouxPueAh052GFgD1zIOf9ajKKbZI69fKgMU=;
 b=XfStVsJ2DYYtS3Tmnv4mueO3cPtG8Lolpsl6eBv/DZydz8aKpCArCfAtyrL4fpiH2p
 BgeCQjsRSiob7LfeU6A+BvFN7OAHlO/IrLNgObLB2xZ2qv8VuNyyA7FU4hXL1lcQKSxi
 vC/ASwKnAsbjWOAsIvQovZ/r8RyuGDzyIk5TFCHM64f3ZdpGaK0ZYpvv1Fkxsgt60YpY
 Y14DhdjCOlEHPGCGIOHnIz2K26afUrEPTNsUqnBn/ubb25ix6Kl6s+23uR9yZo9Ow78k
 3LrUz85r7GWT068dCREbn20h7h+Z4LF5ezY5gsgX5TqrCBpIROhcHjLmsyaRIxqw8Mr9
 ajDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770345900; x=1770950700;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZgalafTouxPueAh052GFgD1zIOf9ajKKbZI69fKgMU=;
 b=uoR/KGncNL3V1LvMfBg1zaZKWT9D1la4EQrSQdTEPLx/naTToCaz/7c2mJVOe24lE5
 T2TI5TjpWHhg09y8GUhFa6Dm+r9WJ8lbkSrUDovNWOE9hzo1aT/O8HoCQCzo9cFzJOPK
 wyzctbuBW1KwRmorDA3Y/ex1QUHWCuLRkeUc+RkmFv8C5tm13q7o9WInQEFKGyp+jpNl
 fmdqnaviZYkMPSlexOcTeqS01IohT2vzPFngvVbKpu4uFuoAmFtd2ZzHsNOQ5VArj34t
 svkrGWrGCQauf6+EwnM3Qtu/41DUnNrf/TKSn5y33faY1Itq7BQ+HAZw/ZGoCs9vhg8o
 VGkg==
X-Gm-Message-State: AOJu0YzRL+mu1I4PId6d6NK5h753W8hPaoCIijw59t/Pcf6e7G2iV7FI
 jzmHyf6NCjtcGOe3GDyydDg/EzGLYIrEixiGuTjxSIeH5XRnDstzE5oN1eQTO/WSai+idKjVVLA
 TcNPMhbXrWg==
X-Gm-Gg: AZuq6aJcJVeA42G2uQtaJhVGy2oeR/103foBEBL7Vgopjy8EUGcNUhYwzaXtpqzEGKd
 ubaAahHLF5hhMZOobjBnqA24KauBuNLQZcD7/LAaiphKLHdvbpzyyX5PpgbXwLJqMG1AAQxTHQD
 AvE13F7WUAROpcDKy2w3tcyjdMqvUfmdKFrH/q4wpcKFGK4kpNXHFXABr7acPFwNRqqFNwcmHqH
 Pazv89LaecNN83lPMX2qZh6vLYQOGajKS6HKZYfLRoB3hY822rTofr+buYc6B3whtouKUn1VLJD
 8/kB+hr8gqPnyehWfnAhezAvgdpcL5UBU412z4+80MHJMOWoYbUBUoUPfssxigS+at9H/BeDJHN
 T2peCnnJpEMH/7gqGz8uBP/lurxSoO0/xxNILKkqJX2GCOPBqNXf8z9Syv9VtT+OSOASGbPX7Q5
 xQB3m5N6cqnfdtc+0DJwLXLyfa9Ep1ugUExh4inXw/Pcwm9+z37/7CbfqLHH1cy+peXo/IDz66m
 Ize8u+/4++UHDhqLPaBy4LQS/TG6XHgf6MITDl6EjM=
X-Received: by 2002:a17:902:e54a:b0:2a5:8d30:58f7 with SMTP id
 d9443c01a7336-2a95163727dmr13857175ad.17.1770345899788; 
 Thu, 05 Feb 2026 18:44:59 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951a63901sm8988605ad.18.2026.02.05.18.44.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 18:44:58 -0800 (PST)
Message-ID: <3522bd10-74d2-4873-b045-9682d2dbf4cc@linaro.org>
Date: Fri, 6 Feb 2026 12:44:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] bsd-user: Add host_to_target_semid_ds for semctl(2)
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-10-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-10-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add host_to_target_semid_ds() to convert host struct semid_ds to target
> format for semctl(2) IPC_STAT operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index 581eb50355..f35f682aa4 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -134,3 +134,23 @@ abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
>       unlock_user_struct(target_sd, target_addr, 0);
>       return 0;
>   }
> +
> +abi_long host_to_target_semid_ds(abi_ulong target_addr,
> +        struct semid_ds *host_sd)
> +{
> +    struct target_semid_ds *target_sd;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
> +                                    &host_sd->sem_perm);
> +    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
> +    /* target_sd->sem_base = h2g((void *)host_sd->sem_base); */
> +    target_sd->sem_nsems = tswap16(host_sd->sem_nsems);
> +    target_sd->sem_otime = tswapal(host_sd->sem_otime);
> +    target_sd->sem_ctime = tswapal(host_sd->sem_ctime);
> +    unlock_user_struct(target_sd, target_addr, 1);
> +
> +    return 0;
> +}
> 

Probably should use __put_user instead, but this isn't wrong.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

