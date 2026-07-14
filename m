Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA529C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfbq-0007CJ-BZ; Tue, 14 Jul 2026 12:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfbo-0007Bv-8p
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:03:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfbk-0002Bz-KZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:03:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 861EE807CD;
 Tue, 14 Jul 2026 19:03:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id c3SW6T0aE0U0-2ALpE0el; Tue, 14 Jul 2026 19:03:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784045019;
 bh=7nLJlxhCQu2pnZXjIwWghr9zj2wkibDChR7aZ8T72BU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=e4/PVGguXjUqIVj5a6OXiTZuWS56kDAxPC1zzhyGTX65+vNGGllImEPSQIXeAtTS3
 R3VafXH716ajCAOx5C4U8Z3OfJJKsDdJLAeRtjF/01F4wVTVX3W3rIVnKI3L1/TK0w
 oPT7dJcfYLYLkf3OhHYEqoxVhg4jdORd9DOefr9s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e8cb2e45-b58b-41f8-a69c-4f3e0f3cdd8d@yandex-team.ru>
Date: Tue, 14 Jul 2026 19:03:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26.06.26 19:46, Andrey Drobyshev wrote:
> v2 -> v3:
> 
> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
> on SETUP migration notifiers, as this approach forces us to reorder
> generic migration code (see v2 discussion).  Instead:
> 
>    * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>      is stopped;
>    * .realize() is adjusted to defer device ownership acquisition for an
>      incoming CPR;
>    * .post_load() actually claims the device (VHOST_SET_OWNER);
>    * FAILED migration event callback re-aquires the ownership on the
>      source after re_save released it.
> 
> v2:https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com

Hi!

Two notes:

1. Did you consider migrating needed FDs through main migration channel, without
use of CPR, like I do in (not yet landed) "[PATCH v19 00/15] virtio-net: live-TAP local migration" [1]

2. I don't know how much vhost-vsock differs from vhost-net, but for vhost-net I remember
that RESET_OWNER + SET_OWNER is effectively equal to simply recreating vhost device on target,
because in kernel vhost device is hardly bound to the process itself, and can't be passed to
another process. So, we can pass only "empty" FD, not the initialized vhost device.
That's why in [1] I only pass tap-fds (and some additional state), but vhost fds are simply
reopened on target (or passed by mgmt app).
Does vhost-vsock work in a different way? Is there real sense in passing vhost fds here?


[1] https://lore.kernel.org/qemu-devel/20260714154246.1242856-1-vsementsov@yandex-team.ru/

-- 
Best regards,
Vladimir

