Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B718606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSvdXQVR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzzE-0005Em-1U; Fri, 27 Nov 2026 12:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrija.panic@gmail.com>)
 id 1xWzzC-0005Eb-LG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:43:50 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrija.panic@gmail.com>)
 id 1xWzz9-0001P6-DT
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:43:50 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso6406570f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795801425; cv=none;
 d=google.com; s=arc-20260327;
 b=IKsyDmWR3zIzqjKxcOzplC16iFI1P4kBrlOnxPUlktruYvBeoAq9Af1ITA0THZgcYt
 pjCXtpIblJZpxkgSrm8qk87jTkvHVVD8HTZeKWkJaIvEDt2lRce3v/mTjP13Yj4lq3YW
 pAByJ4vTJXE+fGg+ERFAr9aUHFFeNTqjK9Hy7wSffAV5Etki/XbVAkFT2mXIXD+8qmma
 dVXTAyE9zahs+aeRxDaixl/K5bnR34iUwP4i/n8dSPWP1JM38J2wl+v3oMoSFM7PCPi2
 vLYmVvkX54iZTafhxpWdKzMkZmkcLTiI3H1/Reyr+3kknSsPhz30lizrWNvB0fnp/gNQ
 cMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vl5PD79wGqjsh96okuxSjadhefpU8YowdWJP6J0R06U=;
 fh=xHki3uV6HwwhBKBCQ6i4DoJkqefwQbmKK8wfFYgnqYY=;
 b=QzyfkJ2S41leMm0pF7Dn/YiW1XIGB747b9zzAOi6KBYZoyYOF72SPT4XgKJCgalnD7
 SF4200FcysfGHfukxQMP0rT9dEITWWYc5Ay3KQ2AZtkWCsEVasnQBJIpLh4iV/SWgFt+
 boWOB/NUomxDHiv34lrY33u+g5AFkkGLwQ/6aE3AJJtz+R4UD85FtwrmDifKai94Vtbw
 MbV9HDgRAt8AOe/291jsNViJMj16q+fANI3/t6BYbroaxMxVkwVO0iBs6romyTd4yBCA
 7APL5CJyHpcggSLWFPegUO0wCSHUhK5spGsPd5YLI7m67LR/SbibQylkVqICq0qM0csH
 bldA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795801425; x=1796406225; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vl5PD79wGqjsh96okuxSjadhefpU8YowdWJP6J0R06U=;
 b=JSvdXQVR/ir4CwFN+pg3ACAjGorVH0TQ16A/wvoQNB/eZ6N4v6UjPptnAHAaOw/vAi
 OJBBY1T+wHMH/nZm0CDwmf7slh5Mu7ap1iZukPwgz4VjSaRFBx9yTL/alUvFDBnCZiAD
 zFywBNScL96YzeqVWJ+DMuWhXVI7xiRGUTIr/oozmaLSF/Z0i1RVtPYLY8KLT0aW7/cR
 gHzdKjnWb+2Kx7fTxBhG2JYQGhtjm3SWG7rtn/0zJdhPQj2bSfqEI8azVxVUiKAVLoD3
 /d5lHgPfxCa2E1pobnMkpXehNzlnKdf13ymBdK4egA1cBKl1DGW7TFErQpEQ0a5h1fpD
 0Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795801425; x=1796406225;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vl5PD79wGqjsh96okuxSjadhefpU8YowdWJP6J0R06U=;
 b=Nz7PIBJRMasCth2LedZdwSenXv0RQID7DBGeXQTEn1BBuJrWdjr7cMjc515g5Vg9tv
 YRUiWXk4UikmnSOULTJPwAEJUfUFNBBWYSIOYh3J47H9z2HXHVMOAWcYmhNxPORX3mdP
 lrbL56cKfTdlC4fOkwlZACmcd65t5mdzu3DKPy5Taa2i8f7ZNzBPHUa71/EpWAWpFGqR
 JoMdXy77Vm468ovpXCHO3ylpXED4KUZTw5n6r/BhqbxF94zW+4Xv8hbsrd6ik2WVW0zZ
 89ImSpgIsRe/GtWLsN2NOQ3f7tFShGZrOdsoY7IEEiBmnEysw40NVv5DKsLg1J04uZI9
 SCXg==
