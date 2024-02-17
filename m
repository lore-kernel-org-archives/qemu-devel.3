Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E803C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRTm-0000pM-GM; Sat, 17 Feb 2024 15:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRTk-0000p5-Pw
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:40:08 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRTj-0008JF-7r
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:40:08 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6e2d83d2568so2120868a34.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202404; x=1708807204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGm7bt0LXkK1ArBzg/CaREi9+G0hDu7PzGsQZhkcbHk=;
 b=M/xhaqhTTbY1Rg36iHzfPxes9IUsY5gh/NuF/zYQ7mldoZOfgMSZcrphbsKo1AdGjd
 6ZCDHijPG9bB+Venf5hGKXFsL2SMSedz0iHQwCNIZU32Jkjjgl58w/xIWeXu8L/XgXrg
 1FYD0ftFBvXqjFhi8kl/4QMeCU2XBEryvv2Zi8OY6cWvejgFuW6oMBbP88JBbTneBPhE
 ClCnWMPHNoOkjjnSo3SvRKlc8JLf+/hep6CNQkR1A0s/AQnyQ5zvQxIlTqBfe4ZpF83s
 QfHkerM2Cgtc8uwc18WR0m0UAmg3gYetPI0hhKXJ4jjyI5GKES6MdH1hjwadnjtmwTUr
 foTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202404; x=1708807204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGm7bt0LXkK1ArBzg/CaREi9+G0hDu7PzGsQZhkcbHk=;
 b=UgHzxophedWSdhsOZAK5V+gjIzUdxYuekA16l7zhYE1FW4oB31Hs91a56vAalVvPuv
 BBl06mZE+wKqQ8rpka4ymFRh3yzY8IhrJXPi2tELNT1nHhEQmupVpbeMz0COtI1O7HCw
 kb/7kF8nicI+YyqGuyDcGEme9OfK8nsdK4h6sPc7xpgftW0td6PNdMe3YIZDn+fz8r7t
 7+CLuEMjrGWz6eA8ptxILgCu/KhP7h64tCa8DFHyVPkhTBRO2cIcK6cgGkKpn4IsN9ll
 dUld0t7sq5st9AzPyWDhR7oYUEBq10MVFasYnEBgV/aVz1D4bqSooR/+O7R2l++dkbLs
 s6qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlavBwC/DN9yUIieseJZSkbsKfvJKmnm8llHhWMGd0rvk2o7RllVxMw1KJSQoBbqYTjSN0tMK0IaE0eUpPQOE1rgp1aD0=
X-Gm-Message-State: AOJu0Yxd+BUjHaYzMIq8m1TDG0Swf+n3Ro0Rdde7BN3z5Hzky3LBKIxO
 flsyN5gOGp+SkM7zm3gVLRXSUid7+dESC1Bx5fQuY0m3ZYbZwG4GIrZt02SEDYU=
X-Google-Smtp-Source: AGHT+IFndQ1NNKaj/Xk0tgIkDpUWc04ixUT7l2t+sbCxB/3S3R9zh4shTkzGH1RzAvbrJNb7dSlWGA==
X-Received: by 2002:a9d:7e96:0:b0:6e4:3e94:d706 with SMTP id
 m22-20020a9d7e96000000b006e43e94d706mr3599278otp.2.1708202404676; 
 Sat, 17 Feb 2024 12:40:04 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 n15-20020aa7984f000000b006e0651ec052sm2049388pfq.32.2024.02.17.12.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:40:04 -0800 (PST)
Message-ID: <08746b20-24b1-4ac0-8f9f-4eda5448c2b7@linaro.org>
Date: Sat, 17 Feb 2024 10:40:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216153517.49422-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 2/16/24 05:35, Philippe Mathieu-Daudé wrote:
> We want to set another qdev property (a link) for the pl110
> and pl111 devices, we can not use sysbus_create_simple() which
> only passes sysbus base address and IRQs as arguments. Inline
> it so we can set the link property in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c    |  5 ++++-
>   hw/arm/versatilepb.c |  6 +++++-
>   hw/arm/vexpress.c    | 10 ++++++++--
>   3 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

