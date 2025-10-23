Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFA9CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBp3t-0005dt-B6; Thu, 23 Oct 2025 02:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vBp3r-0005dd-Rw
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:44:35 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vBp3n-0002KS-G3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:44:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2107C80854;
 Thu, 23 Oct 2025 09:44:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:65f8:2bbd:d1fb:978e] (unknown
 [2a02:6bf:803e:400:65f8:2bbd:d1fb:978e])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PiRdKP0IlSw0-LOBwVAzU; Thu, 23 Oct 2025 09:44:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761201866;
 bh=+tYBk411aGq7jzTNAZE1TivzB7cZRGW/oT1e/dEecUM=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=FFDTz585CMeb1P3VShLvODRiS4RaQDed3POT9Yu8N9rHe9R8igqimpdpN467MOG9m
 HXahO+VBm1rYDX0OQ7hrrcYykO3ySFjI7ze8Z3eyNessruyFwRCV2Ey3ZnL+iW6T59
 KDCBVytI8KKAh4f/SJUUMOd0ZpubCM4lYnKXqNGE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------AP47d7tBnIfmT2GQG50Q9BiN"
Message-ID: <8c79d385-d7a9-4752-b610-9d7b8b3c7f5d@yandex-team.ru>
Date: Thu, 23 Oct 2025 11:44:25 +0500
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
 <453ec8f4-fbda-4411-a02c-5d30429d7083@yandex-team.ru>
 <CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com>
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
--------------AP47d7tBnIfmT2GQG50Q9BiN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/23/25 02:33, Raphael Norwitz wrote:
> On Wed, Oct 22, 2025 at 3:59 AM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
>> Hi!
>>
>> On 10/21/25 23:54, Raphael Norwitz wrote:
>>
>> The logic looks ok from the vhost-user-blk side but some comments inline.
>>
>> On Mon, Oct 20, 2025 at 1:47 AM Alexandr Moshkov
>> <dtalexundeer@yandex-team.ru> wrote:
>>
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
>> Even if it's a more significant change I'd rather generalize as much
>> logic as possible and expose it as a vhost-user protocol feature. IMO
>> too much vhost-user device-agnositic code is being pushed into
>> vhost-user-blk.
>>
>> As far as I understand (correct me if I'm wrong), but this feature must be implemented in device itself (along with inflight field location) or in some base class for vhost-user devices. For now vhost-user-blk doesn't have one yet. The closest base class that i could find is vhost-user-base, but for using it, it has to implement all device-agnostic code from vhost-user-blk, and don't break all existing vhost-user-base derived devices. For example, to support inflight migration in base class, there first need to implement inflight field in it, along with the reconnect feature. Then, with a big refactor, somehow inherit vhost-user-blk from it, along with other devices such as vhost-user-fs.
>>
>> So, IMO it looks like a whole separate track that will need to be tackled.
>>
> I get that inflight is inside of struct VhostUserBlk, not in struct
> vhost_user. Even if not all device types support inflight I think that
> could probably be changed? If we do keep things as you have it here
> patch 1 should probably bring the vhost_dev_load_inflight() and
> vhost_dev_save_inflight() into vhost_user.c rather than vhost.c since
> only vhost_user devices seem to use inflight.

Firstly, I tried to implement inflight in the vhost_user structure, but 
this structure is initialized on every vhost_user_blk_connect() and then 
destroyed on every vhost_user_blk_disconnect(). But, the inflight region 
must survive device disconnect.

During active migration, the vhost_user struct will be destroyed before 
the inflight saving.

And you are right about the location of the functions in patch 1. I will 
move them to the vhost-user.c file, which will be more appropriate. Thanks!

>> As Markus noted this also conflicts significantly with Vladimir's
>> series so I'd suggest waiting until those are in, or possibly
>> attempting to generalize on top of his changes.
>>
>> Yea, but i think, i just need to perform inflight migration only when some non-local migration flag is set.
>>
> I'm not sure about that. While it may be completely safe in your case
> to avoid GET_VRING_BASE/quiescing the backend, it could introduce
> corruption cases on other vhost-user-blk storage backends which work
> differently. I think this would require an "opt-in" migration
> parameter over and above checking that it's not a local migration.
In patch 2 I introduce migration capability for that. Or you think that 
we need something like per-device parameter?
>
> Ideally there would be some way to have the vhost-user backends expose
> support per device with a protocol feature and, if the source and
> destination both advertise support, we perform the inflight migration
> skipping GET_VRING_BASE. I don't know enough about the migration code
> to know how that would be done or if it is practical.
>
> Also (and I think this also applies to Vladimir's series), it should
> be possible to add multiple vhost-user-blk devices to the same Qemu
> instance but have the devices backed by very different backend
> implementations. What happens if some of those backend implementations
> support things like lightweight local migration and/or inflight
> migration but others don't? Ideally you would want the API to be able
> to select target vhost-user-blk devices for accelerated migration
> rather than assuming they will all want to use the same features. I
> don't know if anyone is doing that or if we care about such cases but
> I just want to throw the concern out there.

Hmm, that looks like we need some per-device parameter in order to set 
this feature on for them.

I guess we need a opinion from migration maintainer about such cases

--------------AP47d7tBnIfmT2GQG50Q9BiN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/23/25 02:33, Raphael Norwitz
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, Oct 22, 2025 at 3:59 AM Alexandr Moshkov
<a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Hi!

On 10/21/25 23:54, Raphael Norwitz wrote:

The logic looks ok from the vhost-user-blk side but some comments inline.

On Mon, Oct 20, 2025 at 1:47 AM Alexandr Moshkov
<a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> wrote:

Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in vhost-user-blk.
Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
then, after migration, they will be executed on another host.

At first, I tried to implement migration for all vhost-user devices that support inflight at once,
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

Even if it's a more significant change I'd rather generalize as much
logic as possible and expose it as a vhost-user protocol feature. IMO
too much vhost-user device-agnositic code is being pushed into
vhost-user-blk.

As far as I understand (correct me if I'm wrong), but this feature must be implemented in device itself (along with inflight field location) or in some base class for vhost-user devices. For now vhost-user-blk doesn't have one yet. The closest base class that i could find is vhost-user-base, but for using it, it has to implement all device-agnostic code from vhost-user-blk, and don't break all existing vhost-user-base derived devices. For example, to support inflight migration in base class, there first need to implement inflight field in it, along with the reconnect feature. Then, with a big refactor, somehow inherit vhost-user-blk from it, along with other devices such as vhost-user-fs.

So, IMO it looks like a whole separate track that will need to be tackled.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I get that inflight is inside of struct VhostUserBlk, not in struct
vhost_user. Even if not all device types support inflight I think that
could probably be changed? If we do keep things as you have it here
patch 1 should probably bring the vhost_dev_load_inflight() and
vhost_dev_save_inflight() into vhost_user.c rather than vhost.c since
only vhost_user devices seem to use inflight.
</pre>
    </blockquote>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">Firstly, I tried to implement inflight in the vhost_user structure, but this structure is initialized on every vhost_user_blk_connect() and then destroyed on every vhost_user_blk_disconnect(). But, the inflight region must survive device disconnect. </span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">During active migration, the vhost_user struct will be destroyed before the inflight saving.</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">And you are right about the location of the functions in patch 1. I will move them to the vhost-user.c file, which will be more appropriate. Thanks!</span></p>
    <blockquote type="cite"
cite="mid:CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">As Markus noted this also conflicts significantly with Vladimir's
series so I'd suggest waiting until those are in, or possibly
attempting to generalize on top of his changes.

Yea, but i think, i just need to perform inflight migration only when some non-local migration flag is set.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm not sure about that. While it may be completely safe in your case
to avoid GET_VRING_BASE/quiescing the backend, it could introduce
corruption cases on other vhost-user-blk storage backends which work
differently. I think this would require an "opt-in" migration
parameter over and above checking that it's not a local migration.</pre>
    </blockquote>
    In patch 2 I introduce migration capability for that. Or you think
    that we need something like per-device param<span
    style="white-space: pre-wrap">eter?</span>
    <blockquote type="cite"
cite="mid:CAFubqFsFPoa5xuP1Pd=hhY1bo5vhLL4chhEpfVn3VxhR_SnZEQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

Ideally there would be some way to have the vhost-user backends expose
support per device with a protocol feature and, if the source and
destination both advertise support, we perform the inflight migration
skipping GET_VRING_BASE. I don't know enough about the migration code
to know how that would be done or if it is practical.

Also (and I think this also applies to Vladimir's series), it should
be possible to add multiple vhost-user-blk devices to the same Qemu
instance but have the devices backed by very different backend
implementations. What happens if some of those backend implementations
support things like lightweight local migration and/or inflight
migration but others don't? Ideally you would want the API to be able
to select target vhost-user-blk devices for accelerated migration
rather than assuming they will all want to use the same features. I
don't know if anyone is doing that or if we care about such cases but
I just want to throw the concern out there.
</pre>
    </blockquote>
    <p>Hmm, that looks like we need some per-device parameter in order
      to set this feature on for them.</p>
    <p>I guess we need a opinion from migration maintainer about such
      cases</p>
  </body>
</html>

--------------AP47d7tBnIfmT2GQG50Q9BiN--

