Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF294C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 05:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUJt4-00082D-LL; Mon, 29 Jan 2024 00:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rUJsw-00081H-JB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 00:08:42 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rUJst-0000j7-FD
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 00:08:41 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 2181D40F1DFB;
 Mon, 29 Jan 2024 05:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2181D40F1DFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1706504917;
 bh=I2deGiXAK9W7WTv6NCXDiR6I3ZFue4upC+rSReqVl4Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CmFyJTi/uiNo0OwbBJx49T4f3EILWsIWW0NtCOSo/FUP9u72CCs7I4BYDC7xQK2+L
 akws7p8fcgPyrNVutdcoP84klvVrANfcm8g/fBFS97P59o/ygSUzu92w4ZKmdABS2E
 7Y/Xc3fTZEEQ3zqqquSDWl9MK7k3MwuhpzFGjDXk=
Message-ID: <7b85e87b-d5b5-436a-8133-e921905aa479@ispras.ru>
Date: Mon, 29 Jan 2024 08:08:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240125160835.480488-1-npiggin@gmail.com>
 <20240125160835.480488-5-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240125160835.480488-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 25.01.2024 19:08, Nicholas Piggin wrote:
> This runs replay-dump.py after recording a trace, and fails the test if
> the script fails.
> 
> replay-dump.py is modified to exit with non-zero if an error is
> encountered while parsing, to support this.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   scripts/replay-dump.py         |  6 ++++--
>   tests/avocado/replay_kernel.py | 16 ++++++++++++++++
>   tests/avocado/replay_linux.py  | 16 ++++++++++++++++
>   3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index a1d7ae0364..bfea9c099b 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -21,6 +21,7 @@
>   import argparse
>   import struct
>   import os
> +import sys
>   from collections import namedtuple
>   from os import path
>   
> @@ -104,7 +105,7 @@ def call_decode(table, index, dumpfile):
>           print("Could not decode index: %d" % (index))
>           print("Entry is: %s" % (decoder))
>           print("Decode Table is:\n%s" % (table))
> -        return False
> +        raise(Exception("unknown event"))
>       else:
>           return decoder.fn(decoder.eid, decoder.name, dumpfile)
>   
> @@ -125,7 +126,7 @@ def print_event(eid, name, string=None, event_count=None):
>   def decode_unimp(eid, name, _unused_dumpfile):
>       "Unimplemented decoder, will trigger exit"
>       print("%s not handled - will now stop" % (name))
> -    return False
> +    raise(Exception("unhandled event"))
>   
>   def decode_plain(eid, name, _unused_dumpfile):
>       "Plain events without additional data"
> @@ -439,6 +440,7 @@ def decode_file(filename):
>                                       dumpfile)
>       except Exception as inst:
>           print(f"error {inst}")
> +        sys.exit(1)
>   
>       finally:
>           print(f"Reached {dumpfile.tell()} of {dumpsize} bytes")
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index 10d99403a4..9b3ee6726b 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -13,6 +13,7 @@
>   import shutil
>   import logging
>   import time
> +import subprocess
>   
>   from avocado import skip
>   from avocado import skipUnless
> @@ -22,6 +23,11 @@
>   from avocado.utils import process
>   from boot_linux_console import LinuxKernelTest
>   
> +from pathlib import Path
> +
> +self_dir = Path(__file__).parent
> +src_dir = self_dir.parent.parent
> +
>   class ReplayKernelBase(LinuxKernelTest):
>       """
>       Boots a Linux kernel in record mode and checks that the console
> @@ -63,6 +69,8 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
>               vm.shutdown()
>               logger.info('finished the recording with log size %s bytes'
>                           % os.path.getsize(replay_path))
> +            self.run_replay_dump(replay_path)
> +            logger.info('successfully tested replay-dump.py')
>           else:
>               vm.wait()
>               logger.info('successfully finished the replay')
> @@ -70,6 +78,14 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
>           logger.info('elapsed time %.2f sec' % elapsed)
>           return elapsed
>   
> +    def run_replay_dump(self, replay_path):
> +        try:
> +            subprocess.check_call(["./scripts/replay-dump.py",
> +                                   "-f", replay_path],
> +                                  cwd=src_dir, stdout=subprocess.DEVNULL)
> +        except subprocess.CalledProcessError:
> +            self.fail('replay-dump.py failed')
> +
>       def run_rr(self, kernel_path, kernel_command_line, console_pattern,
>                  shift=7, args=None):
>           replay_path = os.path.join(self.workdir, 'replay.bin')
> diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
> index f3a43dc98c..dd148ff639 100644
> --- a/tests/avocado/replay_linux.py
> +++ b/tests/avocado/replay_linux.py
> @@ -11,6 +11,7 @@
>   import os
>   import logging
>   import time
> +import subprocess
>   
>   from avocado import skipUnless
>   from avocado_qemu import BUILD_DIR
> @@ -21,6 +22,11 @@
>   from avocado.utils.path import find_command
>   from avocado_qemu import LinuxTest
>   
> +from pathlib import Path
> +
> +self_dir = Path(__file__).parent
> +src_dir = self_dir.parent.parent
> +
>   class ReplayLinux(LinuxTest):
>       """
>       Boots a Linux system, checking for a successful initialization
> @@ -94,6 +100,8 @@ def launch_and_wait(self, record, args, shift):
>               vm.shutdown()
>               logger.info('finished the recording with log size %s bytes'
>                   % os.path.getsize(replay_path))
> +            self.run_replay_dump(replay_path)
> +            logger.info('successfully tested replay-dump.py')
>           else:
>               vm.event_wait('SHUTDOWN', self.timeout)
>               vm.wait()
> @@ -108,6 +116,14 @@ def run_rr(self, args=None, shift=7):
>           logger = logging.getLogger('replay')
>           logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
>   
> +    def run_replay_dump(self, replay_path):
> +        try:
> +            subprocess.check_call(["./scripts/replay-dump.py",
> +                                   "-f", replay_path],
> +                                  cwd=src_dir, stdout=subprocess.DEVNULL)
> +        except subprocess.CalledProcessError:
> +            self.fail('replay-dump.py failed')
> +
>   @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>   class ReplayLinuxX8664(ReplayLinux):
>       """


