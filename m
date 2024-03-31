Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12910CD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 17:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqzN6-0000vS-Qc; Sun, 31 Mar 2024 13:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqzN2-0000vG-9d
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 13:53:28 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqzN0-0000tn-LH
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 13:53:27 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5a4817189c8so2311505eaf.1
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711907604; x=1712512404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8vOJ5ZUCfx+GpTRAAjB8Up7qBhtHwL4LVJZ7yE0rZYQ=;
 b=ce+YFubhgge/xmESsmo9cBlHcc2BZGlqJvjK8ub96wkZJ9ybWlyMc7k8N7e5GOPwVt
 ZssNQquuy4N02jMAPrjAK+kXKgXbdfDmP5oG1DT8cCAx6AIN972IW2MYAANfcXOJefgz
 WBt0oRtn4Rk5uVszqu1D3JuSY3sAeP67rFMpPhI1wRe4l7ByEeMPha9rE2Q+m0FtpjsW
 cLeVCAxDYOyYBysSE7x6LsxQ/lVEfVGXVmwaLuostv0FjbJNIsFCTlIjR1dh5CFtN/wK
 w3HwLTbXGYztxdt7yGrc4PfN6Yokr8TYg/EE6DruTNNd7V8ntPIAmh9rSBjvYKcyGoSM
 6a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711907604; x=1712512404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8vOJ5ZUCfx+GpTRAAjB8Up7qBhtHwL4LVJZ7yE0rZYQ=;
 b=AOaa4n1Kj3qml/W+Y3IVZYspuz/3IIzA/lDKy+hI3KPi1xd3RoviDHWVVs7xdkIV/U
 xjZ69sfD+xbgftALyIaMt9b4TNfafKr+3MJlHo4c5NyAeElcT+oJYCU7Q+vjJau1pqY8
 UIcE+z/RizAzB/iHYltJn/cXLYWgsv+JhKCxwh/4ZlU6MVeP8BM/G5tiWCXaj4Gm3Iyg
 ZLvGSXAQc/F46GGyhosyGTcN9tN+KE/JkzAu8izs3hOi7eWsVBlNZR6+MFc6ge1wRHST
 G1nrpUF2T6tFWPREcPVz4UsQkO84uuFGW1Tw1dIO7lekYY8zuDXLVow0mzN9EBT/7fym
 o3wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlt4nKVHxjQjJgitOKkH9hzJrT77IzgAx7ZhrIf0L20pxghRMdkjWzzBhURf5cqgD1WZliZRUOvalnuXNoFbXKJYh+Dcg=
X-Gm-Message-State: AOJu0Yz9UudDy/EbKYy9ZrGRsRqWw5sG7YAQKNIn1mF31DgBoh/sEdEX
 kImHegXSLbszt3h91jlovYPvnJPh+gUwzRWb7p1zx5OY3PLreMRKd9PZeESPoTBSQGQ1dmxCGsd
 1
X-Google-Smtp-Source: AGHT+IFHkkxyv54yQedC63qE+FuYs2DjNfTc3ISmnxqQ8ROpcp50DR/U94HlsNrdriHJ45wA7dT0TQ==
X-Received: by 2002:a05:6358:2905:b0:183:3f8f:5eb5 with SMTP id
 y5-20020a056358290500b001833f8f5eb5mr9740157rwb.4.1711907603882; 
 Sun, 31 Mar 2024 10:53:23 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ot6-20020a17090b3b4600b002a23209024fsm1552850pjb.3.2024.03.31.10.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Mar 2024 10:53:23 -0700 (PDT)
Message-ID: <467864a1-e3fe-4f92-aa80-c4da3a5484fd@linaro.org>
Date: Sun, 31 Mar 2024 07:53:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/syscall.c: fix setsockopt(SOL_ALG, ALG_SET_KEY)
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: YunQiang Su <ysu@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240331084825.2716833-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240331084825.2716833-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 3/30/24 22:48, Michael Tokarev wrote:
> This setsockopt accepts zero-lengh optlen (current qemu implementation
> does not allow this).  Also, there's no need to make a copy of the key,
> it is enough to use lock_user() (which accepts zero-length length already).
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2197
> Fixes: f31dddd2fc "linux-user: Add support for setsockopt() option SOL_ALG"
> Signed-off-by: Michael Tokarev<mjt@tls.msk.ru>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

