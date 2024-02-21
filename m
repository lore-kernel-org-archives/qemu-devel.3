Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D8C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrYo-0002Dr-DM; Wed, 21 Feb 2024 13:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrYm-0002CW-WD
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:43:13 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrYl-0006em-Er
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:43:12 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3e550ef31cso95973566b.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708540989; x=1709145789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mREZuS4vl04GEMCbVbG0gfOlQu3ED2DjSLl2cG2tELo=;
 b=KqyMhNlRybeJM/my5jVqUx8hdFxb1vl3AYfS+2J8825Z90ix1wVCZUzeQ3bSYR4B62
 EO5JMV5nOeryZSVrP7ZAgPQeh33LT4ytBFY3wQQVm3hkLIdjH4GFVqKci5U3dBhl2Bm9
 OvBfMn5gKE6MKmsPXCOjUwoMh3GQZs0HBq/AvcJlqPYJVlt7I3wbh7hOPL9127emOnyX
 sARIDg9RcnhdfoMd2WpxIAp6F3wchhX8xdYkPqk/DGzE1BP5eWCcHW4kput/k5UlZYTN
 156UKrAtjniKuOkcY4TPfRqMOi7hU262D6I4nIeTCTC+yVLSUniQM2DlmqVkbTdH0PgR
 k7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708540989; x=1709145789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mREZuS4vl04GEMCbVbG0gfOlQu3ED2DjSLl2cG2tELo=;
 b=lPlVkdzVKJf/uvV4h/nNfYkM8MtayQQ0Y4v8EhxaypcZtxk58vYCdzZ35SjOhOM5ZC
 3T62wKb/vxIKJ71IjXkFpLvqHOa7FLUoajpCUDR1iMkjcPa+KpNizEBq7Akm2v56xjjz
 rl7QvxyMrYW98AUcRQjDrB6NMjR+ckT65WfQSFAwRu34ho8d/CHV3hpJwbtyCXLAdN0w
 lEZ0QtLd9n9QVoC0fGg4va2q2z6GzVu3eqNEZjJECnvguZHITlV5/vk0BY+Xh63IHtaC
 YcWMw1JCyYL34jKDPugUso3z/biZsHt4oIz9ln9e6/vbG/rzoQRn79kCE8z543eR93hc
 5Z6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPxwqZ3tcPOhg1gVZC5SLQEBFYHDJMfLWiD5jaCQnR9LVy8mfxKmyLsTnCmY7/cD6q2phDfcE8Eik9hu/h6jzUFj2XUWQ=
X-Gm-Message-State: AOJu0Yy7CcBN1JZMSl/rpVKB9fqIt91xFZo4R1zH3bczLxJY1s8dbGve
 WtXPvxZ2txUzJJTIxB2MW2S/1Y1pQypXqQsET3DaSKf9PpeMauKiAibYAwjf7gEgEGwFgvP39KC
 is2M=
X-Google-Smtp-Source: AGHT+IHdgB2L7Xo6+PMSW64+tGlkVQh9R1ZJU8a7Zp61Oofr8cHDQ8+5WwAXqLrVdZMM2AKwAKSPjg==
X-Received: by 2002:a17:906:f4e:b0:a3d:9a28:52e6 with SMTP id
 h14-20020a1709060f4e00b00a3d9a2852e6mr12036319ejj.50.1708540989569; 
 Wed, 21 Feb 2024 10:43:09 -0800 (PST)
Received: from [192.168.221.175] ([93.23.14.172])
 by smtp.gmail.com with ESMTPSA id
 vo7-20020a170907a80700b00a3d00616e1fsm1424939ejc.193.2024.02.21.10.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:43:09 -0800 (PST)
Message-ID: <d1b005a8-ee10-414e-b76b-9c56ef657a9b@linaro.org>
Date: Wed, 21 Feb 2024 19:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/ide: Move IDE device related definitions to
 ide-dev.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240220085505.30255-1-thuth@redhat.com>
 <20240220085505.30255-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220085505.30255-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 20/2/24 09:55, Thomas Huth wrote:
> Unentangle internal.h by moving public IDE device related

Disentangle ... from? Untangle? TIL Unentangle.

Anyway I'm not a native English speaker, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> definitions to ide-dev.h.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/ide/ide-dev.h  | 143 +++++++++++++++++++++++++++++++++++++-
>   include/hw/ide/internal.h | 143 +-------------------------------------
>   hw/ide/ide-dev.c          |   1 +
>   3 files changed, 144 insertions(+), 143 deletions(-)



