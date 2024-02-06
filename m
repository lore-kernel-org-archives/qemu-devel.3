Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71606C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 19:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQoI-00043D-Ou; Tue, 06 Feb 2024 14:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rXQoH-00042t-3D
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rXQo5-0001Gk-PL
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707246513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPd1mMKo0lagx6F3EaQkmHtvw3TrKINmTZMcbKY9eSc=;
 b=Pao47lxF64oln15mhJC/IFPg6+G4HMe+Sontt/+b37LN9fPwM8Amy2AWZwb42wkB3OTWoA
 CETurrwgmTuBSgPUf/H6KG19FwUGGjphhJjrb8NecTlvsq9dV+rLCXWbEcSb8UiFzW2XTB
 miUhezveUBEh2pU+EUleZAWg2Plj/PU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-FVKPM4flPL6mCoin5mY5nA-1; Tue, 06 Feb 2024 14:08:31 -0500
X-MC-Unique: FVKPM4flPL6mCoin5mY5nA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a336006ef27so103773566b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 11:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707246510; x=1707851310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPd1mMKo0lagx6F3EaQkmHtvw3TrKINmTZMcbKY9eSc=;
 b=O9GnfAZ/S97jkF6+CvAZVM/sE5kFGTR2LSgDw5GUYDTC/XE/FcRptjBN9N9wadz57q
 mS6n1dG5ou1yRqja0rPLcaRM5LltualR8KzOYropxweOLRkUEmGzgA23zU3Hx2j3O/i+
 hCy8+QsZisXtGeyRhkqMcO4ZFmuJ3zhN7QOl0QTYbA1VGPHRS7P8OOL3JMXh5yDdKcSm
 FPnSogYqCQEKlTrebOTZoxMExrDwYpxf4LAIzn4k7fiB5gbASRLgvAzl7plkyDRuxtiX
 titii4z+y0253eeguC2z8AVyBzGwAApLpgJ+YvcbPEfk8us5slM5k7ESeb9sJfkrwo5w
 YG7w==
X-Gm-Message-State: AOJu0YyYu1ZnlM2La5NNjxVx/1g973Y8u9+KWc4Bq2wwJn+WmoKF2yNY
 Vbb7H79aoh+VKALLe2zNdF9EDF676J39E21eAHpziikT+mACZCAA6cuLrPsm69em8m7R7lPhdQi
 wWMNUoFsfTEOvk/o8aMTylfHLHofXeq9wKOdtptDLwDcUVWSxdHCL
X-Received: by 2002:a17:906:a849:b0:a38:51a1:14f5 with SMTP id
 dx9-20020a170906a84900b00a3851a114f5mr950601ejb.7.1707246510715; 
 Tue, 06 Feb 2024 11:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLpQGMfM4ulW30COO1C+2TqvPWDHEiWq8pcIi+tSjItxKteb0/w73pNaghXWzDvtPVGG4Vrg==
X-Received: by 2002:a17:906:a849:b0:a38:51a1:14f5 with SMTP id
 dx9-20020a170906a84900b00a3851a114f5mr950583ejb.7.1707246510432; 
 Tue, 06 Feb 2024 11:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWdritBEDF7aOtbBEQukTKJBERbXlJYGfAaiDORk/Twxca6TGGBoY8mT9NmP/IRdTnPo7ZW//81WSlbHmxcBSO1HroxEI3d1l4zcVlcB4jvbhg5h/cxiyNeCndAwewIL09Dbg+UA8YYBcQEjAv/1si5rZJ/9elmUbMOAPNAGDAFoCj0D2YJJMLTQp7+m1Z27saTafo=
Received: from redhat.com ([2.52.129.159]) by smtp.gmail.com with ESMTPSA id
 k6-20020a170906680600b00a372b8ac53fsm1451988ejr.169.2024.02.06.11.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 11:08:29 -0800 (PST)
Date: Tue, 6 Feb 2024 14:08:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/5] virtio-blk: iothread-vq-mapping cleanups
Message-ID: <20240206140815-mutt-send-email-mst@kernel.org>
References: <20240206190610.107963-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206190610.107963-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 02:06:05PM -0500, Stefan Hajnoczi wrote:
> v2:
> - Add comment in Patch 3 explaining why bounds check assertion [Manos]
> - Remove redundant nested if in Patch 1 [Hanna]
> 
> Hanna reviewed the iothread-vq-mapping patches after they were applied to
> qemu.git. This series consists of code cleanups that Hanna identified.
> 
> There are no functional changes or bug fixes that need to be backported to the
> stable tree here, but it may make sense to backport them in the future to avoid
> conflicts.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>




> Stefan Hajnoczi (5):
>   virtio-blk: enforce iothread-vq-mapping validation
>   virtio-blk: clarify that there is at least 1 virtqueue
>   virtio-blk: add vq_rq[] bounds check in virtio_blk_dma_restart_cb()
>   virtio-blk: declare VirtIOBlock::rq with a type
>   monitor: use aio_co_reschedule_self()
> 
>  include/hw/virtio/virtio-blk.h |   2 +-
>  hw/block/virtio-blk.c          | 194 ++++++++++++++++++---------------
>  qapi/qmp-dispatch.c            |   7 +-
>  3 files changed, 112 insertions(+), 91 deletions(-)
> 
> -- 
> 2.43.0


