Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8687C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg7bZ-0006rD-SD; Thu, 06 Feb 2025 14:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tg7bV-0006f8-Nj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:32:02 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tg7bT-0002To-KL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=2k33yNk25PagPEBcHClhr9elIb26+Y/tGaEy2O98CYA=; b=aaCXAIWwnfD8PLmaWgOVLOkyuW
 /VCCPdPKpCy9LHiLaON2RjNxmUOU1upMI2FEvSzGO80Fw/KB+r9n7Mjf/qQS+NDDnqNB3dscafa7I
 EX5w6D553eq1fzmMaGLmQtN/pTMfCVJ7tpt9ZzkJjZMcqYIB16Km24aHOO/ipNUJUZCIquJX0IS+B
 7TX200/gEgrTqgjtELi9p0j2CJBSvQGxISci26fs2BhZJAv24nEnXa17eAC764e515XYNgglR+cYJ
 L59JEyzkvMWFJm81reDAkerXLWSH+W0fTS5xUsAKuKAdhToR3csLt51WYRRpRWOTIxEK7pss65Tnx
 jC8QsreNVCsM8hIVXSH6aplxb14zg+lZtD7dQz7fI8csuC+Zu7wTebfLsAjBsWG5YRdgfEFzvmEWg
 iovONTev81rRbHwxRiX03m43t+PmmDjgHqbF4M8O/cnKtVaRA6O9FEeym1psZZp0hXkwTCErY/g/P
 homn1IFHoSgKc0aMrmbKNlnl36xdKW2BjlQQLDpqsNcTBj3GmeGHCyQC4lAwjiWSvWH7h67ui+u/J
 XGYcE1+xOVsqobBsNIkokTej5yKC8nA4vDwllJt96Od+GQm5h/pYVm2zDD4tCwm/5YdsiKmHSdZf/
 kjpQdOOXkB0PrwNfspWDjUSg6aqeiPzTu5nBrXsS8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/7] 9p queue 2025-02-06
Date: Thu, 06 Feb 2025 20:31:53 +0100
Message-ID: <3857025.yXzrrPSgKx@silver>
In-Reply-To: <CAJSP0QVAdAEKVi6WBGm=XM_wZTjnD5r=qEe9SWwZh6uv5O5uYw@mail.gmail.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
 <CAJSP0QVAdAEKVi6WBGm=XM_wZTjnD5r=qEe9SWwZh6uv5O5uYw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

On Thursday, February 6, 2025 7:49:07 PM CET Stefan Hajnoczi wrote:
> On Thu, Feb 6, 2025 at 11:49=E2=80=AFAM Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> >
> > The following changes since commit d922088eb4ba6bc31a99f17b32cf75e59dd3=
06cd:
> >
> >   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qe=
mu into staging (2025-02-03 13:42:02 -0500)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250206
> >
> > for you to fetch changes up to bfa7bf02782dbd996201c90f850ca11730041af1:
> >
> >   MAINTAINERS: Mark me as reviewer only for 9pfs (2025-02-06 17:10:46 +=
0100)
> >
> > ----------------------------------------------------------------
> >
> > * Greg Kurz steps back as maintainer of 9pfs.
> >
> > * Make multidevs=3Dremap default option (instead of multidevs=3Dwarn)
> >   and update documentation related to this option.
> >
> > * Improve tracing (i.e. usefulness of log output content).
> >
> > * Add test cases for accessing a directory after removal.
> >
> > ----------------------------------------------------------------
> > Christian Schoenebeck (6):
> >       9pfs: improve v9fs_walk() tracing
> >       9pfs: make multidevs=3Dremap default
> >       9pfs: improve v9fs_open() tracing
> >       tests/9p: rename test use_after_unlink -> use_file_after_unlink
> >       tests/9p: add use_dir_after_unlink test
> >       tests/9p: extend use_dir_after_unlink test with Treaddir
>=20
> The following test failure occurred in the CI system:
>=20
> 12/65 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test ERROR 14.74s
> killed by signal 6 SIGABRT
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> Received response 7 (RLERROR) instead of 77 (RUNLINKAT)
> Rlerror has errno 22 (Invalid argument)
> **
> ERROR:../tests/qtest/libqos/virtio-9p-client.c:276:v9fs_req_recv:
> assertion failed (hdr.id =3D=3D id): (7 =3D=3D 77)
> (test program exited with status code -6)
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/9065429175
>=20
> Please take a look. Thanks!
>=20
> Stefan

Hmm, in that test a directory is deleted while still having a directory str=
eam
open (via opendir() call) on it. And that directory removal fails when runn=
ing
in the Gitlab cloud.

So I guess that means that this is file system dependant behaviour whether =
or
not it is accepted to delete a directory while still having a dir stream op=
en.

I'll just drop this directory test then.

/Christian

> >
> > Greg Kurz (1):
> >       MAINTAINERS: Mark me as reviewer only for 9pfs
> >
> >  MAINTAINERS                  |  3 +--
> >  hw/9pfs/9p-local.c           |  3 +++
> >  hw/9pfs/9p-util-generic.c    | 50 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/9pfs/9p-util.h            |  6 ++++++
> >  hw/9pfs/9p.c                 | 45 +++++++++++++++++++++++++++++++++---=
=2D--
> >  hw/9pfs/meson.build          |  1 +
> >  hw/9pfs/trace-events         |  4 ++--
> >  qemu-options.hx              | 49 ++++++++++++++++++++++++------------=
=2D------
> >  tests/qtest/virtio-9p-test.c | 50 ++++++++++++++++++++++++++++++++++++=
++++----
> >  9 files changed, 175 insertions(+), 36 deletions(-)
> >  create mode 100644 hw/9pfs/9p-util-generic.c
> >
>=20
>=20



