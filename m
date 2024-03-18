Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FB1C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8LC-00074E-6G; Mon, 18 Mar 2024 04:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rm8LA-00073w-0W
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rm8L7-0005Os-A4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710750443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnLpjykGS5Hn0jKQbYvXy8JIlp3tqQsy4OEEWvAFYJY=;
 b=UW+AjRESlzBtQC9ZK6CwMAx0qxMBfnOa2CtjdGag4adJkMphhG9W31f2VOBbtuezK3LIMS
 4l+LqJQ5/Poj1OSBkyf/mHGSPt2ezYOKyBdVRxy47EGN9nHo06o+a1lmuH7ibEcM8rJR/7
 eY9QDu/440g1I676Qx0Ncvtwet1aiVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-0NL8KRTyOjib1jzNURlKVA-1; Mon, 18 Mar 2024 04:27:21 -0400
X-MC-Unique: 0NL8KRTyOjib1jzNURlKVA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-414058eef24so10652975e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710750440; x=1711355240;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnLpjykGS5Hn0jKQbYvXy8JIlp3tqQsy4OEEWvAFYJY=;
 b=OYNECv31Yh6DVMr3FVaNdqiCNePd0Tze6jmXxnYZzCBhSSDMxUhite7rqv0gluRJsZ
 ezQb5YAD5rREYkj9MxkC8awmZ8esjsW76PPE32ihlNo1exUTpHkzYw0axEohcClnpN7V
 fLU4PtIe+VAU+b0AR+GqKcQmF7I2tHkcfCdXqK6QrRxmpqYF7e9CQFxwpybpQA+RL89f
 nHp6mn2ATr9un2ggLuSa1qVQhR7kKfwVXApZ/jOh9eF1Md2uol9bCHhtoKuPjetDkgHl
 Nnsdj9PfmwhvEnWHnpe9xW6EQ0riIWfxTOPFMItl6pSNg8quP6LUwt8Nohtpb72OnjZq
 ENSQ==
X-Gm-Message-State: AOJu0Ywf0lf1MCus8HmGXTKxLGwt28a1Sfz5TW7+EZCglMvrHxTA5CP5
 nWX5zaF1gLmaRraVAv5xkolKLW9RBQxHL7OS4xx6CWf2YJvtXsqaRivrmq6Zk0hv6NIuM2B1nFl
 pI1WIx6qhAnqtgQXyYRkoiy7vJtdC3LPgzAf3mvIYkmeT/YpVZYuL
X-Received: by 2002:a05:600c:524c:b0:414:cd1:e46d with SMTP id
 fc12-20020a05600c524c00b004140cd1e46dmr2363750wmb.23.1710750440520; 
 Mon, 18 Mar 2024 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXswg1bfr3RTrv0LRWauMJ9hJHh7I/TxvFvr8qkQI9e+ExzqpozS6x8E1ZwZ9iQhBkPPqTdA==
X-Received: by 2002:a05:600c:524c:b0:414:cd1:e46d with SMTP id
 fc12-20020a05600c524c00b004140cd1e46dmr2363732wmb.23.1710750440153; 
 Mon, 18 Mar 2024 01:27:20 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 fb4-20020a05600c520400b004132901d73asm13961147wmb.46.2024.03.18.01.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 01:27:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:27:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lulu@redhat.com, 
 kwolf@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
Message-ID: <uofjifqnl57vxigv4ebplfk4menefsgplnvvbprisubkywujbw@273bn7kc5hjg>
References: <20240207092702.25242-1-sgarzare@redhat.com>
 <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
 <uufps7n6otfwygiszepy76ltohvsqqo45rwyc6axja3isebda2@mn4rjbji66qt>
 <CACGkMEt-z3YCh81M2yxnCa9PjLpR8qQ8rLQ5rRCMP6=m9yKpFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt-z3YCh81M2yxnCa9PjLpR8qQ8rLQ5rRCMP6=m9yKpFw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 18, 2024 at 12:31:59PM +0800, Jason Wang wrote:
>On Fri, Mar 15, 2024 at 4:23 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Mar 14, 2024 at 11:17:01AM +0800, Jason Wang wrote:
>> >On Wed, Feb 7, 2024 at 5:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
>> >> patch [1] will be merged, it may fail with more chance if
>> >> userspace does not activate virtqueues before DRIVER_OK when
>> >> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
>> >
>> >I wonder what happens if we just leave it as is.
>>
>> Are you referring to this patch or the kernel patch?
>
>This patch.
>
>>
>> Here I'm just checking the return value of vhost_vdpa_set_vring_ready().
>> It can return an error also without that kernel patch, so IMHO is
>> better to check the return value here in QEMU.
>>
>> What issue do you see with this patch applied?
>
>For the parent which can enable after driver_ok but not advertise it.

