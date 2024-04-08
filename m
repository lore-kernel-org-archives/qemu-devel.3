Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24603CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts3u-0003a3-1z; Mon, 08 Apr 2024 12:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts3q-0003Y5-CW
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:41:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts3d-0001Ip-Ts
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:41:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed20fb620fso1276937b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594480; x=1713199280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fUxPQNIOlYvICZKJYqSMBUwxe2rhPnN9IcRUu8sXE14=;
 b=ykfSgDGpi+6Zvu1DtlWiTMpeLWNZ6T5QFZaGa146fVie/r+7ZBSse9JNaw1Zq3B4ma
 33CBCoOVb63al0Q+5lDDx9UG+Xkq6WDGGIccjGtzI777r1LgZrqPmriNuTehk98VJgK4
 0NU0VUPYqTY5/VOMx63YYiNss6FSQc3SXa0TzmEaADNeiAEQ42wFBiL1VHpApZK78Wqn
 4RTU8TE1E4/8iPZLSnWXjKGpoByjAbp4XD9hzaeChsYwrXsU4Jp8e7i8T4jBxPiKZ6b2
 cUD4iTjEDzUs/r/Fvb0Gxk5eIuteOZetKPjHZ477oRyEo1y3KiKoPQkgf/846tagG6yP
 O75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594480; x=1713199280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUxPQNIOlYvICZKJYqSMBUwxe2rhPnN9IcRUu8sXE14=;
 b=OT0gjhhVfMmONha7ZpBv0As6P6XzasqGU7jWZq7nJFh6azznKQbytf40a/MxheWKdI
 GCQ1IVu9jK0TYEvOzzw526ZmP+q7h1LRV/cXEKa5RkCz2676xPMxckCvtAJEZDj0U1qR
 9t6+n82lON8F2xVce5RF4HR1uDvsi8ixvd6cL3HY4CtRjw+rySXqyBfkvrrHgDdeDKSv
 F8esBoI+bqIZ0JDgcH7wjbO8fpIOZ5nDb96pZwBgpSZ/TNLBT1Ss/jXA6U1q0ZNdpfBO
 62yUWw9HVK4xb7p7G83ewteOEHtnkykXBmXpa7jb8mrSN4lICS+N1KSeSLzG9T4CaVKn
 hi1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGqymZOuh6Z4dh8OLaNJ+HMu5rJPb8ig1BiDKovI8yQyEn8C7xnITqKLVeyvcsWuFDqTcUCVvNaRKixCqzKmpw0gmGQ2k=
X-Gm-Message-State: AOJu0Yxcsb0vTZpFKe2I8tp+kUhRQ+xMkeSA3JMOLCpnykg5d/C+QAxl
 l6BAx3IIt0qzKCky718mP6TAevan4tWv0iZtcRwn705hzs+gIG+Ryw6ZBePWW2RebInLPJpu2t8
 a
X-Google-Smtp-Source: AGHT+IHS3NW1hxFSLVeZyK2CGIlGqBOQFm2EEf517cA6pjll/MZDfOsSPya+xDpftOg7HjtaVnxn5w==
X-Received: by 2002:a05:6a21:3d83:b0:1a3:52ef:cc84 with SMTP id
 bj3-20020a056a213d8300b001a352efcc84mr6229435pzc.60.1712594480331; 
 Mon, 08 Apr 2024 09:41:20 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a056a00270300b006e6c61b264bsm6792786pfv.32.2024.04.08.09.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:41:19 -0700 (PDT)
Message-ID: <0c3f5748-3454-4c31-acc2-91f8b1f92857@linaro.org>
Date: Mon, 8 Apr 2024 06:41:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] meson: do not link pixman automatically into all
 targets
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> The dependency on pixman is listed manually in all sourcesets that need it.
> There is no need to bring into libqemuutil, since there is nothing in
> util/ that needs pixman either.
> 
> Reported-by: Michael Tokarev<mjt@tls.msk.ru>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

