Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF23606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxbe.com header.i=@linuxbe.com header.a=rsa-sha256 header.s=default header.b=AavUtsiP;
	dkim=pass (1024-bit key) header.d=linuxbe.com header.i=@linuxbe.com header.a=rsa-sha256 header.s=default header.b=AavUtsiP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJyOU-0001vM-IG; Thu, 22 Oct 2026 15:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jnuyens@linuxbe.com>)
 id 1xJudd-000152-PD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:23:29 -0400
Received: from www.linuxbe.com ([88.99.136.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jnuyens@linuxbe.com>)
 id 1xJudb-0007xK-Ll
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:23:29 -0400
ARC-Filter: OpenARC Filter v1.3.0 www.linuxbe.com D98C4803CF6
Authentication-Results: www.linuxbe.com;
 arc=pass header.oldest-pass=0 smtp.remote-ip=127.0.0.1
ARC-Seal: i=2; d=linuxbe.com; s=default; a=rsa-sha256; cv=pass; t=1792682603; 
 b=k9LwSWFMYDrlckI59h26oLvfyxMbKDwZBbJpdcl7OLgj7DT2wlYJf9VChEZ+Qr6ZVfK6
 VTythmln0p9Y5dMoVsDVnC46RyIc2vbs0t6KzwWEfYPYDEjyy8qgD4ueJjO0XnSdeZmub
 LopxIuK2bPfG9D2uK0A1oAfri99OW0wRvQ=
ARC-Message-Signature: i=2; d=linuxbe.com; s=default; a=rsa-sha256;
 c=relaxed/simple; t=1792682603;
 h=DKIM-Signature:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 ARC-Filter:DKIM-Signature:Received:Received:X-Gm-Message-State:
 X-Received:Received:Received:MIME-Version:From:Date:
 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=k6JhvxZj3baoSxx9eCuoGvc1nwGdEuHDl/dDQuCgP88=;
 b=aLHReuaQgaeIx5xzY/8dNmz1R99z76ZD4SZh4HeSKQpu44BPiWxlPEyh13GL63l7rhLC
 W/NRdtNRGKDSgQCF+GdJIXS9BliSzsq94HcNzl0QXXwowZ7zDpdkr2C384aJsNjr6vFzt
 zAMiRl0HM04ms/1f5kCcejyl8tZe941BnE=
ARC-Authentication-Results: i=2; www.linuxbe.com; arc=pass header.oldest-pass=0
 smtp.remote-ip=127.0.0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxbe.com;
 s=default; t=1792682603;
 bh=k6JhvxZj3baoSxx9eCuoGvc1nwGdEuHDl/dDQuCgP88=;
 h=From:Date:Subject:To:Cc:From;
 b=AavUtsiPI/IVMg/P16QQA4i7z3s3OZ0DIz6Elkawi58KSbYpoA/uhUb+Pj5p3XVCe
 pQN/boSQ8ANx1JEOysJ4pi4pemIkjg6caLTelpMOSZ+5Yy1JNTUiC6mzN9GCW81lxn
 Hv7qYQ2m4E3ch7RTmdKZkkOCoctqMDAC+J4Yphi0=
Received: by www.linuxbe.com (Postfix, from userid 114)
 id D98C4803CF6; Thu, 22 Oct 2026 17:23:23 +0200 (CEST)
ARC-Filter: OpenARC Filter v1.3.0 www.linuxbe.com A8131803CE2
Authentication-Results: www.linuxbe.com; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=linuxbe.com; s=default; a=rsa-sha256; cv=none; t=1792682603; 
 b=z245uzBtAG1XkAWQP2MTEdA8r8m6jD9iCgSftBc+O7WgKCOduodYKt7OC0abvlHgaSk7
 S/SEDEEUq9AOIFxRlxUsE2Tnli525PYGkiv4j68w9fgOpWFqFGP7gLDJrBoT0hGwacE0G
 8gJV+zuZ5qIk+3kdQu2Es7BQHRvn7OgkJY=
ARC-Message-Signature: i=1; d=linuxbe.com; s=default; a=rsa-sha256;
 c=relaxed/simple; t=1792682603;
 h=DKIM-Signature:Received:X-Gm-Message-State:X-Received:Received:
 Received:MIME-Version:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=k6JhvxZj3baoSxx9eCuoGvc1nwGdEuHDl/dDQuCgP88=;
 b=dpWvzP6H7vU3M2kr2JSsWtEUHp/1i7kAYBxqTydXhJMN3T85F2dc4tI1IOeTsVOCbqxE
 BxZLqoqy+BK7CYULQoHRM58EHGSIwD78GYUup9SkXPIU18mzr7zSZWLDkseXyFa1QteB9
 H/flVce1zN795HOumK7qp7HaTPxyKqP8JE=
ARC-Authentication-Results: i=1; www.linuxbe.com;
 arc=none smtp.remote-ip=209.85.161.41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxbe.com;
 s=default; t=1792682603;
 bh=k6JhvxZj3baoSxx9eCuoGvc1nwGdEuHDl/dDQuCgP88=;
 h=From:Date:Subject:To:Cc:From;
 b=AavUtsiPI/IVMg/P16QQA4i7z3s3OZ0DIz6Elkawi58KSbYpoA/uhUb+Pj5p3XVCe
 pQN/boSQ8ANx1JEOysJ4pi4pemIkjg6caLTelpMOSZ+5Yy1JNTUiC6mzN9GCW81lxn
 Hv7qYQ2m4E3ch7RTmdKZkkOCoctqMDAC+J4Yphi0=
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by www.linuxbe.com (Postfix) with ESMTPSA id A8131803CE2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:23:23 +0200 (CEST)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6d290b10a35so885991eaf.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 08:23:23 -0700 (PDT)
X-Gm-Message-State: AFq9FYKbrYVankJVmSaW3iuLHmVXAr7jyqBIHvHQU56hZgGhLmeuoORc
 T+yHRDg+nSMRBQOYj9YHdHZzAz/wY/teiKj38xGLa8BHk8joIRbDlhzNi6BUHg6PFBAWmOSCVaq
 SkRUWibTi9etqQZKcOJ1uyH48SiMo39M=
X-Received: by 2002:a4a:edc4:0:b0:6f9:91c9:4e5e with SMTP id
 006d021491bc7-709419437acmr3247039eaf.47.1792682602209; Thu, 22 Oct 2026
 08:23:22 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 08:23:21 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 08:23:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Jasper Nuyens <jnuyens@linuxbe.com>
Date: Thu, 22 Oct 2026 08:23:21 -0700
X-Gmail-Original-Message-ID: <CADayN0kGbiDEZG7f-fW19+AWJQXUQS8wU8LxbXx3Arc=1oP9fQ@mail.gmail.com>
X-Gm-Features: AclHuK_u3J2jhDq3qprMqd3Ca_MoiPOaruCoQm02ImfoIGr-RFi6gQKN3l81PF0
Message-ID: <CADayN0kGbiDEZG7f-fW19+AWJQXUQS8wU8LxbXx3Arc=1oP9fQ@mail.gmail.com>
Subject: Looking for a speaker on where QEMU is heading (Belgium Proxmox
 Community Day, 3 February 2027, Ghent)
To: qemu-devel@nongnu.org
Cc: team@pveday.be
Content-Type: multipart/alternative; boundary="000000000000b3295b065e6f7175"
Received-SPF: pass client-ip=88.99.136.145; envelope-from=jnuyens@linuxbe.com;
 helo=www.linuxbe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Oct 2026 15:24:01 -0400
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b3295b065e6f7175
Content-Type: text/plain; charset="UTF-8"

Hello,

On Wednesday 3 February 2027 we run the first Belgium Proxmox Community
Day in Ghent, during Config Management Camp and in the week right after
FOSDEM. It is a free one day community event about Proxmox VE and the
stack it is built on: KVM, QEMU, Ceph, LXC.

QEMU is the engine under every Proxmox VM, so we would very much like a
talk from someone in the QEMU community about where the project is
heading and what users can expect: what landed recently, what is being
worked on now, and which directions you see for the next years. An
honest "this is what we are struggling with" is just as welcome as a
roadmap.

The practical part:

- Wednesday 3 February 2027, 10:00 to 18:00
- HOGENT Campus Schoonmeersen, Valentin Vaerwyckweg 1, 9000 Ghent
- Talks are 40 minutes, everything in English
- Free entrance. The audience is mostly sysadmins, integrators and
hosters who run Proxmox in production, plus students
- Cole Hughes of Proxmox Server Solutions GmbH gives the keynote,
"Proxmox, What's New?"
- Many people are in Ghent that week anyway for Config Management Camp,
and Brussels is 30 minutes away by train

If this is something you or a colleague would like to do, submit it at
https://www.google.com/url?q=https://cfp.pveday.be/bpcd2027/cfp&source=gmail&ust=1792769001418000&sa=E
before 1 December, or simply reply to
me and we sort out the details.

More about the day:
https://www.google.com/url?q=https://pveday.be&source=gmail&ust=1792769001418000&sa=E

Greetings,
Jasper
--
Jasper Nuyens
Managing Director, Linux Belgium
https://www.google.com/url?q=http://www.linuxbe.com&source=gmail&ust=1792769001418000&sa=E
Phone: +32 (0)2 747 47 01
Mobile: +32 (0)478 978967

--000000000000b3295b065e6f7175
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hello,<br><br>On Wednesday 3 February 2027 we=
 run the first Belgium Proxmox Community<br>Day in Ghent, during Config Man=
agement Camp and in the week right after<br>FOSDEM. It is a free one day co=
mmunity event about Proxmox VE and the<br>stack it is built on: KVM, QEMU, =
Ceph, LXC.<br><br>QEMU is the engine under every Proxmox VM, so we would ve=
ry much like a<br>talk from someone in the QEMU community about where the p=
roject is<br>heading and what users can expect: what landed recently, what =
is being<br>worked on now, and which directions you see for the next years.=
 An<br>honest &quot;this is what we are struggling with&quot; is just as we=
lcome as a<br>roadmap.<br><br>The practical part:<br><br>- Wednesday 3 Febr=
uary 2027, 10:00 to 18:00<br>- HOGENT Campus Schoonmeersen, Valentin Vaerwy=
ckweg 1, 9000 Ghent<br>- Talks are 40 minutes, everything in English<br>- F=
ree entrance. The audience is mostly sysadmins, integrators and<br>  hoster=
s who run Proxmox in production, plus students<br>- Cole Hughes of Proxmox =
Server Solutions GmbH gives the keynote,<br>  &quot;Proxmox, What&#39;s New=
?&quot;<br>- Many people are in Ghent that week anyway for Config Managemen=
t Camp,<br>  and Brussels is 30 minutes away by train<br><br>If this is som=
ething you or a colleague would like to do, submit it at<br><a href=3D"http=
s://www.google.com/url?q=3Dhttps://cfp.pveday.be/bpcd2027/cfp&amp;source=3D=
gmail&amp;ust=3D1792769001418000&amp;sa=3DE">https://www.google.com/url?q=
=3Dhttps://cfp.pveday.be/bpcd2027/cfp&amp;source=3Dgmail&amp;ust=3D17927690=
01418000&amp;sa=3DE</a> before 1 December, or simply reply to<br>me and we =
sort out the details.<br><br>More about the day: <a href=3D"https://www.goo=
gle.com/url?q=3Dhttps://pveday.be&amp;source=3Dgmail&amp;ust=3D179276900141=
8000&amp;sa=3DE">https://www.google.com/url?q=3Dhttps://pveday.be&amp;sourc=
e=3Dgmail&amp;ust=3D1792769001418000&amp;sa=3DE</a><br><br>Greetings,<br>Ja=
sper<br>--<br>Jasper Nuyens<br>Managing Director, Linux Belgium<br><a href=
=3D"https://www.google.com/url?q=3Dhttp://www.linuxbe.com&amp;source=3Dgmai=
l&amp;ust=3D1792769001418000&amp;sa=3DE">https://www.google.com/url?q=3Dhtt=
p://www.linuxbe.com&amp;source=3Dgmail&amp;ust=3D1792769001418000&amp;sa=3D=
E</a><br>Phone: +32 (0)2 747 47 01<br>Mobile: +32 (0)478 978967<br></div></=
body></html>

--000000000000b3295b065e6f7175--

