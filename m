Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D1BE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlpVp-0004bF-MZ; Fri, 30 Jan 2026 09:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vlpVn-0004ap-NZ
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:30:15 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vlpVm-00074e-79
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=NXFrC9w8wfCb0KoZ4N9SS/Z3c/+SWnwZYRIn3bS/GhY=; b=jeHfJd6fm6TPK9LSSFHUbvdHvf
 pHAwzYdmlN8OxW1lWj98OMgjNIyv7zLvO4aIYWMkiY10eEdqkunfpiQWHFlFj+9T1lTtTAYqBCUMD
 Lb3AofrxFTAut3uEHVdK82tD2PioJuQR1ywgb19VKuPHwirtTMgo4/WZ1eYNoo4t12faNqUSSiUxt
 nQdiOFuVcJBYVV8TN1pLiX7wCo10PjyZJSWa2XhhWmL2WBxaKQe0N2GRXH4NCEGvkbv0tmua5pPqO
 kYaskwpxrWl0IzDM7Peuv0A5cFlcSNVUbZzk6TTdpPCz4Anprta50FP7Ta8E3vc+5hIQXX/5hRRTq
 6bQkVsLw+iQdSh3InM1vKNw4rqc1kONzJDh6SiOBBvoLrCI5Vzm4cRDVIABiDieeszQJXxeOjodI2
 b4SQbZAFEwsWJSIdX++ZlEjNjGpCfy+CwKfzneNN3rsbzluPNPu9bUWo/qOvdRVNJx1uqg3O+u3cl
 B6GSlsR2FO+XiOP0d12wRbo2IOxp6jk664JTuCUahmjHs8TQ3rWfmwKKltjs523awNqdPFNlfwQPn
 8+azW09Nd2A3xLQc6fT+PtchNZ8RWkgvY7CnrmQUVqB8FVBxzjmd96lEw96hEW+glIjHiO6Vz/496
 7D4C1/IKn4fjnq/UGUGeA8+EL4hBzlso7TpHJ+cwU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
Date: Fri, 30 Jan 2026 15:30:08 +0100
Message-ID: <5961971.DvuYhMxLoT@weasel>
In-Reply-To: <d3cd5506-1ba0-492a-9eee-51f814da6087@gmail.com>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <d3cd5506-1ba0-492a-9eee-51f814da6087@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wednesday, 28 January 2026 20:13:45 CET Andrey Erokhin wrote:
> > I was trying to boot from a directory tree owned by an ordinary user,
> > and some daemons weren't happy about non-root ownership of some files
> >=20
> > Example use:
> > -virtfs local,path=3Drootfs,mount_tag=3Droot,security_model=3Dmapped,ui=
d=3D0,gid=3D0
>=20
> I personally switched from fuse-overlayfs to user namespaces+kernel overl=
ay
> fs (for writeable overlay for rootfs) long time ago, so I do not need
> uid=3D0,gid=3D0, I'm being mapped to 0:0 in the user namespace. I wanted =
to
> publish this change to support users which can't use user namespaces, but
> yesterday I realized I could just run QEMU (with fuse-overlayfs) under
> fakeroot =F0=9F=A4=A6=E2=80=8D=E2=99=82=EF=B8=8F

Nevertheless you already came more than half way to finish this. All it wou=
ld=20
take is adding some lines to the command line docs.

But if you don't have the chance to finish this, no problem either, then I'=
m=20
going to pin your current patch version to=20
https://wiki.qemu.org/Documentation/9p#Implementation_Plans in case somebod=
y=20
else might be interested to finish this in future. Your call.

/Christian



