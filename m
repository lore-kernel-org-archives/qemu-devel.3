Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82103C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 04:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKsBi-0007wv-Nl; Sat, 22 Jun 2024 00:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sKsBh-0007wL-EP
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 00:17:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sKsBf-0004IR-Fx
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 00:17:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-706683e5249so139531b3a.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 21:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719029833; x=1719634633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rb6KRZjYXywxtZ+0hOmRX04N1ORuklV8VDvWpQGvH6g=;
 b=X1parxN7NGqUi4gyxtcZ3J9KKPcPt8vTBoscUB2LRUjR+9HGhMsZZPc0UyWxZWltDk
 xFhACqA7VoFrv9TyPgeFR3aNm+iLGXNTBfsQWXp/QRAWMe7113OSReGEGdlc/Y2Oy8BF
 P9rLrJw0dZuLM/2S5ylxgufNgHuvqkLLCcBjcZ5fW7YeWXyvabnUOFaCCWkqYegx/70m
 x7xfmKMXM8y5+k2Y/vH4Yvwf548LySM2jTD2WoREIM6EwO5i3P1xigBL34TLGpRTqU/Y
 BVfSJiCb+0VDqrYTkjULIzPb2PddrFCgJvwhw3XOMinDrbU+7lUzzlDmvO8RucuwZIga
 rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719029833; x=1719634633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rb6KRZjYXywxtZ+0hOmRX04N1ORuklV8VDvWpQGvH6g=;
 b=wsYVPQSDg+ijZCQsu+ouHJJ/hbSTDxlJWxg3GBm1mDLfvQLo7fuZkkaRKBk5/R4W/S
 tdrAeo0AcCRaoS17rO+HjQa5peLiH4Q5kd9EJcKmCUAni/Rd+1dSMGAzTuvfw1ycBWBg
 iJgqOLQAsRq1Y7FE2eb/Vs+sAq53zBtNJPV9bBxTULwhrh+RFaaXb95axelUojK0Mtf9
 a9k2nAb2Giq1JT4+nZbaC74UJ4l1ee6a1tOY17kY5+BSW+eJE82WvexaC7RNHK8URDvK
 l217gwV1buckTGb018+aSwAyUlBoH7CgmfuXsYvfIhZuwU2yCGQZoI8zK7qo0vqP+6vu
 RTBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnwQgyJQx9DT8MNS4Nw80EikUDyKdKqihF/md6jsrhvtw6XapYLmWPMSpBMo8AZ9OaaMiz04PX7BB7vZezLXyOK9EE3kQ=
X-Gm-Message-State: AOJu0YxG/UbbO4UZumfke0dwCSrdOusmKBTDn0JGrQDsgK5mBAId1EJN
 /eKvkmSu+zM6D2zOd76BZdlrX4IT32C+pxiwJxkSU5DClT6UL4fY
X-Google-Smtp-Source: AGHT+IHHrch+PgVa75WQoJfqKkExYb0VEwqsZ8bHF8vPiitflwBv1wtJtyVGhNjAYvAj8weXTBGrqA==
X-Received: by 2002:a05:6a20:da90:b0:1b6:dae0:551a with SMTP id
 adf61e73a8af0-1bcbb574afemr12497823637.24.1719029833334; 
 Fri, 21 Jun 2024 21:17:13 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.83.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9f3c6f088sm18817795ad.284.2024.06.21.21.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 21:17:12 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
Date: Sat, 22 Jun 2024 09:47:08 +0530
Message-ID: <4927942.31r3eYUQgx@valdaarhun>
In-Reply-To: <CAJaqyWcjfaU9mcdTsE2LkL755UCWU-KQ4jz83trr_T0C2ZaGhw@mail.gmail.com>
References: <20240618181834.14173-1-sahilcdq@proton.me>
 <3813507.kQq0lBPeGt@valdaarhun>
 <CAJaqyWcjfaU9mcdTsE2LkL755UCWU-KQ4jz83trr_T0C2ZaGhw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Thank you for your reply.

On Wednesday, June 19, 2024 1:07:54=E2=80=AFPM GMT+5:30 Eugenio Perez Marti=
n wrote:
> [...]
> > "curr" is being updated here, but descs[i].id is always set to id which
> > doesn't change in the loop. So all the descriptors in the chain will ha=
ve
> > the same id. I can't find anything in the virtio specification [1] that
> > suggests that all descriptors in the chain have the same id. Also, going
> > by the figure captioned "Three chained descriptors available" in the bl=
og
> > post on packed virtqueues [2], it looks like the descriptors in the cha=
in
> > have different buffer ids.
> >=20
> > The virtio implementation in Linux also reuses the same id value for all
> > the descriptors in a single chain. I am not sure if I am missing
> > something here.
>=20
> The code is right, the id that identifies the whole chain is just the
> one on the last descriptor. The key is that all the tail descriptors
> of the chains will have a different id, the rest ids are ignored so it
> is easier this way. I got it wrong in a recent mail in the list, where
> you can find more information. Let me know if you cannot find it :).

