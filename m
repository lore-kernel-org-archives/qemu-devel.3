Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B30EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 20:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tONPF-0002Vh-Pc; Thu, 19 Dec 2024 15:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tONPD-0002VX-RP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tONPC-0003OS-9S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734641157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WKV6j8ZtYAeagBcpxmXK9hLRRr2rST/QYsTauSVB9s=;
 b=TJTp0z8g1jO+sJds2dPjYgoEFSnEPmHJA/byqJgbOpWB5QGCpZ8DFEbc2C5Hh3TljGa+Oq
 O9cKCpeC1GEbUihB/GY505sFK586W2i5BIRG/uEjMYa95ejDMUL9d46D9y+ivlxQACzb79
 KmyrsgN+q3+xVVVgp+hptoj+Du3ZKqQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-X1Cpwa_tOZS_0OMqe5-Gjg-1; Thu,
 19 Dec 2024 15:45:53 -0500
X-MC-Unique: X1Cpwa_tOZS_0OMqe5-Gjg-1
X-Mimecast-MFC-AGG-ID: X1Cpwa_tOZS_0OMqe5-Gjg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C38E19560B2; Thu, 19 Dec 2024 20:45:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.70])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94EBD30044C1; Thu, 19 Dec 2024 20:45:50 +0000 (UTC)
Date: Thu, 19 Dec 2024 15:45:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/39] riscv-to-apply queue
Message-ID: <20241219204549.GA724589@fedora>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+UZF0ogYatnLodhi"
Content-Disposition: inline
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--+UZF0ogYatnLodhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alistair,
Please take a look at the following CI failure:

x86_64-w64-mingw32-gcc -m64 -Ilibqemuutil.a.p -I. -I.. -Iqapi -Itrace -Iui =
-Iui/shader -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/us=
r/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w64-=
mingw32/sys-root/mingw/include/p11-kit-1 -fdiagnostics-color=3Dauto -Wall -=
Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-b=
ody -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -W=
ignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-=
attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wo=
ld-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes =
-Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-=
psabi -Wno-shift-negative-value -iquote . -iquote /builds/qemu-project/qemu=
 -iquote /builds/qemu-project/qemu/include -iquote /builds/qemu-project/qem=
u/host/include/x86_64 -iquote /builds/qemu-project/qemu/host/include/generi=
c -iquote /builds/qemu-project/qemu/tcg/i386 -mms-bitfields -mcx16 -msse2 -=
D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-alias=
ing -fno-common -fwrapv -fno-pie -no-pie -ftrivial-auto-var-init=3Dzero -fz=
ero-call-used-regs=3Dused-gpr -mms-bitfields -pthread -mms-bitfields -MD -M=
Q libqemuutil.a.p/meson-generated_.._trace_trace-hw_riscv.c.obj -MF libqemu=
util.a.p/meson-generated_.._trace_trace-hw_riscv.c.obj.d -o libqemuutil.a.p=
/meson-generated_.._trace_trace-hw_riscv.c.obj -c trace/trace-hw_riscv.c
In file included from trace/trace-hw_riscv.c:5:
=2E./hw/riscv/trace-events: In function '_nocheck__trace_riscv_iommu_sys_ms=
i_sent':
=2E./hw/riscv/trace-events:19:22: error: format '%lx' expects argument of t=
ype 'long unsigned int', but argument 6 has type 'uint64_t' {aka 'long long=
 unsigned int'} [-Werror=3Dformat=3D]
   19 | riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32=
_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_dat=
a 0x%x result %u"
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=2E.....
=2E./hw/riscv/trace-events:19:22: error: format '%lx' expects argument of t=
ype 'long unsigned int', but argument 3 has type 'uint64_t' {aka 'long long=
 unsigned int'} [-Werror=3Dformat=3D]
   19 | riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32=
_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_dat=
a 0x%x result %u"
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~                   =
                                                           ~~~~~~~~
      |                                                                    =
                                                           |
      |                                                                    =
                                                           uint64_t {aka lo=
ng long unsigned int}
cc1: all warnings being treated as errors

https://gitlab.com/qemu-project/qemu/-/jobs/8691704969#L2578

Once the issue has been solved, please send a new revision of this pull
request.

Thanks,
Stefan

--+UZF0ogYatnLodhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdkhf0ACgkQnKSrs4Gr
c8iXHgf/fj9jXWVRTBR9cZ5NGew6Ly1mAeDI3DDLJNi4lChFMk8lKKlFnRQWJumS
OrQyUam8N7os5ngzNrgZeReuCBehjz/VOj9214t0jkbh4p6Wz1bPE7sDmo+W264+
7b7yCNzChmZyZOGH37zH+zjNOJi5LnD7ViZjC3qFC7V1DH4S0Pp428db4xts3Cz8
NhlqeL3Jkh/HRDqm+YKy626onqju9CqSUG9mURFpnonVcqZlG8GqdmhLbVHmxv60
AoUjkeD9XNTys2NmlXIoKbebG0kXSg9dBUNBDggCz1m8d28kdFkvLYMB8e2UZ7gj
eflHmqiGMHEE/wjaATNpVf4eAwRwcw==
=9hPE
-----END PGP SIGNATURE-----

--+UZF0ogYatnLodhi--


