Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8119A10F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GYg-0006vs-9F; Fri, 27 Mar 2026 19:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GYa-0006oR-P4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:25:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GYY-00070p-VO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:25:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso25032525e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653933; x=1775258733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwAfQ3Cnq1v8bF/Y/hZpVxKRlEq+QFJ+8VzSzTqam/M=;
 b=L74l4g5mfTG4CApDtRCK6xaLVlWyNleF4/xFEIlmt88uLiiyusUvbzEHfrGteZULUJ
 oEECp5i9KG6NAlrYmOQDq79IcJRC0YdII7vmkgcPNAfDzFFSo+4qODINhKy1wB2Qbd+M
 Oq5CgA/cM1MqKImBpwEBAeEKlVBRUIqz7jtt/fr5bDF6UlCduZbUpVeX3aQ21vRb0Y1U
 1f14C116ncq6LEFevygb8xnBunRevJuSTTnAyW1ejVbWX9nuQ2xi733jzhwYwi82NFTp
 JyWvjlbFgremKMbqh1voa0Bah0ZJJMco2ltNy92OL5QKCAmj2lQ1f3Ge+S9W35TZN75i
 DNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653933; x=1775258733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwAfQ3Cnq1v8bF/Y/hZpVxKRlEq+QFJ+8VzSzTqam/M=;
 b=O3p3kaBhFqqT7Yjk9w3meSdAYqqLLE8Qryp6T/wXHXloQXs3h+9zD3hIXozaiN2dZ4
 p4HEPoQFkfXgDve1RvYPDXyePO8jsmvwh7KrtkApyLGZZ6vpdhH74G9ugC2T9mZVfQpP
 zDv3vBkBGEdESQam8ysC9RvgyGMY931xzQty22t9jDsK9A3/VGZiKhTqi71LE/lR/CKy
 ZNWBIXGQBtVypcPgXeV3U4XnGIY5CJKbkR56DnU/ArLCPvZUZOS3uhEYgqfw/4InN0Ti
 /ghMYofPzbL9ZPxYJO2d273DKxIS8azk7sLO3RvH7/5Gx2xFmuZ8NO6oQzyMElz4NzqK
 HPnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ5si9jfzcd0XgPZimdv479M1Ako41o6+1OoQFVS663Gf0SV9anpGsRRTnhhBmweremDFt0Ze0Spnv@nongnu.org
X-Gm-Message-State: AOJu0YwP9AH5qmahpE1fcoNhjWssxi3fQvQxOgj+HgmQFASBysxTLXyF
 eOG/0kxwqqqWwdROICTb7s6uwfD666hlL2FbXp7Tz7TKglY/AixgNMSRb+tLnF0bwAM=
X-Gm-Gg: ATEYQzw8QVDQKvw+U3xLIommioyf6diOU3H9kYC6qIHJDNJxgvctpobFTZ9SttsEVc/
 GX5yTXn2YUHwwspaJjCad6CSDXJIcAle4dzAiqFQ8J7Antn9jhQcb3CvMxiCTgTax6uk2Jtp8tT
 hiT0Vmaudl3T6hfNrIHfAcA1g6m1B/wxsMEQ2rwD54T6Z2ncPlL6e8dysG4/QsOXo1o76b2oNd6
 cpgqKAf11xiu1FuzJjpD5x2SgDeRGS98iXr0Dzg73/wvNR3MpJdQI6pTbVLh06i8HCVJl3RQ7gh
 IvuMm/k8nNVnj8QDSBHhi1eanu6aOhDKc+n6KEplbd0h/FpIemYEnIRdzdjK0vYKgrX50FMqbbx
 /eJ4Ds6eyGzIo+3GKKkCe/Xi4r6P9jPRxV76bE9swogJZpnH/qyj0NRyfyTPGN8zQpcuWYroG1E
 kTZoXRzHJQUujKP5AGATaYhs9/nSlVo1PIGhW9/kYCUuKg0JGWhByHoGuvGY9iwsKush8ewStD
X-Received: by 2002:a05:600c:2d4c:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-48727eda499mr41036795e9.16.1774653933432; 
 Fri, 27 Mar 2026 16:25:33 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730688694sm10508295e9.11.2026.03.27.16.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:25:32 -0700 (PDT)
Message-ID: <a6f9b903-8326-492d-b639-9058c8d8f935@linaro.org>
Date: Sat, 28 Mar 2026 00:25:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-2-pierrick.bouvier@linaro.org>
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

On 27/3/26 17:50, Pierrick Bouvier wrote:
> This new header defines a new type for target virtual address,
> independent from TCGv and is parameterized by a new define
> TCG_ADDRESS_BITS (name was suggested by Paolo instead of
> TARGET_ADDRESS_BITS).
> 
> By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
> it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
> set TCG_ADDRESS_BITS manually, which is what next commits will do.
> 
> We preserve existing MIT license when extracting this new header.
> 
> Implemented from:
> https://lore.kernel.org/qemu-devel/a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org/
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-mem.h | 126 +++++++++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h     | 100 +------------------------------
>   2 files changed, 129 insertions(+), 97 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

