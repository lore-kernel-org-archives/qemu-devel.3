Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE60DC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 08:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirpT-0003i7-Is; Sat, 09 Mar 2024 03:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirpQ-0003hv-VQ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 03:13:12 -0500
Received: from out-170.mta0.migadu.com ([91.218.175.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirpO-00039M-2Y
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 03:13:12 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MURCzuU0jK4I6zwysWHLwAE69RRVIw8Yj9eSsyth3k=;
 b=rqDRCdwUcSrda/wlHJGlsKMyvtZ+EgGC3tdGMoUBkDlOGzOa3hyesqadcMpaUeidLuynFb
 xg9543QJSrljRfUZFHh+7IqgKdoIv7kzgh9i7ZSEsD3wj8aKpb9ZmV/G9iBvETsGdUQBZZ
 2ZVlIEMEGVQVpQFHn+eh1lvl+/rdESg=
Date: Sat, 09 Mar 2024 08:13:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <676191b98cee7581bce88a328d4eca7cc22d55f8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 7/7] Update maintainer contact for migration multifd
 zero page checking acceleration.
To: peterx@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
In-Reply-To: <CAAYibXjoji3GY7TW_USFsuT3YyVnv_kGFXpvBgK_kf9i1S1VSw@mail.gmail.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-8-hao.xiang@bytedance.com>
 <ZeV5g8nuP2NpYQ5v@x1n>
 <CAAYibXjoji3GY7TW_USFsuT3YyVnv_kGFXpvBgK_kf9i1S1VSw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.170; envelope-from=hao.xiang@linux.dev;
 helo=out-170.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>=20
>=20On Sun, Mar 3, 2024 at 11:34 PM Peter Xu <peterx@redhat.com> wrote:
>=20
>=20>=20
>=20> On Fri, Mar 01, 2024 at 02:28:29AM +0000, Hao Xiang wrote:
> >=20
>=20>  Add myself to maintain multifd zero page checking acceleration fun=
ction.
> >=20
>=20>  Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >=20
>=20>  ---
> >=20
>=20>  MAINTAINERS | 5 +++++
> >=20
>=20>  1 file changed, 5 insertions(+)
> >=20
>=20>  diff --git a/MAINTAINERS b/MAINTAINERS
> >=20
>=20>  index 65dfdc9677..b547918e4d 100644
> >=20
>=20>  --- a/MAINTAINERS
> >=20
>=20>  +++ b/MAINTAINERS
> >=20
>=20>  @@ -3414,6 +3414,11 @@ F: tests/migration/
> >=20
>=20>  F: util/userfaultfd.c
> >=20
>=20>  X: migration/rdma*
> >=20
>=20>  +Migration multifd zero page checking acceleration
> >=20
>=20>  +M: Hao Xiang <hao.xiang@bytedance.com>
> >=20
>=20>  +S: Maintained
> >=20
>=20>  +F: migration/multifd-zero-page.c
> >=20
>=20>  +
> >=20
>=20>  Firstly appreciate a lot for volunteering!
> >=20
>=20>  My fault to not have made it clear. This file alone so far will ne=
ed to be
> >=20
>=20>  closely related to the multifd core, so whoever maintains migratio=
n should
> >=20
>=20>  look after this. It's also slightly weird to have a separate entry=
 for a
> >=20
>=20>  file that is tens of LOC if it's already covered by another upper =
entry.
> >=20
>=20>  What I worry is about vendor/library specific parts that will be h=
arder to
> >=20
>=20>  maintain, and migration maintainers (no matter who does the job in=
 the
> >=20
>=20>  future) may not always cover those areas. So I was expecting we co=
uld have
> >=20
>=20>  volunteers covering e.g. QAT / DSA / IAA accelerators. Since all t=
hese
> >=20
>=20>  accelerators will all be part of Intel's new chips, there's also o=
ne way
> >=20
>=20>  that we have "Intel accelerators" section to cover vendor specific=
 codes
> >=20
>=20>  and then cover all those areas no matter it's zero detect accelera=
tor or HW
> >=20
>=20>  compressors.
> >=20
>=20>  I'd suggest we discuss this with Intel people to check out a solid=
 plan
> >=20
>=20>  later when we start to merge HW/LIB specific codes. For now I sugg=
est we
> >=20
>=20>  can drop this patch and stick with the feature implementation, to =
see
> >=20
>=20>  whether it can catch the train for 9.0. IMHO this is a good featur=
e even
> >=20
>=20>  without HW accelerators (and I think it's close to ready), so I ho=
pe it can
> >=20
> >  still make it.
> >=20
>=20>  Thanks,

No worries. I misunderstood you. We can talk about maintenance later on w=
hen we have the accelerator changes ready.

> >=20
>=20>  --
> >=20
>=20>  Peter Xu
> >
>

