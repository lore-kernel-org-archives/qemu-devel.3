Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F71E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyfe-00009f-PY; Wed, 18 Dec 2024 13:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfd-00008Z-I1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:17 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfb-0001kz-Ua
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:17 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863703258fso719349f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546074; x=1735150874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exZ5QnwADXlGe9wvGwI3Js3yOyhSQnQyZpyAMP6GlqA=;
 b=od5Fl3mWnYbf/F/CfuE7Lg9LGoJq3yZQk2kQKLI2UTWJg/MoP7a6vqo/DKYwBPummN
 AExXNP02oci6M1KAgnOr5SLEkbiaCppiuSOd+lQNb9O3xxYcdARTVdnQrEUlGwWQQdCz
 wdRmkFVC3FmoHo+i+JqqU/PnHhMbyK9RvMXfFhfxEW1irELikxmnKAwi6vxnAi+Uuq80
 YOuzWSDkMAmoMCV9DbRLvrSAKh+whux0EQobbntNmk0UTYvEBVro/Rpnx7EeChZRqh01
 2W7Y5mSLlk46XpPQgjLkHtnaiZhp4gXazYyEXl8q+TQiwGO0GHFv0uWjg9IWOPTJAqJ1
 9nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546074; x=1735150874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exZ5QnwADXlGe9wvGwI3Js3yOyhSQnQyZpyAMP6GlqA=;
 b=jxCRCosTT05r7hMR7AAxuAKMNKectXWUy56bpxpy6PBB1ESRwshqHWfeYfS1DDxkmB
 9PQ80tmIxFyzCEu3CnQEOZrlp+5puk0SlNkz+sUk47Wa1q1JSWs18fOhn5UCIlbXcHrg
 M9kxZCo2E5U4zfbiEeQSlSnCfeKggalXUjh0JEQaUelDbzCmRtMZEuMjMNjg66/fNTZM
 724Ythweu7kZNIDGNtQ0QF5JjyMjlWgrVo4xctg0U7TvNkzaEMEBq6l2jMgwc/bNCtCh
 kox7uQv/Ce5xUJFVaZZBlg6v50ebUkObRn4r5vjoVNQelI5jXfT47eIm1/+zZzj0lYUK
 nflA==
X-Gm-Message-State: AOJu0YwrQ6LG5EZ6m//DZLXUUeIml/qDjyxJEf4yswRo8t+ijqbUhATB
 Dg8gKQGV6SowBpFxzVCIgOQdMtcnAiVlVyhH245reOe11ymzYOrVttlLRL1mpgycm7496b+AdHd
 /
X-Gm-Gg: ASbGncsneFs/acua35eOJjmo6l2hv6q0CajdfO8pxWSfJCfEs629cPA3kDngOlMztmA
 QrhnnEH2O7ejex3X6CgtzFyN4rpIa+/pKijMhmeNK5ozLeuF8Os2ONX73gnRDa1Zd4WcW5iXwId
 Dcd4Du/8hoUZBaSNRHKDLjT4X/PTm9Yuo1cd+mgUh40fl2x6sAJ3fM64LTGOLOVU7r0R5CQ6S0V
 /5Z9aY0EIZr5OvNw5u+TFd+dC1hEmVURzrtLOXxAqBpGp/F+Lmm21oUWqSkNhYxrynFyh2r7eAl
 GUtD
X-Google-Smtp-Source: AGHT+IHEdm+bDsnTz5HW7BI+jRIW1PJWkJJnAaW7u/k5SsOMXVQj63h/0YyYZb4XCxJNT6yo1moD9g==
X-Received: by 2002:a5d:64c4:0:b0:386:321e:f124 with SMTP id
 ffacd0b85a97d-38a1a20e85bmr286357f8f.13.1734546073746; 
 Wed, 18 Dec 2024 10:21:13 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a379d69sm54592225e9.0.2024.12.18.10.21.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 1/7] meson: Run some compiler checks using -Wno-unused-value
