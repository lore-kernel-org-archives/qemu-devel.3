Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4220FC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBif-0003Ke-9M; Fri, 29 Mar 2024 08:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBid-0003KF-93
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:52:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBib-0002Zi-SM
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:52:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4155271cb59so2043445e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716744; x=1712321544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/uqncGmEK8RA22kICeG6fpJeudKfrpDpfSasZWFQjg=;
 b=ZSMbidqDl24fpaqvu1snYciZ3Z5VoASIze+OigNR5z8lXumZJlFvZFvHE2oJ+KWNgW
 BquuyO05wF8b6ykIB3SO3Y7eJwCJ0TKbRS3XahAlTVz5zVP2yXDyTIqe9HWAmVihssEI
 yQmwfaXJPgEVMT5J0N0RhPmWzayRQsOIL81UN96lY78+YNkKaFhwv3N9NwhMrjv97pOO
 C0eT6/yP3pKmaMaQieRBVaJXLf3WO/wTTjCchrqyAHjmN2mDRg1av9Q4SnazwSYlGcU0
 jDiK83axpT37WK95sNp2PhD9Q5Ary0RhTqhJVfz6jb/zO7Ta+wh1fmbP0logh7Ws1w3A
 sV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716744; x=1712321544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/uqncGmEK8RA22kICeG6fpJeudKfrpDpfSasZWFQjg=;
 b=TxFIHR9LirE0q3xqCi82T0p+FypJ8bLuvCFcPwFzqgGOmB6XCZg8RlJASX1nMfgOno
 FJr0rlu8EMfVHtvuHNL5UvLDz8NUR5fCwhCCarUw2uNqoZM4IEFI4R0uPZS6OVQPrT7n
 iZNBTU958TLfSBTAo6q385dNt7lpGnEbScHGv+dTaEcsvbSlkiyNYRQHsyBajtppUagy
 1fZ9xEihASi4dTpV+/xJImgQjfJIXtj5M0E1nI6woL0e1rdHrwKZXn/M72evnTASIZsN
 ggMvVsy+fah0/pHCtfhz9sS4kU9OY4Ll66ItS7R/nNptxr3GtidOEAUEVCvuQD5Eat0O
 Jvfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnMEc6dlr8WVRss7sBSaIYvujplxSmQ/4q/4LAWVYsBjBF56FDe6YJn1aJykyoGTUM1onj8wf4DROz3Lvxv+KZIEGuZuw=
X-Gm-Message-State: AOJu0Yz4Pf+ni+7LWNsQ6CeOjaNF8qpNCWKdV7wKCD5xykvxoXSEjiHn
 K3CDJFCWjR+rFBzTMPezN4Kh59e1r7HO27rIq3ZYVJ/ITAEvCnQxW/uex37c8fo=
X-Google-Smtp-Source: AGHT+IHYhcUzOjFd8haIwKH/5W7ckJr8xzea6tuDdqIspoHfKV0IvTcIVtZlkCFSkS2TNmKUCIpZog==
X-Received: by 2002:a05:600c:1913:b0:414:63da:a347 with SMTP id
 j19-20020a05600c191300b0041463daa347mr1356390wmq.19.1711716744265; 
 Fri, 29 Mar 2024 05:52:24 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 fc9-20020a05600c524900b004154399fbd9sm5459032wmb.45.2024.03.29.05.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 05:52:23 -0700 (PDT)
Message-ID: <0c0c4838-4b64-47f4-b693-8cda95d837b4@linaro.org>
Date: Fri, 29 Mar 2024 13:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen_evtchn: Initialize flush_kvm_routes
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Oleg Sviridov <oleg.sviridov@red-soft.ru>
References: <20240329113939.257033-1-artem.chernyshev@red-soft.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329113939.257033-1-artem.chernyshev@red-soft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 29/3/24 12:39, Artem Chernyshev wrote:
> In xen_evtchn_soft_reset() variable flush_kvm_routes can
> be used before being initialized.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
>   hw/i386/kvm/xen_evtchn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


