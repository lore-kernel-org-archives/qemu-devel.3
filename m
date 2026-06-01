Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC34ACD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTzY9-0000ui-UF; Mon, 01 Jun 2026 06:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wTzXz-0000u3-AF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 06:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wTzXw-0005Ee-CI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 06:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780308419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DPy6D+9qGorVXp/xpY+GuE4b05S2PfuO6qDPxnpEVk=;
 b=YBGxXCj/vc+v2HSlOw6I5Ui6gfRuHo9Gv7vtLDa/mG8/k7/55YL1a05qFkxflE5+ZcG/Zy
 wTZQHz4JyiOQN/FG/Vpcu0xoqbInRkNLcUfez2GnXr0CB1hHLSU8JjlJJmDMrLNE38l89W
 TmpJgX+FcFYTBzJRUbfW3Rt6hDMU79Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-8MKjhvS0P5u4NK5N9znBlQ-1; Mon,
 01 Jun 2026 06:06:55 -0400
X-MC-Unique: 8MKjhvS0P5u4NK5N9znBlQ-1
X-Mimecast-MFC-AGG-ID: 8MKjhvS0P5u4NK5N9znBlQ_1780308415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3BE3180047F; Mon,  1 Jun 2026 10:06:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 135D81800352; Mon,  1 Jun 2026 10:06:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A173721E6A01; Mon, 01 Jun 2026 12:06:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <cleber@redhat.com>
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
In-Reply-To: <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 22 May 2026 13:18:19 -0700")
References: <20260521080511.999266-1-armbru@redhat.com>
 <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:06:51 +0200
