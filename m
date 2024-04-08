Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165F4C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts7t-0006UA-Ji; Mon, 08 Apr 2024 12:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts7p-0006SM-F0
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:45:42 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts7l-00029U-HR
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:45:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso3173063a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594736; x=1713199536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iB7KGmwGOqgH7RyCI1i5UJv1L4HB9p5fxSDoMvvF4EY=;
 b=RKrTO/zMoADz7Q0Zzpb4t6SoMbusu7ZvyBXR0oxAyTgdquxSYFKQvEmuQ/eCmi44yP
 wGOHoRka0wsJrDApdqmNXZ0pqpxOEYNdl81utsXLXwh4VB4oUEfkCcxqGUX484+WnBwE
 40lY33RhW7twsu1JjpsZuta+yIU6Z7OlX/Hfks1mRfPKvS5Bl7CmE3W3lYY2nU4Xvt0s
 x1wjC7cgvFI6/nOK2IPfpWBtI5p1GvYXxXqU7WJ8h0cXZTkvc30DRoOe8C2HYf5/oUOv
 TDzvOfJD0miVb7HpLYRjQh1KCyRgSoh3AJeyjYHqGL/yBFE8SMDQUDZlFFSOddQ8qlec
 1jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594736; x=1713199536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iB7KGmwGOqgH7RyCI1i5UJv1L4HB9p5fxSDoMvvF4EY=;
 b=cGvvFTgq4JtBcE/ePp0KMODn9tmL1UERtzLT/ohErdkm/IYp3QRm+5NwHO8FX83Z3H
 jIT5rwO9zJJDPUzKxCJwjh0aSJGenEM+bfeIu4u7EHwT8eW/VnEY3gCMIoERVp/hcX86
 Y/EVWmQ2+XPeNkINhUrKH0f4uL+MvzqG2Q/Q32HHjVnD3i9xcWq+sut7cxijTqa5rB5j
 7q1zo1fNGiCmJaK3JIAOaH3k9jeNciUPRwJxlAwAWdxl0tJNxzFxw5JQrxyps/dB3P8I
 3Bao8M39ZZzjG9mUJaJeX8mWThJw3aWOESd4Gi1tytIt0hJ3OMa051DKHYgd+VDrRYho
 DCGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyxqq22g51T5N11lE4rT+z32sxOPBjZt5ejRU5NLALXYygKqg1JKPrN/21F8o2jWkuv7FuhushKKyovEkj2D93UkWKYpc=
X-Gm-Message-State: AOJu0YwGcc5fms/p07ybYOaxLy7qF1YKlVaM5lqdr7CyjZHibzRgjR7f
 osbtOTeYbwxt8Too9twShdqvj9yMo5N/xFT1U5D61pnVdAN8J7CGrWE0DF3Ycmg=
X-Google-Smtp-Source: AGHT+IF/qi5BFgCT9qEBEQUA67UxtiTCho3S6n3h7T8Sf5cRNAwGI+svj6FTs0e/jE0Vq7BYL2HWtQ==
X-Received: by 2002:a17:90a:c70b:b0:2a2:bcbf:562c with SMTP id
 o11-20020a17090ac70b00b002a2bcbf562cmr7581870pjt.30.1712594735829; 
 Mon, 08 Apr 2024 09:45:35 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 bj17-20020a17090b089100b002a4ce78e3e8sm3784787pjb.35.2024.04.08.09.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:45:35 -0700 (PDT)
Message-ID: <bf25728b-ff73-47ff-b9e8-435b1e4f0a50@linaro.org>
Date: Mon, 8 Apr 2024 06:45:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] hw/core: Move system emulation files to system_ss
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> hotplug.c, qdev-hotplug.c and reset.c are not used by user emulation
> and need not be included in hwcore_ss.  Move them to system_ss, where
> they belong, by letting the linker pull in the stubs when needed.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   {hw/core => stubs}/hotplug-stubs.c |  0
>   hw/core/meson.build                | 14 +++-----------
>   stubs/meson.build                  |  1 +
>   3 files changed, 4 insertions(+), 11 deletions(-)
>   rename {hw/core => stubs}/hotplug-stubs.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

