Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD98CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uytvo-0007xv-UI; Wed, 17 Sep 2025 11:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uytvT-0007hT-Nq
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:18:33 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uytvO-0001Rm-Pb
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:18:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B2CDC80730;
 Wed, 17 Sep 2025 18:18:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b2a::1:6] (unknown [2a02:6bf:8080:b2a::1:6])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GITZ9O0GmuQ0-UDtOu86g; Wed, 17 Sep 2025 18:18:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758122298;
 bh=67lHwnbyu5awESn6jb82kYWzhww4Dc8hJvljvCon38E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Wge6eKaFdsHG3p9CouAxukzf/ukK48ZzLdv0tbvez+kxpVGjsb38o3mY+bUI/HFvZ
 yTrdmGrlRG/2c4d3Riu74uklvj89lR1KECdrD4+4j829wUU07fl7xftrB3Unr+hXRH
 jdp53pm9DnL6bHqANCWAv5KwsqivAAHa7MC6izw0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b972a642-c12e-4deb-9eaf-c334d1b6e598@yandex-team.ru>
Date: Wed, 17 Sep 2025 18:18:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] error: Kill @error_warn
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-13-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250917115207.1730186-13-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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

On 17.09.25 14:52, Markus Armbruster wrote:
> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
> add global &error_warn destination).  It has multiple issues:
> 
> * error.h's big comment was not updated for it.
> 
> * Function contracts were not updated for it.
> 
> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>    error_prepend() and such.  These crash on @error_warn, as pointed
>    out by Akihiko Odaki.
> 
> All fixable.  However, after more than two years, we had just of 15
> uses, of which the last few patches removed seven as unclean or
> otherwise undesirable, adding back five elsewhere.  I didn't look
> closely enough at the remaining seven to decide whether they are
> desirable or not.
> 
> I don't think this feature earns its keep.  Drop it.
> 
> Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

