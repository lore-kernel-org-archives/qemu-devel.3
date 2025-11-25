Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5ACFD36C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 02:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNipp-0007E3-ED; Mon, 24 Nov 2025 21:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vNipk-0007BK-6Q
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 21:31:12 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vNipg-0000f2-Kb
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 21:31:11 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-644f90587e5so780848a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 18:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764037865; x=1764642665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9Hd5xC5TpcQ8nQyidxQfQtxGk9PTragtZezbN/QNRY=;
 b=MeysVzagn1fGwckSwWyrihBNHvM2529DzsQ4rzip95U4Zd7SysMvszOiKZFtmtJJwm
 wW0Kfo/mPqXpaGsRP/ltyaMB5Nka9fNRya3W+mL00vnONf1haErAjfAvVIVFfZVLjbx8
 tnMJpNXF/VL3b/sH6+OTmdYobpXDSflzbsJAZ0Ni7cdK+tCnjq7DJ+6k+Z2DEDW8YPAz
 KkM971RPuoaa4ImFOS88HQPtksDFu7sMpj2TM8aDyKgJPpoHBwh8ZWlCJdZTIbs8uEXh
 mluBojo5tyhlSZqNBpdHoam/xlRdwTolXOCVbZsv2Qxp2A8RYwanOawiOuqOZ0CE01ea
 ujzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764037865; x=1764642665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R9Hd5xC5TpcQ8nQyidxQfQtxGk9PTragtZezbN/QNRY=;
 b=iLjs9Kwl1ap8jvLOoeYWx9+nW3LgkfkV4olN+P1wc6BSsz952dcMCpFge1K2/mIIGn
 xZrfhZpDI+kFKVZ1Q3QwZMSTPIOBEVPws3FUME4Sbp597zete06dgWPkEhv7iI+r6D4+
 InEWwtdCn8G5M9oHEoJEvZUfoIxOE5Nle9bOTuBJ7MM4DoylamAKve6dvgIuv4uJ1Khs
 +JJw5VfhdGK8F1JpkDcUCfYPSNdYkAZESb7wwxWx51O2mIszj8VUhacvEDgHKtG4u/or
 qTbujWlwCuJY7cMvaCGwwYBmOO/ZoTP8bhMvEcBhA9k80tLvuDLVry0Pyb7XDZ0roAev
 RjiA==
X-Gm-Message-State: AOJu0YyIO3r8Oi3qNuQWqq//GBwHAz4ct8HPQmspS4TgeFbe8kXKH6o0
 55l432Ewi9diq95DVPSvDDCeBU3JHP9tI9PLM5qDhtrNFkBBCoaF937ALuuwE7+DjSg22D0Ch5V
 QMuel7p053DLu/42jCSrPyi4Fmis0YHgMqNp/yE4r
X-Gm-Gg: ASbGncuNLTXdnUI/PA5BkufPloOIdbjLj9k/ZtGIVHcQQ+KbMSSbNxMxPrB5SM2r43S
 N+7GFkuRo6C7SHWiQWc3kQ049UxOdjpEbyPH2LVnCviHZBfiI3geugE2ulm0jdVFnXQZlXrMYNP
 YPiNP7+WmyBAVNHJn3BP2qvNTJMzbk1PSDeBPiE/b6XAHNv4nWzJ4NgCxAiU0tKbYlz8tRpRo/A
 Oi2xMwBi+ax3pIyW6HMOiAtG1+iPQBsjW2V5knva+nvObOWm0b9zRNEvy0cohdD2LqXFg==
X-Google-Smtp-Source: AGHT+IGLOwGqPGohtgPat6kASfjcRdnMhUw4YB67H436y3dRi6er6i7rIXAptj3zdUs68P0ELJTSwcD5gt3rvbvsYnw=
X-Received: by 2002:a05:6402:52cc:b0:640:7f9c:e90c with SMTP id
 4fb4d7f45d1cf-645eb2ab0eamr879060a12.27.1764037864546; Mon, 24 Nov 2025
 18:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20251008191936.3069950-1-navidem@google.com>
 <CAFEAcA_kaB5OeRw53Z1u_K4+oB_a6Mi4q-aaNeuOLXpTp-+0jw@mail.gmail.com>
