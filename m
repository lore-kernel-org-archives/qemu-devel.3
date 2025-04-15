Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E65C369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dWD-0003HI-7j; Tue, 15 Apr 2025 06:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u4dW7-0003Gx-JS
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:27:47 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u4dW1-00014B-3x
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:27:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:921:0:640:f23d:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 534F060B7D;
 Tue, 15 Apr 2025 13:27:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7211::1:d] (unknown
 [2a02:6b8:b081:7211::1:d])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UREC300FW4Y0-PwV2PruN; Tue, 15 Apr 2025 13:27:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744712853;
 bh=McHGVZI9LUQz/jr3rQzmAokdlzQr0GPijR1U/B7Oll8=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=Lw9ChGpZwfDxaWeYuJRoXlwn+pfb/491DMh9kU0iEhsQQbhfG5n0r/IOxueIFf9xd
 UEMlWq4xE1MCM56eeY1oyeaHDvCPUP1wmJsuWMy6DGfjxiAg5WEiQsfCVX7c86OxAw
 1G0XR01QaimIPyhM9ai07gUubMBw6H6YgDMq9ZdE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------VMxT0Bj0aDSY6bBuoT5G5gXi"
Message-ID: <7c63f352-4ef0-4e1e-b95e-8e3e586799dd@yandex-team.ru>
Date: Tue, 15 Apr 2025 15:27:29 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional: add memlock tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20250415090854.71526-1-dtalexundeer@yandex-team.ru>
 <Z_4k7DEDiiaznG2q@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <Z_4k7DEDiiaznG2q@redhat.com>
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

This is a multi-part message in MIME format.
--------------VMxT0Bj0aDSY6bBuoT5G5gXi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/15/25 14:20, Daniel P. Berrangé wrote:
> On Tue, Apr 15, 2025 at 02:08:55PM +0500, Alexandr Moshkov wrote:
>> Add new tests to check the correctness of the `-overcommit memlock`
>> option (possible values: off, on, on-fault) by using
>> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
>> anonymous segments:
>>
>> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
>> * if `memlock=on`, then Size, Rss and Locked values must be equal for
>> every anon smaps where Rss is not 0;
>> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
>> smaps and anonymous segment with Rss < Size must exists.
> How are you running this test ?  Unprivileged users don't get to
> lock any non-trivial amount of memory by default, and QEMU functional
> tests pretty much exclusively get run as an unprivileged user account.
>
> This test immediately fails when run:
>
>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
> 	Exit code: 1
> 	Command: ./build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -overcommit mem-lock=on
> 	Output: qemu-system-x86_64: mlockall: Cannot allocate memory
>          qemu-system-x86_64: locking memory failed
>
> and we don't expect users to run anything as root.
>
Hello, thanks for reply! Looks like i have a larger amount of memory for 
locking in my system:

 > ulimit -l
4063912

I think that's why this test was successfully running on my system.

Honestly,Idon't know yet how to solve this problem properly. Ithink the 
only ways is to runas root (whichis a bad idea)ortoincrease limits on an 
unprivileged user account by using /etc/security/limits.conf.

Best regards,

Alexandr

--------------VMxT0Bj0aDSY6bBuoT5G5gXi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/15/25 14:20, Daniel P. Berrangé
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Z_4k7DEDiiaznG2q@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Apr 15, 2025 at 02:08:55PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add new tests to check the correctness of the `-overcommit memlock`
option (possible values: off, on, on-fault) by using
`/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
anonymous segments:

* if `memlock=off`, then Locked = 0 on every anonymous smaps;
* if `memlock=on`, then Size, Rss and Locked values must be equal for
every anon smaps where Rss is not 0;
* if `memlock=on-fault`, then Rss and Locked must be equal on every anon
smaps and anonymous segment with Rss &lt; Size must exists.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
How are you running this test ?  Unprivileged users don't get to
lock any non-trivial amount of memory by default, and QEMU functional
tests pretty much exclusively get run as an unprivileged user account.

This test immediately fails when run:

  qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
	Exit code: 1
	Command: ./build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -overcommit mem-lock=on
	Output: qemu-system-x86_64: mlockall: Cannot allocate memory
        qemu-system-x86_64: locking memory failed

and we don't expect users to run anything as root.

</pre>
    </blockquote>
    <p>Hello, thanks for reply! Looks like i have a larger amount of
      memory for locking in my system:</p>
    <p>&gt; ulimit -l<br>
      4063912<br>
    </p>
    <p>I think that's why this test was successfully running on my
      system.<span style="white-space: pre-wrap;">
</span></p>
    <p><span style="white-space: pre-wrap;">Honestly</span><span
      class="G9ddARLpRace29mmTWAb" style="white-space: pre-wrap;">,</span><span
      style="white-space: pre-wrap;"> </span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">I</span><span
      style="white-space: pre-wrap;"> don't know yet how to solve this </span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">problem properly. I</span><span
      style="white-space: pre-wrap;"> think the only ways is </span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">to run</span><span
      style="white-space: pre-wrap;"> as root (</span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">which</span><span
      style="white-space: pre-wrap;"> is a bad idea)</span><span
      class="TIR_4zQIf1cnClIRNO3A" style="white-space: pre-wrap;"></span><span
      style="white-space: pre-wrap;"> or</span><span
      class="G9ddARLpRace29mmTWAb" style="white-space: pre-wrap;"> to</span><span
      style="white-space: pre-wrap;"> increase limits on </span><span
      class="G9ddARLpRace29mmTWAb" style="white-space: pre-wrap;">an </span><span
      style="white-space: pre-wrap;">unprivileged user account </span><span
      class="G9ddARLpRace29mmTWAb" style="white-space: pre-wrap;">by </span><span
      style="white-space: pre-wrap;">using </span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">/etc/security/limits</span><span
      style="white-space: pre-wrap;">.</span><span
      class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">conf.</span></p>
    <p><span class="H9RPJ5gKJhRWbrMl3kDi" style="white-space: pre-wrap;">
</span></p>
    <p>Best regards,</p>
    <p>Alexandr<br>
    </p>
  </body>
</html>

--------------VMxT0Bj0aDSY6bBuoT5G5gXi--

