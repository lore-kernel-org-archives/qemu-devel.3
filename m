Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D5FCD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsaW-0000EB-1S; Wed, 03 Jun 2026 16:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZt-0008Co-J3
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZo-0004JJ-Uw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Gj9d92260700
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+qHsgnZ0B7f
 DiRoqQQWP3yXm2jFq0UmJZ5nbSad2ncc=; b=BNKRxdBCqq8Y9WKAkBM9399KKJO
 lzRKgaZdE6yBGnEO7lWPw9jKnbEwpifJhjchoXBUgVop+uPPTd4GU5yJDvaoF92L
 4d0iSec4tkbsQ3YgvgPMsfUeVlXE54mG1Q4czfOtCdlY/CH3nlrBjjpkTlWagfDk
 n5ZTj3Uve63YFd+hWivOcAcjoqmTJfot0iM9i6CZkyWK2xFAIr/sMLeGkCinBc/J
 9mo673vs/uYDGp2k7xlFInCLjydtkP8WFXT8nSTN8yOYYUcoAfwDZSav2DUvrYVV
 5BbugtFcArWrA2QbB+as5pilCaczxJueexdV952oOsirXG0EHr3D+T5sGeA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mh0ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ed777a96so756393eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519950; x=1781124750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qHsgnZ0B7fDiRoqQQWP3yXm2jFq0UmJZ5nbSad2ncc=;
 b=kB6ktttQVxASQL0P+MsWWvraHGtWlONiGI5BvkcRrcG3dxalbVoQniFAXflISZ/r6p
 U1y6l4B61Dma4Ym8a/hn2OyrZUzXZZklEhHev+/4dOnapI5j/s1CXtgcydK8xWmw93tn
 Gm6oHcIn3PzUGqYvpGPrz0iYOj61CDP4K/dSE3yKsvXGkYM7P60nQaklN3lCZpNZ+CWV
 sGj3f+9ldFF6HZ99yExghaCR9W38tGPAAeFX5s6+vyB77M9bbBOwn+x46CdvcXX2VkQv
 g61E/u1qTp3h5zuIJRPv+DBD7VTvIoqnNNogx/aHywbRnor7lYsLSKRloqpW+Poi0Qbm
 5ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519950; x=1781124750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+qHsgnZ0B7fDiRoqQQWP3yXm2jFq0UmJZ5nbSad2ncc=;
 b=pUKxm2j+/K7KIy7wArWSfINRA6VeBuNaYkcbrLrK41dll28nWTao1wqzzFg0xFUI1Q
 D9gE+7izmxIpk1HdWoZwwpp/eaxMPxxHLVvXP5/3STwPlvh1BchFC0FQ8NCc1HcccPMH
 E5J3EcJeAtOhdO80ThOHMYv1Y9IU10J/2KLOeVJB8vGL4tAtNOO8VxdQhwYXat3lHu+M
 6c7WiWFGq/zsuwrlerZIEARyFljtxQc12xoDpyAWvhx2mwbOwVEEgseUWfwjctI7jKx/
 hbLLVc6ZgTL1i2JxM5QAZVl8uHPugw7koWWhIza7L7fxXXUwwA+S3XTEqjlNcQq97fZq
 dr1Q==
X-Gm-Message-State: AOJu0YwCTFC+FuKpF+YpuZcLt0u61Wq/9Vw3jxuqdhiuADzel2sX8aSt
 1TdmvzTfJSWYYUeC+P8sSrGUASB56p/BlCBkLYAZR75FX12Gpj+7Ts/vIE9c2bwG7/CUcu1pOtx
 2cc4IRinj3H5+nFbk7rMLj8FjkUqZtms0uPaBWPgULzMYybcKZ/dVKEv78rnjqDWkEHNU
X-Gm-Gg: Acq92OEfKfqV5YvKVFPk0ZJxrFQJmI3SDQ6MzRvoE2aaAviSzkhyy3JFimOUF3qSO/i
 Lz+Qc7zgdcSG4OopZe9UTdrvEfCy7G6SE7IlKSZS49Pif4qrLf6SKQTj7nFDYfaxd9WMJysugoR
 tIlNs38J7Uo+jScKY3z17+VfECOX/d3TP1xtLNB1CTvb+yMKr5sDsumpI4ybxMiHstiEDByhn0N
 F0EnpUumEcb2An1B41y2ElH6F3ET/Q5GEiu8CeRiKzu5M6a9/ep16+aUPfO1nJXS32ydx+WrzdO
 iD4lvwHGcQTOMy1V1OO20fFajEZNhr701djdx3+iFKaT+PLTKd0+5LSctSRheaAgF6CvJIzPlGK
 BVjalKbw/78lD3l7uheBY1m1fMJ2hAOxDD02LF6rki1VmH6MF3j/aDobN7Gca8DNw6z0AMNQ1NY
 95a+UV/ZPzxFW96dg9
X-Received: by 2002:a05:7301:db18:b0:304:81b6:fd51 with SMTP id
 5a478bee46e88-30761d44422mr321025eec.6.1780519949820; 
 Wed, 03 Jun 2026 13:52:29 -0700 (PDT)
X-Received: by 2002:a05:7301:db18:b0:304:81b6:fd51 with SMTP id
 5a478bee46e88-30761d44422mr321012eec.6.1780519949192; 
 Wed, 03 Jun 2026 13:52:29 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 22/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_ret_cb
Date: Wed,  3 Jun 2026 13:51:49 -0700
Message-ID: <20260603205152.1440291-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BYYKMW8H5binOXqhnhtq0rNlOAT_XpNW
X-Proofpoint-ORIG-GUID: BYYKMW8H5binOXqhnhtq0rNlOAT_XpNW
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a20940e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HFGiEJlbZgj7dAjcEtYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX58+2HEKNy0lG
 0lADcAukFPeQRy5tXl+wo7HyeXJkFD/8cv1jUv5aEn2w1n3ry2RXPpJRGWgebr0pIXklUtoUNxe
 oNJu64Ujv0IqRjPBpYa5x8pPetFKFLFZonUM3Kn41/o/0fJrWGCQU4CdargoYsaBpXJmhU6sJg1
 5uoZPLPpRelOQ4tql9kVdl6EOmCEkKu/ZPiXL2Ekst5P/WKaMND5NdTeTCyUxImUwkEnrtfL9t1
 y3iDLpgEpk21ttF/knFwBBWZ3rRlgtltC62XlSHN1OCPNga7R6AlheAIlkEDeTIhL6nizM5oR+D
 rM/f2zTjiWTdClQ0K4TtK/uIbWfdmzCJ5v9Qd680JnUoCujRN4EFGtFWyYxW+Mnmq6J0yX3iCtX
 o0qSKWrvNpCJBovfgtu1N3Lz+JualIrv1chMWdYsRdAYWzLV334/5RjURL1W+7WfEwgUpFlisJD
 Ymw3uHnq16iAVAJAYRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
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
index 887267f8174..7a58fb537c9 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -557,7 +557,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
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


