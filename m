Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E1CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3rA-0002JU-Lw; Wed, 13 May 2026 03:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3r7-0002Is-UJ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:18:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3r5-0005Sg-L1
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:18:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so27600895e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778656686; x=1779261486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7a6sfd59Y1Jf+u9Q14IixNY/+IPlPlbM9HXvQ7qeKDw=;
 b=dLXzaZR1xYV9lb4bFThhnkjPBYUFkPOXWYuADH9zzrDIfxLHivzKlajM6OYmBttyyK
 2QPtGk7WubRZOBWA/vOXPrFHzZsgufys5AmAlcz8jF9IKtHOleQlVHGj5+m+Zmem3LXv
 jwZPmtkQmqzmXukuoJsUX0FC/xi05ce5MFlyd8O8joaszrAogkcNqfYqU7mTIZFvGkX5
 pYM3oCg1zdiTfzeSrCfkpnPamtUpV/Yu+txNvjDRqbj3NZweAOxMpaeBjII9aypwBbe7
 Wls8dUgdgul8k9qAVeFg2+KtFsYcDrgY4GkrZEGDeCZ+C1LNQRXIK28fbU+H4UL9o3+V
 aZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778656686; x=1779261486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7a6sfd59Y1Jf+u9Q14IixNY/+IPlPlbM9HXvQ7qeKDw=;
 b=DFEicaaUXkTrTK0Y5Wv5j410/vyxXKdticPSwnYTp3PirCElgBYZlpoFgm2EfKlJJ6
 WqIgCjGREq9+S1qYeD5a79OvXqfKI0UXdQA6Mbq00sEcJ7veuw1ms2NA5UEnD5A9humC
 gjJfWIFAtSkK1mWP2nWWAbZ8j8OqFXQldYNywf8b18ttKrTiENF+wLDh17MrWe1TLuz1
 XCAQ8KBzxOLvohjhqjwBbRiSuRhth3v7vM5QyRIxodPBnYVrnOX3I68qv0upUM6hWtAQ
 GDSFBCKMAeDrUheHvl7pK+7Z7ZeTkFFODLV33ycQXB0EiexFImhyzo918OENRAzX6y0s
 3Bjw==
X-Gm-Message-State: AOJu0Yx+atAu/6owr2w7Ko+abym0MbpHj2qjP0Cj0E1dE8ii9qYxWhtR
 BQIU4NGKF3sX/qqOyHHoXyi3d5PocmKRgbLrzf4fiqMONog9mT3wI5kBj08azlKexlA=
X-Gm-Gg: Acq92OFT09zfH+uwhc6BTVS55fzt3cMvr7saRjRPsTLw183+vJ+5lD8+Gmhxwv31buM
 mROmnDxDMlpjpwS3+mLLO7+xWDSZ54ZvFmo06Lbpsqjx5qXvGE4V557p8AgTsg5JxkC2nkyelTu
 Hze94Hun3OBlwgykI5kSNlDeOVh8hKZiCjYb9H3CdIaBUtQSFCky1Cpu+LEjtPEVucwbWJe84cM
 +Ui6BX/h5UDVT2tdPBr5lwZGLkvsWN2a77Sl5+u7uRdJj1Pc3SRnln784K5eiP9gSU1JI4s1OmE
 r7Cgg28H+o36M+M7LZfZ8aQqOkBQ+u3RJkXXQRg5FSkAhijRD+X+ZvKD/IpUG2IrdJvJ0Tbtt36
 5BcCeN9Ohy8Bjvo+ePxxDSY8FfFmj6JG9gvwktSYNnb8ZrcvnSl/Nd6Cw99aHwft0SEuurdVmRB
 AsHrvNNA4XYuvYbwoYFfdW5wO+kMGwwexdH58CqQ4/gLCFFmv3r+7Kb7snNNpWlPraenH9wSdFs
 r1Y
X-Received: by 2002:a05:600c:6305:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48fc9a39b1dmr31196655e9.22.1778656685625; 
 Wed, 13 May 2026 00:18:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f3e7829sm54516775e9.4.2026.05.13.00.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 00:18:05 -0700 (PDT)
Message-ID: <7d877cb8-f176-4442-9df8-776d9f511b4e@linaro.org>
Date: Wed, 13 May 2026 09:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for Checkpatch
Content-Language: en-US
To: Chao Liu <chao.liu.zevorn@gmail.com>, armbru@redhat.com,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260513070830.851842-1-chao.liu.zevorn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260513070830.851842-1-chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 13/5/26 09:08, Chao Liu wrote:
> Add myself as a reviewer for the Checkpatch module, so I can help
> review related patches and continue maintaining it.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

FYI: 
https://lore.kernel.org/qemu-devel/20250819-checkpatch-py-v1-1-99de8bb733db@linaro.org/

