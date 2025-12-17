Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BABD66B81
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVw1v-0000fE-AZ; Wed, 17 Dec 2025 13:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVw1t-0000f2-GQ
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:13:41 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVw1r-0002LU-Ir
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:13:41 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0eaf55d58so5782455ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765995218; x=1766600018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L8DgTyvbqMUayO2l1xNnvYO2P3fS9oDX8SyjcTFpp0o=;
 b=jZrKSc7WyI20s8tGzGkCbc1LhfmSASWoWb4S/KRt5bn5FBz0RA5H8Pa7u4Z+qIEp25
 xCJgVnm15X8z+5Cr/gXlKI66MP1m0GRL2twn8Ls9PtWvQ8LQ1MESYpIgyYzX24dTSb/b
 pW4A0j0UM0n+ljyP2iwVBsNPcYUTDlvgLg/VOUdthsXW5tkXCgFsvBP+q7P2r+b2YZld
 f5UBdFsuTRi1SZq/OZyU2gcWvWsqsTfnSLn8Pg2pKeAj0oFddfjAusC4tlpQDV8riP97
 2gv+MEMbx/yCMkvsuerCTe9Zs68dSfFm835pC7BIGVCqJgjQbnglI7i3S7kORZOvxNxS
 XDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765995218; x=1766600018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L8DgTyvbqMUayO2l1xNnvYO2P3fS9oDX8SyjcTFpp0o=;
 b=c3i3M92xj7vY5DOyoHm+RH+V50hiV8VbT/9uSDzsVrIPRYYEeJ42e26BD+IX4nTwmF
 NhJoYMHjNqAW362yuxq8jYM8zHiTUNr2iaPspBMVrpaJIGWL70T12LOaaIc5xvy7XqBh
 NM0+EPsDngWL0Twf0vS6OuOhsMNvMVxEid245xpC/rStalYc0Fe5+8BlerbWEd3oX1I+
 +B3kR2KTVe+ILS85rAI+t23riienCk2KDulbnUQJBvznEZDy+/L+70NPByHXMI9Lofoa
 a15CyQ8lNRDMnTUmdCBplmrMJxTSf1A29qnQhWSdhFDt2tgan/fkIiUuftHvyvgrIdk0
 H6tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg1eZWONp/IgDApSNqRm5+GlkTelZwPYvXIWjbrL4+l9ITYe5uPlM61AJAKO1vRl6P/H1pZcv1aDrf@nongnu.org
X-Gm-Message-State: AOJu0YxAW2tnre52rVG34+YbusylTNWfHadi9M0adW4V2jBbsZ5i3Fig
 RiiZMzaoU/JR0sRFXFyzDhSlxoeZEHZwph+GZj5bpfUZkjh+oUnZJ66Op6c//4ZBBw9SaC9jq9F
 lhu/jA1c=
X-Gm-Gg: AY/fxX5xmJ2GiQJG4VY29nt2yswGExzOApvytW7QR0+Un25TTD6KRv7S5sTYudblJxd
 zMwcu2SB47+A/QWeFvxbG2/KmwMGulZjC3DgQUUVHxLtqchDeCT6jDFLqoMIUl1mbA2x7q2IlRI
 mFsOLYWFo5ieVHllLkWwShgkZpw7rhtVhm0py4ks26atUQZk0XBjvRhkZbiPk5ao6SiaxmYVbKA
 wTaZPEwzIQXoTkBQEzZ7vWTK2MsYFmsqxQg4U8ZU57A9b2zNU1UuPTCvGdRAuLeFTxFh0jeJzCz
 E38YOu64t9Lr7Xrk1IPcLjqUABMqu306rx8RHxZ3nvUgaKYp/dJv1WEjtUF6VWxQTOjVeftAdWD
 cLGLaf38eVhZxlzxgPXcU9VL0LLtkxOVsod7ToQIlUjkiAuHH75l07wcXzIN0Bd/rsseI33qygP
 5F1EyAbAvvcaD9+qQpAKqIWPNCl7lElWyE9rSxq12lZoZSiXshbmbjNwk=
