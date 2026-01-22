Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F78D3EE74
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwZy-0002YX-N6; Thu, 22 Jan 2026 10:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viwZx-0002XZ-Ik
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:26:37 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viwZw-00005b-4k
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:26:37 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so166515166b.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 07:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769095594; x=1769700394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJnc7kBoipKDrnnn2FeG4648XrAxL/dkWvIlbY7J8ys=;
 b=A8TL+IPaH4FxmBH4EvcHrrFBrMo2qOuj8/IXpdd5xT34HAJ267BbMvnP5UG1PnrjE/
 3lAtRA8VckV4DQ6PkEAhf2iWLQ+PeZ6COAGJl4AHb4mxUsH5QM5W2gWvIjYoRaYvIVI8
 PcxQoKhe4917PORY77Uln3OWBwWQM++dKH7m1XmVPY9w7O8tYqjJsYbvRbvoeSNqYDon
 eNUV7MEHXse44G7nvPCeCsbKF47Dd3BqClB0RDaoGhFSNeCSkjdzb4zWB7axxMSLALWt
 iTDVqLs+NIV36ohcOsu+sU6wXetrkwutQk0xuS0ZqNirrxtXhjYDC5+3oGLa7R6IpC1M
 7kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769095594; x=1769700394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJnc7kBoipKDrnnn2FeG4648XrAxL/dkWvIlbY7J8ys=;
 b=HhWfz0ESNj3XGHpW0prwhhsYhAlcwSKd7QZY2MhFm6/yU37dokKTpwys5dRvzgajES
 HXXkOlHEGceJMNbJ0TkqPzLmnYNr13nIVT89HnPDIM4XxOaJ9qy3Tv1dw0fJbL9vDJ3C
 fqwJrsJ/QqdbTd3HhPuFoT8up59KbI2TAkEy2NYeMsc6X43C/zjwf9YosgiGhXhuV/Yv
 xNPisuRk0jocwFKYkAx9oZRVKJDK6MHWQRBAUwJ6S28mpa8Q4aEm7u/RILx+Uf1WJB9x
 9sEiwL7qjXsJMwe8PA4eGjIzJw+CXDSPWP4TA6QSY9f0I7Icosd+Od6GBBkU/ZdVr9Zh
 TICQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3WBWPA4VPaOncCzSqdBOUMVRghfqWMhv/rfJNA4f7/oZmYOxpOquwDqKjUdRXfmj6Vm929Z4gwwir@nongnu.org
X-Gm-Message-State: AOJu0YyjoPpN+XmjYm138TVDtEPTlqMaTSUF7L6d5ovjYom+8q0Z55ae
 Tro5eZBp7n7sugSSto4gB7SDllP+GgNIDH4ei74cQ04Vxg1GBf9dlN7wsNfNxrxCKY0=
X-Gm-Gg: AZuq6aIUt066bZ1Ld4Qn2AW2Eu52+2GpqvW6A3EqkEHh6MnkUG4yY2ykpYZUPWoVz0M
 gntyd0UX1qlcMFBEn0pfOqq+GX0aINdHdT6mP2mzDivPBolDkG4d8CVKETvX2teu8+7AYcHfn+v
 GuBgQ+nGXF7Zxzwh/ig8Zsma0F/p3ohD2HbUEU+P4yaUYkJRPxHFBgmIFN1qECICgy0G9WmQM21
 9frL6G+dJRaa8FuYPSIIhgUfAzmjlJE9XxarhGA5LO67OLexmEtaePQj61Bmy4hMPbvwB4z0Ey1
 8xS8qrNbYXw4eTLI6NCJD5BC4CQ3HldInKSJrn0BHsQynDtPnac2a8238sgG56n0I8f2h+iAOj3
 BKwiBY8MBrk5XGJEH1iQa8HtyE9lT65ojvVDMBrPMMk4EEC4KNHAB73Eo3wjL6Kl9unKOHrEW2f
 BNOwIekPxhUgyuKuNQinStN2h2pZQxMsTZgpr3+4vSRXZW1ErzzHYF7w==
X-Received: by 2002:a17:907:94c4:b0:b87:7485:b4bf with SMTP id
 a640c23a62f3a-b87965c103amr1791489266b.0.1769095594511; 
 Thu, 22 Jan 2026 07:26:34 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8846fb359fsm68538466b.25.2026.01.22.07.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 07:26:33 -0800 (PST)
Message-ID: <a19e26e9-4097-4028-854c-daa14652e93b@linaro.org>
Date: Thu, 22 Jan 2026 16:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] hw/arm/virt: Drop VirtMachineState::tcg_its
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <20260120180339.1416328-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260120180339.1416328-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 20/1/26 19:03, Peter Maydell wrote:
> We now use VirtMachineState::tcg_its only in the
> finalize_msi_controller() function, and it is always the inverse of
> the VirtMachineClass::no_tcg_its class field.  We can simplify to use
> no_tcg_its and drop the VirtMachineState field entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c         | 6 +++---
>   include/hw/arm/virt.h | 1 -
>   2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

