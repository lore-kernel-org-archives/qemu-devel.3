Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041F0C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra99d-0007pX-NJ; Wed, 14 Feb 2024 01:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra99c-0007oz-HB
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:54:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra99b-0004kU-8L
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707893638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlmrBMsdz2unKlsH8bJ0Ni1feO/iQ9Lb0sgQV6Pnd6A=;
 b=S707uWF8YFqbCKkVV3lP5zkkLzHw8UyILa4/KadS1JR4AxNUwuuUa/cUdyxV4LPzzdQfjL
 3RxMuxJL0gGZXyFhX2I8tthBzZK1EtUmgJJLPsI+nfS4GoD7tgjx++9Is6MCXZVY3x8gAr
 YkzxO3KDgGa4l/Y6eHOPrTqCSZVJuc8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-shO_3N-xNy6r4K9RE9TYlA-1; Wed, 14 Feb 2024 01:53:56 -0500
X-MC-Unique: shO_3N-xNy6r4K9RE9TYlA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-410422e8cd1so29576305e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 22:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707893635; x=1708498435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlmrBMsdz2unKlsH8bJ0Ni1feO/iQ9Lb0sgQV6Pnd6A=;
 b=H/Dq37xJLAieuJOoCJrkkY+ibeWJ1EItk0PBAHZ4Kbj6otViOqx3QXAuFuEzKDSroP
 shMtYj8u7c97nH+Y9vcfyQbil+wOEal2S/gFPRr+B1fmH+sV2OA4l2FfNT68W9kV2Rnl
 o+QLJIs5WX+0piXgNMfjmOOhWylPCQfInKBlMX2KkQBveWpQCaRi6/7otVeiNP337QMP
 ANwZzIzK1lEeGPXACzgca9J9Y+Dwp7e23JX8wjA0aKCVO8TXuc/SSRVWTbxXX9eebuOp
 8g21fM3cQ+ybt0PfY1MCPfRzXF98PfJCLyajEw9rBFvcfKmZDhHrv5jUI7bzv5HL5wML
 +4Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs2VQgWwF9TUw9gYrVbSr8MBTV2ZEeLKyzBePmSDC7y7NF10TVmpHOFZ1wcu+N/3Eko6FQVNsrOy0RQuKz6NXgpqU9N6w=
X-Gm-Message-State: AOJu0Yx8vuIWxO7xhL0X6VH5k6ErNfaG47sR5U3akG6qIxWrlGqOZmey
 RMapptCgBON4+W09Q7LHLHNnZGjQKPja3NrOEM3lsR2l9RiteO15jDbqd7PqF5i/BUzczX+7/7g
 zSl2KmXOiO7cAXcPhvIYt13qyhVygOIdnBFRpSFln/6PDi8iTc1Lm
X-Received: by 2002:a05:600c:3f90:b0:411:e634:8377 with SMTP id
 fs16-20020a05600c3f9000b00411e6348377mr653055wmb.38.1707893635789; 
 Tue, 13 Feb 2024 22:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQiluGHK91IldECEQuGcCw09sGgegGyhkzEgL7UCYLVQ4ccg06zttDduT7tMnuuSY5U2GWUg==
X-Received: by 2002:a05:600c:3f90:b0:411:e634:8377 with SMTP id
 fs16-20020a05600c3f9000b00411e6348377mr653047wmb.38.1707893635446; 
 Tue, 13 Feb 2024 22:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXpJ7KNO141uSIbL/VbipYtq4oA32NjziZ4QbnT3JTQtfX8oURiQSQpsnmUPBrrnMcvmmx8mJRS0tvXzKhzvhupFngNrg9B07xtJecsH1eUZyO0ukz9FX+us3Bn3KiKZ3RlXv+nMXAjMd3uHMdBMhdBW5Au82yCMAseGxBrMFGizW6wiilk0bvIpE5nadQdq58FmtY5UFiVT7iYIgPykTHZ3KJy0MUonG7kBX8LfTLstoawEim4ZxrQFvU09z2bkuxvcm26gpjtd1u+u5thoQcces75Up4yKwoWI/AUi+qtAzYphBVSVY+KRutUejv9sJsqXq/o+Z1kl72FkcHnfrA+OG6SowMVg4EIaa0K1PmmT4rOXUGj6ziceOuJY73vHKPcyww2T3GBDGjOVP9IhkJBdK8fEo/IWEdG3g==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 h21-20020a05600c351500b00411f04e2601sm427840wmq.27.2024.02.13.22.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 22:53:54 -0800 (PST)
Date: Wed, 14 Feb 2024 01:53:51 -0500
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
Subject: Re: [PATCH v4 8/9] pcie_sriov: Do not reset NumVFs after
 unregistering VFs
Message-ID: <20240214015322-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-8-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-reuse-v4-8-89ad093a07f4@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Wed, Feb 14, 2024 at 02:13:46PM +0900, Akihiko Odaki wrote:
> I couldn't find such a behavior specified.

Is it fixing a bug or just removing unnecessary code?
Is this guest visible at all?

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/pci/pcie_sriov.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 9d668b8d6c17..410bc090fc58 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -209,7 +209,6 @@ static void unregister_vfs(PCIDevice *dev)
>          pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>      }
>      dev->exp.sriov_pf.num_vfs = 0;
> -    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
>  }
>  
>  void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> 
> -- 
> 2.43.0


