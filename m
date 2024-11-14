Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10820D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcPK-0001RM-2w; Thu, 14 Nov 2024 11:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcPH-0000wG-01
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:09:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcPF-0003Ul-Fb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:09:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso6849345e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600556; x=1732205356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CiVkVQT8ZUMO/xGFD+WJb3tpg+3sGgL6H5+GHc5Jrtc=;
 b=xnnIip+ryswB5A45Ih2U9F7PMWCjAWUi92XsUIEebxpwMNnepho3nLg2p4yPW2uCTp
 6WUV+uVmsR0wp9rtiIOjyiQCOUk8BDKohyIkJE9/VDYhXY3ydlsjF7FbgjQaB0nR02pM
 TJ4hYJICiO0KBC9vyr2aXDBVGHfbAemhhGKq+KWHj/Bfsi2Gj9IkdbI3zoZtMXFcS3O5
 z01SceiB3lN8Eza8Ss7nmVfqHrAt1IfAEO9VlFF1VH6RhDlK6+C1jSX6+rD2ans8W66P
 4LWsfj9ZX3BOvwbYjROzMk42VwwLXf06/vM8wSfNn4pqiNNmFZ3UKHtyeYAWN6M0KHkc
 ZVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600556; x=1732205356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CiVkVQT8ZUMO/xGFD+WJb3tpg+3sGgL6H5+GHc5Jrtc=;
 b=iQR3NddxsD98p2j6rpPr/O7FxjmwRDx8Jrkb0lYj84HStFrx0hk2WW3xDpe79b0RCf
 HLk1roItlYcAZrnUQ8xDqjGv/j0GzDA4PcrM85e/1t4df2nvArZX4XpkKrk5/IrH0aEA
 qa4wlru6xWLWt4Ix7uHymwoXKJo5J5xFW/jaSykuBA4Hs+kAa/K8MRqTLoe8zass+/z0
 jxInrgB4CxDrGsPfeCRWybtqyJUTnQrEokzu2TVYj+ZO0VyhICCwCveRC8KjPDF7o8Ff
 9vX3mKF3ruaMzDgueJ8pKTzYRLZGf3BfPuO53MmEIM0O0W9SkIDgIsvm7qXhrk52Dq4H
 NI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP1zdJSePvUshb3B0LMz4ghyDwQ9vUXEIG2ZgfGiUSwyUvPmfLlI6zzCHmzRrt51rQewQnZP46t7ze@nongnu.org
X-Gm-Message-State: AOJu0YzLseLNRHIAP3XALd0Y62D2mt7aY0M3ZvkU4Cet3SDAlvxmrwUa
 eP5pfDpW5K4HexHuIYaLeqxG6kQpEk4Otxm+fs/zpkGFFoJfFiw2gRpMaX+H8vjsDYvMyw0cNVt
 6
X-Google-Smtp-Source: AGHT+IFT6PiulzySEO1L7B4gcuti7ub1k7x1n0JSDEi6oQq/tghad3wb63asRzWfN3i0p20f+QyS/A==
X-Received: by 2002:a5d:64e5:0:b0:37d:481e:fca with SMTP id
 ffacd0b85a97d-381f186fa0bmr23411248f8f.27.1731600555762; 
 Thu, 14 Nov 2024 08:09:15 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adad9cesm1825925f8f.37.2024.11.14.08.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:09:15 -0800 (PST)
Message-ID: <f0c6c21d-353d-4c5f-a88c-23c24d30a43a@linaro.org>
Date: Thu, 14 Nov 2024 17:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] linux-user/ppc: Reduce vdso alignment to 4k
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241112203757.804320-1-richard.henderson@linaro.org>
 <20241112203757.804320-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112203757.804320-7-richard.henderson@linaro.org>
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

On 12/11/24 20:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/ppc/Makefile.vdso |   6 ++++--
>   linux-user/ppc/vdso-32.so    | Bin 3020 -> 3020 bytes
>   linux-user/ppc/vdso-64.so    | Bin 3896 -> 3896 bytes
>   linux-user/ppc/vdso-64le.so  | Bin 3896 -> 3896 bytes
>   4 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

