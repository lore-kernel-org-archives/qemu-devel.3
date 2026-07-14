Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C442DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjjSy-00076P-OT; Tue, 14 Jul 2026 16:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentino.paulon88@gmail.com>)
 id 1wjfiZ-0000OV-Vo
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:10:48 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <valentino.paulon88@gmail.com>)
 id 1wjfiW-00037G-1s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:10:47 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a483a552efso264482b6e.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045442; cv=none;
 d=google.com; s=arc-20260327;
 b=pSyUcsCk/UGNXfkxTkkPi/PK+F7kN1IgWqDXU2+5a02FH2jEl0yOQITwqV+08ylq1Y
 IrdDm+aN/X6EbqJdw1FflNqh11BBbI3tM0Hyk8cD9jZlG8XU2LchD/LOJqNj/FHrZJkz
 FXgZ37Um4c4bfnyli4M6rQKvTL9vOoTcVRhUtyMFWPsdQrbtcgwkXJ/Wa7qGcOmlmDOW
 +GIBvb3b8mFmg5RGnrYoL4irmf1kYC28P35sjz1BozejE4xgvRtQuOOzENuH/695GXyO
 RjZxGpz126UaReze0s9vqH6ygPHdJaLrVZXdSs37UL7ZRHlAMjyHXPIcHQFe8UVO6wN9
 /UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NAHbMduCdPTRw4LIzN8jR3UGx8rjDacfsgIeyMlPOnU=;
 fh=UqGKuxG2uuAkcXWun4BvW+vxDhhYyekQMODegFyFMIM=;
 b=dxf5VNqkDNLChQfZQh2Gi3aG1jhYWaQJ5C9u+9NEspGeSEv+X02qef/yF89kCJVG20
 qH+6axvk8sPbBrWP6Aoxc+xh8oYjjCDmx6q3O/sWsNkoJgW8E0PgTAcdUYDv6XMjYTmg
 e3TBkN40xaFFsgJgR3vTe4tcEGaFZ+EcKGdCofnPt+Pkx8E+ktBlKRTj1d0jfWozzHzU
 lvUGdZWPQJCQV58ztITdwvLbByKea13XBSCCt+SuaazpWWA4tNZAPO1BrwRfwqL/f/xf
 CCAlC2sfpUgoS6FxaxZzc5XD34WJF2TZZFDjmKuHH4mM7XDaoGXTJFiO5ORuGwufN8om
 I0fg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784045442; x=1784650242; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NAHbMduCdPTRw4LIzN8jR3UGx8rjDacfsgIeyMlPOnU=;
 b=XRIVmxLkZDFP2WSst1FZ5hKS7pGEXL4cKupsi3ODY4rx16rnsH7rHeJ2cpMWbTt4mR
 BU7QkqesPRf8BAGWEBchDvsEUbhjuKI0hGWKeNOBggCeoUYejWnBJXs2/qjjUGfJxewl
 oP3FPQnZxGp6ivFHbAXHAmjWROpvT1WHkHC35LQjTVec5znidLkpYRHj2xHt5jahMRUz
 lP+LOHqmKRNIPV0uW9P/BjJnvUDgig2KXRgUeTHWNMLVCuq8rPX0o4h3yqmHhjIXk3lI
 Sh4iAsp1tc4j2DDGvwVO+t3eS305c4A3QaCj9aZx9qxrAFdBRaLKeVJBT4oMnRJqqZUa
 NHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784045442; x=1784650242;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NAHbMduCdPTRw4LIzN8jR3UGx8rjDacfsgIeyMlPOnU=;
 b=XC/Eui6pE7xK7hivirliyqcgKvlTxG2dmMhPeBOuQGQYMDcx/92ZjMepWpiKH4jT7U
 cECAIenffjsfh1nppkMGWTcPIdCqL1dXFWVj7Ea5GAl816EkQdNJR3E2k9bVQRruBGKU
 XZNt4neel7APBwvLVDEJZ13QeFQ6n3luuDJPlIDJ8gQpdu3hyYLJ36BZ0Rux9KD0To1e
 /na7RnE2GurwGojEzX8u9ZMrt/M9xPPQV/4kasKQ7YqXK7W4sW1sf2WxwRgRvoMYlN98
 a/euiRL0HWVh6dSKqmhkN/BLdaxLNDNR5UH6tENE1IDJdGfZeDXVJqrGCSOmMVySOH7G
 B0+w==
X-Gm-Message-State: AOJu0YzA6tRJ1knbtN4cVBvp0LRw5wd4h8u7uGrZSc1mcEhkC+O2cgbv
 GGDu9aqUlBIL2sFq+cCUwYlSdKHQSje3fuLiq55ZazmqvNdTgLcwL4G30lc8G7BU/IMS/tTxMgG
 gmaxG6MaJbAs0ffJJQ0d5AxMBe03pXv9glNKnIHVlB9oC
