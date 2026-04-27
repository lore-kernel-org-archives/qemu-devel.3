Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD47FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIMW-00055U-7B; Mon, 27 Apr 2026 05:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIMQ-0004zY-Eo
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:34:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIMN-0000iZ-V6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:34:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso92199805e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282474; x=1777887274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=67RPAAFOZ8aAkIAOwFm8Oqfz/EewRl4PmSMMzn4N/zI=;
 b=O+2cp/li6IGNXYU5CWTpa/eNd8HIQ+uXE8TiyB09pTWUAvPwU7YrtLWwgRo4O0mQoY
 O7by3V8EVVhlzjlSufP1H91zByF9NnIuOBIY/phxeT0eD85jDLV/6HrqEIhndxCa4vz5
 QSDM6MiOom20VGg/GwmEJMwOpbaZzx716yL5rONE+1lm4kYIDLdbjd62vl4WnTNUsk8t
 VuxSPHK4Qf5zi7YyXeuUpgKJ99F7WLY+j+44z6TX+h4OPXniGE6C+f4XoT4NAp1nsRz6
 8FaXi7c30/kzQri70xqgX66vIpzNbjkebr8K+T95LsE/e071k2kPxv5sXJgp88Ux6LZh
 cOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282474; x=1777887274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67RPAAFOZ8aAkIAOwFm8Oqfz/EewRl4PmSMMzn4N/zI=;
 b=AYJNxzYdC3+n8sJsiicX2VdCUViRsJ06m9j24Ea3nuZxOfeFRcctBJcZZy8g3YFwoU
 ObhmMLUg+RiY+qWKa6D90rj34lx7CkvdVdfa77wVkzSVHWfcF86fb/1dFp4WrS4pCucb
 yiX6f3nPD6vn/3XaurfHjls+Vh7I0DLbNYOtxM3EyqvUrAi3jfxuAZKXvYR1kx6olRQ0
 JgY2mfv/tfpkPZtTX2t6i+vuQmGsKhkx4NobeR5ODm4kMK9qfGjI4F2vD4ngKk4ZKvfo
 qmicr/Y0dih+M+WpKayJ8/LYbTCJH9xKpBX3myJU7t5vOqEr1PxuChOBS07uHdeDbRbI
 fu0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ajFZkowMmcgECjE552g92ztYyY0vxDhz5MNYDt8hY28xSynYQkuLWDp1ZXwMNymHXvAsRquiTpvj5@nongnu.org
X-Gm-Message-State: AOJu0Yy3FgNZWlK2NDLNSbOD0mRbd6FRnuDim+hRVVnJ27ncBbXnmMNC
 f47UVEAhRqJAzdmGM3djqeTnRYVYcDPDRH1V+lET+Q/jUlv3H18/4v+A8VQdicSPKen1mxr68vK
 deixdpYw=
X-Gm-Gg: AeBDiesQvS2dZw5AY6++7fK2GitAgmNaPBKHElzEti5lGcyyj/XzV8p3jKmmLHbCxfD
 Bgqdhg3PK8Sd8ifPDzjqeVuQUxxSeNbyFAuLc2ADqt8dyzhkdc5vK2LDtmEY7QEYyyF5ayILrXq
 rpQB3idt4hmnFXLw1ypbGm320aMdnX8ccPDPClxKsXfVc4gt2JpuaUdm175bx4q3lycjhYBdTiV
 b37OsUW+piZV6fOITDmcEYpW7lAimllD55fK4dS10fTTBC0fIGmB2gNW9wI1ZCxFZnzT2luRvSl
 Un4uCuWE8X7WTcA6o3PAlsP+wRrCbBEAtyq/bnBfEtAugKF+9IED62ZhyYiUnmACduoXBxawB5q
 qHNnI3LDDqUikXrVAlMQCEdx1GUbrHhB84Xq8gMtuJ0DqbhLeKg35LMIhL7dmYoTLPuJmeUD0od
 NomH/2sCX22kbrgLshcYDNRQC/AB3m1mPQx3sK6kVakz3n8b9oucBrOHU4yVtzHu81dDD82FHW2
 QRh
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id
 5b1f17b1804b1-4890e49f7d8mr335684405e9.17.1777282473505; 
 Mon, 27 Apr 2026 02:34:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5334cc2bsm157170125e9.19.2026.04.27.02.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:34:32 -0700 (PDT)
Message-ID: <3281139b-9cfe-471d-a32c-ce6be86a0c7b@linaro.org>
Date: Mon, 27 Apr 2026 11:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/84] fpu: Drop parts_canonicalize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use the specific parts{64,12}_canonicalize at each site.
> Drop the forward declarations.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 28 ++++++++++------------------
>   1 file changed, 10 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

