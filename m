Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF38C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 05:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueSOK-0001Es-1t; Wed, 23 Jul 2025 01:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSOE-00019s-67
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSOC-00048u-8s
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753249899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkuXVzYWSZx7vBCj9BEWaK01+ex46WNWZnzX0HM+zK4=;
 b=WbLhjMiLP9RhTu9wwoXo6jUKwfLMCvz/D7CMB1x+L5DeK97H9Ak3xvjP/Fz9w3y51QAY85
 I7J1fpfnwjeasCxoYId8ph1sRJGbohq7qHpc3AZDI5RrUnPq/hEBqfAKymJpJraU+9A5bU
 BEqsB60o8KzIhyoohKhqdRHo0Ui8g3U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-5uVRhM19MoeY1ouTwX4G7g-1; Wed, 23 Jul 2025 01:51:37 -0400
X-MC-Unique: 5uVRhM19MoeY1ouTwX4G7g-1
X-Mimecast-MFC-AGG-ID: 5uVRhM19MoeY1ouTwX4G7g_1753249897
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b2fa1a84566so4895877a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 22:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753249897; x=1753854697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkuXVzYWSZx7vBCj9BEWaK01+ex46WNWZnzX0HM+zK4=;
 b=T7kMnJYUzCt6sOzGajqvDKNojEAlYywJlb/4aSzYX1fWiA4jtHhZngAcRdgVfwGBX8
 h/qb6Ygz815zWttToFsjgZzwuiEkuDAD543Eiu5qBiO8JASA5LFjx1BoMSzl6CNaIz8p
 gtU2GAW7tjJ4UUXMFs8aCg8oxpUYiv1tzVb5k+RFV9+IwPvaBCfLFE6gwGFiSIWb6CRV
 28TsBzUjYpe/KBgmI2RGFwahvOvpKb+wR3FFGZOR/nPRsvX9HQmnknOiD2jofWuA/mVU
 5LZjmx+x6nJfCw55WME7Tt9DsRvrSPXT+4mXGJ9iOqRZmx9KtBqy6LX7EMxEHF9OPTac
 q+Kg==
X-Gm-Message-State: AOJu0Yy/QS+9ygkRwQyVjeUnRLypJXdmESioRkriLKTo6V5ycEqi9KVI
 BFOY15TOuUG5KxnzVEifkxP3x9Wc5Z4C1cKGQNXK5bwRk34G0Oe79BXwg9tYIpRIh5vQO125mCj
 C80yBylui/Pb1Va3ShcKxMxzjjk4nQ+PLoj5iXWxz8PTMKr29eWng+4Ziz62Qnts/eNn0wiQDff
 zgXevzZAcpATqnSoDr1GmH6O2yACjapsM=
X-Gm-Gg: ASbGncue9aUJWyKUc4Bxxo9qGK6NEPC4/WFy26qSRFq7PSfH4taBPVkYDh6SU5wdseS
 j9mVxaouJGmkVZCDt4GqHmEduE1xWPG40+2PcL4dPhO5CXmIejrCYJCfX0wMQtw6+BE21PjL3av
 h9X7lGW0IAzeIyaXqT9Tc=
X-Received: by 2002:a17:90a:e183:b0:313:15fe:4c13 with SMTP id
 98e67ed59e1d1-31e507ce7f7mr2995853a91.27.1753249896771; 
 Tue, 22 Jul 2025 22:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEckhE9pzmqdvIFLYXJbyJc/GaNssOWaLuGEFK3ZEYAo0G5ulsyLbxZZVU9t2x1CttEn9Yjvc4JQgwe8/kbdhY=
X-Received: by 2002:a17:90a:e183:b0:313:15fe:4c13 with SMTP id
 98e67ed59e1d1-31e507ce7f7mr2995813a91.27.1753249896300; Tue, 22 Jul 2025
 22:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
In-Reply-To: <20250722124127.2497406-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:51:25 +0800
X-Gm-Features: Ac12FXwUSAr9QOWIx2LJqBzEpl3D5UZKec83cZsftPcD4lsGrMGIkxatkFbi4vA
Message-ID: <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, mst@redhat.com, si-wei.liu@oracle.com, 
 eperezma@redhat.com, boris.ostrovsky@oracle.com
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

On Tue, Jul 22, 2025 at 8:41=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> This series is an RFC initial implementation of iterative live
> migration for virtio-net devices.
>
> The main motivation behind implementing iterative migration for
> virtio-net devices is to start on heavy, time-consuming operations
> for the destination while the source is still active (i.e. before
> the stop-and-copy phase).

It would be better to explain which kind of operations were heavy and
time-consuming and how iterative migration help.

>
> The motivation behind this RFC series specifically is to provide an
> initial framework for such an implementation and get feedback on the
> design and direction.
> -------
>
> This implementation of iterative live migration for a virtio-net device
> is enabled via setting the migration capability 'virtio-iterative' to
> on for both the source & destination, e.g. (HMP):
>
> (qemu) migrate_set_capability virtio-iterative on
>
> The virtio-net device's SaveVMHandlers hooks are registered/unregistered
> during the device's realize/unrealize phase.

I wonder about the plan for libvirt support.

>
> Currently, this series only sends and loads the vmstate at the start of
> migration. The vmstate is still sent (again) during the stop-and-copy
> phase, as it is today, to handle any deltas in the state since it was
> initially sent. A future patch in this series could avoid having to
> re-send and re-load the entire state again and instead focus only on the
> deltas.
>
> There is a slight, modest improvement in guest-visible downtime from
> this series. More specifically, when using iterative live migration with
> a virtio-net device, the downtime contributed by migrating a virtio-net
> device decreased from ~3.2ms to ~1.4ms on average:

Are you testing this via a software virtio device or hardware one?

>
> Before:
> -------
> vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-net
>   instance_id=3D0 downtime=3D3594
>
> After:
> ------
> vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-net
>   instance_id=3D0 downtime=3D1607
>
> This slight improvement is likely due to the initial vmstate_load_state
> call "warming up" pages in memory such that, when it's called a second
> time during the stop-and-copy phase, allocation and page-fault latencies
> are reduced.
> -------
>
> Comments, suggestions, etc. are welcome here.
>
> Jonah Palmer (6):
>   migration: Add virtio-iterative capability
>   virtio-net: Reorder vmstate_virtio_net and helpers
>   virtio-net: Add SaveVMHandlers for iterative migration
>   virtio-net: iter live migration - migrate vmstate
>   virtio,virtio-net: skip consistency check in virtio_load for iterative
>     migration
>   virtio-net: skip vhost_started assertion during iterative migration
>
>  hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++------
>  hw/virtio/virtio.c             |  32 +++--
>  include/hw/virtio/virtio-net.h |   8 ++
>  include/hw/virtio/virtio.h     |   7 +
>  migration/savevm.c             |   1 +
>  qapi/migration.json            |   7 +-
>  6 files changed, 247 insertions(+), 54 deletions(-)
>
> --
> 2.47.1

Thanks

>


