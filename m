Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4946BCA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSV-0005vV-4n; Mon, 12 Oct 2026 13:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRV-0005Fv-Kg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRN-00077b-P1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso14542135e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824635; x=1792429435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Y3ACsmZ3EhAUMAFT0gmky/QQHKNO1XjjQL0eM7lIcQ=;
 b=Ag1p8TBcEuvSOdqle670EQUHgpPbinQF+mv7eC0KfqmZ+wiBV6SCm5PG0Ke1Snl65Z
 +TSH/v2U9Y6jhYJ7HOo99cYv7jAiuLICzGPXEo26wZYzron0vFtfkGZkSX3MWATwhGjT
 07tKSO1ThNq+8LN3r8dgLA3S1Dh0/XQosJjRHhIvGwDeoAGdBPvuG7TFWgxGR0B4YrzM
 PuDyxfGriJbt+Y/8gUV1DbCh96aMVGWbhanhq0JeTfq8/svQcRxXiZQBZJG4gkpVUG7Y
 7M76A1LodcIPtGD/Frga/tDNbXNSiZKUDVJLRR3x95VsH+BjRgw4uZ3iUd0DvcKPiZJj
 REBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824635; x=1792429435;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Y3ACsmZ3EhAUMAFT0gmky/QQHKNO1XjjQL0eM7lIcQ=;
 b=MWQv6XBgMPjBWwaptsSrTrysGXUnH5OOL7XGsY+vNDXCAUYGG5aOjbiUIs/cY6Zr3q
 u3pKYb4aTDGM56ybM4SeryUX2G5bGWEu+gpXFjNO3HUCN09MCJzLKoLw5l0dkGBXVk2H
 KTFb9t4AJdxrpX5rZlCL2co+NCA0orria/TOSu1kKgbZX0Onme5HZGDJRj8x1nfMgUkH
 OAueak9my7sytlOmw7YLyTKYxCIiirQ3Ga1oqRQBZpxYUr/yUYV+wvuk4toiSNT0QCtx
 xIDzgC01XCwhX3C/qc4ZgoxCon9qyegbjU0PQI0LHR1Z0jCF+0P8enV1b4UQlfddaSvi
 kKKw==
X-Gm-Message-State: AFq9FYKjtTb5kIbGQZ0did+h+bBGbUVfi1H4WXp1fV1Pg6C6lipXoi2d
 k39WppjfwECS9DI0acn/IIVf251yvAVkEdTZi+EaJQ9h1gpLknVRqYS3XG0y6UBQJ2rlOuXg6PH
 tYPN+bj8=
X-Gm-Gg: AYBFou1DxdX6rvVrQipfrRD/dmIK9I3kgaEXAFwv9lWw/+5QBFizMpJSf3DgPTAd9qS
 DhmJT+LOo9UhyTuvKFljWwmHI75NqdS2Uviun+9nowW9RodlfTHw2TNd4yZFYQrvlSBsnutbWJG
 HjElKLfqzzSxGjbpPGOZ27W/5Kiq6k0ZVnx3tfWltNqRSdJEfy6Efu+6EkM1DwjuQOzA910xvX8
 91qgNj/pTszwQtORXDfex/2eReqPwzNRsgFQ6i+IyfaOEAqI33Az5Yo2MUiV8m+ZrEbeJslswmc
 hMjN2p3Zd8NmFzFPCss8ODj/paTxwO2Day80AvHES02L0889ZXyLjg39W1grQFEDjug62WlMyiF
 0LYACC7IWoTRIbr16+ioB3h80FjS8dkky1mzoxpWc954UxRJyfaDNLU+XnnWbqa+D9yx6zffBm2
 ea4eCT6Y4nPW9qhyKbvF8YemFj42ffwDp9jFl34uTPPBKzJsLyu5l0+hTOELGiQ7+Z8Dr3OA==
X-Received: by 2002:a05:600c:8206:b0:4a1:6811:8d with SMTP id
 5b1f17b1804b1-4a18e4a3b34mr196651375e9.11.1791824635007; 
 Mon, 12 Oct 2026 10:03:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm433669045e9.9.2026.10.12.10.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CDAF35FD12;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 08/16] tests/guest-debug: add --symbols option to run-test
Date: Mon, 12 Oct 2026 18:03:22 +0100
Message-ID: <20261012170330.1144446-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Sometimes the debug symbols are not in the kernel binary image but in
a separate elf blob. Provide --symbols to facilitate using them.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 4aa24939b7d..0c7cbd137ef 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -28,6 +28,7 @@ def get_args():
     parser.add_argument("--kargs", help="Kernel args to --append")
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
+    parser.add_argument("--symbols", help="Symbol file for binary to debug")
     parser.add_argument("--test", help="GDB test script")
     parser.add_argument('test_args', nargs='*',
                         help="Additional args for GDB test script. "
@@ -114,6 +115,10 @@ def log(output, msg):
     gdb_cmd += " -ex 'set confirm off'"
     # connect to remote
     gdb_cmd += " -ex 'target remote %s'" % (socket_name)
+
+    if args.symbols:
+        gdb_cmd += " -ex 'symbol-file %s'" % args.symbols
+
     # finally the test script itself
     if args.test:
         if args.test_args:
-- 
2.47.3


