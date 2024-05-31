Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC235C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCz2j-0002yi-Cb; Fri, 31 May 2024 05:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCz2h-0002qu-6g
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:59:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCz2f-000517-L9
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:59:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so19990995e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717149560; x=1717754360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NWtVkOLDgF1rKwf3NbyJWvRkovccoP5yn6Z5++pjXzA=;
 b=LDRgpUp8VdxwH3YtCAfTIQrV8Fa712PHt2DcjDAxPi4pzHao9lbtI/kypQL7HksYwt
 MFkS9KBZDLgPat06I9MD1aNpclFi/FqmnLAvtSKTVSH7LkMComKN+rk7/RZUKvZDBDPn
 p/vDJ/I1mh88Ux19tpMuwt3TxqzMXi+VXbGaXjU0xWmmRvv6/fvvcipVoSIu620xzaMA
 gD+kIW6389nO7ajYEZ+lSFpNAqgEOZ4h7R1lL/cyrSXEFt14RV31GEkJ4qbgcf7t5R9G
 N2GnSB/sj+KALAD2xZZMnJZL8/5jQkxcLmdWs7x78WNHP4nEZAqneEj5dke3Wb8GqCnI
 sRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149560; x=1717754360;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWtVkOLDgF1rKwf3NbyJWvRkovccoP5yn6Z5++pjXzA=;
 b=bIwoYZGFu3/suRk0hKzaIeQVHIFL3wu5kyVLm+uyACRfjNhfcZawXXfo197SRWnNs/
 5i89WfHYLVrIVa4Pp3RLO2/pcLoWuFqE9G6f4qr5XbqRvVmqfEFlOyvtTX7yeaLIZe3v
 X/AdS1wKlW3r85sybTvzlSmqlXnbAEl5zr4sZnDKKVxkmSdD9pYZHlbzajpqbDIOxzV6
 rdkkElEU3kej3R1nNWDYOly6mdTV+GdAHDUXT4wshHYqfWGd1i+mA96jaOQOXC+/b7Db
 ZTHh0nKCcmZ4FEU5DE9qmo62cZ/IYcRnee/8/pvJfSoxUhDXn+BD1narGmTeksTOHQDy
 7vTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzkiP/aNc/sAensLaNAr2C9dDY1mdCGGl+nRFz8mfPoXE+3TO9QZf93n1HM7vZbvcSEMY0sUbrlDEK8tKfF6bqd+YKNlM=
X-Gm-Message-State: AOJu0YwCLBQbuyWnafWYVbd3zi0vFhyuOpMHptpsz2U6FapEU8/y7sib
 wl+y4aBNz4iSD5Tws/gJyCvHJczaAo6tfblLdiEwpY8oGl7FN+wnsWzK324f
X-Google-Smtp-Source: AGHT+IFV51hSYt8NK9PiJAKTrsoXn7LryxkGS6g5ElhZz8ENQt9V721ZCsqMK+nfys/TO6a5gG7gkg==
X-Received: by 2002:a05:600c:4e15:b0:41f:f053:edb4 with SMTP id
 5b1f17b1804b1-4212e076511mr9570605e9.23.1717149560202; 
 Fri, 31 May 2024 02:59:20 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84ba40sm20025015e9.19.2024.05.31.02.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:59:19 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <0fe5773f-1524-4a9d-bdd8-606b18b4ced4@xen.org>
Date: Fri, 31 May 2024 10:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/xen: Register framebuffer backend via
 xen_backend_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-8-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/05/2024 11:49, Philippe Mathieu-Daudé wrote:
> Align the framebuffer backend with the other legacy ones,
> register it via xen_backend_init() when '-vga xenfb' is
> used. It is safe because MODULE_INIT_XEN_BACKEND is called
> in xen_bus_realize(), long after CLI processing initialized
> the vga_interface_type variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-legacy-backend.h | 3 ---
>   hw/display/xenfb.c                  | 9 +++++++--
>   hw/xenpv/xen_machine_pv.c           | 2 --
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


