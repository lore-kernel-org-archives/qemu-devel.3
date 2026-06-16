Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5252CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYl4-0005V7-BL; Tue, 16 Jun 2026 14:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkm-0004l2-0a
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkj-0000TU-SX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOSTt330734
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yiVbwioTL3y
 e/4BGE87zaCpYjIA8+N/nxRR1dbBuLUI=; b=Q8ymY2TYWQMDJ7SpCsmU/V3Gy0N
 e7fkPIX2A/g7SDFCvrQy0JRN06GGbeL+IiFYM0jQkLK40cbk+vcHGM4PYwyfphkv
 6DJHSyV34nJKKucGGN1bA2DmEkGx7C2NOd4CiwfsZPY1IvShZi/attIf2C/oFfe4
 AJH7C2/IsfHfmzDbp9YadhDJ7ZTl0bogbq3XTwIpB3UpFqk9CtEdjMReYcX7M6Mn
 Gp5LvR+oVsBpqx35/QzGXNpPAu1i8wIn3qk1s7gaoFLX8Z+dxfZwNCPRdEo70Rwu
 Yvfh5npawHzh40KE2EnlAKjf1vhd/k/4X8zQnhYrxEDRSB1xstHZVsmm5Mw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gbku1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423f544944so3413749b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635380; x=1782240180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiVbwioTL3ye/4BGE87zaCpYjIA8+N/nxRR1dbBuLUI=;
 b=TeYseXatNGyTizyfsx2ws1n8fTZjSYMZO1Gvb45vcik3S2IEy/7dFz6sB+/cO0NGfC
 QTQ3I0R0nrSDk8y70wooE7G4gKHMzskqA2ZrlcXMrdbRUXL+NgqkjHefcXUVTpm+QDeT
 aEY8psqsMKGG65+Y6GErQBeZj+NXptQrr3ft+u0sp21EOmGvnqLDSgW2SSExcmxkaX7C
 d9KKXAY/U59Y5sc/8RUxpl1mjAUtsbFgicxDolJQx4DtpVNKtvQ11Yyavflw6PNShE/t
 +4j0AleLC0S0TKREt1F8p5s7S6rqySD1JWhvqP71sqr1Oc+sza5FIWfz1j8/6ODU3t4Z
 n7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635380; x=1782240180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yiVbwioTL3ye/4BGE87zaCpYjIA8+N/nxRR1dbBuLUI=;
 b=NIF3RDb0w+R097JKO/oZNPqq9Y/3SQ+90Iy3Pc2Pd0rPYkWy7+jQ3I9Mgn9k28C+1N
 V46MKXMpAvbvLjFNcmkOyTrzMwUqoBWuivNwWxt7YAtNbAtS+qOXo7OPWubzfoWFPBh9
 xxt6W45TP/CPKwGCX0p7YykHK3Qce0P6VgFCB4DAc/pOvU47BjtneY8BewUS1c6x2+0g
 hP464j8DEP95z62wRnG3LuT1+cSIArxwHEFmru8/oiTACKgtfUJ0ewI7jmhooF1uv36W
 jDjvMRhx5APfq7AA02mq7gXCaUDRF0xmkDH8Se+QJ1XcF8pwRutdWHbU+hD3lT5lS/8E
 D5+A==
X-Gm-Message-State: AOJu0YwvG+Y15diL9V7Mg1+is+6Bkep13Szk0cuhFXwWUbein/KSE+Y9
 YVn2sp4rPZOjLyKckECJ2M7kousBKfqAjpXDlqgUUb2xBhaH/9Cajgc2sg9mrhN8Zxl2RzE/gnI
 D3YwbtTuhLNmrVhwoK1bGpXgwTMo1CqPS7A4N/5RHv0kiAgfoPCS5w/PY3WA54Sp/HCKP
X-Gm-Gg: Acq92OFhSbsa35UdLDqZfIVoTsy/lzZCgVFu7g9g3/n70RoHIYPyhwthT+Tik7jg5XZ
 x4AxHdNPzSWj3IYe6plSzH+j/QBmqUqyFVetqPkOukMKkoUPfBAsaC+lYL9Ka3vt9YCahv/zq5j
 XJEMPWBrBT/HyP0V/CRVrJmj6+PE+1jB0vz22lYyvfGMoOTcthRmRRFX2w21mHvVC9Srn6AkeCc
 UVsjz3jgdGU85ol3d+XeQYrpvGD6skQfTgefvwD92oDO7SY18a2qLovbG5HNe+0GYkc8CskT5c7
 tVKxi51ls3WmxVNutA51g/EL2K9BB3YibtXg1JIN5S6UIrU+WWDVi6q8xl8RccRhfTNT8CZOHne
 8L0b/MXLlHN4sdux1LvHypugmIqVbCUuuVZ3I9FjP3s4+T6Zsf1ivbi+pwdsFUawrmXvFQiHUpZ
 3Mzs4ih9w=
X-Received: by 2002:a05:6a00:8014:b0:842:432e:b7ff with SMTP id
 d2e1a72fcca58-845244820ffmr337573b3a.17.1781635380142; 
 Tue, 16 Jun 2026 11:43:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:8014:b0:842:432e:b7ff with SMTP id
 d2e1a72fcca58-845244820ffmr337553b3a.17.1781635379690; 
 Tue, 16 Jun 2026 11:42:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 20/26] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_filter_cb
Date: Tue, 16 Jun 2026 11:42:24 -0700
Message-ID: <20260616184230.303038-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX3TA1EwRW+Pw5
 PIClBCB+zR2uigtDAue0Ao62OZjRkKx7UScYnVgcgADav1BlY0qhMV9RZVoaLuKteb1MuoAY28x
 uA3+Qdmdcz7rPM+8suRtf+48sYdb5xKlWVGBS5njCic6C6vFiUEfgHc8S471sEi5dbp3gzmk2Xr
 9BLmEqZSvyPaxCS5JkbBXgdykZGfh/3LWeK9rBmAOFZgzK3/elOFs917rw3V3X9UK9yBL65gadT
 yVUFDpIFDTqg9fW9Txn6LEgUoD1AhKROVUVrgB+UWGKV3cUnqy2sEdc4RrQmqlqn5CvF7CGo9pq
 O8xZ4qlIBKO+IXU7sNhk648WSXLk0tlC/JyvohscJgu5heSpLIgQkU9txhZzw+kH27WYQo2ZgDP
 bAFlD3RAzMthBuqsWwaTcOZQ9+vQg2hZFH7FC2BSe5WhTYqtUc1nnUhB5Sh8NUkvMpxMgDP9YqV
 VduWRetITO/i5VgNu+g==
X-Proofpoint-ORIG-GUID: Q2nxNdfZaDWe9ve3qzQCllBnkQp8H9mm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXw2z2K0PWRyOH
 zFGlfCHEca1v21hqSHsLKU2G7WUNYUG2/VzL4Z4HfHwhIUiGC13musNXhDC0jEhj2FzccOjagSP
 s+2sPWX5kaZDYiZ5iYHOK2lgKdGuHdg=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a319935 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Rmn1aRlouh7kj9PRvo8A:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Q2nxNdfZaDWe9ve3qzQCllBnkQp8H9mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-21-pierrick.bouvier@oss.qualcomm.com
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
index 223a30cb944..49fe1b582b5 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -591,7 +591,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
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
2.47.3


