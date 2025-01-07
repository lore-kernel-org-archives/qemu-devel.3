Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5821AE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7OX-0005nP-TD; Tue, 07 Jan 2025 06:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7OX-0005mp-4A
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:05:09 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7OV-0007gF-Di
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:05:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so8432209f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736247905; x=1736852705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YprCxf46uUEVHQ88vHxApjTCO8HAkEi9Wh/5iIxVi6E=;
 b=TxyncPea0tI04k2/BTEHFhOxqjD+rekdo5+y4jqkqh86y6ctyGVcK5d+7LmTDaEBL4
 yIv+0LEKEucaHzJ5K4nhhE/Sf4fyLPabFi9o7iP75GnMtPVqqVEfbW5HUGWif5FT9nxS
 9qE19FktwdvmPqd0cQ8KC/+6F4sweIrDq+8dsUnaKISbMoMoRaR2YrLZ4/Ky7A1jeT30
 WWmi+zr57Rg8nhIwumdI+/5CtN8jtNzd6ccNXFceAWV4v50csc6v8Uyz1xJMipRQpkhk
 pbYFnjO5eMaWcSkQaHIi45NGuDt4Frt39Gl5xaW7igSE+qIW56Mcz341mnl5glyzdtgP
 AOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736247905; x=1736852705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YprCxf46uUEVHQ88vHxApjTCO8HAkEi9Wh/5iIxVi6E=;
 b=MHDWM/LraQwR9zKidTI4XhyQMwTBJ2PYqgbo913SzUPq3fyJoot6MnNUcjNVrwJqlt
 B5lslKdADaY4fHg7O6gjIrYf8oRTupy9INoTXAp7vth9e5hEKRUz31zb9TdNiehXG4rj
 TNCMLzTNkWnGdRtKi3C0VB1C0Uvj18FEmYssuidl5jNZog/im1zjOed+nul+RZnSJizs
 5uuiYDGb7P+CSHvSxEkERM2R3szKO56w58XsFY2E6FwiVPrZM8Nwfw3tHeSeVpbuVeU9
 zc8l7wqywlAwSUGdrKT9kh9Vwem65GtmqlMEMLKFGUQ1NISIkuQgohK7X2pry64PmKR3
 LG+g==
X-Gm-Message-State: AOJu0YwZ+uKkj7TOdM5X7n3hAu3NET4IVaw8/vmVt8hGxUIRK0OnpITy
 idGjmgYuj0m5nJCuMEF3aRD8s0jiG3f12jFfQKymosXiNTX+pu8RHVKwDWU6TpL2LJ1TyiO8u2d
 QfZk=
X-Gm-Gg: ASbGnct0iQ5ijr1Qh6af8vtY2xIbRl2J0FRF8xCYhjVJtPZte6jC4L+p8RHFuNXfK2V
 gY6uGSnd6KUMFt4RlVdfun90jJQDK6X5hQhcB0YqXfxb0oeZqdIWleGkX1Ubl70i4f0LFNgKzJh
 r9Lg6VD8kDimIBTN+nsZNS5EMPJv08e5TWaecWjMz0lYqynHeHiKn/owmdKfNmwCyie5pFlZE2r
 2i8qH1SzPDv0bynXmGllXEfp0IVQ2DbyBir4zJutCYm4MVU8EGt9NRKz/PNv0Co5ZDwM1+JHbwB
 X9UjJOu5n9AVmvoiDqJvCyEO
X-Google-Smtp-Source: AGHT+IHLTs9/xxXCKmrPEAcvYzQcSvziQXbObhiUi/vulFRmRwXPyT8hkaseHOFIiSHuOcI+CjX4mw==
X-Received: by 2002:a05:6000:1f89:b0:385:e013:39ec with SMTP id
 ffacd0b85a97d-38a221f1307mr53820657f8f.8.1736247904727; 
 Tue, 07 Jan 2025 03:05:04 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8ac97fsm49485182f8f.92.2025.01.07.03.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:05:04 -0800 (PST)
Message-ID: <838bb25a-e2a2-48c8-9c6d-3d940abc43db@linaro.org>
Date: Tue, 7 Jan 2025 12:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/s390x/css-bridge: Remove the "css_dev_path"
 property
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250103144232.520383-1-thuth@redhat.com>
 <20250103144232.520383-7-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250103144232.520383-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/1/25 15:42, Thomas Huth wrote:
> Now that the s390-ccw-virtio-2.6 and older machine types have been
> removed, the "css_dev_path" property of the css-bridge is also not
> used anymore and thus can be removed.
> 
> This way we finally get rid of the problem that has been described
> in: https://gitlab.com/qemu-project/qemu/-/issues/2213
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/css-bridge.h |  1 -
>   hw/s390x/css-bridge.c         | 16 +---------------
>   2 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


