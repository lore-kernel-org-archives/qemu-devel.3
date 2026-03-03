Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A05EDEBE2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUAx-0003Tc-DN; Tue, 03 Mar 2026 13:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUAt-0003MI-K7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:08:53 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUAo-0002cL-4G
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:08:49 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-824adc96ad2so5716491b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772561323; x=1773166123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oR58/CYTO01gc+EcwaypvmN4dEhyE4FwzzAUoPQlBGE=;
 b=SfxLIv2Xjs/IRPQd9dnALb5ScWo6ATfK1mco6C6Q9MSGHcLxqlDtOiZ8TD8uqaI/oJ
 9rILxgmi0azIlgjdi7lzDqtG95/Y67BvAuYjIsatJ7zvaJTtwrHijlKXjM9TGwzBKLAY
 w5nrEWVofLCjJWPDTKCUT8w1qH0vXF/FlzBJtKK0TmSmqAQSmMiM2XIeWnvKCqNSHCcc
 W+zI2CE3tToBeL/a1oPhOQiIp+iP7n43/B+jT9q6WGooN3Us43TsyMg5ux8p0ib9V1GT
 ficVR/sGOmTEkfRmq7cXrSZTnHaLWlMsLkjrBJy/L1jdIlnU5dxsvnX99hZXeR3woRe/
 +7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561323; x=1773166123;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oR58/CYTO01gc+EcwaypvmN4dEhyE4FwzzAUoPQlBGE=;
 b=hAQRd1pvHu+OreHonkjiwg1nP3cSa8DXLSNSwrqxBO641IodeBTUs1H6yRrPT6nbrs
 ZT7e8ILP+1dmI+FJfxSV2YZ9lXew9Jw/M3MVksNCOmMVUkVdfHGl9dMecSCLf0ely/jT
 /bxbQfF24CzruTii8gBFbamHKWmUG32DXaKpDVMbBRvcCLjx+L+eNrecy4Ij8TmMv1Ab
 hLOUL82ETi1q0onknEjnQcFs9QOCl8o1VdI5qGr6nWnWpCMPVqHVe+FuxLapqOYKCAW+
 rL6+qZmyumD7EypA6RksPTGb+Y2OrD+iOp5JSlqI9xhZI/vhzE46hozOT6BHtoZhuQZx
 BI1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7eTsXFaCeeIskwWISuq9TaWPovKgWsma3CzXGAvzxiLeU/1T4JXobEfAekCYQWs9cjqtRgiV6ansO@nongnu.org
X-Gm-Message-State: AOJu0YzM9Hkq/SFiK6DstWMQgohVBFPe72U9uaCqNdjCfLIinresgz4D
 6EszgnZ+Ieyn1wyxdMfhup1s9rrjEQ3gwsWq+Pm7mfmdkSguPzutYNWnvg/+br4qep4=
X-Gm-Gg: ATEYQzx9PdAK7DCjjVXgCboCOuSQK7ewUTazKuKkmovIoA/N5YO0whkhr/xeSjJKEUg
 r70fmek4Uvq8SrIOIo12YWGTS+2q/fEXDe4FT0ty21xTR9NpmYethZGof+akFVuIfEzCzgecZJf
 jFx8eGtx2lGvAGE2M3L+Z6TCL/GXkxQWawCMfpEolr8C8rAnY6vQskgn8C6zw3JTNrAk9WdyfxR
 MXsMW291IGY5jvVfMEPexkgfNg/QOqCMAzOe7ssmlPK0L3KAzwzZqRt0IHVeUhTEIMiYCQEVcb3
 uf9QYMS/SALutk8JQFyy0xG2S61RadzRSoeGq5IQ/3abN3JLpq9y+9NErlSHuyt9psDfBO4hvCn
 9dIBayp06lCzvzv76iAn06ywNWRF3IVsCMcstV4kCS7wvzqN3A3xOj5klc80WLZsyu83hpjFUGt
 Nh9KdO+M7NedE2/E/C82u6FPR8R+fPeWZbHn1YHEK+z9MuZX+TXj7mYlw1Cp+5KxGmu2qJ
X-Received: by 2002:a05:6a20:cc8e:b0:392:e583:b766 with SMTP id
 adf61e73a8af0-395c3b0f534mr17205719637.42.1772561323007; 
 Tue, 03 Mar 2026 10:08:43 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d87e4csm16300566b3a.15.2026.03.03.10.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:08:42 -0800 (PST)
Message-ID: <5e28e053-842b-46ad-898d-4687340e50ff@linaro.org>
Date: Tue, 3 Mar 2026 10:08:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] plugins: add read-only property for registers
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-5-15c77cfe184e@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260303-setpc-v5-v6-5-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 3/3/26 5:07 AM, Florian Hofhammer wrote:
> Some registers should be marked as read-only from a plugin API
> perspective, as writing to them via qemu_plugin_write_register has no
> effect. This includes the program counter, and we expose this fact to
> the plugins with this patch.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   include/plugins/qemu-plugin.h |  3 +++
>   plugins/api.c                 | 16 ++++++++++++++++
>   2 files changed, 19 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

