Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DB606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q3T/7yJP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNMEN-00017Z-B8; Sat, 31 Oct 2026 23:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNME4-00013c-Sh
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 23:27:21 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNMDv-00019a-KI
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 23:27:13 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so316689866b.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 20:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793503626; cv=none;
 d=google.com; s=arc-20260327;
 b=Svig63qXxKk8Now9e97wn3laaeMJVy8arQJlyZErdAShnLxZx/gG7XPQWML2w4BEOp
 yHHcsYdqtrWwnG4jpqfr795SbAaF8MLFOVjx7VQSPX8Ay9EYg5HgGh1LJ5PDoi4dIoAL
 tBxBFQNkaPJfcNGwcE1NyuU+HzXP6Y3RQlshqBpMSsiTira7/SFUSM1mLgcAZyrMZafS
 rXJfF9PfpgdIXENnDKyqmsuljUEBHvRJ2VZhKZDNRnLhHCkl5a9GOAYFIGha4av5PDp2
 kQH5gSW/ACucw2E9E1x5c5MFa1DmTaiwzyQXMxD3U7D9rxVV3cPb0Je+Ldc/r5nGMJnb
 rjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DWO0Oi5z9yO5iNhbmEE3jx4kds9djaRbLYHcUT+/GCc=;
 fh=zRo5UccLCHrU49948tMObEHCRpxm3W3vc2SqpymKsp8=;
 b=UPS+n37JqCPQEG7VSqLsR1g8Tsc7gy/rHZso2f9DLtLopX98+KcttbOrPUtiLXzjx2
 /rKCBSPwP0WBq9Owpo74FQpnTiefAQOmUyqJEyBqGCSyh277Qh8wH/ztepTudMPXjdVK
 sekWjNXH/HRJhVCEp6AoXMY0SAIgBFsltiyysGSzDewqZ0TcrId4766wDuy3CCgX7b4D
 0jGHQnz7ucPz+yPSvKxHRrVx59nUe+QByxaqQKqrLDxgJFH2cHSiCzEq8AcYe9bfC9hb
 iPABP18lg2XOkA3FvukbvkTD7zTlXR8PNkF05X/swpOb5xIYbqPNOISOIVjMjkBLbVmM
 6byQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793503626; x=1794108426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DWO0Oi5z9yO5iNhbmEE3jx4kds9djaRbLYHcUT+/GCc=;
 b=Q3T/7yJPWjEugDK5ivz5DWIR7WVZFVgIiPnxwB+b2IuQI+U48wUvSghTMpok8dVeh8
 MJNICGDq5Z4Udmpp89YpIXuE+FAwBY1I6iFIrpdqBhMkZOr0bTdIEpFmhHBisryo4vpI
 Rgd05cVSURWEyE0e3+9dVzRBg5JTlbKRs17vMDwl9nVh8TOQlQKgbgoXaeZ/IU//7Pqw
 b2EhFXH+ojy2ofWa6568XQUEwiCDRRzjcirZWTOmS9jTvt2ky+JCCpCVMgiK6WFgPRXA
 eD4EQ10wRXYP5jhUnZHUDKhJQ7HYtGPSPXkvQ5KMuFrx3WrZe2oqnW6qaCIfhd1XOPvh
 dZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793503626; x=1794108426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DWO0Oi5z9yO5iNhbmEE3jx4kds9djaRbLYHcUT+/GCc=;
 b=Cjy3Iu24gjholbgoPkectdQtNH1Dr1wgXzblUtD5fxKkGLkVW+49vJRRL1u9sCB6Pv
 goU4TxAlxfMQ1GbdQIzlaYJtUwGQ1EkqS6onG8viOFpj2LNCwocVtUzHl9xROdEwkMHv
 ome+Ye/sVgsufyXk28ja8kqhZ7eQ7mtR5/8Tw8yH9T8ABBQq5Wco0uzwUeCL9KzHoim6
 5PXALfrFZIiCWJuev1LxZqDLoG+FC4+F5tHk4j2ggS8aK3tRYtn7E8BOScsBhmLMwl2a
 Yhq7jIw1/HGENAjvMfWTG6CHz9RBv4ElgQ0Cs9fO+8cPL3fabo4FnWMMQ7Pj0lHgiQ1H
 l+eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4Zk+ssRKhPxb1WvdfXTvrtGrQlllEg3P5n+Ydzn/fSpXVVa2+n51iZbpV0e1t2Kyu0l9NrRDkh4+n@nongnu.org
