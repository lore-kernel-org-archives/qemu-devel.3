Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAD1C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZaQ-0001MA-W5; Thu, 27 Aug 2026 08:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZaP-0001Lw-Ey; Thu, 27 Aug 2026 08:52:05 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZaM-0000d7-5N; Thu, 27 Aug 2026 08:52:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 7DA588086D;
 Thu, 27 Aug 2026 15:51:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id updoY8WaZKo0-qE1Im8DO; Thu, 27 Aug 2026 15:51:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787835117;
 bh=/Yga4UGOXwD3k1wSjJPifoGSJ8/EVR9AmzhsiGGsWK0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=srjg2OsheCw1GBZYNSJ51Q03KDyBMfepohgfhWgeecrhNXfE1fIM4FXqsXjIoHGPy
 oDOSStbI2+HeA2S2vDJqjGyQb0rtDfzxOvL/ULYiZjWLFgrbdfW+jRj0ETRxY+yVms
 +8veEAONT8+6mrlX871defBY2ZuE6W2BmjuOFElI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <771ada0d-259a-45d6-bbd7-57208591f076@yandex-team.ru>
Date: Thu, 27 Aug 2026 15:51:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iotests/nbd-commands: exercise the simple and
 structured reply modes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260826165747.3768674-1-den@openvz.org>
 <20260826165747.3768674-4-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260826165747.3768674-4-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 26.08.26 19:57, Denis V. Lunev wrote:
> From: Denis V. Lunev<den@openvz.org>
> 
> Every NBD request the iotests send arrives in NBD_MODE_EXTENDED, so
> the server paths kept for older clients are never taken. Instrumenting
> nbd_co_receive_request() over the whole auto group and every test that
> touches NBD gives mode 4 for all of them, which leaves
> nbd_co_send_simple_reply() and the compact header handling dead under
> test. A regression there would only show against a third party client.
> 
> libnbd can negotiate down, so run the same command set three times,
> once per mode, and assert the mode that was actually reached. Block
> status is limited to the two modes that can negotiate a meta context.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Eric Blake<eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

