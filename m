Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736D1FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcSo-0008Um-Dk; Wed, 06 May 2026 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wKcSn-0008Ss-KJ; Wed, 06 May 2026 09:38:57 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wKcSm-00050p-4P; Wed, 06 May 2026 09:38:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C980760126;
 Wed,  6 May 2026 13:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74773C2BCB8;
 Wed,  6 May 2026 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778074726;
 bh=SNeJFU+TSl4y3ZKByDp7IjxKBgALd+IVcqxiw6IPSbM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZBjHEWVCxLIh5z9ZUzKEU6sZQBNEcSU0tFBzsnrEAOImDhYi7IEjhXxtgfjbKwQXc
 k0+qMwedJJWjxcuiuqz9ZpHy2FvoKy82v07uokYVuIERUWP+2VSv6j2HwHYfPxvVcK
 EjeT0MK9//y7Y9HxCFo3z+5nl6t4J8nZV7fA1Yy/7diTliQulejfe6njf5Fc9vygX9
 Y0yZCPt+pzH7bxKCefPmNwCHOpwv3CKTKuOzuPlNc/UtP2UZ/JiEE4tS+r/JOhOUVF
 DR5x9cM6866qNeQJVpezm/QPlqlaeVQiT7UsgexoqDUy0/2QuSocivxMl4NtHHBVYk
 b5GvQvO5VgKiQ==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1wKcSa-00000008qz1-1UXi; Wed, 06 May 2026 15:38:44 +0200
Date: Wed, 6 May 2026 15:38:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>, Glenn Miles
 <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Fabiano
 Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Harsh Prateek Bora
 <harsh.prateek.bora@gmail.com>, Caleb Schlossin <calebs@linux.ibm.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Message-ID: <20260506153843.6d3cd80c@localhost>
In-Reply-To: <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 6 May 2026 14:26:16 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 5/6/26 14:01, Markus Armbruster wrote:
> > I'm cc'ing reviewers and lists mentioned below, and frequent
> > contributors to MAINTAINERS.
> >=20
> > There are a number of MAINTAINERS entries with S: other than "Orphan"
> > without M:
> >=20

...

> > Unless somebody steps up to server as M: or at least R:, we should
> > downgrade to S: Orphan.  Volunteers?
>  =20

...

> >      MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
> >      R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >      S: Maintained

I'm ok to change this one to M.

I can also pickup maintainership on this one:

	ACPI/HEST/GHES
	L: qemu-arm@nongnu.org
	S: Orphan
	F: hw/acpi/ghes.c
	F: include/hw/acpi/ghes.h
	F: docs/specs/acpi_hest_ghes.rst


--=20
Thanks,
Mauro