X-Gm-Message-State: AFq9FYIb0k4DD08tMFL4tehC3FMJtr+iF8IFVQxc87M63cqo8Ep0Oa8k
 /HF4I4cmARHrT2bC3inG+s3j3aBuDtQIszAzxvROVp9uyATOxDNEM+ktdsKBPe0eCerpOh8X6Rn
 I/XP0DysDeigtvwDALBa4RTYbcJQ3p4c=
X-Gm-Gg: AYBFou3NlMg9ZtrUEv6ds21jvg+NLSbyoZGlxnXE1ux9q+pg0iZ9HqEg8eOlz1WPwuz
 H1IEJKz7fvrGjwfyHnfxGROlwhr4FwQVEr34pf27lHQ2ZXuoiVtsVJNtfWjVTEccxBYkQjxHW4d
 y4DOKiFi7PWnMQeUSaUEB/h8fIAwC+tOPfWPgO09NItAkiuimGTo6TEZIbddRpKi1pFYdpjry3F
 zCWT9crqVPrwnR1SKeXamtUmBkYHHMh7HKjBkItYxNXCn3S1HdTvC70yUbPZlp8jqmw1kfJSxsa
 nQRSe1V7GdEUgDBcd/qaQraoY+PGpuRBHG6b5imYvFfgzUDHpa7swNyOZ+piy9UE9QFvMbfVFXD
 CscY99oTBjJYAXCFejs1dCO0dgNkPhfN2WIsEnA==
X-Received: by 2002:a17:907:6d05:b0:c3f:c856:fb7a with SMTP id
 a640c23a62f3a-c4ca793baa3mr525308866b.3.1793503625809; Sat, 31 Oct 2026
 20:27:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <ba106173-fca3-6019-3028-122831887921@eik.bme.hu>
 <CAE2XoE9cR_X0kkDfGTU4Mt_5Hc3WZ8K5rghw2AeL4Vh=eugGag@mail.gmail.com>
 <bf45a858-db07-de03-70ea-ca0061d7a5d1@eik.bme.hu>
 <CAE2XoE9_b5UiE2+BXFRqB3RPv=M+8jr1HQy7rEFVEb6w1DdoGg@mail.gmail.com>
 <a479df5b-721d-c357-5c69-c3760a73e521@eik.bme.hu>
In-Reply-To: <a479df5b-721d-c357-5c69-c3760a73e521@eik.bme.hu>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 1 Nov 2026 11:26:53 +0800
X-Gm-Features: AclHuK9057t8H_kvHtA0m7bf23Rw45MDO_-qUsQ8r90mDc2w3RogzzSts7xwUEo
Message-ID: <CAE2XoE-fkc-PqKsx4Lf+RdHxqctAS2TSuqueGFrnea2jaiQXnA@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, 
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 7:29=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Sun, 1 Nov 2026, Yonggang Luo wrote:
> > On Sun, Nov 1, 2026 at 1:06=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.=
hu> wrote:
> >>
> >> On Sat, 31 Oct 2026, Yonggang Luo wrote:
> >>> On Sat, Oct 31, 2026 at 8:42=E2=80=AFPM BALATON Zoltan <balaton@eik.b=
me.hu> wrote:
> >>>>
> >>>> On Fri, 30 Oct 2026, Pierrick Bouvier wrote:
> >>>>> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> >>>>>> On Fri, 30 Oct 2026, Yonggang Luo wrote:
> >>>>>>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and =
the
> >>>>>>> type_init
> >>>>>>> function that calls type_register_static(). A later change needs =
to
> >>>>>>> pass a
> >>>>>>
> >>>>>> That's the point of the macro to hide the boiler plate code.
> >>>>>>
> >>>>>>> target mask into that registration, and the macros have no parame=
ter
> >>>>>>> for it.
> >>>>>>
> >>>>>> Couldn't you just change the macros to take that parameter instead=
 of
