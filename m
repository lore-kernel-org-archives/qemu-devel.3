Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E4AD6D234
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWFsR-0006OJ-5P; Thu, 18 Dec 2025 10:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWFsP-0006O6-IL
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWFsN-0001Hi-KB
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766071509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkZdLhvGKYJIQ9mQ52zBj/lUTmPMNVXFh8itxvsx6h8=;
 b=cpBPdTOqILpLA5+yQoVgUEsN2J2KfaTbU2pH2rQKDrbYOzX5Hfc1R/SLq1z2UD2BPvLr8X
 5R4al+NAasXz5xr9MJQAAHwAUrE/6QY4hOTMFyC9v1arNSLvfhs8hPXB2mPjDql5LNBRPf
 qaPTilbrFcHdFiBoQnw6SNhwqYEajb8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-Sz_ah9tGN8yyR_uuzEnC8Q-1; Thu,
 18 Dec 2025 10:25:07 -0500
X-MC-Unique: Sz_ah9tGN8yyR_uuzEnC8Q-1
X-Mimecast-MFC-AGG-ID: Sz_ah9tGN8yyR_uuzEnC8Q_1766071505
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F815180062B
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 15:25:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE603180049F
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 15:25:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1095321E6A27; Thu, 18 Dec 2025 16:25:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: Report on MAINTAINERS coverage
In-Reply-To: <288b1dae-68c5-4b48-ab08-62a7b08245ea@redhat.com> (Thomas Huth's
 message of "Thu, 18 Dec 2025 15:06:00 +0100")
References: <87h5toc61n.fsf@pond.sub.org> <aUP5znRDyuBlpGvW@redhat.com>
 <871pkrdi6w.fsf@pond.sub.org> <aUQGWes2pCSWTDfe@redhat.com>
 <288b1dae-68c5-4b48-ab08-62a7b08245ea@redhat.com>
Date: Thu, 18 Dec 2025 16:25:02 +0100
Message-ID: <87sed7ak35.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 18/12/2025 14.49, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Dec 18, 2025 at 02:37:43PM +0100, Markus Armbruster wrote:
>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>
>>>> On Thu, Dec 18, 2025 at 01:45:24PM +0100, Markus Armbruster wrote:
>>>>> Which unmaintained files are we still changing?  Unmaintained files
>>>>> sorted by number of commits in the past year (since v9.2.0):
>>>>>
>>>>>      $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-l=
ist v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort =
-rn
>>>>>
>>>>>      107 tests/functional/meson.build
>>>>
>>>> Opps, that's a mistake. It should of course be under the
>>>> general maint heading "Functional testing framework"
>>>
>>> Thanks!  I can patch that.
>>>
>>> What about the other uncovered files in tests/functional/?
>>=20
>>> tests/functional/aarch64/meson.build
>>=20
>> [snip many more]
>>=20
>> I'd wildcard   tests/functional/*/meson.build under the
>> general maint.
>
> Either that, or make sure the the architecture maintainers own the whole=
=20
> tests/functional/<arch> folders.

The former is easy.  Regarding the latter...

The MAINTAINERS section we use to cover an architecture is often less
than obvious.

meson.build under tests/functional/ covered so far:

    tests/functional/alpha/meson.build      Alpha TCG CPUs
    tests/functional/avr/meson.build        AVR TCG CPUs
    tests/functional/hppa/meson.build       HP B160L, HP C3700
    tests/functional/i386/meson.build       X86 general architecture support
    tests/functional/riscv32/meson.build    RISC-V TCG CPUs
    tests/functional/riscv64/meson.build    RISC-V TCG CPUs
    tests/functional/s390x/meson.build      S390 Virtio-ccw
    tests/functional/x86_64/meson.build     X86 general architecture support

We have "$ARCH general architecture support" (obvious enough), "$ARCH
TCG CPUs" (meh), and even machine sections that happen to be the only
one of this architecture in MAINTAINERS (meh^2).

Thomas, should tests/functional/s390x/meson.build move to "S390 general
architecture support"?

Not covered:

    tests/functional/aarch64/meson.build
    tests/functional/arm/meson.build

        There is no ARM general architecture support section.  Add these
        to ARM TCG CPUs?

    tests/functional/generic/meson.build

        Functional testing framework?

    tests/functional/loongarch64/meson.build

        LoongArch TCG CPUs?

    tests/functional/m68k/meson.build

        M68K TCG CPUs?

    tests/functional/meson.build

        Functional testing framework, as discussed above.

    tests/functional/microblaze/meson.build
    tests/functional/microblazeel/meson.build

        MicroBlaze TCG CPUs?

    tests/functional/mips/meson.build
    tests/functional/mips64/meson.build
    tests/functional/mips64el/meson.build
    tests/functional/mipsel/meson.build

        We have MIPS general architecture support.  I guess we can add
        them there.

    tests/functional/or1k/meson.build

        OpenRISC TCG CPUs?

    tests/functional/ppc/meson.build
    tests/functional/ppc64/meson.build

        PowerPC TCG CPUs?

    tests/functional/rx/meson.build

        RENESAS RX CPUs?

    tests/functional/sh4/meson.build
    tests/functional/sh4eb/meson.build

        SH4 TCG CPUs?

    tests/functional/sparc/meson.build
    tests/functional/sparc64/meson.build

        SPARC TCG CPUs?

    tests/functional/xtensa/meson.build

        Xtensa TCG CPUs?

>>> tests/functional/acpi-bits/bits-config/bits-cfg.txt
>>> tests/functional/acpi-bits/bits-tests/smbios.py2
>>> tests/functional/acpi-bits/bits-tests/smilatency.py2
>>> tests/functional/acpi-bits/bits-tests/testacpi.py2
>>> tests/functional/acpi-bits/bits-tests/testcpuid.py2
>>=20
>> I expected those to already be covered by:
>>=20
>>    ACPI/FUNCTIONAL/BIOSBITS
>>    M: Ani Sinha <anisinha@redhat.com>
>>    M: Michael S. Tsirkin <mst@redhat.com>
>>    S: Supported
>>    F: tests/functional/acpi-bits/*
>>    F: tests/functional/x86_64/test_acpi_bits.py
>>    F: docs/devel/testing/acpi-bits.rst
>>=20
>> but I guess tests/functional/acpi-bits/*  doesn't recurse
>> into subdirs ?
>
> I think we simply have to drop the "*" at the end here.

Yes, that does the trick.

>>> tests/functional/arm/test_max78000fthr.py
>>=20
>> Added by Thomas but not sure what maintainers category it should go
>> under.
>
> No, I just moved the file around. This belongs to the "max78000fthr" arm=
=20
> machine - we need a complete new entry in MAINTAINERS for that one if I g=
et=20
> this right.

Which files?  My best guess based on git history:

    docs/system/arm/max78000.rst
    hw/misc/max78000_aes.c
    hw/misc/max78000_gcr.c
    hw/misc/max78000_icc.c
    hw/misc/max78000_trng.c
    include/hw/arm/max78000_soc.h
    include/hw/misc/max78000_aes.h
    include/hw/misc/max78000_gcr.h
    include/hw/misc/max78000_icc.h
    include/hw/misc/max78000_trng.h
    tests/functional/arm/test_max78000fthr.py

All by Jackson Donaldson <jackson88044@gmail.com>.


