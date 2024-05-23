Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AD0C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 18:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADTc-0001Z3-2t; Thu, 23 May 2024 14:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sADTZ-0001Vh-Gj
 for qemu-devel@nongnu.org; Thu, 23 May 2024 14:47:41 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sADTO-0008LP-Ag
 for qemu-devel@nongnu.org; Thu, 23 May 2024 14:47:41 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e95a7622cfso867181fa.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716490047; x=1717094847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=noqMMMOXkPmANYFZCV5EWRSHO24/boBHs6HDsbfjlbM=;
 b=BJ1Z8yK31ZjRSpvDS4GQEykehg9zRDacBH+ul4Jx3TZsr25zlYhz7pWKRxteFYbhFW
 GYp9RMrHxMsCpEh1eUMx8lohL/e78xOrAwx9E8CCNdkCnU2Ttmhedy8NT9YcrIWSMuBW
 bsJ0D1XFn7s2r21yFC7xwXE743uD+dbvsNqQbxnXC93yLvBytpkYyEQTbMOITfRZivnl
 puC2aEwjo4ffuKnFmtRx60wkrZnNKVO2fg7KMrmcBcpOb/+fE7yVP8Sz2OTk91S14sjM
 XahfJCQMCz9tT4etxth6mASw7uUjovbEoH+Vudke/iu/a3zip1itqNFKAguUKOhSx10e
 flyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716490047; x=1717094847;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=noqMMMOXkPmANYFZCV5EWRSHO24/boBHs6HDsbfjlbM=;
 b=Q/hC/Xls3qOEph7V4++QLBTO51OZwOHxvCZf6QatZMgFvZ20MWle8d0e2GEBupmKhq
 eWLucjIMreYjCgPdiYYL3fJu0F33bERDQ4pWO9SJxTJEoL6LEqG7j06ePuwpLQtPiCMV
 RshsEyIdD157wc1n28heRGM5YqypozDRGXuBG47fLxbdlyuKfnOlJea3soBzi+KOdzgM
 LkoZPOG8jM4C47ft1DfctCRYlOI93/+55Y9VW28Vwm3+wNUOYbcnnkEe3Measdvmxfto
 koQp8cxAj+1mE9drPxxZP/aQvQbrIojRUGDcxaik2Gtrfe8SlHVeIr0Cmu0cPj7GVOWk
 oILA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVir9hP/xutSky8yQjdmqw24uEnEmYOcqsyBCuhNqWC0jePPQbg6AZOXiVbuM5sP4eFGjmCDB3h6hZXl5XhdNaxGJN6r6U=
X-Gm-Message-State: AOJu0Yysk8PnaO7wi1rDRa1no12U/Z6EWQT+G2KUiItCOce4vlYD9QyY
 JEbv+QpOKweyS5KTvEWaTq9O5iAfyH/OETXZlOeNp93uKNzOfp/z7j7G9V92Crk=
X-Google-Smtp-Source: AGHT+IHHsh29Wv9iFC+Z7vof7DAiEAqH4lwv3Us6zH0OmOLgTeRiTquvkVYqb8LQwKCjZW3HjDRtMA==
X-Received: by 2002:a2e:bc24:0:b0:2e1:a0d1:2c0 with SMTP id
 38308e7fff4ca-2e95b0bd79emr205501fa.28.1716490046812; 
 Thu, 23 May 2024 11:47:26 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578366176e9sm2858894a12.74.2024.05.23.11.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 11:47:26 -0700 (PDT)
Message-ID: <456d4233-a1b3-41fb-9fd9-e89a4fbb5c18@linaro.org>
Date: Thu, 23 May 2024 20:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Xiong Yining <xiongyining1480@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

W dniu 26.04.2024 o 09:35, Xiong Yining pisze:
> From: xiongyining1480<xiongyining1480@phytium.com.cn>
> 
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
> this topology can be passed to the firmware through DT cpu-map.
> 
> Signed-off-by: Xiong Yining<xiongyining1480@phytium.com.cn>
> tested-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>

I had some thinking about it recently. This patch exported whole 
/cpus/cpu-map/ tree which we then parse in TF-A to get amount of 
sockets/clusters/cores/threads.

Why not export them directly? Kind of:

         cpus {
                 topology {
                         threads = <0x01>;
                         cores = <0x04>;
                         clusters = <0x01>;
                         sockets = <0x01>;
                 };

It gives everything we need.

Had some thinking about exporting amount of cores per cluster (8 now, 
virt uses 16 which is architecture maximum now) in case we would use it 
in generation of PPTT in EDK2.

