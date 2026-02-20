Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202C7C5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXhG-0006IY-73; Fri, 20 Feb 2026 16:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXhE-0006G8-VC
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:05:56 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXhC-0003va-CH
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:05:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A26D7807BD;
 Sat, 21 Feb 2026 00:05:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:87::1:2c] (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id n5kx865A70U0-LodZPOu2; Sat, 21 Feb 2026 00:05:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621550;
 bh=xV2mqSp0yNggu36qWZt9FJfwfjDoJ2tty162UfQEezU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xcQFrMTx/tOKGhqpMh+OinsM7uRCQzsenbjPaxbs2KALE3DxGP6j6qc5h5BPOjc9j
 xtJP3/DkBztej3ehNI+RlWgQYFEqNZ+QRPcVd2vqV4zBe5A7xC2Aozue2XLlOlUuhA
 HyOR4EOL/wws15Yl9fd5MHBS6A128rGZbH9mPmWE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <821bf42e-e11d-48b3-af9c-fdd2270fb0ab@yandex-team.ru>
Date: Sat, 21 Feb 2026 00:05:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] migration: more bool+errp APIs
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel <qemu-devel@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

I'm sorry, cover-letter missed qemu-devel. add it.

On 21.02.26 00:01, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> As it was discussed here
> 
>    https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
> 
> vmstate_load/save_state() return code is not actually used other
> then check for success. Let's convert them to bool.
> 
> Also, on same way, introduce errp handlers in VMStateInfo, and
> move to them.
> 
> This series converts only migration/ code. Series converting
> other subsystems will follow.
> 
> v1 was "[RFC 00/22] migration: convert vmstate_load/save_state"
> Supersedes: <20251028231347.194844-1-vsementsov@yandex-team.ru>
> 
> Vladimir Sementsov-Ogievskiy (16):
>    migration: vmstate_save_state_v: fix double error_setg
>    migration: make vmstate_save_state_v() static
>    migration: make .post_save() a void function
>    migration: vmstate_load_state(): add some newlines
>    migration: vmstate_save/load_state(): stop tracing errors
>    migration: factor out vmstate_pre_save() from vmstate_save_state()
>    migration: factor out vmstate_save_field() from vmstate_save_state()
>    migration: factor out vmstate_pre_load() from vmstate_load_state()
>    migration: factor out vmstate_load_field() from vmstate_load_state()
>    migration: factor out vmstate_post_load() from vmstate_load_state()
>    migration: convert vmstate_subsection_save/load functions to bool
>    migration: VMStateInfo: introduce new handlers with errp
>    migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
>    migration/cpr: move to new migration APIs
>    migration/savevm: move to new migration APIs
>    migration/vmstate-types: move to new migration APIs
> 
>   docs/devel/migration/main.rst |   2 +-
>   hw/ppc/spapr_pci.c            |   3 +-
>   include/migration/cpr.h       |   2 +-
>   include/migration/vmstate.h   |  39 ++-
>   migration/cpr.c               |  22 +-
>   migration/savevm.c            | 110 +++---
>   migration/trace-events        |  29 +-
>   migration/vmstate-types.c     | 637 +++++++++++++++++-----------------
>   migration/vmstate.c           | 349 +++++++++++--------
>   target/arm/machine.c          |   4 +-
>   10 files changed, 642 insertions(+), 555 deletions(-)
> 


-- 
Best regards,
Vladimir

