Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB428C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cYu-00060j-TL; Wed, 08 May 2024 04:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cYt-00060L-3h
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:22:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cYp-0006EH-JT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:22:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so28370205e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715156518; x=1715761318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GF28yG1IY3Nv/IedZvDPeIbJ8Qbuj9SyoueqTroAHFQ=;
 b=tiNpiZ/Z2zyEY+lJp1/wCJ7JFWDFZgC7zPvfaj5Tb/Mtl7goK5SfteAKlzOh8lJRxF
 WSi2RmgxlPxq1tZmYO839O7PlKWp1nhCTjHkN7qzlUGGqc7V7cefBJf7yUQvpS/bkVF2
 FQw57DPczMWEjHBDbnAfIvLZladyfHvBTzFspuA82wETHiMtD27lQ6/+i1Go/mp91o2e
 O1dhMvmmZ+rCX/eHbgxk3aNZUOvYGILPPmc0piXU2myiVfwxX7VEgQl661cd5NELsdHy
 R3hdijMe1KTQ0ayv+Xzcm9PDbK6AZVLwkeQ9ZDRyOnVIpLWIFw+hx/qxoNHPeaOMRyle
 amuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715156518; x=1715761318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GF28yG1IY3Nv/IedZvDPeIbJ8Qbuj9SyoueqTroAHFQ=;
 b=vUb5J1SLmWalOVwwlvOFoXM7a4/C8nJOPPeaTLp3CWP196JMU4MLgtcA4ppp5megzl
 8JEMO9zO0x9OEM0Dk6IInpp31G2FuoMVF0AyRm77DacXzQ6fVxeoymIryMG6rkYiet5F
 fcXTTldYgbslXSNd9wKU4ymZhr9uUCTSnmUmCcF+Kl1XP4G1ey+/4vrvMfV8gq5HwAOb
 s3NhbdqYhA4r+yz0e9NsdOB39VHZurkoN9reTpqQicy6Vx6J8OwsAhz24fQcUhJTcq/L
 zgd2p2YNLVm0SlOLQBKzaCtqm/AASKHo+C746rFqf1Yzph5xk0LKQQd+aO/tugnSswbp
 e9Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF79wAz11/gz4yIsjgfM7V9nmCUMY99DC4nMbdhCyaaoG8tytBPspjeDIckrDsySlWcnMD7eSXBAebygewXsl0D8vC37s=
X-Gm-Message-State: AOJu0YwCc8BsYMH/YWNLeF1dOG/8QLLdHBAyjrs+0Ij3MYXhN6vRzLSE
 yscpP5ZHPIVabSB74hRYy9XmOQDXAqVEwfCUYVqYulBrRX5wXm79qkbvexmtrp8e/KiOqQZyy1i
 b
X-Google-Smtp-Source: AGHT+IHWwbX2pWZbcYbyooFVMl4TBco7n6rMBVWqS0ecIgBlyM7rR0Ir34LM0qLTdPT5trNVOLvDog==
X-Received: by 2002:a05:600c:3588:b0:41b:dafe:ff78 with SMTP id
 5b1f17b1804b1-41f714f6bf9mr15059685e9.20.1715156518023; 
 Wed, 08 May 2024 01:21:58 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b00419f572671dsm1416177wmq.20.2024.05.08.01.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:21:57 -0700 (PDT)
Message-ID: <157d3cb7-bef6-4da7-a6c8-49648874e3e3@linaro.org>
Date: Wed, 8 May 2024 10:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] meson: move libfdt together with other dependencies
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508075105.15510-1-pbonzini@redhat.com>
 <20240508075105.15510-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508075105.15510-3-pbonzini@redhat.com>
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

On 8/5/24 09:51, Paolo Bonzini wrote:
> Move the libfdt detection code together with other dependencies instead
> of keeping it with subprojects.  This has the disadvantage of performing
> the detection even if no target requires libfdt; but it has the advantage
> that Kconfig will be able to observe the availability of the library.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 79 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 38 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



