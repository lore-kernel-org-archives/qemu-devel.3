Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CE3CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQaA-0006Ao-0G; Mon, 27 Oct 2025 13:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQa8-00069L-Iu
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:00:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQa0-0001pG-3o
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:00:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-474975af41dso34212645e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584418; x=1762189218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aathi89rtU4Qcn0jbqp4B+hZBRllDuF+Ck/DO4z+mQE=;
 b=PZlyGr3UF5omq7agnuef+mV6KYy6T9YevE9pwqGxtECqbLPIlC04jGWfUyZ4sQaG3t
 g1OTaeSgBULJd8TiqhV9WxZzSWBYjno4mL8OaDDJh8Rylv+EGhbjFPc4rjtxPEuNRMMw
 lKIRR8saycBgiA/ZFamcccJZXUclbICZ4PjOLBuDzLNBwHdBgWb2LqIONfl+LGrPg5Ev
 +71kIBEWIWIMBjPH2bQzoorflU1riyZ0puh8nUm/yH+e41+cpmwuhccaxOkufVjVJq+G
 Jibv9bExJU0WLrMgRW5J3frv7mJLbVRCimQ+phS8MyGcBLn6Ve7jBbdZU8+dCND4ny5f
 Ps1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584418; x=1762189218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aathi89rtU4Qcn0jbqp4B+hZBRllDuF+Ck/DO4z+mQE=;
 b=FyEdCWiIOxA8Us/cY/xEjtVNU/90xJpwMECbagWN4zu906vaoC9NKn5G5OrUgPxmu2
 6Pvwwtam05NxZSeVf7Smc988iZRm1JoPxOaWd5NjVxKPx+35AVLz/n1YIz2GKBKuPLCg
 zwHKDsibQE86aKJst0KsF45Z17b2gVJnqR+Id/aZM6cPyCjafDbMA4pQny+KErdh0oBd
 vHj7bRffS7GiKtcZ+3GEhS1bSqWN6WZKGmP23+AfHgtilRbEkvcBLw7iWnfmlKVBHDx0
 3VCM5t/njGf8srY/+UGa27JBvWunLLWngT5K6oPI7UW2VVNfevNVnW+Ig/6YXq53fffC
 5cig==
X-Gm-Message-State: AOJu0YyFMyHExHYh1oOrxP9IV7E/43Z8iJ9Q1AtDCeu1k4a89afbgMIm
 l2/0i8LGRbH2ptfmLvRS20O2gVm/ZwnSASg32KsjsdrawvrrVx4ULPRALVbtLkH0Zq1M/+Zrdp5
 RCV1xs2c=
X-Gm-Gg: ASbGncsN7gYQcQ/Ct41BpM7/WO4FU6zKYtjSrG1X0bxhKuXfmMiUcLemMsHy2tCBKqK
 q+/AX1DEyppz5MEHvMCIyYxLni7OvB/2/QGAKJjfQGwJtUnWFgru1ZMjIq4Yg02uQ+mbBQZFgib
 +cuSHZ+lnxoei5nDjbMQ9/Kky+7B/hAonhHehKtbUgh76QPHcZAkuOQ0i+rPM/zgJUcDPiL/LqM
 FV706ob2/EvowweOVckn+TVbGe711ThEr/M2/JD5PvQ1kNNzfPvgn2vra8tD7KYDcRg2wZ+TD7V
 +BR07faygxmw7e56AW1fDF9dx/nb/gCoqdYOpmXHdIJUkAQK+jf0/quiiEVY0wGsJG9SwfjOgrZ
 mTmYpxfssXdsoYG0UkXLP+Dr543LQ45t1BE4LGEK2U2P4TT0O0AQlhluZ4ofhJFVqy+Lf6WpF16
 mwPAVwZLAi/4aHep6N+JlPJFqLj6wyn7PjfjKzvaAz8Ue/SYNFQvLWhetXCHcZtvz9
X-Google-Smtp-Source: AGHT+IHID/an2damXvT2lLmZrkbJFT/kf+LTqdO0F61dfoUD/wxExN0eQdaJ2LySJCo0t/qB2DXj9Q==
X-Received: by 2002:a05:600c:8b83:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-47717e42293mr3211465e9.21.1761584418032; 
 Mon, 27 Oct 2025 10:00:18 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035e05sm145547525e9.7.2025.10.27.10.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 10:00:17 -0700 (PDT)
Message-ID: <b6881d44-f198-47ef-9c74-e3bb83f51660@linaro.org>
Date: Mon, 27 Oct 2025 18:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/pci-host/sabre: Re-use generic
 pci_host_data_le_ops MemoryRegionOps
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>
References: <20251027165304.98296-1-philmd@linaro.org>
 <20251027165304.98296-7-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027165304.98296-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 27/10/25 17:53, Philippe Mathieu-Daudé wrote:
> Avoid duplicating code, re-use the generic generic
> pci_host_data_le_ops MemoryRegionOps.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/sabre.c      | 34 +++-------------------------------
>   hw/pci-host/trace-events |  2 --
>   2 files changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index 669191b6c7e..eb3dbe3361f 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -246,28 +246,6 @@ static const MemoryRegionOps sabre_host_config_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> -static void sabre_pci_config_write(void *opaque, hwaddr addr,
> -                                   uint64_t val, unsigned size)
> -{
> -    SabreState *s = opaque;
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -
> -    trace_sabre_pci_config_write(addr, val);
> -    pci_data_write(phb->bus, addr, val, size);
> -}
> -
> -static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
> -                                      unsigned size)
> -{
> -    uint32_t ret;
> -    SabreState *s = opaque;
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -
> -    ret = pci_data_read(phb->bus, addr, size);

Likely incorrect, please ignore.

> -    trace_sabre_pci_config_read(addr, ret);
> -    return ret;
> -}