X-Google-Smtp-Source: AGHT+IGdYBTs24ilP1LkU/GKDanxnvfYJaLPrfYjzeMmgGpBWyxEFFmm22Th+UzjJ0xS946gB2KVOA==
X-Received: by 2002:a17:90b:3c4d:b0:340:6b6f:4bbf with SMTP id
 98e67ed59e1d1-34e71e6a525mr252649a91.18.1765995217301; 
 Wed, 17 Dec 2025 10:13:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70dcc7bcsm225830a91.13.2025.12.17.10.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:13:36 -0800 (PST)
Message-ID: <09738981-6ee4-47f9-b868-37f3259c06ed@linaro.org>
Date: Wed, 17 Dec 2025 10:13:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qga/vss-win32: Fix ConvertStringToBSTR redefinition
 with newer MinGW
Content-Language: en-US
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: phind.uet@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-2-phind.uet@gmail.com>
 <CAMxuvaw=ZigHsgHf5matsmLrH57y-HE4gwgQy4Oyht4+u58N+g@mail.gmail.com>
 <CAPMcbCqSGCk0kmHF+uJjOjES+sKHQHQ-v59iU_q4QqY3TOTGVg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAPMcbCqSGCk0kmHF+uJjOjES+sKHQHQ-v59iU_q4QqY3TOTGVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/16/25 1:53 AM, Kostiantyn Kostiuk wrote:
> Hi
> 
> On Tue, Dec 16, 2025 at 8:26 AM Marc-André Lureau 
> <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>> wrote:
> 
>     Hi
> 
>     On Mon, Dec 15, 2025 at 8:57 PM <phind.uet@gmail.com
>     <mailto:phind.uet@gmail.com>> wrote:
> 
>         From: Nguyen Dinh Phi <phind.uet@gmail.com
>         <mailto:phind.uet@gmail.com>>
> 
>         Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
>         _com_util namespace via <comutil.h>. This causes a redefinition
>         error when building qemu-ga on Windows with these toolchains.
> 
>         Add a meson check to detect whether ConvertStringToBSTR is already
>         available, and conditionally compile our fallback implementation
>         only when the system does not provide one.
> 
>         Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com
>         <mailto:phind.uet@gmail.com>>
>         ---
>           meson.build               | 12 ++++++++++++
>           qga/vss-win32/install.cpp |  2 ++
>           2 files changed, 14 insertions(+)
> 
>         diff --git a/meson.build b/meson.build
>         index c5710a6a47..60a980e610 100644
>         --- a/meson.build
>         +++ b/meson.build
>         @@ -3299,6 +3299,18 @@ endif
>           # Detect host pointer size for the target configuration loop.
>           host_long_bits = cc.sizeof('void *') * 8
> 
>         +# Detect if ConvertStringToBSTR has been defined in _com_util
>         namespace
>         +if host_os == 'windows'
>         +  has_convert_string_to_bstr = cxx.compiles('''
>         +    #include <comutil.h>
>         +    int main() {
>         +        BSTR b = _com_util::ConvertStringToBSTR("test");
>         +        return b ? 0 : 1;
>         +    }
>         +  ''')
>         +  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR',
>         has_convert_string_to_bstr)
>         +endif
>         +
>           ########################
>           # Target configuration #
>           ########################
>         diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>         index 7b25d9098b..5b7a8e9bc5 100644
>         --- a/qga/vss-win32/install.cpp
>         +++ b/qga/vss-win32/install.cpp
>         @@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
> 
> 
>           /* Support function to convert ASCII string into BSTR (used in
>         _bstr_t) */
>         +#ifndef CONFIG_CONVERT_STRING_TO_BSTR
> 
> 
>     I wonder if it could check __MINGW64_VERSION_MAJOR >= 14 instead of
>     adding a configure-time check.
> 
> 
> @Peter Maydell <mailto:peter.maydell@linaro.org> preferred to avoid 
> specific version-number checks.
> See: https://gitlab.com/qemu-project/qemu/-/issues/3217#note_2935451782 
> <https://gitlab.com/qemu-project/qemu/-/issues/3217#note_2935451782>
> 
> I also preferred the idea of checking the real function present instead 
> of the version of the component.
> 
> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com 
> <mailto:kkostiuk@redhat.com>>
> 
> 
>     lgtm anyway
>     Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
> 
>           namespace _com_util
>           {
>               BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
>         @@ -566,6 +567,7 @@ namespace _com_util
>                   return bstr;
>               }
>           }
>         +#endif
> 
>           /* Stop QGA VSS provider service using Winsvc API  */
>           STDAPI StopService(void)
>         -- 
>         2.43.0
> 

