Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAF606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EEhlfCq3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeJ-0006eG-7U; Fri, 23 Oct 2026 14:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeG-0006bA-UU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeF-0004Wx-38
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1210861f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778745; x=1793383545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yVu9I6W3MoTMy0FVHeff2dgAoJBTlIEzvYjHE1m6niY=;
 b=EEhlfCq3EPeE8jwyLhvzxJt+t0+1SAJU/fakvOMZPFDitKnldAt8zBVg49vm4XoRSk
 KCTlNWQ+6S6jrSVdFwYcjM72buSQl0Ajx6m1Q9qo0bA81L/RLXdfBQIyR7RukQN01Mjb
 45VRvrq/2JF81aKGXF3rW860XcvxM6pMHABPze9bnB22quVA3VpynDz9Snr4rLTSkeNn
 WIt9G//+sYdgm6BYmqKZUcGq3a8cETnfuc0XwQeQpDdIi3lNVyVbL67Ha+7QiIV9FDRm
 PLA/BCM9641vIAji8pT3jfSkFr9oDmsTbXQ69uT5FJ6tqjQUjGEVt1hQq+wHkf4F2iUB
 MQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778745; x=1793383545;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yVu9I6W3MoTMy0FVHeff2dgAoJBTlIEzvYjHE1m6niY=;
 b=AI97Gd1BnN0z/ewKk4I/60K3v+SGada5K+c6eWze8aG31/+Jf/T2hll/nNBuYMfoi+
 pR2p4Rid4XoNF0Fbz9aThxm8LYx7+a/NKHN60K7MFJxyB1aIOrKVWCSsXwzk/JIDA/Tp
 U4RhtbMcz++Je8kDI89I/EVxoyaTbqMwLLt4Mks+HBPFOX5YCQPVeqgQ69KnaQRO6qCW
 hGN1XY3hZ5x1iYc3hOzMNH3b07inutXHaNbpi99PhMiSJv0/S3czrGN6xmEorgboxqYM
 t/OCosuWIupTK2St48WN8OfvaXU/lfk5G4RZNoaQpWst74Ax8xE1lQ2PCi/G7UFCjctE
 DsfA==
X-Gm-Message-State: AFq9FYJo5Kc/iWynwByqaEs9PRnE7Fy1lwxU+p0LL1FdbZ8xzAwVYv8y
 O4YaoqgJ7SeK7D7FwRCFbpxHyccPWnLahfrcLeaTkzwJ+RM5t4oyK8KlHeFxBv54O8E=
X-Gm-Gg: AYBFou1/VrFObqIwbgkpqRCNmm1lfT2imFeGzteO1stIltse4z5rc3pXEo3z6WzXfk6
 nympXCvw83CFYdrZVm5Co34r2w0AcScHuMD710ozRmUvnvqn9OugQlQpd4GoOk3TPSV79AiZLtS
 v+j4+8IEoWWo/PqidKYIXnuGV+TiscRwbk4+fmEcoUBtZ9Kfso2RXGfqkdKlV/YL9iFZNc2oVtX
 qOSpKJeBqL/BCtreMekJ0VzP1FQoRyiB0WEdCM3e8Pg6QNZtjFhs9pfzm8dxsJI2o3YeYXE0Bkc
 GHoOQJsZJq2jxb767/PslGUQ89J9/ug37YB6C/kGCf3x+kEj09lPqmixEdtoCXq1aOB3kFj/hSP
 bLnUFWaZ2ReFmxVE5uLfjlNpwxuC0kZbYv/ZxnEKAZ1NKaw2abzumYU5aEOHg8VWjuatbYvpKHx
 uqf7P8dQN1DcTIffUmIy1pm7xJFZpEOqvk6GGyiZ9WLJgvF9TDhG7mcTpsb5N9j17U2avzVXnnt
 IfT++GlqzEG67p69cHiViIzqdIBFZJfMaaaLop9z/1ESerwfy1DvJc=
X-Received: by 2002:a05:6000:230a:b0:48d:dfff:fe6b with SMTP id
 ffacd0b85a97d-48e385be006mr4640639f8f.34.1792778745507; 
 Fri, 23 Oct 2026 11:05:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4040d3sm1186534f8f.27.2026.10.23.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 75FEE60FBB;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/19] tests/guest-debug: add --kargs option to run-test
Date: Fri, 23 Oct 2026 19:05:28 +0100
Message-ID: <20261023180539.1574134-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 5a8ec8a68b4..48f9512d21b 100755
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


