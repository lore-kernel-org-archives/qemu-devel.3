Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44777CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOGa-0006FC-6R; Tue, 02 Sep 2025 06:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOGY-0006F2-S7
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:29:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOGW-0000nk-HK
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:29:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b84367affso27346655e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808966; x=1757413766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLAe7TfqJdgk8hDJdYnWblH9TCiuOLATdqkJeJByvhg=;
 b=yCtDMqZIYSCo4hLTbw2XCwck8q1lh6qrdxaV8+1falugv5ldZs3NqaFgBXg4saIhRL
 cm6pVOv3wAzWAzYBIW54umpB4DaNR0YkvGFZB9JQGWPWAUefmHGNacI3hX3eajrEGP2k
 OrvskX/xl5JhaAmCDC7KTBzBV9P6ESpyD+TzfFNxQVNPyNBLpDUsyW/2hxeOVwH6Z/6C
 Ucrm1eKtVph+Gbed/kIOVoUR5WEksYOLLQDghxagRsfk6k2GGjXhh3s9uyXmfdBlgzox
 I4EhljZdaIDKtMQCSO14XA1cXCEYBoOHq4Jf/leR2VRbh5EAOjyZ5o/2JGcJRcwLh1Jy
 segQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808966; x=1757413766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mLAe7TfqJdgk8hDJdYnWblH9TCiuOLATdqkJeJByvhg=;
 b=P5sdIQIRWNxilbI6lOtZbCemOAcw33U/9oYihmkG5ssuuNGYf4b8fjhbbsZBGrF/e6
 XODgdf2slClwC4jnKT8e3DW+Kq0OfUfZfyc/+0Xw+OhV3ZtMLkfJBaIRu+zBX4CMs/io
 ySSQBgMd1jOjFRoZLPdVVa7xbGMS2H4WUio2HcoN53PJ8O86hZH4dHmP9wztI2HHG/Np
 lh7Y4V2761M3tsZRnbluxBwx+EhixRE4b13Gxfr/QoeUEp/qobAIoywZyVLAdoSaq8jY
 dCa76LbnhwL/iOuwJXdDqU45rMHD7MBwf04HMLU55SlMX/Jm6G7G8LAb81qK+rK6yFIp
 uJhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Z5+03EblJc3NbXegD6LUGrznDvXyhUk/oHUUTUKkCTqVIczStiPa+ErWdsu0vNQPbufsT7MRWAaG@nongnu.org
X-Gm-Message-State: AOJu0YyQ5hlHKmiwR2EUqD/tgVTwEh22lAC4xG+LRRexjT0IuMncPxqp
 7qRmM6XipMgmGEITpKE/24c7y87YfLGic/UgA/GSjpLqJ0tKx+tLHrnZAuI5O9DbzhY=
X-Gm-Gg: ASbGncsLghixy2H7dh9fHpMB7PdP8A0zpx1JPVq8Yc17u1dSYUmMZGAmjspBrAGcAoj
 g4IWmazBTHgs4MvIsoRwfHzpOcVbrCZC/f61yDoNlQFk2nwt7Y84aPTRwK1U2cHNbn7o+mM+5Y3
 6E+HkML0DIkPALhSsdyXm2ndOaIFEgot3RfzNmdij3EIx3HxPNy7nXjFtkYy2buN5CNPsK+Dw5a
 /oEgWSq+CUbqpX++sdI2H2G+fdkKXWFO8QVOuuiipRV55cByKMPM8RnS/2LOy/pC8TJYd91dxz9
 Y3yYUSpfxhbHD4TyVvp7yNYbAyRsUjazpMYESvbV3Y4kCEvJK68Fu3dUvpFZo92XiYmTsZTUDHq
 Ty7oLhtCvqCQiLJQsCbbrseZ90gNDX9yh/XtnAWrctJJocOrCfKN4CTU7FpeCCfJIig==
X-Google-Smtp-Source: AGHT+IGzsEwZiz8pU235ZUs+wC3BI/I5uJaAS7DduyZ/Zs6vqHGCCq3jhJWhOhVXz8LAqEf5cb5VqA==
X-Received: by 2002:a05:600c:c4ac:b0:45b:76c6:cfb8 with SMTP id
 5b1f17b1804b1-45b8555c585mr95846815e9.9.1756808966172; 
 Tue, 02 Sep 2025 03:29:26 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm38055375e9.3.2025.09.02.03.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:29:25 -0700 (PDT)
Message-ID: <c5ea3aad-7574-466c-ba25-39f6f9ceae4f@linaro.org>
Date: Tue, 2 Sep 2025 12:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw: Fix qemu_init_irq() leaks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154053.2417090-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 21/8/25 17:40, Peter Maydell wrote:
> The qemu_init_irq() method initializes an IRQ object, but
> the caller is responsible for eventually freeing it by calling
> qemu_free_irq(). Generally we don't remember to do this.
> 
> Implement a harder-to-misuse API, qemu_init_irq_child().  This is to
> qemu_init_irq() what object_initialize_child() is to
> object_initialize(): it both initializes the object and makes it a
> child of the parent QOM object.  If you use this in a device's
> realize or instance_init method then the IRQ will be automatically
> freed when the device is destroyed.
> 
> Patch 1 is the new function; patches 2 and 3 are bugfixes for
> leaks that show up with ASAN in device-introspect-test (which
> does an instance_init -> deinit on every device).
> 
> The other callers of qemu_init_irq() could also be changed over
> to use this new function, but they don't cause in-practice
> leaks because they call the function in realize, and they
> are devices which are never unrealized.

There are only 4 uses left. I don't see any good reason to keep
qemu_init_irq() over qemu_init_irq_child(). Maybe better fully
remove the former by the latter?

> Peter Maydell (3):
>    hw/irq: New qemu_init_irq_child() function
>    hw/char/serial-pci-multi: Use qemu_init_irq_child() to avoid leak
>    hw/ide/ich.c: Use qemu_init_irq_child() to avoid memory leak

Series queued, thanks!

