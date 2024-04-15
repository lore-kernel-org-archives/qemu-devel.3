Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF97BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 07:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwGlX-0003Av-1S; Mon, 15 Apr 2024 03:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1rwGlV-0003Aj-OV
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 03:28:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1rwGlT-0001y4-Cb
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 03:28:33 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso1941212b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1713166107; x=1713770907; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALNYSbrNyWyR7nJbhxUaAD5aYzFFjmdtLSpenaRrYL0=;
 b=iF2dsER6d38RUFMva4if2emOtS9nFlaBnIcNo2jg/WbYJ7DAdRqipRfuja8/jE5wAe
 SaUy8OW2noCixooZQnvjOGa7ezt5JtOzYDzGOm+yz1GMQLrg+qnJ/7zYNyqF3MBmUYnd
 +GDZIAYbRqcBq2PKNW7zyb/+eDckYpQu+cimPPDlhLExPYr5sXqpkhjlHdkY7j4Y80df
 o5+7vvAS465uhuE3jN666hzUx92GDJfupedd7mf1gTRscFXuCdGktqRtdO8tUhTWgD2E
 mtWFDGB8Kg5hvTBePTNp1TkdgWNS1brzCnnDIx30SmHVOZ16DN+SNYwtZQvTkTfc52Te
 r7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713166107; x=1713770907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALNYSbrNyWyR7nJbhxUaAD5aYzFFjmdtLSpenaRrYL0=;
 b=POET8kz7IUJyDBMgSvONZnJ4Yo6F9FcyS6eWcmA4Ag9QbtdYwek+T1zcd6+5ln0KhP
 c/x8kZeQtm/lrT+JPkuLCVjB68LadEVXeKf0ZTH57nAYgQPo8FQZ81Ow7RJnlLxT14k+
 K1DfSe0EOnRfGyeBDyW4xzfiB5L7y9OqNg7KfDsmQ9J/8RCZxGxj04BPsGSGkbKVYL6J
 0L0k3XJK9gVW8vfPCzmwGxDyw2yl42zZnPlCV4P3Sf66uTzBkSZX7C+BX3H3mVcBGLrm
 AhjbyTqtvZxLZKG8WqMC1bsmLKztiO8iv+lwKAfTTydLZqNU0KXo0RrjTrghQIwmlDPX
 rSVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgQnKSl09ozjl6IgRqw66WzSetPUYOeTCQKRhtjdF/kTsjUBweBO9QwqtanAjSXy5zG407LtopueKAXJ40ejnY4Ugx+bY=
X-Gm-Message-State: AOJu0YyRNUIrIb0jQoGrrSLn9zjHwL61yAK3fS1lWI/TYMYz/RWUtBlW
 G0v+fyYsnliR50xW4xqkAhB/jxF/B659GoRImXY2b4VaBXUgTfaGXES/Pf6EXoL+wF6Wjpy8Ppg
 U9ZmLNIrx6RjrwNxOcDyA/7B59APp2itQXCII
X-Google-Smtp-Source: AGHT+IGFxMpebuHs+dmarShvW98snNgUMCQVYNAu2hhiE6BOzt1kC2asMpPYBBDQ+kgoIUlHuggqMJjZLzMUJK3V5TM=
X-Received: by 2002:a05:6a20:2d22:b0:1a3:dfd2:949c with SMTP id
 g34-20020a056a202d2200b001a3dfd2949cmr7949324pzl.54.1713166106883; Mon, 15
 Apr 2024 00:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWcL7DRSj7bPK=MfAZoTw-GgZCKr4on3U0Q8jmRd2OZSPg@mail.gmail.com>
 <20240414044353-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240414044353-mutt-send-email-mst@kernel.org>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 15 Apr 2024 15:28:16 +0800
Message-ID: <CACycT3uXtwQ+TPrBxrz5VcFxYWWQ7vfsYU8nwgstYZ_GhRov_Q@mail.gmail.com>
Subject: Re: Discrepancy between mmap call on DPDK/libvduse and rust vm-memory
 crate
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, German Maglione <gmaglione@redhat.com>, 
 Hanna Czenczek <hczenczek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=xieyongji@bytedance.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Apr 14, 2024 at 5:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Apr 12, 2024 at 12:15:40PM +0200, Eugenio Perez Martin wrote:
> > Hi!
> >
> > I'm building a bridge to expose vhost-user devices through VDUSE. The
> > code is still immature but I'm able to forward packets using
> > dpdk-l2fwd through VDUSE to VM. I'm now developing exposing virtiofsd,
> > but I've hit an error I'd like to discuss.
> >
> > VDUSE devices can get all the memory regions the driver is using by
> > VDUSE_IOTLB_GET_FD ioctl. It returns a file descriptor with a memory
> > region associated that can be mapped with mmap, and an information
> > entry about the map it contains:
> > * Start and end addresses from the driver POV
> > * Offset within the mmaped region of these start and end
> > * Device permissions over that region.
> >
> > [start=3D0xc3000][last=3D0xe7fff][offset=3D0xc3000][perm=3D1]
> >
> > Now when I try to map it, it is impossible for the userspace device to
> > call mmap with any offset different than 0.
>
> How exactly did you allocate memory? hugetlbfs?
>
> > So the "straightforward"
> > mmap with size =3D entry.last-entry.start and offset =3D entry.offset d=
oes
> > not work. I don't know if this is a limitation of Linux or VDUSE.
> >
> > Checking QEMU's
> > subprojects/libvduse/libvduse.c:vduse_iova_add_region() I see it
> > handles the offset by adding it up to the size, instead of using it
> > directly as a parameter in the mmap:
> >
> > void *mmap_addr =3D mmap(0, size + offset, prot, MAP_SHARED, fd, 0);
>
>
> CC Xie Yongji who wrote this code, too.
>

The mmap() with hugetlb would fail if the offset into the file is not
aligned to the huge page size. So libvhost-user did something like
this. But I think VDUSE doesn't have this problem. So it's fine to
directly use the offset as a parameter in the mmap(2) here.

Thanks,
Yongji

