Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A83C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 17:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbkvx-0002ib-L1; Sun, 18 Feb 2024 12:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rbkvv-0002hm-OF
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 12:26:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rbkvu-00016C-48
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 12:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708277187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIKDUPe8anBYWiF2GwAVkIFNMsLY0saGcbkzcrRRG3A=;
 b=KKQujkREXxUn1TcTaYnjqeFUloaILW97e7f1ieG/nkC3yffDu1TSedP18MOSwsPpms/Rui
 nIqCw0EBhwcEM7HZxJEQkisYH2wY4zAmfsRL0dYHtalPtEvDGunLEkqZW1CCI/me1slEiy
 LPW13j3z9RlAz+Fyp+Ktu1JpjHa3fjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-aFUE2aLuOVOP9q3Zaltkmg-1; Sun, 18 Feb 2024 12:26:26 -0500
X-MC-Unique: aFUE2aLuOVOP9q3Zaltkmg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4107469e8adso23282065e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 09:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708277185; x=1708881985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIKDUPe8anBYWiF2GwAVkIFNMsLY0saGcbkzcrRRG3A=;
 b=XFUTnbk32GPwZPWtRFJh1qc3i6wFxUZfQpP3q9DZluBuXbjpYcbIO3lXRTE2tvL9yf
 qgv2UxWzbw7+0a3zTpP4R1xv/t6FNSXdL5UhvqRBVUvCb8u/fW1k4Vj2a1BGmNZnlGTc
 /T7myhk+dfz4Riy4wNpigjC6YVhWBP8WjlXx9A3rwxkYyZ7TAlfrF4aRtcFyLmj4Q5/5
 dma72UgM2MszGpwbai5l+mOQNtQm761wuAgt9cxx7+3BVVAevxYcU9FObBeD47Kh3Db3
 ZU2nbM+k2Nd7wgYMV0m+JKz/R80dJyKrEvJPOYCPUoCxEQ76CLGGvrEdp8V6Zw6lWTJE
 htBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX40RUssHtIqsYDew4RwDWLLYSZNaymNZmcpmwVrwsee3SxwZ4MqZo6Te2sqVqVkfkXi7SvDxNABCBeinT/+Enm6aVRQS4=
X-Gm-Message-State: AOJu0Ywy/5Ppga5kigeyjAHVTr+zKEPY0u/uaBIDyQv9sVvlFcAKc9D2
 lIK41DpqkxWLLgyKxUF+TORP2ml8YxGTbyhIDJ3IvgEOcD0IWgtxmNAlJMuFOZUWfHp3COHM9sJ
 fJ1e0ko7RxQGhRHzfh8FERnOhb86x0536N21aqikc9CgfFfmU+9g9
X-Received: by 2002:a05:600c:4f0d:b0:410:7428:1fb5 with SMTP id
 l13-20020a05600c4f0d00b0041074281fb5mr7670402wmq.27.1708277184970; 
 Sun, 18 Feb 2024 09:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjyPbCSNdnCpg2iDR+6Ei5NMFk191+f9SnzL/Iqabyq43rEQA1o2g8gXFCZ9XGjtisab6QzQ==
X-Received: by 2002:a05:600c:4f0d:b0:410:7428:1fb5 with SMTP id
 l13-20020a05600c4f0d00b0041074281fb5mr7670381wmq.27.1708277184577; 
 Sun, 18 Feb 2024 09:26:24 -0800 (PST)
Received: from redhat.com ([2.52.19.211]) by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0033cdbe335bcsm7860788wrm.71.2024.02.18.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 09:26:23 -0800 (PST)
Date: Sun, 18 Feb 2024 12:26:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v5 05/11] vfio: Avoid inspecting option QDict for rombar
Message-ID: <20240218122530-mutt-send-email-mst@kernel.org>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
 <20240218-reuse-v5-5-e4fc1c19b5a9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-reuse-v5-5-e4fc1c19b5a9@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Feb 18, 2024 at 01:56:10PM +0900, Akihiko Odaki wrote:
> Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
> enabled.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


I see little point in all this reworks: QDict lookups are
robust. But if Alex wants this change, I won't oppose it.
Alex?

> ---
>  hw/vfio/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa387f0430d..647f15b2a060 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>  {
>      uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
>      off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
> -    DeviceState *dev = DEVICE(vdev);
>      char *name;
>      int fd = vdev->vbasedev.fd;
>  
> @@ -1046,7 +1045,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>      }
>  
>      if (vfio_opt_rom_in_denylist(vdev)) {
> -        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
> +        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
>              warn_report("Device at %s is known to cause system instability"
>                          " issues during option rom execution",
>                          vdev->vbasedev.name);
> 
> -- 
> 2.43.1


