Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3164FD10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0w7-00070p-AS; Tue, 25 Nov 2025 16:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vn-0006Xs-No
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vm-0005cv-4j
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so37225645e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107435; x=1764712235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LgfprpKZ8aqOKxqaZnaTPOqIv/4JTra2RbTcU6e4geA=;
 b=vSSeio21mG4UaiuMTt40b9sksqT2+xWUFWsBYKBLjDWlVK8J3xCPc5PShVR2rkADTK
 NiAGSoVONBW9IFSIFxhGZO+v5bJFWV8qKkFvD3vYyfP0dOEXlNmCDymitKHse1Yk/atG
 l3vOCMadKYNtrE0X72nqocqFbmkWM1x/XJ35JkRnVpJj8CncES+C3uiB0QdU8IJMN0fo
 12pbE6nb8gE+JccxQkTEDdWiuL+/9rWf88kIppCPCD9V9rocL7wRvyOaUARtT9NeQ+F0
 PWnV1QIDsegcVukuJqBE5iv1lIpf2khEGHPSnXIyIxixML9EDqHW1g49qVz21bSk+LA1
 6n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107435; x=1764712235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LgfprpKZ8aqOKxqaZnaTPOqIv/4JTra2RbTcU6e4geA=;
 b=OyzTQFgzSYHRHCzb6GBLqXjWLHIQTADaEGnyf0zhqHYRWnQ+XQ6gYr08fMPfEPmFa2
 z/h9Jn2pywmDib+b1IkwRgeW8sV5tkBaBBli+oARXlt5NeRje+b4LApiwBBoKg51QFc/
 nzLYPeGixeybtc+mbPFWaRxg6wx/bML9liShn0d8qLEmv6F+5VRl4i9hkL7jbpufL84J
 E3y68yX5edn6R5RM0Tvx9CJGuTdmJXpiu9/BPjoLoGfVrDeZmNqQi5uuBBGdZas+C/cH
 roWP26cXn/lK9J8h5IzmUu31xFJyPNRHOxtKS0OKVvvW+rTZpK2UNyi6LyS4zf4PKCom
 F31g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3YCCOI5Gzr0xWqFI8kz+mUyQglevvdKV2zPlR6s1+rwwhdPC3ZEg2oc+DJ7Yv44qPWGH0aYU3Pk62@nongnu.org
X-Gm-Message-State: AOJu0Ywvk+ycbpVVedO+wBo5pNR6GEcX+RA3+haHnWfwafe+TSdLsbYq
 A36ZFfk+rziJix4cxsm4lMw1JHL2/vEsXkqkeadf8jMJRUpDVa2hqb1R8OTQrvMjoAQ=
X-Gm-Gg: ASbGncsQLoQZD2zdTdTgbSr3/84/hHJ9Js8M5cD8BOnegqs3ugr4K4z+t5ZEbDWUapw
 r8CGDxlIbcw5HDBFqPNRcCyfQs6wxlirwIiwrCbOu6iGqNd7dVdzNRzWFCHzfC38eLUrlCX4wgT
 dHwfMjhz7iPx4vYJEs92yZqaeyY0QRyK/LVitrgKcQY6bXOyCsjUbDN8wlN/ROg1NjXwSKh3zcs
 0KOXZWGIh7Jqs594En7dmoEYkvaReRzsmFCL2olkZeuKj5r3d1ZJpdMCYGLvBFGnwQ1BkDImnGz
 F3aiuVJ3zKadO47hmB8qf4Mh04n0iAoTOEEn1L1X097LTJKlYB4f0zWIkyRYVX+0dD4sVvoy0j4
 YS9qomhchZb57ZgDwlSmrdPvZtW98mkdG33km5xPGqLG4OetutOTiUkEeF5tsi4AG8++auaLWuu
 W/99SPSKmIRTfdKMhmlmFV1+AQwBqGYfmm12Q2t89vKOkd0U3TceTVUg==
X-Google-Smtp-Source: AGHT+IF6Qz2PhPSiWeFpC736JUJRs4lo6WhMiZvGQJH8mUbnyW9rvfs0TaCOSGbiBy35NGZKf30vig==
X-Received: by 2002:a05:600c:1994:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-477c01740e1mr166514215e9.11.1764107435358; 
 Tue, 25 Nov 2025 13:50:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790530e73esm24779595e9.17.2025.11.25.13.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 13:50:34 -0800 (PST)
Message-ID: <4460eb5e-8d31-4172-8f06-6c4afe2b41ee@linaro.org>
Date: Tue, 25 Nov 2025 22:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qtest: Allow and ignore blank lines in input
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20251106151959.1088095-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251106151959.1088095-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/11/25 16:19, Peter Maydell wrote:
> Currently the code that reads the qtest protocol commands insists
> that every input line has a command.  If it receives a line with
> nothing but whitespace it will trip an assertion in
> qtest_process_command().
> 
> This is a little awkward for the case where we are feeding qtest a
> set of bug-reproduction commands via standard input or a file,
> because it means you need to be careful not to leave a blank line at
> the start or the end when cutting and pasting the command sequence
> from a bug report.
> 
> Change the code to allow and ignore blank lines in the input.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/qtest.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Queued, thanks.

