Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C49C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Yn-0007kW-6n; Wed, 31 Jan 2024 07:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rV9Yl-0007il-Ep
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rV9Yj-0000hG-PO
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706703556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNYcmbvDcxFkEVurHVXl1lNjrqJzXSh4YpIjX2yl2HY=;
 b=IVNzgB5mJQL4vVInMelUWyWSl9Tv+1OPLvlgi2Rp2OPDjHCAhsh1kAaKufbR7OTvWVA08t
 4NzRcpHuB6JjcvaAV6lcnlmljbsPRCcHsxmR8uYJntnuJwSdpPWdp/VA08+vXV7/jEYbBg
 daKw1G6C0/2vp1COQU0YztaO3msd7IU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-9JACTMCONm63N8tFDtVjQA-1; Wed, 31 Jan 2024 07:19:15 -0500
X-MC-Unique: 9JACTMCONm63N8tFDtVjQA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7831aaa797aso131172885a.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 04:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706703554; x=1707308354;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FNYcmbvDcxFkEVurHVXl1lNjrqJzXSh4YpIjX2yl2HY=;
 b=hDpC24404bObP+9ABJkWpLcNsqWcGFgS+0/0N9muNhx+tEgJOLdo0gsl7uCL4ZUV6E
 if+DIcJtk5EPgdGt+DOFdwKhV1bU4MT3GYCEn0Ml8AW/66GFBqt9KGbTSdNBmN8+QNyF
 SmgHEhNraFQ1hyKdKFNFpU78cTD5o8VlEumzJ1J30cDBpQ16OAj1V0dL7TGPLtxWFdVS
 858K2xDKtdsH9WtC+X1HNDG9QRXvS7iKhd0q54Bhc4nCNU/y2XBcqtpAbuFwlScNGqB8
 7bJ0QZD8Y1qMdj3ImHHE7WVlleagrl09rb19IPrFs81WpK7uJW80cWi8pBXlrVEL6qZ7
 eKlw==
X-Gm-Message-State: AOJu0YywQG4jziYrHRJ7H6K88sfRFciNwfSWACijY6zEVHa6dPzcJDkW
 JxGUMWRU2w7hGiYtoNcL85IbxJ+aX0OISAgyFDHJOPIiDa4b9txDmIkuoxCRKdDkbiiruVCYW4m
 PxNt7h1xw//YIhPs24TXyKxTAjYfpmfa2G+bRCf0pLVJG7Rj4iExD
X-Received: by 2002:a05:620a:4443:b0:785:4016:c954 with SMTP id
 w3-20020a05620a444300b007854016c954mr249310qkp.14.1706703554535; 
 Wed, 31 Jan 2024 04:19:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH37FXit2HxYvbVavxL2mHCz2bu8z5ez/7u5MJ8d/a7UoA4RlIkqzOnvjbzN00SvdeQoqKubg==
X-Received: by 2002:a05:620a:4443:b0:785:4016:c954 with SMTP id
 w3-20020a05620a444300b007854016c954mr249272qkp.14.1706703554251; 
 Wed, 31 Jan 2024 04:19:14 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 bk1-20020a05620a1a0100b0078382946fb5sm4753628qkb.29.2024.01.31.04.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 04:19:13 -0800 (PST)
Message-ID: <a71dfb65-be10-409f-87bf-fa4e71253b41@redhat.com>
Date: Wed, 31 Jan 2024 13:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 33/47] hw/m68k/q800: use qemu_find_nic_info()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao
 <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bin Meng
 <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <20240126173228.394202-1-dwmw2@infradead.org>
 <20240126173228.394202-34-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240126173228.394202-34-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/01/2024 18.25, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> If a corresponding NIC configuration was found, it will have a MAC address
> already assigned, so use that. Else, generate and assign a default one.
> 
> Using qemu_find_nic_info() is simpler than the alternative of using
> qemu_configure_nic_device() and then having to fetch the "mac" property
> as a string and convert it.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/m68k/q800.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index b80a3b6d5f..fa7683bf76 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -48,6 +48,7 @@
>   #include "hw/display/macfb.h"
>   #include "hw/block/swim.h"
>   #include "net/net.h"
> +#include "net/util.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/qtest.h"
> @@ -270,6 +271,8 @@ static void q800_machine_init(MachineState *machine)
>       BusState *adb_bus;
>       NubusBus *nubus;
>       DriveInfo *dinfo;
> +    NICInfo *nd;
> +    MACAddr mac;
>       uint8_t rng_seed[32];
>   
>       linux_boot = (kernel_filename != NULL);
> @@ -370,13 +373,6 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* MACSONIC */
>   
> -    if (nb_nics > 1) {
> -        error_report("q800 can only have one ethernet interface");
> -        exit(1);
> -    }
> -
> -    qemu_check_nic_model(&nd_table[0], "dp83932");
> -
>       /*
>        * MacSonic driver needs an Apple MAC address
>        * Valid prefix are:
> @@ -386,14 +382,21 @@ static void q800_machine_init(MachineState *machine)
>        * 08:00:07 Apple
>        * (Q800 use the last one)
>        */
> -    nd_table[0].macaddr.a[0] = 0x08;
> -    nd_table[0].macaddr.a[1] = 0x00;
> -    nd_table[0].macaddr.a[2] = 0x07;
> -
>       object_initialize_child(OBJECT(machine), "dp8393x", &m->dp8393x,
>                               TYPE_DP8393X);
>       dev = DEVICE(&m->dp8393x);
> -    qdev_set_nic_properties(dev, &nd_table[0]);
> +    nd = qemu_find_nic_info(TYPE_DP8393X, true, "dp83932");
> +    if (nd) {
> +        qdev_set_nic_properties(dev, nd);
> +        memcpy(mac.a, nd->macaddr.a, sizeof(mac.a));
> +    } else {
> +        qemu_macaddr_default_if_unset(&mac);
> +    }
> +    mac.a[0] = 0x08;
> +    mac.a[1] = 0x00;
> +    mac.a[2] = 0x07;

Don't we have to change nd->macaddr.a[0 to 2] with this hard-coded 
MAC-prefix, too?

  Thomas

> +    qdev_prop_set_macaddr(dev, "mac", mac.a);
> +
>       qdev_prop_set_uint8(dev, "it_shift", 2);
>       qdev_prop_set_bit(dev, "big_endian", true);
>       object_property_set_link(OBJECT(dev), "dma_mr",
> @@ -414,7 +417,7 @@ static void q800_machine_init(MachineState *machine)
>       prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
>       checksum = 0;
>       for (i = 0; i < 6; i++) {
> -        prom[i] = revbit8(nd_table[0].macaddr.a[i]);
> +        prom[i] = revbit8(mac.a[i]);
>           checksum ^= prom[i];
>       }
>       prom[7] = 0xff - checksum;


