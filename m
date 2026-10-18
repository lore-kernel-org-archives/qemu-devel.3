Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8C7CCF2D4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 23:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIaJi-00045w-Fw; Sun, 18 Oct 2026 19:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIaJh-00045m-DC
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 19:29:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIaJf-0001jt-Gc
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 19:29:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ILjNoD1312163
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GVR/VEDeWEqIDIOBC6C99y
 7Io24VsjPmlnkh4OFRMpU=; b=aPLO8oFiuYvtNC+RB91pmXuItAZIUqgpwX2SSn
 McbPFumR/gfP+VKWxENiTBj57z7BVnkWzaFEPhjD3yTWmdjsgYOizjz9M78YDOkr
 Pwq/bICzXLK8oMdQhY+XvJpxliDpGZXYm/Dlj0F/U73yCPecXGUk7n7XKKmQTTdA
 wdVrWK7fMBmU+CPiKojArzyH0xuqAYs9p0ujAVRnCkO2yeORJW5EPGIz5xbHdfnw
 BZylGXCRcvXWjBOigA7+gY6lMNu+BUEgGPjEhdMUVXblSc+eQklftQTrifZ/H8nU
 B3JxmA35Uugd2ZnwTKVsLwUSRikx470DmVRVTXmTrjA/nPoA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5u1g6sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:29:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a3f673221so616788385a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792366160; x=1792970960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GVR/VEDeWEqIDIOBC6C99y7Io24VsjPmlnkh4OFRMpU=;
 b=chf8RzxTUf8h62IaCIk4RACBVyM9yaz8sppQ9FMqEpWKMzcoX+TdhSWryhozSitqHh
 sL/K04ip+BPtQkDiXJPQrssFiZKW0Vld5+oHuagv1Gcz2EfueDbCGvCqu5aG+xFjobQO
 LRBUaZTY5AhOGzJ3OuKlWHCva58egDlkQ5qByEgJ8AD88qfaNQVuYkhe+21I1tOzJmPh
 p6KGuQYBZdezklqYjSiQgvwAITPzU3bkSjgMK4eN3MyemPDNK4TgWHmbd5u5U+gHNGaI
 YGD2PCar52ObaCg++fB55/bost8MjF+x5eXKvxGe4I/ljm/++xax1iAJP/Dxp0wP9NZA
 DeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792366160; x=1792970960;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GVR/VEDeWEqIDIOBC6C99y7Io24VsjPmlnkh4OFRMpU=;
 b=KH6Z2Oj70WbTMEcsCWAMIBYqOGGjTxYnsVBZfkaORPMwcy8D6MJ+cbcBzxCUh3pwfy
 bLSKHFD7YPcBvikfrWwdcNdyIztv3MLDLJ+E28iCm8rFhnUWxe7amEncWwxIxaMAu7Z7
 KUhTwWCb0JKF87Fn+zSxl723KCvW4BmJSpeuFlzFPT61obsaujQL/y740GdFq7AyiNO0
 GvgC1BOQYoFSXuFjBhoT3oYpf7SlCnJ1jqRRyvUmD1ozZhBqwLn/5uqf8pOoXTCxmjcg
 c+Cqd1jtPmc7IMU7qOuvrLoys1kwnoEy3ZcQB9KAxLiUouFB5JwycPL0CNjDHVoEv2Ba
 9f5g==
X-Gm-Message-State: AFq9FYK7uJ0XGIJHinbKiPMUSb32uPC7rOIAcxYEg8174100OJhed7w7
 NpURSBZYzXWrN3XTouAzWxaQhL8xA1LKsZqB5KW+4yv7zjoHKsR8gyvL8b2lFnI3ba1urSIUhgd
 VH7KehdYwOtjGvFkOaaDo163svxgra5YQBU15lsNoRPZv4m0jiqft5CPxgEkd36/lJg==
