Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F5606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jIrNkMIo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeP-0006io-N8; Fri, 23 Oct 2026 14:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeK-0006em-2S
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeI-0004Y7-Ce
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so12148925e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778749; x=1793383549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2OFNDK3sHQNUOrvoDfW941hOMl4ETnVX010CkjxNAOk=;
 b=jIrNkMIouTmlW6iQWvNq7c5YvnZbtNR4VTTmpDaYE6lkKjTVche5TtlXq6ECu8UKPj
 0x2fc7vlbL5OggiPWHPITN8/qhTViXmDpQU/TPvo+l94fjYNUI1iuWf3l8u5NoX4NDgh
 YPf/LhZCq3qY805F3I8Tw3EYEGqePwyJaoEmvl4rLT8v6HMnsNnPCOA3js1cg1nAjfLn
 6lrwXitfBG2+vROuIC1ZxT2+/SDcEq3y2yj2C0M81rKeaylCkM+uPiv93A4fD0l8Fwi9
 vo3cG0vBvYHYEmnnNgWVA4CfPNK/GEmM9kH/X9N0fKxUGR0qHeS1Hztnwpo3lWOYJPqN
 EKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778749; x=1793383549;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2OFNDK3sHQNUOrvoDfW941hOMl4ETnVX010CkjxNAOk=;
 b=DG4EICHfH5gPUzgeidbRno7cYVrpXzTOOm0w9L+JxglGmcJwb5rp+554pMZTeZop0m
 2a1QLt+N4dQkVnVCTDF2tvuCe3dEQ1p1A9s96hpvjLxxjQpMIEPMXHpCvFBROi/Jtju5
 v2bDXSDJZSMbA/iJbamw2NZKCXeZtJoctpvna0q2SqJGVhY+Nd+apCkgWvBp+H01JcP0
 U+BDvKsamKFAcNrXXVaWpp5Njc9EPJm855weGrcTlw8c6t7MqOE4Jgznr5oZWpZ5i2k9
 HcU9mugch+xbN0ymKzYQTVm22U8OG9U5FDqY5hgNd2Heu8egqAHZaabXwKRb/c5fBnKL
 odGA==
X-Gm-Message-State: AFq9FYKdcozkS2lyScmyKixtpTMEnptVaQjPYBFSzZUdYCrw6ow75HFh
 GFepWGR9IVka/bjIcV0CLqWxi6Q+pkJys32gD+m9BHSJYDZvekiVUqCSrS+KyEhni0Y=
X-Gm-Gg: AYBFou2ZHc9ztAbzFs98iYSozNjCNqO4rM9u+ntRrOGQdg3HtMj4K/dCEVnPD6HabuR
 h38wWA5Kgy6PXY1gsfD54UiN1FdrIyixogy+/siwXsXlfEvgRwKXbVZZJRw9PKg2beMNxqMZce3
 G/5ATFJyTqZiYzVNBocXLf40drT6Xu9dH4R1FiUZi5C6uXw9FrdZ15KSL3kg+bxbSiCTNu+VSoH
 VOuSGuzD37v1uHAZE+dcN/ngb2+Gb5KYLTkoW1avM1n7GFwGn6zQXOwIcEaA97CUkcpd5FCmvqy
 asX+vsXLxi6UZmZjdPbByOsdqwKuF7trujAjWuj9tbAT8y4DS60t181KVkzgwbfryJj2sGGmfNa
 FYRVzKRWKHrTy3eNz3Aw8T/SL7nNINutf68dY3wRRIrmxj25rbnV6W+lgPS4Ls2SKbMr5cci+eF
 ZRWiETxls1ZybJu0YKb00g5gqMmkrDDqmaJazsMEmT+zFNVhWUKJFFlfvlp44RhM1r8fZyPsd0y
 wxutP2Jesiz35hMecGpSI++5Lh6kjzsnEGNOVvkir487wzTGW9GIds=
X-Received: by 2002:a05:600c:590f:b0:4a1:e3b5:f2be with SMTP id
 5b1f17b1804b1-4a204be59eamr99163265e9.9.1792778748925; 
 Fri, 23 Oct 2026 11:05:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d427727sm913390f8f.51.2026.10.23.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BAE360FB6;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 09/19] tests/guest-debug: convert cmd to an qemu_cmd array
Date: Fri, 23 Oct 2026 19:05:27 +0100
Message-ID: <20261023180539.1574134-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

As with gdb_cmd passing a plain string to a subprocess involves making
sure the escaping is correct so the underlying shell doesn't get
confused. Do the same as gdb_cmd and make the whole thing an array.

There are a few minor wrinkles with when args.binary is expected so
add some comments for that.

Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index ab3e3dc9ed5..5a8ec8a68b4 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -79,27 +79,32 @@ def format_cmd(cmd):
     socket_name = os.path.join(socket_dir.name, "gdbstub.socket")
 
     # Launch QEMU with binary
+    qemu_cmd = [args.qemu]
+    if args.qargs:
+        qemu_cmd.extend(shlex.split(args.qargs))
+
     if "system" in args.qemu:
-        if args.no_suspend:
-            suspend = ''
-        else:
-            suspend = ' -S'
-        cmd = f'{args.qemu} {args.qargs} {args.binary}' \
-            f'{suspend} -gdb unix:path={socket_name},server=on'
+        # for system mode we assume qargs has set-up for binary
+        qemu_cmd.append(args.binary)
+        if not args.no_suspend:
+            qemu_cmd.append("-S")
+        qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])
         # There is no guest program command-line in system mode.
         assert not args.pargs
     else:
+        qemu_cmd.append("-g")
         if args.no_suspend:
-            suspend = ',suspend=n'
+            qemu_cmd.append(f"{socket_name},suspend=n")
         else:
-            suspend = ''
-        cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
-            f' {args.binary}'
+            qemu_cmd.append(f"{socket_name}")
+
+        # for user mode binary and args always go at the end
+        qemu_cmd.append(args.binary)
         if args.pargs:
-            cmd += f' {args.pargs}'
+            qemu_cmd.extend(shlex.split(args.pargs))
 
-    log(output, "QEMU CMD: %s" % (cmd))
-    inferior = subprocess.Popen(shlex.split(cmd))
+    log(output, "QEMU CMD: %s" % (format_cmd(qemu_cmd)))
+    inferior = subprocess.Popen(qemu_cmd)
 
     # Now launch gdb with our test and collect the result
     gdb_cmd = [args.gdb, args.binary]
-- 
2.47.3


