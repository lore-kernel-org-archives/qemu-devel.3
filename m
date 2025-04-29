Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4447C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jJC-0000Az-0K; Tue, 29 Apr 2025 07:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jIr-0008Sl-6D; Tue, 29 Apr 2025 07:39:13 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jIk-0000hs-PJ; Tue, 29 Apr 2025 07:39:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:4191:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3ADBD618B5;
 Tue, 29 Apr 2025 14:38:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b423::1:3a] (unknown
 [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wcThbX0Fc4Y0-37XpIxxU; Tue, 29 Apr 2025 14:38:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926738;
 bh=wHOpd3wwpsmD4PN+ajLvwADX3VEerjNY4NCDptR8Ooc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mUZYTn0JvCp7DGV8QqS/cGGdct9AX0QPdVOWbS+g7qA2P/RrIngEcF7iFlh22JCYU
 RWYkqVB7R5+sptlpAPH0OiUgp44xJlb3MuJPfclPYKtFszMiPwYITyUNC8cYWrLvAF
 UC+HK9jvMVhcbjk2tXyGJ7smOlG/b+Fwh/CDfnt8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5aae8743-0fdd-4664-869a-e7d22f40c016@yandex-team.ru>
Date: Tue, 29 Apr 2025 14:38:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] block-job patches 2025-04-29
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Oops, accidentally extra old patches were sent, sorry for the noice. Please ignore patches */5, they are already in master.

The cover-letter message and the tag pull-block-jobs-2025-04-29 are correct.

On 29.04.25 14:33, Vladimir Sementsov-Ogievskiy wrote:
> The following changes since commit 73d29ea2417b58ca55fba1aa468ba38e3607b583:
> 
>    Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-04-27 12:47:23 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2025-04-29
> 
> for you to fetch changes up to 300ef7b9d16067f3d8d85f5c36006c6d9637e07f:
> 
>    blockdev-backup: Add error handling option for copy-before-write jobs (2025-04-29 12:55:28 +0300)
> 
> ----------------------------------------------------------------
> block-job patches
> 
> - deprecate some old block-job- APIs
> - on-cbw-error option for backup
> - more efficient zero handling in block commit
> 
> ----------------------------------------------------------------
> Raman Dzehtsiar (1):
>        blockdev-backup: Add error handling option for copy-before-write jobs
> 
> Vincent Vanlaer (5):
>        block: get type of block allocation in commit_run
>        block: move commit_run loop to separate function
>        block: refactor error handling of commit_iteration
>        block: allow commit to unmap zero blocks
>        block: add test non-active commit with zeroed data
> 
> Vladimir Sementsov-Ogievskiy (2):
>        qapi: synchronize jobs and block-jobs documentation
>        qapi/block-core: deprecate some block-job- APIs
> 
>   block/backup.c                                  |   3 +-
>   block/commit.c                                  | 117 +++++++++++++++++-------
>   block/copy-before-write.c                       |   2 +
>   block/copy-before-write.h                       |   1 +
>   block/replication.c                             |   4 +-
>   blockdev.c                                      |   6 ++
>   docs/about/deprecated.rst                       |  31 +++++++
>   include/block/block_int-global-state.h          |   2 +
>   qapi/block-core.json                            |  95 ++++++++++++++-----
>   qapi/job.json                                   |  30 +++++-
>   tests/qemu-iotests/tests/commit-zero-blocks     |  96 +++++++++++++++++++
>   tests/qemu-iotests/tests/commit-zero-blocks.out |  54 +++++++++++
>   tests/qemu-iotests/tests/copy-before-write      |  90 ++++++++++++++++++
>   tests/qemu-iotests/tests/copy-before-write.out  |   4 +-
>   14 files changed, 470 insertions(+), 65 deletions(-)
>   create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
>   create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out
> 

-- 
Best regards,
Vladimir


