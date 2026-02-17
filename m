Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF4FE9A02D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 18:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsPPt-0002uR-2r; Tue, 17 Feb 2026 13:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsPPg-0002sn-T8
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 13:03:16 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsPPd-0006Ap-IB
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 13:03:08 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 88DB8C01DB;
 Tue, 17 Feb 2026 21:03:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b3b::1:9] (unknown [2a02:6bf:8080:b3b::1:9])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 03eWR83Aj0U0-GDw4CoJA; Tue, 17 Feb 2026 21:03:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771351381;
 bh=L1ejIqlKtor7ZgdGbh5nvO6o06+LKnhD/xSJTYysd44=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=T3yqRDd4Bfxv05MivAqOuADD9dEBPdpsiDzAMyMYWppSVE3KZ1iKbNa9w+LbYcsRD
 PPJaWWdowvIYyocU1yGgfjhr+o1nNgI0xxkCrVqkb31UNPQtKyxVJrWwXSrkrLR63N
 SJcrTfd+Ij7yPi+94VRWVZr4YHbxsTYHdDraARbA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2d779c3a-34ed-4127-a1af-b31ed4a40be6@yandex-team.ru>
Date: Tue, 17 Feb 2026 21:03:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] qapi: remove user addresses from
 x-query-virtio-vhost-queue-status
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, qemu-devel@nongnu.org,
 d-tatianin@yandex-team.ru, Eric Blake <eblake@redhat.com>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
 <20260209073908.2125178-7-vsementsov@yandex-team.ru>
 <87zf57n3m7.fsf@pond.sub.org>
 <86722929-9a4b-49d1-8e69-53f158b20e45@yandex-team.ru>
 <87342zie60.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87342zie60.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17.02.26 18:27, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 17.02.26 12:03, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Remove desc, avail, and used fields as they expose process address space
>>>> information and violate ASLR.
>>>
>>> Isn't the user of the monitor trusted?
>>
>> I don't know exactly the policy here. If keep these fields, their semantics
>> will change anyway with these series. So I decided, it's simpler to drop
>> them (if no objections), keeping in mind experimental status of the command
>> and ASLR.
> 
> The monitor lets you read arbitrary virtual and physical guest memory.
> Feels trusted to me :)
> 
> "Violate ASLR" suggests security is at stake somehow.  I doubt it is.
> 
> "will change anyway" and "it's simpler to drop them" makes me suspect
> they're not useful enough to be worth their keep.  If this is the actual
> reason for dropping them, please rewrite your commit message to say so.
> 

OK, will do

-- 
Best regards,
Vladimir

