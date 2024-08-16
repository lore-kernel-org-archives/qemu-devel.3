Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A737EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sevTs-00084k-LL; Fri, 16 Aug 2024 07:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sevTq-00084B-Tp
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 07:50:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sevTo-00018p-Vf
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 07:50:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d2b921cdfso1544905b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723809050; x=1724413850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OkBr1xUbWvZyC5vs+/WZ0yK7wzImK+NBfcMdOKzbEIo=;
 b=lOmKeWCAIbDGE1VH53JrqLnEobhezAUNAwjaHDzoGZRpxmmAwKn9bUd062Z488K7WN
 kefRZCYYyhzDtXTvaYCVpHvDwSyszTmwW/9DEjRqfJa72mTDYzzorxgFdKY7SYCLlXDX
 SvkGn7butAQlaPv+RFzQd80KzEDMJYFAoW+NH79iMECiF8VwlzU2GuOVTARQd3mBpLDe
 ApxGNwFAkjP+XdAdQuxulT04vCUeNT8oZoLzL8r8mcsHCscinfhD8GpSe4vCNdf7QFux
 GH1hxNfAGEm5nDLW/XMboQINq9uEU0zCf5MuO1bCQWs7zcZW07eo0Po/xDKnMZQwPZpD
 fviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723809050; x=1724413850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkBr1xUbWvZyC5vs+/WZ0yK7wzImK+NBfcMdOKzbEIo=;
 b=srKXVXnjdrOw/oWKzkQT0+v70f8vHPMxn3AkYEgxXoGugPMpY/9WdOzWzdmR45aQ/h
 q2ZTOH+Cri7qSAXRP9Dp/zVVdoW0q5fKH9FufHeF3KLUDdm8+tIM1qCT/af8ydMbLxVU
 45gLav7Mn39JKZibOUX6ZNAghKhN2o2seRjRyBLtkqnWSAAKsUTDn0Rp3F8CgD5XOUgA
 mr4vlablq9rBhgQosE/SofgmKGHxdoiTzt8W6enzjEKqSb3bm0iIt9JnJuuRadR0Mwjd
 sUG258WFbLxP7+Byo8yOTy9WUQZ3C/SykE67bIIzwTU44E/7kJJvUa5ggj6JzMeqwK+d
 A13g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIrtVOd1QKZ+7V4QMz28fmTAkinbC3Y30ZsAzxc9q8tnrCWLsH6gNaxF9vRJ5HdiRXXripVUSr8XruW+zv0ALXZ2toZw0=
X-Gm-Message-State: AOJu0Yy8sIftyIBZmNKdMoHwv+Z0orCw5p8Z5fJV0dhTPlDn1lKtw/1g
 t3SseqLJ1OQRJfmPyZRx96ZXCnfoCTq5XbLBs8o/DSgp3UPyrRj6hWIjkfMRhqA=
X-Google-Smtp-Source: AGHT+IEeG96W5l8jdte9YJV3ckCsGjgl12N7IDb5H1hASpO/fj2NLeimrhOac7l46Ze/dkf6lZfgUg==
X-Received: by 2002:a05:6a20:43a9:b0:1c3:ce0f:bfb7 with SMTP id
 adf61e73a8af0-1c904f88ce3mr3237972637.21.1723809050222; 
 Fri, 16 Aug 2024 04:50:50 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef5f30sm2472810b3a.105.2024.08.16.04.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 04:50:49 -0700 (PDT)
Message-ID: <dbbdfd50-5caf-42f2-91ef-a1d88e8391b9@linaro.org>
Date: Fri, 16 Aug 2024 21:50:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Some small tests and s390x fixes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240816072218.27125-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816072218.27125-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/16/24 17:22, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit b0d6c037ea0a825192285f149af72a73a1baaa04:
> 
>    Update version for v9.1.0-rc2 release (2024-08-15 20:32:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-08-16
> 
> for you to fetch changes up to b4be15a9f9e73fa2e7c46da559f10afc94018984:
> 
>    ci: refresh package lists with lcitool (2024-08-16 09:16:03 +0200)
> 
> ----------------------------------------------------------------
> * Fix a potential build warning in the s390x target code
> * Check for the availability of __attribute__((gcc_struct)) on MSYS2
> * Fix skipUnless decorators in Avocado tests
> * Add missing gtk-vnc package to the CI jobs


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

