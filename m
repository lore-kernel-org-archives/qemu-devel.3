Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB6C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFuW-0005MB-9v; Mon, 18 Mar 2024 12:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmFuF-0005ID-Nb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:32:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmFuE-0007gB-9B
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:32:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e162b1b71so4093146f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710779529; x=1711384329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDJ0ibNF1M3ekEACvkUALcVoaI0Gx11RdJxUho1aJ+Y=;
 b=m0PncYlmLu2khyg607053bOBg/T2KjjQndrJ23OILjNNGmPdmo8n7efnOJmb7g8inW
 I/8J0zldXC9rHuo1YsDfvLRFXbW/0mJlu18c3uuX0gJpk0+xctU3/PbIIgkKGjeYRh1P
 IH6ucPmfBFLOf//k+liiruJYS0+RV2OmgxMXai3ZcvfXjZSAKUIUDysn7mMZftT4e0hz
 EEh1Mz6dfZd8Cs4TBJ1YsNLN+RGDfuF0mpgSaR+lmm6f1ojUHrYaSyZiXycpclT2WmHp
 b/tl7BGBa/p6WYyjlDIwy3Rr0AiTVPR2MhODaicp+XXpwHFE73GDRNkjckX6w+eAmfi+
 XcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779529; x=1711384329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDJ0ibNF1M3ekEACvkUALcVoaI0Gx11RdJxUho1aJ+Y=;
 b=lG0wIcpDANqv5juimjelJ/gyUCIC+27VGBgvx/oHdYth+xBPHAGYxP5cX8Kz6SzFhC
 kYfrHxz34+pEHaiqbwD41U1n14QAHqNqNT32eTBNWeZimSrWKi5UpP5Iwzjn8FwZPLdX
 8FSyLJXGw6id3qtsYJ8czv5TtZit+rPUWfyyS6g4YlNizIBdIlICfQKx93pUtpUaKg0w
 OTTCgrtkOhYUxxhbBVP56OGFURc5SNsDSKRqvA/hPOTfOz9185bBqL6lWCHwHC25xLA+
 yGA8CeKUNYDebjsVgUXoXdiHwu+tCQUQa/wlLGbM7mnaEn+JgThozWcA97PRUyKSDexs
 nveA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc6qKaX60mjHO73zgZg1z40ja/thsUUogzCY/1VBvXQLdomHgdnZUxG1SRvC1Xtg8AQWhC21VHJAaKzbVEMch3TLTYShE=
X-Gm-Message-State: AOJu0YycftlPkzGw5CEzw1JZIJcJ9N/V+r6NAzn8XRdaKs3wjBf2jLg4
 q+EdqjnYbz3Yzg0VN+LPl7xAXcJDC95lkBRLYkLvVQhqft81lszA22zjt+wbfhI=
X-Google-Smtp-Source: AGHT+IG1f63aNRv9RkX0H4yTG077tTi17q9poeBf0mMpYrpOVXgK66ywCeLX3IqO3dY334Af8U7Gyg==
X-Received: by 2002:adf:f350:0:b0:33d:746b:f360 with SMTP id
 e16-20020adff350000000b0033d746bf360mr10035922wrp.51.1710779528722; 
 Mon, 18 Mar 2024 09:32:08 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b0033e7e9c8657sm10163161wrc.45.2024.03.18.09.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:32:08 -0700 (PDT)
Message-ID: <ab0fd2da-bbed-4f04-9829-b6a7841b1f36@linaro.org>
Date: Mon, 18 Mar 2024 17:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] tests/avocado: update sbsa-ref firmware
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
 <20240318-sbsa-ref-firmware-update-v3-1-1c33b995a538@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240318-sbsa-ref-firmware-update-v3-1-1c33b995a538@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 18/3/24 15:08, Marcin Juszkiewicz wrote:
> We now have CI job to build those and publish in space with
> readable urls.
> 
> Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).
> 
> Used versions:
> 
> - Trusted Firmware v2.10.2
> - Tianocore EDK2 stable202402
> - Tianocore EDK2 Platforms code commit 085c2fb
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 40 +++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 19 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


