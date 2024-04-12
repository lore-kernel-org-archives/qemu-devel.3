Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C80CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBmQ-0000Am-VQ; Fri, 12 Apr 2024 03:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rvBmK-0000AG-0u
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rvBmH-0003IN-8e
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712908611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4paDVo5jdXquRvqeO2PrDh5bh917/gaAvlXp96AlTg=;
 b=Y22Fjj7QEUHRrxxWjv4enSHEaWSGBPU42jiILS8VkHedhttlLV7nf/nwmWeyN8TImic9in
 qiW3vnLx5joUNvsnPVw7jJy6TjKW88YHzGkg9v8JtFTlDfZSo5C5QUyA59CIxq2vxIq7kB
 cTEOpFa+t7kIrmygtDc23U2/mtsR3aM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-JXYrpGkpMHa_CgMtT1eIyw-1; Fri, 12 Apr 2024 03:56:48 -0400
X-MC-Unique: JXYrpGkpMHa_CgMtT1eIyw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcbee93a3e1so1203861276.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712908608; x=1713513408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4paDVo5jdXquRvqeO2PrDh5bh917/gaAvlXp96AlTg=;
 b=ricv28Yip71/jeL83u/SOUT5vkiBhCQN4djQis2LL9zMYMmkdKvS029GCqDpzm12sH
 kxtYVhVLqWZAOUPqXI2XdvRqEF/5zVL27JvlzqDDGJgwI4sIRE6YwacQ8zicgj1jSC2v
 rw+Jpb1JLTPijE0QEbcJTY8Hz53PcIiZaTylYvdkVNVdV63ESp4N1P1BtdTQVTEB7528
 axbxA4r41wt32BcOKROQ2P2Lb9wSLGS2N5+wlD5rvQ16UmX4RCvI4wM0RsM/8lujKLTn
 6MZfZrx+aAJTCrmFgaPQSBTeZW3hreqtX06JNY3XuUJZY5k70fLD3JMG8tsm7kY6qZly
 aKzw==
X-Gm-Message-State: AOJu0YytvD8kub02c8XXtgexjn6lxxPS3XeP01r6xf0ZZXxD2LEf9S4W
 3nUeqUV1EGOyNOXAVrghkb1aoZp7zPWPkUy2MzDCk1SbtP4+MJb0nl6t/yyp9y7X934530PJyGv
 VPO5O2VbYCehMD1pfyK11br7nV0kscn/rAWtfeW7BR1s3MgD4iRjyzZ+qcuNfWsjYErrVGWtqAP
 S56AvWondDsUq5ly4RPaaBn1uuT84=
X-Received: by 2002:a25:860e:0:b0:dc6:d457:ac92 with SMTP id
 y14-20020a25860e000000b00dc6d457ac92mr1512087ybk.31.1712908608057; 
 Fri, 12 Apr 2024 00:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsATN990TsziU0rDn00OVHeBAtGb7AzZ/lV658xNRCkJvH8EmMnmNXd8ibUb4z0Nz8huqF2oLBnWOoiRpR5KM=
X-Received: by 2002:a25:860e:0:b0:dc6:d457:ac92 with SMTP id
 y14-20020a25860e000000b00dc6d457ac92mr1512073ybk.31.1712908607743; Fri, 12
 Apr 2024 00:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
In-Reply-To: <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 12 Apr 2024 09:56:11 +0200
Message-ID: <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > The guest may have overlapped memory regions, where different GPA leads
> > to the same HVA.  This causes a problem when overlapped regions
> > (different GPA but same translated HVA) exists in the tree, as looking
> > them by HVA will return them twice.
>
> I think I don't understand if there's any side effect for shadow virtqueu=
e?
>

My bad, I totally forgot to put a reference to where this comes from.

Si-Wei found that during initialization this sequences of maps /
unmaps happens [1]:

HVA                    GPA                IOVA
---------------------------------------------------------------------------=
----------------------------------------------
Map
[0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
[0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
[0x80001000, 0x2000001000)
[0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
[0x2000001000, 0x2000021000)

Unmap
[0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
0x20000) ???

The third HVA range is contained in the first one, but exposed under a
different GVA (aliased). This is not "flattened" by QEMU, as GPA does
not overlap, only HVA.

At the third chunk unmap, the current algorithm finds the first chunk,
not the second one. This series is the way to tell the difference at
unmap time.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html

Thanks!

> Thanks
>
> >
> > To solve this, track GPA in the DMA entry that acs as unique identifier=
s
> > to the maps.  When the map needs to be removed, iova tree is able to
> > find the right one.
> >
> > Users that does not go to this extra layer of indirection can use the
> > iova tree as usual, with id =3D 0.
> >
> > This was found by Si-Wei Liu <si-wei.liu@oracle.com>, but I'm having a =
hard
> > time to reproduce the issue.  This has been tested only without overlap=
ping
> > maps.  If it works with overlapping maps, it will be intergrated in the=
 main
> > series.
> >
> > Comments are welcome.  Thanks!
> >
> > Eugenio P=C3=A9rez (2):
> >   iova_tree: add an id member to DMAMap
> >   vdpa: identify aliased maps in iova_tree
> >
> >  hw/virtio/vhost-vdpa.c   | 2 ++
> >  include/qemu/iova-tree.h | 5 +++--
> >  util/iova-tree.c         | 3 ++-
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > --
> > 2.44.0
> >
>


