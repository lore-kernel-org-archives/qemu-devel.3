Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B6606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IQvvGXV8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWe2E-0006ZD-4Q; Thu, 26 Nov 2026 13:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWe28-0006Xn-69
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:17:24 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWe26-0000lM-C1
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:17:23 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c506a231b88so979646766b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795717041; x=1796321841; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/CqbHUpdbaxJLI4Ndxuhs7Ym9HkvW+lXC3QtuXztVFw=;
 b=IQvvGXV8McRAxseL6vgbQMNABawerYyN5AlkVD0HlAMo7GcIlLsyHW3uTlCSAa0Zke
 Mv8OIO7gHKpElOZHxrE1WztVVttkUcLj2SX+wnuo26mAPAsMCVNeN8FwE7Zy4W6AUhxO
 xgz/B1e4gZToYPadpBXc4Sr6lmmuGVvjnN/TAFTIohjOVL9gcSeu/ROSJz9F3yk8Tg+0
 J3YPzi2YVi8RhdGwNhtFR/dfPAWE/bs31TRw4ET9YSe9rUBj+ILETW/4jC/XIbXN9dhS
 VaYPmOD6rWajGw+Qpi3adDq3MP4TiNTm1H4pUPWYOWZjwFucNJZVQo8/fudUImEPW4tX
 oQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795717041; x=1796321841;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/CqbHUpdbaxJLI4Ndxuhs7Ym9HkvW+lXC3QtuXztVFw=;
 b=jLyiro8NZ8ltY5KCz1WQsdwNtEQ63zr0t70S8PCCjvpgQL3p9SFXddFOjoIFSHQP1e
 COEkAIrBDZmE9Q4AkKxUqWYpYSUTwwws4TwZi5gtktHlfH1G9t1EW6kUzLTqhY2AqPlk
 y+Qema0SqBZz5fd2c0dK24uWW1VdjFqpgZq0Lk4BuebHvHkIobQKrk/xFGppnpco18Xb
 gRwkehRbcwph5Nfjfqf0VnoMyxTOE9fvTzJD2xT4G6q+s3lfFmY6P87vsTjDMgSDST/G
 YREp1C9iQoJH39+1dNfgtiCsNQ/TyltPs6+6PH6iGsnmODlDRUKZwyRR4L7nXo1AADgv
 MV6g==
X-Gm-Message-State: APuU4Z9LkLupmZU1b3pvOPTu1JJ6w9myCJIRf4Jd9EuUAtgnxCIpXwEk
 sSI4r++dCrkp3alPWpd11Px2oe3kSok3Li/Tsk6+msyk5o5D2MDpaR3z
X-Gm-Gg: AZFdTZdIcbobnRR7ACpedxcYdj7nrWL8pktIuzzgpbS4rTMwAg8/Ouj6gEPcRvFQwym
 ZYEDN8BHski9RUtt6/T7S7ZlukkfsfoKbxIVAQ5xjFZaiumPSvn+KCN3mtZRBQ2wjHWzpBPEhpb
 vwZZj8JEUkNWcUZcm+ij+Z7vgcxtvhsPrVfEiXmrWkuGKmegZU0IrPcXpITRuhsJ8cGYhduUY00
 HbBNfEMOwRVCQDsikW4ZLmEz5EzUo03/3PEpGf4nXYNN3DoP4FGI5abKjwgji3ONeUrl590D3n2
 sEWMjjFTV4wo1KD0FldJCmFWt5sCutGA2ZObQ3mj7RlD2UZXWn50+PCXXEmKw+02K3lL8KFhYEq
 2c4W5wkDg1/Y9ODE61yz8Ro2UWuHX9cac6W22VY1gKt4SR13aw1Vfwi/fmLakK3pAj+NLitRaA3
 0Xdah09l99kslg4j/0ikBg5sOXhe8ZBhb0KMkYyTW6pQRzWeV4+JSYoVlC+lRHTuxk+CxY7C91d
 buCnj5ERuEuJ7yBh+V3xMkD4NKFsrKtbbBji34zZSuLfZsQWQNAf4sRAm5Jg09uAX7wL8pnDCn6
 6O1y89ejy12NctlscuYWP4A=
X-Received: by 2002:a17:907:3c8d:b0:c4d:8e7:29b9 with SMTP id
 a640c23a62f3a-c513a43532cmr1693187266b.5.1795717040325; 
 Thu, 26 Nov 2026 10:17:20 -0800 (PST)
Received: from tulp ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae8ce16sm769498966b.37.2026.11.26.10.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:17:19 -0800 (PST)
Date: Thu, 26 Nov 2026 19:16:36 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 05/10] iotests: skip preallocation tests if not
 supported
Message-ID: <awh3gvqh561nkTQ1@tulp>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
 <20261125191701.93931-6-bogorodskiy@gmail.com>
 <awgBfVWItT68xQEW@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <awgBfVWItT68xQEW@redhat.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62a.google.com
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Daniel P. Berrang=E9 wrote:

> On Wed, Nov 25, 2026 at 08:16:55PM +0100, Roman Bogorodskiy wrote:
> > Skip preallocation tests requiring efficient zero writes if
> > not supported. Support is detected by probing
> > "qemu-io write -z -n".
> >=20
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > ---
> >  tests/qemu-iotests/298 | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> > index f2b94077f4..869bdb3242 100755
> > --- a/tests/qemu-iotests/298
> > +++ b/tests/qemu-iotests/298
> > @@ -18,6 +18,7 @@
> >  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >  #
> > =20
> > +import errno
> >  import os
> >  import iotests
> > =20
> > @@ -32,6 +33,15 @@ drive_opts =3D f'node-name=3Ddisk,driver=3D{iotests.=
imgfmt},' \
> > =20
> >  class TestPreallocateBase(iotests.QMPTestCase):
> >      def setUp(self):
> > +        with iotests.FilePath('zero-probe.raw') as probe_path:
> > +            iotests.qemu_img_create('-f', 'raw', probe_path, '1M')
> > +            ret =3D iotests.qemu_io('-f', 'raw', '-c', 'write -z -n -q=
 0 1M',
> > +                                  probe_path, check=3DFalse)
> > +            if ret.returncode !=3D 0:
> > +                if os.strerror(errno.ENOTSUP) in ret.stdout:
> > +                    self.case_skip("File backend does not support "
> > +                                   "efficient zero writes")
> > +            self.assertEqual(ret.returncode, 0, ret.stdout)
>=20
> I guess this works, but any idea what the actul underlying missing
> feature is ?  Is it something we can check directly instead of
> matching on stderr strings ?=20

The actual missing feature is a working handle_aiocb_write_zeroes().
Thus, one of:

  CONFIG_FALLOCATE
  CONFIG_FALLOCATE_ZERO_RANGE
  CONFIG_FALLOCATE_PUNCH_HOLE

and filesystem support.

> >          iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * M=
iB))
> > =20
> >      def tearDown(self):
> > --=20
> > 2.56.0
> >=20
> >=20
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>=20

