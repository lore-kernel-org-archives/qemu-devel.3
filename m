Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B1106703C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0h6G-0001YK-Ld; Thu, 12 Mar 2026 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w0h69-0001Uy-Af
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:33:14 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w0h5w-0003Sx-Q8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:33:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 15A0A8086E;
 Thu, 12 Mar 2026 17:32:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:568::1:9] (unknown [2a02:6bf:8080:568::1:9])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nWIbtM0A7eA0-jebTKoDl; Thu, 12 Mar 2026 17:32:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773325970;
 bh=ExHzWp5GQReiLpjG0kjH0lUsYfDAtWVvueVL083txp0=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=mh6ynnslmo24yqqWdqWlEYEjzURR0EQPJhLdcFwISGAgFTAgD1ugUfa/ReOqRfLYc
 rxJYyWgF6OhSIc3e520aWbkHejbPtvAkT89idU3frGUXYec+nYidMORLE7u61jSJFu
 mxXQkf4w8aa+evuujUqcWdPA1Bv+Gp3pf3v7xGg8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------qYKr8LsMG0KRVzdRNM2GtSA9"
Message-ID: <5e6a8ca2-6475-413b-b77c-9fadae344978@yandex-team.ru>
Date: Thu, 12 Mar 2026 19:32:49 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmstate: fix subsection load name check
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>
References: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
 <878qbxyw0d.fsf@suse.de>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <878qbxyw0d.fsf@suse.de>
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
--------------qYKr8LsMG0KRVzdRNM2GtSA9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/12/26 19:15, Fabiano Rosas wrote:
> Alexandr Moshkov<dtalexundeer@yandex-team.ru> writes:
>
> Sorry, but I'll have to nitpick on the commit message, I can't parse
> this without looking at the code.
>
>> When loading a subset, its name is checked for the parent prefix. The
> What do you mean by subset?
Sorry, i wanted to write "subsection" here..
>
>> following bug may occur here:
>>
>> Let's say there is a vmstate named "virtio-blk", it has a subsection
>> named "virtio-blk/subsection", and it also has another vmstate named
>> "virtio" in the fields.
>> Then, during the migration, when trying to load this subsection for
> What is "this subsection" in this context? 'virtio-blk/subsection' ? Or do
> you mean the 'virtio' field.
Yes, "virtio-blk/subsection".
>
>> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> What's "the prefix condition" exactly? Could you be more explicit?
Ifthe vmstate nameisnotaprefixtothe subsection,thenwethinksucha 
subsectionshouldbe skipped to load for this vmstate,becauseitdoes 
notrelatetoit.
>
>> then the migration will break, because this vmstate does not have such a
>> subsection.
>>
>> In other words, if a field inside vmstate1 is set via vmstate2 with a
>> name that is a prefix of the parent vmstate, then the field can "steal"
>> a subsection belonging to the parent state.
>>
> This is what I read from the above paragraph. Is this it?
>
> vmstate1 "abc"         vmstate2 "abcdef"
>    field -> vmstate2
>    subsection
Yes, that's right.
>> Looks like it happens because migration stream for "virtio-blk" looks
>> like this:
>>
>>   [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
>>
>> "virtio-blk" contains "virtio" field, so migration stream is:
>>
>>   [virtio-blk header] [virtio header] [virtio fields] [virtio
>> subsections] [virtio-blk subsections]
>>
> So the code sees the [virtio-blk subsections] as a continuation of the
> preceding [virtio subsections] because the string "virtio", which is the
> parent of [virtio subsection] is matched in the string "virtio-blk"?
Yes, that's right too.
>
>> And when we load the subsections of the "virtio" device,
>> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
>> this is his subsection. This is where we encounter an error.
>>
>> Thus, the error occurs due to the fact that vmsd does not know how many
>> subsections it has when loading (this does not appear anywhere in the
>> migration stream), so it tries to load all the appropriate ones by
>> names.
>>
>> To fix this issue, we call vmstate_get_subsection() and, in case of
>> fail, ignore it, pop the VMSD stack and will try to define this
>> subsection for outer VMSD
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> ---
>>   migration/vmstate.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 4d28364f7b..8f3a69c26e 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -639,9 +639,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>>           sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>>           if (sub_vmsd == NULL) {
>>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
>> -            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
>> -                       idstr, vmsd->name);
>> -            return -ENOENT;
>> +            return 0;
>>           }
>>           qemu_file_skip(f, 1); /* subsection */
>>           qemu_file_skip(f, 1); /* len */
--------------qYKr8LsMG0KRVzdRNM2GtSA9
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
    <div class="moz-cite-prefix">On 3/12/26 19:15, Fabiano Rosas wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:878qbxyw0d.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> writes:

