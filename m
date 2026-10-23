Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZcAjF8Ks
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeL-0006fB-PE; Fri, 23 Oct 2026 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeH-0006bl-SB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeG-0004XP-1A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso821215f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778746; x=1793383546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dDBE42hvIIwsppuMCaf4q+QPN7mc7NNkXRYhnpn7ico=;
 b=ZcAjF8KsqPZJ/eYHrIEp/GR2jZqunCCoHVSITkv0YuiP9/Hl8U4hyd7olJW3nW2wDL
 ZRGhFoVFf597HugurHQxX+yMeA/Qq8mUUgVHzqVQmjQSu7495T+6aOGE4qlCIXrLVEoS
 b64LpOHxmSrAsRTurku4AaMReYwQUARezx6dSct7seDVhpJiorYIS7Qj0j1qMuFUVTjo
 Hd47Oh7+DvlfoCQH1LSvJUSFzDKjNQOEMRHf6iDRJmYVIFYDBlgKO1IezaiXwgO/wArr
 A1RmcdLBNFy+3FmbNFyzHhDNaGx2YRsvnX4UfToUvJ1pgdN9fL9Z/PAcdkeFVLYUOh5I
 pJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778746; x=1793383546;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dDBE42hvIIwsppuMCaf4q+QPN7mc7NNkXRYhnpn7ico=;
 b=T07wHERuwlanIybw3h54ae1d+k23sKfNPb3Bij6m7Bm0qPhGjVOFW/FZ944qdNyRcU
 dwIdXs3h5ETmRUNXAPDuJKSDrnUXxAdsTgU4mUMLUMIyBcUsA+HJbJn65aDkCcFTcJtr
 dcSOY2PdBTWzBCds9b6LFQ5wKmO1Q92rNr0Xt6jOc/9+zoIDj2XOYhR+E8nJucS/MT4Z
 EH6ZDiy/GqE/B9a/b+SjWVxP7vURHAv8PqV4GkAk7Q38lKG5rYt+d7BDZ78bE2HmLWmi
 +/MfP8De4W2Dk3FL79xHaxU/oQQ+5PN95kakpYpQvdQNjlhouu4UUWjTvfkf0TwvVP6N
 3sgA==
X-Gm-Message-State: AFq9FYK/FN8EFNA8Byw1maxnyL3MsrpdF2cXJVk15dHbU3lWdFGlK5AB
 AD3mJlC0JQfgfZlu+Baa2coSR4qtnnEsPHtk8T9IbnbBnVxY1fOZMTekfxc0HZdFyas=
X-Gm-Gg: AYBFou1+/EfEUsHBdc0MhL5ioY56GC4qV7U2uJ3CYbSwcORs8Rz3re8uzqfqt1isGb0
 TYC/ItKJKjxjeJtEnENbuayHuBVaqGRUs36Rfez5Vvbx6jMLBXBWPL9vsarCVhHEyvEB/rrbbVx
 zUWdikU98ZfY1WKllSECbn1AyGyPv9+kfVM0757WEU2oUwREmxaHdIOsi7VLI4/9XDxacOrf4Zx
 XzSjXap7je/sHnXNaStFkG/3SOKRHa5BQ/vWUO42OLwVUH9M1yatquUU8xH7i1C26MPww8mSC2R
 g3gbiJ7eFCxOq2fas4aA7b4tesaHmCahxRyfSpU3R9zTqXYGpHxfQczKhA+pxZJTwbyIvEI/opH
 GhVTUPAKCh4PYTpFMX5pBJ9V6W+MCDENQaZnFMzRRxjuGWvSNvKzE6w6UtqPG6U50FPwbgecNEs
 ASYQxG3XVdAzpYWGqZF0AC4rweVpYfYTa6072BpS/3gcaFuBwYsHonKnBTNPHTHaG3n93IuQURR
 KqYPzvl1KAH8V04aru5uBLIKAOAjAlPpjwPnfNMGUuYdC53xvg1F98bYWcDMXQ9/MJaSX3FIIts
X-Received: by 2002:a05:6000:ac7:b0:48e:37e:470f with SMTP id
 ffacd0b85a97d-48e385ab6b7mr4002557f8f.51.1792778746461; 
 Fri, 23 Oct 2026 11:05:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d400365sm1298229f8f.25.2026.10.23.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 420D360FA6;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 08/19] tests/guest-debug: convert gdb_cmd to an array
Date: Fri, 23 Oct 2026 19:05:26 +0100
Message-ID: <20261023180539.1574134-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Passing a plain string to subprocess involves making sure the escaping
is correct so the underlying shell doesn't get confused. This can be
tricky to track across multiple  processes. To simplify this build the
command as an array and execute gdb directly without involving the
shell.

We add a mini-helper to make the log output a bit more copy and paste
friendly.

Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 838c1c26971..ab3e3dc9ed5 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -51,6 +51,10 @@ def log(output, msg):
         print(msg)
 
 
+def format_cmd(cmd):
+    return " ".join(shlex.quote(arg) for arg in cmd)
+
+
 if __name__ == '__main__':
     args = get_args()
 
@@ -98,32 +102,32 @@ def log(output, msg):
     inferior = subprocess.Popen(shlex.split(cmd))
 
     # Now launch gdb with our test and collect the result
-    gdb_cmd = "%s %s" % (args.gdb, args.binary)
+    gdb_cmd = [args.gdb, args.binary]
     if args.gdb_args:
-        gdb_cmd += " %s" % (args.gdb_args)
+        gdb_cmd.extend(shlex.split(args.gdb_args))
+
     # run quietly and ignore .gdbinit
-    gdb_cmd += " -q -n -batch"
+    gdb_cmd.extend(["-q", "-n", "-batch"])
     # disable pagination
-    gdb_cmd += " -ex 'set pagination off'"
+    gdb_cmd.extend(["-ex", "set pagination off"])
     # disable prompts in case of crash
-    gdb_cmd += " -ex 'set confirm off'"
+    gdb_cmd.extend(["-ex", "set confirm off"])
     # connect to remote
-    gdb_cmd += " -ex 'target remote %s'" % (socket_name)
+    gdb_cmd.extend(["-ex", f"target remote {socket_name}"])
     # finally the test script itself
     if args.test:
         if args.test_args:
-            gdb_cmd += f" -ex \"py sys.argv={args.test_args}\""
-        gdb_cmd += " -x %s" % (args.test)
-
+            gdb_cmd.extend(["-ex", f"py sys.argv={args.test_args}"])
+        gdb_cmd.extend(["-x", args.test])
 
     sleep(1)
-    log(output, "GDB CMD: %s" % (gdb_cmd))
+    log(output, "GDB CMD: %s" % (format_cmd(gdb_cmd)))
 
     gdb_env = dict(os.environ)
     gdb_pythonpath = gdb_env.get("PYTHONPATH", "").split(os.pathsep)
     gdb_pythonpath.append(os.path.dirname(os.path.realpath(__file__)))
     gdb_env["PYTHONPATH"] = os.pathsep.join(gdb_pythonpath)
-    result = subprocess.call(gdb_cmd, shell=True, stdout=output, stderr=stderr,
+    result = subprocess.call(gdb_cmd, stdout=output, stderr=stderr,
                              env=gdb_env)
 
     # A result of greater than 128 indicates a fatal signal (likely a
-- 
2.47.3


