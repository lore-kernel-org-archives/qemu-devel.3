Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAD0E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKUc-0000OG-PQ; Thu, 19 Dec 2024 12:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKUb-0000Ns-Hr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:39:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKUZ-0001lS-RR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:39:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so833810f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734629958; x=1735234758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=87fce7ngh29CuTlsgk4GtPc7adzzXc0dzXeL/iHv3ww=;
 b=JxuUGWXIxKlSRd6uTfXb4IO7bNZheAD9NrMES1IYb5SbL0Cl/n9KESDAWUDP9/gl74
 eb4x++yFHXtqr3orafNd7xTGBGfNpaMsffEcSH/sAAWwlsMLH/LD++btDqWxPHWUhhK/
 Du9gBxo28fD0Td5iFEhGxlnBSc8Rrq76+XWzdA5RMH8b3x8OdCfsi/2gYAWHHuLTfiJz
 n+MeQOel/OBewFYm0K3NyEOd6WQK9LYyejD0soBcEd3agutlTqi4JRVVwXYLiSyuV2Jg
 sYwM7xZgsyK+LAdMe0rnyqQtcTQzv6me+dW6ocNJh1KV6axkeT9b/Zp74Bw5tMoLy1Sc
 bGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734629958; x=1735234758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=87fce7ngh29CuTlsgk4GtPc7adzzXc0dzXeL/iHv3ww=;
 b=sOvnAFN/5I1zUroYKifMVKcJyL32GF9pj2mrmhxeH4tI+IxyXFhYxgYsTuVAkSBmiy
 aNCrQ1wkYR6idxglrjhVKPxADR7YtgelXwxf90gfL16doq48m/4Ak7QxfCc/3iPqkHPp
 Sce+X5j0cIRZueNwBXdyqzxnO8TmoJtErJ+NXe4VWawC0cQYwieXYQKD62de4aQ6eAau
 5ophz+3Sb4YhmG8BKNyuQoGRCC17ACl53kRIT1fmgc7RpR3bpHCAx1O/2n9RHsR4HsZ2
 MKC+yJJwZJcYg5H8kaC4R3h8orVMgtiG75J4RldFuRObQvee9S62he6GyKdDjHS2FvII
 KrRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlEV81HzU/zSrBSPg5Fg1s+itJFzUWdSvIK/59+XpO7ffgSBF4bHaFPRdSp88UHvRi+F2Kk8FooWU+@nongnu.org
X-Gm-Message-State: AOJu0YxRQyMcO2flgg4Z58BAei56vFefYemKGSxpiB7TbA8+C01leXTj
 h3NEwOX4IWIpNREIdl5AhJmtsIICXuHt41mJRKJw1AMSk36+d3HMk1NmFFfQO/A=
X-Gm-Gg: ASbGnctEpy++dmd38UxxptIQVjvHvMqCPrTTQaz6AYSXkrv8uNqb9XbrmPyZ4zI1nLp
 +R1K3C0xL2BizLACN/gxV+vKNxep6mKUZwogek1xlUcNWRfKTKxVeS66087idaTmgIogdyLyrKq
 z7TakE1S2rqyjRCItTh/q45/1N+yNGdo7ZjkNln5wMJTFVZyed4SwvRzMs47sdGpnzTOwkwH+pX
 hkn2cv/6aYkFBWz1Lxb7o/+tWr57zkyiRQ8b6HWGD38L3oVjPwKhw3/tb9+e61x9ZFwDXc=
X-Google-Smtp-Source: AGHT+IEy0sF56Tv8VKItZs2y9d/E4Bl1dNkdFtlSvuRp8NU/arrMlj+444Bwcpum7SgXmxtFv/1Ziw==
X-Received: by 2002:a05:6000:1f89:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-388e4d311bcmr7850688f8f.8.1734629957942; 
 Thu, 19 Dec 2024 09:39:17 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d7esm2036627f8f.101.2024.12.19.09.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:39:17 -0800 (PST)
Message-ID: <f2cd3c5d-cacb-49f7-afec-1e48e5a9a92d@linaro.org>
Date: Thu, 19 Dec 2024 18:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] meson: Run some compiler checks using
 -Wno-unused-value
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-2-philmd@linaro.org>
 <D6F99DW9FQ1Y.268COFM41BN5X@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D6F99DW9FQ1Y.268COFM41BN5X@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 19/12/24 01:37, Nicholas Piggin wrote:
