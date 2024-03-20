Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4441DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmruO-0005cx-JH; Wed, 20 Mar 2024 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rmruJ-0005cg-LK
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rmruG-0005cg-2g
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710925598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iE5IMFbumI3UueFs/ByUxSkpPd6mdS/V6qBD2cc/xaY=;
 b=OztNeUYB2MRxe5616nBC1kPeah3g+N0a10aGmK3IuDzqCpVSKs07acTxDWQbkpqqdwMWOS
 tgxvnO0EwvxGyMLdMg/uJGVZepFJaNUzmY+kwrWQvrLjhSKRudGyYDYrwi9WgY6AwHG1ob
 BN4HsqrdqiP/SEtggv4EF0/HNrOhGiQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-F3bgAf6XOniOZR04uZCZzQ-1; Wed, 20 Mar 2024 05:06:36 -0400
X-MC-Unique: F3bgAf6XOniOZR04uZCZzQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a46ba1a19fdso231934666b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710925595; x=1711530395;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iE5IMFbumI3UueFs/ByUxSkpPd6mdS/V6qBD2cc/xaY=;
 b=Tukgf/d0YB3rPYjaI82AvJLHzk5lzlFagVevsUtRIP07Kc9lFwfF1TozKLEquBGITk
 Dap/R5MUYdE60SIQ8IOqx7aM82hhcFNkp0HxFKdvvrE7ADVJA0CuDxiElcIs2WETSXUZ
 CSCXQpiJ0U/Vu+m//hPwaO+KrASBlsAbU+RjTg0dQeMjshZ0vREadHtch0WGNhykaasW
 VFiRxlpQ89eOd9gTYZ7QS8FMS/uHt+V2F5v/7KCC79PtUYPXsZReIYCJcprawclaYuNE
 oLG0eHhCi3/yx/SgfY/7uGUSGp67JTWCoYXi6PWWdfzma/34A4V8zUkRJckgTpQJv+DV
 Tieg==
X-Gm-Message-State: AOJu0YySTTA7lsnHrzvFybiNUmbSJPZ+GRDwPhciYM9gwY99oMRYuVWV
 iAElkT/q5XQxmhIiQQetUlOV3uopb0XdLHtHwQPZ1zFGMHdhQnkR47RZHSUirYf7jsZxUNymQdf
 pIJLtymxZpncOr/80WM8airG+Tz2aNj6bTbVVygX22xDyWyLnfP68
X-Received: by 2002:a17:906:dfeb:b0:a45:cedb:5564 with SMTP id
 lc11-20020a170906dfeb00b00a45cedb5564mr3128898ejc.37.1710925595306; 
 Wed, 20 Mar 2024 02:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPow5rdIt9LQiVqpBJ+xUM0OlfWm7/4PhOiXwodhjCbGaIC2+GdNVWvYxwg6bEXTR/4vZAmQ==
X-Received: by 2002:a17:906:dfeb:b0:a45:cedb:5564 with SMTP id
 lc11-20020a170906dfeb00b00a45cedb5564mr3128891ejc.37.1710925594887; 
 Wed, 20 Mar 2024 02:06:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 bw9-20020a170906c1c900b00a45ff821e09sm7010415ejb.150.2024.03.20.02.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 02:06:34 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:06:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lulu@redhat.com, 
 kwolf@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
Message-ID: <5afa5xwifj43bsbfuzb2r4clndun7s5jj33rkfg2cao6dky4ah@m6y4bnmot2hy>
References: <20240207092702.25242-1-sgarzare@redhat.com>
 <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
 <uufps7n6otfwygiszepy76ltohvsqqo45rwyc6axja3isebda2@mn4rjbji66qt>
 <CACGkMEt-z3YCh81M2yxnCa9PjLpR8qQ8rLQ5rRCMP6=m9yKpFw@mail.gmail.com>
 <uofjifqnl57vxigv4ebplfk4menefsgplnvvbprisubkywujbw@273bn7kc5hjg>
 <CACGkMEusWU9d3hp7m1hzhH9PayfYcw5DTDYn9SEbCdBT7evvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEusWU9d3hp7m1hzhH9PayfYcw5DTDYn9SEbCdBT7evvAg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 20, 2024 at 12:18:14PM +0800, Jason Wang wrote:
