Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A601C83F20
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoaY-0005Li-WD; Thu, 10 Jul 2025 06:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZoVw-0001Tj-5n
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:28:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZoVs-00024O-UA
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:28:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so479252f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752143303; x=1752748103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kz6JSasFg0h3wj7hiMCokQEZUdasqtzAx7B/VK1Oxng=;
 b=mYxR7eEhy567xYhBqY7fcb4mhLUp5psLJ1BDSnwh7xePn0X7kjXNy372QXAEPdyBd0
 bxi7xnkJMFl7KaTwep9Tj83bSDNhzrCyI4sijmqDX2jdzO/Qhyf8QwLU1t6ArCxAsucQ
 uGq70bW6PQkN9vqs2wf06H7TPf2I0UqtcgSTbbzEH27aqRO6aTom/8G8c3GJwoLebjB5
 bSCpmUggFPnvfnkSni2EqgSvfQbY4ZH4SawaQbEdqdN4B+kY2nd5xk+HWfWV7KC4JTbk
 rT5RBWefOtMtVTHIBJLG3PuRQd2wM3ThSCdmURt+q5K2JO67/3711UfuGWhbV3t1Efbm
 Vaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752143303; x=1752748103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kz6JSasFg0h3wj7hiMCokQEZUdasqtzAx7B/VK1Oxng=;
 b=pGimD55NbDm4mQfPLv73YKvym4tEIzeVe62bwmAaFvDEbzHVNbvQPSCU09zEOwK1Mm
 TD+4W0wm1QJZwEO6IajRuYbGF+f+bo1VEHVrZrf1Hxo2oX+yJaDgyNluqdopISVRFOoV
 282pCZW3lB5zZFOsyTl9b9umusYcgM/fMYnFHYoe+mtDstyNfZz7DBoo6Pr5I3BrrzD7
 puta/7nBX1BgXbK5Qgt9USza0ktQqw+IGdR7GKmycN9YkGGCGdE7NP8g2DaQQDhKy3D6
 xv+9+MSs/gk8wuv5pMpjfHXlbBIiVBXbTcKq0L3TYhvUDQoIMdlBfnmWHZEgvcVcnyWW
 C/Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQxv3Q2egnnGRybPwbGJcx5sk6jIKb9TTrvU/OqfTnWcexqd/XMieST0NlhOwfMsaBxFgRDXI3RxM+@nongnu.org
X-Gm-Message-State: AOJu0Yz6LO/fN/J7UhjR060x+I6xI1n0yrQpp9k3eOmlRUNnhwvdJtDL
 JAuvzDjM/GPI6ZWTYEEfP7v+NkK5IO2lce4Jqs2gZycJSNx9ITL1nMin5FZnfgvqzXkc7SBrhMU
 ++K4/6SI=
X-Gm-Gg: ASbGnctXeuE4KfRBGnm5l/zhnd3u87eAwHluSOqlNYpjSFMzqI+PDL50Au4NG/0kv4O
 ZlTAFV6klaFawYqVvBo7kvanF81zrxTdd2WZNkp+JsWnrX590xHCMPmFEWhnpMlIlws/pD9Eh+e
 A2Mi0p1X5ZG7KuWeozTekuF9vC3nMOzr9g/l0g5JUlPeJegdAVJqu1ePae+I/t7+tWPMl/55ebo
 +cPQgD32LYBB5fGIan8utMagqNqrx9q7o4Mr98z+LijraMjDIZFcLdgCOmLlPQ146bx9+k6c0nG
 3v/gEqwRb+/pJG9It6p1PgR7Rd1Yv1c5XI6slpkuF3HZtdWIS/n3vnjuhZDIOxyukNjEng2iTT6
 MHFdsxC6LQ3yKN98k3dQShPA2RczmRSKSncyzjCqxXYA=
X-Google-Smtp-Source: AGHT+IHhhlyR9DBlX4e4KM6kRyqP6XjUCnSeWBidBEvKkEBp4CJZS7ljBshOiJMZXLHs9Cn6NSOjYQ==
X-Received: by 2002:a05:6000:4907:b0:3b3:9c56:b825 with SMTP id
 ffacd0b85a97d-3b5e7f34e3cmr2760903f8f.22.1752143303158; 
 Thu, 10 Jul 2025 03:28:23 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537cd9sm15834665e9.26.2025.07.10.03.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:28:22 -0700 (PDT)
Message-ID: <748a2db5-503f-45ea-9507-575e764cf5f5@linaro.org>
Date: Thu, 10 Jul 2025 12:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-10-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141018.674268-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 4/7/25 16:09, Mark Cave-Ayland wrote:
> This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
> safely assume that it should never be used for the isapc machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


