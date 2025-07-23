Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CC8C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 05:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueSUG-0005YQ-IL; Wed, 23 Jul 2025 01:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSTU-0005C4-Ty
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSTR-0004sx-JU
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753250222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmCXPfhJ000TLqkbkcJNZ1T2US+ZrJFHxFhC5dPlz6M=;
 b=DAfjQliPWSYu9/u3aChLyLOthPkzXLweqqEq840/dgXzL9vwKQ6N6SF766zTSX0FwxACH6
 96+aMP6rb9LEp1LE+ubHzZfIaptsr0DkzyLV/dPrCzMtXVLINKRrUL58wEoy6Bekh02pg8
 M+l8oG+ygGloQAx4NZC96mSMI8kzSJc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-jz1aWZ2wNme2fx9yJeqxzw-1; Wed, 23 Jul 2025 01:57:00 -0400
X-MC-Unique: jz1aWZ2wNme2fx9yJeqxzw-1
X-Mimecast-MFC-AGG-ID: jz1aWZ2wNme2fx9yJeqxzw_1753250220
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3138c50d2a0so9715853a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 22:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753250220; x=1753855020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmCXPfhJ000TLqkbkcJNZ1T2US+ZrJFHxFhC5dPlz6M=;
 b=ZYIgTWc0vh3pUhsNqv10j5IWJzyf4wQsXyKc3KA7H+4lgceA3U+LMQkLXZ34df2VR+
 lTUZb9e865sa9C1+PVkWI+jXmjYCa2pYaTPfgW7wNhMUyeL1YUwPLbuWVK5UVuwVA8kw
 FfGtFWZP16JHCGIRajSCtHAWs0gt1cqmgIbFpwXxlrJWapEyVTBpVv3QQ3vZVaJ6u1Of
 KtiRu+hETii2VFVR8W/NfPY2b+mmHGk0Qt8THHr51VZGM6eqkJqo84cvxDyvFSQuAlZ2
 RNkuS7BQad5Q51CiVlYBmzY8tZwAZO6AjIgojxQwKC2AOahFJfTQSia8kYQvgEE1Yf/H
 6BmA==
X-Gm-Message-State: AOJu0YzVt9aQpCGxOigm4i5lGQ5tAQv0pZSrNM0Q+0R7aDYeVGyBh5Zs
 FXTKwse1LQDG3lzSs5AKg+HjejENE6OWrl5enOv1WzujKfKVwE5wqFLid4IddNo92BoH6GY5Px7
 GgFX1zRCl8gfHqQ+cpbDDAs3jSK8dSNSWq3IM0bdF0JNMbPC1LBnR57FiCdtSM3biBcEPwbGS9M
 CJrndvXDNPUyKPjFKDOr/6owIZVjarSeU=
X-Gm-Gg: ASbGnctEnIoH1YmU1lrHwTPKhuKMNB9XCBsx8nt5CS98klWIGdGGkKUErtdkjo9y4k1
 Bhce0PZWsYNH7X8mql2ckBIyaiNHFkn1qyqk1Av6f2Il1IZVrKwL0E4NmngfbWvhsrMVknIK1QP
 J5C6z+pLtIHvt5iu/i/EU=
X-Received: by 2002:a17:90b:4f83:b0:311:b5ac:6f63 with SMTP id
 98e67ed59e1d1-31e508169d0mr2576525a91.21.1753250219853; 
 Tue, 22 Jul 2025 22:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI1uVfEfILiZmxv6TOh5zIEHxu3cNL0ig0fgBuATaGeCKUOTzj9sDMyCjAJ66Xj3yNdoQSAbCeSWrpyypQ9Kk=
X-Received: by 2002:a17:90b:4f83:b0:311:b5ac:6f63 with SMTP id
 98e67ed59e1d1-31e508169d0mr2576492a91.21.1753250219367; Tue, 22 Jul 2025
 22:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
 <CACGkMEtWOk2o1xRK9XtaXPuWBnd8Yrfk4DVNJZB4kRCZzxWwRQ@mail.gmail.com>
 <776da82d-b218-45fe-8780-e8048b6074de@redhat.com>
