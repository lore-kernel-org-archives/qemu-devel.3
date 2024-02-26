Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUW2-0000jZ-R1; Mon, 26 Feb 2024 01:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1reUVx-0000j8-OX
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:31:01 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1reUVu-0002sS-99
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:31:01 -0500
Received: from [192.168.178.59] (p57b42e65.dip0.t-ipconnect.de [87.180.46.101])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 247C4DA078B;
 Mon, 26 Feb 2024 07:30:55 +0100 (CET)
Content-Type: multipart/alternative;
 boundary="------------zAyEWsJIpIGBrkY2ohHhoi0t"
Message-ID: <3b6e065d-c50f-4503-bcd1-f6f08e734d97@weilnetz.de>
Date: Mon, 26 Feb 2024 07:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] scripts/nsis.py: Automatically package required DLLs
 of QEMU executables
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20220908132817.1831008-1-bmeng.cn@gmail.com>
 <20220908132817.1831008-4-bmeng.cn@gmail.com>
 <556496df-4362-6780-8379-e14bf4269e3f@ilande.co.uk>
 <CAEUhbmVmKhJJk0pQcVJKryie+V4uZEznZCu0dzjftYCycBtD8w@mail.gmail.com>
 <504673a3-d269-428d-876d-fd3dcc8fe680@weilnetz.de>
 <CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com>
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------zAyEWsJIpIGBrkY2ohHhoi0t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.02.24 um 05:35 schrieb Bin Meng:

> On Mon, Feb 26, 2024 at 1:37 AM Stefan Weil<sw@weilnetz.de>  wrote:
>> Am 10.09.22 um 02:37 schrieb Bin Meng:
>>> On Sat, Sep 10, 2022 at 12:49 AM Mark Cave-Ayland
>>> <mark.cave-ayland@ilande.co.uk>  wrote:
>>>> On 08/09/2022 14:28, Bin Meng wrote:
>>>>
>>>>> From: Bin Meng<bin.meng@windriver.com>
>>>>>
>>>>> At present packaging the required DLLs of QEMU executables is a
>>>>> manual process, and error prone.
>>>>>
>>>>> Actually build/config-host.mak contains a GLIB_BINDIR variable
>>>>> which is the directory where glib and other DLLs reside. This
>>>>> works for both Windows native build and cross-build on Linux.
>>>>> We can use it as the search directory for DLLs and automate
>>>>> the whole DLL packaging process.
>>>>>
>>>>> Signed-off-by: Bin Meng<bin.meng@windriver.com>
>>>>> ---
>>>>>
>>>>>     meson.build     |  1 +
>>>>>     scripts/nsis.py | 46 ++++++++++++++++++++++++++++++++++++++++++----
>>>>>     2 files changed, 43 insertions(+), 4 deletions(-)
>>>>>
>> [...]>>> diff --git a/scripts/nsis.py b/scripts/nsis.py
>>>>> index baa6ef9594..03ed7608a2 100644
>>>>> --- a/scripts/nsis.py
>>>>> +++ b/scripts/nsis.py
>>>>> @@ -18,12 +18,36 @@ def signcode(path):
>>>>>             return
>>>>>         subprocess.run([cmd, path])
>>>>>
>>>>> +def find_deps(exe_or_dll, search_path, analyzed_deps):
>>>>> +    deps = [exe_or_dll]
>>>>> +    output = subprocess.check_output(["objdump", "-p", exe_or_dll], text=True)
>> This fails on non x86 hosts where objdump does not know how to handle a
>> Windows x86_64 exe file.
> Does this command work in the MSYS2 environment on Windows Arm?


I don't know and cannot test that, because I don't run Windows on ARM.

>>>>> +    output = output.split("\n")
>>>>> +    for line in output:
>>>>> +        if not line.startswith("\tDLL Name: "):
>>>>> +            continue
>>>>> +
>>>>> +        dep = line.split("DLL Name: ")[1].strip()
>>>>> +        if dep in analyzed_deps:
>>>>> +            continue
>>>>> +
>>>>> +        dll = os.path.join(search_path, dep)
>>>>> +        if not os.path.exists(dll):
>>>>> +            # assume it's a Windows provided dll, skip it
>>>>> +            continue
>>>>> +
>>>>> +        analyzed_deps.add(dep)
>>>>> +        # locate the dll dependencies recursively
>>>>> +        rdeps = find_deps(dll, search_path, analyzed_deps)
>>>>> +        deps.extend(rdeps)
>>>>> +
>>>>> +    return deps
>> [...]
>>>> FWIW I wrote a similar script a while back to help package a custom Windows build for
>>>> a client, however I used ldd instead of objdump since it provided the full paths for
>>>> DLLs installed in the msys2/mingw-w64 environment via pacman which were outside the
>>>> QEMU build tree.
>>>>
>>> Yep, ldd also works, but only on Windows native build. objdump can
>>> work on both Windows native and Linux cross builds.
>>
>> objdump fails on Linux cross builds on any non x86 host, because objdump
>> typically only supports the native host architecture.
>>
>> Therefore I get an error on an ARM64 host (podman on Mac M1):
>>
>>           objdump: /tmp/tmpvae5u0qm/qemu/qemu-system-aarch64.exe: file
>> format not recognized
>>
>> I could use x86_64-w64-mingw32-objdump to fix the cross builds, but then
>> native builds might fail because they don't have x86_64-w64-mingw32-objdump.
>>
>> Is there a simple way how we can get the information here whether
>> objdump requires a cross build prefix?
> For QEMU Windows, I believe the only supported architecture is x86_64,
> correct? Do we want to support (cross) building QEMU for Windows Arm?