> >>>>>> expanding it everywhere?
> >>>>>>
> >>>>>
> >>>>> Problem of macros is that they don't have default parameters, so yo=
u
> >>>>> need variants for everything:
> >>>>>
> >>>>> DEFINE_MACHINE
> >>>>> DEFINE_MACHINE_EXTENDED
> >>>>> DEFINE_MACHINE_WITH_INTERFACES
> >>>>> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> >>>>> and now would need a new variant, with variant for other existing o=
nes.
> >>>>>
> >>>>> In the end, it's just simpler to remove this and add the boilerplat=
e.
> >>>>> It's written once and never modified, so using a macro just save ty=
ping
> >>>>> those lines once.
> >>>>>
> >>>>>> Regards,
> >>>>>> BALATON Zoltan
> >>>>>>
> >>>>>>> This series expands every caller first, with no behavior change, =
so the
> >>>>>>> follow-up only replaces the type_register_static() call.
> >>>>>>>
> >>>>>>> Each machine file gains a class_init function, a TypeInfo, and a
> >>>>>>> type_init
> >>>>>>> function that calls type_register_static(). The last patch remove=
s
> >>>>>>> DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core/b=
oards.h.
> >>>>
> >>>> Macros help reading the code not saving typing. If the actual
> >>>> functionality is buried in a lot of boiler plate it's harder to unde=
rstand
> >>>> and spot bugs so putting the unintresting boiler plate behind a macr=
o is
> >>>> better even if you need a separate version for different cases. Then=
 the
> >>>> code that uses the macro will be much more obvious and not just a lo=
t of
> >>>
> >>> I think mainly because DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* are
> >>> not defined properly
> >>> that causes them to not be extended easily.
> >>>
> >>> DEFINE_TYPES is another example, use them can extend easily, how abou=
t
> >>> always use DEFINE_TYPES?
> >>> Or add a DEFINE_TYPE to replace DEFINE_MACHINE* and DEFINE_SECURE_MAC=
HINE*?
> >>
> >> Maybe I'm missing the problem but DEFINE_MACHINE macros are just
> >> convenience wrappers around DEFINE_MACHINE_EXTENDED. So why can't you =
add
> >> the needed parameter to DEFINE_MACHINE_EXTENDED and use that for machi=
nes
> >> that need it, or if it's needed by all machines then make the new
> >> parameter required and add it to all convenience wrappers too so you c=
an
> >> keep using DEFINE_MACHINE* and just need to add one parameter to it in
> >> machines?
> >
> > That's the issue, add parameter to DEFINE_MACHINE_EXTENDED means all
> > calls to it also need
> > to be changed, that means touch many $target_arch files. currently
> > it's 13. But after these
>
> That's not different from expanding the macro which would touch the same
> files.
>
> > changes, there will be much more usage on it, and if we want to add
> > more parameters or attributes
> > to it, it will be a new tree-wide change.
>
> Do you expect to need more parameters? Can't you add them at once then?
>
> > And DEFINE_TYPES do not suffer from such issues. As the TypeInfo[] is
> > explicit defined for
> > DEFINE_TYPES
>
> My point is that keeping the boiler plate as little as possible makes the
This is also what I want, makes the code more readable and little boiler pl=
ate.
> code more readable. DEFINE_TYPES hides some of the boiler plate,

The DEFINE_TYPES would be like this:

static const TypeInfo dp264_types[] =3D {
    {
        .name       =3D MACHINE_TYPE_NAME("clipper"),
        .parent     =3D TYPE_MACHINE,
        .class_init =3D clipper_machine_class_init,
    },
};

DEFINE_TYPES(dp264_types)


> DEFINE_MACHINE hides even more so converting to DEFINE_TYPES would expose
> some even if it's better than no macro at all.
>
> What exactly are the parameters missing from DEFINE_MACHINE_EXTENDED that
> need to be added?
>
> Regards,
> BALATON Zoltan



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

