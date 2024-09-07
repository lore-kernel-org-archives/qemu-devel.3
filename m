Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D169FECE56F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 21:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn2rA-0000Yr-Ng; Sat, 07 Sep 2024 17:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1sn2r5-0000YF-RS
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 17:20:27 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1sn2r3-0004bt-V9
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 17:20:27 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f762de00fbso948851fa.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725744024; x=1726348824; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=egdYHOrY8zJOY4e8DhyBJJ0bzy8tKCfbBnhryO95qpg=;
 b=npfrpf5IbL8NB8Q4djzSD9bJOqWaerUezMt9nAbITyh+5bSRTZ5mdORvbRhGKHX0Xy
 drIHxyR1PCA7Bbeh2p6tLfRB0nECbLkQZDv6pjog74elRm/jy7gFcP4COlK7W0M7lLdw
 hxeE+Gwe2Q6m5DTgbNZOPaogP8m6FicWmE6qnO8mqG3oOI74tSPEQNus0fTX5BoSuNOV
 UQSnanrrDK2YUSECe3+qEQ/zwGMAy7O/ReHMFRZs4nerpA7BKfVB8mV15RF+KzjHflG7
 w4AURy6+MtkjMDQA7VRwxov4GC8QkkxkcxbF0od8f9awjKck8PSpe7UcktL0VQrpNbeo
 BIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725744024; x=1726348824;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=egdYHOrY8zJOY4e8DhyBJJ0bzy8tKCfbBnhryO95qpg=;
 b=NyOsW3G4mN4Ptd3ehCN6cjTHwXTsMzWFq26zes9yNSJsqzsX1bVKct8kSWFJbmOpf2
 xKw511NimtO+Fxxbhoh2Pp5frTDSHRr7wRWN79UEeF/Bor4lKPEZI0h4htuggjFKlRxv
 vcLVzYLhKG2n11EgSFCKXKyXfw1M/UpO/gLZ6LxUPFM1k8b0cEEAEjj4385xJBwvHJn1
 qzI5NJ7Ocbjwr39rWnsXb/koIBqC1MGZf9B07qTewBcqRaA+RBvSdvXFIA9ptg7eY0Zd
 X4fXUk+Gsc9eHKhksPFGFogQEHJ34ep0op4Mvmr2vfL2W8nVNIJkp2wI2425HFyohxtP
 0y9w==
X-Gm-Message-State: AOJu0YxA1s5/zUEOwvR33ULGkLSUPFwkDcq8szmfsc+vmQLh18WEjBVN
 E2FWo3CpDe2R2yDRNXfFF2uX/0I4+JGLZZh41eYge0ZvkaiNcWGEWuGIPunGJR3mP9NdcHgRS/T
 Mo3nFnvlcCsMR5FN1ILaauzmnRTtW0W14
X-Google-Smtp-Source: AGHT+IGdTpFy3R4DfXG5oRXcXQsq5KaRT0Sp3YxFMBLyDkWioSR6MANU/XKfCP0UsdI9KY+bXcDcZF67AcmIC2Arrfc=
X-Received: by 2002:a2e:6119:0:b0:2f7:4e8c:9c11 with SMTP id
 38308e7fff4ca-2f751ea793emr45267051fa.1.1725744023322; Sat, 07 Sep 2024
 14:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7rcp_qUmp7k6dqo62KqNpAuNgVznWiCxgBrhf4V7PT5=YDhQ@mail.gmail.com>
In-Reply-To: <CAK7rcp_qUmp7k6dqo62KqNpAuNgVznWiCxgBrhf4V7PT5=YDhQ@mail.gmail.com>
From: Kenneth Adam Miller <kennethadammiller@gmail.com>
Date: Sat, 7 Sep 2024 15:20:12 -0600
Message-ID: <CAK7rcp-jQAx3Qr_OntcTeNhfM_nzyoOiLDvSpPj=__FfxhSrcw@mail.gmail.com>
Subject: Re: How to run qemu
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007bc84806218e1797"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=kennethadammiller@gmail.com; helo=mail-lj1-x236.google.com
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

--0000000000007bc84806218e1797
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I found this:
https://qemu-project.gitlab.io/qemu/system/linuxboot.html
and this:
https://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-ke=
rnel-in-qemu-and-debugging-it-with-gdb/

So I now have serial output. But I still need to know how to put a binary
in the image so I can run it.

I made it a few steps further:

./qemu//bin/debug/native/qemu-system-x86_64 -enable-kvm -m 2048 -display
vnc=3D:89 \
        -netdev user,id=3Dt0, -device rtl8139,netdev=3Dt0,id=3Dnic0 \
        -netdev user,id=3Dt1, -device pcnet,netdev=3Dt1,id=3Dnic1 \
        -L ./qemu/pc-bios \
        -nographic \
        -append "console=3DttyS0 nokaslr" \
        -initrd ramdisk.img \
        -boot c -kernel $HOME/workspace/kvmctf-6.1.74/bzImage/bzImage

