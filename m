Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49840C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLGA-0007cg-5v; Tue, 03 Jun 2025 02:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uMLG2-0007c7-VO
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uMLG0-0003Ov-Ki
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R66+puoHPY9X4tsWAukGiwrmMsHKYtaNXr2bPbSXazY=;
 b=JwKPqaASwJSEE516aoyxks8UHhUHBhwbW8FaasfxaWVZRELKH6xS95U53IPHD6Tr1oORT0
 5zDWJ49+0SiPHz/3h4sRG4dOXD9AXyi/+YyjBTbVekscjI3WQebB4wNnXsQ/uqvcVGH/l1
 u6rb7OlOPa6+R6ToahHhjQyMW9rcvZg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-nPzR0HKsPaCbpJYQvSXRVw-1; Tue, 03 Jun 2025 02:36:14 -0400
X-MC-Unique: nPzR0HKsPaCbpJYQvSXRVw-1
X-Mimecast-MFC-AGG-ID: nPzR0HKsPaCbpJYQvSXRVw_1748932573
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad5697c4537so489583566b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 23:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748932573; x=1749537373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R66+puoHPY9X4tsWAukGiwrmMsHKYtaNXr2bPbSXazY=;
 b=ABcWaFnR8cIlRQOIeYmrxq1a1qLL++yoOnkHdpZOAAjGCVJs2lbbDx0LX/SIen1nWd
 /zzTz/LoX9y8GZfx74KRqwkSuwyqe1dRIXUvAYoBsWV/EpT4XVkZ3mG731GGYbrzE0vC
 4lfNIQEZ7wD8rELxEbE4UiMi/mA2dz+eNyIkLAplwhE74Wgc3cLArxukOCousPVkPel1
 hBGqop7PNfC8QtWF0FSmsPBTAABVFfePLqm/0qaM0AwXoR2Doy7YAoRd7aAyzwIdvE9Q
 S0K+lWuAfgjLZzumUS54kOJ1n8oJOLrzZOv4HEXiWroyiA0e6JVgvoGqi7eX5OzDkCnC
 XyjQ==
X-Gm-Message-State: AOJu0YxaNyxsLAFa55tKK6WDQubZMh4bYK17iiNLvTXqSK6ErrG0uEuG
 IsZLHHVECu5dr1kqEfQledRFk8RzaDD+Uisj4E62ILVWsG6OTJti8wSTlBT5A1vzY79rvdus55u
 bunbc4mnpr3h4YkTIWEHEDl6tSvUrxh79lBobcM3hMagajymLWFqDomWrldKWVHsQMvbD0wnob2
 GG9apg66VI93XLmDfptHLLgLPDQ0n0Yfg=
X-Gm-Gg: ASbGnctSLVKyJe0HUL9Ar7eCY2Ojm8eneZD6weszQ+7mv7sGZnF6hBrMLWbe9ZIERmp
 2cmEI4txV7SoguB/aywE7io6oBKa66SLGOEQoN9nabiDkdzlSmXM4t2DQN72rJBlPc1dtvg==
X-Received: by 2002:a17:906:9fd2:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-adde66cf7fcmr113150066b.24.1748932573201; 
 Mon, 02 Jun 2025 23:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELB4D4LCjP9tgSo/ivRstoVP/3ds2VI/DMx8o/wP64EeWJnYgYvw6TJbNfNpBxK0Gu4MKOSn7esb44iAwIWZw=
X-Received: by 2002:a17:906:9fd2:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-adde66cf7fcmr113148266b.24.1748932572825; Mon, 02 Jun 2025
 23:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
In-Reply-To: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 3 Jun 2025 14:35:35 +0800
X-Gm-Features: AX0GCFsB1BbYb-83gO5ehkKc2zHgUaLmc6aVZGvXXfmA1H5GF5grB68q-cFpLAc
Message-ID: <CAPpAL=ypHiO42XZ0oou6Yz20=9YD=Los_1a9uTFBxT80ssuNSg@mail.gmail.com>
Subject: Re: [PATCH RFC v5 0/5] virtio-net: Offload hashing without eBPF
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested with this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, May 30, 2025 at 12:40=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> I'm proposing to add a feature to offload virtio-net RSS/hash report to
> Linux. This series contain patches to utilize the proposed Linux
> feature. The patches for Linux are available at:
> https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com/
>
> Note that the referenced patches for Linux implement UAPIs that are
> compatible with older versions of this series but not compatible with
> this version. Compatible patches for Linux will be posted shortly.
>
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/
>
> Patch "docs/devel/ebpf_rss.rst: Update for peer RSS" provides comparion
> of existing RSS mechanism and the new one (called "peer RSS") and
> explains how QEMU selects one.
>
> ---
> Changes in v5:
> - Changed UAPIs.
> - Rebased.
> - Link to v4: https://lore.kernel.org/qemu-devel/20250313-hash-v4-0-c75c4=
94b495e@daynix.com
>
> Changes in v4:
> - Rebased.
> - Added a reference to the documentation to the cover letter.
> - Link to v3: https://lore.kernel.org/r/20240915-hash-v3-0-79cb08d28647@d=
aynix.com
>
> ---
> Akihiko Odaki (5):
>       net: Allow configuring virtio hashing
>       virtio-net: Offload hashing to peer
>       virtio-net: Offload hashing without vhost
>       tap: Report virtio-net hashing support on Linux
>       docs/devel/ebpf_rss.rst: Update for peer RSS
>
>  docs/devel/ebpf_rss.rst | 22 ++++++++-----
>  include/net/net.h       | 13 ++++++++
>  net/tap-linux.h         |  4 +++
>  net/tap_int.h           |  4 +++
>  hw/net/virtio-net.c     | 84 ++++++++++++++++++++++++++++++++++++++-----=
------
>  net/net.c               | 11 +++++++
>  net/tap-bsd.c           | 15 +++++++++
>  net/tap-linux.c         | 16 ++++++++++
>  net/tap-solaris.c       | 15 +++++++++
>  net/tap-stub.c          | 15 +++++++++
>  net/tap.c               | 23 ++++++++++++++
>  net/vhost-vdpa.c        | 13 ++++++++
>  12 files changed, 209 insertions(+), 26 deletions(-)
> ---
> base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
> change-id: 20240828-hash-628329a45d4d
> prerequisite-change-id: 20250530-vdpa-2c481c64ce45:v1
> prerequisite-patch-id: a8c36f25d07b2b1a658ec3189bdf8bf12ef5ce8d
> prerequisite-patch-id: 414474fbb325338338f2d84f7065be241c27df2b
> prerequisite-patch-id: 6db7f777008d6d1fae86df2a1fffcd2ddb394e05
> prerequisite-patch-id: 762aad5a811163b3d9326870bb751fbe7853c21c
> prerequisite-patch-id: 9dfcea59addbdebfc1cc8fda26c91ebf21482d21
> prerequisite-patch-id: 3d391c14efe64541a881421735cf9ff04bb69713
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


