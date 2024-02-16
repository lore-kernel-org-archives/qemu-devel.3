Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E28C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravG3-00062R-D1; Fri, 16 Feb 2024 05:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ravG2-00062G-3A
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ravFs-0008Ik-NP
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708078539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TNDKd5Jznj5auueSmqVcM+enXa+3BTkREqBc+DxwTRI=;
 b=Mbd7tC5KH0ljWWQGC7yegsNjmxU2PxRK9nXlLoPxmKmTAGkxUWPD/otyRawEHK1va1bL6i
 DN7ee0vXPF4FbDqOMR1/Ndch0aNa+hUjgBekjHuL8dlQY2huRSdy0VE9nnfdGunSz/13Aa
 NFiZ4uC21qv7TzaDnl8aj0mRH/FTrTA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ztfNmZOSPkyJ8YfSGE6WRQ-1; Fri, 16 Feb 2024 05:15:37 -0500
X-MC-Unique: ztfNmZOSPkyJ8YfSGE6WRQ-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4c01afaee2cso812492e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 02:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708078537; x=1708683337;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNDKd5Jznj5auueSmqVcM+enXa+3BTkREqBc+DxwTRI=;
 b=LDPaOYNDWrm+hsYcYusyWTeciru/hGXFCZrPftojHXpw/ZUNiDQKtwIHn9DEFRpKGg
 s4RaK8j4rL3s2RZ0gXqrC5LGVc8AJiNFwqbSAxsJp8+Mrhe7e/hO5hcuzn1Thlo0bj6u
 bmJU31gyEJtN6LZdSFwKjP/2YIgKrIWVjIM2PDy89a74egfuC1kvpJP4p4Lp9sh+4pfh
 4yJ1JJj+QzKnf1W8GTqlVOpUJCBGyocJt68CQybz2bbUbc92XixeooasdC5anw/MO50e
 l9fhNfOcG//KrmqmMLVNXdx/qUrYyoj7lbbB7fN3ygcZe9hK6ZiOwoWXz0ABC0vLFlWj
 9O+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFWrZqwQ6r1hzmwalzb/Dcn+m4j31O3FO6KZ+YnFUvoxlUW6ATD+SuNqLCPTMPO4dfwN5pCSTdP9kwWqTfPdO2ZE4z5dw=
X-Gm-Message-State: AOJu0YzxiddJG0UWb7dzFrApqlzK6LYxK6CxlMo2oNziotWf3L1AbJ4w
 qlP96Jaq1DtJONjWIrpQcFFejskKbXCz+y4NnTT3JSwdX+FcSirEJPEc9k44R8RFJRlvYkJymYh
 4NPW5iCTLrIFq1sOjLkiAFHdo8nfEPe1S4O534uk8hRSJJjPhYXVx
X-Received: by 2002:a1f:ec83:0:b0:4c0:2cff:9d7a with SMTP id
 k125-20020a1fec83000000b004c02cff9d7amr4540261vkh.5.1708078536264; 
 Fri, 16 Feb 2024 02:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGejeccPhDOYSs8jaQ3daGBtGvKqAxO8YBXuLcXhlhQc+CHLEudcWY0TNHeOyY2bTqia8jPaQ==
X-Received: by 2002:a1f:ec83:0:b0:4c0:2cff:9d7a with SMTP id
 k125-20020a1fec83000000b004c02cff9d7amr4540230vkh.5.1708078535364; 
 Fri, 16 Feb 2024 02:15:35 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 z11-20020a0ce60b000000b0068ceaf5d835sm1610379qvm.16.2024.02.16.02.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 02:15:34 -0800 (PST)
Message-ID: <09ec9481-3f80-4625-8a2a-7db3a6947344@redhat.com>
Date: Fri, 16 Feb 2024 11:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/ppc: Document running Linux on AmigaNG
 machines
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, clg@kaod.org
References: <20240216001019.69A524E601F@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240216001019.69A524E601F@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 16/02/2024 01.10, BALATON Zoltan wrote:
> Documentation on how to run Linux on the amigaone, pegasos2 and
> sam460ex machines is currently burried in the depths of the qemu-devel

s/burried/buried/

> mailing list and in the source code. Let's collect the information in
> the QEMU handbook for a one stop solution.
> 
> Co-authored-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Supersedes: <20231216123013.67978-1-shentey@gmail.com>
> 
>   MAINTAINERS                 |   1 +
>   docs/system/ppc/amigang.rst | 160 ++++++++++++++++++++++++++++++++++++
>   docs/system/target-ppc.rst  |   1 +
>   3 files changed, 162 insertions(+)
>   create mode 100644 docs/system/ppc/amigang.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24c2b51b6..8e5b47e7b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1560,6 +1560,7 @@ F: hw/rtc/m41t80.c
>   F: pc-bios/canyonlands.dt[sb]
>   F: pc-bios/u-boot-sam460ex-20100605.bin
>   F: roms/u-boot-sam460ex
> +F: docs/system/ppc/amigang.rst
>   
>   pegasos2
>   M: BALATON Zoltan <balaton@eik.bme.hu>
> diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
> new file mode 100644
> index 0000000000..c03a7e0d66
> --- /dev/null
> +++ b/docs/system/ppc/amigang.rst
> @@ -0,0 +1,160 @@
> +AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
> +=========================================================
> +
> +These PowerPC machines emulate boards that are primarily used for
> +running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
> +also run Linux which is what this section documents.
> +
> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
> +===============================================

Wouldn't it be better to use a subsection here (i.e. "----" instead of 
"====") ? And also adjust the subsections below to subsubsections?

> +
> +The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
> +which is a rebranded Mai Logic Teron board with modified U-Boot
> +firmware to support AmigaOS 4.
> +
> +Emulated devices
> +----------------
> +
> + * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``)
> + * Articia S north bridge
> + * VIA VT82C686B south bridge
> + * PCI VGA compatible card (guests may need other card instead)
> + * PS/2 keyboard and mouse
> +
> +Firmware
> +--------
> +
> +A firmware binary is necessary for the boot process. It is a modified
> +U-Boot under GPL but its source is lost so it cannot be included in
> +QEMU. A binary is available at
> +https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28.
> +The ROM image is in the last 512kB which can be extracted with the
> +following command:
> +
> +.. code-block:: bash
> +
> +  $ tail -c 524288 updater.image > u-boot-amigaone.bin
> +
> +The BIOS emulator in the firmware is unable to run QEMU‘s standard
> +vgabios so ``VGABIOS-lgpl-latest.bin`` is needed instead which can be
> +downloaded from http://www.nongnu.org/vgabios.
> +
> +Running Linux
> +-------------
> +
> +There are some Linux images under the following link that work on the
> +``amigaone`` machine:
> +https://sourceforge.net/projects/amigaone-linux/files/debian-installer/.
> +To boot the system run:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone.bin \
> +                    -cdrom "A1 Linux Net Installer.iso" \
> +                    -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
> +
> +From the firmware menu that appears select ``Boot sequence`` →
> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
> +``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
> +hit escape once more and from the exit menu that appears select either
> +``Save settings and exit`` or ``Use settings for this session only``. It may
> +take a long time loading the kernel into memory but eventually it boots and the
> +installer becomes visible. The ``ati-vga`` RV100 emulation is not
> +complete yet so only frame buffer works, DRM and 3D is not available.
...

  Thomas


