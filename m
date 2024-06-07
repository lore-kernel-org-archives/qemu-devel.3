Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3624C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 05:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSXz-00044b-La; Fri, 07 Jun 2024 01:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sFSXw-000449-9V
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 01:53:53 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sFSXt-0002WQ-Sy
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 01:53:52 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe639a5so2026497a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1717739625; x=1718344425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRzi2U/aGEWVOu13r3wPYJj/enOLXzMocY1cfz2tIJw=;
 b=ZAZjX2LTQldyytw8bBSi2x6KlaxLL2VJakfnq8igS13NFv5x1WpLkBAHbmuDTuKCa3
 +T+eaB+w6fUMV0pxymfBxSj+yfwqGkB4bdBW2RAQ5MyrAIGVgUETRmXtfQP2FEveBeh1
 VEOQgxRlgd6SJDG5UGqPkv8mT7IaVIf569mcR4UZQb/JMmqSGQ9eq6OA5Oj9iTEPppC2
 x4vU14OfXUUR7/pkeNn1FMM4q82XJMzP8gMYqUWF+DuIXwp18JwQJ4ox2ccrc7e5jqUp
 wC39jaT+U2jJhm8cRiUAPvfJGyMj3IK+bZea5GC61DStiZ9pUdKrMFsX0Avcl9ZIyUeO
 Cg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717739625; x=1718344425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRzi2U/aGEWVOu13r3wPYJj/enOLXzMocY1cfz2tIJw=;
 b=TMqiOrK79V8bb/+shIaF1nltwku9j/XlTO9C+fJJ4xo+Bb/mB2Qy/MsZmbJ2iBJkVh
 g5fq/lia4bsjNAfWJYmC81X7Nw4d69OBRfi5a99YwyY1dxuZ141RBMCgk3EriziBjy6c
 IZMQeprJKN8rEQv8VurqRZupn/zfPaDLlwxSZgkEpVNG/Hmyik7mftICeaYMQtUtNclu
 ljvng0EDmLtoFBWInAFrEExl+Y5S8mzj7ck2kIFSompRXIyEaK1i9VZMkMK52YnzHdxn
 EznNP/LcEPwpD1O375NBs/oWmFyR+VuVuLN5iVJ59aPeuEX3qQ6HIQDepe+DYvRS9gvf
 Kz5Q==
X-Gm-Message-State: AOJu0Yxqfi4/buTasQlVrJpin6AqWJ5wCnQJTi6R40GnWa+1e9AhlPHJ
 VDHudR6mDBprnocU2fFELMQAS0weI76o90NM8hpVzMqj90uIg30eFIVHV3sar84RCFjuGXHtGdZ
 H5Wo33G26zBFWOhw6j/4l/a4dGMLg5TGYJwH82Q==
X-Google-Smtp-Source: AGHT+IELw58JibX99xmkcVEIIyx5rwz/M9lBuMjWpNn/fhzqVwwVM822hkEfekIqEgdaEN35EH9XLbQsv9Y6Ex/K9j4=
X-Received: by 2002:a50:d791:0:b0:57a:33a5:9b78 with SMTP id
 4fb4d7f45d1cf-57c50999129mr723574a12.34.1717739625569; Thu, 06 Jun 2024
 22:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 7 Jun 2024 07:53:34 +0200
Message-ID: <CAMGffEkUd2EOS3+PQ9Yfp=8V1pZB_emo7gcmxmvOX=iWVG6Axg@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com, 
 mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com, 
 berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com, 
 pbonzini@redhat.com, mst@redhat.com, xiexiangyou@huawei.com, 
 linux-rdma@vger.kernel.org, lixiao91@huawei.com, 
 Jialin Wang <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52e;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Gonglei, hi folks on the list,

On Tue, Jun 4, 2024 at 2:14=E2=80=AFPM Gonglei <arei.gonglei@huawei.com> wr=
ote:
>
> From: Jialin Wang <wangjialin23@huawei.com>
>
> Hi,
>
> This patch series attempts to refactor RDMA live migration by
> introducing a new QIOChannelRDMA class based on the rsocket API.
>
> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> detail of rdma protocol into rsocket and allows us to add support for
> some modern features like multifd more easily.
>
> Here is the previous discussion on refactoring RDMA live migration using
> the rsocket API:
>
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.o=
rg/
>
> We have encountered some bugs when using rsocket and plan to submit them =
to
> the rdma-core community.
>
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradatio=
n,
> hoping that friends with RDMA network cards can help verify, thank you!
First thx for the effort, we are running migration tests on our IB
fabric, different generation of HCA from mellanox, the migration works
ok,
there are a few failures,  Yu will share the result later separately.

The one blocker for the change is the old implementation and the new
rsocket implementation;
they don't talk to each other due to the effect of different wire
protocol during connection establishment.
eg the old RDMA migration has special control message during the
migration flow, which rsocket use a different control message, so
there lead to no way
to migrate VM using rdma transport pre to the rsocket patchset to a
new version with rsocket implementation.

Probably we should keep both implementation for a while, mark the old
implementation as deprecated, and promote the new implementation, and
high light in doc,
they are not compatible.

Regards!
Jinpu



>
> Jialin Wang (6):
>   migration: remove RDMA live migration temporarily
>   io: add QIOChannelRDMA class
>   io/channel-rdma: support working in coroutine
>   tests/unit: add test-io-channel-rdma.c
>   migration: introduce new RDMA live migration
>   migration/rdma: support multifd for RDMA migration
>
>  docs/rdma.txt                     |  420 ---
>  include/io/channel-rdma.h         |  165 ++
>  io/channel-rdma.c                 |  798 ++++++
>  io/meson.build                    |    1 +
>  io/trace-events                   |   14 +
>  meson.build                       |    6 -
>  migration/meson.build             |    3 +-
>  migration/migration-stats.c       |    5 +-
>  migration/migration-stats.h       |    4 -
>  migration/migration.c             |   13 +-
>  migration/migration.h             |    9 -
>  migration/multifd.c               |   10 +
>  migration/options.c               |   16 -
>  migration/options.h               |    2 -
>  migration/qemu-file.c             |    1 -
>  migration/ram.c                   |   90 +-
>  migration/rdma.c                  | 4205 +----------------------------
>  migration/rdma.h                  |   67 +-
>  migration/savevm.c                |    2 +-
>  migration/trace-events            |   68 +-
>  qapi/migration.json               |   13 +-
>  scripts/analyze-migration.py      |    3 -
>  tests/unit/meson.build            |    1 +
>  tests/unit/test-io-channel-rdma.c |  276 ++
>  24 files changed, 1360 insertions(+), 4832 deletions(-)
>  delete mode 100644 docs/rdma.txt
>  create mode 100644 include/io/channel-rdma.h
>  create mode 100644 io/channel-rdma.c
>  create mode 100644 tests/unit/test-io-channel-rdma.c
>
> --
> 2.43.0
>

