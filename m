Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32799CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDTN-0001bD-A6; Tue, 05 May 2026 06:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKDTL-0001an-Bo
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:57:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKDTI-00031p-Qj
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:57:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so3265318f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777978667; x=1778583467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VxplSUpXi9bv1KzzE4OgyVwhYqVJESpnIMetbREGK4=;
 b=oMLBY3rOiFWlNYlz45EnumewltQVQJWKH8GCJxezpKhADtogdtS70xJYKCs+PuL7YD
 RsmRyCi6e9cJTX/uOdKxNXUCOVIyB9VL5l61OqsPv9jPF1Kq3Ruk9BexMXUdEn04ZUOV
 NURnzXpd8Y+RtoMdGR+fGc+sWcOqWTmtXxocO/B/jN4J68ERt3YNB+8K/rw440du6hqO
 vro7t1mfje6SosXOCOs6ys+HS2GwGWELWlh9hb6b67gmxlsjFL63JUV0A9NYdUIWEZd6
 tByT1xRecP+CBxlmotrFxnAu1/EHOu215VKhOidh+WZCOoBPeiqcDlsrRMn3F0w6KEe+
 D27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978667; x=1778583467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VxplSUpXi9bv1KzzE4OgyVwhYqVJESpnIMetbREGK4=;
 b=P6uU54rOBSC6M1fL6Hd02zVfYxBU+lKSBqjUUqQUUYMuoZ/xeZp65HGlIPqio/wEF6
 mh1Qxu2i9uQI2erIvThoDs00SKVP/94mqZgDyxKx750T2pI8Q+qYc4vr7IJ9HKQuEPlM
 P8NyrpJdDEJWXoazfiltr9efTK6w89pbYvN3ac+89gjR+0/Ekk14/fPgs27kqY34qaBG
 UIHE3JKt8VAXFFaO+jf7RXyJUL2MrK0aWld0mwXa8zGr85InNvtrWLsDU08o/fba4IRx
 OUa5hJW/TxSz1PeYdWjncEp7dmnVufycZYghbckb7DdCXFeKsujV0dqGyXYssPeEbBob
 bGyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F7pxdzRN4lJF9v4QPrAxoO0fWiBuPUkG3zAtya6So/vY+Xb6jaqAVPN3n+ywcmfO/15eKYu7hVWLc@nongnu.org
X-Gm-Message-State: AOJu0YyO6fwSDtfk/N6C/5BXHdqBph0uKux3rPZDfPyfgBJXBC9h7vmM
 ZLAXEVDyp0w+vyNxhiilHteFc1JziXGZYUJXIDgPzjnk0Pctq1fO5Rr9KzUWhAD17T7Rk36+nxj
 ypR9b7Lw=
X-Gm-Gg: AeBDievq2NTZv+Dlun49HSNwggWMYK6+oqsCqolGzmoedTtdIBIVq1qaaIEoDsIS9Dn
 W1H5omLevNec9A1T73Bao7/Gzjn4kDX5i8QRUT0w9W6i4JtnVxjZ+X8mj8K5jFuVxevqo81BAlb
 qX11bkquH+jhTpTeNoP8bbImckgDgkrlpgo+XKl9pJxCPuDZTjhG83xRnvPtB6a7roJ/3gjbpTM
 ADE9vV238RW//BYZSPLAoaP9xmds0wCJbum9e2as+RWj8Tg66O6Oh84f46OxP//CttCazeq2TM8
 Z+80EG+O6ZX+Dpwdq7lcNprY6GlZ5sxPosexcE3uzIMAcH/oLS85taDSuxkbvy0yjMyUn+WaRVa
 p2/ZVWmb5My4DzeV/dLhdG4XHfHUpbX7NlWdDpSrgaZyviT2hGsxWNOqiwQv4FV1295ddri2Rmi
 WaWa3zhwuxCNCJah0G8Hu5cLutCHK7tffqfcjYdGS5WZoF29X8U0KZ6Pwniw5U4w24Hdfz6mikR
 yWk
X-Received: by 2002:a05:6000:2001:b0:439:b1c3:84c8 with SMTP id
 ffacd0b85a97d-44bb5b4d5e9mr24469817f8f.21.1777978666827; 
 Tue, 05 May 2026 03:57:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2487dsm3661733f8f.35.2026.05.05.03.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 03:57:46 -0700 (PDT)
Message-ID: <3fbbb017-7868-4f24-ba7a-de6f8d96ea76@linaro.org>
Date: Tue, 5 May 2026 12:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Report IL=0 for Thumb 16-bit BKPT insn
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260505103726.419195-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505103726.419195-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/26 12:37, Peter Maydell wrote:
> The Thumb BKPT insn is 16-bit, and the ESR_ELx syndrome register
> definition requires that we set the IL bit to 0 for this, and 1 for
> the 32-bit A32 and A64 BKPT/BRK.
> 
> We used to do this correctly, but accidentally lost it in the
> conversion to decodetree, because we converted the A32 BKPT first,
> and then when we converted the T16 BKPT we forgot that trans_BKPT()
> was unconditionally setting IL=1.
> 
> Pass the right value for syn_aa32_bkpt()'s is_16bit argument.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3474
> Fixes: 43f7e42c7d515f ("target/arm: Convert T16, Miscellaneous 16-bit instructions")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

