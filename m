Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E003606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LceebWfR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5BO-0007GD-SQ; Mon, 16 Nov 2026 17:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT5BH-0007Dy-RA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:28:09 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT5BG-0006l2-5I
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:28:07 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3b197cd42b0so2852625a91.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794868085; x=1795472885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RgW8ZVOJvBBrgjraK52/6ZhPwpT6lszk3lueISApOho=;
 b=LceebWfRS+QFGKdXCX80CxyiFOb6dAV8hHtVhbso06ScabJys2sjh9DySxMUH/fG3Q
 5M76aew6cCzVRLFEiDeafsZkF6czVUawEOGGAS8Hv+SEGTSVDOyrswyWxFO4I1/1bDU9
 qVXnF7esiY5aSDOKw7YY7Tx3cqUW5oOR13ZZChgjSRe8nH0gk88g7k1JYLE9qNhi3UjY
 iguAheRyT0kq+CvFUaAC+F/hfITvEhlQBw8cZg3vJtHxUv61L6d0RMb7cl4OAdnJC91z
 re6ZfH2xzL3bDX0AsplAm1WFKXm2ebGiSaSXFjBjvp5K7rpoDvWqpaKFrTrvxLNSj/XV
 fG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868085; x=1795472885;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RgW8ZVOJvBBrgjraK52/6ZhPwpT6lszk3lueISApOho=;
 b=Cco9f3XhWtwgk3q7z4FB8vwy+xbUTUozoXNoCOvvsmZz546aBDs+tBjvrt31uM1WJa
 i/BZVBE4IAHGNe04ovmWM8GwlWLTUqj2VfrFjBUq72X8fTCDo9eXUObREp4Ph0QYJto8
 24KDWGkZrtm3Gf2pAuZZ72f+9WcuT7BihXZ5LMXXYZKp7VHEBvVmVpjtcwuujiSo5ySU
 R2G+5o9ZlRrW1E8T0PtTVZyO+UvWr2Lbf06+QOk111fNenkbaFJ6sMFAMMwuGNF74Zf1
 b0WFpvsKTQx8wYjp28BXR92JlAxpxCncl5bCvXXwtLlgdRXekmce1wK9mWQ53omAd2SP
 cHaA==
X-Gm-Message-State: APuU4Z9MH+92Cea1O+AMEEwISqj0mlpX1KiJgCKJzcS01wkC8MjG61v+
 xTK2zX2Ko1NGU627pRk45Te3luDBh5k2OuhgHRwiLJSQDJgAEStIDTSfVXldyFxloBk=
X-Gm-Gg: AZFdTZeZV+RXAteYuWVy71DbYni2wPon9NL6md0mwOuLOl4L4F7nw3d85qgRb1F4cnl
 tsWxyniTtzPKR+DUMsKc8Gk2/IoS5u2Y2JzozxprNs5jDuOV04SqoUKY3vE+Ca7/fgc/FWOHPkJ
 2oRM+ijYRCQUdU271Awrk1riadINqBFgmTC5o+XPqRrOyVejLvl+V1F87VY4ZheV8+KRkhsKxP+
 RrwpAwQ87vP1mD6YhE4BlfIp+UP1ZP7revAEmqVuaVRaucd54nyHAd7GlMu8xhtIm93AJqDuEoh
 1PPhEotm8GFtI8VKW0ug1zbyhB7u8mJ1bcbqzE6a5dxS1ULQd10cpijC/HKpUbETtoUot6XIWTI
 CGDYTSy0vkACHtGr17myvNZ0KavPJDQb6ClyoBZtqpQRlUTs+GNViMjAZpevV7atjbS/fNCmW/k
 rMDwb9CCN8COVfZz57XkjNhLov5fPnhOw+cG9zlNz2mrK3LXP1dENIGcxU3foXzmkVJKdylcR0T
 STo8prxHuLsOb/jagxPtulY6uZ8aJL0sPyANyK91DOmXUc8f2YfP1bTC4gPYvqsk/dSXUtIf56t
 UtGBWne2eYB4CQ5jAvDwrBnuWDXj0bYnJdFi9vG8eE0672bF5AKYQJsSuJljXYrKbnVBHS5Ab9v
 FPY/E5AJQvEZIX9Ev
X-Received: by 2002:a17:90b:5585:b0:3b0:ae41:2711 with SMTP id
 98e67ed59e1d1-3b1b0a12f15mr10615837a91.24.1794868084610; 
 Mon, 16 Nov 2026 14:28:04 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abb786f7sm981834a91.1.2026.11.16.14.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:28:04 -0800 (PST)
Message-ID: <f8113426-968f-4e96-bf1f-f80f2de6642a@linaro.org>
Date: Mon, 16 Nov 2026 14:28:02 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
 <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
 <ccfcea11-ada8-4753-a71f-f59ed1bcb067@oss.qualcomm.com>
 <CAFEAcA9FE_dTUo5s2g7DMw9-ZhbjBUOfF0RJxdT7gMwm-rYuGQ@mail.gmail.com>
 <558f35d3-5a10-4652-8af4-4a88f382ca3d@oss.qualcomm.com>
 <CAFEAcA_gBzv7URWJNjXwjUbKOJuRQ=bd1NS9enpU_AW_tCZzvg@mail.gmail.com>
 <b0633aca-736d-479e-b6fd-743f5ef23035@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <b0633aca-736d-479e-b6fd-743f5ef23035@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 09:05, Philippe Mathieu-Daudé wrote:
> Tangent to this, it makes sense to deprecate quickly enough on
> QEMU side when a host-related project we use deprecates / removes
> it; when this is guest related I don't see the urge, in particular
> when the maintenance is almost zero cost. For the particular
> aarch64_be I agree what we lacks is coverage testing; but for
> other features I'd prefer we keep them as long as there is interest
> within QEMU users, independent of external projects change like
> the Linux kernel.

There have been a couple of attempts at aarch64_be, but *never* any 
upstream traction.  qemu-linux-user is about emulating Linux -- you 
can't divorce these two.

In my opinion, those that want to work on aarch64_be can work in system 
mode, where the endian switching bits work as required by the architecture.


r~

