Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEDFEA8114
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnoC-00046k-Sz; Tue, 10 Feb 2026 08:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpno7-00044w-EP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:29:37 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpnnz-0000uI-PP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770730157; x=1771334957; i=lukasstraub2@web.de;
 bh=y6t7y0Pzhxn0+YXrohoNq+JMrng6wR19IITES5+yTgU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AeIT4slrcA1o+PydrrO1JGO11M/wYyrCJegOQ2w5SmpwAcaMaFkIRyujW9kHSkbg
 oCUcmjrQFU7DtCuPQqxfkeAPrXRZozxslAzahtc5UPV2UD8/xoaSETfwcWZQ0Bnly
 9jh8AfX7rP/R1udD5tLgvK4954e6/4GachGrPyFSgXrHMAyBUYK66ydC7UG27W4Ap
 oPWFPDnGOKDPsSHebTs+rCUcE7uzO3xZEeD5qVqAiJ1if3db9EH41M+qWVACrcUHp
 jKD0oePZx0TZ9DDJ5n6wMbf5PImOf9ArVNjDdHtFlKRPDnUwJSSYtuqSo6MmgybKK
 cPCwbavBrma7lw58fQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([141.58.36.84]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59jC-1vquGO40k0-002nRo; Tue, 10
 Feb 2026 14:29:17 +0100
Date: Tue, 10 Feb 2026 14:29:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 06/16] colo: Don't send ENABLE_COLO command
Message-ID: <20260210142914.29158748@penguin>
In-Reply-To: <aYoIpX1i_lwgQKyw@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-6-57508b7389f6@web.de>
 <aYoIpX1i_lwgQKyw@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rI0v=WPRYyw9VzYAF88fl=0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:wZ0QVW1Sb3H2FiB5B/RRNVo/P9GRLXM2sZHWXu8W0HjfqYeYTzr
 wYLlYWASAY/7RY0iSCOlDFN3sMp2LH3WgcVhqEkIdujasLgb7vwrsb+CXalK5DJJ91Put+I
 HsbsNDcMNkiGLT4XLoZLjD9B97n7SUTurxhmjZ7XAJ3FAtk4Tso7o74le/yb8txPQOThkT7
 hoURTFfD4GFnuzNKnalwA==
