Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86303CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJ6x-0006Su-L7; Tue, 02 Jun 2026 03:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUJ6n-0006S6-V3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUJ6h-00020f-RA
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780383608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TVsXtVMZ8rV5wQemwgJHTieiteqYEbIHXxXuSg1md4=;
 b=etA0czVxv9pwIQfeKNJQLvnSCE3K1L/TKsfFBceqG1rnLjjdHt++TDAJIVk8BOUeRlXONf
 lNN/BeUlgoF1nyAkfOmDlSK+92bRM9wvquenZiLDXkW2Spu1vFphvEQ5jjKeLon9kU7luu
 32MHTwugr4/hvk5Msj8m/TNOv8l46Rw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-dcr3KtctMH-PJjs0e3xCmQ-1; Tue,
 02 Jun 2026 03:00:04 -0400
X-MC-Unique: dcr3KtctMH-PJjs0e3xCmQ-1
X-Mimecast-MFC-AGG-ID: dcr3KtctMH-PJjs0e3xCmQ_1780383604
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B855F1800372; Tue,  2 Jun 2026 07:00:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D95E1956095; Tue,  2 Jun 2026 07:00:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A76BB21E6A01; Tue, 02 Jun 2026 09:00:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  John Snow
 <jsnow@redhat.com>,  Cleber Rosa <cleber@redhat.com>
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
In-Reply-To: <c7cc0040-872d-425c-827f-c57db87ee12c@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 1 Jun 2026 12:03:30 -0700")
References: <20260521080511.999266-1-armbru@redhat.com>
 <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
 <87y0gy8thg.fsf@pond.sub.org>
 <c7cc0040-872d-425c-827f-c57db87ee12c@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 09:00:00 +0200
Message-ID: <87wlwh77gv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 6/1/2026 3:06 AM, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> Hi Markus,
>>>
>>> On 5/21/2026 1:04 AM, Markus Armbruster wrote:
>>>> Quite a few F: lines don't match any files.  The quick & dirty check
>>>>
>>>>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>>>
>>>> finds about fifty.
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 recently posted a few fixes:
>>>>
>>>>   MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>>>   MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch sect=
ion
>>>>   MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>>>   MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>>>   MAINTAINERS: Cover python.docker with Python library section
>>>>   MAINTAINERS: Fix s390x storage key/attribute device paths
>>>>   MAINTAINERS: Fix tcg/s390x/ path
>>>>   MAINTAINERS: Correct scripts/coverity-model.c path
>>>>   MAINTAINERS: Fix hexagon-linux-user.mak path

[...]

