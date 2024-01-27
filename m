Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BD7C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaTD-0004iF-B9; Fri, 26 Jan 2024 23:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaTB-0004hi-DD
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:39:05 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaT9-0007Zz-TN
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:39:05 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d62aab8fecso969101a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330342; x=1706935142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=le0H8gaQkBD7VvKHeuxHvCVhj7ywYthEe58MKkyHS30=;
 b=CS+mVa9i74Ctj6er7hS1HxuUFrM9Mmv8NUPXRJd2IwsVHSdMYykWpSaiTSA5K5noOW
 E9CKfzsTLNkSlTOBdjtoTgrTb00TwCywz9eNIFjUBxyLNjxYvKK6sQzwS4UOj3TesyTg
 c0W1o2qlKNdjzwpe+tL9wSHbmqcATa94Ob/GAWL3ltjjMptIUtbwnMD3cl0u7USkZVAJ
 y9btJHoai/zmYsUlXmHBjete+9suLo+0xi8QQawkw9yZPLW3v5DYC2aDLMfHPv1JspGX
 qc/tu8Sbtj6c8Ubdp6cj4gcdlC6HOceHWhegVW1yZqPHxV+1/fZmoGLIRXyJP/KzMZJo
 CldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330342; x=1706935142;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=le0H8gaQkBD7VvKHeuxHvCVhj7ywYthEe58MKkyHS30=;
 b=ZEn1Hv1D1w0TWbB9YpZsYAfi/Ad+9LhA5rD7hTPII5wWYy+G422g+LYlT5KbL6I6Vv
 4akmsYKJFapw3BZLJ4Ou0BjH+UeIBvmE7MjFsYFnztylV5ndBHnIvDYDXRs+3gJB/X6V
 d14/M+oCCp7jrh8XOmIAFsd6xYGLSRENpaXq0LjFa5FqJy7cIYdH2v5no7sJqmaaMXNM
 Q7E3mkM7UdjXSRUp5H/Ef0CoBp2DkJPAdoa49g+B6DCIhqUDc7Ba+4zwA4YHlkxjjkos
 kjL5J1R38KBNZh2xSNk+g5RyJ+EK13Qf/2nUmuya5eiEu49hB5GoqatIaciSXhjJg7io
 uA8w==
X-Gm-Message-State: AOJu0YwrwTBTTkkqw/RZ3H73Hz0uR8rqf/InMFcERSXpmXKHC2fAOxap
 ts1ijcGPhjMIR41/K21czjUFTo+JSKU8xF/Zq/f6OBzvcusllgPFNRSMxjCKXrQ=
X-Google-Smtp-Source: AGHT+IGyVy+av6LkWCVcNlXM3A6uiDQtiN6Vx3N+Ikgxzd4G9TAnJzGj04WU/+e6u4mLxAJ2hHehSg==
X-Received: by 2002:a05:6a20:7da2:b0:19c:74b8:3309 with SMTP id
 v34-20020a056a207da200b0019c74b83309mr1236509pzj.56.1706330342257; 
 Fri, 26 Jan 2024 20:39:02 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 p30-20020aa79e9e000000b006ddd13c09c7sm1924769pfq.172.2024.01.26.20.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:39:01 -0800 (PST)
Message-ID: <f6cfd36f-32ff-41af-8ee9-c19f262cd1f3@linaro.org>
Date: Sat, 27 Jan 2024 14:38:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/23] target/ppc: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/mpc8544_guts.c         |  3 +--
>   hw/ppc/pnv.c                  |  3 +--
>   hw/ppc/pnv_xscom.c            |  5 +----
>   hw/ppc/ppce500_spin.c         |  3 +--
>   hw/ppc/spapr.c                |  3 +--
>   hw/ppc/spapr_caps.c           |  6 ++----
>   target/ppc/cpu_init.c         | 11 +++--------
>   target/ppc/excp_helper.c      |  3 +--
>   target/ppc/gdbstub.c          | 12 ++++--------
>   target/ppc/kvm.c              |  6 ++----
>   target/ppc/ppc-qmp-cmds.c     |  3 +--
>   target/ppc/user_only_helper.c |  3 +--
>   12 files changed, 19 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

