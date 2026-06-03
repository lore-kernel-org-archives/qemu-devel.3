Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012ECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsae-0000Wr-S7; Wed, 03 Jun 2026 16:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsa0-0008HB-Pt
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZy-0004IR-Sy
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653KF0Aq1740883
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dtYli/cv0Et
 LiTk960i6eZHYKN3lSoJNgps2z3Cozcg=; b=ItzDSgsl2EI44MGONlBZODywYpQ
 zZBOAXt2XpirbAWAWOUBNu2Jfn5l9Gm688rZPOqtGX/yV7tbTw5rJ+tWGNAzMb36
 CkbnB+3a4DWpHgM1ZRPc0HUHK4Gzuj1ysVWBQhK75oosb4Pn2UHKRil6aBptjnVe
 a/NBx6suLKEXp45e9ODVLI+KMYRb9JocfISVxxCaok4sbdFviZscZFwJsvPg1Lj0
 qDfojkBrwNQ2nytC1Aslj5OeT710fFw3uCUadIE8H7QcXzZ3Tc3tS4REIM+0eGnY
 yTAvDtB4No48tyfV+MfDaca8x5wcJklHsKs6Z1D5XiZwCOqucxbqM85QAOA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7uyd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e4636205so17097360eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519947; x=1781124747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtYli/cv0EtLiTk960i6eZHYKN3lSoJNgps2z3Cozcg=;
 b=cChZORwPxI8YB1BhzSoUjNns2bTixhArD0KRtiGLv5oDBeq/XcHZ5T1ke7ny4jQiF4
 AzeOp+84oB6Tk7jz0VO+4wwGVjlZ7V9m+nhyw4zM3iJ4ILkfnV3xejaghZoMpSqVn6ZU
 ayYnbBzAZ79OOud45qzJ4bFfZK81WaIHonJD8vZnSrSR21Z7uWCRXMOSw7FP+hQbN8nL
 /WTpXq4nSWSqQtklfKaNxfJ8EtPvAVxjys8elWOK5WtRF9VGg89bBAIMcZJlu1Tq9aQa
 b2BpIN5nq3bqO4NeXR8O3fL3H/zLwP6hoHXOr8m//B319izH86zorEdM9hDUeTFrn8sM
 CiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519947; x=1781124747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dtYli/cv0EtLiTk960i6eZHYKN3lSoJNgps2z3Cozcg=;
 b=quOB3vXrcECmxezl595DWBzarawOtdwPDLr4uQGBKI3FVlulhYj8g6hodZ1vjnmGHG
 4U/u01rLWZDh6KFR+GzLbmrso8grgv3VDwb2F2hueL7jo+4amLEGJ9sEuiF3y7UB20ZO
 dTSPKWEBO7AEF2zzmkOrH9C7oMUtQ+yaI+VNcOy93He2dD7qiyYaVFpm7+HAQ7ohS7cf
 rQAzZ5ClPilUFaTNnELsU0jC1Q2uKddybbBcsmKiNbtm2Jc/SeYtM/j7wNuuBp1lyiNy
 ul9u2XDInQhZ3PuWKkU9kpT4vW8V4dOmdOuYiiXghIcjOSag4pvEEzDUrflCOkM3BjF3
 O+sw==
X-Gm-Message-State: AOJu0YwyqH/Qz3Eiq/NKlv/3RGnZQ/8x/kXEWSs+vV+Zlhp1pefkA1xI
 mpb6H2RNtM6zmRUMNJYSctQDGSj18bYkHO9XU80zQb49w92mIGWlkVDRj38dMqnw8AubhrEIAmZ
 UpyDE1H/q1KBqRvhnGzIPtK84tm4mUMvghCmhwBFlrGf1m46xrkmy51bv6dNT9XswbNCF
X-Gm-Gg: Acq92OGOGcTvow1uyW0YyQxalityrCA+cRwFYrfc/eKJjJlYVtIjTfwG8es0bnsXnXf
 cIXs/2e6QmOWoscVd1rchFhznh4GX/09h0o2tK7uZ2fo+Gu75w0/J0TRupggz19YFvsvcug23qb
 CMKO19GJfclPFbdMTBsty8NlDmoIX7j05JRnWq98S/tKDb7pJAjz5sYoh++3/oZ7gmxFrWkKaS3
 dy7CXpFbzXSArpET0V0S91WBJhru7wy+qYadq6KZpOBZ6QDmgzObtMUT60reQ/PKu8CEfwlaXtP
 +x/TADG761SNIxAViH1Q6Whvbjnydpz+0r58AQjJ5VaMtXOIjitEajTCfRL2svxJzxNGzBQ3fUK
 z46uWrlSiebMfUZ5u1dS1Ron3YcY/VLtS1xx3eaAcyCpSr5F/WcMk8/E32NFeC5C7snwsH1vo0w
 1NGjkmJXo7DAfgMSzo
