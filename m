Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FB3C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH3Q-0002uL-VM; Thu, 04 Jul 2024 03:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPH39-0002l2-Br
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 03:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPH37-0001fE-Ly
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 03:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720078717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WupVS4jy2yd83kCNqab5/4/svLeaqZHFOnO70w+d1Ck=;
 b=Ttw6pm13WihCmxEcOw+weWq1qzXsD5nozfnjq9V0Vhqt3RwDrQtAXnGpHuTdbs3zEybw+F
 IgMbJYHKkiQTCMpfdxwLCp8R8CVB6i1aLHOOBVZsNe2paM+uy3tgta7lGDog3A6cHrlihO
 xUbFWzO0kkSVmFXaS9f5mo/tE0E2cEw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-M_DswJHoMcO5Q4QHzBxedg-1; Thu, 04 Jul 2024 03:38:32 -0400
X-MC-Unique: M_DswJHoMcO5Q4QHzBxedg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec61a87db0so3331741fa.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 00:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078711; x=1720683511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WupVS4jy2yd83kCNqab5/4/svLeaqZHFOnO70w+d1Ck=;
 b=tgSX7JSYrHN+mMtOuBiqk8GiQT6de726UDYsA3lQBM1kmf1yDXjTefZYUf+b/idpnb
 wq4IDt4qV8Siuc6p8EbiyqicIe3Ev94Og/jgTb5CBsa45ZnMxVcOiCueBcZWSWrEmAEQ
 EYphM/SPbmOXSSAwjbWe3q2Nei9RVkaicEGn73xlEn3D8w7lq3J2n4CxFsnbHqG3MxsW
 YRtiGC5XTEyRI7PO4Y2CcNwZTjtPVuNl9wMj2vUdV3hbo/Hu175bX3zQTgtuFXGjtIAX
 o96k0ItiU0KIlGpTGEa9LY9uAPGvbblcOB18a6gExWrVnPU8j1eMwe2KbxwwgBBLfNCz
 MmkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN49mJBeMZgs/NhSLo43knMIgJhB8GO+NhAC5HsWlRLqX8pEocmroaD8GAJfgePeCGV/eXOYxgUxv1spUJeUFZAdjc6N4=
X-Gm-Message-State: AOJu0YyD/8C7DzM94GkKVdrr884LsRE15rhH3MRLYw6udwMMkCycTC6b
 rz7fo9Xf7mFmfZy/XmEeZolZLJCQbag9wUWgoapKNh8qGGaqAFzdQFqBa4GgkXJjVY9UE1ymjIR
 Si/AcIGpZVPF9ubGxFZ63/SeDtshRri7O9l3T/hNF34FPiMUURkmb
X-Received: by 2002:a05:651c:11c5:b0:2ee:8701:787e with SMTP id
 38308e7fff4ca-2ee8ed62fb2mr5246561fa.1.1720078710952; 
 Thu, 04 Jul 2024 00:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9rCY8skyMXuoUo7+q6ETzr+91+TodOELQECjpIg3JE8+Z/Zz9/lJvsjE6I2UsuvxWb2BS0A==
X-Received: by 2002:a05:651c:11c5:b0:2ee:8701:787e with SMTP id
 38308e7fff4ca-2ee8ed62fb2mr5245881fa.1.1720078708264; 
 Thu, 04 Jul 2024 00:38:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:82e2:c2d2:c800:4b76:dc98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cc59sm12582415e9.25.2024.07.04.00.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:38:27 -0700 (PDT)
Date: Thu, 4 Jul 2024 03:38:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Krasheninnikov <krashmisha@gmail.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio: Implement Virtio Backend for SD/MMC in QEMU
Message-ID: <20240704033637-mutt-send-email-mst@kernel.org>
References: <20240703145956.16193-1-krashmisha@gmail.com>
 <87le2ipigb.fsf@draig.linaro.org>
 <7c281582-e5a3-265b-f6fc-80f7a1f01078@gmail.com>
 <20240703160451-mutt-send-email-mst@kernel.org>
 <e0e1e2bd-a230-a460-79b2-dd9318e7c92e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e1e2bd-a230-a460-79b2-dd9318e7c92e@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Jul 04, 2024 at 10:25:53AM +0300, Mikhail Krasheninnikov wrote:
> 
> On Wed, 3 Jul 2024, Michael S. Tsirkin wrote:
> 
> > On Wed, Jul 03, 2024 at 10:55:17PM +0300, Mikhail Krasheninnikov wrote:
> > > 
> > > Hello, Alex!
> > > 
> > > No, there's no patch to the VirtIO specification yet. This is 
> > > proof-of-concept solution since I'm not sure that I did everything 
> > > correct with the design (and as folks' reviews show, for a good reason). 
> > > As soon as most obvious issues would be out of the way, I think I'll 
> > > submit a patch.
> > 
> > 
> > Mikhail, if you want people to review your patches but not merge
> > them yet, pls use an RFC tag in the subject to avoid confusion.
> > 
> > Thanks,
> > 
> > -- 
> > MST
> > 
> > 
> 
> Hello, Michael!
> 
> I was planning to submit three patches: to the kernel, emulator and Virtio 
> specification around the same time - as soon as the obvious bugs are 
> fixed, I'll submit a patch to the specification. I thought it wasn't 
> necessary to use the RFC tag in that case, but if you think it is, 
> I'll include it with the next version of the patch.

RFC means "this is proof of concept". On the one hand some people
won't bother reviewing then. On the other your patch will be
judged less harshly. If your code still has debugging printks,
it's clearly an RFC at best.

-- 
MST


