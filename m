Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB8210706DB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 14:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1PZ0-0002K8-E6; Sat, 14 Mar 2026 10:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PYm-0002E0-O0
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 10:01:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PYg-00050W-C5
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 10:01:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so27500475e9.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773496896; x=1774101696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wrnvhO/47wItgj6hs0/jd9cXDC8g8YmHreYK+iZfXLc=;
 b=FDl9T+/PRG6bRJcvdWLpQbj5PlI9rQBXfsLhhAbnFYunoUhtaA8hAtLj9VWw5JY5eP
 h2MJrXfGXSsP3zt+hktilYGVF8l34/riOpgfIUWVpWNAPCefgC8ELDQTD9dKEkaf/NIJ
 y8CSMBGSzCSSMvdBNDx/CrUMaESpg+PIf7e4YQdFiMKsHXRh8Y60QohcJvltuD/Doth0
 EZl8UrS9w/jT6zzCQOytM/6QvLX1mMcOKgapY8kEifosDssM9n/tbC8YO2qjA/T9ST01
 7M84hXdsqh1ueSlLeIroTJcWsRubsPb8Bcmbar/s2dFgAftOncAs30svajne2fHk5oQm
 H95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773496896; x=1774101696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrnvhO/47wItgj6hs0/jd9cXDC8g8YmHreYK+iZfXLc=;
 b=kXdmj07bN7gOSRMdgJWkb8ctTgYmok0NU9rzKOqJ+fXGoMcZYYqYsZdvFQVzVmeVSc
 G9QoV+bocxQwztic3Ob4VFtJOuVlzMIWfxPcUktg1ZmZl2nn5RShZKQzh3uIB/Ygh+4L
 eAxTwvsxDowxgA6j1vbPLtfrWcduZRu0bEHar7lTIOQo+H3U4KxPW9mbgRopKY35bCXu
 qm1WhT1igEv2e8oIgX8cvAbru6dmLs4lmx5rYmY5f8clF+YjOK+QLWz/LfEzYCkRBgxA
 GvRttym/+oWuJrXJy9vypRtve3JtSRm6ebkJixoFxM4Ip0eDXML7ZVLdnlrZmdGbURGH
 4R8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpF5sHqhyA9bGK5+j0MKb3+mrTnuq0m96/BEIVZLFhgbRO29voiCbS5INhhEV8tJyKKFgsKu0p1cyF@nongnu.org
X-Gm-Message-State: AOJu0YwzCOGLjvkyr59gjMo5lDFxIFQBRyZP/NmKAHG1x5fWG7Y/72ME
 WqUiaxU4aEM0j00xzQvTscIng23ylTKXZ+FkvkTQFVJ44A3aXVWaHsCbsAAZotYWnW0=
X-Gm-Gg: ATEYQzzabEcsVso4qbbTbkRWsmbhJi41dOoTZW6Tepn3iKr7jPRl+lOjiYPGxftzf2D
 J/nypVtE4s4UGMnrzBuidT2yl4Hn54Nj0xw55YBZeNin7i/fc//g/oPuHGduld1EnE+sIXqIUmq
 wuwlSqbDi51rgWrhCl8I1O6Ybl/0H809kWkdoCvJKrmriw7VDLsECu87xG4FUUSXxF/i+qXkj16
 Rp5L/6//4zMzUufTsSlmdoudFUm75ywpnxoPFeRgphPBRxGTqaI2OwMdP9DsYDQj1vfZhwz5HEi
 Un41+cSV7pfJChn8wl7YjYWiHb8/746T+YI+jDnVvv3jY41peBE+bpaAQ0qxkJmLQQ5Tw3Zo5R/
 mU8TD4l7QJJXYV0xG79JmhQdBBEUHvIRWfwAqQZJsI8XhK/qgGFGZY3h092iw/oGtwsqOgHZn0D
 HDX9Bi0J+XM83PL4OYzKakftx/D8Eij8O+Ichqlqc5bhcMOsADl/Xd7Lk/ghiMC9wTXg==
X-Received: by 2002:a05:600d:4453:20b0:485:383b:d5bb with SMTP id
 5b1f17b1804b1-4855670c0e5mr82595755e9.27.1773496894988; 
 Sat, 14 Mar 2026 07:01:34 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22e9ddsm24415222f8f.37.2026.03.14.07.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 07:01:33 -0700 (PDT)
Message-ID: <a9f11187-c1b2-4e60-accd-29c17fc0c919@linaro.org>
Date: Sat, 14 Mar 2026 15:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] MAINTAINERS: Remove myself from various sections
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260313113424.15583-4-thuth@redhat.com>
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

On 13/3/26 12:34, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> I likely won't have much time in the future for QEMU anymore, so
> remove myself from various sections that have already enough other
> maintainers / reviewers.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

