Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE37C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6Fm-0001rO-91; Mon, 19 Feb 2024 11:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rc6Fk-0001r9-57
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:12:24 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rc6Fi-0005cT-1N
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:12:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 415AA4E98B;
 Mon, 19 Feb 2024 19:12:29 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D5AB9842F1;
 Mon, 19 Feb 2024 19:12:10 +0300 (MSK)
Message-ID: <5b763bd2-387c-42c0-ba36-af4594a894b9@tls.msk.ru>
Date: Mon, 19 Feb 2024 19:12:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: do not require gcc runtime library for
 firmwares
Content-Language: en-US
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240216181238.262772-1-marmarek@invisiblethingslab.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240216181238.262772-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

16.02.2024 21:12, Marek Marczykowski-Górecki :
> probe_target_compiler() when checking for multilib support checks if
> -nostdlib works together with -lgcc. It isn't necessary for building
> various components in pc-bios/optionrom, as evidenced by looking at
> actually used link flags there.
> Alpine Linux for x86_64 does not ship with 32bit libgcc, but its gcc is
> otherwise perfectly capable of building firmwares in pc-bios/optionrom
> dir. Make configure recognize this situation.

This is exactly the same situation as I faced on debian.  However it was
easy to work around in debian, - there, there's an i386 cross-compiler
available, which is found automatically by the current ./configure just
fine, and it is named the same way on debian and fedora for example.

> Keep requiring functional -lgcc in other places.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>   configure | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index ff058d6c48..7721999f49 100755
> --- a/configure
> +++ b/configure
> @@ -1216,7 +1216,7 @@ have_target() {
>     return 1
>   }
>   
> -# probe_target_compiler TARGET
> +# probe_target_compiler TARGET [nostdlib-extra-ldflags]
>   #
>   # Look for a compiler for the given target, either native or cross.
>   # Set variables target_* if a compiler is found, and container_cross_*
> @@ -1226,6 +1226,9 @@ have_target() {
>   #
>   # If TARGET is a user-mode emulation target, also set build_static to
>   # "y" if static linking is possible.
> +# When testing -nostdlib build, -lgcc will be added for more extensive multilib
> +# support test, but the -lgcc can be overriden with the second argument to the
> +# function.
>   #
>   probe_target_compiler() {
>     # reset all output variables
> @@ -1243,6 +1246,7 @@ probe_target_compiler() {
>     container_cross_strip=
>   
>     target_arch=${1%%-*}
> +  nostdlib_ldflags=${2--lgcc}

This is a) difficult to follow, and b) difficult to override too,
if we don't need any options besides removing -lgcc (like using " "
which will be removed by the shell down the line).  At the very
least this ${..} is better to be written in double quotes, to allow
more options in one arg.

Maybe it's better to do it other way around?  Like, to pass additional
options required for -nostdlib case, including -lgcc, in the places where
it is actually required?

Also, I'd use an option here, - positional parameter is definitely too
difficult to follow.  Like

   probe_target_compiler [-nostdlib-ldflags=foo] TARGET

   nostdlib_ldflags=
   case "$1" in
     -nostdlib-ldflags=*) nostdlib_ldflags="${1#*=}"; shift;;
   esac

>     case $target_arch in
>       aarch64) container_hosts="x86_64 aarch64" ;;
>       alpha) container_hosts=x86_64 ;;
> @@ -1432,7 +1436,7 @@ probe_target_compiler() {
>       case $1 in
>         *-softmmu)
>           if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
> -          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
> +          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" $nostdlib_ldflags; then
>             got_cross_cc=yes
>             break
>           fi
> @@ -1544,7 +1548,7 @@ echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
>   if have_target i386-softmmu x86_64-softmmu && \
>           test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
>           test "$host_os" != "haiku" && \
> -        probe_target_compiler i386-softmmu; then
> +        probe_target_compiler i386-softmmu ""; then
>       subdirs="$subdirs pc-bios/optionrom"
>       config_mak=pc-bios/optionrom/config.mak
>       echo "# Automatically generated by configure - do not modify" > $config_mak


