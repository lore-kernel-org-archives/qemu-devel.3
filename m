Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF883CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 15:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7bUm-0007at-4P; Sat, 11 Oct 2025 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v7bUk-0007aV-FL
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 11:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v7bUf-0004GY-Lv
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 11:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760196405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raYUQ25sWonJEhoWeJL6N3AgrsHV98Ws8xF5NzVMhlo=;
 b=aaxIlOtOoAWyop/S13j0dHZaDwh4hYr5Wwq8u0IqM8Xo6uUQh0FiQXseLnnRBnQi7qrq8W
 yMxtUYezC2Q5fBd45ZRCGHNyEMMWUFp9YgiI4I/jyQ1iWZFXP2GBAqyasXaChdnTESP7Gk
 IbTUD/SmnnWix80veXDV1gzRt6UNeso=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Sr53_wXRNtuPvgD7SJmSxA-1; Sat, 11 Oct 2025 11:26:44 -0400
X-MC-Unique: Sr53_wXRNtuPvgD7SJmSxA-1
X-Mimecast-MFC-AGG-ID: Sr53_wXRNtuPvgD7SJmSxA_1760196403
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b504dd6dbf1so248460366b.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760196403; x=1760801203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=raYUQ25sWonJEhoWeJL6N3AgrsHV98Ws8xF5NzVMhlo=;
 b=QfFlqK728NTQKb6lkTZxx2k/8goUiDS1Ut1n6ultJHYZA3AFxDcG+vjYBfY4pU5CWM
 F5dRmPD2vctBF/A2RDHZ0kb7kVUvxJwJNhhQ07R+1rgUNOq1R4wTPKj7x7edrVQtDJbq
 NKGSZrqrPR3o7pS/B6QsuqSZxZ6pQQDMdbqom87m7ucsIRAqyXGyC3Ya34cCfeSVdWBj
 lTREkpQli55u0jWY7yJEOEWXkxio/LS0fdKqc80YpEx75ZKxnZ1wzG6/i2GXpxOQX9rl
 JnOOTFGe4GTAQ6guGp78evGlKin+26uUUoKfQTrqul30gx015FF91DarQ8cjsZfGl3WF
 i3jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfpHKDUt6sbrdvIHgPrvBad7kibhQd8ZcMFw4xzzvOsX302flyTWRT0daBDsAkNV8WIZBNgx9P5/xn@nongnu.org
X-Gm-Message-State: AOJu0YwAmGpKHP6v4dale0/btcxTODziWiYutn69KdyA5RV7kIEj4Czp
 UMDZ0mwrL2Gw4Yhd3oOw0m2QDTj3Ec0umpwnD2BjbUHvbQXxhMGlqKo04Ngp8zyoRsRzEmpLyI4
 awClMXFOdl/h748BUkTjIckcKgZNZ3Cij2qM2clz4ho2tcJ9NlGzH8Vit/wMFEeYUUXMzd/k3sQ
 PxbuGbm6G2QB3KCqbUiei9uIWcgCjuNuU=
X-Gm-Gg: ASbGnct/lSjbOXB0JUl7sxR4xRe0TKId50PFwemInCnIWbHXTZurwhNpbWkcbBJBjNR
 RsgyXPz0XTBU5smc1z42n3FYglCjnq8xi+Hf+JAZhpeKF7TUyz0lSapMyr2F7T5XDSFT+oxHLT2
 vQWCUzixZZfpLO40jDo0fvVQ==
X-Received: by 2002:a17:907:26c5:b0:b3b:f19:ac7c with SMTP id
 a640c23a62f3a-b50aba9e59bmr1365430666b.36.1760196402966; 
 Sat, 11 Oct 2025 08:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvA1w+77i3PFKYtkvcbs1k7UTGyBTRam31Cn0V4rbe8kGDlZOKKL3wYWedcr4PyYGelagytGuQ4WLQ2G0JVpM=
X-Received: by 2002:a17:907:26c5:b0:b3b:f19:ac7c with SMTP id
 a640c23a62f3a-b50aba9e59bmr1365428966b.36.1760196402569; Sat, 11 Oct 2025
 08:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 11 Oct 2025 23:26:06 +0800