Sorry, but I'll have to nitpick on the commit message, I can't parse
this without looking at the code.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">When loading a subset, its name is checked for the parent prefix. The
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
What do you mean by subset?</pre>
    </blockquote>
    Sorry, i wanted to write "subsection" here..
    <blockquote type="cite" cite="mid:878qbxyw0d.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">following bug may occur here:

Let's say there is a vmstate named "virtio-blk", it has a subsection
named "virtio-blk/subsection", and it also has another vmstate named
"virtio" in the fields.
Then, during the migration, when trying to load this subsection for
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
What is "this subsection" in this context? 'virtio-blk/subsection' ? Or do
you mean the 'virtio' field.</pre>
    </blockquote>
    Yes, "virtio-blk/subsection".
    <blockquote type="cite" cite="mid:878qbxyw0d.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">"virtio", the prefix condition will pass for "virtio-blk/subsection" and
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
What's "the prefix condition" exactly? Could you be more explicit?</pre>
    </blockquote>
    <span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="0:4"
    style="white-space: pre-wrap;">If</span><span
    style="white-space: pre-wrap;"> the vmstate </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="5:3"
    style="white-space: pre-wrap;">name</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="9:7"
    style="white-space: pre-wrap;">is</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="17:2"
    style="white-space: pre-wrap;">not</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="20:8"
    style="white-space: pre-wrap;">a</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="29:9"
    style="white-space: pre-wrap;">prefix</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="39:1"
    style="white-space: pre-wrap;">to</span><span
    style="white-space: pre-wrap;"> the subsection</span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="51:1"
    style="white-space: pre-wrap;">,</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="53:5"
    style="white-space: pre-wrap;">then</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="59:2"
    style="white-space: pre-wrap;">we</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="62:7"
    style="white-space: pre-wrap;">think</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="70:5"
    style="white-space: pre-wrap;">such</span><span
    style="white-space: pre-wrap;"> a </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="41:10:76:9"
    style="white-space: pre-wrap;">subsection</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="86:5"
    style="white-space: pre-wrap;">should</span><span
    style="white-space: pre-wrap;"> be </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="92:10"
    style="white-space: pre-wrap;">skipped to load for this vmstate</span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="102:1"
    style="white-space: pre-wrap;">,</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="104:4"
    style="white-space: pre-wrap;">because</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="109:3"
    style="white-space: pre-wrap;">it</span><span
    style="white-space: pre-wrap;"> does </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="113:2"
    style="white-space: pre-wrap;">not</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="116:9"
    style="white-space: pre-wrap;">relate</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="126:1"
    style="white-space: pre-wrap;">to</span><span
    style="white-space: pre-wrap;"> it.</span>
    <blockquote type="cite" cite="mid:878qbxyw0d.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">then the migration will break, because this vmstate does not have such a
subsection.

In other words, if a field inside vmstate1 is set via vmstate2 with a
name that is a prefix of the parent vmstate, then the field can "steal"
a subsection belonging to the parent state.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is what I read from the above paragraph. Is this it?

vmstate1 "abc"         vmstate2 "abcdef"
  field -&gt; vmstate2
  subsection
</pre>
    </blockquote>
    Yes, that's right.
    <blockquote type="cite" cite="mid:878qbxyw0d.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Looks like it happens because migration stream for "virtio-blk" looks
like this:

 [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]

"virtio-blk" contains "virtio" field, so migration stream is:

 [virtio-blk header] [virtio header] [virtio fields] [virtio
subsections] [virtio-blk subsections]

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So the code sees the [virtio-blk subsections] as a continuation of the
preceding [virtio subsections] because the string "virtio", which is the
parent of [virtio subsection] is matched in the string "virtio-blk"?</pre>
    </blockquote>
    Yes, that's right too.
    <blockquote type="cite" cite="mid:878qbxyw0d.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">And when we load the subsections of the "virtio" device,
vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
this is his subsection. This is where we encounter an error.

Thus, the error occurs due to the fact that vmsd does not know how many
subsections it has when loading (this does not appear anywhere in the
migration stream), so it tries to load all the appropriate ones by
names.

To fix this issue, we call vmstate_get_subsection() and, in case of
fail, ignore it, pop the VMSD stack and will try to define this
subsection for outer VMSD

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 migration/vmstate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..8f3a69c26e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -639,9 +639,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd-&gt;subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd-&gt;name, idstr, "(lookup)");
-            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
-                       idstr, vmsd-&gt;name);
-            return -ENOENT;
+            return 0;
         }
         qemu_file_skip(f, 1); /* subsection */
         qemu_file_skip(f, 1); /* len */
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------qYKr8LsMG0KRVzdRNM2GtSA9--

