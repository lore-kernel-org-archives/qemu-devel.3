Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D42F8DFCC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUL6-0004IA-HX; Thu, 16 Apr 2026 17:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUKo-0004B8-J7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:33:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUKm-0000iD-2F
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:33:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so28375e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776375191; x=1776979991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JnWRcMJ1IszhB8maH/ZQFr32G2NWRJ9/v70LkuycTGw=;
 b=OPXS7dn6IfdC3Lfr2Hw+NjQaQmkogRk2v53pwM9OUMobCCwx6xPZ/cWtNwFkH/Nuv7
 n71m9tvOp46wFBVacfhNJ1XOovxZ7WdaRwckp7EDlM31fYAvbQ1LOG9mkGW1TrDhWwsU
 V95YovMxXZZbLNOYYrH5rtA/pnM+7eqNYQYUrnJpmIoYxO39bz4ioq5QObt/Y7ovJLRz
 7ycLTWu1ajVhsifyPRhADdD9ah77qvM6fy5nX0DvWJ4n4n+k/w4pUCUmQUqdZxwh5Pbb
 cNh2h4FDofMHB70ZGVJjTv/hZp8n7apXwMpMR35uFrKvUCYMST7holmUH7PLSMBK4EnA
 TLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375191; x=1776979991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnWRcMJ1IszhB8maH/ZQFr32G2NWRJ9/v70LkuycTGw=;
 b=n6kXBjPJ1erpCBjF2iYCum3LPAx4h8IeTEuCrH1D8eVL1YMrxE4fUeSH6muEqbgXxc
 5q0b8w4MBoSw8ke3+7lzxaR2/pnRrkjKBYKzorNXpIukdMwI6u9gLVyqKN+GVQKonY//
 zj71vkeraXUvr3yIvqRL3Ucjs5Kgy9lcqzsgjSD2i59G/O+pLvJNS5Y3DiLdW11l16LT
 PWsd9bI5vigI7ZazdXpKoodRhbb4+U+IIwheAH0F86lP0WqCEqQW4ZU0uTpdGc0XTRbC
 nOCS+88mfCjC8EviCQVrp9fXIzAugv0BHXKA1JI5Xds2EDoIrk5z9TqS+zSR1stT5VN7
 DWew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TdexeICHSoN5cKoEJsgWEx7QT2En3KgmYEZvc83oANVlie73tb+ZiO5ZWf8kGyhMBY3+yh77WFZKo@nongnu.org
X-Gm-Message-State: AOJu0YwJsOtBHXRq3QJHvURCAgpVWZJ2he2DIoHbxTfkBIGlp5FQ0pRo
 iXWkFNPwCbDEPmpm/j0AcLXLK+TKIIrNvDi+5a1mu7i6atiPKQqV7+7IN9L3/qj3qqQ=
X-Gm-Gg: AeBDietkAx1cnwRxrUOK9NN5khls//RrU0gzj1Y5/pBrwZDu4J1BVHNQ29fIOn46aM0
 MwEOTzQvkjN3/hQpxEmufqLEpskBbB+Jz4hSgafJxFi3I1RMCTuL3rT2o5YeA6b39MConw0gAAM
 Vc5Sfyg1wY2/WM2jItgqZL+zpqKeeemkxrfpbUzLRoAhFo+nOJYPpM0VE/mmt19sXJ0HvVb68sq
 fXUBaGKOQy4GP76QhnbBZvsYaXGhh+sEcTxmD9m6JtGQoXTqXC5108a/EVnphzy2mwBd2N9zfEq
 YjDP5WeU/IFF3dOGIXbtnBPQAinjyZxZyEiiywjXRqRDsXl4V1og++DkzOr0jDOyG8G23qaP+EI
 TCySMPkEtZrQtKOCApooqIt8oLZWcgNvvUwofQTvPX+1/taWthyD61ITGIpGCDlSQl5O07E3JsD
 LD8Pv+PfJV64UboEzQFq6pdoLcuAQNS6Zy7ujRpLdgvuHHc/MZ3QhOWYaVEQ/RQaZwHBfPpA5FU
 j1Q
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id
 5b1f17b1804b1-488fb7863femr3519305e9.27.1776375190691; 
 Thu, 16 Apr 2026 14:33:10 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f58163cbsm83679925e9.1.2026.04.16.14.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:33:10 -0700 (PDT)
Message-ID: <689d0885-5f89-4a8a-8039-ba131dd06978@linaro.org>
Date: Thu, 16 Apr 2026 23:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] tests/qtest: Add hexagon boot-serial-test
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-10-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 16/4/26 23:03, Brian Cain wrote:
> Add boot-serial-test support for Hexagon architecture using the virt
> machine.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/qtest/boot-serial-test.c | 8 ++++++++
>   tests/qtest/meson.build        | 2 ++
>   2 files changed, 10 insertions(+)


> +static const uint8_t bios_hexagon[] = {
> +    0x00, 0x40, 0x00, 0x01,                 /* immext(#0x10000000) */
> +    0x00, 0xc0, 0x00, 0x78,                 /* r0 = ##0x10000000 */
> +    0x54, 0xc0, 0x00, 0x3c,                 /* memb(r0+#0) = #0x54 Write 'T' */
> +    0xf8, 0xff, 0xff, 0x59                  /* jump 0x0 ; Loop back to start */
> +};

Great, thanks!

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


