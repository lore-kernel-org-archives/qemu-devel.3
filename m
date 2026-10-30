Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F1606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb/regRW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrdD-0004pV-5l; Fri, 30 Oct 2026 14:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xMrd5-0004ng-Mg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:47:08 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xMrd3-0003xz-W5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:47:07 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-93f2a8cfd4fso20521485a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793386025; cv=none;
 d=google.com; s=arc-20260327;
 b=RqrmsK092TyeKL5oFi9sM5sTOh73zFo6tNZj35Iaur5Mili/cUCXVGdEIywYyeUfxL
 4eq+khT3Ln82LdW008GlHYj/fR32dR5RWFmUlpRRG4AfkbpERtwguMSz+qZpzxkI8DKm
 94ebXUKqxorArqust5074IFe2brozHPOFjNJq9GgPUGuNXNbK3yHhCRKsO3/qtu7qhJ5
 xwqUIBsjR2x+xMl6X5ixqDOsjPiJNDRu8k21dNcdStQTrIEX6T4R8cWMXmRXH888rFrn
 /STDdYMFWYYGNCSlVtawrf/EWNkz+Y5LQK3RSTgs6EEfjIZViwUwRvpzIGBinRzOYQNL
 MEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j4yh7nQRVb8uOL3VoGxI35GLKTnLJ3xEHrJnWbQiP9g=;
 fh=gOSx22aQXdrwULJpxwJD0N8CmiHKF2c5r9J8ThNfWr4=;
 b=LUh6iIKgK15aS0mwPX2Rf0myQn+/lyNvGHTn5uAn5fDitrPZqPvHQfoxgvcNbxNXPv
 Eoj1P06R+c8qfjInSZw7taD7rsZ7jPovEkmA+HCo6EY7Gccl4KGmKEaZEb97pCVCXscA
 Gjjcyw1Z1g1O/OUdOjyVgEMTPLg1nqqpT3+cw2kZyx9U73fE+D6G6OUy2XXX6zVPdVl2
 9OY3jUyd7Q5J/oPaJ66ZOzfQZKY6YskGV7hqtRJYMtzai80mdaiIwjgzJRRzQGje2HM8
 +c89+LXOzIIRpXRa+BuUe3zgCzma0PvnM04eeUC//CQXaSxK1uxDxX+LjTTGgbQ4QkYY
 k8Jw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793386025; x=1793990825; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j4yh7nQRVb8uOL3VoGxI35GLKTnLJ3xEHrJnWbQiP9g=;
 b=Mb/regRW78KIy96O003O27S5ciz72dUeI3WikZCgfBGNAskyQ8a6N4/rNYQo6bmNsY
 3XuxPEdVDx/GquC+cc4Mqi7kR/QhQrQe6Ku6B7vXKeDkU4uFPWV498uhgXF6T04N+PRN
 65x52/Pqp2WXyECooar0Uhzv/ksHY8Qh6mqTZ4O5f4BUvq9b0Qb7tKGcQFiIA4GBgI2N
 hoVsoBLfdhEeXjisa6T+I6no0bViaBH5+gPFJxhUJ+r+Q9+vpf88n/E9kLYfrq6MVvB9
 HhSAnN68eJPB1jsnRYqxjz2EplH6JmgpBsLL7kPdjlwgMBD5vRfEIlcmOe8XYiY667tB
 GyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386025; x=1793990825;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j4yh7nQRVb8uOL3VoGxI35GLKTnLJ3xEHrJnWbQiP9g=;
 b=yll1XfghzwxaA4PReK7UoIwhq/Ua6Go+NxV6NB23go0JzXMPNii4OrFLw1s3e8EkiX
 pbuZk1QS+NK6dZFvW1ve3rbOf5xcTNYnsSV+at5vIBzIlaFIEpF4A7S0Ph9z4SvNKNTB
 TTc7/SE346RlTg1pR78I0tBxidiUFl+pkMBT2r+tRmfa4GWw6TResLBhaFLKpyYoVl58
 t/mfGsChYXBdGZScoG4F8ihna+1EJBwC2KshJX6lAFx3tw6q0bu1kRVNx5Jc7t8udn+4
 b6OHrcvEZynA+Fdnp8cVAtXUh/TPQntT1a8QDBqXXlo0s8tIMAo3+cZqzlNco1x+BZuT
 E2lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4/BC97fc1Bse1A8k+xUeCZ7P/B3i27pUN1Csao+/5o0TSyFqkYYsWlq7xUogiwJCr1kW61vg/8Gb3@nongnu.org
