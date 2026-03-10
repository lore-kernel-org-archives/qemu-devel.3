Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D14FD4F34
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w041F-00052J-H2; Tue, 10 Mar 2026 16:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1w041A-00051q-BF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:49:28 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1w0417-0007L6-Db
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:49:28 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b942424d231so642681366b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773175763; cv=none;
 d=google.com; s=arc-20240605;
 b=LCnB/qDFpAHpt6wJPayVIT8J37i4pt220x61aduEiSPFVnxxzqtJ/+MEvWCA4raUs0
 fE9c9V2KGZdJudwr3PhzSvcVtI+Vdyt/KPxmJvN4Lk5zFIQN3XtG9u04tOeDxt0FYuZY
 C1CTZYMoR49RqhcldgeCpdHGYjt7EzEoF1otzFEVfJRk2e+qd5rBNeNIqRbn32qN4d49
 otpyfvPaH4T+V/2qvTSCx5T52Cls2y3H9w6v9lXoSuunfSBJZHRhCQQoVm9btuFSeMZW
 7wsUpy0E7loV12S7wuCor81qFp0/eI2BS3WRTcbqBIvueBER+c7sLBoD7IujpuMeohYk
 swpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ET48Ebc1Y+UJ4ohkIxXyEB2cx87sQGQ/pzcJH28Eap4=;
 fh=UiDxkIoW/Cl5tQEWUJ54k+U5JOwL5Catzm5hR4C5J+8=;
 b=X2BkLMquh8fmSOtUE7fVTUrbe/tkZloB9fnBbo+fpVNCGWxKjmS6c6utqssOrW29qt
 QcXy7y6u8UmfC/gQV2MwEDR1c9OGHaXAtzE668ElCMLOdRnQ5p4bSFg2T7ccfRYkeTYd
 MOadiQ/bTseieDceNa0LQUsiEnXTo17vMnBUIMV/1T+L7vjtjiDR7CKF7br1frUCVKHs
 ZZekpw862sQS5GbiZrhVGQ0CAQelSXzjcPFLFCmMBZP6mWXoRpHXVtU8A3ZZQPEgBV9T
 gbTOummBodKpkDr7O0BMiYHlhNmeTK8kZMojvkQWOef5I3zHH06rHvdhd0tc0plSh21M
 BINg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773175763; x=1773780563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ET48Ebc1Y+UJ4ohkIxXyEB2cx87sQGQ/pzcJH28Eap4=;
 b=Lifzq0JYNAt6Piu+OOJ8VtaeaIR07mk6Q7DsNNDwpqAJ7VpOiZtzJ4xuT6MoijXzZI
 hLuBY0eQg7DN9FwQtKlfLTLI4SzvV7s3tJbbjQQ+96oD1nFc8wnvbMbxQlt7MKHvmqnx
 SrYcJdf+l56O88PhfIHPRLpT84vCzTzx1ZcKVKDBFDSDq23nRHu42bFAQuHM08StBY+q
 7QLrwuItZCLNxClnuLVPE22hFMgA53ugsI+SQvHwBQqf+yPw2rFfT8WWUbALATRNb830
 kNBISo+cuet6mKrRj7JdfGRmKIS6mySDnnlhMc601rlvUEYaSozRyl74GA58uL2OVTfB
 VPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175763; x=1773780563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ET48Ebc1Y+UJ4ohkIxXyEB2cx87sQGQ/pzcJH28Eap4=;
 b=vHXY1yubdhQEz/C7Pg6R0qG01iuOJlNrT+xWjFDl89HvebH92kRSqM604oGqhioWtc
 cza707fa+x0iPHhQS3zRXDTLiGBU2XgWRCI/xo6Zm9Hu7vNq40gCdxyNZ0YQVqDyfb1L
 3lS0ma/gdmSem5onugGOiTFnUq6PztZ+fOBRnDhsgOyXHMRvl4BKQC7AENQsw5qJU6gZ
 Bz07j0T3qmLS+o4dQLtG5//Fp4vtFfz+vfvBATbf0MzURN+mKIkX4YKmYG9nLRuzURR8
 wnaXr0UgETWQyRV/OemXFXU9TJR2GikQAA2kyZxni2Bn1XdnfbM9sJeuo4YV23Q2+Utc
 gFWw==
X-Gm-Message-State: AOJu0Yxmv0GBHafdQ7oZQ2fU2YJNtHtUxugzUxjvpUi/o5Roan7XaXh9
 7cPZomnqgTJ64pAAWD75G7Vq4N5vHxysf6RKqO28wf/pubPmPOtlybKPfgp/3S6LU0CDIEsrZYx
 YKgDdAa8NJmiIo9rpE8RVZicRYByBodA=
