Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB01CC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRYs-0004EK-Q9; Sat, 17 Feb 2024 15:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRYq-00045a-Fi
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:45:24 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRYl-0000Us-NM
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:45:24 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2997c5fe6abso108778a91.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202718; x=1708807518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxx3yRy+wPdldh3Xc5l49IHo+DQaWnfCOpLIPykHwyo=;
 b=k3a74zerF087k3UsihjLwxs8taCRXX4T3IZciJ820BhDhD8F/regusqKsTKsH9gw36
 674eWPXuWXymvXEIhAOckFYQ52wA/DTbaMW/F7PLnznxliH3k9QQv5W9RrgmiRvDJB3q
 HXWe3O8cqTHPz1A9sskhtFGJmGRjJNKPunZ6oubAk4RHWKg0AaoEjcDyBVGh/QNs7BF2
 WCsdL9egU0b5vtJKQcS77eBGnOf4eUrGHxSKJi/EHRvQMD9VAdznn7ieHbPzGsMB1coI
 srTK7Bi/xqlqCKqz/20/DOfYhErzJr6w0Zz5RYt6ZFoux+Emj0JdLVHmySAlyjQn33Pg
 RH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202718; x=1708807518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxx3yRy+wPdldh3Xc5l49IHo+DQaWnfCOpLIPykHwyo=;
 b=lCJPu2lKHm+NRTk7EXFcjijlG/06NkrDPj20AOCEsuhlUsFSGhUVes95rj2ykqlZVk
 +rbj5jNEe6Pf+XMmFnvctKVC9P9MXqHSBn+SFVzhZXE9NF5mIKYw/FlY5e5Rge26M8Zf
 vojCv1nGu/y+Ku0IBbl5japzIqvfQHNN4GZ1R3yxVxQIiY0pnXJxqxGdDgGfZtjyt7nW
 mbkH/G3/a7q+63ZzMwqpzubklJfLpwo/DxeuxRoJ7LFHskWa5CP2HOfL9b/GEYeel6jy
 qAWYBOK423N3aLiui9q+f8Gyp4TJ2WtNwYk84CoqFhpMXYr10JIW6Kn1HEgjTG1Znh7J
 uMUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRLoBtbjBACLKvttiOAhf4lWBxWhAovG1XJE7gOEKcUcGjlPfSSUiNWNsoNnZU87l73Mlx1g1VIt2f6Jrv9kLJ+gzLLs0=
X-Gm-Message-State: AOJu0YxfN574mFIZgkCGCQNE520plrFyvMmQb4vYfNq6U+C7tqYHuWWP
 FhFyRJwOv7/HtiMQyM9sh4u7QuheiSM7kCFFAgEAYHlzIQMj9QAOlN+BOMQ/vsI=
X-Google-Smtp-Source: AGHT+IFKSRClkZKYyR3HbMJvBS92BRGuLIZ1xyWpSzzVfELVWTdFq+ZxRlJswl4xgizAW5FBIXhdGg==
X-Received: by 2002:a17:90b:30d0:b0:299:5579:33af with SMTP id
 hi16-20020a17090b30d000b00299557933afmr1744510pjb.20.1708202718170; 
 Sat, 17 Feb 2024 12:45:18 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y4-20020a17090aca8400b00296f2c1d2c9sm2227236pjt.18.2024.02.17.12.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:45:17 -0800 (PST)
Message-ID: <7979b6d3-6340-4fd3-8daf-d3a9715e097b@linaro.org>
Date: Sat, 17 Feb 2024 10:45:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/i386/kvmvapic: Inline sysbus_address_space()
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
 <20240216153517.49422-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216153517.49422-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> sysbus_address_space(...) is a simple wrapper to
> get_system_memory(). Use it in place, since KVM
> VAPIC doesn't distinct address spaces.
> 
> Rename the 'as' variable as 'mr' since it is a
> MemoryRegion type, not an AddressSpace one.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/kvmvapic.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

