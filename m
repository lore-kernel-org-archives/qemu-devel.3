Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92418C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTXR-0000pp-4P; Wed, 12 Jun 2024 15:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sHTXO-0000o1-Q3; Wed, 12 Jun 2024 15:21:38 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sHTXL-0004a9-BT; Wed, 12 Jun 2024 15:21:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5d80:0:640:e743:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 0D0DD60D06;
 Wed, 12 Jun 2024 22:21:28 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6517::1:1e] (unknown
 [2a02:6b8:b081:6517::1:1e])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PLleXh0GjeA0-vFHQyiL7; Wed, 12 Jun 2024 22:21:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1718220087;
 bh=RMvpRBX+dBfD/M4CE3JIsDEhJDwb/nYUskO1hS6uE0M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rpHzB+4xFLO5NcvkAcxpHE0C/V2xLj11/bwauFuJZY0tpTWy3H/0kEqPcNi5qGFD6
 BuRzhwGbqOCrTWsJ+HhujMRG0iEWKAjfj0MPmdSbcPHD1o4ShG8i2agbopp3ZM/2Pe
 1UAwUy2hh9ZQ55pS2UVsJ1m5raNPwC5Pgrju/UCE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <accc6cdc-7b1e-4d26-9352-380f93cc3853@yandex-team.ru>
Date: Wed, 12 Jun 2024 22:21:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iotests: add backup-discard-source
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 hreitz@redhat.com, jsnow@redhat.com, f.ebner@proxmox.com
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
 <20240313152822.626493-6-vsementsov@yandex-team.ru>
 <ZmiORpYFHEWUXQRI@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZmiORpYFHEWUXQRI@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11.06.24 20:49, Kevin Wolf wrote:
> Am 13.03.2024 um 16:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Add test for a new backup option: discard-source.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 
> This test fails for me, and it already does so after this commit that
> introduced it. I haven't checked what get_actual_size(), but I'm running
> on XFS, so its preallocation could be causing this. We generally avoid
> checking the number of allocated blocks in image files for this reason.
> 

Hmm right, I see that relying on allocated size is bad thing. Better is to check block status, to see how many qcow2 clusters are allocated.

Do we have some qmp command to get such information? The simplest way I see is to add dirty to temp block-node, and then check its dirty count through query-named-block-nodes

-- 
Best regards,
Vladimir


