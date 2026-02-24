Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804BEEFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumYy-0003d3-Vg; Tue, 24 Feb 2026 02:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vumYw-0003cd-GV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 02:10:30 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vumYs-0008MW-LM
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 02:10:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2F33F807FC;
 Tue, 24 Feb 2026 10:10:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:515::1:1d] (unknown
 [2a02:6bf:8080:515::1:1d])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IAai9x6A1Os0-m1TJWu1M; Tue, 24 Feb 2026 10:10:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771917020;
 bh=UoN65ke4fkNVZhaux1bKsvgKQSyqpX4ZlHWrMSjyIL8=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=b89nhanlavGeQgEEowwoG6DajlNdX1j0HDereFP/PPLYztGy7Pe/lYAGxbM8DqS6K
 LHptAh96O8hr39B2lSWOsjTL1JDcxaXesZuu+EFJEikCBlwOOWboQo6shL5HJPo4ZQ
 gEMLLB4fJNtCdElUQOqL4FCZQzoZZwsZFAXqLEtw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------oS04YtdL96s9e9InkEzxgMTw"
Message-ID: <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
Date: Tue, 24 Feb 2026 12:10:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
 <aZyjaw8Pz-xvZ3AZ@x1.local>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aZyjaw8Pz-xvZ3AZ@x1.local>
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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
--------------oS04YtdL96s9e9InkEzxgMTw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/23/26 23:58, Peter Xu wrote:
> On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
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
>> Fix it by checking `/` at the end of idstr.
> Checking versus '\' looks reasonable, however I'm still confused on the
> example given, and what problem you hit.
>
> Here, your concern seems to be that vmstate_subsection_load() can
> accidentally load a FIELD of the parent VMSD whose name is exactly the name
> of the parent VMSD (which will be the prefix of all subsections).

Thanks for reply,

vmstate_subsection_load() while trying to load a FIELD (whose name is 
prefix of parent name) of the parent VMSD will try to load parent 
subsection.

>
> Now my question is, when reaching the line you modified below, it needs to
> be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
> subsection rather than a field.  OTOH, when dumping a field, we never dump
> any name; I don't think we name FIELD at all..
>
> Could you share the failure you hit in real life?  That might help to
> understand the problem on its own.

Here is code example:

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
&vmstate_vhost_user_virtio_blk_inflight,
NULL
}
};

```

VMSTATE_VIRTIO_DEVICE is

```

#define VMSTATE_VIRTIO_DEVICE \
{ \
.name = "virtio", \
.info = &virtio_vmstate_info, \
.flags = VMS_SINGLE, \
}
```
So here is "virtio-blk" vmsd that have "virtio" vmsd field and 
"virtio-blk/inflight" subsection. This configuration will result in the 
fact that inflight vmsd will not be loaded at all (assuming that it met 
all the requirements). Qemu logs will contain 
trace_vmstate_subsection_load_bad (lookup) error for "virtio" vmstate 
when loading "virtio-blk/inflight" subsection.


Thanks

> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
> ---
>   migration/vmstate.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..e9901ee349 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>   
>       while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
>           char idstr[256], *idstr_ret;
> -        int ret;
> +        int ret, vmsd_name_len;
>           uint8_t version_id, len, size;
>           const VMStateDescription *sub_vmsd;
>   
> @@ -631,7 +631,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>           memcpy(idstr, idstr_ret, size);
>           idstr[size] = 0;
>   
> -        if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
> +        vmsd_name_len = strlen(vmsd->name);
> +        if (strncmp(vmsd->name, idstr, vmsd_name_len) != 0 ||
> +            idstr[vmsd_name_len] != '/') {
>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
>               /* it doesn't have a valid subsection name */
>               return 0;
> -- 
> 2.34.1
>
>
--------------oS04YtdL96s9e9InkEzxgMTw
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
    <div class="moz-cite-prefix">On 2/23/26 23:58, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aZyjaw8Pz-xvZ3AZ@x1.local">
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
      <pre wrap="" class="moz-quote-pre">
Checking versus '\' looks reasonable, however I'm still confused on the
example given, and what problem you hit.

Here, your concern seems to be that vmstate_subsection_load() can
accidentally load a FIELD of the parent VMSD whose name is exactly the name
of the parent VMSD (which will be the prefix of all subsections).</pre>
    </blockquote>
    <p>Thanks for reply,</p>
    <p>vmstate_subsection_load() while trying to load a FIELD (whose
      name is prefix of parent name) of the parent VMSD will try to load
      parent subsection.  </p>
    <blockquote type="cite" cite="mid:aZyjaw8Pz-xvZ3AZ@x1.local">
      <pre wrap="" class="moz-quote-pre">

Now my question is, when reaching the line you modified below, it needs to
be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
subsection rather than a field.  OTOH, when dumping a field, we never dump
any name; I don't think we name FIELD at all..

Could you share the failure you hit in real life?  That might help to
understand the problem on its own.</pre>
    </blockquote>
    <p>Here is code example:</p>
    <p>```</p>
    <div
