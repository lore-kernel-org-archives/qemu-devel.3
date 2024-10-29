Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E11D5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 04:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5eJg-0002d6-AL; Tue, 29 Oct 2024 00:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5eJe-0002cV-40
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 00:58:50 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5eJc-0008Hd-Ff
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 00:58:49 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso3586445a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730177926; x=1730782726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYGwB7KjbyyWhMNOuKKcVBiqCuLAsdAcvRtaKrppj+I=;
 b=tOieteygZ++ECFOz5lU2VUsU80GHr+ujBk/gMyL3+6OXEYCiJME7H1uf/2ZD/NrSK7
 V8+WA+1Uae9BG6s6s0YU9d1h1ob1K/rWNZFQjt19hQAUxVxsbTf7RmUlCuyJgOJ7VZJW
 cKmTlLBOBvEDnYqF7poXOn+P8o4wiFq07viUpJdlvnvaYMyDXD1yhzyxmVdCZuLQSuQE
 RbsTKhyHZKRllvLVtMYZkMNpn0EDCf1UNPlLn9lxcs6pIbgDVeM51+Rm/Iql6ltmYGe7
 1dF3jF21lJSaHHHAtEHP3gv11rzVaF7Xo0G1MS9nCnjG7phCYODuFRinks6TlQ+RCJyL
 jauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730177926; x=1730782726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYGwB7KjbyyWhMNOuKKcVBiqCuLAsdAcvRtaKrppj+I=;
 b=uAHrbt/r+CBTbg8ioGS2Tm1y6FUyiJYfCGZm2UKYSvg/ZztGr3d0gXf6hoKKx8XUfM
 ZEWvuirsTn056tWB9jSSo9B5teFPIaO9Vx0S19mubjuY9X+m7IGlemv2lpgsFM6G28qi
 K4akB292F4orEHskCLJqfv433clpeaG3oFv99TZMfrdq70e94HGcqgfIu2qbHyf8JJyl
 ItzzL5NaiakHJgHOs7IVtMcZBBdSOFwgwePFekEwTwaxWBg+f5uXCzzb2iVKMUOZrWcC
 gGZ+IA3mQOBQ+VUoIBbzGmLJk/3aI5fymq8InH25pIyG92raHeYSziFDItJaPqvfFoSi
 j5jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbwcZ+MB9XEhcqIwZnkcBcp7yqv0Qvb3RFROE0bpocDM+SiwUbFxG/MY3I1anlR2fYxGcp5MGt7VfA@nongnu.org
X-Gm-Message-State: AOJu0YwnefyjjQuc8eetvO1/h8yT+2oJiqkwS2f41VQgPH0yOypTqmMV
 SRPe1veUrz9b2hdLhRcljM1Rvw1WXV6tDnAyUIkq0TcaehCZfroGaYhF7xbJ5JJz7QEmFplUjip
 +
X-Google-Smtp-Source: AGHT+IEKorNHywbGNlMkjsMBNdsMr63iH66S9yoEvb1jcjxYgUZUlYKksItHIBeDiKtCGuWUa15c+Q==
X-Received: by 2002:a05:6a21:1807:b0:1d8:fc13:2399 with SMTP id
 adf61e73a8af0-1d9a842d27emr15500443637.16.1730177926387; 
 Mon, 28 Oct 2024 21:58:46 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0d025sm6679634b3a.101.2024.10.28.21.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 21:58:45 -0700 (PDT)
Message-ID: <f58d7435-c329-4961-a461-9242a4e89366@linaro.org>
Date: Tue, 29 Oct 2024 01:58:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: enable at24c with aspeed
To: Patrick Leis <venture@google.com>, clg@kaod.org,
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.co,
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241028181420.1438938-1-venture@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241028181420.1438938-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52e.google.com
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

On 28/10/24 15:14, Patrick Leis wrote:
> Enable AT24C with ASPEED in the KConfig because the boards build this
> device.

Maybe explicit the at24c_eeprom_init_rom() call which instanciate
TYPE_AT24C_EE.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Patrick Leis <venture@google.com>
> ---
>   hw/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)


