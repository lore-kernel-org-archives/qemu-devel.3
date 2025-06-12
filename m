Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E5FC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 22:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPq4U-0003EM-S9; Thu, 12 Jun 2025 18:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uPq4T-0003Dw-0R
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:06:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uPq4Q-0002Lk-Fb
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:06:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 81C2E55BC03;
 Fri, 13 Jun 2025 00:06:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fVfga0KTVRLr; Fri, 13 Jun 2025 00:06:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3237C55BC02; Fri, 13 Jun 2025 00:06:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2D0CC745683;
 Fri, 13 Jun 2025 00:06:46 +0200 (CEST)
Date: Fri, 13 Jun 2025 00:06:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
In-Reply-To: <CACcXsZhwqiLcyuE6uQYTDqQqJucC1FQfXOCNSPwSQKvuEjBCcg@mail.gmail.com>
Message-ID: <860d4ea3-fd5f-b837-4bf6-b55e7032e0ac@eik.bme.hu>
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
 <CAJSP0QXOiaYWo-s8V7tRRBdyzJTCruY5ufvu9zyNPm9ZQR1SrQ@mail.gmail.com>
 <CACcXsZhwqiLcyuE6uQYTDqQqJucC1FQfXOCNSPwSQKvuEjBCcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-314526806-1749766006=:46155"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-314526806-1749766006=:46155
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jun 2025, Oleg Tolmatcev wrote:
> Am Do., 12. Juni 2025 um 21:35 Uhr schrieb Stefan Hajnoczi <stefanha@gmail.com>:
>>
>> On Sat, Jun 7, 2025 at 5:47 AM oltolm <oleg.tolmatcev@gmail.com> wrote:
>>>
>>> Sorry, I forgot to cc the maintainers.
>>>
>>> The build failed when run on Windows. I replaced calls to Unix programs
>>> like ´cat´, ´sed´ and ´true´ with calls to ´python´. I wrapped calls to
>>> ´os.path.relpath´ in try-except because it can fail when the two paths
>>> are on different drives. I made sure to convert the Windows paths to
>>> Unix paths to prevent warnings in generated files.
>>>
>>> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
>>> ---
>>>  contrib/plugins/meson.build         |  2 +-
>>>  plugins/meson.build                 |  2 +-
>>>  scripts/tracetool/__init__.py       | 15 ++++++++++++---
>>>  scripts/tracetool/backend/ftrace.py |  4 +---
>>>  scripts/tracetool/backend/log.py    |  4 +---
>>>  scripts/tracetool/backend/syslog.py |  4 +---
>>>  tests/functional/meson.build        |  4 +---
>>>  tests/include/meson.build           |  2 +-
>>>  tests/tcg/plugins/meson.build       |  2 +-
>>>  trace/meson.build                   |  5 +++--
>>>  10 files changed, 23 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>>> index fa8a426c8..1876bc784 100644
>>> --- a/contrib/plugins/meson.build
>>> +++ b/contrib/plugins/meson.build
>>> @@ -24,7 +24,7 @@ endif
>>>  if t.length() > 0
>>>    alias_target('contrib-plugins', t)
>>>  else
>>> -  run_target('contrib-plugins', command: find_program('true'))
>>> +  run_target('contrib-plugins', command: [python, '-c', ''])
>>>  endif
>>>
>>>  plugin_modules += t
>>> diff --git a/plugins/meson.build b/plugins/meson.build
>>> index 5383c7b88..cb7472df8 100644
>>> --- a/plugins/meson.build
>>> +++ b/plugins/meson.build
>>> @@ -33,7 +33,7 @@ if host_os == 'windows'
>>>      input: qemu_plugin_symbols,
>>>      output: 'qemu_plugin_api.def',
>>>      capture: true,
>>> -    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
>>> +    command: [python, '-c', 'import fileinput, re; print("EXPORTS", end=""); [print(re.sub(r"[{};]", "", line), end="") for line in fileinput.input()]', '@INPUT@'])
>>>
>>>    # then use dlltool to assemble a delaylib.
>>>    # The delaylib will have an "imaginary" name (qemu.exe), that is used by the
>>> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
>>> index bc03238c0..6dfcbf71e 100644
>>> --- a/scripts/tracetool/__init__.py
>>> +++ b/scripts/tracetool/__init__.py
>>> @@ -12,12 +12,14 @@
>>>  __email__      = "stefanha@redhat.com"
>>>
>>>
>>> +import os
>>>  import re
>>>  import sys
>>>  import weakref
>>> +from pathlib import PurePath
>>>
>>> -import tracetool.format
>>>  import tracetool.backend
>>> +import tracetool.format
>>>
>>>
>>>  def error_write(*lines):
>>> @@ -36,7 +38,7 @@ def error(*lines):
>>>
>>>  def out_open(filename):
>>>      global out_filename, out_fobj
>>> -    out_filename = filename
>>> +    out_filename = posix_relpath(filename)
>>>      out_fobj = open(filename, 'wt')
>>>
>>>  def out(*lines, **kwargs):
>>> @@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
>>>              fmt = [fmt_trans, fmt]
>>>          args = Arguments.build(groups["args"])
>>>
>>> -        return Event(name, props, fmt, args, lineno, filename)
>>> +        return Event(name, props, fmt, args, lineno, posix_relpath(filename))
>>>
>>>      def __repr__(self):
>>>          """Evaluable string representation for this object."""
>>> @@ -447,3 +449,10 @@ def generate(events, group, format, backends,
>>>      tracetool.backend.dtrace.PROBEPREFIX = probe_prefix
>>>
>>>      tracetool.format.generate(events, format, backend, group)
>>> +
>>> +def posix_relpath(path, start=None):
>>> +    try:
>>> +        path = os.path.relpath(path, start)
>>> +    except ValueError:
>>> +        pass
>>> +    return PurePath(path).as_posix()
>>> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
>>> index baed2ae61..5fa30ccc0 100644
>>> --- a/scripts/tracetool/backend/ftrace.py
>>> +++ b/scripts/tracetool/backend/ftrace.py
>>> @@ -12,8 +12,6 @@
>>>  __email__      = "stefanha@redhat.com"
>>>
>>>
>>> -import os.path
>>> -
>>>  from tracetool import out
>>>
>>>
>>> @@ -47,7 +45,7 @@ def generate_h(event, group):
>>>          args=event.args,
>>>          event_id="TRACE_" + event.name.upper(),
>>>          event_lineno=event.lineno,
>>> -        event_filename=os.path.relpath(event.filename),
>>> +        event_filename=event.filename,
>>>          fmt=event.fmt.rstrip("\n"),
>>>          argnames=argnames)
>>>
>>> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
>>> index de27b7e62..17ba1cd90 100644
>>> --- a/scripts/tracetool/backend/log.py
>>> +++ b/scripts/tracetool/backend/log.py
>>> @@ -12,8 +12,6 @@
>>>  __email__      = "stefanha@redhat.com"
>>>
>>>
>>> -import os.path
>>> -
>>>  from tracetool import out
>>>
>>>
>>> @@ -55,7 +53,7 @@ def generate_h(event, group):
>>>          '    }',
>>>          cond=cond,
>>>          event_lineno=event.lineno,
>>> -        event_filename=os.path.relpath(event.filename),
>>> +        event_filename=event.filename,
>>>          name=event.name,
>>>          fmt=event.fmt.rstrip("\n"),
>>>          argnames=argnames)
>>> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
>>> index 012970f6c..5a3a00fe3 100644
>>> --- a/scripts/tracetool/backend/syslog.py
>>> +++ b/scripts/tracetool/backend/syslog.py
>>> @@ -12,8 +12,6 @@
>>>  __email__      = "stefanha@redhat.com"
>>>
>>>
>>> -import os.path
>>> -
>>>  from tracetool import out
>>>
>>>
>>> @@ -43,7 +41,7 @@ def generate_h(event, group):
>>>          '    }',
>>>          cond=cond,
>>>          event_lineno=event.lineno,
>>> -        event_filename=os.path.relpath(event.filename),
>>> +        event_filename=event.filename,
>>>          name=event.name,
>>>          fmt=event.fmt.rstrip("\n"),
>>>          argnames=argnames)
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index 52b4706cf..ee222888f 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -411,6 +411,4 @@ foreach speed : ['quick', 'thorough']
>>>    endforeach
>>>  endforeach
>>>
>>> -run_target('precache-functional',
>>> -           depends: precache_all,
>>> -           command: ['true'])
>>> +alias_target('precache-functional', precache_all)
>>
>> Hi Oleg,
>> There is a CI hexagon build failure. Maybe precache_all is []:
>> ../tests/functional/meson.build:417:0: ERROR: alias_target takes at
>> least 2 arguments, but got 1.
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/10336566320#L4267
>>
>> Please take a look. Thanks!
>
> Hi Stefan,
>
> this should be replaced with
>
> run_target('precache-functional',
>           depends: precache_all,
>           command: [python, '-c', ''])
>
> Should I send a v4 of my patch?

I think it would help if you can send a v4 also fixing up the commit 
message as was discussed so Stefan does not have to do it. Generally more 
than trivial fixup needs a new version of the patch sent by the author, 
only fixing simple typos might not need a resend. Ideally maintainers 
should not need to do any fixup just take the latest patch version.

Regards,
BALATON Zoltan
--3866299591-314526806-1749766006=:46155--

