Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B14606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KKRPO3Xa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JqYyvoao
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrb-0006c2-R7; Tue, 27 Oct 2026 15:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrY-0006Jf-Rz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrW-0002Th-Ew
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIAuT3486333
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pCLF3qARxKPjszPwebyr7j8AOoYU3m1TDLjxq95k2yA=; b=KKRPO3XanqAAKqLq
 1ZJlv5zDA8vCKiV1QB//wp1tFjA8jxJHLDqRwwFWYX3mgAhVY8EI0teLHKCWnCPv
 K/mL+cLp+lqS8S3ofOlONOG5C7LrxG9B2LcGMT9EdNHxLoHY6WlzCXygQLLH5DLh
 2DPTphe05WGwswglN92Q9HuI7mI3aJ5aOSspnQSkynhpp8JWB3EHr2HxNgnNyaZ7
 +O34qla06URJ4QZ8ux/LPteDYww/JYYxen4IRZ0cDNWRtYlZefLw5fa6epTlTYni
 UU4Li8ciig5rgsveGYehUVXXwElyg00qzm0Q1dsnGxy4xSqUC2lUES8/et9Sr/6S
 BrmHfg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc390-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9308eafb465so29068185a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129373; x=1793734173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pCLF3qARxKPjszPwebyr7j8AOoYU3m1TDLjxq95k2yA=;
 b=JqYyvoaoW2hK4IP4oA2jXsmKeHJEQRmh0hUuDmaU5EAUu76k1008vDVbAwadgPD8f4
 WCtq8f5fyFHI5B+FPfNMaaPRKUETIcaJnzaid+qFHZRWzFhxtxC4Gtkhlb/Gcutfdy9I
 WGEKauXBAfHtzZjILC09EyptAUD29dQ0xGuReixezXFtOCdRJ83nbPZVFA0kJHKuKx5K
 dujloyq/uCqesGQppMwsmwYcnQEuPMTvLYde1FirLWzeG3tDIcbJnwMcJuLe0fyqGGYI
 s2W7zTe/acP3lvAfAn1Z/RHKMIyqGK/WyOkp1YVhzCcN0lyDOJBO5b+Tz6ViYKJdhmpE
 U+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129373; x=1793734173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pCLF3qARxKPjszPwebyr7j8AOoYU3m1TDLjxq95k2yA=;
 b=p/tqI1kon2ItTDXUTZNyH8PVhkUz157AkNfTJQqJiBW6z0bA34bBhk4gxrbv5f5zOR
 qGXYx+6hCtLcogjOIJ34p8Dmg9698vhOVyJGWrmHO4ZzdvS3t4ZMAy4mlRoOb4k+G3Co
 CoNIb0bnIwhNnvcAKlS5XWb7/Bz7ROUxTgDBINS5Cpw2kucOaKiaaEniWXFIV4AdE9WL
 Cz8FFKBIh5uRUdolhlGW8A/XF63hXWPbVJqhlR6aDxOh7/KZz/uWKu6wb0rfsLAEa88/
 IMwbGLfM6QhfIMrb+FISSST5LyajK3opYhcL4ehMa4v10JSIAmeuf3n1yAS2OIG7odxt
 FgZg==
X-Gm-Message-State: AFq9FYJU8zvCt7kNN1y/oWkcJHQ7gryjeFojd6CMbaTMX/Ed3P+neHUt
 9KYMF79VZbKXvqFkTnna5w9jxr31uSVMn6zqe5wBC8+Hxlpm7tjnuYcM6qlI2eK+OV7oFvPc2mn
 mus/6GfzitSMx0p858MqY9cfJswpnUbpfO83KEMgzjLQKckgR4KgwqVDyawUjWZWhmQ==
