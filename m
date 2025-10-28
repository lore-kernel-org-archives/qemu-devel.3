Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28316CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd8J-0000kV-Ds; Tue, 28 Oct 2025 02:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd8F-0000d9-TQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd8B-0000eG-C0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761632670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmJ4DdX3KJyM0AXtrAMV6SkuVa0vW97LQJz3GfQfRyA=;
 b=Ffua5f5V3G5GFK7/3/aKAwoGq8n0TvxVqz+mV4qvx+jWehyoUSnJZ7TJH4vPBcYC3tbD2F
 zMgtM+aEab3rsRnFjR+tRvu5U/V3fsaCHwdPn+GCgvsrXU95QSPuXAcvfrzsw93loOBeWs
 L4tAv4RBKJJ3FE629t0oYeyx6EMFcgY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-Up4nE-eZO1alzP7pULGf5A-1; Tue, 28 Oct 2025 02:24:28 -0400
X-MC-Unique: Up4nE-eZO1alzP7pULGf5A-1
X-Mimecast-MFC-AGG-ID: Up4nE-eZO1alzP7pULGf5A_1761632667
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290c07feb72so44648515ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632667; x=1762237467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmJ4DdX3KJyM0AXtrAMV6SkuVa0vW97LQJz3GfQfRyA=;
 b=rXskF0E6ZXqSkfBE7q/bq3N/cw49nFVg1Jz/JkUIAiUYKShuF3CI5yXQd/r9jWpzMn
 +caJRHOrFD5BA5q5ImkVtoUVZSYQYNcOTqCwkBX5t/xK5DDz7wRb1QXZ4EFN5eA7+aZe
 T7Ch/H409JvCxay8lZZ0R+3/M6yQ5m5LLXkHzeQ5UtJeicAAIjQBZrQR06WzvOrsKt3W
 BH4VFS+UQKIpV3v9lB+AOhTBsnhChVLGOv4xy4zBmDHLxGGl0BySQumyadkE0kujR9Ix
 b/HrFczrWZTpsQO0vhj/ptT/V67gQrEDgVKIhgNIi4tlSrjG73LPLs0Zwb3epSU2BAWT
 VcJg==
X-Gm-Message-State: AOJu0YwvUQFEZPQfx9BlZwQl5Pi+cFHxx3i1ZSIEvm90GZxIwgjea2Z7
 0D8od9BQOpmzfVR+VCsnKZIqJw461MYsdvZ9rIhhElE1mXnd50D05Z7wUnTcMnhjSrEEuDIdJEW
 VsXkzdNBhNDfmPr4U9yDOvuBE+96hJh82uFr1s9CYbzYaRURa/7Yor4SF
X-Gm-Gg: ASbGncuX2fEuVNbF+z9GoLHSRHcsGMNWv4TJqGm1ipv3U6A1sNgVYblonxiM19KsvlJ
 MldartbsQBDxMRs8F90Pb86zDD+Ub+HPJa+xYxm6CBI0V3xzZamTdCD7dqR8QnW9iGquitKw2kT
 L1h6+eBVl6N83ikAxwV2768UQLzLyuiisFkzlRP66q91BRbqmvFiLCGVFkIOlxmxW/DbMa1ZaoG
 P+As/Xz0JONA7Pgiyh2d9rgSbpqn+sYhmw0ueG09fMybv7CMiRXqe2HH1GZcgdhO7+GLtHrYjxO
 dRZ+csIsaHsQS+jBEJeXNyizXVmaTcVJyF1Dw+uYuKBnYcPThN4O3SpyE9QVH0VWZpA3dD3jVKj
 2X+0X9m5pxMFc
X-Received: by 2002:a17:902:d4c3:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-294cb39d89cmr30826225ad.19.1761632667057; 
 Mon, 27 Oct 2025 23:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErL8dQU7aG7YDmNzO6AFC7Nl7t2cW7h5AGeTEcvHY5W2fNIpmUY13tDIKRNp4MT+cur7A7gA==
X-Received: by 2002:a17:902:d4c3:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-294cb39d89cmr30825955ad.19.1761632666634; 
 Mon, 27 Oct 2025 23:24:26 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d274aasm102564135ad.56.2025.10.27.23.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 23:24:26 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:54:14 +0530
From: Arun Menon <armenon@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] migration: Fix regression of passing error_fatal into
 vmstate_load_state()
Message-ID: <aQBhjlwixHZ4Ut1m@armenon-kvm.bengluru.csb>
References: <20251024-solve_error_fatal_regression-v1-1-d26e6cbd0a7e@redhat.com>
 <87v7k0twwt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7k0twwt.fsf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Cornelia,

On Mon, Oct 27, 2025 at 12:18:58PM +0100, Cornelia Huck wrote:
> On Fri, Oct 24 2025, Arun Menon <armenon@redhat.com> wrote:
> 
> > error_fatal is passed to vmstate_load_state() and vmstate_save_state()
> > functions. This was introduced in commit c632ffbd74. This would exit(1)
> > on error, and therefore does not allow to propagate the error back to
> > the caller.
> >
> > To maintain consistency with prior error handling i.e. either propagating
> > the error to the caller or reporting it, we must set the error within a
> > local Error object instead of using error_fatal.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  hw/display/virtio-gpu.c | 20 ++++++++++++++------
> >  hw/pci/pci.c            | 13 +++++++++++--
> >  hw/s390x/virtio-ccw.c   | 15 +++++++++++++--
> >  hw/scsi/spapr_vscsi.c   |  9 +++++++--
> >  hw/virtio/virtio-mmio.c | 15 +++++++++++++--
> >  hw/virtio/virtio-pci.c  | 15 +++++++++++++--
> >  hw/virtio/virtio.c      | 10 +++++++---
> >  7 files changed, 78 insertions(+), 19 deletions(-)
> >
> 
> (...)
> 
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index 4cb1ced001ae241c53c503ebfd7c90e336799c37..41c7d62a482de3c618e71dd07c0cd23e1bcd5578 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -1130,13 +1130,24 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
> >  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> >  {
> >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > -    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
> > +    int ret;
> > +    Error *local_err = NULL;
> > +    ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
> > +    if (ret < 0) {
> > +        error_report_err(local_err);
> > +    }
> >  }
> >  
> >  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> >  {
> >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> > +    int ret;
> > +    Error *local_err = NULL;
> > +    ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
> > +    if (ret < 0) {
> > +        error_report_err(local_err);
> > +    }
> > +    return ret;
> >  }
> >  
> >  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> 
> I was wondering whether it would make sense to pass the error object in
> VirtioBusClass's ->{load,save}_config instead, but it seems virtio-ccw
> is the only one using that pattern there (virtio-mmio and virtio-pci are
> doing that dance in their ->{load,save}_extra_state callbacks); so let's
> just do it this way and think about more error object passing later.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thank you for the review.

> 

Regards,
Arun


