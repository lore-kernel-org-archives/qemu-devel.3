Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B57BC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 05:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueonf-0000J7-Fe; Thu, 24 Jul 2025 01:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ueonO-0000HD-6K
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 01:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ueonL-0007aB-GO
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 01:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753336024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqixnRsWNJFb9DxT6PW1Lt0vY/3Dm/N2n3LatiyeHeQ=;
 b=KbJ+OPo2i9A0TQagTS0HSHWWGobojUOAtIVcteiL/hWE/QaptC64oxe7y+T76PyJJ9A5vV
 U4WDThTiBpjyz8PXakX+G8V1QSKIaBgox/jBg45IgVk0JJYcjw34wUE8DfhQvH7N8HOFag
 GhDvWnkbBxqYH30L2qXdPhJG5eVgYJA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-SMCtim35PDKtiWHzq_nZzA-1; Thu, 24 Jul 2025 01:47:02 -0400
X-MC-Unique: SMCtim35PDKtiWHzq_nZzA-1
X-Mimecast-MFC-AGG-ID: SMCtim35PDKtiWHzq_nZzA_1753336021
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-af4f3e4514dso14493366b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 22:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753336021; x=1753940821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqixnRsWNJFb9DxT6PW1Lt0vY/3Dm/N2n3LatiyeHeQ=;
 b=XZBuqUQTz+UDUHhJ/iG2CUaz1R3pcuVMfCGpkbeXjEOUkuZDxCfucFNr9+43kn4tzK
 RjO+U6VYM6VtSe7UR91lx5eBej6pstpmeBakD4l8fDWuSTeLHm39P3CDf362tloPBLn5
 xz8JEw/2NV1TtftiivKKtPq4nbilJJXv892yxNZ03aGrYLyfHoU6kJxVxgeiJfXZYMfO
 4GyVssPbGyMkxjXflo6/flh3cES6DGoYyD5qDmCIZ+nM4m6jmLWNcFSpIRsMQ0HIylP+
 l4/8rD3Yiw2rkLcrWSUmewCi1QoPm5xe0PhvXfUgpXNLXvYKiPCGHyq6TjLaQ4cfGjcY
 7/Gg==
X-Gm-Message-State: AOJu0Ywqh0NDJ9irP330CcAnZ2tJsbYbXu+zLfpUZR9t1XHwoBxjqTl1
 LCRrghhPjVZUKXFdLD8tp0mpu7WYvtBNs5CDJVUenfcWfiRTTMIqZnWJQF37OwWHmaJoil7ZuS2
 xhMjtcTSZxBm3/84+lzktYDx9Vm2ay1sPer6+dN0PbBYGgiKSNwpt97qNua83dzfbxTOwyP5M9K
 /EpU5dN/5nMYw6W80BvAJO97uWvWIZBFs=
X-Gm-Gg: ASbGnctOitxq/sSOky6TsQmXiYrj2vF09akdeoWWAFR0sudd9WI9xtP/fAYGpYwuTQR
 qHeVV5f/DrMSDTrOxtWqx1wRdEcbA7qKWVHE8ojLDWmZ00Xpg4P6aXTSepZCq8Uq9ZMy4NsTT16
 f+4cTVr3WhIB/cf2SfuMJ3sw==
X-Received: by 2002:a17:907:7211:b0:aec:6e14:25fa with SMTP id
 a640c23a62f3a-af2f92788f9mr563203966b.55.1753336020997; 
 Wed, 23 Jul 2025 22:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpt4SLdliGZw2zE1IxzjIpnAgS4qXAa4cH81p6+2qLOm3qprQOYhM2DrJ0WA0CFA+Qnt0gabJ4mzpejEW3gu8=
X-Received: by 2002:a17:907:7211:b0:aec:6e14:25fa with SMTP id
 a640c23a62f3a-af2f92788f9mr563201966b.55.1753336020609; Wed, 23 Jul 2025
 22:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <CAPpAL=y=2os30kCA4_MCMT8OdE3PqGZdg7oBPeS8SKCN0heMrg@mail.gmail.com>
In-Reply-To: <CAPpAL=y=2os30kCA4_MCMT8OdE3PqGZdg7oBPeS8SKCN0heMrg@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 24 Jul 2025 13:46:24 +0800
X-Gm-Features: Ac12FXybIcSl5vxyNHX_dqL8khUZHXDL8xFw6g5rHGzDVFdNBGPQb4aMM8MTrOo
Message-ID: <CAPpAL=wBma8Gg=n=Pkk0DE-kRktE58KiOXfokNGRzMuGx0Ct7g@mail.gmail.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

On Fri, Jul 18, 2025 at 4:48=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Steve
>
> I tested your patch which hit a problem under enable/disable nic mq
> state(The full test scenario is live migration vm at local under
> enable/disable vm nic mq state):
> Run command: /qemu-img info /home/images/vm1.qcow2 --output=3Djson
> Error info: qemu-img: Could not open '/home/images/vm1.qcow2': Failed
> to get shared "write" lock
>
> In the same environment if I remove the enable/disable nic mq steps,
> it can work well.
>
> Note: This issue has not been reproduced 100%, but in order to confirm
> this is really a bug, I test the following:
> 1. Live migration vm at local under enable/disable nic mq state: 3/5
> reproduce ratio
> 2. Only live migration 5 times are all passed.
>
After double confirm tests, the above mentioned problem should not be
related to the current series of patches, because I also hit this
problem after multiple tests using the upstream master branch.

Tested-by: Lei Yang <leiyang@redhat.com>
> Thanks
> Lei
>
> On Fri, Jul 18, 2025 at 4:48=E2=80=AFAM Steve Sistare <steven.sistare@ora=
cle.com> wrote:
> >
> > Tap and vhost devices can be preserved during cpr-transfer using
> > traditional live migration methods, wherein the management layer
> > creates new interfaces for the target and fiddles with 'ip link'
> > to deactivate the old interface and activate the new.
> >
> > However, CPR can simply send the file descriptors to new QEMU,
> > with no special management actions required.  The user enables
> > this behavior by specifing '-netdev tap,cpr=3Don'.  The default
> > is cpr=3Doff.
> >
> > Steve Sistare (8):
> >   migration: stop vm earlier for cpr
> >   migration: cpr setup notifier
> >   vhost: reset vhost devices for cpr
> >   cpr: delete all fds
> >   Revert "vhost-backend: remove vhost_kernel_reset_device()"
> >   tap: common return label
> >   tap: cpr support
> >   tap: postload fix for cpr
> >
> >  qapi/net.json             |   5 +-
> >  include/hw/virtio/vhost.h |   1 +
> >  include/migration/cpr.h   |   3 +-
> >  include/net/tap.h         |   1 +
> >  hw/net/virtio-net.c       |  20 +++++++
> >  hw/vfio/device.c          |   2 +-
> >  hw/virtio/vhost-backend.c |   6 ++
> >  hw/virtio/vhost.c         |  32 +++++++++++
> >  migration/cpr.c           |  24 ++++++--
> >  migration/migration.c     |  38 ++++++++-----
> >  net/tap-win32.c           |   5 ++
> >  net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++---=
--------
> >  12 files changed, 223 insertions(+), 55 deletions(-)
> >
> > --
> > 1.8.3.1
> >
> >


