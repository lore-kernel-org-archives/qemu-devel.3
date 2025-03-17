Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE9FC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu6yZ-0003GR-7n; Mon, 17 Mar 2025 05:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tu6yX-0003Fb-7w
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tu6yV-0006o3-BM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742204492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzhdwtJEUenVDmTXktA9sItAz8Kq5AgaNcpeNF/lFo8=;
 b=bHAEkYsiPGStNKdrtYw3/36AUIbuur6mc1sJIb361TNinW4ZWeqwwcrwjoy+rY9sryJSZC
 VqaLte45lNdClHgwTu3q6wG7QS3WoG4KYMIAAkNlZp1a0To9R/FlK28zzh+7HFsK7oJ8to
 ccmYo4F4V6jNb7zuuBx+IUtoAnVteks=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ldIaoGAGPBOFikQLQqKVtQ-1; Mon, 17 Mar 2025 05:41:30 -0400
X-MC-Unique: ldIaoGAGPBOFikQLQqKVtQ-1
X-Mimecast-MFC-AGG-ID: ldIaoGAGPBOFikQLQqKVtQ_1742204489
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e67df8c373so4473409a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 02:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742204489; x=1742809289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzhdwtJEUenVDmTXktA9sItAz8Kq5AgaNcpeNF/lFo8=;
 b=om+Xh2yUUZpTkF+QuCh2lCVvUUYI2/brPhSsJwQTenD+Wm+onq+bt/qMumun+yc9M6
 4Hte3ai8Y9G5nEGm+FunAGe3ls+Gyrs2f+o8tMheQjPXY5KFWyVM/gLEfGH2imnIMbCq
 miHwswpfRS1NEEC3Le4Miq+iWZZp4nZ/sQOHnTgdc72JgigtE/fyiAnLbH/XuEPVgEUf
 rI5X0o82EoP3dL7HZOUxhaQ26c6YJp8drmRT7foWO6IRnFltWfnpbHoZtcYjTopfHd7B
 6Fxzbo7354hqC46z+n2xFlLG79iNxsemXqWzwwyg5rSwYyjYWU88kCK+PCprUkG7PEEm
 HoZw==
X-Gm-Message-State: AOJu0YxLp9ZqyT7WBvyEJdq+sGvh12dFWXqL7lczaNJtlta2GpnfSvlh
 Ukgb7ubrWHtYWYSVLn8V/LeWBipS+Svr/0GZ8iL2XfyPapE3dJXK3E42hrNKnQY6idyOG8KxToS
 DBKve8dBqjVLKmDqHgXcx6b45UpJDRB40NzVYBtbhy2lYbgnHDIlTVcnGFnRB84wn9OOLSJt5LL
 px3rhwSGnD1iP98zlsS4S1K8prQGA=
X-Gm-Gg: ASbGncvcAb3LOf3Kkbbtm3VJYGmGLlVQuh5A+gyq9XCFEBEgLeZa74Xt62fB0QoA6bZ
 18Sy4JsDWvTY/5/XAfzDJpbY2ITs0ozaAadV9otcPBJMM9L+PZmK/+wVmHBVEeiiDOT23szwwCw
 ==
X-Received: by 2002:a05:6402:42c5:b0:5e6:60da:dc45 with SMTP id
 4fb4d7f45d1cf-5e8a0520618mr9282107a12.31.1742204489229; 
 Mon, 17 Mar 2025 02:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMZ++bbNcahuIpjV91VmvmYZL7d4VWpzOppgHUxXBmD/iWetxioLZBrDSZ4OW+UQoseUNApyl2OVm7TK0MkA4=
X-Received: by 2002:a05:6402:42c5:b0:5e6:60da:dc45 with SMTP id
 4fb4d7f45d1cf-5e8a0520618mr9282084a12.31.1742204488738; Mon, 17 Mar 2025
 02:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 17 Mar 2025 17:40:51 +0800
X-Gm-Features: AQ5f1JqmZlOHofNsBbGsfMG23HCaBUKjYjEVYTASl2tqLTdbnINT5MlSfGturog
Message-ID: <CAPpAL=xCj+=ts8Anq19suBahrbJ_sa62EjDjxhK8kJDnH5T-0g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 00/11] virtio-net: Offload hashing without eBPF
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QE tested this RFC series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 13, 2025 at 2:56=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> I'm proposing to add a feature to offload virtio-net RSS/hash report to
> Linux. This series contain patches to utilize the proposed Linux feature.
> The patches for Linux are available at:
> https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com/
>
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/
>
> Patch "docs/devel/ebpf_rss.rst: Update for peer RSS" provides comparion
> of existing RSS mechanism and the new one (called "peer RSS") and
> explains how QEMU selects one.
>
> ---
> Changes in v4:
> - Rebased.
> - Added a reference to the documentation to the cover letter.
> - Link to v3: https://lore.kernel.org/r/20240915-hash-v3-0-79cb08d28647@d=
aynix.com
>
> ---
> Akihiko Odaki (11):
>       qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
>       net/vhost-vdpa: Report hashing capability
>       virtio-net: Move virtio_net_get_features() down
>       virtio-net: Retrieve peer hashing capability
>       net/vhost-vdpa: Remove dummy SetSteeringEBPF
>       virtio-net: Add hash type options
>       net: Allow configuring virtio hashing
>       virtio-net: Use qemu_set_vnet_hash()
>       virtio-net: Offload hashing without vhost
>       tap: Report virtio-net hashing support on Linux
>       docs/devel/ebpf_rss.rst: Update for peer RSS
>
>  docs/devel/ebpf_rss.rst        |  23 ++-
>  include/hw/qdev-properties.h   |  18 +++
>  include/hw/virtio/virtio-net.h |   6 +-
>  include/net/net.h              |  20 +++
>  net/tap-linux.h                |   2 +
>  net/tap_int.h                  |   3 +
>  hw/core/qdev-properties.c      |  67 ++++++++-
>  hw/net/virtio-net.c            | 331 +++++++++++++++++++++++++++++------=
------
>  net/net.c                      |  14 ++
>  net/tap-bsd.c                  |  10 ++
>  net/tap-linux.c                |  18 +++
>  net/tap-solaris.c              |  10 ++
>  net/tap-stub.c                 |  10 ++
>  net/tap.c                      |  15 ++
>  net/vhost-vdpa.c               |  41 ++++-
>  15 files changed, 478 insertions(+), 110 deletions(-)
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20240828-hash-628329a45d4d
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


