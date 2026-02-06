Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B6AECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBr4-0001zr-UD; Thu, 05 Feb 2026 21:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBr2-0001xg-86
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:45:56 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBr0-0004cY-Gt
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:45:55 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c6c67bc8b9eso595745a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770345953; x=1770950753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6WFKT9rWYIvi/odq3wdowm3aUVNnHQcbLFwBNRdFbw=;
 b=dn9+KwLuPcFWE1N1TTYNQTGrXXRpIBs8eEQ6LdzPyUTx5UwX1ZdNqrVoDhxXGkH703
 k6TqRO4zkl4WXz/rbyBq4uHRFs5v79207uIgd/lUgiaynKlqfDMfIU6TSQCsmC8FATjj
 GYhPkCaHP6f7PS/xbo2lMZIGANLk7w6fonhe3hp58oC3IPkakduWsLpIOd0ZLg2LcZlV
 kCzCUBg0uYQc5r5Ck3gvCl7tiwQ/RBsc524qWgVKe2nBIpGZ0puCkfAzqXXVvFpqz6zB
 YP/VeRs4Vsexwu1GIGFpVwRH2xKhCg70hsGKzWRXimX7eaVQ/yhowSLj8bkY8P3y5Wvu
 Qt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770345953; x=1770950753;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6WFKT9rWYIvi/odq3wdowm3aUVNnHQcbLFwBNRdFbw=;
 b=WBNdJkEyLGgWaNKbxVQPlPJ5pIRDrWPoVZEnl8r7GEAxc7DNoVV+vqnZSZL1NiSI7T
 zVYs5nJZS6t8ASRSxc6OfjJWE4/7hH5RlQ+qzowM4HfAifldZHbQebYjVlPKjBO+105I
 bXy8dUTfIqeHf3PsJnLF3mqcC/RiZ33HbhWcViGGRVkHp0Selz9HXg8N7XqGKB8glnLx
 VC5tdcd4SQkeGBZcboAoajm2PRWyWSHpFP0jbJCFz1uaFu5uINBR4jl5PAamZs+uwrYF
 ZVcN1mo0Ah5YNt8LGMzLy9kh+2VZWreLvzvD4Ia+r5ODqGCWXnAwOSn49bNGimZw4Cuk
 byMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt+wEdPA69DI8EVZ791CFo2fPdcXkPVV3Yg6PNdNNjIbeS3K5za25tGPHJShyrsf3ePCely0hs3zsP@nongnu.org
X-Gm-Message-State: AOJu0YzqXYVMTKAvl3MUqfuUb9fvnbO+J9WPJuNHRk4TorW40Tj5TCCA
 pnSjY5dpM9oOk/3gnj0RsB5Tyz5PoZfT6HrR4mslyX/T/TM30hdDk63vVA5f1mLnsmw=
X-Gm-Gg: AZuq6aIi0XgfPekGyJHePAyja/BLuLolkBYU+hDudCDQpj+R+O2f6OJ91MwRp5nTfKl
 3pub5QoKbeb3br3Hw22gzDrA+VqWZVkdTn19m3gPTXLYOduAQ0vWt7/l1M5gvZPt+/YeQrH+xds
 vVxLD/CoRBNpapajLG38kgHusl6a57k1/MxLSrJkXwNJGkzxb1Hibz8E/uYEqcs16h8aOIqV8/R
 YhbS+yTdKxWWc78rk/aqV7RI0Nucx5IQvNQjUQf4gylqrel6LDJFuozQltre8j6nefsQKyxbGo2
 YsyczLepH4wNTS4YQAuPGEweJOdVBbzvPt7CuUchpYXW/WF0mOPBEwf6NvP5klayBr3IlBJt7ae
 DtlUWiLz3/GTsaawSeuDhR8r3KGgYby43s+nHyFZvVNgOWhrrXs9FLT10R6vyIKXaBJ7+iMa5v0
 +gztJyWl+ZczcingnaXv/C+VP4AYBeYYU3Mms2bp/NuUM93dgEsN+4jVR3zsh/lDNsgmzuSUUfI
 Oo0Qymuyg1iGnC2PghTBUqgFzeO34zIHZK53oMIKXE=
X-Received: by 2002:a05:6a20:72a2:b0:38d:ed3b:87e4 with SMTP id
 adf61e73a8af0-393ad3ec887mr1227663637.79.1770345952852; 
 Thu, 05 Feb 2026 18:45:52 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb3cb742sm755197a12.0.2026.02.05.18.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 18:45:52 -0800 (PST)
Message-ID: <b5484b2f-34c0-45ce-9b5b-11a74986a16f@linaro.org>
Date: Fri, 6 Feb 2026 12:45:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>,
 Mikael Urankar <mikael.urankar@gmail.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-11-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-11-8d8ff0035372@bsdimp.com>
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
> Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
> format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
> rather than directly accessing kernel-only members. Handles FreeBSD
> 64-bit time_t except on i386.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index f35f682aa4..e7031c5264 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -154,3 +154,36 @@ abi_long host_to_target_semid_ds(abi_ulong target_addr,
>   
>       return 0;
>   }
> +
> +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
> +        abi_ulong target_addr)
> +{
> +    struct target_msqid_ds *target_md;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_md, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    memset(host_md, 0, sizeof(struct msqid_ds));
> +    target_to_host_ipc_perm__locked(&host_md->msg_perm,
> +                                    &target_md->msg_perm);
> +
> +    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
> +    host_md->msg_cbytes = tswapal(target_md->msg_cbytes);
> +    host_md->msg_qnum = tswapal(target_md->msg_qnum);
> +    host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
> +    host_md->msg_lspid = tswapal(target_md->msg_lspid);
> +    host_md->msg_lrpid = tswapal(target_md->msg_lrpid);
> +#if defined(TARGET_I386)
> +    host_md->msg_stime = tswap32(target_md->msg_stime);
> +    host_md->msg_rtime = tswap32(target_md->msg_rtime);
> +    host_md->msg_ctime = tswap32(target_md->msg_ctime);
> +#else
> +    host_md->msg_stime = tswap64(target_md->msg_stime);
> +    host_md->msg_rtime = tswap64(target_md->msg_rtime);
> +    host_md->msg_ctime = tswap64(target_md->msg_ctime);
> +#endif
> +    unlock_user_struct(target_md, target_addr, 0);
> +
> +    return 0;
> +}
> 

Use __get_user and you won't need the ifdef, since the size of the type is then 
automatically handled.

r~

