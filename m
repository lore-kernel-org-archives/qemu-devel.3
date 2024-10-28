Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A926D1359C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 12:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Oek-0000zu-5l; Mon, 28 Oct 2024 08:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1t5Oeh-0000zi-RP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:15:31 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1t5Oee-0002UM-Nd
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:15:31 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id A66BA1520F2C;
 Mon, 28 Oct 2024 13:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1730117719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Npmui7R0ZJojKtl9M40/JdyKwbEDIPldT3zvdmxfNs4=;
 b=eQHYLArPbnXaqnUZaOOgcklWSrtD8kme3gxEhd6MZP41ok2whz+nSFjHDLyN9/ot+3qsUt
 OC899++eIoYt9TnJMu1nROMtvjfWCQvVct5oNr9biD/mf7bdFrxgyVuitx908PDX5vimrA
 u/vGaDq45fNRAxCh8JCoP1mQoN2zvSl033u6gn85y9tcYbhdfNleclIIOqNJEEqDsFzIEv
 FHynGXPielywl9snnRA4Cp1jBMP7YOb7piNrrt7BjYBpuChf2/86Lq2nKmWvhtcEbIK+ZA
 0iB2vMLATz/8V0TI7AIrqBNSvrgRhpJyahMlzCeyoxbOPDYuTXqdoQzgIn6vOA==
Content-Type: multipart/alternative;
 boundary="------------zyxahYZQFeG5UReIOQ2KDn3t"
Message-ID: <25723cba-8c60-401e-8b9a-731430f0970d@dupond.be>
Date: Mon, 28 Oct 2024 13:15:18 +0100
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] qga: skip bind mounts in fs list
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
References: <20241002100634.162499-2-jean-louis@dupond.be>
 <b0a518bc-a600-4d0d-b1c9-5b43f95c90b9@dupond.be>
 <33d6a951-033d-4827-9d85-88fba69bf839@dupond.be>
 <CAPMcbCrkzq3dGSJBkYZ_bU8qYTvXDokgJGkh563gg8OHGqB1wQ@mail.gmail.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <CAPMcbCrkzq3dGSJBkYZ_bU8qYTvXDokgJGkh563gg8OHGqB1wQ@mail.gmail.com>
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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
--------------zyxahYZQFeG5UReIOQ2KDn3t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Konstantin,

Thanks for your response.
What I observed was when running CloudLinux is that with a /tmp on a 
loop device, is that the underlying fs was first freezed, and then the 
/tmp was getting a freeze call.
But this was hanging, because it couldn't freeze as the underlying fs 
was already freezed.

So the whole system became unresponsive expect if you send a unfreeze 
via sysrq.

Build a qemu-ga with this patch included, and then it worked fine.
Because it skips the bind mounts and therefor made sure that the loop 
device was first freezed and afterwards the underlying fs.
Which works fine :)

I did not see real kernel crashes, so that was not debugged/tested.

Thanks
Jean-Louis