But this patch is not changing anything in that sense, it just controls
the return value of the VHOST_VDPA_SET_VRING_ENABLE ioctl.

Why would QEMU ignore an error if it can't activate vrings?
If we really want to ignore it we should document it both in QEMU, but
also in the kernel, because honestly the way the code is now it
shouldn't fail from what I understand.

That said, even if we ignore it, IMHO we should at least print a warning
in QEMU.

>
>(To say the truth, I'm not sure if we need to care about this)

I agree on that, but this is related to the patch in the kernel, not
this simple patch to fix QEMU error path, right?

>
>>
>> >
>> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We do know enabling could be
>> >done after driver_ok.
>> >Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We don't know whether
>> >enabling could be done after driver_ok or not.
>>
>> I see your point, indeed I didn't send a v2 of that patch.
>> Maybe we should document that, because it could be interpreted that if
>> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated the enabling
>> should always be done before driver_ok (which is true for example in
>> VDUSE).
>
>I see, so I think we probably need the fix.
>
>>
>> BTW I think we should discuss it in the kernel patch.
>>
>> Thanks,
>> Stefano
>>
>> >
>> >Thanks
>> >
>> >>
>> >> So better check its return value anyway.
>> >>
>> >> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u
>> >>
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >> Note: This patch conflicts with [2], but the resolution is simple,
>> >> so for now I sent a patch for the current master, but I'll rebase
>> >> this patch if we merge the other one first.
>
>Will go through [2].

Here I meant that the conflict is only in the code touched, because
Kevin's patch remove/move some of the code touched by this patch.
And rightly he checked the return value of the ioctl as I would like to
do in the other places where we call the same ioctl.

So honestly I still don't understand what's wrong with this patch...

Thanks,
Stefano

>
>Thanks
>
>
>> >>
>> >> [2]
>> >> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/
>> >> ---
>> >>  hw/virtio/vdpa-dev.c |  8 +++++++-
>> >>  net/vhost-vdpa.c     | 15 ++++++++++++---
>> >>  2 files changed, 19 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>> >> index eb9ecea83b..d57cd76c18 100644
>> >> --- a/hw/virtio/vdpa-dev.c
>> >> +++ b/hw/virtio/vdpa-dev.c
>> >> @@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>> >>          goto err_guest_notifiers;
>> >>      }
>> >>      for (i = 0; i < s->dev.nvqs; ++i) {
>> >> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
>> >> +        ret = vhost_vdpa_set_vring_ready(&s->vdpa, i);
>> >> +        if (ret < 0) {
>> >> +            error_setg_errno(errp, -ret, "Error starting vring %d", i);
>> >> +            goto err_dev_stop;
>> >> +        }
>> >>      }
>> >>      s->started = true;
>> >>
>> >> @@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>> >>
>> >>      return ret;
>> >>
>> >> +err_dev_stop:
>> >> +    vhost_dev_stop(&s->dev, vdev, false);
>> >>  err_guest_notifiers:
>> >>      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>> >>  err_host_notifiers:
>> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> >> index 3726ee5d67..e3d8036479 100644
>> >> --- a/net/vhost-vdpa.c
>> >> +++ b/net/vhost-vdpa.c
>> >> @@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
>> >>      }
>> >>
>> >>      for (int i = 0; i < v->dev->nvqs; ++i) {
>> >> -        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
>> >> +        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
>> >> +        if (ret < 0) {
>> >> +            return ret;
>> >> +        }
>> >>      }
>> >>      return 0;
>> >>  }
>> >> @@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
>> >>
>> >>      assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>> >>
>> >> -    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
>> >> +    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
>> >> +    if (unlikely(r < 0)) {
>> >> +        return r;
>> >> +    }
>> >>
>> >>      if (v->shadow_vqs_enabled) {
>> >>          n = VIRTIO_NET(v->dev->vdev);
>> >> @@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
>> >>      }
>> >>
>> >>      for (int i = 0; i < v->dev->vq_index; ++i) {
>> >> -        vhost_vdpa_set_vring_ready(v, i);
>> >> +        r = vhost_vdpa_set_vring_ready(v, i);
>> >> +        if (unlikely(r < 0)) {
>> >> +            return r;
>> >> +        }
>> >>      }
>> >>
>> >>      return 0;
>> >> --
>> >> 2.43.0
>> >>
>> >
>>
>


