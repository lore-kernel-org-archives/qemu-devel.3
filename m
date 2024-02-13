Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB478C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqOu-00089Z-H3; Tue, 13 Feb 2024 05:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqOs-000892-SC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:52:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqOq-0004ql-Ly
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707821547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4O4DrrRry27HKAvcwhEGA3zHh4rSgrAW/aC/iyCw18=;
 b=a4wi0ZOO/OVSIHM9P+4agsy/GE0864d/9H1GkXeuoSbtVInVU3rRC7kFsA5cqNtCUddynN
 4nb/jZR1YpFV8Obkb0KFwZlev1e7RFfM54Tta//Z+rdUQOnFARuX1Odw3IGndiA11fyFcD
 QZL1LnjJUPQTvOmPiRSb00vPh3Xn8KM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-Q89OrV_vNMusCsujrZ9wDg-1; Tue, 13 Feb 2024 05:52:25 -0500
X-MC-Unique: Q89OrV_vNMusCsujrZ9wDg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2f1d0c3389so272064566b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707821544; x=1708426344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4O4DrrRry27HKAvcwhEGA3zHh4rSgrAW/aC/iyCw18=;
 b=j2rs/5vhw2ivNLnGjwldlxIwu9J6H8cHoBu771PY4yNzPtuAaFwltcPHTulIF+2SB0
 +R485tarMpwHXw0dAC40ryJhge/uq3p2pkfex2d0nRuptM0fBJf6Nplqz8/Pjr+MGIyg
 MA3YfHMtsypOyMbRPug3nK4ikUzU6b7Jy9PmuRlSA/4S51Hfsm277GJx2fQ9vgZE/p7d
 Tyt/tdBf++F7TCwxgry6U86Ym3NVpfeDnAxVh4c7VL//kIiI0NypnY3XjrZLI4ZsJRqz
 9egkLCD0d1Mg9pZL7/YmWKf7Or/jmhUSSmpC09Ghk+PvxzRjFLlczemPmBawpg3v3/YQ
 CnDA==
X-Gm-Message-State: AOJu0YyV1fn4FzSVSTGWKmW0pkmnC8Us8pnhGzgoGUCRRbu6LJVYjlg+
 DTVRcFq26MaDKSGbCNSL4Thwi2D+dIL5a/aoQqej/l0kYlXPn6R5pAbR/ExSbkqhs/04GJCIDJf
 FruTNpBKP38kTyt30iwVE48rJ3ebtSpMeRRSiGVILhMsHAOwdMmvr
X-Received: by 2002:a17:906:138b:b0:a3c:c75e:df60 with SMTP id
 f11-20020a170906138b00b00a3cc75edf60mr3317247ejc.14.1707821544653; 
 Tue, 13 Feb 2024 02:52:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/pxelvaI98n+jBGV7eqnKev8P/nCUpkGKW9OSqBEuICVLLS0aJCszD1ELmb+XjK2aFZfWKA==
X-Received: by 2002:a17:906:138b:b0:a3c:c75e:df60 with SMTP id
 f11-20020a170906138b00b00a3cc75edf60mr3317234ejc.14.1707821544273; 
 Tue, 13 Feb 2024 02:52:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUuAYoo8aaSNnMFyZcu/9VcwWRXUtWiNFW+5UdJT4vwYP5nFCdISVCHheExinKC5VvzEz8ZvAaTH2ych5C4IPEtHKHY82lLbk93yaB0tiMANuzVlkFx9QnUo6tcTC6/8C8egma2VBWm5RE74z5aiGOUJYJBBrqx+rxivsB4cuULvJ1r2cUQD2KeCbriLHJvFiJuS5Aj9jDCRQNX0oodEzLPnymENjumN7MCzOS2EpgIUTlD3EDiJznVohvjxFVg5dpwh/4E4wDqCK16PVOH8lpHs1jdh00xuiXo7IzejJPRVyTN1HILjdFb9nBNy39q06CkqnSHWWvAv9Wb9WiJ/yctvl1hEnXrnNnfphqMUSHS7B1jdqry9qv7NQOasB1W/dyF+YD+H6SS7bdTaSkv01yVSGb2ZH6J2bhMxw==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 g18-20020a170906199200b00a3d16494636sm201745ejd.75.2024.02.13.02.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:52:23 -0800 (PST)
Date: Tue, 13 Feb 2024 05:52:11 -0500
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
Subject: Re: [PATCH v3 2/7] hw/pci: Determine if rombar is explicitly enabled
Message-ID: <20240213055006-mutt-send-email-mst@kernel.org>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-2-8017b689ce7f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-reuse-v3-2-8017b689ce7f@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On Mon, Feb 12, 2024 at 07:20:30PM +0900, Akihiko Odaki wrote:
> vfio determines if rombar is explicitly enabled by inspecting QDict.
> Inspecting QDict is not nice because QDict is untyped and depends on the
> details on the external interface. Add an infrastructure to determine if
> rombar is explicitly enabled to hw/pci.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/pci/pci_device.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b273..7564e9536dbd 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>      return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>  }
>  
> +static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
> +{
> +    return dev->rom_bar > 0;
> +}
> +

I don't get it. rom_bar is uint32_t if it's set to "-1" is is still >0.

How was this patchset tested?


>  uint16_t pci_requester_id(PCIDevice *dev);
>  
>  /* DMA access functions */
> 
> -- 
> 2.43.0