On 28/10/2024 11:57, Konstantin Kostiuk wrote:
> Hi Jean-Louis,
>
> Thanks for your patch. I hope next week, I will test and review this 
> patch.
>
> Just a question, did you have a chance to test that this patch fix 
> kernel crash?
>
> Best Regards,
> Konstantin Kostiuk.
>
>
> On Fri, Oct 25, 2024 at 1:06 PM Jean-Louis Dupond 
> <jean-louis@dupond.be> wrote:
>
>     On 9/10/2024 10:34, Jean-Louis Dupond wrote:
>     > On 2/10/2024 12:06, Jean-Louis Dupond wrote:
>     >> The filesystem list in build_fs_mount_list should skip bind mounts.
>     >> This because we end up in locking situations when doing
>     fsFreeze. Like
>     >> mentioned in [1] and [2].
>     >>
>     >> Next to that, the build_fs_mount_list call did a fallback via
>     >> build_fs_mount_list_from_mtab if mountinfo did not exist.
>     >> There it skipped bind mounts, but this is broken for newer OS.
>     >> This as mounts does not return the path of the bind mount but the
>     >> underlying dev/partition, so S_ISDIR will never return true in
>     >> dev_major_minor call.
>     >>
>     >> This patch simply checks the existing devmajor:devminor tuple
>     in the
>     >> mounts, and if it already exists, this means we have the same
>     devices
>     >> mounted again, a bind mount. So skip this.
>     >>
>     >> Same approach is used in open-vm-tools [3].
>     >>
>     >> [1]: https://gitlab.com/qemu-project/qemu/-/issues/592
>     >> [2]: https://gitlab.com/qemu-project/qemu/-/issues/520
>     >> [3]:
>     >>
>     https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df22a8ab58
>     >>
>     >> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>     >> ---
>     >>   qga/commands-linux.c | 25 +++++++++++++++++++++++++
>     >>   1 file changed, 25 insertions(+)
>     >>
>     >> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>     >> index 51d5e3d927..426b040ab8 100644
>     >> --- a/qga/commands-linux.c
>     >> +++ b/qga/commands-linux.c
>     >> @@ -59,6 +59,22 @@ static int dev_major_minor(const char *devpath,
>     >>       return -1;
>     >>   }
>     >>   +/*
>     >> + * Check if we already have the devmajor:devminor in the mounts
>     >> + * If thats the case return true.
>     >> + */
>     >> +static bool dev_exists(FsMountList *mounts, unsigned int
>     devmajor,
>     >> unsigned int devminor)
>     >> +{
>     >> +    FsMount *mount;
>     >> +
>     >> +    QTAILQ_FOREACH(mount, mounts, next) {
>     >> +        if (mount->devmajor == devmajor && mount->devminor ==
>     >> devminor) {
>     >> +            return true;
>     >> +        }
>     >> +    }
>     >> +    return false;
>     >> +}
>     >> +
>     >>   static bool build_fs_mount_list_from_mtab(FsMountList *mounts,
>     >> Error **errp)
>     >>   {
>     >>       struct mntent *ment;
>     >> @@ -89,6 +105,10 @@ static bool
>     >> build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
>     >>               /* Skip bind mounts */
>     >>               continue;
>     >>           }
>     >> +        if (dev_exists(mounts, devmajor, devminor)) {
>     >> +            /* Skip already existing devices (bind mounts) */
>     >> +            continue;
>     >> +        }
>     >>             mount = g_new0(FsMount, 1);
>     >>           mount->dirname = g_strdup(ment->mnt_dir);
>     >> @@ -172,6 +192,11 @@ bool build_fs_mount_list(FsMountList *mounts,
>     >> Error **errp)
>     >>               }
>     >>           }
>     >>   +        if (dev_exists(mounts, devmajor, devminor)) {
>     >> +            /* Skip already existing devices (bind mounts) */
>     >> +            continue;
>     >> +        }
>     >> +
>     >>           mount = g_new0(FsMount, 1);
>     >>           mount->dirname = g_strdup(line + dir_s);
>     >>           mount->devtype = g_strdup(dash + type_s);
>     >
>     >
>     > Ping + add kkostiuk@redhat.com as I missed him in the initial mail.
>     >
>
>     Any chance on a review or getting it merged?
>     Think it's a good (of course ;)) improvement.
>
--------------zyxahYZQFeG5UReIOQ2KDn3t
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Konstantin,</p>
    <p>Thanks for your response.<br>
      What I observed was when running CloudLinux is that with a /tmp on
      a loop device, is that the underlying fs was first freezed, and
      then the /tmp was getting a freeze call.<br>
      But this was hanging, because it couldn't freeze as the underlying
      fs was already freezed.<br>
      <br>
      So the whole system became unresponsive expect if you send a
      unfreeze via sysrq.<br>
      <br>
      Build a qemu-ga with this patch included, and then it worked fine.<br>
      Because it skips the bind mounts and therefor made sure that the
      loop device was first freezed and afterwards the underlying fs.<br>
      Which works fine :)<br>
      <br>
      I did not see real kernel crashes, so that was not
      debugged/tested.<br>
      <br>
      Thanks<br>
      Jean-Louis<br>
    </p>
    <div class="moz-cite-prefix">On 28/10/2024 11:57, Konstantin Kostiuk
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPMcbCrkzq3dGSJBkYZ_bU8qYTvXDokgJGkh563gg8OHGqB1wQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Hi Jean-Louis,</div>
        <div><br>
        </div>
        <div>Thanks for your patch. I hope next week, I will test and
          review this patch. <br>
        </div>
        <div><br>
        </div>
        <div>Just a question, did you have a chance to test that this
          patch fix kernel crash? <br>
        </div>
        <div><br>
        </div>
        <div>
          <div>
            <div dir="ltr" class="gmail_signature"
              data-smartmail="gmail_signature">
              <div dir="ltr">
                <div>Best Regards,</div>
                <div>Konstantin Kostiuk.</div>
              </div>
            </div>
          </div>
          <br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, Oct 25, 2024 at
          1:06 PM Jean-Louis Dupond &lt;<a
            href="mailto:jean-louis@dupond.be" moz-do-not-send="true"
            class="moz-txt-link-freetext">jean-louis@dupond.be</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          9/10/2024 10:34, Jean-Louis Dupond wrote:<br>
          &gt; On 2/10/2024 12:06, Jean-Louis Dupond wrote:<br>
          &gt;&gt; The filesystem list in build_fs_mount_list should
          skip bind mounts.<br>
          &gt;&gt; This because we end up in locking situations when
          doing fsFreeze. Like<br>
          &gt;&gt; mentioned in [1] and [2].<br>
          &gt;&gt;<br>
          &gt;&gt; Next to that, the build_fs_mount_list call did a
          fallback via<br>
          &gt;&gt; build_fs_mount_list_from_mtab if mountinfo did not
          exist.<br>
          &gt;&gt; There it skipped bind mounts, but this is broken for
          newer OS.<br>
          &gt;&gt; This as mounts does not return the path of the bind
          mount but the<br>
          &gt;&gt; underlying dev/partition, so S_ISDIR will never
          return true in<br>
          &gt;&gt; dev_major_minor call.<br>
          &gt;&gt;<br>
          &gt;&gt; This patch simply checks the existing
          devmajor:devminor tuple in the<br>
          &gt;&gt; mounts, and if it already exists, this means we have
          the same devices<br>
          &gt;&gt; mounted again, a bind mount. So skip this.<br>
          &gt;&gt;<br>
          &gt;&gt; Same approach is used in open-vm-tools [3].<br>
          &gt;&gt;<br>
          &gt;&gt; [1]: <a
            href="https://gitlab.com/qemu-project/qemu/-/issues/592"
            rel="noreferrer" target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">https://gitlab.com/qemu-project/qemu/-/issues/592</a><br>
          &gt;&gt; [2]: <a
            href="https://gitlab.com/qemu-project/qemu/-/issues/520"
            rel="noreferrer" target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">https://gitlab.com/qemu-project/qemu/-/issues/520</a><br>
          &gt;&gt; [3]: <br>
          &gt;&gt; <a
