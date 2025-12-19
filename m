Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5534AD74965
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWW5U-0006uQ-JG; Fri, 19 Dec 2025 03:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWW5R-0006ts-20
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWW5P-0005cn-DV
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766133820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB+otCePS152F2Ujf+IoHyuMUeBkkreNeZF/migVD3A=;
 b=Zud5s+v+osNJZlYJl9/7tQxLucdANjjCAzUKwLBqgikCIGSxlRD5fqdvkZhMJl3DPJ1XPs
 x+NtskGEN+vyhyeoeY7K3hwD29D+x8IXOk4NAWwLgemz3LGxbm+ObnDwNoS3tUVaSrgSLV
 GKLFIoosEI/Dr/QjYAnA78JYKOPzePs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-thzsZS-ZPR64JgUUgkTgEw-1; Fri,
 19 Dec 2025 03:43:37 -0500
X-MC-Unique: thzsZS-ZPR64JgUUgkTgEw-1
X-Mimecast-MFC-AGG-ID: thzsZS-ZPR64JgUUgkTgEw_1766133816
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FC8318D95CF
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:43:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E89194C65A
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:43:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90C6121E6A27; Fri, 19 Dec 2025 09:43:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: Report on MAINTAINERS coverage
In-Reply-To: <4a47b7bf-422a-4201-a060-0e437f4e4cc3@redhat.com> (Thomas Huth's
 message of "Thu, 18 Dec 2025 17:08:09 +0100")
References: <87h5toc61n.fsf@pond.sub.org> <aUP5znRDyuBlpGvW@redhat.com>
 <871pkrdi6w.fsf@pond.sub.org> <aUQGWes2pCSWTDfe@redhat.com>
 <288b1dae-68c5-4b48-ab08-62a7b08245ea@redhat.com>
 <87sed7ak35.fsf@pond.sub.org>
 <4a47b7bf-422a-4201-a060-0e437f4e4cc3@redhat.com>
Date: Fri, 19 Dec 2025 09:43:28 +0100
Message-ID: <87a4ze7tfz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 18/12/2025 16.25, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 18/12/2025 14.49, Daniel P. Berrang=C3=A9 wrote:
>>>> On Thu, Dec 18, 2025 at 02:37:43PM +0100, Markus Armbruster wrote:
>>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>>
>>>>>> On Thu, Dec 18, 2025 at 01:45:24PM +0100, Markus Armbruster wrote:
>>>>>>> Which unmaintained files are we still changing?  Unmaintained files
>>>>>>> sorted by number of commits in the past year (since v9.2.0):
>>>>>>>
>>>>>>>       $ for i in `cat unmaintained-files`; do echo -n "$i "; git-re=
v-list v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | so=
rt -rn
>>>>>>>
>>>>>>>       107 tests/functional/meson.build
>>>>>>
>>>>>> Opps, that's a mistake. It should of course be under the
>>>>>> general maint heading "Functional testing framework"
>>>>>
>>>>> Thanks!  I can patch that.
>>>>>
>>>>> What about the other uncovered files in tests/functional/?
>>>>
>>>>> tests/functional/aarch64/meson.build
>>>>
>>>> [snip many more]
>>>>
>>>> I'd wildcard   tests/functional/*/meson.build under the
>>>> general maint.
>>>
>>> Either that, or make sure the the architecture maintainers own the whole
>>> tests/functional/<arch> folders.
>>=20
>> The former is easy.  Regarding the latter...
>>=20
>> The MAINTAINERS section we use to cover an architecture is often less
>> than obvious.
>>=20
>> meson.build under tests/functional/ covered so far:
>>=20
>>      tests/functional/alpha/meson.build      Alpha TCG CPUs
>>      tests/functional/avr/meson.build        AVR TCG CPUs
>>      tests/functional/hppa/meson.build       HP B160L, HP C3700
>>      tests/functional/i386/meson.build       X86 general architecture su=
pport
>>      tests/functional/riscv32/meson.build    RISC-V TCG CPUs
>>      tests/functional/riscv64/meson.build    RISC-V TCG CPUs
>>      tests/functional/s390x/meson.build      S390 Virtio-ccw
>>      tests/functional/x86_64/meson.build     X86 general architecture su=
pport
>>=20
>> We have "$ARCH general architecture support" (obvious enough), "$ARCH
>> TCG CPUs" (meh), and even machine sections that happen to be the only
>> one of this architecture in MAINTAINERS (meh^2).
>
> Yes, it's ugly, but that's basically what we currently have in MAINTAINER=
S,=20
> I think.
>
>> Thomas, should tests/functional/s390x/meson.build move to "S390 general
>> architecture support"?
>
> It doesn't matter much since there is currently only one single machine f=
or=20
> s390x, and that's this S390 virtio-ccw machine.