>>> In addition, see the patch attached to this email.
>>> It integrates checking this directly at configure time, so we never run
>>> into any missing entry again in the future.
>>>
>>> I share this here not for a review, but simply to avoid a duplicated
>>> effort, and make sure people know it will be sent after this series.
>>>
>>> I don't believe in adding this in checkpatch, because it's not enforced
>>> systematically unfortunately. Breaking the meson configuration is a good
>>> way to make sure it's enforced by design.
>>=20
>> No objection.
>>=20
>>> With your series applied, the left entries are:
>>=20
>> Most of these are fixed in Philippe's patches mentioned above.
>>
>
> =F0=9F=91=8D
>
>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +258:
>>> configs/targets/hexagon-linux-user/default.mak
>>=20
>> MAINTAINERS: Fix hexagon-linux-user.mak path
>>=20
>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +259:
>>> docker/dockerfiles/debian-hexagon-cross.docker
>>=20
>> MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>=20
>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2956:
>>> hw/s390x/storage-keys.h
>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2965:
>>> hw/s390x/storage-attributes.h
>>=20
>> MAINTAINERS: Fix s390x storage key/attribute device paths
>>=20
>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3241:
>>> scripts/coverity-model.c
>>=20
>> MAINTAINERS: Correct scripts/coverity-model.c path
>>=20
>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3468:
>>> tests/*.py
>>=20
>> This is the exception I mentioned above.
>>=20
>> The intent is to match *.py below tests/.  It actually matches only in
>> tests/, not in its subdirectories.
>>=20
>> Here's a dumb fix:
>>=20
>>     F: tests/*.py
>>     F: tests/*/*.py
>>     F: tests/*/*/*.py
>>     F: tests/*/*/*/*.py
>>=20
>
> It's acceptable, and nice because it's not ambiguous.
> Also, it shows us the first line is not a correct entry (there is no
> tests/*.py).

It's also brittle: breaks when we add the first .py at level.

>> for however many levels we have.  Same for the scripts/ line next to it.
>> Blech.
>>=20
>> The smart fix might be to port N: from the kernel.
>>=20
>> 	N: Files and directories *Regex* patterns.
>> 	   N:	[^a-z]tegra	all files whose path contains tegra
>> 	                        (not including files like integrator)
>> 	   One pattern per line.  Multiple N: lines acceptable.
>> 	   scripts/get_maintainer.pl has different behavior for files that
>> 	   match F: pattern and matches of N: patterns.  By default,
>> 	   get_maintainer will not look at git log history when an F: pattern
>> 	   match occurs.  When an N: match occurs, git log history is used
>> 	   to also notify the people that have git commit signatures.
>>=20
>> But I wonder: is this section useful at all?
>
> I would prefer to use the manual entries approach above, especially if
> there is only folder that is concerned.
> When we'll have two different use case, maybe we can consider a more
> generic approach.

I'm aware of just two:

    Python scripts
    M: John Snow <jsnow@redhat.com>
    M: Cleber Rosa <crosa@redhat.com>
    S: Odd Fixes
    F: scripts/*.py
    F: tests/*.py

The section was added almost a decade ago (commit ad904f6689f), and
never worked as intended.  I asked John Snow about deleting it to
unblock your work.  He told me he'd be fine with that.  Could add it
back later fixed.

>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +4149:
>>> tcg/s390/
>>=20
>> MAINTAINERS: Fix tcg/s390x/ path
>>=20
>>> Once your current series is pulled, I'll fix the remaining and send the
>>> attached patch. Or feel free to do it directly if you like the idea :)
>>>
>>> Regards,
>>> Pierrick
>>=20
>> Two remarks inline.
>>=20
>>> From 6c9b49ac7ec06c0159d2b4ba9c9d1081e02ef765 Mon Sep 17 00:00:00 2001
>>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Date: Fri, 22 May 2026 12:23:17 -0700
>>> Subject: [PATCH] meson.build: check MAINTAINERS file is consistent with=
 source
>>>  tree
>>>
>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>> configuration time (and not at build time), to not hurt build time.
>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>
>>> We can expect things to be mostly in sync since adding or removing a
>>> source or test file will trigger a configure step.
>>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>>> build things from scratch and always run the configure step.
>>>
>>> With this, it should be impossible by design to have an upstream
>>> MAINTAINERS file with non existing file entries.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  meson.build                       |  5 +++
>>>  scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>>>  2 files changed, 58 insertions(+)
>>>  create mode 100755 scripts/check-maintainers-file.py
>>>
>>> diff --git a/meson.build b/meson.build
>>> index eeb096c1487..ddfb0b90ca6 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -18,6 +18,11 @@ add_test_setup('thorough',
>>>=20=20
>>>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.p=
y'))
>>>=20=20
>>> +# check our MAINTAINERS file is consistent
>>> +check_maintainers =3D find_program('scripts/check-maintainers-file.py')
>>> +maintainers_file =3D files('MAINTAINERS')
>>> +run_command([check_maintainers, maintainers_file], check: true, consol=
e: true)
>>=20
>> My version of meson (1.8.5) chokes on console: true.  According to
>> https://mesonbuild.com/Reference-manual_functions_run_command.html#run_c=
ommand_console
>> it's new in 1.11.0.
>>
>
> Our configure script creates a venv with an updated version of meson,
> which is 1.11.1 at the moment.
> If you called meson directly (which uses your host meson), it's not how
> we're supposed to build QEMU.
> How did you try this?

I ran make :)

>> I tested with it deleted.
>>=20
>>> +
>>>  ####################
>>>  # Global variables #
>>>  ####################
>>> diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintain=
ers-file.py
>>> new file mode 100755
>>> index 00000000000..b001816a401
>>> --- /dev/null
>>> +++ b/scripts/check-maintainers-file.py
>>> @@ -0,0 +1,53 @@
>>> +#! /usr/bin/env python3
>>> +
>>> +# Check incorrect file entries in MAINTAINERS
>>> +#
>>> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import argparse
>>> +import glob
>>> +import sys
>>> +
>>> +
>>> +def check_one_entry(line) -> bool:
>>> +    return True
>>> +
>>> +
>>> +def main() -> None:
>>> +    parser =3D argparse.ArgumentParser(description=3D"Check MAINTAINER=
S file")
>>> +    parser.add_argument("maintainers", help=3D"Path to MAINTAINERS fil=
e")
>>> +    args =3D parser.parse_args()
>>> +
>>> +    found_file_entry =3D False
>>> +    found_incorrect_entries =3D False
>>> +    line_counter =3D 0
>>> +
>>> +    with open(args.maintainers) as file:
>>> +        for entry in file:
>>> +            line_counter +=3D 1
>>> +
>>> +            if not entry.startswith("F:"):
>>> +                continue
>>> +            entry =3D entry[2:].strip()
>>> +            found_file_entry =3D True
>>> +
>>> +            file_exists =3D len(glob.glob(entry, recursive=3DTrue)) > 0
>>=20
>> I'm afraid this matches files not in git, just like my quick & dirty
>> one-liner.  Shouldn't we match against contents of HEAD, say output of
>> "git-ls-tree -r --name-only @"?
>>
>
> I don't think it's needed to restrict to git ls-tree. The only risk is
> that people have a local file they forgot (or didn't want) to add in
> git. It will be caught by CI that won't have such a file, so we're safe.
>
> What do you think?

Yes, we're safe, but the earlier we catch mistakes, the better.  Now,
the juice isn't always worth the squeeze.  How hard would we have to
squeeze here?  We could use fnmatch.filter(names, pat) to test whether
@pat matches anything in @names, where @names is from git-ls-tree.

>>> +            if file_exists:
>>> +                continue
>>> +
>>> +            found_incorrect_entries =3D True
>>> +            print(
>>> +                f"No matching files for {args.maintainers} +{line_coun=
ter}: {entry}",
>>> +                file=3Dsys.stderr,
>>> +            )
>>> +
>>> +    if not found_file_entry:
>>> +        raise Exception("no file entry found - is MAINTAINERS path cor=
rect?")
>>> +    if found_incorrect_entries:
>>> +        raise Exception(f"incorrect entries found in {args.maintainers=
}")
>>> +
>>> +
>>> +if __name__ =3D=3D "__main__":
>>> +    main()
>>=20
>
> Regards,
> Pierrick


