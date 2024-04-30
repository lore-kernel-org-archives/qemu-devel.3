Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C177DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfv-0005FR-5f; Tue, 30 Apr 2024 12:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1qfr-00051S-Mw
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1qfp-0005kT-1S
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f3e3d789cdso3833173b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495782; x=1715100582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IarsLd1siC2KBKBAZ2wwcXkmppgtkgBa0Bs/A2SwmS0=;
 b=eGOcwkSmPAR23VG/DFGW5hcdyOEy71jgjT5aThIOOpRUSEtcqmn1r/27uXdyte+LLY
 mUBO3Ck+Yz8aSaDuXmWEqCi2JIiT6qDjc8xYr79kCMmDlFleuxZDAe2Z1e4R1yG0QOS3
 KJOVx9QbnfVysuiN2U6LAJZtNcQHf7Vhv4hKApReWiE7MeHNqHumUCuXVSlW3oKEfTa7
 1mHeOeVE0N2+4DU+Ba7u8bWy3rCE+ajrBLl4JvnPEcLe/zWQToXToWoaXs4UM8W+RGby
 uz3fALHGNiWfyg7JXoiRsoURjorLKsMb267qeOrn/J0/M6EpxTxFCNlUQQf5hwm3/WHL
 m+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495782; x=1715100582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IarsLd1siC2KBKBAZ2wwcXkmppgtkgBa0Bs/A2SwmS0=;
 b=R0xJxi/Jt3BdUcW3gCX+mRf/82Me9zbzUMCy59fLHGmfX5ZmnpCK99ZjA0dnSF9afv
 Z9FWooqKSLom0jB4OcIuLDzyYZ8BFTaXnFCAQfylDUo4XivGNCK24RViXfJ7a3ExYke3
 dm01skYYPZpjHUaQwLziP7CCxopvyiztWhHrByo8ehOR4JDPAEruiELRgfYIOQE7EDOX
 0wIfJvTRxSpMMDu4lOAY46IaL84hG72XDlmgYyHDTIIGkj4sDPVyRhy1/k49zPuFmIbi
 8XntNayc7XivUQF2z+DIpmS2jZMjZH0qIPRHTpQwTQ6b0ffNgiyo84iji4OfVEW9+3MU
 CVFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTwPNum7BaOXTVw9q+1FyXkowYs8FYxIMja5vTnavJhqrMoaOqDt7HhWpUHzJE2+FAJwna54x227scKwoR3FG2NPPUg+o=
X-Gm-Message-State: AOJu0Yz+GE8hv8wefOzlwRRemFjSxbaoAKzZM4Y7QHKQK+Ql5LX+OcL4
 sSKFZLEcqXovS3Roxc1XSLpsSPsfXz0Rb0rvbv1hK7qJjupF8XgaCWFCSc/O93Y=
X-Google-Smtp-Source: AGHT+IElVy++anV7xVJAaVTKt1ceGRMiCr0H2YBc5LTS8iuBSqMcN0Xef80XhfWrafOiDnao2WDMLw==
X-Received: by 2002:a05:6a00:39a5:b0:6ea:b818:f499 with SMTP id
 fi37-20020a056a0039a500b006eab818f499mr262592pfb.19.1714495782308; 
 Tue, 30 Apr 2024 09:49:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a056a00170600b006e6b180d87asm21311037pfc.35.2024.04.30.09.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 09:49:41 -0700 (PDT)
Message-ID: <69b01fbf-9648-4169-99e9-422a6f698596@linaro.org>
Date: Tue, 30 Apr 2024 09:49:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/17] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240429023043.2607982-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429023043.2607982-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/28/24 19:30, Song Gao wrote:
> The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:
> 
>    Merge tag 'accel-20240426' ofhttps://github.com/philmd/qemu  into staging (2024-04-26 15:28:13 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20240429
> 
> for you to fetch changes up to 841ef2c9df5317e32de590424b0c5c36fbb4de78:
> 
>    hw/loongarch: Add cells missing from rtc node (2024-04-29 10:25:56 +0800)
> 
> ----------------------------------------------------------------
> Add boot LoongArch elf kernel with FDT
> 
> v2: Fix 'make check-tcg' failed.

Gah, wrong hotkey:Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as 
appropriate.



r~


