Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB300CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsa8-0008L1-QN; Wed, 03 Jun 2026 16:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZj-000853-0N
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZY-0004GI-Ef
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EbXSd1476538
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=n+kWYTH6qpM
 j15+EyZjW7Wg8K5k7t9ZwT/3Uje08PSQ=; b=Pn/Vz3H/LwgXlsandEzMSPy1GKG
 6FgJDGf22AGv2Ht+v2FdnI0p7hIpWeSdP01J9PBjtrstW7mHDnmsE2wDwtm2kNgZ
 K7ZgMPbWG6VMRB43KNu64SYamblI+XKdec8+Wa9y2DZVhRd6U9dsuYdkk/G5MOfq
 AP3vCaBlGB+s6L3GTehHEU3uOJYjcTty2dnuCeXwTYVW9nLetE0mxEfUZr+NnQep
 NpJ2egnDtHwOECEz0b20KlsCXyUX6ylx4sRJV8DAS0N063j/ROXeaLU4jNn68Ok5
 G9B1SDMsHTnp5Hsjq8OOx/YKuZGdOIbM3ngeqrjHsVJYIu1/W4FjMe9C2jA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nsmxc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so12087636eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519938; x=1781124738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+kWYTH6qpMj15+EyZjW7Wg8K5k7t9ZwT/3Uje08PSQ=;
 b=Ea/dhwjItOMLO2ZM4+VAd/mf25abdx3PfHMMRgqBFUkDLHDewX/Tpeh8kn9MbLk/Gg
 1b0yqW+Wj3cgfZuWke7pfWQnuoRgxBakD+L3SZClUz9S5oj/UuRUOTzPt/jHxdM+kZiE
 uzfCb1KPU3UDTyiu9bgqxZVT0hdfqclEIwmqavOUH+Wd4jq2X6GC9XWlOU3j/9jdBBM/
 jVJMa5R6EYlxsNLcP22o44MwjYre4usV5agG1Ycs07n0kLTD9VwHeF+JB6PQyYOgQqDm
 CDHL0WfQLzcEWMBKYzXiMoHLpmppCUgm8jKeR3TF1eVaI3qieXhbk8NnevkjkFOqtI8n
 81Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519938; x=1781124738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+kWYTH6qpMj15+EyZjW7Wg8K5k7t9ZwT/3Uje08PSQ=;
 b=jMGEc6xFKmlPFCJ3cXxmPsmZDxUVBwKJDnUUeZmVMaH4EHomsFjA3vM2HGO0aD38Aw
 LBuI7Hjdy6EeyeU+o58S4+4p6J5TDwLfPvEU1Rj54BSk5EU54JYUeQUM1ij2+ukA11Dd
 5FCyk7puzq/mEP18F52WiFvzxlPh69jUNrrTguUNGEjfZNZKyIbpTifLVISlysopQN4c
 pweVZOnufVVmXN/UX4vWkja+foJ0Tvc6MkMrgJawFUE24ufGsL/mUlLS41gClrf8x0Qi
 oHQrQQNMNeAOZcmzs6xWqsXcKvbq7o+KkUobypZDSlDIDSh9qVbyw1klx+ZCXVzRX+JY
 q5Ow==
X-Gm-Message-State: AOJu0YzxvJ7ojRALK2/CJgkAWtXtY3FgkKap+CbxCHtdCl3XsvWdZcM5
 I2Ljd+wX1HKD8aNjvAu5RJdGP7KXw5Qja5giBMepHfY8ZDl01pqKArOdH+2gemB3POUT7etAgbF
 IOgETX8JN5B+BO7F59oqwc73IThIsfjgk66xe6o+8GNTLIYhNkcsYTXR8+l3bYKLGGtIP
