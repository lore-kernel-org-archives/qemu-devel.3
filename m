Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B2BC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlF9i-0001zd-0s; Fri, 15 Mar 2024 17:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF9g-0001z2-V3
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:31:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF9f-0006Vw-GH
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:31:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so2317093b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710538314; x=1711143114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5A1YaA3bpC6ns8VDHfgvuE3YqJD3z1HczRsfEVw1VwY=;
 b=Ty2lsMmolYs93WcEVm+fmKj8VDNJF1ZFLCKWjRceSAQv2M5TAhnz5I+mT3FUc7bYug
 3y6KPQFr7vorvbZyPuynTUF+PCQkE9hYAonY9MFcrmYAf51n/BYktyEjEgzI+KF6fpcW
 YSN93deIDlqIUcOwji7/qDSd8ImW+QeLjEZXVmUp+o9aaZb7U2Tijk1p5/Zv7muaPQOF
 2MpcGEwsQHuquNJiYTCbc0qHwvuatXDgHif2PmnbzhRVzG9YPgtz5w/m8ZJ2z+Y8kpA3
 DxwTo7tbSRNO2Jr47JVUXYc79xo/sGFKgPLyPUQTWwYcGk2VNnHEB9LucjMp0H/Oqw2S
 lQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710538314; x=1711143114;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5A1YaA3bpC6ns8VDHfgvuE3YqJD3z1HczRsfEVw1VwY=;
 b=LhmwUvNKjaZKhyYDlHsSpiLP5y0RePkT4IQwppxZ02O5ng/Za43akDKbxW3AxSLzWv
 z/IQiIJV0pWrBJ1ZkoPLovPX6aSgxSdkXv60Mj7L+wTxi82ftFQ5P+x9LLrKDL8O8imp
 MKwHfAEpuohmvJ89/F+ER34BFMHssVjYSZvVAkTADK+4K4JGaURofyONjVQCe5SIGr7o
 52StowwWvHzS91Ip6hkHfzi++GJULQoiqPM579GgJuUSD5C8oJFu/sPGMh0Ua6jQyb7f
 DSaZtA7aH7bcEO+zrlzNCq2ReXJR0v6EjOSmUP36H76aUpn9b6d8yAL7FD7H4U2Nk/bt
 Fk+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTQeYr7KHWpEFbu9lfs4NbCborZXRzEftPT84q40fJyxw5NHarIhXaE+65uVSUrjwIAdCu7KJcE5+EoRU+NXmsZepi6cw=
X-Gm-Message-State: AOJu0YweQMZQvY6uLeZSmu4aEoc5uRcCEQpEk5eb3UHX2C3RhlTmWU39
 nE7sAKWPybRmULokFYbmhfnXcoCm3tg1fUoQAEfG2G29kP3QfFORyFZQhjAY2BA=
X-Google-Smtp-Source: AGHT+IHTeU24YXdfhKWtHpsY8pYJHBvZdGNdNrgAXOTIiQnyyCnbiUg08oQR3s+QTKB/GWWkurXYtg==
X-Received: by 2002:a05:6a20:9147:b0:1a3:5606:9875 with SMTP id
 x7-20020a056a20914700b001a356069875mr7291pzc.4.1710538314115; 
 Fri, 15 Mar 2024 14:31:54 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 r8-20020a62e408000000b006e64c9bc2b3sm3962473pfh.11.2024.03.15.14.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:31:53 -0700 (PDT)
Message-ID: <99d40eb9-1f74-42f6-bf7c-9db2de018598@linaro.org>
Date: Fri, 15 Mar 2024 11:31:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 11/12] tcg: Remove unused CONFIG_SOFTMMU
 definition from libtcg_system.fa
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/meson.build | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tcg/meson.build b/tcg/meson.build
> index 8251589fd4..b5246676c6 100644
> --- a/tcg/meson.build
> +++ b/tcg/meson.build
> @@ -42,7 +42,6 @@ user_ss.add(tcg_user)
>   libtcg_system = static_library('tcg_system',
>                                   tcg_ss.sources() + genh,
>                                   name_suffix: 'fa',
> -                                c_args: '-DCONFIG_SOFTMMU',
>                                   build_by_default: false)
>   
>   tcg_system = declare_dependency(link_with: libtcg_system,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