X-Gm-Gg: ATEYQzzSetUyPjhv2CW9haWCEV9RJuwKbheR/uMvtf1gbm1EQvmae5CRtfAaVEoQOJb
 8Qbop78yYtQOkPqsLUq1ToP9+Yn+Lqnc4vos30gQwbT9FSANr3owh60j7ShgwyCJPPvTMQq/fxw
 mxljyBzMkeWRF9mGfd/yrfEEu3Xx+5akIHEPpITL5SO/6nuRz4gqlKQv4JeNvwzZX5Sy9v7iCL2
 v3XQHTsfuFbw70HffBjJ3V1yid0KALhYPJ0lqxF1dMCVFi1PPoCrKODbl94ZXrJqrjw95IynoqK
 bnw+5DMpsA1x22ZNJENX/0Q67AepcL6vhMAxD+m6
X-Received: by 2002:a17:907:928e:b0:b87:7042:9aea with SMTP id
 a640c23a62f3a-b942dcea15amr996852366b.18.1773175762942; Tue, 10 Mar 2026
 13:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
 <edfc4472-783a-4205-acab-80f16d113784@gmx.de>
In-Reply-To: <edfc4472-783a-4205-acab-80f16d113784@gmx.de>
From: razvan ghiorghe <razvanghiorghe16@gmail.com>
Date: Tue, 10 Mar 2026 22:49:47 +0200
X-Gm-Features: AaiRm514L9AGgEcSYCJ89EFR1eDhCLIHbZeMggn-L1w679X_iL4VmXtoU6cipf8
Message-ID: <CAK=UehJqpN5=wkTq2x6dn4iUdcBL5_x3+VRdo43AbFnfN1b2jQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix zero_bss for RX PT_LOAD segments
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Content-Type: multipart/alternative; boundary="00000000000079a696064cb1a768"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

--00000000000079a696064cb1a768
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Helge,

