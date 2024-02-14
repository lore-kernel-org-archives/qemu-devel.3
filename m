Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E1AC4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra98W-00078d-7X; Wed, 14 Feb 2024 01:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra98U-00078D-Ks
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra98T-0004Zl-9a
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707893568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y3kAxDY63lrLkqUjIa0lfJbeC7ma0135aPiV67YAc6w=;
 b=Rdv2trWWftOgn5/wntmssC7vHbKyrfkPd7hz53CiuBUXBoCchXxfJ3ZWpZXXa21a3+SLXQ
 YPiUA3nQQjLQ7KePZPoLdpfPoEnqDkyE8LruGAJKw0Bu8XPqlvMaocyYNxOIZR60vOWX/C
 sQgxgbSWOcSeUCPvpkGMQzEYyMqNG24=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-VKuL06uFMXy3yErEFlwJhA-1; Wed, 14 Feb 2024 01:52:45 -0500
X-MC-Unique: VKuL06uFMXy3yErEFlwJhA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso32500925e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 22:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707893564; x=1708498364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3kAxDY63lrLkqUjIa0lfJbeC7ma0135aPiV67YAc6w=;
 b=RQfd05GWFiGsgY72DDGkhr08ATuZafd7bl5xhW5n1rMAkGTiOaVL1Y1q0YcfFwMKsA
 kTk/H5IYVPDvhlSZYMkd8XJ8i/Cb86bfpQP0hQXv/Fg4uWSUyW8zrKtZjCaaVpvsa86Z
 zcs70Abx1OSWYbTAI9jJ30LolpYQH2c1h2v6V8JbbDEPpIjyu8bt5fKXTMB1KHFfebOS
 MvKtZr0RYbliFTB4zqa80JACffTh5lmOCwYRxJt8lm6DQ7lGpi0aW0lpCywBAOXTwq+7
 8BGdGCa5BDxV9aK2m1TVGIs6vwpS/rKOgBIwrqDke1zRQwieS7rG8qHzep3W7LO52iYG
 Qbcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWinpc6rah5IFbzKQqfMGXOY96j03SZ28JzFQu6cUVeTYQKGXQ+/cmE6B14zPiNUBPMaQHgtWtHeGJSNv67Su6bZezsZKE=
X-Gm-Message-State: AOJu0YxAOnd4phdcqCO0EVXZ+mXt7nDa5rFB1Y6xUf/fivnRakBrXCQt
 e14JwDkayNWU84yvJ5HpvL0TFrX/F1lCPO7qEvPANOihQF7qmuN4Wm0r85HSfpFNvKnDnAvX2yg
 Af3kg2vkRX/atyVa2uG2RnYQ7rEyahqIlEi7z7QriXWLqWmG1R4MQ
X-Received: by 2002:a05:600c:4f46:b0:411:d253:55dd with SMTP id
 m6-20020a05600c4f4600b00411d25355ddmr1370401wmq.8.1707893564094; 
 Tue, 13 Feb 2024 22:52:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJeESxbJy17miYJXqqlFAfWn1VMSBwQQQOLekF5EmKEjjMK/5fUuOnLt5EnywM+rmO/oJbsg==
X-Received: by 2002:a05:600c:4f46:b0:411:d253:55dd with SMTP id
 m6-20020a05600c4f4600b00411d25355ddmr1370388wmq.8.1707893563750; 
 Tue, 13 Feb 2024 22:52:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXdsYIpt71qD8spH/0AdR+HH5JOwBkhqaqCEyrTU0H1AoojV1dbdaoI/0nKGg0RAnsmdpH9t0g66QpFExT15T91TyBN/w+kRDH0Xu/uCGtTMuus1ayquLTKWAxeFqhsmCatWeEP0lyc1dme6BaN0JuoYIWhCr15lXzFFibrnLLZGu+rSgewIbWKK4xjY6yPwcrJhMagdaCGByS5BZOv1MoQA7GKzbM+CnNMB424mnFbJaQ20BBshNk5YojwyY281gGBMAC3X/69UZm0rX5CDh/uZnhRrXWvYqxXDs0SFElzIMVGcknR6Qg1XBPmIT6zJrfEJ+um9vINyetcehwh48X0Fs2IrxV5gmxTFgBWkuNn+3eTgTv4qfSZrQPXxdMZVzhiT//SIrvMu/MvyzEMZ1+3wqq5cVPiNsbcrQ==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ch16-20020a5d5d10000000b0033b58cbf3ebsm11509336wrb.26.2024.02.13.22.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 22:52:43 -0800 (PST)
Date: Wed, 14 Feb 2024 01:52:39 -0500
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
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
Message-ID: <20240214015107-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 14, 2024 at 02:13:43PM +0900, Akihiko Odaki wrote:
> The guest may write NumVFs greater than TotalVFs and that can lead
> to buffer overflow in VF implementations.
> 
> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/pci/pcie_sriov.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index a1fe65f5d801..da209b7f47fd 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
>  
>      assert(sriov_cap > 0);
>      num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> +    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
> +        return;
> +    }


yes but with your change PCI_SRIOV_NUM_VF no longer reflects the
number of registered VFs and that might lead to uninitialized
data read which is not better :(.

How about just forcing the PCI_SRIOV_NUM_VF register to be
below PCI_SRIOV_TOTAL_VF at all times?

>      dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
>  
> 
> -- 
> 2.43.0


