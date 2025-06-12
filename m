Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE6C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPhgG-0002Fr-SD; Thu, 12 Jun 2025 09:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPhgE-0002FW-Mx
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:09:18 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPhgB-0004DL-Gm
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:09:18 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so163533866b.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749733753; x=1750338553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oF9HV3J9cGHJC5/rdUJ1C0ToRyFmid67B4txS1enQ0I=;
 b=C9rWQ9BkOE3tXBSTAhmf/la2/ZVqbJdTfkBSxlj/EN28zEUDGh1swlpSnVptuQQTq3
 rtVq+6ohYuKops7i6cB+gR4MoA9+0BeiqGSsCDp8Yz6bSmPA95oeRdp3lC/yW2BAWOs7
 HFMDBwIEx+HefwlCWvTc6EfHGa7Vw7tcsEb8uDzqAuFEvdIocvtbQ1b3/FOaZh3jnm9e
 Ift2Z5+nZ+SXbP7uMi6SmD6/AFZgRIF4DucMV2jh0XpEXRcE+ZGb0wyxYId7JRTPj9dN
 w5/dVl8BQUy9JkzwyLpJJcStNJ7Ec07o/fKsKhvdOlTXg/wYADzn7Vh0gMBdLB0Z4Rh9
 tWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749733753; x=1750338553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oF9HV3J9cGHJC5/rdUJ1C0ToRyFmid67B4txS1enQ0I=;
 b=VXbf7W6ydCIqGard1nY1GgIGNm667zfEgbttFCID70YKcRtKPw8X7wYu/hnzjnPKXw
 s746uALmuZ/38JSmoV35zZSQ8Gqj7VraHNWJ5ZrHkaygY67R0z39HQCYBWS70nMkuW7v
 guuxwZgMMSenEPsi4dPPjEU08wHUkWG1Kyc1/ulYoMp+F0sP9AH9OEEB1G+2rEPxLD53
 3pZgy46sTGDfoOHTM7f7ydQfhKpBjcZn0vci1sVuadRVG43VHzGNIPgHYt3/oWT7I4X0
 uLXrpsP5a2mo3+uUdIE4WRDR9Qvv6YJogwWIpVZMx9R2jTEapNkamGJ3KRbSIxHvf0je
 fqWg==
X-Gm-Message-State: AOJu0YynXmlHeGnlOBu/EJzW3MbF+do9A+H6EPg+dy/4iqy8k/Uarmg+
 7LLlLgxk919WFpgDvilVGWx8N7P9bmuP6q9Iy+3qcSvSYF8SF0v5qllrKDl1gQZHirk+my3CVz4
 wULkFaEiB55L4fSXA1cETQ/qTl9Y/25w=
X-Gm-Gg: ASbGncsS9F2Yx+0SgVMhXaOLufSZi0GSBHtJl/LhWQJUfJ1S5owymQZ4bFkY2MMON9u
 HVrd/9widEWG3tWq1hIB6fl4lCPQBD2Zp/BqT4HP5JA6n6nfIWdVWfMgfAvO1H04HBRNJM71Lqt
 XuW6bpSLTAkCbddcA7+PeU/lfu64mh/97W9ZS1LYz+WQ==
X-Google-Smtp-Source: AGHT+IFHY6d8YxAXJYgsP/7BmYyi9VNlX0/i0llV3grQn+HMHnJ7D5UrvBkNkOiuZvw5TVYCGamp5xeiGBYdyaaIsCw=
X-Received: by 2002:a17:907:3fa5:b0:ad8:a935:b8eb with SMTP id
 a640c23a62f3a-adea8d31416mr323523566b.3.1749733751647; Thu, 12 Jun 2025
 06:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
In-Reply-To: <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jun 2025 09:08:59 -0400
X-Gm-Features: AX0GCFsjo2OK5aIeqBglRtNlr8mhFTcyM4gVNDQqKwkNsMXSM6JwwYiZnbn4Yq0
Message-ID: <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62a.google.com
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

