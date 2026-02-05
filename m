Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB1ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VA-0006Z7-KR; Thu, 05 Feb 2026 14:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V8-0006YI-Si
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:54 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V7-00032r-C4
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:54 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so911985f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321531; x=1770926331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCYp6e1o8/fOhB4Yb7faE7VFCfaYZvUcACOBcpqqyGA=;
 b=VS3Gvh9ELpLrVeJbVZoHxSIAgx5G9Z6DhvEVqd2YREFM+RHkEU/bpxV3Mhz3WLDRn9
 eGbm1/sRpWTrbmOLOrAt/4p7SgqhjibyLn1eP4kyQK1G1C44tzrtTlkd/I2ArErYcxU5
 4+diH9/+vxYk0onxg+W7wlPbDtoA7rMBwHzjT18QLq4ujYdz4RCkyEoqUv4iE24H+eAl
 pgrBi1Ash7SuEPzOSnSW0yHcwK0kE5SgdIsFWoZG9sMv9/WKs2vAA18LLmC5+qvlZzBz
 tNGxIq89bWOSHL4hENeXOgNcse12L787qPMAxoxfegBaF2qq6jajjoL689rQKqzHyQzL
 sggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321531; x=1770926331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vCYp6e1o8/fOhB4Yb7faE7VFCfaYZvUcACOBcpqqyGA=;
 b=o8qcVn9KfUzCTNB/qzMj7M5LDZkj6JTZa9bqmjdYqXoxDlG0oixlrlxajWNIOE5os7
 6qurdTOGPEZxLJvfU53Pn8Ifg4VRwwMdJJCLNQzIuIoN55TBn+zSsl89L1W/enPbWamt
 ekttmVSwNRpBbO3KPiNfwvkK/9X1lnTy4p6apc4b+zPsyV7UQitaEtEU7S2+u93MTem2
 2SsvO3xXmpM6J9+HkSEOascxdYc2vbnxmiPGmgeivlYcsZraTVQlp3ePvkQS4ELTs1bi
 VeQ8Px/5OLe8w2jFO7jrIcjqi5moSFqd6FTV+Q279Pmo+RvRZMGWPgEQEQ5e1wdXKET9
 sSVA==
X-Gm-Message-State: AOJu0Yw6EYfIy60a/4t3iGGHjGWUAainijLbjWnbIPNtJH7pPHHhJ6L6
 zFTNa5rRNyDj/vOTe+TIz39khynS6FZ20Ry5X3f24vZikzeS2X1P5pt1YFMUv48yLEg=
X-Gm-Gg: AZuq6aLmyvB8jQWaIZCOQ7Ttxs1FnqZ1vc8snucI1+NJ7J8gBXLDViR2vfJrbnY2DuU
 twELkqKjQH07Zf3MujAN0QBMeC42gfFCCtXE6DR3NCC/AsiN+jtdqxn0e2AgzOPGaUbYAu6H+bY
 ixiNeqlWn4eNRo/kA7epJQ+71G5YpAWHGRfs4we38luSmTXJahsRzokPQPvdM5UfhMSnIaLtF4z
 KGBPo7nd0uCVCBCpAdpH6G+24icrmvqwPbGlYp11jEELDk6It7hncnTzYwgtduS3qgVI8swB1U8
 JIFevsEy8j4GU+dale2RQSI39i/Vaa/dHpUXWVo/FRySlqX1AwY7Gpapsgz4XUOt/83F6KCp2Ws
 lsu5V+NtH0H6NAKmFDxMkkwqgZamxuqAj8Y8gCz8GyZly3ETKhlTRbOCbgGz3WA5kxBWv5itgVD
 X0CixS3GCNHAE3YIe3ILI=
X-Received: by 2002:a05:6000:2303:b0:435:9612:2d24 with SMTP id
 ffacd0b85a97d-4362937e1d7mr618106f8f.53.1770321531276; 
 Thu, 05 Feb 2026 11:58:51 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:50 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 06/29] system/vl: Introduce -machine-path command line option
Date: Thu,  5 Feb 2026 20:58:01 +0100
Message-ID: <20260205195824.2610192-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch adds a new command line option `-machine-path` to specify
a directory path for shared machine resources.

This path is intended to serve as a base directory for devices or
subsystems that need to automatically create coordination files,
such as Unix domain sockets, particularly in multi-process simulation
environments.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/system/system.h |  2 ++
 qemu-options.hx         | 10 ++++++++++
 system/vl.c             |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/include/system/system.h b/include/system/system.h
index 03a2d0e900..0cd012004d 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -57,6 +57,8 @@ bool is_mlock_on_fault(MlockState);
 
 extern MlockState mlock_state;
 
+extern const char *machine_path;
+
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/qemu-options.hx b/qemu-options.hx
index 6dd3e04e38..b7dd2a64f0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -765,6 +765,16 @@ SRST
     Preallocate memory when using -mem-path.
 ERST
 
+DEF("machine-path", HAS_ARG, QEMU_OPTION_machine_path,
+    "-machine-path DIR A directory in which to create machine nodes\n",
+    QEMU_ARCH_ALL)
+SRST
+``-machine-path path``
+    Selects the machine path.
+    Multi-arch machine nodes will be created in <path>.
+    This option also sets -mem-shared-path to the given path.
+ERST
+
 DEF("k", HAS_ARG, QEMU_OPTION_k,
     "-k language     use keyboard layout (for example 'fr' for French)\n",
     QEMU_ARCH_ALL)
diff --git a/system/vl.c b/system/vl.c
index c890da586c..4750b1cf69 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -182,6 +182,7 @@ static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 static bool nographic = false;
 static int mem_prealloc; /* force preallocation of physical target memory */
+const char *machine_path;
 static const char *vga_model = NULL;
 static DisplayOptions dpy;
 static int num_serial_hds;
@@ -3128,6 +3129,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc = 1;
                 break;
+            case QEMU_OPTION_machine_path:
+                machine_path = optarg;
+                break;
             case QEMU_OPTION_d:
                 log_mask = optarg;
                 break;
-- 
2.43.0