When cross-compiling using fedora-win64-cross, it can find the function 
in header but does not link it.

$ podman run --pull newer --init --rm -it -v $(pwd):$(pwd) -w $(pwd) \
docker.io/pbolinaro/qemu-ci:fedora-win64-cross \
bash -cx './configure $QEMU_CONFIGURE_OPTS && ninja -C build install'
...
[4434/4696] Linking target qga/vss-win32/qga-vss.dll
FAILED: qga/vss-win32/qga-vss.dll
x86_64-w64-mingw32-g++ -m64  -o qga/vss-win32/qga-vss.dll 
qga/vss-win32/qga-vss.dll.p/requester.cpp.obj 
qga/vss-win32/qga-vss.dll.p/provider.cpp.obj 
qga/vss-win32/qga-vss.dll.p/install.cpp.obj 
qga/vss-win32/qga-vss.dll.p/vss-debug.cpp.obj 
-Wl,--allow-shlib-undefined -shared ../qga/vss-win32/qga-vss.def 
-Wl,--start-group -Wl,--out-implib=qga/vss-win32/qga-vss.dll.a 
-fstack-protector-strong -Wl,--no-seh -Wl,--nxcompat -Wl,--dynamicbase 
-Wl,--high-entropy-va -fstack-protector-all -fstack-protector-strong 
-Wl,--add-stdcall-alias -Wl,--enable-stdcall-fixup -lws2_32 -lole32 
-loleaut32 -lshlwapi -luuid -lkernel32 -luser32 -lgdi32 -lwinspool 
-lshell32 -lcomdlg32 -ladvapi32 -Wl,--end-group
/usr/lib/gcc/x86_64-w64-mingw32/14.2.1/../../../../x86_64-w64-mingw32/bin/ld: 
qga/vss-win32/qga-vss.dll.p/install.cpp.obj: in function 
`_bstr_t::Data_t::Data_t(char const*)':
/usr/x86_64-w64-mingw32/sys-root/mingw/include/comutil.h:279:(.text+0x1dc8): 
undefined reference to `_com_util::ConvertStringToBSTR(char const*)'
...

Looking into mingw files, the symbol is not there.
$ nm /usr/x86_64-w64-mingw32/sys-root/mingw/lib/lib*.a |
grep -i ConvertStringToBSTR

It's present in header file though:
/usr/x86_64-w64-mingw32/sys-root/mingw/include/comutil.h

Not sure if something is missing in mingw, or if it's missing an 
attribute to say it should be available at runtime only, but in all 
cases, a simple fix to the patch is:

diff --git a/meson.build b/meson.build
index ab19317f5af..113296544c4 100644
--- a/meson.build
+++ b/meson.build
@@ -3261,7 +3261,7 @@ host_long_bits = cc.sizeof('void *') * 8

  # Detect if ConvertStringToBSTR has been defined in _com_util namespace
  if host_os == 'windows'
-  has_convert_string_to_bstr = cxx.compiles('''
+  has_convert_string_to_bstr = cxx.links('''
      #include <comutil.h>
      int main() {
          BSTR b = _com_util::ConvertStringToBSTR("test");

I would recommend to use cxx.links instead of cxx.compiles for now.

Regards,
Pierrick

