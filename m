Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EN7-0002Ij-AZ; Wed, 15 May 2024 09:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EN5-0002IP-O0
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:08:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EN3-0002tE-6v
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:08:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04e2so42111635e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715778516; x=1716383316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zEgomMiEuD0tsBeq5sUxgpW7X/3HPpVsfBFhDZjym+U=;
 b=BaRs2L+x74YF6yiWF1jfWbbDUEfVgdwqy3b+rR4kku15Vpt8M/cMd/XvCAxa+yHIbW
 SZiCsouj2JdOulFSmCkX/GltZeWlKW/nfbOnzRYUnJobSrkpMMOV4EL14AaXIl2lgzco
 Xob4Z+AYcXMq0D4f4vuJ0ks9D3iQVaZyGsSZB/JzX5A9ua+6SS6Wc3yvIBKSromxxyEz
 Jk9lPV2NC+N4DqgioP7jNsCMeaLP0wlDqIhR28YnlIatcqKLP/Ji8DokDCTeU8jX8pi/
 movSz/3pR7Y1mz50UNgYGI5N/fEwXKZdpDS5QZ8bORBCYcqD0g9BqRsdhaYwU6VuBY+W
 7/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715778516; x=1716383316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zEgomMiEuD0tsBeq5sUxgpW7X/3HPpVsfBFhDZjym+U=;
 b=xOMaJ7x5rplQMhoHRxBKcW+zQRKMuylV8O2nAxlq1KAcxU56IPG4x/7pcSfopaMzJI
 cMQ5rGpDGnpdQw+0/MYYEHga08OVhZl5CHD+eFkfe7NFrB//4WWdTcQSU36TTz99XNzy
 5uOKmQWKH2Y5nBMjwXzH/1qRQhYx7FQecvlAFjU6G2flq6O9ES8Fkbd1uIiM8VEOAcT6
 wDDKiiVxXJ6GMOK01bdQ/Lc9dyotTRylsO7ICBMwXrwH6pDsGRWmVY9lep6YVynh7M1e
 KSLxyrTEhT3KlI3j3iprpWEu246Zvx7/o79hssofamnAebnMbBZ8h2o0ZLVz4Pki6ua+
 DtMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtVGSaLoc+637MbqA+XoZxEjHucEncr24x32jkEJWoUstGmakaLuM1K9UyJAsozGAOyQaGifTNRl0+bJ44ufJXSVhE8bU=
X-Gm-Message-State: AOJu0YxiEGet3+ojVbRy82IEzo4xDMRhECIs9hgSOgeegOu4B3r73Axr
 SYVx3QVLX0oo7TYcg/avOzSmF/mhnwEeNXklJfFkiLoCxgocobeGQFFPgzovge4=
X-Google-Smtp-Source: AGHT+IEiUo6WHNmUfiYE37xguYcn0zD2hEZ/nK26Ocq9rWOpz63vo0Tiqdx1PeS8t0+GkUlg+qrNRw==
X-Received: by 2002:a05:600c:3b97:b0:418:5ed2:5aa6 with SMTP id
 5b1f17b1804b1-41feac63341mr133755575e9.31.1715778515758; 
 Wed, 15 May 2024 06:08:35 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42016a511a7sm106381875e9.0.2024.05.15.06.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:08:35 -0700 (PDT)
Message-ID: <17177912-fee1-49d4-a2be-3e25a4deae6d@linaro.org>
Date: Wed, 15 May 2024 15:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] Build elf test cases instead of raw binaries
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/5/24 13:54, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   Makefile       | 19 ++++++++++---------
>   test.ld        | 12 ++++++++++++
>   test_aarch64.s |  4 ++--
>   test_arm.s     | 16 +++++++++++-----
>   test_i386.S    |  4 +++-

Maybe briefly mention why the .S changes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   5 files changed, 38 insertions(+), 17 deletions(-)
>   create mode 100644 test.ld


