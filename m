Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25013C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 00:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3Gl-0002rX-CD; Mon, 22 Jul 2024 20:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sW3Gi-0002qp-1R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sW3Gd-0000gl-ST
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721694033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IDWc/d7nncXUPkfXNVMX4RyT95orJUOO1z4lWmuviBg=;
 b=gsboBADCEyiUUqjaZBDvYA21WQBiWMURCqYNaSLWljdlL5OA+WEgPDfgY/qdW7gWKUD3xi
 ETyp2Lqk1ZYCOeCdVoM0AkIvEvHQ7br7BKOW6iJDtAgO/jdsf6EVYkBODWRxdKkM55E9xe
 tCqYSTxDYHB91AVhP5CzFcBKk4ucxLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-q075c4a-PGm15po8xfoaVQ-1; Mon, 22 Jul 2024 20:20:28 -0400
X-MC-Unique: q075c4a-PGm15po8xfoaVQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426679bc120so32932055e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 17:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721694027; x=1722298827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDWc/d7nncXUPkfXNVMX4RyT95orJUOO1z4lWmuviBg=;
 b=wkjQ+KbE4Ya2AXarsrCw0Jl4CdOwzHY7Q0tuSdjbHcaMiR2ljXmxziEsGmY8Sv0PCM
 G//25nLuHIQJ/+Y1PV4r8q5Az5N2D6YWgDQ2tz8GdpvMq4a17GlFwlyhBS43Wrtq8JsK
 jA22ejnd6Kl3zBk/P2qfHLaMgkMHzKIu2dHi7VMLMXlYMRNZja6uXXTApWgAXhVTetaT
 zOrfkfKfgsZwyAJcER/bzsTu5a/C1p+NJI52d5e6sQdfG+ZBifx6Vrq9bJSb5Rzmm8ay
 8vVKj3b5/MM+otOvlzyGH1kpDr8gbCKY9qPTzSUPRa1gJpEBgMW77b3pGZfPxgVNG3vA
 SxCg==
X-Gm-Message-State: AOJu0Yxsi7ncfOM9KrsMPJdqdkLM8kn+GGvhsOZZ12kR3gmk+hJ3USuD
 gM0FWkFh5fnJTbhes0lg3xDWDOI0wXX/jXs8UQeLP41JKg5BEPbQD9R/fDHkhSFn+4j8oEhD3IN
 133QN7Ip2gZs0MyzX2SSdrxfzoLRNZW1PkWvNYHaP9EEJXSU2YVAm
X-Received: by 2002:a05:600c:358d:b0:426:6353:4b7c with SMTP id
 5b1f17b1804b1-427ed918ae7mr8417575e9.8.1721694026899; 
 Mon, 22 Jul 2024 17:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt+ii/4X0QeYiYZOD4XMdpCWE0TbIaKFPPbORI5TWdQAHTC+vfxHvfYiN0yjyNjhWzStgjrA==
X-Received: by 2002:a05:600c:358d:b0:426:6353:4b7c with SMTP id
 5b1f17b1804b1-427ed918ae7mr8417435e9.8.1721694026335; 
 Mon, 22 Jul 2024 17:20:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5415:9d1e:913c:6f61:614e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878694833sm9820812f8f.55.2024.07.22.17.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 17:20:25 -0700 (PDT)
Date: Mon, 22 Jul 2024 20:20:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
Message-ID: <20240722201719-mutt-send-email-mst@kernel.org>
References: <cover.1721607331.git.mst@redhat.com>
 <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Tue, Jul 23, 2024 at 07:32:56AM +1000, Richard Henderson wrote:
> On 7/22/24 10:16, Michael S. Tsirkin wrote:
> > A couple of fixes are outstanding, will merge later.
> > 
> > 
> > The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:
> > 
> >    Merge tag 'pull-loongarch-20240719' ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to 67d834362c55d6fca6504975bc34755606f17cf2:
> > 
> >    virtio: Always reset vhost devices (2024-07-21 14:45:56 -0400)
> > 
> > ----------------------------------------------------------------
> > virtio,pci,pc: features,fixes
> > 
> > pci: Initial support for SPDM Responders
> > cxl: Add support for scan media, feature commands, device patrol scrub
> >      control, DDR5 ECS control, firmware updates
> > virtio: in-order support
> > virtio-net: support for SR-IOV emulation (note: known issues on s390,
> >                                            might get reverted if not fixed)
> > smbios: memory device size is now configurable per Machine
> > cpu: architecture agnostic code to support vCPU Hotplug
> > 
> > Fixes, cleanups all over the place.
> > 
> > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> 
> Fails ubsan testing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7397450714
> 
> ../publish/hw/net/virtio-net.c:3895:18: runtime error: member access within
> null pointer of type 'struct vhost_net'
> 
> 
> r~

Thanks! this is just make check under ubsan build, right?