X-Gm-Gg: AYBFou05alS2myrK2wd3Q6kc1CDVIpXzy14Uxi+8zQ0hfcS5JyahlbqoULSCpP/JbRj
 vZvA1rTBhwY/CzHW3T+bt+LzpXTxtRbAmK5/X2Ubhe/ysRBDy4Mp9ehq2Mqqb5wvKeYsgTkTidI
 V3HTSXW+wqtvm2VkIaNLAlOb/d0Xq4qaS0oDobVhhNwX7chQW4vZBrDtcSqKVoVynDKclD3bp/S
 h5ucsdjueQLvO9z0pxxY1C5LIMgRfppXeIXkBCQqsNblVa8iEKjmk9BOzHFQawko0ep5IluppDu
 17oSYwqxuebsBE+YRZmlcJdSuvarWLlPfm7JZweHzU8rZIVuzgc1gnfUqpnVlWYRjryRPlDVdg0
 MSpVLlOtIfEvaKeueM9gKMeyy4e3FgG6K7ULoXPSp
X-Received: by 2002:a05:620a:7018:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-93f29cccec2mr1143533485a.25.1792366160443; 
 Sun, 18 Oct 2026 16:29:20 -0700 (PDT)
X-Received: by 2002:a05:620a:7018:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-93f29cccec2mr1143530485a.25.1792366159929; 
 Sun, 18 Oct 2026 16:29:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ae6d2esm231222095e9.6.2026.10.18.16.29.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 16:29:19 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] system: Remove deprecated '-name foo,
 debug-threads=...' option
Date: Mon, 19 Oct 2026 01:29:17 +0200
Message-ID: <20261018232917.7716-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p-ljjWeLSry4SkIcuV-81CRGyTDmJz1k
X-Authority-Analysis: v=2.4 cv=NItAaE6g c=1 sm=1 tr=0 ts=6ad55651 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LQmNBL1JU3umNfIF-20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA5MyBTYWx0ZWRfX9XzA7ms/9Yzm
 uxY7aN+SJRl+4ajXL5UA+u5uo83BLH+ImkB2ARsSNPm6+OxarKPgSu/yUU4Ebg/dQqTJHxPuO/F
 0Wn5si6H+Yu/4Tit0/Ix2xhHODst7VQ=
X-Proofpoint-GUID: p-ljjWeLSry4SkIcuV-81CRGyTDmJz1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA5MyBTYWx0ZWRfX9rJOhOSai/JC
 NjRjktTQ3JincSbPUciHUVcn8ikTBMoJhbZeMj9THqTXo/lq4P7P1BRJqt33ZH0e4kThixdFQ0T
 bXZIHr6QNFjlqWHOGB8GSEUqTpQablVhtvSdj0cdt2foKdZxyoT2fM6/CEkNv3AcO638nBYmadY
 9NVNEQ5Mb4x5+od7YoEuuSI2YuC5sVTLWMf9uwbNY4NurXcp0GTXNtYymOUF3kgkPAYxmceG3bs
 lgDz79/8+0bBqjXpTBFhHcABZp8W6UowBFK5V3WdLgSjd5+cvN6M1Rils9QiPIfERL5g3+9cBpN
 4YFiCg1L59O5L3w5k4kks3nmDqVqFr4E6cnwooGQryJtZRM5uSlE2uerXXYwJ1QbDm+o1+W2zE8
 ukqqCMePpc+ZcSyCFd475GFUGfNiXM7t3nSXcdWZwCe/aJigQH1VSw76QdM2KCWyYUC/JfDhCHZ
 rsYPThbetop5GXFpd6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-to:  =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
From:  =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

'debug-threads' option for -name was deprecated in v11.0
(commit 1b65aeed2a0 "system: unconditionally enable thread
naming") thus can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/about/deprecated.rst             |  7 -------
 docs/about/removed-features.rst       |  9 +++++++--
 system/vl.c                           | 11 -----------
 tests/qtest/migration/framework.c     |  4 ++--
 tests/qtest/migration/precopy-tests.c |  2 +-
 qemu-options.hx                       |  7 +++----
 6 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..08d86bec314 100644
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
index 6a9944a0c79..cd4f3338bcc 100644
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
index 468a9fc247a..e766402f7e1 100644
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
index b7aef6b21cb..fbe1e1f247d 100644
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
index d57ffcac234..3298bf026a1 100644
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
index 2f6863180b0..7f75fe54a12 100644
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


