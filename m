Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76512CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA7-0002uJ-VR; Thu, 30 Apr 2026 16:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYA3-0002oW-E6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9v-0000st-Ci
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UGIUTQ2121543
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ONXkN3ifjbZ/ePm7DoxSplyChWIv5V/mKaE+92h7psE=; b=W9BUoXXDCm/Kff3p
 xz+lY+DcdUXaDl7epE3vLkjVemFoob4g3NG7RSnAVjigkSE0AcyBa7eFHTnBmsUH
 sCRhMbafdgzBr3DLOcvg+UPDlUYRstrgXO8Shc6oXObobqfdJ9cyzINe0+1DOQs1
 ckjSG69M5ol3QTtWTbSiVoqa0y45CcaQwuvogiFL+gWHZbv6O0g/oopRwXjpvWlq
 wpqcBrCJwM1AeOHLjNlJWV78dXhDLB7jr1bguzXrjMJbKcq9kD0QGUhgHwPmnVTP
 +hVWBjxPG9tGIdeRisgYTNt2qr7cfNjNW0hJyRzLY1lmFh8sxboXddMafED0hThv
 IsRFLA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4s6wb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee34588671so599157eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581531; x=1778186331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONXkN3ifjbZ/ePm7DoxSplyChWIv5V/mKaE+92h7psE=;
 b=ORLntglVrt2E59WGqAEw2gpwCXUW8xoHGgzHUvZmSiIfj2GhKH4S1SvFjKZX7h0rLr
 5kJmZSV90rNdMqyaHzcLNfIutTsnHIWEz4HYbVE2PWb7jmv4cPaxT/O2sJp0N7KtzXmJ
 eQgMDpyy4UzTuv2ZuD/16KeKmVwM8Bs5LdKPFC9J8qQmy8I3xi7f3pRAsc6ie1R885/t
 dmRPyIQD2n1gxBTC7lgSZGtY9VN6AgS7GR3awp8QQBGOFd2x2dA2uvKlKPUu7yPrCA6N
 T+Io0nAVRW5acEK9vpcSF5BB5wBcorqnBLWroyulaRGdBUo7TI3UkYisTVvaswcs73ua
 Eqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581531; x=1778186331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONXkN3ifjbZ/ePm7DoxSplyChWIv5V/mKaE+92h7psE=;
 b=D7HRc00pO//RQFQrLVlMRUR4Tv4rnNmLG5/p2CrrMnmj7sQI/CjS8yP/8PsLYsmep1
 gmHpb0tFkO6CllYNIjptDcfReoc8RScjPWqa3Q8OIv7QnQclH6BReU3YplZS/n2wVYJ1
 dE298C4QLRqBKVajvGiygVvbCkH2tbHqN7iqlCS0Ll12XK57GzgnZhxEFxBa5zSWZonV
 N8sGXhuzAXK3v6gn3DIoX7niU004YjEblH+wfPaDQmm8tFNToTTJ8AcNX3VKb+VyE5hu
 x8+AnqQysVBDmw5rmylhJ8AositnlvgTtG56Q+TvYW1Rdsbuj42EykYFAdQ/6CAfp78f
 kX6g==
X-Gm-Message-State: AOJu0YzNLQ4dH6fDtlqdbMY4POTIXazzN7KIammZFLUgZishI5ZTkS7G
 Vd35f9i/0I62Qk5mMf8CRGQU1ARXPf8qmVHxMnVnvigULHPQ1IwsRal1Y8a4I3M6T6/ciy8x9yi
 Ky5FjBp6updwK33n4rKAE8NSSPsmO4PbXhxtCNbaipg5EbJV9FF1YzVpOU1VQVKx2maLn