This is a real-life case reported by user xtex in GitLab issue ( #3179) [1]
who encountered an ELF binary with PT_LOAD + (PROT_READ | PROT_EXEC) that
the Linux kernel loads successfully but QEMU rejects.

In response to Richard's feedback, I sent a follow-up patch on February 3rd
with 2 test cases that reproduce the exact ELF layout:

test-zerobss-1 has a .bss section but never accesses it, validates that the
loader correctly zeros the fractional .bss in an RX segment without
permission violations. test-zerobss-2 reads from multiple .bss variables
and exits with the sum as the exit code ( if .bss was correctly zeroed,
exit code is 0)

Both of them use a custom linker script that forces .text and .bss into the
same PT_LOAD segment with FLAGS(5) =3D R|X.Note that this reply is to the
first patch and the test cases are in the second patch sent on February 3rd
[2].

Best regards,

Razvan

[1]: https://gitlab.com/qemu-project/qemu/-/issues/3179

[2]:
https://lore.kernel.org/all/20260203073740.19913-2-razvanghiorghe16@gmail.c=
om/

(https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg00662.html)


=C3=8En vin., 6 mar. 2026 la 21:53, Helge Deller <deller@gmx.de> a scris:

> Hello Razvan,
>
> On 2/2/26 01:24, Razvan Ghiorghe wrote:
> > zero_bss() incorrectly assumed that any PT_LOAD containing .bss must be
> > writable, rejecting valid ELF binaries where .bss overlaps the tail of
> > an RX file-backed page.
>
> A .bss section which overlaps with a RX page?
> That sounds strange.
> Since I wonder, if is this a real-world case or just a theoretical case,
> maybe you can explain a littler further why/how you ran into that issue?
>
> Helge
>
> > Instead of failing, temporarily enable write access on the overlapping
> > page to zero the fractional bss range, then restore the original page
> > permissions once initialization is complete.
> >
> > To validate the correctness of the modified zero_bss() implementation,
> > two targeted test cases were constructed, designed to exercise the edge
> cases where
> > the .bss segment overlaps a partially filled virtual memory page
> belonging to a
> > R_X region. The test binaries were intentionally built without a main()
> function
> > and instead defined a custom ELF entry-point via the _start symbol.
> > This approach bypasses CRT, dynamic loader, libc initialization etc.
> ensuring that
> > execution begins immediately after QEMU completes ELF loading and memor=
y
> mapping.
> >
> > The first binary defines a minimal _start routine and immediately
> terminates
> > via a system call, without ever referencing the .bss symbol. Although a
> .bss section
> > is present in the ELF, it is not accessed at runtime, and the resulting
> PT_LOAD
> > mapping can be established without triggering any writes to a
> file-backed RX page.
> > In this configuration, QEMU successfully loads the binary, and the
> loader reaches
> > the zero_bss() path, validating that the fractional .bss region is
> correctly zeroed
> > without violating the original segment permissions.
> >
> > The second binary explicitly reads from the global .bss symbol (x) at
> program entry.
> > This forces the linker to materialize the .bss region within the same
> PT_LOAD
> > segment as the RX code, yielding a segment with p_filesz < p_memsz and
> flags R|X.
> > In this case, QEMU correctly fails during the initial file-backed mmap(=
)
> of the PT_LOAD
> > segment, returning EINVAL. This behavior is consistent with the Linux
> kernel=E2=80=99s ELF
> > loader semantics, which prohibit mapping a file-backed segment as RX
> when it (logically)
> > contains writable memory. Consequently, this failure occurs before
> zero_bss()
> > is reached (behaviour expected and correct).
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3179
> > Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
> > ---
> >   linux-user/elfload.c | 38 +++++++++++++++++++++++---------------
> >   1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index 35471c0c9a..fa3f7cda69 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -449,18 +449,11 @@ static bool zero_bss(abi_ulong start_bss,
> abi_ulong end_bss,
> >   {
> >       abi_ulong align_bss;
> >
> > -    /* We only expect writable bss; the code segment shouldn't need
> this. */
> > -    if (!(prot & PROT_WRITE)) {
> > -        error_setg(errp, "PT_LOAD with non-writable bss");
> > -        return false;
> > -    }
> > -
> >       align_bss =3D TARGET_PAGE_ALIGN(start_bss);
> >       end_bss =3D TARGET_PAGE_ALIGN(end_bss);
> >
> >       if (start_bss < align_bss) {
> >           int flags =3D page_get_flags(start_bss);
> > -
> >           if (!(flags & PAGE_RWX)) {
> >               /*
> >                * The whole address space of the executable was reserved
> > @@ -472,20 +465,35 @@ static bool zero_bss(abi_ulong start_bss,
> abi_ulong end_bss,
> >                */
> >               align_bss -=3D TARGET_PAGE_SIZE;
> >           } else {
> > +            abi_ulong start_page_aligned =3D start_bss & TARGET_PAGE_M=
ASK;
> >               /*
> > -             * The start of the bss shares a page with something.
> > -             * The only thing that we expect is the data section,
> > -             * which would already be marked writable.
> > -             * Overlapping the RX code segment seems malformed.
> > +             * The logical OR between flags and PAGE_WRITE works becau=
se
> > +             * in include/exec/page-protection.h they are defined as
> PROT_*
> > +             * values, matching mprotect().
> > +             * Temporarily enable write access to zero the fractional
> bss.
> > +             * target_mprotect() handles TB invalidation if needed.
> >                */
> >               if (!(flags & PAGE_WRITE)) {
> > -                error_setg(errp, "PT_LOAD with bss overlapping "
> > -                           "non-writable page");
> > -                return false;
> > +                if (target_mprotect(start_page_aligned,
> > +                                    TARGET_PAGE_SIZE,
> > +                                    prot | PAGE_WRITE) =3D=3D -1) {
> > +                    error_setg_errno(errp, errno,
> > +                                    "Error enabling write access for
> bss");
> > +                    return false;
> > +                }
> >               }
> >
> > -            /* The page is already mapped and writable. */
> > +            /* The page is already mapped and now guaranteed writable.
> */
> >               memset(g2h_untagged(start_bss), 0, align_bss - start_bss)=
;
> > +
> > +            if (!(flags & PAGE_WRITE)) {
> > +                if (target_mprotect(start_page_aligned,
> > +                                    TARGET_PAGE_SIZE, prot) =3D=3D -1)=
 {
> > +                    error_setg_errno(errp, errno,
> > +                                    "Error restoring bss first
> permissions");
> > +                    return false;
> > +                }
> > +            }
> >           }
> >       }
> >
>
>

--00000000000079a696064cb1a768
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-4c49cdaa-7fff-8972-44=
ef-2d1d2d538fdf"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;m=
argin-bottom:12pt"><span style=3D"font-size:11pt;font-family:Arial,sans-ser=
if;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-al=
ign:baseline">Hello Helge,</span></p><p dir=3D"ltr" style=3D"line-height:1.=
38;margin-top:12pt;margin-bottom:12pt"><span style=3D"font-size:11pt;font-f=
amily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-variant-alternate=
s:normal;vertical-align:baseline">This is a real-life case reported by user=
 xtex in GitLab issue ( #3179) [1] who encountered an ELF binary with PT_LO=
AD + (PROT_READ | PROT_EXEC) that the Linux kernel loads successfully but Q=
EMU rejects.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:=
12pt;margin-bottom:12pt"><span style=3D"background-color:transparent;color:=
rgb(0,0,0);font-family:Arial,sans-serif;font-size:11pt">In response to Rich=
ard&#39;s feedback, I sent a follow-up patch on February 3rd with 2 test ca=
ses that reproduce the exact ELF layout:</span></p><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:12pt;margin-bottom:12pt"><span style=3D"font-si=
ze:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tran=
sparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-var=
iant-alternates:normal;vertical-align:baseline">test-zerobss-1 has a .bss s=
ection but never accesses it, validates that the loader correctly zeros the=
 fractional .bss in an RX segment without permission violations.=C2=A0</spa=
n><span style=3D"background-color:transparent;color:rgb(0,0,0);font-family:=
Arial,sans-serif;font-size:11pt">test-zerobss-2 reads from multiple .bss va=
riables and exits with the sum as the exit code ( if .bss was correctly zer=
oed, exit code is 0)</span></p><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:12pt;margin-bottom:12pt"><span style=3D"font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline">Both of them use a custom linker script that fo=
rces .text and .bss into the same PT_LOAD segment with FLAGS(5) =3D R|X.</s=
pan><span style=3D"background-color:transparent;color:rgb(0,0,0);font-famil=
y:Arial,sans-serif;font-size:11pt">Note that this reply is to the first pat=
ch and the test cases are in the second patch sent on February 3rd [2].</sp=
an></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:12pt;margin-bott=
om:12pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:r=
gb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-var=
iant-east-asian:normal;font-variant-alternates:normal;vertical-align:baseli=
ne">Best regards,</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:12pt;margin-bottom:12pt"><span style=3D"font-size:11pt;font-family:Ari=
al,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nu=
meric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;=
vertical-align:baseline">Razvan</span></p><br><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:12pt;margin-bottom:12pt"><span style=3D"font-size:11=
pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpare=
nt;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-=
alternates:normal;vertical-align:baseline">[1]: <a href=3D"https://gitlab.c=
om/qemu-project/qemu/-/issues/3179">https://gitlab.com/qemu-project/qemu/-/=
issues/3179</a></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:12pt;margin-bottom:12pt"><span style=3D"font-size:11pt;font-family:Arial=
,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ve=
rtical-align:baseline">[2]: </span><a href=3D"https://lore.kernel.org/all/2=
0260203073740.19913-2-razvanghiorghe16@gmail.com/" style=3D"text-decoration=
-line:none"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;back=
ground-color:transparent;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;text-decoration-line:underline;vert=
ical-align:baseline">https://lore.kernel.org/all/20260203073740.19913-2-raz=
vanghiorghe16@gmail.com/</span></a></p><p dir=3D"ltr" style=3D"line-height:=
1.38;margin-top:12pt;margin-bottom:12pt"><span style=3D"font-size:11pt;font=
-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font=
-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alterna=
tes:normal;vertical-align:baseline">(<a href=3D"https://mail.gnu.org/archiv=
e/html/qemu-devel/2026-02/msg00662.html">https://mail.gnu.org/archive/html/=
qemu-devel/2026-02/msg00662.html</a>)</span></p></span><br class=3D"gmail-A=
pple-interchange-newline"></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">=C3=8En vin., 6 mar. 2026 l=
a 21:53, Helge Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx.de</a=
>&gt; a scris:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
ello Razvan,<br>
<br>
On 2/2/26 01:24, Razvan Ghiorghe wrote:<br>
&gt; zero_bss() incorrectly assumed that any PT_LOAD containing .bss must b=
e<br>
&gt; writable, rejecting valid ELF binaries where .bss overlaps the tail of=
<br>
&gt; an RX file-backed page.<br>
<br>
A .bss section which overlaps with a RX page?<br>
That sounds strange.<br>
Since I wonder, if is this a real-world case or just a theoretical case,<br=
>
maybe you can explain a littler further why/how you ran into that issue?<br=
>
<br>
Helge<br>
<br>
&gt; Instead of failing, temporarily enable write access on the overlapping=
<br>
&gt; page to zero the fractional bss range, then restore the original page<=
br>
&gt; permissions once initialization is complete.<br>
&gt; <br>
&gt; To validate the correctness of the modified zero_bss() implementation,=
<br>
&gt; two targeted test cases were constructed, designed to exercise the edg=
e cases where<br>
&gt; the .bss segment overlaps a partially filled virtual memory page belon=
ging to a<br>
&gt; R_X region. The test binaries were intentionally built without a main(=
) function<br>
&gt; and instead defined a custom ELF entry-point via the _start symbol.<br=
>
&gt; This approach bypasses CRT, dynamic loader, libc initialization etc. e=
nsuring that<br>
&gt; execution begins immediately after QEMU completes ELF loading and memo=
ry mapping.<br>
&gt; <br>
&gt; The first binary defines a minimal _start routine and immediately term=
inates<br>
&gt; via a system call, without ever referencing the .bss symbol. Although =
a .bss section<br>
&gt; is present in the ELF, it is not accessed at runtime, and the resultin=
g PT_LOAD<br>
&gt; mapping can be established without triggering any writes to a file-bac=
ked RX page.<br>
&gt; In this configuration, QEMU successfully loads the binary, and the loa=
der reaches<br>
&gt; the zero_bss() path, validating that the fractional .bss region is cor=
rectly zeroed<br>
&gt; without violating the original segment permissions.<br>
&gt; <br>
&gt; The second binary explicitly reads from the global .bss symbol (x) at =
program entry.<br>
&gt; This forces the linker to materialize the .bss region within the same =
PT_LOAD<br>
&gt; segment as the RX code, yielding a segment with p_filesz &lt; p_memsz =
and flags R|X.<br>
&gt; In this case, QEMU correctly fails during the initial file-backed mmap=
() of the PT_LOAD<br>
&gt; segment, returning EINVAL. This behavior is consistent with the Linux =
kernel=E2=80=99s ELF<br>
&gt; loader semantics, which prohibit mapping a file-backed segment as RX w=
hen it (logically)<br>
&gt; contains writable memory. Consequently, this failure occurs before zer=
o_bss()<br>
&gt; is reached (behaviour expected and correct).<br>
&gt; <br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/317=
9" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/3179</a><br>
&gt; Signed-off-by: Razvan Ghiorghe &lt;<a href=3D"mailto:razvanghiorghe16@=
gmail.com" target=3D"_blank">razvanghiorghe16@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0linux-user/elfload.c | 38 +++++++++++++++++++++++---------=
------<br>
&gt;=C2=A0 =C2=A01 file changed, 23 insertions(+), 15 deletions(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt; index 35471c0c9a..fa3f7cda69 100644<br>
&gt; --- a/linux-user/elfload.c<br>
&gt; +++ b/linux-user/elfload.c<br>
&gt; @@ -449,18 +449,11 @@ static bool zero_bss(abi_ulong start_bss, abi_ul=
ong end_bss,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong align_bss;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* We only expect writable bss; the code segment should=
n&#39;t need this. */<br>
&gt; -=C2=A0 =C2=A0 if (!(prot &amp; PROT_WRITE)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;PT_LOAD with non-w=
ritable bss&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0align_bss =3D TARGET_PAGE_ALIGN(start_bss);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0end_bss =3D TARGET_PAGE_ALIGN(end_bss);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (start_bss &lt; align_bss) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags =3D page_get_flags(s=
tart_bss);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(flags &amp; PAGE_RWX)) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The whole add=
ress space of the executable was reserved<br>
&gt; @@ -472,20 +465,35 @@ static bool zero_bss(abi_ulong start_bss, abi_ul=
ong end_bss,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align_bss -=3D T=
ARGET_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong start_page_aligne=
d =3D start_bss &amp; TARGET_PAGE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The start of the bs=
s shares a page with something.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The only thing that=
 we expect is the data section,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* which would already=
 be marked writable.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Overlapping the RX =
code segment seems malformed.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The logical OR betw=
een flags and PAGE_WRITE works because<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in include/exec/pag=
e-protection.h they are defined as PROT_*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* values, matching mp=
rotect().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Temporarily enable =
write access to zero the fractional bss.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* target_mprotect() h=
andles TB invalidation if needed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(flags &amp=
; PAGE_WRITE)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;PT_LOAD with bss overlapping &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;non-writable page&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_mp=
rotect(start_page_aligned,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_PAGE_SIZE,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot | PAGE_WRITE)=
 =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 error_setg_errno(errp, errno,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Error enabli=
ng write access for bss&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The page is already mapp=
ed and writable. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The page is already mapp=
ed and now guaranteed writable. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(g2h_untag=
ged(start_bss), 0, align_bss - start_bss);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(flags &amp; PAGE_WRIT=
E)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_mp=
rotect(start_page_aligned,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_PAGE_SIZE, =
prot) =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 error_setg_errno(errp, errno,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Error restor=
ing bss first permissions&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--00000000000079a696064cb1a768--

