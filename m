Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E458C3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 21:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVeXp-0007Sa-2a; Sun, 21 Jul 2024 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sVeXe-0007QU-9i
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 17:56:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sVeXc-0006Ty-2O
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 17:56:30 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so2061831a91.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721598985; x=1722203785;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EyChh+Cw9Tbwaah/pdMVM3ZKRU6DYtfmN0YnKAUHyFc=;
 b=u38WlI3iRaGHPHWOa246QqTHCQkeUZrqmj1BEVPeeNNjlM9Ys1jSXj9F0ShoVRYYYc
 2MGaccBDFX/9XF3yk0etHCjKrVcbscdj74f2U+xEHZ/gyxuY0uAY2hmXvzZwOCutvOpF
 MiCS8j01Qj6SLKbbviU6o/6Rx+n7PuECDhrUIca+chcNT0D0RWZBOfuATMNSdGEg9Bnd
 KESC237q/eSmAieY1M44DQZuGWnx6RlLS2d1YwJ6UTGqVYDa/p1m4Mu42MPW/6hBsZQe
 TInnoLFG4yC5Bz87UjmSMsEDMcaJCK9bTt7cNum3jziphYnHi3/bycqyB7gWdPX84ry1
 f9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721598985; x=1722203785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyChh+Cw9Tbwaah/pdMVM3ZKRU6DYtfmN0YnKAUHyFc=;
 b=FgpR5sLHb7L1w/15l3Dy653FaaH4k7AcmWussBYy6p0sZ2CDRExadiHnV3G7tNcrcE
 m0ADnWuK1JOSH/iHXRDPnt9fy4DLOAusE/yRijOKEX3k1nYimbfh0IXko3rMlkPx/9Eg
 zs5UNLWiCv+KU0ULWdqEIAVm5PokBetFfGLrhuhPN8kPIDBL1aQ+6V6GZsNaGAtn8guE
 GR+dMwp3pvKS10ubP8LRDBgvkTdtyVxBukzLLZVSxcLU50QF+ichoaa07PjBI7DJTYxv
 21e2dOn2k+7Fd1DQl2OsxNuZPWvLY0MXBnGmVpz3rb5lj6puhNSLyYkS2vfMf2fkUXom
 ioLw==
X-Gm-Message-State: AOJu0Yy1Wp5Z4sYiXCXDcvQITbgxAayJ6n267CouYYrtWqK/yCvN6UTo
 elQq/3Z4ah/AKOGIS1zyLoLtyWop9pfTOzEaKqrzophPPoNUA/xEEFgFmg+82VWHk+nUAn06pdE
 /wTJACjNsahIBUUcoms1OQXMqU2auPs+xyL4jzg==
X-Google-Smtp-Source: AGHT+IFituLIgtxOCsddZjyOJrhkdW9DbWRkSvFgy0VJhVaFPV/zczwXIIDBpHr5X5buwy1OjrvL9VoxUeFne0MKTQ0=
X-Received: by 2002:a17:90b:11c4:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2cd16d42434mr9082187a91.9.1721598985352; Sun, 21 Jul 2024
 14:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240707191128.10509-1-itachis@FreeBSD.org>
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 21 Jul 2024 15:56:14 -0600
Message-ID: <CANCZdfrXwxNqTjcBnh9tSBeebTggt-H4A0rvXT7+Z1O5+jOn9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] ARM AArch64 Support for BSD
To: Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Ajeet Singh <itachis@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000f7cf86061dc8ffc8"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000f7cf86061dc8ffc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued for my 9.1 pull request...

Thanks! Sorry for the delay...

Warner



On Sun, Jul 7, 2024 at 1:11=E2=80=AFPM Ajeet Singh <itachis6234@gmail.com> =
wrote:

