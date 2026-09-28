Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211ADCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9LG-0002B6-93; Mon, 28 Sep 2026 07:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB9Kj-00028G-GL
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:15:52 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB9Kh-00008W-Bl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:15:45 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aaf10bf094so3518594a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790594142; cv=none;
 d=google.com; s=arc-20260327;
 b=UV7XhS9ZmQz6sjh8etBTVQxjf1g7wHmeuIBwPdikWmMoLs7FNTmqDEtINrBf3NvnAA
 L0PqP92aFXRwW6lt+3NRWbHzdByt0L2FyrxMMwhddsQPZ/4zI7nsJzoTaL4zDa1Bl3/E
 PCieWoYFPPR10xR4fD+Pn0OTflwwC0CjoS/afWJfEOZeHfVpYQE5z4xcGMw0grn9gTb8
 1kJMrw6BnGpzYuOyT7bbe+yE7IX4NX76ep2a5BSKYu5aHtJSvOKY8fS8JUBTXxCr9DZG
 ozw134R7Ukl1vjkt8JQMSt6bkmbGQrvpDPeZj2fio+dAM4uUikfXTiebWLpQOGlSLrIU
 VrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l/W5KMfmAafbh94ihcimc3L0jPH5ZoJNODiRrHBRay4=;
 fh=6jdXT6b4cnfDza0iCJZs0pGSp8j3wtI2284GwcwH8j8=;
 b=evaIwqW6eLIMkh2vsO4hFsFbPnZjcT7aUy3AJtoUHgWzyB+fYB3FbVA1qPhXnYXyBI
 QYLkJWjdBjmG8A3Mr862cMqv7oq1drqYflkHHgUeIkInDTWTI3FAyZkMIJjVgVR7yYkP
 OsluSYyiS06g1MkuXVrpQSPEO2E2ACnqEbzyKJ2MEFO8aoI0okkoOicNtLMrRgOA0Smi
 JvTUWwQRyHlZNQOheYDhZ9q3bF6+fiVubKcbtaSb2OsJF2wAFddEtUFyA2cLaVqSaixz
 fjJMfVtT3Hmfx06xxs4t7lyXSMYKMTVVOzFMwB8uOVIcOpK7wqWrO8DhJdUPiFmJBFMv
 nIpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790594142; x=1791198942; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/W5KMfmAafbh94ihcimc3L0jPH5ZoJNODiRrHBRay4=;
 b=ZqDYUsiaPKBMCeDa5SLzt0XPm3hS7PAegS0Hsmvp0JsoSzVnfi0M/xKvH794a5lTxp
 3HRKxLKb/9qSZi8WPYqw/YDPJuJ6KKpPWUPWtETvRaE/zz2Q23TRLOZjSNImm5vsFXUQ
 67LAHQw8ATpWAO/sNst799pvqcoFdl8QW09DFgVRjurj1chK3CYccp11Gzk57VDwOZbg
 xQs70sYv8Y1N4dY4HvmM1QH/vDCiV9rilsUn6XzGLJpwYcvK10zBhei5f1HtBo2IN0R7
 MH5wRTJdOnxBxRylC29MAa0AWhHzT9J3r6mKMbwaQdRQJuvFSad+pAA4EYa5rxqceSAh
 EBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790594142; x=1791198942;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l/W5KMfmAafbh94ihcimc3L0jPH5ZoJNODiRrHBRay4=;
 b=ihte5aH6PX/iQZnS5IZUZZMNWXCUccC+VmqIPCfv++cKZnyhref+jRngabeAcp4qwW
 2tYT83+nBZ0BVtGYzkWgY5cRAs50iKJ6mPgRUGgT+KZA33kmt+ELjey4yZ+R32P9xRzw
 5NcMVfiaif+3GnbkpGFuH4ezBU/A9/IXrmVYRQwZIVEONN8y56mWX1u9E3bk6Cm0viv4
 beqd/wUDXoZGZAAHSJ7sbmtMIOXk7kkheT6RXaK6y4Dl007sBMyenUxkBuOAY83qDFKa
 22brR7Y0MGwByrM+NDFmMalXz/A8cnaNvQtijSJ4piVAGs7xfTmRyEBwJT2mrEUn57cF
 gyVA==
X-Gm-Message-State: AFq9FYLYuJmkOy4uAy6CLMsWyMwd/4zhDNm4GeII2eSfe3RbU4vlsmn2
 TsUwERfAs6pmzY6y1O1Q5xA/HohOKVCmoeGjHOGgWqXVZY/qX66vkMb+X3M4Ld9w/B6Xhbh0wJF
 T9iv4XjVlgYQ/UhLzQXreafQOaNuoZrQ=
