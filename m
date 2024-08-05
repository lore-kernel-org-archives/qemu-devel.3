Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCDFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxi5-0001Lh-Hk; Mon, 05 Aug 2024 09:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1saxi3-0001LA-K9
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1saxi1-0003kK-D5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722864307;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMk2xJy+hizaSNo05vyxCc1NUwUMbhmnaaCpVx4gcdg=;
 b=NWin/eGrvgKMeLYZos/2QVkQ6eptITdinK78j4hOV3VngyTxGse9tnGibBP/3i8N7paBqC
 RC4f7+FxpnRpYWrUFEhiVJL8uIu7AlLrObwUcnIs5qHzLb/XOwrDTaFsXHo5SF5Yi3bZUy
 9dDPXp+TGt5WBVc316i/CV4sO5BOYZ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-bi-SYYdMOoi84XMkmQYT6w-1; Mon,
 05 Aug 2024 09:25:04 -0400
X-MC-Unique: bi-SYYdMOoi84XMkmQYT6w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 546701955D48; Mon,  5 Aug 2024 13:25:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8164D1955D42; Mon,  5 Aug 2024 13:25:00 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:24:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 5/6] qapi: apply schema prefix to QAPI feature enum
 constants
Message-ID: <ZrDSqXtiT2U7zS-p@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-6-berrange@redhat.com>
 <87y15bnoq0.fsf@pond.sub.org> <ZrDGoSTUIcpaVGO8@redhat.com>
 <87a5hrm7wv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87a5hrm7wv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 05, 2024 at 03:11:12PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Mon, Aug 05, 2024 at 02:22:47PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >>=20
> >> > This allows us to include multiple QAPI schemas in the same file.
> >> >
> >> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>=20
> >> I figure you had reason to simultaneously include headers generated for
> >> multiple schemas.  Do tell :)
> >
> > I didn't want to have this patch, but the unit tests do this :-(
> >
> > [2/37] Compiling C object tests/libtestqapi.a.p/meson-generated_.._test=
-qapi-commands-sub-sub-module.c.o
> > FAILED: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub=
-sub-module.c.o=20
> > cc -m64 -Itests/libtestqapi.a.p -Itests -I../tests -I. -Iqapi -Itrace -=
Iui -Iui/shader -Itests/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2=
=2E0/include -I/usr/include/sysprof-6 -fdiagnostics-color=3Dauto -Wall -Win=
valid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body=
 -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wign=
ored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-att=
ribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-=
style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wt=
ype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psa=
bi -Wno-shift-negative-value -isystem /var/home/berrange/src/virt/qemu/linu=
x-headers -isystem linux-headers -iquote . -iquote /var/home/berrange/src/v=
irt/qemu -iquote /var/home/berrange/src/virt/qemu/include -iquote /var/home=
/berrange/src/virt/qemu/host/include/x86_64 -iquote /var/home/berrange/src/=
virt/qemu/host/include/generic -iquote /var/home/berrange/src/virt/qemu/tcg=
/i386 -pthread -msse2 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARG=
EFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-in=
it=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -MD -MQ tests/libtestqapi.=
a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o -MF tests/libt=
estqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o.d -o t=
ests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c=
=2Eo -c tests/test-qapi-commands-sub-sub-module.c
> > In file included from tests/test-qapi-types-sub-sub-module.h:17,
> >                  from tests/test-qapi-visit-sub-sub-module.h:17,
> >                  from tests/test-qapi-commands-sub-sub-module.c:19:
> > tests/test-qapi-features.h:16:5: error: redeclaration of enumerator =E2=
=80=98QAPI_FEATURE_DEPRECATED=E2=80=99
> >    16 |     QAPI_FEATURE_DEPRECATED,
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ./qapi/qapi-types-error.h:17,
> >                  from /var/home/berrange/src/virt/qemu/include/qapi/err=
or.h:275,
> >                  from /var/home/berrange/src/virt/qemu/include/qapi/com=
pat-policy.h:16,
> >                  from tests/test-qapi-commands-sub-sub-module.c:14:
> > ./qapi/qapi-features.h:16:5: note: previous definition of =E2=80=98QAPI=
_FEATURE_DEPRECATED=E2=80=99 with type =E2=80=98enum <anonymous>=E2=80=99
> >    16 |     QAPI_FEATURE_DEPRECATED,
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~
> > ninja: build stopped: subcommand failed.
> > make[1]: *** [Makefile:167: run-ninja] Error 1
> > make[1]: Leaving directory '/var/home/berrange/src/virt/qemu/build'
> > make: *** [GNUmakefile:6: build] Error 2
>=20
> Compiles for me with PATCH 5/6 taken out.  What am I doing wrong?

