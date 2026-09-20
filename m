Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A6DC982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ppu-0008Fh-P7; Sun, 20 Sep 2026 18:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Pps-0008F9-EO
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:16:36 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Ppq-0003jy-So
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:16:36 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1781161a91.3
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789942593; x=1790547393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ssobi2S5kqPLuVlsNtZkMYsJk+ojZRJu3bVO3/wAV8w=;
 b=SpbCjmcBTx9Lu59d0uX3enN0jJoxMnOt1sHyFyJjhCHZNU1qwuxqD4AgM0OHtZ3gVK
 MN04zY5sagopW14tjT8+tIyBEPD9Fs3LaRDG9ZW8Xp99U+iLFAZcI7b0auw/zZkD3uUo
 FIocmnZAONbGrunyzZLg4h3ZG4R+1O3KCyD1nOkC2ccf8SFC7j6iRabOgWPGWx5BWcwY
 YTuHZjJ2KW/zbzIol+KQOMvpA8EIYz4Mgh/LFRTq/2jHZplIZeIq+XuZ9+0Xao/0HD1T
 gJTPFHMFKS3bMwtKGIBwMqZuyWeB0CvBKL7JtwcLQmJt0tcwUUdOgCPXZZsRQ6XY8RFd
 ulwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789942593; x=1790547393;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ssobi2S5kqPLuVlsNtZkMYsJk+ojZRJu3bVO3/wAV8w=;
 b=az+9GoAlVS7Z4hHQKamUzBTBBraJxhziy5D4BmWnAzr0h7twRdqLP41WCoiYzl9gSv
 9rlvAAqCEg4Xpaa7EIlhaTn3pJ0v2yQmCMjfnHKVVB0wVHo3b/hJ7dPfHEuRsYGbxu/4
 nSES8uxMwmWi2U20qyJBGA1yf59CX2spdPxEXomrKlxV6YO3tUKmvgqAxEqzuLrbXSMR
 tRG7b4n+l0Pw0wggb8E7WCMKgjM9HAhuLSoZnycTHVvUklWzbasjm/2TpAaMzB1yJs4f
 plnoF9bAH6u+i01bkOHwG2q72EEPq8+Km/n++wK3Hy9HbEZ0fZMVBj4nzLzWyH7Q4k/h
 Vuqg==
X-Gm-Message-State: AFuF++kmt3HGXxhMQ4WJcLUGRYDdlIR5+lkd+2gO+RT7qvgR3IZwojyG
 X8vsFv1828XN3+gJqmhKgmVP1Fv6HJxXZmN7SN7zn4CRrBaLQkjiTZkfFXRXJHmYq/3vW+d/Bcs
 K3j4+iOA=
X-Gm-Gg: AYBFou1NWtmcIy/BxKkn/DQH/w6g7jnEM/0oeWFJZyDzeJDosHNRYgx6CdK7rv7InLo
 Z0RcjedxPuVKQ1vDCnLjU5yt10E2n7Od3V2GTx4khqGz4t38pJ9hiaw0p0goSb4xEs75Blr/zCU
 myVgmdTNJNYBHfsZFtF2lDSx2AjZnHQy0qRwZGg2HVjEmIn9mI4xEPGAxQXLw5KQ5N544rKLBdU
 3YXzepKHHMBgB+Th/VCcH+vuVurBT4uqzDp5lZ57UpdU+zul8rAeNsWIF5a9VMJSVpEw3JheOWg
 2FdVdRxJEbULKRfjEC6hN9BmMDmbVirm7tBqZ3QLt7EHbnBAu+r7/u0GYGXdSNbzPNx0srmoBiU
 18LVILr5rDEpzI+VwF/cAcTnJga5A2WjaygGjiN3vHLlODNqL2QlxA8kLJeg774CrtnvgYilW0F
 J+2d4wyertGl4PhoRD8E1tCAYLMVy2YBuFrWhQSDXG1PO8w4jgyLn0iUskfrZXpzenzvnEwcah4
 8buy7XujrRITNg8ory16X6QVgWPFn/ef3YIFW57ymvzL/pxALZUWdNFMKZG
X-Received: by 2002:a17:90b:1f90:b0:39e:4c7f:7306 with SMTP id
 98e67ed59e1d1-39e5504d02emr14787166a91.29.1789942593259; 
 Sun, 20 Sep 2026 15:16:33 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3313d907sm13753038eec.11.2026.09.20.15.16.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:16:32 -0700 (PDT)
Message-ID: <f38d17d4-f4cf-44e1-b606-68d6f4faec5b@linaro.org>
Date: Sun, 20 Sep 2026 12:12:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] bsd-user: Fix MAP_TYPE definition.
To: qemu-devel@nongnu.org
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-8-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-8-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> The 0xf I think was copied from the Linux headers a long time ago, since
> BSD doesn't define this. In FreeBSD, there's only two bits of this low
> nibble that are used for the sharing type (linux has 2 more types
> encoded in these low bits). The kernel rejects bogus flags (0xc part of
> 0xf mask), so it's better to have just these two bits here.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/syscall_defs.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 506aea3e27..c4fd5f5589 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -121,7 +121,14 @@ struct target_msgbuf {
>   /*
>    *  sys/mman.h
>    */
> -#define MAP_TYPE                        0xf
> +/*
> + * FreeBSD doesn't define this, but Linux does. In Linux, it's only MAP_PRIVATE
> + * and MAP_SHARED and a few Linux-specific types (0xf). FreeBSD allows other
> + * types of mapping with MAP_ANON, MAP_GUARD, and MAP_STACK. The mask on Linux
> + * excludes these: They don't have MAP_GUARD, and MAP_STACK and MAP_ANON have
> + * similar flags with different names that aren't in it's 0xf MAP_TYPE.
> + */
> +#define MAP_TYPE (MAP_PRIVATE | MAP_SHARED)
>   
>   /*
>    * sys/time.h
> 

Needs to be merged with patch 6.

r~

