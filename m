Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF62CCD1B3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvec-0007Rg-Vz; Wed, 18 Sep 2024 10:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqvea-0007QZ-E5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqveX-0006SB-Aa
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726669651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIgVPU3TLKPEsCMv1wjFkbv85I5TqpwZPw2NbHOb//M=;
 b=btw8kzd6afAw5l62prDMoDMdyvzxZOoC9ovoqKtc1nP7z6KQTHHsYL9bWKrbh2QwpPAnWA
 069xjk3QRqiFQlIf/k1RVK1hKZjAloqAarYmh/B/L29GswyDUASuec7nlcgUGAwxLHnR3n
 R07B8m68k2yL/EBKyZ8WCSZL4/BsyH8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-8wD0HAKyPDmz02GqpUwDKA-1; Wed, 18 Sep 2024 10:27:28 -0400
X-MC-Unique: 8wD0HAKyPDmz02GqpUwDKA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cbcf60722so51512095e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 07:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726669647; x=1727274447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FIgVPU3TLKPEsCMv1wjFkbv85I5TqpwZPw2NbHOb//M=;
 b=QrC8gKItU37qmUrAicGnwDsPhH+Rn8navtdg+5Xi4730cSM7fa+VloPhPXDUPg0tOh
 iY1v7qTUGUZz04mxDWn9CnDP9UTiRbzog34W+bgSqQrTlCDGnntLTcI6I0PkLdRs+net
 q9j+ZbBFz38asWtCoImewqUFxWTNQCHjB9Xiv1kphof3KBGpcky00N9ePn0J7ynggWsG
 F70yplSVqQmPpjdHSI/b31aDNFlEJKU/swkPS03HfNIoRMKfnp1CE93lpKD2SISEoKMy
 tzrlszowW17AJGtCuOXpFWJ138XUDKJkxlX6c1l6Pm1Da78U7I+X/oTMB208SKFjLds8
 q7Zw==
X-Gm-Message-State: AOJu0YznpY6wTgub39HMtEGylzZCrOyj9OJvy1ogiggCiy0JoWEntx4N
 i2pGB9VNT/WtEXk3IkiKq/A5PwZXp2pFdgOmLRX74n7mAxqtaeLUkHa77bCDGSeCBxwH24VBY4y
 Ma22dPA9vS8wZ0mXU7osiunG5FWu6pjYhqQzu0uklg1C2nGZSa2B2
X-Received: by 2002:a05:600c:548a:b0:42c:bc60:5332 with SMTP id
 5b1f17b1804b1-42cdb54eda5mr150614525e9.19.1726669647150; 
 Wed, 18 Sep 2024 07:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFThXfqY8CNcjvealDz2b5nSaUA5TMA0zwDQapFLdvhHMpAVpWewquNcGOaTca4hTKT37rU8g==
X-Received: by 2002:a05:600c:548a:b0:42c:bc60:5332 with SMTP id
 5b1f17b1804b1-42cdb54eda5mr150614325e9.19.1726669646644; 
 Wed, 18 Sep 2024 07:27:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7053856esm18287175e9.33.2024.09.18.07.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 07:27:26 -0700 (PDT)
Message-ID: <b143662e-67a1-4edf-8bfa-cf43039989a8@redhat.com>
Date: Wed, 18 Sep 2024 16:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/13] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
 <20240913-reuse-v16-2-d016b4b4f616@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240913-reuse-v16-2-d016b4b4f616@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

Adding :

   Harsh for QEMU/PPC pseries machine,
   Shivaprasad for KVM/PPC VFIO and IOMMU support.

Could you please give us your feedback on these changes ?

Thanks,

C.

  

  On 9/13/24 05:44, Akihiko Odaki wrote:
> Disabled means it is a disabled SR-IOV VF or it is powered off, and
> hidden from the guest.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/ppc/spapr_pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7cf9904c3546..f63182a03c41 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
>           return;
>       }
>   
> +    if (!pdev->enabled) {
> +        return;
> +    }
> +
>       err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
>       if (err < 0) {
>           p->err = err;
> 


