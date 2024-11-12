Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611ACD42B9C
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 15:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAszD-0007P0-5r; Tue, 12 Nov 2024 10:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAszB-0007Or-CC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 10:39:21 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAsz9-0007ja-OZ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 10:39:21 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20ca388d242so60166665ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731425956; x=1732030756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6naAgyzr8NIQ3dfLBQP4tXCN6EDglg6RtY0hMazGmQ=;
 b=BO1HJCJfGFq/O3HQ2Y8qkuiEInPJ3em0buCtZY0uCTUJugVQRLa6rUZqNLnxTKeoBl
 e5Diy+bgdAv/gniG2EM9C+NIaUpbJkOJ7qb6FqnBw+t2SxfPSRuSx1aYJT1xySFwjn4d
 1aU25VlgMdRFYoGyNtOiir6HEsVYcPvA6ZTlG0FfJlyMWtX+3IEDkjGHjCd8fCYMlOGI
 ohf00OuFkz4OgYCvt6hHK95Wd1d/2B0YQ6FF2vOCmxvpWWLWtwIB3JzK1NzWT+mcXHtj
 C2mJzzNKXEWcQi24N+oIqtjqdc/s5XWXiGt1G3ncZMir3sEqOFp5XtqkAmbZpzh808Xz
 oY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731425956; x=1732030756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6naAgyzr8NIQ3dfLBQP4tXCN6EDglg6RtY0hMazGmQ=;
 b=AYooWUJx23Iy2meWsfZl1tVtSa3vGp0Q5CzzzXj+gDGfboV/CU8TzoyTCAFWot4X5w
 0FSKDhg+HVilGm/LIzkOI0luhBT5AgCy+actrCx0GppuuCx8OHNe87kcW+zC/yaQ+HxZ
 Ecj6lKDa4w/ZkgSJsPghdo7BbvEYXkSBuhgmxw++hM6+cVsozFOwMHoIVcU+3qUB8zF8
 yitxP4BgCTqBry8RKF/bPgRRSn3bsul3nYYASwfjxneTom9c6GoHild4DFDYO1A+UpfW
 1VZuiYjBLeO3tD1TVCnnieUAkP97oMs3jRFNaGxNske3R5FOjmiECf1hl/lE1MPC0w1r
 qyeA==
X-Gm-Message-State: AOJu0Yzn1V/ogLy1mDgStH/dyXyTlLY5cA3zDOyoHou26+2xfWwBO7X/
 lnkVBSVhwjXN3vllFIMtk+mx65vG/T3LO+wXG4JH+O0wlxl4k+zLZYV336eNR0c=
X-Google-Smtp-Source: AGHT+IGJpSyNVTH+cnYGn7GlNhyB1xdikcsVTF4FRDrYu7ei0qQq39yEsQEr9429/YqHmCEO9TOExA==
X-Received: by 2002:a17:902:d508:b0:20c:8cf9:6133 with SMTP id
 d9443c01a7336-21183d0b82cmr240909935ad.8.1731425956101; 
 Tue, 12 Nov 2024 07:39:16 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e41651sm95404565ad.134.2024.11.12.07.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 07:39:15 -0800 (PST)
Message-ID: <a9dfc8d6-108e-43bb-a424-2032f10ee63d@linaro.org>
Date: Tue, 12 Nov 2024 07:39:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] tests/tcg: Test that sigreturn() does not corrupt
 the signal mask
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241108145237.37377-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241108145237.37377-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 11/8/24 06:50, Ilya Leoshkevich wrote:
> v1: https://lore.kernel.org/qemu-devel/20241017125811.447961-1-iii@linux.ibm.com/
> v1 -> v2: Drop patch 1, since it's merged.
>            Add -pthread to the test (Richard).
> 
> Hi,
> 
> I noticed that while the sigreturn fix was merged, the test wasn't.
> Richard noticed that -pthread was missing, so I'm resending the test
> with this issue fixed.
> 
> Best regards,
> Ilya
> 
> 
> 
> Ilya Leoshkevich (1):
>    tests/tcg: Test that sigreturn() does not corrupt the signal mask
> 
>   tests/tcg/multiarch/Makefile.target     |  3 ++
>   tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c
> 

Queued, thanks.

r~

