Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC1FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjYSK-00037P-CV; Tue, 14 Jul 2026 04:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjYSI-00036l-9b
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjYSF-0008Vg-MN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784017526;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hdKyCPbHxxHsBrbw5EfkS5WKmfTU35zhjuIHhiVoCLI=;
 b=NiY0fakxtYQV9JFwilrAcZ6wCw46BMjyNnZy+xbHn9e8zjpTJ3uG18J3APDNLTADGSa0YB
 UfJJWa7jNlYBoPLJvfHDFrQ1URZ5HotIMVzjYb36GEXPq1OIJWNBcqY5lro/Ir54aioA40
 iXUnkEs5QyDX5B/+UX4eTrvumsMDJyE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-y3QeSpxPNVWf53jiwzGkdg-1; Tue,
 14 Jul 2026 04:25:19 -0400
X-MC-Unique: y3QeSpxPNVWf53jiwzGkdg-1
X-Mimecast-MFC-AGG-ID: y3QeSpxPNVWf53jiwzGkdg_1784017517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8C521800597; Tue, 14 Jul 2026 08:25:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73B15195608A; Tue, 14 Jul 2026 08:25:12 +0000 (UTC)
Date: Tue, 14 Jul 2026 09:25:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH 14/14] tests/functional: Add hexagon semihosting systests
Message-ID: <alXyZCtBmMecWdf1@redhat.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <da280da8fec576b2cc59e7bf48a2845312ee50cc.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da280da8fec576b2cc59e7bf48a2845312ee50cc.1783973054.git.matheus.bernardino@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 13, 2026 at 01:07:22PM -0700, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/meson.build      |   9 ++
>  tests/functional/hexagon/test_systests.py | 133 ++++++++++++++++++++++
>  tests/functional/meson.build              |   1 +
>  3 files changed, 143 insertions(+)
>  create mode 100644 tests/functional/hexagon/meson.build
>  create mode 100644 tests/functional/hexagon/test_systests.py
> 
> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
> new file mode 100644
> index 00000000000..6cd684b0df7
> --- /dev/null
> +++ b/tests/functional/hexagon/meson.build
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +test_hexagon_timeouts = {
> +  'systests': 180,
> +}
> +
> +tests_hexagon_system_thorough = [
> +  'systests',
> +]
> diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
> new file mode 100644
> index 00000000000..b20b9fc56cc

Test files should have execute permissions.

> --- /dev/null
> +++ b/tests/functional/hexagon/test_systests.py
> @@ -0,0 +1,133 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import re
> +import time
> +import unittest
> +
> +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> +
> +
> +_TARBALL_BIN_PATH = os.path.join(
> +    "systests_standalone_package",
> +    "StandaloneSysTests_6.4.0.2_v68",
> +    "bin",
> +)

Don't use os.path.join to refer to files needed by the test
suite - always use one of the helper methods on the QemuBaseTest
class....

> +
> +
> +class SysTestsStandaloneTests(QemuSystemTest):
> +    SYSTEST_TIMEOUT_SEC = 30
> +
> +    ASSET_TARBALL = Asset(
> +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.9/systests_standalone.tar.gz",
> +        "db961ea3fcc389b478b3d5c2f3bac60bec87e7f3d7efef5e58a9ae8ee78d0e40",
> +    )
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.archive_extract(self.ASSET_TARBALL)
> +        self.bin_dir = os.path.join(self.workdir, _TARBALL_BIN_PATH)

...so also skip this...

> +        self._orig_cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +        self.addCleanup(os.chdir, self._orig_cwd)

Don't change directory during tests - use properly qualified paths
to files.

> +
> +    def tearDown(self):
> +        if hasattr(self, "_orig_cwd"):
> +            os.chdir(self._orig_cwd)
> +        super().tearDown()
> +
> +    def binary(self, name):
> +        """Return the full path to binary *name* inside bin_dir."""
> +        return os.path.join(self.bin_dir, name)

This should be just:

  return self.scratch_file("systests_standalone_package",
        "StandaloneSysTests_6.4.0.2_v68", "bin", name)

