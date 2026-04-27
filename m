Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D1AFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHQiA-0008F9-0m; Mon, 27 Apr 2026 14:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHQi8-0008EE-9D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHQi5-0004R8-Nd
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777314571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wbrGrpYwAoexGyBI/YIu1zfMm+EWJWNiqlXkgHATKjg=;
 b=fZTqPVCaW50Jp9A7f2N660rreqUOoweiUfVlNLnOcYthSCoK6NfQtu748yChmoNOXZThTv
 a7F2cW+Hfq51D+hI+yEy6FFoQL2QL1t92yHrjA+fv/CPPlL6i3Z/awuAPaNH7uZN8WkefG
 QfqaYinjHaU2JhL/s2ok4BvFUTHR4+w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-qh093ZeUMjaQ7F5v2J1n6Q-1; Mon,
 27 Apr 2026 14:29:29 -0400
X-MC-Unique: qh093ZeUMjaQ7F5v2J1n6Q-1
X-Mimecast-MFC-AGG-ID: qh093ZeUMjaQ7F5v2J1n6Q_1777314568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEDA519560B5; Mon, 27 Apr 2026 18:29:27 +0000 (UTC)
Received: from localhost (unknown [10.44.34.59])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BF191800446; Mon, 27 Apr 2026 18:29:26 +0000 (UTC)
Date: Mon, 27 Apr 2026 14:29:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: npcm7xx_timer-test failing sporadically in CI
Message-ID: <20260427182923.GA235067@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DRXTIOb8GETp2UAR"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--DRXTIOb8GETp2UAR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
The npcm7xx_timer test fails sometimes in QEMU's CI. Is it possible that
"clock_step" is stepping to some other deadline and not the
npcm7xx_timer device's deadline?

In tests/qtest/npcm7xx_timer-test.c:

  /* Verifies that a periodict timer fires an interrupt every time it expir=
es. */
  static void test_periodic_interrupt(gconstpointer test_data)
  {
      const TestData *td =3D test_data;
      unsigned int count =3D 65535;
      unsigned int ps =3D 2;
      int i;
 =20
      tim_reset(td);
 =20
      tim_write_ticr(td, count);
      tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
 =20
      for (i =3D 0; i < 4; i++) {
          clock_step_next();
          ^^^^^^^^^^^^^^^^^
 =20
          g_assert_cmphex(tim_read(td, TISR), =3D=3D, tim_timer_bit(td));
          g_assert_true(qtest_get_irq(global_qtest, tim_timer_irq(td)));

Here is the output from a test failure:

 56/113 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test           ERROR=
            0.82s   exit status 1
>>> MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:p=
rint_stacktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 QT=
EST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon ASAN_=
OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 QTEST_QEMU=
_BINARY=3D./qemu-system-arm G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/=
tests/dbus-daemon.sh RUST_BACKTRACE=3D1 PYTHON=3D/builds/qemu-project/qemu/=
build/pyvenv/bin/python3 MALLOC_PERTURB_=3D187 UBSAN_OPTIONS=3Dhalt_on_erro=
r=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 /builds/qem=
u-project/qemu/build/tests/qtest/npcm7xx_timer-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
**
ERROR:../tests/qtest/npcm7xx_timer-test.c:475:test_periodic_interrupt: asse=
rtion failed (tim_read(td, TISR) =3D=3D tim_timer_bit(td)): (0x00000000 =3D=
=3D 0x00000010)
**
ERROR:../tests/qtest/npcm7xx_timer-test.c:475:test_periodic_interrupt: code=
 should not be reached
**
ERROR:../tests/qtest/npcm7xx_timer-test.c:476:test_periodic_interrupt: 'qte=
st_get_irq(global_qtest, tim_timer_irq(td))' should be TRUE
(test program exited with status code 1)

https://gitlab.com/qemu-project/qemu/-/jobs/14108292900#L5637

Stefan

--DRXTIOb8GETp2UAR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnvqwMACgkQnKSrs4Gr
c8jCPwgAseySeZ3Mot57FbwXpyjTte2WZ82eDEJIJUloX03jJeoEK20UNQ7CMFMG
QQQjPoB0ZvsGFH3qt5xsxN2Xk7ssuvucRnnhaISNuM90A8DDO0JhzE0tVT2H0gYE
oRAMzW9Z+9z0lAW6XFyez2dPTjNzXkyidItubdxpuPMHTv3Fi8UrQ5jdTDAxeIiq
Qg0vRo0XuiYc7jDbkeW/dZY/k9O2Bx4yCyBe1xX7NWlYaIWq4wOXwza05qEYSbtD
cPQ91V3LUDybcbiXI5+EmqrxFqcw4gpY7jLOEVurWGDFdAAZ8abqk6MbpoKjnoFI
KxYKgpY8r/QZ9VZTpV4Feu8syqehRA==
=NHKO
-----END PGP SIGNATURE-----

--DRXTIOb8GETp2UAR--