X-Received: by 2002:a05:7301:e2b:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-3074fcab311mr3011983eec.35.1780519947209; 
 Wed, 03 Jun 2026 13:52:27 -0700 (PDT)
X-Received: by 2002:a05:7301:e2b:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-3074fcab311mr3011958eec.35.1780519946458; 
 Wed, 03 Jun 2026 13:52:26 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 20/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_filter_cb
Date: Wed,  3 Jun 2026 13:51:47 -0700
Message-ID: <20260603205152.1440291-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX6bEYRQb0dgR5
 Z/ugBJh97mmKPfiQxt229r0zZ2Oqs909Mj2O6b4GpvQi3qtgLytM62Oo05Gub283/Ky7ReHwkTl
 20RY28poW3Cv0wQDRzWNPFQtLw2rBwvm9gQR4B6GVxrbMVLreO+Qw1DQSS73vCwbPx5KR+e2Hdi
 BET/mVlW+joyRnRoKLCu1edjP50noJRZbGpB6/jcMoMvThLYTC9OYvvmt2R8Ow6OODOL2CQpW00
 09qrLC7YtvfaA0wgwOiFr+UtURmIYAcc1Am69WDgARXXzfqprp2XHapbX7kTjxLKJNdPoARHMq2
 zzX5/a9oezyTtlY8IlQ4e00hOSP+0arPRNJsXe0x9LTMdI2z9nUhsggitM7tERwaq6ifEW2Q29p
 TeHb/lmdmGeTIThLDI9KpqOfOmmd1lCr/MldaTitcN4cw8ZE/SH+xYTZP3MYXz4JrJFipQ0KKxD
 4HcPqN4rVKxfck3SzgQ==
X-Proofpoint-ORIG-GUID: zCiZ_qFLdOCEEflsTlcOtGn52kpgZfF1
X-Proofpoint-GUID: zCiZ_qFLdOCEEflsTlcOtGn52kpgZfF1
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a20940b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Rmn1aRlouh7kj9PRvo8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 4 ++--
 tests/tcg/plugins/syscall.c   | 4 ++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index c38ae7db1b3..33d6f8e0b7d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -863,6 +863,7 @@ typedef void
  * @a7: the 7th syscall argument
  * @a8: the 8th syscall argument
  * @sysret: reference of the syscall return value, must set this if filtered
+ * @userdata: user data for callback
  *
  * Returns true if you want to filter this syscall (i.e. stop it being
  * handled further), otherwise returns false.
@@ -872,7 +873,8 @@ typedef bool
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
-                                        uint64_t *sysret);
+                                        uint64_t *sysret,
+                                        void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
@@ -906,6 +908,7 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
  * callback
  * @id: plugin id
  * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
+ * @userdata: user data for callback
  *
  * This registers a callback for every syscall executed by the guest. The @cb
  * function is executed before a syscall is handled by the host. If the
@@ -916,7 +919,8 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
 QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
-                                            qemu_plugin_vcpu_syscall_filter_cb_t cb);
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb,
+                                            void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
diff --git a/plugins/api.c b/plugins/api.c
index a72cec541dc..f2176be5304 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -217,9 +217,10 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
 
 void
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
-                                            qemu_plugin_vcpu_syscall_filter_cb_t cb)
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb,
+                                            void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb, userdata);
 }
 
 /*
diff --git a/plugins/core.c b/plugins/core.c
index 987e49b89cd..fe292a098da 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -590,7 +590,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
 
         if (func(cpu->cpu_index, num, a1, a2, a3, a4,
-                 a5, a6, a7, a8, sysret)) {
+                 a5, a6, a7, a8, sysret, cb->udata)) {
             filtered = true;
             break;
         }
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 9bb5bf0f5f7..7c78f182f01 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret)
+                                uint64_t *sysret, void *userdata)
 {
     if (num == MAGIC_SYSCALL) {
         if (a1 == SETPC) {
@@ -99,7 +99,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            int argc, char **argv)
 {
 
-    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     return 0;
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 2afd71895e3..410fe617804 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -175,7 +175,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret)
+                                uint64_t *sysret, void *userdata)
 {
     /* Special syscall to test the filter functionality. */
     if (num == 4096 && a1 == 0x66CCFF) {
@@ -274,7 +274,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
-    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
-- 
2.43.0


