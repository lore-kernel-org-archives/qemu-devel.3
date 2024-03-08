Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EADC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rid83-0006Ja-UB; Fri, 08 Mar 2024 11:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rid81-0006J3-Ox
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:31:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rid80-0003Ak-5S
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:31:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412fc5f5152so16635935e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709915482; x=1710520282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZceiDNe4Pk4vwFUlsXaNjT4fs3ZZIBnah+BnXTL1+6Y=;
 b=boJuzn/XrDmrOQ6bHO/zrFJ/4sYRqPzfvveRMWSGvWReBu4aWpizeiPgzlWIKvhRad
 +uW22UqBtdnqYZ1im8DyrcHLWavGugK0hZ/OQK+EIezxmkos6vO7oZZD4ep76iF9tQx8
 KYYlRsiBRRpKHfk4MevRFVPBodut14vZ6Sm8hH1YHZUOPpmx/aM9MmxUgqd1Ji0mP8Ug
 n1sXeocdvE9BpS6dF4r5KhcgIdogDRV81/Kr5dI2OVFNRMnMj802/Kqp4F9PCGhTdjUC
 afpWWFahkCrXt4MwtJrA9bn6YEK65CFdhzTwL6EXhQA/uZiKsaTLS/ekNsh4Dtn79aL4
 xKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709915482; x=1710520282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZceiDNe4Pk4vwFUlsXaNjT4fs3ZZIBnah+BnXTL1+6Y=;
 b=QteMioOAWpyGHsS5emBGhgf1Of+zEOtAQgGnxVUntyhgOkhxkCo60AN9EhE8GLy3kg
 tfuUsWMnU1Rh0MFPWg7tmqZC7B1pFe+qUvJF+4vSyZpvQLcsvM29jRSmaxPvS3mvn+wq
 ubs3MygYNokFJyBXPX/BdP4vewCKNwAJDJ8ylfIOokejRXYZ44CV5ND4KyZzoZNBv0yJ
 q0+l5lTazD3m6vx6KbOm5i7KLgH2zictxUt8OLU43/HwJOGaxUJa0WTZtwWA+rNhH48k
 JX53oisfqgw25HMmqvo4zJGnT92q8alRx8hvne9PpksSuHtajF0pdcqrJ+FaR/UXi6Mq
 tI4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyUT+bnvxVfmOaYdNUk67kQniQn/t24lRQ9HTeU+BpILCXfTKQlUQ89m9OdX8Deo1q7bxi3LwHWmj68hbclWdVqsck9S0=
X-Gm-Message-State: AOJu0YzE1bxv4RLuaQXYmk4fwheHxzE3i05vlE3nmEdArXZEKEVZvIQP
 PGFU9Aj4oPumOwIS2Qa0a13dfGXf8RRasmvhL31MBvI0gnc75+w7Pw/1nUgRJek=
X-Google-Smtp-Source: AGHT+IFlhBazuzAF3FH28Z3HmZoMmuiZJJ0wsDu4xMWhByq6ZdxgdFwkjGEP51AgqXk/+rSl5muYiQ==
X-Received: by 2002:a05:600c:3111:b0:412:ffc9:d551 with SMTP id
 g17-20020a05600c311100b00412ffc9d551mr5533835wmo.14.1709915481622; 
 Fri, 08 Mar 2024 08:31:21 -0800 (PST)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-62.dsl.sta.abo.bbox.fr.
 [176.184.49.62]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b0041312c4865asm4682487wmq.2.2024.03.08.08.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:31:21 -0800 (PST)
Message-ID: <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
Date: Fri, 8 Mar 2024 17:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Zhao,

On 8/3/24 17:01, Zhao Liu wrote:

> ---
> Zhao Liu (13):
>    hw/core/machine-smp: Remove deprecated "parameter=0" SMP
>      configurations
>    hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
>      configurations
>    hw/core/machine-smp: Calculate total CPUs once in
>      machine_parse_smp_config()
>    tests/unit/test-smp-parse: Drop the unsupported "dies=1" case
>    tests/unit/test-smp-parse: Use CPU number macros in invalid topology
>      case
>    tests/unit/test-smp-parse: Bump max_cpus to 4096
>    tests/unit/test-smp-parse: Make test cases aware of the book/drawer
>    tests/unit/test-smp-parse: Test "books" parameter in -smp
>    tests/unit/test-smp-parse: Test "drawers" parameter in -smp
>    tests/unit/test-smp-parse: Test "drawers" and "books" combination case
>    tests/unit/test-smp-parse: Test the full 7-levels topology hierarchy
>    tests/unit/test-smp-parse: Test smp_props.has_clusters
>    tests/unit/test-smp-parse: Test "parameter=0" SMP configurations

Can you share your base commit please?

Applying: hw/core/machine-smp: Remove deprecated "parameter=0" SMP 
configurations
Applying: hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP 
configurations
error: patch failed: docs/about/deprecated.rst:47
error: docs/about/deprecated.rst: patch does not apply
Patch failed at 0002 hw/core/machine-smp: Deprecate unsupported 
"parameter=1" SMP configurations


