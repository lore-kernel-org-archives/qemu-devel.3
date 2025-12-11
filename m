Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76ACD41D59
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTib3-0007Ji-M3; Thu, 11 Dec 2025 10:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTiaz-0007JB-RO
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:28:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTiax-0006dR-66
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:28:45 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BBFSL10011999
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Dec 2025 00:28:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=w/t0LDqQ9Knb1vwIejvnWbL/mUIsRMQi5sAL6bYXuXk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1765466905; v=1;
 b=Bf9Zosu9F2ZCxbejNhLEa4kpoGZrycpJwp5Nqzw1+Vn6jlEMTpRgl7YFb7GxymJm
 4MsIPNGuSUPUU1zta3Kk9n84OqJSBmGUeOQZcPR9dygGlrz0PqnXu6cGdsCPEZDB
 cxO2qe4y5eEDfM57vTdxQXGbKOhB/UaDhQQH0InodqnFp85jz0bOirblDMQEqJY9
 eqUrfB+41GcxXyRqgQIHYLG9862VKnIZfiQAkH1K13EVvt5r9AgBCAjZr5wxX8hh
 xQA3puMZL54zdzT8alKOT77brlRc4WJiraWtq+tg2eo1ZEabxWLgqqg/KF7roE2A
 c3DIo7wyEqrY492ArAhdZQ==
Message-ID: <a3b5e158-adae-4c66-89f9-7f0af26c63da@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Dec 2025 00:28:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/10 1:28, Peter Xu wrote:
> [This is an RFC series, as being marked out.  It is trying to collect
>   opinions.  It's not for merging yet]
> 
> Background
> ==========
> 
> It all starts with machine compat properties..
> 
> Machine compat properties are the major weapon we use currently in QEMU to
> define a proper guest ABI, so that whenever we migration a VM instance from
> whatever QEMU version1 to another QEMU version2, as long as the machine
> type is the same, logically the ABI is guaranteed, and migration should
> succeed.  If it didn't, it's a bug.
> 
> These compat properties are only attached to qdev for now.  It almost
> worked.
> 
> Said that, it's also not true - we already have non-qdev users of such, by
> explicitly code it up to apply the compat fields.  Please refer to the
> first patch commit message for details (meanwhile latter patches will
> convert them into a generic model).
> 
> Obviously, we have demands to leverage machine compat properties even
> outside of qdev.  It can be a network backend, it can be an object (for
> example, memory backends), it can be a migration object, and more.
> 
> This series tries to introduce a common root class OBJECT_COMPAT for it.  I
> didn't abuse OBJECT because I know there're too many OBJECTs that do not
> need compat properties at all.  With this design, we can also opt-in piece
> by piece on the new root class, only when needed.
> 
> Class OBJECT_COMPAT
> ===================
> 
> This is almost OBJECT class, except that it'll also apply machine compat
> properties from anywhere.  One can refer to patch 1.
> 
> Note that currently I didn't further identify the three possible source of
> object_compat_props[3] (accel, machine compat property, legacy globals).  I
> don't think it's a huge issue so far because non-qdev objects will not
> collapse with names in accel / legacy globals, due to the fact that object
> names cannot dup acorss QEMU binary.  So I kept the changeset as minimum as
> possible.  Feel free to shoot if there's concerns I overlooked.
> 
> This part is done in patch 1-6.  This is the part I felt slightly more
> confident with.  Meanwhile, these will be the dependency if we want to
> e.g. allow TAP network backends to take compat properties like a virtio-net
> frontend (but likely we'll need to QOMify TAP first).  That's something for
> the future even if applicable.
> 
> Export Property from QDEV
> =========================
> 
> I also have patch 7-10 below for one step further beyond OBJECT_COMPAT.
> Feel free to take it even as a seperate small series to review.
> 
> So far the first part will be the focus, but I still want to collect
> opinions here on this second part.  This is about exporting Property for
> non-qdev uses.  Currently, migration is the only user.
> 
> In short, Property is something qdev uses internally to ultimately
> represents ObjectClass's properties hash table.  It's pretty handy to
> e.g. avoid definining accessors for object properties, setting default
> values, etc.  Then they'll be converted to Object properties at some point.
> 
> Migration object currently defines all the global fields in Property and
> can use "-global migration.XXX" to allow global overrides, with almost one
> line for each property, which is efficient.
> 
> This 2nd step will allow migration object to inherit from OBJECT_COMPAT too
> with almost only a few lines of changes, and keep the functionality as-is.
> 
> Two other options we have:
> 
>    (1) Keep migration object to be a qdev, it's still fine, even if it
>        sounds hackish.. if we want to keep "-global" working as before
> 
>    (2) Inherit OBJECT_COMPAT without supporting "-global" anymore.
> 
> Any comments welcomed, especially on the first half (1-6), thanks.

I'm actually less sure if the first half makes sense than the second half.

Exporting Property from QDEV did make me think it may be polluting the 
codebase with QDEV-specifics, but its motivation (creating properties 
without defining accessors) is clear and it meets its requirement.

The motivation is less concrete for the first half. It says the current 
code is explicit, but it is a relative term. I'm not sure if specifying 
TYPE_OBJECT_COMPAT is less explicit (or more implicit) than calling 
object_apply_compat_props(). Also, having a class for compat props but 
not for global props makes the decision look arbitrary. It is nice to 
have some clarification on these.

Regards,
Akihiko Odaki

> 
> Peter Xu (10):
>    qom: Introduce object-compat
>    qdev: Inherit from TYPE_OBJECT_COMPAT
>    hostmem: Inherit from TYPE_OBJECT_COMPAT
>    accel: Inherit from TYPE_OBJECT_COMPAT
>    confidential guest support: Inherit from TYPE_OBJECT_COMPAT
>    qom: Unexport object_apply_compat_props()
>    qdev: Pave way for exporting Property to be used in non-qdev
>    qdev: Introduce helper object_apply_globals()
>    qdev: Refactor and rename of qdev_class_add_property()
>    migration: Inherit from TYPE_OBJECT_COMPAT
> 
>   include/hw/qdev-properties.h          | 11 ++++++++
>   include/qom/object.h                  |  2 +-
>   migration/migration.h                 |  2 +-
>   accel/accel-common.c                  |  2 +-
>   backends/confidential-guest-support.c |  2 +-
>   backends/hostmem.c                    |  8 +-----
>   hw/core/qdev-properties.c             | 37 +++++++++++++++++++++------
>   hw/core/qdev.c                        |  6 ++---
>   migration/migration.c                 | 31 +++++++++++-----------
>   qom/object.c                          | 16 +++++++++++-
>   system/vl.c                           |  1 -
>   target/i386/sev.c                     |  1 -
>   12 files changed, 79 insertions(+), 40 deletions(-)
> 


