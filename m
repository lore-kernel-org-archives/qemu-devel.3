Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A634CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tObPA-0007wH-SH; Fri, 20 Dec 2024 06:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1tObP3-0007vk-W2; Fri, 20 Dec 2024 06:42:46 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1tObP1-0008ON-Iw; Fri, 20 Dec 2024 06:42:45 -0500
Received: from [10.35.8.9] (unknown [80.250.189.26])
 by mail.ispras.ru (Postfix) with ESMTPSA id 797AA518E788;
 Fri, 20 Dec 2024 11:42:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 797AA518E788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1734694956;
 bh=dSRqGQtO13PL2fUIjbQNUoHQ+E9epfdVau3MGnTx+oI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cjiliVPNHP17dSLt2dieOvwR3AWYV1RgLf6P0EqC+VTHuAwhnN+BHeSJ4UH5mkJkA
 JQMXW2fio7LwigT5DOtWRmgUq9/Ty/fCcXsFFhRV7cXQ0JhXuZNVWJdX8dNY6747fY
 QoPlg3kWAk969EAHFWHlpNMu/b8q0+B9DdDKOgGs=
Message-ID: <71250e4e-ac3e-4df6-ac7a-5ed53fc8cd35@ispras.ru>
Date: Fri, 20 Dec 2024 14:42:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] replay: Fixes and avocado test updates
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
Content-Language: en-US
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 20.12.2024 13:42, Nicholas Piggin wrote:
> Hi,
> 
> This is another round of replay fixes posted here
> 
> https://lore.kernel.org/qemu-devel/20240813050638.446172-1-npiggin@gmail.com/
> 
> A bunch of those fixes have been merged, but there are still some
> outstanding here.
> 
> Dropped from the series is the net announce change, which seemed to
> be the main issue Pavel had so far:
> 
> https://lore.kernel.org/qemu-devel/6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru/
> 
> New in this series is a reworking of the replay BH APIs because people
> didn't like the replay_xxx APIs throughout the tree. These new APIs
> also have some assertions added to catch un-converted users when replay
> is enabled, because it is far harder to debug it when it surfaces as a
> replay failure.
> 
> These new API assertions caught a hw/ide replay bug which solves some
> replay_linux test hangs. Couple of fixes in the replay_linux test case,
> and now all tests are passing including aarch64 tests, see here
> 
>    https://gitlab.com/npiggin/qemu/-/jobs/8695386122
> 
> (In that run a couple of the x86_64 tests were disabled to fit the
> aarch64 tests in because gitlab seems to kill the job after 1 hour
> so we can't fit them all in)
> 
> ppc64 also passes replay_linux after a couple of ppc64 fixes I'll post
> a patch to add the ppc64 test later after everything works through.
> 
> Thanks,
> Nick
> 
> 
> Nicholas Piggin (17):
>    replay: Fix migration use of clock for statistics
>    replay: Fix migration replay_mutex locking
>    async: rework async event API for replay
>    util/main-loop: Convert to new bh API
>    util/thread-pool: Convert to new bh API
>    util/aio-wait: Convert to new bh API
>    async/coroutine: Convert to new bh API
>    migration: Convert to new bh API
>    monitor: Convert to new bh API
>    qmp: Convert to new bh API
>    block: Convert to new bh API
>    hw/ide: Fix record-replay and convert to new bh API
>    hw/scsi: Convert to new bh API
>    async: add debugging assertions for record/replay in bh APIs
>    tests/avocado/replay_linux: Fix compile error
>    tests/avocado/replay_linux: Fix cdrom device setup
>    tests/avocado/replay_linux: remove the timeout expected guards
> 
>   docs/devel/replay.rst              |  7 +--
>   include/block/aio.h                | 44 ++++++++++++++++--
>   include/sysemu/replay.h            |  2 +-
>   backends/rng-builtin.c             |  2 +-
>   block.c                            |  4 +-
>   block/blkreplay.c                  | 10 +++-
>   block/block-backend.c              | 24 ++++++----
>   block/io.c                         |  5 +-
>   block/iscsi.c                      |  5 +-
>   block/nfs.c                        | 10 ++--
>   block/null.c                       |  4 +-
>   block/nvme.c                       |  8 ++--
>   hw/ide/core.c                      |  9 ++--
>   hw/net/virtio-net.c                | 14 +++---
>   hw/scsi/scsi-bus.c                 | 14 ++++--
>   job.c                              |  3 +-
>   migration/migration.c              | 17 +++++--
>   migration/savevm.c                 | 15 +++---
>   monitor/monitor.c                  |  3 +-
>   monitor/qmp.c                      |  5 +-
>   qapi/qmp-dispatch.c                |  5 +-
>   replay/replay-events.c             | 29 +++++-------
>   stubs/replay-tools.c               |  2 +-
>   util/aio-wait.c                    |  3 +-
>   util/async.c                       | 75 ++++++++++++++++++++++++++++--
>   util/main-loop.c                   |  2 +-
>   util/thread-pool.c                 |  8 ++--
>   scripts/block-coroutine-wrapper.py |  3 +-
>   tests/avocado/replay_linux.py      |  9 ++--
>   29 files changed, 245 insertions(+), 96 deletions(-)
> 


