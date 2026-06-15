Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67606CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD8C-00066G-6p; Mon, 15 Jun 2026 15:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6V-0002bU-I6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6R-0001WF-AW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ2IQx1245707
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YUWsPSzIcxw
 Ew+Bgs0V5mR5cOn85MWNM+dpapPEnV6k=; b=ZZ5Zsb4Vgqx1ub34qlTGBX268ND
 eqasLstPS6ltK0pE7A85/J7MDl75FCvydqlFzURy+VaklXeZKrdRMdPXI7OS4NDR
 F1+dY42hgcXxPFTl9jcqZsgjhNeQKj9PFI8MJAbs1UijxVoO16joAjHiJ40Jvgkl
 9p47hzI7JJSeTSyWETL0/VkIrGdaelyJJc2Z/NJ6GkUYwODo4kUXIta2mMicuz2Q
 I+BTtt6ybs53FKBzHALH2o3sRgl7RmRMkPIhEDkKebzIm0SS1LY/3sFYqKLFwdpM
 KkHF40ngTYfP96tuj6WOQa/M21PnZB1qDW+h8LaabY1msEUTybe8/1Acb1w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf2jep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304dd917645so7795891eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552159; x=1782156959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUWsPSzIcxwEw+Bgs0V5mR5cOn85MWNM+dpapPEnV6k=;
 b=A1cbvw0cHAfVzZ5lmWihRixHBYtJ4LT/Z4Zuu2/r7kR1GkzeBheVISERRWtt7wkmJ/
 V5B3PiYN4wF4KiUkYROdHTU9Pfr3RZqGEVZ2DMU20mf1LpORHxiG9XMLygd8pDptSGpH
 TRD/5WgQRqfZD8iODG7M/V685QW6Qqmk7mX5G5SYE2niC2IYlxbrQZNGqsLA/avIKJJU
 P2ChLD0cfL8iOJImQROx5FMa9ivueMdMaR7uMgADNuVwiJxHp0TK49A68ubszGLse9I3
 HmOUCsG76NLdvhIKNccQX0RXG0gWg4L78w/7U8akzMOG/7QlVp07C92SnzTiSI9vaFeJ
 uBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552159; x=1782156959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YUWsPSzIcxwEw+Bgs0V5mR5cOn85MWNM+dpapPEnV6k=;
 b=SsUfFpG6bvtcLrBen7fmOB9aCJM24hRftKSTfHTnp2cgt1YI0jIMBeLCbK4R2rtny9
 yQEbxBJ0ij7CIavyYz7PCYPuaWYrZnq1SqeSF3Lj2HUxJkGddEn2lrK2ysuSYXfG9dQp
 mxzOLvRs6jN+8k8M4Cd8bNjvMly7AxD9GO21vAPLGR2rCFzsc1FdIXOIRWIU4DAzwa9x
 9XxMi4+WwcMp1kbN7uA+G4kqF+agjbj0sfPVwoe0v2x0GPilqXsszuzkRzs0SRjmcBz3
 GFXddLRCnfa/ZXp9578BI+IyXanJaw/LXy7pmj3R+kvWtDSOPpWVThJhtE7NKPij8hY2
 JVhA==
X-Gm-Message-State: AOJu0Yx1NdKmGB+i73yR6soy2hyFgZ0ahKmuCmJpAKGNnAPc2/usmlnk
 WCbwqQL5mKiutFLaCse/TuLGGqYlJg9dTagttgqb1gfPLqqHXGNVmnpd2/MfjNJBLCtUx+yQ1O/
 pQ9pZ5CZ4MvBvjrTdElY+H1qhlcuiZRl+wCB2BykzFnrNZCzXPwLWkEmI7u5hFGPzsMx8
X-Gm-Gg: Acq92OENOqDvEg2k1MhrjXu3XLD5K/SMsJjzkKy+AomD7ONIS6BF5gXFE1Npq8GkCCG
 o2az/qdkEflW7PIWjRd7EmGFPrqfrinq3ACPecyFMCa+Q9aHb9CgtvJw/+jUJehBr4bAbBxnq/A
 Bp7uMYvvKiwBGqyMib/XnkisNE9khMrxnNHAAuryk/moX5tpwc0Gqv2L1fwuLov0VaHfIdGIeMw
 a961I3PXZivE/ys0KcB4KMi83S3HCNueDyxAj8KG8bgeEJsfoGN1I+c8MZGzpUbh109Ot+bb13O
 C4gF81q8lnA9hJQc6rINHpDMGJXjitaFAYGiNvMK8QXWLSh3/pHNdB8LUcEpQOyuqXXyh7lSgqC
 1A9yAT4zH76xJdXr5HwRImtWS1AEUqtAHBw0kWOLSMZyQnYg7Dsoh8qgdrLsUb+rFsBWx6uyA94
 AIxFQOAQ==
