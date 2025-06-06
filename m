Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80035C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 07:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNR4A-00039G-6J; Fri, 06 Jun 2025 03:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNR46-000389-Ou
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:00:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNR42-0003aZ-9U
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:00:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cd6b511cso11745095e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749193228; x=1749798028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mP1DjCo5cPJh6pwSjlKl+FpmXjk6KJM75Yy+iR5Nae4=;
 b=PvGo1V5jwBCNbd8lc7UpA/mHCtSjMTy2jhRmZkIbGnhcUEYYgnrW3A/maP9c3AzI/0
 R3qzR9lCpGVpmHzYvv1fDXShmF6oGldVSzikxo0kCu/CzKj/UQLDFGSPzcUgd9auNLcf
 x4/cWnyqWlyl3FvdeCzSBe26qhz5Wy5ioPlXDQOT5BrY7FV3OAefp5fMkZZx/P+Ai8oL
 fozA4ld+rD9g9N0b79VjNaiZVRbhbRTofImQsnjnTJexG5UTLYacl4lyCiYQpyJPwxpM
 WjdSWDaTtX15FsrmEQGMrh3ujK6IhLBBgLwSHGUdkj0VIr0KElejnIxfs5i8c/HeUOem
 r9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749193228; x=1749798028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mP1DjCo5cPJh6pwSjlKl+FpmXjk6KJM75Yy+iR5Nae4=;
 b=tK8ZcZFTFMBY4rHji/+VVh5rp9N+qXX0UuMoeLG0QEXku+VbeRVGN5sUZxtWOR+8U9
 N++lj6OmeXNXAMCGYUpsskCsD69+cjk6yBQt3UcuX5gtiV3m1l38ItxQM2FoRV5fGHFS
 TroC/3Ny9gaQ7Sxw1GIm20qddIiACfNFE7OHHuVpYVG7aE0ZaOrKqZvH7+xGLosfIaHn
 pqOL7KidFx31tSK33fAZqdy83L0bWEM2Emp4ZJ/ARnL/ShxyNzyx26N8c3pZSUI5XWpx
 8/TTlfFKoeAbuGGT+bDUdn6UjjCSJaB42r9UcQFyS5XlfiInolTTMM+y8lKLEVTaQ+NX
 iSdA==
X-Gm-Message-State: AOJu0Ywi3iDsVZ0rAWVcf25BLrGyddvnUmVjZ6QZM1aWWArxOahAbmvC
 Cij2T/fgWUK8bVQTYSZ48eZthj5+B56sE8H9+LE3NrSbBSpsTB07wzNJbUshIeZ1T64=
X-Gm-Gg: ASbGnctXf0FkXzfjmE0FfAS5seIvkgbd4kMtAEGMe2KuA+85Nfg15dgbIkT2b3sab0C
 KLn+1ml7oYi5O2ShzZI7Wj3cilm8I3hWaiV/htcd2Db9tBggQv17OeFBoIfpChRDPHk2e3kAxMP
 wHFjV3eh0HpNnUr7ZfnHH1bxpXLMt/3uDdtq73xQVdGXPvFUySdl31CjWNr8OQNwLa8Lol6ajgR
 reU8XVIWK5CtLUoMPN3smZPjoG47d+/y1j/6CErHvpZwVFSaB3RqX7fzRvw8ofCvH8nYSN8mfBR
 krJNCxlECRwENGnkj7NsWYF9JwpUO7aVFuIy+QF7DVovTo7Kt9b29yu+HQwDh3YmCEgik60OHUR
 B1m/05cZyBRRz8NfIBW1A109ff/dnaQ==
X-Google-Smtp-Source: AGHT+IEDSeTNBZeCr4ut4dFeVWE6cWY6/LDOojiqMOmp4zt1q9/pW6HioQeU5Bx6aKIzOZCk/Wewtg==
X-Received: by 2002:a05:600c:1e1c:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-452fbbf6c36mr1502355e9.23.1749193227894; 
 Fri, 06 Jun 2025 00:00:27 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e0563cesm11774665e9.1.2025.06.06.00.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 00:00:27 -0700 (PDT)
Message-ID: <012d6175-aa80-4bdf-bb2b-48b4ee424083@linaro.org>
Date: Fri, 6 Jun 2025 09:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] backends/tpmL Avoid using g_alloca()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
 <20250605193540.59874-3-philmd@linaro.org>
 <a4ed62b2-4bb3-a78d-c833-a58bedcc95aa@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a4ed62b2-4bb3-a78d-c833-a58bedcc95aa@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/6/25 23:23, BALATON Zoltan wrote:
> On Thu, 5 Jun 2025, Philippe Mathieu-Daudé wrote:
>> tpm_emulator_ctrlcmd() is not in hot path.
>> Use the heap instead of the stack, removing
>> the g_alloca() call.
> 
> Typo in subject L -> :

Oops thanks, I hurt my ring finger and have it now tied with the
middle finger; typing like that is slower and makes me do a lot
of typos ;)