X-Gm-Gg: Acq92OHNkkQ2woPQzcg8+rNTfbaYq2FiZw6l3qxrk8hpiQvdPQGZsneIVGkA+AMpmK3
 c4hOiQb+aYgM3tjZGkvXntsoQmmq2qkSzupF2tF8lHkKTfqVBL+SuZ0av0ahT0yunxAnRzu6RXc
 ohpIiT8HjJU8tZqshj23XcajrVXCbWQlUCT/wEGhy7Inwpi0KFVFilR1aGcCDD+l9f0JEwKBKhB
 R2DXqLUkfcg2mUrdSoJY8IIhKy5wkjamhoBUeKcdepFZTt4YuC0t/9XnjGI8Br8VeTmRLEfroUS
 slocqpsLjBl2sPCcxje6qOhwnwu1236Mto0If4qItnd5PzkTnoUYjGnSLZ/qH5T60Xh7+U8duN9
 GT9Qvoxt/muvE2ZPnAH9yA0fJ8qPgtwwWNTTuq9PStaj0aX5JPbl3Kx2M0b4RPhsYfpKmuRKzg1
 /t5dkOQGEU1PkhOSUO
X-Received: by 2002:a05:7301:1006:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-3074fbb703emr2129603eec.25.1780519937876; 
 Wed, 03 Jun 2026 13:52:17 -0700 (PDT)
X-Received: by 2002:a05:7301:1006:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-3074fbb703emr2129492eec.25.1780519937322; 
 Wed, 03 Jun 2026 13:52:17 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 14/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_discon_cb_t
Date: Wed,  3 Jun 2026 13:51:41 -0700
Message-ID: <20260603205152.1440291-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: msPXHma_3TJsR-VK_BtBhL0iqS1r7xVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX3/bzZGDYUhgq
 2uM96DJSZXemxXfEDFLsrElfEF7RH0W4n62qzx1dw+YJG0YpjGCDhgV+dbW+DSjvndWLtf1dOW/
 HAv/wSU3lfo3IFIbdDROzdONifOmoh+qaUfMUCrvCT/5H8XGX3CGvnQ7b1YFyYrfgzAz7ZXbx3X
 SSjj7nF+fCHhes6kR138f0DQpmbcmj2jgh4MiC2uN/32QCmMW1oUPKZVblSrcpL+6Ore8T5I2Fq
 ido7IbLBDBW4Qz6x7OUDINGvLgPAmQo25ryNRI9pho0PCEyQHqdmrN/HEukhgGLPImS5CfSyivc
 uk9wvoQkAtg+IYXoT0EuXKkWW2mLX6GgGPAyyJiqfnRNMNhDOZPjo2tbkRlwyehqajWrSz/EBRE
 RKWvzaeS5l0lBUXtKY26Bpatd91oUqybWoZDIA6fPlW6lmatERGJ/VG7UpWrmywpI9hVT9p3i8M
 ECzIQGEjl88RVBVdskw==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a209402 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ZiyQStk_4VnRclnpaacA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: msPXHma_3TJsR-VK_BtBhL0iqS1r7xVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
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
 contrib/plugins/traps.c       | 2 +-
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 2 +-
 tests/tcg/plugins/discons.c   | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index 4d59aa3c09d..b6df4455d63 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -23,7 +23,7 @@ typedef struct {
 
 static struct qemu_plugin_scoreboard *traps;
 
-static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_discon(unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
                         uint64_t to_pc, void *userdata)
 {
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 03e7b2b1fb8..60d27d8d9c1 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -180,7 +180,6 @@ enum qemu_plugin_discon_type {
 
 /**
  * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
- * @id: plugin ID
  * @vcpu_index: the current vcpu context
  * @type: the type of discontinuity
  * @from_pc: the source of the discontinuity, e.g. the PC before the
@@ -196,8 +195,7 @@ enum qemu_plugin_discon_type {
  * observable via general instruction exec callbacks. The same may be the case
  * for some host calls such as hypervisor call "exceptions".
  */
-typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
-                                             unsigned int vcpu_index,
+typedef void (*qemu_plugin_vcpu_discon_cb_t)(unsigned int vcpu_index,
                                              enum qemu_plugin_discon_type type,
                                              uint64_t from_pc, uint64_t to_pc,
                                              void *userdata);
diff --git a/plugins/core.c b/plugins/core.c
index 54ab3bdbedc..3c3212aedda 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -122,7 +122,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
-            func(cb->ctx->id, cpu->cpu_index, type, from, to, cb->udata);
+            func(cpu->cpu_index, type, from, to, cb->udata);
         }
     }
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index 22114830fdc..5ab645705e3 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -96,7 +96,7 @@ static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
     g_free(report);
 }
 
-static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_discon(unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
                         uint64_t to_pc, void *userdata)
 {
-- 
2.43.0


