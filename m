Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1AAC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDdA-0006T7-6R; Mon, 02 Jun 2025 18:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMDd4-0006DW-J5
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:27:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMDd2-0003zZ-OK
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:27:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-602c4eae8d5so1422711a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748903254; x=1749508054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHqwA1ABbeo2Fvwh8ZD2w9mg0RbKFrSUeCxF2e1Hees=;
 b=dTFvXbVDHweTylRR3S6l3XGmxOU9Dz3MK6STz/IMoq66kmLXyGng5qeJTPndoGLF4o
 /KuR3FHLKPMtyAhHFluQQuYQx+uAg2QejOnWvh/YJnfVUcbJyRUP/pAFgUGvj4UNX79v
 nhxp283/F+anXpJmt9nKq4FV5E2A8qnfhuky4f2JGMFJC9mzGPJmBJVwOf1Wv8jf3ztr
 yneOgnY13XrS0KjNr9NNkaDKBh4hCT1wDH+2tFeic6qYbY3G9e3EmI8k1ugqOU84op51
 rXLW3MKF8Z3VTWYBE7BiqbGas3aAWYloxMRqUFz94afbgkuLA9Pt0beLXRzrn+4x8lWO
 5ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903254; x=1749508054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHqwA1ABbeo2Fvwh8ZD2w9mg0RbKFrSUeCxF2e1Hees=;
 b=SOlUshA3+1EdcXMXA+8gPh4+ccybiaNcf0tVkCnX6GO2IDoDgTASFbD+rnRsdl06Jv
 hzwpcjo5x74ZucDqA/mxWAaUQFsv148Pgh2WJ0Nng+ZsDZTm/EGNAX2JfutkPLQ3eXwo
 bByIGOgZoUostnX5JwxZ4WrvI+Fp9h/nHxR6ADAJiz4zoHZ2i6wvHShxOhQTaYCgqhPZ
 2MzwcFJNexcTua75WlEyeS8YwEg+wyX6sel1I25coMvvJeHNe3sDMKTzXTKou+8VF/rS
 hN0H/PGGWbpQQX3lTgmGpEUuco5sKujsra+Hl/t1JQ5EAEokh6g79EooV7pB5BVFd8Zc
 zx7A==
X-Gm-Message-State: AOJu0Yz/GwsT09K3bCoscLpqZkuErxbPqxJfadf5Uumwk5AJgDkle/cs
 rSj/q2yWf7XmN5jI1qBhaJvaKQclm1bMmEQJX9TISanFFkjtL+fj1zGsrj0kt7gIhVBveWyVOG0
 08NCoid3esZDnCB6S3oa2+GXv4kk2E98=
X-Gm-Gg: ASbGncuQDpk483ii7HC7ARkEOVglFG6p5QqS/Mkk+iy85xtzaYS4GYazGodlUx9yeOP
 WEzMDcQVWkXvX+hmuWS+EOEiENKGuhG+Bh74wePmnZ3/KXyZCL2ZiliSUuKesbY2FaUnn0bN9p4
 mlnBZv47Au3AbS4bJ1fEZYm7iR+FGy2g0=
X-Google-Smtp-Source: AGHT+IHqQWDtRJY6Aw9hc0QC6mByiYTSrKlD5pSAuaWfdi76bA0Metwu9tmGOxMKAmnm4WK9H8KG5KB7sU9V68fq5Mc=
X-Received: by 2002:a05:6402:2351:b0:604:e752:fedb with SMTP id
 4fb4d7f45d1cf-606afa24580mr254429a12.10.1748903254457; Mon, 02 Jun 2025
 15:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1748791463.git.mst@redhat.com>
 <CAJSP0QUCipXvUWQ7uOm4Ct2a0O7=SFF9XZAozTFtAZfak8-EGg@mail.gmail.com>
 <20250602135333-mutt-send-email-mst@kernel.org>
 <CAJSP0QWvkMMcuy=5hU=4Ps4DtoE2TQ8Up4fDSLZZ8ia_+9jjEA@mail.gmail.com>
 <20250602142634-mutt-send-email-mst@kernel.org>
 <20250602175809-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250602175809-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Jun 2025 18:27:22 -0400
X-Gm-Features: AX0GCFux6-Rx_58n2xw1GY04pAWUiTlhS5G2Tgnib-Ewo3Kg4GBVsxJPKUVQQgg
Message-ID: <CAJSP0QWrGXRL0wxMaE+upge57_2YxXmrLFH7qdLiRhmDsLOOLw@mail.gmail.com>
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Jun 2, 2025 at 5:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 02, 2025 at 02:31:19PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 02, 2025 at 02:25:48PM -0400, Stefan Hajnoczi wrote:
> > > On Mon, Jun 2, 2025 at 1:54=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Mon, Jun 02, 2025 at 12:39:17PM -0400, Stefan Hajnoczi wrote:
> > > > > On Sun, Jun 1, 2025 at 11:34=E2=80=AFAM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > The following changes since commit d2e9b78162e31b1eaf20f3a4f563=
da82da56908d:
> > > > > >
> > > > > >   Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/a=
rmbru into staging (2025-05-29 08:36:01 -0400)
> > > > > >
> > > > > > are available in the Git repository at:
> > > > > >
> > > > > >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for=
_upstream
> > > > > >
> > > > > > for you to fetch changes up to 1c5771c092742b729e2a640be184a0f4=
8c0b2cdb:
> > > > > >
> > > > > >   hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine (202=
5-06-01 08:30:09 -0400)
> > > > > >
> > > > > > ---------------------------------------------------------------=
-
> > > > > > virtio,pci,pc: features, fixes, tests
> > > > > >
> > > > > > vhost will now no longer set a call notifier if unused
> > > > > > loongarch gained acpi tests based on bios-tables-test
> > > > > > some core pci work for SVM support in vtd
> > > > > > vhost vdpa init has been optimized for response time to QMP
> > > > > > A couple more fixes
> > > > > >
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > >
> > > > > Please take a look at this CI failure:
> > > > > https://gitlab.com/qemu-project/qemu/-/jobs/10225580735#L4750
> > > >
> > > > Hmm must be how it interacts with something in your tree.
> > > > Which commit are you merging with?
> > > > Let me know, I'll try to rebase.
> > >
> > > commit 25de0b9aa129b2b014a0595befef05f04511868d (HEAD -> staging)
> > > Merge: 3e82ddaa8d 6e672b2a08
> > > Author: Stefan Hajnoczi <stefanha@redhat.com>
> > > Date:   Mon Jun 2 09:56:12 2025 -0400
> > >
> > >     Merge tag 'for_upstream' of
> > > https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
> > >
> > >     virtio,pci,pc: features, fixes, tests
> > >
> > > Commit 6e672b2a08 is the one you published and 3e82ddaa8d is the
> > > qemu.git/master.
> >
> > I could not figure it out. Must be a loongarch bug dealing
> > with s390 hosts. I dropped them from the tag for now.
> > Cc contributor to figure it out.
> > Bibo Mao pls take a look.
> >
> > New tag:
> > 0b006153b7ec66505cb2d231235aa19ca5d2ce37
> >
> >
> > Thanks!
>
>
> hope this is ok now. going offline for vacation. see you after the 10th!

Yes, it has been merged now. Enjoy your vacation!

Stefan