X-Gm-Features: AS18NWAbzUcTFED3b2Jyw2iriaj8XulFVhglgRzr11LLowngPhb25_4wHlpF49o
Message-ID: <CAPpAL=zGHDwYCbeEw_9cg0uQbWZWxSxkztbW0HUa8sEi1PA0uw@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] virtio-net: live-TAP local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, farosas@suse.de, 
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, 
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org, 
 michael.roth@amd.com, steven.sistare@oracle.com, davydov-max@yandex-team.ru, 
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Oct 11, 2025 at 1:40=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is a new migration parameter backend-transfer, which allows to
> enable local migration of TAP virtio-net backend, including its
> properties and open fds.
>
> With this new option, management software doesn't need to
> initialize new TAP and do a switch to it. Nothing should be
> done around virtio-net in local migration: it just migrates
> and continues to use same TAP device. So we avoid extra logic
> in management software, extra allocations in kernel (for new TAP),
> and corresponding extra delay in migration downtime.
>
> v7:
>
> 01-13,18: r-b by Maxim Davydov
>           t-b by Lei Yang
>
> 05: fix tap->script to tap->downscript
> 07: tiny rebase conflict around "NetOffloadsd ol =3D {}"
>
> 14: reworked to vmsd handler
>     tap is migrated inside virtio-net. And we support backend-transfer
>     only for virtio-net+tap. So, it's better to support initialization
>     postponing directly in virtio-net, the code is simplified, and we
>     don't have to manage global list of taps.
>
> 15: reworked on top of 14
>
> 16: - drop QAPI_LIST_CONTAINS macro
>     - improve commit message
>     - improve QAPI documentation comments
>
> 17: - don't add extra check into virtio_net_update_host_features(),
>       as we now can call it only when needed (more explicit logic)
>     - drop extra includes
>     - no need in "attached_to_virtio_net" variable anymore
>     - add .has_tunnel to the state
>
> 19: add also test-cases for TAP migration without backend-transfer
>     (to be sure, that we don't break it with new feature:)
>
> Vladimir Sementsov-Ogievskiy (19):
>   net/tap: net_init_tap_one(): drop extra error propagation
>   net/tap: net_init_tap_one(): move parameter checking earlier
>   net/tap: rework net_tap_init()
>   net/tap: pass NULL to net_init_tap_one() in cases when scripts are
>     NULL
>   net/tap: rework scripts handling
>   net/tap: setup exit notifier only when needed
>   net/tap: split net_tap_fd_init()
>   net/tap: tap_set_sndbuf(): add return value
>   net/tap: rework tap_set_sndbuf()
>   net/tap: rework sndbuf handling
>   net/tap: introduce net_tap_setup()
>   net/tap: move vhost fd initialization to net_tap_new()
>   net/tap: finalize net_tap_set_fd() logic
>   migration: introduce .pre_incoming() vmsd handler
>   net/tap: postpone tap setup to pre-incoming
>   qapi: add interface for backend-transfer virtio-net/tap migration
>   virtio-net: support backend-transfer migration for virtio-net/tap
>   tests/functional: add skipWithoutSudo() decorator
>   tests/functional: add test_x86_64_tap_migration
>
>  hw/net/virtio-net.c                           | 150 ++++++-
>  include/migration/vmstate.h                   |   1 +
>  include/net/tap.h                             |   5 +
>  migration/migration.c                         |   4 +
>  migration/options.c                           |  33 ++
>  migration/options.h                           |   2 +
>  migration/savevm.c                            |  15 +
>  migration/savevm.h                            |   1 +
>  net/tap-bsd.c                                 |   3 +-
>  net/tap-linux.c                               |  19 +-
>  net/tap-solaris.c                             |   3 +-
>  net/tap-stub.c                                |   3 +-
>  net/tap-win32.c                               |  11 +
>  net/tap.c                                     | 425 +++++++++++++-----
>  net/tap_int.h                                 |   3 +-
>  qapi/migration.json                           |  42 +-
>  tests/functional/qemu_test/decorators.py      |  16 +
>  tests/functional/test_x86_64_tap_migration.py | 396 ++++++++++++++++
>  18 files changed, 1001 insertions(+), 131 deletions(-)
>  create mode 100644 tests/functional/test_x86_64_tap_migration.py
>
> --
> 2.48.1
>


