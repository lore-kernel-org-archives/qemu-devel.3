Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC482C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PTE-0006UA-7J; Fri, 26 Apr 2024 13:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0PTD-0006U1-HF
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:34:47 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0PTB-0005vT-Qp
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:34:47 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5193363d255so3315828e87.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714152884; x=1714757684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yi0PqBRHgvpC6oNMRYqv+hACME+//jZfvlEAAw1+QN0=;
 b=dDK/ii7rrKbheH+25Ba419DdncK1TJVFpNvjFyijYVoBaAl+eBYCIFIfwzZ0nu9JMg
 2Dho4hxUm4O2+YDPAhi17wn1tltidGiAQe5jr72zBJGJWobTvJAzA6kdaXP/muzrhyBT
 ab8g7lknCk3s6OZdUBVOZ9l1uuZOx6lciUdERFFcsNXAGIC/7YbCzCRjOlOW+0v3T4+U
 1HACFqqAdjApOc446FhSuNW2d6xTal8HGNmQHrciJi8hmQSjLGFYrkF/bwfmeUewuPuf
 uQrnqnokLgXvaZk7PbkNzd+sasmLV5QlEha/K0IuA+zLLrjaeUKVHaz5HGZ1nosfGdQ2
 +ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714152884; x=1714757684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yi0PqBRHgvpC6oNMRYqv+hACME+//jZfvlEAAw1+QN0=;
 b=KeqV2wOQ8JmcTqMikgZRL9m0+0Jl5xPL1nZXbMEcaSfqjArQL9S3zawhBjEjOgtBQt
 Rb5MwzWJOpeOASoGHOH8gPJL/UGF4K61WPNAxl0zitfAqf3LEi+B0ZnPxEVdpl+Y6FFP
 /HTWypdWURXkwx5JiJE3/9w/P7qiygHuSSXpMAaiTr1iCYi77ORDsdeReiGjeRkW7l4p
 rOutBshSRQZM0kCBabaa0Yt0DA10c2YoHWHqPh163MRYIxzWyLvprfWgCBZPsrNmC1oY
 bE0GMVRrZGrIU8EuHPjFlS2mlTrFISLHSoOPIY2PsEqgr1J5aUAB6vPeE+LiCr/Kpv9l
 KMcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAp9TuNIO3/bOq0lqVvWz8W/T517bf367HOpM2c4+rsZClaqZKpRb+5B0rKX8NfB82ADYj/KhwoZHT8oK5aul5M5VUrrQ=
X-Gm-Message-State: AOJu0YytmOWkjeamyAYtoMDpWt7dBGP6V1EzFfbrCJQflPwD4GDwohfd
 cJQh7FAbEaZYZ5c9wBbM03gLsP1WiWwa9Cqv03pSXYngSsTS5ubOd0OBLmTQphs=
X-Google-Smtp-Source: AGHT+IGwccHF5XtAhN1b0bRo/G++FcPvO5eg6Ed+AKvB759U7rch3WvEU5zs5c1vaFjQIPl8fC/fKw==
X-Received: by 2002:a19:9112:0:b0:51c:c7d:7f0f with SMTP id
 t18-20020a199112000000b0051c0c7d7f0fmr2129350lfd.67.1714152883776; 
 Fri, 26 Apr 2024 10:34:43 -0700 (PDT)
Received: from [192.168.69.100] (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 c4-20020a056402100400b005720caa01easm5753414edu.69.2024.04.26.10.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 10:34:43 -0700 (PDT)
Message-ID: <de690aec-133d-4aca-a6ba-6ec1e69b14f3@linaro.org>
Date: Fri, 26 Apr 2024 19:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Re-enable the qga-ssh-test when running without
 fuzzing
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240426162348.684143-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240426162348.684143-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 26/4/24 18:23, Thomas Huth wrote:
> According to the comment in qga/meson.build, the test got disabled
> since there were problems with the fuzzing job. But instead of
> disabling this test completely, we should still be fine running
> it when fuzzing is disabled.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qga/meson.build | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



