Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F42ED2502F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 05:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfAm8-0005dt-Vh; Mon, 12 Jan 2026 00:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfAm6-0005cu-0W; Mon, 12 Jan 2026 00:47:34 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfAm3-0001II-11; Mon, 12 Jan 2026 00:47:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:11a5:0:640:fbe2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 48D808070E;
 Mon, 12 Jan 2026 08:47:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:6fcf:dbb2:9b0:d80b] (unknown
 [2a02:6bf:803e:400:6fcf:dbb2:9b0:d80b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KlKZDu0Ae0U0-hnQBW9eW; Mon, 12 Jan 2026 08:47:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768196843;
 bh=2xL+pbp/c/7jCx2MsofxoaPkXUOfId6pq6e5MiP+zFA=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=qpauIxaeoh42kCqoZxHMgF4fWRNl1/OD2OZZUEvU6j5zEnJ2mlW9+KJShCab7wveq
 qzADDGyhBxEKNzIwnxmL8tmt35ajXuwwmKmxs792I7dLAlCrabHjloWuJM91nYMLDf
 oxFHZmvmCgqhcrwa6LJXRi4NXIJWZUb9k3yjyQYs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------CuXEZwmLqkodHw7JkcQ0n9Po"
Message-ID: <e47d43ab-857b-4836-b032-620b4ee0b987@yandex-team.ru>
Date: Mon, 12 Jan 2026 10:47:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support inflight migration
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20251229102107.1291790-1-dtalexundeer@yandex-team.ru>
 <20260106190422.GB123256@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260106190422.GB123256@fedora>
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

This is a multi-part message in MIME format.
--------------CuXEZwmLqkodHw7JkcQ0n9Po
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi! Thanks for reply!

On 1/7/26 00:04, Stefan Hajnoczi wrote:
> On Mon, Dec 29, 2025 at 03:21:03PM +0500, Alexandr Moshkov wrote:
>> v4:
>> While testing inflight migration, I notices a problem with the fact that
>> GET_VRING_BASE is needed during migration, so the back-end stops
>> dirtying pages and synchronizes `last_avail` counter with QEMU. So after
>> migration in-flight I/O requests will be looks like resubmited on destination vm.
>>
>> However, in new logic, we no longer need to wait for in-flight requests
>> to be complete at GET_VRING_BASE message. So support new parameter
>> `should_drain` in the GET_VRING_BASE to allow back-end stop vrings
>> immediately without waiting for in-flight I/O requests to complete.
>>
>> Also:
>> - modify vhost-user rst
>> - refactor on vhost-user-blk.c, now `should_drain` is based on
>>    device parameter `inflight-migration`
>>
>> v3:
>> - use pre_load_errp instead of pre_load in vhost.c
>> - change vhost-user-blk property to
>>    "skip-get-vring-base-inflight-migration"
>> - refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher
>>
>> v2:
>> - rewrite migration using VMSD instead of qemufile API
>> - add vhost-user-blk parameter instead of migration capability
>>
>> I don't know if VMSD was used cleanly in migration implementation, so
>> feel free for comments.
>>
>> Based on Vladimir's work:
>> [PATCH v2 00/25] vhost-user-blk: live-backend local migration
>>    which was based on:
>>      - [PATCH v4 0/7] chardev: postpone connect
>>        (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
>>      - [PATCH v3 00/23] vhost refactoring and fixes
>>      - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler
>>
>> Based-on:<20250924133309.334631-1-vsementsov@yandex-team.ru>
>> Based-on:<20251015212051.1156334-1-vsementsov@yandex-team.ru>
>> Based-on:<20251015145808.1112843-1-vsementsov@yandex-team.ru>
>> Based-on:<20251015132136.1083972-15-vsementsov@yandex-team.ru>
>> Based-on:<20251016114104.1384675-1-vsementsov@yandex-team.ru>
>>
>> ---
>>
>> Hi!
>>
>> During inter-host migration, waiting for disk requests to be drained
>> in the vhost-user backend can incur significant downtime.
>>
>> This can be avoided if QEMU migrates the inflight region in vhost-user-blk.
>> Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
>> then, after migration, they will be executed on another host.
> I'm surprised by this statement because cancellation requires
> communication with the disk. If in-flight requests are slow to drain,
> then I would expect cancellation to be slow too. What kind of storage
> are you using?

Iprobablychosethe wrongword"cancel"todescribethe patch. 
Weimplementedthis logic as follows:the vhost-userserverdoes notwaitfor 
in-flightrequeststo complete,butmarksthemallwith specificstatusCANCEL 
-inreality, norequestis explicitlycanceled.Thenthe 
serverimmediatelyproceedstocompletethe connectionwiththe 
VM.Thus,allin-flightrequestsmigrateto thedestinationvm.

So,thisis moreabout ignoringin-flightrequeststhanactuallycancelingthem. 
In our case, this logic can lead to in-flight requests being sent to the 
backend twice, but this will not result in double execution of the 
requestson our disks.

>> At first, I tried to implement migration for all vhost-user devices that support inflight at once,
>> but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
>> in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).
>>
>> Therefore, for now I decided to leave this idea for later and
>> implement the migration of the inflight region first for vhost-user-blk.
> Sounds okay to me.
>
> I'm not sure about the change to GET_VRING_BASE. A new parameter is
> added without a feature bit, so there is no way to detect this feature
> at runtime. Maybe a VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
> feature bit should be added?
>
> Once a feature bit exists, it may not even be necessary to add the
> parameter to GET_VRING_BASE:
>
> When VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT is zero,
> GET_VRING_BASE drains in-flight I/O before completing. When
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT is one, the backend may
> leave requests in-flight (but host I/O requests must be cancelled in
> order to comply with the "Suspended device state" semantics) when
> GET_VRING_BASE completes.
>
> What do you think?
This solution looks much better! Thanks, I'll fix it.
>
>> Alexandr Moshkov (5):
>>    vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
>>    vhost-user: introduce should_drain on GET_VRING_BASE
>>    vmstate: introduce VMSTATE_VBUFFER_UINT64
>>    vhost: add vmstate for inflight region with inner buffer
>>    vhost-user-blk: support inter-host inflight migration
>>
>>   backends/cryptodev-vhost.c         |  2 +-
>>   backends/vhost-user.c              |  2 +-
>>   docs/interop/vhost-user.rst        |  8 +++-
>>   hw/block/vhost-user-blk.c          | 28 ++++++++++++-
>>   hw/net/vhost_net.c                 |  9 ++--
>>   hw/scsi/vhost-scsi-common.c        |  2 +-
>>   hw/virtio/vdpa-dev.c               |  2 +-
>>   hw/virtio/vhost-user-base.c        |  2 +-
>>   hw/virtio/vhost-user-fs.c          |  2 +-
>>   hw/virtio/vhost-user-scmi.c        |  2 +-
>>   hw/virtio/vhost-vsock-common.c     |  2 +-
>>   hw/virtio/vhost.c                  | 66 ++++++++++++++++++++++++++----
>>   include/hw/virtio/vhost-user-blk.h |  1 +
>>   include/hw/virtio/vhost.h          | 13 +++++-
>>   include/migration/vmstate.h        | 10 +++++
>>   15 files changed, 125 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.34.1
>>
--------------CuXEZwmLqkodHw7JkcQ0n9Po
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi! Thanks for reply!<br>
    </p>
    <div class="moz-cite-prefix">On 1/7/26 00:04, Stefan Hajnoczi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260106190422.GB123256@fedora">
      <pre wrap="" class="moz-quote-pre">On Mon, Dec 29, 2025 at 03:21:03PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">v4:
While testing inflight migration, I notices a problem with the fact that
GET_VRING_BASE is needed during migration, so the back-end stops
dirtying pages and synchronizes `last_avail` counter with QEMU. So after
migration in-flight I/O requests will be looks like resubmited on destination vm.

However, in new logic, we no longer need to wait for in-flight requests
to be complete at GET_VRING_BASE message. So support new parameter
`should_drain` in the GET_VRING_BASE to allow back-end stop vrings
immediately without waiting for in-flight I/O requests to complete.

Also:
- modify vhost-user rst
- refactor on vhost-user-blk.c, now `should_drain` is based on
  device parameter `inflight-migration`

v3:
- use pre_load_errp instead of pre_load in vhost.c
- change vhost-user-blk property to
  "skip-get-vring-base-inflight-migration"
- refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher

v2:
- rewrite migration using VMSD instead of qemufile API
- add vhost-user-blk parameter instead of migration capability

I don't know if VMSD was used cleanly in migration implementation, so
feel free for comments.

Based on Vladimir's work:
[PATCH v2 00/25] vhost-user-blk: live-backend local migration
  which was based on:
    - [PATCH v4 0/7] chardev: postpone connect
      (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
    - [PATCH v3 00/23] vhost refactoring and fixes
    - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler

Based-on: <a class="moz-txt-link-rfc2396E" href="mailto:20250924133309.334631-1-vsementsov@yandex-team.ru">&lt;20250924133309.334631-1-vsementsov@yandex-team.ru&gt;</a>
Based-on: <a class="moz-txt-link-rfc2396E" href="mailto:20251015212051.1156334-1-vsementsov@yandex-team.ru">&lt;20251015212051.1156334-1-vsementsov@yandex-team.ru&gt;</a>
Based-on: <a class="moz-txt-link-rfc2396E" href="mailto:20251015145808.1112843-1-vsementsov@yandex-team.ru">&lt;20251015145808.1112843-1-vsementsov@yandex-team.ru&gt;</a>
Based-on: <a class="moz-txt-link-rfc2396E" href="mailto:20251015132136.1083972-15-vsementsov@yandex-team.ru">&lt;20251015132136.1083972-15-vsementsov@yandex-team.ru&gt;</a>
Based-on: <a class="moz-txt-link-rfc2396E" href="mailto:20251016114104.1384675-1-vsementsov@yandex-team.ru">&lt;20251016114104.1384675-1-vsementsov@yandex-team.ru&gt;</a>

---

Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in vhost-user-blk.
Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
then, after migration, they will be executed on another host.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm surprised by this statement because cancellation requires
communication with the disk. If in-flight requests are slow to drain,
then I would expect cancellation to be slow too. What kind of storage
are you using?</pre>
    </blockquote>
    <p><span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="0:1"
      style="white-space: pre-wrap;">I</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="2:7"
      style="white-space: pre-wrap;">probably</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="10:6"
      style="white-space: pre-wrap;">chose</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="17:12"
      style="white-space: pre-wrap;">wrong</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="30:5"
      style="white-space: pre-wrap;">word</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="36:1"
      style="white-space: pre-wrap;">"</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="37:12"
      style="white-space: pre-wrap;">cancel</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="49:1"
      style="white-space: pre-wrap;">"</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="51:3"
      style="white-space: pre-wrap;">to</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="55:8"
      style="white-space: pre-wrap;">describe</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="64:5"
      style="white-space: pre-wrap;">patch</span><span
      style="white-space: pre-wrap;">.

</span><span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="71:1:78:2"
      style="white-space: pre-wrap;">We</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="85:11"
      style="white-space: pre-wrap;">implemented</span><span
      style="white-space: pre-wrap;"> this logic as </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="97:17"
      style="white-space: pre-wrap;">follows</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="114:1"
      style="white-space: pre-wrap;">:</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="116:5"
      style="white-space: pre-wrap;">vhost</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="121:1"
      style="white-space: pre-wrap;">-</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="122:4"
      style="white-space: pre-wrap;">user</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="127:6"
      style="white-space: pre-wrap;">server</span><span
      style="white-space: pre-wrap;"> does </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="134:2"
      style="white-space: pre-wrap;">not</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="137:10"
      style="white-space: pre-wrap;">wait</span><span
      style="white-space: pre-wrap;"> for </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="159:2"
      style="white-space: pre-wrap;">in</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="161:1"
      style="white-space: pre-wrap;">-</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="162:6"
      style="white-space: pre-wrap;">flight</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="169:8"
      style="white-space: pre-wrap;">requests</span><span
      style="white-space: pre-wrap;"> to </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="148:10"
      style="white-space: pre-wrap;">complete</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="177:1"
      style="white-space: pre-wrap;">,</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="179:1"
      style="white-space: pre-wrap;">but</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="181:8"
      style="white-space: pre-wrap;">marks</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="190:2"
      style="white-space: pre-wrap;">them</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="193:4"
      style="white-space: pre-wrap;">all</span><span
      style="white-space: pre-wrap;"> with specific</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="198:8"
      style="white-space: pre-wrap;">status</span><span
      style="white-space: pre-wrap;"> CANCEL </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="214:1"
      style="white-space: pre-wrap;">-</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="216:1"
      style="white-space: pre-wrap;">in</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="218:10"
      style="white-space: pre-wrap;">reality</span><span
      style="white-space: pre-wrap;">, </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="229:7"
      style="white-space: pre-wrap;">no</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="237:6"
      style="white-space: pre-wrap;">request</span><span
      style="white-space: pre-wrap;"> is </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="244:4"
      style="white-space: pre-wrap;">explicitly</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="253:10"
      style="white-space: pre-wrap;">canceled</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="263:1"
      style="white-space: pre-wrap;">.</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="265:5"
      style="white-space: pre-wrap;">
Then</span><span style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="271:6"
      style="white-space: pre-wrap;">server</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="278:5"
      style="white-space: pre-wrap;">immediately</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="284:9"
      style="white-space: pre-wrap;">proceeds</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="294:1"
      style="white-space: pre-wrap;">to</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="296:10"
      style="white-space: pre-wrap;">complete</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="307:8"
      style="white-space: pre-wrap;">connection</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="316:1"
      style="white-space: pre-wrap;">with</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="318:5"
      style="white-space: pre-wrap;">VM</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="323:1"
      style="white-space: pre-wrap;">.</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="325:13"
      style="white-space: pre-wrap;">Thus</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="338:1"
      style="white-space: pre-wrap;">,</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="340:3"
      style="white-space: pre-wrap;">all</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="344:2"
      style="white-space: pre-wrap;">in</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="346:1"
      style="white-space: pre-wrap;">-</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="347:6"
      style="white-space: pre-wrap;">flight</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="354:7"
      style="white-space: pre-wrap;">requests</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="362:9"
      style="white-space: pre-wrap;">migrate</span><span
      style="white-space: pre-wrap;"> to </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="372:2"
      style="white-space: pre-wrap;">the</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="375:11"
      style="white-space: pre-wrap;">destination</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="387:2"
      style="white-space: pre-wrap;">vm</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="389:1"
      style="white-space: pre-wrap;">.</span><span
      style="white-space: pre-wrap;">
</span></p>
    <p><span style="white-space: pre-wrap;">
</span><span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="391:3"
      style="white-space: pre-wrap;">So</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="398:1"
      style="white-space: pre-wrap;">,</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="400:3"
      style="white-space: pre-wrap;">this</span><span
      style="white-space: pre-wrap;"> is </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="404:6"
      style="white-space: pre-wrap;">more</span><span
      style="white-space: pre-wrap;"> about </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="411:17"
      style="white-space: pre-wrap;">ignoring</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="429:2"
      style="white-space: pre-wrap;">in</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="431:1"
      style="white-space: pre-wrap;">-</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="432:6"
      style="white-space: pre-wrap;">flight</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="439:8"
      style="white-space: pre-wrap;">requests</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="449:3"
      style="white-space: pre-wrap;">than</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="453:8"
      style="white-space: pre-wrap;">actually</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="465:6"
      style="white-space: pre-wrap;">canceling</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="462:2"
      style="white-space: pre-wrap;">them</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="471:1"
      style="white-space: pre-wrap;">. </span><span
      style="white-space: pre-wrap;">
In our case, this logic can lead to in-flight requests being sent to the backend twice, but this will not result in </span><span
      class="TIR_4zQIf1cnClIRNO3A" style="white-space: pre-wrap;"></span><span
      style="white-space: pre-wrap;">double execution of the </span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">requests</span><span
      style="white-space: pre-wrap;"> on our disks.</span></p>
    <blockquote type="cite" cite="mid:20260106190422.GB123256@fedora">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
At first, I tried to implement migration for all vhost-user devices that support inflight at once,
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

Therefore, for now I decided to leave this idea for later and
implement the migration of the inflight region first for vhost-user-blk.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Sounds okay to me.

I'm not sure about the change to GET_VRING_BASE. A new parameter is
added without a feature bit, so there is no way to detect this feature
at runtime. Maybe a VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
feature bit should be added?

Once a feature bit exists, it may not even be necessary to add the
parameter to GET_VRING_BASE:

When VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT is zero,
GET_VRING_BASE drains in-flight I/O before completing. When
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT is one, the backend may
leave requests in-flight (but host I/O requests must be cancelled in
order to comply with the "Suspended device state" semantics) when
GET_VRING_BASE completes.

What do you think?</pre>
    </blockquote>
    This solution looks much better! Thanks, I'll fix it.<br>
    <blockquote type="cite" cite="mid:20260106190422.GB123256@fedora">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Alexandr Moshkov (5):
  vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
  vhost-user: introduce should_drain on GET_VRING_BASE
  vmstate: introduce VMSTATE_VBUFFER_UINT64
  vhost: add vmstate for inflight region with inner buffer
  vhost-user-blk: support inter-host inflight migration

 backends/cryptodev-vhost.c         |  2 +-
 backends/vhost-user.c              |  2 +-
 docs/interop/vhost-user.rst        |  8 +++-
 hw/block/vhost-user-blk.c          | 28 ++++++++++++-
 hw/net/vhost_net.c                 |  9 ++--
 hw/scsi/vhost-scsi-common.c        |  2 +-
 hw/virtio/vdpa-dev.c               |  2 +-
 hw/virtio/vhost-user-base.c        |  2 +-
 hw/virtio/vhost-user-fs.c          |  2 +-
 hw/virtio/vhost-user-scmi.c        |  2 +-
 hw/virtio/vhost-vsock-common.c     |  2 +-
 hw/virtio/vhost.c                  | 66 ++++++++++++++++++++++++++----
 include/hw/virtio/vhost-user-blk.h |  1 +
 include/hw/virtio/vhost.h          | 13 +++++-
 include/migration/vmstate.h        | 10 +++++
 15 files changed, 125 insertions(+), 26 deletions(-)

-- 
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------CuXEZwmLqkodHw7JkcQ0n9Po--