On Sat, Sep 7, 2024 at 2:58=E2=80=AFPM Kenneth Adam Miller <
kennethadammiller@gmail.com> wrote:

> Hello,
>
> I've got qemu built and now I need to figure out how to run it with what
> I've got. I have a vmlinux and a bzImage that I want to serve as the kern=
el
> that QEMU runs with, and a single binary, let's just call it
> literally `program`, that I want to issue a command to run once QEMU boot=
s
> with the kernel.
>
> I tried to figure out how to run the QEMU on my own, and made it as far a=
s
> this:
>
> ./qemu//bin/debug/native/qemu-system-x86_64 -enable-kvm -m 2048 -display
> vnc=3D:89 \
>         -netdev user,id=3Dt0, -device rtl8139,netdev=3Dt0,id=3Dnic0 \
>         -netdev user,id=3Dt1, -device pcnet,netdev=3Dt1,id=3Dnic1 \
>         -L ./qemu/pc-bios \
>         -boot c -kernel $HOME/workspace/kvmctf-6.1.74/bzImage/bzImage
>
> It runs, but there isn't any output to the screen to show it booting, and
> QEMU runs the processor hard indefinitely. I need to be able to see
> standard output and to be able to type into the console to enter the
> command, and I don't know how to get it to or why it isn't showing that
> already. Also, once that is working, I need a way to put `program` into t=
he
> QEMU session so that it can be run. Can someone help me? I think I need t=
o
> make an img file that can boot but I don't really know how to do that
> either.
>

--0000000000007bc84806218e1797
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I found this:<div><a href=3D"https://qemu-project.gitlab.i=
o/qemu/system/linuxboot.html">https://qemu-project.gitlab.io/qemu/system/li=
nuxboot.html</a><br></div><div>and this:</div><div><a href=3D"https://nickd=
esaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-=
and-debugging-it-with-gdb/">https://nickdesaulniers.github.io/blog/2018/10/=
24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/</a><br>=
</div><div><br></div><div>So I now have serial output. But I still need to =
know how to put a binary in the image so I can run it.</div><div><br></div>=
<div>I made it a few steps further:</div><div><br></div><div>./qemu//bin/de=
bug/native/qemu-system-x86_64 -enable-kvm -m 2048 -display vnc=3D:89 \<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -netdev user,id=3Dt0, -device rtl8139,netdev=3D=
t0,id=3Dnic0 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -netdev user,id=3Dt1, -device=
 pcnet,netdev=3Dt1,id=3Dnic1 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -L ./qemu/pc-=
bios \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -nographic \<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 -append &quot;console=3DttyS0 nokaslr&quot; \<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 -initrd ramdisk.img \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -boot c -ke=
rnel $HOME/workspace/kvmctf-6.1.74/bzImage/bzImage<br></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 7, =
2024 at 2:58=E2=80=AFPM Kenneth Adam Miller &lt;<a href=3D"mailto:kennethad=
ammiller@gmail.com">kennethadammiller@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hello,=C2=
=A0<div><br></div><div>I&#39;ve got qemu built and now I need to figure out=
 how to run it with what I&#39;ve got. I have a vmlinux and a bzImage that =
I want to serve as the kernel that QEMU runs with, and a single binary, let=
&#39;s just call it literally=C2=A0`program`, that I want to issue a comman=
d to run once QEMU boots with the kernel.</div><div><br></div><div>I tried =
to figure out how to run the QEMU on my own, and made it as far as this:</d=
iv><div><br></div><div>./qemu//bin/debug/native/qemu-system-x86_64 -enable-=
kvm -m 2048 -display vnc=3D:89 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 -netdev use=
r,id=3Dt0, -device rtl8139,netdev=3Dt0,id=3Dnic0 \<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 -netdev user,id=3Dt1, -device pcnet,netdev=3Dt1,id=3Dnic1 \<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 -L ./qemu/pc-bios \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 -boot c -kernel $HOME/workspace/kvmctf-6.1.74/bzImage/bzImage<br></div><di=
v><br></div><div>It runs, but there isn&#39;t any output to the screen to s=
how it booting, and QEMU runs the processor hard indefinitely. I need to be=
 able to see standard output and to be able to type into the console to ent=
er the command, and I don&#39;t know how to get it to or why it isn&#39;t s=
howing that already. Also, once that is working, I need a way to put `progr=
am` into the QEMU session so that it can be run. Can someone help me? I thi=
nk I need to make an img=C2=A0file that can boot but I don&#39;t really kno=
w how to do that either.</div></div>
</blockquote></div>

--0000000000007bc84806218e1797--

