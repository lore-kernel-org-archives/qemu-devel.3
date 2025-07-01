Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF30C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYek-0008DG-Eh; Tue, 01 Jul 2025 06:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uWYef-0008Ce-Dj; Tue, 01 Jul 2025 06:56:01 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uWYeb-0002BN-LS; Tue, 01 Jul 2025 06:56:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:3878:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4A9F560B7B;
 Tue,  1 Jul 2025 13:55:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:555::1:c] (unknown [2a02:6bf:8080:555::1:c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mtXdMN0FgeA0-Rqm3z1Mo; Tue, 01 Jul 2025 13:55:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751367349;
 bh=xAaGqagBqaxVf/aRPfJDKqaQiLQSgAZftd2VwUD2ygU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=few7hnAK30LLWjkBlgw/dKFUIvmXia5il+b6D7+tIpKSVChzg2Pq/fDQ7fEPkpQd+
 HaW4ou6bTB/1MGKRrYIi9VSblSMcFdsRRomcN/kMs8hdXpQbNtt+240xOJ3WTIkYmF
 33iHIu+/R2TDJBukdqkk4oFZ+t2kX0cBkKWfaYQc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c062d161-719f-4721-8e10-c45df79dac4b@yandex-team.ru>
Date: Tue, 1 Jul 2025 13:55:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vhost-user-blk: add an option to skip GET_VRING_BASE
 for force shutdown
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Ping :)

On 6/10/25 12:25 AM, Daniil Tatianin wrote:
> This series aims to address SIGTERM/QMP quit() being a bit too graceful in
> respect to devices. Both of the aforementioned ways to stop QEMU completely
> bypass the guest OS so in that sense they're basically equal to pulling the
> power plug on a computer, yet the device shutdown code still tries to do
> everything as graceful as possible, draining all in-flight requests etc.
> I explain one of the use problems/use cases below.
>
> If we have a server running disk requests that is for whatever reason
> hanging or not able to process any more IO requests but still has some
> in-flight requests previously issued by the guest OS, QEMU will still
> try to drain the vring before shutting down even if it was explicitly
> asked to do a "force shutdown" via SIGTERM or QMP quit. This is not
> useful since the guest is no longer running at this point since it was
> killed by QEMU earlier in the process. At this point, we don't care
> about whatever in-flight IO it might have pending, we just want QEMU
> to shut down.
>
> Add an option called "skip-get-vring-base-on-force-shutdown" to allow
> SIGTERM/QMP quit() to actually act like a "force shutdown" at least
> for vhost-user-blk devices since those require the drain operation
> to shut down gracefully unlike, for example, network devices.
>
> Daniil Tatianin (3):
>    softmmu/runstate: add a way to detect force shutdowns
>    vhost: add a helper for force stopping a device
>    vhost-user-blk: add an option to skip GET_VRING_BASE for force
>      shutdown
>
>   hw/block/vhost-user-blk.c          |  9 +++++-
>   hw/virtio/vhost.c                  | 52 ++++++++++++++++++++++--------
>   include/hw/virtio/vhost-user-blk.h |  2 ++
>   include/hw/virtio/vhost.h          | 15 +++++++++
>   include/system/runstate.h          |  1 +
>   system/runstate.c                  | 10 ++++++
>   6 files changed, 75 insertions(+), 14 deletions(-)
>

