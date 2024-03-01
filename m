Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B83C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8v5-0003nQ-Ks; Fri, 01 Mar 2024 14:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg8v4-0003m5-5K
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:51:46 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg8v2-0005df-F8
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:51:45 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso2236345b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709322703; x=1709927503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YKKPqCaBp34ZvikGcVi4z2VqdZGdGAgfaYBtkaDdt6I=;
 b=YkibVjNg5Shd3PKrrJr2QBXAOVgnQPODq68e2B2OJa06U0krVASSx0vGXb1aDdSfOk
 fVugzXHhvwDQ4/DZ43ivK6oVspH7pLdccbgV+p2T9vLj/y5xA00Fal65Fuu30zPbGYXU
 oHlFEzAC1OzF9t3q+ItxXDNzYx8UrTxowgvs5z4WrwruSkyjAWEkUYPs1EDw/guaW7SO
 LGSIu9qxkPN41+dzsS3mf/XHhoTk7/0hzVP83YwvLy+DbCHwjej7QRnekn7fLq+OryG0
 mOzwLyw0R5J2oE9lCv5LV46ViaG5zBTpwFN6ehH5zU3geb/JmJQzQwe1oScARGh7XmTR
 nD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709322703; x=1709927503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YKKPqCaBp34ZvikGcVi4z2VqdZGdGAgfaYBtkaDdt6I=;
 b=YvVQ7eV4VTkcDak8IzxGX+J5qFmlXuzWT1N9C6qEpJu63U3q+gKgt3gX2/Wg5Vka41
 Gig44RTTC7UmDpw3PX6zt/KjURWcoALwALwQTYshSrqVDS7eovxuykyKfISKK1Kk9fJq
 pf3Xnk8MS5PLtDPRrUai2mDbOBPX6+LHpiC4zR93aZ6WNBcuqtSdwqEkzlUN6iDhYv4K
 QjbjUyCCXQrnneZYHPRWuoN9HicmLkFKSxMLstRBHk/vqNxcubMLJzQ74u4O5Vz7gDAi
 cpNRgBxrwCHw8VPqtbtulXiZ1R62HjKMOd7LDpJY+HWlRG2ZODIP5ej68tlaZrSXsfRb
 dmRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT7ffJY+IssKKG6/mNCVfk1UXMJWo5yAos+WKri/kNQSFO9s/RqFdIU5snBM1DhQTKUWpm8DM4i8ApvBnEGfjlGsioyzk=
X-Gm-Message-State: AOJu0Yz/IOsE7DAFHknm+pow4pD6Ld4kLSZUgaVKJKrVhZ401pOqm0yZ
 5KedJ2wZzcBsp9SuK23a+vVCB0pqKo+JgKSV75LIr3revz7BMISSpqKtIbnDLs8=
X-Google-Smtp-Source: AGHT+IEmlVgHobIfRgIhUY3xR9gp6wy05yat/or7EnLg50UjNsNdCHZrRfsAg9LnczTFOsRb04TJtA==
X-Received: by 2002:a05:6a00:803:b0:6e5:7b34:fabb with SMTP id
 m3-20020a056a00080300b006e57b34fabbmr3252285pfk.29.1709322702626; 
 Fri, 01 Mar 2024 11:51:42 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 k4-20020aa79984000000b006e559bc3250sm799108pfh.68.2024.03.01.11.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:51:42 -0800 (PST)
Message-ID: <a5bfeeb9-5b56-4edd-b98b-d16f4dbcc57c@linaro.org>
Date: Fri, 1 Mar 2024 09:51:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make some structure static
Content-Language: en-US
To: Frediano Ziglio <freddy77@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAHt6W4cH+=pyxNZ9F_8Yed4K_pYfO-qP6iNHQHEYLvWUk+aGUw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAHt6W4cH+=pyxNZ9F_8Yed4K_pYfO-qP6iNHQHEYLvWUk+aGUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 3/1/24 08:56, Frediano Ziglio wrote:
> Not used outside C module.
> 
> Signed-off-by: Frediano Ziglio<frediano.ziglio@cloud.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

