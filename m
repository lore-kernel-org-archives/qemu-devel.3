Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B05CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcLp-0000fE-NT; Mon, 08 Jun 2026 11:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4619146f5c=eblot@meta.com>)
 id 1wWcLk-0000dl-5d
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:57:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4619146f5c=eblot@meta.com>)
 id 1wWcLi-0003es-7l
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:57:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6584tGNr1801232
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 08:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Q//KCy9ZYyS88KKtoOHjSbcBqO4n89RNi3ouB80cUP0=; b=ImPAgJOxCAoi
 xdqXumv3LvslNwXcsfaBme+u1kcFQ7tVlSi29cyE1TAAcGvlpK8piEJWKW2cbf3N
 8aDdnCSpYLtWaEunbDY+38V3Oyv2oqqiuVziwPXwatlTD4B17Q1gFHC4Hp31oVJE
 ew9o+TkLDFFqTvCiMHvaxrn0mnTBe+OWzRMN/0qFR5iCajrgBcTfQejfbMv9aaQd
 qRsjzCB+xC2z+HXH/sUu7MOkgCjtrDapff2mKEqBNVkLwO7s2Dsp3TbE6BiBePLS
 6/rAmzrWWyGOXhwPbldgjxVpRtJRVqMI5veOq1btHQoAeXehTGakpwBf+Uip+DCS
 uOBZuKSpwA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4emh2d1fgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:57:12 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so3355154a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934232; cv=none;
 d=google.com; s=arc-20240605;
 b=NFpRKhg6RNp1jGy+MfmvB1ab3sGLsIzpQQeKeHpNuq8HwzyLO33bOmPIGmvaLgZyf5
 bXFFALiuCwg/bXvNrb9AUKgag/glfx8dosYfvByrMFBrquvPJ9FSlRqVik2o97loQpXX
 aPTY8zbsIppkIlQ7E7whqE5XQ62Dz2RwSdCKQtsrFIa7TNGGd986uFUQa+eyMqArGefx
 W67ekClPelU+FqrCCd+g3ioGwxhuF2gpgARUqczepegu186/sc+mwI2zUd3pz7hZo10X
 s9uarXGoP8Wi6FAOGQQsMxdsTXv0a96JpbdTWcJCozPxjb1peM/UkYF8TE1Fv1v4OXSD
 St9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=wXrkZmRW8q6ev0lbC6075XkH3sRIIk4ZCvhPKBsOLC8=;
 fh=Wpp3Am9pj4kZdbyFL5poOWciMtDhgAwXiZUQ6qxZVsQ=;
 b=UZtl9WSOIr4TOm2wOA+wKilg+0P7S8QOjtXuxWIKxhiZiF1AmS/OMA7r8ZlTSZ5E+m
 8dYAH0dfXlCtcnXm5b12BISXXsgkGu6cFFJS1u8+VXnczCqQGqnV28iN5m3E64g8txDE
 ig1b5IldHCqKZZ9W6L1z6fj1Mr4Ksmyiztxyh59yir6/R0Z9QYzrbFkwmj8Tq1EbBwmx
 HM8X+JkbGlhyInIFrDfdUY4IU0P7Ec3arwTDjjdswyWwNf/qCSM4TPsAAYki+kj9fSay
 C+0jnF6acSo4wzkyLjMoR1FZC3JuIb/C0zt3mPSPfuSzmbV86eLcUrbc6e+HEmzw0BWY
 Li4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934232; x=1781539032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wXrkZmRW8q6ev0lbC6075XkH3sRIIk4ZCvhPKBsOLC8=;
 b=BHBsAZlnfLyF9pcOO7gZZ9cawJq/oqmC1oSZeKevu+xnkfQL/NnGa2A4s1W2E5ZHHL
 xLO0z9K+HHNxUckBANm1uPk8ZWFtBOlsPlz+CEEBaqJXY5is03qdRP0GYEd8H2t5OvyM
 N5cxnW51FqD0Ozb4KHTGVlksaZG0AjoEYNMItiXKGbuslj4uTSlwekQWg3kztKYAFVJi
 RX0vKkKdvw66a6JhgchZSL5TmAhfpI9G9QQG5sW5UoOk5xNkkgbeKkZZPcnCZiGe40/N
 b/Z5bXuNNj8+oR3qv18V9W3Vhjv1MUms2mpCpts5x4td7uhUTH/h1BccA5a1zeyUApno
 fQrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97QkjcGl9ONWQ0LkdZ+cA/0KuQfJmFurpA3ibEMNdIG3ma0fINPvkblIF2qnW4cHUV0yqog8xjwOtF@nongnu.org
X-Gm-Message-State: AOJu0Yy/4YOdKLkVUJ4c9+g8Sk5hJ6DsD7wxv7gIcaMHpbKTGcUwGSIu
 RahExCtE4/ufdjhgC7V6joobGBW/M/EKp1dy2YWW2/s0vTsr8UIDKwmDmPYbBvw/2u93/ZPUOe3
 MNjMEtRn+eUqNsZS2RHX7sWHSoosRbDYAoet/7EYQNfh8favZ1xAHY1zAyF0zN0iYMJo8dn+EV9
 WKEPI366wbHmA3GX4NyHDjFNEcwQMl
X-Gm-Gg: Acq92OErA3uQM8B5FYn2kVVBM56A3v2fAlnELPYh50BCCLD2AdmGc7wu7ETRnrkpr/X
 KmhusFL4aHY/FzJm6BzaAreU/mY8FBVUVSQ/bEz+IIqb9y8fSowWURKdB1NKatEI4R0WujqqfMo
 9A+DpBNkaC0dvsOfjpteD+Eh0Oey3CR1rQZb0ignjZqvZRAUvsZyho6vlpvMJ8ojyc6+yp7x0PB
 7Gynw5BIwySIfhHqSx12eY6zk1C300=
