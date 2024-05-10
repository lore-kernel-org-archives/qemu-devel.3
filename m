Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB082C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NsA-0006i1-QM; Fri, 10 May 2024 06:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Nrz-0006aM-Td
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:52:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Nrr-0002K2-4V
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:52:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ba0bb5837so13116945e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338365; x=1715943165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7sIFTUuD+KOnWU1gakeh0NFMU6Pja/uxomvMgU9Skw=;
 b=hAMXNYp5FcI7UjGn3m0FWXSmxHKztlarmfSeNH7l13a51t5J1X4SO13pCgGu3T7pxO
 AsO4aOX2PQKrmfDW2EMRiQY3BWqgIWqOtRntxSd+4WJqu03wgz7rIj+2ujpKD4h20R1S
 mwaEQw6RKYuv7DYDx83dNlvbfPHtQiT4tTp6nldZfq6CPyetlev06B1pG1EQdHvYJKr1
 pdCkZimOHfV01jwLZoGAbLvhbtix4kYkImlb3Jfms61LEQZOoaDXF2KCieI8hx2ySsT7
 v2ikKvkBZbu8epvhkje0290VfRaDR8T3IZlAs1GtUE7NzNQXvzxYELC1VG+P8a0VbzEa
 LpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338365; x=1715943165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7sIFTUuD+KOnWU1gakeh0NFMU6Pja/uxomvMgU9Skw=;
 b=OGMo4cmmfMP5TrluSl/6mrOl5tDHaBJiXFZ/eAnJM0pkWuHSzmGZ8Y6SFvDSz8Fk8L
 3b9DUXDfRxsXBH2TaZMzJOlOk5Y9f5azsyK6QzmRIT0WX2Al91iG4+TL/2Eh1mvRA5Fy
 1+9EsL2oD/qY7EzfGBSe3V9ZetYOx4I8yT9faOeneJn186LY7DLz5gi6/g7uNnrhVvdm
 v3BjfnT4XfVOicAguouxeI50K8cXglMkxwL2zE5FLWu6WnmqtR5C7Pq5P7u2d89ga9c0
 DJOlO5W7KXsh36DmE6pTGBj+pwId3Tn66XiBlT7TNA8II8VwL8VBocp1C7/SLHa7XeS6
 o19w==
X-Gm-Message-State: AOJu0YxBmC/iiqF8vhIQR61riCpuXZuLCchKzYudTDWJApgGrPeDYLS6
 i7RnjBilcvABfdJmW9DBXlWQFdvvmYLbsCqPEyFpot//k6i+/gMKb66o8GeDzuziah8+gNUglRC
 n
X-Google-Smtp-Source: AGHT+IHuuJHQzBXjTwqPYG6Xft9Ercp9HGQcE/jtvUNQuTmVyJXtzh7vd29oX2VK0Fk1fhEyp1ZyvQ==
X-Received: by 2002:a05:600c:1e13:b0:41b:3e4e:bd99 with SMTP id
 5b1f17b1804b1-41feaa390c4mr19037495e9.12.1715338365250; 
 Fri, 10 May 2024 03:52:45 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87d200c6sm93588085e9.23.2024.05.10.03.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:52:44 -0700 (PDT)
Message-ID: <84c89274-f8a9-4f86-84e9-40a962dc4f77@linaro.org>
Date: Fri, 10 May 2024 12:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/xen: register legacy backends via
 xen_backend_init
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-7-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240510104908.76908-7-philmd@linaro.org>
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

On 10/5/24 12:49, Philippe Mathieu-Daudé wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> It is okay to register legacy backends in the middle of xen_bus_init().
> All that the registration does is record the existence of the backend
> in xenstore.
> 
> This makes it possible to remove them from the build without introducing
> undefined symbols in xen_be_init().  It also removes the need for the
> backend_register callback, whose only purpose is to avoid registering
> nonfunctional backends.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20240509170044.190795-8-pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-legacy-backend.h | 11 ++---------
>   include/hw/xen/xen_pvdev.h          |  1 -
>   hw/9pfs/xen-9p-backend.c            |  8 +++++++-
>   hw/display/xenfb.c                  |  8 +++++++-
>   hw/usb/xen-usb.c                    | 14 ++++----------
>   hw/xen/xen-legacy-backend.c         | 16 ----------------
>   6 files changed, 20 insertions(+), 38 deletions(-)



