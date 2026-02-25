Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF21E9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv810-0003X8-68; Wed, 25 Feb 2026 01:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vv80v-0003Vv-FE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:04:49 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vv80s-0001k4-8Y
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:04:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5C62280762;
 Wed, 25 Feb 2026 09:04:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:4d::1:19] (unknown [2a02:6bf:8080:4d::1:19])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id e4aTxU7AGSw0-p3STJEBz; Wed, 25 Feb 2026 09:04:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771999481;
 bh=Lbk1qoN29i+Nwct3UUWiV3GvTHsg5YfIdU66pU37C6Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=f+t6FFTm72jB8uqioNn7w/arrYeU+nlQ4qpU/SQGcpoJtx001uEusT8n7um+tcLa8
 F1nDMVcD/qc2N/Oy2RXdFGF718YUX8LjqxKQkVjdVZZ3d9Yw7LTiI87a5Yq/nxKrBY
 Yfgr6/2aIitR/svlX6fLwCec/125lJhNgP7RYJ64=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <819b9493-327b-4765-bbd9-c592cd3cfcdd@yandex-team.ru>
Date: Wed, 25 Feb 2026 11:04:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
 <aZyjaw8Pz-xvZ3AZ@x1.local>
 <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
 <aZ3OQLHuYy0zEK76@x1.local>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aZ3OQLHuYy0zEK76@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 2/24/26 21:13, Peter Xu wrote:
> On Tue, Feb 24, 2026 at 12:10:20PM +0500, Alexandr Moshkov wrote:
>> On 2/23/26 23:58, Peter Xu wrote:
>>> On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
>>>> When loading a subset, its name is checked for the parent prefix. The
>>>> following bug may occur here:
>>>>
>>>> Let's say there is a vmstate named "virtio-blk", it has a subsection
>>>> named "virtio-blk/subsection", and it also has another vmstate named
>>>> "virtio" in the fields.
>>>> Then, during the migration, when trying to load this subsection for
>>>> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
>>>> then the migration will break, because this vmstate does not have such a
>>>> subsection.
>>>>
>>>> In other words, if a field inside vmstate1 is set via vmstate2 with a
>>>> name that is a prefix of the parent vmstate, then the field can "steal"
>>>> a subsection belonging to the parent state.
>>>>
>>>> Fix it by checking `/` at the end of idstr.
>>> Checking versus '\' looks reasonable, however I'm still confused on the
>>> example given, and what problem you hit.
>>>
>>> Here, your concern seems to be that vmstate_subsection_load() can
>>> accidentally load a FIELD of the parent VMSD whose name is exactly the name
>>> of the parent VMSD (which will be the prefix of all subsections).
>> Thanks for reply,
>>
>> vmstate_subsection_load() while trying to load a FIELD (whose name is prefix
>> of parent name) of the parent VMSD will try to load parent subsection.
>>
>>> Now my question is, when reaching the line you modified below, it needs to
>>> be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
>>> subsection rather than a field.  OTOH, when dumping a field, we never dump
>>> any name; I don't think we name FIELD at all..
>>>
>>> Could you share the failure you hit in real life?  That might help to
>>> understand the problem on its own.
>> Here is code example:
>>
>> ```
>>
>> static const VMStateDescription vmstate_vhost_user_virtio_blk_inflight = {
>> .name = "virtio-blk/inflight",
>> .version_id = 2,
>> .needed = vhost_user_blk_inflight_needed,
>> .fields = (const VMStateField[]) {
>> VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
>> VMSTATE_END_OF_LIST()
>> }
>> };
>>
>>
>> static const VMStateDescription vmstate_vhost_user_virtio_blk = {
>> .name = "virtio-blk",
>> .minimum_version_id = 2,
>> .version_id = 2,
>> .fields = (VMStateField[]) {
>> VMSTATE_VIRTIO_DEVICE,
>> VMSTATE_END_OF_LIST()
>> },
>> .subsections = (const VMStateDescription * []) {
>> &vmstate_vhost_user_virtio_blk_inflight,
>> NULL
>> }
>> };
>>
>> ```
>>
>> VMSTATE_VIRTIO_DEVICE is
>>
>> ```
>>
>> #define VMSTATE_VIRTIO_DEVICE \
>> { \
>> .name = "virtio", \
>> .info = &virtio_vmstate_info, \
>> .flags = VMS_SINGLE, \
>> }
>> ```
>> So here is "virtio-blk" vmsd that have "virtio" vmsd field and
>> "virtio-blk/inflight" subsection. This configuration will result in the fact
>> that inflight vmsd will not be loaded at all (assuming that it met all the
>> requirements). Qemu logs will contain trace_vmstate_subsection_load_bad
>> (lookup) error for "virtio" vmstate when loading "virtio-blk/inflight"
>> subsection.
> Thanks for the details.  However it didn't resolve my confusion.  Let me
> ask more explicitly.
>
> In this case, VMSTATE_VIRTIO_DEVICE will be a single field in the parent
> vmsd of "virtio-blk".  Meanwhile, "virtio-blk/inflight" will be the only
> subsection.
>
> Now, if you hit a LOOKUP error of trace_vmstate_subsection_load_bad(), it
> means the dst QEMU hits this:
>
> vmstate_subsection_load():
>          sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>          if (sub_vmsd == NULL) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
>              error_setg(errp, "VM subsection '%s' in '%s' does not exist",
>                         idstr, vmsd->name);
>              return -ENOENT;
>          }

Yes, and it will return -ENOENT. This causes an error in upper function. 
Error in destination qemu logs will looks like this:

[... load virtio field ...]
vmstate_subsection_load_bad virtio: virtio-blk/inflight/(lookup)
qemu-system-x86_64: Failed to load virtio-blk:virtio
vmstate_load_field_error field "virtio" load failed, ret = -2
qemu-system-x86_64: error while loading state for instance 0x0 of device 
'0000:80:03.0:00.0:00.0/virtio-blk'
qemu-system-x86_64: load of migration failed: No such file or directory

> IIUC, when reaching here, the load of VMSTATE_VIRTIO_DEVICE should have
> been completed, because we always load fields before subsections.
>
> Meanwhile, when reaching here, "idstr" should be "virtio-blk/inflight",
> because that's essentailly the only subsection this parent VMSD has.
>
> vmstate_get_subsection() should try to lookup all subsections matching it,
> and it should find it.
>
> I do not yet get why the VMSTATE_VIRTIO_DEVICE can get involved in the
> lookup (e.g. it is not on vmsd->subsections), and why it caused failure.
>
> Could you help me to find where I missed?
>
> Thanks,
>

