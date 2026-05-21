Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E8DCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Ny-0001nV-4X; Thu, 21 May 2026 07:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ1Nk-0001mP-Es
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:16:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ1Ni-0004L8-8A
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:16:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso50079225e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779362160; x=1779966960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hiC0WF36NDFgtTmQxhbpENg5yDvvV+A2beEKRzJVvM=;
 b=xLMACaSm1ljpS8OGY7MXYarPbsMXleOLcPMxBkF4dPnwKkMbTz+VJttJBGINNyQbHT
 qzJTNTh5mo1aEYSlO2HjM//uhrJ/FVjzim/3jrMxR6XlxRaLH6CnA1tFsPGQem/Qisjd
 eF9F/OBduzRsCvprSnzgkNn8jGG5cn6QKHe6LmLKsC/AQBdTXn57N6h66X7I9nw5eFR+
 f6wFvzufz1W7MaM3sgFmzAkOLisoJ3BxkDrNWCShczsl0MTrnt5FA+1J2Y2ojoor0r0Z
 jqFuPM2x8ei4wA09I9iF56nddVSYF+Qw2oyReFk43awlnRvQuaEfMMTBdvXypAS4oeVI
 EMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362160; x=1779966960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0hiC0WF36NDFgtTmQxhbpENg5yDvvV+A2beEKRzJVvM=;
 b=TU4suhYex36yiyb2KULkOee0tcKCCkbgEbjvB04s2QWT4doXOhJz93CIF6ozRk1Tzs
 AWc2NOlUg0RP4tQbuHHk5/1T5LqeXYscvuRhFFgnXvpePHMKj3Hac6hlalkL6uhXypnD
 m+YpS4n/jULCOq7EoGc+GMRfcI+zolOMgaFO/nBIkh//b9H1MinqDPi/JkeURyNFXsNM
 x/7GnDSo+2AKTy9OpkNz/MQoIXWy3hjhYjP8lSgPVIzS4BtO+++8ZGA42HHQHB6UapLl
 YE1Tsnz8ROZoCDJ2HqUReNBAR1HWclBzb6/wPLk8LUb0nA4/e0yKsKbkvw6ForAPFphI
 bA4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NL0Cwu1Y+SFUK5EG4vbBoRuppuWw06yfQMp58WvtVoRmN521ywSMFU1VUjF7d/tJBiNxC0l/q0Ytk@nongnu.org
X-Gm-Message-State: AOJu0Yw/GNi3KL3eV+DI7HFqHA0gqq/1Ng/F2sgUCa12lgTmvknjEWyJ
 9Z9saJfo78bgAJ14eSqg9VgAlfv1Wpr5zljCIIDtpNi6hpZKpxTgXATdZgE1bKTEAZ4=
X-Gm-Gg: Acq92OGxeCu5UDRfTxnHseIvLjqfF+CxUHf95sBI/g2Ui3tZ7jo1XrZQysu335u5Ngv
 +dgnAss2M5XDBTo4cQNLgbknZlt4yf9C+TSHULA7CJnJdBCXMYLcxzrNLSmbOW0EZi1dfB8w0+N
 gjfYb+EmiCurahzN9IP5LJEgXEcYr/IINNJaRMDypmXeX9izJDwUGXhXdHDIHFjioB6N8h1HKa5
 ks2/6oLifCAS3YUdN8a+3A9LH3/Ij56P5RtdzAVcibVDOzvWS1EYw4Bitp32FIZ2FD+ODr+d0VH
 Ll8Ogwn6r5Dt8hVnoGNj3BcAq4lBpmNEeNCeB8BwLZbIAUh4g+5prluZemcP3sOO0rMw2FCLAaA
 jY3KA9503cubOk1qIsEJ0b8JTpyY4U056mcrvuT8Nxs265a1h7wAgmfYKy+im2nbcI/lyZsSuOS
 1rLLNwcgTG6sp1bmn8AenCXG05n8cOjQplVcawsDvJrzDxc1AgBTQEIh1JAedktoKITA==
X-Received: by 2002:a05:600c:8596:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-4903604ccb3mr28617365e9.3.1779362160391; 
 Thu, 21 May 2026 04:16:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3515asm66798265e9.1.2026.05.21.04.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 04:15:59 -0700 (PDT)
Message-ID: <21ecefbf-7052-4382-8332-564ec70eeb0d@linaro.org>
Date: Thu, 21 May 2026 13:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Use float_raise
Content-Language: en-US
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com
References: <20260521110824.1091323-1-antonb@tenstorrent.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521110824.1091323-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/5/26 13:08, Anton Blanchard wrote:

Use float_raise instead of open coding it.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   target/riscv/vector_helper.c | 35 +++++++++++++++++------------------
>   1 file changed, 17 insertions(+), 18 deletions(-)