X-Gm-Gg: AeBDieuRXgjbt0bTxvOy6rJvTKJtlg6hplZkxxTDvGQP7wbtMd0/4O1zK1rbx7BopMr
 KRizqE1OZJ96GqhOjGc3Gph4s2iJAatS+9wC9EbCcX61J5wy6H5BhQlxnSgaQtHCW/i2i244A1D
 yctfCJtF6mT64NP2y+tgq2/j4Ltl2uwjD34t3T73XOcqLdyoSYpRo/waqFxDiKZN02jEzAaO59+
 4Mnes0Eide2vL5pfq4PZNPEdCoguc21EFV0Fpby7puAqzMsrGc9BHKHcO4WKGdYDL8S8I9hgIm+
 bAU4j3edMgHx4Up7ZRii/aiBi6PjF7F3SUY8NBRxbt1eW4Ou4gq/ZqbNGsPRAqGRBp52Q66bgKx
 c19wfcWgHnYJLLgMVk9l+0K4FkW0bdvTjQqOtAotB9SxGcGbwqIlqXYfA9nvHcKBfUmelCkIVsO
 Xp5XMOStBJr7e6ujE8
X-Received: by 2002:a05:7301:e0c6:b0:2ed:b131:240e with SMTP id
 5a478bee46e88-2edb13124d5mr964212eec.23.1777581530856; 
 Thu, 30 Apr 2026 13:38:50 -0700 (PDT)
X-Received: by 2002:a05:7301:e0c6:b0:2ed:b131:240e with SMTP id
 5a478bee46e88-2edb13124d5mr964196eec.23.1777581530191; 
 Thu, 30 Apr 2026 13:38:50 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/8] qemu/module: add a new QOM_EARLY init step
Date: Thu, 30 Apr 2026 13:38:35 -0700
Message-ID: <20260430203842.29156-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h7ckFA70UG8DUrsYaseGT2eaIhqKBjna
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfX6a7m4OEoGrMr
 FkiocFyAXPMi6KODYiWxnEUi6kmyiO7weDVy4oAJRtDL0JPS2VbpUL3y76SpRbN5+cNOTjSDDJy
 lIZCl8pRomGVzYTYGiZJFvizL7qHsBVBX1OidYfkUSihZYcnt9aK9Z3ZhPnAdCqX63BknH9LRYQ
 lijN6EkRhEmB8P4wxFv3hHNbcmeRju6i//OFWosEWLYy3+Fr7FspN9C8ZLG9u1+BCRcCSMnpXYS
 dldXtK8NtrcIWU2ZVVP9raVH2XSEx+1kL/Evdqk36fsGZDFiIDFOGfzawktoTpqI7Q4nmTUxVlM
 DyoI90RItafUnhLsgtD8bPvUCMJu/yj/eaBLf/Wi1L313gOc7eeYYTHsRnvUlpXp58r0F2x+p50
 naOfXvw+We8J8/oXSBiJWzxXc2Z3YXLsQjELgpKeusM63wX9ENlEglE5W71pDJ29jSOIAGrOMog
 iv5Xi+O3dLB7A599V/Q==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3bddc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=IYgryfmtWe4h1XmuO8sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: h7ckFA70UG8DUrsYaseGT2eaIhqKBjna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300213
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This step will be used to initialize fundamental QOM types, like OBJECT,
INTERFACE or TARGET_INFO that will be introduced in this series. It may
be used in the future if needed.

