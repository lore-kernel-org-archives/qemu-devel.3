Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F976ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snedg-0002HQ-BK; Mon, 09 Sep 2024 09:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snede-00029T-78
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:41:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snedb-0007wo-FB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:41:05 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c24c92f699so4882083a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725889261; x=1726494061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dNaok0/389JuNyOt2LzZ4r2pSU2fDk+h6HXAOu16lR8=;
 b=bq3J1HmQq3WPtVi32ivb8IhRD7+70hEC0AzXaaiNbIyVEmI+BrNh1JtSvqDRK0sn7S
 mwueP/+HRCqvlldSdfJ9uz/wrsdm08FXuZJoy0i/fHoRBqoMT+MzsDoEghY26zrKtg+l
 rReP+eM54rxc1IvaN/uhoS69TAhhN+7IEmn8u2g+OE4gM6NrMwoTpmR1M010g47ZAHFs
 bntIVlPmif7hOIvOfIwgB0WRtS0c3ct2gqHVIhEgft4NDxd8I1C98mjLTKDCH5hFLVVp
 wEVogPeEo9HhYWGCiJ48p5Oa8692u2e2Hrr/jIm5LMmMEJhWpg8G3Pu7bVHpXwSJf9dT
 +eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889261; x=1726494061;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNaok0/389JuNyOt2LzZ4r2pSU2fDk+h6HXAOu16lR8=;
 b=qA4F4j+9IrBOLgO8rwshB/HxENSlXsRMlU0w6c19+55uHmDP/5M5U32q5aiEjQGqy8
 OL2wNh7MyBdqSIErfEyekdRTcmgL9iUJPM9LWhXIpKTPhS0y9gF2TaoNjmKhHG7BCEcM
 L5IivJNuX+vHOKHg2IWSjr2fmtoyFpzuDHXgZ4l/Q4VGvEuV242vrshj6lfrQY0hFOVj
 F70LI2ejGDggLaNG10UYwNbzCsIpZMGoTUwirElp4vIkUx28kP/kdf+4WvfOKadWXkIT
 Fjpu19lFgM9h3CtLIMEwpN7X0UbYdps0moBA5nVTXU5/y+LmnQx0a6L3PKHbmgUg4DCm
 LFXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVin+0cC8GkIT/DCoRrdH9AXMRd10ut8VPc1OF6eCkswPvf20wZ41FRgihOWO1k5T7JEzJfNXagZhWS@nongnu.org
X-Gm-Message-State: AOJu0YwCw8//+JfpZbJfJv//oDR71FIjyrI8GLUj9xxJKJpcC010iyXl
 vvZYm1U/BMHgxYIGgxdbsrW5/w51HuHP1/+Z6/cbGqjXlXisOlUo6pGW9Y+eIpE=
X-Google-Smtp-Source: AGHT+IGFGoKjWoOQKZ768kZDw09E/FTLlxs99b9bC9uKTUaBG19DUYoWXRMscuEPqyXM8q2OGwYupw==
X-Received: by 2002:a17:907:9628:b0:a8b:6ee7:ba25 with SMTP id
 a640c23a62f3a-a8b70ee944emr940646666b.47.1725889261042; 
 Mon, 09 Sep 2024 06:41:01 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced1bfsm343371466b.154.2024.09.09.06.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 06:41:00 -0700 (PDT)
Message-ID: <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
Date: Mon, 9 Sep 2024 15:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
Content-Language: en-US
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Guenter Roeck <linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Hi,

On 3/9/24 18:06, Peter Maydell wrote:
> This patchset removes the various Arm machines which we deprecated
> for the 9.0 release and are therefore allowed to remove for the 9.2
> release:
>   akita, borzoi, cheetah, connex, mainstone, n800, n810,
>   spitz, terrier, tosa, verdex, z2

> The series includes removal of some code which while not strictly
> specific to these machines was in practice used only by them:
>   * the OneNAND flash memory device
>   * the PCMCIA subsystem
>   * the MUSB USB2.0 OTG USB controller chip (hcd-musb)

> thanks
> -- PMM
> 
> Peter Maydell (53):
>    hw/input: Drop ADS7846 device
>    hw/adc: Remove MAX111X device
>    hw/gpio: Remove MAX7310 device
>    hw/input: Remove tsc2005 touchscreen controller
>    hw/input: Remove tsc210x device
>    hw/rtc: Remove twl92230 device
>    hw/input: Remove lm832x device
>    hw/usb: Remove tusb6010 USB controller
>    hw/usb: Remove MUSB USB host controller

Some of these devices are user-creatable and only rely on a bus
(not a particular removed machine), so could potentially be used
on other maintained machines which expose a similar bus.
We don't have in-tree (tests/) examples, but I wonder if it is OK
to remove them without first explicitly deprecating them in
docs/about/deprecated.rst. I wouldn't surprise users when 9.2 is
release. Maybe this isn't an issue, but I prefer to mention it
now to be sure.

Regards,

Phil.

