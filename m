Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1055FCC9C2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzpi9-0003Zg-V8; Tue, 10 Mar 2026 01:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vzpi7-0003ZG-RA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:32:51 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vzpi4-0002ed-J5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:32:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 73E2080758;
 Tue, 10 Mar 2026 08:32:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:190::1:24] (unknown
 [2a02:6bf:8080:190::1:24])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eW7K1Z1AaGk0-XJAxenkq; Tue, 10 Mar 2026 08:32:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773120761;
 bh=MSPdfkH2LYXYdLWghw8VSXKUqWEHLFOLcMpNFX3GwYs=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=Z83Ek+hJ1DxY36YZkGnHzj6sjmaMUKLptUCs5lZsiEgYASmCohucO2zX2QsYV8/gl
 Z/3Vd0vcn3wQZF60naRtVPxa6mDfOD7ZofuhjOIUFWhTIDuRi0YXMuridfhE1SLGU0
 zR1ENcRnhRzZjdDVnDGkxRVctCPJb7dLOETRdpOs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------gdyWSvfvmARHFqlxPSLw8MGh"
Message-ID: <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
Date: Tue, 10 Mar 2026 10:32:42 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <87y0k5136i.fsf@suse.de>
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
--------------gdyWSvfvmARHFqlxPSLw8MGh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/26 18:46, Fabiano Rosas wrote:
> Alexandr Moshkov<dtalexundeer@yandex-team.ru> writes:
>
>> When loading a subset, its name is checked for the parent prefix. The
>> following bug may occur here:
>>
>> Let's say there is a vmstate named "virtio-blk", it has a subsection
>> named "virtio-blk/subsection", and it also has another vmstate named
>> "virtio" in the fields.
>> Then, during the migration, when trying to load this subsection for
>> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
>> then the migration will break, because this vmstate does not have such a
>> subsection.
>>
>> In other words, if a field inside vmstate1 is set via vmstate2 with a
>> name that is a prefix of the parent vmstate, then the field can "steal"
>> a subsection belonging to the parent state.
>>
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
>> And when we load the subsections of the "virtio" device,
>> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
>> this is his subsection. This is where we encounter an error.
>>
>> Thus, the error occurs due to the fact that vmsd does not know how many
>> subsections it has when loading (this does not appear anywhere in the
>> migration stream), so it tries to load all the appropriate ones by
>> names.
>>
>> Fix it by checking `/` at the end of idstr.
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> ---
>>   migration/vmstate.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 4d28364f7b..187f3861f2 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>>   
>>       while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
>>           char idstr[256], *idstr_ret;
>> -        int ret;
>> +        int ret, vmsd_name_len;
>>           uint8_t version_id, len, size;
>>           const VMStateDescription *sub_vmsd;
>>   
>> @@ -631,7 +631,10 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>>           memcpy(idstr, idstr_ret, size);
>>           idstr[size] = 0;
>>   
>> -        if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
>> +        vmsd_name_len = strlen(vmsd->name);
>> +        if (strncmp(vmsd->name, idstr, vmsd_name_len) != 0 ||
>> +            /* to avoid taking parent subsection here */
>> +            idstr[vmsd_name_len] != '/') {
>>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
>>               /* it doesn't have a valid subsection name */
>>               return 0;
> Hi, this breaks migration for s390x and ppc64:
>
> qemu-system-s390x: Missing section footer for qemu-s390-flic

Thanks for reply! It happens because "qemu-s390-flic" vmsd has 
"qemu-s390-flic-full" subsection. I'm not sure if we can change the 
names of the existing subsections. Peter, what do you think?

It seemsto be a biggerproblemthatthe 
migrationframeworkdoesnotdocumentthe namesforsubsections in any 
way.Atthe same time, the codeimpliesthat atleastthe namesshould bea 
substringwithitsparent. There is even such a code comment `subsection 
name has to be "section_name/a"`, that seemsto implythe presenceof /.

--------------gdyWSvfvmARHFqlxPSLw8MGh
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
    <div class="moz-cite-prefix">On 3/6/26 18:46, Fabiano Rosas wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87y0k5136i.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> writes:

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

Looks like it happens because migration stream for "virtio-blk" looks
like this:

 [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]

"virtio-blk" contains "virtio" field, so migration stream is:

 [virtio-blk header] [virtio header] [virtio fields] [virtio
subsections] [virtio-blk subsections]

And when we load the subsections of the "virtio" device,
vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
this is his subsection. This is where we encounter an error.

Thus, the error occurs due to the fact that vmsd does not know how many
subsections it has when loading (this does not appear anywhere in the
migration stream), so it tries to load all the appropriate ones by
names.

Fix it by checking `/` at the end of idstr.

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 migration/vmstate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..187f3861f2 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
         char idstr[256], *idstr_ret;
-        int ret;
+        int ret, vmsd_name_len;
         uint8_t version_id, len, size;
         const VMStateDescription *sub_vmsd;
 
@@ -631,7 +631,10 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         memcpy(idstr, idstr_ret, size);
         idstr[size] = 0;
 
-        if (strncmp(vmsd-&gt;name, idstr, strlen(vmsd-&gt;name)) != 0) {
+        vmsd_name_len = strlen(vmsd-&gt;name);
+        if (strncmp(vmsd-&gt;name, idstr, vmsd_name_len) != 0 ||
+            /* to avoid taking parent subsection here */
+            idstr[vmsd_name_len] != '/') {
             trace_vmstate_subsection_load_bad(vmsd-&gt;name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
             return 0;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hi, this breaks migration for s390x and ppc64:

qemu-system-s390x: Missing section footer for qemu-s390-flic</pre>
    </blockquote>
    <p>Thanks for reply! It happens because "qemu-s390-flic" vmsd has
      "qemu-s390-flic-full" subsection. I'm not sure if we can change
      the names of the existing subsections. Peter, what do you think?</p>
    <p><span style="white-space: pre-wrap;">It </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="0:6"
      style="white-space: pre-wrap;">seems</span><span
      style="white-space: pre-wrap;"> to be a </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="7:7"
      style="white-space: pre-wrap;">bigger</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="15:8"
      style="white-space: pre-wrap;">problem</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="24:3"
      style="white-space: pre-wrap;">that</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="28:12"
      style="white-space: pre-wrap;">migration</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="41:9"
      style="white-space: pre-wrap;">framework</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="51:5"
      style="white-space: pre-wrap;">does</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="57:2"
      style="white-space: pre-wrap;">not</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="60:13"
      style="white-space: pre-wrap;">document</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="74:8"
      style="white-space: pre-wrap;">names</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="83:3"
      style="white-space: pre-wrap;">for</span><span
      style="white-space: pre-wrap;"> subsections in any </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="87:11"
      style="white-space: pre-wrap;">way</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="98:1"
      style="white-space: pre-wrap;">.</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="100:3"
      style="white-space: pre-wrap;">At</span><span
      style="white-space: pre-wrap;"> the same time, the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="109:3"
      style="white-space: pre-wrap;">code</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="113:13"
      style="white-space: pre-wrap;">implies</span><span
      style="white-space: pre-wrap;"> that </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="127:3"
      style="white-space: pre-wrap;">at</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="131:7"
      style="white-space: pre-wrap;">least</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="139:6"
      style="white-space: pre-wrap;">names</span><span
      style="white-space: pre-wrap;"> should </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="146:4"
      style="white-space: pre-wrap;">be</span><span
      style="white-space: pre-wrap;"> a </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="151:10"
      style="white-space: pre-wrap;">substring</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="162:1"
      style="white-space: pre-wrap;">with</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="164:3"
      style="white-space: pre-wrap;">its</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="168:9"
      style="white-space: pre-wrap;">parent</span><span
      style="white-space: pre-wrap;">. There is even such a code comment `subsection name has to be "section_name/a"`, </span><span
      style="white-space: pre-wrap;">that </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="35:5"
      style="white-space: pre-wrap;">seems</span><span
      style="white-space: pre-wrap;"> to </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="41:15"
      style="white-space: pre-wrap;">imply</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="57:7"
      style="white-space: pre-wrap;">presence</span><span
      style="white-space: pre-wrap;"> of /.</span></p>
    <p><span style="white-space: pre-wrap;"> </span></p>
    <p><span style="white-space: pre-wrap;"></span><span
      style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------gdyWSvfvmARHFqlxPSLw8MGh--

