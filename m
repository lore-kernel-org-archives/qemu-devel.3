Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6DDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtxZ-0001IJ-6C; Thu, 25 Jul 2024 04:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtxX-0001GU-Fj
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtxV-0001sE-Q8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721896580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tWnW0XCTZKI3/y6YIY6d8s5cJtA8AMjjJcAqpazU78=;
 b=A12IwJjjvbNkfCFEttqvAdeWnlBlX3SEFumRQrXrx/8bpQnZgd0ZuPIAhtHegjRyyRdzjx
 LVEWqxQ8jegwPB/JPLjWmc86yBKCZb5EhU4dMZlfYecfR5fuYiSBVrWNhv54MEg+3/RoAA
 Hk+thBVlJFEwEnf7X0PgvshY8/CeUP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-XdnQnGNFMGi0do38ctdz9Q-1; Thu, 25 Jul 2024 04:36:18 -0400
X-MC-Unique: XdnQnGNFMGi0do38ctdz9Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso4642305e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 01:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721896575; x=1722501375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tWnW0XCTZKI3/y6YIY6d8s5cJtA8AMjjJcAqpazU78=;
 b=qLg6dSIKS+A/+DHYywcBSbZAWtZZN/gOSVRch5Q2nLkBhzP0ZPZH5ArD+pteQlsyzF
 i6i75BxFgsUIwhulyBAYpnklx6qd5SShzJusIjgSCexPJe5JHTcp1jWA2NQpyY4Nd+Hg
 2DfomAnYO9ISIpMJdMtmDElcTqqpY6Etg+n16hdZomh9NqCh0tTjxKrtKnPG92u+jh7L
 GrXROugcpC5dvmIwcMGk2+c9IcL8EW+NDFANzEojpo+2qN9G03DJFrlj5kg3NBkpWNdb
 okoqbCo2Ve0lDdHKnKNejjUOSeyaVowEji368yz5UDa0N9MRtzbyFGp7qVgcRBFnuyCN
 tOuA==
X-Gm-Message-State: AOJu0Yynn7b/tUhjS7VIquUWNd/EETD5/JshyW/bbeZ/cA7SIEIs8xSV
 efGzJmZkA/VXRPTHPxJUHw2rGTFdT5nmnS+Q51//tHDlgfpemma+YaF7e0Ts/J0vQu0UV/b1vSK
 9zDEPBTwK3VTL5zHhcwQYlyqtx024xuhIrdD9iq6pdzhL+cogXYuwqIlCFejcvVxojgUkZdA4Wy
 8/qjIcrYrQu0y7Eh/ovW3DvYMgVf10ZbeUyZwk
X-Received: by 2002:a05:600c:4f8f:b0:426:51ce:bb14 with SMTP id
 5b1f17b1804b1-4280550c64dmr9446875e9.30.1721896575613; 
 Thu, 25 Jul 2024 01:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+rE0tZzs9pWDskbJIXgPgxi3T00rA4xUy6RQKi51KRWO4VLbkfFlLRAmVcyRNTLceaJ3csw==
X-Received: by 2002:a05:600c:4f8f:b0:426:51ce:bb14 with SMTP id
 5b1f17b1804b1-4280550c64dmr9446645e9.30.1721896575053; 
 Thu, 25 Jul 2024 01:36:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc624sm1352926f8f.57.2024.07.25.01.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:36:14 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:36:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Yao Xingtao via <qemu-devel@nongnu.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Subject: Re: [PATCH v3] pci-bridge: avoid linking a single downstream port
 more than once
Message-ID: <20240725103614.43875165@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240725032731.13032-1-yaoxt.fnst@fujitsu.com>
References: <20240725032731.13032-1-yaoxt.fnst@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 24 Jul 2024 23:27:31 -0400
Yao Xingtao via <qemu-devel@nongnu.org> wrote:

> Since the downstream port is not checked, two slots can be linked to
> a single port. However, this can prevent the driver from detecting the
> device properly.
> 
> It is necessary to ensure that a downstream port is not linked more than
> once.
> 
> Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> ---
> V2[2] -> V3:
>  - Move this check into pcie_cap_init()
> 
> V1[1] -> V2:
>  - Move downstream port check forward
> 
> [1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
> [2] https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fujitsu.com
> ---
>  hw/pci/pcie.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6e0..aa154ec4b054 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
>  
>      assert(pci_is_express(dev));
>  
> +    if (pci_is_express_downstream_port(dev) &&
> +        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
> +        pos = -EBUSY;
> +        error_setg(errp, "Can't link port, error %d", pos);
perhaps, also mention what's wrong and suggest user how to fix mis-configuration

> +        return pos;
> +    }
> +
>      pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
>                               PCI_EXP_VER2_SIZEOF, errp);
>      if (pos < 0) {