X-Gm-Message-State: AFq9FYJ+YXoQcUy5FqPag+lkEbNWILKDWKTqs3KARK6oYFkFFb9KAylV
 NmSN8mTfmLhmcJshgY0qPqG1GaefSPAUpkNRNzj9cPF1CFJqnSQ8z+69iA9Fk00YnaVn2U3gwn6
 Su07rJWL5BIcA2pEDSqKxkQmOV9YWQnA=
X-Gm-Gg: AYBFou07sogEeo3UtIPta3qJYZm93s5HZZZD6UaJ1GVFOVTQC0ymNyV+Kj8JxP7M1JW
 UWLKLub903HHdg09f71L2KOppWtoCN7rzd+CE8xGWpMN+CoQEVR3GavqhusWYb4rpL2Ci2BXcug
 0Ra4uImiLMAkxZp1d32Y+qi3/TLXXcKLdZcXHtz7AF/zmhYMRILU3UzigjPBg2+865KGdGMG9lP
 KEu0o2E4ZMPU2Yxf3Wv45y2P5hCQIWUgyAMzH79LCi7dLPX50kcK4E8sgnlV8LDKubL8Ln+dWnF
 z7ItNfDazhWHGeW27W1ax97BCL3EGZywsOoUdyYqhxUZRnu4GxPdiFXFyQeAmYc7BkvUwCgWP0u
 Owv0ln4jCcxNMTyn+PW0s3X9w5rVc82Jg7PPxYyBM9Ur06RjdXILYsB5WsU7Kb7ex88PJXEQWmg
 RsyEwo/4Qr9MBIDqOGiz+uD4pC6JZ4
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id
 af79cd13be357-94421619197mr527331985a.2.1793386024760; Fri, 30 Oct 2026
 11:47:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793207602.git.mst@redhat.com>
 <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
 <CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com>
 <fe0694c6-383b-4cf2-abc0-c6d73a3d6c3c@tls.msk.ru>
 <20261030091030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261030091030-mutt-send-email-mst@kernel.org>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Fri, 30 Oct 2026 19:46:53 +0100
X-Gm-Features: AclHuK8CsycuRM1g5JSt2nRpwh2ma6uIOgrkrlMzPOFE5pRagELTt-SnnOWRnQk
Message-ID: <CANukVxup5pBM=33-S8pN8ADioLkqg3fWUm=6piXow7a0+WPT7w@mail.gmail.com>
Subject: Re: [PULL 40/78] pcie_sriov: register user created virtual function
 before realizing it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 14:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Oct 30, 2026 at 09:28:50AM +0300, Michael Tokarev wrote:
> > On 10/28/26 20:34, Daniel Paziyski wrote:
> > > Hello Michael,
> > >
> > > I think you have queued this patch for pulling on accident. There is a bug here,
> > > which is yet to be solved, as you have pointed out in
> > >
> > > https://lore.kernel.org/qemu-devel/20261028074508-mutt-send-email-mst@kernel.org/T/#mca344ac148a62107cdc298e97e6713b6657b5c55
> > >
> > > Please, hold off this patch for a while, until I come up with a fix soon.
> > Am I right this buggy version of the patch has just landed in the master branch,
> > instead of the fixed v2 one?
> >
> > Here's the difference between what's in current master and the v2:
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index d4187293b1f..6242204a52c 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2310,10 +2310,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >          pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
> >      }
> >
> > -    pci_dev = do_pci_register_device(pci_dev,
> > -                                     object_get_typename(OBJECT(qdev)),
> > -                                     pci_dev->devfn, errp);
> > -    if (pci_dev == NULL) {
> > +    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
> > +                                pci_dev->devfn, errp)) {
> >          pci_unregister_acpi_index(pci_dev);
> >          return;
> >      }
> > @@ -2332,6 +2330,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >          }
> >      }
> >
> > +    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
> > +        pci_qdev_unrealize(DEVICE(pci_dev));
> > +        return;
> > +    }
> > +
> >      /*
> >       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> >       * associate only Device 0 with the device attached to the bus
>
>
> Yes sorry, pls post a fix as a patch.
>

If you are referring to me, do you want me to make a v3 fixing master,
or will you revert
the patch in master and include the v2 (which is already in the lists)
when you request pull?

fwiw, here's the link to v2:
https://lore.kernel.org/qemu-devel/20261028213800.236067-1-danielpaziyski@gmail.com/

Daniel

> > ~
> >
> > Thanks,
> >
> > /mjt
>