href="https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df22a8ab58"
            rel="noreferrer" target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df22a8ab58</a><br>
          &gt;&gt;<br>
          &gt;&gt; Signed-off-by: Jean-Louis Dupond &lt;<a
            href="mailto:jean-louis@dupond.be" target="_blank"
            moz-do-not-send="true" class="moz-txt-link-freetext">jean-louis@dupond.be</a>&gt;<br>
          &gt;&gt; ---<br>
          &gt;&gt;   qga/commands-linux.c | 25 +++++++++++++++++++++++++<br>
          &gt;&gt;   1 file changed, 25 insertions(+)<br>
          &gt;&gt;<br>
          &gt;&gt; diff --git a/qga/commands-linux.c
          b/qga/commands-linux.c<br>
          &gt;&gt; index 51d5e3d927..426b040ab8 100644<br>
          &gt;&gt; --- a/qga/commands-linux.c<br>
          &gt;&gt; +++ b/qga/commands-linux.c<br>
          &gt;&gt; @@ -59,6 +59,22 @@ static int dev_major_minor(const
          char *devpath,<br>
          &gt;&gt;       return -1;<br>
          &gt;&gt;   }<br>
          &gt;&gt;   +/*<br>
          &gt;&gt; + * Check if we already have the devmajor:devminor in
          the mounts<br>
          &gt;&gt; + * If thats the case return true.<br>
          &gt;&gt; + */<br>
          &gt;&gt; +static bool dev_exists(FsMountList *mounts, unsigned
          int devmajor, <br>
          &gt;&gt; unsigned int devminor)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +    FsMount *mount;<br>
          &gt;&gt; +<br>
          &gt;&gt; +    QTAILQ_FOREACH(mount, mounts, next) {<br>
          &gt;&gt; +        if (mount-&gt;devmajor == devmajor
          &amp;&amp; mount-&gt;devminor == <br>
          &gt;&gt; devminor) {<br>
          &gt;&gt; +            return true;<br>
          &gt;&gt; +        }<br>
          &gt;&gt; +    }<br>
          &gt;&gt; +    return false;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt;   static bool
          build_fs_mount_list_from_mtab(FsMountList *mounts, <br>
          &gt;&gt; Error **errp)<br>
          &gt;&gt;   {<br>
          &gt;&gt;       struct mntent *ment;<br>
          &gt;&gt; @@ -89,6 +105,10 @@ static bool <br>
          &gt;&gt; build_fs_mount_list_from_mtab(FsMountList *mounts,
          Error **errp)<br>
          &gt;&gt;               /* Skip bind mounts */<br>
          &gt;&gt;               continue;<br>
          &gt;&gt;           }<br>
          &gt;&gt; +        if (dev_exists(mounts, devmajor, devminor))
          {<br>
          &gt;&gt; +            /* Skip already existing devices (bind
          mounts) */<br>
          &gt;&gt; +            continue;<br>
          &gt;&gt; +        }<br>
          &gt;&gt;             mount = g_new0(FsMount, 1);<br>
          &gt;&gt;           mount-&gt;dirname =
          g_strdup(ment-&gt;mnt_dir);<br>
          &gt;&gt; @@ -172,6 +192,11 @@ bool
          build_fs_mount_list(FsMountList *mounts, <br>
          &gt;&gt; Error **errp)<br>
          &gt;&gt;               }<br>
          &gt;&gt;           }<br>
          &gt;&gt;   +        if (dev_exists(mounts, devmajor,
          devminor)) {<br>
          &gt;&gt; +            /* Skip already existing devices (bind
          mounts) */<br>
          &gt;&gt; +            continue;<br>
          &gt;&gt; +        }<br>
          &gt;&gt; +<br>
          &gt;&gt;           mount = g_new0(FsMount, 1);<br>
          &gt;&gt;           mount-&gt;dirname = g_strdup(line + dir_s);<br>
          &gt;&gt;           mount-&gt;devtype = g_strdup(dash +
          type_s);<br>
          &gt;<br>
          &gt;<br>
          &gt; Ping + add <a href="mailto:kkostiuk@redhat.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">kkostiuk@redhat.com</a> as I
          missed him in the initial mail.<br>
          &gt;<br>
          <br>
          Any chance on a review or getting it merged?<br>
          Think it's a good (of course ;)) improvement.<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------zyxahYZQFeG5UReIOQ2KDn3t--

