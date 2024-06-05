Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC07C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElWX-0006px-37; Wed, 05 Jun 2024 03:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sElWV-0006pi-Fe
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sElWT-0004vE-DI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717574248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AZEdKeDV6It+lG/VoCMIa73B0kziRqa48QTZ9z2H54=;
 b=FUnLF2QwONCqyBbg+EoA9LLGJYP6KXUEA9by+hlz4lEp+gwrG6DougfYS0ajbloE237ext
 JmRcjLA0jLLT+DS05hAqx6mXiwcxA68wAS818Hmcdz70GOMIrB/Rn+YjMiKgVHa3IegcGe
 R6hYPYFNjuET/TaVw5OOFAato3J3wfg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Dpi2-SIZOaCHknKO4NP-yw-1; Wed, 05 Jun 2024 03:57:25 -0400
X-MC-Unique: Dpi2-SIZOaCHknKO4NP-yw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so69858966b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574244; x=1718179044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AZEdKeDV6It+lG/VoCMIa73B0kziRqa48QTZ9z2H54=;
 b=J3a0+YuW1EXeCMy7OCrjkiQWGbT7GV4u9fHuZ3hG7ddsjk3rcNNDkLh1xqoLsM+MZ6
 LQ5I7pfgFSCpPc2DQpsHPU8lynKXtvk9470XUVp6Btz3c8KVf1RKBom5BoUOKDTOZarM
 59syxxBjfaIWHtzKNFfv32f02f8SjmFFFlaYQLABWM2SVDEFSKhDDciKtklp+lZ2c13t
 VLMoiD5bmJ7Wq9RLzoz8NTggGi1OfiICJhEYntdZfCnMsaq4aGYnWDK3JOdBifQn77sb
 iqCB20w1cZo1exnayfowMcbK6iQa4kjh8MysYBpHCdFvssYnfCCkRQJtysARfQMh3vGT
 URxw==
X-Gm-Message-State: AOJu0Yx/J4wBQoBwVIWU8ETFPGgSIxsqprJm18vVAyl2oK7FBbwCvhRO
 XgPfQWJCZb1qHwImvgyc907D3d377juk8W2nS50aHRD0zeCYNzJ4kZOU1lT34GOrpxFsWBN45qK
 wQX5Vn6H7+QcY0aBxQDYSKxiEl+QwfYvXWH+BK5qwGwEZBkfmSxrz
X-Received: by 2002:a17:906:e293:b0:a68:b073:14a5 with SMTP id
 a640c23a62f3a-a695425e2e8mr382008866b.9.1717574244303; 
 Wed, 05 Jun 2024 00:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo86eY/+NYIWpLgLobm7VEbFCXsxnF8uUvdSLuT2MbMA7sHu6ghdGJJjiI3cCrT2mvWig16w==
X-Received: by 2002:a17:906:e293:b0:a68:b073:14a5 with SMTP id
 a640c23a62f3a-a695425e2e8mr382007766b.9.1717574243761; 
 Wed, 05 Jun 2024 00:57:23 -0700 (PDT)
Received: from redhat.com ([2.55.8.167]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68cc45cea7sm548198566b.51.2024.06.05.00.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:57:23 -0700 (PDT)
Date: Wed, 5 Jun 2024 03:57:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com,
 mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com,
 berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com,
 pbonzini@redhat.com, xiexiangyou@huawei.com,
 linux-rdma@vger.kernel.org, lixiao91@huawei.com,
 jinpu.wang@ionos.com, Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240605035622-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
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
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> 
> We have encountered some bugs when using rsocket and plan to submit them to
> the rdma-core community.
> 
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradation,
> hoping that friends with RDMA network cards can help verify, thank you!

So you didn't test it with an RDMA card?
You really should test with an RDMA card though, for correctness
as much as performance.


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


