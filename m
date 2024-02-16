Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4CBC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravK0-0007eu-2X; Fri, 16 Feb 2024 05:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ravJy-0007eQ-Ta
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:19:54 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ravJx-0000kE-Bd
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:19:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso993499f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708078792; x=1708683592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dfjzs7lUQ6pj9EbFLIycFa/Gecwa2zxP0/rG7S2nwls=;
 b=tfcMFDEFm8VHMNiHEsJJ1IlLo7QO81hxZKXmX0u2S0Us6k8szG6brEgfJh451PktBE
 7tbRlpZwIrkTQXPzsEkpJUgoZlCBBMZ1BATjbUMIMBwF/7xv3zJufbdpW3TOtzsqe9kO
 oeRG19/DydsApPz/TpBM7m8bdbnw0rRRGP907FHCyH0qFaHlMghNdmKF6Ygl+nzl+llB
 Z3u55628JXeZuJ0M1J6rWe0QEgOXLaxotmApmSrHHyVX8fnvwjIxG5QcyBF8pEYMTau6
 Jpx/oX/s/Md0jHVaHfFRgu+7ruYMqslBZCYgITwF7QdEeL/+udiVEGqyWS9UyMQTn2lA
 JD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708078792; x=1708683592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dfjzs7lUQ6pj9EbFLIycFa/Gecwa2zxP0/rG7S2nwls=;
 b=egGv57kZYuTa3vztwkD+eTpfa48zvjzkePP83I3aY0yXRB6cINGILsXzKaqt6b2W9v
 87icKaPUOwS6qizlHGmz/zuD2EqJxrbCT/MYIK1VOxSAkuF8i6M/5CqYH+k0OqK10Vkf
 fCXU4NZpNgDYN3Ehy/A7EuMfbQW43WZQNEBHFS7DDz7uP2O82piu3PE9mL+w1dFtWmIy
 8Lh9v3EwhFVDjTPQWFI3MXhrqYXEgKc39K6hooxWbE6FLr/sariaM8hgTqbbVekUR5DH
 KZ8TivAHn8p2rjTO4UFaaWmu/APNVaVTYBrP5xbqoAkNWPr7tWPwgr8t9zq1yLvpWPtg
 0/6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabwcJu7O65hW2C4ytume/DlttTMT9xa4dDKIySAhXccI2DcZvU4dP/CU6ojkYw4/pmII1qRRN1XuqtpsdcSYrlf9G7Yg=
X-Gm-Message-State: AOJu0YyoK7tgDviwSI8FsaJfVB9EGAzd/vQ7nNgUNysMSxphtYzBL0Ls
 k1h3zFN8NhMSKQj3mbvQ4YzAiJazaBVok0smx6o+8mVR1Stqynwmyk1cwih1UPQ=
X-Google-Smtp-Source: AGHT+IGZ5HrsPZTgDb8j1lcZOu631LRNvyzg654+pKaz7NL80OHMmxT6VuzfNlye/ZsiZUZJZhQVSQ==
X-Received: by 2002:adf:f8d1:0:b0:33b:2100:3a44 with SMTP id
 f17-20020adff8d1000000b0033b21003a44mr3741785wrq.39.1708078791672; 
 Fri, 16 Feb 2024 02:19:51 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a5d66d2000000b0033940016d6esm1756251wrw.93.2024.02.16.02.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 02:19:51 -0800 (PST)
Message-ID: <2b236cac-b940-4570-8a2e-2d7bf9828feb@linaro.org>
Date: Fri, 16 Feb 2024 11:19:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org
References: <20240216091621.32989-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240216091621.32989-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 16/2/24 10:16, Thomas Huth wrote:
> When running "configure" with "--without-default-devices", building
> of qemu-system-hppa currently fails with:
> 
>   /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in function `machine_HP_common_init_tail':
>   hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
>   /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to `usb_create_simple'
>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_find'
>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_create_simple'
>   collect2: error: ld returned 1 exit status
>   ninja: build stopped: subcommand failed.
>   make: *** [Makefile:162: run-ninja] Error 1
> 
> And after fixing this, the qemu-system-hppa binary refuses to run
> due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
> the right config switches to fix these problems.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Keep "select SERIAL" instead of replacing it

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