In-Reply-To: <CAFEAcA_kaB5OeRw53Z1u_K4+oB_a6Mi4q-aaNeuOLXpTp-+0jw@mail.gmail.com>
From: Navid Emamdoost <navidem@google.com>
Date: Mon, 24 Nov 2025 18:30:52 -0800
X-Gm-Features: AWmQ_bkGrpgIZvahBhNormGFpoZUgHx24NoWciirybp0ib_LKEWs2n1kXbkNOdM
Message-ID: <CAGXevki+HpoXt=LhopwAQGyn4fnYJHer+GpLFr=mu5NsCXVrUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Zubin Mithra <zsm@google.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=navidem@google.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 6:03=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 8 Oct 2025 at 20:21, Navid Emamdoost <navidem@google.com> wrote:
> >
> > The qpci_iomap() function fails with a fatal g_assert(addr) if it
> > probes a PCI BAR that has a size of zero. This is expected behavior
> > for certain devices, like the Q35 PCI Host Bridge, which have valid but
> > unimplemented BARs.
> > This assertion blocks the creation of fuzz targets for complex machine
> > types that include these devices.
> > Make the check conditional on !CONFIG_FUZZ. In fuzzing builds, a
> > zero-sized BAR is now handled gracefully by returning an empty BAR
> > struct, allowing fuzzing to proceed. The original assertion is kept for
> > all other builds to maintain strict checking for qtest and production
> > environments.
> >
> > Signed-off-by: Navid Emamdoost <navidem@google.com>
> > ---
> >  tests/qtest/libqos/pci.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> > index a59197b992..df9e2a3993 100644
> > --- a/tests/qtest/libqos/pci.c
> > +++ b/tests/qtest/libqos/pci.c
> > @@ -541,6 +541,22 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uin=
t64_t *sizeptr)
> >          addr &=3D PCI_BASE_ADDRESS_MEM_MASK;
> >      }
> >
> > +#ifdef CONFIG_FUZZ
> > +    /*
> > +     * During fuzzing runs, an unimplemented BAR (addr=3D0) is not a f=
atal
> > +     * error. This occurs when probing devices like the Q35 host bridg=
e. We
> > +     * return gracefully to allow fuzzing to continue. In non-fuzzing =
builds,
> > +     * we retain the original g_assert() to catch unexpected behavior.
> > +     */
> > +    if (!addr) {
> > +        if (sizeptr) {
> > +            *sizeptr =3D 0;
> > +        }
> > +        memset(&bar, 0, sizeof(bar));
> > +        return bar;
> > +    }
> > +#endif
>
> Personally I think I'd prefer it if we didn't make this
> dependent on CONFIG_FUZZ. If BARs with no size are
> a valid thing then the libqos API should handle them
> (e.g. in theory one should be able to write a test that the
> Q35 host bridge provides the addr=3D0 BARs it is supposed to).
>
> I think if we added the size to the QPCIBar struct then we
> could assert in the accessors like qpci_io_readb() and
> friends that the offset provided was in range. That would
> catch both the unlikely "we implemented the BAR with no
> size" case and the rather more likely "we got the size too
> small" case (and also the "bug in the test and it got the
> offset too big" case), and would mean that we don't lose
> anything by not asserting that we have a non-zero-size BAR here.
>
> What do you think?
>
> thanks
> -- PMM

Hi Peter,

That's a much more elegant approach. Thank you for the suggestion!
I've done an initial investigation into the impact of adding a size
field to QPCIBar and checking it in the accessors. As you anticipated,
making the API safer immediately and correctly flushed out a few
latent issues in the existing qtest suite.
Before I prepare and send the full v2 patch series, I wanted to run my
plan for fixing the test failures by you:

- Issue with qpci_legacy_iomap: Several tests (like ide-test and
tco-test) fail because they use qpci_legacy_iomap, which has no way to
provide a BAR size. My plan is to change its signature to
qpci_legacy_iomap(dev, addr, size) and then update the handful of
failing call sites to provide the correct, explicit I/O region size.
This seems like the cleanest way to make them compatible and safer.

- Issue with nvme-test: The qos-test fails during the
nvmetest_oob_cmb_test because the test logic was performing an illegal
out-of-bounds access on the entire PCI BAR. My plan is to rewrite this
specific test to correctly read the CMB registers and perform a valid
out-of-bounds check within the BAR's limits, which is what the test
was originally intended to do.

Does this plan for handling the test failures seem correct to you? If
yes, I will go ahead and prepare the v2 series with the above fixes.

--=20
Thank you,
Navid.

