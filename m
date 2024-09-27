Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67355CDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 19:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suGyP-0002Ax-Km; Fri, 27 Sep 2024 15:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1suGyK-00028F-Me; Fri, 27 Sep 2024 15:49:49 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1suGyJ-0004ok-9q; Fri, 27 Sep 2024 15:49:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 96DB460C90;
 Fri, 27 Sep 2024 22:49:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b735::1:26] (unknown
 [2a02:6b8:b081:b735::1:26])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jncwV00Xs0U0-b92yDMMW; Fri, 27 Sep 2024 22:49:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727466585;
 bh=chxI0j4iXn8i8H//W2X0/TYsj5AXHavudzYqUyEirzU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LyOfIwCNBIjcpXwu1lVaCF168VCogr4P/846UajXczTFzd3PS7I63GguJsfI5Dy8n
 U5MCGyo7Avj/KYw+SLR/F34DbHazxrgvsU/kw4R0boRihnpzzOAbLBV4gKCxmHza7o
 g1w5N/5r0p8kn0gqOfrlSD0Y/y7RJK025XaznC00=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <69ef022f-ed8c-4c82-9a50-a0fdd3628d73@yandex-team.ru>
Date: Fri, 27 Sep 2024 22:49:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unused aio_task_pool_empty
To: dave@treblig.org, jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20240917002007.330689-1-dave@treblig.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240917002007.330689-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17.09.24 03:20, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert"<dave@treblig.org>
> 
> aio_task_pool_empty has been unused since it was added in
>    6e9b225f73 ("block: introduce aio task pool")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert<dave@treblig.org>

Thanks, applied to my block branch.

-- 
Best regards,
Vladimir


