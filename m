Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09772EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 04:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vow1S-0001xh-20; Sat, 07 Feb 2026 23:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vow1M-0001x5-Tk
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 23:03:41 -0500
Received: from mail-106117.protonmail.ch ([79.135.106.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vow1I-0007NK-7Z
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 23:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail3; t=1770523407; x=1770782607;
 bh=VOiPFD37AM/eSS6MMCpWnBkk6OxrDsnTEGVnbAv2Fik=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JtLsnWlsuU1WB74+dFC3Zz2rgwjWetLA1XgjAt7BbUh6sUKKQ3xMOOGtiG/+yVV6l
 ENB9w45NvXiNFGynfuUfU55zqFI+5dXP2KTpTSHNm/rsGtBfFiRVb27a4IELSs8CWl
 4gXT8rN814HqwCSnX76lqotya3xip2yTQDg9FfzLqJNE2IaoqNn7aorGr4p4sxZIFv
 s9RGAVwqm9F/wzYCO+FixBIHJBT5pHxwWtgei+mZ2K0Pw3D77uvV7/wC5d5joXjFh7
 /TSjt0QSBISUSdefR5LkoCY0UWhTTx1p73OCttVVnMlsBWJMjWb3scsTeCknBSAUPm
 wj4f8Y6gVgKtw==
Date: Sun, 08 Feb 2026 04:03:21 +0000
To: Stefan Berger <stefanb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 peter.maydell@linaro.org, kwolf@redhat.com, berrange@redhat.com,
 eblake@redhat.com, bugaevc@gmail.com
Subject: Re: [PATCH v3 3/4 qemu] Exclude TPM ioctls definitions for the
 GNU/Hurd
Message-ID: <5d9dd511-117f-21a6-1e2e-eed22077aaa1@zamaudio.com>
In-Reply-To: <26b39a30-8ef0-4f68-af65-58a6718226a6@linux.ibm.com>
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-4-damien@zamaudio.com>
 <ac182e8e-cd4f-467b-b6a8-31f03b70b3b9@redhat.com>
 <26b39a30-8ef0-4f68-af65-58a6718226a6@linux.ibm.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: aac940b6ec738f1cfb4181eeb0f8e12b4ef1e5a8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.117; envelope-from=damien@zamaudio.com;
 helo=mail-106117.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Stefan,

On 2/4/26 2:21 AM, Stefan Berger wrote:
> So this file comes originally from swtpm here:
> https://github.com/stefanberger/swtpm/blob/master/include/swtpm/tpm_ioctl=
.h
>
> To keep them in sync as much as possible -- would this here work?
>
> #ifndef _WIN32
> #include <sys/uio.h>
> #include <sys/ioctl.h>
> #endif
>
> #ifdef HAVE_SYS_IOCCOM_H
> #include <sys/ioccom.h>
> #endif
>
> #ifdef __gnu_hurd__
> #include <mach/x86_64/ioccom.h>
> #endif
>
> and then keep this as-is?
>
> #if !defined(_WIN32)
> enum {
>       PTM_GET_CAPABILITY     =3D _IOR('P', 0, ptm_cap),
>       PTM_INIT               =3D _IOWR('P', 1, ptm_init),
>       PTM_SHUTDOWN           =3D _IOR('P', 2, ptm_res),

No, this wont work because the _IOT__IOTBASE_* symbols are missing for=20
the tpm structs on GNU platform:

In file included from /usr/include/x86_64-gnu/sys/ioctl.h:26,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ../backends/tpm/tpm_ioctl.h:17,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ../backends/tpm/tpm_emulator.c:39:
../backends/tpm/tpm_ioctl.h:290:30: error: =E2=80=98_IOT__IOTBASE_ptm_cap=
=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 290 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_GET_CAPABILITY=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D _IOR('P', 0, ptm_cap),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
../backends/tpm/tpm_ioctl.h:291:30: error: =E2=80=98_IOT__IOTBASE_ptm_init=
=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 291 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_INIT=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D _IOWR('P',=
 1, ptm_init),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:292:30: error: =E2=80=98_IOT__IOTBASE_ptm_res=
=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 292 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_SHUTDOWN=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D _IOR('P', 2, ptm_res),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
../backends/tpm/tpm_ioctl.h:293:30: error: =E2=80=98_IOT__IOTBASE_ptm_est=
=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 293 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_GET_TPMESTABLISHED =3D _IOR('P', =
3, ptm_est),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
../backends/tpm/tpm_ioctl.h:294:30: error: =E2=80=98_IOT__IOTBASE_ptm_loc=
=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 294 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_SET_LOCALITY=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D _IOWR('P', 4, ptm_loc),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:296:30: error: =E2=80=98_IOT__IOTBASE_ptm_hdata=
=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 296 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_HASH_DATA=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D _IOWR('P', 6, ptm_hdata),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:300:32: error: =E2=80=98_IOT__IOTBASE_ptm_reset=
_est=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 300 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_RESET_TPMESTABLISHED =3D _IOWR('P=
', 10, ptm_reset_est),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:301:30: error: =E2=80=98_IOT__IOTBASE_ptm_getst=
ate=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 301 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_GET_STATEBLOB=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D _IOWR('P', 11, ptm_getstate),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:302:30: error: =E2=80=98_IOT__IOTBASE_ptm_setst=
ate=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 302 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_SET_STATEBLOB=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D _IOWR('P', 12, ptm_setstate),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:304:30: error: =E2=80=98_IOT__IOTBASE_ptm_getco=
nfig=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 304 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_GET_CONFIG=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D _IOR('P', 14, ptm_getconfig),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
../backends/tpm/tpm_ioctl.h:306:30: error:=20
=E2=80=98_IOT__IOTBASE_ptm_setbuffersize=E2=80=99 undeclared here (not in a=
 function)
 =C2=A0 306 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_SET_BUFFERSIZE=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D _IOWR('P', 16, ptm_setbuffersize),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:307:30: error: =E2=80=98_IOT__IOTBASE_ptm_getin=
fo=E2=80=99=20
undeclared here (not in a function)
 =C2=A0 307 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_GET_INFO=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D _IOWR('P', 17, ptm_getinfo),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~
../backends/tpm/tpm_ioctl.h:308:30: error:=20
=E2=80=98_IOT__IOTBASE_ptm_lockstorage=E2=80=99 undeclared here (not in a f=
unction)
 =C2=A0 308 |=C2=A0=C2=A0=C2=A0=C2=A0 PTM_LOCK_STORAGE=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D _IOWR('P', 18, ptm_lockstorage),

If you want to preserve the enum, I am happy to put an ifdef instead of=20
removing it.

That would be exactly what we had in v3 3/4.

Damien



