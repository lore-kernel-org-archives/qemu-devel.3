Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081FBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZKa-0002ce-Ho; Thu, 01 Aug 2024 13:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZKZ-0002Wz-21
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:11:11 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZKW-0008C8-Rc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:11:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a309d1a788so9470482a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722532267; x=1723137067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6mqXJquTnHdY/YtS54manBY5C+91VQc0Rygeywp5xE4=;
 b=nFDdG/1i254+JjFP6OPUTTmzejJMsgOzcNDH2AA/4JhFRU1xy7Lsm8B47m8FUSiHAu
 Q0sPuOjxGZyLnHDLSHBJadQi1HbPdPPD0KF6pQF4HjZIvTQt11JBNtUqsWFOYz4hvUl4
 PXlAp2GZP2NHD6CqfD9QnYum0ovvq/x3gwcF7VJAQ6DhvvhNL/bjJqLnCoRiMaGXttHH
 ZDKzx1kc5Ym2Z0QiFXH2kPiEtOgJIVlUbJ+7Id0kmGxw0PvtEMkprUwW9r917dnYMCHS
 IZJ9kZSPsja8Us3sDvC7eHFjzXsKyksgNzllf6fgDov9uLEXbZOcE6qYte1v8mAQlybD
 Bwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722532267; x=1723137067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mqXJquTnHdY/YtS54manBY5C+91VQc0Rygeywp5xE4=;
 b=YtilPBUAyrzyEj+YAgayota+GXpWYcOWSOh2kKlz6SSDRzHXWJePFD8b+xAQtnnBlJ
 ehDyxzqpeod5KakWbptZuqut3MfVldJtk0CCJ1aWsFzhSv4h/+HWM0zpMz/8H0ozNiW7
 e2crcJwrJ5YZad/JgWiUhqO3dhLY0Gm2lzzbkrJLI45mzhZ0DL074dw+Q2I1Gzbmiwfy
 WYt1fwAM78In+OWqWCULjG01wR4wQDIpjS1WFtBUP17G4cwdEixi91o6sf8sLb/7N9ML
 TGaGLZCmQM4rOmT0IEVwWSZp3a/GXy7G6vk0Gv9zB+nxuMmYxTfEcjdp/mfHM7fush3y
 CIeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7370MOgPCoTfLDhfTXXFo+3FGtCjJYKiJAMG2oPd5XQdOA5YpNwbFUfL0LN6wNgWTC/caPUSoo5FeozekadSlAqhmm60=
X-Gm-Message-State: AOJu0YzrbCZJ3Xr34odHhMdh98Mc4EiaE/IOaXPPOgNyWdZvY97ryiRR
 uwEC9dpNikN6FScE700+EpTajui5G2g3CLrcq7CDKj4JfYFWfKTPfHV5UOElzeCQOhiJ5IpCFL1
 hfuw=
X-Google-Smtp-Source: AGHT+IHo3VsVJ1vJiEN0oTzOvljVrVHgZlDukt2+k9AqGOpF0Wkjmb1M7Y3/Em4C363Y8FhH/mczIQ==
X-Received: by 2002:a50:eaca:0:b0:5af:5342:c5bf with SMTP id
 4fb4d7f45d1cf-5b7f540a6bcmr829042a12.29.1722532266682; 
 Thu, 01 Aug 2024 10:11:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b82bf63sm4230a12.75.2024.08.01.10.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 10:11:06 -0700 (PDT)
Message-ID: <0f30e83a-2048-4dcb-ba41-47920c62e1e1@linaro.org>
Date: Thu, 1 Aug 2024 19:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/24] tests/functional: Convert the s390x avocado
 tests into standalone tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-14-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These tests use archive.lzma_uncompress() from the Avocado utils,
> so provide a small helper function for this, based on the
> standard lzma module from Python instead.
> 
> And while we're at it, replace the MD5 hashes in the topology test
> with proper SHA256 hashes, since MD5 should not be used anymore
> nowadays.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  4 +-
>   tests/functional/meson.build                  |  6 ++
>   tests/functional/qemu_test/utils.py           | 14 +++
>   .../test_s390x_ccw_virtio.py}                 | 79 ++++++++---------
>   .../test_s390x_topology.py}                   | 86 ++++++++-----------
>   5 files changed, 94 insertions(+), 95 deletions(-)
>   rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (85%)
>   mode change 100644 => 100755
>   rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (88%)
>   mode change 100644 => 100755

Conversion LGTM, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Now while testing I'm getting errors, but maybe pre-existing...