Message-ID: <87y0gy8thg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Hi Markus,
>
> On 5/21/2026 1:04 AM, Markus Armbruster wrote:
>> Quite a few F: lines don't match any files.  The quick & dirty check
>>=20
>>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>=20
>> finds about fifty.
>>=20
>> Philippe Mathieu-Daud=C3=A9 recently posted a few fixes:
>>=20
>>   MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>   MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
>>   MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>   MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>   MAINTAINERS: Cover python.docker with Python library section
>>   MAINTAINERS: Fix s390x storage key/attribute device paths
>>   MAINTAINERS: Fix tcg/s390x/ path
>>   MAINTAINERS: Correct scripts/coverity-model.c path
>>   MAINTAINERS: Fix hexagon-linux-user.mak path
>>=20
>> These are in
>>=20
>>    Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
>>    Date: Mon, 18 May 2026 12:22:15 +0200
>>    Message-ID: <20260518102222.80735-1-philmd@linaro.org>
>>=20
>>    Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
>>    Date: Tue, 19 May 2026 19:12:36 +0200
>>    Message-ID: <20260519171240.97420-1-philmd@linaro.org>
>>=20
>>=20
>>    Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
>>    Date: Tue, 19 May 2026 19:19:26 +0200
>>    Message-ID: <20260519171926.98099-1-philmd@linaro.org>
>>=20
>>    Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
>>    Date: Wed, 20 May 2026 14:39:47 +0200
>>    Message-ID: <20260520123947.12711-1-philmd@linaro.org>
>>=20
>> This series takes care of the remainder, except for one discussed
>> below.  It applies cleanly with and without Philippe's patches.
>>=20
>> The exception is the last line in
>>=20
>>     Python scripts
>>     M: John Snow <jsnow@redhat.com>
>>     M: Cleber Rosa <crosa@redhat.com>
>>     S: Odd Fixes
>>     F: scripts/*.py
>>     F: tests/*.py
>>=20
>> Both F: are actually wrong here: they match only in the scripts/ and
>> tests/ not further down.  Left for another day.
>>=20
>> Markus Armbruster (39):
>>   MAINTAINERS: Improve another "Overall" section headline
>>   MAINTAINERS: Delete trailing colons in section headlines
>>   MAINTAINERS: Drop stale F: from "Guest CPU cores (TCG)"
>>   MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
>>   MAINTAINERS: Drop stale F: in "SPARC TCG CPUs"
>>   MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
>>   MAINTAINERS: Drop stale F: from "Overall CPUs other accelerators"
>>   MAINTAINERS: Drop stale F: from "virtio"
>>   MAINTAINERS: Fix F: in "Apple Silicon HVF CPUs"
>>   MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
>>   MAINTAINERS: Fix F: in "WebAssembly"
>>   MAINTAINERS: Fix F: in "Allwinner-a10"
>>   MAINTAINERS: Fix F: in "Raspberry Pi"
>>   MAINTAINERS: Drop bad F: from "Xilinx Zynq"
>>   MAINTAINERS: Drop stale F: from "New World (mac99)"
>>   MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
>>   MAINTAINERS: Fix F: typo in "sam460ex"
>>   MAINTAINERS: Fix F: in "SiFive Machines"
>>   MAINTAINERS: Fix F: typo in "ACPI/HEST/GHES/ARM processor CPER"
>>   MAINTAINERS: Fix F: in "SSI"
>>   MAINTAINERS: Fix F: in "vhost"
>>   MAINTAINERS: Fix F: in "virtio-input"
>>   MAINTAINERS: Fix bad / stale F: in "virtio-rng"
>>   MAINTAINERS: Fix F: in "vhost-user-stubs"
>>   MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
>>   MAINTAINERS: Fix F: typo in "pcf8574"
>>   MAINTAINERS: Drop stale F: from "Block I/O path"
>>   MAINTAINERS: Fix F: typo in "Dump"
>>   MAINTAINERS: Drop stale F: from "Human Monitor (HMP)"
>>   MAINTAINERS: Fix F: in "QDev"
>>   MAINTAINERS: Fix F: in "QMP"
>>   MAINTAINERS: Fix F: typo in "I3C"
>>   MAINTAINERS: Drop stale F: from "EDK2 Firmware"
>>   MAINTAINERS: Drop stale F: from "TCI TCG target"
>>   MAINTAINERS: Drop stale F: from "Linux io_uring"
>>   MAINTAINERS: Fix F: in "VFIO-USER"
>>   MAINTAINERS: Fix F: in "Build and test automation"
>>   MAINTAINERS: Drop stale F: from "Sphinx documentation configuration
>>     ..."
>>   MAINTAINERS: Fix F: in "Rust build system integration"
>>=20
>>  MAINTAINERS | 73 ++++++++++++++++++-----------------------------------
>>  1 file changed, 24 insertions(+), 49 deletions(-)
>>=20
>
> thanks for posting this.
>
> In addition, see the patch attached to this email.
> It integrates checking this directly at configure time, so we never run
> into any missing entry again in the future.
>
> I share this here not for a review, but simply to avoid a duplicated
> effort, and make sure people know it will be sent after this series.
>
> I don't believe in adding this in checkpatch, because it's not enforced
> systematically unfortunately. Breaking the meson configuration is a good
> way to make sure it's enforced by design.

No objection.

> With your series applied, the left entries are:

Most of these are fixed in Philippe's patches mentioned above.

> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +258:
> configs/targets/hexagon-linux-user/default.mak

MAINTAINERS: Fix hexagon-linux-user.mak path

> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +259:
> docker/dockerfiles/debian-hexagon-cross.docker

MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path

> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2956:
> hw/s390x/storage-keys.h
> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2965:
> hw/s390x/storage-attributes.h

MAINTAINERS: Fix s390x storage key/attribute device paths

> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3241:
> scripts/coverity-model.c

MAINTAINERS: Correct scripts/coverity-model.c path

> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3468:
> tests/*.py

This is the exception I mentioned above.

The intent is to match *.py below tests/.  It actually matches only in
tests/, not in its subdirectories.

Here's a dumb fix:

    F: tests/*.py
    F: tests/*/*.py
    F: tests/*/*/*.py
    F: tests/*/*/*/*.py

for however many levels we have.  Same for the scripts/ line next to it.
Blech.

The smart fix might be to port N: from the kernel.

	N: Files and directories *Regex* patterns.
	   N:	[^a-z]tegra	all files whose path contains tegra
	                        (not including files like integrator)
	   One pattern per line.  Multiple N: lines acceptable.
	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.

But I wonder: is this section useful at all?

> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +4149:
> tcg/s390/

MAINTAINERS: Fix tcg/s390x/ path

> Once your current series is pulled, I'll fix the remaining and send the
> attached patch. Or feel free to do it directly if you like the idea :)
>
> Regards,
> Pierrick

Two remarks inline.

> From 6c9b49ac7ec06c0159d2b4ba9c9d1081e02ef765 Mon Sep 17 00:00:00 2001
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Date: Fri, 22 May 2026 12:23:17 -0700
> Subject: [PATCH] meson.build: check MAINTAINERS file is consistent with s=
ource
>  tree
>
> We add a new script: scripts/check-maintainers-file.py, that will run at
> configuration time (and not at build time), to not hurt build time.
> This script runs in 0.2s on my dev VM, which has an old cpu.
>
> We can expect things to be mostly in sync since adding or removing a
> source or test file will trigger a configure step.
> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
> build things from scratch and always run the configure step.
>
> With this, it should be impossible by design to have an upstream
> MAINTAINERS file with non existing file entries.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build                       |  5 +++
>  scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100755 scripts/check-maintainers-file.py
>
> diff --git a/meson.build b/meson.build
> index eeb096c1487..ddfb0b90ca6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -18,6 +18,11 @@ add_test_setup('thorough',
>=20=20
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'=
))
>=20=20
> +# check our MAINTAINERS file is consistent
> +check_maintainers =3D find_program('scripts/check-maintainers-file.py')
> +maintainers_file =3D files('MAINTAINERS')
> +run_command([check_maintainers, maintainers_file], check: true, console:=
 true)

My version of meson (1.8.5) chokes on console: true.  According to
https://mesonbuild.com/Reference-manual_functions_run_command.html#run_comm=
and_console
it's new in 1.11.0.

I tested with it deleted.

> +
>  ####################
>  # Global variables #
>  ####################
> diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintainer=
s-file.py
> new file mode 100755
> index 00000000000..b001816a401
> --- /dev/null
> +++ b/scripts/check-maintainers-file.py
> @@ -0,0 +1,53 @@
> +#! /usr/bin/env python3
> +
> +# Check incorrect file entries in MAINTAINERS
> +#
> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import argparse
> +import glob
> +import sys
> +
> +
> +def check_one_entry(line) -> bool:
> +    return True
> +
> +
> +def main() -> None:
> +    parser =3D argparse.ArgumentParser(description=3D"Check MAINTAINERS =
file")
> +    parser.add_argument("maintainers", help=3D"Path to MAINTAINERS file")
> +    args =3D parser.parse_args()
> +
> +    found_file_entry =3D False
> +    found_incorrect_entries =3D False
> +    line_counter =3D 0
> +
> +    with open(args.maintainers) as file:
> +        for entry in file:
> +            line_counter +=3D 1
> +
> +            if not entry.startswith("F:"):
> +                continue
> +            entry =3D entry[2:].strip()
> +            found_file_entry =3D True
> +
> +            file_exists =3D len(glob.glob(entry, recursive=3DTrue)) > 0

I'm afraid this matches files not in git, just like my quick & dirty
one-liner.  Shouldn't we match against contents of HEAD, say output of
"git-ls-tree -r --name-only @"?

> +            if file_exists:
> +                continue
> +
> +            found_incorrect_entries =3D True
> +            print(
> +                f"No matching files for {args.maintainers} +{line_counte=
r}: {entry}",
> +                file=3Dsys.stderr,
> +            )
> +
> +    if not found_file_entry:
> +        raise Exception("no file entry found - is MAINTAINERS path corre=
ct?")
> +    if found_incorrect_entries:
> +        raise Exception(f"incorrect entries found in {args.maintainers}")
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()


