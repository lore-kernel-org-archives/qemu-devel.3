Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E51C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOE6-0007Bi-Ck; Thu, 01 Aug 2024 01:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZOE5-0007BE-8v
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:19:45 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZOE0-0000t8-FR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:19:41 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so94629881fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722489578; x=1723094378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AKpJYklq1Xog1Mxm0++EnSVi030b9sU/bDkF4yrwdUw=;
 b=zSCzDbBQkqmsXr01/YM391Q7zwuzAQGR20JFhDm63t2PlmTxEONXgfOT9eoCd0tNsG
 ISdzwVXCBnH1WyS26MiKUEzPZzJWyOcABXaumXuSq1MjjhT/1ulXU6mWJjEPRYI6OXq8
 tJ9pjJYDW2+q4TW9Vti4APbBonqi2Tof6wb5Y9wrX+NXt+7KO0ib89hi6HV8foXuA6Or
 UC+YIfTufj4TWFjjKgAnDlg75rXeHe5xH3eCrXGmL3HN/SZ20moMIsYOr04e8uos8RAB
 EsW+8/RHmq6pJDa3FsE1TszFCvWLhzETYZ4Hqo/bOsG/RZszQTpKxFnmh3i5wVGqwHvG
 8TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722489578; x=1723094378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKpJYklq1Xog1Mxm0++EnSVi030b9sU/bDkF4yrwdUw=;
 b=OLbZKSNHcjEcp3bpliDoyPmweDzIfEZ4yPdYHfBfxwFodYRqfN4z/Ybp0CsLtkPyGC
 u4xGiJNKZ0/8LgheG4/pVUGxGaii7oiS6+d1E2tf9Lnt0z/7hYMkv1Q1BdsA5y21ZbqJ
 Pw8jO0NPJY4L+cTuI9xPWlEPyLOFTqODaB3j4DHI8sA9IRNok3nDEiavL3SJeIBvU0Gb
 YzNZhJY3Pf5kcxH9ZmW5nOjqwIwxcRdA6NZK2s5CsJypxu5XYW5XCCSkMqmT+uUhoi0J
 ZGPu6y15JAFP/A2pyirZ+mNgH+aSFqk76pno/S//t+FiG70KKNlENryXZHp3zzxO6VrY
 A5DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhBDzfD3hCAkSfsykGYm2/8gcvtjZJbXxhagzFZGu01xClDlZaz3ZwolopRLhn34mUNoHrAOW97x1xYOIWsZegEzkpnQs=
X-Gm-Message-State: AOJu0YwrFwQAoHfQFJkHUKVMORpb8hjvyM95zB0Te6vMnD5rIq7LIEnQ
 pQ1rSW3ybKlom4uA1ctC40nIe6jBqYcLh+5ziMMUDHhJiSvaW8oMuoIhGZC+ISM=
X-Google-Smtp-Source: AGHT+IGaEQTe88q5AmZy+8bCRPC81CyhVW8etLFj4JyqZxVStlNgQ06h9+VZQaIB/sBL/QwFUigSAQ==
X-Received: by 2002:a2e:b00b:0:b0:2ef:23af:f202 with SMTP id
 38308e7fff4ca-2f1533b2145mr10226371fa.46.1722489578027; 
 Wed, 31 Jul 2024 22:19:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb82d5sm841247766b.199.2024.07.31.22.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 22:19:37 -0700 (PDT)
Message-ID: <9c8360f9-c15d-4d50-9f30-49c3458a8018@linaro.org>
Date: Thu, 1 Aug 2024 07:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Makefile: trigger re-configure on updated pythondeps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240731140232.22193-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731140232.22193-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 31/7/24 16:02, Alex Bennée wrote:
> If we add additional deps for meson we need to ensure we trigger a
> reconfigure to make sure everything is set up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 02a257584b..0281a883a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -78,7 +78,7 @@ x := $(shell rm -rf meson-private meson-info meson-logs)
>   endif
>   
>   # 1. ensure config-host.mak is up-to-date
> -config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/VERSION
> +config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/pythondeps.toml $(SRC_PATH)/VERSION

This long line could be split with \, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   	@echo config-host.mak is out-of-date, running configure
>   	@if test -f meson-private/coredata.dat; then \
>   	  ./config.status --skip-meson; \


