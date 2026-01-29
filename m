Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67527D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZSX-0005s3-CM; Thu, 29 Jan 2026 16:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZSP-0005ka-Th
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:21:42 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZSN-0006NQ-GN
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:21:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 02E58807A2;
 Fri, 30 Jan 2026 00:21:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b74::1:d] (unknown [2a02:6bf:8080:b74::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WLrIiT5BD4Y0-v3eKJs0W; Fri, 30 Jan 2026 00:21:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769721693;
 bh=yxdyUMsT0G3ukN5sMBQYbP5EYMEf4eyPlKl7u1fE5Hc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pJhYPCcTO+/+bkb9dK9/nrlHysasqV67+DeL5P+LBK0i7v74am75u5neZmlbDpjJ1
 Aqsu8ejhUs349TqEX6UltLW2OPqcDE3AcfrtxAuJ8UFt/otv9XNzERRgrJdPhTmkH2
 uSIfA3tjf6jNLOlTQlTVnPrmGqfF9YPWRPOs1ZVY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a8a29f4e-ebc2-40ed-ad2d-4573a007d994@yandex-team.ru>
Date: Fri, 30 Jan 2026 00:21:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] qapi: net: deprecate vhostforce option
To: Jason Wang <jasowang@redhat.com>
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20251113071711.349651-1-vsementsov@yandex-team.ru>
 <CACGkMEv=UYKjc5jZRSQCzgzCe6Bdz8OGMHYA5F-5OkRVrRom9g@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEv=UYKjc5jZRSQCzgzCe6Bdz8OGMHYA5F-5OkRVrRom9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 14.11.25 04:34, Jason Wang wrote:
> On Thu, Nov 13, 2025 at 3:17 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> This option for tap and vhost-user netdevs doesn't make sense
>> since long ago (10 years!), starting from commits:
>>
>>   1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>>   24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
>>
>> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
>> some specific kind of guests (that don't have MSI-X support), you should
>> have set vhostforce=on.
>>
>> Now guest type doesn't matter, all guests are equal for these
>> options logic.
>>
>> For tap the current logic is:
>>    vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>>    vhost unset : vhostforce counts, enabling vhost
>>
>> So you may enable vhost for tap several ways:
>> - vhost=on
>> - vhostforce=on
>> - vhost=on + vhostforce=on
>> - and even vhost=on + vhostforce=off
>>
>> - they are all equal.
>>
>> For vhost-user we simply ignore the vhostforce option at all in the
>> code.
>>
>> Let's finally deprecate the extra options.
>>
>> Also, fix @vhostforce documentation everywhere to show the real picture,
>> and update vhost-user test to not use deprecated option.
>>
>> While updating command line options, drop "experimental" word from
>> "experimental in kernel accelerator". vhost-net is in production for
>> years.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>
>> v6: - update numbers 10.2 -> 11.0
>>      - add r-b by Markus
> 
> I've queued this for 11.0.
> 
> Thanks.
> 

Hi! Isn't this forgotten? You've recently pulled some my commits, but this one is still not in master..

-- 
Best regards,
Vladimir

