Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F2DCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 11:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOOw-0007Ds-Bb; Fri, 22 May 2026 07:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wQOOt-0007DT-Ec
 for qemu-devel@nongnu.org; Fri, 22 May 2026 07:50:48 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wQOOq-0005C2-0O
 for qemu-devel@nongnu.org; Fri, 22 May 2026 07:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1779450636; x=1779709836;
 bh=h2gAU1E6xgxowMI4sHjZqiWrfArhknfbZMatAninrXs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Vd8KlEEjWTN99ynzh4FqcXwiYhWg7EbLw5PMxcGLP8FwMrjF/UNwlom2w5+1qd6Ub
 gJfIoZ34ncl70Jjy9LAKSEq/GzhwbCsbPSqH3FJErpAcdz3DiAL0nuIkTI/mWzYziX
 7noO0Z4nAqr0D3LCh7QkJXfpNXUcWKi8I0vHgV/EBMFMTWMIHwAn0hq/P2WxwrAetD
 xhJa68OTkib7zjnu2ypVvVjjS0Khk/2hAAlREJN/MiF9nb+ajf14HEz+L/zMxSWYoZ
 MsKQPQdAGs6M1DewIKcwCWK+eAC9vdudF2v++tnw7BGMdOdJk8WCF7ZaX8emNVP1Q7
 qW9nIHKoyQzwg==
Date: Fri, 22 May 2026 11:50:31 +0000
To: Amit Machhiwal <amachhiw@linux.ibm.com>
From: Matthew Penney <matt@matthewpenney.net>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 1/1] tests/qtest: fix discarded const qualifier warning
Message-ID: <V1VlxqiLrL0xjvmwFVM9QmR5sNRhsM13hnXRQXS-NIq0SqtG0frvkF6NLgDY_vSshA1Xj6Q5l4kIyeMN_m7PnNeFBk5rig6dx1lRwhN7piA=@matthewpenney.net>
In-Reply-To: <20260522135219.6cff4e3e-78-amachhiw@linux.ibm.com>
References: <20260518155344.5945-1-farosas@suse.de>
 <20260518155344.5945-2-farosas@suse.de>
 <20260522135219.6cff4e3e-78-amachhiw@linux.ibm.com>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 062212a9160987e2602eab60346f03c06e7b9e50
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=matt@matthewpenney.net; helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Amit,

Thanks for the follow-up and for working on a more complete solution.

Your approach using g_getenv() and g_strstr_len() makes sense regarding
consistency with GLib/QEMU conventions and avoiding future issues with stri=
cter
compilers.

I appreciate the note and the rebase on top of my merged commit!

Regards,
Matthew

On Friday, 22 May 2026 at 09:27, Amit Machhiwal <amachhiw@linux.ibm.com> wr=
ote:

> Hi Matthew,
>=20
> Thank you for addressing the const qualifier warning in qtest_verbose(). =
Your
> fix correctly resolves the immediate compilation issue with modern compil=
ers.
>=20
> I had independently worked on this same issue and submitted a similar fix=
 as
> part of a patch series:
>=20
>   https://lore.kernel.org/all/20260518172517.12466-3-amachhiw@linux.ibm.c=
om/
>=20
> While both our approaches fix the immediate strstr() warning by making 'f=
ound'
> const, I noticed that getenv() still returns char * despite environment s=
trings
> being semantically read-only. This creates a subtle const-correctness gap=
 that
> stricter compilers (like GCC 16) may flag in the future.
>=20
> I've prepared an improved v2 patch [2] that builds upon your merged fix b=
y using
> g_getenv() and g_strstr_len() to maintain const correctness throughout. T=
his
> approach:
>=20
> - Uses g_getenv() which returns const gchar *, matching the read-only sem=
antics
>   of environment variables
> - Employs g_strstr_len() for consistent use of GLib string functions, ali=
gning
>   with QEMU conventions
> - Eliminates all const-correctness warnings with strict compilers The v2 =
patch
>   supersedes my earlier attempt and is rebased on top of your merged comm=
it
>   (e68da5b7a2cd).
>=20
> Thanks again for the quick fix!
>=20
> [1] https://lore.kernel.org/all/20260518172517.12466-3-amachhiw@linux.ibm=
.com/
> [2] https://lore.kernel.org/all/20260522082555.54918-1-amachhiw@linux.ibm=
.com/
>=20
> Regards,
> Amit
>=20
> On 2026/05/18 12:53 PM, Fabiano Rosas wrote:
> > From: Matthew Penney <matt@matthewpenney.net>
> >
> > Modern compilers warn that the result of strstr() may discard
> > const qualifiers when assigned to a non-const pointer.
> >
> > Make 'found' a const char * to fix the warning.
> >
> > Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Tested-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  tests/qtest/libqtest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> > index bf9284b9a1..b1e06ea364 100644
> > --- a/tests/qtest/libqtest.c
> > +++ b/tests/qtest/libqtest.c
> > @@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, uns=
igned size_mb)
> >  bool qtest_verbose(const char *domain)
> >  {
> >      const char *log =3D getenv("QTEST_LOG");
> > -    char *found;
> > +    const char *found;
> >
> >      assert(domain);
> >
> > --
> > 2.51.0
> >
> >
> 

