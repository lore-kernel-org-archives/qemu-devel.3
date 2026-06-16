Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C73CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkw-00058I-Fk; Tue, 16 Jun 2026 14:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYki-0004fK-5Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkf-0000Sl-OX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOYLJ382253
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MjXOHfx5o5R
 rTonUDljOc7syG8vIMcs7qBl+YmeQS5w=; b=a1bQtXYY3gL1xMCAQNivcKIkHVI
 YZe3LmrDI8bCpktyGtsF7Cs7H3d2JNxohsLZQTHD9ClZCtlvHPOtI2aJltC2xT61
 gRg7SyIS9+HUq19OhSKPsCapCG6H/Q3jLvrh3fMzysRRPw//9R8g9zrWJxf9/W0K
 LynwkJoVVxHSgVnIBM3eX1Asm2N8kppJbkQweP/RlwskVu9htZyRveQtbegWAQOo
 OAToQIDw2JTLfevYk5RUad7MjT459TTNWekyy50xPhPyLhDSLAa2wGeWLj/+Buyj
 dR107340ukyRfJHbFYvhdp4R/A9Rvyd5w7VTWfmBHnDCJbNjZSNnyQLPtIg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjfmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso5669578b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635377; x=1782240177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjXOHfx5o5RrTonUDljOc7syG8vIMcs7qBl+YmeQS5w=;
 b=Bw9LT7meK3vub7edd9YwINkcgkOS4eMXTsKjT6uudkwiPSjj4tGxAPBu9gC/5EZvnB
 g+hOvNzxnSBzJhXqyVnkS0G1Sr6vMJTvj/AuSv2oyGhfYyHZIFNeoAVGmyHcAynAcsND
 GDr4JLiVI7wfI+2/BBUhmjfl4jck+LTf8Cd4ID80Qk22N6azZZKP2Ef7fTogh+qlt43Z
 qDOXanB3jFTepZZrs4SRsJ5NZ3163i5jnJE/w5aFv0VkJ/ecdnROml4dTGhf/5IRaj4h
 z7UZs9ee+RlDo7dppWMRMB7A/UP030D/emOdt1GI84nd9go9EMu4+l7EvtR0r4Qm+KJi
 8sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635377; x=1782240177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjXOHfx5o5RrTonUDljOc7syG8vIMcs7qBl+YmeQS5w=;
 b=nRBQkieTNB1BAFGolxA4T64ErYGrPCIHYFZK04twyakrHzU3zkevws9a+Pth35t6+2
 cBLVmZqq8WshqJw5NHTcsto2j68bT6xnHMA8xF8hsIXAZ1fmaYfxQWbwdNQ8F4lfQ/sN
 SAkt7jgKn3riNxOhhasqVFxz7cJMzBpI3ldu8vEk6Wl4e3HJxybbTq1+z0mrmL2Y1Isk
 VCucd3GxHG2U0UzX4KvhAlXv+7RP0D+6gSSllwzx9nkZVuFYK44E1PrmvKvtqVKS0lZ8
 +K5SzAe2owqxBbTXwhvHwe0xhoxKRpfAr08DCAF8zgNysX3dCKqOTluNjtHFiTb4OdUA
 z9Sw==
X-Gm-Message-State: AOJu0YzMRoc9kZ9bVsDn1wCadIWz0KRO7V6hKHFfslIblKT5FzFxCEcf
 KLwGPipZ2nR9MlgKdyXpI7PW4aidpi00cdU6IAr3XVX4Ui4lUagIgVvGqMHfupxUW64nZqn9WSq
 AYdzHuLCLzzGbRbFAlHNllDMHuOZMipXnE+ScjQPm7p1qieJCEZg8HvdCjG/f/jSYv9px
X-Gm-Gg: Acq92OELuy3SAijfzguyW6abQs5X9PtGP2jclFYm7k0X/J4NbfnBL/gyyqDyLIVgLA2
 kmFg7rdT7fd5IWkIRW4BJmVhtGLT5S68quR15tEOwvnzosWzNyBfSILgOXg7kGsLFcKXumV+p9J
 ARIlqKAfCHL6eEr7pattFCz3smlqcCHc9vcBO3IPfS+NPc3InnaBYxh8W+DFKi3elB+/rpbwcc0
 yJYX5ehcELpoNTfr3ggWBBfU0+PzfjaKFJYo/jR+YIa9R9QWbu7/hhDy/5cWL2gSj1EibSFCVPS
 +pLT0Ekoao8dZikdOBfMmyq1Lyv9wzeTAqH3xU/86NmZDalvT0Gw2+b+izxtk24xNUfEHyFb+V3
 K4fETD6a+gA4dK7xjOXVfp/PlR+DWsoIieChPlB6vIShzguMn0ytQOmISvtcmk2iAMYAc/gjCEz
 xUY4KCuGY=
