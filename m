Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F5CCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIOw-0005R3-8p; Thu, 15 Oct 2026 06:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHIOu-0005QX-RF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:09:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHIOt-0001Yq-6K
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:09:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so42544975e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792058965; x=1792663765; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YTMjJcxLHFYhK0t2BEMaYirfuhfv5R8r99yrmcGXKV8=;
 b=oW7c6yaQIJK6mELN2qisW8/PJbaYcvmCNl+/AP6fp9J85T3hvM6QGwlD3hLzZThoPi
 DdxbVZ5S/DAh2ktpdZjp/zUue7PIrlWtxm0605CmuOvYwNelXgQOa7HXOznyLOguYep+
 ltfBJc4GessZCxZ/flmV/FSoqz3PRt/6/RDZynPj0XcZZGfhvFxhqctZrZZ8FhnFNzUy
 aSSEFuZRq+38VslbMFN7dG5ygORW7mWMlbFIoIdCe+evrgzOEU2qhYd+g2H5lj5hoS0C
 2NGZI1L6pXJ9rCpcGhsYGmJgPZOk6zh7hVTrB9XGWYNQC+av98nM4qrGig77sCeQvDJZ
 L0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058965; x=1792663765;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YTMjJcxLHFYhK0t2BEMaYirfuhfv5R8r99yrmcGXKV8=;
 b=BhcCcol4bKAwGAMoBd45HqJppWkRBAL/uEtKHPcaTN1YZmRucRtdwd0O9RNFIjo/8X
 T4/keJsEEF2t6PRIytlPWmm5JGSB8M/uJptq9cA583g7jwk4xu3xOycLaDEDEZ06iG3Q
 ogMr2v1coqP8dXe2ovz3aWv8wypt0JEh934/bxhdfXdEVOPYPwfToesJ8K092CIc7bah
 /Pa4vzTdLLyZZ52upvkPIzfSfym3WiM85H73RnjvhNXSbLgucgK2EAVem9sErEMCByaA
 sxqWzl3LxiLNxK3lkowiWhE65zV3sKbUcDuhxiyHBs06W+Tcp0dgVgKcVAlGHhlwlom9
 sU/w==
X-Gm-Message-State: AFq9FYJX5JQx9wJ3gJwi9gnEKGst9ojdYHXuMxtWN3t5BrzVDm8nzODn
 KYt23lHkgRnbT3qNQ6AROhGjMQEXUqY64CuAcTWHkZ38AEHMg00PlFbw
X-Gm-Gg: AYBFou1xECE1wAUHfA79UFvGG20yEz99n50yys2ppWuvi60Xq86tPhl4YE4SrfQtwie
 0ClSC2YW6ayciTk98bI+Dbf2hZ6s5MaarI56Rm++KOMpaK8opb+XFCtz7+2zKkPWTIHXL2y29gD
 eeMdGJlsN1TifS8hkNOcgJcPZLOCdZcdtzsAOgDZ3fdw9waBYvhtcoj9+ybYpow3uTqBNAoMFP3
 TsmDAdILcq2GLoeEN8BjSKg1cntVV57mKbQkSGKJR8l+sM2S+FWa0W1uYZm2ixF3Xb5gJnfTZw5
 yiMSdL4L8c+s3dJDJZBZcLZdn90IrYCd5e41sVg/pBLHSQcHQnnMOJWmzI0pGXazWdaSCwYr5eQ
 IiRGAevXZbcR6ts5EHaL3xGFzWrPAxfw3gv2+HRuywBDLecIofkU+drzzpXxsD3Zch59jlHqO0i
 VpLH9YdzSkspFNG3rPKP4j0zDDpcUqJVk+di+G+caoAqXkS/Epf/YsPDBJR3Ei7jYzpvena8gqL
 sEAcKlRCq0o836DXgdX7LX2UVEvzlx2
X-Received: by 2002:a05:600c:3554:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a18e43a1cemr376800725e9.1.1792058965100; 
 Thu, 15 Oct 2026 03:09:25 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab506bsm18562105f8f.27.2026.10.15.03.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:09:24 -0700 (PDT)