> Patch 1: Previous patches 1 to 5, which were reviewed and acked, have bee=
n
> folded into this patch.Some changes that were suggested,
>          such as replacing "pstate &=3D ~PSTATE_C" with faster constructs
> like "env->CF =3D 0", have been addressed in patch 8.
> Patch 2: In this patch, patches 6 to 11 have been folded. Changes such as
> using "ROUND_DOWN" for stack pointer calculation
>          and replacing "__uint128_t" with "Int128" in the following patch
> 8 have been addressed. Also, "CPUARMState" will be
>          changed to "CPUArchState" in the upcoming version, and the issue
> with "-R" is being worked on separately.
> Patch 3: Patches 12 to 16 were reviewed and folded. The function
> "get_second_rval" will be used upstream.
> Patch 4: Patches 17 to 19 were folded, and "__uint128_t" to "Int128" has
> been fixed in patch 8. Also, the suggestion to
>          use "const_le32()" has been deferred for now.
> Patch 5: Previously patch 20, the FP suggestion is being deferred, but th=
e
> patch is ready for review.
> Patch 6: Previously patch 21 has been reviewed.
> Patch 7: Previously patch 22, same as patch 5.
> Patch 8: Previously patch 23. For now, no changes, but issues of other
> patches have been addressed, such as updating
>          AArch64 code to use CF directly and changing FP data structures
> to use Int128 instead of __uint128_t.
>
> Stacey Son (6):
>   bsd-user:Add CPU initialization and management functions
>   bsd-user:Add AArch64 register handling and related functions
>   bsd-user:Add ARM AArch64 signal handling support
>   bsd-user:Add get_mcontext function for ARM AArch64
>   bsd-user:Add set_mcontext function for ARM AArch64
>   bsd-user:Add AArch64 improvements and signal handling functions
>
> Warner Losh (2):
>   bsd-user:Add ARM AArch64 support and capabilities
>   bsd-user:Add setup_sigframe_arch function for ARM AArch64
>
>  bsd-user/aarch64/signal.c               | 137 +++++++++++++++++
>  bsd-user/aarch64/target_arch.h          |  28 ++++
>  bsd-user/aarch64/target_arch_cpu.c      |  31 ++++
>  bsd-user/aarch64/target_arch_cpu.h      | 188 ++++++++++++++++++++++++
>  bsd-user/aarch64/target_arch_elf.h      | 165 +++++++++++++++++++++
>  bsd-user/aarch64/target_arch_reg.h      |  56 +++++++
>  bsd-user/aarch64/target_arch_signal.h   |  80 ++++++++++
>  bsd-user/aarch64/target_arch_sigtramp.h |  48 ++++++
>  bsd-user/aarch64/target_arch_sysarch.h  |  42 ++++++
>  bsd-user/aarch64/target_arch_thread.h   |  61 ++++++++
>  bsd-user/aarch64/target_arch_vmparam.h  |  74 ++++++++++
>  bsd-user/aarch64/target_syscall.h       |  51 +++++++
>  bsd-user/qemu.h                         |   3 +
>  13 files changed, 964 insertions(+)
>  create mode 100644 bsd-user/aarch64/signal.c
>  create mode 100644 bsd-user/aarch64/target_arch.h
>  create mode 100644 bsd-user/aarch64/target_arch_cpu.c
>  create mode 100644 bsd-user/aarch64/target_arch_cpu.h
>  create mode 100644 bsd-user/aarch64/target_arch_elf.h
>  create mode 100644 bsd-user/aarch64/target_arch_reg.h
>  create mode 100644 bsd-user/aarch64/target_arch_signal.h
>  create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h
>  create mode 100644 bsd-user/aarch64/target_arch_sysarch.h
>  create mode 100644 bsd-user/aarch64/target_arch_thread.h
>  create mode 100644 bsd-user/aarch64/target_arch_vmparam.h
>  create mode 100644 bsd-user/aarch64/target_syscall.h
>
> --
> 2.34.1
>
>

--000000000000f7cf86061dc8ffc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Queued for my 9.1 pull request...<div><br></div><div>Thank=
s! Sorry for the delay...<br><div><br></div><div>Warner</div><div><br></div=
><div><br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sun, Jul 7, 2024 at 1:11=E2=80=AFPM Ajeet Singh &l=
t;<a href=3D"mailto:itachis6234@gmail.com">itachis6234@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Patch 1: Pr=
evious patches 1 to 5, which were reviewed and acked, have been folded into=
 this patch.Some changes that were suggested,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0such as replacing &quot;pstate &amp;=3D ~=
