Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082AEC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgEo-0005BY-Te; Tue, 30 Jul 2024 02:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYgEh-0005Av-Qm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:21:28 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYgEg-0000DQ-0a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:21:27 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso2906429b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722320483; x=1722925283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjL85NotHQ8toPNIHmMePxXJ4iOtZCFRVDauIFVf10I=;
 b=Rr+0l29fXbnO84yOX9ur59dB5MKaqDNNSRpK3BO13v75xbCE19fK/+9EMzbywZIzZT
 NYtcS/UwB527HojHHWMW/MFnvVs/bZtYgeQCiOwvsiRHzlqM1LW2Jg4+AJNmAOJndcAl
 catMukDGA03mabcNZGmgJMcAYg7N3FCZpdKv/cIO9HK2X6K073IgpHMm42WJ/wATrsX6
 VJiV1nnTyxq4GDTgyiJhriVmGGIUoDx2bujOAS4OpbSkYf6L7dsb9vRXn1sebugJcnKx
 IfgpP5iUregwc7jE6l9LSYkBZ4T5ATNubp5Py5812kd5GHCz7aQl6gOEM5ixWDuRKdLN
 REGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722320483; x=1722925283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjL85NotHQ8toPNIHmMePxXJ4iOtZCFRVDauIFVf10I=;
 b=C0uRz03tzBsanSXRYE9+aLEai/cKGb1gLEWlUrwo15XxcbtN2Jd8NbUgmueKv+xpPP
 3TElf13On+d8cpEF1SdrG+KFxyF11I2Qs0oA8yZaAR4+i/MwQmwTX6omiepyoGmfQke3
 m+3BOMq31B5doNI+LxvVBiuqLl8bIQSUpHrooCRt+HK0RtOMKMkK0DuwXRmJs8V7rbEb
 E+rU4kQF3ezfhar09KO3ACQcOGwvR9++NkOz4XeLegSe23RyDaXZ5B86mVyPKh52CxUN
 jXhv0Ig7yl9B6AeYHuzcUaoMCf8zcj/UdG7s/+W852umtEFgHkImFCaLHSUjXr3ixud1
 PiYw==
X-Gm-Message-State: AOJu0YynUpWBNn34o3627lDSajetZTnt+kUIyNrU7/f/y+HRxHX/Pnrw
 jyDQGzLQYa5gXevuXZBMuwRC+9IsIk2DC2utO+tR/JsWn0BKjQCKrwVt5QT7yON9k7x5zewNU8f
 PQ5w=
X-Google-Smtp-Source: AGHT+IFCs+PU6taSDcEhic8kT+WDt4N5h30tgUVFNOrEp/eMCiwiN/BKkcRoUXz5TT6paHJmLcGeyg==
X-Received: by 2002:a05:6a00:10d1:b0:706:726b:ae60 with SMTP id
 d2e1a72fcca58-70ecea2ef33mr8179939b3a.17.1722320483345; 
 Mon, 29 Jul 2024 23:21:23 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:3e4:c598:8b5f:3919?
 (2403-580a-f89b-0-3e4-c598-8b5f-3919.ip6.aussiebb.net.
 [2403:580a:f89b:0:3e4:c598:8b5f:3919])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead89fda1sm7729278b3a.191.2024.07.29.23.21.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 23:21:22 -0700 (PDT)
Message-ID: <09d0813d-e2ff-4ab9-96ea-a096306a4ed8@linaro.org>
Date: Tue, 30 Jul 2024 16:21:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] linux-user/syscall: introduce prctl for indirect
 branch tracking
To: qemu-devel@nongnu.org
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-9-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729175327.73705-9-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/30/24 03:53, Deepak Gupta wrote:
> Each application enables indirect branch tracking (forward cfi) for itself
> via prctl. Adding branch tracking prctl in linux-user/syscall.
> 
> Using same prctl code as proposed in cfi patches in kernel mailing list [1]
> 
> [1] - https://lore.kernel.org/all/20240403234054.2020347-1-debug@rivosinc.com/
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Co-developed-by: Jesse Huang <jesse.huang@sifive.com>
> ---
>   linux-user/syscall.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b8c278b91d..ec157c1088 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6295,6 +6295,17 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
>   # define PR_SME_VL_INHERIT   (1 << 17)
>   #endif
>   
> +#ifndef PR_GET_INDIR_BR_LP_STATUS
> +# define PR_GET_INDIR_BR_LP_STATUS      74
> +#endif
> +#ifndef PR_SET_INDIR_BR_LP_STATUS
> +# define PR_SET_INDIR_BR_LP_STATUS      75
> +# define PR_INDIR_BR_LP_ENABLE          (1UL << 0)
> +#endif
> +#ifndef PR_LOCK_INDIR_BR_LP_STATUS
> +# define PR_LOCK_INDIR_BR_LP_STATUS     76
> +#endif

This will of course have to wait until the uapi lands upstream.

> @@ -6477,6 +6488,14 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
>       case PR_SET_TSC:
>           /* Disable to prevent the target disabling stuff we need. */
>           return -TARGET_EINVAL;
> +    case PR_GET_INDIR_BR_LP_STATUS:
> +    case PR_SET_INDIR_BR_LP_STATUS:
> +    case PR_LOCK_INDIR_BR_LP_STATUS:
> +#ifndef do_prctl_cfi
> +        return do_prctl_inval1(env, arg2);
> +#else
> +        return do_prctl_cfi(env, option, arg2);
> +#endif

Do not combine 3 prctl into one.
Do not put the ifdef here; put it above with the rest, e.g.

#ifndef do_prctl_set_fp_mode
#define do_prctl_set_fp_mode do_prctl_inval1
#endif


r~


