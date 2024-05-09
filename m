Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC0FC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s547H-0004pL-RZ; Thu, 09 May 2024 09:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s547F-0004on-QG
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s547E-00074u-1H
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715262438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQk3sIE+Iw7PHvJ1+LA8rqbVX+HTOauMzCqOyUEDKSI=;
 b=ey0OY5kZuoaSJrQTRgjXtFWbzGfPyyQQg83XFKnEQVIqgv/0VI186zfFEzPLURC9ieXXka
 z+13fpkXvBaN98uJb2qRN3ShEipu6sPa5T32JmsBYd6WGT7yK7th1Hz7R2v/bLiTTy+XvI
 mwi2EKyzDBG+whH44EvD/TBLUlIweK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-H2sGk2ncOhSJHTE-BwxsHA-1; Thu, 09 May 2024 09:47:15 -0400
X-MC-Unique: H2sGk2ncOhSJHTE-BwxsHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 228D28030B4;
 Thu,  9 May 2024 13:47:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FD3F207AEB2;
 Thu,  9 May 2024 13:47:14 +0000 (UTC)
Date: Thu, 9 May 2024 09:47:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
Message-ID: <20240509134712.GA515599@fedora.redhat.com>
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
 <ZjxKDkZjAitxCasH@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CSp30u6XvKq91i/M"
Content-Disposition: inline
In-Reply-To: <ZjxKDkZjAitxCasH@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--CSp30u6XvKq91i/M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:59:10AM +0800, Zhao Liu wrote:
> On Wed, May 08, 2024 at 02:05:04PM -0400, Stefan Hajnoczi wrote:
> > Date: Wed, 8 May 2024 14:05:04 -0400
> > From: Stefan Hajnoczi <stefanha@gmail.com>
> > Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable
> >  timestamp as WARN
> >=20
> > On Wed, 8 May 2024 at 00:19, Zhao Liu <zhao1.liu@intel.com> wrote:
> > >
> > > In some trace log, there're unstable timestamp breaking temporal
> > > ordering of trace records. For example:
> > >
> > > kvm_run_exit -0.015 pid=3D3289596 cpu_index=3D0x0 reason=3D0x6
> > > kvm_vm_ioctl -0.020 pid=3D3289596 type=3D0xffffffffc008ae67 arg=3D0x7=
ffeefb5aa60
> > > kvm_vm_ioctl -0.021 pid=3D3289596 type=3D0xffffffffc008ae67 arg=3D0x7=
ffeefb5aa60
> > >
> > > Negative delta intervals tend to get drowned in the massive trace log=
s,
> > > and an unstable timestamp can corrupt the calculation of intervals
> > > between two events adjacent to it.
> > >
> > > Therefore, mark the outputs with unstable timestamps as WARN like:
> >=20
> > Why are the timestamps non-monotonic?
> >=20
> > In a situation like that maybe not only the negative timestamps are
> > useless but even some positive timestamps are incorrect. I think it's
> > worth understanding the nature of the instability before merging a
> > fix.
>=20
> I grabbed more traces (by -trace "*" to cover as many events as possible
> ) and have a couple observations:
>=20
> * It's not an issue with kvm's ioctl, and that qemu_mutex_lock/
>   object_dynamic_cast_assert accounted for the vast majority of all
>   exception timestamps.
> * The total exception timestamp occurrence probability was roughly 0.013%
>   (608 / 4,616,938) in a 398M trace file.
> * And the intervals between the "wrong" timestamp and its pre event are
>   almost all within 50ns, even more concentrated within 20ns (there are
>   even quite a few 1~10ns).
>=20
> Just a guess:
>=20
> Would it be possible that a trace event which is too short of an interval,
> and happen to meet a delay in signaling to send to writeout_thread?
>=20
> It seems that this short interval like a lack of real-time guarantees in
> the underlying mechanism...
>=20
> If it's QEMU's own issue, I feel like the intervals should be randomized,
> not just within 50ns...
>=20
> May I ask what you think? Any suggestions for researching this situation
> ;-)

QEMU uses clock_gettime(CLOCK_MONOTONIC) on Linux hosts. The man page
says:

  All CLOCK_MONOTONIC variants guarantee that the time returned by
  consecutive  calls  will  not go backwards, but successive calls
  may=E2=80=94depending  on  the  architecture=E2=80=94return  identical  (=
not-in=E2=80=90
  creased) time values.

trace_record_start() calls clock_gettime(CLOCK_MONOTONIC) so trace events
should have monotonically increasing timestamps.

I don't see a scenario where trace record A's timestamp is greater than
trace record B's timestamp unless the clock is non-monotonic.

Which host CPU architecture and operating system are you running?

Please attach to the QEMU process with gdb and print out the value of
the use_rt_clock variable or add a printf in init_get_clock(). The value
should be 1.

Stefan

--CSp30u6XvKq91i/M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY80+AACgkQnKSrs4Gr
c8iuCQf/WnZZZCB1oH3Ye26zHAJq7ihcDVeLAb8RfF4bifkG0YWmTFHoPYdeWzNN
UAZWBQHO2mIreQhgbogrGHDI9vvyrGEbyJ5g/yy1KaFme6qurEiHI2Po2aJFQzXI
jJ1ZdA0eaJAxKT9WLe5OAC6L0InWi6weX4Yda7BslitFELiWkvFYG8VU+EwP7SEV
hZ6zr+t6drzbj0FBpCKSvmNaQipEsTQZYH/d2Qir8qXStxXAJ1KDbmYzLKMqJz45
+EURusJQKan7ZdZcjM5tv1uca90FEXij5n8qVCe+ZjV0Cpyc+gnSSfTOvGxM64ms
N3nzw45CpTLJIutvWS4AQTGTh1m8ig==
=YOEF
-----END PGP SIGNATURE-----

--CSp30u6XvKq91i/M--