We need to patch all call sites to module_init(MODULE_INIT_QOM) to call
module_init(MODULE_INIT_QOM_EARLY) as well.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 bsd-user/main.c                         | 1 +
 include/qemu/module.h                   | 2 ++
 linux-user/main.c                       | 1 +
 qemu-img.c                              | 1 +
 qemu-io.c                               | 1 +
 qemu-nbd.c                              | 1 +
 rust/hw/core/tests/tests.rs             | 1 +
 scsi/qemu-pr-helper.c                   | 1 +
 storage-daemon/qemu-storage-daemon.c    | 1 +
 system/runstate.c                       | 1 +
 tests/audio/test-audio.c                | 1 +
 tests/qtest/bios-tables-test.c          | 1 +
 tests/qtest/fuzz/fuzz.c                 | 1 +
 tests/qtest/migration-test.c            | 1 +
 tests/qtest/qos-test.c                  | 1 +
 tests/qtest/tpm-crb-swtpm-test.c        | 1 +
 tests/qtest/tpm-crb-test.c              | 1 +
 tests/qtest/tpm-tis-device-swtpm-test.c | 1 +
 tests/qtest/tpm-tis-device-test.c       | 1 +
 tests/qtest/tpm-tis-i2c-test.c          | 1 +
 tests/qtest/tpm-tis-swtpm-test.c        | 1 +
 tests/qtest/tpm-tis-test.c              | 1 +
 tests/unit/check-qom-interface.c        | 1 +
 tests/unit/check-qom-proplist.c         | 1 +
 tests/unit/test-authz-list.c            | 1 +
 tests/unit/test-authz-listfile.c        | 1 +
 tests/unit/test-authz-pam.c             | 1 +
 tests/unit/test-authz-simple.c          | 1 +
 tests/unit/test-char.c                  | 1 +
 tests/unit/test-crypto-block.c          | 1 +
 tests/unit/test-crypto-secret.c         | 1 +
 tests/unit/test-crypto-tlscredsx509.c   | 1 +
 tests/unit/test-crypto-tlssession.c     | 1 +
 tests/unit/test-io-channel-buffer.c     | 1 +
 tests/unit/test-io-channel-command.c    | 1 +
 tests/unit/test-io-channel-file.c       | 1 +
 tests/unit/test-io-channel-null.c       | 1 +
 tests/unit/test-io-channel-socket.c     | 1 +
 tests/unit/test-io-channel-tls.c        | 1 +
 tests/unit/test-io-task.c               | 1 +
 tests/unit/test-qdev-global-props.c     | 1 +
 tests/unit/test-qdev.c                  | 1 +
 tests/unit/test-smp-parse.c             | 1 +
 tests/unit/test-throttle.c              | 1 +
 tests/unit/test-vmstate.c               | 1 +
 tests/unit/test-xs-node.c               | 1 +
 tests/unit/test-yank.c                  | 1 +
 tools/i386/qemu-vmsr-helper.c           | 1 +
 48 files changed, 49 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c3274..a6e7a285af7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -285,6 +285,7 @@ int main(int argc, char **argv)
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     envlist = envlist_create();
diff --git a/include/qemu/module.h b/include/qemu/module.h
index 9885ac9afb3..37b63cd2b03 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -43,6 +43,7 @@ typedef enum {
     MODULE_INIT_MIGRATION,
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
+    MODULE_INIT_QOM_EARLY,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
@@ -54,6 +55,7 @@ typedef enum {
 #define block_init(function) module_init(function, MODULE_INIT_BLOCK)
 #define opts_init(function) module_init(function, MODULE_INIT_OPTS)
 #define type_init(function) module_init(function, MODULE_INIT_QOM)
+#define type_init_early(function) module_init(function, MODULE_INIT_QOM_EARLY)
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
diff --git a/linux-user/main.c b/linux-user/main.c
index 86d04cca3c4..629a6b64cf1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -702,6 +702,7 @@ int main(int argc, char **argv, char **envp)
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     envlist = envlist_create();
diff --git a/qemu-img.c b/qemu-img.c
index c42dd4e995e..096dd318963 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5931,6 +5931,7 @@ int main(int argc, char **argv)
 
     qcrypto_init(&error_fatal);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     bdrv_init();
 
diff --git a/qemu-io.c b/qemu-io.c
index 8f2de83f3c8..d0db7df2ad7 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -537,6 +537,7 @@ int main(int argc, char **argv)
 
     qcrypto_init(&error_fatal);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
     bdrv_init();
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ed5895861bb..f9fe220b176 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -629,6 +629,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_TRACE);
     qcrypto_init(&error_fatal);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
     qemu_init_exec_dir(argv[0]);
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 05aa5d4a377..08597ca46b7 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -91,6 +91,7 @@ fn init_qom() {
     bql::start_test();
     if !ONCE.get() {
         unsafe {
+            module_call_init(module_init_type::MODULE_INIT_QOM_EARLY);
             module_call_init(module_init_type::MODULE_INIT_QOM);
         }
         ONCE.set(true);
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9dcd3ec7111..089b95842c9 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -907,6 +907,7 @@ int main(int argc, char **argv)
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
     qemu_init_exec_dir(argv[0]);
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index eb725613582..8ede324fd89 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -406,6 +406,7 @@ int main(int argc, char *argv[])
 
     os_daemonize();
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_TRACE);
     qemu_add_opts(&qemu_trace_opts);
diff --git a/system/runstate.c b/system/runstate.c
index 770253b467b..43d60bafedf 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -981,6 +981,7 @@ void qemu_init_subsystems(void)
 
     atexit(qemu_run_exit_notifiers);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_MIGRATION);
 
diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index af8cf03d10e..8962cc6be45 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -584,6 +584,7 @@ int main(int argc, char **argv)
     dir = g_test_build_filename(G_TEST_BUILT, "..", "..", NULL);
     g_setenv("QEMU_MODULE_DIR", dir, true);
     qemu_init_exec_dir(argv[0]);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     module_init_info(qemu_modinfo);
 
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 510751799e4..460ddf18589 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1527,6 +1527,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *arch,
 
     tpm_tis_base_addr = base;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     test.addr = g_new0(SocketAddress, 1);
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index ca248a51a6c..031b3173a36 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -172,6 +172,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Initialize qgraph and modules */
     qos_graph_init();
     module_call_init(MODULE_INIT_FUZZ_TARGET);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e582f05c7dc..f69e679895a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -46,6 +46,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     env = migration_get_env();
     env->full_set = full_set;
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     migration_test_add_tls(env);
diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 50fa0ceef36..c4bc2408cb2 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -343,6 +343,7 @@ int main(int argc, char **argv, char** envp)
         qos_printf("}\n");
     }
     qos_graph_init();
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
     qos_set_machines_devices_available();
diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index ffeb1c396b8..297182a73bb 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -50,6 +50,7 @@ int main(int argc, char **argv)
     ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
     ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
index 396ae3f91c1..08d58b613eb 100644
--- a/tests/qtest/tpm-crb-test.c
+++ b/tests/qtest/tpm-crb-test.c
@@ -144,6 +144,7 @@ int main(int argc, char **argv)
     GThread *thread;
     TPMTestState test;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-tis-device-swtpm-test.c
index 517a0770055..ad2660210f9 100644
--- a/tests/qtest/tpm-tis-device-swtpm-test.c
+++ b/tests/qtest/tpm-tis-device-swtpm-test.c
@@ -58,6 +58,7 @@ int main(int argc, char **argv)
                                      NULL);
     ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/qtest/tpm-tis-device-test.c b/tests/qtest/tpm-tis-device-test.c
index 3ddefb51ecf..be0f2e3df03 100644
--- a/tests/qtest/tpm-tis-device-test.c
+++ b/tests/qtest/tpm-tis-device-test.c
@@ -37,6 +37,7 @@ int main(int argc, char **argv)
     char *args;
     int ret;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 3a1af026f2e..c23fdefd4a3 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -605,6 +605,7 @@ int main(int argc, char **argv)
     GThread *thread;
     TPMTestState test;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 105e42e21d6..30a07fa1adc 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -53,6 +53,7 @@ int main(int argc, char **argv)
     ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-tis-swtpm-test.XXXXXX", NULL);
     ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/qtest/tpm-tis-test.c b/tests/qtest/tpm-tis-test.c