Date: Wed, 18 Dec 2024 19:21:00 +0100
Message-ID: <20241218182106.78800-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218182106.78800-1-philmd@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When running Clang static analyzer on macOS I'm getting:

  include/qemu/osdep.h:634:8: error: redefinition of 'iovec'
    634 | struct iovec {
        |        ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_iovec_t.h:31:8: note: previous definition is here
     31 | struct iovec {
        |        ^
  1 error generated.

Looking at meson-logs.txt, the analyzer enables -Wunused-value
making meson generated code to fail:

    Code:
    #include <sys/uio.h>
            void bar(void) {
                sizeof(struct iovec);
            }
    -----------
    stderr:
    meson-private/tmpe8_1b_00/testfile.c:3:13: error: expression result unused [-Werror,-Wunused-value]
        3 |             sizeof(struct iovec);
          |             ^~~~~~~~~~~~~~~~~~~~
    1 error generated.
    -----------
    Checking for type "struct iovec" : NO

    Code:
    #include <utmpx.h>
            void bar(void) {
                sizeof(struct utmpx);
            }
    -----------
    stderr:
    meson-private/tmp3n0u490p/testfile.c:3:13: error: expression result unused [-Werror,-Wunused-value]
        3 |             sizeof(struct utmpx);
          |             ^~~~~~~~~~~~~~~~~~~~
    1 error generated.
    -----------
    Checking for type "struct utmpx" : NO

    Code:

            #include <getopt.h>
            int main(void) {
                /* If it's not defined as a macro, try to use as a symbol */
                #ifndef optreset
                    optreset;
                #endif
                return 0;
            }
    -----------
    stderr:
    meson-private/tmp1rzob_os/testfile.c:6:17: error: expression result unused [-Werror,-Wunused-value]
        6 |                 optreset;
          |                 ^~~~~~~~
    1 error generated.
    -----------
    Header "getopt.h" has symbol "optreset" : NO

    Code:

            #include <vmnet/vmnet.h>
            int main(void) {
                /* If it's not defined as a macro, try to use as a symbol */
                #ifndef VMNET_BRIDGED_MODE
                    VMNET_BRIDGED_MODE;
                #endif
                return 0;
            }
    -----------
    stderr:
    meson-private/tmpl9jgsxpt/testfile.c:6:17: error: expression result unused [-Werror,-Wunused-value]
        6 |                 VMNET_BRIDGED_MODE;
          |                 ^~~~~~~~~~~~~~~~~~
    1 error generated.
    -----------
    Header "vmnet/vmnet.h" has symbol "VMNET_BRIDGED_MODE" with dependency appleframeworks: NO
    ../meson.build:1174: WARNING: vmnet.framework API is outdated, disabling

Fix by explicitly disabling -Wunused-value from these meson checks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Probably meson should do that in has_header_symbol() / has_type()?
---
 meson.build | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 85f74854735..9d93dcd95d7 100644
--- a/meson.build
+++ b/meson.build
@@ -1189,7 +1189,8 @@ cocoa = dependency('appleframeworks',
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
 if vmnet.found() and not cc.has_header_symbol('vmnet/vmnet.h',
                                               'VMNET_BRIDGED_MODE',
-                                              dependencies: vmnet)
+                                              dependencies: vmnet,
+                                              args: '-Wno-unused-value')
   vmnet = not_found
   if get_option('vmnet').enabled()
     error('vmnet.framework API is outdated')
@@ -2713,7 +2714,7 @@ config_host_data.set('CONFIG_RTNETLINK',
 config_host_data.set('CONFIG_SYSMACROS',
                      cc.has_header_symbol('sys/sysmacros.h', 'makedev'))
 config_host_data.set('HAVE_OPTRESET',
-                     cc.has_header_symbol('getopt.h', 'optreset'))
+                     cc.has_header_symbol('getopt.h', 'optreset', args: '-Wno-unused-value'))
 config_host_data.set('HAVE_IPPROTO_MPTCP',
                      cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
 
@@ -2731,10 +2732,12 @@ config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
 # has_type
 config_host_data.set('CONFIG_IOVEC',
                      cc.has_type('struct iovec',
-                                 prefix: '#include <sys/uio.h>'))
+                                 prefix: '#include <sys/uio.h>',
+                                 args: '-Wno-unused-value'))
 config_host_data.set('HAVE_UTMPX',
                      cc.has_type('struct utmpx',
-                                 prefix: '#include <utmpx.h>'))
+                                 prefix: '#include <utmpx.h>',
+                                 args: '-Wno-unused-value'))
 
 config_host_data.set('CONFIG_EVENTFD', cc.links('''
   #include <sys/eventfd.h>
-- 
2.45.2


