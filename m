Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 16:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s02Eh-0002Ez-Ch; Thu, 25 Apr 2024 12:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s02Ee-0002E5-Bl
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:46:12 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s02Eb-0003Je-Bh
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:46:10 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6eb55942409so626435a34.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714063568; x=1714668368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bk7xD4Z+wnEjumDHf85N1cBVZhmG++l/jd5kbNi9uWU=;
 b=vWbLWDTJFRAJdI9enZ4+jY3Wl7O1gkmmbjwZTN0tQbVCTAl5E2I1nZogLwuVVqF0PD
 5DBB/d4TNKFwv5ysGRFvvCwGF7bLOIApzt3oHvkVZkQxztBXeWWr7qAmhq47LVnsGCTU
 WIZTdncTSekixX4+GLeHkUsgdAZMSbaJ4OyrJWsYTR+8rkyRVVaa/SZAQVaEhLiOqLN7
 MnGGeJIK9+sOJY9FR1VsEt/L1uco+H7cNRBL2gnJE2CEzrGdQDLeNfJWeW37p45eQLDQ
 LLNoc2zdjDHbQkqJuBubfRxRBHEHEgxPWD76PYzfhTssjca4yn3C1NWOFquRWCkbrFqV
 jdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714063568; x=1714668368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk7xD4Z+wnEjumDHf85N1cBVZhmG++l/jd5kbNi9uWU=;
 b=hkBqo5lTqWHDEi5DpH1uctMbBa0gv1PW78Dg9T0prnUkEe/g/ena7q/5ogPUq1+Fed
 d3nvqSGLn6+nEteUjMse1NtwPvuQt4ICFn73ITuChS0nAlXvA4bc2I0pROeQQ0LBlcp9
 hjjItD7SDCHamKvYz8OIi6e3uYKBxKbHyR8wUwzoXsmaAJLxnrfe6GQBOoYvpkUP4ekA
 v248hGg87XHrju2ZacjA7RcWOf52vme+JoDmAhlp5N2SUXHrJDL14x9Z+rHXmNiL2jd5
 2Tny+GoIaMRjhFV2x0kyIHuTSc6oq6Vk89C+bproIhJpFfuPBDjy+3i0d8swHIKjS+9G
 Re9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCy1eQcNkQu+G7WVhd9Ov3kjlWBv79RduMY05qW1rEoIrCRkuZ3VkKvGZtFcqghmeW6v4SACLxnS/W0ROuvM+HG70Py/k=
X-Gm-Message-State: AOJu0YyD3MkrqRnOxq8nhntAiF+sKAVkn6Camyt1tZEgkgz0GTL7R1we
 DLE1zpfJeWcDMhLeGkLyA2WmtPQ4/XgPIemDN1IZJh3MmNCQsD8vCQbYKjC22StuA5osvxT+yXL
 A
X-Google-Smtp-Source: AGHT+IE2jTuzoHlXW29MXwP+NBk5Zz6LD5WoKQaF6d90b9qKxxw70xt3kZsVO4sC7M8gYCD9F3U3Vg==
X-Received: by 2002:a9d:77d4:0:b0:6eb:b266:a2a1 with SMTP id
 w20-20020a9d77d4000000b006ebb266a2a1mr7705702otl.19.1714063568101; 
 Thu, 25 Apr 2024 09:46:08 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d?
 ([2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a05683014d400b006eb77e42ff5sm2746637otq.26.2024.04.25.09.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 09:46:07 -0700 (PDT)
Message-ID: <7eb856f2-4415-48c4-9142-d24069acc4f5@linaro.org>
Date: Thu, 25 Apr 2024 09:46:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/16] CI job updates, header cleanups and other misc
 patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240425145737.451721-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240425145737.451721-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 4/25/24 07:57, Thomas Huth wrote:
> The following changes since commit 5da72194df36535d773c8bdc951529ecd5e31707:
> 
>    Merge tag 'pull-tcg-20240424' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-04-24 15:51:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-04-25
> 
> for you to fetch changes up to 17523a38194d80f2955c6a8e0702e0fc86dd083d:
> 
>    target/s390x: Remove KVM stubs in cpu_models.h (2024-04-25 15:15:25 +0200)
> 
> ----------------------------------------------------------------
> * Update OpenBSD CI image to 7.5
> * Update/remove Ubuntu 20.04 CI jobs
> * Update (most) CentOS 8 CI jobs to CentOS 9
> * Some clean-ups and improvements to travis.yml
> * Minor test fixes
> * s390x header clean-ups
> * Doc updates
> 
> v2: Drop the problematic patch that updates the custom CentOS 8 runner

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


