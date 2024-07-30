Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3EBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYl2r-0006HE-Su; Tue, 30 Jul 2024 07:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYl2q-0006GV-Ku
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYl2p-0002pN-42
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722338970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=irfX0+RsgRcA6qBUsAOv5A+2smHa4tMsV0g+wH3goyM=;
 b=Lb7KYKNSB61qXbhxfH2mMSEfob2Zwrcn1wCDwK+rTxE1MX+LIwB6XpTxP83htgRhQXMQUH
 vKjUzzIzg4Cb3Re2XBrYuEuAz3cRAXTWFYhQ6qb6aywQmD90KBhCjDjw8Mq0Q9K8j2/bd+
 BC6dUt4Bway807ihbUGx0ZsfejpYWSQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-jDpbqmHhMWaJ15spssG8lQ-1; Tue, 30 Jul 2024 07:29:27 -0400
X-MC-Unique: jDpbqmHhMWaJ15spssG8lQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52efe4c2372so5078993e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 04:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722338966; x=1722943766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irfX0+RsgRcA6qBUsAOv5A+2smHa4tMsV0g+wH3goyM=;
 b=vQ2pInIF7IBKKagguW3PxsMPoMCe7QiSzbfJxmo1MBIFVwk3rIWWmCNWAf/zCe4spT
 Kj79HUcwUgX7sqdYIp3bYN9qcs2OX53nl86YQlwpdAIRDMjfClRhXkBCr+eh3YXz2b1R
 QpqMYbd3pjdO3eG6wXeO2ExMFlru8qBb4Y3am7Qprnj51OXHa3SBMQd1EH/OyMWbPLds
 EPEow8YJpPfuYWG3nX2glYAMCXfUF+jjEJziYFN8es77zw5MFv/hBra15IIb2eZnAEaC
 OOEC7rNQWbI5B91wtESJVnaPsRe5bZjwXQwREZ2CZRyMLnnp/Nk9yq8mvtCz+kUVc+Ru
 ymWg==
X-Gm-Message-State: AOJu0YzdkXoclOHWmBFiexZWt+vXEwSipTcx0m/Z1CcwEDpYUtVYLUOs
 MJDEcsNo1myY8+jzUQhg5nIp10eCBlPgbKv1lFsAl/+XLES76K5YGfzmOmCBFvm7eAcaTJ8yibt
 rrH9bSVviUyw4yCTazQHD1vEy5b5kJLxe3nNGyHEiUlT8eDog/X9v
X-Received: by 2002:a05:6512:781:b0:52c:d9b3:2b06 with SMTP id
 2adb3069b0e04-5309b2c7a1fmr6516119e87.58.1722338966414; 
 Tue, 30 Jul 2024 04:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT0jqUaaxcj8sKHT3GrVnxmtSqOGDtNNeH8+PSXNg+nniVCI1DikFrJOAhOw1YKSt+fw1rSQ==
X-Received: by 2002:a05:6512:781:b0:52c:d9b3:2b06 with SMTP id
 2adb3069b0e04-5309b2c7a1fmr6516104e87.58.1722338965658; 
 Tue, 30 Jul 2024 04:29:25 -0700 (PDT)
Received: from redhat.com ([2.55.24.20]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af473522cfsm5835844a12.86.2024.07.30.04.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 04:29:24 -0700 (PDT)
Date: Tue, 30 Jul 2024 07:29:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH] virtio-rng: block max-bytes=0
Message-ID: <20240730072753-mutt-send-email-mst@kernel.org>
References: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
 <f6beb6d6-5434-4f85-a00b-20d662b77b36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6beb6d6-5434-4f85-a00b-20d662b77b36@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 11:07:11AM +0200, Laurent Vivier wrote:
> On 24/07/2024 12:51, Michael S. Tsirkin wrote:
> > with max-bytes set to 0, quota is 0 and so device does not work.
> > block this to avoid user confusion
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/virtio/virtio-rng.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> > index f74efffef7..7cf31da071 100644
> > --- a/hw/virtio/virtio-rng.c
> > +++ b/hw/virtio/virtio-rng.c
> > @@ -184,8 +184,9 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
> >       /* Workaround: Property parsing does not enforce unsigned integers,
> >        * So this is a hack to reject such numbers. */
> > -    if (vrng->conf.max_bytes > INT64_MAX) {
> > -        error_setg(errp, "'max-bytes' parameter must be non-negative, "
> > +    if (vrng->conf.max_bytes == 0 ||
> > +        vrng->conf.max_bytes > INT64_MAX) {
> > +        error_setg(errp, "'max-bytes' parameter must be positive, "
> >                      "and less than 2^63");
> >           return;
> >       }
> 
> Michael, do you plan to send the PR yourself? Or perhaps it can go via trivial?
> 
> Thanks,
> Laurent

I will pick it up, I do not think this is appropriate for trivial though.

-- 
MST


