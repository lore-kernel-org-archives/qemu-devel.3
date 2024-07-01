Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B0DC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIW9-0005GX-Vp; Mon, 01 Jul 2024 11:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIVs-0004iO-Cj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:00:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIVq-0007kZ-4m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:00:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso28157305e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846011; x=1720450811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ypUVq+qGNZm9nq7Bu6AhzAAvs9/y5+Ly1uBouhDlzI=;
 b=tdCmuoLQxG7Esqae0ycNmqyUAt26B5h1RNzUz/uObf8QXPWajcbNlVz3cwNtysWkyu
 6p7RP3Q41drFBhz30ND6UA0MIu8/WWKgpvd+KmpW0Q0qebgC6cyxV7Khhk65UMh8yS19
 ETGHTn/quN4o661ADuiuX7H1h1Urtunx8vgPHX607aHMqU4PxWi3qJddfkfG3XtfPK+d
 Tz3yoGfdyedET+XX9v60GsevizymyvTDEL4WARNamjv4QlGUZKpAt7Brfb/GRuTTcI+9
 szf4RQEKnjIRZYTnUSIKkfGiiBK3XHnlFwP6ct28qKAIDjnGKWnYtVQh4GT0vorqIJ9W
 7BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846011; x=1720450811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ypUVq+qGNZm9nq7Bu6AhzAAvs9/y5+Ly1uBouhDlzI=;
 b=lOUV6j6x/H+0IS/h4nq5jjHd8mderqTBaytJORNEtOK2rOOtiPyCxIZBCNNBnH+9X3
 bV9XYVDORO7fA7cg2y5lyQCICcmDGs+U8g7QovRvTL6zl8uIZ38HakHsMLhofKClZkLh
 fUn/oYp5MZ6W9FBRfxIr/qFD8/hjnVAasIULijQfge/Lc2mHZcCQ62v682Bsbh4Kan78
 rrM6gEMsPsjpRavwlgrRY33luQywgnQPwdKpNXDZDrk8eXlHvekSwTLH4qBcfnoq2tLl
 xRm8c2vfDRRGTEEWl3S747dw3ilaYLwNZTlhgiH/DDTqMNrD0U/kXkxHgP7iPIpazJmi
 oY5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtEZPvmKjfSsZaGd8JQqDz50wggfV6vKUxZhyrKaK8B6gBSRsd6RgZw9hVhzkXMw22zQ0TbRWs3Qnv1RGVEnc2H3usLrs=
X-Gm-Message-State: AOJu0YzzEkgVczg1+M8vpR15RWuYZQ+eM23emqgusVQYAcgnxMWOzgO1
 0f/6Pnniv1+F3SCerhaB9fPHPZ0DrGCyhlYOswQjmABBSBFyo6AZslG0l35zlow=
X-Google-Smtp-Source: AGHT+IGw4utSZofaR8s31XurL9kN4SXhhNSrKLuYaBCuGsr4+mtj0e9rxF4SQHyKBbhaywyRqmNGSA==
X-Received: by 2002:a05:600c:6d4:b0:425:5fd9:370f with SMTP id
 5b1f17b1804b1-4257a006636mr49779265e9.9.1719846011602; 
 Mon, 01 Jul 2024 08:00:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b068d1fsm156950185e9.23.2024.07.01.08.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:00:11 -0700 (PDT)
Message-ID: <8300bbce-9cdf-4e55-8696-89b450634f9a@linaro.org>
Date: Mon, 1 Jul 2024 17:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/macio.c: switch from using qemu_allocate_irq()
 to qdev input GPIOs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, akihiko.odaki@daynix.com
References: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/6/24 18:03, Mark Cave-Ayland wrote:
> This prevents the IRQs from being leaked when the macio IDE device is used.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ide/macio.c                | 10 ++++++----
>   include/hw/misc/macio/macio.h |  7 +++++--
>   2 files changed, 11 insertions(+), 6 deletions(-)

Thanks, patch queued.

