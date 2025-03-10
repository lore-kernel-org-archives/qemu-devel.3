Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A896C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tra3n-00015T-0n; Mon, 10 Mar 2025 06:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tra3l-000158-Sg
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tra3j-0006J9-U6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741601310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52o2P25rC28Zpm3VI7wgloat0NA13OjVz73wINU7pGE=;
 b=KL/pcjN8qCMWx881y24JdmldopDgs6LZaBfUpsS5EcywzMYRdZxr1p2HNZEF3k6WnAc+v8
 eTggoW7AHNiA7+Bzhq0c0x29GMo5MHNkUthMbnImBfD0G8RnJrYxLWz6ls1+POJZP/5Q8P
 NE44i3FFdGUh8Zbf4HWZQQWhmw7DqtQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-UCTIr86_MayzM6KHWOFYpQ-1; Mon, 10 Mar 2025 06:08:29 -0400
X-MC-Unique: UCTIr86_MayzM6KHWOFYpQ-1
X-Mimecast-MFC-AGG-ID: UCTIr86_MayzM6KHWOFYpQ_1741601308
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abf7171eaf2so404340166b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741601308; x=1742206108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52o2P25rC28Zpm3VI7wgloat0NA13OjVz73wINU7pGE=;
 b=C72uVhORdVAar0PpVFZ+xC3VPK5sTTnJGWSAmxqN7gEq4hMVB7H+kQp1t9zsHVlOJZ
 NC1n36jQbA6Tr5UiD7SmhsKCDGxoExvifTkZoGLvlmgBuyxzaHms2Ob2cCGpkb9CL8pj
 DiGhRWbLUl5zUcBPY2CtgVrQMdag/VVebjdZqb/ZLSf6fgLNknmfoj7cQHIuv/iTMrZS
 EdpbXdnU8F1bwT4WGsXl4wPUR0qMchnFkZgO0GMzNdI9ht4+9Snb6NGVW45Bt1TOEqah
 rK+DcktaQrUtwWXr2ePD1d+AQYmktueCKfstklXHglyEywIQjsH7ErM9oiGQeHlcmbJ3
 fBpQ==
X-Gm-Message-State: AOJu0YwsNlcSAtGW+Eyfyk6+omfTtBYTtSVi8odFj2KYWtufyeBoSQrz
 YzUkJnmAHR9mPF3lfQx1H8eGPnS7P4Z/FksBBuiBW+Fsa248dSVN5dGQTEZsWg6YrTpsH4aK6dA
 t9cnFfAQxCa2CQ4V+RWK4DvG0Gn9e4WsfKZ9NT2TsLALZr2rPqTq38fZO3mQYhz82klDGtMZ7wZ
 LmcQMNQFU0nhqys5ovy2Xp8vNXV/s=
X-Gm-Gg: ASbGnct+yVkqgEWei9vGXExsv2qzI+FK/pMl6dfjTRviRZg4Or5kiylynk2AaMDY6IA
 EzecXV532FF09WJ+HOc+vtKPlScbzFSj0TIUJbiGd2BRsyM/p11ryurkX4cHCfaIkLxN8f9uybg
 ==
X-Received: by 2002:a17:907:3f2a:b0:abf:5fa3:cf96 with SMTP id
 a640c23a62f3a-ac252a879d7mr1239950866b.14.1741601308157; 
 Mon, 10 Mar 2025 03:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuUnUSKhCfzQbJvrdTlad7XwxPqx9RpIJMknp1mQxfDVlCTkmSK+Eo/K9BmOfawPGtxJi1YrFAFyjMCDObKUM=
X-Received: by 2002:a17:907:3f2a:b0:abf:5fa3:cf96 with SMTP id
 a640c23a62f3a-ac252a879d7mr1239947266b.14.1741601307729; Mon, 10 Mar 2025
 03:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
In-Reply-To: <20250309090708.3928953-1-haoqian.he@smartx.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 10 Mar 2025 18:07:51 +0800
X-Gm-Features: AQ5f1JobDMyCKZ7Uv8P13FpXzRMkJG8pXM_elCpyqlp6kJ_2uR8UpfFe_NACc94
Message-ID: <CAPpAL=x4PpDa4c2fDZ43UGjqY1KF-vm9_1J-pUk3z-A1omxYzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost: fix the IO error after live migration
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, fengli@smartx.com, yuhua@smartx.com, 
 Raphael Norwitz <raphael@enfabrica.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Mar 9, 2025 at 5:09=E2=80=AFPM Haoqian He <haoqian.he@smartx.com> w=
rote:
>
> At the end of the VM live migration, the vhost device will be stopped.
> Currently, if the vhost-user backend crash, vhost device's set_status()
> would not return failure, live migration won't perceive the disconnection
> with the backend. After the live migration is successful, the stale infli=
ght
> IO would be submitted to the migration target host, which may leading to
> the IO error.
>
> The following patch series fixes the issue by making the live migration
> aware of the lost of connection with the vhost-user backend and aborting
> the live migration.
>
> Haoqian He (3):
>   virtio: add VM state change cb with return value
>   vhost: return failure if stop virtqueue failed in vhost_dev_stop
>   vhost-user: return failure if backend crash when live migration
>
>  hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
>  hw/block/virtio-blk.c                 |  2 +-
>  hw/core/vm-change-state-handler.c     | 14 +++++++------
>  hw/scsi/scsi-bus.c                    |  2 +-
>  hw/scsi/vhost-scsi-common.c           | 11 +++++-----
>  hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
>  hw/vfio/migration.c                   |  2 +-
>  hw/virtio/vhost.c                     | 27 ++++++++++++++-----------
>  hw/virtio/virtio.c                    | 25 ++++++++++++++++-------
>  include/hw/virtio/vhost-scsi-common.h |  2 +-
>  include/hw/virtio/vhost.h             |  8 +++++---
>  include/hw/virtio/virtio.h            |  1 +
>  include/system/runstate.h             | 11 +++++++---
>  system/cpus.c                         |  4 ++--
>  system/runstate.c                     | 25 ++++++++++++++++++-----
>  15 files changed, 115 insertions(+), 68 deletions(-)
>
> --
> 2.48.1
>
>


