Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52110C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOe1t-0006ZD-3H; Tue, 02 Jul 2024 09:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOe1r-0006YK-2x
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOe1p-0000Sp-FB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719928719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fAUdLMIG+WEYcVO/YEI86Qif/UezPCMX6O1sgII+ks=;
 b=LxFmSzfdjdKqztmN6yYd1+8SEaq3AXrP+IN01mW6ngYMYLDaEWsaPCdzd9zjb7y9vUwJQi
 QTc1V8JW+PRQZtFasLODbvZLHIKbnTgjRjUyPWm7nc8fPUEESJuTL5+/Xe+Y8fTaNlE88b
 NhmSGh6+G6qGWwCHSWky341zK32pbIU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-IwVgXkdGOSuSThtvvbPTSQ-1; Tue, 02 Jul 2024 09:58:34 -0400
X-MC-Unique: IwVgXkdGOSuSThtvvbPTSQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a706f279c56so273382666b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 06:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719928713; x=1720533513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fAUdLMIG+WEYcVO/YEI86Qif/UezPCMX6O1sgII+ks=;
 b=OOZg+vFo09fWkSAHInmzjisQuikYME+4kiwy6AapM7U5nRjCwfKZ9eB/tJWv5w04OS
 ggYa7F5N3eE2o9dXG/GhNmrVjWtoIQo+5sMhpf+vjki6H1c5CodSqSwTNZeuw8ovYABy
 P+I2m5k81J00aIOb3kqhiewuHCsgtY0HTpZUc82mXbz8+rnSvOmUIZXkZaYFyiOIxGZ6
 I13HWDFzoxZhUGSljDaU9khpCESl0uTt2dWUNDQxyuLaqrRZZNlWjzGiZrsUVjkmXwtQ
 n2jYKcInHvYdgYWa7alb5wi2YgNmQTlp0E/r+dTuGSB7n3O2cjfOLivYx2zI1x5/H5Ty
 XvSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOtjHGELLShwFAh0qi9UAXX/VOipoWiUGTNJXYJomVPH2F41VScrOSgB0eR9ae0JZBItHyx4iwqLGLNAzCRVbkJbPbndk=
X-Gm-Message-State: AOJu0Yww9FDkw9uWJOXSzGlAFHrLnj/mVSVA086VP6KDbLmE0gz6CW0U
 2gSLU+oxPR8/sqlP6R7EQG3N3wbbFoFR/otUQcqyYEZZmaQkpWAlTyyCopfd49Zkoy004xq7tJa
 THSJ+iIoh+4tpk+/IMR6+E1m+BNVxjB4+DpFs7H8AnTvW6ySU5xCy
X-Received: by 2002:a17:907:868c:b0:a72:84c9:cedc with SMTP id
 a640c23a62f3a-a7514419960mr779560866b.8.1719928713340; 
 Tue, 02 Jul 2024 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETprv4dvavQ+IXkpfNH54MlMAogH3FShzOqgrRvKbBdVbBNjKy+Sg2VQheJqNOUpbmlekBdA==
X-Received: by 2002:a17:907:868c:b0:a72:84c9:cedc with SMTP id
 a640c23a62f3a-a7514419960mr779557266b.8.1719928712590; 
 Tue, 02 Jul 2024 06:58:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b7dcfsm424777566b.209.2024.07.02.06.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:58:31 -0700 (PDT)
Date: Tue, 2 Jul 2024 09:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v10 11/12] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <20240702095426-mutt-send-email-mst@kernel.org>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-11-7ca0b8ed3d9f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-reuse-v10-11-7ca0b8ed3d9f@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 03:08:00PM +0900, Akihiko Odaki wrote:
> rom_bar is tristate but was defined as uint32_t so convert it into
> OnOffAuto.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Commit log should explain why this is an improvement,
not just what's done.


> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index e17bb50789ad..35c6c8e28493 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
>        ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
>        PCI address 1f.0.
>      * The IGD device must have a VGA ROM, either provided via the romfile
> -      option or loaded automatically through vfio (standard).  rombar=0
> +      option or loaded automatically through vfio (standard).  rombar=off
>        will disable legacy mode support.
>      * Hotplug of the IGD device is not supported.
>      * The IGD device must be a SandyBridge or newer model device.

...

> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 39dae72497e0..0e920ed0691a 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -33,7 +33,7 @@
>   * execution as noticed with the BCM 57810 card for lack of a
>   * more better way to handle such issues.
>   * The  user can still override by specifying a romfile or
> - * rombar=1.
> + * rombar=on.
>   * Please see https://bugs.launchpad.net/qemu/+bug/1284874
>   * for an analysis of the 57810 card hang. When adding
>   * a new vendor id/device id combination below, please also add


So we are apparently breaking a bunch of users who followed
documentation to the dot. Why is this a good idea?


-- 
MST


