Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251EAC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZqN-0006Ls-57; Mon, 10 Mar 2025 05:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trZqB-0006DD-GE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trZq9-0003Un-MR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741600469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knUqcaUFd6QoC5rFeKVCnBaBdtVopmXb8aUPjfInEHo=;
 b=BoL2AzL8cMctzD5ZtCSLi4ZIwpAN1eXRoqd85vSW7jngylA/5Njil4Rs/BcUmiKMKPWxZL
 tbAoNq7fJDt2spi5sjLH+Nm1P8o8+dLTwLUCsVAtExiH4vB3eZara+cX/h/WbaYxolMY3m
 KcXynJuLmRx0jcxXjfQB3lua2wsoxpk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-c9iwqCdsPDqUijZpldipNA-1; Mon, 10 Mar 2025 05:54:27 -0400
X-MC-Unique: c9iwqCdsPDqUijZpldipNA-1
X-Mimecast-MFC-AGG-ID: c9iwqCdsPDqUijZpldipNA_1741600466
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so6728485e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741600466; x=1742205266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knUqcaUFd6QoC5rFeKVCnBaBdtVopmXb8aUPjfInEHo=;
 b=HOn1s/ogar+dK44pnGAEtXwcvkHwr0D63atiich6tgQPj8xFN7MShk0HuO3c/wk/Ls
 0F6jcXOeEy+1qRkVdadDnrc/bYObZT/L266gUdMrVZqqlK3MwSKUHSktoAk+UKZ5YSse
 KBAgVgOTuywtvKC8a23neBoy1z/D25rFitQPqEy/afVzPCld9CC1cyIVp56KznKeHO2F
 StNqFirAPDAF/uBhNY4aWnXb6az/RYIWc2DmgkclMWndqcPq4WG70C4eHG/aVNjlex+l
 GiPEMua0mkBY6Yw27swngK4erhUWHoE4nLk6Ra4jx0Rm1TimuVpegeCvozKdH1nlP5EN
 wFEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK2NzIyAd7jMYIp52/AmM6LMsQNG56AtqPD7oNET327C+QuQAybzO/QpPjzM15N+SLmeDaQ+NPRQQM@nongnu.org
X-Gm-Message-State: AOJu0YwbCKbFMFVv9Sitlhsb2T/ACxZrOVUllrUDh/nltSEbaDWjzJLY
 mUWzvzcaDENE5roY8ux4BhXz+ykFpKmu1RMnhAb9zD/MJWCezaK3lAAgCRSBuzrdaeBkmK2XW8m
 8At1hE3HT0XP1WcBgL0gsYfgCioCFhFz4i0fUZfV5Lt2Ag53ykiIB
X-Gm-Gg: ASbGnctrbu9WmzlexluICuU6vrW5sm0dpyQdzZTvUyJ9mk7Gz6ob4FV+l5RzrOLQX5l
 SnxiGKw1DYNnlfNpcyUWhhAOEAI79YS+VSjzAtv4H6zcCYUTj5L+0tbZwVKpXr0Exq1CFuoPz8T
 rXO552ym2xvMdysTwUxxPT3EWh8Gt94MXgkjE4EaVAs8DeCUuGWJ1nx8RNbraONW0qFEscZQl0z
 6GfwlLjfLlhgUDX58PVH8rYfOwM//LQ7AJsX6EBRCSkf9OJYnYQT5IDbY6tWMn12hq72ddo2Dq9
 7YrIw10Ro2eH0pytcUryVbXo8wwIDNO/c8DrPbwZOjt47ywxD1H6EIESeW27TWQ=
X-Received: by 2002:a05:600c:3baa:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43ce7a7b0a6mr31777905e9.26.1741600466341; 
 Mon, 10 Mar 2025 02:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeOhaEVjxlboWMIMPA3Ze452+5QA5jZVNgwyGxbj5odwB+nFwSMjdsqE16kkqGB+0ELecQzQ==
X-Received: by 2002:a05:600c:3baa:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43ce7a7b0a6mr31777715e9.26.1741600465895; 
 Mon, 10 Mar 2025 02:54:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7ae4sm13985560f8f.5.2025.03.10.02.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 02:54:24 -0700 (PDT)
Message-ID: <4b864eac-04e3-4d03-a3a0-ee75f9072963@redhat.com>
Date: Mon, 10 Mar 2025 10:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/21] hw/vfio/igd: Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-12-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE once to help
> following where the QOM type is used in the code.
> We'll use it once more in the next commit.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/pci-quirks.h | 2 ++
>  hw/vfio/igd.c        | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
> index d1532e379b1..fdaa81f00aa 100644
> --- a/hw/vfio/pci-quirks.h
> +++ b/hw/vfio/pci-quirks.h
> @@ -69,4 +69,6 @@ typedef struct VFIOConfigMirrorQuirk {
>  
>  extern const MemoryRegionOps vfio_generic_mirror_quirk;
>  
> +#define TYPE_VFIO_PCI_IGD_LPC_BRIDGE "vfio-pci-igd-lpc-bridge"
> +
>  #endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index b1a237edd66..1fd3c4ef1d0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -262,7 +262,7 @@ static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
> -    .name = "vfio-pci-igd-lpc-bridge",
> +    .name = TYPE_VFIO_PCI_IGD_LPC_BRIDGE,
>      .parent = TYPE_PCI_DEVICE,
>      .class_init = vfio_pci_igd_lpc_bridge_class_init,
>      .interfaces = (InterfaceInfo[]) {
> @@ -524,7 +524,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
>                                   0, PCI_DEVFN(0x1f, 0));
>      if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
> -                                           "vfio-pci-igd-lpc-bridge")) {
> +                                           TYPE_VFIO_PCI_IGD_LPC_BRIDGE)) {
>          error_report("IGD device %s cannot support legacy mode due to existing "
>                       "devices at address 1f.0", vdev->vbasedev.name);
>          return;


