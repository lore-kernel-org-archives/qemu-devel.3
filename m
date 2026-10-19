Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE95606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BwcxBLV4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt2G-0001ik-DF; Mon, 19 Oct 2026 15:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt15-0000WE-E7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt13-00038L-Fl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1369602f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438044; x=1793042844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YV9eJVsxbqw8J76FHBdHJCWhMzBUl9uMTeF3jAHykKE=;
 b=BwcxBLV4skLmPJADV2wydBT+qq7cpSVVBeVvEbaQs36sp4pELVLkgULDawK7fJLuyP
 T3rFzXp4T2IZVvPqo+l7RH9BbXPye/ZIXNlDgp6hMwAiUwuFvi9xz7maDtaqfmAR9Fe2
 TIgj+0TZdS7YgyLLf5sDtN00ukE2nqH43xyiR9YJK2eGn9x5/cnFX6wsavNTKpBZIR/G
 gCM5ynBsX0S+44SX7w0mAw7gTteDd3saGfwY54/EwghB+a1AqG6Z43YL3rYtuiTSS6QT
 Hp5vXELcJQKcMRPp5+C27t4FkszEh0VtTqJJHnCuYx4RCDyUDze6K4orjEXm9q2mTlmg
 0dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438044; x=1793042844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YV9eJVsxbqw8J76FHBdHJCWhMzBUl9uMTeF3jAHykKE=;
 b=H2bBqha6gqRVmHOQw6c8PoeEu/DHFXYTwJt9ypdEgVnDm2QCQD0bLEBP22IMthWxJ1
 Ekg5Obw/Ap/GfJ82xWzF9/yadBq+T+k4c7/JqHEWPUy0q2PlGn/akpJOVxShR1JfRGDN
 EgtbW9FVmjXhhce+60VejhEg7wPQpTE9U0P8DYNiYJjJyXsX26uE1z9Yhw3ZRciUSwVp
 bhNnqKP1VnM9kaPKhIJ7k24On+aoLsKRK5WPq7cadZX478tRgzihocYRN1i+1QvIvl0E
 XnYVQ/Y9VbVLkl13Py1t7kmUr9aOMClCdyxdLq3kZXTwNY4l1dgSjNyctlBDGkNkIE+4
 XqVA==
X-Gm-Message-State: AFq9FYJ7jNk5BdOyJEGhWAzOMYxYIWMH1v5qucCOK+Y7gUSVNz9Ug+hf
 184WEr4ZIf3Bu8uP+MqXmIc8ANq6votxPG4EBUIvMcNDjOt0i9C5yx3cRra02aF4YvE=
X-Gm-Gg: AYBFou01V4kXNTvRYcxaGPXcM+/7FxJuEDPyLNnprw1Ba5XO1qtemh793GBruSpkEgG
 5vOU9LNz4L89y++KOW8oW76U83MnrTax7kinggY3bjduc1W8DSvcYLOXqD+c0xjXr3T5EAn3+8c
 9RS1T33lqZOYm61LAgo4HCt8Yx0HvBE4L4kMc7hL06SlRMODnUlQYj0GxgWPgTPeAvoNFF+ToMB
 Y8PzXPJy+uoVu6OYhTiWm5CnkQwMm4H5Qav9ScBEP9WXmJX5FBkyAcLmTpCJDN8LydPezf1fXCo
 XBT9BVhvvuMX9IWjX6BrMA5nBV7K516QsNgf6USoQXoIOGIfuGxSSmqQCxtZM0D8ziKJoVLzSZD
 ea8YC4B/QtoPPwmR1UOoiSnOgUlDA58jQ7uwFDWSR9D/GQS6A9c7U5kfTPW3KSKZFkLL8NndRbu
 p3+T/CqTWf/TtpHlwItuYvMOghnb36dTXP/L7SNf//PGCFrKMPQdTr32Nsjx34Xgjx0bkbfQ==
X-Received: by 2002:a05:6000:2990:10b0:486:f4ae:72a2 with SMTP id
 ffacd0b85a97d-48e07b9201emr13278166f8f.1.1792438044019; 
 Mon, 19 Oct 2026 12:27:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d83a099sm701373f8f.57.2026.10.19.12.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 121BE5FC8D;
 Mon, 19 Oct 2026 20:27:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 10/19] tests/guest-debug: add --kargs option to run-test
Date: Mon, 19 Oct 2026 20:26:55 +0100
Message-ID: <20261019192704.3220373-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When passing kernel arguments to QEMU with --append we need to take
care that things are properly escaped. It's easier if we get the run
script to do it for us that constructed the nested escaped --qargs.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fix merge with array
---
 tests/guest-debug/run-test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index d5ffaaa9ffc..782c0c5da19 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -25,6 +25,7 @@ def get_args():
                         required=True)
     parser.add_argument("--qargs", help="Qemu arguments for test")
     parser.add_argument("--pargs", help="Program arguments for test")
+    parser.add_argument("--kargs", help="Kernel args to --append")
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
     parser.add_argument("--test", help="GDB test script")
@@ -89,6 +90,10 @@ def format_cmd(cmd):
         if not args.no_suspend:
             qemu_cmd.append("-S")
         qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])
+
+        if args.kargs:
+            qemu_cmd.extend(["--append", args.kargs])
+
         # There is no guest program command-line in system mode.
         assert not args.pargs
     else:
@@ -98,6 +103,9 @@ def format_cmd(cmd):
         else:
             qemu_cmd.append(f"{socket_name}")
 
+        # There are no appended args in user-mode
+        assert not args.kargs
+
         # for user mode binary and args always go at the end
         qemu_cmd.append(args.binary)
         if args.pargs:
-- 
2.47.3