pyvenv/bin/meson test  --no-rebuild -t 1 --setup thorough 
--num-processes 1 --print-errorlogs  --suite func-s390x  --suite 
func-s390x-thorough
qemu:func-thorough+func-s390x-thorough+thorough / 
func-s390x-s390x_ccw_virtio time out (After 180.0 seconds)
1/5 qemu:func-thorough+func-s390x-thorough+thorough / 
func-s390x-s390x_ccw_virtio        TIMEOUT        180.05s   killed by 
signal 15 SIGTERM
▶ 2/5 test_empty_cpu_model.EmptyCPUModel.test 
                 FAIL
2/5 qemu:func-quick+func-s390x / func-s390x-empty_cpu_model 
                 ERROR            0.21s   exit status 1
stderr:
Traceback (most recent call last):
   File "/home/user/qemu/tests/functional/test_empty_cpu_model.py", line 
21, in test
     self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empty')
AssertionError: Regex didn't match: '-cpu option cannot be empty' not 
found in 'Could not access KVM kernel module: Permission 
denied\nqemu-system-s390x: failed to initialize kvm: Permission denied\n'


(test program exited with status code 1)
▶ 4/5 test_version.Version.test_qmp_human_info_version 
                 FAIL
Traceback (most recent call last):
   File "/home/user/qemu/python/qemu/qmp/protocol.py", line 425, in 
_session_guard
     await coro
   File "/home/user/qemu/python/qemu/qmp/qmp_client.py", line 250, in 
_establish_session
     self._greeting = await self._get_greeting()
   File "/home/user/qemu/python/qemu/qmp/qmp_client.py", line 270, in 
_get_greeting
     msg = await self._recv()
   File "/home/user/qemu/python/qemu/qmp/protocol.py", line 1009, in _recv
     message = await self._do_recv()
   File "/home/user/qemu/python/qemu/qmp/qmp_client.py", line 402, in 
_do_recv
     msg_bytes = await self._readline()
   File "/home/user/qemu/python/qemu/qmp/protocol.py", line 977, in 
_readline
     raise EOFError
EOFError

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
   File "/home/user/qemu/python/qemu/machine/machine.py", line 448, in 
launch
     self._launch()
   File "/home/user/qemu/python/qemu/machine/machine.py", line 487, in 
_launch
     self._post_launch()
   File "/home/user/qemu/python/qemu/machine/machine.py", line 381, in 
_post_launch
     self._qmp.connect()
   File "/home/user/qemu/python/qemu/qmp/legacy.py", line 153, in connect
     self._sync(
   File "/home/user/qemu/python/qemu/qmp/legacy.py", line 102, in _sync
     return self._aloop.run_until_complete(
   File "/usr/lib/python3.10/asyncio/base_events.py", line 649, in 
run_until_complete
     return future.result()
   File "/usr/lib/python3.10/asyncio/tasks.py", line 408, in wait_for
     return await fut
   File "/home/user/qemu/python/qemu/qmp/protocol.py", line 382, in connect
     await self._session_guard(
   File "/home/user/qemu/python/qemu/qmp/protocol.py", line 456, in 
_session_guard
     raise ConnectError(emsg, err) from err
qemu.qmp.protocol.ConnectError: Failed to establish session: EOFError

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
   File "/home/user/qemu/tests/functional/test_version.py", line 22, in 
test_qmp_human_info_version
     self.vm.launch()
   File "/home/user/qemu/python/qemu/machine/machine.py", line 461, in 
launch
     raise VMLaunchFailure(
qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish 
session: EOFError
	Exit code: 1
	Command: qemu-system-s390x -display none -vga none -chardev 
socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
	Output: Could not access KVM kernel module: Permission denied
qemu-system-s390x: failed to initialize kvm: Permission denied

5/5 qemu:func-thorough+func-s390x-thorough+thorough / 
func-s390x-s390x_topology          SKIP             1.14s   0 subtests 
passed

Summary of Failures:

1/5 qemu:func-thorough+func-s390x-thorough+thorough / 
func-s390x-s390x_ccw_virtio TIMEOUT        180.05s   killed by signal 15 
SIGTERM
2/5 qemu:func-quick+func-s390x / func-s390x-empty_cpu_model 
          ERROR            0.21s   exit status 1
4/5 qemu:func-quick+func-s390x / func-s390x-version 
          ERROR            0.25s   exit status 1

I'm surprised by "Could not access KVM kernel module" because
kvm_available() checks for RW access:

   def kvm_available(target_arch: Optional[str] = None,
                     qemu_bin: Optional[str] = None) -> bool:
       if not os.access("/dev/kvm", os.R_OK | os.W_OK):
           return False

Maybe missing require_accelerator() in tests?

