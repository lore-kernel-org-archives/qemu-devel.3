Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B2ACD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ09d-0000tt-Mq; Thu, 21 May 2026 05:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ09b-0000oX-4X
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:57:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ09Z-0006r4-Hm
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:57:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903dba5c3cso363925e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779357440; x=1779962240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v68qS+R0DxAkHf0xH3nI958dkcGkpy2PVL8LjqCbVWo=;
 b=j9Dt8WHww+B1gb6Iqp/2tgwEPvNMLK8FfmsTBvQ4Dk4uCgTCmBI+iO8JZGOon6UbQa
 wg39u+MG1WmO/p5ThdJmbRISgHV2fCwRRaNQMPUsaeQNqylHV1WOu0lLfV0nQUs8GcuM
 +5VAa1PFpy66kT2PIhzLke0YfbCR9s2mEr9FymUTQyQvDudZb/c7Vvnc2NMokvcqWFqN
 FrNO50diuSgcYtk4iKVLCE8bPZ7V68NjZmLyZaPh2PYqpCpgoax5l6o9sfkX3x8XKNEW
 ILow7YG3MLEP/2i/n5HzY6rXUXdpjzzkHLgkIHweGxWf2y8cZa2o/cqnHouHadMhr7Qc
 Wrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779357440; x=1779962240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v68qS+R0DxAkHf0xH3nI958dkcGkpy2PVL8LjqCbVWo=;
 b=ocKSH2GoNnhAAWmSz+Cx9LmZf9Inp88fD33IlzyjsAEO/ktUBWXml5A5a1Wdjfwk1U
 QPyPMtZSjelCia42iz2qt+oPjHK7EiR+lcYkh1teQ+H62vkdCdHzIuamqek4ONWCtNlK
 hp5v1SdoGIjrj98aS2g1xKzC3jSTuFR7qjVjxx7IYFeZ0ZZxYB+trhEWrT38paR2wo7R
 oYDjYWhfDWKbv0Af9AB6vmLfgC7C55kbxL/8qzxJ8x0yankWcmDo/Ji+5wlolHKKbtlu
 is3yyM0I5jlNN7IV5Y/goWNkytanbjcj8qCcFMxyMbQxAEiY8JMqyh8iKWWBU1Igr7uz
 suMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vSyQ9MTzBVwp6jyLsGblNJliOqdVUJpzzkJ8qQiKLuXddIXlfPTycX0dlrP9sBeeSrX61OQ7WE4OZ@nongnu.org
X-Gm-Message-State: AOJu0YzMoYKG/RBefaYB+xzH2yO04/3qIN1+ilqa2yXJJNn+sqfRs5QG
 Mvi9jiBCFzbgWEcQ5LoLyTbH4GbK1YHKB+aqzngnCYbfd/2e37W3mYMIor5DPqaWC92ztqQe4qp
 XDu8fnbg=
X-Gm-Gg: Acq92OErIGaiBIsrSBA6lFzpkmrks9vetM1Ia/NwGqKx77tko1wenOjFF2cbsHBffKg
 b1YJJfOhk62vDjWtEEjAqxX8a7QiU3o2dXHeUE/1grS2SeXZjlpAcB0ZysAXJ99OQ9a/i30YWJw
 wW3cdBZzsHbmlnV6H3LaafMvhA5rkJtxdAhtl7PnlLvOFNtIjmzQV4yqbNRzkI6WpOcx10QSwt2
 HxKmOjiWBqhpO7L5uZuMN8UFMnbYGHK0y5zmORDltInLboaulj/VdxrHgdW121QMy8c4Q4k2NxN
 UDvibi3ZUNPHqdYnwu1wdhQqLJzKhMK6SS6uqDJPsJEA0VmROsUJebQJHsnQzUuX20cWgCwXCuS
 mHJLHoejHM3nTxdlPtglUc9u/L63m05+Pb7SN8+BkQHBWyjpXaAzuDkBz9igF+By//2afPDJfk0
 zt4akh+XcLO/ymWskhsgwq723OS1YSkev69i8OurDortFtQ5PcMqYIZXTND7RxS3Liaf+jDc/8c
 1rU
X-Received: by 2002:a05:600c:3147:b0:48f:d2fc:d025 with SMTP id
 5b1f17b1804b1-49036035282mr27917655e9.6.1779357439689; 
 Thu, 21 May 2026 02:57:19 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035eef87bsm13066855e9.34.2026.05.21.02.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 02:57:18 -0700 (PDT)
Message-ID: <1be388e4-b612-4e81-beb9-a81feff41bb6@linaro.org>
Date: Thu, 21 May 2026 11:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use float_raise
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com
References: <20260521074016.1065645-1-antonb@tenstorrent.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521074016.1065645-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/5/26 09:40, Anton Blanchard wrote:
> Use float_raise instead of open coding it.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   target/riscv/vector_helper.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)

Please convert all uses within this file, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