UI-OutboundReport: notjunk:1;M01:P0:PmvPvsOAee4=;1fnXjZW6wL97YifnYXwhU0+7kTc
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--Sig_/rI0v=WPRYyw9VzYAF88fl=0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Feb 2026 11:17:41 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Feb 03, 2026 at 11:15:12AM +0100, Lukas Straub wrote:
> > We only support COLO with the same version on both sides so this is
> > not needed anymore.
> >=20
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> Besides squashing with prior patch, another nitpick inline:
>=20
> > ---
> >  migration/migration.c  | 5 -----
> >  migration/savevm.c     | 8 +-------
> >  migration/savevm.h     | 1 -
> >  migration/trace-events | 1 -
> >  4 files changed, 1 insertion(+), 14 deletions(-)
> >=20
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3f3fc5276bb067ae1960e4b675b33208ad641b23..5515be1bf305b40ba0b5901=
36df18a53451872c5 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3496,11 +3496,6 @@ static void *migration_thread(void *opaque)
> >          qemu_savevm_send_postcopy_advise(s->to_dst_file);
> >      }
> > =20
> > -    if (migrate_colo()) {
> > -        /* Notify migration destination that we enable COLO */
> > -        qemu_savevm_send_colo_enable(s->to_dst_file);
> > -    }
> > -
> >      if (migrate_auto_converge()) {
> >          /* Start RAMBlock dirty bitmap sync timer */
> >          cpu_throttle_dirty_sync_timer(true);
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 413688b75f4bee6cb10878eb51886cf6ba14872d..a3af09616a7bd22194ffba3=
cfb7cc4cf15fc88e0 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -90,7 +90,7 @@ enum qemu_vm_cmd {
> >                                        were previously sent during
> >                                        precopy but are dirty. */
> >      MIG_CMD_PACKAGED,          /* Send a wrapped stream within this st=
ream */
> > -    MIG_CMD_ENABLE_COLO,       /* Enable COLO */
> > +    MIG_CMD_UNUSED_0,          /* Unused since 11.0 */ =20
>=20
> IMHO it's not "when unused" that matters, but "when it was used, and used
> as what" that matters.  E.g. if we received this unused command in some
> future QEMU debugging session, we can guess where it came from with that =
info.
>=20
> Hence, I'd suggest:
>=20
>        MIG_CMD_DEPRECATED_0,      /* Prior to 10.2, used as MIG_CMD_ENABL=
E_COLO */
>=20
> I still think DEPRECATED is better here, as it reminds people we shouldn't
> "reuse" it and better be left untouched to catch surprises, where "UNSED"
> may imply "you can use it now".
>=20
> Other than that looks all good, thanks.

Okay, will fix this in the next version.

>=20
> >      MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
> >      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
> >      MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
> > @@ -1092,12 +1092,6 @@ static void qemu_savevm_command_send(QEMUFile *f,
> >      qemu_fflush(f);
> >  }
> > =20
> > -void qemu_savevm_send_colo_enable(QEMUFile *f)
> > -{
> > -    trace_savevm_send_colo_enable();
> > -    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
> > -}
> > -
> >  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
> >  {
> >      uint32_t buf;
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 125a2507b7279412bcb0745b95a774874c31c54f..0a1e5bfd1ca125565a4c90c=
6f31b2f8c94404117 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -62,7 +62,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *=
f, const char *name,
> >                                             uint16_t len,
> >                                             uint64_t *start_list,
> >                                             uint64_t *length_list);
> > -void qemu_savevm_send_colo_enable(QEMUFile *f);
> >  void qemu_savevm_live_state(QEMUFile *f);
> >  int qemu_save_device_state(QEMUFile *f);
> > =20
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 91d7506634c9f110e8f0b5f9183728058fe6542a..cfd4d58a0f82ec299ca9e8a=
9260dd3c3a210cece 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -37,7 +37,6 @@ savevm_send_ping(uint32_t val) "0x%x"
> >  savevm_send_postcopy_listen(void) ""
> >  savevm_send_postcopy_run(void) ""
> >  savevm_send_postcopy_resume(void) ""
> > -savevm_send_colo_enable(void) ""
> >  savevm_send_recv_bitmap(char *name) "%s"
> >  savevm_send_switchover_start(void) ""
> >  savevm_state_setup(void) ""
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/rI0v=WPRYyw9VzYAF88fl=0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmLMqoACgkQNasLKJxd
sljoGxAAlVK0If33CmrI7NGM28o0WZ32B0jlv7aPjxSVbS2pUy3zSi+ESVdczHDW
MJH4BRWkAD9xHoMVImwGD1GFA4N06Nqu3oi/lJ3V8g2ylcgrrS/xyPbPf0Vn0wWE
zmMvK65eDyq5j6JgTi5o0fUpKJJTl0BpEeFY53hc9el7qKiI8KBoLWWgBb/Oxuki
vzdt+o0OYnPWq9d3lM5eQfwRgUqU6prKnpC5Yh1noeqFCA9d8rsMxej84b7yLmqQ
KZ45eVTfXWcpx5UXld6M7yTVA8/bBk9tsSe+GQ7TRjp3MnoSHfiViuHxa2V9XDsP
GVbU7oepXb27fmpUqJ5I2vkOFsoA/QzQY3kMTv7715rgU4nSDnIQ5NNcvHzlQApB
wFPnfp7E0bWETSsn+cKnrR2lbSb6++K+AdMNDboB9HmTklmUiV7F69gHiZsNBKYw
xy1TNp/06WoMwFVZI2uSNS1V664rUOu/7PaJ5AMy9EUQ9HJcCFK8s2yO1Z+OFMDL
Jq6pWMfJO7e9ZFUq/VwQGp1oJgsRr2wxPlc40tXK8pzXwx2WvtIKYejUIjwdoSo+
wb9Qg6QfK7OVxd5hL9e3TUkzzK60x6SOYE9K06myxvpoj3w4Lh2aoI6SvPGVDunS
ugcSjdh9kLk8eVYl7nRwoNUUa8RvvMFL0lwGC1ot6rqR5tq3pyo=
=3h0F
-----END PGP SIGNATURE-----

--Sig_/rI0v=WPRYyw9VzYAF88fl=0--

