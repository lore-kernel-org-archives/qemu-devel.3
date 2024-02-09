Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1126EC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYN0j-0007oY-PF; Fri, 09 Feb 2024 04:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYN0i-0007oJ-Nd
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:17:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYN0h-0003EB-7F
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:17:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-410489e1a63so5881595e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707470245; x=1708075045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MAlIT1USiQ9q9FnARJDOe4Jn+g3Pa0g/TjWVOShLmpU=;
 b=pKTTsI42i3JrF79DHj3Dg39AxjcldXemZR1QBLuu77C16IEbvleSMn7xyoLCaybjtN
 InskuGZzrgOi3HBew5xfxv0rVzg9dG595/Y4lmiTX9FUDC2zVyeI8A1nB/lsS/NOWJM9
 u4moew5N6CEjZbTtGdaV0aOWemGQ51ZbN20oouI+poi6q+sfJ9ZU3XZcoVCoPY4vjBpp
 7T3pcp24VchY+Mi7oj2DC+XrSHfrmUKXgXG9lZT8TVGFyNumEKt1o98iUGJMTdBcOOq2
 7Qh184l8VYXo9tFdSjnKAYKLW4dGiyXiAHCnZtke7y0qlptgF0DsSszW14ZKqlN2lSaO
 2vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707470245; x=1708075045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MAlIT1USiQ9q9FnARJDOe4Jn+g3Pa0g/TjWVOShLmpU=;
 b=ufyTAPeXl/i4hjFtyospVyV6VRr7O5o4QuCAM+NU/+S+HLXARf3IxB1Yw5xdFOaDNG
 sh9FnltyLXJg4KtzXSRUQMekRGfEkSbQGclOneNnWqnMY8ErjDsGtxG6zDpwrsmVph9r
 eWw3VuD4A2pgR6CCZ6VHppn1P/85z6jjZEJ24rfv36FW11db+Jjj9xTP9anEX7o0gM48
 /AksU7lQCE+rB/rik2nPX8RCv/Gap0mTT5VOQ3+ojp+r25/0/XjF7Atc6iYMP2+CkrIA
 OZ9lAaXJ8/fJY6hrm2RJW1eRqlQRnOHpu53HPP1m09kJZhTujbD8GTwp++3f06o6MiCR
 zh7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdR7A+Dw+Yv/x/79+rh3e6iSz3oQeHA0XJKKuUKDH7rTE3xxd5tt+mwfrt6pojZeKr9PEcglq4bwwvg69BdfTGEhtLxsE=
X-Gm-Message-State: AOJu0YxU6IyY6HgOSuQlMxEAoXFM1Gd6skycUUoGVTv0yLmLlf9+0Vr8
 dEZOoWkt6Ll7NBphG6d6jJEVfgsNJINhxAKxVKzz/eGhEwX1dLGmlgy358ghBuI=
X-Google-Smtp-Source: AGHT+IEQXUVI7x6sTYES/shNXgz8jyz48U4LXQpBwCP2qselSu6zaZhSdmpHGTzxcvE4XAC0qTM2XQ==
X-Received: by 2002:a05:600c:190f:b0:40f:ddb6:a63b with SMTP id
 j15-20020a05600c190f00b0040fddb6a63bmr855639wmq.24.1707470245676; 
 Fri, 09 Feb 2024 01:17:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXo10M95yI6hhrJbjBIIqg6s54h+iroIVUtCVkbEF1E9FEj8mnAnc1ybtKfF6CfndvG1uaai7SZtyb4GXR7wNFGm3yfz2USP4fbblmBwpTBx+hUtZpk3Z+mJPTqh4HH+YNfCauyPCi/lxnRiS6SvWNljcF42efKeE4ia57p1UQkkfNagmqLfnQ4DdkOkSkuBOOTCGGX6v74TfqUPfmy4R3sU0hAZS0I6qftUnvzLIQz7JEaDbkMlZvsKA==
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a05600c310600b0041047382678sm1846wmo.1.2024.02.09.01.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 01:17:25 -0800 (PST)
Message-ID: <af236412-0c90-449a-a4b6-b527e848574e@linaro.org>
Date: Fri, 9 Feb 2024 10:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] hw/i386/pc: Merge pc_guest_info_init() into
 pc_machine_initfn()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> Resolves redundant code in the piix and q35 machines.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h | 2 --
>   hw/i386/pc.c         | 9 +++------
>   hw/i386/pc_piix.c    | 2 --
>   hw/i386/pc_q35.c     | 2 --
>   4 files changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


