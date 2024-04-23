Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A22C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGLm-0001X8-VP; Tue, 23 Apr 2024 09:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGLi-0001Sj-0F
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:38:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGLg-00063f-Aw
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:38:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41a5b68ed4fso17767005e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879495; x=1714484295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKdvWdOLl4429vB5fFNR0EJvzin0N9kTBhc9sjvq97I=;
 b=PclKFBFvm2MxBdvhwXAnf7Eh3iCjyZBR6O0Ni6KEfx0tzWQ8Y3ZIrObtdfdhlpR7h5
 Yb7VEYLXDxg4HPSPib5SFWzPMcap7rxYtu3/2Jyleoy28Dx1lfE4AiRRORmofIRAO+l1
 V/6xu97nP4sbfa7eiEu/1KskEFesc7JAsVxFIzr8zEK23tnj1YHBKvW9ElZB5tePys3k
 6eEv6r5DVkpoR54ctMtiMvQs1WqzJeHvgmrlaGHpolkP6HcbsN731Liozfwiged1oT+d
 L8TQ67N+NUedcwHZuqXDO0RP6IgBah+iL1GNYfkmUXH1jLJ/JI0jxn/cyIVPnObFVJGM
 f3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879495; x=1714484295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKdvWdOLl4429vB5fFNR0EJvzin0N9kTBhc9sjvq97I=;
 b=oGaz1GlwqJ6UZy0Qix/RY25tJhQYVTWhxhx//XAqorG9mY2Wp++GQEv6/8nSMpIxf9
 3l/Q9CORwxVym5Lg8WMww/UDFMZnxUDhBUy8kuWPCaf8Zywz6tuKcTLFmw0d6i5+qCw2
 t+Ys6wx2t4rudzqvInq0ZXb+tBmtfNZo98L9y8BKBP460uQDvR7tOFaps/4h9nP820YG
 DSY+hbmdf+tUponLZbXRvhFoY9ULAhGvQyQf66Mrs+C6EELKhx3V6qkuU2OiOcEprcby
 al8++XjLetKuPhKZb4vvWFx+mFExw3lwcHwGe3iR0StopTkLbPi/y9scPS6tqaHlzEdJ
 yhXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCf5WGsyYyDhC+1SvsKj5xG5tsI6JgtCovfpF/rkWwtEe2HtokDTXntm3ygrGy1ygTcQh11IwWeyr5p3CyDM6yrI7Qj3w=
X-Gm-Message-State: AOJu0YxwoBnEwp8M7jZviL8Q9AbAEN0mASO1YUvRzdD13YNHTEW112wn
 AfA4pPchId98Vt38NU03NXOSi1YRL/G83h29dz0ZMcAe++iFqcExNem8jAjvhgA=
X-Google-Smtp-Source: AGHT+IGVXfN6/toGrhuMlUAngFmZuEI+GY3FkOiIVjgBLLoE1RSk67qBOOdrabNLzQaQgVJuC7zNBw==
X-Received: by 2002:a05:600c:4585:b0:41a:7ab1:fd98 with SMTP id
 r5-20020a05600c458500b0041a7ab1fd98mr3558708wmo.21.1713879494814; 
 Tue, 23 Apr 2024 06:38:14 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a05600c458f00b0041ac56fd580sm1770343wmo.31.2024.04.23.06.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:38:14 -0700 (PDT)
Message-ID: <555581e8-4752-4e34-9bd2-a4c73af0c5b8@linaro.org>
Date: Tue, 23 Apr 2024 15:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] cris: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-6-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-6-pbonzini@redhat.com>
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

On 23/4/24 15:15, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with CRIS.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/cris-softmmu/default.mak | 5 ++---
>   hw/cris/Kconfig                          | 2 ++
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