X-Received: by 2002:a05:6a00:1782:b0:842:5931:7b88 with SMTP id
 d2e1a72fcca58-845244181camr412511b3a.1.1781635377311; 
 Tue, 16 Jun 2026 11:42:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:1782:b0:842:5931:7b88 with SMTP id
 d2e1a72fcca58-845244181camr412482b3a.1.1781635376857; 
 Tue, 16 Jun 2026 11:42:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 18/26] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_cb
Date: Tue, 16 Jun 2026 11:42:22 -0700
Message-ID: <20260616184230.303038-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: evmJ1qmOTRXgKYcVEmxcOFUN9Q7aACZ8
X-Proofpoint-ORIG-GUID: evmJ1qmOTRXgKYcVEmxcOFUN9Q7aACZ8
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a319932 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=HFGiEJlbZgj7dAjcEtYA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX7TZyVtr5qKb3
 lzoTjFbt1/e8W+4Fz9T5Y8uNzhGTmDXM17zzWxYGf12hJm/u6QVLVfo4Zw1nGtirOVrN3fxWcLt
 +LTE+I9E1uR1YBYHN49kGqFb42eHbDcG9r8yc/SwlW8v+CvZH2Y3DvB5TdTcn50KBnEFrm4sAaA
 qtyx+MtnFNEA3EuZSmL5KLCN3mOwqkntUeHVlVKEZkkLx4kBQnqGz55aDx3fIYoAXHknDauo/Ur
 t6YL7PzEDf0eVdLKZrROkx7KvA16MNj5cJPQWatfsP2J//uCISDKd5iuca7maf1JhBZ9BxMgmco
 kPO8pFiKICx9EQuXYdwGNQri0e57uHCrHX2jRDyjSlqiIhcsX9QHfY+Cgb+J0IxBNsOInKoVIGX
 KZ+2m9ZjedkxShSgEYyQqr6YIxqKZNN8lbHqLvnt04tt7J/i9F3XRfkDh+k4bVNy57LZm6J4/JY
 FXe1OdJ/+FNzZ0ghHDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX08odH68V+hoB
 UpTlyMV+i4cE0q/rTHlsr1vyVPYd7bQLn/o8tdW2KP8ztAN9p04KnY1v6uk8nTT9KsYAZCQ43ge
 ZDtMM7qMsF1VqobyLq7N7IuniFcVDWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-19-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d82d996bce6..909f19b7128 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -840,12 +840,14 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
  * @a6: the 6th syscall argument
  * @a7: the 7th syscall argument
  * @a8: the 8th syscall argument
+ * @userdata: user data for callback
  */
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
                                  uint64_t a3, uint64_t a4, uint64_t a5,
-                                 uint64_t a6, uint64_t a7, uint64_t a8);
+                                 uint64_t a6, uint64_t a7, uint64_t a8,
+                                 void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
@@ -891,13 +893,15 @@ typedef void
  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
  * @id: plugin id
  * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
+ * @userdata: user data for callback
  *
  * This registers a callback for every syscall executed by the guest. The @cb
  * function is executed before a syscall is handled by the host.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
-                                          qemu_plugin_vcpu_syscall_cb_t cb);
+                                          qemu_plugin_vcpu_syscall_cb_t cb,
+                                          void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
diff --git a/plugins/api.c b/plugins/api.c
index 774b1b80214..a72cec541dc 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -202,9 +202,10 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
-                                          qemu_plugin_vcpu_syscall_cb_t cb)
+                                          qemu_plugin_vcpu_syscall_cb_t cb,
+                                          void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb, userdata);
 }
 
 void
diff --git a/plugins/core.c b/plugins/core.c
index c272f47b642..7e2f25a9548 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -534,7 +534,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8, cb->udata);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index bfe12ad5558..8a823acfca7 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -128,7 +128,8 @@ static void hexdump(const GByteArray *data)
 static void vcpu_syscall(unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
-                         uint64_t a6, uint64_t a7, uint64_t a8)
+                         uint64_t a6, uint64_t a7, uint64_t a8,
+                         void *userdata)
 {
     if (statistics) {
         SyscallStats *entry;
@@ -271,7 +272,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         memory_buffer = g_byte_array_new();
     }
 
-    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-- 
2.47.3


