Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3679EC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNHG-0002qk-UO; Tue, 21 Jan 2025 18:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNHF-0002qH-85
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:03:21 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNHB-000328-9C
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:03:19 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so10752467a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737500595; x=1738105395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GcutIom7S3tEE2IGaEQJe0kYDcNIFERPJMY0HamDLN8=;
 b=i+qf9yBGzguXso+f1LXTFrF3oqRK8E2uszW0mo6P6cKb2EnZwTiI1fRhG6LU5pKnJz
 J8Y6cj4tmZSnx8ubELIY5N7bWifnSlhSzGq/i5aERnWW0peV94LHhcR8kedSblDs+uLe
 lW3R3PyG3R998k6zZehUbIVzzX8Y0UY2q6D82dou/zF3z+sr0gHd4IrpmrUvkihQ6MpM
 7XXdaIWVvUSVBW3zYWYvApS262PrJcurFnknDnwiMF4Q66B4fs5mmW21NHeyxnKcdkGw
 z3AW9E3UJ9MwEQaRewJbs1PGoupDtF29t/7k32vm+UbQhv2DyLElJ/s8X6Htb7qYmppx
 5Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737500595; x=1738105395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GcutIom7S3tEE2IGaEQJe0kYDcNIFERPJMY0HamDLN8=;
 b=F+v5qEA8t6w6UoioUml8vNUxguAcBzl4lOeg7N2zx/JFhRfO3SMrJLpoe6dyxwFXrp
 36G+5k/zsOj7Zx0/8LqdH+SH4a/F5l+vIz2p9z/2sbLnYWDHQgjSbpBGL0BAMIkDHSAM
 Ex7JNF/ACKlAaJk1piNgYUXK4j/cntNIyIOr7sn8o4nE4paHL8CFIk1U+3Bhv9Yh9jWc
 +rIvTdtusunBzyqunGk//qHgfMiVPUhYeHxGOQAfm85fy2VNZ5evxTCdJ8GcQ6POsQzt
 NcNQvoQq9i1d3G3eZ1RSHjehMb8auwoNpgqEq15sPIF5+ku5jrYnpKPYr1Nj6G0YxX2V
 6K2A==
X-Gm-Message-State: AOJu0YzkA0Ugy6S5/5uPYAlyUztQQ/W8ILynLXOrWAzAtLoZgi82BP5Q
 utq9Vgi+q6js8vm6OUZ1u4LEzelXQEqKD0O+zYvAd3msT96hEOckvb/+t1ALLVy8qSuz8uWCc/k
 i
X-Gm-Gg: ASbGncsS3lV8Vl5s6+pgizLJOZbi986PtL4CcPT8Zp+KM0Ez5OwDpQGFjMUF5wjW6b1
 eJmF878ByBotpOGVBUP56JxVMLIVWL/WmA5PeNyr/xO9KW4InUh9/39o7Uw+rpoyyOUSsnU4YHz
 hflmHyTE1pBnbqf4haH6jB/kUwtw2FgAgtnkVudKIAy1T7WFZ/nSna9XJ6wRgJg5DNKDcz5Gtj2
 8moh6iIO43hHlQRy4gCMpu71ocFpiwLGkJ/3PXpubEf+6/yURO25lzus/YPLTT+/aqGMVqKrj8h
 PHAR72QguHSB+YKb76K18u4DqTbcNLzJ6cry
X-Google-Smtp-Source: AGHT+IFEuWhINacyg35C9mCllVeq1h6AbALMDwEGx00pwmLV0RcEMxP2/IHw/anehpTJbBNMOOUgVg==
X-Received: by 2002:a17:90b:524b:b0:2ea:3d2e:a0d7 with SMTP id
 98e67ed59e1d1-2f782c9846fmr29422422a91.15.1737500594848; 
 Tue, 21 Jan 2025 15:03:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7e6b71e75sm40491a91.30.2025.01.21.15.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:03:14 -0800 (PST)
Message-ID: <21f53d1e-3760-4ca3-a662-e3f48b7b49ba@linaro.org>
Date: Tue, 21 Jan 2025 15:03:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/ipack: Remove legacy qemu_allocate_irqs() use
To: qemu-devel@nongnu.org
References: <20250121155526.29982-1-philmd@linaro.org>
 <20250121155526.29982-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121155526.29982-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/21/25 07:55, Philippe Mathieu-Daudé wrote:
> No need to dynamically allocate IRQ when we know before hands
> how many we'll use. Declare the 2 of them in IPackDevice state
> and initialize them in the DeviceRealize handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/ipack/ipack.h | 7 ++-----
>   hw/char/ipoctal232.c     | 4 ++--
>   hw/ipack/ipack.c         | 5 +----
>   hw/ipack/tpci200.c       | 6 +++---
>   4 files changed, 8 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

