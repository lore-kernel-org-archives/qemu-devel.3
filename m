Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D89CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYl3-0005PG-GS; Tue, 16 Jun 2026 14:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkn-0004m2-Fy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkk-0000UR-Ig
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOqgA382584
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tY1o+stizUR
 ECalBslE/70IyflG64DiO56m5PTWttXQ=; b=cKKEV1F84rQQq12WmY4pCCx+Vuf
 u7H1dW3825AzNDg0kaa/UezovB/aRPq4bUEQQsySjXgEXXutlDVioj3/ibbcN2oN
 12VjDPaj4rRMQvg+DnHwin3n/+r1V7s00YbH+hyNLs0Ur0esHd3AXjLfklDQGuYp
 aSxt/2iT1FSKqUnCc+gHlWfwQ8vtUa0hQK8SoCV6kpVCn4N8nYy7+F9iBjcTF0ur
 Wx5v2Cq0FdNNC4rUXFnXB934kLJfZvuARztaf5MlfScQjteOF5tvyxeJd7n757yN
 J37uMrJuloLPCebZIS8XBvF2aAOCAS5MXZIVep4nJG8ooN3a8f0Q9CoZ63A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjfn3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8425a9979e1so3209040b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635383; x=1782240183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tY1o+stizURECalBslE/70IyflG64DiO56m5PTWttXQ=;
 b=FOjnn1mprr86XAlPj/HqJ1aY+B4h6gVxdunMmLqckemnUNPnjAnOBfl5e5ooP3PEtN
 PjJJMTs0MkFUs+v7MzQb93uYyLjalVnMJ016f5pJVauH/aZ0vdBbO1qxREvh/V63Ww5m
 lLk9E0oOAQwocGQ3aMfGP797MHf1RZ/CTyEQHZxRIiji+aUSK+q4JRDxw9/1lgc1hTB+
 H8I+aaGZcqN6TVpr2iCy29j23bF5NrLcCjHsNi1wRjXNuFfQH+IXyGMMXkL8vjuoh9kH
 hdb02ay8sCx32kf00hVWg9d4cc2CAbMsTlkWRJpOfrDNel4bNhgrmqj+2yMJaFohbdSy
 5J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635383; x=1782240183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tY1o+stizURECalBslE/70IyflG64DiO56m5PTWttXQ=;
 b=BL3a/ps8jOFoV70raRtB8TNaK3Tn9CSE/DvWd/4PUanxu4trLOoCa6RQ8TzYJKJxGg
 mjNRKLDAq/xXnJb/vpC79RdhpUdCNioaKahqa+sLltNoBBPDX8913I3DOrhCEIgRLZJ2
 F1SCXUffG0oFcF/3lK7xp4xZ0jpMBx50KrvlTCK4LNQhzd2GUXSsDF+JxRvUzLk8Lhnz
 lZ4djkNb3N9HzWcsj7p748TYeXD4UgeOlhFk1gqa4lz5n+UNALhvXrAq4HmiwuliZwbS
 lCzlWMiS+vtZJr9b2nXOCP5yo4FZEM3DTqU1S+BdrgPN7VAEX9cxbnTFNyv5+CK8bqSf
 XnAQ==
X-Gm-Message-State: AOJu0Yzp16ldAJsHHe7L9BBjfWm1D2d0WT9W5OowVuNJCPfqdkoe4YEQ
 Slw5bQ7PCoC6EMkbHBSG/jQVE1vJCGvANvthEEoMey5KyQQ4vNuzWdTcD5SHVTF3LVVGagWAJD2
 Hw7dw8B3CPrhQglSUQaWV3/bIetzvAdelnjUCbuiR6JleLvoV/xh9FnLXqFloojaeZDzY
X-Gm-Gg: Acq92OHQeDos8T/kpX1/Il3vQKt0O719gnakmAjDwhXu6Kud4eawVHAPpbRrs0T+4HF
 SFp1oS71MEdS8ZpInQVGmDbL8F29QAwUkMRw9/a1Ywf1hKtZotWN3rS9rOY5/qBywRo863RYZ3K
 3YuVUeSgJmNMsxr8s4R/9LWVAWEbzE5uJ0ef5EZs+/6E/XX60EACe7u3ZOU6bCDrqyl3Uf/jcUq
 zm+WR3jWBnsRWsiNgVP9Kiu5vIBGIVuJYG2lazPzQMsT5QlV8/mzUcjZIBlq2aA8gPyAo7Lt0jH
 c1fT7OgFqemmW8BKGU/PWqxkYPCONKU6X2IBrq011n3BqM4xb8V0baT/iO2s59ROGi8AOrkQqve
 zM9I3H4Ar71nrBwapR5jSBz7jo8Lv7qPf/6Nzvf03AourH7nfYdHa0QJQO94ZMILFSWYST8LyOQ
 ZfB6oF+OQ=
X-Received: by 2002:a05:6a00:3d54:b0:843:468d:7804 with SMTP id
 d2e1a72fcca58-84524575795mr359064b3a.34.1781635382670; 
 Tue, 16 Jun 2026 11:43:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d54:b0:843:468d:7804 with SMTP id
 d2e1a72fcca58-84524575795mr359033b3a.34.1781635382115; 
 Tue, 16 Jun 2026 11:43:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 22/26] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_ret_cb
Date: Tue, 16 Jun 2026 11:42:26 -0700
Message-ID: <20260616184230.303038-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qpktzwQy32Qou9wSK6r0If-zu92JlXf0
X-Proofpoint-ORIG-GUID: qpktzwQy32Qou9wSK6r0If-zu92JlXf0
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a319937 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=HFGiEJlbZgj7dAjcEtYA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX0yc4dpe2tsj2
 paVgsCfIgpW0coAuf58wL+k9tneyo0YhiJ6nyKMilEPBkkFeu8u5fVYSpJtwkBnn8K1TE89PIzY
 WpoBVuAP0JXq5Pyyaezmwcv2ZNtfak7hqZ7EC1KgOk2MjJerlenYMrWNtq2RSj0pAb2A5NLkCKR
 v4MUj/wqiVfVCP7Ff66bkGJLV+XOiRikLeuyQxRE20NmIP0X3Z1deQES+4u4ogAyorI3GTKZu93
 TjhFFCF541hC2YKMztF7at8cMhWu25I4F71R/o2Zfb4MVsxb84POl2VTyvi2kdOtnsaQHNgRNLI
 7JQy/XgDkVSK7ycXPcrCtTTXDMyF5NIJNZE0nm8M/VZvH43wgT2UBoi4t4NMOH9WjT2DKd9YaIh
 KrCMEG6x+uWZUqI/eq+HVr8Y7m0SpzNFEbyPZcaSMz6R0mv2ZVwsdOekHbbBvzjw04krAfZsvzP
 rGdN35qLoOWVrYoL/XA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfXw9DG1kTizUfh
 uGMu3bV7RlW0M66LlnpRfjUagYS0E62yRnjI3ylNbdK9mVwPBco/N3jAFKtOyfik0mSLVLK7pxY
 axXx2FGDvoFcRdUKYBK5ShA0OhPJLbU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160191
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-23-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