PSTATE_C&quot; with faster constructs like &quot;env-&gt;CF =3D 0&quot;, ha=
ve been addressed in patch 8.<br>
Patch 2: In this patch, patches 6 to 11 have been folded. Changes such as u=
sing &quot;ROUND_DOWN&quot; for stack pointer calculation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and replacing &quot;__uint128_t&quot; wit=
h &quot;Int128&quot; in the following patch 8 have been addressed. Also, &q=
uot;CPUARMState&quot; will be<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changed to &quot;CPUArchState&quot; in th=
e upcoming version, and the issue with &quot;-R&quot; is being worked on se=
parately.<br>
Patch 3: Patches 12 to 16 were reviewed and folded. The function &quot;get_=
second_rval&quot; will be used upstream.<br>
Patch 4: Patches 17 to 19 were folded, and &quot;__uint128_t&quot; to &quot=
;Int128&quot; has been fixed in patch 8. Also, the suggestion to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use &quot;const_le32()&quot; has been def=
erred for now.<br>
Patch 5: Previously patch 20, the FP suggestion is being deferred, but the =
patch is ready for review.<br>
Patch 6: Previously patch 21 has been reviewed.<br>
Patch 7: Previously patch 22, same as patch 5.<br>
Patch 8: Previously patch 23. For now, no changes, but issues of other patc=
hes have been addressed, such as updating<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AArch64 code to use CF directly and chang=
ing FP data structures to use Int128 instead of __uint128_t.<br>
<br>
Stacey Son (6):<br>
=C2=A0 bsd-user:Add CPU initialization and management functions<br>
=C2=A0 bsd-user:Add AArch64 register handling and related functions<br>
=C2=A0 bsd-user:Add ARM AArch64 signal handling support<br>
=C2=A0 bsd-user:Add get_mcontext function for ARM AArch64<br>
=C2=A0 bsd-user:Add set_mcontext function for ARM AArch64<br>
=C2=A0 bsd-user:Add AArch64 improvements and signal handling functions<br>
<br>
Warner Losh (2):<br>
=C2=A0 bsd-user:Add ARM AArch64 support and capabilities<br>
=C2=A0 bsd-user:Add setup_sigframe_arch function for ARM AArch64<br>
<br>
=C2=A0bsd-user/aarch64/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 137 +++++++++++++++++<br>
=C2=A0bsd-user/aarch64/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 28 ++++<br>
=C2=A0bsd-user/aarch64/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 +++=
+<br>
=C2=A0bsd-user/aarch64/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 | 188 ++++++++=
++++++++++++++++<br>
=C2=A0bsd-user/aarch64/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 | 165 ++++++++=
+++++++++++++<br>
=C2=A0bsd-user/aarch64/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 56 +++=
++++<br>
=C2=A0bsd-user/aarch64/target_arch_signal.h=C2=A0 =C2=A0|=C2=A0 80 ++++++++=
++<br>
=C2=A0bsd-user/aarch64/target_arch_sigtramp.h |=C2=A0 48 ++++++<br>
=C2=A0bsd-user/aarch64/target_arch_sysarch.h=C2=A0 |=C2=A0 42 ++++++<br>
=C2=A0bsd-user/aarch64/target_arch_thread.h=C2=A0 =C2=A0|=C2=A0 61 ++++++++=
<br>
=C2=A0bsd-user/aarch64/target_arch_vmparam.h=C2=A0 |=C2=A0 74 ++++++++++<br=
>
=C2=A0bsd-user/aarch64/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5=
1 +++++++<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A013 files changed, 964 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/aarch64/signal.c<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_cpu.c<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_cpu.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_elf.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_reg.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_signal.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_sysarch.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_thread.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_arch_vmparam.h<br>
=C2=A0create mode 100644 bsd-user/aarch64/target_syscall.h<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000f7cf86061dc8ffc8--

