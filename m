Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A3606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OI5TfxnZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNTZh-00085O-Tv; Sun, 01 Nov 2026 06:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNTZg-00084Y-25
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 06:18:08 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNTZd-0006HH-SX
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 06:18:07 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ab43af5e97so22618677b3.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 03:18:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793531884; cv=none;
 d=google.com; s=arc-20260327;
 b=lhednqTQv4nI8DKHlodXVJ9wfrsvlIY89Go0Akg/hqkPGk+RMADt94MQnzdYgevptY
 kWL7O9/2iMEMwezeDwXSOThKNpegZNgooL98DdqfYm7mUub8t0g1AjkemH3Cie92SNCY
 7IRAfJwX2PxegUb2Qzc07QyJBM5lvO0Xg9ZrNjOIeJPd9yUGP36Cvv6P76tGx2T/hDhf
 qLspjM9WEqgq8DQJmfIpMYLNa7m0+LLJetKob9ZlK+y+6c/qz4tWzipLi6AZcOnnmI0O
 OTcRIMpU1fj1cd7lGQjt/GhjXZjpqqkmFUn1GZIjQ8fckxn+TulYNnFfLV8zUALgM/PK
 jHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Iz2aB3fbR7pTJKdioeDsQd7zU+F7Y1nK34xOfdODwoA=;
 fh=9poLHRP5IP2SM/po373n9NwnHrSTo4hQPXNHYKtHtfg=;
 b=ietHGD8EyF09Qe3EOQwUBPqWaz9ZPDV1om8aOBUI0FO6X/YR7u3eEKzjLQ+2DzjvLM
 A/6OJfYD4iMPC3T2GkN9OcvgeO9kaje3O7OkK4rOAKUgWta448eMHSSL9JIey5lvklCQ
 7oJFAYxA/IK+4QU4ZBnF+vQJmvHlZdIeG/kMC4FKB58qUgPQj1pBPk4GpGtpspAuk/73
 VgvgLP06B5DHpNK3nicwlTdHqef7thn/ZWEQd02uSRAMr1HicPjlaUSkulMyKHNnBA/B
 aEX2lUU26FxkEeSrFdygyQjM4eYSI0MipJRiN/DoLphXzzRml+AhOk0X1xKlgbmRhIfe
 Dh6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793531884; x=1794136684; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Iz2aB3fbR7pTJKdioeDsQd7zU+F7Y1nK34xOfdODwoA=;
 b=OI5TfxnZzH8rzoxuXsvP7COG1jkgSE8GvgMWVx6uP3dwFqYuCus0n5pJY9JhQiQ9xZ
 clCg/D9SXWUnaUOL0UaIfqoI/L3p3OmwkFaUMdHTFp6UaTRKGUuGlZh4Md5Dc9mh/Kqe
 yx0WZ11dPekstOm2wbnoAdA3i1cC1OeOVNOfLdy1NnTKLZ8LNb63dJOMn9SfTZ+snSdT
 gTo7qWCYuOH2jJHEPieA5fvtsgY1Oep+jZ9XJpkU9/8q2nb59frmiqqJ/nxU/d+glW3C
 vRn0+A/h2haJatTzcpLQu96Re60rOYtxEbt/EyGhdlPxMl1VdnLDriZa/oWMdi6HB8Jo
 XtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793531884; x=1794136684;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Iz2aB3fbR7pTJKdioeDsQd7zU+F7Y1nK34xOfdODwoA=;
 b=yWCJ7JcWZCGXFyWx5D3vBXCcCnv//ek8JwZp+c/QF8eqP/cvZYDWpS5hf4fR380ufv
 3gd0YuqjwmPbtlbCGECXwWS7AfReGhB9Y9JDQNgO6H7RP8S1v+ulQWF5yjRvSUMvpjm5
 sWWv3QFXuDQBG3mqe4Ojm/OEl/YrLuRa8JRLRYGyIRPFRN/vdvH9P8AkPnSuW9RdxOfY
 i5Jg1R0CYsdTSPD9PQuTunjh0VnwfNLKMb8/jyuVOZD/Pp47f1OT88xifCJ+BUiwi8CY
 ZTSPtj8rh4khBNqmPjQ7KLcCcgaEBECfckkmNgFR+BYpS/WV8J/vEMhPB8gCWekdaTC3
 4Tjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZoki8oU7MRt4qUWCH2KxDGLOUgdeuGjANMOUp1DwADVlSuAhZ7lOx6VfFDHfBbHC/Qi+QpHtBOczS@nongnu.org
X-Gm-Message-State: APuU4Z+7RFKY2PCsST2oDhYomwgtXFdp40s0kYpE9dS4oj98CMMOFp+y
 Xha6+MHeBKTB2w7mh+e36acJEsaiaAvsFbqbtUQ33AYM8TXpHBDJaZHgv244vsh6GDisTgso67f
 1XmShT2WL08Tlxq4l7H7VF3wjhthSDB5YKSONLVb4aQ==
