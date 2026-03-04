Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E96EDEBFC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxajA-0007R3-MN; Tue, 03 Mar 2026 20:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxaj9-0007Qk-7y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:08:39 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxaj7-0006HP-1t
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:08:38 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 bbad38fcc903f08aac8a34fb38bf4536185f8411583b835b7bb0c42ea97dc03e with SMTP id
 69a7860b4ce38e3214e11674; Wed, 04 Mar 2026 01:08:27 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772586507;
 bh=kDjXa0tH01bQbdhHxQjGRUx6dbdyLDrjECGJFp5Aw10=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=IPkMENs/d6xofws+6b1WDVIXedG7M6VSzMCj+5MpZQ1hFLCTNXKqN+yr+nY2GTrTJ
 iFfcfJpONanGwlisAm+2SxT6Ulvs9EeZg4G1O1PhQA3b+ToJH7WXH+Nhsh/RE5Jj5J
 kDJYaggfUBQ/Q2J1SOLap+HUQa/Iv9FdATdPx/lPVhY8O4Zcg3L/zPNP+yBRj4vzEx
 K41Lr6JeMri/9V9jgiHggVBYGQurwlQqsGFuuM3gMTLuIOl8QVClFfL4JGbBBsFJjS
 Hv09NvAzQBbOgyNpX1dF1xbpR8ggB+QRH31xoeXmSBT3ZzEDlCL5E/l9HQ8q8ILLAB
 qZMBgPsU57bSA==
Message-ID: <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
Date: Tue, 3 Mar 2026 19:08:25 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260303012054.484837-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

+Daniel (thanks for your comments)

On 02/03/2026 19:20, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
> clang if available, otherwise disable the treatment of warnings as
> errors.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
> Hi,
> 
> The previous version only disabled Werror whenever `--skip-meson` wasn't
> used and the build occurred in a git repo, but this change should
> probably apply to all types of builds. So, let's use meson_option_add
> to globally disable Werror instead; IIUC (and according to my testing),
> this will override the value in config-meson.cross.new.
> 
> I'm still not sure if we should be disabling Werror for ubsan, even
> though it's not currently breaking builds with GCC; please let me know
> what you think.
> 
> Special thanks to Peter for looking into the cause of the reports around
> this, for sharing the findings, and suggesting approaches to resolve it.
> I couldn't pick one over the other, so I went with using clang when
> available with Werror disable as a fallback; please let me know if you
> think this is an XOR kind of policy decision.
> 
> Link to RFCv1:
> https://lore.kernel.org/qemu-devel/20260302210039.261325-1-yodel.eldar@yodel.dev/
> 
> Link to mentioned discussion:
> https://lore.kernel.org/qemu-devel/CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/
> 
> v2:
> - Fix misnomer in commit message
> - Simplify condition by using the same variable for all sanitizers
> - Use meson_option_add to disable Werror
> 
> Thanks,
> Yodel
> ---
>   configure | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/configure b/configure
> index 5e114acea2..e457e8a17d 100755
> --- a/configure
> +++ b/configure
> @@ -762,6 +762,12 @@ for opt do
>     ;;
>     --wasm64-32bit-address-limit)
>     ;;
> +  --enable-asan) use_sanitizer="yes"
> +  ;;
> +  --enable-tsan) use_sanitizer="yes"
> +  ;;
> +  --enable-safe-stack) use_sanitizer="yes"
> +  ;;
>     # everything else has the same name in configure and meson
>     --*) meson_option_parse "$opt" "$optarg"
>     ;;
> @@ -771,6 +777,18 @@ for opt do
>     esac
>   done
>   
> +if test "$use_sanitizer" = "yes"; then
> +    if has clang; then
> +        echo "Sanitizer requested: setting compiler suite to clang"
> +        cc=clang
> +        cxx=clang++
> +        host_cc=clang
> +    else
> +        echo "Sanitizer requested: disabling Werror for non-clang compilers"
> +        meson_option_add -Dwerror=false
> +    fi
> +fi
> +
>   if ! test -e "$source_path/.git"
>   then
>       git_submodules_action="validate"

We could treat the rtl8139 as a one-off by carving out the
offending code with a GCC pragma or finagling GCC into cooperation
by substituting eth_payload_data with the expression assigned to it
(thank you, Thomas and Daniel, respectively); indeed, AFAICT the
rtl8139 is currently the only code that triggers the GCC bug
(and is overdue for a refactor/cleanup), so it's tempting to go with
either of these helpful suggestions; *however*, until the GCC team
fixes their buggy pairing between sanitizer and -Werror
(a pairing that they themselves disavow [1]), IMHO there's a
significant risk of recurrence if we went with either option, and
it's not clear to me whether reviewers will be able easily spot the
next one before it's too late (post-acceptance).

That said, I fully share Daniel's concerns about "overriding the
user's choice of compiler"; so, what if we instead moved the
sanitizer check into the existing "Preferred compiler" section
in configure, such that we only set cc=clang when the user hasn't
explicitly specified CC/CXX (diff below)? Note: there's already
precedent for this with the Obj-C compiler [2].

I'm definitely onboard with Daniel's warning message in meson whenever
the user: 1) explicitly opts for gcc/g++, 2) enables sanitizers, and 3)
-Werror is enabled. At the risk of overengineering, though, what if we
made it an error message instead, and gave users an escape hatch like
`--force-werror-sanitizers` (name TBD)? I can see that being too much,
but it may prevent some grief if they missed the warning, and the build
breaks several minutes later. WDYT? It's not included in the diff below,
but I'll gladly add it to v3 if there's interest; if not, I'll go with
the warning message as suggested.

Thanks,
Yodel

[1] https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html (Peter)
[2] 
https://gitlab.com/qemu-project/qemu/-/blob/master/configure?ref_type=heads#L302-315

-- >8 --

diff --git a/configure b/configure
index 5e114acea2..861723b0a4 100755
--- a/configure
+++ b/configure
@@ -245,6 +245,12 @@ for opt do
    ;;
    --wasm64-32bit-address-limit) wasm64_memory64="2"
    ;;
+  --enable-asan) use_sanitizers="yes"
+  ;;
+  --enable-tsan) use_sanitizers="yes"
+  ;;
+  --enable-safe-stack) use_sanitizers="yes"
+  ;;
    esac
  done

@@ -286,15 +292,25 @@ static="no"
  # Preferred compiler:
  #  ${CC} (if set)
  #  ${cross_prefix}gcc (if cross-prefix specified)
-#  system compiler
+#  clang if sanitizer requested, otherwise system compiler
  if test -z "${CC}${cross_prefix}"; then
-  cc="cc"
+  if test "$use_sanitizers" = "yes" && has clang; then
+    cc=clang
+    echo "Sanitizer requested: setting cc to clang"
+  else
+    cc="cc"
+  fi
  else
    cc="${CC-${cross_prefix}gcc}"
  fi

  if test -z "${CXX}${cross_prefix}"; then
-  cxx="c++"
+  if test "$use_sanitizers" = "yes" && has clang; then
+    cxx=clang++
+    echo "Sanitizer requested: setting cxx to clang++"
+  else
+    cxx="c++"
+  fi
  else
    cxx="${CXX-${cross_prefix}g++}"
  fi


