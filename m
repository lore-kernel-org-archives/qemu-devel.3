Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7630AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLemc-0007Gv-4o; Mon, 24 Jun 2024 04:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLema-0007Ga-Jw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:10:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLemZ-00009f-0H
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:10:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so23002815e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719216633; x=1719821433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RTAQwadnmzU+2BsFPLzaRXRc6gtw+sJYjl6MK8WhZU=;
 b=zawszadUYbmpYjsZomjFz3OYZsDOx8WgpgXB+xyMbOGJU1EcqNdp4Z04aVNRpWcA+k
 QYWsX/OpO0gtJAgAEEpO5su0JKrVTUS7YHvORViB+75JtIslLhXElqdlVGm8qHLfUj3d
 z41b3d5pWdFcYPKKj3E401IeDZDDhZOUxiyW1KgEa6KjYKETalpE/IRUBrIkbKaZ291t
 tZc1lPIQmwW//n5SawXz2MrD02WGvJIeDaQhJKAUycAAUONya77GKrTRdd7K4AxwtF4/
 ARcUZAhtX52ZJ046UodQ761oWCxtoUlzDRJBTpqOE998X4Q3vnClso45WiCEnFAWQhrg
 f89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719216633; x=1719821433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RTAQwadnmzU+2BsFPLzaRXRc6gtw+sJYjl6MK8WhZU=;
 b=W55A1ypRvFgv+sZsqs9fnY5iUDIFiENCkpCJo71ZsC7zcpy+/fII3fuJwVUicxGJmY
 Ky1toXlJX/EbRqJOTgpy231YEcOnmqcLj09/KwYwqZeTzMvYzV2L5I24W10gg1L455OM
 E4YXwzxNSfUtuFmAy8canYeLTPtMf5+tYXrmKS8h8O7yEK60oDEtBaQ7LNsE/NyxcPc7
 LW5jlk01DDNzURauIgHectWcaZD78Dexg5zprue3EIbyt033csstJsLrtxNM+pQPx11K
 oDQRKfnpdU71Ninod3TjtlfXAmvKUoCH7BlFQLJZcfwtPC7gTyWERgr5SNYylE7aSR3G
 XcFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFDYGtwxBRK5TkgfbkQEMbo1oSN8C7zInxLjFKFNtnM3KEsCR5TSk3YJzR6QifGjYv6SxPcCCN9xk3r94kCJHFpIbYQSc=
X-Gm-Message-State: AOJu0Yx6UCje6+SRvHjsB/nhx61TbG8xFnuT/mXivjvvYchB6tWjvIqy
 PDq2ZpLhyI2RR8Y6Ky5Kdg+SB+LxC3swjKuOyzlROyR0+gr6YuLfW+qD9t90RV0=
X-Google-Smtp-Source: AGHT+IHq6KjIURezU8b+BRJ8jiKQzT3UWlP3f7vvC+JWUKJ7fh6QHdbUDsW/ZXHsv/XAiMs3xAx6DQ==
X-Received: by 2002:a05:600c:470e:b0:421:79b5:6d84 with SMTP id
 5b1f17b1804b1-42489540d0fmr42327055e9.17.1719216633255; 
 Mon, 24 Jun 2024 01:10:33 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817b6121sm125415505e9.27.2024.06.24.01.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 01:10:32 -0700 (PDT)
Message-ID: <ba81d71b-ddda-4b17-af3d-2e4d7b46e554@linaro.org>
Date: Mon, 24 Jun 2024 10:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] tests/avocado: make sbsa-ref working with >1 core
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ard Biesheuvel <ardb+tianocore@kernel.org>,
 Rebecca Cran <rebecca@bsdio.com>
References: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 20/6/24 12:19, Marcin Juszkiewicz wrote:
> Recent changes made sbsa-ref crash when more than 1 cpu core was used.
> We handle it in firmware now so one patch updates it to the working
> snapshot (TF-A 2.11 + EDK2 snapshot + EDK2-platforms snapshot).
> 
> Other change drops "-smp 1" from CI to make sure we test default setup
> of sbsa-ref.
> 
> Previous firmware worked with 1 cpu by pure luck probably.


> Marcin Juszkiewicz (2):
>        tests/avocado: update firmware for sbsa-ref
>        tests/avocado: use default amount of cores on sbsa-ref

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


