Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nMJ-0001rh-Fn; Fri, 03 May 2024 03:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nMC-0001mT-6z
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:29:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nM9-0002Om-Ox
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:29:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b79451145so55857185e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714721359; x=1715326159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z9bqEAtNhn3qs5FhjXeq5ut6y5vaA8pG1ZZojn3H/WM=;
 b=FtMSLkRHoJtopVLeb+kXSmFfnFAOaVgJoX5u8mMSIlfM5hREo6KRAxDjSvHyrTIDaz
 CI8o7OmO8GB+2FW8Tx0bqp4++SuaLoFT+vN/EX0wemlDFNWAkJv5RRT8jGZcuCMNM1Aq
 FYIu+DxN5d0MuXAFZzF1RBdpHZcSnaL3D+NmeHKptbEwyDjpHjIRv7SkG9NqGJJJ6ODg
 CJ9vSTf8HsbeYiLbcr3yDOKFTuPUbwTZfievXSAE+xu2a1UCtpHNqsRBhMPAIOr4eJkB
 CWh0OEs1JeVDj69+WEJxM+59OBUT/AkyTE1IDxKe49A7AnjXAPK/N/0eZK1epqXeofd0
 L9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721359; x=1715326159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9bqEAtNhn3qs5FhjXeq5ut6y5vaA8pG1ZZojn3H/WM=;
 b=R1natsxjwq4iV0sZerSxMWLq+EO8Ir1zhYb4/q75MvqRLccx3xrUqV0qQ3poEppKTC
 Xb67VG/4HkNFJVP97CYQ7yxJUM3dDsxHyE688t181ECbXGNiRw47CskkGO97CYvSBoMe
 2OzSB0iqCwHZDYOhUy1zoHqQ8gY0lQ7gZFn7i3gjhJOTRrCyv6buBlbEzcd6YneEq8Xb
 8u8YkTLNODGnOZ2JVIs8gESn2qxJeyuISACpRcy9ys8ilDDJEtVwNE082chOBpMyfKuQ
 2Fuvn1/kG23cYBnY3m/dsYzuzGsn5tGTdX9OQ43M3CMnvsswDpVBO+WqayARrCvjpY+Q
 rojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuKR8jNToInVa76zu9jKecqPrPOI2mkCfz7NDwwOW4SS2Gskx+66shpaS6l5S/aelBMkGFfuQMlzDRrrTSpcJuKGw0yng=
X-Gm-Message-State: AOJu0YwlaLr57QqifSRZYO7Q1prSANswvpkxOlScaUAYyw22HIFy1yny
 F37qPOe8kOPB+Ga7txkbZxomuMD3IgXje93AFluD3ayJDdc0AT1N+izRpd40+OI=
X-Google-Smtp-Source: AGHT+IGxB4CyUasDpRP94btOLvuCs2KICbumA8OSYXHfXJDPkJuaEyoz/HAieJ+3ElrUw07Lb9BGeg==
X-Received: by 2002:a05:600c:1ca4:b0:41b:8660:c530 with SMTP id
 k36-20020a05600c1ca400b0041b8660c530mr1392510wms.5.1714721359069; 
 Fri, 03 May 2024 00:29:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a05600c445200b0041bf21a62bcsm8338529wmn.1.2024.05.03.00.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:29:18 -0700 (PDT)
Message-ID: <251fb76d-b53b-4ee5-97b3-b1e8d1fcedff@linaro.org>
Date: Fri, 3 May 2024 09:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] numa: remove types from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> Exactly nobody needs them there.  Place the typedef in the header
> that defines the struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/typedefs.h | 2 --
>   include/sysemu/numa.h   | 8 ++++----
>   2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


