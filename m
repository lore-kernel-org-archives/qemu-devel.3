Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE18C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 23:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEyv6-0007F5-O2; Tue, 13 May 2025 19:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyv4-0007EK-Sk
 for qemu-devel@nongnu.org; Tue, 13 May 2025 19:20:18 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyv2-00067U-6F
 for qemu-devel@nongnu.org; Tue, 13 May 2025 19:20:18 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30aa3980af5so7311746a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747178414; x=1747783214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ptnBdOrH3dXuhVdA1Pm0/5wz+jwDYOdOULmTRQstQJ4=;
 b=nwTkIOrUZMrNyEefbxktyCfXxxj0pcOD5MiyPWlgsCjrs9ATaSBScbBl0vYzgGsZd6
 /EXCReGNeNlK61dpVmaqP3A6DwnnTQPPyGNzzOGftWV4BZD1j6GQ6eIadHo5lEXmaMFd
 MT4eRFAZndlDNIVe6c3ezrpB5aJ8T4Lo1ygRpDzEXqrD84G/srzY2eQa5unRyJrBI3dZ
 +vzjcuN/IaoUzEtrXKsGHQTYlMNTICXIAAioQ+jOPM5PvoH7+fwjuGXYyP/hgoPi0EPQ
 /iQB8wjVxnMRj2WdgApR/ltuaEQc32TfRCgGTbSXxyXIfBNvp1uzF+Xy7E7nHtlt3ru+
 lOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747178414; x=1747783214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ptnBdOrH3dXuhVdA1Pm0/5wz+jwDYOdOULmTRQstQJ4=;
 b=r9Ec/Ld0y44hKF36AVKHZXNxmDkTBTmypHFWb5Vcyd2M4LSJzlJoFhkZDAvVK4oqNb
 PUJ3aqB0RbdZELA5ZpoJE08mfePqdiDDYK1Z3vot7+4PvkZ+i6quH/gNj1FsqJ25Vd35
 PuDZegCGsFR1dY+YOptmIlMaGTt/GM6naT1RyslQKtNnBWlHSv+G+BHNbx6WZGwWsCSJ
 Poo0V+fbdQhLls3ANfzTeHkfiz7PJN0gRg5+6qomEGT0uOwStHt1+8drJlJx8S1lyrB4
 xxsbbhhA47416MMCB4YASS2natkOD2VGHH8rffLaV0YmH1oY1LDmlkqhPDH5bYntkcO3
 UlkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9/nTMzVuJ/r2dfTrxW1I880X+jLvWTX0sqtdQsKW4cd7HWuzxF7T3r9XhzQhcyKIBuVBUuqqb2/PB@nongnu.org
X-Gm-Message-State: AOJu0Yzb5K1lQwHSpYX/LjGhOdYUibdRo10kilVZPDwmeJaWMe1XUBAp
 GmCF6hNY8rdv4Svvg/swlNzdc1derpyJCTzY1rY9p2+uIYDzYxxN5Q9uQy/fRxE=
X-Gm-Gg: ASbGnctc12QFt7SciwnxpoBxR/XI64QcRJE6mQCc+efu33l39qx98D0RbCc1pEQbWKy
 e9Z7f0fN1dUv/wtayDpcpk77Jr0Fg9zwSHxBI1LfOExAQJGUzOH/c9+XCZPPMAnb3uwpyfQ19kn
 yQ3/mdrhZnFeCi7JAIsi5FiFhGvWH38YL/QCIODluloNbRlbHYP+zN+fvZc0ZITUdy0go85gj3O
 U+pjW8ja+G+/WiJlSVuYDsIjDwcAgDY2vL6S3HAflarGtvQMWiW35oY2EguZmK8JFjGffmyiaUe
 ht71EENpOuPGj4/sv80tb6PzgF5eH6Wpnd4y8SeQ50O8ROZJZcq+Ghyn9h0TomNH
X-Google-Smtp-Source: AGHT+IGBiHuqiSKVuJqBr16yPpdIuT6KtY//P+LhaxrbTOwYGaGm1QEUa2Z7RZTeKOtheFCiXpb04w==
X-Received: by 2002:a17:90b:518d:b0:2f2:a664:df20 with SMTP id
 98e67ed59e1d1-30e2e59bfd7mr2339027a91.7.1747178414356; 
 Tue, 13 May 2025 16:20:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e3345ffcesm160832a91.29.2025.05.13.16.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 16:20:13 -0700 (PDT)
Message-ID: <d1bf2e99-7320-4a20-a5cb-2e7ce70036b8@linaro.org>
Date: Tue, 13 May 2025 16:20:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson.build: Compile hw_common_arch_libs files with
 right header include paths
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Brad Smith <brad@comstyle.com>
References: <20250513115637.184940-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250513115637.184940-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Hi Thomas,

On 5/13/25 4:56 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since commit 6f4e8a92bbd ("hw/arm: make most of the compilation units
> common"), compilation of some arm machines (like musicpal) fails on
> certain host systems like OpenBSD 7.6/7.7 since headers like <epoxy/gl.h>
> don't reside in /usr/include and we currently don't add the right
> CFLAGS for the common files to include the additional header search
> paths. Add a loop similar to what we already did in commit 727bb5b477e6
> to fix it.
> 
> With this fix applied, we can now also drop the explicit dependency
> on pixman for the arm musicpal machine.
> 
> Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [thuth: Add commit message + changes in hw/arm/meson.build]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Change the subject of the patch according to Paolo's suggestion
> 
>   meson.build        | 27 ++++++++++++++++-----------
>   hw/arm/meson.build |  2 +-
>   2 files changed, 17 insertions(+), 12 deletions(-)


Thanks for the patch.
I didn't run into any issue when building for {linux, macos, windows, 
freebsd}, so I assumed it was safe to do things this way and specific 
dependencies could just be listed with associated sources.
It seems like there are cracks in this approach, so adding all the 
dependencies per base arch is a good idea.

Any chance you could base it on this commit [1] (and add it for new 
libraries as well)?

This is going to be pulled very shortly (as part of a wider series), and 
the same fix will be needed.

[1] 20250512180502.2395029-4-pierrick.bouvier@linaro.org

Thanks,
Pierrick

