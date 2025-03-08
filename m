Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB5FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 09:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqqOO-00009Z-5l; Sat, 08 Mar 2025 04:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqqOM-00009A-C7; Sat, 08 Mar 2025 04:22:46 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqqOK-0005OV-Gd; Sat, 08 Mar 2025 04:22:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3ACE4A458C3;
 Sat,  8 Mar 2025 09:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B19C4CEE0;
 Sat,  8 Mar 2025 09:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741425755;
 bh=Ej/ETKPHxuo5RpVLYbH3+Q1984+YqMNYqlfecOZ2L4o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bPPUhYy5j6jK6SFJqmyMvIRJtaqO/osXy8OXOp1+wXzZII9OxerW5YSq818FvzJ0Q
 h4QeQJe2tKC980sZdWpyY0x4jAsuNK6b7G+QJgOKK/Pqa0yOKEsvCImOEFK5PQWCHS
 XAOPI/zH5AKzhPc17IeKEFULEGCMOBAlDcMadrI00SjTTLeKeteTm82selNVu5/Wxi
 bN3KGBs3eBwc6BCIf37MoqBya9DXu97P2RpUeXz1+y0YrezgyTjvvpBl918u663NJW
 WF7rUbjNlFyeRjp2Jki4VNtdmNFDVyEWsqnunPPWVp1UMKpzcQJHHL1QMITViFWytB
 4GNoJWnJMmPJA==
Date: Sat, 8 Mar 2025 10:22:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju
 Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, linux-kernel@vger.kernel.org, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v8 20/20] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20250308102228.389e2537@foz.lan>
In-Reply-To: <3f777e6a-01bc-44eb-8eac-7ff685a3fbee@linaro.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <3045b51edaf2d07eb0c513249fd1c621562ee3d9.1741374594.git.mchehab+huawei@kernel.org>
 <3f777e6a-01bc-44eb-8eac-7ff685a3fbee@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Phillipe,

Em Fri, 7 Mar 2025 22:05:27 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> escreveu:

> Hi Mauro,
>=20
> On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> > Using the QMP GHESv2 API requires preparing a raw data array
> > containing a CPER record.
> >=20
> > Add a helper script with subcommands to prepare such data.
> >=20
> > Currently, only ARM Processor error CPER record is supported, by
> > using:
> > 	$ ghes_inject.py arm
> >=20
> > which produces those warnings on Linux:
> >=20
> > [  705.032426] [Firmware Warn]: GHES: Unhandled processor error type 0x=
02: cache error
> > [  774.866308] {4}[Hardware Error]: Hardware error from APEI Generic Ha=
rdware Error Source: 1
> > [  774.866583] {4}[Hardware Error]: event severity: recoverable
> > [  774.866738] {4}[Hardware Error]:  Error 0, type: recoverable
> > [  774.866889] {4}[Hardware Error]:   section_type: ARM processor error
> > [  774.867048] {4}[Hardware Error]:   MIDR: 0x00000000000f0510
> > [  774.867189] {4}[Hardware Error]:   running state: 0x0
> > [  774.867321] {4}[Hardware Error]:   Power State Coordination Interfac=
e state: 0
> > [  774.867511] {4}[Hardware Error]:   Error info structure 0:
> > [  774.867679] {4}[Hardware Error]:   num errors: 2
> > [  774.867801] {4}[Hardware Error]:    error_type: 0x02: cache error
> > [  774.867962] {4}[Hardware Error]:    error_info: 0x000000000091000f
> > [  774.868124] {4}[Hardware Error]:     transaction type: Data Access
> > [  774.868280] {4}[Hardware Error]:     cache error, operation type: Da=
ta write
> > [  774.868465] {4}[Hardware Error]:     cache level: 2
> > [  774.868592] {4}[Hardware Error]:     processor context not corrupted
> > [  774.868774] [Firmware Warn]: GHES: Unhandled processor error type 0x=
02: cache error

Thanks for your review!

> > Such script allows customizing the error data, allowing to change
> > all fields at the record. Please use:
> >=20
> > 	$ ghes_inject.py arm -h =20
>=20
> It should be easy enough to add a functional test covering this,
> do you mind having a look?

It is on my TODO plan to add some tests to check it, but instead of
a functional test, I'm aiming to test the full stack.

See, I'm one of the reviewers of the RAS subsystem at the Linux Kernel,=20
and the author/maintainer of the userspace tool used to report and take
actions in case of troubles [1]. So, I'm targeting a solution that
will have rasdaemon installed on a Linux VM, testing all three
components altogether.

This will require to implement something at rasdaemon that will have
an interface at the rasdaemon to report errors to the host OS. It
currently have ABRT support, but it will likely need something
different to output error report in a way that the same error will
report the same over newer versions of the components inside the
stack.

For such purpose, I'm planning to implement a new feature on rasdaemon=20
to allow reading the errors eithe via a TCP/IP socket with some
simple text output interface, or maybe add a SQL interface[3].

[1] https://github.com/mchehab/rasdaemon
[2] https://docs.kernel.org/dev-tools/ktap.html
[3] internally, rasdaemon has already a SQL interface, used with
    SQLite. It shouldn't be hard to add PostgreSQL and/or
    mariaDB/Mysql support on it.

Before implementing it, we need to have this series merged.

So, in summary, my plan to add tests for firmware-first error
report is:

1. Have this patch series merged;
2. Add a new report mechanism on rasdaemon to report errors via
   a TCP/IP socket;
3. Setup a runner that would periodically test the full stack and
   report regressions. Such runner would need to fetch from 3 different
   sources (QEMU, Kernel, rasdaemon), so it would likely be triggered
   by some scheduler.

Btw, for the first version of the script, only ARM Processor Error is
there, but my long term plan is to be able to test other type of
GHESv2 errors, like this one [4]:

	https://gitlab.com/mchehab_kernel/qemu/-/commit/8a774121750def2723ea59ce23=
43a774a3f01ca6

[3] I implemented PCIe bus error without checking first if the Kernel
    supported it (when I tested, it didn't). I opted to add this one
    to ensure that adding new subcommands to the ghes_inject.py script
    would be trivial. It helped me to organize the code in a way that a
    new error injection code means just a two lines change at the main
    script. In this specific case, it is:

	+ from pcie_bus_error import PcieBusError
	...
	+    PcieBusError(subparsers)

    With the actual implementation handled on a separate .py module.

    This way, we can add multiple handlers there, each one with its
    own separate Python file.

    After having this series merged, my TODO plan for GHES type support is
    to add error injection code for the errors that are already implemented
    inside the Kernel and rasdaemon, after checking that the support for
    they are OK. Then, add support for it at the runner that will be
    checking for potential regressions at the full stack.

Regards,
Mauro

