Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96525C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhWV-0007PA-F2; Tue, 18 Mar 2025 20:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhWS-0007Ot-BB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:43:04 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhWQ-0005Yb-PT
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:43:04 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso7247333a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344981; x=1742949781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Og/ff6+fR73Ia2iau4p+STUSwnhCCqsInKmWIj+XIFA=;
 b=KIbGN6rlgcLN3YvvLzMMjU85eAiIyfeUeFGs36QdLJOYqiIEwe2r0uNoVABsNpkrwe
 kEa68aAN2WMc08LfPgKSIP4oI7XSCiLRbgXNjRldfgZtP2P9zI2De+0o8DUxz2uVOGif
 OpVWQZ0B07K9QLKE5ROMpTQvaweOHq9NJHq4wu27vGAV97QilyTMM/MSS0Zy+0VX/0Tw
 Aa+KXRa+IVn4ntqefYEuhIkQFoQ4Pz/TVuidKm8Zx1dtRUui1bfb8zLw5+Nw/xG9ZDKB
 uSPI0GW8r6EgYpOddPkFJQVnS61rUeYPrqDiD9yN++Ib8N28R5Ma37C3INPS7oe49pPb
 SyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344981; x=1742949781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Og/ff6+fR73Ia2iau4p+STUSwnhCCqsInKmWIj+XIFA=;
 b=rXWQ6ZBh+3fHlrmZUzz/r35PRJr58h8hDw/GMEM7cPAdMf/oKhZRQVlOpHPf56OtUA
 X69zTZd1mjGYQUNCfCG/4IsH1yTrwfezEypiXQZbR3/6yp2WwhgdwtD2jpFdk1tvVjbD
 Jx6buA3HaqlmsrR6FNyQDwk0OqeEb9yWoWb9bFFXwYItk4BRf7AH1qBcEp3jtyPo6w/m
 kiuPoWBc+n830FJwED/YsxkICmpPWYwvUugE/XcM9ivQxxQhPVWisbCxGCvAcZCDRbOa
 A8bUOkbnSCzKAq2eotqJ2pHBxTTnRA7PWGJ++0B4ihyUWmMn/ZVKV4P8SQoQgPV+YQeQ
 cSBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRnzx/6bG8SFF1UouDvIpZafL4NpU6/6eSPAYd7vVHgSmTJKrJXKeReUJiOjqIvMwN4f4r94N6zyLk@nongnu.org
X-Gm-Message-State: AOJu0YzAaZWOJ6kmVH/4AodCzn2AT6jwaSrpAzecnie7PVC+BdbM3DEt
 CVS23m98OsxUm0JJmW6yB9BvmPkhlzPLnbp4y6R9nhsieKOcDwaZ+wr/MLhIXow=
X-Gm-Gg: ASbGncsDnEqq7SwRxTMx+mUvCrFv5iD+bm8Cd8FLuNxC1VHBR7XRVUbjeIvFjlz11Z0
 tyedNSAILJScRLSbRUUl3gvg5tqUYiqb1q/YCo3e/JN6UfFD03d1ydlOR5VQcZhmufSgO/I6d/N
 RRoZ3I2qOBb6gi1PGg2wygwmCf+kgBlt3lMkwkVwoInDysSeDCZHUvpnDz7YHjkB+c27k0kzk+G
 VeMMIXhAdUhCAU7bHYxPOfatUEB+LX5qeww8ZWGXkYu608Lvvqq9E6vLPjcm9pwGxAF3UlUqVH2
 IPCzWQ5JKcxWpolahlcItC+umkKMhf5VqmsTqsmppJS6dmoDI8nWONJKqA==
X-Google-Smtp-Source: AGHT+IEKSnTLFc/bb2wZlYAD//CKQ7jS2TXoS7RZGbcZCgpSLoYYHHzxOchM40l94W7mGQJPuaoXSw==
X-Received: by 2002:a17:90b:4fc7:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-301bde552b5mr1150137a91.8.1742344981116; 
 Tue, 18 Mar 2025 17:43:01 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf576c70sm164564a91.6.2025.03.18.17.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:43:00 -0700 (PDT)
Message-ID: <9b4724bb-d019-440b-9325-38f539e4941e@linaro.org>
Date: Tue, 18 Mar 2025 17:43:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/42] include/system: Remove ifndef CONFIG_USER_ONLY
 in qtest.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-40-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/18/25 14:32, Richard Henderson wrote:
> This is include/system, so CONFIG_USER_ONLY will never be true.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/qtest.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/system/qtest.h b/include/system/qtest.h
> index 6ddddc501b..84b1f8c6ee 100644
> --- a/include/system/qtest.h
> +++ b/include/system/qtest.h
> @@ -23,7 +23,6 @@ static inline bool qtest_enabled(void)
>       return qtest_allowed;
>   }
>   
> -#ifndef CONFIG_USER_ONLY
>   void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
>   void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
>   bool qtest_driver(void);
> @@ -33,6 +32,5 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
>   void qtest_server_set_send_handler(void (*send)(void *, const char *),
>                                    void *opaque);
>   void qtest_server_inproc_recv(void *opaque, const char *buf);
> -#endif
>   
>   #endif

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


