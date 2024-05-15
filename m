Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6308C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 06:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78Ul-0000Cb-L3; Wed, 15 May 2024 02:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s78Uk-0000CR-CA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:52:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s78UZ-0007bT-3a
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:52:10 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f0b6b682fso6985843e87.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715755916; x=1716360716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cLSqH+BfxjojZuy+C6oOrjVfgsx++3/DQt50XEKYQxQ=;
 b=Q3QJ4cIAWKKr7hdEhlyt8ENBdC0+LIGhB0GZGHp8udwuKZn0iOGq0+xT3I7yHgfVLZ
 m2WGK4s8NU50EinY6M0BqNZiN86BtMNHQkWxZt1RhpdQdPmU4SSA/yBe5j1O4Tf4/abN
 r2yIKClkvjl2fec5K4/IlF+QY6TPqTvgEuto7nmrIlbdHte3aoShfocUwS0wG39ShD8I
 yUzAyVq5ECYUfDRgFtCe0gRlazlqozxbWkr6XH6pWpaGFxL//3BDIpnZOBs8a+gRABk5
 wLCHMDny61iGAqe7QJqaDKxNjHNnT+PeSodb/ZZ9TjqYSnPHGvOPYzKk0KjaNJl/Cgoj
 ON6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715755916; x=1716360716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLSqH+BfxjojZuy+C6oOrjVfgsx++3/DQt50XEKYQxQ=;
 b=k/Pxqr7Z+OYtn7N3wK56bMPL3opoyQEWB6ZDTtkeBojqatNlXc8QAChxOEXFcVKE5Z
 0NZF5vAulcaXTD9d7t6W7udjIiHVKtwnb81C+VLEJszam+URUYzZvcIIvvjcDClzs9Pi
 HmcqcUZy0uBrT1wjE0vCjNtUBFdYkAih0qunOqYmI0EEWWkPuuLbCVDKsI7wB60kTQHr
 88UUbv/tRfnIkgNyErNI4oAJSPHDDkztP1d3JVcP83ckTNAQJhefPDQr2M4Z2siMJzPW
 VG6HaDL1hnYw7Lk8QY6SSXltL5RiDx3MscP6LywEgGRlbAM/QiwKNaZTvv5g0PaONKrh
 QPSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpg1HakncQms5x6tLpCOVu9sQ9DtSivivoiEmwDNZSQTVoy8/1MYc2fxxMYHfThIgZkdqcZi/Bi6jBEfJgYHSsRjnF/4E=
X-Gm-Message-State: AOJu0YyZYBBdqibP2u207xZb/kAftZSUUdxuhX2tv7IM/s5bLxgNnmRx
 8xOOrubeN/CIMlU3aV/mMZHeLuZAM27bgOZm8lOusHnfWZuyYGAvDxVBWhjt+pc=
X-Google-Smtp-Source: AGHT+IHAKm149e686F9FpC1NZj38nJKCgNg/7E8coIlRnA0wn39DWxsLpkAi3XtNvaiGmI2O0yTSOg==
X-Received: by 2002:a05:6512:789:b0:51f:621:fdaa with SMTP id
 2adb3069b0e04-5220fc7bd97mr12441412e87.18.1715755916504; 
 Tue, 14 May 2024 23:51:56 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc955sm15501480f8f.111.2024.05.14.23.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 23:51:56 -0700 (PDT)
Message-ID: <02ebd299-f3f2-441f-9c3e-9dd763c25dfd@linaro.org>
Date: Wed, 15 May 2024 08:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] gitlab CI fix and glib update
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240514125119.284638-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 5/14/24 14:51, Thomas Huth wrote:
> The following changes since commit 9360070196789cc8b9404b2efaf319384e64b107:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-05-12 13:41:26 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-05-14
> 
> for you to fetch changes up to da79537e0c8cef007d30298343d05acb0ba8b427:
> 
>    util/uri: Remove the old URI parsing code (2024-05-14 12:46:46 +0200)
> 
> ----------------------------------------------------------------
> * Fix the "tsan-build" CI job on the shared gitlab CI runners
> * Bump minimum glib version and use URI code from the newer glib
> * Fix error message from "configure" when C compiler is not working

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


