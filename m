Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D94C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2BMx-0003Jc-Fh; Wed, 01 May 2024 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2BMv-0003Ih-Cv
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2BMt-0007SO-N4
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714575333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDKNmjBt2XVxNh6XjPNq7FBa91pFzJyG8q4ncdW3W6I=;
 b=KSDo5Po+HtDL2iKadHIWrDMSVzeY3SCiJpysMaMIHsQYxhms9rFyoWNzCztsOAZ7v1wjP6
 FuPF0qlpvXH4M4HTAd6kYq/ud7dWd32F50qCTbXD9Gs6RsmgT0EkVb/3zZoYG3/UsCcFU8
 51ueIEpGw4TLVnFRb8tbXq8g2i37ut8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-_Z_TPm9cNJWzIgY-L7AyFA-1; Wed, 01 May 2024 10:55:32 -0400
X-MC-Unique: _Z_TPm9cNJWzIgY-L7AyFA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a0e5402962so5037576d6.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714575331; x=1715180131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aDKNmjBt2XVxNh6XjPNq7FBa91pFzJyG8q4ncdW3W6I=;
 b=cQ7dOBRRavP/CvMHHJMXJS+ZWgpkNMdYIvAAo4QCk8rtB6yCg2ZktZ6MKQUSXS5vP+
 3srMXZRzTsZDgkVRIa06UxRouqQptJXVc/eXvHngSp2FlO7a82AHUrnMb3HbI0Z7NU9C
 u7efPT1GZU0OPuh5EpZdNyML2ueqBpMdSmi2aKmN8aQy0RqtC/atxDgiEkya7OvX6x0f
 cqSwm5TCCutkq5xP8aqNIcKN5lLIn+Hrh41f+F0F6lEoERn4Q3gjkAP/6/s27WYeICEa
 qEvOgnJnfRixRgcmhXZ/S2ICJfuUtG+3fMlnBmB7jwXFOf6Tzkzz7zNuKCrsq1COhq3W
 IiAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JrEwyXkKZiJnfPAVHese/xY9ZnNVebAK+2gmoiYz653PLvq1EJR+LV12mYxz2dAhs0MtPxnnOtNhEXL2YBkkyknz5WA=
X-Gm-Message-State: AOJu0YzyV/SHWimfC/3wJxamE8WnCLpeEJy1RUEjXfDtfCBVbUzeM9ly
 T6913ifILQMD5gGLN/tiw6RTWhjyNODQkc4bdwga6Ai86v9K0JsiXoD8GGspeNisFSL/6YsxNMN
 eHBS18eflIY3Hta9XaqtYbjGhUIgyf4IMpHVmhiMZb97MiOUMMexC
X-Received: by 2002:a05:6214:411b:b0:6a0:d5b0:11b9 with SMTP id
 kc27-20020a056214411b00b006a0d5b011b9mr2706784qvb.6.1714575331121; 
 Wed, 01 May 2024 07:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfvs3wbM8Lfs0BzBVBaf7+gNoN9gagum93m+JGroWWseGktNnlkqSZtSJ6U62VPqxrhYzAKg==
X-Received: by 2002:a05:6214:411b:b0:6a0:d5b0:11b9 with SMTP id
 kc27-20020a056214411b00b006a0d5b011b9mr2706745qvb.6.1714575330351; 
 Wed, 01 May 2024 07:55:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z15-20020a0cf00f000000b0069942e76d99sm12395014qvk.48.2024.05.01.07.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:55:29 -0700 (PDT)
Date: Wed, 1 May 2024 10:55:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 5/5] virtio-gpu: fix scanout migration post-load
Message-ID: <ZjJX3530Q5h9cHox@x1n>
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
 <20240312140216.313618-6-marcandre.lureau@redhat.com>
 <b3215169-005d-4766-ad19-3b649ff0e4c9@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3215169-005d-4766-ad19-3b649ff0e4c9@proxmox.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Tue, Apr 30, 2024 at 02:30:19PM +0200, Fiona Ebner wrote:
> Am 12.03.24 um 15:02 schrieb marcandre.lureau@redhat.com:
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > The current post-loading code for scanout has a FIXME: it doesn't take
> > the resource region/rect into account. But there is more, when adding
> > blob migration support in commit f66767f75c9, I didn't realize that blob
> > resources could be used for scanouts. This situationn leads to a crash
> > during post-load, as they don't have an associated res->image.
> > 
> > virtio_gpu_do_set_scanout() handle all cases, but requires the
> > associated virtio_gpu_framebuffer, which is currently not saved during
> > migration.
> > 
> > Add a v2 of "virtio-gpu-one-scanout" with the framebuffer fields, so we
> > can restore blob scanouts, as well as fixing the existing FIXME.
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Sebastian Ott <sebott@redhat.com>
> 
> Hi,
> unfortunately, this broke migration from pre-9.0 to 9.0:
> 
> > vmstate_load_state_field virtio-gpu:virtio-gpu
> > vmstate_load_state_field virtio-gpu-scanouts:parent_obj.enable
> > vmstate_load_state_field virtio-gpu-scanouts:parent_obj.conf.max_outputs
> > vmstate_load_state_field virtio-gpu-scanouts:parent_obj.scanout
> > vmstate_load_state_field virtio-gpu-one-scanout:resource_id
> > vmstate_load_state_field virtio-gpu-one-scanout:width
> > vmstate_load_state_field virtio-gpu-one-scanout:height
> > vmstate_load_state_field virtio-gpu-one-scanout:x
> > vmstate_load_state_field virtio-gpu-one-scanout:y
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.resource_id
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.hot_x
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.hot_y
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.pos.x
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.pos.y
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.format
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.bytes_pp
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.width
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.height
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.stride
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.offset
> > qemu-system-x86_64: Missing section footer for 0000:00:02.0/virtio-gpu
> > qemu-system-x86_64: Error -22 while loading VM state
> 
> It wrongly tries to load the fb fields even though they should be
> guarded by version 2.
> 
> Looking at it with GDB, in vmstate_load_state(), when we come to
> field->name == parent_obj.scanout, the
> 
> >                 } else if (field->flags & VMS_STRUCT) {
> >                     ret = vmstate_load_state(f, field->vmsd, curr_elem,
> >                                              field->vmsd->version_id);
> 
> branch will be taken and suddenly we'll have a call to
> vmstate_load_state() for vmsd==vmstate_virtio_gpu_scanout with
> version_id==2 rather than version_id==1, because that is
> field->vmsd->version_id (i.e. the .version_id in VMStateDescription
> vmstate_virtio_gpu_scanout).
> 
> Would it have been necessary to version the VMStateDescription
> vmstate_virtio_gpu_scanouts too using VMS_VSTRUCT (or am I
> misinterpreting the use case for that)?

Looks right.  And there's only one such user which is when it's introduced
in 2018.  It's sad we can't simply already use vmsd subsections even if
that was there before this VSTRUCT thing, and that should work with
internal versioning.  Maybe we introduced that because we can't replace a
VMS_STRUCT to subsections?

https://lore.kernel.org/qemu-devel/1524670052-28373-1-git-send-email-minyard@acm.org/#t

OTOH, I don't think vmsd versioning would work for ping-pong migrations.
Migrating backwards should fail with 'not supported' with vmsd versionings.
Depending on the requirement (in this virtio-gpu case, it looks like
applicable to be used in a cluster and doing back-and-forth moves?), we may
want to support bi-directional migrations which should be superior.  That
will need to stick with machine type check (compat fields in hw_compat_*,
then conditionally save/load fields) to guarantee migration can work back
and forth.

Thanks,

-- 
Peter Xu


