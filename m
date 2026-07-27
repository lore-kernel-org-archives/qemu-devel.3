Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7992EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJNG-00087A-O0; Mon, 27 Jul 2026 07:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1woJND-0007xM-Vd
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:19:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1woJNB-0007Ml-KX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:19:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C5145835F8;
 Mon, 27 Jul 2026 13:19:49 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uAGEZHy7VDrX; Mon, 27 Jul 2026 13:19:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7DED5835F4; Mon, 27 Jul 2026 13:19:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C5D62583229;
 Mon, 27 Jul 2026 13:19:46 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:19:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] Add option to disable building tests
In-Reply-To: <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
Message-ID: <6b432df2-b318-75ec-e26d-e1134baa06ca@eik.bme.hu>
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
 <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-348381267-1785151186=:14453"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-348381267-1785151186=:14453
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Jul 2026, Thomas Huth wrote:
> On 27/07/2026 10.12, Philippe Mathieu-Daudé wrote:
>> On 24/7/26 18:45, Pierrick Bouvier wrote:
>>> On 7/24/2026 6:54 AM, Florian Schmidt wrote:
>>>> There are situations in which you might want to build QEMU without
>>>> building the full test suite, which in some configurations can take a
>>>> considerable amount of time to build. This is especially true when using
>>>> LTO with clang. For example:
>>>> 
>>>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' 
>>>> '--extra-cflags=-flto=thin -ffat-lto-objects' 
>>>> --target-list=x86_64-softmmu
>>>> [...]
>>>> $ time make -j8
>>>> [...]
>>>> [3078/3078] Linking target tests/qtest/qos-test
>>>> real    6m43.250s
>>>> user    101m15.967s
>>>> sys     4m3.813s
>>>> 
>>>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' 
>>>> '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64- 
>>>> softmmu --disable-tests
>>>> [...]
>>>> $ time make -j8
>>>> [...]
>>>> [2024/2024] Linking target qemu-system-x86_64
>>>> 
>>>> real    3m14.277s
>>>> user    33m13.174s
>>>> sys     1m36.642s
>>>> 
>>>> Add a toggle to optionally disable building tests.
>>>> 
>>>> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
>>>> ---
>>>>   meson.build                   | 2 +-
>>>>   meson_options.txt             | 2 ++
>>>>   scripts/meson-buildoptions.sh | 3 +++
>>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/meson.build b/meson.build
>>>> index 49a5baf5b5..ad728c26ec 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -4605,7 +4605,7 @@ subdir('docs')
>>>>   subdir('pyvenv')
>>>>   # Tests are disabled on emscripten because they rely on host features 
>>>> that aren't
>>>>   # supported by emscripten (e.g. fork and unix socket).
>>>> -if host_os != 'emscripten'
>>>> +if get_option('tests').allowed() and host_os != 'emscripten'
>>>>     subdir('tests')
>>>>   endif
>>>>   if gtk.found()
>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>> index a07cb47d35..68333ca402 100644
>>>> --- a/meson_options.txt
>>>> +++ b/meson_options.txt
>>>> @@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
>>>>   # on the configure script command line.  After adding an option
>>>>   # here make sure to run "make update-buildoptions".
>>>> +option('tests', type: 'feature', value: 'auto',
>>>> +       description: 'Build the test suite')
>>>>   option('docs', type : 'feature', value : 'auto',
>>>>          description: 'Documentations build support')
>>>>   option('fuzzing', type : 'boolean', value: false,
>>>> diff --git a/scripts/meson-buildoptions.sh 
>>>> b/scripts/meson-buildoptions.sh
>>>> index c003985047..3fec13a336 100644
>>>> --- a/scripts/meson-buildoptions.sh
>>>> +++ b/scripts/meson-buildoptions.sh
>>>> @@ -194,6 +194,7 @@ meson_options_help() {
>>>>     printf "%s\n" '  spice-protocol  Spice protocol support'
>>>>     printf "%s\n" '  stack-protector compiler-provided stack protection'
>>>>     printf "%s\n" '  tcg             TCG support'
>>>> +  printf "%s\n" '  tests           build test suite'
>>>>     printf "%s\n" '  tools           build support utilities that come 
>>>> with QEMU'
>>>>     printf "%s\n" '  tpm             TPM support'
>>>>     printf "%s\n" '  u2f             U2F emulation support'
>>>> @@ -515,6 +516,8 @@ _meson_option_parse() {
>>>>       --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
>>>>       --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
>>>>       --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
>>>> +    --enable-tests) printf "%s" -Dtests=enabled ;;
>>>> +    --disable-tests) printf "%s" -Dtests=disabled ;;
>>>>       --enable-tools) printf "%s" -Dtools=enabled ;;
>>>>       --disable-tools) printf "%s" -Dtools=disabled ;;
>>>>       --enable-tpm) printf "%s" -Dtpm=enabled ;;
>>> 
>>> That's a great addition, including just for speeding up normal builds.
>>> 
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> 
>>> If we want to overengineer the thing, it could be possible to still
>>> declare all tests, but not build them by default. However, it's probably
>>> too error prone and much less simple than this patch. So I don't think
>>> it's a good idea.
>>> 
>>> Regards,
>>> Pierrick
>>> 
>> 
>> When is it useful to build without the provided test suite?
> I sometimes wished indeed for a --disable-tests switch in the past already 
> (was just too lazy to contribute a patch): I'm sometimes building QEMU in a 
> separate directory, just for a very special case like testing a patch with an 
> --enable-asan build, or for doing a "git bisect". In such cases, I never want 
> to run the normal tests since it's simply not necessary. I run the tests from 
> my main build directory instead once I have a final patch and want to 
> contribute it to upstream. So IMHO this patch is a good idea.

I similarly have a local patch for this for such usage, that I never 
cleaned up to submit but I think it's a good idea.

Regards,
BALATON Zoltan
--3866299591-348381267-1785151186=:14453--