X-Gm-Gg: AYBFou3OGiHhPFLmrS58jOQGQqpC/vkTM+HxmNw9X5LQktYkE/ebiatc8/CP0iT/BAr
 LSn4zTFuxa8ZWNCpMw2hlCjr4op5mb6mkvBLJcJDB5e/5i0TlL/pXd0hYEayYn6a0mM1OqPb9vJ
 kMrOV/XmEqEpLFA5E7y45wdTtAWZmsa7HfVpTGBKXhQYsrRm5VGO1iU1uhoIlV3czymZ9imcIyc
 Tq3mp0Qxb98OcH7XGQecb2XauIhj8t5N7pbKgjmS2FDxs85jxV+Meva47bmSzfGve2ZBFVDMnQ2
 J6BLNedevpzNHlP4yrQFPoMB7PzwX7zwAYqRbyS3eqHt0d34ICf/DkVLkqJnIy3ZI19k9VWA8ja
 /xI86iKooX6rRVkpRqrvoURrmaIKWb1E7y0nwAS8HlqNcDJAALezZNGZ0
X-Received: by 2002:a05:620a:2955:b0:93f:611d:a18e with SMTP id
 af79cd13be357-940ef913527mr1638864785a.55.1793129372513; 
 Tue, 27 Oct 2026 12:29:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:93f:611d:a18e with SMTP id
 af79cd13be357-940ef913527mr1638861085a.55.1793129371844; 
 Tue, 27 Oct 2026 12:29:31 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8290sm3218015e9.9.2026.10.27.12.29.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/59] system: Remove deprecated 'debug-threads' option for
 -name
Date: Tue, 27 Oct 2026 20:23:32 +0100
Message-ID: <20261027192341.9197-52-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxMpqW5kBzWyF
 3HLxg41k7WFimbO3yes89d76ZYkU0E1pohsyC7gQ+Ag707x6ELWgiElFPHjXd6Jy23WWJJksdMT
 Lo8qxdQog8SqbDjQoCZ9RTOEXaowd7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4BAC5n7IeN9P
 ioucZm0hECeI1sQ/O4ohxNnKtOSRtA/lRT0tMRNdwU6WwJ//TqZjPFI2zjfMDHzQOK/pAJrRtSC
 ktDmeSM6lEk25RApo2tq9qRm8ZEogtdnY1lqR93VPV1c79w2+763NMPOt/OAHyKDt4rEZ+ot/6h
 B34hXtmgO3u1j66L37zDzkpAVRD3GSzqiFc7GYZu5apN8B/aFKoTHE3YC/9amm5/6rEVrp748Um
 t2pr/DJp3tdkt5XcTFcMaEDQYSV/57ekoSPiyDKwbciMplwFCjBlajMoYbu3N0YYQaD1WRm7tyX
 qDpVuhhRKhsUogMBgoI8b542UA/YqamWfIlXqV4CY4xdV8ltYhKkZx3G7clxqxr2rD88+uT0Y/b
 F79j52R9STAniQkQ47ptxLFPWGbMn3J0UQNZ5Anwjh04XwZATZzspwJEfwppDXh5B5uZ2GS1pZH
 gHlp0Wvtdltxo2oh1nA==
X-Proofpoint-ORIG-GUID: -wXhfrxCEvWHNvFzPMBpZ2cPGiQIRW6Y
X-Proofpoint-GUID: -wXhfrxCEvWHNvFzPMBpZ2cPGiQIRW6Y
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fb9d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8 a=LQmNBL1JU3umNfIF-20A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

