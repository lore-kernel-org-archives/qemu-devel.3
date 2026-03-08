Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201E7EA854A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 23:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzNiM-0003f3-F2; Sun, 08 Mar 2026 19:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzNiK-0003el-Bl
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:39:12 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzNiI-0002de-Lj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:39:11 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35990245493so4783443a91.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773013148; x=1773617948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eug/jfxnSan6lzaq3lUDDGCvVd8cjG6uoHHMv+3dEPk=;
 b=i/DCvAtx+PDrVeKEgjl3DutQdD8IYAmkP8pdXfGZ/1xcw3WWjBjThrv7WqoACsIFEO
 4O6H+wbFbh3oGH28tqNAN9PgkpJr1gHcXElsYrn2Ik1fz0zUt409Wd7PkLw710acyGLK
 rsT1iPMh4OEMHz3aPx9UuOOgOpobZ7RluzID6aFdTW3iYR2PlDZPDxal7rN5XrzhGj9l
 zhHxknT98p0OWD0xTT0N0rw1SCANPNXR7lNm4xDnAInsBiCQONGTH0+Y5wm94Btx8iJC
 JyyLBvg2YgoxXASCwQJMQ78PoyfwuvKg/UvBiKqGhVi0AjusKyyTapePD0jPFeUJFiu8
 YUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773013148; x=1773617948;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eug/jfxnSan6lzaq3lUDDGCvVd8cjG6uoHHMv+3dEPk=;
 b=eeLlHqwWVBb5tG8gPjXzSFdeURY5qPzThO6qJpR8tUMgAohD6rxE29tclknVbVeDTl
 k7+Qd/8sbykQ7DW6AeifOiER3pCPrBn10IXRV8LDShSV0LXfxb88MvuNV1zqoB8ImABd
 anN0Ib6cg1yxLYDkYp2tZIVD054Srnm9iHmC8ebZ5GXz9qJvfydB/7CcH4SOP+xmMVx5
 EIWRXNnLYu5yB9y4nOc1eg1mIqsVdFQ/RJFsIEF+QqsbVEOgckbBj892Z4hn4eyVdBrd
 XwJCpTNdKrYGgLmDYWSEZcLYf453t2b+8DnD+0TXQ0YpjTv+VppQaXs9+iiJM3+c68iW
 m+qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5eyDQnSHbmB1gH6loeSAuFDMTK0d6/swR4lD6RGdICDELOiybaOTQ79vaaHc/amHEYkL7r+zoo1Xg@nongnu.org
X-Gm-Message-State: AOJu0Yx1YvMdr3FSN4e3oTZa+c7f+yljkAYH3IOp32ULRGOvjaZPP0Xd
 FTN9dyFjmGGcAi4/bezb+jr3c1Sn1MCMAN5ksIJKyAIwjNdCM6qPK50J46dTzvEM/gE=
X-Gm-Gg: ATEYQzxFjy9DcPomQmZG4GfMGv838LMFzHF1XwRZF7f4qnIonIS4kClx5uMogpuYA3j
 vNRJIAh2TCTBwFnwDnLEXuJcHHkcCazDawXbEt09S1xzKNtYNlcu/PQIbjagDWp+8YMOTKaSJXd
 Ti0SsLjEPYoZtBwBbSF5Wc7ik26AHXv7cXF+1Z6EkMjKBhVcFDzDeMfBFo3pHPtEajLK72/Qdz8
 CH0tyY51KYIdiZqs6JaoS5Xsc/nGk5RJTnWCiGn/vksurMyT2quOX1i/r5AMfk5rskfkcP1BUM5
 MgxihIBUkU+uKgSivC8CojKO9cQS3h9zArdcBh21HMP8YQrxuLFzTTCjCleJbocOJUM9/6HGWaU
 XeCEK/HF8nAo6oh2fJbmXImWtZQpJmnXlggLmGjsbPv2IU9j+Sn6DP35zlEWxUQ/TZLudIMVTI6
 gGuUCpN21+4FDKAO7EXBG822zeIU9mn8aQo0oFNnNn7VsVOUrWdJ9xLHr+cnm0CvUjrb+Y
X-Received: by 2002:a17:90a:fc45:b0:359:791f:5f7a with SMTP id
 98e67ed59e1d1-359be34a896mr8466509a91.30.1773013148361; 
 Sun, 08 Mar 2026 16:39:08 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359c003d75csm11152512a91.2.2026.03.08.16.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 16:39:07 -0700 (PDT)
Message-ID: <30d92179-80ea-4285-a6a0-90e2544fea3f@linaro.org>
Date: Sun, 8 Mar 2026 16:39:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: skipping the x86_64/test_memlock.py functional test when QEMU
 built with asan
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <CAFEAcA8yiCxkyoGdCE-CZiDFK8gqim48_9XteOcBmbgSG2MnGA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA8yiCxkyoGdCE-CZiDFK8gqim48_9XteOcBmbgSG2MnGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 3/8/26 1:01 PM, Peter Maydell wrote:
> The clang/gcc address sanitizers intercept calls to mlock() and
> make them do nothing, because mlock doesn't play nicely with the
> huge allocations the sanitizers do. This means that the functional
> test x86_64/test_memlock.py fails, because it looks in /proc/ to
> see if the binary actually locked anything, and fails because it
> sees 0 pages locked.
> 
> What would be a good way to skip this test in this situation?
> 
> (1) Should we make QEMU's mem-lock related command line options
> actively fail for an asan build (since they won't actually do
> anything, and if a user runs one they probably would want to
> know this)?  Then we could detect that particular error in the test.
> 
> (2) We could run the QEMU binary with
>   ASAN_OPTIONS='bang' qemu-system-x86_64 -help >/dev/null 2>&1
> which will exit success on a non-asan build and fail on an asan
> build (with an error to stderr about the invalid ASAN_OPTIONS
> syntax, which we send to /dev/null). Then we could use that to
> decide whether to skip the test.
> 
> thanks
> -- PMM
> 

Wouldn't that be possible to simply deactivate this test in meson.build 
in case of sanitized builds?

if get_option('asan')
...
endif

