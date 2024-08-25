Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C25C52D6F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 00:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1si1YL-0006h1-Cm; Sat, 24 Aug 2024 20:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1si1YK-0006g0-A6
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 20:56:20 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1si1YI-0005Ev-FA
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 20:56:20 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70940c9657dso2469530a34.1
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724547376; x=1725152176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4OOby9xhVQ9Is9uyFNgofdcb1TLkEOYfYzBf8KU3Ck=;
 b=spgnTFKrrJbxQ6HaKUL4adciEiU4u7bUB+tSYtg1myhrrQsAET4qJ7W6gEg1g67AG+
 nBHt0yxUiBa+T5GrR+VSdatHbDprrIRuMKwxJvRRtabNLyjGPsJI7I15nqAha3oFlDd1
 6YBtOvSk08MqphiZBVKnVMJNpYKcXiS/GJEOFXowehHz4ixnicKUtSSmv/HyYfP9DOfX
 eyKWXkf2v51XKvBiw7PROWgUr/1U/GxjUukQUdgFbbAqRGtGUNWIg3ra5XLiyQGrAR1g
 4Ir6NecJAWSxPIiB6mfRliwuwuHd/jgR8uEMz3EONoNl/WeTS2liMtxL8IS5CeStgXIY
 MYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724547376; x=1725152176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4OOby9xhVQ9Is9uyFNgofdcb1TLkEOYfYzBf8KU3Ck=;
 b=qgt8TlQUAa573GXAJU5GBsDmA8qszQRm+Bo6SJ3fbf6zLKXEp2Hccsp2qWaI2rZxTx
 4zckxP/6NJjQP5rj01m5wW5f9TEg7EwPzX8sNqKbDCp07YuYhCowZ26SKI+i2uECtnbe
 6Qkz212yK1F2ZEzF8KzmA+U4/ykaVEHhlB5yzIFsNSQ5NLU+0wdqG5PqdblDbdmGrigU
 walohBS8exntmJhWStwHGScEm22W380rQ7aX6GLdpPYmWR05dtNCDu6puGF8qAbgRVt5
 YSwmcBomxLFoXYASrHpaBvV0NLCmdDZGrBcJiDUiZgA/wIbAq690hYnUAhltauv3oZnJ
 VR8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhBVZh8pBdhdnZZw6PNoFBewWoFanZa0Uitwa0vydStzgBIH+5nUTE1qBbPYUhzAFo5MxRZhScpta/@nongnu.org
X-Gm-Message-State: AOJu0Yxdtz7A9S4M79Nczoa7ku8byNBG8K+5t/94gB/xOZMQWA1BzKr3
 JtoCALXNhbk5Rd7tu0k9twFnti8mGoeUZyWDDt2LUz5bxtstIONkjRWOvQlF6fQ=
X-Google-Smtp-Source: AGHT+IEv5x9NVcQo/5dEKyO7C3j6DeylNXXoAT7eGIEKmehQH+H9Auh74qva8RSetwHpuoxWSQbhBg==
X-Received: by 2002:a05:6830:7318:b0:708:9433:3574 with SMTP id
 46e09a7af769-70e0eb2b6a3mr7249265a34.16.1724547376420; 
 Sat, 24 Aug 2024 17:56:16 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.146])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03b85c97sm1314932a34.65.2024.08.24.17.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Aug 2024 17:56:16 -0700 (PDT)
Message-ID: <15121255-37bf-46f8-8ccf-277ea231df8b@linaro.org>
Date: Sun, 25 Aug 2024 10:56:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-9.1 0/3] Trivial patches for 2024-08-23
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240823141542.1411594-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240823141542.1411594-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/24/24 00:15, Michael Tokarev wrote:
> The following changes since commit 407f9a4b121eb65166375c410e14d7b704bc1106:
> 
>    Update version for v9.1.0-rc3 release (2024-08-22 15:07:32 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to d6192f3f7593536a4285e8ab6c6cf3f34973ce62:
> 
>    hw/display/vhost-user-gpu.c: fix vhost_user_gpu_chr_read() (2024-08-23 12:10:28 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2024-08-23
> 
> There are just 3 patches in here, one adding a comment (no code changes)
> and two fixing bugs (one is a regression bug).  I think it's suitable for
> 9.1


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