'debug-threads' option for -name was deprecated in v11.0
(commit 1b65aeed2a0 "system: unconditionally enable thread
naming") thus can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20261018232917.7716-1-philmd@oss.qualcomm.com>
---
 docs/about/deprecated.rst             |  7 -------
 docs/about/removed-features.rst       |  9 +++++++--
 system/vl.c                           | 11 -----------
 tests/qtest/migration/framework.c     |  4 ++--
 tests/qtest/migration/precopy-tests.c |  2 +-
 qemu-options.hx                       |  7 +++----
 6 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 153fe118151c..ffcbe624a4e9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -54,13 +54,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``debug-threads`` option for ``-name`` (since 11.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``debug-threads`` option of the ``-name`` argument is now
-ignored. Thread naming is unconditionally enabled for all platforms
-where it is supported.
-
 ``-mon`` option (since 11.1)
 ''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 6a9944a0c794..cd4f3338bccf 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -578,6 +578,11 @@ kernel since 2001. None of the board types QEMU supports need
 Keeping 32-bit host support alive was a substantial burden for the
 QEMU project.  Thus QEMU dropped all support for all 32-bit host systems.
 
+``debug-threads`` option for ``-name`` (removed in 11.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Thread naming is unconditionally enabled for all platforms where it
+is supported.
 
 User-mode emulator command line arguments
 -----------------------------------------
@@ -779,8 +784,8 @@ values could be assigned to integer device properties or vice versa.
 Removed with no replacement, as it reported only a limited set of
 threads (for example, it only reported source side of multifd threads,
 without reporting any destination threads, or non-multifd source
-threads).  For debugging purpose, please use ``-name
-$VM,debug-threads=on`` instead.
+threads).  For debugging purpose, thread names are unconditionally
+enabled where supported.
 
 ``migrate`` argument ``detach`` (removed in 11.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''
diff --git a/system/vl.c b/system/vl.c
index 468a9fc247ac..e766402f7e19 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -403,11 +403,6 @@ static QemuOptsList qemu_name_opts = {
             .name = "process",
             .type = QEMU_OPT_STRING,
             .help = "Sets the name of the QEMU process, as shown in top etc",
-        }, {
-            .name = "debug-threads",
-            .type = QEMU_OPT_BOOL,
-            .help = "Enable thread names"
-                    "(deprecated, always enabled where supported)",
         },
         { /* End of list */ }
     },
@@ -556,12 +551,6 @@ static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
 {
     const char *proc_name;
 
-    if (qemu_opt_get(opts, "debug-threads") &&
-        !qemu_opt_get_bool(opts, "debug-threads", false)) {
-        fprintf(stderr, "Ignoring deprecated 'debug-threads=no' option, " \
-                "thread naming is unconditionally enabled\n");
-    }
-
     qemu_name = qemu_opt_get(opts, "guest");
 
     proc_name = qemu_opt_get(opts, "process");
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b7aef6b21cbb..fbe1e1f247d6 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -413,7 +413,7 @@ int migrate_args(char **from, char **to, MigrateStart *args)
 
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
-                                 "-name source,debug-threads=on "
+                                 "-name source "
                                  "%s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s",
@@ -433,7 +433,7 @@ int migrate_args(char **from, char **to, MigrateStart *args)
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
-                                 "-name target,debug-threads=on "
+                                 "-name target "
                                  "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming defer "
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index d57ffcac234d..3298bf026a1a 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -807,7 +807,7 @@ static QTestState *dirtylimit_start_vm(void)
 
     bootpath = bootfile_create(qtest_get_arch(), tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
-                          "-name dirtylimit-test,debug-threads=on "
+                          "-name dirtylimit-test "
                           "-m 150M -smp 1 "
                           "-serial file:%s/vm_serial "
                           "-drive file=%s,format=raw ",
diff --git a/qemu-options.hx b/qemu-options.hx
index f72f30e246d6..c9653ca69daf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1376,18 +1376,17 @@ SRST
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-    "-name string1[,process=string2][,debug-threads=on|off]\n"
+    "-name string1[,process=string2]\n"
     "                set the name of the guest\n"
     "                string1 sets the window title and string2 the process name\n"
-    "                When debug-threads is enabled, individual threads are given a separate name\n"
     "                NOTE: The thread names are for debugging and not a stable API.\n",
     QEMU_ARCH_ALL)
 SRST
 ``-name name``
     Sets the name of the guest. This name will be displayed in the SDL
     window caption. The name will also be used for the VNC server. Also
-    optionally set the top visible process name in Linux. Naming of
-    individual threads can also be enabled on Linux to aid debugging.
+    where supported, set the top visible process name (individual threads
+    are always given a separate name to aid debugging).
 ERST
 
 DEF("uuid", HAS_ARG, QEMU_OPTION_uuid,
-- 
2.55.0


