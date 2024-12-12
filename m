Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8CBE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmUv-0004cW-6i; Thu, 12 Dec 2024 11:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tLmUk-0004bf-1f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:56:59 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tLmUg-000076-D3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:56:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:292a:0:640:622b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BCAB0609AC;
 Thu, 12 Dec 2024 19:56:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b585::1:1f] (unknown
 [2a02:6b8:b081:b585::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lur4l60GUeA0-A0aUeVRu; Thu, 12 Dec 2024 19:56:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1734022608;
 bh=iIR1JWFK8ZvoXqwiafYI3+MCNjIehnFcBEX5bo1tRDg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xxZBppg2uzXGc6HZvtzR5lstiz4kzmaX72lQfapYoy4bng0IVWwtCC2LgKSdnBwht
 bKUyu5NzSt1D+vDObKn8ZQRRs/250Ai5BZinuFQLzGizYf2qqNu/ml36BSSHFM1VKM
 ey2pDZXKO+GCGzabO+Ih5rMVWGIPE/jC9TGZRSWw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3a36f041-de45-4ec2-b656-7e76aa259a98@yandex-team.ru>
Date: Thu, 12 Dec 2024 19:56:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] sysemu: introduce a new MlockState enum
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
 <20241211230433.1371327-4-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20241211230433.1371327-4-d-tatianin@yandex-team.ru>
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

On 12.12.24 02:04, Daniil Tatianin wrote:
> Replace the boolean value enable_mlock with an enum and add a helper to
> decide whether we should be calling os_mlock.
> 
> This is a stepping stone towards introducing a new mlock mode, which
> will be the third possible state of this enum.
> 
> Signed-off-by: Daniil Tatianin<d-tatianin@yandex-team.ru>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir


