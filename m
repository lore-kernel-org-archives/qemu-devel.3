Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ABCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYqh-000433-Vh; Thu, 01 Aug 2024 12:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYqg-00041S-Hq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:40:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYqd-000734-98
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:40:17 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7a8e73b29cso597286966b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722530413; x=1723135213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6Z2n0ebMktOOjoQWlsAGCJxA015gQdqxPZE8ODqIHI=;
 b=R3EwDkkQ5YntMYBDQ7pRj2k5NL46h5X4zIYfqH0XQ1JljaCWEVJRppkrAKsUZ3ub/a
 mnZMGHmZPSS0ENLiX9X4JpCzAXp6eAvYykq29kKMgsuIAuamHsI0fM89K5OoNcM2zQBV
 mpOOi+Qpxsjqbd4SGBzLLIbvzV8MfG64YmMi4xN71kfkyPNPTGt7vyoMxAMoyMV+hiXu
 vcdKUcLqeyWRhlZ0dQL4KWBc2nPHSNaz/xtxAa4BM08D+Zj64zjgTeXE0y23tkLMf3/L
 szQi3yvkM7axkb14p3yN9Cl6uBn3Qt5XMcATx4LuwGACOePVpw2zSVn/4hDUUwrZUL20
 uLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722530413; x=1723135213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6Z2n0ebMktOOjoQWlsAGCJxA015gQdqxPZE8ODqIHI=;
 b=RYXy4hli5cumn52xWDyUlFASvmqrFdU33tHqORk0DUAoOWTD2sVx8qISFkW5t1HZOt
 9Mu1iMvxA3xOHx6uNvoEi8k+i+27BQe17S5NaGbWYJzuLbpvOW3izhaM1Gv6bw0CrmPu
 5dZkxdH16AweTQt9kpPKU5QXF1Aw+pinEGHxopEOvGIn/i6G0S7P0mEN2XXP/hPwSYvB
 DbhlHZd6kDgYmiD2ItP26gXW+U4bOQRCogQoHVy1wfwJPhVIfFe4/lil5v+dgVkqSC0D
 eiYCHiFP38zs+qyi/UaQrWmqz7meAt296sMYyPxHh+Q5kvkKqWSLs7G0I1mkA5jkNexc
 MgCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVumdQzzwIo6Jj1Frus+1obVcocrjuveBfFcjNRmYVJGj0J8420PRKUTcI9HIb9QBr/0iuMigOBXH9MekIvtlDXx9EWuw=
X-Gm-Message-State: AOJu0Yy2Os7B2FhPukT/8qod8bLo5I2Kola5mXU6LwJ9yfZwvT9+u0Y7
 s8xapLqMthYd/KJOCQmWtBwiWtai9iFt7QEdKSAdpK8oJ1NaQYFR5WWbGm6YF3E=
X-Google-Smtp-Source: AGHT+IFDpfV+GJXnMl8pLul5AH+7oboba+FIXr2PLOrpTUrbFDGhN1xiTiJtGW+3A6vjFzTwuS6eDQ==
X-Received: by 2002:a17:907:98e:b0:a7a:ba59:3172 with SMTP id
 a640c23a62f3a-a7dc501651dmr58090666b.38.1722530412872; 
 Thu, 01 Aug 2024 09:40:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad90486sm918519966b.150.2024.08.01.09.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:40:12 -0700 (PDT)
Message-ID: <cf1f0a0a-1ab1-4472-9a59-094290484c7a@linaro.org>
Date: Thu, 1 Aug 2024 18:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/24] tests/functional: Convert the rx_gdbsim avocado
 test into a standalone test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-24-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-24-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Provide a "gzip_uncompress" function based on the standard "gzip" module
> to avoid the usage of avocado.utils here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  4 ++
>   tests/functional/qemu_test/utils.py           | 12 ++++
>   .../test_rx_gdbsim.py}                        | 57 ++++++++++---------
>   3 files changed, 45 insertions(+), 28 deletions(-)
>   rename tests/{avocado/machine_rx_gdbsim.py => functional/test_rx_gdbsim.py} (54%)
>   mode change 100644 => 100755

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