X-Gm-Gg: AYBFou2nHS40scHxxMRVzkEd2G2gpfZHhE7Y6hJlBpuugX6zYW9TXNbDtq90znq0jcc
 paM0WQoUBK8YbkmEOmUs7G0NPBFs2NNEDMP/FK1WmvhTIuQdX5dh6NmiW0blgd43R+HfhYn7MY3
 9Z1EUhVeQzZN996XC8v3nxBkiZli3wvMpcHk4CYkWSQTv7fmOxubvPAQhF3khHSBAJjzlxJoIb/
 z5JoCL9y7KfLBMX0tQmtTHWsqrDnBt4M6h8meoq5kIwu4zZxq7za0ay1y4Z0633uD+ykT0yAEQb
 Waujg9S4fhwOPs1GIi5wQNdDU1NBzXdYNAPevpFQtsX5etBN3BlRXYQ=
X-Received: by 2002:a05:6402:2811:b0:6ac:68a3:3c30 with SMTP id
 4fb4d7f45d1cf-6ac68a344c1mr2814577a12.14.1790594141547; Mon, 28 Sep 2026
 04:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-32-luoyonggang@gmail.com>
 <87cxtxhd5i.fsf@pond.sub.org>
In-Reply-To: <87cxtxhd5i.fsf@pond.sub.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 19:15:27 +0800
X-Gm-Features: AclHuK-f1y9KNL5-AcTF1mHTwD55vm1IehHZN18_5Lor_nIRBDnfBXmN0m0UOEw
Message-ID: <CAE2XoE-Qs6EL1CGFnE-Z6vdP2Zui3=4HZXtLSvKhpwkrPuNpgA@mail.gmail.com>
Subject: Re: [PATCH v4 31/55] accel/tcg: move memory helpers out of
 tcg-runtime.h
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000be74f0065c892f4d"
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000be74f0065c892f4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:40=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > memset, ld_i128, and st_i128 are declared in ldst_common.h, and
> > ldst_common.c.inc emits their helper info. Atomic helpers move to
> > atomic_common.h, with info records emitted from atomic_common.c.inc.
> > tcg-runtime.h keeps the integer helpers implemented in tcg-runtime.c.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>
> Another compilation failure:

Sorry for the annoyance, catched by gitlab-ci, and I have already fixed it
locally. the gitlab-ci is green at commit

https://gitlab.com/lygstate-qemu/qemu/-/commit/cc6301e7142730de016cfd94c112=
ba8fd240d189

>
>     cc -m64  -o tests/unit/test-tcg-call-tl
libevent-loop-base.a.p/event-loop-base.c.o libqom.a.p/qom_container.c.o
libqom.a.p/qom_object.c.o libqom.a.p/qom_object_interfaces.c.o
libqom.a.p/qom_qom-qobject.c.o libqom.a.p/qom_compat-properties.c.o
libqom.a.p/target-info.c.o libqom.a.p/target-kconfig.c.o
libsystem.a.p/accel_tcg_tcg-runtime.c.o libsystem.a.p/tcg_optimize.c.o
libsystem.a.p/tcg_region.c.o libsystem.a.p/tcg_tcg.c.o
libsystem.a.p/tcg_tcg-common.c.o libsystem.a.p/tcg_tcg-op.c.o
libsystem.a.p/tcg_tcg-op-vec.c.o libsystem.a.p/tcg_perf.c.o
tests/unit/test-tcg-call-tl.p/test-tcg-call-tl.c.o
tests/unit/test-tcg-call-tl.p/test-tcg-call-tl-stubs.c.o
tests/unit/test-tcg-call-tl.p/.._.._page-vary-common.c.o -Wl,--as-needed
-Wl,--no-undefined -pie -fstack-protector-strong -Wl,-z,relro -Wl,-z,now
-Wl,--start-group libqemuutil.a
subprojects/libvhost-user/libvhost-user-glib.a
subprojects/libvhost-user/libvhost-user.a -lnuma /usr/lib64/liburing.so
/usr/lib64/libgio-2.0.so /usr/lib64/libgobject-2.0.so /usr/lib64/
libglib-2.0.so /usr/lib64/libgmodule-2.0.so -pthread
/usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1.so
/usr/lib64/libepoxy.so -Wl,--end-group
>     /usr/bin/ld: libsystem.a.p/tcg_perf.c.o: in function
`perf_report_code':
>     /work/armbru/qemu/bld/../tcg/perf.c:328:(.text+0x5e9): undefined
reference to `debuginfo_lock'
>     /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:341:(.text+0x66f):
undefined reference to `debuginfo_query'
>     /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:361:(.text+0xa91):
undefined reference to `debuginfo_unlock'
>     collect2: error: ld returned 1 exit status
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000be74f0065c892f4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 6:40=E2=80=AFPM Markus Arm=
bruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =
wrote:<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; memset, ld=
_i128, and st_i128 are declared in ldst_common.h, and<br>&gt; &gt; ldst_com=
mon.c.inc emits their helper info. Atomic helpers move to<br>&gt; &gt; atom=
ic_common.h, with info records emitted from atomic_common.c.inc.<br>&gt; &g=
t; tcg-runtime.h keeps the integer helpers implemented in tcg-runtime.c.<br=
>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:l=
uoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;<br>&gt; Another=
 compilation failure:<div><br></div><div>Sorry for the annoyance, catched b=
