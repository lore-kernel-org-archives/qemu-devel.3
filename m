Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C1FD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7w3d-0007SW-Oc; Mon, 04 Nov 2024 07:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=br0a=R7=kaod.org=clg@ozlabs.org>)
 id 1t7w3c-0007SE-HD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:19:44 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=br0a=R7=kaod.org=clg@ozlabs.org>)
 id 1t7w3a-0007QH-5d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:19:44 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XhrBD2qTzz4xCV;
 Mon,  4 Nov 2024 23:19:32 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XhrBB3rjQz4x8S;
 Mon,  4 Nov 2024 23:19:30 +1100 (AEDT)
Message-ID: <c88e891e-153e-4fc3-bb10-6b9dff5e7789@kaod.org>
Date: Mon, 4 Nov 2024 13:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-function failing on func-arm-arm_aspeed
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
 <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=br0a=R7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/4/24 13:12, Thomas Huth wrote:
> On 28/10/2024 18.14, Peter Maydell wrote:
>> Trying a "make check-functional" I find that the func-arm-arm_aspeed
>> test seems to hit a timeout:
>>
>> 18/18 qemu:func-thorough+func-arm-thorough+thorough /
>> func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
>> signal 15 SIGTERM
>>
>> This is with commit cea8ac78545a.
> 
> Cédric, is it working reliable for you?

I have never seen this issue on the systems I use. Let me try again.


Thanks,

C.



  

> 
>> Does anybody else see this, or is it some oddity happening only
>> on my local dev machine?
>>
>> The "full log" in testlog-thorough.txt doesn't seem to be
>> very full. All it has for this test is:
>>
>> =================================== 18/18 ====================================
>> test:         qemu:func-thorough+func-arm-thorough+thorough /
>> func-arm-arm_aspeed
>> start time:   16:54:50
>> duration:     600.08s
>> result:       killed by signal 15 SIGTERM
>> command:      G_TEST_SLOW=1
>> PYTHONPATH=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python:/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional
>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>> MALLOC_PERTURB_=238
>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
>> MESON_TEST_ITERATION=1
>> QEMU_TEST_QEMU_IMG=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-img
>> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>> QEMU_TEST_QEMU_BINARY=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-arm
>> QEMU_BUILD_ROOT=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang
>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_aspeed.py
>> ----------------------------------- stdout -----------------------------------
>> TAP version 13
>> ok 1 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_04
>> ok 2 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_07
>> ok 3 test_arm_aspeed.AST2x00Machine.test_arm_ast2400_palmetto_openbmc_v2_9_0
>> ==============================================================================
>>
>> Is it possible to get the log to include a pointer to the
>> actual log for the test (including the guest console output)?
>> It's hard to debug tests if they don't report what they're doing.
> 
> I tried to add something to the log iff the test case failed (e.g. by
> checking defaultTestResult().wasSuccessful() or something similar in the
> tearDown() function of the test), but that does not seem to work ...
> so all I can suggest right now is to print out the path to the test log
> unconditionally, something like:
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index aa0146265a..7436f37bc5 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -47,13 +47,14 @@ def setUp(self, bin_prefix):
>           self.logdir = self.workdir
>           self.log = logging.getLogger('qemu-test')
>           self.log.setLevel(logging.DEBUG)
> -        self._log_fh = logging.FileHandler(os.path.join(self.logdir,
> -                                                        'base.log'), mode='w')
> +        log_file_name = os.path.join(self.logdir, 'base.log')
> +        self._log_fh = logging.FileHandler(log_file_name, mode='w')
>           self._log_fh.setLevel(logging.DEBUG)
>           fileFormatter = logging.Formatter(
>               '%(asctime)s - %(levelname)s: %(message)s')
>           self._log_fh.setFormatter(fileFormatter)
>           self.log.addHandler(self._log_fh)
> +        print(self.id() + ' log file: ' + log_file_name)
> 
>       def tearDown(self):
>           self.log.removeHandler(self._log_fh)
> 
> Downside is that the message is also always printed if you e.g. run
> "make check-functional V=1" ... does that still sound ok to you?
> 
>   Thomas
> 