X-Gm-Gg: AfdE7ckueFXdOY35GOYgqpEkK23B3tH0BRBaGxLo5Nca/EOTTIvd2vi6hwGnXZ14V+R
 rbc3CmW13tNR23Fxv1Os+iVqjNclXK/3TH2ARTDwEQfIKGHBXuHnOSCTcvNZdbI5ybmFcm3XbTW
 8DH+XBVROMPMNN9YgnoqY1tfjs4SZi4hsP/l6T/ZZ9sdtm+EhJ5dW6jp9DkOTY8/BWLS51KalfZ
 wLz/NqG6qCxQnyxwTc7TUrmUfpbbYtVThwZXZGv0s8L1r9WXptOXQNzwwRxchSEDpN11yQ=
X-Received: by 2002:a05:6808:151e:b0:4a4:c12:49d9 with SMTP id
 5614622812f47-4a42ace0782mr8385541b6e.3.1784045442288; Tue, 14 Jul 2026
 09:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
 <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
In-Reply-To: <alYdwKHMWoVcay_B@redhat.com>
From: Valentino Paulon <valentino.paulon88@gmail.com>
Date: Tue, 14 Jul 2026 18:10:30 +0200
X-Gm-Features: AUfX_myyEDx4o3wqGK4o71lNMmMSqYPZsjlqvfIpsqEG2Awo6WfjVEZ2zm_NX5A
Message-ID: <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: qemu-devel@nongnu.org, berrange@redhat.com, kkostiuk@redhat.com
Cc: yvugenfi@redhat.com, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000d9cf2d065694722c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=valentino.paulon88@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Jul 2026 16:10:55 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

--000000000000d9cf2d065694722c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > So, you propose to call seteuid/setegid before any I/O operation?
>
> Yes, specifically for the SSH commands, because they're unusual in
> that we're doing stuff on behalf of an unprivileged user.

+1 on the euid/egid direction -- as the reporter that's the outcome I
was hoping for. It confines every step (read, mkdir, create, rename,
chown) to what the target user could already do himself, which removes
the whole TOCTOU class instead of chasing one instance of it.

A few implementation details that tend to bite with this pattern, in
case they save a round-trip:

