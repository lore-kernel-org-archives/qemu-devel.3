Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E75D4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 21:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVE7-0008NV-PI; Thu, 15 Jan 2026 16:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgVDt-0008J0-R2
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:49:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgVDs-0005mw-G9
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:49:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so3804535e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768513783; x=1769118583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdsQ2gazNALECRxJP1VZ1zRl85PWY1rLo9QPjTTKkeA=;
 b=M40n6KFVk/KSV4x7fijujNaCRT/9UbcQ3bl3ue+JiQfSZYo2G1gneTGg/HnUBqDlya
 a2EVviER4jgMiqgEGeUZ0o+1dzExsB+7BWqdg+ayPEvqYntJSjB4Ga03JDbiSqy+CNhM
 Im25yfIZLnl4ndjA6mUbQBmhej7E8iwsvY2wdbbQOz4FaxJTPsXdydDobe0ZGX6+KSYv
 NRTyWVOVXOmPbGBA49tmqmC0taZrBx+fZP/juaPhJx2FzSqVM/cMRzTGgWlM4R48XRWW
 CGazaK784lHI+6R1oBcNbivyfPl7Apd6OiZkePgA0oAZyh/thoHVDgBnTbAHldt/uxJA
 4f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768513783; x=1769118583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdsQ2gazNALECRxJP1VZ1zRl85PWY1rLo9QPjTTKkeA=;
 b=QT4mtHLT4zrZqy0sXJ/GF9J8jmVynhxR+ZXpG7A5XcpjUxhPU2i57NDnRCAN57CyMI
 Nxwtb7eJM5Pt7dl2ZaoBq1dZqy7cOV4rVw5/mO7xRQPuYU6lUJR3C7e8F3oiqbi5GM8i
 h9OuIMXe8LpLsTBDNJpYUOF9q6rTly4zAZDhulzzHkfbIyMMgffrtVLDb5nuH1LOR39j
 HwZMWmlRo38szqCi2/S5voyukUcU01XB1ImQabkcnlUrEbPbai96eLui7LoT50crVCNy
 /mU5sN1Bmu7IFe7px8A5mF8IAnUhUJobTdYmsaGdOcGlwFoFsAXJGyL1VST+PEtPo2AP
 cF0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSRHrjbF3a24KhPIUsBdZpnzBK2q0JmB9e+snQvoGeJfhLbVhL6XcNsF5ib1z7b1KLdtjf4jmyaeYn@nongnu.org
X-Gm-Message-State: AOJu0YzoF0NsYCfgX983yPE0YJg1WIYqbPfiakN2yMij9phYm39yykJK
 0Gy9zXR8Ts8XBhAfq6ETfrpXXJwomkpNH/tkognGz5wbXghB/l/RZiuUbA0+aYjsycRC246kwT5
 f3HiJpCE=
X-Gm-Gg: AY/fxX4KrWdnVwAvpecVUj0YGE5cYyDGY/WilDel0G/eiOn7L/T3laG+0g7zkDo6Sjw
 n/iV+Vi7NDskdKPwnTzjexwtz9omP0JqzvgRCxgKvrjFxa12Jg651UomJ/HSzOzsvGwHL+VLIF8
 A7arqRrG0R5mG+u4QvO/SoXaqkXRxj0G0qbaMok71/lE5PkNIB3c7ucWGM/fIFzqkyCv0okwFJN
 D6coWUiQexHb0CDdmy8+gIVg6cthfTtiOMtZDeRp+Ks0fkhuFvNMLa+zWTQh6gUmQv7P2vQFREP
 dI+1M4Fi59UQiql1CCJnLqlZD1TiMPCcw1ewcQg7b/xACagPryYKUJachl1Z92t5mGf/mPIrvdO
 UaBxG5crwbnwUICKazITBZYQeh0WKr+nIxtsw+ES0rmpOMS+CpniaEolu29RZFlx7voXvCdpOUZ
 NYcYH+NZdfcvBTesfOzND8fnP7ugtwEr2bpx6SSDoT/LuMGsdv/SDZcQ==
X-Received: by 2002:a05:6000:288c:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-4356a02c594mr849237f8f.14.1768513782977; 
 Thu, 15 Jan 2026 13:49:42 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699271easm1238154f8f.14.2026.01.15.13.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 13:49:42 -0800 (PST)
Message-ID: <5ef11484-a45a-418e-9ead-baa67527a2dc@linaro.org>
Date: Thu, 15 Jan 2026 22:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewer for linux-user
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/1/26 21:17, Pierrick Bouvier wrote:
> I had interest in this area for some time, and would like to help
> reviewing it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

