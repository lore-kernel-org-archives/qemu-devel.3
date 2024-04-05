Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E20AC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsju4-00080E-1q; Fri, 05 Apr 2024 09:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rsjtl-0007xo-1J; Fri, 05 Apr 2024 09:46:30 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rsjth-0001aj-Nn; Fri, 05 Apr 2024 09:46:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3b00:0:640:c3c9:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 91EBB60EB4;
 Fri,  5 Apr 2024 16:46:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b538::1:32] (unknown
 [2a02:6b8:b081:b538::1:32])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IkVtDL0IaiE0-vJoEG6G4; Fri, 05 Apr 2024 16:46:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712324779;
 bh=fIL34b7NYTkHjFpRLsOLYzcuna0uh2m2SpgFb17l7gM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=d6piLWvpaygpHvtnfTYGdKMGWoxTEWDX7xkMcDc2PUjeiYdQ9j9N4ncMZeI3Tg9FW
 cUaL1ZdF9ssDFL1Y6Wn01sZ7odXbiEHR0Z68TOsabpudDVifvrkvUgjOTNTm770LYC
 Hr7obMjrB73YLR2QEZMdJev3G1nnC1bQF+7CGQz4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <78590860-ccd6-4434-8410-a19031cebdc1@yandex-team.ru>
Date: Fri, 5 Apr 2024 16:46:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] backup: discard-source parameter
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, f.ebner@proxmox.com
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240313152822.626493-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13.03.24 18:28, Vladimir Sementsov-Ogievskiy wrote:
> Hi all! The main patch is 04, please look at it for description and
> diagram.
> 
> v4: add t-b by Fiona
>      add r-b by Fiona to 02-05 (patch 01 still lack an r-b)
>      05: fix copyrights and subject in the test
>      04: since 9.0 --> since 9.1 (we missed a soft freeze for 9.0)
> 
> Vladimir Sementsov-Ogievskiy (5):
>    block/copy-before-write: fix permission
>    block/copy-before-write: support unligned snapshot-discard
>    block/copy-before-write: create block_copy bitmap in filter node
>    qapi: blockdev-backup: add discard-source parameter
>    iotests: add backup-discard-source
> 
>   block/backup.c                                |   5 +-
>   block/block-copy.c                            |  12 +-
>   block/copy-before-write.c                     |  39 ++++-
>   block/copy-before-write.h                     |   1 +
>   block/replication.c                           |   4 +-
>   blockdev.c                                    |   2 +-
>   include/block/block-common.h                  |   2 +
>   include/block/block-copy.h                    |   2 +
>   include/block/block_int-global-state.h        |   2 +-
>   qapi/block-core.json                          |   4 +
>   tests/qemu-iotests/257.out                    | 112 ++++++-------
>   .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
>   .../tests/backup-discard-source.out           |   5 +
>   13 files changed, 272 insertions(+), 70 deletions(-)
>   create mode 100755 tests/qemu-iotests/tests/backup-discard-source
>   create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out
> 


Thanks for review, applied to my block branch.

(r-b to 01 is still appreciated, I will not pull this until 9.1 tree opened)

-- 
Best regards,
Vladimir