> +
> +    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
> +        """Launch *binary_name* and assert it exits with code 0.
> +
> +        :param binary_name: name of the binary inside bin_dir.
> +        :param extra_args: optional pairs of (flag, value) strings passed
> +            to set_vm_arg(), e.g. ('-append', 'myarg').
> +        :param machine: QEMU machine type (default "V66G_1024").
> +        """
> +        self.set_machine(machine)
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", self.binary(binary_name))
> +        for flag, value in zip(extra_args[::2], extra_args[1::2]):
> +            self.set_vm_arg(flag, value)
> +        self.vm.launch()
> +        self.vm.wait(timeout=60.0)
> +        self.assertEqual(self.vm.exitcode(), 0,
> +                         f"Test {binary_name} exited with "
> +                         f"code {self.vm.exitcode()}, expected 0")
> +
> +    def run_console_pattern(self, binary_name, pattern, *extra_args,
> +                            machine="V66G_1024"):
> +        """Launch *binary_name* and wait for *pattern* on the semihosting console.
> +
> +        :param binary_name: name of the binary inside bin_dir.
> +        :param pattern: string pattern to wait for via wait_for_console_pattern.
> +        :param extra_args: optional pairs of (flag, value) strings passed
> +            to set_vm_arg(), e.g. ('-append', 'myarg').
> +        :param machine: QEMU machine type (default "V66G_1024").
> +        """
> +        self.set_machine(machine)
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", self.binary(binary_name))
> +        for flag, value in zip(extra_args[::2], extra_args[1::2]):
> +            self.set_vm_arg(flag, value)
> +        self.vm.set_console(semihosting=True)
> +        self.vm.launch()
> +        try:
> +            wait_for_console_pattern(self, pattern)
> +        finally:
> +            self.vm.kill()
> +
> +    def test_fopen(self):
> +        """fopen reads a file passed via --append and verifies its contents."""
> +        with open(os.path.join(self.workdir, "dummy.so"), "w") as f:

  self.scratch_file("dummy.so")

> +            f.write("valid\n")
> +        self.run_exit_zero("fopen", "-append", "dummy.so")

How is this working ?  You've created a file dummy.so on the host OS,
and you're passing a filename "dummy.so" to -append which is a kernel
arg. The implication is the kenrel opens this file, but how is the guest
kernel accessing the file from the host ?!?!??

> +
> +    def test_ftrunc(self):
> +        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
> +        ftrunc_path = os.path.join(self.workdir, "_testfile_ftrunc")

self.scratch_file("_testfile_ftrunc")

> +        with open(ftrunc_path, "w") as f:
> +            f.write("valid\n")
> +        # Sleep 1 s so mtime change is observable
> +        time.sleep(1)
> +        self.run_exit_zero("ftrunc")
> +        self.assertEqual(
> +            os.path.getsize(ftrunc_path),
> +            1,
> +            "_testfile_ftrunc should be 1 byte after ftrunc",
> +        )
> +
> +    def test_dirent(self):
> +        """dirent lists a directory passed via --append; output must be
> +        '. .. fileA fileB'."""
> +        dirent_dir = os.path.join(self.workdir, "_dirent_testdir")

self.scratch_file("_dirent_testdir")

> +        os.makedirs(dirent_dir, exist_ok=True)
> +        open(os.path.join(dirent_dir, "fileA"), "w").close()
> +        open(os.path.join(dirent_dir, "fileB"), "w").close()

self.scratch_file("_dirent_testdir", "fileA")

> +        self.run_console_pattern(
> +            "dirent", ". .. fileA fileB", "-append", "_dirent_testdir"

Again I'm wondering how the guest OS accesses _dirent_testdir which
is a location on the host OS ?

> +        )
> +
> +    def test_access(self):
> +        """access checks R_OK|W_OK on _testfile_access."""
> +        with open(os.path.join(self.workdir, "_testfile_access"), "w") as f:
> +            f.write("valid\n")

self.scratch_file("_testfile_access")

> +        self.run_exit_zero("access")
> +
> +    def test_semihost(self):
> +        semihost_dir = os.path.join(self.workdir, "_semihost_dir")
> +        os.makedirs(semihost_dir, exist_ok=True)
> +        open(os.path.join(semihost_dir, "fileA"), "w").close()
> +        open(os.path.join(semihost_dir, "fileB"), "w").close()

The intermediate dir feels redunddant - why not just create fileA & fileB 
directly ? ie

self.scratch_file("fileA")
self.scratch_file("fileB")

> +        self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
> +
> +if __name__ == "__main__":
> +    QemuSystemTest.main()
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index c158197c4b7..c7362dd00ef 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -14,6 +14,7 @@ subdir('aarch64')
>  subdir('alpha')
>  subdir('arm')
>  subdir('avr')
> +subdir('hexagon')
>  subdir('hppa')
>  subdir('i386')
>  subdir('loongarch64')
> -- 
> 2.37.2
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