In-Reply-To: <776da82d-b218-45fe-8780-e8048b6074de@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:56:48 +0800
X-Gm-Features: Ac12FXwPejaR1_XlZoPS6RkML3j-WNk2xWgwK-VNttDi3Oo62HeVKOJdk4llt70
Message-ID: <CACGkMEvb-y3fvfR=O66MzO2iQz9ioZDnLfBfoGR9jYur6oGkVg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 12:55=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 7/22/25 5:32 AM, Jason Wang wrote:
> > On Fri, Jul 18, 2025 at 4:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> Similar to virtio infra, vhost core maintains the features status
> >> in the full extended format and allows the devices to implement
> >> extended version of the getter/setter.
> >>
> >> Note that 'protocol_features' are not extended: they are only
> >> used by vhost-user, and the latter device is not going to implement
> >> extended features soon.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >> v2 -> v3:
> >>   - fix compile warning
> >>   - _array -> _ex
> >>
> >> v1 -> v2:
> >>   - uint128_t -> uint64_t[]
> >>   - add _ex() variant of features manipulation helpers
> >> ---
> >>  hw/virtio/vhost.c                 | 73 +++++++++++++++++++++++++++---=
-
> >>  include/hw/virtio/vhost-backend.h |  6 +++
> >>  include/hw/virtio/vhost.h         | 33 ++++++++++++--
> >>  3 files changed, 100 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index c30ea1156e..85ae1e4d4c 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost=
_dev *dev,
> >>  static int vhost_dev_set_features(struct vhost_dev *dev,
> >>                                    bool enable_log)
> >>  {
> >> -    uint64_t features =3D dev->acked_features;
> >> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
> >>      int r;
> >> +
> >> +    virtio_features_copy(features, dev->acked_features_ex);
> >>      if (enable_log) {
> >> -        features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> >> +        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
> >>      }
> >>      if (!vhost_dev_has_iommu(dev)) {
> >> -        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> >> +        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
> >>      }
> >>      if (dev->vhost_ops->vhost_force_iommu) {
> >>          if (dev->vhost_ops->vhost_force_iommu(dev) =3D=3D true) {
> >> -            features |=3D 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
> >> +            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
> >>         }
> >>      }
> >> -    r =3D dev->vhost_ops->vhost_set_features(dev, features);
> >> +
> >> +    if (virtio_features_use_extended(features) &&
> >> +        !dev->vhost_ops->vhost_set_features_ex) {
> >> +        VHOST_OPS_DEBUG(r, "extended features without device support"=
);
> >> +        r =3D -EINVAL;
> >> +        goto out;
> >> +    }
> >> +
> >> +    if (dev->vhost_ops->vhost_set_features_ex) {
> >> +        r =3D dev->vhost_ops->vhost_set_features_ex(dev, features);
> >> +    } else {
> >> +        r =3D dev->vhost_ops->vhost_set_features(dev, features[0]);
> >> +    }
> >>      if (r < 0) {
> >>          VHOST_OPS_DEBUG(r, "vhost_set_features failed");
> >>          goto out;
> >> @@ -1506,12 +1520,27 @@ static void vhost_virtqueue_cleanup(struct vho=
st_virtqueue *vq)
> >>      }
> >>  }
> >>
> >> +static int vhost_dev_get_features(struct vhost_dev *hdev,
> >> +                                  uint64_t *features)
> >> +{
> >> +    uint64_t features64;
> >> +    int r;
> >> +
> >> +    if (hdev->vhost_ops->vhost_get_features_ex) {
> >> +        return hdev->vhost_ops->vhost_get_features_ex(hdev, features)=
;
> >> +    }
> >> +
> >> +    r =3D hdev->vhost_ops->vhost_get_features(hdev, &features64);
> >> +    virtio_features_from_u64(features, features64);
> >> +    return r;
> >> +}
> >
> > Nit: let's have a vhost_dev_set_features() as well?
>
> I guess you mean to factor out the
> vhost_set_features_ex()/vhost_set_features() in a specific helper am I
> correct?

Yes.

>
> Note that there is already a vhost_dev_set_features() function. It's
> touched by the previous chunk. I opted for not creating the mentioned
> helper to avoid some weird naming issues, as such helper would not lead
> to any code deduplication.

I'm fine not having that then.

>
> Please LMK if you have strong opinion for a different choice.
>
> Thanks,
>
> Paolo

Thanks

>


