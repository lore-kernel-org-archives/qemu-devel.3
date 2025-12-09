Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02415D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 04:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSpek-0003sj-H0; Mon, 08 Dec 2025 23:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.qgyztwionhte0d5=5kcu62m7tkzb=gxl3a4lq8kukr8@em483429.turing.llc>)
 id 1vSpei-0003sO-Ku
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 23:48:56 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.qgyztwionhte0d5=5kcu62m7tkzb=gxl3a4lq8kukr8@em483429.turing.llc>)
 id 1vSpea-0002Ch-Qm
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 23:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turing.llc;
 i=@turing.llc; q=dns/txt; s=s483429; t=1765255712; h=from : subject :
 to : message-id : date;
 bh=r8rGopfBw6bwJy23KqsbmOwKGLXJuHKMEv8Nxq99UH0=;
 b=Ih8nIwGIMunIUM2QpQLdB/LRalnyHyHBbnVnNW4XMU5OK8tw3BIGQOqff7/d8Bk/6YlwP
 /cIrzqDdz/0Io/Yw3qE16X2q69YPmQ0Qy5/GNotHIsmLBVY5BA1wJkrJ2MLtBZMbiI5tjUf
 lUF7dEEL5nLHqZfbJtNJnJjFkxHTN70qDEuAV5A8EPUFl1St/9fEAGP6WfeI/1HUMy8mY2o
 N6RrQfA9t89BmW59HxvMGsUq1HkHDR2NtQMmPz7crEPSTxIMqwNkDB2kkWwlfvHKHZhDuKf
 Dg3RrwrgxI6s2UfkpWcInLqPBJst+OwpOqO3TZPs9MbDdMWmA3d/0YZhf2Aw==
Received: from [10.159.238.187] (helo=mail-ed1-f53.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <osy@turing.llc>)
 id 1vSpeI-FnQW0hPuZhd-HrIz for qemu-devel@nongnu.org;
 Tue, 09 Dec 2025 04:48:30 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-647a3bca834so6700078a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 20:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV56E6dJvjbVdnz8v5fxrmKD3jfmr2k2eeFLgxpFQi5u2WW4Mm0dhPNifibhayvA/nWBoJlPeXQ3WjJ@nongnu.org
X-Gm-Message-State: AOJu0YzXYlcwzrnKqUrqphU9U/XJA4+MkCRPxc6gIkpagJxp6T6YLkLs
 A0WMFBdPj+AKB65FIBpjpaBXb7YfFZnrerFbyG79EwwNg+yP2RUA+rOkvBYOL5vl7a2Cf1EvQGU
 Litll4p9ihMHE9vnb7LFXnOUYNJ09ztc=
X-Google-Smtp-Source: AGHT+IExPtGph5JgSBOK7fTmMQ6mGMJ690P/V1G3eZMJCzlAD8HkiiZY2Y3r5asH5eeIQYjYEt6da3T/mBDiywvpcdI=
X-Received: by 2002:a05:6402:5343:10b0:649:296a:62b7 with SMTP id
 4fb4d7f45d1cf-649296a6310mr5300171a12.29.1765255709462; Mon, 08 Dec 2025
 20:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
 <20251205151115.2035930-3-alex.bennee@linaro.org>
 <ff000682-b14d-4152-88b3-cb2761b60bc1@linux.dev>
 <87zf7shped.fsf@draig.linaro.org>
 <0c2f64fa-a635-4593-8631-12a40af4a79b@linux.dev>
In-Reply-To: <0c2f64fa-a635-4593-8631-12a40af4a79b@linux.dev>
From: osy <osy@turing.llc>
Date: Mon, 8 Dec 2025 20:48:17 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCRmFGeMBYH-hzRb40DMJR78rVFDcBnOtLR-zJjouUXoA@mail.gmail.com>
X-Gm-Features: AQt7F2ruaS7DqZo7bkDs1u0G6uoCrW8rqyJ0LYut7us9fHTm33Jft4iN9QGSz1I
Message-ID: <CA+E+eSCRmFGeMBYH-hzRb40DMJR78rVFDcBnOtLR-zJjouUXoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: ensure PSCI register updates are flushed
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sXWb4exm9p
X-smtpcorp-track: bGlVr2IR9SPD.h8XUeeURGsZP.m_zKOwog0At
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.qgyztwionhte0d5=5kcu62m7tkzb=gxl3a4lq8kukr8@em483429.turing.llc;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Tested-by: Joelle van Dyne <j@getutm.app>

(With HV_EXIT_REASON_CANCELED change, otherwise it hangs on shutdown)

On Mon, Dec 8, 2025 at 4:56=E2=80=AFPM Zenghui Yu <zenghui.yu@linux.dev> wr=
ote:
>
> On 2025/12/9 01:08, Alex Benn=C3=A9e wrote:
> > Zenghui Yu <zenghui.yu@linux.dev> writes:
> >
> > > Hi Alex,
> > >
> > > On 2025/12/5 23:11, Alex Benn=C3=A9e wrote:
> > > > When we handle a host call we report state back to the caller via
> > > > registers. Set vcpu_dirty to indicate QEMU is currently the referen=
ce
> > > > and hoist the flush_cpu_state() and make the call unconditional.
> > > >
> > > > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3228
> > > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > >
> > > This fixes the guest boot issue.
> > >
> > > However I notice that some (all?) HMP commands (e.g., "info registers=
")
> > > don't return and result in guest hang. Haven't dig further though.
> >
> > Does this fix it:
> >
> > --8<---------------cut here---------------start------------->8---
> > target/arm: make HV_EXIT_REASON_CANCELED leave main loop
> >
> > Without this we can spin tightly in the main HVF dispatch loop and
> > never release the lock long enough.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > 1 file changed, 1 insertion(+)
> > =EE=98=9E target/arm/hvf/hvf.c | 1 +
> >
> > modified   =EE=98=9E target/arm/hvf/hvf.c
> > @@ -2020,6 +2020,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vc=
pu_exit_t *exit)
> >          break;
> >      case HV_EXIT_REASON_CANCELED:
> >          /* we got kicked, no exit to process */
> > +        ret =3D -1;
> >          break;
> >      default:
> >          g_assert_not_reached();
> > --8<---------------cut here---------------end--------------->8---
>
> Yes it works. Please feel free to add
>
> Tested-by: Zenghui Yu <zenghui.yu@linux.dev>
>
> on it and patch #2. Thanks for the fixes!
>
> Zenghui
>