X-Received: by 2002:a05:7022:310:b0:137:ea00:3f49 with SMTP id
 a92af1059eb24-1384bb966aemr5905731c88.35.1781552159224; 
 Mon, 15 Jun 2026 12:35:59 -0700 (PDT)
X-Received: by 2002:a05:7022:310:b0:137:ea00:3f49 with SMTP id
 a92af1059eb24-1384bb966aemr5905715c88.35.1781552158745; 
 Mon, 15 Jun 2026 12:35:58 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 22/26] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_ret_cb
Date: Mon, 15 Jun 2026 12:35:21 -0700
Message-ID: <20260615193526.2883349-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a305420 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=HFGiEJlbZgj7dAjcEtYA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UMa8mtiCf8rT1FmzyqPFSO-rUg7LiJsX
X-Proofpoint-ORIG-GUID: UMa8mtiCf8rT1FmzyqPFSO-rUg7LiJsX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX7EKaDb2KZU4P
 yrNZysakACPoTCm/rrdPVk94wgf4hAtMd+xQtwotcWsmaUj8D4vFJ6zJ6Mp8HCqSIqw4kZeGM9C
 8JGiV1yAaMlHf12k7DzP7MByF83By+Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXzeIRnvqmzZ2h
 1QhvtNMs7aEhj2qKmE2wEp55An/SOvUk1Ocu0QX/OTHjtALCXzG51ZR4rP/Hg9jtrx10q1n/0mh
 xdNfih4LshrASXdvJP9zr6Q5hhUO+Xmtq01PUqxVNBaIx2sOyG3O8r13nQD9oLEOrbbHNAEsjnc
 tN9vVTQLY8Pp9RwhTqXvSSvWnbD+22FFxxQk1Ipr8FGq23Wj/yiQWXxRzjYUAhhVXOvUKTIVPLS
 ZsATZw9xrf09pE1Qpk/bF6xLF7kFJtBa9/OBW9K3/BrMuadAVl5AMiv236pFz5kSgPcmb2Wi42C
 FCt93BZTUK9FjA6Nf5GxUEvepwY2Lg2JK2tujZVjqARXTyH+dTPozs7WKhyIssyGWm/AFsrS93U
 1Nrl6Ne1LTNPdqDnHt+ay7SmL4uXclVWnXsUYNWHal2qQhro9M0w6cRrrPHg+lpAIaJ5PL4UT0g
 4l4gAcFSb+VYBxyC7tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 4f0c73c7b33..50a39e51d46 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -882,10 +882,12 @@ typedef bool
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @ret: the syscall return value
+ * @userdata: user data for callback
  */
 typedef void
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(unsigned int vcpu_index,
-                                     int64_t num, int64_t ret);
+                                     int64_t num, int64_t ret,
+                                     void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
@@ -925,6 +927,7 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
  * callback
  * @id: plugin id
  * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
+ * @userdata: user data for callback
  *
  * This registers a callback for every syscall executed by the guest. The @cb
  * function is executed upon return from the host syscall before execution is
@@ -933,7 +936,8 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
 QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb,
+                                         void *userdata);
 
 /**
  * qemu_plugin_insn_disas() - return disassembly string for instruction
diff --git a/plugins/api.c b/plugins/api.c
index f2176be5304..0038da6d706 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -210,9 +210,10 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
 
 void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_syscall_ret_cb_t cb)
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb,
+                                         void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb, userdata);
 }
 
 void
diff --git a/plugins/core.c b/plugins/core.c
index 0a18910f873..4b55aacd2d7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -558,7 +558,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cpu->cpu_index, num, ret);
+        func(cpu->cpu_index, num, ret, cb->udata);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 1bc737824ce..a28d1087840 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -152,7 +152,8 @@ static void vcpu_syscall(unsigned int vcpu_index,
 }
 
 static void vcpu_syscall_ret(unsigned int vcpu_idx,
-                             int64_t num, int64_t ret)
+                             int64_t num, int64_t ret,
+                             void *userdata)
 {
     if (statistics) {
         SyscallStats *entry;
@@ -273,7 +274,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
-    qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
+    qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret, NULL);
     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.43.0