Yes, I think we only support QEMU on Windows x86_64. I also don't know 
anyone who has tried building for Windows ARM. And up to now I also was 
never asked for that, so obviously there is still no need for it.


> Based on your observation, objdump on Linux cross builds on any x86
> host works, but not on non x86 host.
> Maybe it's a hint to ask for binutils guys to include the PE format
> support for objdump Arm by default.


I am afraid that we'll have to find a solution on the QEMU side, not 
wait until all binutils support the PE format for x86_64 (which would 
make the binaries or the library much larger).

Stefan


--------------zAyEWsJIpIGBrkY2ohHhoi0t
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Am 26.02.24 um 05:35 schrieb Bin Meng:</p>
    <blockquote type="cite"
cite="mid:CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Mon, Feb 26, 2024 at 1:37 AM Stefan Weil <a class="moz-txt-link-rfc2396E" href="mailto:sw@weilnetz.de">&lt;sw@weilnetz.de&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Am 10.09.22 um 02:37 schrieb Bin Meng:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Sat, Sep 10, 2022 at 12:49 AM Mark Cave-Ayland
<a class="moz-txt-link-rfc2396E" href="mailto:mark.cave-ayland@ilande.co.uk">&lt;mark.cave-ayland@ilande.co.uk&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
On 08/09/2022 14:28, Bin Meng wrote:

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">From: Bin Meng <a class="moz-txt-link-rfc2396E" href="mailto:bin.meng@windriver.com">&lt;bin.meng@windriver.com&gt;</a>

At present packaging the required DLLs of QEMU executables is a
manual process, and error prone.

Actually build/config-host.mak contains a GLIB_BINDIR variable
which is the directory where glib and other DLLs reside. This
works for both Windows native build and cross-build on Linux.
We can use it as the search directory for DLLs and automate
the whole DLL packaging process.

Signed-off-by: Bin Meng <a class="moz-txt-link-rfc2396E" href="mailto:bin.meng@windriver.com">&lt;bin.meng@windriver.com&gt;</a>
---

   meson.build     |  1 +
   scripts/nsis.py | 46 ++++++++++++++++++++++++++++++++++++++++++----
   2 files changed, 43 insertions(+), 4 deletions(-)

</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">[...]&gt;&gt;&gt; diff --git a/scripts/nsis.py b/scripts/nsis.py
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">index baa6ef9594..03ed7608a2 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -18,12 +18,36 @@ def signcode(path):
           return
       subprocess.run([cmd, path])

+def find_deps(exe_or_dll, search_path, analyzed_deps):
+    deps = [exe_or_dll]
+    output = subprocess.check_output(["objdump", "-p", exe_or_dll], text=True)
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This fails on non x86 hosts where objdump does not know how to handle a
Windows x86_64 exe file.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Does this command work in the MSYS2 environment on Windows Arm?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I don't know and cannot test that, because I don't run Windows on
      ARM.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
cite="mid:CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+    output = output.split("\n")
+    for line in output:
+        if not line.startswith("\tDLL Name: "):
+            continue
+
+        dep = line.split("DLL Name: ")[1].strip()
+        if dep in analyzed_deps:
+            continue
+
+        dll = os.path.join(search_path, dep)
+        if not os.path.exists(dll):
+            # assume it's a Windows provided dll, skip it
+            continue
+
+        analyzed_deps.add(dep)
+        # locate the dll dependencies recursively
+        rdeps = find_deps(dll, search_path, analyzed_deps)
+        deps.extend(rdeps)
+
+    return deps
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">[...]
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
FWIW I wrote a similar script a while back to help package a custom Windows build for
a client, however I used ldd instead of objdump since it provided the full paths for
DLLs installed in the msys2/mingw-w64 environment via pacman which were outside the
QEMU build tree.

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Yep, ldd also works, but only on Windows native build. objdump can
work on both Windows native and Linux cross builds.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">

objdump fails on Linux cross builds on any non x86 host, because objdump
typically only supports the native host architecture.

Therefore I get an error on an ARM64 host (podman on Mac M1):

         objdump: /tmp/tmpvae5u0qm/qemu/qemu-system-aarch64.exe: file
format not recognized

I could use x86_64-w64-mingw32-objdump to fix the cross builds, but then
native builds might fail because they don't have x86_64-w64-mingw32-objdump.

Is there a simple way how we can get the information here whether
objdump requires a cross build prefix?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For QEMU Windows, I believe the only supported architecture is x86_64,
correct? Do we want to support (cross) building QEMU for Windows Arm?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Yes, I think we only support QEMU on Windows x86_64. I also don't
      know anyone who has tried building for Windows ARM. And up to now
      I also was never asked for that, so obviously there is still no
      need for it.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">Based on your observation, objdump on Linux cross builds on any x86
host works, but not on non x86 host.
Maybe it's a hint to ask for binutils guys to include the PE format
support for objdump Arm by default.
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I am afraid that we'll have to find a solution on the QEMU side,
      not wait until all binutils support the PE format for x86_64
      (which would make the binaries or the library much larger).</p>
    <p>Stefan</p>
    <p><br>
    </p>
  </body>
</html>

--------------zAyEWsJIpIGBrkY2ohHhoi0t--