X-Received: by 2002:a17:90b:548e:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-370f0b55fbemr16344735a91.20.1780934231818; 
 Mon, 08 Jun 2026 08:57:11 -0700 (PDT)
X-Received: by 2002:a17:90b:548e:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-370f0b55fbemr16344698a91.20.1780934231290; Mon, 08 Jun 2026
 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
 <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
 <aibhMPHu6nbBT3Yi@redhat.com>
 <CAFEAcA98r4DxQbB+yiWKqnTGSzps+GGQ3gxFPLogBGTXY77jXQ@mail.gmail.com>
In-Reply-To: <CAFEAcA98r4DxQbB+yiWKqnTGSzps+GGQ3gxFPLogBGTXY77jXQ@mail.gmail.com>
From: Emmanuel Blot <eblot@meta.com>
Date: Mon, 8 Jun 2026 17:56:59 +0200
X-Gm-Features: AVVi8CcRcIdTsKX7hX3mDDzgjeXa6tihGnDab3I3IwFPPh19pPLMtJKvnovk-cs
Message-ID: <CAMdbysh2-mjxmWZcfDw53UbJd0keBtTgO_gnGc6pPMzv3GOPDw@mail.gmail.com>
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _eDf7Zi3uIGGxqS08_jpfDnbgI3td4WJ
X-Proofpoint-ORIG-GUID: _eDf7Zi3uIGGxqS08_jpfDnbgI3td4WJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1MiBTYWx0ZWRfXy+K2eKcMPptm
 qfG4ugdM+jFBaM53DLcsggQBYLWPSsIuPtMfaQyvmE8Dc6kbGAaFi0yDdNWS2G06XVODfOKK/3T
 4L8U9WJ2ByZD220exVKQ1lVbBUuM46wDJfx8abW6qs8klIi/95j7sPEDZMmvbEzU7p5h5x/HpHi
 3/KRP1Gjy3qXM3izYSjmy3iy4EwMsR/g5oKPBgTnENvddgjsEa5bDGZ9N9pLLtyrdtMspBBeAzD
 lKfuAoi8gfeYD+/zmUjqVEO1ZOf7kLmH4x8srv54yfA3YiQjDMUIuCqkCUiAkSiAEd3NBNYwmd6
 qNfyAGsFt3XFO7/RciRF9buoqF+5wkGgT8UPVD4Kyv41iZVSX2eJoh1LgPt7k+jCjAP/LzoZsBm
 z5bQbT9kP0eMo4oBPaZJnG/K9DinrFS5pmhgAOuKeiljufIyBtPZDQwO5biU6O9wCQVZPqVW5uh
 CdatZrSyJbf5dG4kmPw==
X-Authority-Analysis: v=2.4 cv=FY0HAp+6 c=1 sm=1 tr=0 ts=6a26e658 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=ysZfgnxKZJDchDpiqNcA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=4619146f5c=eblot@meta.com; helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ok thanks, got it.

I need to use `ninja -C build qemy-system-arm` to generate the signed
binary, because the default target only generates the `-unsigned`
version (I guess this is the linker's default output, macOS requires
an extra signing step).
The signed version is defined as an on-demand command which is not
part of the default build (`all`).


On Mon, Jun 8, 2026 at 5:38=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> >
> On Mon, 8 Jun 2026 at 16:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >
> > On Mon, Jun 08, 2026 at 04:29:47PM +0100, Peter Maydell wrote:
> > > On Mon, 8 Jun 2026 at 16:25, Emmanuel Blot <eblot@meta.com> wrote:
> > > >
> > > > On macOS, plain QEMU binaries are named qemu-system-<arch>-unsigned.
> > > >
> > > > In libqtest, qtest_get_arch() extracts the architecture by splitting
> > > > after "-system-", which yields "arm-unsigned" instead of "arm".  Th=
is
> > > > prevents the QOS graph from matching any machine node, causing all
> > > > QOS-based tests to be silently skipped.
> > > >
> > > > In the functional test framework, the same suffix causes the arch to
> > > > be parsed as "unsigned", leading to wrong output directories and
> > > > teardown failures.
> > > >
> > > > Strip the "-unsigned" suffix on both code paths.
> > > >
> > > > Signed-off-by: Emmanuel Blot <eblot@meta.com>
> > > > ---
> > > > Address issues with liqtest and functional test framework when run =
from
> > > > a macOS host.
> > > >
> > > > Unsigned binaries on macOS may be appended an `-unsigned` suffix, w=
hich
> > > > confuse these components that rely on the binary name to recover the
> > > > guest architecture.
> > >
> > > I still think this not the right thing to do. The "make" process
> > > on macos should produce and sign the binary in-place in the
> > > build tree, so that users and test cases don't have to care
> > > about this macos specific weirdness. (If the signing is
> > > location-specific and we need to sign again for "make install"
> > > that's fine. But we should produce a working binary with the
> > > usual name in the build tree, not a non-working one or one with a
> > > nonstandard name.)
> >
> > Yes, I was just about to write similar when I saw your message.
> > We should not have this custom "-unsigned" name  in the build
> > tree as specialcases like this break too many expectations,
> > especially when most devs aren't ever testing for macOS and so
> > won't see the special case.
>
> I think it's OK to have the -unsigned binary as an interim step,
> where we compile to qemu-foo-unsigned and then immediately sign
> to produce qemu-foo. The problem is that "make" is for some reason
> not actually doing the signing step. Alex notes in that other
> thread that you can make it do the signing part by manually
> running "make qemu-system-aarch64". We just don't have this
> working correctly so that "make all" does it.
>
> -- PMM

