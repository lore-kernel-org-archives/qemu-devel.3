Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C8BCFC518
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 09:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vN61b-0002WK-Tm; Sun, 23 Nov 2025 04:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vN61X-0002UQ-7p; Sun, 23 Nov 2025 04:04:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vN61N-0005uH-1s; Sun, 23 Nov 2025 04:04:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5622116D483;
 Sun, 23 Nov 2025 12:03:55 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E004D322E17;
 Sun, 23 Nov 2025 12:04:06 +0300 (MSK)
Message-ID: <f53de975-28ee-47ff-992d-98c30112ef0e@tls.msk.ru>
Date: Sun, 23 Nov 2025 12:04:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] Machine types, s390x, functional tests and Avocado
 removal
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20250423073610.271585-1-thuth@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/23/25 10:35, Thomas Huth wrote:
>   Hi!
> 
> The following changes since commit 1da8f3a3c53b604edfe0d55e475102640490549e:
> 
>    Open 10.1 development tree (2025-04-22 15:09:23 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-04-23
> 
> for you to fetch changes up to 12c6b6153063aafcdbadca8fee7eac793ef85e4b:
> 
>    MAINTAINERS: Add functional tests that are not covered yet (2025-04-23 07:51:25 +0200)
> 
> ----------------------------------------------------------------
> * Remove the obsolete s390-ccw-virtio-2.9 machine type
> * Prepare the dump-skeys QMP command for the universal binary project
> * Add compat machine types for 10.1
> * Convert the remaining Avocado tests to the functional framework
> * Some more small fixes for the functional tests
> 
> ----------------------------------------------------------------
> Cornelia Huck (2):
>        hw: add compat machines for 10.1
>        tests/functional/test_vnc: skip test if no crypto backend available
> 
> Philippe Mathieu-Daudé (4):
>        hw/s390x/skeys: Declare QOM types using DEFINE_TYPES() macro
>        hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
>        hw/s390x/ccw: Have CCW machine implement a qmp_dump_skeys() callback
>        qapi/machine: Make @dump-skeys command generic
> 
> Thomas Huth (23):
>        hw/s390x/s390-virtio-ccw: Remove the deprecated 2.9 machine type
>        hw/s390x/css: Remove the obsolete "css_migration_enabled" variable
>        hw/s390x/s390-stattrib: Remove the old migration_enabled flag
>        hw/intc/s390_flic: Remove the obsolete migration_enabled flag
>        gitlab-ci: Remove the avocado tests from the CI pipelines
>        tests/functional: Move the check for the parameters from avocado to functional
>        tests/functional: Convert reverse_debugging tests to the functional framework
>        tests/functional: Convert the i386 replay avocado test
>        tests/avocado: Remove the LinuxKernelTest class
>        tests/functional: Convert the 32-bit big endian Wheezy mips test
>        tests/functional: Convert the 32-bit little endian Wheezy mips test
>        tests/functional: Convert the 64-bit little endian Wheezy mips test
>        tests/functional: Convert the 64-bit big endian Wheezy mips test
>        tests/avocado: Remove the boot_linux.py tests
>        tests/functional: Use the tuxrun kernel for the x86 replay test
>        tests/functional: Use the tuxrun kernel for the aarch64 replay test
>        tests/functional: Convert the SMMU test to the functional framework
>        gitlab-ci: Update QEMU_JOB_AVOCADO and QEMU_CI_AVOCADO_TESTING
>        docs/devel/testing: Dissolve the ci-definitions.rst.inc file
>        Remove the remainders of the Avocado tests
>        tests/functional: Remove semicolons at the end of lines
>        tests/functional: Remove unnecessary import statements
>        MAINTAINERS: Add functional tests that are not covered yet

Hi!

I'm picking the bulk of this patchset from Apr-2025 to 10.0.x stable
series of qemu, so that testing framework for 10.0.x will be the same
as current/future versions of qemu.

In particular, I'm picking up the following patches, all of which
applies cleanly to 10.0.x:

4e3823c68c tests/functional/test_vnc: skip test if no crypto backend 
available
22baa5f340 gitlab-ci: Remove the avocado tests from the CI pipelines
bc65ae6961 tests/functional: Move the check for the parameters from 
avocado to functional
951ededf12 tests/functional: Convert reverse_debugging tests to the 
functional framework
0e756f404d tests/functional: Convert the i386 replay avocado test
574f71bc1f tests/avocado: Remove the LinuxKernelTest class
42a87f0ce7 tests/functional: Convert the 32-bit big endian Wheezy mips test
689a8b56a6 tests/functional: Convert the 32-bit little endian Wheezy 
mips test
8e3461c3a6 tests/functional: Convert the 64-bit little endian Wheezy 
mips test
f79592f427 tests/functional: Convert the 64-bit big endian Wheezy mips test
e83aee9c6a tests/avocado: Remove the boot_linux.py tests
7fecdb0acd tests/functional: Use the tuxrun kernel for the x86 replay test
a820caf844 tests/functional: Use the tuxrun kernel for the aarch64 
replay test
5c2bae2155 tests/functional: Convert the SMMU test to the functional 
framework
f8c5484417 gitlab-ci: Update QEMU_JOB_AVOCADO and QEMU_CI_AVOCADO_TESTING
5748e46415 docs/devel/testing: Dissolve the ci-definitions.rst.inc file
52e9ed6d3a Remove the remainders of the Avocado tests
858640eaee tests/functional: Remove semicolons at the end of lines
99fb9256b7 tests/functional: Remove unnecessary import statements
12c6b61530 MAINTAINERS: Add functional tests that are not covered yet

The result is at https://gitlab.com/mjt0k/qemu/-/pipelines/2174244481.

Please let me know if I should skip/omit some of them.  And please also
let me know of there's someting else which is worth picking up for 10.0
in the testing area, to keep an LTS branch more manageable.

Thanks!

/mjt