index a4a25ba7452..7ea2bafc045 100644
--- a/tests/qtest/tpm-tis-test.c
+++ b/tests/qtest/tpm-tis-test.c
@@ -31,6 +31,7 @@ int main(int argc, char **argv)
     GThread *thread;
     TPMTestState test;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index 86ae5f6c3b1..c02acfc7b27 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -90,6 +90,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&test_if_info);
     type_register_static(&direct_impl_info);
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index ee3c6fb32b1..d8e5cd97091 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -652,6 +652,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&dummy_info);
     type_register_static(&dummy_dev_info);
diff --git a/tests/unit/test-authz-list.c b/tests/unit/test-authz-list.c
index 5351992a013..1f7754f1024 100644
--- a/tests/unit/test-authz-list.c
+++ b/tests/unit/test-authz-list.c
@@ -147,6 +147,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_add_func("/auth/list/default/deny", test_authz_default_deny);
diff --git a/tests/unit/test-authz-listfile.c b/tests/unit/test-authz-listfile.c
index 64d0e1500f7..b8d39645362 100644
--- a/tests/unit/test-authz-listfile.c
+++ b/tests/unit/test-authz-listfile.c
@@ -170,6 +170,7 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     workdir = g_dir_make_tmp("qemu-test-authz-listfile-XXXXXX",
diff --git a/tests/unit/test-authz-pam.c b/tests/unit/test-authz-pam.c
index 4fe1ef2603e..d23f3fb0871 100644
--- a/tests/unit/test-authz-pam.c
+++ b/tests/unit/test-authz-pam.c
@@ -123,6 +123,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_add_func("/auth/pam/unknown-service", test_authz_unknown_service);
diff --git a/tests/unit/test-authz-simple.c b/tests/unit/test-authz-simple.c
index 6f9034d8ff2..a6c038220ae 100644
--- a/tests/unit/test-authz-simple.c
+++ b/tests/unit/test-authz-simple.c
@@ -43,6 +43,7 @@ static void test_authz_simple(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_add_func("/authz/simple", test_authz_simple);
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index b88b557133a..0686d917434 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1898,6 +1898,7 @@ int main(int argc, char **argv)
         goto end;
     }
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_chardev_opts);
 
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 218e585f988..5197e6c122a 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -565,6 +565,7 @@ int main(int argc, char **argv)
 {
     gsize i;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/unit/test-crypto-secret.c b/tests/unit/test-crypto-secret.c
index fc32a01747b..ee2b7bd3469 100644
--- a/tests/unit/test-crypto-secret.c
+++ b/tests/unit/test-crypto-secret.c
@@ -558,6 +558,7 @@ static void test_secret_crypt_bad_iv(void)
 
 int main(int argc, char **argv)
 {
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
 
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index b1ad7d5c0d8..c83e2ef82d2 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -140,6 +140,7 @@ int main(int argc, char **argv)
 {
     int ret;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 0d06a6892eb..f9e23ace76c 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -412,6 +412,7 @@ int main(int argc, char **argv)
 {
     int ret;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
diff --git a/tests/unit/test-io-channel-buffer.c b/tests/unit/test-io-channel-buffer.c
index 9c6724dea41..45f9528d8d3 100644
--- a/tests/unit/test-io-channel-buffer.c
+++ b/tests/unit/test-io-channel-buffer.c
@@ -43,6 +43,7 @@ static void test_io_channel_buf(void)
 
 int main(int argc, char **argv)
 {
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_init(&argc, &argv, NULL);
diff --git a/tests/unit/test-io-channel-command.c b/tests/unit/test-io-channel-command.c
index 964418b5cd9..a5d6becff73 100644
--- a/tests/unit/test-io-channel-command.c
+++ b/tests/unit/test-io-channel-command.c
@@ -124,6 +124,7 @@ static void test_io_channel_command_echo_sync(void)
 
 int main(int argc, char **argv)
 {
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_init(&argc, &argv, NULL);
diff --git a/tests/unit/test-io-channel-file.c b/tests/unit/test-io-channel-file.c
index b597350dca3..41b45e23f9b 100644
--- a/tests/unit/test-io-channel-file.c
+++ b/tests/unit/test-io-channel-file.c
@@ -337,6 +337,7 @@ static void test_io_channel_pipe_sync(void)
 
 int main(int argc, char **argv)
 {
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_init(&argc, &argv, NULL);
diff --git a/tests/unit/test-io-channel-null.c b/tests/unit/test-io-channel-null.c
index b3aab17ccce..d27a389a061 100644
--- a/tests/unit/test-io-channel-null.c
+++ b/tests/unit/test-io-channel-null.c
@@ -85,6 +85,7 @@ static void test_io_channel_null_io(void)
 
 int main(int argc, char **argv)
 {
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_init(&argc, &argv, NULL);
diff --git a/tests/unit/test-io-channel-socket.c b/tests/unit/test-io-channel-socket.c
index dc7be96e9cd..fd9162aac41 100644
--- a/tests/unit/test-io-channel-socket.c
+++ b/tests/unit/test-io-channel-socket.c
@@ -566,6 +566,7 @@ int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6, has_afunix;
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_init_main_loop(&error_abort);
     socket_init();
diff --git a/tests/unit/test-io-channel-tls.c b/tests/unit/test-io-channel-tls.c
index 4e4034af67b..661fdbf7434 100644
--- a/tests/unit/test-io-channel-tls.c
+++ b/tests/unit/test-io-channel-tls.c
@@ -269,6 +269,7 @@ int main(int argc, char **argv)
 
     g_assert(qcrypto_init(NULL) == 0);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
diff --git a/tests/unit/test-io-task.c b/tests/unit/test-io-task.c
index b1c8ecb7abb..60e09ef14b0 100644
--- a/tests/unit/test-io-task.c
+++ b/tests/unit/test-io-task.c
@@ -282,6 +282,7 @@ static void test_task_thread_failure(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&dummy_info);
     g_test_add_func("/crypto/task/complete", test_task_complete);
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb90..79d13f0139c 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -306,6 +306,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&static_prop_type);
     type_register_static(&subclass_type);
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03f..61c6a9ba08a 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -83,6 +83,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&my_dev_type_info);
     test_init_machine();
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 1b6450e7d8f..412b151865a 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -1566,6 +1566,7 @@ DEFINE_TYPES(smp_machine_types)
 
 int main(int argc, char *argv[])
 {
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_init(&argc, &argv, NULL);
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 52eb8966b3f..a6931fed19a 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -806,6 +806,7 @@ int main(int argc, char **argv)
     qemu_init_main_loop(&error_fatal);
     ctx = qemu_get_aio_context();
     bdrv_init();
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     do {} while (g_main_context_iteration(NULL, false));
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index df1fb4c7780..e32417c759d 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -1626,6 +1626,7 @@ int main(int argc, char **argv)
     temp_fd = mkstemp(temp_file);
     g_assert(temp_fd >= 0);
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_setenv("QTEST_SILENT_ERRORS", "1", 1);
diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
index 2f447a73fb8..2eb56549c86 100644
--- a/tests/unit/test-xs-node.c
+++ b/tests/unit/test-xs-node.c
@@ -857,6 +857,7 @@ static void test_xs_node_tx_resurrect2(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
 
     g_test_add_func("/xs_node/simple", test_xs_node_simple);
diff --git a/tests/unit/test-yank.c b/tests/unit/test-yank.c
index 9fc86a21282..23c3acf6eba 100644
--- a/tests/unit/test-yank.c
+++ b/tests/unit/test-yank.c
@@ -202,6 +202,7 @@ int main(int argc, char **argv)
         goto end;
     }
 
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_chardev_opts);
 
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index f12fd3c3e81..25f054edcf0 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -359,6 +359,7 @@ int main(int argc, char **argv)
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
+    module_call_init(MODULE_INIT_QOM_EARLY);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
     qemu_init_exec_dir(argv[0]);
-- 
2.43.0


