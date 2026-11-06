Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E006606A33A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=WLS1Z5gC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP9oG-0005RG-Ue; Thu, 05 Nov 2026 21:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xP9nx-0005Q3-Pe; Thu, 05 Nov 2026 21:35:53 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xP9ns-0005jG-Pl; Thu, 05 Nov 2026 21:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793932538; bh=MtAWZHCAyQBUegViX3TGrp9QBnsdJdgns39VOFtCfOQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WLS1Z5gC5T4ghOfl2kKi2m3yOmXSpuVLf/D9dbgzshDcZNV05qp3InxQeZ6mHUdgC
 fHGud/Ps+Ppedz3DoRcQrR/dzapvsl6KlG3H53o5Bjs9gaZ5u1Vztefe1yBGhhpsjj
 lAa/fqFvwWbIGAxIopBihfxFb71oThmJyLbFBa4tS2dYrvla6R9ThEIPuxy/fqwFLY
 BU7gn1F9jA+GSvcA9C9Pz8YBoRB3bABjyuxPUWGcngAcY04cNSwajRBBsjw3kuwGG6
 jMb5Y1K15V9DTf/SagciSFGsR3AQcJKE93+Kivi1DFrFgL+m+uLRZH/lAaFlGu1qx6
 fXFBpTGoNETQw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D504A1E42E0;
 Fri, 06 Nov 2026 05:35:38 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B49B84550EA;
 Fri, 06 Nov 2026 05:35:38 +0300 (MSK)
Message-ID: <56f5cf1d-e221-465f-8993-866d744241ca@tls.msk.ru>
Date: Fri, 6 Nov 2026 05:35:38 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 QEMU Stable <qemu-stable@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Oleg Drokin <green@linuxhacker.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 5/27/26 09:16, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. That's a preparation for vhost-user-blk backend-transfer
> feature.
> 
> 07: rebase on master,
> 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))
> 
> Vladimir Sementsov-Ogievskiy (22):
>    vhost-user: rework enabling vrings
>    vhost: drop backend_features field
>    vhost-user: introduce vhost_user_has_protocol_feature() helper
>    vhost: move protocol_features to vhost_user
>    vhost-user-gpu: drop code duplication
>    vhost: make vhost_dev.features private
>    virtio: move common part of _set_guest_notifier to generic code
>    virtio: drop *_set_guest_notifier_fd_handler() helpers
>    vhost-user: keep QIOChannelSocket for backend channel
>    vhost: vhost_virtqueue_start(): fix failure path
>    vhost: make vhost_memory_unmap() null-safe
>    vhost: simplify calls to vhost_memory_unmap()
>    vhost: move vrings mapping to the top of vhost_virtqueue_start()
>    vhost: vhost_virtqueue_start(): drop extra local variables
>    vhost: final refactoring of vhost vrings map/unmap
>    vhost: simplify vhost_dev_init() error-path
>    vhost: move busyloop timeout initialization to vhost_virtqueue_init()
>    vhost: vhost_dev_init(): simplify features initialization
>    hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>    vhost-user: make trace events more readable
>    vhost-user-blk: add some useful trace-points
>    vhost: add some useful trace-points
 From this pullreq, I'm picking the following changes for 10.0.x stable series
(with small adjustments to apply to 10.0.x):

  4e61c89262a vhost: final refactoring of vhost vrings map/unmap
  4801e50cf1a vhost: vhost_virtqueue_start(): drop extra local variables
  60abdf60d50 vhost: move vrings mapping to the top of vhost_virtqueue_start()
  060ef8cac11 vhost: simplify calls to vhost_memory_unmap()
  558084367e9 vhost: make vhost_memory_unmap() null-safe
  c85f42703df vhost: vhost_virtqueue_start(): fix failure path

Additionally, I'm picking

  41d5e37e0e2 hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls

to 10.0.x too - this is basically a no-op change, but it makes
subsequent changes to apply cleanly and makes older code closer
to current, simplifying back-porting and making this back-
porting easily verifiable.

Please take a look at the 6 top commits starting

  https://gitlab.com/mjt0k/qemu/-/commits/16071441316f92915dccf08dabdddc722674e38c

-- it should be very similar to the changes in this pull request, but
a quick look is appreciated anyway.

Is there anything else in this area which should be picked up too?  Maybe
some subsequent fixes?

Thanks,

/mjt

