Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4BC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuLF-0003G9-Cw; Wed, 06 Mar 2024 11:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhuL7-0003DR-3t
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhuL0-0002gh-3d
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709743308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V8VOOJzg7EU1rcgDZalKtXvCRPqpjoeKlonHGIvbJe0=;
 b=ILOz7FdHGd1Rw7D9fw5cbPHFCxB4fWvlhlat5QavHesW5HWyZ33FFN49fgxfLxC/SZt8WW
 MhX3itJTAkOIzyPNsRnCihzEv8eWtkSjDHl8p99GMH6uucIEEFCUt30jarzSYRiqkBnz3G
 GFdRZ/ziV/JrUB+OT1pyhKyt20iMSEU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Xa5u0vRzOkKBNppjvmowhg-1; Wed, 06 Mar 2024 11:41:47 -0500
X-MC-Unique: Xa5u0vRzOkKBNppjvmowhg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-567279be640so1600586a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709743306; x=1710348106;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8VOOJzg7EU1rcgDZalKtXvCRPqpjoeKlonHGIvbJe0=;
 b=CHoK5h7ILm7cwKxPZKWbMVJSNUqwgaVWPRLzQvVR8nUX26TbbsDQDLYqApjJH9OacW
 pYKNvIjdEz68YwoCiHaWDGmOh0Cob3/MOBqzpHjKP3pSnPIHEvR9cYyUv54x+J8/2jZp
 cXV9XDwJ0IadjDr9gMjVkKAjcmj7SQRFIg9Z1pf4yU2hXA9ycttdmOQD0jPMtMkc9lb9
 SZm4uYAVwbRIrWIhREq5waHbSsGSiw8vhjZHb6unBH0ue4rZdgf0y7XmznWs47y6jHIP
 vaitiszqpOb1+ao2fujp890DuQPyF7ShbYg5pR0Gt2EmwcKQwMPYG9Et89imOimO5qga
 KUVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK6q+HfkwgWPOlkEW4cx7K5z8aoYkhO2Lu3C5zGGGKKLYhsL8DS9p/tHe80i3ZQ2PxXhCe2qm2Df/+zLRC9MRfcN86gCs=
X-Gm-Message-State: AOJu0YwXAlohR7KRhRJ21m3HlbGpgm+6yXJRRVc6yJsNeYN+OzpHBpeu
 oEBYM/mwCl5mlNyINO5gw2jj2fYFP9tOCjE8ZqPaV4U7ha6MYRYy90ACJe8ug9m4mtiFdMbw3iO
 Zoh6/h/DZEXQ/vCZW0pF5cixsqHuuNPHrxstwrdQXALzyvQU0YtPn
X-Received: by 2002:a50:8d86:0:b0:566:825b:98 with SMTP id
 r6-20020a508d86000000b00566825b0098mr11232270edh.6.1709743306159; 
 Wed, 06 Mar 2024 08:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL4qHcVN9nkeyWoAJu9LMysctnxQMaIsiMCnnrKmreq1AJI22WOebtuymhBjq2UGu7Q7XllQ==
X-Received: by 2002:a50:8d86:0:b0:566:825b:98 with SMTP id
 r6-20020a508d86000000b00566825b0098mr11232254edh.6.1709743305859; 
 Wed, 06 Mar 2024 08:41:45 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 s12-20020a056402520c00b0056691924615sm7068330edd.2.2024.03.06.08.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:41:45 -0800 (PST)
Message-ID: <571fb716-2f13-4ad7-b47b-8104ec46d1d3@redhat.com>
Date: Wed, 6 Mar 2024 17:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 01/18] hw/i386/pc: Remove deprecated pc-i440fx-2.0
 machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240305134221.30924-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 05/03/2024 14.42, Philippe Mathieu-Daudé wrote:
> The pc-i440fx-2.0 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       |  2 +-
>   docs/about/removed-features.rst |  2 +-
>   include/hw/i386/pc.h            |  3 ---
>   hw/i386/pc.c                    | 15 -------------
>   hw/i386/pc_piix.c               | 37 ---------------------------------
>   5 files changed, 2 insertions(+), 57 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 8565644da6..6d4738ca20 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -221,7 +221,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> -``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
> +``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
>   These old machine types are quite neglected nowadays and thus might have
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 417a0e4fa1..156737989e 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -801,7 +801,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
>   
>   This machine has been renamed ``fuloong2e``.
>   
> -``pc-0.10`` up to ``pc-i440fx-1.7`` (removed in 4.0 up to 8.2)
> +``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
>   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
>   These machine types were very old and likely could not be used for live
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index b958023187..3360ca2307 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -285,9 +285,6 @@ extern const size_t pc_compat_2_2_len;
>   extern GlobalProperty pc_compat_2_1[];
>   extern const size_t pc_compat_2_1_len;
>   
> -extern GlobalProperty pc_compat_2_0[];
> -extern const size_t pc_compat_2_0_len;
> -
>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>       { \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f5ff970acf..bb7ef31af2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -311,21 +311,6 @@ GlobalProperty pc_compat_2_1[] = {
>   };
>   const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
>   
> -GlobalProperty pc_compat_2_0[] = {
> -    PC_CPU_MODEL_IDS("2.0.0")
> -    { "virtio-scsi-pci", "any_layout", "off" },
> -    { "PIIX4_PM", "memory-hotplug-support", "off" },
> -    { "apic", "version", "0x11" },
> -    { "nec-usb-xhci", "superspeed-ports-first", "off" },
> -    { "nec-usb-xhci", "force-pcie-endcap", "on" },
> -    { "pci-serial", "prog_if", "0" },
> -    { "pci-serial-2x", "prog_if", "0" },
> -    { "pci-serial-4x", "prog_if", "0" },
> -    { "virtio-net-pci", "guest_announce", "off" },
> -    { "ICH9-LPC", "memory-hotplug-support", "off" },

I think you could clean up memory-hotplug-support for the ICH9-LPC device 
now, too (in a separate patch).

For this patch here:
Reviewed-by: Thomas Huth <thuth@redhat.com>


