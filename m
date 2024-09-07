Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B4AECE571
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 20:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn2Vx-0001OY-AZ; Sat, 07 Sep 2024 16:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1sn2Vv-0001Nz-A5
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 16:58:35 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1sn2Vt-0002Q1-Ll
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 16:58:35 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so6505771fa.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725742711; x=1726347511; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y+UTyXXj23nK0PmjGyVZrOxFQL60Dretw3oaG+pf2jg=;
 b=i41QSbZcX6MO+WvLTAsAm/9tFRzghjHz3jYX9jv1t9NVYmo8YswvB0RcqNWQzLc5/8
 9SbVHcyg9hs62jQhIFLvzwsnq60E9/hqV0Kdy8qXe3uzeIL49HAbMbd6QBbqHRAOXg70
 FUu0cGe+XVs3DArK23m3w0f5EqeOz+QSURtEIBi20YXiTqPXkldutdnulKII11b4z5WQ
 xkId22JHqRokZ4SORN1jE4mVYyaXyDq38kcTKJYDHLOnfS9pLqBwX179Robu4g1PJw9a
 cP8d6vjdG8DRlvU2VSbVTl7fpwTv93dlKVijmtFSCwZjQ9vS4nl2UTVVqJOvzI00WFBn
 tKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725742711; x=1726347511;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+UTyXXj23nK0PmjGyVZrOxFQL60Dretw3oaG+pf2jg=;
 b=mtdvMgfxdT9yNqqbIbwsEbCgYAiNGC24Tsny9QXsWemmJm1nMz8OwXwJBHSvzlEjSe
 8FLabkGHvROuYuoPMxnO48l/0H30MWUximfs19RCnSKNL8aYlOMHJZx6Wh2BFLsfn5Jl
 S2NZAfGtCCA0TqPyTx7khefhB7ejDTzNavr+/t1Y569WrWY+nz7yWJ7hZ1R+/hk5wVTR
 6NBlqHDXyJ5Hwtv+IGOzzEC2KrJYNZTz1ASNMOGCxENqUVkO6wuShjHvdWF08znDQXzd
 +bs0o8VWb6AVKX6EUI916SZICV9ExeHiEpNchZo3Zj2y2G61hdu7LcE5dIKf2eDGn31V
 dRAg==
X-Gm-Message-State: AOJu0Yxc+eS1dZQyyb1IjFjWrTeTE0Hdhd+NH3NadBbWmZcxherYxzha
 u+YwAdQ0Cx7FtTrHdIxrK1+Fd7C4gaGLbxyiyYkWKE4SPVmISmGJyjvhlnhzCNDQP8dJXBScUt1
 CmxKiojf0CXbopFejprboo9F9Q7rP0bhF
X-Google-Smtp-Source: AGHT+IHDb7GhckfEgx/l7cSlPvoktdhCWRt1PR+swaY+9z1JY/gjH7HJE5ZhDNBqCor+cqPyOpAlN9mGubS7ZWMjThs=
X-Received: by 2002:a2e:f12:0:b0:2f6:2855:5c8c with SMTP id
 38308e7fff4ca-2f75a9884demr20952091fa.20.1725742711300; Sat, 07 Sep 2024
 13:58:31 -0700 (PDT)
MIME-Version: 1.0
From: Kenneth Adam Miller <kennethadammiller@gmail.com>
Date: Sat, 7 Sep 2024 14:58:20 -0600
Message-ID: <CAK7rcp_qUmp7k6dqo62KqNpAuNgVznWiCxgBrhf4V7PT5=YDhQ@mail.gmail.com>
Subject: How to run qemu
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000047e7f406218dc934"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=kennethadammiller@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000047e7f406218dc934
Content-Type: text/plain; charset="UTF-8"

Hello,

I've got qemu built and now I need to figure out how to run it with what
I've got. I have a vmlinux and a bzImage that I want to serve as the kernel
that QEMU runs with, and a single binary, let's just call it
literally `program`, that I want to issue a command to run once QEMU boots
with the kernel.

I tried to figure out how to run the QEMU on my own, and made it as far as
this:

./qemu//bin/debug/native/qemu-system-x86_64 -enable-kvm -m 2048 -display
vnc=:89 \
        -netdev user,id=t0, -device rtl8139,netdev=t0,id=nic0 \
        -netdev user,id=t1, -device pcnet,netdev=t1,id=nic1 \
        -L ./qemu/pc-bios \
        -boot c -kernel $HOME/workspace/kvmctf-6.1.74/bzImage/bzImage

It runs, but there isn't any output to the screen to show it booting, and
QEMU runs the processor hard indefinitely. I need to be able to see
standard output and to be able to type into the console to enter the
command, and I don't know how to get it to or why it isn't showing that
already. Also, once that is working, I need a way to put `program` into the
QEMU session so that it can be run. Can someone help me? I think I need to
make an img file that can boot but I don't really know how to do that
either.

--00000000000047e7f406218dc934
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br></div><div>I&#39;ve got qemu built an=
d now I need to figure out how to run it with what I&#39;ve got. I have a v=
mlinux and a bzImage that I want to serve as the kernel that QEMU runs with=
, and a single binary, let&#39;s just call it literally=C2=A0`program`, tha=
t I want to issue a command to run once QEMU boots with the kernel.</div><d=
iv><br></div><div>I tried to figure out how to run the QEMU on my own, and =
made it as far as this:</div><div><br></div><div>./qemu//bin/debug/native/q=
emu-system-x86_64 -enable-kvm -m 2048 -display vnc=3D:89 \<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 -netdev user,id=3Dt0, -device rtl8139,netdev=3Dt0,id=3Dnic0 =
\<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -netdev user,id=3Dt1, -device pcnet,netdev=
=3Dt1,id=3Dnic1 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -L ./qemu/pc-bios \<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 -boot c -kernel $HOME/workspace/kvmctf-6.1.74/bzIm=
age/bzImage<br></div><div><br></div><div>It runs, but there isn&#39;t any o=
utput to the screen to show it booting, and QEMU runs the processor hard in=
definitely. I need to be able to see standard output and to be able to type=
 into the console to enter the command, and I don&#39;t know how to get it =
to or why it isn&#39;t showing that already. Also, once that is working, I =
need a way to put `program` into the QEMU session so that it can be run. Ca=
n someone help me? I think I need to make an img=C2=A0file that can boot bu=
t I don&#39;t really know how to do that either.</div></div>

--00000000000047e7f406218dc934--

