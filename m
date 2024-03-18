Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5709C54E67
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3a9-00011u-Rh; Sun, 17 Mar 2024 23:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rm3a8-00011e-B5
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rm3a5-0001NC-FT
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710732152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFguYLzX4bliK8h7l9Ux1BIaRSgSVvC7TiaqIvX4ZSk=;
 b=FbNFBmAyLrPY21A9/ltfCSYsIJj4C+HqC4dipTAPN/GSxp9EqQhC2EBGwEcYPoHkUo2Pnn
 iXRWj0nn9Bs2jkeJzDQBPnfdsJWn2t6mGCJwJoplUWL4RrCWfU5ZoVIpa1dPZAs5xTb/n6
 wy+LBq6wXfw01+izifrmPbkFpF3PPe4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-yC5xoTr3PaaDX9Y9k2aWvg-1; Sun, 17 Mar 2024 23:22:30 -0400
X-MC-Unique: yC5xoTr3PaaDX9Y9k2aWvg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29dfc072e95so1683486a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 20:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710732149; x=1711336949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFguYLzX4bliK8h7l9Ux1BIaRSgSVvC7TiaqIvX4ZSk=;
 b=gi4MVmFwDpjNg3xM7NE+lCld7uzV1mrIL575zUKoHyQeeSgtUPktp/t5oYtFuSJCFt
 gy9N0TxLXCtyTHMcjI8s+gD8+YYlOAHfvNgO1kpUexg5DPDfgYN1bDgonwc9xtiDsMpW
 Z58EhKVr/K0qlts3oYdLWuQtylQGOSPWvLIWDNFirul65ZZ8rTtiNFFyEiDwxVAjU3mO
 WhlArOSfk8MMKk0LlpsS1xoppXB8Ujlnkts54SsOZMRG5V96u3C9oxxvAHr+ycsO/MFH
 ZF8g4iAp2ph8F7dl2B7si97DOXnQSqJ+G86HrsgVVaZQgb5YL+M2JWC4MsyNZWKfFTq2
 raXw==
X-Gm-Message-State: AOJu0Ywawj1q8iwQf3dIPgjXAOu7xP1e8EUPwmex9p0BvyHooahGieIB
 qbtHIfL9abKTUUQxj7PStMlrM1SEaLfoMndbcyMCZuXdRxPN3N75SWnOhjn4qBi6hSxez1TtNlg
 W+ZVdNFZpVLBO6DTzJ0O8bsz1qMsw/BvT4uvzyDKfxD2tSMWen8gBQ+dqYF5UWk2JXh3KwS0BDl
 F29XzZythuI22uJnpwD7FQm8KnVag=
X-Received: by 2002:a17:90b:4384:b0:29d:da79:8d76 with SMTP id
 in4-20020a17090b438400b0029dda798d76mr6820130pjb.47.1710732148982; 
 Sun, 17 Mar 2024 20:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPs3SwWrvo5NWlNFvrkqYq/u+9EQfjS7GfG/4uEVLcisGwJPZLw5fK6Zgd2bJysw0Tj2QC90CA/2qSNyeEja0=
X-Received: by 2002:a17:90b:4384:b0:29d:da79:8d76 with SMTP id
 in4-20020a17090b438400b0029dda798d76mr6820124pjb.47.1710732148659; Sun, 17
 Mar 2024 20:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
 <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
In-Reply-To: <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 11:22:17 +0800
Message-ID: <CACGkMEtEtmOZB53xibp5G7ZeVdKpZogEnetfnfj1QCSX-RWY8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Sat, Mar 16, 2024 at 2:45=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 3/14/2024 9:03 PM, Jason Wang wrote:
> > On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> On setups with one or more virtio-net devices with vhost on,
> >> dirty tracking iteration increases cost the bigger the number
> >> amount of queues are set up e.g. on idle guests migration the
> >> following is observed with virtio-net with vhost=3Don:
> >>
> >> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> >> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> >> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> >> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
> >>
> >> With high memory rates the symptom is lack of convergence as soon
> >> as it has a vhost device with a sufficiently high number of queues,
> >> the sufficient number of vhost devices.
> >>
> >> On every migration iteration (every 100msecs) it will redundantly
> >> query the *shared log* the number of queues configured with vhost
> >> that exist in the guest. For the virtqueue data, this is necessary,
> >> but not for the memory sections which are the same. So essentially
> >> we end up scanning the dirty log too often.
> >>
> >> To fix that, select a vhost device responsible for scanning the
> >> log with regards to memory sections dirty tracking. It is selected
> >> when we enable the logger (during migration) and cleared when we
> >> disable the logger. If the vhost logger device goes away for some
> >> reason, the logger will be re-selected from the rest of vhost
> >> devices.
> >>
> >> After making mem-section logger a singleton instance, constant cost
> >> of 7%-9% (like the 1 queue report) will be seen, no matter how many
> >> queues or how many vhost devices are configured:
> >>
> >> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
> >> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
> >>
> >> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>
> >> ---
> >> v3 -> v4:
> >>    - add comment to clarify effect on cache locality and
> >>      performance
> >>
> >> v2 -> v3:
> >>    - add after-fix benchmark to commit log
> >>    - rename vhost_log_dev_enabled to vhost_dev_should_log
> >>    - remove unneeded comparisons for backend_type
> >>    - use QLIST array instead of single flat list to store vhost
> >>      logger devices
> >>    - simplify logger election logic
> >> ---
> >>   hw/virtio/vhost.c         | 67 +++++++++++++++++++++++++++++++++++++=
+++++-----
> >>   include/hw/virtio/vhost.h |  1 +
> >>   2 files changed, 62 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index 612f4db..58522f1 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -45,6 +45,7 @@
> >>
> >>   static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> >>   static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> >> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX]=
;
> >>
> >>   /* Memslots used by backends that support private memslots (without =
an fd). */
> >>   static unsigned int used_memslots;
> >> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
> >>       }
> >>   }
> >>
> >> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
> >> +{
> >> +    assert(dev->vhost_ops);
> >> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> >> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> >> +
> >> +    return dev =3D=3D QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->bac=
kend_type]);
> > A dumb question, why not simple check
> >
> > dev->log =3D=3D vhost_log_shm[dev->vhost_ops->backend_type]
> Because we are not sure if the logger comes from vhost_log_shm[] or
> vhost_log[]. Don't want to complicate the check here by calling into
> vhost_dev_log_is_shared() everytime when the .log_sync() is called.

It has very low overhead, isn't it?

static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
{
    return dev->vhost_ops->vhost_requires_shm_log &&
           dev->vhost_ops->vhost_requires_shm_log(dev);
}

And it helps to simplify the logic.

Thanks

>
> -Siwei
> > ?
> >
> > Thanks
> >
>


