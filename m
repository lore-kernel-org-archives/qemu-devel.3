Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1400AD1D48C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwPj-0006Kt-KN; Thu, 08 Jan 2026 15:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdwPc-0006GQ-FV
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:15:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdwPZ-0001Li-Vt
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:15:15 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c13771b2cf9so2577017a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903312; x=1768508112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r/FIof0CkpaoXxGLitfqWpYgvt9zO1PQH0geDkZpq2k=;
 b=exFNFwcAfpkKir4a36qCwdVfJkJsNc2Khvaa7B+UNfuwYXhuhyDk9nhuzpHCTb8qn8
 GVXI1UxsAhopnXnZNFokrlEeyO2Q2eQq9FpaJNFlWASu5fyZGMpdHHs9zxCxaQJru5ok
 zFlwXTiakHbuB2RptrhOIONEyhDNxG71JxKfNUx5HdolP3lW+VEqOHNIpsIq9Ao/Bf04
 YGmNVp0PH49/CLqJfOoPjB0PzFQrwKldlnJxGzvCP/r7lPflYIgLpy4jW4VkvHKSbyZj
 8/V3+wI+EURWTjGg0bG53TnmYO1xD9oO8G0YKqRF/sa1u37kFwZoMHI4U9CKA1L6Mzd9
 rrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903312; x=1768508112;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/FIof0CkpaoXxGLitfqWpYgvt9zO1PQH0geDkZpq2k=;
 b=Nd2JesrYGd3t5FpEa679UO328PPimYZ/lnTaGH0FIO3nNMxFGp0ekuSctcI7tjRe4U
 jzI/YJQEXIPnCzt9VkoW3soXumarVn3GhaJKLCbpBXHp4omrPg4pIfleu4Yhd90uJfGJ
 BZ8wEOxgYWzGwCU6l2uZ7C5fKKMb4UyxYVL544z2gtFQzOUuv39HUaljA4w4jCQrv36O
 dBiVvJ9X/1sySdMhqVgQiaCXNqQTFLRQQRFl5Q2ZUILAqNXeg6ZtgFd61+PRzeviLGS1
 fiwNvX0ONKtO9U97xOFeQpOa+wjGojDk66MJaYlXwtR/9DQTB2yovMuv1olwU8i7tMLe
 1Caw==
X-Gm-Message-State: AOJu0YxSpFf07rek+jmRaxaPHQrg5r18nE2qyl0uvr6XQryMNWMIpwbG
 TCi+1RtAhYstF5Wc1pbF558q4gKHIUuj5R8RfNvnjDEi7Dp63lSmx9wNsPCHmgqb4K8TO9nJnUg
 daKWzJcJ7rA==
X-Gm-Gg: AY/fxX7EbQ4G418EI/g2SySn4iCXJoc9L2PZN1bgyLZFHbUxw6DQ52AfNq83idb3obM
 24/tLv9P+gcC1DmtMih/gOxt+aykeKO0SwuvKxeOAi1ahH+zTSap9591pp9wlagrzgnplial12R
 R+V1mil9B9Ux2q1P2pDdL2Ar0iFl7SCQvK1nLnIWF8yPxJgNVaeGY0rDg+jjO7ItshOXbtqjQeK
 XsfKxsXQLJ3mOiBnkyh12YzH1V/y6Gxc47att1oD7wu6cW4JnAaixABJ2iRLjtLqM+szDyl7bkL
 CdJLPJR1wdBa3Yln6wMaEZyEcjSdBJFk3zsWMFEZfiHJ4eOSgk7K7i/yOOVLqVeuqvzIuKrSbkp
 lg+8/Y0Nq2mXTJrcu3MOOF11s/d0PX9dgj4yhpVRgr+J1ycKCLYy15PDmRCxXodlUeV3dUXVO7f
 ORk2HxJ/+V4jRMCXqGaL6Vq+dMUt/Wew==
X-Google-Smtp-Source: AGHT+IEGDqtxwlCsHa+Cg4Xl9/fdjsVZB02bzazXlDc/15WPeKeQE26SM8H2ra/IguQkE9b/nklSfg==
X-Received: by 2002:a05:6a20:258e:b0:352:d5b:c427 with SMTP id
 adf61e73a8af0-3898f88f227mr6914189637.3.1767903311982; 
 Thu, 08 Jan 2026 12:15:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a560sm85337995ad.21.2026.01.08.12.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:15:11 -0800 (PST)
Message-ID: <fee59a5f-e917-488d-a89a-1e5cc264fa0b@linaro.org>
Date: Fri, 9 Jan 2026 07:15:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/50] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-5-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108053018.626690-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

On 1/8/26 16:29, Richard Henderson wrote:
> The target test is TARGET_I386, not __i386__.
> 
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/syscall_defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 52f84d5dd1..68b7860e30 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -247,7 +247,7 @@ struct target_freebsd11_stat {
>       unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
>   } __packed;
>   
> -#if defined(__i386__)
> +#if TARGET_I386
>   #define TARGET_HAS_STAT_TIME_T_EXT       1
>   #endif
>   

Gah. #ifdef.

r~

