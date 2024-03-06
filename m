Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D38C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhu6v-0006Cn-3O; Wed, 06 Mar 2024 11:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhu6t-0006CR-Nb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:27:15 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhu6o-0005cn-O9
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:27:15 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a45b6fcd5e8so129793766b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709742427; x=1710347227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7e15dIZpLQgAh6CGa/cDD5YfSifUjp0dN+jEODvmCFM=;
 b=manqkOYFFRWbl6kHQFeiDRLxOCYBicwryzgb0iT0aqOC45bBzbrypbutQVE+roq8iR
 bNWD05YnxqWZWzfeZ9VmZ015vUvZW6xJ0Evicams2H7qJqLOxm5RDwZmLv5fbBoMDt7G
 Lu+PFKf45bcYqHbEanCA0Yt3ONOE2AVrcKaJpU0I3WD+6x+mXWzr9c6B3VhiGrOJhynC
 /VKwl1t0S8xO4Yf0yS7MkPpDdlOq3vF6dNQEUXcsGkBHrVBE+0lIstNKzLhYRh9HHmyn
 4JtyNFQzaDIKi/rjEeCLW06gB6rdBj8WCP4MEbOfH7hjNil3I/QsXsJW0ts1VHRv4nxW
 CzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709742427; x=1710347227;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7e15dIZpLQgAh6CGa/cDD5YfSifUjp0dN+jEODvmCFM=;
 b=WYv7m6BajAxo6XWzGIjlydirHEZ57OxoY3f5Nwng84KxrLZjWgEVSCwCsEeS7zqs37
 vzK+VABeknM0bfKTEESKpYhtJuSlJezGmv3SPyprfNbaNYE/mZ7CFvGBrm2vkkHGPZS4
 HCp3b/jb2PNsHswtxZrjRTdubuxz6mE1vleNi2WjgMDvNhcn2U8HmBkFxiVSyV1pC5lU
 XZo2alSxB7mV/B5hcN6PyZxkXfa5Jz5zYSjrcw1mtiNXEjWUltWlT4Qv5Xkw98bHpDHX
 2jDv8TdESVl2+xfLzYQbdzYTxIV9+97Llc/hm0RawEWdoZ9t4wuNogeUt9aUG8mD3fmG
 dBpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXsJNgHzGl7mEKEWKH+/nc/tvN1ycQdbhVycXkTChOjf6aycq8kvxbTB3+AseyEKUuY+OriO+qW4YKJOax/h/wJqZ7op4=
X-Gm-Message-State: AOJu0YwUJX0l3GjgSTgCPj4IQhtk86nuwXvGnlr/swcVDAwQefdILJjI
 YnVvGO6c8Tkhq6yZ5By6yvOQpuOQw6TdRrqdhIfMu7TfWZ9lms2Rluw1naAUjxPrCdtl25GjnH8
 +
X-Google-Smtp-Source: AGHT+IFht5Tqsu8boM73seYwEPOnC9mx+cH1c4lZZduryvfhX6GCvGO1C9kkaxOX+eImkbwLSk2XNA==
X-Received: by 2002:a17:907:397:b0:a3e:b188:fcf3 with SMTP id
 ss23-20020a170907039700b00a3eb188fcf3mr9708927ejb.48.1709742427446; 
 Wed, 06 Mar 2024 08:27:07 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 q18-20020a170906361200b00a45c2e93438sm414322ejb.143.2024.03.06.08.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:27:06 -0800 (PST)
Message-ID: <fc7756ff-e810-47a6-af10-93e5edaab899@linaro.org>
Date: Wed, 6 Mar 2024 17:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How do I enumerate devices connected to i2c busses on running
 QEMU?
Content-Language: en-US
To: Paz Offer <poffer@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <MW4PR12MB699791410D2714B76FE8E863A0212@MW4PR12MB6997.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <MW4PR12MB699791410D2714B76FE8E863A0212@MW4PR12MB6997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Hi Paz,

On 6/3/24 12:44, Paz Offer wrote:
> Hi,
> 
> I want to enumerate all devices connected to i2c busses in running QEMU 
> hosting Linux.
> I understand I need to use 'qom-list' and 'qom-get' in monitor mode, but 
> I did not find documentation on how to use them for specific information.

Try "info qtree":

$ qemu-system-i386 -M q35 -S -monitor stdio
(qemu) help info qtree
info qtree  -- show device tree
(qemu) info qtree
bus: main-system-bus
   type System
   dev: q35-pcihost, id ""
     bus: pcie.0
       dev: ICH9-SMB, id ""
         bus: i2c
           type i2c-bus
           dev: smbus-eeprom, id ""
             address = 87 (0x57)
           dev: smbus-eeprom, id ""
             address = 86 (0x56)
           dev: smbus-eeprom, id ""
             address = 85 (0x55)
           dev: smbus-eeprom, id ""
             address = 84 (0x54)
           dev: smbus-eeprom, id ""
             address = 83 (0x53)
           dev: smbus-eeprom, id ""
             address = 82 (0x52)
           dev: smbus-eeprom, id ""
             address = 81 (0x51)
           dev: smbus-eeprom, id ""
             address = 80 (0x50)

> 
> Thanks for any tip,
> Paz


