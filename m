Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69089C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc8w-0003As-En; Tue, 15 Jul 2025 05:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc8o-0002wY-Jp
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:40:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc8j-0000t3-8K
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:40:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so26615905e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572395; x=1753177195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYh6NyW0fmQyh6oHC4vRL5yJ4GG3tY8yAwYYCVSAo9M=;
 b=EQvm5/J0JfgKu8cRZb5fq3vzkJBFbC61SNeWUfdDSDciO6WfuJI72dW0Mx/cd3A6dX
 ZjTTn7cDWWe1nsZ3FF9c5prkK5c3xXI23LAYEY31QAhIXcIjJeQndaN0yQiwC13fDD77
 6vsVpE36kEVyeyMb6Xjl8y4PHn7SRSce0ugoVxJCcNgkyA9Wt/KXy0WyQwRQFwTb11d+
 09DI9Zjef1HeczdQ1KfXVcfVZvRXdwSJb4U+hIRY2lFyv19IKVL+APQmYGTHqeIo0s8X
 t2OC+cCAdMOfO5VLGkXQZEzn9zngIrr7jv0zafy+Q5qA/mvcCN8G7Rv14FHUY76uDUl/
 DXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572395; x=1753177195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYh6NyW0fmQyh6oHC4vRL5yJ4GG3tY8yAwYYCVSAo9M=;
 b=mKerp7QRJRAE3NbHJ9q06MgXLudLeIWY0BKLXQow7LQwcUvcV+blIKG5ZSo4i85bvv
 Mfby1fPbzDDgJ0AUh204Vcv1R6DrHeWvWBsEIdLAzVKeh2RdxuHjibgp7faOxlOAnthr
 5byw+Ft4w0nQxmkFK3H7rh1gjlx0ih8INJEfrg0IEPtQdeQnxvLGXHbOFtImPXBRifCV
 xgbYdUoXqW1rDBlJLK+24TfuIxsY+t9J2mL7Ts0+rt8Xd5I8CP7yOtD464hq4bPFDemR
 ae4dZsHw6kJupAOOwijSYqEMaPyAxU9NHAk++21WV1fALt4sSBJIJQ4kgpSUz0OqvL8q
 moIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK35g7vWRA23LExjjPJHRFrEd/mb7QjJNRVQc5OKzz1/N+gTrLi86YteYj4k8MNLXBtWHlHvQSEHBY@nongnu.org
X-Gm-Message-State: AOJu0YwXsRoFLvHFSmHIdGuABhIwhjLs7qyT4Ij/QZPSOxoxNOuslkif
 VnxGvbuSkdWGz8v+Au4c8Goh6yvlAv4Plliozl/WNviPl8FnZ08VQDG+wDJ1TVo4OeQ=
X-Gm-Gg: ASbGncvTK7B7km7BxfIjFihZy/pegk9Rlyb9/iYZMBk5QRkL6ytvF/p4GN9jy0CgpHY
 sPCymKj4urmGADgGMc77oz41yTLA4X/9mvu9WxGn2G0uXRn8UUJU4m70nQSq2BhRdCkjj92kqHJ
 Uqi9pzz5ZQvOfjb9QK81pfTSdD9ma76bi7jqv9d8ycz4dosQcs6BEEplRZO+5dvq1S1pbQxITVi
 eflhPNu+hQj/0yA6ZKtN3BwsUZK+8/ThhCiJaIOHSdxt35wFE1c42FkRTNfzUKs8iaX9xcGUB+p
 U1aT7MunKfVMR/ZFmMxuXsVhlkvuxcD+pKig7pqotTYlsHP05VA/4mw3No1H5g8qEeHF2YALtuu
 zrrUpJ5h2weEHvx6l95Q+2n5WS7Pw9NT/Rk7f4A+iiXMoS80uz75+Rl57VwZoes6KQxBbXF8=
X-Google-Smtp-Source: AGHT+IHF54uAGkN6MbGgRI9y8Mw6QN/AeLHIJyhWYCh5HuNkW3A7puL4iogLEE9zdosNSZwcSNbE1Q==
X-Received: by 2002:a05:600c:1909:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-45629ae4011mr10557265e9.24.1752572395251; 
 Tue, 15 Jul 2025 02:39:55 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd14sm86568305e9.30.2025.07.15.02.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:39:54 -0700 (PDT)
Message-ID: <d30acd0d-22ec-4ed2-971c-ce31dc95184a@linaro.org>
Date: Tue, 15 Jul 2025 11:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] vfio-user/container.h: update VFIOUserContainer
 declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-9-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-9-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Update the VFIOUserContainer declaration so that it is closer to our coding
> guidelines: remove the explicit typedef (this is already handled by the
> OBJECT_DECLARE_TYPE() macro) and add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio-user/container.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


