Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8FCFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 06:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJmnj-0000tW-Dv; Mon, 04 May 2026 02:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJmna-0000tK-Qf
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:28:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJmnV-0003g4-KR
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:28:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso29186335e9.2
 for <qemu-devel@nongnu.org>; Sun, 03 May 2026 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777876131; x=1778480931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EXwXyzuveJ6b4hwT82l7UBCs8i+zWxsE6JoeCxX3LZA=;
 b=LIznwWc8vzs4WaTRaj3FP9hpg7v9G5IyHU7eShFmikc3gEE4gl923IgDXgNZM3nFel
 y1ShZfrckOKlU1o6EdQjybDId7RUB+dn+wuYnnrWp7zx/XFAY+rQuutCB7g+mMnu50rS
 01C290RsYCepxwG/yuhRaxeVqELlM8tpukf5r4HBnJzdNwgr5N60wzoMdDxLVNmkJrbz
 OvHbAi8gbCTogHMGiuLRFj0s3oyBH2XyQcHbh0ojVPG7sevUCkVEAzll+spOmCbztEio
 ep6SxgXYmE5jPBYOiC+nCh4sCn/lZXUog0wd8ouW4aofA6qoiPi07LI389lG6PNmf8mW
 AX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777876131; x=1778480931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXwXyzuveJ6b4hwT82l7UBCs8i+zWxsE6JoeCxX3LZA=;
 b=s/jha1srJ6wb5k8UlyCtCyta50bxKJHzw0rUSB/ak2vA+ZBeGPZt4hUHFWwJsmrQct
 LBY4MEFoBG0zwx1N3xcTRMuL+IOSXwWb3tSnl+6YOdBsLlWEAk4jVFv43vfVEK2lTwQe
 F1fEFa7EIZIFvpN7o6v37ZehfhHnFLGF84MRXEDGeaD7CH8uIJ6QYRoLBIZP5lPqPT6s
 d8DaMP/6V93e6zML4mnOkRCQ3UeqDraaZtUreiP80AQhTq9oyA0jUlFFC8yQuNem80gi
 u73FTR6Y9qJ0DnCL0wbk+z5MrcyzBL0GFQn8xWZKpdInbmayo8OUUxdtIjolIv+9LIXt
 r/HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o1dSKJ06dV+l59rvbFeJgm+7jgjPH72NuL+mf6ABkWArc3J7lwnDrK2LXfrk8kshv0eH+b94NhLlW@nongnu.org
X-Gm-Message-State: AOJu0YyTGIkqKIZpHuLCCyTi8w3jdQSsMXSbnIeBFw5OkeTJHuMHo8Q6
 YwKgiTsiDeszySbL8jbMm6+xBdKYnOJdDz8t+Di9wC5WDrhvS+uxH2J8oXnn+xmw5V8=
X-Gm-Gg: AeBDiet77VYzWZAkzlsQdwlZgAlMZL9wNKVFoPHmW3B5zD/+0ThBI/+Vl+ab7OFRLhv
 7lTBu7Od5QTZy58due2xsVLBg98D7XDnplal+CZ15LW0isp6lyJ4ExnANYIUY1GVjL69lOjXSMQ
 9f5OCgMl6/P6I2K3yXAO394iK+Lsc1Bh2xbCFq7mreNg3sYX5saS8mZJq8rLOx4qkTPjLzrbdFg
 jyjm3vRDEIkvYoGETvAyUKX4lgofXvElAqyZ3uVCjP9orF0ELjX8xmLITrHe+0FvqTdk5X5QtK6
 bAs4uFcU+eIuTYWa2J9x3yZZrWLNsvGCrjTjr9quLFS5epPNHysFfoaJTe+cJVrvAOIDTXOnVCy
 Fydxpum90RnQl5T7XzHBYykx5J3RztnaJnETYQUyQDD0PEIrHoFBDrrvLFks1XaaZ9NoAxVrkAM
 gTyA+kcWQIejd6+Ah4Oh6MXQmzjywNEXCRUhYPhQsZF1V4KTBd6bnYW/js/HfsaXY/3TR6idOBH
 OVU
X-Received: by 2002:a05:600c:c171:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48a9865d9b6mr152214035e9.14.1777876130688; 
 Sun, 03 May 2026 23:28:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm310896945e9.12.2026.05.03.23.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2026 23:28:50 -0700 (PDT)
Message-ID: <09b2ec62-4b67-41da-893d-aaccf011537c@linaro.org>
Date: Mon, 4 May 2026 08:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/58] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
 <20260430172204.1006673-7-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430172204.1006673-7-pbonzini@redhat.com>
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

On 30/4/26 19:21, Paolo Bonzini wrote:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

This was not reviewed by Marc-André (at least not publically on
the list) but by Alistair and myself:
https://lore.kernel.org/qemu-devel/20260430090534.841894-3-pbonzini@redhat.com/
Not a big deal, it just shows this email workflow limits, as
reviewers might wonder what the point of doing public review if
being ignored.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/misc/Kconfig  | 8 --------
>   hw/riscv/Kconfig | 4 ++++
>   2 files changed, 4 insertions(+), 8 deletions(-)