The bit in patch 6 which generates the enum still has the prefix:

+        self._genh.add("typedef enum {\n")
+        for name in features:
+            self._genh.add(f"    {c_enum_const(self._prefix + 'QAPI_FEATUR=
E', name)},\n")
+
+        self._genh.add("} " + c_name(self._prefix + 'QapiFeature') + ";\n")


>=20
> > I would be nice to eliminate that, but some parts of the test appear
> > to pull in more of the system emulator code which forces in the main
> > qapi schema
> >
> > n file included from ./qapi/qapi-types-block-core.h:17,
> >                  from /var/home/berrange/src/virt/qemu/include/block/bl=
ock-common.h:27,
> >                  from /var/home/berrange/src/virt/qemu/include/block/bl=
ock-global-state.h:27,
> >                  from /var/home/berrange/src/virt/qemu/include/block/bl=
ock.h:27,
> >                  from /var/home/berrange/src/virt/qemu/include/monitor/=
monitor.h:4,
> >                  from /var/home/berrange/src/virt/qemu/include/qapi/qmp=
/dispatch.h:17,
> >                  from tests/test-qapi-init-commands.h:16,
> >                  from tests/test-qapi-init-commands.c:15:
> > ./qapi/qapi-features.h:16:5: error: redeclaration of enumerator =E2=80=
=98QAPI_FEATURE_DEPRECATED=E2=80=99
> >    16 |     QAPI_FEATURE_DEPRECATED,
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~
> > In file included from tests/include/../test-qapi-types-sub-sub-module.h=
:17,
> >                  from tests/include/../test-qapi-commands-sub-sub-modul=
e.h:16,
> >                  from tests/include/test-qapi-commands-sub-module.h:16,
> >                  from tests/test-qapi-commands.h:16,
> >                  from tests/test-qapi-init-commands.c:14:
> > tests/include/../test-qapi-features.h:16:5: note: previous definition o=
f =E2=80=98QAPI_FEATURE_DEPRECATED=E2=80=99 with type =E2=80=98enum <anonym=
ous>=E2=80=99
> >    16 |     QAPI_FEATURE_DEPRECATED,
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~
> > tests/test-qapi-init-commands.c: In function =E2=80=98test_qmp_init_mar=
shal=E2=80=99:
> > tests/test-qapi-init-commands.c:64:71: error: =E2=80=98TEST_QAPI_FEATUR=
E_DEPRECATED=E2=80=99 undeclared (first use in this function); did you mean=
 =E2=80=98QAPI_FEATURE_DEPRECATED=E2=80=99?
> >    64 |                          qmp_marshal_test_command_features1, 0,=
 1u << TEST_QAPI_FEATURE_DEPRECATED);
> >       |                                                                =
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                                                                =
       QAPI_FEATURE_DEPRECATED
> > tests/test-qapi-init-commands.c:64:71: note: each undeclared identifier=
 is reported only once for each function it appears in
> >
> >
> > Maybe the test needs to be split into two ?  One test exclusively testi=
ng
> > with the tests/qapi-schema/qapi-schema-test.json, and one test exclusiv=
ely
> > with the main QMP QAPI schema ?
>=20
> Which test is it?

I'm unclear which is using this - its just failing with plain 'make' for
me.

With regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