On Thu, Jun 12, 2025 at 12:36=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 11/06/2025 21.09, Stefan Hajnoczi wrote:
> > On Wed, Jun 11, 2025 at 2:36=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
> >>
> >> On 11/06/2025 09.50, Gerd Hoffmann wrote:
> >>> The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d6=
00c40f:
> >>>
> >>>     Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://git=
lab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>     https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-p=
ull-request
> >>>
> >>> for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952d=
e1:
> >>>
> >>>     seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> seabios: update to 1.17.0 release
> >>>
> >>> ----------------------------------------------------------------
> >>>
> >>> Gerd Hoffmann (2):
> >>>     seabios: update submodule to 1.17.0
> >>>     seabios: update binaries to 1.17.0
> >>
> >>    Hi Gerd, hi Stefan,
> >>
> >> I'm now getting this when doing a git pull:
> >>
> >> Fetching submodule roms/seabios
> >> fatal: remote error: upload-pack: not our ref
> >> b52ca86e094d19b58e2304417787e96b940e39c6
> >> Errors during submodule fetch:
> >>          roms/seabios
> >
> > GitLab CI didn't detect this, probably because the tests don't build
> > SeaBIOS from source and use the binaries instead. Given infinite CI
> > resources we should rebuild all ROMs from source to catch problems
> > like this one.
> >
> > I wanted to mention this in case anyone wants to tighten up the CI to
> > catch these issues for SeaBIOS and other ROMs.
> >
> >> Looking at
> >> https://gitlab.com/qemu-project/seabios/-/commits/master?ref_type=3DHE=
ADS
> >> there is a problem with the mirroring:
> >>
> >> "This project is mirrored from https://review.coreboot.org/seabios. Pu=
ll
> >> mirroring failed 4 months ago.
> >> Repository mirroring has been paused due to too many failed attempts. =
It can
> >> be resumed by a project maintainer or owner.
> >> Last successful update 4 months ago. This branch has diverged from ups=
tream. "
> >>
> >> Could you please fix this?
> >
> > `git clone https://review.coreboot.org/seabios` works on my machine,
> > but I manually clicked the "update" button and GitLab failed again.
> >
> > In the GitLab UI there is a button to add a new mirror repo. I thought
> > maybe we can delete the old repo and add a new one, but the push/pull
> > direction dropdown list is disabled. Maybe that's because only 1 repo
> > can be a mirror source for pull, I'm worried that deleting the
> > existing failed repo will leave us with no way to add a new repo that
> > supports pull.
> >
> > Does anyone know how to go about fixing this failed mirror?
>
> Maybe do a manual push --force to our mirror to sync them again? ... but =
it
> would be good to know how this could have happened at all - maybe seabios
> force-pushed their master branch at one point in time? Or did we commit
> something to the mirror that was not in the upstream repository?
>
> Anyway, I just noticed that it seems to be working now again - how did yo=
u
> fix it?

I didn't fix it. GitLab's mirror operation is still failing. Your
suggestion of force pushing should fix it, but I want to understand
why a commit was lost first.

The issue is that QEMU's mirror and upstream have diverged. The
following commit is only in QEMU's mirror repo:

commit 44693a974cd90917f81a7d0310df4b592edd7e09
Author: Christopher Lentocha <christopherericlentocha@gmail.com>
Date:   Tue Jan 21 11:59:14 2025 -0500

    Fix AHCI Disk Detection when using EDK2 CSM

It is not possible to fast-forward to upstream's master due to this differe=
nce.

Gerd: Do you know what happened to this commit upstream? According to
the mailing list archives you merged it, but I don't see it on the
master branch:
https://patchew.org/Seabios/clqcnplppk34e7eyiquorweq5dvmbsgm2qrk7ozhzybvxvi=
boa@4i2yfqplktar/

Stefan

