Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6E7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 22:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2IEj-0006st-AK; Wed, 01 May 2024 18:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2IEa-0006qJ-3p
 for qemu-devel@nongnu.org; Wed, 01 May 2024 18:15:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2IEV-00078B-4U
 for qemu-devel@nongnu.org; Wed, 01 May 2024 18:15:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so994609b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714601721; x=1715206521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQlmYy0YIE7T85BfOwuecrIQle7FWuqWO+1dZVtK4l0=;
 b=Z8NxA5pN78aVMtQzhzY65jYoOF9B3BcxyvS4r7/bw95HdgEow29gNsDl8PV/YpUPM1
 4cNn6F2uRjHsTdYrsOZNLgasd4O12orp0XksHtn+w8r9RU/ud6jopHQCLNoqroljb5Nx
 LnganRprhtZZcvpBjE7TGqmS/u5iwzDE91hRvdIeg6wzjrf4E5+CRI2X8z1V3lP+ZcKl
 HXkKr7hUf9DbXH7J4XLacm+jFdcy3itExc2XNffR3RHNujGXzHZoeVHcFZskYQ93lomN
 MmS+VEOBf2wN8yMvl7WQGxUD0nT4e7hCuLC4Hh19uKD8X9G8jA17IBa8+xU4z+5yHY/Q
 siSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714601721; x=1715206521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQlmYy0YIE7T85BfOwuecrIQle7FWuqWO+1dZVtK4l0=;
 b=uIVtE5j66u7b7M+itvlUiByRT8E7NKXwwnCRrrsfer01r+ajHkW3RNPFTnXRCWIyaT
 r9039YaZp2j0yNRDIbh4vmO/9t0GP2vywoUjLdM1O/JZrgMBw9sEa84RWMgdh5Jm90vU
 HUiY+yllCTmMKfYWbBmYvFASgCRIEmQX+anpMZqoqCs1cj7bf2lBLr8xO/jHJJbhybyI
 UJeYSen81WTsUyD9IxD8Bk2gjlUf/aZyClAk5rEcPF0lYMviE89+zPQMK3wvTgyVYu7m
 5byzs4FBKj/4yF99RIstlKEkDgIQK80eqQB7P8ZBlgeNGHTKX2DVX1VXA5BToC2qqfT2
 o4mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyPvUJLPyaCAHqy2SURNyySzen81BFgkl93KYD2F/brkOCwrA9i1PZSnkqvQllWsFLmO1063eGvPFMwQbwca9Wch27P3M=
X-Gm-Message-State: AOJu0YzZtLygmIGnEtpyGjA3NFu0g/Paxq8Z0XFhC0/GUgTH2lwL2dDq
 hYunJjSaRl8iVfIFp3t0EwAvpnZ1sklRQomrxf89rQkEhiEdI0KkPsRLN160E7i6vA7I/naTeDr
 0
X-Google-Smtp-Source: AGHT+IHetZmCWR9x3mpYr7iMi0hHh32vQnkeB2HICfp/qPjWBENkFxexdhhewIT0WEu8UyUHeW0mCw==
X-Received: by 2002:a05:6a00:1795:b0:6ec:ebe0:e4ba with SMTP id
 s21-20020a056a00179500b006ecebe0e4bamr1347223pfg.9.1714601721182; 
 Wed, 01 May 2024 15:15:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a638c02000000b005e857e39b10sm23154925pgd.56.2024.05.01.15.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 15:15:20 -0700 (PDT)
Message-ID: <aeb7cc0d-8823-4f81-a135-795a4d45886c@linaro.org>
Date: Wed, 1 May 2024 15:15:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] QGA misc changes for 2024-05-01
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240501074340.19641-1-kkostiuk@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240501074340.19641-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/1/24 00:43, Konstantin Kostiuk wrote:
> The following changes since commit 9c6c079bc6723da8061ccfb44361d67b1dd785dd:
> 
>    Merge tag 'pull-target-arm-20240430' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-04-30 09:58:54 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git  tags/qga-pull-2024-05-01
> 
> for you to fetch changes up to 6b9296ba7a9cf7adb157c51c124ca522d2180739:
> 
>    qga: Implement SSH commands for Windows (2024-05-01 10:35:45 +0300)
> 
> ----------------------------------------------------------------
> qga-pull-2024-05-01

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