- drop the supplementary groups too, not just egid: initgroups() (or
setgroups() with the user's list) while still root, otherwise the
agent's effective access won't match the user's in either direction
-- e.g. group-writable paths under the home.
- keep the real uid at 0 and change euid/egid only, so it stays
reversible; setegid() before seteuid() on the way down, restore in
reverse.
- effective ids are process-wide, so this assumes the SSH command is
not doing its I/O from more than one thread concurrently -- worth a
quick check against the agent's dispatch model.

The passwd lookup already runs before any of this, so it can stay
outside the dropped region.

Happy to re-run my PoC against the reworked version once it's ready and
confirm the window is closed.

Regards,
Valentino Paulon

On Tue, Jul 14, 2026 02:30 PM, "Daniel P. Berrang=C3=A9" <berrange@redhat.c=
om>
wrote:

> On Tue, Jul 14, 2026 at 02:28:35PM +0300, Kostiantyn Kostiuk wrote:
> > On Tue, Jul 14, 2026 at 1:37=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com>
> > wrote:
> >
> > > On Thu, Jul 09, 2026 at 01:57:07PM +0300, Kostiantyn Kostiuk wrote:
> > > > Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> > > > SSH key for an existing local user, the agent (running as root)
> decides
> > > > whether to create the user's .ssh directory with a symlink-followin=
g
> > > > directory test, and then writes and chowns the authorized_keys file=
.
> > > > A local unprivileged user who owns their home directory can pre-sta=
ge
> > > > their .ssh directory (or the authorized_keys file) as a symbolic li=
nk
> > > > so that, when the host or operator triggers a key add for that user=
,
> > > > the root agent follows the link and transfers ownership of an
> arbitrary
> > > > root-owned file or directory to the unprivileged user, who can then
> > > rewrite
> > > > it to obtain root
> > > >
> > > > Fixes: CVE-2026-12080
> > > > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> > > >
> > > > Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> > > > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > > > ---
> > > >  qga/commands-posix-ssh.c | 53
> ++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 45 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> > > > index 661972e34e..4e717d8ae8 100644
> > > > --- a/qga/commands-posix-ssh.c
> > > > +++ b/qga/commands-posix-ssh.c
> > > > @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const struct
> passwd
> > > *p,
> > > >          return false;
> > > >      }
> > > >
> > > > -    if (chown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> > > > +    if (lchown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> > > >          error_setg_errno(errp, errno,
> > > >                           "failed to set ownership of directory
> '%s'",
> > > >                           path);
> > > > @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GStrv keys=
,
> > > >          return false;
> > > >      }
> > > >
> > > > -    if (chown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> > > > +    if (lchown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> > > >          error_setg_errno(errp, errno,
> > > >                           "failed to set ownership of directory
> '%s'",
> > > >                           path);
> > > > @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const char
> > > *username, strList *keys,
> > > >      g_auto(GStrv) authkeys =3D NULL;
> > > >      strList *k;
> > > >      size_t nkeys, nauthkeys;
> > > > +    int fd;
> > > >
> > > >      reset =3D has_reset && reset;
> > > >
> > > > @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(const char
> > > *username, strList *keys,
> > > >      ssh_path =3D g_build_filename(p->pw_dir, ".ssh", NULL);
> > > >      authkeys_path =3D g_build_filename(ssh_path, "authorized_keys"=
,
> NULL);
> > > >
> > > > +    fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> > > > +    if (fd =3D=3D -1) {
> > > > +        if (errno !=3D ENOENT) {
> > > > +            error_setg_errno(errp, errno, "failed to open director=
y
> > > '%s'", ssh_path);
> > > > +            return;
> > > > +        }
> > > > +    }
> > >
> > > IIUC, you're trying to protect against the possbility that
> /home/fred/.ssh
> > > is
> > > a symlink to some other privileged directory.
> > >
> > > >      if (!reset) {
> > > >          authkeys =3D read_authkeys(authkeys_path, NULL);
> > > >      }
> > > >      if (authkeys =3D=3D NULL) {
> > > > -        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
> > > > -            !mkdir_for_user(ssh_path, p, 0700, errp)) {
> > > > +        if (fd =3D=3D -1 && !mkdir_for_user(ssh_path, p, 0700, err=
p)) {
> > > >              return;
> > > >          }
> > > >      }
> > > > +    if (fd >=3D 0) {
> > > > +        close(fd);
> > > > +    }
> > >
> > > Does holding open an FD on a directory prevent that directory being
> > > altered ?  Even if it prevents it being deleted, surely there's still
> > > a race where the dir could be renamed, andd .ssh turned back into a
> > > symlink ?
> > >
> >
> > Yes, you are right; race is possible
> >
> >
> > >
> > > Rather than do these checks and switch chown->lchown, I wonder if we
> > > are better off having the agent simply change its effective UID/GID
> > > while it updates the SSH key files ? That way the agent would be
> > > confined just like the user would be and we don't need to implement
> > > special cases, nor would we have to think about race conditions.
> > >
> > >
> > So, you propose to call seteuid/setegid before any I/O operation?
>
> Yes, specifically for the SSH commands, because they're unusual in
> that we're doing stuff on behalf of an unprivileged user.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000d9cf2d065694722c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"auto">&gt; &gt; So, you =
propose to call seteuid/setegid before any I/O operation?<br>&gt;<br>&gt; Y=
es, specifically for the SSH commands, because they&#39;re unusual in<br>&g=
t; that we&#39;re doing stuff on behalf of an unprivileged user.<br><br>+1 =
on the euid/egid direction -- as the reporter that&#39;s the outcome I<br>w=
as hoping for. It confines every step (read, mkdir, create, rename,<br>chow=
n) to what the target user could already do himself, which removes<br>the w=
hole TOCTOU class instead of chasing one instance of it.<br><br>A few imple=
mentation details that tend to bite with this pattern, in<br>case they save=
 a round-trip:<br><br>  - drop the supplementary groups too, not just egid:=
 initgroups() (or<br>    setgroups() with the user&#39;s list) while still =
root, otherwise the<br>    agent&#39;s effective access won&#39;t match the=
 user&#39;s in either direction<br>    -- e.g. group-writable paths under t=
he home.<br>  - keep the real uid at 0 and change euid/egid only, so it sta=
ys<br>    reversible; setegid() before seteuid() on the way down, restore i=
n<br>    reverse.<br>  - effective ids are process-wide, so this assumes th=
e SSH command is<br>    not doing its I/O from more than one thread concurr=
ently -- worth a<br>    quick check against the agent&#39;s dispatch model.=
<br><br>The passwd lookup already runs before any of this, so it can stay<b=
r>outside the dropped region.<br><br>Happy to re-run my PoC against the rew=
orked version once it&#39;s ready and<br>confirm the window is closed.<br><=
br>Regards,<br>Valentino Paulon<br></div></div></div><br><div class=3D"gmai=
l_extra"><div>On Tue, Jul 14, 2026 02:30 PM, &quot;Daniel P. Berrang=C3=A9&=
quot; &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange=
@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Tue, Jul 14, 2026 at 02:28:35PM +0300, Kostiantyn Kostiuk wrote:<br=
>
&gt; On Tue, Jul 14, 2026 at 1:37=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Thu, Jul 09, 2026 at 01:57:07PM +0300, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; Before this commit, when qmp_guest_ssh_add_authorized_keys a=
dds an<br>
&gt; &gt; &gt; SSH key for an existing local user, the agent (running as ro=
ot) decides<br>
&gt; &gt; &gt; whether to create the user&#39;s .ssh directory with a symli=
nk-following<br>
&gt; &gt; &gt; directory test, and then writes and chowns the authorized_ke=
ys file.<br>
&gt; &gt; &gt; A local unprivileged user who owns their home directory can =
pre-stage<br>
&gt; &gt; &gt; their .ssh directory (or the authorized_keys file) as a symb=
olic link<br>
&gt; &gt; &gt; so that, when the host or operator triggers a key add for th=
at user,<br>
&gt; &gt; &gt; the root agent follows the link and transfers ownership of a=
n arbitrary<br>
&gt; &gt; &gt; root-owned file or directory to the unprivileged user, who c=
an then<br>
&gt; &gt; rewrite<br>
&gt; &gt; &gt; it to obtain root<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fixes: CVE-2026-12080<br>
&gt; &gt; &gt; Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/wor=
k_items/3929" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-=
project/qemu/-/work_items/3929</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Reported-by: Valentino Paulon &lt;<a href=3D"mailto:valentin=
o.paulon88@gmail.com" target=3D"_blank">valentino.paulon88@gmail.com</a>&gt=
;<br>
&gt; &gt; &gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++=
++++++++++------<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 45 insertions(+), 8 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-s=
sh.c<br>
&gt; &gt; &gt; index 661972e34e..4e717d8ae8 100644<br>
&gt; &gt; &gt; --- a/qga/commands-posix-ssh.c<br>
&gt; &gt; &gt; +++ b/qga/commands-posix-ssh.c<br>
&gt; &gt; &gt; @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const str=
uct passwd<br>
&gt; &gt; *p,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (chown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (lchown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, err=
no,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to set ownership of dire=
ctory &#39;%s&#39;&quot;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path);<br>
&gt; &gt; &gt; @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GSt=
rv keys,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (chown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (lchown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, err=
no,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to set ownership of dire=
ctory &#39;%s&#39;&quot;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path);<br>
&gt; &gt; &gt; @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const =
char<br>
&gt; &gt; *username, strList *keys,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 strList *k;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 size_t nkeys, nauthkeys;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 reset =3D has_reset &amp;&amp; reset;<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(cons=
t char<br>
&gt; &gt; *username, strList *keys,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 ssh_path =3D g_build_filename(p-&gt;pw_d=
ir, &quot;.ssh&quot;, NULL);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 authkeys_path =3D g_build_filename(ssh_p=
ath, &quot;authorized_keys&quot;, NULL);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLO=
W);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(=
errp, errno, &quot;failed to open directory<br>
&gt; &gt; &#39;%s&#39;&quot;, ssh_path);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; IIUC, you&#39;re trying to protect against the possbility that /h=
ome/fred/.ssh<br>
&gt; &gt; is<br>
&gt; &gt; a symlink to some other privileged directory.<br>
&gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!reset) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys =3D read_authkeys=
(authkeys_path, NULL);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (authkeys =3D=3D NULL) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_file_test(ssh_path, G_FI=
LE_TEST_IS_DIR) &amp;&amp;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !mkdir_for_user(s=
sh_path, p, 0700, errp)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D -1 &amp;&amp; !mk=
dir_for_user(ssh_path, p, 0700, errp)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (fd &gt;=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Does holding open an FD on a directory prevent that directory bei=
ng<br>
&gt; &gt; altered ?=C2=A0 Even if it prevents it being deleted, surely ther=
e&#39;s still<br>
&gt; &gt; a race where the dir could be renamed, andd .ssh turned back into=
 a<br>
&gt; &gt; symlink ?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, you are right; race is possible<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Rather than do these checks and switch chown-&gt;lchown, I wonder=
 if we<br>
&gt; &gt; are better off having the agent simply change its effective UID/G=
ID<br>
&gt; &gt; while it updates the SSH key files ? That way the agent would be<=
br>
&gt; &gt; confined just like the user would be and we don&#39;t need to imp=
lement<br>
&gt; &gt; special cases, nor would we have to think about race conditions.<=
br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; So, you propose to call seteuid/setegid before any I/O operation?<br>
<br>
Yes, specifically for the SSH commands, because they&#39;re unusual in<br>
that we&#39;re doing stuff on behalf of an unprivileged user.<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000d9cf2d065694722c--

