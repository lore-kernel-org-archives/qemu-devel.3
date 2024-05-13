Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E85C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ths-0004SP-KL; Mon, 13 May 2024 07:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Thk-0004N7-7W
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:18:53 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Thi-0005pk-DN
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:18:51 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5a4bc9578cso419655966b.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715599128; x=1716203928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibQ85ixNT9G40m/4MLD390M5q2qqcr/yhfHtGtGw+h0=;
 b=J3Sj+JD0OaKqmNTbex44xq/kocF2k1oHs0BmZKV6DD4Pomc71vsmlIBaupZpjeVp2U
 WWLsCOY187Fv/Mf9kfFFD/V+RmN3XHUTcWERfcOmhLv2kj9mWWgJYb8bUtDOJNkG20FG
 4+vMd8qnotT3mlrQY9TyF42Bl0XYY6Za7idwA61VHJX+DQ3IwVrfSgRWS9iYnugRHUY+
 JQLaC9wmj9nSZcq8WIKFLTwJ8zKgXW5e5L1BSSOrezXTdOEMNE8qoRO9rACxeriK8kfk
 88N7QQMTeeB32fbo655FfdD4IcfjrJArMLxWtTGkmr/4f8/PeXfv9QLPVtJHkQ0ogvR9
 IeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715599128; x=1716203928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibQ85ixNT9G40m/4MLD390M5q2qqcr/yhfHtGtGw+h0=;
 b=we0d2CfunFc615u11aKMKTVOjc4JKWnMJoFe6po19QYBRQ8Ry1+RnU4rR2zdBQKuBS
 yekkqR/7SUB02ZeDq8ZgK0PzMcuaT0nqAWYVsc5Tmed476DI9OmZTk3ftL9nWlf/Vo0e
 CV3XMImbYiPTmTCsqObCWWbZ4fOkmUqNlhrqK6wPYdFTG43OcM6sGgNzRxosE3BMdwbk
 S4wWuu6fvEzlv+scgXGuwKqeZUqs0kXJgFpAZkXy0AjUweX6wueASrMThA+zo/WFMUS9
 5pg/cl2j37SANvUpQWuQQL+Ai26fxV8nLp0+6ovM/sqefmXgismAaNVdmvwwuTWGOI+t
 f26Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURAlKDNng/gCRtmRTOxT201fqNq6sBWYCbSMtPFkj2ZeDIEG5l8/GhKqwHfCWOTk3LBSTMZMZAyhfMHWk0638LI61lOUU=
X-Gm-Message-State: AOJu0YxK/VVYwLhSx7GkXwg7XOE9RyUvTlXue2vP35nezgWZtqkwA+qW
 Rser/vyfZcJgdLQRrUr7JLJzaAiYu7Q4v1v19LnTQ6J3AT1sqPFHgEI7AzTD2zz5i/600Nfw3GK
 TCvo=
X-Google-Smtp-Source: AGHT+IEwXAgo6xmU+A6t52pHdggpgsx+BMid6vQjj1lheZ1wiWmLpFH+hJPYer/cyZaBMBVpm4vKvg==
X-Received: by 2002:aa7:c997:0:b0:573:5c4e:cce6 with SMTP id
 4fb4d7f45d1cf-5735c4eccf8mr6091550a12.42.1715599128413; 
 Mon, 13 May 2024 04:18:48 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7d6esm6113521a12.72.2024.05.13.04.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:18:48 -0700 (PDT)
Message-ID: <c9942efa-4f3c-46b0-b29d-9e4107314c58@linaro.org>
Date: Mon, 13 May 2024 13:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/45] target/hppa: Use umax in do_ibranch_priv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Richard,

On 13/5/24 09:46, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index ae66068123..22935f4645 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1981,7 +1981,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
>           dest = tcg_temp_new_i64();
>           tcg_gen_andi_i64(dest, offset, -4);
>           tcg_gen_ori_i64(dest, dest, ctx->privilege);
> -        tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, offset);
> +        tcg_gen_umax_i64(dest, dest, offset);

Isn't tcg_gen_umax_i64(dest, dest, offset) equal to:

     tcg_gen_movcond_i64(TCG_COND_GEU, dest, dest, offset, dest, offset);

?

>           break;
>       }
>       return dest;


