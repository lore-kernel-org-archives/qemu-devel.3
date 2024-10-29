Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574CED2AB1F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 11:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5kT2-0007zh-3i; Tue, 29 Oct 2024 07:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t5kSv-0007z8-0p; Tue, 29 Oct 2024 07:32:49 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t5kSr-0003Bv-Iz; Tue, 29 Oct 2024 07:32:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 928E6615EE;
 Tue, 29 Oct 2024 14:32:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8908::1:27] (unknown
 [2a02:6b8:b081:8908::1:27])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aWXMGW0IfSw0-zAu71Ent; Tue, 29 Oct 2024 14:32:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1730201556;
 bh=+qDpaN58y+xVuMGdw9iAyvEWoGl+X8W90gmp4pwuWDU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BZAsBhOiPRhwwEamnE9Oe4wttCLoqzwQQ1bchPcjZpF4POA26ZLd+oO9+GqtHkblc
 DxkOmNinTJQQ/CR5rJXQzVdZRCZDh7T4zNre3z+gy7aDz3NNFv5J3qqFhkMbwJLmCb
 P2BBtGjgfuQKjfwmwPVDN+QGm4n6vnMvp8+oEoFw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <197ecb4c-6c1c-48be-8f29-15430402c2d9@yandex-team.ru>
Date: Tue, 29 Oct 2024 14:32:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] qapi: block-job-change: make copy-mode parameter
 optional
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, devel@lists.libvirt.org, hreitz@redhat.com,
 jsnow@redhat.com, pkrempa@redhat.com
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
 <20241002140616.561652-4-vsementsov@yandex-team.ru>
 <ZxecANVZTYjhpeye@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZxecANVZTYjhpeye@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 22.10.24 15:35, Kevin Wolf wrote:
> Am 02.10.2024 um 16:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> We are going to add more parameters to change. We want to make possible
>> to change only one or any subset of available options. So all the
>> options should be optional.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> This is different from blockdev-reopen, which requires repeating all
> options (and can therefore reuse the type from blockdev-add). One of the
> reasons why we made it like that is that we had some options for which
> "option absent" was a meaningful value in itself, so it would have
> become ambiguous if an absent option in blockdev-reopen should mean
> "leave the existing value unchanged" or "unset the option".
> 

Right.. Thanks for noting this. I'll try to apply blockdev-reopen approach here.

> Are we confident that this will never happen with job options? In case
> of doubt, I would go for consistency with blockdev-reopen.
> 
> Either way, it would be good to document the reasoning for whatever
> option we choose in the commit message.
> 
> Kevin
> 

-- 
Best regards,
Vladimir