Message-ID: <85c97944e59abe645eb95602b7193cba15e3a17a.camel@gmail.com>
Subject: Re: [PATCH v3] treewide: use qemu_dup() instead of dup()
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini	 <pbonzini@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent
 Vivier	 <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,  Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Mark Kanda
 <mark.kanda@oracle.com>,  Ben Chaney <bchaney@akamai.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Date: Thu, 15 Oct 2026 12:09:22 +0200
In-Reply-To: <atCJCs4acmZoss2H@redhat.com>
References: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
 <atCJCs4acmZoss2H@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2026-10-15 at 09:04 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Oct 15, 2026 at 03:34:43AM +0200, Filip Hejsek wrote:
> > Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
> >=20
> > The only direct users of dup() are now guest syscalls in the user
> > emulators and the implementation of qemu_dup() itself.
> >=20
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> > For each call I replaced, I checked how the resulting fd is used
> > afterwards. In summary:
> >=20
> > hw/virtio/virtio.c:
> >     the fd is passed to memory_region_init_ram_from_fd, used for mmapin=
g
> >=20
> > io/channel-file.c:
> >     the fd is passed to qio_channel_file_new_fd, used for reading/writi=
ng
> >=20
> > migration/cpr-exec.c:
> >     the cloexec flag is cleared
> >=20
> > qemu-nbd.c:
> >     the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO
> >=20
> > system/vl.c:
> >     no change in behavior, the code was already setting the cloexec fla=
g
> >=20
> > ui/dmabuf.c:
> >     the function is called by qemu_spice_gl_update, which passes the fd=
s
> >     to SPICE server
> >=20
> > tests/qtest/bios-tables-test.c:
> >     temp dup of stdout, dup2'd back to STDOUT_FILENO
> >=20
> > tests/unit/test-util-sockets.c:
> >     one fd is dup'd again and returned from mock monitor_get_fd; anothe=
r
> >     is converted to string and given as address to socket_connect
> >=20
> > tests/unit/test-vmstate.c:
> >     passed to qio_channel_file_new_fd to create a channel
> >=20
> > Changes in v3:
> > - Also replace the use in migration/cpr-exec.c and the tests
> > - Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-=
v2-1-12ecd94263b7@gmail.com
> >=20
> > Changes in v2:
> > - Replace the use in qemu-nbd.c too
> > - Changed commit message
> > - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-=
v1-1-03d94852a6c8@gmail.com
> > ---
> >  hw/virtio/virtio.c             | 2 +-
> >  io/channel-file.c              | 2 +-
> >  migration/cpr-exec.c           | 2 +-
> >  qemu-nbd.c                     | 2 +-
> >  system/vl.c                    | 9 +--------
> >  tests/qtest/bios-tables-test.c | 2 +-
> >  tests/unit/test-util-sockets.c | 6 +++---
> >  tests/unit/test-vmstate.c      | 2 +-
> >  ui/dmabuf.c                    | 2 +-
> >  9 files changed, 11 insertions(+), 18 deletions(-)
>=20
>=20
> > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> > index daa50916d2..2f38db30bb 100644
> > --- a/migration/cpr-exec.c
> > +++ b/migration/cpr-exec.c
> > @@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp=
)
> >  {
> >      QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> >      /* coverity[leaked_storage] - mfd intentionally kept open across e=
xec() */
> > -    int mfd =3D dup(fioc->fd);
> > +    int mfd =3D qemu_dup(fioc->fd);
> >      char val[16];
>=20
> This change needed to be:
>=20
>    int mfd =3D qemu_dup(fioc->fd);
>    qemu_clear_cloexec(fioc->fd);  =20
>=20

There was a call to qemu_clear_cloexec(mfd) already, even before the
change, just outside the visible hunk:

   bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
   {
       QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
       /* coverity[leaked_storage] - mfd intentionally kept open across exe=
c() */
       int mfd =3D qemu_dup(fioc->fd);
       char val[16];
  =20
       /* Remember mfd in environment for post-exec load */
       qemu_clear_cloexec(mfd);
       snprintf(val, sizeof(val), "%d", mfd);
       if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
           error_setg(errp, "Setting env %s =3D %s failed", CPR_EXEC_STATE_=
NAME, val);
           return false;
       }
  =20
       return true;
   }

>=20
> If that is added:
>=20
>  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> =20
>=20
> With regards,
> Daniel