I found the mail here [1] :)

> In the split vq is different as a chained descriptor can go back and
> forth in the descriptor ring with the next id. So all of them must be
> different. But in the packed vq, the device knows the next descriptor
> is placed at the next entry in the descriptor ring, so the only
> important id is the last one.

Ok, this makes sense now.

> > > +        if (++i >=3D svq->vring_packed.vring.num) {
> > > +            i =3D 0;
> > > +            svq->vring_packed.avail_used_flags ^=3D
> > > +                    1 << VRING_PACKED_DESC_F_AVAIL |
> > > +                    1 << VRING_PACKED_DESC_F_USED;
> > > +        }
> > > +    }
> > > +
> > > +    if (i <=3D head) {
> > > +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> > > +    }
> > > +
> > > +    svq->vring_packed.next_avail_idx =3D i;
> > > +    svq->free_head =3D curr;
> >=20
> > Even though the same id is used, curr will not be id+1 here.
>=20
> curr is not the descriptor index, but the id. They're used in a stack
> format: One available chain pops an id and one used id pushes its id
> in the stack.
>=20
> Maybe I'm wrong, but I think the main reason is to reuse the same
> memory region of the descriptor state etc so less memory is changed to
> be used in all the operations.

Right, curr is the id. I didn't really understand the popping and pushing
part.

In the implementation, the possible ids are stored in svq.desc_next. And
it's implemented in a way that the next id is (id + 1) % queue_size.

By the following line:
> Even though the same id is used, curr will not be id+1 here.

I meant that if, for example,  there is a chain of 3 descriptors and the
current id is 1, then all 3 descriptors will have 1 as their id. If the vri=
ng
size is 5, then the value of curr that will be filled in the 4th descriptor
will be 4 instead of 2.

> > > +    return true;
> > > +}
> > > +
> > > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > > +                                const struct iovec *out_sg, size_t
> > > out_num, +                                const struct iovec *in_sg,
> > > size_t in_num, +                                unsigned *head)
> > > +{
> > > +    bool ok;
> > > +    uint16_t head_flags =3D 0;
> > > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> >=20
> > I chose to use out_num+in_num as the size instead of MAX(ount_num,
> > in_num). I found it easier to implement
> > "vhost_svq_vring_write_descs_packed()" like this. Please let me know if
> > this isn't feasible or ideal.
>=20
> Not a big deal, I picked the MAX just because it is all the
> hwaddresses the function needs at the same time. Addition should work
> too, and AFAIK chains are usually short. We should get rid of this
> dynamic allocation in the future anyway.

Ok, understood.

> [...]
> > In "struct VhostShadowVirtqueue", I rearranged the order in which some
> > members appear. I tried to keep the members common to split and packed
> > virtqueues above the union and the rest below the union. I haven't
> > entirely understood the role of some of the members (for example,
> > VhostShadowVirtqueueOps *ops). I'll change this ordering if need be as I
> > continue to understand them better.
>=20
> That's fine, but do it in a separate patch for future series, so it is
> easier to review.

Sure, I'll do that.

> ops is used when a kind of device wants specialized handling for the
> descriptors forwarded. vdpa-net uses it when QEMU also needs to
> inspect the descriptors. Feel free to ask more about it, but adding
> packed format to SVQ should not affect the ops member.

Got it. I don't have any other questions related to ops.

> > For the next step, I think I should work on "vhost_svq_start()" which is
> > where members of the struct are actually initialized. At the moment, on=
ly
> > the split ring part of the structure is initialized.
>=20
> Sounds reasonable. My recommendation is to mimic the patches of the
> kernel, doing a git log and following that order. You also need to
> apply the fixes in the history from that moment.
>=20
> > I think I should also start working on enhancing "vhost_svq_kick()" to
> > actually send the buffers to the device. I think it'll be easier to test
> > these changes once that's done (I am not sure about this though). Would
> > this involve implementing the notification mechanism and event_idx?
> You can start omitting event_idx if you disable it from the device or
> from qemu's commandline with event_idx=3Doff. If you use vdpa_sim, it's
> easier to remove it using qemu's cmdline in my opinion. Also, there is
> a needs_kick boolean that you can set to always true for testing
> purposes, since it is valid to send extra notifications. I think you
> don't need to modify anything else from vhost_svq_kick to test the
> device receives the buffer, but let me know if you find problems.

I'll take a look at the kernel patches. I'll also try testing these changes=
 with
vdpa_sim. I'll check if the device gets the buffers.

Thanks,
Sahil

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg01843.html



