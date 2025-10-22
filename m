Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0619CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTlD-0005nT-SO; Wed, 22 Oct 2025 03:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vBTlB-0005mz-Ud
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:59:53 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vBTl8-0000tx-KA
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:59:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0871183B5B;
 Wed, 22 Oct 2025 10:59:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:559::1:29] (unknown
 [2a02:6bf:8080:559::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gxRSpH0IoSw0-XQFiy1vX; Wed, 22 Oct 2025 10:59:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761119984;
 bh=H9oGwegLKyEa5NZhkVqe105h25xopNgzVfR8bMdYTCo=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=hdtJcbypPsdnHJylbrsY+3r0qCDO85xWwYAOlvieSi2ZqjmjPnXwLfMqTjzmOL51z
 2fPQaSe8v7cY0WJK5bc1CtERSvdSWAClArBA5sK1B+PIh6xDH7g723mhfTZNib5UH1
 U+A1kbFOs+psbwdANrDSYTIJqVlwdbz/Kj+mMaXU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------08ApbnoH1AJ1ExvN0hn4oqcj"
Message-ID: <453ec8f4-fbda-4411-a02c-5d30429d7083@yandex-team.ru>
Date: Wed, 22 Oct 2025 12:59:41 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vhost-user-blk: support inflight migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com>
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------08ApbnoH1AJ1ExvN0hn4oqcj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

On 10/21/25 23:54, Raphael Norwitz wrote:

> The logic looks ok from the vhost-user-blk side but some comments inline.
>
> On Mon, Oct 20, 2025 at 1:47 AM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
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
> Even if it's a more significant change I'd rather generalize as much
> logic as possible and expose it as a vhost-user protocol feature. IMO
> too much vhost-user device-agnositic code is being pushed into
> vhost-user-blk.

As far as I understand (correct me if I'm wrong), but this feature must 
be implemented in device itself (along with inflight field location) or 
in some base class for vhost-user devices. For now vhost-user-blkdoesn't 
have one yet.The closest base class that i could find is 
vhost-user-base, but for using it, it has to implement all 
device-agnostic code from vhost-user-blk, and don't break all existing 
vhost-user-base derived devices. For example, to support inflight 
migration in base class, there first need to implement inflight field in 
it, along with the reconnect feature. Then, with a big refactor, somehow 
inherit vhost-user-blk from it, along with other devices such as 
vhost-user-fs.

So, IMO it looks like a whole separate track that will need to be tackled.

> As Markus noted this also conflicts significantly with Vladimir's
> series so I'd suggest waiting until those are in, or possibly
> attempting to generalize on top of his changes.

Yea, but i think, i just need to perform inflight migration only when 
some non-local migration flag is set.

And i think, Vladimir's series already have that flag.


Thanks for the comments!

--------------08ApbnoH1AJ1ExvN0hn4oqcj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi!<br>
    </p>
    <p>On 10/21/25 23:54, Raphael Norwitz wrote:</p>
    <blockquote type="cite"
cite="mid:CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">The logic looks ok from the vhost-user-blk side but some comments inline.

On Mon, Oct 20, 2025 at 1:47 AM Alexandr Moshkov
<a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in vhost-user-blk.
Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
then, after migration, they will be executed on another host.

At first, I tried to implement migration for all vhost-user devices that support inflight at once,
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Even if it's a more significant change I'd rather generalize as much
logic as possible and expose it as a vhost-user protocol feature. IMO
too much vhost-user device-agnositic code is being pushed into
vhost-user-blk.</pre>
    </blockquote>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">As far as I understand (correct me if I'm wrong), but this feature must be implemented in device itself (along with inflight field location) or in some base class for vhost-user devices. </span><span
      style="white-space: pre-wrap;">For now vhost-user-</span><span
      data-lexical-key="311" data-highlighted="false" data-error="true"
      style="white-space: pre-wrap;">blk</span><span
      style="white-space: pre-wrap;"> doesn't have one yet.</span><span
      style="white-space: pre-wrap;"> 
The closest base class that i could find is vhost-user-base, but for using it, it has to implement all device-agnostic code from vhost-user-blk, and don't break all existing vhost-user-base derived devices.
For example, to support inflight migration in base class, there first need to implement inflight field in it, along with the reconnect feature. 
Then, with a big refactor, somehow inherit vhost-user-blk from it, along with other devices such as vhost-user-fs.</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">So, IMO it looks like a whole separate track that will need to be tackled.</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
cite="mid:CAFubqFsiEGHP1Py78VapGvPBi1rpGWZcRbb8Li-QvWhbRGYDiA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
As Markus noted this also conflicts significantly with Vladimir's
series so I'd suggest waiting until those are in, or possibly
attempting to generalize on top of his changes.
</pre>
    </blockquote>
    <p>Yea, but i think, i just need to perform inflight migration only
      when some non-local migration flag is set.</p>
    <p>And i think, Vladimir's series already have that flag.<br>
    </p>
    <br>
    <p>Thanks for the comments!</p>
  </body>
</html>

--------------08ApbnoH1AJ1ExvN0hn4oqcj--

