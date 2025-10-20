Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B00CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmwV-0001wK-Ib; Mon, 20 Oct 2025 06:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAmwQ-0001t5-M6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:16:38 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAmwI-0005pr-JK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:16:38 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 490C1807BD;
 Mon, 20 Oct 2025 13:16:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:eb76:dac8:b48b:fd00] (unknown
 [2a02:6bf:803e:400:eb76:dac8:b48b:fd00])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LGSgqt2NvKo0-zG29UdlF; Mon, 20 Oct 2025 13:16:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760955382;
 bh=SSmqhZksH1Sa4Bp2fazb8hwRgQcZenJZau9ahdqPXLo=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=UWqa+GWmo5mXC8epzqsNmEw6+fbNlyCzaYuv5AM72OvVapcDqKfsZlCi0OwJj5EmZ
 OkFZbx4GRv4Hhu0O8DeSsaX+JIjjwQW4w1eohyw/4VuRh8jAePAclq/HDVfObD6rr9
 oivPwUjobSCWk2T5auJMLNkL1ByUTFspPKLL9PcU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------0bk0iU709TWNced8YMjtNssV"
Message-ID: <fe4dfac5-1542-4810-b569-de21de3f8df1@yandex-team.ru>
Date: Mon, 20 Oct 2025 15:16:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vhost-user-blk: support inflight migration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <87a51l99to.fsf@pond.sub.org>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <87a51l99to.fsf@pond.sub.org>
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------0bk0iU709TWNced8YMjtNssV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/20/25 14:55, Markus Armbruster wrote:
> Alexandr Moshkov<dtalexundeer@yandex-team.ru> writes:
>
>> Hi!
>>
>> During inter-host migration, waiting for disk requests to be drained
>> in the vhost-user backend can incur significant downtime.
>>
>> This can be avoided if QEMU migrates the inflight region in vhost-user-blk.
>> Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
>> then, after migration, they will be executed on another host.
>>
>> At first, I tried to implement migration for all vhost-user devices that support inflight at once,
>> but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
>> in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).
>>
>> Therefore, for now I decided to leave this idea for later and
>> implement the migration of the inflight region first for vhost-user-blk.
> How is this work related to Vladimir's "vhost-user-blk: live-backend
> local migration"?

Hi!

Vladimir's work is only related to local migration (including inflight 
region fd), when my patch allows to migrate inflight requests to another 
host to reduce downtime without waiting for disk requests to be drained.

--------------0bk0iU709TWNced8YMjtNssV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/20/25 14:55, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a51l99to.fsf@pond.sub.org">
      <pre wrap="" class="moz-quote-pre">Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in vhost-user-blk. 
Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
then, after migration, they will be executed on another host. 

At first, I tried to implement migration for all vhost-user devices that support inflight at once, 
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and 
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

Therefore, for now I decided to leave this idea for later and 
implement the migration of the inflight region first for vhost-user-blk.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
How is this work related to Vladimir's "vhost-user-blk: live-backend
local migration"?
</pre>
    </blockquote>
    <p>Hi!</p>
    <p><span style="white-space: pre-wrap;">Vladimir's work is only related to local migration (including inflight region fd), 
when my patch allows to migrate inflight requests to another host 
to reduce downtime without waiting for disk requests to be drained.</span></p>
  </body>
</html>

--------------0bk0iU709TWNced8YMjtNssV--

