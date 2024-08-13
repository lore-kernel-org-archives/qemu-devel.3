Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69F9C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0gr-0002xu-DL; Tue, 13 Aug 2024 19:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0gn-0002ue-BP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:12:29 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0gk-0004N8-BB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:12:28 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db16129143so3418243b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590745; x=1724195545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOO081gv4TsYwdUqSrBiqVLz7Nt3aMfzd+Mu2FwWgU0=;
 b=q3CQ7UBneU9eJdniRFLg645rlpQbnOlcGuy0aBsQP25URKOhYcF4YIapXQL2fwuZtQ
 5SsUhJgJZYXkgkyNO+koKVfjupE8tloauhQ3Ntk8arq+tMiTNrA/FfZFIDBmikhbMWcA
 IUQQh3Q1IdFbsg6uN2AZwDd0p0QFFbVJ88kJrVt8tGaGRd/RE3UxjuwAqVZib5BqJ0v0
 gadeLsUgC8yZW+S2AMQAZ/tX6vW8EPt/bB8/L/2twtLCD+kpAarF4bClgXQvD+PlvONA
 tN5CgNyJtvJVaFfiKA46OTO1bO9FIZSZkBXN8XINfrQmSU7RuNI/PaHG/g1eQshT2b77
 yW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590745; x=1724195545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOO081gv4TsYwdUqSrBiqVLz7Nt3aMfzd+Mu2FwWgU0=;
 b=vL/r5CQi8fGb4g5IwVPol4CGXqQDHfGMnHm6SP7NcU9930fBRwobuEg6LrGl95Srul
 4Hq14dU57Bi75BlJbIVFAAAyyZmb6c07VSvi6XTBh/KBnzsnpDioU8vt+hMajZjwR+GN
 Ee5ULF5cUrqAS3l74xsj349H5+5KA8l1dkjcP2kDpCaAToFI+1wacJeAJcCeiyvt90xy
 2eGbOMRmBbEOOriFsGJURyiQ9nXRZvA8E6E7BqUwhphS8pXi6Qyz/VQYKtwieQgrXM/s
 PjVqEcsevsvIr16CevFX1tW7EDTO0/zvc9SLBYivrqoOH42OftJ8NYuTQyjcT1GxG+BA
 G0mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4pR++SeMgdIcQ51wWR2xgnH/5Yd+2AklCMryBl6NSj9++k99uXY4XQaholca7DjiQBNJKXaqjX8e/w4jdCAqfEqjEYmg=
X-Gm-Message-State: AOJu0YwYdhc/z98j25Rbt4V2dq4SZVx3VS0LbdXhaELwUw6iHr1i8pfU
 SBkGcSfdk4aKoN7DXpeFD/aR8IwGBCFwVEOARkugTxjH+58kF4AG0YQWOhhAubs=
X-Google-Smtp-Source: AGHT+IEcLPZFy4CMYI6tKcKu7YVRzZ56Egp/KFIXr4pHRUUK4YGy/sDEvST0fYwLqQv1LahU7vmbXg==
X-Received: by 2002:a05:6808:1825:b0:3db:19b9:1e39 with SMTP id
 5614622812f47-3dd2997f78emr835132b6e.50.1723590744871; 
 Tue, 13 Aug 2024 16:12:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c697a6c464sm1993114a12.76.2024.08.13.16.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:12:24 -0700 (PDT)
Message-ID: <998ac96c-9256-4015-a3ea-d783f6330ec9@linaro.org>
Date: Wed, 14 Aug 2024 09:12:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 07/10] hw: Define new
 device_class_set_legacy_reset()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 8/14/24 02:52, Peter Maydell wrote:
> Define a device_class_set_legacy_reset() function which
> sets theDeviceClass::reset field. This serves two purposes:
>   * it makes it clearer to the person writing code that
>     DeviceClass::reset is now legacy and they should look for
>     the new alternative (which is Resettable)
>   * it makes it easier to rename the reset field (which in turn
>     makes it easier to find places that call it)
> 
> The Coccinelle script can be used to automatically convert code that
> was doing an open-coded assignment toDeviceClass::reset to call
> device_class_set_legacy_reset() instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/coccinelle/device-reset.cocci | 30 +++++++++++++++++++++++++++
>   include/hw/qdev-core.h                | 13 ++++++++++++
>   hw/core/qdev.c                        |  5 +++++
>   3 files changed, 48 insertions(+)
>   create mode 100644 scripts/coccinelle/device-reset.cocci

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

