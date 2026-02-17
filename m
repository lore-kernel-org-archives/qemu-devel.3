Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2A6E6816B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 12:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsJt0-0000C6-P2; Tue, 17 Feb 2026 07:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsJsx-0000Bn-L2
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:08:59 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsJsu-0005uL-Gv
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:08:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 982B3C0154;
 Tue, 17 Feb 2026 15:08:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b3b::1:9] (unknown [2a02:6bf:8080:b3b::1:9])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id l8Y11B3Ag8c0-AFoCpwxh; Tue, 17 Feb 2026 15:08:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771330129;
 bh=boq3LJBuAZAVtntRUugh1xwn3pcxogTSu/7Z9UlJj/4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0IQGHkmPx4zgFG6m3z+ng8ISwyZzhKyOHRVaTvNfVSUXvmYhWuBQp43bOw6SxshlF
 JZaawoJe1CNMEZ1x/YNb9ASGywEtSiiXnA+ScoPQM+icXQeSlkx8MkcpAo428u5wPh
 z6xIfbKkWSUvRXd2YsyvUyk9Gl4pL76MPK6I04SQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <86722929-9a4b-49d1-8e69-53f158b20e45@yandex-team.ru>
Date: Tue, 17 Feb 2026 15:08:47 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87zf57n3m7.fsf@pond.sub.org>
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

On 17.02.26 12:03, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Remove desc, avail, and used fields as they expose process address space
>> information and violate ASLR.
> 
> Isn't the user of the monitor trusted?

I don't know exactly the policy here. If keep these fields, their semantics
will change anyway with these series. So I decided, it's simpler to drop
them (if no objections), keeping in mind experimental status of the command
and ASLR.

> 
>>                                Since this is an experimental command, we
>> can safely remove these potentially sensitive fields.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Patch looks good.
> 


-- 
Best regards,
Vladimir