X-Gm-Message-State: APuU4Z9/5YaKrUDQMjL1Cy+x8m0Z9itboqyxPgVkRC5L41gXSeU8BU+a
 PQfBQ3IEi44jV9qgQWzkVXrHttZ7W+BKwfHNuV16esqAZuR69xP9qSmY3ZHKe2Ksnok6OuupowK
 iQ3BRef7wSZ6tq5L5e7JN0Zx7HLMkUc0=
X-Gm-Gg: AZFdTZfGeckq745zrlLbaoqtOds8nP4+OUEILatWD1KV/Yh8SKkX7In8rwrhYvG5iAg
 i5xfJhZOGByNRFywv/mPyCUwk9Riy7CqOUSMw/Tb7/iSIg1v4PLjfY6vxgKogh8pWGTMxPNdvzv
 VDkyIcT8LXbYZHaAzVh+dA5K+TUI5h7j9Y2GEJuH8fG7lSwwZKDUlSI50Lzqp2N2yGhSmXbGOt3
 QE/q80CkhBBVFCp7pnghQuSpnNfwR1sTm4srFLulYiptQAy2y4m0CK30EJtCKOcS3MCN4irG0FH
 +SIZWzkKtSFrI6NpHmauYvyTtTNhkZmLJ4cLKE5yAcBgMgn0v7AY/jZ0w0BzKroIS8rCTWhmgLn
 OK1JIwupbvYhRV/4FVKrI8HHS7F8QAkeZ7kvjvTa9pylQvJR4nnOcBsDilfYVxz07tB+92D06gF
 4JjtKUIVwVWGb++cWPrW93/mYZZN9Qz+DTkHEgYL13bVeElrYXR7Lt5rj/ZQNnBOMwwMw5h/wHG
 TQ6F9UZ
X-Received: by 2002:a5d:5846:0:b0:4a6:4ac6:d950 with SMTP id
 ffacd0b85a97d-4abb400ae95mr51100320f8f.39.1795801425222; Fri, 27 Nov 2026
 09:43:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMvtBPPveK4wH+P9bhWtWk-i9S-xBP-nggvWppFkJ7P=++0D5g@mail.gmail.com>
 <awlLW-Gr30ZTIMEp@redhat.com>
