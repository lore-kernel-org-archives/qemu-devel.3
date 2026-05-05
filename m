Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A3FCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIhq-00021v-KI; Tue, 05 May 2026 12:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIhj-00020z-Ly
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIha-00053v-1C
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777998760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tprvENamPh4m1tDtsOs7ttix38gqVQeUM63jn9Wac0Q=;
 b=UnHHZZXbZhxXjwvsHXk6NbuEdtLBTBa/dLUGzZPbfYa2TCIWozIXPDX3kXcGkAitLIDeZY
 w+ahfmyZhJoMEHwBP2meLjgMAqQKGsmPanJPWBKgfnWOigIQ7OtHs/ISNASDvwn81x+RE/
 r26Wa8HkUD2KmWZFTaxo+ekMphutZOM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-vsLvpXxpPUOX67sq6QR4-w-1; Tue, 05 May 2026 12:32:39 -0400
X-MC-Unique: vsLvpXxpPUOX67sq6QR4-w-1
X-Mimecast-MFC-AGG-ID: vsLvpXxpPUOX67sq6QR4-w_1777998759
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b552610488so74334376d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777998758; x=1778603558; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tprvENamPh4m1tDtsOs7ttix38gqVQeUM63jn9Wac0Q=;
 b=ouKE3Zp3T600axf6gEeg211tJb563QlT7EM7vOgceHwc3t7CP72S0CH2oj+UUL/m7L
 ObtBgpDoou17FLr1if2HPSBZPwx2LbMnDfGQOrAKoGfDs3SCuoxWk493WtbfOmRqDAVo
 RgYz+EjW88iZJqtO37+LJ6A7xuEwR6WtVIXLNTgX8Uzy4OISqLND6NsY7a9I8ojanjn2
 t5HPdsw+2sWiAptVkb1GddZRVzVDcwP2ps6kktibVPgFssPjfiQW5d4xR7rDj8wZ/i9c
 8deYWIlYeg4OsmgZfR+Zz/doyWo0Be3jzgwDsjiV8d0u9Qth0Uf3wisvvbx9yz0EFI5F
 cLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777998759; x=1778603559;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tprvENamPh4m1tDtsOs7ttix38gqVQeUM63jn9Wac0Q=;
 b=CPbK5h/7UP8GPk1BtFm6UDFNzwv2PW7EOJ00ynYhuksVdGNVE31QnnRN0wlaC3IjbY
 KJ3Sp+JxA85ndntGDAmh2XwwXldL81NI0uMEoZQFQub+mXgHa4yP2Ailp5O+7QtfP9UN
 pew4Xa+oDWZFzLRMIXCYHLHgWNLAp3W9uO2AtG/q4koCM79/rKe+08NbeKImwTEsrel/
 +3BnugAVssERUUm4u7+W3nX0kZxFQfZ71nYQ3LgSA1YsKh6uRnrlGEPQ/icQX0NL//ev
 wvqJaBD2vqZ3EPqoY1pP3YLFVLRO/fIWSD13Brwixowrehk6USx0d7HUwLBk2VEkEGkm
 0TAA==
X-Gm-Message-State: AOJu0Ywnqa3BY/lSyojAOciUgBfA+RIDoIqzOZEA8aOA0rHC4RkHT9Fg
 /lJerjupiqr7YgC27kOUa8Bn298y7Oess9VKrJHN00ihSkpLtf9/zPRnBt+CWdsWduUYgIPJJgN
 Dod8FT10gknefO33PrCEEqXNQ241y7ypV69rIGiWb3IDuZ3TIxZs5am+V
X-Gm-Gg: AeBDievNXlX0VY1oSUzcIVY6wkxelW/kDX6g6dbH8y5AvLbXB8+2cjpb+eX4aPUyJFZ
 bifqMqG92Mkm5g12FV9Vp0AUlUJyg5XZ209NuvCZQqHofXdITHpy23g7XLh0USPDINjSAOU9duu
 Mbd9Nt47UIsTwDlrAhuCkt+byK4a8gJRGDr13ijtiuAlJVq9zoUGM+M7WziFl0pp9KGl/xa5Phm
 keF1OrF7vKkJngHHROfk/Ub/7y10vgrlRZPvSx1bMm+SQpHYCRWiqjJyiLCJLc/N9jCfMIezFs0
 qo2B+M25m1dM5EPvNAixgAkEYpNKA9hCHu2vwHWRGAt1FYPZUc4roJgKL2MADYsYn5VTAN9vgx4
 A/cerW7FdBrw/4IGpc9M70nQePGyUaE20UMeRaAva6nouKgCYpT2SirbRqA==
X-Received: by 2002:a05:6214:5888:b0:899:fb4e:47aa with SMTP id
 6a1803df08f44-8b668c12cfbmr231640796d6.39.1777998758417; 
 Tue, 05 May 2026 09:32:38 -0700 (PDT)
X-Received: by 2002:a05:6214:5888:b0:899:fb4e:47aa with SMTP id
 6a1803df08f44-8b668c12cfbmr231639406d6.39.1777998757107; 
 Tue, 05 May 2026 09:32:37 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b5391e3636sm160014436d6.13.2026.05.05.09.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:32:36 -0700 (PDT)
