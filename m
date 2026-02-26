Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CF0FC5909
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvW6S-0001FG-2s; Thu, 26 Feb 2026 02:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vvW6Q-0001Ev-Mm
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:48:06 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vvW6N-0003u2-Q1
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:48:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4782780D5E;
 Thu, 26 Feb 2026 10:47:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:1f::1:3a] (unknown [2a02:6bf:8080:1f::1:3a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tlcwQu7AE8c0-IzJ84hwO; Thu, 26 Feb 2026 10:47:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772092077;
 bh=pozOZFz+A/t1duB0Ez/IjrU/hVdTd8b10lKyoKH/+QI=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=ynhJDi/5X3w75ZdVyU6M7szEEytUkguSRxAO+4VwapoJXdmZPw3vYwq+6PGZQvleA
 3Rj5CybIcl7lxLJ6sDN6HJebwpMxRnsn79linuzgKz9H4qkKDOIn9CNFr6LvhupIt+
 Fk5ijDeqnijTFZZgPKbfsyhq5iT3CxY3UZZd5HHg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------utQ1UmbkWT4Qj7evAM5vFaEi"
Message-ID: <ee35b828-c8e9-4850-be64-72d0842b2dde@yandex-team.ru>
Date: Thu, 26 Feb 2026 12:47:55 +0500
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
 <819b9493-327b-4765-bbd9-c592cd3cfcdd@yandex-team.ru>
 <aZ8wGsxhkD76LRBD@x1.local>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aZ8wGsxhkD76LRBD@x1.local>
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

This is a multi-part message in MIME format.
--------------utQ1UmbkWT4Qj7evAM5vFaEi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/25/26 22:23, Peter Xu wrote:
> On Wed, Feb 25, 2026 at 11:04:40AM +0500, Alexandr Moshkov wrote:
>> On 2/24/26 21:13, Peter Xu wrote:
>>> On Tue, Feb 24, 2026 at 12:10:20PM +0500, Alexandr Moshkov wrote:
>>>> On 2/23/26 23:58, Peter Xu wrote:
>>>>> On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
>>>>>> When loading a subset, its name is checked for the parent prefix. The
>>>>>> following bug may occur here:
>>>>>>
>>>>>> Let's say there is a vmstate named "virtio-blk", it has a subsection
>>>>>> named "virtio-blk/subsection", and it also has another vmstate named
>>>>>> "virtio" in the fields.
>>>>>> Then, during the migration, when trying to load this subsection for
>>>>>> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
>>>>>> then the migration will break, because this vmstate does not have such a
>>>>>> subsection.
>>>>>>
>>>>>> In other words, if a field inside vmstate1 is set via vmstate2 with a
>>>>>> name that is a prefix of the parent vmstate, then the field can "steal"
>>>>>> a subsection belonging to the parent state.
>>>>>>
>>>>>> Fix it by checking `/` at the end of idstr.
>>>>> Checking versus '\' looks reasonable, however I'm still confused on the
>>>>> example given, and what problem you hit.
>>>>>
>>>>> Here, your concern seems to be that vmstate_subsection_load() can
>>>>> accidentally load a FIELD of the parent VMSD whose name is exactly the name
>>>>> of the parent VMSD (which will be the prefix of all subsections).
>>>> Thanks for reply,
>>>>
>>>> vmstate_subsection_load() while trying to load a FIELD (whose name is prefix
>>>> of parent name) of the parent VMSD will try to load parent subsection.
>>>>
>>>>> Now my question is, when reaching the line you modified below, it needs to
>>>>> be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
>>>>> subsection rather than a field.  OTOH, when dumping a field, we never dump
>>>>> any name; I don't think we name FIELD at all..
>>>>>
>>>>> Could you share the failure you hit in real life?  That might help to
>>>>> understand the problem on its own.
>>>> Here is code example:
>>>>
>>>> ```
>>>>
>>>> static const VMStateDescription vmstate_vhost_user_virtio_blk_inflight = {
>>>> .name = "virtio-blk/inflight",
>>>> .version_id = 2,
>>>> .needed = vhost_user_blk_inflight_needed,
>>>> .fields = (const VMStateField[]) {
>>>> VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
>>>> VMSTATE_END_OF_LIST()
>>>> }
>>>> };
>>>>
>>>>
>>>> static const VMStateDescription vmstate_vhost_user_virtio_blk = {
>>>> .name = "virtio-blk",
>>>> .minimum_version_id = 2,
>>>> .version_id = 2,
>>>> .fields = (VMStateField[]) {
>>>> VMSTATE_VIRTIO_DEVICE,
>>>> VMSTATE_END_OF_LIST()
>>>> },
>>>> .subsections = (const VMStateDescription * []) {
>>>> &vmstate_vhost_user_virtio_blk_inflight,
>>>> NULL
>>>> }
>>>> };
>>>>
>>>> ```
>>>>
>>>> VMSTATE_VIRTIO_DEVICE is
>>>>
>>>> ```
>>>>
>>>> #define VMSTATE_VIRTIO_DEVICE \
>>>> { \
>>>> .name = "virtio", \
>>>> .info = &virtio_vmstate_info, \
>>>> .flags = VMS_SINGLE, \
>>>> }
>>>> ```
>>>> So here is "virtio-blk" vmsd that have "virtio" vmsd field and
>>>> "virtio-blk/inflight" subsection. This configuration will result in the fact
>>>> that inflight vmsd will not be loaded at all (assuming that it met all the
>>>> requirements). Qemu logs will contain trace_vmstate_subsection_load_bad
>>>> (lookup) error for "virtio" vmstate when loading "virtio-blk/inflight"
>>>> subsection.
>>> Thanks for the details.  However it didn't resolve my confusion.  Let me
>>> ask more explicitly.
>>>
>>> In this case, VMSTATE_VIRTIO_DEVICE will be a single field in the parent
>>> vmsd of "virtio-blk".  Meanwhile, "virtio-blk/inflight" will be the only
>>> subsection.
>>>
>>> Now, if you hit a LOOKUP error of trace_vmstate_subsection_load_bad(), it
>>> means the dst QEMU hits this:
>>>
>>> vmstate_subsection_load():
>>>           sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>>>           if (sub_vmsd == NULL) {
>>>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
>>>               error_setg(errp, "VM subsection '%s' in '%s' does not exist",
>>>                          idstr, vmsd->name);
>>>               return -ENOENT;
>>>           }
>> Yes, and it will return -ENOENT. This causes an error in upper function.
>> Error in destination qemu logs will looks like this:
>>
>> [... load virtio field ...]
>> vmstate_subsection_load_bad virtio: virtio-blk/inflight/(lookup)
> Yes, this implies vmstate_get_subsection() failure.
>
>> qemu-system-x86_64: Failed to load virtio-blk:virtio
> This implies the above failure happened in a nested load of
> "virtio-blk:virtio", rather than the top "virtio-blk".
>
> Here virtio_load invokes two vmstate_load_state on vdc->vmsd,
> vmstate_virtio.
>
> If the loader side was trying to lookup the "/inflight" subsection within
> e.g. vmstate_virtio then it will fail indeed, but I don't understand why it
> sees the "/inflight" subsection.  Can you help explain?

Yes, looks like it happens because migration stream for "virtio-blk" 
looks like this:

[virtio-blk header] [virtio-blk fields] [virtio-blk subsections]

"virtio-blk" contains "virtio" field, so migration stream is:

[virtio-blk header] [virtio header] [virtio fields] [virtio subsections] 
[virtio-blk subsections]

And when we load the subsections of the "virtio" device, 
vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if 
this is his subsection. This is where we encounter an error.

Thus, the error occurs due to the fact that vmsd does not know how many 
subsections it has when loading (this does not appear anywhere in the 
migration stream), so it tries to load all the appropriate ones by names.

>
> Are you using different versions of QEMU on src/dst when testing?  If
> they're different (or with different patches applied), please spell them
> out.
>
> Or if you could help me to answer what is missing that I stated below it
> might also help me to figure out what I missed.  So far I'm still a bit
> lost and not yet understand why this patch helps..
>
> Thanks,
>
>> vmstate_load_field_error field "virtio" load failed, ret = -2
>> qemu-system-x86_64: error while loading state for instance 0x0 of device
>> '0000:80:03.0:00.0:00.0/virtio-blk'
>> qemu-system-x86_64: load of migration failed: No such file or directory
>>
>>> IIUC, when reaching here, the load of VMSTATE_VIRTIO_DEVICE should have
>>> been completed, because we always load fields before subsections.
>>>
>>> Meanwhile, when reaching here, "idstr" should be "virtio-blk/inflight",
>>> because that's essentailly the only subsection this parent VMSD has.
>>>
>>> vmstate_get_subsection() should try to lookup all subsections matching it,
>>> and it should find it.
>>>
>>> I do not yet get why the VMSTATE_VIRTIO_DEVICE can get involved in the
>>> lookup (e.g. it is not on vmsd->subsections), and why it caused failure.
>>>
>>> Could you help me to find where I missed?
>>>
>>> Thanks,
>>>
--------------utQ1UmbkWT4Qj7evAM5vFaEi
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
    <div class="moz-cite-prefix">On 2/25/26 22:23, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aZ8wGsxhkD76LRBD@x1.local">
      <pre wrap="" class="moz-quote-pre">On Wed, Feb 25, 2026 at 11:04:40AM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 2/24/26 21:13, Peter Xu wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Tue, Feb 24, 2026 at 12:10:20PM +0500, Alexandr Moshkov wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 2/23/26 23:58, Peter Xu wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">When loading a subset, its name is checked for the parent prefix. The
following bug may occur here:

Let's say there is a vmstate named "virtio-blk", it has a subsection
named "virtio-blk/subsection", and it also has another vmstate named
"virtio" in the fields.
Then, during the migration, when trying to load this subsection for
"virtio", the prefix condition will pass for "virtio-blk/subsection" and
then the migration will break, because this vmstate does not have such a
subsection.

In other words, if a field inside vmstate1 is set via vmstate2 with a
name that is a prefix of the parent vmstate, then the field can "steal"
a subsection belonging to the parent state.

Fix it by checking `/` at the end of idstr.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">Checking versus '\' looks reasonable, however I'm still confused on the
example given, and what problem you hit.

Here, your concern seems to be that vmstate_subsection_load() can
accidentally load a FIELD of the parent VMSD whose name is exactly the name
of the parent VMSD (which will be the prefix of all subsections).
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Thanks for reply,

vmstate_subsection_load() while trying to load a FIELD (whose name is prefix
of parent name) of the parent VMSD will try to load parent subsection.

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Now my question is, when reaching the line you modified below, it needs to
be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
subsection rather than a field.  OTOH, when dumping a field, we never dump
any name; I don't think we name FIELD at all..

Could you share the failure you hit in real life?  That might help to
understand the problem on its own.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Here is code example:

```

static const VMStateDescription vmstate_vhost_user_virtio_blk_inflight = {
.name = "virtio-blk/inflight",
.version_id = 2,
.needed = vhost_user_blk_inflight_needed,
.fields = (const VMStateField[]) {
VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
VMSTATE_END_OF_LIST()
}
};


static const VMStateDescription vmstate_vhost_user_virtio_blk = {
.name = "virtio-blk",
.minimum_version_id = 2,
.version_id = 2,
.fields = (VMStateField[]) {
VMSTATE_VIRTIO_DEVICE,
VMSTATE_END_OF_LIST()
},
.subsections = (const VMStateDescription * []) {
&amp;vmstate_vhost_user_virtio_blk_inflight,
NULL
}
};

```

VMSTATE_VIRTIO_DEVICE is

```

#define VMSTATE_VIRTIO_DEVICE \
{ \
.name = "virtio", \
.info = &amp;virtio_vmstate_info, \
.flags = VMS_SINGLE, \
}
```
So here is "virtio-blk" vmsd that have "virtio" vmsd field and
"virtio-blk/inflight" subsection. This configuration will result in the fact
that inflight vmsd will not be loaded at all (assuming that it met all the
requirements). Qemu logs will contain trace_vmstate_subsection_load_bad
(lookup) error for "virtio" vmstate when loading "virtio-blk/inflight"
subsection.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Thanks for the details.  However it didn't resolve my confusion.  Let me
ask more explicitly.

In this case, VMSTATE_VIRTIO_DEVICE will be a single field in the parent
vmsd of "virtio-blk".  Meanwhile, "virtio-blk/inflight" will be the only
subsection.

Now, if you hit a LOOKUP error of trace_vmstate_subsection_load_bad(), it
means the dst QEMU hits this:

vmstate_subsection_load():
         sub_vmsd = vmstate_get_subsection(vmsd-&gt;subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd-&gt;name, idstr, "(lookup)");
             error_setg(errp, "VM subsection '%s' in '%s' does not exist",
                        idstr, vmsd-&gt;name);
             return -ENOENT;
         }
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Yes, and it will return -ENOENT. This causes an error in upper function.
Error in destination qemu logs will looks like this:

[... load virtio field ...]
vmstate_subsection_load_bad virtio: virtio-blk/inflight/(lookup)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yes, this implies vmstate_get_subsection() failure.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">qemu-system-x86_64: Failed to load virtio-blk:virtio
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This implies the above failure happened in a nested load of
"virtio-blk:virtio", rather than the top "virtio-blk".

Here virtio_load invokes two vmstate_load_state on vdc-&gt;vmsd,
vmstate_virtio.

If the loader side was trying to lookup the "/inflight" subsection within
e.g. vmstate_virtio then it will fail indeed, but I don't understand why it
sees the "/inflight" subsection.  Can you help explain?</pre>
    </blockquote>
    <p>Yes, looks like it happens because migration stream for
      "virtio-blk" looks like this:</p>
    <p>[virtio-blk header] [virtio-blk fields] [virtio-blk subsections]</p>
    <p>"virtio-blk" contains "virtio" field, so migration stream is:</p>
    <p>[virtio-blk header] [virtio header] [virtio fields] [virtio
      subsections] [virtio-blk subsections]</p>
    <p>And when we load the subsections of the "virtio" device,
      vmstate_subsection_load() uses qemu_peek_byte() to try to figure
      out if this is his subsection. This is where we encounter an
      error.</p>
    <p><span style="white-space: pre-wrap;">Thus, the error occurs due to the fact that vmsd does not know how many subsections it has when loading (this does not appear anywhere in the migration stream), so it tries to load all the appropriate ones by names.</span></p>
    <blockquote type="cite" cite="mid:aZ8wGsxhkD76LRBD@x1.local">
      <pre wrap="" class="moz-quote-pre">

Are you using different versions of QEMU on src/dst when testing?  If
they're different (or with different patches applied), please spell them
out.

Or if you could help me to answer what is missing that I stated below it
might also help me to figure out what I missed.  So far I'm still a bit
lost and not yet understand why this patch helps..

Thanks,

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">vmstate_load_field_error field "virtio" load failed, ret = -2
qemu-system-x86_64: error while loading state for instance 0x0 of device
'0000:80:03.0:00.0:00.0/virtio-blk'
qemu-system-x86_64: load of migration failed: No such file or directory

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">IIUC, when reaching here, the load of VMSTATE_VIRTIO_DEVICE should have
been completed, because we always load fields before subsections.

Meanwhile, when reaching here, "idstr" should be "virtio-blk/inflight",
because that's essentailly the only subsection this parent VMSD has.

vmstate_get_subsection() should try to lookup all subsections matching it,
and it should find it.

I do not yet get why the VMSTATE_VIRTIO_DEVICE can get involved in the
lookup (e.g. it is not on vmsd-&gt;subsections), and why it caused failure.

Could you help me to find where I missed?

Thanks,

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------utQ1UmbkWT4Qj7evAM5vFaEi--

