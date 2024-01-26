Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510BEC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 16:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTPO7-0004tX-Bq; Fri, 26 Jan 2024 11:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTPO5-0004su-Vt; Fri, 26 Jan 2024 11:49:05 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTPO3-0007bc-Rg; Fri, 26 Jan 2024 11:49:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TM3Yk1qTzz4xF2;
 Sat, 27 Jan 2024 03:48:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TM3Yh5kY6z4x23;
 Sat, 27 Jan 2024 03:48:56 +1100 (AEDT)
Message-ID: <1ab62ecc-7e3e-4c84-96e9-040193d9b35b@kaod.org>
Date: Fri, 26 Jan 2024 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] aspeed queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Ninad Palsule <ninad@linux.ibm.com>
References: <20240126133217.996306-1-clg@kaod.org>
 <CAFEAcA8Q66Qw7spMOcBju0v-=C=x10hz1rwPWxjCzYWhdkX8Ww@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAFEAcA8Q66Qw7spMOcBju0v-=C=x10hz1rwPWxjCzYWhdkX8Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/26/24 16:56, Peter Maydell wrote:
> On Fri, 26 Jan 2024 at 13:33, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> The following changes since commit e029fe22caad9b75c7ab69bd4e84853c11fb71e0:
>>
>>    Merge tag 'pull-qapi-2024-01-26' of https://repo.or.cz/qemu/armbru into staging (2024-01-26 10:21:27 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/legoater/qemu/ tags/pull-aspeed-20240126
>>
>> for you to fetch changes up to b40769f4b49d15485ffaaa7acade3e3593ee6daa:
>>
>>    hw/fsi: Update MAINTAINER list (2024-01-26 14:22:08 +0100)
>>
>> ----------------------------------------------------------------
>> aspeed queue:
>>
>> * Update of buildroot images to 2023.11 (6.6.3 kernel)
>> * Check of the valid CPU type supported by aspeed machines
>> * Simplified models for the IBM's FSI bus and the Aspeed
>>    controller bridge
>>
>> ----------------------------------------------------------------
> 
> Looks like you have an endianness bug, either in the device
> or in the test. From the s390 runner:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/6029422595
> 
> 232/847 qemu:qtest+qtest-arm / qtest-arm/aspeed-fsi-test ERROR 0.38s
> killed by signal 6 SIGABRT
>>>> PYTHON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./qemu-system-arm G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=82 QTEST_QEMU_IMG=./qemu-img /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/aspeed-fsi-test --tap -k
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> **
> ERROR:../tests/qtest/aspeed-fsi-test.c:152:test_fsi0_getcfam_addr0:
> assertion failed (curval == 0x152d02c0): (3221368085 == 355271360)
> (test program exited with status code -6)
> 
> where 3221368085 is 0xC0022D15, and 355271360 is 0x152D02C0...


drat. Indeed. I didn't check BE ... Sorry about that.

Ninad,

Some changes are required in fsi_aspeed_apb2opb_write().

Could you please rework the address space accesses to use
address_space_*_le() routines instead of address_space_rw() ?
This will be less concise.

To check, you can use a PPC64 debian (big-endian) on a PPC64
KVM guest or PowerVM LPAR, or a s390x LPAR.


Thanks,

C.