style="background-color: rgb(255, 255, 255); font-family: &quot;Input mono&quot;, &quot;monospace&quot;, monospace, &quot;Droid Sans Mono&quot;, monospace; font-weight: normal; font-size: 14px; line-height: 19px; white-space: pre;"><div>static const VMStateDescription vmstate_vhost_user_virtio_blk_inflight = {</div><div>    .name = "virtio-blk/inflight",</div><div>    .version_id = 2,</div><div>    .needed = vhost_user_blk_inflight_needed,</div><div>    .fields = (const VMStateField[]) {</div><div>        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),</div><div>        VMSTATE_END_OF_LIST()</div><div>    }</div><div>};</div></div>
    <p><br>
    </p>
    <div
style="background-color: rgb(255, 255, 255); font-family: &quot;Input mono&quot;, &quot;monospace&quot;, monospace, &quot;Droid Sans Mono&quot;, monospace; font-weight: normal; font-size: 14px; line-height: 19px; white-space: pre;"><div>static const VMStateDescription vmstate_vhost_user_virtio_blk = {</div><div>    .name = "virtio-blk",</div><div>    .minimum_version_id = 2,</div><div>    .version_id = 2,</div><div>    .fields = (VMStateField[]) {</div><div>        VMSTATE_VIRTIO_DEVICE,</div><div>        VMSTATE_END_OF_LIST()</div><div>    },</div><div>    .subsections = (const VMStateDescription * []) {</div><div>        &amp;vmstate_vhost_user_virtio_blk_inflight,</div><div>        NULL</div><div>    }</div><div>};</div></div>
    <p>```</p>
    <p>VMSTATE_VIRTIO_DEVICE is </p>
    <p>```</p>
    <div
style="color: #000000;background-color: #ffffff;font-family: 'Input mono', 'monospace', monospace, 'Droid Sans Mono', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div>#define VMSTATE_VIRTIO_DEVICE \</div><div>    {                                         \</div><div>        .name = "virtio",                     \</div><div>        .info = &amp;virtio_vmstate_info,         \</div><div>        .flags = VMS_SINGLE,                  \</div><div>    }</div><div>```</div><div>
</div><div>
</div><div>So here is "virtio-blk" vmsd that have "virtio" vmsd field and "virtio-blk/inflight" subsection. <span
    style="white-space: pre-wrap;">This configuration will result in the fact that inflight vmsd will not be loaded at all (assuming that it met all the requirements). Qemu logs will contain</span> trace_vmstate_subsection_load_bad (lookup) error for "virtio" vmstate when loading "virtio-blk/inflight" subsection.</div></div>
    <p><br>
    </p>
    <p>Thanks</p>
    <blockquote type="cite" cite="mid:aZyjaw8Pz-xvZ3AZ@x1.local">
      <pre wrap="" class="moz-quote-pre">Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 migration/vmstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..e9901ee349 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
         char idstr[256], *idstr_ret;
-        int ret;
+        int ret, vmsd_name_len;
         uint8_t version_id, len, size;
         const VMStateDescription *sub_vmsd;
 
@@ -631,7 +631,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         memcpy(idstr, idstr_ret, size);
         idstr[size] = 0;
 
-        if (strncmp(vmsd-&gt;name, idstr, strlen(vmsd-&gt;name)) != 0) {
+        vmsd_name_len = strlen(vmsd-&gt;name);
+        if (strncmp(vmsd-&gt;name, idstr, vmsd_name_len) != 0 ||
+            idstr[vmsd_name_len] != '/') {
             trace_vmstate_subsection_load_bad(vmsd-&gt;name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
             return 0;
-- 
2.34.1


</pre>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------oS04YtdL96s9e9InkEzxgMTw--