y gitlab-ci, and I have already fixed it locally. the gitlab-ci is green at=
 commit</div><div><br></div><div><a href=3D"https://gitlab.com/lygstate-qem=
u/qemu/-/commit/cc6301e7142730de016cfd94c112ba8fd240d189">https://gitlab.co=
m/lygstate-qemu/qemu/-/commit/cc6301e7142730de016cfd94c112ba8fd240d189</a><=
/div><div><br>&gt;<br>&gt; =C2=A0 =C2=A0 cc -m64 =C2=A0-o tests/unit/test-t=
cg-call-tl libevent-loop-base.a.p/event-loop-base.c.o libqom.a.p/qom_contai=
ner.c.o libqom.a.p/qom_object.c.o libqom.a.p/qom_object_interfaces.c.o libq=
om.a.p/qom_qom-qobject.c.o libqom.a.p/qom_compat-properties.c.o libqom.a.p/=
target-info.c.o libqom.a.p/target-kconfig.c.o libsystem.a.p/accel_tcg_tcg-r=
untime.c.o libsystem.a.p/tcg_optimize.c.o libsystem.a.p/tcg_region.c.o libs=
ystem.a.p/tcg_tcg.c.o libsystem.a.p/tcg_tcg-common.c.o libsystem.a.p/tcg_tc=
g-op.c.o libsystem.a.p/tcg_tcg-op-vec.c.o libsystem.a.p/tcg_perf.c.o tests/=
unit/test-tcg-call-tl.p/test-tcg-call-tl.c.o tests/unit/test-tcg-call-tl.p/=
test-tcg-call-tl-stubs.c.o tests/unit/test-tcg-call-tl.p/.._.._page-vary-co=
mmon.c.o -Wl,--as-needed -Wl,--no-undefined -pie -fstack-protector-strong -=
Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a subprojects/libvhost=
-user/libvhost-user-glib.a subprojects/libvhost-user/libvhost-user.a -lnuma=
 /usr/lib64/liburing.so /usr/lib64/<a href=3D"http://libgio-2.0.so">libgio-=
2.0.so</a> /usr/lib64/<a href=3D"http://libgobject-2.0.so">libgobject-2.0.s=
o</a> /usr/lib64/<a href=3D"http://libglib-2.0.so">libglib-2.0.so</a> /usr/=
lib64/<a href=3D"http://libgmodule-2.0.so">libgmodule-2.0.so</a> -pthread /=
usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1.so /usr/lib64/libepoxy.so=
 -Wl,--end-group<br>&gt; =C2=A0 =C2=A0 /usr/bin/ld: libsystem.a.p/tcg_perf.=
c.o: in function `perf_report_code&#39;:<br>&gt; =C2=A0 =C2=A0 /work/armbru=
/qemu/bld/../tcg/perf.c:328:(.text+0x5e9): undefined reference to `debuginf=
o_lock&#39;<br>&gt; =C2=A0 =C2=A0 /usr/bin/ld: /work/armbru/qemu/bld/../tcg=
/perf.c:341:(.text+0x66f): undefined reference to `debuginfo_query&#39;<br>=
&gt; =C2=A0 =C2=A0 /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:361:(.t=
ext+0xa91): undefined reference to `debuginfo_unlock&#39;<br>&gt; =C2=A0 =
=C2=A0 collect2: error: ld returned 1 exit status<br>&gt;<br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div>

--000000000000be74f0065c892f4d--