Date: Tue, 5 May 2026 12:32:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix A-B file build
Message-ID: <afobo6vVUd2Pga76@x1.local>
References: <20260429231025.30818-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260429231025.30818-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 29, 2026 at 08:10:25PM -0300, Fabiano Rosas wrote:
> The generation of the guest workloads for migration-test is all
> broken:
>=20
> 1) We moved code around and forgot to update the includes from the guest
> workloads at qtest/migration/<ARCH>/.
>=20
> 2) Since this code doesn't build by default due to the need for cross
> compilation, we also broke the s390x code entirely by removing the
> libc implementation from sclp.c.
>=20
> 3) The build adds a blank line at the end of the header files due to
> how the sed command used to remove extra variable declarations is
> written.
>=20
> 4) Must be too long since we last built this thing that powerpc
> compilers would output BE by default. Nowadays we need -mbig-endian to
> force it.
>=20
> 5) Format of comments needs fixing to please checkpatch.
>=20
> Fix everything. Most changes are trivial, except for s390x where I had
> to reimplement some of the routines from sclp.c. Compiling that object
> file in doesn't work because of its various includes that this
> standalone code can't provide.
>=20
> Testing this change (assuming x86 host):
> $ cd build
> $ pushd tests/qtest/migration
> $ make clean
> $ make i386
> $ make CROSS_PREFIX=3Dyour-favorite-cross-compiler- s390x
> $ make CROSS_PREFIX=3Dyour-favorite-cross-compiler- aarch64
> $ make CROSS_PREFIX=3Dyour-favorite-cross-compiler- ppc64
> $ popd
> $ make -j$(nproc) # must build the tests again
> $ QTEST_QEMU_BINARY=3D./qemu-system-<ARCH> migration-test
>=20
> Fixes: 9f4278837d ("pc-bios/s390-ccw: Use the libc from SLOF and remove s=
clp prints")
> Fixes: e1803dabdc ("tests/qtest/migration: Move common test code")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Since things are essentially broken, I queued this one directly.  However I
don't have any knowledge to review the s390 changes, please s390x
developers do so and if things need change we can do follow ups.

I did test all these and they work.  One thing to mention below,

> ---
>  tests/qtest/migration/Makefile             |  11 +-
>  tests/qtest/migration/aarch64/Makefile     |   4 +-
>  tests/qtest/migration/aarch64/a-b-kernel.S |   2 +-
>  tests/qtest/migration/aarch64/a-b-kernel.h |   7 +-
>  tests/qtest/migration/bootfile.h           |  11 +
>  tests/qtest/migration/i386/Makefile        |   4 +-
>  tests/qtest/migration/i386/a-b-bootblock.S |   2 +-
>  tests/qtest/migration/i386/a-b-bootblock.h |   8 +-
>  tests/qtest/migration/ppc64/Makefile       |   6 +-
>  tests/qtest/migration/ppc64/a-b-kernel.S   |   2 +-
>  tests/qtest/migration/ppc64/a-b-kernel.h   |   8 +-
>  tests/qtest/migration/s390x/Makefile       |   8 +-
>  tests/qtest/migration/s390x/a-b-bios.c     |  66 ++-
>  tests/qtest/migration/s390x/a-b-bios.h     | 609 +++++++++++++--------

I somehow generated different a-b-bios.h for s390x after cross-make.  But I
verified both versions of s390x_elf[] work here.

My gut feeling is it is a compiler difference causing different code
generated, even if there's no real functional difference.

My "your-favorite-cross-compiler-" dumps this:

$ s390x-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3D/usr/bin/s390x-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/s390x-linux-gnu/15/lto-wrapper
Target: s390x-linux-gnu
Configured with: ../gcc-15.2.1-20250808/configure --bindir=3D/usr/bin --bui=
ld=3Dx86_64-redhat-linux-gnu --datadir=3D/usr/share --disable-decimal-float=
 --disable-dependency-tracking --disable-gold --disable-libgcj --disable-li=
bgomp --disable-libmpx --disable-libquadmath --disable-libssp --disable-lib=
unwind-exceptions --disable-shared --disable-silent-rules --disable-sjlj-ex=
ceptions --disable-threads --with-ld=3D/usr/bin/s390x-linux-gnu-ld --enable=
-__cxa_atexit --enable-checking=3Drelease --enable-gnu-unique-object --enab=
le-initfini-array --enable-languages=3Dc,c++ --enable-linker-build-id --ena=
ble-lto --enable-nls --enable-obsolete --enable-plugin --enable-targets=3Da=
ll --exec-prefix=3D/usr --host=3Dx86_64-redhat-linux-gnu --includedir=3D/us=
r/include --infodir=3D/usr/share/info --libexecdir=3D/usr/libexec --localst=
atedir=3D/var --mandir=3D/usr/share/man --prefix=3D/usr --program-prefix=3D=
s390x-linux-gnu- --sbindir=3D/usr/bin --sharedstatedir=3D/var/lib --sysconf=
dir=3D/etc --target=3Ds390x-linux-gnu --with-bugurl=3Dhttp://bugzilla.redha=
t.com/bugzilla/ --with-gcc-major-version-only --with-isl --with-newlib --wi=
th-plugin-ld=3D/usr/bin/s390x-linux-gnu-ld --with-sysroot=3D/usr/s390x-linu=
x-gnu/sys-root --with-system-libunwind --with-system-zlib --without-headers=
 --with-arch=3DzEC12 --with-tune=3Dz13 --enable-decimal-float --with-long-d=
ouble-128 --enable-gnu-indirect-function --with-linker-hash-style=3Dgnu
Thread model: single
Supported LTO compression algorithms: zlib zstd
gcc version 15.2.1 20250808 (Red Hat Cross 15.2.1-1) (GCC)=20

--=20
Peter Xu


