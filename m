Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBB5C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaeo-0000V2-Kh; Fri, 26 Jan 2024 23:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaem-0000Ud-Sx
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:51:04 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTael-0001Ey-Da
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:51:04 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d7005ea1d0so705299a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331062; x=1706935862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Szf1Wp/RxsOxRdiKYTeWSH/x9AgUlF49i0UVXxrYKXA=;
 b=NsG5YApWM+YQFBHISQquNICSKqx6c35GG3rnVoeRcXJ7mNj+wea0SBFTXrs6DGeqDy
 UZpeEwqGd1vBDXSMyAa2UP5SzdSY/cc3uew0Z1PzLcORuib60iupMcRtP7RT548Cy9oN
 clg0FsQzrEo7XhmukEM2Iw7banRBGgKWdOHfpq9rIhCXWfEyJJQ2x4I8C0+UcWkOTkv0
 K44zm2m2CgorWFeIZ8EJIHvlA0GuANJVqYQnPBNjnbdYXvB+QvJMWcAtlnE5dck/TeXK
 Y58B9fcPyLqy+10+Ae8RcldNA8xbu0XrPSdrfJKd9b+5o2BxH38FlxuWrlW901x3m+ZB
 9R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331062; x=1706935862;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Szf1Wp/RxsOxRdiKYTeWSH/x9AgUlF49i0UVXxrYKXA=;
 b=V8PcPFX81+uLPl5zeb8zCveMyaA9o1T0naCo1Ee862C+vaXXECIEpGHHnnNHVwmYdn
 rk000d5I24t6QQAlL1g/kHPcEJrFLhhEiiUeR9lm3usQVzh3ul4N0XdTSuNhZm0mGM26
 n+hW7qlh1lDETwpGXJDJ6pDf5NijKuyF0sbiWJ3Tl2FEy+z0+4qKQ1WsNqDCPCYtcG4/
 w+Ys+K87tUCSVCiHGcS9O//o6L0o0RBEtiycpmn5pd+FJt03m4pvK5cnWlubReW7bH0Q
 pUHE2Qm/7LklYstxgN635zviptNWT/WIkjh3V3e86c9ZwguhwA39WPVBQMVORpfQ1mmg
 WMmA==
X-Gm-Message-State: AOJu0YxnHqrF/aJO7dLGf7IwXgDDRMUSMeHdW4Pnsy4nGz8Ig6RcgBZl
 JFXFxBsgJw7nKfLMbx2uwuPcHGDT9+wIJGx8Kd50tje0na/+oamqVBvjPY7iLM0=
X-Google-Smtp-Source: AGHT+IFnGp3ZJBOsUHGdJ2CuXh0yh8DLqGzQ/n2s/sPy1h97gA2qzRGuYLoJjZ+rCyLaJzbsf7Sy2A==
X-Received: by 2002:a05:6a20:3805:b0:199:d02a:9565 with SMTP id
 p5-20020a056a20380500b00199d02a9565mr918353pzf.19.1706331061821; 
 Fri, 26 Jan 2024 20:51:01 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 h13-20020aa79f4d000000b006d9974a87fcsm1882908pfr.215.2024.01.26.20.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:51:01 -0800 (PST)
Message-ID: <aa1ec084-c189-4600-a02c-1fed90d18288@linaro.org>
Date: Sat, 27 Jan 2024 14:50:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/23] target/tricore: Prefer fast cpu_env() over
 slower CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 1/27/24 08:04, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/cpu.c       | 20 ++++----------------
>   target/tricore/gdbstub.c   |  6 ++----
>   target/tricore/helper.c    |  3 +--
>   target/tricore/translate.c |  3 +--
>   4 files changed, 8 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