In-Reply-To: <awlLW-Gr30ZTIMEp@redhat.com>
From: Andrija Panic <andrija.panic@gmail.com>
Date: Fri, 27 Nov 2026 18:43:28 +0100
X-Gm-Features: Aa3M54oIKY819WwgVyNTOVacnMIkeIMhsDtXpyAp2XvpdjGLKYUV9E_BZi2lDTk
Message-ID: <CAMvtBPPk8qEnJCBZPfdh0Ceys=D9gpJVpFLC+EmP4QDz0kXYJQ@mail.gmail.com>
Subject: Re: qemu-ga: safer default command policy? (re: "Improve mechanism
 for configuring allowed commands", June 2024)
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com, 
 armbru@redhat.com
Content-Type: multipart/alternative; boundary="00000000000009a0320661459a04"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=andrija.panic@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=1.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000009a0320661459a04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the quick and detailed reply, and for the background on
the series.

> On balance I feel like we shouldn't be handing over the keys on a
> platter out of the box, and that we should cut out arbitrary file
> read/write arbitrary exec, and password/ssh key injection by default.

Agreed, and I would like to help make that the upstream default
rather than leave it to each distribution. The packaging survey shows
why: where a distro made a deliberate choice (RHEL), guests are
reasonably protected; where the package follows upstream as-is
(Debian and Ubuntu, and Fedora by the oversight you mention),
everything is open. Those are also the guests that most cloud images,
templates and migration tools hand to end users who never look at
qemu-ga at all. A safe built-in default protects exactly the people
who don't know they need to configure it.

A proposal for discussion:

- Built-in default: an allow list of what management stacks
actually use (guest-ping, guest-sync*, guest-info,
guest-network-get-interfaces, guest-get-osinfo,
guest-get-host-name, guest-fsfreeze-*, guest-fstrim,
guest-shutdown, and similar read-only status commands).
Everything else, including exec, file access and the user
auth commands, off unless explicitly enabled.
- An allow list rather than a block list, so a command added in a
future release stays off until someone decides it is safe.
- Confidential VMs get your stricter profile on top of that.

Two more points that I think make the case:

- In-guest disk encryption (LUKS, BitLocker) protects data at rest
from the host, but with today's default the host can still read
the decrypted files of the running guest through guest-file-read
or guest-exec. The guest owner did everything right and the agent
undoes it. I expect that to surprise security auditors.
- It puts the responsibility in the right place. A cloud operator
cannot realistically ask every unmanaged tenant to harden an
in-guest agent; a sane default in the package can.

I am happy to test a v3 on Debian, Ubuntu and RHEL-family guests with
libvirt and Apache CloudStack, and to report which management
features keep working under each profile. If it helps, I can also
collect the list of agent commands the common management stacks
depend on.

Thanks,
Andrija

On Fri, Nov 27, 2026 10:20 AM, "Daniel P. Berrang=C3=A9" <berrange@redhat.c=
om>
wrote:

> On Fri, Nov 27, 2026 at 06:30:27AM +0100, Andrija Panic wrote:
> > Hi Daniel, Michael, Kostiantyn, all,
> >
> > I would like to revisit Daniel's series from June 2024:
> >
> >   [PATCH 00/14] Improve mechanism for configuring allowed commands
> >
> https://patchwork.kernel.org/project/qemu-devel/cover/20240604153242.2513=
34-1-berrange@redhat.com/
> >
> > As far as I can see in the archive, it stopped after the branch
> > request in July 2024, there was no v2, and current master still has
> > "allow everything" as the fallback policy in ga_command_is_allowed().
> > Is the idea still wanted? I would be glad to help with testing.
> >
> > Why I am asking now: I work on Apache CloudStack and on VMware-to-KVM
> > migration tooling. Until a few years ago qemu-ga was installed on
> > relatively few guests. That is changing quickly. Management stacks
> > now use it for IP reporting, boot readiness checks and quiesced
> > snapshots, and migration guides tell users to install it. Many guests
> > that never ran the agent are getting it now, usually from distro
> > packages, with whatever the distro default is.
> >
> > Those defaults differ a lot today (read from each packaging source):
> >
> >   - QEMU upstream: everything allowed.
> >   - Debian and Ubuntu: the unit runs plain /usr/sbin/qemu-ga and no
> >     qemu-ga.conf is shipped, so everything is allowed. Debian bug
> >     #1076139 (July 2024) asked for a change; it was marked wishlist,
> >     with the service file taken from upstream as-is.
> >   - Fedora rawhide: a block list is shipped but commented out, so
> >     everything is allowed.
>
> This is an oversight I noticed a while ago, but didn't want to
> change until my new patches were merged. IMHO it should have
> been following RHEL's policy all this time.
>
> >   - openSUSE Factory: blocks guest-exec and guest-exec-status only;
> >     guest-file-* stay enabled.
>
> Pointless, as you just use guest-file-write to the qga config file
> to re-enable guest-exec
>
> >   - RHEL 9/10 and rebuilds: an --allow-rpcs list without guest-exec*
> >     and guest-file-*. That list still includes guest-set-user-password
> >     and guest-ssh-add-authorized-keys, i.e. the "user auth" group the
> >     --no-user-auth flag was meant to cover.
> >
> > So no distribution I checked blocks password and SSH-key injection,
> > and only one blocks file access.
> >
> > I understand the usual answer: without confidential computing the
> > host can read guest RAM and disks anyway. I think that undersells two
> > things:
> >
> >   1. Cost and visibility. Reading secrets out of RAM or editing an
> >      offline disk is deliberate, specialised work. guest-exec is one
> >      JSON line, gives a root shell, and looks like routine management
> >      traffic. Least privilege still matters when the attacker is a
> >      stolen operator credential or a compromised management service
> >      rather than a determined host admin.
>
> Yes, I feel the same way. QGA makes it waaaaay to easy for a host
> admin to compromise a guest.
>
> >   2. Confidential guests. As Daniel's cover letter says, with SEV-SNP o=
r
> >      TDX the host is not trusted, and an agent with every command
> >      enabled undoes the protection. Guest images are increasingly
> >      built once and run both ways.
>
> Any confidential guest image running the QGA today needs to have
> a CVE filed against it, unless they've blocked a vast number of
> APIs manually.
>
> > Concretely:
> >
> >   - Is there interest in a v2 of the series? Was there a design
> >     objection, or did it run out of review time?
>
> This is just my fault for switching priorities, but also partly
> because I wasn't entirely happy with the design. I wanted to
> have  it "do the right thing(tm)" out of the box when running
> on a confidential VM. With my patches in v2, it required having
> two separate systemd services, one confidential and one not, or
> writing a bunch of preexec code to change what features were
> asked for.  I was thinking about revisiting recently to try for
> a v3.
>
> >   - Would the maintainers consider changing the built-in default
> >     (for example blocking the "unrestricted" and "user auth" groups
> >     unless explicitly allowed), or is that seen as a distro decision?
>
> For a confidential VM, we clearly need to strictly lock it down
> out of the box, otherwise it completely undermines confidentiality.
> This needs to "do the right thing", as there's way too high risk
> of users or distros installing QGA in a confidental guest and not
> realizing the consequences.
>
> For non-confidential VMs, it is harder to argue what the default
> behaviour is. On the one hand I think we shouldn't expose APIs to
> the host admin to directly compromise a running guest. On the
> other hand, any restrictions we put in place are somewhat like
> snake-oil, since if they try hard enough a host admin can do
> anything they like to a non-confidential guest.
>
> On balance I feel like we shouldn't be handing over the keys on a
> platter out of the box, and that we should cut out arbitrary file
> read/write arbitrary exec, and password/ssh key injection by default.
>
> >
> > I can test a v2 on Debian, Ubuntu and RHEL-family guests against
> > libvirt and Apache CloudStack, and report which management features
> > keep working with each group blocked. CloudStack, for example, only
> > needs guest-ping, guest-sync, guest-network-get-interfaces and the
> > guest-fsfreeze-* commands for its core features.
>
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

--00000000000009a0320661459a04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">Hi Daniel,<br><br>Thanks for the qu=
ick and detailed reply, and for the background on<br>the series.<br><br>&gt=
; On balance I feel like we shouldn&#39;t be handing over the keys on a<br>=
&gt; platter out of the box, and that we should cut out arbitrary file<br>&=
gt; read/write arbitrary exec, and password/ssh key injection by default.<b=
r><br>Agreed, and I would like to help make that the upstream default<br>ra=
ther than leave it to each distribution. The packaging survey shows<br>why:=
 where a distro made a deliberate choice (RHEL), guests are<br>reasonably p=
rotected; where the package follows upstream as-is<br>(Debian and Ubuntu, a=
nd Fedora by the oversight you mention),<br>everything is open. Those are a=
lso the guests that most cloud images,<br>templates and migration tools han=
d to end users who never look at<br>qemu-ga at all. A safe built-in default=
 protects exactly the people<br>who don&#39;t know they need to configure i=
t.<br><br>A proposal for discussion:<br><br>  - Built-in default: an allow =
list of what management stacks<br>    actually use (guest-ping, guest-sync*=
, guest-info,<br>    guest-network-get-interfaces, guest-get-osinfo,<br>   =
 guest-get-host-name, guest-fsfreeze-*, guest-fstrim,<br>    guest-shutdown=
, and similar read-only status commands).<br>    Everything else, including=
 exec, file access and the user<br>    auth commands, off unless explicitly=
 enabled.<br>  - An allow list rather than a block list, so a command added=
 in a<br>    future release stays off until someone decides it is safe.<br>=
  - Confidential VMs get your stricter profile on top of that.<br><br>Two m=
ore points that I think make the case:<br><br>  - In-guest disk encryption =
(LUKS, BitLocker) protects data at rest<br>    from the host, but with toda=
y&#39;s default the host can still read<br>    the decrypted files of the r=
unning guest through guest-file-read<br>    or guest-exec. The guest owner =
did everything right and the agent<br>    undoes it. I expect that to surpr=
ise security auditors.<br>  - It puts the responsibility in the right place=
. A cloud operator<br>    cannot realistically ask every unmanaged tenant t=
o harden an<br>    in-guest agent; a sane default in the package can.<br><b=
r>I am happy to test a v3 on Debian, Ubuntu and RHEL-family guests with<br>=
libvirt and Apache CloudStack, and to report which management<br>features k=
eep working under each profile. If it helps, I can also<br>collect the list=
 of agent commands the common management stacks<br>depend on.<br><br>Thanks=
,<br>Andrija</div></div></div><br><div class=3D"gmail_extra"><div>On Fri, N=
ov 27, 2026 10:20 AM, &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"ma=
ilto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Nov 27, 20=
26 at 06:30:27AM +0100, Andrija Panic wrote:<br>
&gt; Hi Daniel, Michael, Kostiantyn, all,<br>
&gt; <br>
&gt; I would like to revisit Daniel&#39;s series from June 2024:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0[PATCH 00/14] Improve mechanism for configuring allowed co=
mmands<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://patchwork.kernel.org/project/qemu-devel=
/cover/20240604153242.251334-1-berrange@redhat.com/" rel=3D"noreferrer" tar=
get=3D"_blank">https://patchwork.kernel.org/project/qemu-devel/cover/202406=
04153242.251334-1-berrange@redhat.com/</a><br>
&gt; <br>
&gt; As far as I can see in the archive, it stopped after the branch<br>
&gt; request in July 2024, there was no v2, and current master still has<br=
>
&gt; &quot;allow everything&quot; as the fallback policy in ga_command_is_a=
llowed().<br>
&gt; Is the idea still wanted? I would be glad to help with testing.<br>
&gt; <br>
&gt; Why I am asking now: I work on Apache CloudStack and on VMware-to-KVM<=
br>
&gt; migration tooling. Until a few years ago qemu-ga was installed on<br>
&gt; relatively few guests. That is changing quickly. Management stacks<br>
&gt; now use it for IP reporting, boot readiness checks and quiesced<br>
&gt; snapshots, and migration guides tell users to install it. Many guests<=
br>
&gt; that never ran the agent are getting it now, usually from distro<br>
&gt; packages, with whatever the distro default is.<br>
&gt; <br>
&gt; Those defaults differ a lot today (read from each packaging source):<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0- QEMU upstream: everything allowed.<br>
&gt;=C2=A0 =C2=A0- Debian and Ubuntu: the unit runs plain /usr/sbin/qemu-ga=
 and no<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-ga.conf is shipped, so everything is allowed. =
Debian bug<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1076139 (July 2024) asked for a change; it was mar=
ked wishlist,<br>
&gt;=C2=A0 =C2=A0 =C2=A0with the service file taken from upstream as-is.<br=
>
&gt;=C2=A0 =C2=A0- Fedora rawhide: a block list is shipped but commented ou=
t, so<br>
&gt;=C2=A0 =C2=A0 =C2=A0everything is allowed.<br>
<br>
This is an oversight I noticed a while ago, but didn&#39;t want to<br>
change until my new patches were merged. IMHO it should have<br>
been following RHEL&#39;s policy all this time.<br>
<br>
&gt;=C2=A0 =C2=A0- openSUSE Factory: blocks guest-exec and guest-exec-statu=
s only;<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest-file-* stay enabled.<br>
<br>
Pointless, as you just use guest-file-write to the qga config file<br>
to re-enable guest-exec<br>
<br>
&gt;=C2=A0 =C2=A0- RHEL 9/10 and rebuilds: an --allow-rpcs list without gue=
st-exec*<br>
&gt;=C2=A0 =C2=A0 =C2=A0and guest-file-*. That list still includes guest-se=
t-user-password<br>
&gt;=C2=A0 =C2=A0 =C2=A0and guest-ssh-add-authorized-keys, i.e. the &quot;u=
ser auth&quot; group the<br>
&gt;=C2=A0 =C2=A0 =C2=A0--no-user-auth flag was meant to cover.<br>
&gt; <br>
&gt; So no distribution I checked blocks password and SSH-key injection,<br=
>
&gt; and only one blocks file access.<br>
&gt; <br>
&gt; I understand the usual answer: without confidential computing the<br>
&gt; host can read guest RAM and disks anyway. I think that undersells two<=
br>
&gt; things:<br>
&gt; <br>
&gt;=C2=A0 =C2=A01. Cost and visibility. Reading secrets out of RAM or edit=
ing an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 offline disk is deliberate, specialised work. gues=
t-exec is one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 JSON line, gives a root shell, and looks like rout=
ine management<br>
&gt;=C2=A0 =C2=A0 =C2=A0 traffic. Least privilege still matters when the at=
tacker is a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 stolen operator credential or a compromised manage=
ment service<br>
&gt;=C2=A0 =C2=A0 =C2=A0 rather than a determined host admin.<br>
<br>
Yes, I feel the same way. QGA makes it waaaaay to easy for a host<br>
admin to compromise a guest.<br>
<br>
&gt;=C2=A0 =C2=A02. Confidential guests. As Daniel&#39;s cover letter says,=
 with SEV-SNP or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TDX the host is not trusted, and an agent with eve=
ry command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 enabled undoes the protection. Guest images are in=
creasingly<br>
&gt;=C2=A0 =C2=A0 =C2=A0 built once and run both ways.<br>
<br>
Any confidential guest image running the QGA today needs to have<br>
a CVE filed against it, unless they&#39;ve blocked a vast number of<br>
APIs manually.<br>
<br>
&gt; Concretely:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- Is there interest in a v2 of the series? Was there a des=
ign<br>
&gt;=C2=A0 =C2=A0 =C2=A0objection, or did it run out of review time?<br>
<br>
This is just my fault for switching priorities, but also partly<br>
because I wasn&#39;t entirely happy with the design. I wanted to<br>
have=C2=A0 it &quot;do the right thing(tm)&quot; out of the box when runnin=
g<br>
on a confidential VM. With my patches in v2, it required having<br>
two separate systemd services, one confidential and one not, or<br>
writing a bunch of preexec code to change what features were<br>
asked for.=C2=A0 I was thinking about revisiting recently to try for<br>
a v3.<br>
<br>
&gt;=C2=A0 =C2=A0- Would the maintainers consider changing the built-in def=
ault<br>
&gt;=C2=A0 =C2=A0 =C2=A0(for example blocking the &quot;unrestricted&quot; =
and &quot;user auth&quot; groups<br>
&gt;=C2=A0 =C2=A0 =C2=A0unless explicitly allowed), or is that seen as a di=
stro decision?<br>
<br>
For a confidential VM, we clearly need to strictly lock it down<br>
out of the box, otherwise it completely undermines confidentiality.<br>
This needs to &quot;do the right thing&quot;, as there&#39;s way too high r=
isk<br>
of users or distros installing QGA in a confidental guest and not<br>
realizing the consequences.<br>
<br>
For non-confidential VMs, it is harder to argue what the default<br>
behaviour is. On the one hand I think we shouldn&#39;t expose APIs to<br>
the host admin to directly compromise a running guest. On the<br>
other hand, any restrictions we put in place are somewhat like<br>
snake-oil, since if they try hard enough a host admin can do<br>
anything they like to a non-confidential guest.<br>
<br>
On balance I feel like we shouldn&#39;t be handing over the keys on a<br>
platter out of the box, and that we should cut out arbitrary file<br>
read/write arbitrary exec, and password/ssh key injection by default.<br>
<br>
&gt; <br>
&gt; I can test a v2 on Debian, Ubuntu and RHEL-family guests against<br>
&gt; libvirt and Apache CloudStack, and report which management features<br=
>
&gt; keep working with each group blocked. CloudStack, for example, only<br=
>
&gt; needs guest-ping, guest-sync, guest-network-get-interfaces and the<br>
&gt; guest-fsfreeze-* commands for its core features.<br>
<br>
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
</blockquote></div></div>

--00000000000009a0320661459a04--