X-Gm-Gg: AYBFou3QioL0gwIQjo1Ufmuu8Vv8OrTig4bNkS4LUFXfGoWH68x3wafOGsRufx7ggZM
 /2Kjwh9PCvK61Sj7wBsVI4WpEjWuKCLBh5zbLD+lY9PBxd5jSj4RDIVDd2K24H3bsi/cgjgrfaK
 WJ811S+4TbJAEYJusXldOxg/gMkOD/JX+iwDklZFuQb3X+Ah14CdHJB2cNfik4mRFV8hz9RJj6S
 2GcCuvvRhrTeO+dPdyjwmgmxd/ZbZHFhefHOOatnY6d6QRPgmpvc1Bgj6y4VSrZ8vfMh6wKXk0u
 zEQkDW0v11x72LsqU/prQhtCKhT/RrJ5uLygvvcgSeU9NpzqJqPdHImTXiLmt4VDnsohJMCv2rw
 c/yog0R8nUEN7STNt3wsa9qduvK/fOLHU3God7gk/u8jXeaKCNrG5Gjc6rdcLo5j8yNMX1n8Au+
 M5Ec3tM4Bl3BwAhdCNubP0
X-Received: by 2002:a05:690c:c:b0:8a9:9f40:24b4 with SMTP id
 00721157ae682-8b2b6720e21mr52862257b3.15.1793531883783; Sun, 01 Nov 2026
 03:18:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793207602.git.mst@redhat.com>
 <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
 <CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com>
 <fe0694c6-383b-4cf2-abc0-c6d73a3d6c3c@tls.msk.ru>
 <20261030091030-mutt-send-email-mst@kernel.org>
 <CANukVxup5pBM=33-S8pN8ADioLkqg3fWUm=6piXow7a0+WPT7w@mail.gmail.com>
In-Reply-To: <CANukVxup5pBM=33-S8pN8ADioLkqg3fWUm=6piXow7a0+WPT7w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2026 11:17:52 +0000
X-Gm-Features: AclHuK_m0s78F-eoyeNo5WO0KbXRdsRa-9Ny2l_5fg60am6sgZuPc5vwcemx-Qc
Message-ID: <CAFEAcA-ncDKy-VooKJY1OzTYkd1SriaYKZNkkWWK3cAP6g-M9w@mail.gmail.com>
Subject: Re: [PULL 40/78] pcie_sriov: register user created virtual function
 before realizing it
To: Daniel Paziyski <danielpaziyski@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 18:47, Daniel Paziyski <danielpaziyski@gmail.com> wrote:
>
> On Fri, 30 Oct 2026 at 14:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Oct 30, 2026 at 09:28:50AM +0300, Michael Tokarev wrote:
> > > On 10/28/26 20:34, Daniel Paziyski wrote:
> > > > Hello Michael,
> > > >
> > > > I think you have queued this patch for pulling on accident. There is a bug here,
> > > > which is yet to be solved, as you have pointed out in
> > > >
> > > > https://lore.kernel.org/qemu-devel/20261028074508-mutt-send-email-mst@kernel.org/T/#mca344ac148a62107cdc298e97e6713b6657b5c55
> > > >
> > > > Please, hold off this patch for a while, until I come up with a fix soon.
> > > Am I right this buggy version of the patch has just landed in the master branch,
> > > instead of the fixed v2 one?
> > >
> > > Here's the difference between what's in current master and the v2:
> > >
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index d4187293b1f..6242204a52c 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -2310,10 +2310,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > >          pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
> > >      }
> > >
> > > -    pci_dev = do_pci_register_device(pci_dev,
> > > -                                     object_get_typename(OBJECT(qdev)),
> > > -                                     pci_dev->devfn, errp);
> > > -    if (pci_dev == NULL) {
> > > +    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
> > > +                                pci_dev->devfn, errp)) {
> > >          pci_unregister_acpi_index(pci_dev);
> > >          return;
> > >      }
> > > @@ -2332,6 +2330,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > >          }
> > >      }
> > >
> > > +    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
> > > +        pci_qdev_unrealize(DEVICE(pci_dev));
> > > +        return;
> > > +    }
> > > +
> > >      /*
> > >       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> > >       * associate only Device 0 with the device attached to the bus
> >
> >
> > Yes sorry, pls post a fix as a patch.
> >
>
> If you are referring to me, do you want me to make a v3 fixing master,
> or will you revert
> the patch in master and include the v2 (which is already in the lists)
> when you request pull?

Please send a patch which takes current master to the state it should
be in. We usually don't do revert-and-reapply unless it's a big obvious
failure where we're not yet sure of the fix.

(Coverity points out part of this error as CID 1689947, calling
pci_unregister_acpi_index() on a NULL pointer).

thanks
-- PMM

