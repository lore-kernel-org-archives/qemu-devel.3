Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FB3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQJO-0008NF-Rb; Thu, 21 Mar 2024 17:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQJN-0008Mp-VI
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:50:57 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQJM-0005sP-K6
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:50:57 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e67cf739d0so788862a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711057855; x=1711662655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9Ube5/lKN167PQQ0N/CvubHyOf170bdVUOGAgVFyFw=;
 b=zVVzP8Caxz+eUNU8ac1i8O35vHFpUcud0aLoVS3rzqlLyfdqbAmiTec6HFyr08rFxS
 +fxyKEMnQahRK7JwK/YycfOpmZpIgcbJKo+mZK71hacgAy90tiX+hrR/0f4bbzsZbfK1
 kuneGpW2Z5HQpvtuEejNF8EDxI2FdYm4xlcmLCoIwAbq/Uh7g0fnBbeNBWS6j+6xVEWd
 1LjIBWXJKccCumRNw44XFm4kB55JAUc3oQ88tyMTTmt62W0iFHu7oIyggx0b8Pdwim4R
 Ke0Hvhu3q++yUANxNdyVvT5s5e9/mJMgVDcAlt7yvHMqPA8752LaUpeEI9fooulf+FaT
 8L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711057855; x=1711662655;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9Ube5/lKN167PQQ0N/CvubHyOf170bdVUOGAgVFyFw=;
 b=BasBzwWLDuz1EToyRKc+W820RJO/D3Q2R+hdbwNQb+/PDSdlevU17QiiHTnzHw5gZL
 sKI2gxaUQDmoJUTP1bZJuNLVh3S7t/VUbNeNHssoctHRNvYwCwRPe2nfsRhLg3Bviq7Z
 SbxibTa2u6qVaHeso1eJPbcj2CBgoKHUicSEIF8tdel1UFG/ynxkEiw71US0iB5Bte6W
 jN/z1Fg1MudQrb7HQIO2ZgNrVSnCbKn4zbKrtWE3H/VoK8/O8/2PBJ2Me4QbK7iOuILr
 +yJeQYL1AB9gr7sILqhsavRk86Po5aRayUUEDh923zJI4UmXVzCa1MoEkUK5AVRXZR1M
 E1aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnrNUdLOeWAkI4V+zKtMVeWVejJOMNEB2S9Uur57Xs0kJ/5Iljk5giIxnmeR9umdAT4WvT/mYHM8PBjW8bT2aFX+/sfHE=
X-Gm-Message-State: AOJu0YxpeTUC6hHHtiyY2X/euQZHA1bkTyVvhIFjhf/DbIapqhJ1GBYv
 PHQ/u3RT6t0bp+VXas7x5mHLPgRLPCllJY0wl1FNup43L2ZIPWfiMXeOlwn37h9BLtHj/TjlOE/
 6
X-Google-Smtp-Source: AGHT+IEYeGi8m8xzIloQzgdEBbjV8Pj6H93m1yvJbKtkEu90J5eOvRLFFdiCsKnXU3/OpL/cZlKarA==
X-Received: by 2002:a05:6a21:329c:b0:1a3:a25d:aacb with SMTP id
 yt28-20020a056a21329c00b001a3a25daacbmr142037pzb.43.1711057439136; 
 Thu, 21 Mar 2024 14:43:59 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a21-20020aa78655000000b006ea80883ce3sm253938pfo.133.2024.03.21.14.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:43:58 -0700 (PDT)
Message-ID: <ea08de00-6a08-4178-82cc-6bf6991aef96@linaro.org>
Date: Thu, 21 Mar 2024 11:43:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 03/21] target/i386: Move APIC related code to
 cpu-apic.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> Move APIC related code split in cpu-sysemu.c and
> monitor.c to cpu-apic.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/cpu-apic.c   | 112 +++++++++++++++++++++++++++++++++++++++
>   target/i386/cpu-sysemu.c |  77 ---------------------------
>   target/i386/monitor.c    |  25 ---------
>   target/i386/meson.build  |   1 +
>   4 files changed, 113 insertions(+), 102 deletions(-)
>   create mode 100644 target/i386/cpu-apic.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

