Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDFDCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 00:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEFK4-0001NF-33; Tue, 06 Oct 2026 20:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xEFCm-0000sS-7m; Tue, 06 Oct 2026 20:08:37 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@yandex-team.ru>)
 id 1xEFCK-0000U8-N6; Tue, 06 Oct 2026 20:08:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0937FC0508;
 Tue, 06 Oct 2026 13:00:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55a::1:27] (unknown
 [2a02:6bf:8080:55a::1:27])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id b0JM1X0ZUW20-jOwjmri0; Tue, 06 Oct 2026 13:00:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1791280838;
 bh=yYwiJARKAGbTkXn7NyRBbq+z7Md4QhdezMcpYZdDHSE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=U+tZnpJZlW2dqCVielQlQp/F4nFhtBgmqdHLuJOKZFuUc97jUljUTI88x4tPq72Bu
 BknZNYL5V9fwJcB+bA/YYBmTbzKjH+7GEJqfqDgaflq09A14uMEX1ikXsUpnNA9dHo
 KSY8uf7jN8XPQbUrx9Pfc72isE8DLeyPkL6vxyDs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <578ce54e-4313-4d69-bf0d-b69682f8eb8d@yandex-team.ru>
Date: Tue, 6 Oct 2026 13:00:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] virtio: two fixes
To: mst@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com, berrange@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping

On 23.09.26 00:32, Vladimir Sementsov-Ogievskiy wrote:
> Hi all! There two fixes for my old patches. I apologize if
> this affected anyone.
> 
> Vladimir Sementsov-Ogievskiy (3):
>    tests/funtional: add test_virtio_status.py
>    qapi/virtio: Restore backend features in x-query-virtio-status
>    qapi/monitor: Handle missing vhost-user protocol features
> 
>   MAINTAINERS                                   |  1 +
>   hw/virtio/virtio-hmp-cmds.c                   |  6 +-
>   hw/virtio/virtio-qmp.c                        |  2 +
>   qapi/virtio.json                              |  5 +-
>   tests/functional/qemu_test/testcase.py        |  9 +-
>   tests/functional/x86_64/meson.build           |  2 +
>   tests/functional/x86_64/test_virtio_status.py | 95 +++++++++++++++++++
>   7 files changed, 112 insertions(+), 8 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_virtio_status.py
> 


-- 
Best regards,
Vladimir