Different maintainers, though.=20=20

I'll leave it alone.

>> Not covered:
>>=20
>>      tests/functional/aarch64/meson.build
>>      tests/functional/arm/meson.build
>>=20
>>          There is no ARM general architecture support section.  Add these
>>          to ARM TCG CPUs?
>
> That's the best solution, I think.
>
>>      tests/functional/generic/meson.build
>>=20
>>          Functional testing framework?
>
> Yes, please.
>
>>      tests/functional/loongarch64/meson.build
>>=20
>>          LoongArch TCG CPUs?
>
> Yes.
>
>>      tests/functional/m68k/meson.build
>>=20
>>          M68K TCG CPUs?
>
> Yes.
>
>>      tests/functional/meson.build
>>=20
>>          Functional testing framework, as discussed above.
>
> Yes.
>
>>      tests/functional/microblaze/meson.build
>>      tests/functional/microblazeel/meson.build
>>=20
>>          MicroBlaze TCG CPUs?
>
> Yes.
>
>>      tests/functional/mips/meson.build
>>      tests/functional/mips64/meson.build
>>      tests/functional/mips64el/meson.build
>>      tests/functional/mipsel/meson.build
>>=20
>>          We have MIPS general architecture support.  I guess we can add
>>          them there.
>
> Sounds right.
>
>>      tests/functional/or1k/meson.build
>>=20
>>          OpenRISC TCG CPUs?
>
> Yes.
>
>>      tests/functional/ppc/meson.build
>>      tests/functional/ppc64/meson.build
>>=20
>>          PowerPC TCG CPUs?
>
> Yes.
>
>>      tests/functional/rx/meson.build
>>=20
>>          RENESAS RX CPUs?
>
> Yes, though it's orphan, so it won't help much.
>
>>      tests/functional/sh4/meson.build
>>      tests/functional/sh4eb/meson.build
>>=20
>>          SH4 TCG CPUs?
>
> Yes.
>
>>      tests/functional/sparc/meson.build
>>      tests/functional/sparc64/meson.build
>>=20
>>          SPARC TCG CPUs?
>
> Yes.
>
>>      tests/functional/xtensa/meson.build
>>=20
>>          Xtensa TCG CPUs?
>
> Yes.

I'll post a patch for these.

>>>>> tests/functional/arm/test_max78000fthr.py
>>>>
>>>> Added by Thomas but not sure what maintainers category it should go
>>>> under.
>>>
>>> No, I just moved the file around. This belongs to the "max78000fthr" arm
>>> machine - we need a complete new entry in MAINTAINERS for that one if I=
 get
>>> this right.
>>=20
>> Which files?  My best guess based on git history:
>>=20
>>      docs/system/arm/max78000.rst
>>      hw/misc/max78000_aes.c
>>      hw/misc/max78000_gcr.c
>>      hw/misc/max78000_icc.c
>>      hw/misc/max78000_trng.c
>>      include/hw/arm/max78000_soc.h
>>      include/hw/misc/max78000_aes.h
>>      include/hw/misc/max78000_gcr.h
>>      include/hw/misc/max78000_icc.h
>>      include/hw/misc/max78000_trng.h
>>      tests/functional/arm/test_max78000fthr.py
>
> You missed:
>
>      hw/arm/max78000fthr.c
>      hw/arm/max78000_soc.c

No idea how I missed them, git-log shows them.

> Maybe simply use hw/*/max78000* and include/hw/*/max78000* to cover most =
of=20
> the files?

Yup.

I asked the author whether he's willing to serve as maintainer.