> On Thu Dec 19, 2024 at 4:21 AM AEST, Philippe Mathieu-Daudé wrote:
>> When running Clang static analyzer on macOS I'm getting:
>>
>>    include/qemu/osdep.h:634:8: error: redefinition of 'iovec'
>>      634 | struct iovec {
>>          |        ^
>>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_iovec_t.h:31:8: note: previous definition is here
>>       31 | struct iovec {
>>          |        ^
>>    1 error generated.
>>
>> Looking at meson-logs.txt, the analyzer enables -Wunused-value
>> making meson generated code to fail:
>>
>>      Code:
>>      #include <sys/uio.h>
>>              void bar(void) {
>>                  sizeof(struct iovec);
>>              }
>>      -----------
>>      stderr:
>>      meson-private/tmpe8_1b_00/testfile.c:3:13: error: expression result unused [-Werror,-Wunused-value]
>>          3 |             sizeof(struct iovec);
>>            |             ^~~~~~~~~~~~~~~~~~~~
>>      1 error generated.
>>      -----------
>>      Checking for type "struct iovec" : NO
>>
>>      Code:
>>      #include <utmpx.h>
>>              void bar(void) {
>>                  sizeof(struct utmpx);
>>              }
>>      -----------
>>      stderr:
>>      meson-private/tmp3n0u490p/testfile.c:3:13: error: expression result unused [-Werror,-Wunused-value]
>>          3 |             sizeof(struct utmpx);
>>            |             ^~~~~~~~~~~~~~~~~~~~
>>      1 error generated.
>>      -----------
>>      Checking for type "struct utmpx" : NO
>>
>>      Code:
>>
>>              #include <getopt.h>
>>              int main(void) {
>>                  /* If it's not defined as a macro, try to use as a symbol */
>>                  #ifndef optreset
>>                      optreset;
>>                  #endif
>>                  return 0;
>>              }
>>      -----------
>>      stderr:
>>      meson-private/tmp1rzob_os/testfile.c:6:17: error: expression result unused [-Werror,-Wunused-value]
>>          6 |                 optreset;
>>            |                 ^~~~~~~~
>>      1 error generated.
>>      -----------
>>      Header "getopt.h" has symbol "optreset" : NO
>>
>>      Code:
>>
>>              #include <vmnet/vmnet.h>
>>              int main(void) {
>>                  /* If it's not defined as a macro, try to use as a symbol */
>>                  #ifndef VMNET_BRIDGED_MODE
>>                      VMNET_BRIDGED_MODE;
>>                  #endif
>>                  return 0;
>>              }
>>      -----------
>>      stderr:
>>      meson-private/tmpl9jgsxpt/testfile.c:6:17: error: expression result unused [-Werror,-Wunused-value]
>>          6 |                 VMNET_BRIDGED_MODE;
>>            |                 ^~~~~~~~~~~~~~~~~~
>>      1 error generated.
>>      -----------
>>      Header "vmnet/vmnet.h" has symbol "VMNET_BRIDGED_MODE" with dependency appleframeworks: NO
>>      ../meson.build:1174: WARNING: vmnet.framework API is outdated, disabling
>>
>> Fix by explicitly disabling -Wunused-value from these meson checks.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: Probably meson should do that in has_header_symbol() / has_type()?
> 
> I don't know about the build system to answer this, but should we
> instead disable -Werror on these tests to be a bit more future-proof?
> Compilers often add new warnings or catch more cases of existing
> warnings.

Sorry, I didn't mean to include this patch in this series. I happen
to have my series on top of it and forgot to change the base commit.

> Alternative would be to keep -Werror but fail the build if a test
> throws a warning, but that seems like a lot more work for little
> benefit...

I'm trying to fix it on the meson side with this:

-- >8 --
diff --git a/mesonbuild/compilers/mixins/clike.py 
b/mesonbuild/compilers/mixins/clike.py
index d56547b47..9d6957973 100644
--- a/mesonbuild/compilers/mixins/clike.py
+++ b/mesonbuild/compilers/mixins/clike.py
@@ -360,7 +360,7 @@ class CLikeCompiler(Compiler):
          int main(void) {{
              /* If it's not defined as a macro, try to use as a symbol */
              #ifndef {symbol}
-                {symbol};
+            (void) {symbol};
              #endif
              return 0;
          }}'''
@@ -885,7 +885,8 @@ class CLikeCompiler(Compiler):
                   dependencies: T.Optional[T.List['Dependency']] = 
None) -> T.Tuple[bool, bool]:
          t = f'''{prefix}
          void bar(void) {{
-            (void) sizeof({typename});
+            size_t foo = sizeof({typename});
+            (void) foo;
          }}'''
          return self.compiles(t, env, extra_args=extra_args,
                               dependencies=dependencies)
---

