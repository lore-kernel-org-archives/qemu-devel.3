Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EF606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WCdw4MtV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeN-0006h2-U9; Fri, 23 Oct 2026 14:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeI-0006c8-Au
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeG-0004XY-NT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a218ffa23dso4215785e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778747; x=1793383547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5mqyaB2e54Dp88sZKUYT29UJuJv0Cg1+maROpCqpvd0=;
 b=WCdw4MtVsczbLaLCg1B+zqdytiCo+kcvbj/BX1lx4zbAxFN9/pcWph4a/zFVz4KOCr
 BG4AD+t+n0loVcu03AzV4ivd4agA9kCdGfoY+EvyR9OUlWW8lxL9WJ8mrzlSmiu7R485
 gWeEbVXS9eTo2jixQS30ZGq/0ZXugJ6RCFLleqY1QFx6k7v9dJqigsDuaxyT7CXQgddW
 vueiVnMdTk5N96+ltldl+e1nI8mi6UPIzd6hfb0qgnLFiXKFpV2cSYP32V3jqvfz/tt+
 qE0Vg+aOHT/kzY/knVZyKloRjU55nkXK6Gu84JnklEZrbYumlhpYdHkFJr1JEDM1pcV+
 9E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778747; x=1793383547;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5mqyaB2e54Dp88sZKUYT29UJuJv0Cg1+maROpCqpvd0=;
 b=aoYEIP5rupgHlnszJUE/GLUTB5ORjpyvQwgy0XL77zfvHDQne5mgNrjrHXn/AjIVV+
 Npq4X38qhPZEk9Bf5kg6ZcoV0buYBdDKK8HBtuVTp9kuOzfbo8fEO/6I9FhxAvk6KYuh
 N/cTetWachh4q5YP4ThROaaYU0q6naYCXjamXpkBlzDWaS3jfRg5Tb2eVpEaB6MVbeNl
 7710eik78Q8VOGHesDng/M3DxhpJ+dRrBqmhAWkcCqTTeerlDFJrKsfMjBUJdhvERnJ4
 bYTWVdyliiAwK4nPzPNPZo/sn94v8WUpK5SRt4TWy09/dsbv6Ae66VtZU2Ohp+VVki37
 RcaQ==
X-Gm-Message-State: AFq9FYKDA9yu7BAv8ItWtGh7FBKzBw9V92THCE0+t0gCGz46gOSfdn2N
 QsmX28I9m7A/aHiAS9TwiQmNItbFcQTKYQTPEzWUHc/Ju3qDFpSupilS4ImkIDoe7Bw=
X-Gm-Gg: AYBFou2PcEcIwDhxRJ7F346ToFL8pW/iAdUL0b9Gw/2tVphJHvnapKTYqhWSAFmcjl4
 cAIFHgIe5Da7d43Yke4yoPj79q+21EeEx7+ceVQC7LriiD7AdUS5MBz8seCruRKpIRJ9YaTifpp
 ITkBtxf1nF56OtEb5BadLjd8HbFAhp/EIDwcsUuN/4l6zH4LdjMxAMbc0i9wYXaKh+LGEMXKVKk
 8brW499HP5CzfE6oNZgju1ez+wyFrTnUjvqg/NwJ4J/kMpINTeR8JXtwwqLxk6cKNjl4+qpV7Ms
 Be+8YuK0LU7sDeGe6SG0GdJ+chL9YZHGJqObeG2kSw22WycLLojGLnmZGbZP8OUu8zC1BA2douL
 aoVQkBngB0xGXe8wvHWMmsFIjEhrl9j7j7sGw6WeTmZKE28eLY8BsxJCgfMOyjucWutimT9R7LB
 aihoEEwjH2hcVCJryDk423ZrEaipR0EOf/GbRxtPecO65trAVwH0UQR98rgilvjmjbJgNw9s3TG
 KZkBBbPn+Lbj4cF8mO7kgB3mQwu2ojvPP7Wit/V28ZhxkZW65MzNWU=
X-Received: by 2002:a05:600c:138e:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a211eff350mr54266395e9.35.1792778747104; 
 Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d41e0fesm1140919f8f.46.2026.10.23.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F8FB60FCD;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 11/19] tests/guest-debug: add --symbols option to run-test
Date: Fri, 23 Oct 2026 19:05:29 +0100
Message-ID: <20261023180539.1574134-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Sometimes the debug symbols are not in the kernel binary image but in
a separate elf blob. Provide --symbols to facilitate using them.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 48f9512d21b..afde0e2c008 100755
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
@@ -127,6 +128,10 @@ def format_cmd(cmd):
     gdb_cmd.extend(["-ex", "set confirm off"])
     # connect to remote
     gdb_cmd.extend(["-ex", f"target remote {socket_name}"])
+
+    if args.symbols:
+        gdb_cmd.extend(["-ex", f"symbol-file {args.symbols}"])
+
     # finally the test script itself
     if args.test:
         if args.test_args:
-- 
2.47.3


