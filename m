Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA1606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v6jGR0vX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt2A-0001Wj-7E; Mon, 19 Oct 2026 15:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt11-0000Tb-6i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt0x-00034p-LS
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso2032565f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438034; x=1793042834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z+hzAC5Hq510CpP4qtWjwafBYrnKIC1zr/PjN6LgqaI=;
 b=v6jGR0vXzb7sEpxG2RalkEL702LmmLpgUAWw8vukHBAjDkvFCNPUhO1vCdglrbiX0h
 5vUeXcw44rHWn3XvsrdhZDEDvLDjKO30XwCRXRc4sQLqgNFfdkyj1zxE2c9fVgUhgd+G
 f4rJSYKuyGFTJhRawwNf1rvXmXcqBUULtoXa48o+mO9Rm1Yc2dDUYdg7b+icwGDU5qwn
 9ZOSpBr1sJZKNDc4cfkBhhFZvnlTCqqHTOlrMwfSNQ+0BeqRywjnjTUWzQsRXR8RUyUN
 N+LmhuBLLkwilHAN0Tai8bLNyKcuXWl/NGkR/dWNjotDqUgCPoVguZ1ykHEJO6a1xzbm
 1Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438034; x=1793042834;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+hzAC5Hq510CpP4qtWjwafBYrnKIC1zr/PjN6LgqaI=;
 b=ArR9lvloMdjb1nCtNLm0d6QAEM+8TQlVKezRUq2wAfPO0EJ0nawSEgINNLDVOtyh4p
 APzpgxSG9QYWizd1j8O86PIkt1n7yGyXZCrpTedyhl7757AtIb4C7DdHrroLNLcf0+Tk
 Ti1CjjCH4fO96MzgpsCh+3CcS6RAOhQ9rcqI+sh5+lfv6D4hTjTzF9pMrwNsFhRDKbsH
 V/iaOrZCZjdLLzmefjSENzrm3te82mgIC1/kK3SHEk/sD+CaZL0xM54VkbAxqtSTBZTJ
 F9O/ttXv70tINR6yEAwn82WcmnoUZHQwyKuE6d3eyd3KWPmPE5WRPXZa0cgI1BU60IBv
 sf3A==
X-Gm-Message-State: AFq9FYJ9HDKAQeZy8IqcDF4XXsEZGcepRrH5+nZeLUpkBVbY3FAWTO3e
 y7M4Ine6ljpyuCzDUHavXiXgqMnHi4Nx6XgM5N3B7cdo3z+uYIANJ/Wn7brOim6PeWs=
X-Gm-Gg: AYBFou0xrk/x1jNmYRH9cHXUBaG1OdkPNRrbYGSZLDYGyQnibu0o5ThHnYpjejpKiZH
 a6itR0683Oz1lGlMTS4ykCOHCT8YxbBdU2CVI09J/cOd5/50rFVQhesiWqc+VtykSLwROo3cSns
 8eObEBQiNzNjUT3m7cAbAQFNwjL9GiOTfP7iUeEoexPJMOrFGHOwQ5Who/SsPY2UHAke6g1+KD6
 UEIO3dTaSCLj32q5hG9kXYEj6Fevk7Wo9KfVoZUgRg+HcW9IojECUB13o2XSo5PJma0acFISAAs
 SVsmeGSHbEpZms4c9Rk8jvANsL9QQelEgJ5oazlaC27M0HkQ+N72VQfE8sSdE1eum8SNPr0CJgE
 tEVk2k2SD8sQXl6GOsvPM6E/NzwsHTP8UBt/KoECUgzy8TFiWbbPw9dduWqPU/qpGuORTlXJvN2
 wKldKinEsqVarZa/FQOaG+k47ZkwSnqKMIELb83O0R9FMngW9h16mjRBnTG6lhx8bvu0u/P6A=
X-Received: by 2002:a05:6000:2484:b0:485:8cc8:1f5f with SMTP id
 ffacd0b85a97d-48e07fa892amr17250660f8f.42.1792438034445; 
 Mon, 19 Oct 2026 12:27:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm799256f8f.35.2026.10.19.12.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3FA95FB4A;
 Mon, 19 Oct 2026 20:27:05 +0100 (BST)
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
Subject: [PATCH v3 08/19] tests/guest-debug: convert gdb_cmd to an array
Date: Mon, 19 Oct 2026 20:26:53 +0100
Message-ID: <20261019192704.3220373-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 838c1c26971..e8b69f85cd1 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -51,6 +51,10 @@ def log(output, msg):
         print(msg)
 
 
+def format_cmd(cmd):
+    return " ".join(f'"{arg}"' if ' ' in arg else arg for arg in cmd)
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


