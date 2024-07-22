Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C43C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmlB-00059N-6z; Mon, 22 Jul 2024 02:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmlA-00058u-7B
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:43:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVml8-00035x-6a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:42:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so27769645e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721630575; x=1722235375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KPqc7MrWap17Nbcp3hdIUkiPO/kcoGf38DyP/tbov1E=;
 b=Oiqdj6PgJvlXLCHs7VcwyNxZd+w4gerIAUZ4JgFNhxOvNfZea9xn+1GZicba5nELOO
 vfu6NBfbPPK8L9YJT594k9uzU3anxCIQVFY9cQSFmxL/NjKLjteTLLeUkadZJ73UldI7
 2GXTdnOpyymxMws6jQBgBWgDxwP7EkLAl279aIv2Q7VwDgBEH885KE8zHWjPdz22atgp
 O7rg1DwsoUOzBQXIFtNN2BgkPXlxskK7nIeArcaktiCBn5Iwf83sWEuyByaP2W7UHJE9
 t6WFWqI04ctMTXextsFysTmljSVjokCIs7O+4oKMiql9T8KhPC1Tg/Dr+WK8OHc8lc+B
 Xs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721630575; x=1722235375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPqc7MrWap17Nbcp3hdIUkiPO/kcoGf38DyP/tbov1E=;
 b=LbDp84cZ6HcRyNWMnXxgwwpJg5/n0CbB7SV7ujU2U2FUDR7IyJutev+AFIq8LtBMp6
 A/x7+swG9C641XoCCQKq2h76rOW9OOO86fpKpjg+7P3E3DZ+V7SR4Lks+y9yF7BF0L7H
 N0tLMpWSsHWZtDowralRHKyDJS4z7ogacEPGgPAT3DDD8AJyJqUv3nZ+uWGoOMFuwob/
 iMjN99ok/CFUMgSmHe64Iox6NtOrgwt8euhEwypmUCaxaUORpCYOYuaC3z1TZg3KhVqM
 RGSdCV+ai9jBP0CenYRg1ym6avhc/wvYdgL+z7Ar4oSPisWldxOg2CENslkOjeeOVs5U
 QEDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9EWHhTp8DPyF/3uucKvQBmtuqVCs9p1fhZ+m7t/e+pdb3nC5M41CwuR2ee94zzKFhp/0ZAONgSZhNHFPK11H51APJJDE=
X-Gm-Message-State: AOJu0YwSF740u8u9nEbRLmZbSDdGn3LTbMoMc44a1DTwS+uONCk49E5x
 GR4OLfObi5KodI+b5B6Ygj1zkUuY0sLrn7CtlZ02txU+qhoQjKAHvy52/wOXWZ8IMuHtv6R/7SK
 C
X-Google-Smtp-Source: AGHT+IFObpYxMawCK7iuGWSLE+oBpDcWNhTPO7BuTR5HVICnXf27IscqLrokpbZME+Dr2j9vExG8Bg==
X-Received: by 2002:a05:600c:4589:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-427dc59e752mr44479695e9.32.1721630574828; 
 Sun, 21 Jul 2024 23:42:54 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6901781sm114048665e9.14.2024.07.21.23.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 23:42:54 -0700 (PDT)
Message-ID: <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
Date: Mon, 22 Jul 2024 08:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] make range overlap check more readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Yao,

On 22/7/24 06:07, Yao Xingtao via wrote:
> Currently, some components still open-coding the range overlap check.
> Sometimes this check may be fail because some patterns are missed.

How did you catch all these use cases?

> To avoid the above problems and improve the readability of the code,
> it is better to use the ranges_overlap() to do this check.
> 
> Yao Xingtao (13):
>    range: Make ranges_overlap() return bool
>    arm/boot: make range overlap check more readable
>    core/loader: make range overlap check more readable
>    cxl/mailbox: make range overlap check more readable
>    display/sm501: make range overlap check more readable
>    aspeed_smc: make range overlap check more readable
>    qtest/fuzz: make range overlap check more readable
>    sparc/ldst_helper: make range overlap check more readable
>    system/memory_mapping: make range overlap check more readable
>    block/vhdx: make range overlap check more readable
>    crypto/block-luks: make range overlap check more readable
>    dump: make range overlap check more readable
>    block/qcow2-cluster: make range overlap check more readable


