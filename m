Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5E9C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 10:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI4VL-00045D-R2; Fri, 14 Jun 2024 06:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sI4VJ-00042v-Pb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:49:57 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sI4VI-0004so-7z
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:49:57 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6cb130027aso137189966b.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718362194; x=1718966994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LyiZLDwZ2ruh2x/3JT28HfUwemba0ZVuFbD6YSVOYC4=;
 b=ofcxvrjtYitaCd2zpRxlSiiOprjwzPBpVuSZBdi1mgAiuaiSyF3OGIfhxTZcLuIAee
 +nOod3VKgYvH4H9oj4ghYdJr/YbWlEGDagPaRCs6zTrCzsDf5UHwZknxAkLKK/JjzchK
 Z+E0VlsUYXpDrud+pBoeV2CI3zIU9+opyyZ5tltqZKXWLlHWjTVOKvaqJpAQqnlCVe5D
 kn8mtAZLFBUO5yCD8lAd8q8jXkpgAmpfCv0cXrDR/BwFiCO7b4ReGMGNkVRTQIMuCMPt
 cusOi+yYCNFeAuCY2Ke82tLc+x4J78Xwtg3nKtn9yNWzw0kOIFVkK+gi7Mso9h6RIzOC
 jC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718362194; x=1718966994;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyiZLDwZ2ruh2x/3JT28HfUwemba0ZVuFbD6YSVOYC4=;
 b=SC5pS8UdnEzTMCDnndv5EeXLnZ4NYEm0kcqG4XCXw0wEHpj0Inp/OYcQEsNc5Hwr0D
 4vezzgtGi/Lzt97HEJnS8r8rGQtNEtKj8as2gMQEUAqXRApXTPjRvpEI8M5tql0Lg6j5
 sjVcGlty2ZYByn9XxvqkdO5mH689iytJkFjoXH5dzss0fRpCqv6pdfmnLCqCQEt61c4i
 WyO2Cs6dhmR5DJOAafGSAtdq6ByuKMSgSav1AuHwuXmoZP8L+CG2FStRixlqTVSW7EIg
 Mn+JDNFxM6QwtPHhzCcB4VB6KmEF8eVuiHpB0DzCRu4pkSUJ09pHG73ej9VG3+BUCtmA
 D9cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl1K7yv2tcz3PSlWEVbGtoT9AHmj2AyuamGFPKQR5FnXDNl8ZhfsQU458eRLD1FYgIIAOjdCnEeKk0rF7Q5E0PTmsTZPI=
X-Gm-Message-State: AOJu0Ywmo80E4CihurbV2aVfHQU6HTv3nZyw9jwLyrPvxjv8Z+IBnWfO
 ICBx8bBtAjGScAxVP5web32Ofif+pyJRi4DK+yJbjNLg4wm40E3mA1jHe7QmLVg=
X-Google-Smtp-Source: AGHT+IGSFTjBe0eoN7qqX+IRN6dq6gbn/AaS8PSt+1RzePz/kF/+eJ5/V6GGbkczO/kxfFHnkGFaIQ==
X-Received: by 2002:a50:ccd5:0:b0:57c:8035:50ef with SMTP id
 4fb4d7f45d1cf-57cbd8b98e6mr1852293a12.35.1718362193988; 
 Fri, 14 Jun 2024 03:49:53 -0700 (PDT)
Received: from [192.168.200.106] (83.11.211.179.ipv4.supernova.orange.pl.
 [83.11.211.179]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e782sm2081458a12.64.2024.06.14.03.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 03:49:53 -0700 (PDT)
Message-ID: <7c28fa29-8d62-4553-82fb-098ed06a8774@linaro.org>
Date: Fri, 14 Jun 2024 12:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Xiong Yining <xiongyining1480@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com
References: <20240607103825.1295328-1-xiongyining1480@phytium.com.cn>
 <20240607103825.1295328-2-xiongyining1480@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240607103825.1295328-2-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62d.google.com
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

W dniu 7.06.2024 o 12:38, Xiong Yining pisze:
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
> this topology can be passed to the firmware through /cpus/topology
> Device Tree.
> 
> Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
> tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


