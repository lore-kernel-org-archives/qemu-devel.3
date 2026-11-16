Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF199606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJ46xkcL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT46u-000423-0i; Mon, 16 Nov 2026 16:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1xT46s-00041r-A0
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:19:30 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1xT46q-00035D-Rg
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:19:30 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D74FF41804;
 Mon, 16 Nov 2026 21:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19F01F000C4;
 Mon, 16 Nov 2026 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794863965;
 bh=r+aIJPrcv/6jqNiqvoDZbj0ty6chj9nLzftqu/jVFF8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=lJ46xkcLMEGO0f5T0uxLO4DA/YmS9sR1nrlVFW8glYqiwpgaSA7k8j+vrq6BWa9iZ
 uTYiRqok1/JliQsEAcIGEgMjn0l6bU9yeoUyna3CtRDhuDuWgHIHbtePzJErc9L6Nf
 6xp9g0yaa94sphClL5PDusJeVTlhm4v+WRFkafBFQVz5yN/isCzQ5wp2QyO0PpgZt2
 6/EaialiKpr1dfnq1E3A34fOM5t9cK8F/gZWYhd03HheR5STZpb8q0Nf+T34a4L+5j
 GG5IxbOarzhVbil2fr5MR2HqpPSFGNyDk2G+oqiFhMikOnpzAhvo4BEYJjoDH9yUWN
 Rt3pzVjakVt1Q==
Date: Mon, 16 Nov 2026 13:19:20 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
To: Julian Vetter <julian.vetter@vates.tech>
cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, qemu-devel@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] hw/xen: Mark legacy Xen backends as hotpluggable
In-Reply-To: <1794814281.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f@vates.tech>
Message-ID: <552c4efb-3108-1259-9aa1-acc404b6bed7@kernel.org>
References: <20261116-qemu-xen-usb-v1-1-bff36d5b646b@nxp.com>
 <1794814281.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f@vates.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026, Julian Vetter wrote:
> On 11/16/26 03:56, Peng Fan (OSS) wrote:
> 
> > diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> > index 7977b527127..bf4396c9460 100644
> > --- a/hw/xen/xen-legacy-backend.c
> > +++ b/hw/xen/xen-legacy-backend.c
> > @@ -640,6 +640,13 @@ static void xendev_class_init(ObjectClass *klass, const void *data)
> >       DeviceClass *dc = DEVICE_CLASS(klass);
> >   
> >       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    /*
> > +     * Legacy Xen backends are created and destroyed dynamically from
> > +     * xenstore at runtime, after the machine has been initialized.
> > +     * TYPE_DYNAMIC_SYS_BUS_DEVICE marks devices as not hotpluggable,
> > +     * so override that here.
> > +     */
> > +    dc->hotpluggable = true;
> >       dc->bus_type = TYPE_XENSYSBUS;
> >   }
> >   
> 
> This also fixes the legacy vfb/vkbd backends with -machine xenpv 
> (qemu-system-i386 -xen-attach -machine xenpv -vga xenfb) on an arm64 Xen 
> 4.21 host. Without this fix QEMU exits with "Device 'xen-backend' does 
> not support hotplugging" as soon as the backends are created from 
> xenstore. Tested on top of QEMU 10.1.0 with an arm64 Debian 13 guest 
> (xen-fbfront/xen-kbdfront).
> 
> Tested-by: Julian Vetter <julian.vetter@vates.tech>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

