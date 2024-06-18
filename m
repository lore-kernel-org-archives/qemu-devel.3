Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C10C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJawm-0008WB-6V; Tue, 18 Jun 2024 11:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJawl-0008Vz-5F
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:40:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJawj-0003Qh-Ku
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:40:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4230366ad7bso50865585e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718725232; x=1719330032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3TH3VMND1OnLXBFvOhf0iTkyKP8jXTJBC9xtTqD4fu0=;
 b=uqOoIToduTox74qrVBcARmGNAyDeXnupEWp60IwW5zbr21kXwrX7BuhHJ0KqtHDif8
 D4a81bDA9T6vp0iTZJwpZYoG3k37opLXm1gyTUz58PJmydk3A2d6VFllbmmj7IiTyviY
 5vzMB7y91s/E6u7JTSYNsdwt0Jk2ZYCf1WAuKeNP4vRRrJgPCn23XiWre0wQZuoACuVv
 U7ExhSZEo6wXOMygnKCpOO6JLvDhn36hOGIwzKjG3h9l951/UUCl5KvhEPIDUG9Es0HB
 DotMKtTLbntaoSXqBwncNN7ooLWnTEc6xaluVVLsPGm2l4yO4PGLbukbv7ThapAOwXDo
 J1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725232; x=1719330032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TH3VMND1OnLXBFvOhf0iTkyKP8jXTJBC9xtTqD4fu0=;
 b=DsF3hZBfjifhG3uC3Wo3rvGkOWQnxHyTwra+YkvLyNLHew82lblzg2gYoVVKTmeTGR
 +fqM/s58MbYkRw+UbSimA6RhR+7pzozbhgrJ2rkUKMPgelOIp0kZhZugTduHtkzcVJmQ
 djBt2/AfE48IkDCGvSbh9wYTfPbzc7OtqU0ZUvvlVc8Klbnf8/8egBuJeLG6FGG5VCaK
 BgS8FTSsSek2IQuRSpoyvqwJXKMcaYoiNSSfpPZmNq7O56Ihp+AedJmxGCL7bBRhITtP
 ZNG8tkjdHruCsD1XIt4OcN0ESZcqMQmR4km/D7C8nXIeG9Hs9b1SvLeFKIK1yP18OlvG
 Du4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdIrlj0KEaF1pZbkWu01Dwqc9vUsufXcis3lwS4qxGB12KDmb0+JedvXoMRjadYmX24sfdQABzuPgTjrQtDSre8d01EgQ=
X-Gm-Message-State: AOJu0YwR/JMM7QvdsCOWW4mjKbRNdaPghNT7HegCd0BEbDUvPj/NzTdA
 GnZAekBXk0M+Rg32sgZ9P3cZoJg+5kDKCCMYj0ACewBbyvlC++Eqa39RkqHVF1o=
X-Google-Smtp-Source: AGHT+IGl0O2YeHvYQg3Hc91XtFZghhVOWm5fGxusF4uKa718IAvFV+J2JpDpR+MlUwMd1dTPcEwIDA==
X-Received: by 2002:a05:600c:17d0:b0:423:b5f9:203f with SMTP id
 5b1f17b1804b1-423b5f92170mr77583245e9.5.1718725232171; 
 Tue, 18 Jun 2024 08:40:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe9230sm227170405e9.17.2024.06.18.08.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:40:31 -0700 (PDT)
Message-ID: <d37c8eb0-afd2-45e2-a775-785f08987c3f@linaro.org>
Date: Tue, 18 Jun 2024 17:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-mtp: Correctly report free space
To: Fabio D'Urso <fdurso@google.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20240618003657.3344685-1-fdurso@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618003657.3344685-1-fdurso@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 18/6/24 02:36, Fabio D'Urso wrote:
> In order to compute the amount of free space (in bytes), the number
> of available blocks (f_bavail) should be multiplied by the block
> size (f_frsize) instead of the total number of blocks (f_blocks).
> 
> Signed-off-by: Fabio D'Urso <fdurso@google.com>
> ---
>   hw/usb/dev-mtp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks!

