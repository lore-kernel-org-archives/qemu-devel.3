Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2202CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyqf-0003mv-DH; Thu, 07 May 2026 09:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyqe-0003mn-Ct
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:33:04 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyqc-000185-M8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:33:04 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a8891febd2so954897e87.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778160781; x=1778765581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+iedPB5U9P6rIxrU9uMtq0/tJODLfdKB0lRc+YBi8g=;
 b=PJ4TfO1eKfRplLlNQbzs16kKTelKRppQ175uohYQ+ZbyIPqHvp3d0hK9TAwCvUFsFZ
 vBwcy8jvYiXQsmCQK/zmU1boQb8K1OCsYF2qDtPfUyyqz68vznQOcR9ipX4LL6Jpf4vP
 tKH2u3F9UWds8c6vzeK41LYVAcvrREtPJMPA1loGSdxYE5HoLmZ/SaIXVl2y/1XqPSQM
 RHgrW9YrQ2e3arUcIGMo055RGT8x9QubSMueertw71R0GHr509JHzUh/QnOPekhlLG9D
 l6BjnblOCgPWqk797pKYjJHcK8oypF4fcfZhIiuLNlX5Ig3bpC74xRArEFj5vHPSPEse
 rD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160781; x=1778765581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+iedPB5U9P6rIxrU9uMtq0/tJODLfdKB0lRc+YBi8g=;
 b=k/7q0IGvvU4EzUOkSvluxv8XIQZvXUYhDjSnTp7gsK6LvPrAWbx6ngc7GqgX/fFWhM
 gjIEpj8zfh9kDV49HTtsxe++wNwf+w0l0+lpq89i3J+bA/PoO9k8Zbob90JN0R++Qtmy
 UgbxA8YrNyOpkQqqkFzeG2g4ZBGe9X/3kUbJ1U5amr7ZQ7O1gOS+Fzi3mI6xUTrJ/fAq
 xRfE4syZ+7DmEZooGp892vYtoAOVnh9/+z0Z0JtwMiccmem+HE/3XPnyI/STEJVAdi63
 MtQz5CoA8ASpDIDrPsI6nPEHTHn0HQiP3YVcqrFMc9p+8UcH5tWy7N5EfaUnjuCj8Abi
 8Olw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/88WK9ggq8KzVXsPHypqlh9ClPwURVSKe3ICYN9La//2Lf6tt1hf41YcZJrx2BpMfUewP++AqHXjWm@nongnu.org
X-Gm-Message-State: AOJu0Yz1s8UTkHIieag6CZKQQVUKuDrQRQSe6nudAkBGxldalQ0ottpL
 dkP8Jru70oXuYrtiBCP4KZQTr/BM/oHhcxq0KmfX57DqLvLmx9Wd2KwJmx1vVR1Id7g=
X-Gm-Gg: AeBDieugulll4MpwQIy9CwNdNE5aEUIcKyXkHDePhfY+qh0Uhr4mRMc5O+HSt5E0KVk
 sOjCaChxG4q2weuZrvBjHrZW8y/UCr6Ua8aMeVmPpgvIzNntyO4CLwNjxNRg9tHO5jGcg4GBW/R
 6vTV6yPsNsxh8BAe1mv/iRMh5RiLtQFD8j+ev3yn6QMGRPZS8cBqIDoPRJ64AIxzobU3HUCrkCW
 RNUC2Wu6zDRGflzpjMuRgfbaWDD1KH3QVVMc6ABy/E+LnThu+PNcLkPyzfGb3vXBGPdZdYuHyHL
 2Lb+q6tz9xp1+7quF5h9tqSCQCRZlor3hphrFqqTYoWifaiXArhn5KApLgR9tDP6TCgSqxbPvcR
 0AgLVaATWkdf2lo6X/r+pmxv8naqrz49plA8/DflLFocrYEelSAi9UD/njI+s5Ogk4yD4Q8BrFm
 8RreVv8D3Yun66LEFoetqu/TZuVGGZs5k6WQfK8KbIeicK6MgK0g9OeCq78qPZWAuxPylxI9tdw
 fDZ
X-Received: by 2002:a05:6512:400f:b0:5a3:e7d7:c67 with SMTP id
 2adb3069b0e04-5a887ada558mr2655063e87.5.1778160780574; 
 Thu, 07 May 2026 06:33:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960811sm21384789f8f.27.2026.05.07.06.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:32:59 -0700 (PDT)
Message-ID: <b538fba1-77e3-43a9-bdfb-e7ed1e5218d6@linaro.org>
Date: Thu, 7 May 2026 15:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 ops
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410183249.4046456-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

> Peter Maydell (2):
>    hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
>      pattern fills
>    hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
>      copies

Series queued, thanks.

