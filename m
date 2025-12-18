Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8155D68BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWECW-0004nz-Cb; Thu, 18 Dec 2025 08:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWECV-0004mH-Dt
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:37:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWECT-0000Zp-SR
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766065069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wz8CsjLwton2YMtPvNoSs+qoEz82of5wT3W0apQcmnU=;
 b=X+ynf9fE1oJYeRoQDjQJS6klBuj6YA6cTiL9KcX2zTgKWDOiniYj07b2Z5DOWzasQ0wey9
 O58QnJ6kwSN6JKp8RxN9SL6CYfR1BNv3l7dw5esiN8dz91HqqyPAs73P7i3eiVDihmGASC
 yPHFXfcQXBX9fYBc2xTCekznLwO26lA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-zeFJRBjIOfuGb7uZiaLyNA-1; Thu,
 18 Dec 2025 08:37:47 -0500
X-MC-Unique: zeFJRBjIOfuGb7uZiaLyNA-1
X-Mimecast-MFC-AGG-ID: zeFJRBjIOfuGb7uZiaLyNA_1766065066
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10F521955F54
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:37:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCEEB1953987
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:37:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3996721E6A27; Thu, 18 Dec 2025 14:37:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: Report on MAINTAINERS coverage
In-Reply-To: <aUP5znRDyuBlpGvW@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 18 Dec 2025 12:55:42 +0000")
References: <87h5toc61n.fsf@pond.sub.org> <aUP5znRDyuBlpGvW@redhat.com>
Date: Thu, 18 Dec 2025 14:37:43 +0100
Message-ID: <871pkrdi6w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Dec 18, 2025 at 01:45:24PM +0100, Markus Armbruster wrote:
>> Which unmaintained files are we still changing?  Unmaintained files
>> sorted by number of commits in the past year (since v9.2.0):
>>=20
>>     $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list =
v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn
>>=20
>>     107 tests/functional/meson.build
>
> Opps, that's a mistake. It should of course be under the
> general maint heading "Functional testing framework"

Thanks!  I can patch that.

What about the other uncovered files in tests/functional/?

tests/functional/aarch64/meson.build
tests/functional/acpi-bits/bits-config/bits-cfg.txt
tests/functional/acpi-bits/bits-tests/smbios.py2
tests/functional/acpi-bits/bits-tests/smilatency.py2
tests/functional/acpi-bits/bits-tests/testacpi.py2
tests/functional/acpi-bits/bits-tests/testcpuid.py2
tests/functional/arm/meson.build
tests/functional/arm/test_max78000fthr.py
tests/functional/generic/meson.build
tests/functional/loongarch64/meson.build
tests/functional/m68k/meson.build
tests/functional/meson.build
tests/functional/microblaze/meson.build
tests/functional/microblazeel/meson.build
tests/functional/mips/meson.build
tests/functional/mips64/meson.build
tests/functional/mips64el/meson.build
tests/functional/mipsel/meson.build
tests/functional/or1k/meson.build
tests/functional/ppc/meson.build
tests/functional/ppc64/meson.build
tests/functional/rx/meson.build
tests/functional/sh4/meson.build
tests/functional/sh4eb/meson.build
tests/functional/sparc/meson.build
tests/functional/sparc64/meson.build
tests/functional/xtensa/meson.build