>On Mon, Mar 18, 2024 at 4:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Mon, Mar 18, 2024 at 12:31:59PM +0800, Jason Wang wrote:
>> >On Fri, Mar 15, 2024 at 4:23 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> On Thu, Mar 14, 2024 at 11:17:01AM +0800, Jason Wang wrote:
>> >> >On Wed, Feb 7, 2024 at 5:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >>
>> >> >> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
>> >> >> patch [1] will be merged, it may fail with more chance if
>> >> >> userspace does not activate virtqueues before DRIVER_OK when
>> >> >> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
>> >> >
>> >> >I wonder what happens if we just leave it as is.
>> >>
>> >> Are you referring to this patch or the kernel patch?
>> >
>> >This patch.
>> >
>> >>
>> >> Here I'm just checking the return value of vhost_vdpa_set_vring_ready().
>> >> It can return an error also without that kernel patch, so IMHO is
>> >> better to check the return value here in QEMU.
>> >>
>> >> What issue do you see with this patch applied?
>> >
>> >For the parent which can enable after driver_ok but not advertise it.
>>
>> But this patch is not changing anything in that sense, it just controls
>> the return value of the VHOST_VDPA_SET_VRING_ENABLE ioctl.
>>
>> Why would QEMU ignore an error if it can't activate vrings?
>> If we really want to ignore it we should document it both in QEMU, but
>> also in the kernel, because honestly the way the code is now it
>> shouldn't fail from what I understand.
>>
>> That said, even if we ignore it, IMHO we should at least print a warning
>> in QEMU.
>
>Right.
>
>>
>> >
>> >(To say the truth, I'm not sure if we need to care about this)
>>
>> I agree on that, but this is related to the patch in the kernel, not
>.> this simple patch to fix QEMU error path, right?
>
>Or it's the charge of the Qemu vDPA layer to avoid calling
>set_vq_ready() after driver_ok if no
>VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK. Or it might be too late.

Yeah, maybe is too late. We already released several versions without
that.

>
>>
>> >
>> >>
>> >> >
>> >> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We do know enabling could 
>> >> >be
>> >> >done after driver_ok.
>> >> >Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We don't know whether
>> >> >enabling could be done after driver_ok or not.
>> >>
>> >> I see your point, indeed I didn't send a v2 of that patch.
>> >> Maybe we should document that, because it could be interpreted that if
>> >> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated the enabling
>> >> should always be done before driver_ok (which is true for example 
>> >> in
>> >> VDUSE).
>> >
>> >I see, so I think we probably need the fix.
>> >
>> >>
>> >> BTW I think we should discuss it in the kernel patch.
>> >>
>> >> Thanks,
>> >> Stefano
>> >>
>> >> >
>> >> >Thanks
>> >> >
>> >> >>
>> >> >> So better check its return value anyway.
>> >> >>
>> >> >> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u
>> >> >>
>> >> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> >> ---
>> >> >> Note: This patch conflicts with [2], but the resolution is simple,
>> >> >> so for now I sent a patch for the current master, but I'll rebase
>> >> >> this patch if we merge the other one first.
>> >
>> >Will go through [2].
>>
>> Here I meant that the conflict is only in the code touched, because
>> Kevin's patch remove/move some of the code touched by this patch.
>> And rightly he checked the return value of the ioctl as I would like to
>> do in the other places where we call the same ioctl.
>>
>> So honestly I still don't understand what's wrong with this patch...
>
>Nothing wrong now.
>
>Acked-by: Jason Wang <jasowang@redhat.com>

Thanks for the review,
I'll send a v2 carrying your and Eugenio acks, rebasing on top of 
Kevin's patch, so it should be easy to merge.

Stefano


